Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61174C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatp-0002cn-0j; Sun, 18 Jan 2026 17:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatN-00029f-Kv
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:07 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatL-0000d6-Fu
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:04 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a110548cdeso24515685ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773901; x=1769378701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1elLXYSGrJNsfz40yQiYIFdnTmy9vR+YxG5ftNQkGbA=;
 b=D3qlQ9OXenMm39QsRr4VJTOR/+M132m2owehbRumXFAXMrQOZxPvUFTtbDcH8yVd2k
 ucgry0T4AmJWZ0+0sUv8rpPzPoenwauJKp//yA1gDxXbcAdpkcbmaClzwzz6p11/UX/3
 nyvYxj5UQpN4W4KqiAKW1BpjHeGnGkL8pp7ZYfmn6NC9stgXDOqa0bzKfrpcGy5bppFM
 MhJn771eR+5dVeyzmeRJTEgfPYe+aXIpZWZwgjNnYh2SBJOdIo9uEKWDXAcKlCqclmIu
 NzsFDcKYVC5FxWshfU+5/EbK+IZKE8D3tVeQix4Vg6H170u32P2Cd8V/59dnvMqTc5uk
 GpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773901; x=1769378701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1elLXYSGrJNsfz40yQiYIFdnTmy9vR+YxG5ftNQkGbA=;
 b=Ok1r+edDeSGxPkknIBFgDUoN1WUi2BA5GgcyTCQS1wzRcF+6tMt96fP6zWt714bX4B
 Rv4vIyEYpWyjAN3Rmbw0ZwcxQyZf2I3Uir2OrA8aMV3Kz7V/YOVyw4ENPE44gp2piqrR
 CZgvH6NrT00Z4zoJF1fL5FkQpoXA3VTTqRW3vAuWoQlMf3ocgJ4iW9OHcRXq4zHjNf4j
 DB6V91mf5Vw3FMmGiU+wE8c1rhOXb7mM/YIG31eiOQGPmsme6Bs7SkGWGr/MehsVPMSB
 b1fJ4Ag/AItgF/KxiIervv/ANXyymbZay0D/l6ay8s7qhridRVVI2y7wtm5YOdEt2F8I
 5dlw==
X-Gm-Message-State: AOJu0YybV1OCfsr8JrIE+ZlTukn2uVLtxRIFNqHDAqx7IKA8CF7ac7Go
 C0lgvTIUqzQ+O4T+kHJKAEX/dd8UnPlvkrKSuwRA0y0p1M1B43as5Wa6RULv+rjjdZwjubjvqnn
 KCixI4t2rYQ==
X-Gm-Gg: AY/fxX7Fe4TT+euRVHfID06hbZMHkxUCeSdG5AgT+VdIiEZCbPDjKDeD/X5hOE8KDiz
 KmHK4lOgoBCnQPbONwnaz2Wm74pg1XoiiIWp6DJD3cEYsGMqeGVCBrAKh9qZEXH3j1Unl0X7lIU
 CRw/FRCthQUtDestjMoBUwwLeI9ZQ4xgSBTSGspEspZGn3qmMc5zsbyOtG5MdvTYeF9iInuWKDX
 VvpPXBx6EuyugAgeZhAi6wOSz+D0FJRFkiNAgFC1kmveA10IAEqqmGvLJ4yQ0C/5EApk5QMALJI
 YQmA8y5GDGu+nB/C0PSVYZ2tpSDMSjMNPwyVVpjZiP9mqdgHiF8ZWuj8dcRu5aJTtdkEpdnRphe
 +fEbfy1QogN+Vj2ksERVwvfGTcrJhBwB00U6FZ9aJH1lJdhc8PYiZRwVcEIbiQbRnxJMkNtRz6v
 x7/qPnOvd6b103QTs1MQ==
X-Received: by 2002:a17:902:d488:b0:295:7b89:cb8f with SMTP id
 d9443c01a7336-2a717413b94mr74261785ad.0.1768773901329; 
 Sun, 18 Jan 2026 14:05:01 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/54] meson: Drop host_arch rename for riscv64
