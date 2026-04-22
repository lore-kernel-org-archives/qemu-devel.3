Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2064F9B607
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUen-0007Dc-EN; Wed, 22 Apr 2026 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeM-0006yn-5q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0002N0-OT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so67561485e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853048; x=1777457848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
 b=rMkYgyCVxR0x/IGkZoHlqbDBuMiCo41H5fBGAj7wNhFryHQNV+J+Mhdwb654IDqYjX
 5RiKIg/trrCSAnqxp62aAe5LcSZPCLBL6nbfYdnOX4Wz09cIDXzzECO/2xt8PTquUmbv
 fAzyMfZ53jhrmSesK7S4x89cFUbaqpNKOJuCEldlIQINtsi419E3GxqYz52b0uXvHh/6
 Cj2bBctBXdIdnCSs4U+4fLS2blJEGMq7CvvFdhue+AHdDtRIMICJIdrSUPubVofn5mNk
 rZ3Y3y1l6UMoQuXGVJzNCdcPMrGBCRVKCt6wNzZUecw2aJImU1QbMsw3tZCDhiVTRkkk
 hZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853048; x=1777457848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
 b=cx3Gyhf392LlPaU71u37iWzNbL0YBvszmFvZouvFW2fEqtd9Zo7rGrClyRZURLYA5o
 9ufB6wgpAPWXZnB1g0SaWXgZedMzEwga+F5HUDte2lbF22nGEHOclzCN5uS+6OZ49gpB
 tkb1c2X4RhHJZsj0GpJG2sKp/POBlO4yUDoV6Z/7tz0VVf4MxKoRk7yQFsaFMgbnxhu6
 TVtZO39dTv2bbs9foAqE4XmJGO5P/8WMYGgmwqFJqcAeV8lQ9ykSGsqNxvULlB2JyFcN
 ejJaVtr4iNupCCq4tcyYkXgXkxyD09YAPbDYEbRoe3IwTUeCL4P0jR+3z1wvkYPON8cL
 O1Aw==
X-Gm-Message-State: AOJu0YwIp6d8gkDeag5z1YbHsJnwUeCd9dSzyEpdajYNN11T8ou+ba1B
 c5Cwz2oKbf/X+lxal1KX6/i5685Gc2XKqzKhVRMvtuw91dQW248pjomyLL71cAW19mI=
X-Gm-Gg: AeBDiesaFUszbeV8YnXYXrkvD0wuXGV871yL7QadBwl9TnZC+fF49CGUGsCP3hrMoun
 6/29zge67bHZ4RAlZEwIa+ZCwonr/C0FYbF7bsnuN8FNJGDCmtZGV9JXZlok/Ced2BI7ILdXlpa
 0D9vV+o5a5S341ML2Vo9DicwBxCun0KLb+3LLdrAmT1Fvb2UOPAQEjQh0k6yFscShkTLAvqZWVG
 Rm+uiiUoxtLQJR9ldnQKJjTBxBraroD1ayvhxurZMpVezgp5Y10kW8H6HZC/ElAR2qiSvDjNYKL
 tYUekxnjuktOYljtWw2BrwELmDIFEn224N2AFZIG9Qs3LWHOnPs+HSNxlgSAZWAy8Jp+9dL3YJB
 4jOylLPzIRZD+M0LTCTz2A91uNBH+VIJsien52rIGeuFRso3PzKE9JN/5esOarpfHAuiKGJBhDx
 anmBIFe3okOk8eJtGy3i+1qNp2lPbDp+hMiA==
X-Received: by 2002:a05:600c:3216:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-4891ff17521mr88617735e9.20.1776853047996; 
 Wed, 22 Apr 2026 03:17:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cdfcd50sm84551615e9.9.2026.04.22.03.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 863CD61667;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 26/31] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 22 Apr 2026 11:10:37 +0100
Message-ID: <20260422101043.1234229-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 073454b9195..d79c8ab431b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
-- 
2.47.3


