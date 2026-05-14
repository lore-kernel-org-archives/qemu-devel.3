Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292A0CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2A-0002DM-H0; Thu, 14 May 2026 13:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa12-0000rr-OQ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:34 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-000448-Pz
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:32 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbe437b072so4850221a34.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780295; x=1779385095; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oeLEn0bt4fyJr23Y5IHppjNsOacLgHrIxZD0NLe2nvw=;
 b=dNVyz46eR7LwZ0BxkwrwW0YzBQJlJNXwmKn5s60AKrxC3w+1mIOxzDkef66y33DTjT
 9YBDdiDPDqgUiIm4tJfbH7STuPh3nOrH6BULCiDfs8/J03Z7Z7Jvbg0O0vTe7hrM53De
 36BGUr3bGdb+lZvgPWD2MMeZHwnWMLV8MdqYbgHBEiazafD0tFQsjpOhVwn38BIDM0kr
 K/Dfohr+9llj/GrVkQdslaIiyGjTCHc1v5pv39a97MPgxsxMZQGsGGtsxcTfvu8fDztH
 sVBprqYg3+ZX1hFRsnGMwZftY1JKJX8VPQ/R1ZHndz/ot+HR3WtS5iLuVSG6P3UU6ir1
 zeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780295; x=1779385095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oeLEn0bt4fyJr23Y5IHppjNsOacLgHrIxZD0NLe2nvw=;
 b=GlRUnnQFj9gR7EQvvjGcMnzmQAHeaK4c+SLaKsrYBm5SmYdOvHbKE2YmLsNds8dpw8
 A5hAxpZSzQbNGBo6sYLjTX4T7XWpRQvExJ10M8wFmSG8+UgvC5eKZY5Vhtm2yq3E0A0O
 ecvC9j73tX/xobwYD6Ke2OnhFxkY++IRb3MTVT4+QMGSxEJfRw6ZhYppwiElwM9nT0wV
 5ZThJggQu8XWXPxPV2PVcotp6lanoxiWlmbynbrNQh1v/5VOcxk+MVeaSlxPbaFgDMyW
 mmjB7uGOkG5V70TOwGQqjSWgSJ1N69NaW6e2QgRFb9FMyKNnHcbvYP+R9ZQeQy6RA/t5
 Qnxg==
X-Gm-Message-State: AOJu0Yw1G2v5UU2vvjpHNQzK51gj3B7F0er9Ze9WKQQLH9P4Lwpylurq
 kezcDD3gLK50AZVHTobbFH3TwkShvkyXXz6IbJmdDcr9Ct9z584PZAeS
X-Gm-Gg: Acq92OG0cIShbpJ7qG5x/670883oSflbdStcElXykMJz3wYp+HFHAqqdm+bdye6Z3V+
 0zAp1hxJmCbSKbWYlJpHuJ3uCAaY5JJXYqMC3Q3qppO4XTNyfgTlIfmPA8UYSkzZeYq03Py1EZA
 JHyqFHeONNbN54aNHOMVX2LgWCtZLgwoIAaPvSkslOzj8ckdgZP6jRGbPojv/kaU5XIiUbo/RYM
 c4Dw6lmnGGYh5d8nO4kluj2SVpJFFjKaebONjzkpgW1zMqK5XOw8LHmG0orSTjTmqf1rGRoOedc
 b/rv+Kdo+1zbgdmx9aMdQdrQbWhvRNIA65+xGdduHuA3GTfJWnuFMXCnb8Wj12T8Dot38qXCVVl
 xOo/Wbp1HpuEbJHR+iVFGAaoRQXw1X+9quyMKFsziVhAp0XRvaVtPi2kwmXGsZqq3qqwFL4mD5x
 pmnQs2Ux7ewXZQLkp1eat37ZDPz66RY6/GMRs1qnbMEROfv4AcMKH5XZn019aUhF6B/w6N1aNUC
 9kHFIA2h1nHvLBnU7tyVWwWQ2z+EbLufsXJFRfR027F8n6vbNtwSg7+56mCvgGGyaoB
X-Received: by 2002:a05:6820:820:b0:696:17a7:498c with SMTP id
 006d021491bc7-69c9437a908mr235617eaf.30.1778780295565; 
 Thu, 14 May 2026 10:38:15 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:11 -0600
Subject: [PATCH v7 22/35] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-22-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

VMM0 performs the VMULU accumulation, returns the low result, then feeds
that result back into the MTM0 multiplier state with a zero high operand.
It sets MPL[1] to zero, clears partial products, and models the remaining
architecturally unpredictable multiplier lanes as zero.

Add helper and translator support for this multiplier chain-update
operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MTM0-style high-lane update and set MPL[3] to zero
    when feeding the low result back.

Changes v5 -> v6:
  - Zero MPL1 and deterministic-zero the remaining modeled MTM0 lanes after
    checking the CN71XX VMM0 definition.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 20 ++++++++++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f1e78ae329..46ccad95c3 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
+DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 74d24c18de..c1c3506d20 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 62cbbd3c82..304aa58065 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -317,3 +317,4 @@ TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
+TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ab3fb06a16..45e208ca43 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -176,6 +176,26 @@ uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return sum[0];
 }
 
+uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo = helper_octeon_vmulu(env, rs, rt);
+
+    /*
+     * VMM0 is architecturally equivalent to VMULU followed by MTM0 with
+     * the low result and a zero high operand.
+     */
+    env->active_tc.octeon.MPL[0] = lo;
+    env->active_tc.octeon.MPL[1] = 0;
+    env->active_tc.octeon.MPL[2] = 0;
+    env->active_tc.octeon.MPL[3] = 0;
+    env->active_tc.octeon.MPL[4] = 0;
+    env->active_tc.octeon.MPL[5] = 0;
+    for (int i = 0; i < ARRAY_SIZE(env->active_tc.octeon.P); i++) {
+        env->active_tc.octeon.P[i] = 0;
+    }
+    return lo;
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


