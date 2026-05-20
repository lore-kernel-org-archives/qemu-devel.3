Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70B1CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmY8-0001GD-6a; Wed, 20 May 2026 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXX-0000yG-HX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXV-0002DY-EW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so62401005e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305107; x=1779909907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XM8/ESUZyxARANoG97kDLPmVt2Q2WvRDXAoslUdYf3A=;
 b=uIMdI7W15pj7E5SpF4vwSHuyPkQ9s6z25UZG0EsJGB40wc5oI+5CVsvkV8l4BjE31o
 wJF0CQT3+gZn6HIcht3RXBDvGfn0L00ITmxhNk1tg5lqTB8YVo3F95i58Ih7tzFcr/ae
 aTFo0E+2pYAMUW+38GP2q/89KyhXtmrAA6Y7epB8SaF2cJ8tap1zR1sTQSxexAJTgNPn
 h0HSJtcAPMLUd882Kz/NA+TACVLnIhIEGzxVaeh8E75vLbO/+VvTuEgDjOCFNsYHxARQ
 cZJxBhUahCxsGDl0A+ZrEAo99/W1L6UyPylXqxMYp/Z0+TzjU4FCSXOMLmz2418bez6M
 W8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305107; x=1779909907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XM8/ESUZyxARANoG97kDLPmVt2Q2WvRDXAoslUdYf3A=;
 b=MMvd9zv35doaZVykdd2pYpkZmwRp5iww9Snl9S0FoxZ2tAuxtqUHb7uwiBiENJrCKq
 g3RrfQ+MBkijttPpQqbc4jqZ5fgyoBAEecpg2IVHZtkb1jYdxetSTVQ9lV4HY3F8zslC
 aMDSx/g2k3hifloG4n3dNI5CpTAXzmObxogVAdpBdaQrbgGTG4WK4xXkKqA6mFvZVV1q
 C0jamZRsV9E//1w8QeyFTe8Y7qK0SkzQ0jKNudau0/dy5GWK6R/Fsv/Am2HRgHrTDa3f
 Vx2gG8bcbflT+2Ot9paZrV0UDAz6NMKpljMbljpCzicUgjwdFsnR2Vo/rbjjOTwxn8fw
 218w==
X-Gm-Message-State: AOJu0YzanmwoyPev4GYbyosFS/8TqdjCWCEX82Ss3a2w+GKdpxnDN7Wz
 hV/oAZs8UYNbNu2B2tnctXyrEp3xs4CKUOC5OObHfCOam5nQxiFJIAjZvsXBuzNwQHyAUfCbx9b
 vPkaMutc=
X-Gm-Gg: Acq92OGCzLYSFheks58r9SO9GdOiJA/sBSDjaNtAqZtobHAODy1/t9TAqmnRPXbsa38
 eabwuXncd+yp3cxZdbahsPJNl8fYBUQSYa1lAGv9tP2xyRwA2a7vDi4e2+ZtfFqTjRARMiOuWFW
 h+pNAwm7+Fc0R7MCC2w9uPXvCKo4o9pq/2nEM3MmpiEfpprs52bflJ+jQ7LFK1zlGYKOwQCJuR6
 Rb6AcfsNzU49zWY0k6/r5fODI8agSwXz+9SYkLqMn3Cs2NSQkIhuimzN8SHhAMT+QeuXKyCMWf5
 sb7H89vwXeuz719Tmy7IVv4qp4KatMk0hnjrt1yWPxj1QU3Da+GYJwOHPdBeWGbsMJtY9+yhMlH
 LpgxpWTR+J2WzQuZQ7SNT7F9YAh3KYDqgQm7YEHVvHjVmcQQIx5LO6ilPuEt8EFCv2PtSejLviD
 GNbogI0kpHos7XJYDDfEQvyAtnu6Q5aODtlpXzymf2QgA1wUjUSoYDpNrsZZI6lLe9okfxNr7IG
 AR9z1YX42A=
X-Received: by 2002:a05:600c:34ca:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48fe60ee4c7mr404414015e9.14.1779305107476; 
 Wed, 20 May 2026 12:25:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm140077555e9.1.2026.05.20.12.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] target/mips: expose Octeon68XX floating-point support
Date: Wed, 20 May 2026 21:23:17 +0200
Message-ID: <20260520192338.40036-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and use
CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-5-philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab04738..cc1916232f5 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
-- 
2.53.0


