Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2E6C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfw-00071E-PL; Mon, 29 Jun 2026 08:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tL-Qs
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfW-0007No-K5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so11484295e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734452; x=1783339252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7NXEh6OXHSzjD4eG2UcaoneiN/XAFR9prpxJ8BGPQMw=;
 b=o/eV+aFgZMAwN5r54WfKHjho043kIVfBlB8HyFsIbEnQbHMYWPDBrSvvtz7V5wMvxO
 R48eHbcNg7+XPO00OfMWig4VqKUhyFy2ZpXXti3nbXdxzt7upLU3zmgIPmIng3MJitOy
 2jnlQiIp38wh7x6hxHFTRPpuOMIKg4h+GcZ9ZX3KX+GuqPu6MsD57gdKxZd1FaPCqrKJ
 RFg0bJm6uGe8+BzNyAKQqG+mFAMyj+MxCuQGAX1Z5bxP3xClzbRfssLGYmH2VyMapN9S
 Bs+2D24LoUqKlGLFFrNxTw8V3L9IU/IMCCLDukU4GlhM/By5/jE5NjPdMWBzUBwrjj2C
 NHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734452; x=1783339252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7NXEh6OXHSzjD4eG2UcaoneiN/XAFR9prpxJ8BGPQMw=;
 b=rQMCNNXJd1C0AdTpjOYp4MHDa0LH+Wfsowb2Pi4kQ61XCnFd/aWrMVFcBdaymhzS4h
 OaqdjF7YSbUCxpJX0rgcJn+OrFF+P6uS4A4IJju+mV0YcTVV9Gbr1o9Ai+/9LWOe6DGX
 RQSSbTdwvTTD+bDiukw2F31ApihZZ8mC70iwzTNzmk5dA8eC3mGdzePO55+YPkiL0zfS
 EEiS5GYZ8fy2VyKNqAwmfs5e0OUzKeQVme2hQ+Xp7rS6jSAL48pFQR2PbkjA/e969zHR
 7w5NB2zCAGh+WSm1aypmdrr0BadAQIiUC7cVh3dzcadZPcscVapGslZKFU6VEt5eIO8N
 vShg==
X-Gm-Message-State: AOJu0Yx2QaG+rmgZtSEhK4tAU0Sswpbm1lZghgLaJ6XcqMYA8cPTha+s
 YIImh5jiqaKXR8ekT75VMqQaNOvqpKciTjCq6vfb1zOHPwzVMe3ssgTij+cpeI9uZ/8xgnfuLnq
 xwuLJ
X-Gm-Gg: AfdE7cnB+MejU12fmGGTtCxZYZlkAzpGjFZK5R/23H+if4oEURR/nvc1SruEqTXznlM
 L0hjAjPYBwHztMTqiD7YoFAdOABhS9i54OmzuXiChdzm1gXglhuyZSg/oMc81cIcnUexL5BIbqv
 v2ZVZmFYdHVUdl2fUOwe1oBEcJyh+3sYJNy/3iLtDS0wCgh/0Pj2SDAac8mii/sKpkyDm+75brM
 NhkrdOCj+h0sWVgoeIdzZHaJgEeF8x8O2SO779oi5REa3fx9KNOhdFTKh4kNYyASVx60qzYDSPn
 51nmymFbtAs9hoaD0IgVDIyu+7wshl1OWTNfWJ+IIghfOPKRhZccIO3Jw/08QVQd1SG4gbzLu4r
 MstIXmDKGHGVH6rnwfDM9fUQxbhIp6BC502IYzjOdDE1aej5fgRrvSjBz88oxuqflzqd5nwmZE8
 3ouqD4Ih4Vl2TjOY2GoBqoA/cQavp9JOA5OANHruDTSsbh4Ta1Uq5ayn/FGJKa3YN+1CvBizFkf
 nNg1Ro2n1NFyH88Nakucg==
X-Received: by 2002:a05:600c:4f4d:b0:492:7083:e5a with SMTP id
 5b1f17b1804b1-493b71dc518mr9286085e9.31.1782734452397; 
 Mon, 29 Jun 2026 05:00:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/54] target/arm: Implement FDOT (multiple and indexed vector)
Date: Mon, 29 Jun 2026 12:59:55 +0100
Message-ID: <20260629120032.1645265-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618041517.573469-9-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 3 +++
 target/arm/tcg/translate-sme.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 04dd0e6df0..7324ccddac 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -781,6 +781,9 @@ FMLALL_nx_b     11000001 0100 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
 FMLALL_nx_b     11000001 1001 .... 0 .. 0.. ....1 00.. .    @azx_2x1_i4_o1
 FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
 
+FDOT_nx_b       11000001 0101 .... 0 .. 0.. ....1 11 ...    @azx_2x1_i2_o3
+FDOT_nx_b       11000001 0101 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i2_o3
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 467b44e832..a9adaa02bd 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1161,6 +1161,10 @@ TRANS_FEAT(FMLALL_nx_b, aa64_sme_f8f32, do_azz_acc_fp8,
            a->n, 4, a->rv, a->off, a->zn, a->zm,
            a->idx << 2, 0, false, gen_helper_gvec_fmla_idx_sb)
 
+TRANS_FEAT(FDOT_nx_b, aa64_sme_f8f32, do_azz_acc_fp8,
+           a->n, 1, a->rv, a->off, a->zn, a->zm,
+           a->idx, 0, false, gen_helper_gvec_fdot_idx_sb)
+
 static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
-- 
2.43.0


