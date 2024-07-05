Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12AFC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3b-0003KW-4V; Fri, 05 Jul 2024 18:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3a-0003JB-4M
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3X-0007c9-Ok
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424ad289912so14168625e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217125; x=1720821925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fniJoDv0JvGQIrVVzQXHvMIti3h9L7JHmKwMnT7C6s8=;
 b=S+iG/9flDDq0GPoeMxaLsAOHmOXxxHISjQlHHfjs5/jnV80zJTedWiGCYTb5nRSUYJ
 DzAZyTmpCDlDtFMHzX921/+kENKPBLgC7yM4zA+27D4pJsPthDr+kEvyvvkhU8Y3MJGM
 LATZfW4X5t/zPlZDp9RA7COd+pm2MV5LJkqRK3q85CmHIkae9RwN+fAedA+6b9ybkQ9S
 1XL/Cav2bEFX2e30at66XsfI7qidAXDRV1ZM3xP3VGCvHnPnFERDXlsnb5zoeALLWg8B
 ycVb1ahKd/E/w/MaRg10ef3gu3NohDUI1mkyPyqzqe026EU0Ofb9v+PCMSC9ST9W7csI
 n3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217125; x=1720821925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fniJoDv0JvGQIrVVzQXHvMIti3h9L7JHmKwMnT7C6s8=;
 b=dA+6KfDhzbdFLbcbgjpMUSOfD31K6s7ryb++2NHe11H/5rZJTdN2bB1YwEMfDKDQ3t
 DAhBc4YeYOL2xq6EjdQYzhe7o1iUf64tX8udimKPYoS8EJu2+44q3m8OBF0FjJ7JSTd2
 1Busiri5Lzgy4qAeQReVnA94pD/tBs1mVbcXQqI1o3oU19mQbeyYxGA+JXLz4Kg/D6mE
 05cQfgYiSZWKhLR2rEAaHGrBzZgTBSwHtgE09iFvct64zVS+IN0xkrWUQzH6wl7WRHCY
 0s9wVo4Lo/AHmzcUotCac3hlmoudvD9Ze7YdGYi6pbQVOTUcLJEW4cnBuvn3G9X2gqTw
 IaWw==
X-Gm-Message-State: AOJu0YyIbGicN3CWvK9QG5lhNgQRS5kJpBaTr4om+zplebw2xvbjvkJe
 0tPVa1kmNTRdZeU1q/s9Q8KmWwmvl1sSI//VUvlW3ZJBGMTtq9jwAslzwMTTOb+InXqHVK8Hdqc
 o
X-Google-Smtp-Source: AGHT+IGLy4efDOQBdT5KqhRwf4MbrZpH+wS8334TJmUP1WnhZZp5grEsKwABA17q0tuNXIX2XxiFEw==
X-Received: by 2002:a05:600c:5126:b0:424:bb93:7aad with SMTP id
 5b1f17b1804b1-4264a36eebbmr45998925e9.0.1720217124877; 
 Fri, 05 Jul 2024 15:05:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f23c1sm75365555e9.28.2024.07.05.15.05.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 09/16] hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
Date: Sat,  6 Jul 2024 00:04:27 +0200
Message-ID: <20240705220435.15415-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
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

All handlers using the 'sd_none' enum got converted,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-76-philmd@linaro.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 29c76935a0..c1a35ab420 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,7 +76,6 @@ typedef enum  {
 } sd_uhs_mode_t;
 
 typedef enum {
-    sd_none = 0,
     sd_spi,
     sd_bc,     /* broadcast -- no response */
     sd_bcr,    /* broadcast with response */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 10f2764a53..43f60cf089 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -524,17 +524,12 @@ static void sd_set_rca(SDState *sd, uint16_t value)
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
     switch (s->proto->cmd[req.cmd].type) {
-    case sd_none:
-        /* Called from legacy code not ported to SDProto array */
-        assert(!s->proto->cmd[req.cmd].handler);
-        /* fall-through */
     case sd_ac:
     case sd_adtc:
         return req.arg >> 16;
     case sd_spi:
-        g_assert_not_reached();
     default:
-        return 0;
+        g_assert_not_reached();
     }
 }
 
-- 
2.41.0


