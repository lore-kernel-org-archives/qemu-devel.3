Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8404CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 20:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v58Ra-00013L-7N; Sat, 04 Oct 2025 16:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RQ-0000yf-1Y
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RM-0006E6-0s
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:15 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b551b040930so2269925a12.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759608066; x=1760212866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyUMAKAMMzxzjBFdIg7etB3CpnVzv30SqV4s7/yn2ic=;
 b=ff4iOuavI+aMAQoF3s1ylC7cHH1Lp4rSASSnEGubqeC8MWOFRuYTLf3CiXf99ze0Ae
 Mw0LKR8cLGlFVgIsW+yVDV2eDgbg7qf2kZf+0+7Oq4MYA+I+9gjOY3a/zqHk2PW5WSu5
 OP+PURNjFyivjkGAyuuIr+nG/QwEYkmOJCxyg2gPSd9bpvE50wS4TZA/mzcFK0GpLPpj
 kPKlAUD/Giacz+c0sm6DbdP+pbV6ClWxH7VCHAmjBiOXifFz0MK5EycjLRl/HtuPxI+8
 88c1IsQU9CrxeC8NCrHKu3G/s2KW2aMN3LTaWs9JOhS02GFHN24X1dxaKyA3+Dp2f/ud
 E64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759608066; x=1760212866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dyUMAKAMMzxzjBFdIg7etB3CpnVzv30SqV4s7/yn2ic=;
 b=h+D9SGvw4WSU8y15S2EwjuKLSFD5oVVJPUbA78hd0XhsadNQncdFDvtfYxImZXmWhM
 N3Wn+wDg8S+FqTVWWODhBPsUm8+HJOEpXImuiTp9IdS9CkFM9hz/Apz+e8RnvH/U7aOd
 IcRQpFpoPuxV+9YH58m5Q6Hwu6G3p9YqxPBs1dqQvYfO2rsMaLZ/SDBUzKbKZGwSjVLW
 1zshDWlDta629tWytdcdfax+02Z6SfuAD0hLG5K1teRB+oR+1GKBedj2r2gkZp8GpNaR
 qGxwUS/rsleNCafRJWBI0/b4C52d4oslUAWANPckt2EJ9Zpgx5nhmAnqWdiuurjNjd1/
 AC+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWcB1DL2SqzL4UfpFuaJJz8AZmrjq06mYXWLkzVKPGvDlq88YFvf3oXDS88xuSaGvwK4WW4uTYVpi@nongnu.org
X-Gm-Message-State: AOJu0YwnE3eWoTQM5wMQVLiKiN0x01RKH0dkLqYjvcjsMVq2ShuH4Y5s
 wtQhQc+iqrddzMafYfgbXjiov1fkPQRDyEMu5EUIKYr2Y13t02fNKAI9
X-Gm-Gg: ASbGncupZniW5uwefvmYd1n39YcLkOpuk9t2+n88D5iNzHPwxjQ5MfVGN++2RqMzSTp
 TwwYM/qVEQlcsfJZUYSafXnHdcz7efd/ZPdeACl8nXMjXT3hg25J8Qfys1dfIaRVmx4fmRa++9k
 9P/uo9CrWyEAlivL5N6Nb9e+wbQ/OecF6Y5Jr9HNI4Q7LKCxpVa4RauEGuPOh2MXJTHfPa3TaK2
 HBOqX6xArPlm0qv7+u8tRZpq4QhW1mOhKmcF5LDcLxA3u3BbQebBV0yJ9CaLDlmJCEDHw+7b3lR
 fdGTxZjJubTssmliKLoZ0r5iEalk9VtE7g6aanrSRlFkKzcBmAUzzZ1U21XnlG3jXKxtClUtT8Z
 cT9v0iHjLfU+VU6z34x7DlARUxE5xH3y6DL59G2bIlgYG0M/2qY44KL8ApCXXRwZhxJQhwA==
X-Google-Smtp-Source: AGHT+IF4GLh/DEwGXvo9nnOljFzhXZzDwwKhHqMjw9WeWrpp+4F8ir1DPNGb4u+yhaR9ZykCQQqMsA==
X-Received: by 2002:a17:903:2f84:b0:27e:dc53:d239 with SMTP id
 d9443c01a7336-28e9a5f7230mr83878455ad.35.1759608066171; 
 Sat, 04 Oct 2025 13:01:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1260cfsm86141925ad.48.2025.10.04.13.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:01:05 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/4] microchip icicle: Enable PCS on Cadence Ethernet
Date: Sat,  4 Oct 2025 13:00:49 -0700
Message-ID: <20251004200049.871646-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251004200049.871646-1-linux@roeck-us.net>
References: <20251004200049.871646-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PCS needs to be enabled for SGMII to be supported by the Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 6e2a6e721b..5d3007e8d3 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -415,6 +415,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
     object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
     object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, errp);
+    object_property_set_bool(OBJECT(&s->gem0), "pcs-enabled", true, errp);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
@@ -426,6 +427,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
     object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
                              OBJECT(&s->gem0), errp);
+    object_property_set_bool(OBJECT(&s->gem1), "pcs-enabled", true, errp);
     sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
                     memmap[MICROCHIP_PFSOC_GEM1].base);
-- 
2.45.2


