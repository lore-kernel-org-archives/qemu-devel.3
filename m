Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7C3C2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIE-0005Kv-G2; Fri, 21 Jun 2024 04:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIC-0005It-8c
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIA-0008Ji-2J
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-364ff42999eso1301282f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957199; x=1719561999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/RgyhQBn7T7/7BrixgsTi+BC7Dln0yA+HQ13ohYUUo=;
 b=ERdp1tgpQ0CP3m0+t/dPTumLnSj1jKZ4hfzDu9xvA9cytya1wnlMkXBS1JatlnF/+V
 80oJ3SLcN7yQO2uuqi4Cwbfis6mSljWZ010K0gYvX9HRb8yBoBQcbfh9+Ow0G0L4caOH
 unnYgqs0EQYqpSg+xIAGc60BtjqUaLkmAgHPgrYi0hUlWE0wsntcsE/j+ICbkEqDKT3N
 eRgX3Ut2e4UoE19C0WKTqisSCLNKhgVBxGB23Cha6AFhTdrCLwb7Bb3qjS4iLAyUxF7M
 Zq9Z/cuCLgOwOsjLFhfTzQI+rqAHSfE0AJJMujpjIOw/vhuHtwYcAQ1kT7r5BkJvbAcI
 H3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957199; x=1719561999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/RgyhQBn7T7/7BrixgsTi+BC7Dln0yA+HQ13ohYUUo=;
 b=gRXUfbEcX2MUk873cS3C1/zYx2rzmqDN7Fl+RyubJWoz5ugKZ30+TPipZ/FaNf7kgL
 vAoR1jfUPyfm0df9uu2pP47aVmV6nGOAYhH0fb6RC5N8tBobvudBOD20jfO3LRz0OuKT
 EQDw5W9lLsiUe/+7H6xQxh0OrpWCOiNd+YRevv6hx13rbQHSS8L4Hb6TwNVr4/6vvVmv
 bvv1rS/7b0V13zMiXvlghEwRU69u0mGAns6WV5c8gtqNf4FQ+7WTOFdUer2UCEehrkVV
 UF9JZThpfmolCBv8Um9s0KFhlSh3Qjvv8EFKqhmbzItSbZ190lYAP754pkK5Nsdz/oUg
 L98g==
X-Gm-Message-State: AOJu0YyzmtdbsottZRhv7/7KYj3XYNbOC69Q0982afTrU4rzGc+93SjY
 I2c8vxj5xwy52ms2moqotJD4cFZlg7hmDWT9RzX4y6p+Vv+mXxYLEL6kOUt5vzEoS5caFTUWai2
 /
X-Google-Smtp-Source: AGHT+IGeRbmY4LdJ/gNJBgZWLBPlfAf6117+uKh/sO4vbzQ+GFfWHwuDAwrHgYiPV9LOHHQo23I9sA==
X-Received: by 2002:a5d:590c:0:b0:35f:1eba:cf66 with SMTP id
 ffacd0b85a97d-363199905dbmr6916611f8f.61.1718957199119; 
 Fri, 21 Jun 2024 01:06:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8aa6sm962550f8f.105.2024.06.21.01.06.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 07/23] hw/sd/sdcard: Remove ACMD6 handler for SPI mode
Date: Fri, 21 Jun 2024 10:05:38 +0200
Message-ID: <20240621080554.18986-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

There is no ACMD6 command in SPI mode, remove the pointless
handler introduced in commit 946897ce18 ("sdcard: handles
more commands in SPI mode"). Keep sd_cmd_unimplemented()
since we'll reuse it later.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b0cd30c657..e9af834a8c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1012,6 +1012,7 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 }
 
 /* Commands that are recognised but not yet implemented. */
+__attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
@@ -2153,7 +2154,6 @@ static const SDProto sd_proto_spi = {
         [52 ... 54] = sd_cmd_illegal,
     },
     .acmd = {
-        [6]         = sd_cmd_unimplemented,
         [41]        = spi_cmd_SEND_OP_COND,
     },
 };
-- 
2.41.0


