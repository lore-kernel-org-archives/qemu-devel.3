Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94321CCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjn-0000oz-TL; Thu, 23 Oct 2025 00:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjl-0000oK-Sd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjk-0007Me-3q
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-781206cce18so356709b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192938; x=1761797738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSdBIzUFAJ8jmSWRkWF95NhSo1Eq4JPgHiE1RjnAzx0=;
 b=AoiDYwylIzhwWqt2fYpGSsYKMKYwEDhhe4a9T/2q5PDPmpveLtItMMX3dFglqqgp6F
 RQMsGLRMzt8qfHO8WRvuSnXBHP2Cv2GX/zOuobGb1QNxga7YyEzri59mgRRHkU3f1+0Y
 w7BvfTlR/E5TnF8rYSxODMyAABPCut+Rb6yvZ2DeZmxpuQrpHf0szwiNoGdQhL7BSCRn
 KvTfMFKIROdDO2mI8w3Ewpo2m9lOm2Ne6aGZxN/ayWSeanEG0CvwfmJtwcUXfc2b2aOD
 0xM6FwWlj88vR0pQSgrn4ODVewaNEy0Vm0el383dK8XcdRo2g5ANWq+Nlj+sFqT3K1EU
 iM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192938; x=1761797738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSdBIzUFAJ8jmSWRkWF95NhSo1Eq4JPgHiE1RjnAzx0=;
 b=AYTMA7kZrbSM63kDCLAKrIS1k5V1ONR4n1rH55J2G5DrOkHaoYNKmnPe1+rXLtMPJb
 QnIdPzT7fmV+hViebk6YcxbhLsTdDPBMRBDmjnpn3vvxAFf6CRIenGqPbTS6w4xZFRaQ
 1z0uEfgbiXTrwH/XEGC6/5oknaJkytVbettGjGqUlsbJk9/qtBZnx37bkfZp2yiMd9aJ
 LKWlS7sE/uVg2Tj2gxNf8PQWtwjYlZaa3QkyX7BSbJRNGRyU7czcStETO+10vGf4FWiS
 au7stzrw7WCUuhe/OdRJsXSWNjYaP+nkEnxyveLRRmKIUV9BzxubSYxv/jQ/zaiaNWqQ
 fgCg==
X-Gm-Message-State: AOJu0YxYEdQf1Fmm5xjDlpsIQcx3EzsvQmdL0S4xACsMiuqXrTPeN+tr
 zDIi5Dk199yZ7Sya1/+ETKPsa/ZnlS0SrSjepq0JOCYrX5hUNaCZOp7mbXxJPw==
X-Gm-Gg: ASbGnctA5vP4GQ2kzY9UOReUCrkI+yFW7Q1DuVaXQzhv0Om16NnBjXQTJTE+USGWncf
 GqgBz4EkfqaUZ7mmq9yJb6f5RguiAuQ+B6bTwbDZW4ZSnelJP/dJOwY9HmQHBi9PE7NiKM8QesE
 0o6UW16nnVBrSzZTsX7WEhRYVwC/Nr+bnIafopmg/2c+9hZRitLOdddrOVv588ouEDT90IaIEHp
 A+ZFfX8VbwIYGJLKWMrSlb/IB4UVa4q2SiPsiHQmfIS/xaJ6kxVPNelHGM3MKCsqFA4YFMMZoGG
 Cjcm/zVSf2zrQdiFqZquPhl0N2pXzsPis7G4wOIhDm2Bj3zy/MXP9c1jN3pnDoc+DDA7YTIhONA
 EQvHFdSmJwO9ZM4mIBoBpbhK/BFBnpFkBFpdGJHoD16Qcp+8vAiQfngvUZ8Y9FO1Cim31962AcF
 x2AeOtd8jFNJw3udVqvKoZf+cuV3MqXKcUr8/RIxzHadK+yt5qfiO2BoxcEJ1nfwFwRuHdmR08N
 KeGT5tJZw==
X-Google-Smtp-Source: AGHT+IGM5xJy71F6hwK63RTqc+2lEU7LFa4kHgYVTKKTnACwI0FNSFfR4E/GrSmVRt/Fn9LI09pypA==
X-Received: by 2002:a05:6a00:b01b:b0:77f:43e6:ce65 with SMTP id
 d2e1a72fcca58-7a26b1b4467mr2933160b3a.0.1761192937933; 
 Wed, 22 Oct 2025 21:15:37 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/37] hw/riscv: microchip_pfsoc: Connect Ethernet PHY channels
Date: Thu, 23 Oct 2025 14:14:13 +1000
Message-ID: <20251023041435.1775208-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-3-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 2e74783fce..9fbfba8ece 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -414,6 +414,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
     object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
+    object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, errp);
+
     sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
                     memmap[MICROCHIP_PFSOC_GEM0].base);
@@ -422,6 +424,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->gem1), "revision", GEM_REVISION, errp);
     object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
+    object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
+                             OBJECT(&s->gem0), errp);
     sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
                     memmap[MICROCHIP_PFSOC_GEM1].base);
-- 
2.51.0


