Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AC8C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS70-0008DO-M9; Sat, 15 Feb 2025 19:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6N-0007gZ-8r
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:41 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6J-0006IT-Te
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso65732745ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664087; x=1740268887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rukBaoFAhTzDmJvULpWTGzngQp4v55URg/psH7yIqjg=;
 b=akkxytO360qN3nPUhn8V84Aq7NiuZewAXV9gJBgGzhQscQPVfy1FUX4Jyq2dMfxjpi
 kDSkqKLCAfz7ct+ovysCHBbhexj1zoMtxIueYx7OPnsJn1bcJHzOKAn67raMgT52GZaD
 C4QnbszIHVqwMdJ63YqSud1gTYQ4z4DbSInsyM4247JdKPuXSM5gwbWXNJC1LdB5BMwL
 oHYCsE3VpyM0uTd9vSVAmSXMri0WKeTUAFoHUSk78GMsHObbprS32snbRAiRSpy2E65N
 0yt4uMWJ//jFRJAO4ODYolLEEonSRS9OyBM0zhVHWCmLtJfxWP27QnZQ5Yw8mdOgMw8L
 2g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664087; x=1740268887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rukBaoFAhTzDmJvULpWTGzngQp4v55URg/psH7yIqjg=;
 b=Gnc08yBnf+a+vsRx8OrRcQfFwQVkVriqOtBhyjjrRgN1atQffTX3Fp/yM2jaN2XWEW
 wYQLhbD6HTec8SI0PKP9M/2NUg1/4yr2qh8H8hRkAdaLjJvVq9BgBLDgm0CykF9RUP7D
 npLP776g29SUprYDR1itoT4xALr91txHNT9r6zR65iSzxUb5bADaGkR8VatZzj1dBuCG
 1JPMSehr1QCY0s1EPtADf0AKeb/cFBknHhHJE99LA4kFej8WCQ9nJLhaNIcXFV/AIZgH
 RdqKIVgh+E2bQZzuA/x1ZrYDsqp3OuA25GZhC3Sm1zAot+00jJXTJybGqQqKo8Lr4niW
 u0uQ==
X-Gm-Message-State: AOJu0YycWqJq6KT1vIotietCOvM6suKPhyWS4FF9AX1E+RHXGtzL1AGf
 t6W9N4t8sRLnaMDjdgA1pOyqc6ZjO/s/MkFvP11yqqfDn6dc0eX2zSZvm5lnXoYLV5QrjoZyXRt
 l
X-Gm-Gg: ASbGncv19CtT7Ym1s/tRDwHZtnYisrUB7eLB1mS2me6UttBpLvIgcVilB6w54TbMu5b
 STwRY91SvnVp4odk45WHXtDFI/t+z2uuBEiOHz8cguDPTVqLZiwbs6p7GfKdXfsVDwybCLPnWPt
 SYtA75YsaJUcmJ6YHaGHaLR88op3xRR6E1FmGIYs0GyVfVtSH8tH2K1d0j0HUY28M8rtrOP5BBw
 oCw0Qo9f5lrH2pXIO3HimG7JIp/slznB5HSrZMDlHobE8EdUth8RY8twRKR/yX40zxp47Qlwa/B
 15y8yC7T5us7tpq4p+SDTBh5+qzE+S59gfm/Ah/iHmICuPI=
X-Google-Smtp-Source: AGHT+IFGg1KS1b0ZQ/uI/4PsLRHL828PsByj/fwQoGql6+uCuPKP5tsJ1WK8ocbwd8XMfBmuy50x7g==
X-Received: by 2002:a17:902:d58b:b0:21f:dbb:20a6 with SMTP id
 d9443c01a7336-221040ab935mr82479675ad.33.1739664087560; 
 Sat, 15 Feb 2025 16:01:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikael Szreder <git@miszr.win>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 22/24] target/sparc: Fix register selection for all F*TOx and
 FxTO* instructions
Date: Sat, 15 Feb 2025 16:01:06 -0800
Message-ID: <20250216000109.2606518-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mikael Szreder <git@miszr.win>

A bug was introduced in commit 0bba7572d40d which causes the fdtox
and fqtox instructions to incorrectly select the destination registers.
More information and a test program can be found in issue #2802.

Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
Signed-off-by: Mikael Szreder <git@miszr.win>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
[rth: Squash patches together, since the second fixes a typo in the first.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250205090333.19626-3-git@miszr.win>
---
 target/sparc/insns.decode | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..cfcdf6690e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -321,12 +321,12 @@ FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
-FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
-FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @d_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @d_q2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_d2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_d2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_d2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
-- 
2.43.0


