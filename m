Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC3EC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkD-0003H9-Ps; Wed, 15 Jan 2025 18:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkB-0003G8-U3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:15 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkA-0003y0-4n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:15 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862d161947so171551f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983452; x=1737588252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdD9bi6uaCwY/ZRVzob+rztBkSJoCnjaJvN09ChGPpM=;
 b=Lc1cC0hlDQs5NTCY/wUYf8gzqpUdnyu+XtTv83By4FIN8qP+4UyBH0kjkWJfIQUe72
 k09QVwUeXYaEgQ4gPaDC7m0JP6FVZMT/kkH0HH7dn8hy+Rr0beURrj7U07fK31BzywBp
 dehZE5rLtOi10sceTHHppGWKWoWT80ZDb32EfCKFtuCfVSvfBxh9mMvB46hLXSmC6jfY
 jrEAOHo2fstoZmShnZ2C7zZa+0gUBtsYuNFX29REY0VGWmwNtFQjIK5dFwVfECDGrXYT
 q31DxCNeuF03NjCPbV1jc1qLwBfUTC89SzLE1SffxFY71KX4GYJ49O9eEQLzURKFtr2J
 wnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983452; x=1737588252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdD9bi6uaCwY/ZRVzob+rztBkSJoCnjaJvN09ChGPpM=;
 b=mNQ8XySCF+TNSZSRhGO1Qu+B7+LP4Vvyigy98ehyPya4hCLgsEKu3K4NYSwl+Oh71c
 EXSMmEMKynJ+VwQVPNvEX9nNWIgAZqTWmf2t+Qg2mZvx12Jz48147SPUhLl7ZSlGTJo7
 P6rnc/axJ30LfWtSGSUEEJPs5glgMgRjA/5pSV2lAm1/W3Nj4poAnpoI7HnrvlkixZ3m
 11rmSh47NwoAXBA7LEJuUF6Rf8HAHl+LuUvwZuxsGGnwRlUazumaj2e9Ouhl0Rhd7oXc
 aEtCj3Nl0RYLHAiBrheiSEXbuc3PEoTjqUlODmYFU61ByzfOKhmK8tUxxylqJcYrbiAu
 DgFw==
X-Gm-Message-State: AOJu0YxP+yYyZDGXyoZKLbiDQV20HugUeOI2RabvJb2MfsaWNPewJjwZ
 upCX3vWzsTFCtxDOAjRDMZyjHgPJrUlMOmsOqEbDdF1l0TYVH7W8wewp9SE0ZqOx33UeiFBHom+
 w1s4=
X-Gm-Gg: ASbGncsl3zj77mcGK4FR+g98aSD2/SHjdBbAKURqyKcAuBBljRrzm3e5KdozYBCS7X2
 ZESJalC3ES0eHG+zd/CaZbifC+Xve1esHrbS25WZ0YdNYxWtKr1ORMVCxe8/CwZZMDUJ9RE2Dz5
 QbuSX+KR6jcL/cZEMH2evh4q5L8DW9PUuUKw8fW27BJPyajdYgIvdV9r5kyoBwSfA/H68sheklu
 JS+y/S44nUcnMkyv+vl1n9WLuKXt2aPXZP966gORd9nqduE3tK+dK1S3BFtdav/w8ffEJ6SghZF
 9HEO4PHnSjSxH2KszuxdZrgec1VWJWo=
X-Google-Smtp-Source: AGHT+IG5ZPcTJ/butZ1Q1KFL4i/I0LtLLg/PQo8EuOK4+jrDnkdhxoim9QJ3Mqyi9C1hmKjZYbuuxg==
X-Received: by 2002:a5d:6d8e:0:b0:38a:88be:bcb4 with SMTP id
 ffacd0b85a97d-38a88bebd23mr26128923f8f.29.1736983452255; 
 Wed, 15 Jan 2025 15:24:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38d008sm19327110f8f.59.2025.01.15.15.24.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 15/21] hw/block/fdc-isa: Remove 'fallback' property
Date: Thu, 16 Jan 2025 00:22:41 +0100
Message-ID: <20250115232247.30364-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 hw/block/fdc-isa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index a10c24aab10..9e99a183c1d 100644
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
 
 static void isabus_fdc_class_init(ObjectClass *klass, void *data)
-- 
2.47.1


