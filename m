Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF64C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrz1-00026J-Fq; Thu, 27 Jun 2024 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryz-0001zt-A1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:25 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryu-0003RW-Gx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:25 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce6a9fd5cso5040659e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505698; x=1720110498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nu8acyjpOBs616osR1RalX8TR2/NJv3m9AnCQgylDWw=;
 b=kbq85n7ApPOGi9S5wvgOjM4bpa9bC6cpI56kHkVC7EUJPmVsVmJZ2BI6Rmvq45h1JO
 uD1mGAgAHFjskqrenjCXup5o84H53Lalv/JGz8CN225rRS1It8ldpW9ZMd61d1jJ1UY2
 UkX7LukTWpwj2INhuXXHTVY1pDu4VKkT1dljG07eA/0Aj3oalK7thOUMoSKmlr4j6p50
 0RLUH/rkn6fvMomc25qOk3nCPbxWH0KjmYYByn4W6UIz0PLalVIysPDoV+DACLvdHEVP
 GmClgJWbhgqc3rxxEPmGALBL2aMjuBeLzq7mbb4sAYpaW7fwWngTCpo/0/Yrtr8HZnCD
 Gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505698; x=1720110498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nu8acyjpOBs616osR1RalX8TR2/NJv3m9AnCQgylDWw=;
 b=WzMAmvWGP4i63f2nvBwivQu8/AJ7Oek5CWuWHYvX2+rotx05s1to+y6S7/QyHeRbmf
 HHXcq+2OCOvfduHuFryFEUnDr00ocICdbkkxMGGflCnsMkDo77RoCDGkDboVNgdnUXLj
 RNA1kVBcyhwwkpFRitONFx38qf2dDxAXfRtvWcDRTmuxkoJkahENai/COg/e2l8s5F7j
 e+g3Vr71g76x97vzEoa7q5bAv5LZqD+OfxajXJQHxM8PgPrSm5gWk4dS060+28nNM767
 dvfeuwFmvoXwmt1BSVpUVTYXgCIJnoUpns+oWKWYZdfzTW5QlX1dhbfxOpj0E3CD+d43
 hfWQ==
X-Gm-Message-State: AOJu0Yzxk2VKiqb4hcUCQhiEHdLLsg62IzNxhdHlu4COe6k71gAbFapH
 2uLlIdwzvMpglArE8uo6Nzy3b7159LHiBx98QPB2ZMoU59UTKego7yY0PdnzYzQpxbLuw8O0NeO
 0tfI=
X-Google-Smtp-Source: AGHT+IGq3CiDQeS8+/xyTZfwPjEr64B/Qna+T+BMaosaC1ZtFyMqrrgmafTsJzwie2K0PFiQskKcBg==
X-Received: by 2002:ac2:5490:0:b0:52c:9e51:c3f with SMTP id
 2adb3069b0e04-52ce185cfb0mr9045412e87.42.1719505698287; 
 Thu, 27 Jun 2024 09:28:18 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8245e87sm76229945e9.9.2024.06.27.09.28.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 04/11] hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK /
 READ_MULTIPLE_BLOCK cases
Date: Thu, 27 Jun 2024 18:27:22 +0200
Message-ID: <20240627162729.80909-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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


