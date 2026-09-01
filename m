Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6461CC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONl-0001Wt-SA; Tue, 01 Sep 2026 09:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONj-0001Sx-E8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONh-0007Mm-MM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so167239566b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268708; x=1788873508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T6Y8NTxUwacUq1EZfJmnQGUX7BUFz5w8qBfHF+P51yc=;
 b=kqI/oMdGcpzh5rEeeVwPvb1o1AMt7khGo8Kbng5h2dCnluv5sahYo59XjWvDWnQRrG
 Rg8Lho9MMRSK/Q+/Fu9soBky+v80J/0qFCu9QmQX/4DT2+gwU3dNawnFvYXeSrZAOAN7
 O3w7AYnYZgNRjOk2rfuRMPM2PA4iqbWCgu/LZUrl304/c3SYA3lfTqAOKyzoJhzddvOV
 kG0lwABro3VDfHTPistpxryBMNZUwihOn1ScSvSp7DRHLLL5qfO2eGlGxYyVhLSb2RMj
 ETs2g6yoN3ehrZp6bbd7guAXSsNpeBK6pueNcT30UwC4Ebe2zlO3uuD/OMmW8YW2zGmr
 2h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268708; x=1788873508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T6Y8NTxUwacUq1EZfJmnQGUX7BUFz5w8qBfHF+P51yc=;
 b=ox78YbEKUTLCqfk7hW2lRFa7jiIb8mDahDPNPwSYGVdwa2VFe3apsnVjhg9urrIoZZ
 EyWocdeJdaeDqMFSElg4taAWkLOeGRjoNNXWdatUheGhFJUe165zBdxwoGdrDawYDFUN
 0CEGDgXLXm+O0Knhq9YS0p59oKcNSa5m/Rn5o9LIUGQsQ4KurKuQKfT+eBqzuy1tGaFJ
 itJyOtLPl8fbZQSx53rG3iz5DYuR1q0tuSBnoFPs9muGrahbC9vj6ytHWveWBEpgCn03
 EjqGz4vbfCeaWSJTCvZ1ocUjDM4zAkBovFtgZsPa7SzpmYD8UQfQf+Igb7/Jlvo4zoDc
 E4yQ==
X-Gm-Message-State: AFuF++mfaceEuYLacHuYw5YwU7tWv1Vb/XKyvqfu09KiGHePLad9th0X
 oPsWzHhwtwfmHlDbBs5wcaATNoS4ppaq5y8ZYBGf+5wyO1F8+40iTZ66K8f4bbGbQp09sxrLfQX
 i5TayF+A=
X-Gm-Gg: AR+sD10/J3B0Ny2EdaPuIJ8Hf6Jkahd2nJoTBVKeJLFPuC1bxAjzJm0Gy7vwXb3kk3e
 G7fby0sz2M8TFmUxBC500t1LOZKnbu29NVKYmjPhrS6SbJjVBW8pJ+ZCEtsHlAH+LUShxXUg8Wd
 MmddDTgwKEm9aJInBKe1S5X4WAZuCfFH4JwN82uul8HPoOzKg0b9vKGH1aU5C/5W0mLqXTzwZF4
 BruNH2W6j7HUq+0B7SOv8JZc9gWyLE9WoYzTeL/BPinSqoUb73Rp/xgoUAqO69dYY+R1VM4ZYwp
 JmMr8BdX7WzWtBKgebGYpdf8TvZDTfyGvmFd9RJlzDS5qx3oZ1JRQvsJu235i1YCPKjMCb95s19
 Gbkn1/yoFlmQXAw3STwr3bZMzeB84dXC6RI93Ppiko1hR8zI8beaaiSXQax6FEu6GkYh9y++wFG
 p21yk1Tp5Ywp+GqksECuGpfYyVz3+GWjs7PwhbNzEAPT6cRdY4RgGy5lUgeOBnYHZm76BvLMrrP
 E6Zs2fC5lAvv4m59CX51GhdDx3e3P0FyRtK+IrhuPbBRXxsWnImb/frzDNIGCsC03Pn6w==
X-Received: by 2002:a17:907:e1c5:20b0:c25:4ba1:594f with SMTP id
 a640c23a62f3a-c25b8ce561amr278732366b.0.1788268708219; 
 Tue, 01 Sep 2026 06:18:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/58] target/arm: Implement AESEMC
Date: Tue,  1 Sep 2026 14:17:29 +0100
Message-ID: <20260901131732.2263947-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/sve.decode      |  3 +++
 target/arm/tcg/translate-sve.c |  2 ++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 05f193b3d17..ae677cdf209 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -193,6 +193,37 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            AESState *ad = (AESState *)(vd + s);
+            AESState *st = (AESState *)(vn + s);
+            AESState t;
+
+            /* Like above: Arm AK comes first; api AK comes last */
+            if (HOST_BIG_ENDIAN) {
+                t.d[0] = st->d[1] ^ rk.d[1];
+                t.d[1] = st->d[0] ^ rk.d[0];
+                aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+                ad->d[0] = t.d[1];
+                ad->d[1] = t.d[0];
+            } else {
+                t.v = st->v ^ rk.v;
+                aesenc_SB_SR_MC_AK(ad, &t, &aes_zero, false);
+            }
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 /*
  * SHA-1 logical functions
  */
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 1a0e4130aa2..512054d2f5d 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -460,6 +460,7 @@ DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesemc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 1ab1b4042b5..5832e0190c6 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1988,6 +1988,9 @@ AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
 AESD_idx        01000101 00 1 .. .10111011 ..... ....0   @aes2_2
 AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
 
+AESEMC          01000101 00 1 .. .11111010 ..... ....0   @aes2_2
+AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cb1542f3931..64ff2345307 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8346,6 +8346,8 @@ TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aese_idx)
 TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesd_idx)
+TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesemc)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


