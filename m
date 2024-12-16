Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3AEE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28u-0007Gs-Gl; Sun, 15 Dec 2024 22:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28r-0007FR-12
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:33 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28p-0005yS-4L
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:32 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e173ed85bso1715793a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321090; x=1734925890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=abmW9S10QDXgkxuzkPFMFVNs91hcysNUK3ttKoHVbJj301wv7BBUDV4CcMFXZwlAbB
 bRL0JnoqONbfeeCP5uwm1ba25Nr1korG2W44b8fkdkXJK9DcFo1s0Jxzdh2aZUZmb0m+
 auPi5xthjQozsBhmZwzsXd+EmEEz+0r4yBjHsC4GV937jp5eVahcBM0Ss8wWIh3DgbPN
 0si4K/05YNIJsW8FGzO8HvyQa4hrNtzHQ4YfD+7lQ87FTuvSnypZsX+l096IyTKvvddK
 BG6yWsDI6kCVnWViPe7yTF2bYw2ScUp5BtTTzb2JWW6p2oWSNBdm20JqubzTZ2bIwMn2
 dcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321090; x=1734925890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=cY+YMqUgsC63A7VHfKEN41VcdVb1uNVw9zArFa2UTg/7sPZ5z5RgZYFJ79bEt8To1C
 Kkqz0CWGlP56JZU+gf3Jh3VYTo3ystDP5xTZjPsCjh3yaDUhbdpgnQV1QnpMv+MbLi/4
 D0uqFdpnLtMw8PGUg1al0IzfJ3lunvrp6Uo9qszxQGWPsGzjksTGOPnYuFyliHLxGQq5
 bcs0DHYF+4zBueIbskDsaESbr/FLBcwY/hTM9LvRZFac4gGS8isWXIsPVsVrSbd9XlCQ
 TKFp3rmVgsgpG4aB2II8b4I48myoaRLMmCxyVvGn4fml5OJrU6OAEEmKsX+70IkhcpiY
 YFYw==
X-Gm-Message-State: AOJu0YwNmC2WE95hxvH0YP/sIxcqsk42VLo7z/rA35c8oCvVoRobvCqK
 vR8Z0in+IWb1Ht/zOm/hlLiglRFPsRu2Pk5oA7kJVml1D8aC/LQ3kbPw8xUlQlxKMpfpIyDeLaG
 txrkz4sb/
X-Gm-Gg: ASbGncvBpwsjIti7dFBQPzbqma+yIqdMj2s3V6pOHG2tSGBmA6J+9s6g43tjGIUNvZl
 j/ATO1dmrhn10vCv94WRewGTExxq4B/LiDZDkbUuw6nS/T20HAVyZA7jqptrACI25FPJbPx/Qe5
 V+1paYIg/ajlvoWD59xWL9d8zw0ohkSj/mTKZKu0BBdmRAat1OcGMDvfTGthmnev0Y0Dzj+//Cr
 LvyUY5KTbb1oAgCliOQWUFGl3cFKMC/qgwMXdQWTHMcpzILXKy562a//rC+Uoh5QSd/OrVdVgWW
 xDPa3SWCSBUJO/VoEmUhwXTFtZI8daS4GLcRy2vz9Cw=
X-Google-Smtp-Source: AGHT+IGZoDWByMfEPTo2zvuvPbFUoQO9FkhiLoSfPjxvCjQ5YjZFUJRzlkVZp2LC1FkUeAq4xkqO/w==
X-Received: by 2002:a05:6830:6603:b0:71e:1ca5:fc93 with SMTP id
 46e09a7af769-71e3b8a781emr6280458a34.16.1734321090019; 
 Sun, 15 Dec 2024 19:51:30 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/24] hw/pci-host/astro: Remove empty Property list
Date: Sun, 15 Dec 2024 21:50:50 -0600
Message-ID: <20241216035109.3486070-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/astro.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 379095b356..62e9c8acbf 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -461,10 +461,6 @@ static void elroy_pcihost_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), elroy_set_irq, ELROY_IRQS);
 }
 
-static Property elroy_pcihost_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static const VMStateDescription vmstate_elroy = {
     .name = "Elroy",
     .version_id = 1,
@@ -490,7 +486,6 @@ static void elroy_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, elroy_reset);
-    device_class_set_props(dc, elroy_pcihost_properties);
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
 }
-- 
2.43.0


