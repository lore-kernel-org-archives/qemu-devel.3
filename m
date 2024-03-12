Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C1C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I5-0003ey-EY; Tue, 12 Mar 2024 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Hh-0003Yi-GD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HW-0007lH-Ip
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:14 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29bf9bd1907so1663736a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254342; x=1710859142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4kGtxvZdOI4O7h397wt7Rdsn7HhdcYY3ZpxBI2vFnmQ=;
 b=ddrgLnUhYTpUf8096/8VR6xp9aWJcJ013OVE6LR5U6S6ZMpF6flZHIht5LlZnvh03h
 timKwhZ7cnQ6X13TNUpmQgOrHLslSwjvWExUnaZcl7NgOJeB1RqcL25QnVXNkCnnwdib
 cw/fokdx6uyB6zFfEvyMRjB5351x8QYGIhlTh9j1EeZXm24rAS57HQafMfF3iabjEoBx
 uNTPxJuCmivMQgcGrGcjh9ObVhXK+vf0wAjgfxAV+001VYN0bS2iTwQsCQgjnIIGG1vM
 Rwn6vjdglsorayZGQ0U47SEgGsTQ2TpV02+886EoFG3RxFA0w4cSbBAZhntpuhmS2JQy
 41Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254342; x=1710859142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kGtxvZdOI4O7h397wt7Rdsn7HhdcYY3ZpxBI2vFnmQ=;
 b=D8thayn55LrLWGmldcC5JY5+YVm658s5E1rlPH1EsyU1zhjEnbl8JEGEDhb2UDJfQH
 TbQ2P2hR8K6RknRmzBO0NKmfyz0iyFDCaBzUSZgiqOeR4UIqCwetvE/qx21KMkNHGEI0
 Mr4TsiCkwoPLM/175tn/9kZ8La4huR7X4OLfd4a47KPUXB7tviM0zSx+widNkBhMOpao
 ejO+PRVVTH/50KOJ+UxiMCXUfs409PnuJ5dYVqr7uF9mJ+sdOlHYVVi0u3DXaM9k1+Qi
 FdmKT+sYC3zOnBBPhoonxjNZRlQ1LCnAOQ7FkMiwiTeg5La6QIGrj95ucZ7uiKsUb9Qb
 xZkg==
X-Gm-Message-State: AOJu0YyZ4HeD/MONucvdms1zMqZKuhPUheWMpc3XNwYLJCgR0lYcOjAV
 VTm0P7ru0rU1DWv7/ZK/iVbUB9HGpkDHM2VZZdR77NWvnaILzkeDZvm5UtXzmX09JqN8NLSaxGA
 0
X-Google-Smtp-Source: AGHT+IHlOS2xj0anKavqKlad4CNIkDBOcuEN+KGtRwjo5Ro7M+z1bC+QgOjkAEJccs0T/S2StX4HVg==
X-Received: by 2002:a17:90b:48d2:b0:299:3ebf:d180 with SMTP id
 li18-20020a17090b48d200b002993ebfd180mr634093pjb.6.1710254342569; 
 Tue, 12 Mar 2024 07:39:02 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.39.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:39:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] tcg: Use arg_is_const_val in fold_sub_to_neg
Date: Tue, 12 Mar 2024 04:38:38 -1000
Message-Id: <20240312143839.136408-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 39bcd32f72..f3867ce9e6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2451,7 +2451,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     TCGOpcode neg_op;
     bool have_neg;
 
-    if (!arg_is_const(op->args[1]) || arg_info(op->args[1])->val != 0) {
+    if (!arg_is_const_val(op->args[1], 0)) {
         return false;
     }
 
-- 
2.34.1


