Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561F1C982FE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ls2-0006Yg-Fp; Mon, 21 Sep 2026 17:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrz-0006Ww-DO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:15 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrx-0000P3-1M
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:15 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4885d4825adso625343f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027292; x=1790632092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mFfNlCTxXkztwKYCkDn6NKboOwUdQfG0bLFi45cKBWE=;
 b=d9jC9s1AJUVbCq2ZPQO4wB0As3g5gAABZHGcrNr57IWe9sYk9odKHSRmF1haiCdSy7
 q3HeCFjEcb11p5P33kywqXplfCtZsooMpyGn9S+lg+hzjEZrJ/6NgLEL+dsqYHG0o5wV
 UpnQ50+ptCvhN3VEbP1pia41LNl9DhFIQxL3A+pkA6dUVVGbBTO687KBMAAVF+zqFdML
 00OaRO1jZsW/6NHuTl8BVWhwqbsNTd94TFGnur7xbDPP0T4HWaTqSpifR8sLjHIdiD18
 behyaDA+SDsFm8b9t8AfW25r3t9LH7kkzagOuzvtGxsnJxVrHUPEj3D7r3BWlubHfGX1
 s8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027292; x=1790632092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mFfNlCTxXkztwKYCkDn6NKboOwUdQfG0bLFi45cKBWE=;
 b=qsZxWmhyE/gooLYVNGupC6ajsan2oXBsIxVEILAfS7/TGk9gRFYgtExBxh9VTGrVD1
 5fD38O25nGKP+jFFYVX7oZ7gzkDq61dLS5suSCWEWzL0GND48oiduQ0KDtHAahsQCoKW
 PCVvyZsivUq2WRYr4v9gn6gARdZH4y80WXtx0NpIR4wT3Jp/CSMSLwOkqfKxjIPAQwJD
 W+J/ARvWqvyrgTXBff6GrhXSUK7vEuJM5QtqWRKKbYXvK3vuWnbwm4JcTrOF4E0rh0F+
 7wcEckynrXqs9ts8+hnEShLYxSnfZydcBNB2PmHvL99MTz7B7fcjCOvzpTlh6WNRXflE
 EN5A==
X-Gm-Message-State: AFuF++kjiJ3tBZf6Ypny+eeE4VY9Uz0DFZZ+jYFiynKDV650oUoJ7oV8
 X9ZV2IreiAMs/XZ/8hz9nTMJf+kZB9aWHzATLo2SghFvMTpkNg5VMKGWc3yssA==
X-Gm-Gg: AYBFou2OG90Vbm9Q9r3aBEhmqFuG2D4BeWG59feSNr0wRYP/bt4fPMB6fF6GvZlWq8s
 7/7Rfws5h9j4H0uudken2eme6LoHigsfEp/K3/AjQ1qoPIF6BsFo+rEzMQSx90E5xBA23KCAtNN
 JfxqSpzKT0qd0T5zmZfYyUpJFW2MTVz2aGWRWL1BCOMbEw7sfXj2G60RbtpTeDng3uj6ZiFBZgz
 RskFPvkG3ADaM0p43e55NMCJCoBrZ21p7kd6DFjn6ajH0cEohSO0ZQzlhmG82BPjpJ33X7O3Ldi
 JJkShtLynJ3PNzPtiAiqFrbv94cSdhq7FGfu5HeqV/79p+7JCzJCOolq6Dbaxuhp1wLcWEuwGSC
 Go4Z/W3v+WgtqR34odZIGmdaLGz/A9NStDFn83YSKXFbq4bejDTsNtl2zQ7AgaPyoDchGehCM7R
 qi+ShGdI+WChR4lZEQY33v/IJPp/a8UzGtSs8FC+BWcuIulq+DQ1wZxYCstI2LKdtcEKOnMy2li
 KOYWCE1E8IhI3dZXHxHtTkwg0D1orFoRO1mQRizosFsijNCe3u0y6FAJX9OgboD1BJg3TKQPvAP
 w5A=
X-Received: by 2002:a05:600c:34d0:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49fc56ef520mr167751315e9.12.1790027291544; 
 Mon, 21 Sep 2026 14:48:11 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 33/42] hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency
Date: Mon, 21 Sep 2026 23:47:01 +0200
Message-ID: <20260921214710.29422-34-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The config option GPIO_PWR provides the "gpio-pwr" type which is
currently only used by the ARM virt machine. Remove this unused
dependency from config VMAPPLE.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/vmapple/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 2382b29767..b8aa7d8eb0 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -25,7 +25,6 @@ config VMAPPLE
     select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
-    select GPIO_PWR
     select PVPANIC_MMIO
     select VMAPPLE_AES
     select VMAPPLE_BDIF
-- 
2.55.0


