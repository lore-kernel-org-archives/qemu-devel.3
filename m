Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC40C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg8-00075j-A7; Mon, 29 Jun 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfW-0006sX-TS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfS-0007MR-Px
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-472493849a3so1257092f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734448; x=1783339248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VXFilGwZO6Lxb9w6gQAfVKLFe+2dN3L93usdO1OfhGI=;
 b=hGVa4uhau4RyVVTlaOhQYlDFbhJoGyAQPAi6zEjSJOytvxUDv402U/X/3WZUtV6rmj
 M3+IJ+wWroB2jSJNHB6Prkr65rtdnyNt9CXWjTXOf7stJiw53KP+I9ffpOaRwnuDRWkv
 WYc6ZSdbG84H0DEv7VS9b3mWGeZl9UbolesVCYZdebRZvmKi/3TwcufxOFv6jILvv9df
 JbjvEapyfHn875o7znD0kATCKX04QA9Xr0EgH1xN5MMBaV7jd5tkez08AetwdFRLAWA0
 sjXgqcmh71POPFWBv1xhtxaQ7R1ijl7vXnrakQyu3rAy06qdVTP286XI0op3npX3z2/e
 CbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734448; x=1783339248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VXFilGwZO6Lxb9w6gQAfVKLFe+2dN3L93usdO1OfhGI=;
 b=oCh0a/EwK69G9h5RjKZUZROn4KPAlJRXCE/lyikm6CIzPumOO6pYhOqkNdjJDAW04l
 W6YK1jTLOW2iK1T2C+yOiiy/8lH6HyCAZ3krZDwnCIfMHCCt7dB64LFEfDZ0J22eH0wN
 6mtveXt6uAYp4i+PVIQTFGGCww8ABeE222vKNYBOjZVBuP0FkvQxrVPs88O8ofBsW9pS
 UjL47I5BUDFONPcrnrnsmeKF3wsm0NNox4ldTdly7oMi1IIp0xTyblKBqTog58aiz+qC
 pd7w9QHedNreEpJglf4v/WzREZjuJLuQaj3pEZzu9PDeaULhb3+uniE6NNusdEAy3qID
 7YNQ==
X-Gm-Message-State: AOJu0YwcJIVRP18Wyys9JowPWlaz+CE9UxiKkuYuApofTv+KdLke6sGF
 vEw/BdrqLwygpgT3SgXz+7f5wPjuDWukMINR6mgaBPisR5h301Aeki7+p1v0E9WCL4/RtUX2obF
 +ThH6
X-Gm-Gg: AfdE7clV0LrdILvavKWOqv/S4icL2LH3eIBot443K3x2KWfHt9N6Sz3zDk/BTL3pRB3
 LrwjG8Er2HxjZOrr11VjT5Em0qc6dPDNJHtJvHj6OjbIedPQ3fPyEOnmuwBUzwDQiACqNfQx32e
 Vn3ygHC431XjeIItos8tKTu0GkyMnF1BeyjlTikgxx7/FDESjYhIjSZLLJt4uDBCldHvrAaxdxi
 lyqbuC4bgj+zfANpNTvWvpU3KyFuod+X9GF8bKEs9ZFXFQnmVVPuNBziixKrNQi1YdqB8aVndGB
 OeBHLziccLIcQkNWBPMN7PW1PYmvdml8WqIFLsI3tsQzn5uLntHyPBgh93jBWjBv6P74xnZDn/r
 HTZFRTZ1UtyYvh1KrB8BONsvl2o2nmNExRf3uWJ0hSpMdCwhd1kLuFKunWDrixRObBRaBBopdJ8
 8t1Q9KOxfGQLlszgRyZbxOaNoNtNrKf2ThfxfOHLIbPlO4nebw4W0rso6WK3TONK7icvCdlGv+T
 vAOOBmbuWUpkE5EWrIYsQ==
X-Received: by 2002:a05:6000:2c0a:b0:474:9991:60d9 with SMTP id
 ffacd0b85a97d-4749991628amr2384137f8f.10.1782734448289; 
 Mon, 29 Jun 2026 05:00:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/54] target/arm: Implement FMLALL (multiple vector)
Date: Mon, 29 Jun 2026 12:59:51 +0100
Message-ID: <20260629120032.1645265-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618041517.573469-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 3 +++
 target/arm/tcg/translate-sme.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4956995924..ccc33463c2 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -569,6 +569,9 @@ FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 
+FMLALL_nn_b     11000001 101 ....0 0 .. 000 ....1 0000 .    @azz_2x2_o1x4
+FMLALL_nn_b     11000001 101 ...01 0 .. 000 ...01 0000 .    @azz_4x4_o1x4
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 30487c34a0..ae1dbd0528 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1119,6 +1119,7 @@ static bool do_fmlall_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 }
 
 TRANS_FEAT(FMLALL_n1_b, aa64_sme_f8f32, do_fmlall_fp8, a, false)
+TRANS_FEAT(FMLALL_nn_b, aa64_sme_f8f32, do_fmlall_fp8, a, true)
 
 static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 {
-- 
2.43.0


