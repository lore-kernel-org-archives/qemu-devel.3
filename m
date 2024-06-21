Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86652C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIb-00065S-5q; Fri, 21 Jun 2024 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIZ-0005tA-5U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:07 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIX-0008RQ-Kw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:06 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec10324791so18847291fa.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957223; x=1719562023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rbyk3UWFgM2fJ2qZVnBwxOBfAjBIau/lAmmpzLCFWnw=;
 b=bJBMf9dxKyzAgyzihFLFZH8SPPYh2kMP/y9tLOIsPBeP67f9Uxn/1mB0bo8c1GXJM1
 e5ZpEDFWomTWnIJ0YMpC0NrldInZesAD+mcVhEHqnycT1IB9X10jxY/TnwvLAmcF1Lh8
 VSPkbfEwe+SVjJEKVb7lnlLjzIEiULXKoo6mGW0h2gN4xocuUJqFuoHzcv8ZYeUVO/Gi
 hnTg3B19n/V0UKS8LMRON/LxzOu6Xd5r4voN0I1Ys9Sa8bOd/ZwYV7YHmGifEm5rF0wT
 BG9S+AiTuaFXpg+XBP4MXvyGQYKu2/pj5vmAu7WFpKk1HpBd5gsfbAiCBtGk+7QIskWy
 E3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957223; x=1719562023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rbyk3UWFgM2fJ2qZVnBwxOBfAjBIau/lAmmpzLCFWnw=;
 b=qtYpXqruTaauvexR7qg6VoBf2F0Uffv2RS7QciPI1fd1NMIRu7ABiiZMlW54uVnkpW
 Lx59h5eDc7Km06TN/YqfWDkE3HU+tB72EfuWSyJKnRBNsNhVLleI1f6BhOKWVrAh3cL+
 Jf1eO7cey5YY6ArUrUGRl3k/SE7SMfPsHNFEYjcDjp1aRZVtVEmwGEJr/VJ6Able5Blv
 yiFj5Fib9jbwVb9wDV6nX5WjdV25Lej8EDapukxcSEEziqts0DnnVjyy0VWGQfDiDCAg
 o4SH4PenlGlTiqSFC1zzNZZdM0a4CxgR9BWQo98MI+Kh3dM3++jP99mGxppqTtkBBb3F
 JE3A==
X-Gm-Message-State: AOJu0Yy39IpzNwdkY9Sf74L6t9xE7haTTdi/frEv97PdM6UlCSgVc0Lq
 Wkp6tUP6uI+CWhZspSOFh66Tk6ySdeOrIRsqpUrXQdvB39uVLkxenECM2hHiQmPD037SP2JRboV
 l
X-Google-Smtp-Source: AGHT+IGawaLYlGgk/gVLgzkpXV7SUK2EpYuj7y7wStFOwxJrgW0ZYHCThrOHSQyfGNS+5ZDdCj7hrg==
X-Received: by 2002:a05:651c:91:b0:2ec:22c0:66e6 with SMTP id
 38308e7fff4ca-2ec3ce9b78cmr51243561fa.7.1718957223676; 
 Fri, 21 Jun 2024 01:07:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42471e66013sm90039585e9.1.2024.06.21.01.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 11/23] hw/sd/sdcard: Trace update of block count (CMD23)
Date: Fri, 21 Jun 2024 10:05:42 +0200
Message-ID: <20240621080554.18986-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 1 +
 hw/sd/trace-events | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4e378f7cf7..2586d15cbd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1087,6 +1087,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 94a00557b2..724365efc3 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -43,7 +43,8 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_reset(void) ""
-sdcard_set_blocklen(uint16_t length) "0x%03x"
+sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
+sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
 sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
-- 
2.41.0


