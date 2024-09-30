Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6145ECF64A6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFuB-0007Lc-G5; Mon, 30 Sep 2024 08:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFu9-0007E4-LN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFu8-0006WU-5e
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so2515622f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700810; x=1728305610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rooDbjFBHfskknaRJcxcqLhZU7vMreorn+2suTNR1/M=;
 b=y0cfUEHL5Ooc9asoLqL1bUV7dh49poavofxCK6bhWNMeBqIW/ShyaIQat6vXd85NDb
 W5YnuRg2mxY40Zqk8RvzZhbCIygtquH61uyfGuTU7JhTBQOxPEptyVvQHUPrOgvalaV7
 r/i+BqfraHzavvdUTNBfep+pi0juEH89pyuUukosqVy1mpHUvq6sSlHMH/IcgCAyNllZ
 iKHbsJLko2B3vM9GjruGproeFC+ibhONtmri1KZAyAhP0Xdf+GJ6VYrNQ5WSgLzNMcHj
 EoSpwhlbKU0BtdaZo+OBiqYvE4o8Vv50vQJTCYqg3AgCYbWuoveuJH+YWVA2pq1QjLNh
 Dg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700810; x=1728305610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rooDbjFBHfskknaRJcxcqLhZU7vMreorn+2suTNR1/M=;
 b=IPWCQ+lXATCwKN5HizB0tYSRwSF2gqJpQi4oewBrzlYI4Qnbw6IyPEZmbTb8ZjckNn
 /qdZAAODGy24mW+WoQwNQxYwe+5/14c1/TpzFWXLvjU6NyyQIoTNiA/sA4c+dUMSxmgf
 guwfV6CJ/tlkU0Tk0784pCJ0kIfXYgjrvlUWc8fx3wJbUAlBLRZy23LeDfBUEebhP/7J
 jOL8IbpExSj59RXXIBTl5Tgld49TeFAp4ewXMpdjWyVtEztJ2ot+vaHhl9qJyIgwonqf
 NV/3t51KUi1Z9qpBlhl55RfShxulEQohWFWmrRnR1X0+zGyuFH/YU+oFg2AcdeipzCoQ
 +pEg==
X-Gm-Message-State: AOJu0YzJeevab04X39BF7msju/w24HrhDfBf5MqRpkKCxyaNHaUJNBWk
 hkuRrAISjt1y3eI4MQUwgQTl5qDCDl140pdOTARx4bOERoaJ6eVRkBcZGDrSLqA75sHo+QjQqsO
 OlRs=
X-Google-Smtp-Source: AGHT+IEW8YNikHY5Y4sAcKNQBup7VdcwTIwyAD1x6agouxae3hdwz/Zzb5hqpckP/lZ/7Zz/oUhmBw==
X-Received: by 2002:adf:f60f:0:b0:374:b5fc:d31a with SMTP id
 ffacd0b85a97d-37cd5aaf0dcmr6187060f8f.25.1727700810335; 
 Mon, 30 Sep 2024 05:53:30 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d35bsm9034905f8f.21.2024.09.30.05.53.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 05:53:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/ppc: Expose ppc_cpu_is_big_endian() prototype in
 'cpu.h'
Date: Mon, 30 Sep 2024 14:53:21 +0200
Message-ID: <20240930125323.54671-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930125323.54671-1-philmd@linaro.org>
References: <20240930125323.54671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Expose ppc_cpu_is_big_endian() so it can be used by hw/ code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h      | 2 ++
 target/ppc/cpu_init.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75..4a4911502d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3007,6 +3007,8 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 
     return ile;
 }
+
+bool ppc_cpu_is_big_endian(CPUState *cs);
 #endif
 
 void dump_mmu(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9..00e0a8bf2c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7343,7 +7343,7 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 
-static bool ppc_cpu_is_big_endian(CPUState *cs)
+bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
-- 
2.45.2


