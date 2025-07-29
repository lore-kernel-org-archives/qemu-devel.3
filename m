Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A90C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiy9-0003UI-MV; Tue, 29 Jul 2025 07:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiy7-0003KP-OQ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiy3-0006FO-Kp
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so22838585e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790281; x=1754395081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRnxsxDSzCOpoWZVRmPH/J8Ta9I3EJlki8/3qSZwuX4=;
 b=sf8PRfMiHN37rRxYa429vEhHDOkpvUDiw7fV0zccD0AjVx4U9/aSZQI+6BkinJQ4fK
 T7aspd8GXEqmPiPzWmQKSuF83yCDxrtOjI/4M0AZsRqP6UikMS3M+/q832GIm8fYjMUo
 xMKy2yJZNXpf8u2dKlz6uo6ywbSWhhwlFpH46Fw9ork5Y2KQlwpwIiSHr13CuA0yp2YS
 WNRaWMj3ZVpX7nfU+VRHEzt6vHyu9bEdPtjL3cJggVozY+0e8VuIdVkrtuKb6XnrFQHr
 89tkQvxOSMSEfCNFQvjcPs2e6yNqd58HMfFO62yV4r7t4k8apO/9iDvjxUTjvfgz+lIf
 rwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790281; x=1754395081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRnxsxDSzCOpoWZVRmPH/J8Ta9I3EJlki8/3qSZwuX4=;
 b=OfkIgKGGMLg1G/XwSdL52rw+N973+KcZVaQkiyneNmlHIbXDPrkYaXODLo7a6186w4
 FaKx4SYrKCuyi3PhxeFeNZl8peRU3FfwftIf1Q8S8RBOxpiZz41+ggnmZIyoKrovyHNG
 t1Gn+Qk6QWoLD08xGRM0D03lwIMwcultWJfrgkgdfecz5GMOfKphJmO5jGeFi0Cuj8QV
 8hFKnD2xbmIiaTzxzfu8uK/c2y66AukIngbBm9PGwZdqlv2jlGLAf6q6pUGF8008484p
 Setwd7PeS7yrNxMBd7iGTOUIVZnai5fzjqUGFBQPrK8He63jzl1i12K91r0cn5ZW5Xlx
 NaJw==
X-Gm-Message-State: AOJu0YxbUDGMqHX/Se9QQhp+CWQxPe00THzc9v1pJFQM7TZjYxXnQYa8
 zy9kpw3cs00CKCBX67zP2addg/1MQ509nwGmeCRnGAN8QK8lxhxpSXejN2yH6I9ItCWmm0+l6HA
 Strl+
X-Gm-Gg: ASbGncuoVLTUM2SnzNmBfeope83VmPh/N/zTHo90NtAPM+5VrRMNHXXFMev/eDKybV9
 mabWoczd9U01DCKDpCuH1mypV2rz3EsvjtK2G18cs5kguzS0YHX1BuXBAqbRuJMKMvrHDOKi2HC
 NBB6qH/7VLteRYwPxeNCy0fkZUbMizCHn6Zpk+wQA3pi6AFJkDdGnyARsk1oD4Wjh0nBMe37eKm
 0DmFDZJmb6n6hPM0NbRD9/IYo4Rigtl3H7kRONTQKky1864vfG03gl21nYiA+yFSn+xUgG242M7
 UPDaRZTmpOaa8nMpFaIraDj+2Ou4ab0Z9z36mqVJZ5Kd0D/zezNBeStLwA/3KjNiquYxVE/+iZH
 8CkBZhdjMRCcM7Me4+Ahd4+jBGoqCse2Yz1QTP5CLtvOibqase6GRApdos/wYt3r32MhcDvtG
X-Google-Smtp-Source: AGHT+IHu2fbOTUGSX2J/50N6V/iYeoAU6KhTTfxUYFj1XtrQ9l0Wno1Kfm+k6IpEyK7/bej9Jg6qBw==
X-Received: by 2002:a05:600c:1914:b0:456:c50:1b3 with SMTP id
 5b1f17b1804b1-45879bf0bd8mr86388555e9.29.1753790281186; 
 Tue, 29 Jul 2025 04:58:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588ee11c91sm11240745e9.4.2025.07.29.04.57.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:58:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, qemu-stable@nongnu.org,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PULL 5/9] hw/net/cadence_gem: fix register mask initialization
Date: Tue, 29 Jul 2025 13:57:30 +0200
Message-ID: <20250729115735.33619-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Luc Michel <luc.michel@amd.com>

The gem_init_register_masks function was called at init time but it
relies on the num-priority-queues property. Call it at realize time
instead.

Cc: qemu-stable@nongnu.org
Fixes: 4c70e32f05f ("net: cadence_gem: Define access permission for interrupt registers")
Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Message-ID: <20250716095432.81923-2-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 50025d5a6f2..44446666deb 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1756,6 +1756,7 @@ static void gem_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
 
+    gem_init_register_masks(s);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
@@ -1776,7 +1777,6 @@ static void gem_init(Object *obj)
 
     DB_PRINT("\n");
 
-    gem_init_register_masks(s);
     memory_region_init_io(&s->iomem, OBJECT(s), &gem_ops, s,
                           "enet", sizeof(s->regs));
 
-- 
2.49.0


