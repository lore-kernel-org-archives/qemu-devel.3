Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927F8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWG-00055y-Ui; Tue, 06 May 2025 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSz-0007xX-C8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSw-0001oy-5A
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so48944035e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542412; x=1747147212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjm2NV3MsVuXzERs7qPetKCBg7pCwU7Ow/3BPmE8MOo=;
 b=Xjk62Jlp3DqNNz9afNzwHvDaDwml0+amNkLC3zIG4jWdlEC4xNIKOurZ5vlgdCUkgf
 mMSWARf8az2VDI41p0Kw9ltonkIOlst/SjTCjHnLtWSdiAMZ0A/6JpgsSTKzEYB5D5Fu
 u5asibyvdd9xVCYKzcQ8MbUQDprXMtn6z+K9muBspyuaO6OviRYbh0pL+9XbTNPKwNP/
 yNsR3Pv7piMJYHFnM+dgfJLumTcrNqQePvJOTwTGGmqSkS1DGAh2/doeNL+ylA1Ht78R
 HxE2g6FO6xTLkKi78HLH73UIhTUhA+937lbc4MHGU3idliIEIpHEasq1LeLn3e6IdvRO
 3APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542412; x=1747147212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjm2NV3MsVuXzERs7qPetKCBg7pCwU7Ow/3BPmE8MOo=;
 b=Pu+0X+7b6qj2bxiaQEwaFB/60qm4xbsiKxfulTX+2FlHGpm39Vrbg3SJU2QPeeqHIS
 oSxrNyRjKw6n6pcFP5KnYZ17Gbh9v9klNiakTfKBj6L7NB0kbmU6t2jQpDy1DIDlLo6u
 jmirXprlxPoqPvliijHVLdbya+VEcUFRZIwLHaxgak3dZPHAMJpynq9YAxc0VPYaEACt
 V6yimrGJpLGhL3JqSfqW5S1Mb7l7CUnFLDzlfTtNIkHEQ/wQiOXghgT2hdNX6v936vBl
 ySCO16RNSiPCSOw3zbohtWA6vJDMiFxz8yJgQZY7ZDX5OmUv4e9Uq7WUixSd+qe7LsJI
 D6aA==
X-Gm-Message-State: AOJu0YwI0XwjVLKW2YrAmCDpSnHDcMN9R3YulZ/38AZyDspXeqFzoxeo
 e1ywCjCYBmserNX4KKsekN6JClDE9blEU9uWm8DSoBet9p7hlEtJ643/tkbH54Xi0y8cde0DDPx
 W
X-Gm-Gg: ASbGnctvAuKkDU0mipHyUG7czgjXSrbiWcufmmx1Vx7h9j5piz7vrTHrkcVllmXK2aF
 Y6WudbOIZxlBaSr5yGYK9jYcfhHUyGXFoKpfJzaPw9cbAEDi8O8obKPk4m3dBKFLP/k55fnU00R
 djK+K6LwJjt9irWTzrl+SjFH8kFmXdH4e7Kk/v2ZVthFGmzvafT4ZWn9uWljsUGAI+Hf/qL6QlZ
 Go0OTLocVi6a59kYW11S/KaTvu4Lyqnc6yYUmkATf+V5v0LnSp1h1foaMEjE79Iv8cXrADBNzZH
 8LDr45VGuWjXFqSKzkGVtoViP9ODHmXrdMX2qLqe7TBSsCPh/jIJ4e1qvuCEIMo2X6UVZ+AKcC9
 qKPXaHz8qUZSeLvdcprbf
X-Google-Smtp-Source: AGHT+IFfW5Wf4GJ7c+jOUtNj3caz1pDTdwGoQd9yyE/c8rQULGOIrDYd+PbbAFh6yKmLXTvh+8fOkg==
X-Received: by 2002:a05:600c:35cb:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-441d0524b5bmr36344135e9.17.1746542412050; 
 Tue, 06 May 2025 07:40:12 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d2f28628sm4871995e9.3.2025.05.06.07.40.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 13/19] hw/block/fdc-isa: Remove 'fallback' property
Date: Tue,  6 May 2025 16:38:59 +0200
Message-ID: <20250506143905.4961-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The "fallback" property was only used by the hw_compat_2_5[] array,
as 'fallback=144'. We removed all machines using that array, lets
remove ISA floppy drive 'fallback' property, manually setting the
default value in isabus_fdc_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/fdc-isa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 6d1790e0e61..090b91361cd 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -112,6 +112,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
+    qdev_prop_set_enum(dev, "fallback", FLOPPY_DRIVE_TYPE_288);
 
     fdctrl_realize_common(dev, fdctrl, &err);
     if (err != NULL) {
@@ -293,9 +294,6 @@ static const Property isa_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1].type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
 };
 
 static void isabus_fdc_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


