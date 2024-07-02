Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ED1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZip-0003TX-Ci; Tue, 02 Jul 2024 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZil-0003B5-J9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZij-0006Yl-F2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso24429365e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912159; x=1720516959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fq0Hp2Una8Cq+xwhreR1xxCEuiahEpzKceutH3MuTZk=;
 b=qdt+3ZWJqTeRbVKd8w7QB40JOUqY74DrAxG+IkeApxtHylJaQEtIFRTE7jk4UZU9QJ
 y8HnzQRnw8rzPbuLEyQ3CBUpwgNayjK4MBEtYnuAFRuwqtzTnUpvrRzCvEV2naV7oQ2s
 o+uf5KHVFmagKSVaeTuWlQbIaDThUS8KM8UuSbbczhh8wBPtublHpOjwa8CjjHrxctHX
 BZEVDBGXl3XK9KVhMkH1PTHQ/u4H0COp2106FmqAz6ko9dQXcaWIFvMETt04mJ4nvZ9/
 tfrVIDxkAO2jzCtpzXeyrx1hQchm4cGaAxVfTrt6sAm7LFE0Dcr5oER0wm0MC+yGH6ml
 FKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912159; x=1720516959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fq0Hp2Una8Cq+xwhreR1xxCEuiahEpzKceutH3MuTZk=;
 b=PKomb9TEompUIvxIA5lQPHI59X6GaAMHWFbY3AOxYMPJIvkHYZ1SxUuTNTw/A0HHCr
 mlWul0qbe+Uf3/oaHycd0Sdi9eG1WiklI3nHJ/hey744IKl0uCBlf43ZS00iwPGSP0nI
 LoDIq/Bvij1YTsZ9rHz2i7Qu8ACQC0vHvuwswb1Dp5G0VZFgFgfPBJkYvXKcpV8iiCmo
 s9FzYouyYAJhubmXNq66oqWZi1LhvC/z3wFcPi8pXlJI1CKQwTOjpbLBujDZno+6/jT1
 I8XNOkv49gw2+oExMIRDjWdFTo0DTFv8o66dj3YiFtD755shwWeLG299atlezQyOvLY0
 E2mA==
X-Gm-Message-State: AOJu0YzpGD6CX34QivM5zFp/xwHk97N86gUxqNaNd67Q1qL2hMBcvZNs
 coqwijrbHlfmE9maam+ktaUp9A5B1BkFrIpoXSufzH51i8LLXg4FkkMsZa81tD9jFEjvzPSLEaM
 6
X-Google-Smtp-Source: AGHT+IHRMv2GEE1n8Z1bFbcTuxj/Y9F+LiZgH07uCRh8Pa4rWqY1hmkZX6x+MM08LUMvMv/lY0zhjA==
X-Received: by 2002:a05:600c:1d21:b0:423:394:cd28 with SMTP id
 5b1f17b1804b1-4257a04fe67mr53501255e9.25.1719912159574; 
 Tue, 02 Jul 2024 02:22:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8cd8sm12607603f8f.27.2024.07.02.02.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/67] hw/sd/sdcard: Convert READ_SINGLE_BLOCK to
 generic_read_byte (CMD17)
Date: Tue,  2 Jul 2024 11:20:01 +0200
Message-ID: <20240702092051.45754-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-23-philmd@linaro.org>
---
 hw/sd/sd.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 43e0a2d925..8415c23e20 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1397,11 +1397,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            sd_blk_read(sd, addr, sd->blk_len);
+            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 
         default:
             break;
@@ -2137,6 +2134,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 17: /* CMD17:  READ_SINGLE_BLOCK */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2147,16 +2145,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0) {
-            sd_blk_read(sd, sd->data_start, io_len);
-        }
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= io_len)
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0


