Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C4C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dP-0008W4-Mj; Fri, 28 Jun 2024 03:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dN-0008Va-6P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dK-0006gL-ND
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-366e70d0330so222888f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558176; x=1720162976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+otp2F30HYnVaW0wjGWSRpaE6+qcbVlZ832snl2PQg0=;
 b=wCkloADm0pPloudzt7dnxonITj/Qg2stcHTytdguwXTnu9LMzcW9WGERZE4B0cdIm/
 Ln12+/S5tZwINLDPri2awlQn5yb0stpZSZ4ZDq30x1dLGy7OPP7zsh3ar/gkc8rcmbL7
 KQxReWQlanf6HNeE7ixlfL4fdHAGDIJfafUHkV+AwaFBaOMIxPuXB11zGq7upa2bDkyJ
 Z0PjZy4hVaRNqBk1HGbq2IpP02tkRnzsknU8opRHa2ZXAvECJaDZuOWD+N9tMUAB+lcg
 plu9sBJNqQ/zLXCrzQHmIsCnaURqU1AKlAcTv+CPZKAOpniJqGN19KgEk9QX8DhVWQpH
 tJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558176; x=1720162976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+otp2F30HYnVaW0wjGWSRpaE6+qcbVlZ832snl2PQg0=;
 b=j2sn1V4X2ogNPOlnpw8pfQFEHSxHnKfTZSJezFhyvKkkx14szO0eU3Qq/ZfuVkCtOw
 Vw+uvKnykKQl7vvLfY66WcgQNMb+EsaSuerlflNABCFRVHK/x3P7sUmyuVDsaeafVx76
 VIg7LLsfVH35q2ZCzlP20YF/GUk4vUDGd7t1BynB6qXbLTmwnGVycDFZlQkfJ/ccBK8V
 juvJs4HSrFiV1RkzHkDtDH/bjQUPudPCo1UV6aKZXKXf4yUrs9R1HgSMM/URt7u9AAcx
 f/6kROmFceUBY18eYD2Zb/M1lLPU0k5iAVSHq0yU5+PK0LLA8SoKWdnwSoHEgQU3DYP1
 3Tng==
X-Gm-Message-State: AOJu0YynXzqHzM/4C2RNPpbo7c59MDfiJzZfjkeLfKceX6R1NcHRNm5t
 H4Rl7mxxGK1Mb1sezr5XEBWL95GSzvhrx/nCNXKPDj7TZkhKVPD2JRHYLWiLvBvhYTOwVBdTFgR
 OsQU=
X-Google-Smtp-Source: AGHT+IFQ9JZ71myrGQ6ba6tD9LBYXLP/xfp05Svcs8cDsVtVJGQtXEtHefy+uSOEsd/KGtjCmFQDzA==
X-Received: by 2002:a5d:6dd0:0:b0:367:43af:5b8c with SMTP id
 ffacd0b85a97d-36743af5d8fmr2506909f8f.53.1719558176379; 
 Fri, 28 Jun 2024 00:02:56 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb973sm1317253f8f.67.2024.06.28.00.02.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 07/98] hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
Date: Fri, 28 Jun 2024 09:00:43 +0200
Message-ID: <20240628070216.92609-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f3eea6e84..4e09640852 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1507,7 +1507,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_sendingdata_state;
-            *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
+            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1;
-- 
2.41.0


