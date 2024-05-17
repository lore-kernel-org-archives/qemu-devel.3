Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFD5C25B77
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wez-0004qA-Aj; Fri, 17 May 2024 08:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wew-0004om-FU
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7weu-0006GQ-Ta
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZ2tfYZTfmYrTRdPDDBMx41AUVQyGSLeTEG9/lN7XKY=;
 b=Ynrv5VkEkWvnKynekzhmiMlned9Uyuk2Pk6nx6cdzvxQsRJqyKOxWXO+ysOPX9E2fYL0dF
 +PyhIouvB5tkOTa2F9s2N/Rnvpk0h/bO+Qdx1Gm4YSCroCyu8wSgnLVLxWSb+wFD4whipW
 Hko9EsQtS6W4GA6tTtCtKyDK3wWA6lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-xSkbXg-6Pnujs2qwkbK3cg-1; Fri, 17 May 2024 08:25:56 -0400
X-MC-Unique: xSkbXg-6Pnujs2qwkbK3cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03B22812296;
 Fri, 17 May 2024 12:25:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 205E91050174;
 Fri, 17 May 2024 12:25:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/6] tests/lcitool/refresh: Treat the output of lcitool as text,
 not as bytes
Date: Fri, 17 May 2024 14:25:47 +0200
Message-ID: <20240517122552.584215-2-thuth@redhat.com>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
References: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In case lcitool fails (e.g. with a python backtrace), this makes
the output  of lcitool much more readable.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240516084059.511463-2-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/refresh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 24a735a3f2..174818d9c9 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -43,12 +43,12 @@ def atomic_write(filename, content):
 
 def generate(filename, cmd, trailer):
     print("Generate %s" % filename)
-    lcitool = subprocess.run(cmd, capture_output=True)
+    lcitool = subprocess.run(cmd, capture_output=True, encoding='utf8')
 
     if lcitool.returncode != 0:
         raise Exception("Failed to generate %s: %s" % (filename, lcitool.stderr))
 
-    content = lcitool.stdout.decode("utf8")
+    content = lcitool.stdout
     if trailer is not None:
         content += trailer
     atomic_write(filename, content)
-- 
2.45.0


