Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE3DCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVIB-0005fB-7P; Mon, 11 May 2026 14:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHf-0004lO-2v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:16 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHd-0002to-4P
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:14 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dca4debedaso4600531a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523792; x=1779128592; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VYzrL4rdP1K5g7jmbB/XNJrOB5204yKt0KXsRVorpVo=;
 b=b5uDXO6K4UzHrLcNtnhWC/7hXjW+JLttGWxdmiuNjyQXOagA+DXY1ffUNT8NRhqLTr
 E9sEMQLmlvHXGD8ewafvLQPZRgtYHP4b+rXCw97LP4s/zvN1aBnHHM3YiYFzlQIB/j/x
 yEODP9nIzoY6Ukyj6W09thVBUlWKAOkt6kec/KOzLjWsOlbBH+KsZSdAV9UaBdiE36tA
 LkB5LbvuU6VCHaM+X9sYrJm2da7roKCJigg3KIql7Drnds/tof5pb4dfGZtLzPSEDU1N
 ksoWfe8GUv7WHbiQDQ34ylo3DO4f+AeJ8Out0b/5x4u/ehyP11xuUxy/wk0zIGEfERlO
 uOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523792; x=1779128592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VYzrL4rdP1K5g7jmbB/XNJrOB5204yKt0KXsRVorpVo=;
 b=V055jys4gVpoig+P7j1k2bovQTEc5Siw7G0b1azvOItcmNFXmbBSMHwQb2DGqmbfEd
 7peRe/pceuMMrvRjS/WRhzZNP1SiFTAyOJYxGuEe5O0lXTf/Sxf1EhgdI0TOEV2F0qUc
 gf4G5dSAc0z1CLCUuL0fzo20QVrIQOg6AHAElHa6BqHqk39WUJZwiGTsE+1I/nVRZPVB
 W7fDdzPwzuTn808FtQ652NeQfEEIHmV3EfM9FBxMGcKL6X02xqkAqvsAO4mFJpX/39JT
 LDOX85T/0Qij46JFqnKhIBicwfPsOeGJfeyqR2UnhJ+dcJ7d+rUA6wC/gj0DpzKhm+Yj
 pt+w==
X-Gm-Message-State: AOJu0YzcUNj+kFMxgfibHpugld1myAZcoI6aSAdcRSLx1iN+2kV3mPB0
 WTXfBq/9olxaZqCvJ5Gxph7s9Bv3n7YH4pZgKGyFomss3YFap3hBy165
X-Gm-Gg: Acq92OEyE5lUYPRnFXV4Rqk9N7TmuocPaDHOnSmBNMY7lUpUvw4WsHJrKsrXmJBSCR9
 ++Xg3qPzh8TNDYNbfJS/MEzTVWVsxlyIcZCqGH/+vdlo0U2/StbObJ1qaKntAnZO5DR0thnsOjx
 301xobAXI82wnyo8shDo+w8k+TIaDv/feCmHJrkk9w+DBv7QtYJaTlOxIJMod3PErNvRIIa90+m
 0E7UrgymCvKu/gCQ5zhJ4V9FIEWi68CF84P2KEhmMAJPx917jvkmi+0dFyR685Koh0Y3gCsNuDF
 /miZ59mby2kXRYnMx2f053iIcE9MrN5/irNK1MWkL3JiTePNZBnHV9G4KjKH/PV+0UJWfliA8UZ
 PM09k/4vPT5zRI7t+n5x9sn7iNo6F6KQFDSZ8OcAXk8wwQ+bulIGZPEN1txh2NDAI5MEK4Ffc0m
 INSIq8mNWuz0ZYQz+JyOriVXD/OBr0u9UfChxC9MiwQZ1OHFo9cHsTb0mEd5y4S0KUuLoeRJ3Bk
 fal20GEy1ffCdwx1t7K2VMlzU/KX9LdcxqFDofHAVYcfivqpSld7+trQnSoYpYkiUIWFwJ+CkuC
 Gyc=
X-Received: by 2002:a05:6830:6514:b0:7d7:f146:8738 with SMTP id
 46e09a7af769-7e381f70e3emr7688101a34.12.1778523791957; 
 Mon, 11 May 2026 11:23:11 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:53 -0600
Subject: [PATCH v6 22/35] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-22-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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
index 75834afc6c..c60af2d39a 100644
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
index 348d0d8601..75ab1daa70 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -313,3 +313,4 @@ TRANS(MTP0, trans_mtp, 0);
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


