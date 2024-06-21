Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88735C2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZHh-00055k-PQ; Fri, 21 Jun 2024 04:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHg-00055M-GL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHe-0008FO-Rn
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-361b376236fso1359233f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957169; x=1719561969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0JRQjH2+2iHubv4pv2oDVEMyEJlpvL6A+oovFUXEtM=;
 b=m1fP/5+pJgOEEkKCQyCckKKH/4BlHhZIvrNV0M8B3jB3ODvVrNb0COBPI/C3HSGAE2
 TwR2YwS/wKaRI5tEN7XyYAAqCBe7evD0DPQntn332WQA3AGsp+qNtiFn9A01/ylCHlLQ
 gL7lmtAIAPEmk8C5dYXR3XxEFVY/HgMMawzBXBW7yO8gYF+9OlN/gwAxeNRoUrZgA5Uu
 DxhxXdTcO3qfG+dw/jjNPR64CjnzetTcJOOqUOpFhbPRFoSuXbueJ+2FjvHsJaPy4zU6
 Qkm+eKjS7ZVSVr+rqe0rv0V7YfGPBJ5s75jhur6fYnOB6tLWBMw9O1WeZ5PoOkOFbn02
 FLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957169; x=1719561969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0JRQjH2+2iHubv4pv2oDVEMyEJlpvL6A+oovFUXEtM=;
 b=jnL19XlYjwgDJhWWdL7s2lSM5LZ2sEquzN9IogcCRROoltNmg+lwVnxxNy9ngULLPB
 grUBtTdThC/mEOsJrnDaMDEmadnjND9hoySSmZL7oPTjz3sLdLb6M9g55kywU3P6zzTG
 qu8T2BRxXR1c8T93G445G9jl8PnYAUaTVUcbPxtzo1+69HTiT20hm1v6LZIPAzYiakE8
 c6KEjs6kEUPq/fI/QD01Y2ZDZGKfRNTdAMWZTQhUhCJR8BN6ajEF/7v/mmsvdII3l9ff
 9EzVv1byT+25OkR7RXzFXe3OsHuC7N7luo6BIHapAOb8dBzeRtWNGgoEg1hAAT5uxXxS
 8reg==
X-Gm-Message-State: AOJu0YzFdRFeB80VX1DyFgdvGVQkN1AgieYgI3B3diTDVgRKqu7DbdWN
 tsyxh2QEaYW9T17U6TguRyon4vF61OeW7+Mv0mGvr1fs+0KI9vann4TzUnlUvHRokwxjvTme/4v
 1
X-Google-Smtp-Source: AGHT+IH5TT3+lDR+GsaOnFLP2PjzHVMeAkgwomSDXLjdB5ZspNRReLQf3vRj0sDhdQlv2C208SGp+w==
X-Received: by 2002:a05:6000:1107:b0:364:e290:c60b with SMTP id
 ffacd0b85a97d-364e290cbf5mr3280674f8f.38.1718957168962; 
 Fri, 21 Jun 2024 01:06:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8451sm963793f8f.101.2024.06.21.01.06.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 02/23] hw/sd/sdcard: Rewrite sd_cmd_ALL_SEND_CID using switch
 case (CMD2)
Date: Fri, 21 Jun 2024 10:05:33 +0200
Message-ID: <20240621080554.18986-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Keep this handler style in sync with other handlers by
using a switch() case, which might become handy to
handle other states.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 626e99ecd6..addeb1940f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1044,13 +1044,13 @@ static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_ready_state) {
+    switch (sd->state) {
+    case sd_ready_state:
+        sd->state = sd_identification_state;
+        return sd_r2_i;
+    default:
         return sd_invalid_state_for_cmd(sd, req);
     }
-
-    sd->state = sd_identification_state;
-
-    return sd_r2_i;
 }
 
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
-- 
2.41.0


