Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7989CCD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgZ-0006EL-PQ; Sat, 09 May 2026 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgU-0006Cf-2w
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:22 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgR-00031E-Gk
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:21 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6967080e6beso1032649eaf.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379258; x=1778984058; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOnUIztUpeEPTVi9E6fUVmKhtcYW7IIrA3J7zG/vK7E=;
 b=DmFDlLfDNnzAm6auugSu85fNcbLcqs32GPUQzuYaUtMPALefd/i9BKNLnV+hmoMraR
 2drr2XOEsQeX86S8DLC2HSv7OBDMVaXnhUXAyQEVYhPdDXBzNUHn+QFE0MOFKwCQd3rY
 LwzAx1PT9TxVu3cJvWPKwkyHwCalWBv7vdYCtHJwka8ekHNUkXmLVquHPIQ0unLoUTqb
 L+aUNeGihOilViUR4cZAIk9O1QOG17ydISGJjCr4tXYxZPzHnOpy0P+blzemOD+AueC9
 C6umwfAiQeNExYrbfQLMhbgVqw0+IunSn7ciR65rws4eO0PtQA15I2cDNiEeGgFxzBEe
 A2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379258; x=1778984058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QOnUIztUpeEPTVi9E6fUVmKhtcYW7IIrA3J7zG/vK7E=;
 b=Q6z5APzaBcSpWxWFFjepBv64X9PRjXOyvOLtSOQ7nMqygEljListfDf/fFLijNu9FG
 B8lMf0RT+TAtkemhUbmHAV6+EM6IZOP0EIv4ZlTjU/2GQHFTJ/wzbyC5XDJCIA00XL7U
 niBurYBnDRaeTer66LWFk03b9Ac3Z80E0snl+n890kWbsSgXwKNcl4hT9Ot+zqabAV7c
 F0zx0cK+1J2gHmv8BVjoa2xT9U8D+C61440WEzUpya9awkyJMmgoMOUxSo+38+wvCq/6
 5JvwTyvdZEyeWksa0V9ATiqd5PQv4LANJS42uvMZnWgE9gRj2X2hBef7FJ3OUUxHYTR3
 +rhw==
X-Gm-Message-State: AOJu0YyrGUxiJtTihNnd0lNsDzyWebT2bpc1onRxD8F5BgpIWFp1poLS
 Bg6U0QIQZ5LEyliyTYRMOqZ/8Fe9HWcRVM0E7NKO9Ev4ykV26b18LD+4/+dXScUc
X-Gm-Gg: Acq92OHVsGN3Qb8tG3cei1/4Aln2ZNMO3+qM2KRwSIPC/p+G4ViEtmBueHta0hD/MBf
 s5dj6rAj51UtSWbVzWEp3qCnF72w6S1/zKQ+BJjj2Dmk4sYyxJtURtwY6b32sWK+FKEg+VxFBXD
 IcjjyO5zPy8To1K5+DA8u7ZKcmXYm7+vrigBX9vGjq048am8dibtlNkHVXaLcq12EHAOXlqSYrF
 FGGpIt+AwRL/xRYpI9nRARmxgKx+RRlD3wCctn/yHJbe9V0H/o218E0cVk4r75+0sXTQzF+Drd2
 LnzsB5XNIUAcXIDopBEBg0ijeTRVhBi3vqKt/eB3aQae4dXcInLYP4OuCD5qq2NZ9qKrkXnU0VK
 sOE8mymCv6RoO42Q5sTiTXwzGlBuit0YavrJQqQBFPbNxSfiohjUGx2tK0AjklqaytUsj1S4Cgg
 pmzIMNasjF2Cch4tgAKRwGnIsm6pXBIrtMqKjAALnH+a46Zi8zLtY9QDpBmSALL4odAkT3V2QD3
 HOTsHVDyM5p51/0UVuHjT6BArAUR0wA7x5zXgpQo+j1+vKm+fOunbi9RsjOUuYkmepwFZce4ye9
 eCE=
X-Received: by 2002:a05:6820:2206:b0:696:6f52:95ea with SMTP id
 006d021491bc7-69b36ad6472mr2460404eaf.7.1778379258123; 
 Sat, 09 May 2026 19:14:18 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:46 -0600
Subject: [PATCH v4 23/32] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-23-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2d.google.com
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MPL3-MPL5/P3-P5 high lanes used by the two-source
    MTM/MTP forms and Cavium SDK/runtime code.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 46ccad95c3..08fda55ae1 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -26,6 +26,7 @@ DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
+DEF_HELPER_3(octeon_v3mulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a909ffcee..54ca92a654 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -52,6 +52,7 @@ MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 0a4c359390..7d45fc3d29 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -308,3 +308,4 @@ TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
 TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
+TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 124855d4dc..f565aaea20 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -192,6 +192,52 @@ uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return lo;
 }
 
+uint64_t helper_octeon_v3mulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[OCTEON_MULTIPLIER_REGS + 1] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 2);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[2], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 3);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[3], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 4);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[4], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 5);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[5], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 5);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 6);
+
+    octeon_add_limb(sum, ARRAY_SIZE(sum), rt, 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[1], 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[2], 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[3], 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[4], 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[5], 5);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    env->active_tc.octeon.P[2] = sum[3];
+    env->active_tc.octeon.P[3] = sum[4];
+    env->active_tc.octeon.P[4] = sum[5];
+    env->active_tc.octeon.P[5] = sum[6];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


