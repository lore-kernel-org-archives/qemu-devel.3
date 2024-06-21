Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FE0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZI0-0005BS-DE; Fri, 21 Jun 2024 04:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHy-0005An-Ce
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:30 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHx-0008Gx-0d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:30 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc121fb1eso1935628e87.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957187; x=1719561987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsqEi0yMZfaJd1hK4BOnT6B+zva2T6NVwv7/H2dxiDs=;
 b=oxgfh8HExCZk6IENBaMrpTqBaLEPkglxxT4ecUs6CvFnf6aQvzcN/3AL8G7HGJT7g/
 K/GufHu4HEtsPLCmpl9OaIvIgW4PhiS7DQkRZ50qD3oyQHe9qr0gHE/AiUfPemTImxXF
 5JCZ+lf/cB7fh4pGTKRmKL0aSeZY6PYItJRFv/R3PRq7Qy8Zqbu6qbRUxZga9Xj6+CSj
 M4bRa/QyZ2VM5+lnacaDrSbLUG87Nz3MrXkaccbAimeuZ929uxdyY87N80iO7UtmaWvr
 xCq2PD+r8TwbKcWaUTE8FsX6LkAKd2mgOKQW9lUBB1w7SIoz118S2ReDxpbrzqx9zop+
 m5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957187; x=1719561987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsqEi0yMZfaJd1hK4BOnT6B+zva2T6NVwv7/H2dxiDs=;
 b=Qy+Ufv9OIrRHGhzCiTGPdSmFiH1vNS6iiNAEnu4XJgu8a4ULVlGAs8c6nUMSHIfEmZ
 kUTZ3T6Wt6cF5HNDAYgzWBSyJof3a7HRGG0BwXg4Z62olx57NjVkyUD1EISrwBcIuczT
 g8W8YeqIdllh6enuEOIV0DwGDxy4mS2MPZfwzcDrq7ep50kX+1EAWdfh7gUPGKLT/J4+
 uoFmf47grMbFX4ekH0lDPjsuYQazdCw1EXc74URI+OrdwJv5nYqcsBA/UFXOQXDEn8/2
 QO8aKfxnOm1VNoE0NlR5KjUn/cd7TW6FU4nza4KJY+RaaLjFMjTXhvJrq04rNYCii3kO
 nE5w==
X-Gm-Message-State: AOJu0YxMgzmzUzFT4pLbVlcqDXHLiGy6P4C0LDRtCQE/ehofRDyWus29
 p80oxVI7To13rn9KE4AWol+2l0UqUs9v7GTdExk7KOtt9Uj2qY4ZEkISHZWqdpKVOxiuhKnUoso
 h
X-Google-Smtp-Source: AGHT+IF+oecqc0QCYs+h4dF4w6KMDPV6yo2V/Jq6b9Wq4b60F2vqMqvZYuMOC5p2ZKmdzvY8GpUQrA==
X-Received: by 2002:a19:e048:0:b0:52c:dac0:59f8 with SMTP id
 2adb3069b0e04-52cdac05a32mr75707e87.53.1718957186790; 
 Fri, 21 Jun 2024 01:06:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0beb13sm52737585e9.14.2024.06.21.01.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 05/23] hw/sd/sdcard: Use registerfield CSR::CURRENT_STATE
 definition
Date: Fri, 21 Jun 2024 10:05:36 +0200
Message-ID: <20240621080554.18986-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use registerfield-generated definitions to update card_status.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c528c30bcf..24415cb9f0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1788,8 +1788,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
          * (Do this now so they appear in r1 responses.)
          */
         sd->current_cmd = req->cmd;
-        sd->card_status &= ~CURRENT_STATE;
-        sd->card_status |= (last_state << 9);
+        sd->card_status = FIELD_DP32(sd->card_status, CSR,
+                                     CURRENT_STATE, last_state);
     }
 
 send_response:
-- 
2.41.0


