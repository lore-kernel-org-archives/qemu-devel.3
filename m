Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D8C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg9-000762-1S; Mon, 29 Jun 2026 08:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tM-Qk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfV-0007Ml-78
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c122b25cffaso272741566b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734449; x=1783339249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I73P2D2VsCwRMd9PMwHjaDmHqcZUxEFjuxMd4+bODjA=;
 b=gEw8n9jthqRC4w9HP4qYp3Z626hvFP6oZVMSrWXUalp9KjleSwHeXAELNyBk++myhq
 54QLXbpd9YOj56Uuev8enZtEfpcAnjZtgsNzdy7Yxu7OGxgqjp8vrokoWNUx2Quaz0V9
 8Rfn5a1Fhwq3mMu1FLBvIrh++E1H6TiuHfoLVgSN7TIZyPEPtalEgSjPmCQLvAw6eSTx
 UwFmP7BlnaGNHXWY4h906PWxWVOw73jrvnf3somJC00vmwjmThDT+Zye1eTOJu6iXYt2
 ppczKVDvV/eIVAuSi6r8wn4BBiFt2EWY95bXu1d16eleXRBROAqQYbYsPTQx0BDCf0cZ
 nFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734449; x=1783339249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I73P2D2VsCwRMd9PMwHjaDmHqcZUxEFjuxMd4+bODjA=;
 b=LbNpkIvKK2c3sjwoB9ksDI9qvFSOzIpmF7KPIHa55GoSq7EHXnVuZXoaq15HgTlxlJ
 k6a0/jJUDoCRftzVQDiXoKxnbLJGdQQ6+pHlztReTdpmVk+b9Dq4N7qqww6t3KqPjFfO
 PGgaBNmFZt7CpDSETUbRE9kWIufpMVbg2EdqQN88txHxuz133ihTfgO5jJfjOo3GqH2j
 gAXJ2/xvEzEx0QOIZ34zseIR9TPqOWuWlWXCxvAmDr6l02Ojk6lEDv/BjfaneOTJ0Xhf
 JnMsNJWZiTtSKXNZQF6iFIfuTJT8HKned5yyn9aFCK6Mt2FpYXPyOuCxRFdMZkeH6T37
 DneQ==
X-Gm-Message-State: AOJu0Yy6099235kolZ6Kt392KbPsI75XXKcxJ0T0BPVeusg9K73GySq9
 XcoNxq4W31OGR4UaQO+oalni6uLgRdLaxMQVOKHNpT7GFrCLB83iNgGoY+BIJL/9pnkSqybB4gA
 GrcoM
X-Gm-Gg: AfdE7cmJ8jzD0hJeMxrKS/RCp9YnRubGO6jNz6DZaTgguLAETxqGRjbAdqLxhCxAuxi
 81KxmFg/ZbAhZVOWRysE1SJVmtFDFJCc8oG0eSHnoAIvQHy/jTaJqWwdV660DlfpXsrTNE8sbJz
 MF9DuZC0opgMIfIFAuw9RC/8j8eqjEfeUoz0WR/Nuto6D+SMpOuJvcQgIwVoyarfZmt8vME3lpy
 4zKOKJH06dNsRcsA3txcG8YHlz/8zSJReaago768DPxL5q8w1rB3gTZWn1h7BIyYI70ycSgB0my
 YKww2vdgbylr+4jadZLMz5K4Yy76LVdsTmgaSn3S4Cz2ZCWTJKtaGcdpbbvOAtcdA0kt2dt3aKC
 tAeSkLnZnkYEzKnKiBncfYBdDb6mlVWmXDw0RS6Rk6THDf5o1e8dZqX9o2oSZBS2n3w/P3Rf4r/
 rEsOWsJSBCtoOGzxdJQXj2Z/lj2jfVjCdhfkQ9UM77WXSylXJN9llVjIe8HAF/p0tOCFeGskDdh
 s/UUhAoSck8pkkNF8J+IDXzt3fQPp6z
X-Received: by 2002:a17:907:3f9d:b0:c12:6c23:2f62 with SMTP id
 a640c23a62f3a-c126c234712mr144053766b.12.1782734449269; 
 Mon, 29 Jun 2026 05:00:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/54] target/arm: Implement FMLALL (multiple and indexed
 vector)
Date: Mon, 29 Jun 2026 12:59:52 +0100
Message-ID: <20260629120032.1645265-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Message-id: 20260618041517.573469-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 4 ++++
 target/arm/tcg/translate-sme.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ccc33463c2..80ad674cf2 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -771,6 +771,10 @@ FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
 
+FMLALL_nx_b     11000001 0100 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
+FMLALL_nx_b     11000001 1001 .... 0 .. 0.. ....1 00.. .    @azx_2x1_i4_o1
+FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ae1dbd0528..cc85c6d6e0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1157,6 +1157,10 @@ static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
 TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
 
+TRANS_FEAT(FMLALL_nx_b, aa64_sme_f8f32, do_azz_acc_fp8,
+           a->n, 4, a->rv, a->off, a->zn, a->zm,
+           a->idx << 2, 0, false, gen_helper_gvec_fmla_idx_sb)
+
 static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
-- 
2.43.0


