Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16385CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzu-0007L4-5K; Thu, 16 Oct 2025 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyI-0004zE-96
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9My1-0000NT-Qf
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so605604f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617217; x=1761222017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYzKpI7On0MRpnE5eDZLRsYT0gO39fAqRkOpQvV/LBA=;
 b=Ri9RqTzve8ZIHTghIaKcY3LDvgD1lYkdb1PLi2SGqYvXyNFy1xQwzhfW1RfAgwebgv
 QQK6dAeHdLHzM6jRVRznHWbZElNK1OpJQ/BTPAOx47oIjLRQtrHPthPxcV21FgWHZsvu
 nHTNvGy1+agk/iFAwwbvlQlIfZIOwo+5vGaBWs70rgoaUQYFV/OMm0klXM8a79ZvFZRR
 PksCaAyvOO74dicaHA23eTh61EA9wcdlZmBGdI7jA9JPGsfjfKRcDy4pYGPqi25KQzZE
 jjWTWL6dG4MixRPJ/ePdo2D2Y9Hhqn77kxoLy5JH4IjGxRFe9zGV1/FklAhGgPfj17ps
 PzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617217; x=1761222017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYzKpI7On0MRpnE5eDZLRsYT0gO39fAqRkOpQvV/LBA=;
 b=GWDaKOqmMFmU6oSYTa4mA7HIcIRu3DWQVQAQoRwr1bTc9xcrZB9j+mKlPxHOpTGQmT
 dOzyghahghpMwdcNMU9peyl/mrqKU8VsT3q5N9PRSvr+chvQGPPMFBQSbN1+/EWVjN4N
 hgUHLW5eg+iqvFwmIxhjl81pOtGsfw9bt6UiPyySX1jPt5zcA/jzQg0XqTUh/FaQyEIn
 axLQgu6AbZ9te++WwHPE8stvhXd1TvPCr6al0Lt2i6rqaLTm4RUJiaSs9AwH4m8KOnGu
 qs19kFkgYGVoHOrvrW/YfnKbJzBANq4DyEb6R9Fb25zStS5nCmZGb7rTnyOqLqMFU42B
 RxkA==
X-Gm-Message-State: AOJu0YxsSxA2xH67iJD1EVjntbI0BFWQE4VdupougC16ouSra7CcFqku
 Kry36niTGolvfXQPMWjc8LE+Nl2ZQzYEp9yzRub+hogfPcQfMC1anuPagarrp9aJ7Ivbg/im8uA
 LKWsEb/I=
X-Gm-Gg: ASbGnctw2HYKsgzmWQXc2a4y3HP4sZwYY+dE+Prra6NBI7v7w04ssLSBP/vXpONvuG4
 aECvg13Sxd1d8+HYuq1kXfIKm5OQEUU4KUJFVD98Q6ZgN9Nf1sNAo6D0lPqa0R3xUlKrwgaK5ud
 mrBTcHJmJTynU6+pSrTB0Pn5rczAiDCN85qUQMnLpCGb+m039+utXiNx4xcs6YWUMsqOsJQM//9
 mfWXvQaZrNUe1yKmU3fSXSe/pFvz+xhlEq9Ludp/yLAo5ywgvZAdeQiawKzNZYqiZ6f9DKsOwcU
 v2fwcdgXhi0dcWtNMV19ltaGDiHTNfyQ5sdba1PxDg5dRuZ6WBxtK7BnLh5G2Ps/4zDll/1/eJH
 lUnbaS8RczYIIxIBgCaBfUSoMDx27zPE/52iSUfXJwGdvIHPsB5MDFsdwORms2fgWcD56KzT7Ov
 sBflsS9O+r/sEIzvuExrxY7xrXBIjU8OUbt0iT4zbCZz9piAP64pc90wtQoox70AGo
X-Google-Smtp-Source: AGHT+IEtGu8znaEWebsyP3vItMeXBQqzg/sEAnh8f67SAgAj8RnoeFlzFJ5ylOtdr0CCleVm2jaHNg==
X-Received: by 2002:a05:6000:4210:b0:426:d832:c5d8 with SMTP id
 ffacd0b85a97d-426d832c9femr11378119f8f.51.1760617217158; 
 Thu, 16 Oct 2025 05:20:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0006sm34612333f8f.34.2025.10.16.05.20.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/75] target/tricore: Remove target_ulong use in
 translate_insn() handler
Date: Thu, 16 Oct 2025 14:15:17 +0200
Message-ID: <20251016121532.14042-62-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
for virtual addresses") the DisasContextBase::pc_first field is a
vaddr type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-4-philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd09f0651f5..4b769b204ab 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8414,7 +8414,7 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        target_ulong page_start;
+        vaddr page_start;
 
         page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
         if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE
-- 
2.51.0


