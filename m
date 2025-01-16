Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312CDC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRNC-0003LQ-Bi; Thu, 16 Jan 2025 10:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMI-0002Of-P9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMG-0000Bi-HM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so6741175e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039630; x=1737644430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ncjei48IWitzJKqL1woSljhbl8hcDr3h6yIvRO+sxGY=;
 b=ftKcboLI6xevBOoFnn8wDlmJ63E9dqXgshPFRKH543E21PrMFaCI+wMLZT/YKfQOXu
 y8yvOgFo4iVtvMF84GdvEX6i+bsYrXvpDTOFAMlDuZFhyPweorC0ulVxAJJbt6jafzPH
 KUX+yd8Cwo/ujWB71M6Z4v937AFNaE7eiyxtyvY1BCPEhMa3Mr8h/eXf6ZkYOtBuqvTA
 xoV9UrJIhFODYCj5ossXw4jlHcEo74XFwW9hCOB21okJEbG28cYdUrvb8uLLKIPZiP6P
 mb0v+O+hoAiCDRpzi2YUODqDFtLE7Y5Pw573PAAZ3IKKCjocGjS3yZMnsblzvJdTP9Kz
 2R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039630; x=1737644430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ncjei48IWitzJKqL1woSljhbl8hcDr3h6yIvRO+sxGY=;
 b=E6AIShJmQ+iS1Xl//exTJHtsbeT+pA3Cy0S1SQuZPnq1gcitfspkrc29PbbNkIlf0V
 TI3GLSq1MHRJDVrd2iAnn+ZwiW9HqityxBQ2/Crmc1gL/4juNqZvkJs1NjtDh76wx5kY
 d9A88fSajylPqZT8peWfD0pgjl2nwo2pVzGqomZLJCvRzdTNQdlQqRzqnAg8p6JAIuOs
 dCyXB4kWS0CihnrPTkdphTYhuQOxoBhbjQMTvjzY5nfaKLLb8GWWgF5ssiLZjCAElvIh
 iJCc989/PtoerFfhq8qip+JfLcn1tT6oxcVyQZVbQCDAPYztyOk/gFXc5IJUyNNEQqfD
 HSig==
X-Gm-Message-State: AOJu0YyEtZM0DyQsft7l5KCNO6Cn1D+YdRBUNfXXwxizfkVTQVkEs9Te
 +HTDjJPxHGHZt3qLp1fI+ICDQFGlAsCUyiBOOe7SHXNeE9TJdRNpn0disDUxsbidrmvU+ZQEe0F
 3s8A=
X-Gm-Gg: ASbGncuJ143ScFEW6nZ0yR1wNo9xv8vU40MZqFH/az282doymykBlU5b85+Yq7b10/k
 wv2n4eesdx8t0fKrvCG2tSdUOZOyHE0asMEQQtzMDoUO6K5R8guE7rRAWZFDzrS3Y+fANGopPai
 XxgTXTxL4Bd6dX7EYev4B0i08zQPwIO2/GLmX329UXy/YUwpSKDUVXhFJ0dFLqJLFAGtqrmV2ie
 meshglDPfGi34x77aw15uTE2YDC9WJU7PTaU6uYP1o1FV6Lhz7L+P84kyza2VcKENEDf2VuuL4o
 c/iRLsExyH8/9nlpCTqtcRAVMMZO70c=
X-Google-Smtp-Source: AGHT+IFy1Piogm3KLS6gRYg68IJP34wCP8tYJNMxF8R8ZvQFVq/mSdaoYyGSAaxL1rsHVrcQwb796w==
X-Received: by 2002:a05:600c:a09:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-436e2684aebmr303238395e9.4.1737039630130; 
 Thu, 16 Jan 2025 07:00:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499932sm61857625e9.7.2025.01.16.07.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 09/13] hw/arm/virt: Remove deprecated virt-2.10
 machine
Date: Thu, 16 Jan 2025 15:59:40 +0100
Message-ID: <20250116145944.38028-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 14fc4b100a3..54c7b92b6d9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3551,12 +3551,3 @@ static void virt_machine_2_11_options(MachineClass *mc)
     vmc->smbios_old_sys_ver = true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
-
-static void virt_machine_2_10_options(MachineClass *mc)
-{
-    virt_machine_2_11_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    /* before 2.11 we never faulted accesses to bad addresses */
-    mc->ignore_memory_transaction_failures = true;
-}
-DEFINE_VIRT_MACHINE(2, 10)
-- 
2.47.1


