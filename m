Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C11C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJY-0002Wn-Gz; Tue, 23 Jul 2024 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJP-0001ey-2H
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJN-0004QX-9B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36844375001so3393229f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767239; x=1722372039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McKHquff5/qMRalcyN7OIwCMwCYYM5fhTICEYe9ToHg=;
 b=Fzo+aERdpm7HcFj4Gd29zqVgcoYkCwGoOBa+Q0iGmgoC8mqWseAgeTaZU5NTdZg30o
 WPIIs7dXC39vFCKnJXoTcSoXaRdv2kuwnBzTzgw2swyUyKb55eIz1xN26na3VvPCIArV
 U56um/1BB76CISpzNuIRR+n5fYGacV1fAYxXDFDMCxul+2MF52cbm4l6Ytd2Trcn2ccS
 TYtKJUZPiKdI2tAQdzeeE5Q6n3E66dkUhhvldGPfNxs2+EVg1a/o9cKSrzu92f3bLZ5w
 V4v7rvvsg5jk5ub0r5mPJeIzR0kPX1ODOkcAF2dLgywd2hv+u8n9KPQt9eYu4kCPaYwN
 2jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767239; x=1722372039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McKHquff5/qMRalcyN7OIwCMwCYYM5fhTICEYe9ToHg=;
 b=vXehf20EcY3ejoV0Ei4GMMBfSKXF4AGLF/BHRFHMdOGPSzhZdRZmr3y39bs3lIwDGj
 Zk073w9VHDSjBdwKM8Zy3fNkz4B1tgv/S67z+roRBpewrR7jOtaaZh764bVBbWjh16Fu
 oxhVMqY5TXY/S8JrdvtiXT2Llm0CKfnFmKxGFykXwBJWlkBLkMinLYpUehbUOZDJqPEu
 L+vBqH+crm2BDQPHHr+JZHZexOVVQODQSmnopSmLz0I1R9Py6fYwSND93g0pmR8CZIVV
 sFuSKU1YJurTXEXt9NvGqpZanl6Gc1CFzfo/Vm6ZbzEy/2sZ6NgbuYW/GFiF7x6b4xZI
 QQwA==
X-Gm-Message-State: AOJu0YwwcEiaHKq9TVeD+nmKo4nCfAolbbuiwyh2MgL2Ogztx/pSW+e3
 FEq5NsxguG87AcIkPa+dMVr9QdmvkXhryAOtbt3sTyMAosS3h1+K3evjFroYXbmGZbhMohBneCJ
 vypE=
X-Google-Smtp-Source: AGHT+IHnk625/khGNvD1ccVYa/EYeq0wZHtqPBlRu5r5aTdSfBJWafRkUQ1h+3UZLC4HuSFHRGpYYg==
X-Received: by 2002:adf:9790:0:b0:367:909b:8281 with SMTP id
 ffacd0b85a97d-369f5b9ebdcmr19251f8f.59.1721767239488; 
 Tue, 23 Jul 2024 13:40:39 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868482esm12386768f8f.16.2024.07.23.13.40.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/28] hw/nubus/virtio-mmio: Fix missing ERRP_GUARD() in
 realize handler
Date: Tue, 23 Jul 2024 22:38:45 +0200
Message-ID: <20240723203855.65033-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

According to the comment in qapi/error.h, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

In nubus_virtio_mmio_realize(), @errp is dereferenced without
ERRP_GUARD().

Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
method - is never passed a null @errp argument, it should follow the
rules on @errp usage.  Add the ERRP_GUARD() there.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240723161802.1377985-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nubus/nubus-virtio-mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
index 58a63c84d0b..7a98731c451 100644
--- a/hw/nubus/nubus-virtio-mmio.c
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/nubus/nubus-virtio-mmio.h"
 
 
@@ -23,6 +24,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
 
 static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
     NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
     NubusDevice *nd = NUBUS_DEVICE(dev);
-- 
2.41.0


