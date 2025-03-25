Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29B7C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0Y-0002ez-QX; Tue, 25 Mar 2025 18:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0U-0002PB-HJ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0Q-00077Y-PC
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so37139035e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942661; x=1743547461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JG2VRaJptEB9qSuT5SVsGGWb28vBDAuwNTjCKkTxX/4=;
 b=xlUEOtqY8RK6YPCJV1+iwe/3bkff9SZG0CsThUBTOvg8AtaBTIbgVvE8I84ud65paC
 7zBx84S9/1QWFIDETVsX3JZJqrBALXHy8XQCScX93G2v0vw3UfQYBFI3hSLHB0s3Qf18
 yvd+3Jd871DT9VcdUZZfmPo/tx4CLtTophl6P+/20LYm3RKi+cclhRyZ7PB4a7iey55k
 dO83alSyFd9Wx4TxV36UsT71rc5u2EV7bZoqJUgq5yvnM5leWDFSvGnH4RtIK2swoqu/
 b6CfhhfiRGr+mFFGOEP/cPNkpWFbGgrFemoN2ll9PrMtOrnPdGFkZJwt7LTpx1nVysqV
 xJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942661; x=1743547461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JG2VRaJptEB9qSuT5SVsGGWb28vBDAuwNTjCKkTxX/4=;
 b=u5E2ENODNYMu18Xi02Y6GRJJIFE6bEgm4JUKynkCY/9cOx5JC/E77Brxt8OUulCH+2
 iQcwGtLSIXI0i65/eNhZhOWvxBSzcIALDxMFkj78ER7vtM276lFZ9KoUL2Q6+flfDeLG
 j5CjE6vtuvLjyJpKqXgFD+Q5lArknljRW006ZJYcneTOOSuex4wfI8OsMvb1yqYwwb19
 KpCKkss2Le0X/9aa+E2SFFM3CqMwOQe8uyex0CohA1BusNuuI8GLV1bplEGbg4g24X0i
 CMusv3MP1t03imuUbY8aKq0zuTrYOTdCGPHv0V2m/yRpVA+GHp6p0aFUmovwN6Z9YvGt
 yLpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA+BRlCu/7RYK6V1sVcR8pF1gH/vq8fFoIZ4lQNeuWKEqMfvUzeY1VUOTzUCw7im/snZDfE/XTr4Ub@nongnu.org
X-Gm-Message-State: AOJu0YxA5tNb8iaSQ229+RIaSS7MiteU8C9uhrMxFQJPAmxso5fiJWed
 ZzpUIxDPgB6infuv1FVATqH9k0M6SzAaMBaWxlExhKEhr9BYZqrMiNhSE3yTgRo=
X-Gm-Gg: ASbGncvc4NGBmpf+v2iIaGZ5q01OHgIJniN2jGDS7dznlUTpXhicDtx4HrunD9sMCRB
 TIzw6lHuc+bfbiSp48LSlvjsbDCRPdw600is5KMNoY3qNwOJ5Ok3p6BUqHBr6IFTeuHhzKp7L+J
 WdkqV6sLxrELpw4TDLmb74Hz2VqGY0txblYhzaCIZqrKppkGYxO9+lbXiIbRaek5hwj7JlvXmFJ
 ONJITa1CkFtgPDaiMl3GamUA/QRyI13fCXCha2TGWHfjum1cRD5YGku+Wke4k26j6acoYx+EAU9
 EAYo+z4+fxSNP71bX/3gd6kf7G2xukgqeSIn+IECBAbNWCrWKgb1NT5C6GZk61pZPLOmBr2xh3b
 6aaW6ax2+ej3D7DXFyfU=
X-Google-Smtp-Source: AGHT+IHtCqqvEbiZkF49JQUKYCyK1lGiUAwYYACnRUKAwCWdLsBh+wdAaKzPxqdwJWLSGFThr3AZgg==
X-Received: by 2002:a05:600c:1989:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43d508725ecmr163452165e9.0.1742942661253; 
 Tue, 25 Mar 2025 15:44:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea6ecsm164303625e9.5.2025.03.25.15.44.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:44:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [RFC PATCH-for-10.0 12/12] hw/s390x/zpci: Re-categorize as BRIDGE
Date: Tue, 25 Mar 2025 23:43:10 +0100
Message-ID: <20250325224310.8785-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

A 'zpci' device encapsulate a PCI device to be usable
by System/Z. Categorize it as bridge.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2591ee49c11..dbfe24f6eca 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1562,7 +1562,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "zpci device";
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, s390_pci_device_reset);
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
-- 
2.47.1


