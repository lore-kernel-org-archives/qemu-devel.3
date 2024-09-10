Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767E1EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so084-0001RU-FQ; Tue, 10 Sep 2024 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so07r-0008K0-0r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so07n-000581-PD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZJnuK2h81KcY66kd08hYy3F+YH70C9Bsh4bBdmoAuQ=;
 b=dUbgZm3hfijWgJHEyI9dvMHyr/6uYcpPVoFV6E4x2Ym1VBnlvZBAr+wND/ToN41s7J8y1H
 b/cxW0CS6s5hqQlzbwKAj79B8T4mR4GsztPluF1sR/nDVfm4V/vvftkrN5sCw54Wm0UVML
 gSQ9Pyky5gNJHmfjuagrHGMLw133M5w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-t_yedJesOGejhof5mDoQLg-1; Tue,
 10 Sep 2024 08:37:35 -0400
X-MC-Unique: t_yedJesOGejhof5mDoQLg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B9F6193E8CE; Tue, 10 Sep 2024 12:37:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D640119560B0; Tue, 10 Sep 2024 12:37:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/22] meson: Move -fsanitize=undefined into normal configuraton
Date: Tue, 10 Sep 2024 14:37:03 +0200
Message-ID: <20240910123726.182975-3-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

With 8e466dd09246 and 23ef50ae2d0c, we disable function pointer
sanitization in CI because the qemu code base does not support it.
We must disable this for normal usage of --enable-ubsan as well,
so move it there.

Append options rather than prepend, since all of this requires
proper ordering of options.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240813095216.306555-3-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build                | 11 +++++++++--
 .gitlab-ci.d/buildtest.yml | 10 ++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index f6b8060b72..4701ee3aab 100644
--- a/meson.build
+++ b/meson.build
@@ -493,8 +493,15 @@ if get_option('ubsan')
   # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
   if cc.links('int main(int argc, char **argv) { return argc + 1; }',
               args: [qemu_ldflags, '-fsanitize=undefined'])
-    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
-    qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
+    qemu_cflags += ['-fsanitize=undefined']
+    qemu_ldflags += ['-fsanitize=undefined']
+
+    # Suppress undefined behaviour from function call to mismatched type.
+    # In addition, tcg prologue does not emit function type prefix
+    # required by function call sanitizer.
+    if cc.has_argument('-fno-sanitize=function')
+      qemu_cflags += ['-fno-sanitize=function']
+    endif
   else
     error('Your compiler does not support -fsanitize=undefined')
   endif
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1d2afae996..9ac0776b94 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -428,9 +428,8 @@ clang-system:
     job: amd64-fedora-container
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++
-      --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
+      --extra-cflags=-fno-sanitize-recover=undefined
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
@@ -441,10 +440,9 @@ clang-user:
   timeout: 70m
   variables:
     IMAGE: debian-all-test-cross
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system --enable-ubsan
       --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
-      --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
+      --extra-cflags=-fno-sanitize-recover=undefined
     MAKE_CHECK_ARGS: check-unit check-tcg
 
 # Set LD_JOBS=1 because this requires LTO and ld consumes a large amount of memory.
-- 
2.46.0


