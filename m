Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AE8D637A2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0O-00008z-HB; Wed, 13 Nov 2024 12:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0M-00007y-Eq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:10 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0K-0003k1-VN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:10 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso5347368a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518287; x=1732123087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rGaIJlJUbuhCUG8sC2dah6C7SrySAgZlFZil3t+2Qw=;
 b=LrS757i0S99GrVISy0hwD63cZevuN0ePIRxg9IgjXcluAL67mXVOS9q7wuwvgJaS9Q
 fwro0pX1EyEI03X1KRLr+tSFMVwocr7Zj7ldPdN490QX+mLSOnVcWmLDB57RjJEAStfQ
 zztTrC3zZDiCCJCAyaE/rLdclgA5lsTIUnAw3L364n5RR621q3KwksCAlSAujLpTIrdG
 5Bpbdgi1v42YhdXjukjkB7NPvKlX6iw0H7jI8l1e70+3TyZh+YdzUHkrrpoQ8DZYBSH7
 iUJdf0ExxlpS+fi/5+9BGqx46il4Bc5Q+toUGELUEoWI6v15jvPPRt7i8WsnAFT0sk4U
 +BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518287; x=1732123087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rGaIJlJUbuhCUG8sC2dah6C7SrySAgZlFZil3t+2Qw=;
 b=SAO2qlMhiNSYqU7I9q3x5fHZ1QkjWRRpXoVWLNQV9eH8gYBLjv+naMNSmuOFMKnAYK
 ubOx6mP4A4je3r7qBfDaf6KLVTm5tAJvstuQymlvAls4JZtFFmlSN97plMFMGfU8wLbB
 iab79YjYQn7UZ3FmoSlljUWWHHOegVAAU7AnEC4wk3QsA/emhlp15xGkai82wCCqWQ4e
 47jyL0ApYMSXZciqurbn+zWzvyLUltlC3Ls2vf4rSneZfc5BQpFH5n0zjflS4yFK5I/R
 Wn+cx6EDVY3OXAVfYgc0ur0BnCS9PSj2L6QJ6Ay+NC4bMjdHaHJ1md03LzOLV182p07A
 iVRg==
X-Gm-Message-State: AOJu0YwQCfpwsmCxzBIvhE6L2J1QBxsOWVgjPOTmmfli6M4RP2ExqAAb
 H2fxqNmAzAxiiPgbaD9VPTVAqXE1AyvtpN7s8+CIVCcT6OPYCTgHEzeYIPMtrJQXMROiQivIM/5
 N
X-Google-Smtp-Source: AGHT+IHnSZ/MQSOGvPcLpzVNXU9qbeg3NYHKpsqYD3nTvhuiqXn12KVw5/xYebc4vhUaMSeFs5eG4g==
X-Received: by 2002:a17:903:244e:b0:20c:d2e4:dc33 with SMTP id
 d9443c01a7336-21183c65cbcmr311579785ad.14.1731518287065; 
 Wed, 13 Nov 2024 09:18:07 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 1/9] target/riscv/tcg: hide warn for named feats when
 disabling via priv_ver
Date: Wed, 13 Nov 2024 14:17:47 -0300
Message-ID: <20241113171755.978109-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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

Commit 68c9e54bea handled a situation where a warning was being shown
when using the 'sifive_e' cpu when disabling the named extension zic64b.
It makes little sense to show user warnings for named extensions that
users can't control, and the solution taken was to disable zic64b
manually in riscv_cpu_update_named_features().

This solution won't scale well when adding more named features, and can
eventually end up repeating riscv_cpu_disable_priv_spec_isa_exts().

Change riscv_cpu_disable_priv_spec_isa_exts() to not show warnings when
disabling a named feature. This will accomplish the same thing we're
doing today while avoiding having two points where we're disabling
exts via priv_ver mismatch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..cd83968166 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -304,6 +304,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+
+            /*
+             * Do not show user warnings for named features that users
+             * can't enable/disable in the command line. See commit
+             * 68c9e54bea for more info.
+             */
+            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
+                continue;
+            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -331,11 +340,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
-    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64 &&
-                          cpu->cfg.has_priv_1_12;
+                          cpu->cfg.cboz_blocksize == 64;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.0


