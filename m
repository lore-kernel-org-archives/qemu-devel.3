Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA16ACD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AN-0005ZM-Lu; Thu, 18 Jun 2026 00:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4AA-0005WX-GU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A7-0005cn-E4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6bb8a5980so3501925ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756130; x=1782360930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+ZFcB7hmPMQ0d58EGVQ3yeZwBQzynsJic03YTjk5bk=;
 b=vPv0wfNLKKTl/EKE7Yg3/9ewuWWEmKlqq4nZyUYikN403WCYttyfJkCF8SFS1JsWsB
 +Cz4X+wQ4tD/R6DlpKYcErl3+gwyUj29Zt6+ogd5ersaMdXVbhVhd0brr63vmiebfgEt
 yW8sS2j1C+gzFYa1WgdXnHMDBzR/mvnl37gMjNwbdK1ClZwnqWxvc18Io4PhihauNjUq
 C73YuLxcIh+1Q8pDHnT+Y9sJ/yPiVebRCGSn0SFbGXD36Uo+921z+0KSj+j4qBf/tWiv
 xH7VnGiShg0SXvK3ldEBeu8LBYDEeQMvX89g0v9ZY2CZQi4tMDuV7jM3bHHL+NUCMb5s
 ODzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756130; x=1782360930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T+ZFcB7hmPMQ0d58EGVQ3yeZwBQzynsJic03YTjk5bk=;
 b=tK+/kEmg9A72d3njZCRKoS0LIi9fWcMlIv/mnhTrVMMcH9R//zNwptDBUSK76AirU2
 7EVAoucBiA4VQtd1c4BVDRNWd/7k64lSTVxt0N9QaTQnhjTijJ8/XDu1at89mK8HQXTN
 FtWoznuDczU/Kg9WtGQ5esvosyAyzXLao3241uGMP4/iHZdibEOIGSdRSrZfuQd5Nwk5
 k/UmYIgU5C52R/ZRLMMCdOk1Pw0eSxhXIVrv0wckyV0th5kzZAwqx/Un6x+hpcRD4uFS
 zsbv+7rW8ttuX7TRb2uG1w0XogGjAN9Vuz6IZUkLeBTquvvCi/rPJJ6DrvCUgg3ftvX0
 c4kQ==
X-Gm-Message-State: AOJu0YyFF83KL9pvthJyfjL+Ssu93tByePEnvM4kAXq43uM/wmKDhpqd
 YRQlcSbU4B6m6uycCUeeytIj0CzWteF6YxRx3F+xvkgyvD+hrQQVXXbKW+NJWTB1TN51+6FqBTH
 iygdk
X-Gm-Gg: AfdE7cnm5uGirOMI8uzya1bwfmnjIqeCSgVVcKp4Ig95UoZU+LE8NJ9yY018RSA+6t5
 1iEOenFFTgxlyCpMmpXt0nzJJPBCgZMK0QTkY68ngzY6GVkKlwnIUchept+jf7cYHy6bB04dz6c
 T9PEj5HZsoBgN/S7CDEOuPitCmh2TR666GD+iLX9ZhygezxxuulxQ6NK7lk6ofnvQzEE6Z0TwdP
 4tGPlfjAPgM+X/9dYkfNM7HP5kAtULZLpgfYr4IeaMtbTNp5JnliqyS2nr+r3vKEO7eSav8K/Oh
 UVqGtB+esf/4TL+4MOWlP11XZIjF+DdVFAVyVEYrCGYUkUohdOIyADi9gAv6fDamvPkFzEdLNsn
 cWdAVLFom7W5MuU3YN4zW8j8h+aeKKUeBPBq8ozvP3xmAMqaq1KZVDz38IDM6Kql39WNPuUAEmt
 O0+uTCtFLqpAgbV8hdLvEWQFZ08X1JAEANidUMLnBcbMea0prEMw==
X-Received: by 2002:a17:902:f641:b0:2c0:f807:56b2 with SMTP id
 d9443c01a7336-2c6e52c975emr20462325ad.34.1781756129565; 
 Wed, 17 Jun 2026 21:15:29 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/10] target/arm: Implement FDOT (multiple and indexed vector)
Date: Wed, 17 Jun 2026 21:15:15 -0700
Message-ID: <20260618041517.573469-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate-sme.c | 4 ++++
 target/arm/tcg/sme.decode      | 3 +++
 2 files changed, 7 insertions(+)

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
-- 
2.43.0


