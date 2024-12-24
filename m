Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B55CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDd-0007Na-Pp; Tue, 24 Dec 2024 15:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDN-00065t-7t
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:14 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDL-0002wW-Ob
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21644e6140cso59073775ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070950; x=1735675750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoS6fF+zYBIciWuFVqUakribBmIpxW8sJFwdLDnjnLM=;
 b=hHDaFsZnSIG3RwsIImP/mb1KE6Go6dQQQBvAbbVj9QN7HHrv/ssXPHX8lrltBZgwVg
 p6t6dxPvYYcLGnsrKGco4D4OlQUAdt3zSMysC2yo+9PjuCYU/azYxNjEMfGUhaF/gJtn
 /xe4jq7/7KOaKvSy0uVLJ8RsBuQQOvwnmMGPtedkcqYgjt+YplQwfjV5+KC0GNAvgm4Z
 J9Ky+rSV89HWTdoJaNf7lor0XkklFRYNuS72XYHDPAVfHVC2ku//YxpUFbCcWWr1oF4u
 Nl9yWIpfJxSnK+7idTfsWUkA3Kfo9PqNRGPj/qjowkN+uSdByrw1q4u/Nc/tITiepYqM
 cBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070950; x=1735675750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NoS6fF+zYBIciWuFVqUakribBmIpxW8sJFwdLDnjnLM=;
 b=EclfKCQXv7D3nA8e8XB4tLukVei4IDvxL86geXOazMpqldHNaCSaKLS3ws/ldPiYII
 D/xF1cDizFFf2A2NVIyE7b5I9VjFgkqlEz4amEyk+IVI8IkN4AAiPeU/htswthnVr/BP
 VK9KvAB8HIyaBzGYHLi+Lmb9FdEy/audteJdo0vzfS2VfV7Pvp1aZb38HztbMkbpSFb9
 OthFy7Dj7tquaJVpZN1MWXIadwdrha9IqAzbJygszYkofSjxPuzX42dxzTVsrXJCu1BS
 IUpcFFnAOHtZPSPt6nnF0VDZD/FBSI2LDZomehynIdynnlIcFuheyAliC5Y6srfp15AC
 a+qA==
X-Gm-Message-State: AOJu0YwM+3zT00MM5ixtXRnU8u/clpDynJxoy/3W4v+yHDgJr6/L9No+
 qHVCiNlrBH1M48C45/oogG/JvHqx7fFMsfrB0F+LqGx39kdi+xxvzR5p9vzEMQ8qWeK/6KFarwf
 7KkY=
X-Gm-Gg: ASbGncs0nIe/hJl8WmO/qIvRUC0hP6Tb2pYpXwA/JRnVB23VhbCFJ84CV690/nM8pRX
 /v3SuV2JIxRszs0V5GJ6Qw0JWAQqCRfSM7i1qKKDph6UUwedV4aELGrN4K8L9ols3qTRN9DmCXk
 Zx4iVObdthE1PM372CvvakHZer50cYES+0Xh1ypTWzkcuzURtEtTTEjgQgLLqq5CIZyuDrQN/Xz
 TSVmVzwkD51e7W1llc3QUGm35H8K5WagqkpK36cm64XSAPjBljMbF+MBvmUQD0Pb671HMtVCdFr
 UhsOegc9AvL4qCCKTIi/kDYxaQ==
X-Google-Smtp-Source: AGHT+IEWMJfN8ElHEHoZyIpi/XwOcIxp5CAYobXPXWITvUbQIHJwGOJwM+4rNsu1jjKq238HfJomSQ==
X-Received: by 2002:a05:6a20:9185:b0:1e5:7db5:d6e7 with SMTP id
 adf61e73a8af0-1e5e083f019mr35018185637.46.1735070950563; 
 Tue, 24 Dec 2024 12:09:10 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 50/72] tcg/optimize: Use finish_folding as default in
 tcg_optimize
Date: Tue, 24 Dec 2024 12:04:59 -0800
Message-ID: <20241224200521.310066-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

All non-default cases now finish folding within each function.
Do the same with the default case and assert it is done after.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4271d14d2c..51cfcb15d2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3096,11 +3096,9 @@ void tcg_optimize(TCGContext *s)
             done = true;
             break;
         default:
+            done = finish_folding(&ctx, op);
             break;
         }
-
-        if (!done) {
-            finish_folding(&ctx, op);
-        }
+        tcg_debug_assert(done);
     }
 }
-- 
2.43.0


