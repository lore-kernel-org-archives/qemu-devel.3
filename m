Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F27C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 09:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te9bl-00014i-Aq; Sat, 01 Feb 2025 04:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bg-00014C-As
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:16:05 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9be-0000ja-U0
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:16:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso20846985e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 01:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738401361; x=1739006161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0KOfqY1jZzuDBLOoyIvqjDh4dLpYlCKlbjmZKCpncY=;
 b=Cgql6/QtC1u95c6dcBjJqqWEKbAnv4ORmQ3frkiUrZR0T8c7PWXOVFh+FFbQI/D88U
 8KHEv10VmerLvP83375WosyKQmHnfocIT8upHwV4dHWMACWHFwf4wYj/LhYogL/slVbN
 /XGQXeylVD/eu0UkqMcdsQzeR5qiZShsQueEEUh+fA8KyakjrVY6nbgS+hVp7BPHJTsw
 zkPbYtFbB+uHkJsBmZrqQ7bKbH9ggT4kQqv81Ok8q19gxr6a/pDMPNnx9970VKhsDaEO
 PYCJEaX/u2t7E4BbQmzxud3eQh9zHSjY/5WD3/hfwFOTAoJYRFNMq7rn4rL1J2M1FlP6
 ePXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738401361; x=1739006161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0KOfqY1jZzuDBLOoyIvqjDh4dLpYlCKlbjmZKCpncY=;
 b=LoQOw+4Uz5kj3fB71qguTQ6bePdESPm1mUb8RdzMw3SRT8leJxS0qesuRiT2iph7Mx
 cJhHu2WAdpnRowW56PibIJVjJB8G6N+xrPa+kAjSD6p4UWKFSU4hX/C0x40ARPzu+fmv
 gutzN+vsi5d13J0GK8BRpaE3NSHOVC0iP0xlFLKezH8A/Ixsc8rgVGJI07R2POdv1obz
 AfqOeKUDS6to6fP4/PXC2vD5L+ytuNPToUcx5iu9tSAJuOKrKrN1pVmDZwoq7Rd7Kl1g
 nX8FA7y4JinG+kEBXr8oHiMmdwvQSHLoe851mUc/ZL0uAnff9abLKimbWgPrb9oTRHHY
 XdeA==
X-Gm-Message-State: AOJu0YxUONHTxnvxCyWgTh2KbTisSjY4h587Rn+fgX9ABDTeCrrJwTI4
 7nfJzsbjSOwy5RIeEyohEYOOgILGZHX/fNdB6cCBo0y6hROvaQAbaS+aY1PXVJ/qDy2NIrRsE/A
 6Uzw=
X-Gm-Gg: ASbGncvLEiJYeDdyF/i7ETUrlVcAjo3VudUEePIqGeM5OCQWqmvSsYcglzKUVSj29Vv
 BzfuRQ+YqJgLNLKde6b1bQ/za2HaxGPX/t3t1QiZd6Thv+eMaa5ch1YC7z5+7ruqeKdDcEmDTJD
 gp2UZa6+YzhyEfVFkTFue3pQvgFnoC0bdeNi9vKwx6y8WRFf6kdci9mI5NHF7b8ko9mImcXXoRu
 HdueAAqLjFIFwnbItxeC9aVXm/fBudu+JqYuz6Y9s4Yla+eDokQRjkXOerdn5AAe9V5Oe0nZrSo
 xc/3PnPTv6OCXdr2vk9LRDTQF/6BVbG6f6l/W56lasGAEmK+Px7ry8IbK/YjEkdFVg==
X-Google-Smtp-Source: AGHT+IHud876BMZ/APlo5xZ+MxstGyVHcTwcYW4a27I3C1chvn9bo3mAf/dbsNnCVUka3qigCD05hw==
X-Received: by 2002:a05:600c:154f:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-438dc3ca79fmr141484875e9.14.1738401361073; 
 Sat, 01 Feb 2025 01:16:01 -0800 (PST)
Received: from localhost.localdomain (232.170.88.92.rev.sfr.net.
 [92.88.170.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b5a03sm6766496f8f.71.2025.02.01.01.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 01 Feb 2025 01:16:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] hw/arm/raspi4b: Expose the raspi4b-1g machine on 64-bit
 hosts
Date: Sat,  1 Feb 2025 10:15:26 +0100
Message-ID: <20250201091528.1177-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250201091528.1177-1-philmd@linaro.org>
References: <20250201091528.1177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

There is no particular reason to not have the raspi4b-1g machine
available on 64-bit hosts, so expose it there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi4b.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 713b4693a49..59b0d2ced44 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -107,7 +107,6 @@ static void raspi4b_machine_init(MachineState *machine)
     raspi_base_machine_init(machine, &soc->parent_obj);
 }
 
-#if HOST_LONG_BITS == 32
 static void raspi4b_1g_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -117,9 +116,12 @@ static void raspi4b_1g_machine_class_init(ObjectClass *oc, void *data)
 
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
+#if HOST_LONG_BITS == 32
     mc->alias = "raspi4b";
+#endif
 }
-#else
+
+#if HOST_LONG_BITS > 32
 static void raspi4b_2g_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -131,22 +133,21 @@ static void raspi4b_2g_machine_class_init(ObjectClass *oc, void *data)
     mc->init = raspi4b_machine_init;
     mc->alias = "raspi4b";
 }
-#endif
+#endif /* HOST_LONG_BITS > 32 */
 
 static const TypeInfo raspi4_machine_types[] = {
-#if HOST_LONG_BITS == 32
     {
         .name           = MACHINE_TYPE_NAME("raspi4b-1g"),
         .parent         = TYPE_RASPI4_MACHINE,
         .class_init     = raspi4b_1g_machine_class_init,
     },
-#else
+#if HOST_LONG_BITS > 32
     {
         .name           = MACHINE_TYPE_NAME("raspi4b-2g"),
         .parent         = TYPE_RASPI4_MACHINE,
         .class_init     = raspi4b_2g_machine_class_init,
     },
-#endif
+#endif /* HOST_LONG_BITS > 32 */
     {
         .name           = TYPE_RASPI4_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
-- 
2.47.1


