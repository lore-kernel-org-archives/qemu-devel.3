Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54j-0004gP-VN; Thu, 23 Oct 2025 19:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54i-0004bC-6e
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54g-0007R6-4g
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so18592165ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263428; x=1761868228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSdBIzUFAJ8jmSWRkWF95NhSo1Eq4JPgHiE1RjnAzx0=;
 b=TqgZvelAsjBAKh+kZOzdNCQ76MHoASnw1Z3LKzLNJOG9fYqPrUz9Lk85HfQZ28mMIS
 cbHbJiOcgZXjty+sWYoVR5XvOI5vh6K84+V9t/e0gopzHoa5tBMTYtoj6bcD0He5yawh
 SLr3jzKpgDfkhNp9fRqz/uT/aBD0afe6oSWbwu/NQ7DwKyizLfgGhNWcq6OaHdr6CjMe
 5tKSrh/zd1Axxf/zcJRqkbiZxohYXC3vPyRAeWaHpiwXPylIoi8Dm3FsFWP72iJW8FJY
 aEuU4RJ6wF2NY+Z64bzaBcL003dFEnRJUwQOeAPnIVg7K9oMIZhuRKApKBXB1mW/kkQk
 G1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263428; x=1761868228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSdBIzUFAJ8jmSWRkWF95NhSo1Eq4JPgHiE1RjnAzx0=;
 b=enT0GzvO4/sVrkIidaNw3edBQsfsDjsEkvpDyjXs1CertjsDafrx0d+4mzb7XtBK+o
 2Wda4H6ARMWGfNh3jcTvqSUolm5hNi25Mi/Z+NVfxhgIIcVRpJ1JEI3F8MoG+ala7076
 hdICjtn4BnAkKda/IhGfDku9cYouQevKslX356k18sE47X45o/cjx8f1UDDXGcrD+Nbk
 QV8Z6wZeVzL/3/tx3mT4KTTfhZWIcqRfRMGNeNeo46okHPadC1s2X+pnONE4YkZRit3S
 PGzI4G5JYgm3lErHjiz23tTNBsG+LxnuvUHzTwf6IewQ50BWym0EELC4qjYha3UV0XNO
 tZeg==
X-Gm-Message-State: AOJu0YxqQvSZpFO58BGHoDxwFTKuzOamYStAPbdqZe08Ly5qw4QO/Dze
 rISFtGH9YIZy8A9afNCkovj8oKfGn4++afzS9chp+GFqsCSoSrJ5SY06gfXKKA==
X-Gm-Gg: ASbGncukGFHQekJjBntvVgydp3sYOJORFMQ7GQByLOOk6ZBzRojeVkRxQZMj+OHukvt
 LjqdfZisJX6ghge5woEDADbpdeyD0P0sAlDwaWxG4pYvXtSzcgqeGO4j3thgUK+xlDN8s5wcm2l
 EQ8oKqK4Y8SvLuw8j6Gv/QxEH/ulzMsW9lpS/98y4R2Cvta8a6VOKKqYfHQ5RkW58zAWbmMeQ02
 y6oCcpcJOYdLgHWaUZy0RtLNpQVhyxvUG3EWHL+VtsgMJPNv3G1eHZEh8kdfmE/+3YWuFzKnfW6
 kRk58/J0fcXXFwXz8nEqUvvFTtR5rxbqJon3ZjN94NZVe5drlRnix7XQceDGkdaVuHc40Ftz/9Z
 jAOcFqKqb3a1IAUzty5i6e9JEi7EdaSFb5fBQsezXmfu9+q4puMJDUYThYlZqYorTUPRounpDOJ
 lDBajxdz7V9dCn9z60h7yfvOxJM1k0PsCBCNdYXmUjtg4jZLEODA0Eoq/mAqrB6jOXgeNh4kgMo
 IvqfmV9
X-Google-Smtp-Source: AGHT+IGDfCxSQTgX1Ucivyhvv2syL2OJX+KyuSEZw48bnpdRHh9jzBQx6gaY6IdU2LJ1FG5sXJX1fw==
X-Received: by 2002:a17:903:238b:b0:26b:3aab:f6b8 with SMTP id
 d9443c01a7336-2948ba7c997mr2412085ad.58.1761263428306; 
 Thu, 23 Oct 2025 16:50:28 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/25] hw/riscv: microchip_pfsoc: Connect Ethernet PHY
 channels
Date: Fri, 24 Oct 2025 09:49:17 +1000
Message-ID: <20251023234927.1864284-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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


