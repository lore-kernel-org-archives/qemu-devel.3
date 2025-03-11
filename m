Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04B4C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKt-00028d-2L; Tue, 11 Mar 2025 09:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDx-0004zv-Vd; Tue, 11 Mar 2025 09:00:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDq-00006S-1t; Tue, 11 Mar 2025 09:00:44 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fef5c978ccso8070371a91.1; 
 Tue, 11 Mar 2025 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698033; x=1742302833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZ8e0vShkNtIuKOZGNzWODhsrmyTMS8jpNRn157CjZU=;
 b=VoLqJz/Cm7CDbXqFUPLqUOd7Q23puRPRbYBgZS3bnhPnXGlu17okWYc6sHRpCxf370
 fAL12m1kg19v3Qb/hiLAHp/UoUNWihxxqVAbDO1Q4c+Ly5zrOaOXX1y3on72g4b2REzF
 aeo/Zm6Ix6Il8Iu7M7Ml238vRq4UIFDKuWGUUbEUQLu16HV2FYaUiMuZnmf85gIhMina
 pP8tGYcuB1+0MBpeYiUN2vjr49XkNs/2f4QRmHiHfdYFR8QCdJUUh/paYJ0XeOlcoUeo
 6RRHHkX5tcV8GszxeYUKNSo9dp1FkNa283+VGFwE8UQbDTYhd+S03IU0F+x+EuqqhKu9
 gvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698033; x=1742302833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZ8e0vShkNtIuKOZGNzWODhsrmyTMS8jpNRn157CjZU=;
 b=IGobXPt7zBWFIWjmjd/5Ppc2xWWeG35UoIiqqAPJCNQiplyCAmRyiIrr11rDavEG70
 wI+DoPOOiFDJUnxz8BdcQe1hqQK5ioce4nB5qPUeZYh3nfwND9lFAiOW5lu/ULodUFgO
 fSeCzGqJwnsc7Q9lAwOOstAm9cQXdYoJx6Dpm7Cby/gbTJpj3vX38Lf7QUY5fxIgVtIB
 kDYnwyFj+Xw3g27rp4D+PogV3PK4M+WTlBh3FY3tdTDy+9Nlr/Axi2CHC9dp+eWL+ZrR
 h2ejGVr+mL4tpdiHjbSJt5996CZvrHxE+nVUzq0yyJlybBbnt/tA6hrQTdU2O6eYLPg+
 5Vpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2UyOnIbtQKHA3pIJ3CuWJXPmCwmqVFQRejh/eOvhz3K4VN73ffKDVZ/KP7lyavP/o6kKDu75+7g==@nongnu.org
X-Gm-Message-State: AOJu0YwyZUmdJMzOS59G6Vnyiyi/bNj/Kv5OKwmNwo6A+Wfcv2Gywgp8
 rgtIaefELMtdMHCNkc4TNtd4K0wRw6Hqq2+y+exLYLF8+n4+mE3/3f3ROw==
X-Gm-Gg: ASbGncsl/9S2vqMu3mqcnmgr6VssuP0wYfuBtsyzd8QfWdfORq9IUERBLuOAsQ9nelv
 X3d2j6Y5h4nJs/7EzkKzLWi3TNLqyGKcBO1LMf/SJsL3p/LRF5vcEkggElh8iQ/Fm2ZhOLH3XPh
 +/GCUmx12fWHp/L5fbo0Gqv7CH1xmDggH55WhMyuQvJPoQOX20gmtw12aQxFNHxKOIailqeDfKd
 xE/xv0pU/PGTqv5RpZvSR07Mm2eRQYiBTRl1d9T7Siu1P6YGhlJiyehOA2aZ/sIKvhFgBlXlNv6
 J+AmXMMgRdZl3ZrCJwi8pi8z547HbU+g2g6PKryg2JkVTW6+vwY=
X-Google-Smtp-Source: AGHT+IEqcXWS1kF+UEBbIJscupE6OMlrGspwIhQqxXseanccg+qVgpTrd8f9LikehZQg7pqTgEV6/Q==
X-Received: by 2002:a17:90a:e7c2:b0:2ff:693a:758d with SMTP id
 98e67ed59e1d1-2ff7ceef0famr25700066a91.27.1741698033020; 
 Tue, 11 Mar 2025 06:00:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/72] hw/ppc/spapr: Restrict CONFER hypercall to TCG
Date: Tue, 11 Mar 2025 22:57:35 +1000
Message-ID: <20250311125815.903177-42-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

KVM handles H_CONFER and does not pass it along to QEMU, so
only vhyp (as used by TCG spapr) needs to handle it.

[npiggin: Add changelog]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250127102620.39159-2-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f987ff323f..4f1933b8da 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -580,6 +580,8 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     CPUState *cs = CPU(cpu);
     SpaprCpuState *spapr_cpu;
 
+    assert(tcg_enabled()); /* KVM will have handled this */
+
     /*
      * -1 means confer to all other CPUs without dispatch counter check,
      *  otherwise it's a targeted confer.
-- 
2.47.1


