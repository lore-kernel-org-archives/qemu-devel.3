Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59080E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyb8-0001hh-Jl; Wed, 18 Dec 2024 13:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNya3-0001BF-ER
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:39 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNyZy-0007Vo-CI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:29 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso1217956566b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734545715; x=1735150515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qe//gJViys+yhtB7j7EeuPsosME5JBmgNhwY0OmT6DE=;
 b=fuV+O5jGEazW/kMYEL7vhf1bv9G3mcDeXU8uivlmCmHvNiYD/hWOfNK5G8merW+b9f
 URvjLqlN3iex0D/v9K/6/xcbOQCj/tZ9udBvh4C1+DZbGjm21o/BIoOfR5Eus+cceh1E
 nw+uUCd8pyfA5pG1ChLFs6Gh2b2wVzsG2mva7W2corRMNKC17PbI5ezuo58ZvHNd0jMb
 klncAtK6KRY2+MQlQ6Zoafvcl0Y2iBHcHo8fdmUSKk9+EXJeoxJxHInk7tYjRqi4mJsN
 XRjOr1LIkILD7NE/LgHYGlxRakPcLr+wKHiir4FucDhuukS3yjVE3ab7MB6U64aArGSA
 ShFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734545715; x=1735150515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qe//gJViys+yhtB7j7EeuPsosME5JBmgNhwY0OmT6DE=;
 b=uWGDtA0NdD3BiV9g9QkbxpYCOUgd76jyncyUMunq2+4qVKuZcLBjoZWDeZvBgORz+V
 HcQ1H8WlRZS0jblWnp5NeKNcTlYue3SaSKKSwOkeA4Q6AUmB610TvZo0KqP4VQ6sZFck
 eoUVk/GJPeN24/JR9lJbuo0xDUVmleba6u8sQMzRC7g2rbTFEAUPAkLSTI3wQ5VwpD85
 6bsKX4HW1YSO6XZkF+42eog2/VnxYxfRKkNe+LnWxE55AkI14ne9Zl/RqzMY377oSzS1
 kbsoqUGBbzi5IY714JbFCmuseQG1fup7Ykwy7XHLGxTl/ZkeObLQ78G+RJUpZWoVuts8
 ljTQ==
X-Gm-Message-State: AOJu0Yyzq2OeNBwGpkf7nE4kfRZKmuirf0kgIRLHA1P+ZYigWu2chmiS
 Qs9GCKr/eMygGxd5w6AyxD5/1q8RHITK0kijHNqkH3BSbkfPBvmPD3H1vKizKH0=
X-Gm-Gg: ASbGncvON4ZkjB6e9mA3qDLAeR6lR2yvQv2FpIgo4ZXE0Vz2E58P5Jwl1Nhy2pnHWAo
 qzvJ6Jnsux0sBjp7bTkvt0qkRpZu7qjglNdf72okr0VBCarZxOEprZVCkNEb8+PjYAaq4VB/RlQ
 wfW6YGyYzczvuTaq5HwAGfD1an4zNLLJcYhuyDjDnqGfleyabDYYaBFEqRiwKl7wV6VahKfuRz5
 Y7gIjfuxa7BZPKWqPz1/N4fix5Y8dBF0Pf9+wCbJxoIpVe8p5F1Q7s=
X-Google-Smtp-Source: AGHT+IEWg0lGJTdmj7iVoVggh5TZTrqiosrV2csXvzuMSzzLJdVA/ws4t9a4otc43XJj/nNSQO8Xfg==
X-Received: by 2002:a17:906:319a:b0:aab:7467:3f70 with SMTP id
 a640c23a62f3a-aabf471905bmr341369766b.2.1734545715455; 
 Wed, 18 Dec 2024 10:15:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96006c2fsm578533666b.9.2024.12.18.10.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 10:15:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E685B5FC9D;
 Wed, 18 Dec 2024 18:15:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 5/5] hw/arm: enable secure EL2 timers for sbsa machine
Date: Wed, 18 Dec 2024 18:15:11 +0000
Message-Id: <20241218181511.3575613-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218181511.3575613-1-alex.bennee@linaro.org>
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..c02344004e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -484,6 +484,8 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_SEC_PEL2] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_SEC_VEL2] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.39.5


