Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9557CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDy-0005Lc-0K; Wed, 20 Aug 2025 17:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDv-0005Jk-Tw; Wed, 20 Aug 2025 17:19:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDu-00051J-AE; Wed, 20 Aug 2025 17:19:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61a2a5b06cdso647554a12.1; 
 Wed, 20 Aug 2025 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724796; x=1756329596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JUtot82YvSwyf3aXIjcJBWwXAuoQGNyUhMh8fZ0EZY=;
 b=KP4hnxjv78mMp71ZA8MKofgqCJPLZDwD3wcWMCEwgXH84kxqNM/wgca3rDe84DxTMa
 DaxilM/YBoYLt1fFDpOBhNquLrU5Nj9eLQ3V29REJj9zoYyqzYOnOwnvaTzF15TgpkgV
 ZTKs9+qQ+Vpo759VgCecnpd8NkicgVaNI4hNrjLYaUgjbYyggYOshyNxR6V0prduXfT2
 EXdJVFtW3z1eKFtdh+euWxRRQffdYtYh+SfiiA5DmVDJe2mR5H4rxwl+gRlgX8UGFjdI
 96YoHMVaX0IHtirlP5n9SFYUnH/rVxKQVAkEkLMaCon5MDAuDRWgWY8NU5490FKnEOlf
 L7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724796; x=1756329596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JUtot82YvSwyf3aXIjcJBWwXAuoQGNyUhMh8fZ0EZY=;
 b=NNl/7lMEw+2fBkLYAKg6iKcU63eV6s3JDQ3AI0iSVyEGgDFi6nq4WByeZoJGKF5URC
 q4z5+x2/nnfiBeQKpoM/VIN0IsquFTVIHu6E7ZSbVuL5TtCjGupPNbOGZ931smbF5ewG
 a4IMIoxEgFa9pjl08fTJ8NeZ0lI1MHb+7YnWYHCcbPVjLQ49kb0y3c0AMMPzELQf4VXw
 NWOkADRMxpgJYwaDCr6yBRHXj7tEhQvAXIpnxkaw6TqjNOWV8RfXaK/w+jdD1PPUzL7I
 +1RmlNYyhvOBhzsGeulRhaM3dNdNIHFBhq57xSe38ZOYDKb1PI3HtiqWtE2IIzdOeGB+
 60pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg+TpB946OwDJtVZCxEsppShebMA8T5MFTeV3V9y5veE4FgiSt8+Bj+LK1O6vRbolF4N/A0rMujg==@nongnu.org
X-Gm-Message-State: AOJu0Yx8dCbtD5spT1eUHZR0NisVi43z7rpuVRgdh5uQFkIXGtnFCZZx
 y2Vnu3ERVeCTQnm/NY+p006hGSjYJFDafsO+QOCWnRXBT12/3O/l66CTlHtKNAIl
X-Gm-Gg: ASbGncvDZ5md26DpIXHTjLpsYNhSMZoR38KZqe9UCepsGrKBOKZza3VwYJu6cl6rSjs
 XTTRFrPLAMBmxY9gAdYOi4AcMxKIC+MlVaL/wjlSatpWKOCJj5bEKs4dUwzXuloRCa80hFjcAv/
 pOzoaRXwhLTnYYFWkVxJ5aHv76WberGoCBYkvW9oTVVlMzIjmazfhLnYTj1X+r+5+/pudVgnWQG
 ZqAny1OEDKotEOk0Ur7xcp4NNZykv87AbX404I24m3tDTCZDJoEooRqrcqhlsZuu03hdEvIFDNx
 tT2OOJDJsezTMQtzJbe8sb6erVmewDXj9YkiN6aAcjOrda+pD3RECP3h/SfAMovq4QZ7dWxhBWl
 QFLd/JQdebIB3qIucUFo3rt2Ci0NRPYhXOLluD50jX9hpJrP5m26pedkLi7DEnHJCqKeiFwcJww
 Iccq3iHizjEPfkWW1XeDrX3iTrN9zurMtQN88hfCIClBY=
X-Google-Smtp-Source: AGHT+IFt58OrVR9gr38S9PgFLB8xA861Rr+G7Xsrqf4pF6NeMy4JJbmTpaxhffrkWfRt3MCCjraLBw==
X-Received: by 2002:a05:6402:2551:b0:61a:8e5c:f4ef with SMTP id
 4fb4d7f45d1cf-61bf872606cmr117418a12.18.1755724796135; 
 Wed, 20 Aug 2025 14:19:56 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/10] hw/pci-host/designware: Don't map PCI memory space into
 PCI inbound window
Date: Wed, 20 Aug 2025 23:19:29 +0200
Message-ID: <20250820211932.27302-8-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The real device has a default mapping which disappears as soon as an inbound
iATU is configured. Furthermore, inbound and outbound mappings are entirely
defined by iATUs. Remove the hardcoded mapping of PCI memory space to match
real hardware.

Note that the device model attempts to implement the default inbound mapping
by reusing an inbound iATU. However, Linux clears all iATUs during boot,
including the one purposefully set up by the device model, resulting in no
default mapping. This will be fixed in the next patch.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 1e29b7e6be..2fd60a4817 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -703,8 +703,6 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                        OBJECT(s),
                        "pcie-bus-address-space-root",
                        UINT64_MAX);
-    memory_region_add_subregion(&s->pci.address_space_root,
-                                0x0, &s->pci.memory);
     address_space_init(&s->pci.address_space,
                        &s->pci.address_space_root,
                        "pcie-bus-address-space");
-- 
2.50.1


