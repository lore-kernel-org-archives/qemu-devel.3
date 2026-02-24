Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A7E9B25A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFJ-0005Ye-1k; Tue, 24 Feb 2026 07:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF8-0005XL-IW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:23 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF4-0005s3-UD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:20 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b884d5c787bso874069066b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935017; x=1772539817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRvKEquHoRhR9FTtoJbDGwgOdmk9XFImG/i1KpW6qVc=;
 b=YkiLoTJxU05iGoGtoTXut76udDURfSW3EnubDE0sZ7DZRksoN2icUhKqvP22qTkPqH
 shjTj2sHMH2BBejpbwBVf9JfN0eeGdwbWRMdy0RJhU/7HFM+L/V1M0z5SHgXTxnUTXwj
 x5Q06H9U7gEGYdsFZF8WrwTkq2yZbRaaINB46HMRSVANN0Wksiayc8fahHrGlhp+l1qL
 iyRcfVFntLx2fCF3CpmzSbrKUWpUykLoe6PVnaQR/kzdKts0ePEYCiBInHwdpvW9qh6M
 sbbusHFyd3Kpkgu+ShzY1ylvzQ8NRjUdTn9lnM99uDSJt+xqIpzfK98lv6xtC9dYp1EF
 0fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935017; x=1772539817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRvKEquHoRhR9FTtoJbDGwgOdmk9XFImG/i1KpW6qVc=;
 b=jXONMQwn3gvY/sfhpGGrh88TnK77dIi68NMvHag5SfJRENtitbICV73S+NtIAZ5r6A
 rt55mlUe8jiC+8SoHCWiyHWNnVgtrxLTPt4i4R1+qBWemMY+9yprtzOxCyo1icOc7PFn
 pusrAeksafYrwyiRvBP10+yFsR2rPCfOpRZ3RbbK98K6VUEucxMU2fIDYgPbVpmAvs9G
 TiAQ5ujyGF7kEGAaeBtXgKzdPljR7VOiWwlk0DWSrxjcJxGK8KfAWfzsLCp5EDhjvcWx
 41XAk/sMyrhjYJ4mBOnm8kpygUcKQT2JqggNZ2H6S5N0ZZIO8uY2h4cmbNFAxjgXnJO3
 1H5w==
X-Gm-Message-State: AOJu0YyOze5ilyNwtHd9tNoWvyjHQscfC4CCUiVKvpf6aO9VDTCCkv29
 23M7YUOOFmOfs7fBqasWJUnTgnrFq73gvI5KNTfOMlANnwwwZUhV0lqitoKkr2n7IHrjxqHtLpg
 2APmC
X-Gm-Gg: ATEYQzzOnHn8SyEKDU74txyuvTIcaQcMkOJ41lx8o8yJidmds+mhT9uILNRRMAwAY1E
 yd5m/4TBYOMrWuVHx0JbGZntTLigP++3e61IR/s6BUyGD+SEcirq9qCDUqeewCDHs7l/D8YdO1I
 YvfnhnWx2Hp63H4OGPwGK9YU348VsaTD6JBJETa2+LxUcn15zdmIZkqteIZrzUv+QoMF+GQtDei
 xg5Vq5FQomgbY3T1laZJ0SA842ifT3+knEo/kZqdpzs+XihWpOs7WOBMxhSr/8LMpc7DhC2EEzw
 QSUTvruF21p0wGJZIB3LTCeF7UQcN+YWPiHSHGq144oKACfoWXEVSDbU34TD5i5qlZDQxk+1SXL
 +ovVMF8qH2SaD822dJVYYkPwREq+lm6g0OKR1aBvPBiQnK+Idj+90CJbmRuKt0S5ykcgfVVEI4+
 utZ/B/L1bEWF98ZYVY+WZDNLE=
X-Received: by 2002:a17:907:fdca:b0:b8f:9283:f3db with SMTP id
 a640c23a62f3a-b9081b5e4c9mr735760666b.53.1771935016752; 
 Tue, 24 Feb 2026 04:10:16 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5de66sm428690066b.10.2026.02.24.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A64365F8BA;
 Tue, 24 Feb 2026 12:10:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/8] target/arm: set the correct TI bits for WFIT traps
Date: Tue, 24 Feb 2026 12:10:07 +0000
Message-ID: <20260224121014.279248-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

The WFIT trap should be reported as 0b10.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4d708635068..aa14f15eb62 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.47.3


