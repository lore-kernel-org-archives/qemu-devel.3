Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4487AC30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fD-0004MZ-8t; Fri, 28 Jun 2024 03:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5f0-0003xF-VX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:45 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ez-0007Wb-A6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:42 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso3202961fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558279; x=1720163079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nu8acyjpOBs616osR1RalX8TR2/NJv3m9AnCQgylDWw=;
 b=HrSXvBRpueaEImtmpIHPFXJBV+LE2gVunaOQcGkdo1qCzPCsMEnrC0eNLXC8P+O7cn
 NTVPe+02vYa35fah4jhXFRy4Yl4XrtAcCpswNlNfn44r99LEWdlT+cGHphOdE+f1vn8O
 hB+FRWQMaR1XHlPkdZ7RgWarxqXcxO+MX/M6a1IGsh/nw5FrruAmsJ9bthrQ9m5e7BEg
 Blr7qcd4zCI+br0L8T+iz2lPYcesuOjqAxYkEsHbrGxRAw9uXU9EUkb0tSo9VBIuaYD/
 crM3WGHox4GLt8HOhEZngKcv8wi3a4guoOz+pcmmQqUw0Bt2egkPyV4J51AEVZqBLJrD
 jugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558279; x=1720163079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nu8acyjpOBs616osR1RalX8TR2/NJv3m9AnCQgylDWw=;
 b=rT6fXRkluEpEuc7NxEsLhPyD3NpIxrrVo5QdALV7u0JGyEOvMPnLZwf++CwHSmWqLf
 shVg+0zn87fztPeoYt6DBRP8/Twwd/uQjCpYMbgnolgGOWhJVLLBp+fNAQO10ZxD96QO
 CmiFplQ2hsfpWeW4wJ9ATZXVGX7N/Or0m7vsi+vjbdD4nUi5EEIGCSjaamNRBXk5RNja
 aiq+SHSbjY6WyWzMLh2W5m3LtLVURryMdiTap0PKpyAx3tcn/r1zzUQvavztPlTkGHrG
 wijzXDrji5Nwo6XwdWL/TUt8qTkX7uMNammk6FPYBjXZSg5URY52bO9FSHr/3xoarhgu
 HPEQ==
X-Gm-Message-State: AOJu0Yzvuev8xEvmXMBpCEAZB5pjdSs7Ba8G3ewm01febaAshoWMSpmJ
 016PX7AHymcYYfDUPphRFxvvln+5YZOYF33NA9fInji8knG94RGDZTFELWRRw5izDGTiINOi3PH
 cRHk=
X-Google-Smtp-Source: AGHT+IFHx5vu5d95rRkGQEWchNHvHnaGRROKSVPrWgiX1lY/qwkwRiVr2ZOH4UtVER/31ykbRdhaRw==
X-Received: by 2002:a2e:7c07:0:b0:2ec:4f0c:36f9 with SMTP id
 38308e7fff4ca-2ec5b31d140mr128811921fa.36.1719558279382; 
 Fri, 28 Jun 2024 00:04:39 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3b8c0sm21387495e9.2.2024.06.28.00.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 21/98] hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK /
 READ_MULTIPLE_BLOCK cases
Date: Fri, 28 Jun 2024 09:00:57 +0200
Message-ID: <20240628070216.92609-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

In order to modify the READ_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8201f3245c..dfcb213aa9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1398,6 +1398,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


