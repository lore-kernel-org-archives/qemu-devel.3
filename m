Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBACDEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGz-0005lN-Ou; Wed, 11 Sep 2024 08:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGx-0005QM-43
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGs-0007TJ-6Y
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so17395715e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056988; x=1726661788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcxrQmlncOi9RQ8/5TKjDLqLTGvXZJ41pNBta9PgccY=;
 b=IxTTCfLnAKD1VYNRu1leNmIE1nXiWNF1tm5gVC9nEkKGLxdmooOKhReteHOhxuNZ+g
 HM9qQ0MkHl0wIvBH92ayb2+7exMm1cFeg2BK9VvDwERQNiewthuvgq9w4diBoFzhOmNi
 vpGeYvJqP4kBsa8ZeTSUezMBpkVxiz5m+ORix3VnCJcpl8eRbfPIPvt2FZLBvNPJhTaB
 dgODBUL+qpQA6RopycjNe6eSpbNrCptqgB1GrNtCBjA7+sQSFKh4ldvpldlEC0AfsTP/
 IivI246qNv8mPlzlahNqRYSSe3qYu1MaNSSEB5l717xIgxJcoDt8t5cuJyn8C8ItFFqP
 rOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056988; x=1726661788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcxrQmlncOi9RQ8/5TKjDLqLTGvXZJ41pNBta9PgccY=;
 b=NXADyHMLx2pGqAue1EqCBtIT417XPUp290yamhcvRJIhlmHWlFATFqZSO3Dd5DhHAU
 iNvvVeYFn3Lm05fdc8NDKLNWwcVUy+o/lhy1196wVvydiUgIsDhtf0A5WMW/1riQeYHJ
 VjmqyCxsVJQ10pycGpjnfohVL1hUd8XsZLlkBvAdcF/4IyqZT/iypUL7Yq/Ar7I2UPkt
 U9pCqTL2SEDwhK0ngKJkr4hvmvih1JViqCmdNFPni/xr5VMA2WZuA3lBcI9a4VriFjty
 64nRvuiA30AEUtGVlLo6jv8mdOMgjt4HfFuOVX4xPwdl00PpWOd/TrnyFp4eMxjWB+hx
 friw==
X-Gm-Message-State: AOJu0YziQtS16FeddgNL3oHxv5EaEYhdzut5XAWR6wEVFbeKEPOxsNg2
 oc4NZ3TizbZxTRXcuqp59Mw15EgUoqQsEsvT4hMkniibxaQ/QCpLA3FGlQ8uDNNKMBl0ICVPPln
 W
X-Google-Smtp-Source: AGHT+IHQ2L2y+JaiQWeq0+hXswSbT9JmOxhES+D+C/ASGsL9WO6d7i/SVmpsLGUEMyGxOpYJLMHvsA==
X-Received: by 2002:a05:600c:5115:b0:42c:ba1f:5475 with SMTP id
 5b1f17b1804b1-42ccd35aa7amr23701255e9.26.1726056987569; 
 Wed, 11 Sep 2024 05:16:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb32678sm140205125e9.16.2024.09.11.05.16.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 18/56] system: Remove support for CRIS target
Date: Wed, 11 Sep 2024 14:13:43 +0200
Message-ID: <20240911121422.52585-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are about to remove the CRIS target, so remove
the sysemu part. This remove the CRIS 'none' machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-13-philmd@linaro.org>
---
 configs/devices/cris-softmmu/default.mak | 1 -
 configs/targets/cris-softmmu.mak         | 1 -
 qapi/machine.json                        | 2 +-
 include/sysemu/arch_init.h               | 1 -
 .gitlab-ci.d/buildtest.yml               | 2 +-
 .gitlab-ci.d/crossbuild-template.yml     | 2 +-
 6 files changed, 3 insertions(+), 6 deletions(-)
 delete mode 100644 configs/devices/cris-softmmu/default.mak
 delete mode 100644 configs/targets/cris-softmmu.mak

diff --git a/configs/devices/cris-softmmu/default.mak b/configs/devices/cris-softmmu/default.mak
deleted file mode 100644
index 3726699370..0000000000
--- a/configs/devices/cris-softmmu/default.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for cris-softmmu
diff --git a/configs/targets/cris-softmmu.mak b/configs/targets/cris-softmmu.mak
deleted file mode 100644
index e483c42066..0000000000
--- a/configs/targets/cris-softmmu.mak
+++ /dev/null
@@ -1 +0,0 @@
-TARGET_ARCH=cris
diff --git a/qapi/machine.json b/qapi/machine.json
index d4317435e7..63b84bc575 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -33,7 +33,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8d041aa84e..5b1c1026f3 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -6,7 +6,6 @@ enum {
     QEMU_ARCH_ALL = -1,
     QEMU_ARCH_ALPHA = (1 << 0),
     QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_CRIS = (1 << 2),
     QEMU_ARCH_I386 = (1 << 3),
     QEMU_ARCH_M68K = (1 << 4),
     QEMU_ARCH_MICROBLAZE = (1 << 6),
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfc51be08a..9e42d841e1 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -675,7 +675,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
+    TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
       ppc-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
       sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 18ec5b6253..2ce0432eb7 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -20,7 +20,7 @@
     - ccache --zero-stats
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
-        --target-list-exclude="arm-softmmu cris-softmmu
+        --target-list-exclude="arm-softmmu
           i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
           mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
-- 
2.45.2


