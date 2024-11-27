Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428AAD609CF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFOv-0006Ab-AN; Wed, 27 Nov 2024 05:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFOu-0006A8-D2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFOs-0001D0-II
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732703761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMgk/YScTLU4mxrI16zf0pSPSex+Rb+lgo104kYKSiY=;
 b=BJtek//LD75DrfBFeZzeHyhvtShlmYRlMV6fk+4AziG5cW5Gt7UIB/V076JsRvH4PZBnQc
 XcmgCa9HLopl25cjDAC9yVLlCSvcwins2kGtpeacU+tvRP0X4CmoNFUppaeHQTB6fMntmv
 0fUKDN8yE6PctrZfb/tkc7Gs0e9g8xQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-KqdAjDIwNKCHykc0sIV0qA-1; Wed,
 27 Nov 2024 05:34:38 -0500
X-MC-Unique: KqdAjDIwNKCHykc0sIV0qA-1
X-Mimecast-MFC-AGG-ID: KqdAjDIwNKCHykc0sIV0qA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C3E195608A; Wed, 27 Nov 2024 10:34:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B21731955F3D; Wed, 27 Nov 2024 10:34:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/7] meson.build: Refuse XCode versions < v15.0
Date: Wed, 27 Nov 2024 11:34:22 +0100
Message-ID: <20241127103425.378289-5-thuth@redhat.com>
In-Reply-To: <20241127103425.378289-1-thuth@redhat.com>
References: <20241127103425.378289-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

According to our support policy, we only support the two latest
major versions of macOS, and we already removed compatibility code
for older versions. However, it's still possible that people install
an older version of XCode on a recent version of macOS - which won't
be able to compile QEMU anymore, see for example the ticket here:

 https://gitlab.com/qemu-project/qemu/-/issues/2694

Thus let's set the expectations right and refuse older versions of
XCode that do not match the two latest versions of macOS anymore.

Message-ID: <20241126081054.244365-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index e0b880e4e1..a290dbfa33 100644
--- a/meson.build
+++ b/meson.build
@@ -315,8 +315,8 @@ foreach lang : all_languages
     # ok
   elif compiler.get_id() == 'clang' and compiler.compiles('''
       #ifdef __apple_build_version__
-      # if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
-      #  error You need at least XCode Clang v12.0 to compile QEMU
+      # if __clang_major__ < 15 || (__clang_major__ == 15 && __clang_minor__ < 0)
+      #  error You need at least XCode Clang v15.0 to compile QEMU
       # endif
       #else
       # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
@@ -325,7 +325,7 @@ foreach lang : all_languages
       #endif''')
     # ok
   else
-    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v12.0) to compile QEMU')
+    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
   endif
 endforeach
 
-- 
2.47.0


