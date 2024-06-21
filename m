Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6552C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJ5-0008DN-Oj; Fri, 21 Jun 2024 04:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJ4-0008CT-Di
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJ1-00005i-Ij
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so12979725e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957254; x=1719562054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dkx6RwZS43D0XJ3kR94XAto+d+FvcMQ26elVXwwNzdM=;
 b=M9y7L6eo8u1SSzlwjG3bPeA80ItpwZFFacZjGqLha0GUja05FVW4aZv7MncCRa7GXe
 6XB025H2HuH7MM33DAAgothUNaBbwpk1uFeW86A6fh4Gqkvcr7nKad4N6cT8FmpBK5he
 lf1Wa5AmkrulNE+BgusxD+fvKE7VluyncyhV2TISiOTnBV5J1URHlScQBSgoyTYzvjoY
 NZeAE2BwxxCtihivdWjAWTpFlgojF0dTwk0S39DUEFjqiYQdw6mQ04Z91HGIgr+SgnSa
 Eyug75Fn94kpVMIjS4jpbSfR84yCPPQ0xvFW+llylTsMVN5Y+Q52wHK7iQsN4jbKJf17
 8BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957254; x=1719562054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dkx6RwZS43D0XJ3kR94XAto+d+FvcMQ26elVXwwNzdM=;
 b=Cr4sxLZXlY2EnJZySbWABpYwYF49P9BDlrnHRZi83qEymp70QHmMqu3mu5yFmdRvxJ
 UvorEiAgoLN9hTbyN2aBebrRAqM7fzu746ktPXWKiMm/OnqNc1jHkQ7Cp2U3eNVS8fva
 A7GOTHJZChDt6wQTOKbX6t7i8/V98QHaSTjLIupVEQwaO4lt8lVKGfTgxBQk3m1QM3CO
 GJFU4nHhGKc9hgOVcS0bQI0+Sv64gAPazSi+HX9Xc1WlfUH4AjQOmQ6k/zhvHJnkUKS3
 haDvn1ONQ4/ne7es59xbo4WB7E5M9zMbOPBuUo/wmYoCEY67EzUBqIw6Rau+v5pNlh8g
 8pLg==
X-Gm-Message-State: AOJu0YxI40vbUT3ejQrTSLIaRUmS9xiQQtAKxxjTLZ0FhKuq3Lxgbiqd
 +wIo1rru4J8fSbL/5JvMEvEfgFhn8UurGkbnpG6P/coFYgvmUr5AVwAdOdIEmWWJlMoiJJyjBrk
 W
X-Google-Smtp-Source: AGHT+IFJQOMpC4zv82QEusGi/eTvPb05vUrvtRBhLpsRHM0N3kBIGIFITYvRVi/HjymsC6gz6bR7Kg==
X-Received: by 2002:a05:6000:9:b0:360:6435:b40 with SMTP id
 ffacd0b85a97d-363171e23e3mr6249258f8f.7.1718957253950; 
 Fri, 21 Jun 2024 01:07:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f6af9sm973358f8f.73.2024.06.21.01.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 16/23] hw/sd/sdcard: Factor sd_req_get_address() method out
Date: Fri, 21 Jun 2024 10:05:47 +0200
Message-ID: <20240621080554.18986-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Extract sd_cmd_get_address() so we can re-use it
in various SDProto handlers. Use CARD_CAPACITY and
HWBLOCK_SHIFT definitions instead of magic values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cb9d85bb11..a0193a46ea 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -579,6 +579,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
+static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
+{
+    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        return (uint64_t) req.arg << HWBLOCK_SHIFT;
+    }
+    return req.arg;
+}
+
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 {
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
@@ -1103,7 +1111,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
-    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
+    uint64_t addr = sd_req_get_address(sd, req);
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
-- 
2.41.0


