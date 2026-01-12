Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA81FC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJJj-0007ko-Hy; Mon, 12 Jan 2026 09:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJe-0007dD-9c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:46 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJb-0001Vf-Ne
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:45 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64fabaf9133so11764144a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229680; x=1768834480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/Bc8ruLWvUKFLbKbwJTV3mI2vIezZtb/awn2u9R0Sc=;
 b=Japl+Vg0wDdi7c/DAp76R/u2Z02OBRMDSSBoAMon+P55D1xxTlv97LfDDaKrVeszI7
 8pZTx6n9V29xq/2GP650ZyCT6/sDd2DNccMGsLVwgTviOSlE7K5YcQO0Os9eWIpdPU4x
 xfDo4Zh9OGwQC6EtrV5Odq2IZQ2/Ye19IJcdlcTTRpI8UZyBEsinsqWA4tML+T8Aq0QT
 kMRuiZmJJR1EfT9b917wh6Vne02IA/s0jhmEbDF74c4X92SRAeN++/iF74aq86fQkDoD
 1BdiG2HBKeFr8jthfSixexDWRjzHN3MiE7d5m7WFJqVNIVssR+VC7MQz57ZsVEzDVNdl
 MTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229680; x=1768834480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/Bc8ruLWvUKFLbKbwJTV3mI2vIezZtb/awn2u9R0Sc=;
 b=W7Ly2rwPlQagx7Cp1v9scyQ6sOf+zK2cKBU3gOAuls+03wB617W2PkD9fEnFT4FW+k
 Ooe+duvdxBlR4nhVELWemKAGkhjxtnLLqagFKTz+CBF//WW4PPv5aO3druntGs9t5zAH
 DexrIilK+nPZKbVBzBCJrzp2t0moMKqHfRWN4IelprtgwyFQRElGvRtteI6vIxOK9q6M
 JKt7KKk6t+uihNPEuhUOrAMMAlfRpx/rtHgidM2fu8sJvtBy+8xz6+OfadV2RxACadFw
 tZ1AWwpx1p3DtocOFsWe1mU9GaudPy0ZsKpSuNm3M4ibQwfK0g37RLq/MP3gRrDdpJ77
 J2aA==
X-Gm-Message-State: AOJu0YzN1v/L9o3KLjrYBDBAPBaWnx7YiwsJAzt+etByd59E0bNxno1q
 McLErB+J4IpD41/IpXXOTIebbffCnL5MUtUUfR5cvaiK35Y6793r2kFJvJdiQw==
X-Gm-Gg: AY/fxX5FVfRp8u9lq08p1ndGv0MhCOOWHB2WWv5Wh+e7uXGgihihM+DzgBENHRLjde8
 6w03yuv1/LUTRBZIK60nGAANdG9M6Ke0MSIGcYruxBNYH4finrMvaWEof+mdqUYkJ8UIn+sXGX4
 +dqY0NAm4dKsNTP1IfIcoisJXSKvZT87Ec1b1k4AEUWrHDZOxTCUTf9pb25N4VNNFggzrTbF+nM
 U1lcNH/CkGatAt9QTyu+aBKKiolenJxF3kmD0mYr4s9FuI4lrO6PG5mvmpQGja3eWupMyBu2hqn
 NJCGlXqI4/1QwaufXOtFNJEkRI5iBft5O8Um0Tr7AQQHoC1wfcu27bbOBsMOZnW2NR/+s7u/Sva
 8aSSSzZjY0vhzC3pRy69vwpVY5zSZY5+tprd15PLi+5RUqSf2lqe5EDHEi7KDtb7fsHkNjUYqjR
 TG2lrxPrumVhhFk1Qcgu62NUTb+5sgufX/Rh5OoTD+hrxVtYCXBquEGuzvcZOpSwRoWUu6jABG
X-Google-Smtp-Source: AGHT+IFiSdFwTXIhd5gYIuSg1GPgu2PpSZsMBZMIssC6s2idbJNbLr9CJghzMhIYm1T/jXyRlH/1IQ==
X-Received: by 2002:a17:907:689e:b0:b86:ef31:c2c7 with SMTP id
 a640c23a62f3a-b86ef31ccf3mr507569666b.42.1768229679538; 
 Mon, 12 Jan 2026 06:54:39 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:39 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 02/14] hw/arm/fsl-imx6: Remove now redundant setting of
 "sd-spec-version" property
Date: Mon, 12 Jan 2026 15:54:06 +0100
Message-ID: <20260112145418.220506-3-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that TYPE_IMX_USDHC sets this property internally it is not needed
on the SoC level any longer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f3aa1d8150..46967b7488 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -323,8 +323,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 3,
-                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
-- 
2.52.0


