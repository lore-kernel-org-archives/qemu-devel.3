Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67FFC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeN-0000XD-79; Wed, 26 Aug 2026 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHeB-0000EF-Eo
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe9-0004tA-K5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso1312357b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766163; x=1788370963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WrrRWKpGNWDrU8AN2wOPobSA2FL+e0hgHNz5HBTnLvM=;
 b=mbfmvcaXkfZQNtJTodnu397UALlTaaAFdC9q6LA+/lqfx1Spz1dO9vHm6ZQp4VN/oF
 t17aUNUN5VtclYrPvHQj2st7pI7wNeqHq1skSl6GZi0a9ul1nZWAgO5UpcInVYf9N+At
 IFai0cGA0geAG81IxA3bmG86mOYQmHDRhL23kg91+5cqw46Cjeod0VXJOx+ywo5RjU2U
 S9NWtiVezCELZfxH5TRH9KXJjGcrI+hk1L/zXzCJfPNl49LzRwfjGPFw1Lv5dSkpbuGG
 Zdo/hmGksqpL92g9n3AL67OmX96Z+tzWAPCaiyda0rQimtkjwamhdWlSOxt0lT8XP5qH
 vUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766163; x=1788370963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WrrRWKpGNWDrU8AN2wOPobSA2FL+e0hgHNz5HBTnLvM=;
 b=jB8SZLXFPMhBhV4pz9GZOm2CditDbL7EdCit4XOhY4HJaPYsorrVSc2PdxXYhKnCWM
 gyxxVH5ooPDVVm1aDyNw1oVUcFYieG1R8x4UWNa3NbSXu3a6/4VXosLdGktNUKqGL5bH
 jffOxMXgCYLs+b5FjnfFGI51LISiF9a8MqBkXc3Qpj6g8Tp7pbj/+2sRkRqvr6erUNBX
 vjPQMNjH2iv7C5Oh2x7MadmE5/yGJ4a5ocoOSe33nQ0519FDEyYrIEUxcijmqKXQNrED
 dZvTYaLMzwAWT5P8Bbii36MInozRcwiN5WQ0z8v/uSF6fu7jNMJbvSrx/1YvYhWKSGH/
 FXHA==
X-Gm-Message-State: AFuF++k12P8sgfUwbcia1tkfDv9oIzdVNhpfHe/qbpwJS49McQFjBKhH
 FhnRotczOcShFmuRDpHU3Uaa9ONWWCmKWon/dhaaZhhKadZTobTVUhf7kwwabG3eeqdSCH39BBx
 rrMJ3jRc=
X-Gm-Gg: AR+sD11wSHXPPNe7bSjZXVObMoTIQ9hTEh49rv4OcKop1ZK3JQBdlv9fUdiRTE43Qdi
 MuSu00YaarlWm0rrVmu/2WGf9r/oz280lfjoPljVRkd+a+0K37rZfypVinhgHGgJRof9HkARF0u
 AhVZfRQfHTstHuThibnLghGhpG0R/mUoX1igEQ2fu39dQawip5MKLHDhD4oMmCXbvhcItdPCws/
 lWvh9U4snKMKe8PpkH5HnNmowxWTht4oJI7ugpNzIXILbstQipNW9xXdT/CzQwBBYuNVA/r5t+r
 Cee2slU+cLIo3yxzwbPmtiIQuxIIKbek67fbRs3Y+Kzgx8ogS3oZ/k7hQS3SAAId2q58BdP2oxk
 NlB9EPZiNafu6FSDMcYEpvqZ3h1uB5xxRja3TIxMkWO/MCP89KBwkpdVMiecJxz1RwhIq0RB1JL
 Jv7OR8f1ZOY4NNRtlELUS/J2iCKc9Mf/3fYD94Xw1Il+I/yxzXjbV/TY4iu1XbWUslxusiPu3K9
 VWO7J2JRSaPJ1Mjug==
X-Received: by 2002:a05:6a21:a87:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3cf75773e9dmr18258053637.6.1787766163170; 
 Wed, 26 Aug 2026 10:42:43 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 24/25] target/arm: Implement PMULL, PMLAL
Date: Wed, 26 Aug 2026 10:42:11 -0700
Message-ID: <20260826174213.614571-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  3 +++
 target/arm/tcg/translate-sve.c   |  5 +++++
 target/arm/tcg/vec_helper64.c    | 34 ++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index f78e77662de..498468a7723 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3215,3 +3215,6 @@ DEF_HELPER_FLAGS_4(sve_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_pmlal_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1098cf0b388..10375577b1e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8351,6 +8351,11 @@ TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
 TRANS_FEAT_STREAMING_IF(AESDIMC, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesdimc)
 
+TRANS_FEAT_STREAMING_IF(PMULL, aa64_sve_aes2, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_sve_pmull_q, a, 0)
+TRANS_FEAT_STREAMING_IF(PMLAL, aa64_sve_aes2, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_sve_pmlal_q, a, 0)
+
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVTNT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 88799693507..4f43869d9e9 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -89,6 +89,40 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
+void HELPER(sve_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    uint64_t *d0 = vd;
+    uint64_t *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[2 * i + 0] = int128_getlo(rl);
+        d0[2 * i + 1] = int128_gethi(rl);
+        d1[2 * i + 0] = int128_getlo(rh);
+        d1[2 * i + 1] = int128_gethi(rh);
+    }
+}
+
+void HELPER(sve_pmlal_q)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *n = vn, *m = vm;
+    uint64_t *d0 = vd;
+    uint64_t *d1 = vd + sizeof(ARMVectorReg);
+
+    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
+        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
+        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
+        d0[2 * i + 0] ^= int128_getlo(rl);
+        d0[2 * i + 1] ^= int128_gethi(rl);
+        d1[2 * i + 0] ^= int128_getlo(rh);
+        d1[2 * i + 1] ^= int128_gethi(rh);
+    }
+}
+
 DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
 DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
 DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, /**/)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 7030d81db7e..42f451ff9f0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1994,6 +1994,11 @@ AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
 AESDIMC         01000101 00 1 .. .11111011 ..... ....0   @aes2_2
 AESDIMC         01000101 00 1 .. .11111011 ..... ...00   @aes2_4
 
+PMULL           01000101 00 1 rm:5 111110 rn:5 ....0 \
+                &rrr_esz esz=0 rd=%zd_ax2
+PMLAL           01000101 00 1 rm:5 111111 rn:5 ....0 \
+                &rrr_esz esz=0 rd=%zd_ax2
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.53.0


