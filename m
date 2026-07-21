Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5BFC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCpT-0005IQ-FP; Tue, 21 Jul 2026 11:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpO-00051C-Jk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpL-0004y7-5J
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbIHrfpI23qwnv3Bj8tZqkyqADPJ3K3ZtgBCDyBb2j4=;
 b=Wdr6hJnS5JV2qpsRZWEU4AaYG85DQDjTgeKwtUyNp0EAv9b3bamB62o/aq0iBXyLWV8c++
 5zwrF28COvCNXFzEeIEs+UN8dI/jHijikYViagZb6bkJHlySpDHMBLD5YjT10pfknnswxt
 0UmHklWApvaxW/1Z+lQiCVAEviJ8yjE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-l6BFnfkVN_yCWXyrJPattg-1; Tue,
 21 Jul 2026 11:56:10 -0400
X-MC-Unique: l6BFnfkVN_yCWXyrJPattg-1
X-Mimecast-MFC-AGG-ID: l6BFnfkVN_yCWXyrJPattg_1784649368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 385A81944DE7; Tue, 21 Jul 2026 15:56:08 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.83])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB4A31800616; Tue, 21 Jul 2026 15:56:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/5] tests/vm: update to FreeBSD 14.4 image
Date: Tue, 21 Jul 2026 16:55:51 +0100
Message-ID: <20260721155554.128840-3-berrange@redhat.com>
In-Reply-To: <20260721155554.128840-1-berrange@redhat.com>
References: <20260721155554.128840-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This avoids an interactive prompt that halts execution when
attempting to run the FreeBSD tests due to outdated 14.3
base image:

  `Bootstrapping pkg from pkg+https://pkg.FreeBSD.org/FreeBSD:14:amd64/quarterly, please wait...
  Verifying signature with trusted certificate pkg.freebsd.org.2013102301... done
  Installing pkg-2.6.2_1...
  Newer FreeBSD version for package pkg:
  To ignore this error set IGNORE_OSVERSION=yes
  - package: 1404000
  - running userland: 1403000
  Ignore the mismatch and continue? [y/N]:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/vm/freebsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index ea09b21fbc..bfb1a85af3 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/releases/CI-IMAGES/14.3-RELEASE/amd64/Latest/FreeBSD-14.3-RELEASE-amd64-BASIC-CI.raw.xz"
-    csum = "ec0f5a4bbe63aa50a725d9fee0f1931f850e9a21cbebdadb991df00f168d6805"
+    link = "https://download.freebsd.org/releases/CI-IMAGES/14.4-RELEASE/amd64/Latest/FreeBSD-14.4-RELEASE-amd64-BASIC-CI.raw.xz"
+    csum = "627937af554eb6522891875ddc8cf5b86b40e9a12143c1b951f830b3f691de49"
     size = "20G"
 
     BUILD_SCRIPT = """
-- 
2.55.0


