Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD8C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb9S-0001gA-7j; Thu, 31 Jul 2025 17:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapk-0002Iw-8x
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhaph-000803-TI
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so10680945e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997340; x=1754602140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Obt7l2dUxC1zZFfVKxnVIXG3NpYsLOMtlWCU49WAEg0=;
 b=rHn+gtU/BZPOYKM1FvdO1B+JDY6UuL+hwppn203K2lKvC+O9cDEzHg7rfJaZOmfyH1
 GVpGx05ro/QKKHaG1k5cqY2ywlSvSO+xLWBjeIEzR1YLqYuNnMRRtqeS3y4bZ/Lw35ck
 Uf6RqXij7zMRrLDcs/Rxz95gt/xNG0ncUmPgwgiXC74rt5Ngjft8kH6Ud3o3zIXY3Vtf
 3vHLCJPB3JX+MOr8Ef3E2UticS2XjBg7pCYu4FRfsz5BOH3SkRyiFFBgsw4Yeat/XQPc
 UIDsJhII3RDeLu7+ntxKhq8r31j98ORSJsDPcnLJim8ENOR0QLIUW/ugbgz8rh8hP2oX
 2lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997340; x=1754602140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Obt7l2dUxC1zZFfVKxnVIXG3NpYsLOMtlWCU49WAEg0=;
 b=c8QBFgkO9ZKyu8UVDFsXAeKLMCyn4VZrQ7sbBEBR/ZAVmqBXciJkYfKo574MNfHRSJ
 GrEyNe4alU3QT7X/klkSnEOGb2QXnVJzHGDhHGieVX1t57IERydzmCrVlyDbOu+rfNyr
 Q2MBv9Uw7NVZGJox484IiFNNvu2PdBTYFNFRnZZZ7ok34oKsqrfXpnkWUiYMffI9OaaL
 e3An485atwt6/uG9so/L0dUQrzpuhwGe/1XmBi8gohlgdYK/+0SzuBVCgwuqEYaHOIZq
 rceX9ybR2TK1TEeOmLW5P+9HDqvt0ZQgXkmEVF94CKW+C6ff3dtpOt+U6jZKU1GkRudV
 r5KQ==
X-Gm-Message-State: AOJu0YxeijwIw7uB7QAHw638rmrCXS+XNUH+P+k0tBOby4NZ5rVIjJiq
 4mJFcea9+emgl9KurgLi3q7h/OgEVzb8O5a1isFLtsK9aNkZ8WMIvFMTKGzqyDEmU1/my6MDby1
 7J326
X-Gm-Gg: ASbGncspQnVftMddhTQZjT1UWkQtJUXht3xBuxEpbbn05571s/mCkN0NRaRuqk2V+Rl
 gpVYfqdRzqGA1Zijx3lhu2/GbKGRgO1fbytyav3zgpO03jhiFjPFKf072ecaOqindvgVBYNSRh5
 Shttt7cctJF3LvA5lbAPLfd2M5i4e68iYbxz+qRKtDZc5i2s6IlbP9PFHOvORUo08i91zzMaKzR
 4K3M1gJDImcMPS6SPQbMwVuFsRlUGjAAT9UUrUjmNfjgyo1+KThZ9LBDEej5Q5FS2tck+7CndKw
 7OOi864RYi6ZupV1FSK61JTsSylN88kvZ5BZ6ZMOBkVXfCSyhXaP6hjOapwJXWDOMdJmbridyPo
 UYRuM167k86M2MYp1oZevND8IjztA4jBbn3VuDuCgm3A+S4NmkHc5kRXloD5LiNvWGIuKC3B+
X-Google-Smtp-Source: AGHT+IF0x1KCEHM6qibFWkF/SRblq0y5j3s9nWHgsDMIjOquYMLJ1MWGmeq0wvW4yyd8xeqMt7qyOA==
X-Received: by 2002:a05:600c:1d09:b0:458:6dea:af6f with SMTP id
 5b1f17b1804b1-458a2431906mr39548015e9.15.1753997339922; 
 Thu, 31 Jul 2025 14:28:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458981d0b06sm82538785e9.5.2025.07.31.14.28.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:28:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 09/11] hw/sd/sdcard: Disable checking STBY mode in
 SPI SEND_CSD/CID
Date: Thu, 31 Jul 2025 23:28:04 +0200
Message-ID: <20250731212807.2706-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The card should be in STANDBY mode to process SEND_CSD or SEND_CID,
but is still in IDLE mode.

Unfortunately I don't have enough time to keep debugging this issue,
so disable the check for the time being and the next release, as it
blocks Linux. I'll keep looking.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ef72ce717b8..79395f7c5bb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1579,9 +1579,20 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
 static sd_rsp_type_t spi_cmd_SEND_CxD(SDState *sd, SDRequest req,
                                       const void *data, size_t size)
 {
+    /*
+     * XXX as of v10.1.0-rc1 command is reached in sd_idle_state,
+     * so disable this check.
     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
+    */
+
+    /*
+     * Since SPI returns CSD and CID on the DAT lines,
+     * switch to sd_transfer_state.
+     */
+    sd->state = sd_transfer_state;
+
     return sd_cmd_to_sendingdata(sd, req, 0, data, size);
 }
 
-- 
2.49.0