Date: Mon, 19 Jan 2026 09:03:37 +1100
Message-ID: <20260118220414.8177-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This requires renaming several directories:
tcg/riscv, linux-user/include/host/riscv, and
common-user/host/riscv.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/{riscv => riscv64}/host/cpuinfo.h           | 0
 linux-user/include/host/{riscv => riscv64}/host-signal.h | 0
 tcg/{riscv => riscv64}/tcg-target-con-set.h              | 0
 tcg/{riscv => riscv64}/tcg-target-con-str.h              | 0
 tcg/{riscv => riscv64}/tcg-target-has.h                  | 0
 tcg/{riscv => riscv64}/tcg-target-mo.h                   | 0
 tcg/{riscv => riscv64}/tcg-target-reg-bits.h             | 0
 tcg/{riscv => riscv64}/tcg-target.h                      | 0
 MAINTAINERS                                              | 2 +-
 common-user/host/{riscv => riscv64}/safe-syscall.inc.S   | 0
 configure                                                | 4 ++--
 meson.build                                              | 2 --
 tcg/{riscv => riscv64}/tcg-target-opc.h.inc              | 0
 tcg/{riscv => riscv64}/tcg-target.c.inc                  | 0
 14 files changed, 3 insertions(+), 5 deletions(-)
 rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
 rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-reg-bits.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target.h (100%)
 rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
 rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
 rename tcg/{riscv => riscv64}/tcg-target.c.inc (100%)

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv64/host/cpuinfo.h
similarity index 100%
rename from host/include/riscv/host/cpuinfo.h
rename to host/include/riscv64/host/cpuinfo.h
diff --git a/linux-user/include/host/riscv/host-signal.h b/linux-user/include/host/riscv64/host-signal.h
similarity index 100%
rename from linux-user/include/host/riscv/host-signal.h
rename to linux-user/include/host/riscv64/host-signal.h
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv64/tcg-target-con-set.h
similarity index 100%
rename from tcg/riscv/tcg-target-con-set.h
rename to tcg/riscv64/tcg-target-con-set.h
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv64/tcg-target-con-str.h
similarity index 100%
rename from tcg/riscv/tcg-target-con-str.h
rename to tcg/riscv64/tcg-target-con-str.h
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
similarity index 100%
rename from tcg/riscv/tcg-target-has.h
rename to tcg/riscv64/tcg-target-has.h
diff --git a/tcg/riscv/tcg-target-mo.h b/tcg/riscv64/tcg-target-mo.h
similarity index 100%
rename from tcg/riscv/tcg-target-mo.h
rename to tcg/riscv64/tcg-target-mo.h
diff --git a/tcg/riscv/tcg-target-reg-bits.h b/tcg/riscv64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/riscv/tcg-target-reg-bits.h
rename to tcg/riscv64/tcg-target-reg-bits.h
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv64/tcg-target.h
similarity index 100%
rename from tcg/riscv/tcg-target.h
rename to tcg/riscv64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index d3e6041186..c1e586c58f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4086,7 +4086,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-F: tcg/riscv/
+F: tcg/riscv64/
 F: disas/riscv.[ch]
 
 S390 TCG target
diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv64/safe-syscall.inc.S
similarity index 100%
rename from common-user/host/riscv/safe-syscall.inc.S
rename to common-user/host/riscv64/safe-syscall.inc.S
diff --git a/configure b/configure
index 04d0b214b6..ee09f90125 100755
--- a/configure
+++ b/configure
@@ -469,8 +469,8 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mlittle-endian"
     ;;
 
-  riscv32 | riscv64)
-    host_arch=riscv
+  riscv64)
+    host_arch=riscv64
     linux_arch=riscv
     ;;
 
diff --git a/meson.build b/meson.build
index c36f2f6962..e1ac764793 100644
--- a/meson.build
+++ b/meson.build
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu in ['riscv32', 'riscv64']
-  host_arch = 'riscv'
 else
   host_arch = cpu
 endif
diff --git a/tcg/riscv/tcg-target-opc.h.inc b/tcg/riscv64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/riscv/tcg-target-opc.h.inc
rename to tcg/riscv64/tcg-target-opc.h.inc
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
similarity index 100%
rename from tcg/riscv/tcg-target.c.inc
rename to tcg/riscv64/tcg-target.c.inc
-- 
2.43.0


