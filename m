Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8133C48297
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX15I-00020h-Pj; Mon, 05 Feb 2024 10:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX15F-00020X-5U
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX159-0003EX-Dc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707147626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0p7P3og37MTPR9gQt1JM8TtZQZu0D+Zl3iQLi40a7Q4=;
 b=LVEF9y11F5Tl/hatPrYzoGYyayqKOdi0Nx1EDZ9unyHpDuJeZU18PXgE09pz4b422Y2PZ3
 Zf3UbovKds6JqKEd9k+1kn8uTHoIUM+xi6H/vdkJaMEQMWc/90ecrx7HxFmCBi7Y1cQSTH
 AHH0uO3mDYA8cLmeZCiJFBWINLuKusY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-pA3WDJ8yMT-N0vwSUdGjDw-1; Mon, 05 Feb 2024 10:40:21 -0500
X-MC-Unique: pA3WDJ8yMT-N0vwSUdGjDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AC02877CA8;
 Mon,  5 Feb 2024 15:40:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB3731C060B3;
 Mon,  5 Feb 2024 15:40:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] iotests: fix leak of tmpdir in dry-run mode
Date: Mon,  5 Feb 2024 15:40:19 +0000
Message-ID: <20240205154019.1841037-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Creating an instance of the 'TestEnv' class will create a temporary
directory. This dir is only deleted, however, in the __exit__ handler
invoked by a context manager.

In dry-run mode, we don't use the TestEnv via a context manager, so
were leaking the temporary directory. Since meson invokes 'check'
5 times on each configure run, developers /tmp was filling up with
empty temporary directories.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/check | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f2e9d27dcf..56d88ca423 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -184,7 +184,8 @@ if __name__ == '__main__':
         sys.exit(str(e))
 
     if args.dry_run:
-        print('\n'.join([os.path.basename(t) for t in tests]))
+        with env:
+            print('\n'.join([os.path.basename(t) for t in tests]))
     else:
         with TestRunner(env, tap=args.tap,
                         color=args.color) as tr:
-- 
2.43.0


