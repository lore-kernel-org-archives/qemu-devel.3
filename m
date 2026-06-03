Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0EFCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcI0-0006bk-Be; Tue, 02 Jun 2026 23:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHy-0006Zr-Hs
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHw-0003ai-D5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84234c83142so1386685b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457343; x=1781062143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ju7MvbZ+6rpswi0zKUUV/NNDdV2pPctsZQZ9KK8lwu0=;
 b=OsLT/mC3GsjRIt8t1VPBphQEgcoNhdMkM0SoGCo47W2eapzWxqvNyDpNwg736dB/Uq
 GQqqAmJ/cy0N/wqxfLGmjHddT8vas3dGVhcBXmJdEn0CseMfuh6XJzKyMYNzdh8KRszw
 EHlNqT3Qq5E23Ia/xocMJLADnPDXQBkbJWZbyPGB+zgjOyNFjXaOSI8MReaauCtxH+Pw
 GW4X54Noqcf1GTBhrdbdeb5EL6pA8Z3FZgV1JljUerOURUMZ1wJSFeJeqCqxwdGPrHRO
 MgWH929LbgmSfCy83QLfq6AH4m/hmBoEt/wx2kj0UBS2pirMf5/ToEkvsdCpX/uJSzGO
 SF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457343; x=1781062143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ju7MvbZ+6rpswi0zKUUV/NNDdV2pPctsZQZ9KK8lwu0=;
 b=hf9zuCWNiDmUNKaNM8Da+sKVSnpLIl7/zqGzq7XzRyxrPn6nV/P/uEBeUhq2RWRk3x
 a/wneIpcf+2FgRlDXYaAo4TVsfO4cUuw425aLs5ibeR9SQO2gt7400Rug9bGi598B15d
 V7NhuDanJl5NDo2MDLuc4BAGxia/D7UT/urZlNOPskLgrQP3sKB4ID7nszl7tfHgIEyt
 yv2HerJtRKD6NumEff6wKsLGEjgMAuayQ9d08YR4u9j4XzoiZjPt5GUOFwy1MCPxEsY9
 lvNcX7/fM0CsVNqZBBG39hMtnyE7d8eC5yWdi+lLYkUE98t1KeXGVDgp1bIWvm57NwVl
 zfzw==
X-Gm-Message-State: AOJu0YzKweqFrSM0GGFnUjIfCxaRPLPlP4tynBSy0GAsMrfEZrlXlrMq
 hPlRfecYozV7dqDS+QzTO7uq1+LJbjBi5E6UWNlwxkt0VMb+NXqUyW/Eis2kblg1rD5h8P9affJ
 Em6NtNR4=
X-Gm-Gg: Acq92OFSWcIupIGfZUelRbpizcGDpH7mdOzmDRa9fL4+WJPhP6nACmBaghYNAemnpMT
 azDdTXmZlTi59XDMIM/37kVOX1LSm/HMg1XxfoTonewDHYBsZZNL7BMx4ma6PsgWPgbRZxyyCW9
 DtIBIGj4TwSWTYp7nBCWbb6l8uN9J5b7IkSu8JQJwr6M7gEF40UEks2mQwDzuk6X5FjkSate8Bl
 U/bTCipt0130+Ojv9ApbQKRFY15IOcgGQi33h2zHDc21EiHe1nKDLb61WyVJ6AjSGwwxxPINpya
 ykr0pFwnXDryr6dm6WpioSumqDNhwMzacgkLCxj6mQGDPMZWBw0mGPx7qEmZ8LNrxUpf3FmEMAz
 b0eHex+G+Hz6xtCc09pyRtY16WWjuQiF6fCsLaDEM0ICKq+ep3q0eZ5GRXhHYjZPFzBVakDNyhY
 E8RN48iBRuB+pwV/mM5RXv4k5X+AarK9KeByDjJ+2baU3TUkEtsA==
X-Received: by 2002:a05:6a00:3d49:b0:842:6097:467d with SMTP id
 d2e1a72fcca58-84284e2997amr1578832b3a.15.1780457342961; 
 Tue, 02 Jun 2026 20:29:02 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v9 09/45] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Tue,  2 Jun 2026 20:28:18 -0700
Message-ID: <20260603032855.106930-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 target/arm/tcg/sme.decode        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index c551797c6f..01aad4c231 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -250,7 +250,7 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7ef6f5d71b..30355662d9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1726,7 +1726,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 82aa14131b..652a72e972 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ee874be1a6..7a8e1abb59 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -789,7 +789,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 @zz_4x2_n1      ........ ... ..... ...... .... . .....      \
                 &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
-BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVT_hs        11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
-- 
2.43.0


