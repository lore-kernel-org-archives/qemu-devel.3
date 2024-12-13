Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB8C-0008IR-QX; Fri, 13 Dec 2024 14:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB71-0006HX-7J
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:08 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6z-0007Ws-4N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:06 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29f88004a92so1252808fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117242; x=1734722042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=mONUwRD2MXRaN0nY/A0cU+d3qyXomnOqz/2q06pw+bmo/FVow1VUfB8Ej/0m84lSWo
 xUUAcc9fnVRqPQNvekIhcbx00LHKZ3tAWkEiKhi//e9DNHShvRGh3EpFicVnGCJskTkc
 YOOoU4W/Qkf6sKzXkSUUjvwevZaECIpealOztPaAd2dqndazI9EVXb1V3F5BCUaUbB+/
 0CIdEqjTGjqrLh6zSK4sSBv+gIQxPZIneaLMz7rk0swuhjNJZriFEIgI7Q9t785v3oay
 pARksdA0e8nNzMFzYAWj7B0ujYQUfEGXCyHiVzIt9030Rcq9Rkduxh8VSkWkv7ogFjCt
 Krxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117242; x=1734722042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht4ZlthGspVYtEWG+5uRpgdlGJS5T3fuIdiO1kKsIqU=;
 b=v4hm5ApXTYQyunL3yWHMsyKC1d7D7/Sqjz3St0hmI58SRmPUfxCoPVKzUg2sht/2pd
 ZjX/lXG8Lw7TYr6us/6x/nboT8LIID3QVv4FlOc5fdPE77Ds+Jpn4mci8zIzVOVcZVoh
 kk1xWDSCKzNCyYa20W/Jncl/gJ5RdSMAqty5wJhyaldlG+YSV9uzlkfjKe6cX90S86v9
 pTwi83IJyPQORAHrRBhZGo0hID+IM0rtadPtqhhehUONOrSdT93rmA5octnkoxmhdV2X
 +3WKhOk0yg5a7GKwRlUvQ9l+F7UxqZD7OFbD0f+S2uCBaRlJQUOrhpJz1uyTyN9woHsa
 idDQ==
X-Gm-Message-State: AOJu0Yx1xFs0dCR6LsCMR9/fye9uqLpSFAEPhVXLL5tJpMe0ZptwNdZP
 Iz5zdK6MHw+MCPPFyHVvXaNRIVkyE3UkJKbi7HQaKKhCvDgpHqtR5HN+lpouTKtjing2liIvhxO
 s0msJlWnb
X-Gm-Gg: ASbGncthzfxpt7cl9YiI/Hg4IIVf3He4VLszcr2yPtJL96d/tLwCcSMuaT5zJXI6wSK
 BkTVAYQyYHciSiTibXDb69hNP2fyktEXnEwXtDKFTQL7QEMvoGScWjKozly3R0c1At0ZWEnfai+
 4Or7MqU5hYaarIyzs6+8vXSk3QgALEnebduDuKK22S7n98HvOzmeEd5jTr3NWaM9yatS5iSgKFt
 4h+2s7jmCgW3QBzp1gniRB7SgX1ep0DfVb6bR6xWvEXS/bEYFQHZr8b7agkKX1Z
X-Google-Smtp-Source: AGHT+IGZ/PvUMGmqi5e8Bk1rGup3iswt9ghvsT2e9lIq++g1rY7eR5j8PsVNC0mxbnECi6p4/IfHmA==
X-Received: by 2002:a05:6808:218d:b0:3eb:3619:6a90 with SMTP id
 5614622812f47-3eba693ab5bmr1514702b6e.33.1734117242461; 
 Fri, 13 Dec 2024 11:14:02 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 46/71] hw/pci-host/astro: Remove empty Property list
Date: Fri, 13 Dec 2024 13:07:20 -0600
Message-ID: <20241213190750.2513964-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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


