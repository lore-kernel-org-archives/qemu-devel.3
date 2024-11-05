Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB3ED2C11E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L3r-00008r-92; Tue, 05 Nov 2024 10:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8L3g-00007w-4m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8L3b-0000gi-MJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730818881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Al8uMIy4idSHQy73devQTh7tjClJ9L57DftFqIg+cU8=;
 b=NtAzZwyTjAl7Jc5h1z2+Z5wu4BJggSP6aK5KU+BVnB3suo3rBjX3cs+xJ8ruBvNglWCAsO
 lghU/j+dI3Zb0ouC655aWJ8jXrbqD9i5/R2+1l7JEpx1dOtULrQi8Ja25paBHXqI1QaNJI
 py9smF7KBx5kA+N71BEMLuYrps2mG/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-ke3du5JlMHGbgLKaXHxhHg-1; Tue,
 05 Nov 2024 10:01:19 -0500
X-MC-Unique: ke3du5JlMHGbgLKaXHxhHg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEEB61954B1C; Tue,  5 Nov 2024 15:01:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ED5119560AE; Tue,  5 Nov 2024 15:01:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson: explain more verbosely why we forbid Clang on Windows
Date: Tue,  5 Nov 2024 15:01:14 +0000
Message-ID: <20241105150114.334985-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Contributors are repeatedly sending patches to remove the blockage of
clang on Windows, ignoring that we need 'gcc_struct' support. Put some
more explicit comments in the code to discourage people from doing
this.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/compiler.h |  7 +++++++
 meson.build             | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb4..38ed8997ca 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,6 +22,13 @@
 #define QEMU_EXTERN_C extern
 #endif
 
+/*
+ * QEMU requires 'gcc_struct' on Windows for correct guest ABI.
+ * meson.build checks for 'gcc_struct' and blocks use of CLang
+ * on Windows, pending a fix for:
+ *
+ *   https://github.com/llvm/llvm-project/issues/24757
+ */
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
diff --git a/meson.build b/meson.build
index 2c9086a3fe..37b7daa758 100644
--- a/meson.build
+++ b/meson.build
@@ -330,9 +330,18 @@ elif host_os == 'sunos'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
 elif host_os == 'windows'
+    # Clang is blocked, pending impl of 'gcc_struct' support:
+    #
+    #  https://gitlab.com/qemu-project/qemu/-/issues/2476
+    #  https://github.com/llvm/llvm-project/issues/24757
+    #  https://github.com/llvm/llvm-project/pull/71148
+    #
+    # Once the above is available this check should "do the right thing".
+    # This check can then eventually be removed once the CLang minimum
+    # version checked 50 lines earlier guarantees support
   if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
                            args: '-Werror')
-    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
+    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang (https://github.com/llvm/llvm-project/issues/24757)')
   endif
 endif
 
-- 
2.46.0


