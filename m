Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A70CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4Aa-0005ls-KU; Thu, 18 Jun 2026 00:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A3-0005TS-T1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A2-0005aT-2N
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c6c57c5bcfso4558995ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756124; x=1782360924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lo1SvQDZ7bTY6IMwdvD6UkdlbGJhlUGXDrYODR1SRVA=;
 b=ZUlw0cZ8NQ/8OlQaTLha3KOUw7L2QI+200XzQUnawIDDorLsQY731B72lUN5pY+cmU
 wbELQquVk779ZtnffaPLj0aJez5UasY8nTKlEZ0XwhlEHn0ALK4qRd4qfd4hhzDIMoBD
 DbMBjQQVsdtZIQVcEXX0hoWG736mdC9xceCvXxgyfje5SBnVwxu6MenlmDKmBk0/DyDt
 3LsSOvPrjlfnm+CQfkC9jRvDrwALrZ7HLD+qEEtAAJ1JxNnzqybqbtqB7h9Ejp7A7bLo
 ztcOAAJ8PIZ/4iobxTu8C5SVnIkDeoD3HpoWT9K+s/vq5Z8GVYBKhZwkaYBdcaowgmaX
 hDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756124; x=1782360924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lo1SvQDZ7bTY6IMwdvD6UkdlbGJhlUGXDrYODR1SRVA=;
 b=mH2C13mF5Zh8b85VwDZUcJfjxJxXA2nOvvsFPWb80RsCygtFOSbB2B/u6e1rGajU6f
 pknKBrgddeZQAbpM+5EKVTyOWCZCR4rcWyg48mTUSx2H8gmockIyOGEanETV0DfJh635
 hELPZt9g8fEhAKDA4gcGEg5VZHz81+n4t6gZqqNz2U0deE3QpAbAfedeprQuWBnOdr+k
 zXPjtjGefLvgTpreOgOnyGHvQAEsm5pMBVDqicBTAhXJxXhR4AYk5aDlZk6S2o5KNQfn
 AfpFUfmkeawCyw/pH/SAfGVfD3f7p6hePxxlpj49xpLV48ADLMsH/YbR5CHPgGV1CECs
 Q68A==
X-Gm-Message-State: AOJu0Yx2uOOz4+oPMfhBykw4Zn9NSlBK81uh+Ic/hRuiledNchmTk1/i
 tkGICDFVRWOJCBe1Dd15GGclI6V2aQJ6RbX6FW7ndmeZb7BrvMZ6AVyDPRXEgduYarkHdZO0xl4
 5KJyz
X-Gm-Gg: AfdE7cmCC1DEH0dR7JYVIaP8Bz1UOWJC4govp+qT2p86EikCJFIFxKQuZRAut854uOX
 Szn7GmcL78jjoS7FhGkzQH0u3dtC6azmW57mfF+aGocugupOwUu/js0hqSzT1yDZjNUvYnZOeZ6
 b1Wz6/EebN4wbymxf2K49SXWNa8izuikNKUf0I28XwgwEC6zq16kWNnSZd6H4S2Fi56xRU+Z9Ku
 9Y9nw50dc8QRbNMgLpJMjJohte0XkHFzNrFX6jO+XtJW92+1Hv+mHXWLDcsrCOYpfIIg3Yomu+r
 rgh7x4obtS9uy+rBdEqXBQHlmxGJnk2FRXluKc8T3IK3E/22+wfKhq79+2GsZ59DEJF5YuRqDcY
 TcONHfKmRi9XO1R+oPTbdAefWKgpynzztkbj7gAOSevTjoFOrZJODlbhwt8b9PJ2hRwLI7+TC02
 Vwh0mSCzAZ+dNfG7CGcOf7s64jA5nX2BqlZ/etTgUd254Dvc60WA==
X-Received: by 2002:a17:903:2306:b0:2c2:75c4:4b0f with SMTP id
 d9443c01a7336-2c6bbf99275mr81442515ad.2.1781756124446; 
 Wed, 17 Jun 2026 21:15:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/10] target/arm: Implement FMLALL (multiple vector)
Date: Wed, 17 Jun 2026 21:15:11 -0700
Message-ID: <20260618041517.573469-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/sme.decode      | 3 +++
 2 files changed, 4 insertions(+)

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
-- 
2.43.0


