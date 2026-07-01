Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D0BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevkE-0005oQ-Lt; Wed, 01 Jul 2026 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevju-0005a3-Mq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjs-0000Q6-IJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782915392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gEif2qYHepHJvdWURDByK6avdn/IZiDQubCf5GuVgc=;
 b=NDmKDrSonoEGiqAsHiydVSX2STPqrCESYtW9+5tLGRv19UP+kXhUfDvICn1clrL3PScgbV
 /qyhS9KhF0TUoy70S8M9CIT0+sFJGKifevqsdGEdThYALL85ZOadJBRDDfqLoeZRon92jn
 dGegzPmuQBK/o5aJWGvq3gP6cN2xIdc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-oDySWi9QPbi6CUNz0_Ne-w-1; Wed, 01 Jul 2026 10:16:30 -0400
X-MC-Unique: oDySWi9QPbi6CUNz0_Ne-w-1
X-Mimecast-MFC-AGG-ID: oDySWi9QPbi6CUNz0_Ne-w_1782915390
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso4927575e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782915389; x=1783520189; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5gEif2qYHepHJvdWURDByK6avdn/IZiDQubCf5GuVgc=;
 b=MV23XodCsEau3g4W9ez23CMgNEnKAoyrLmjtzaUiGcFrQes/rgfAIRKJmgsSB0/7EC
 2hSc3OIbzir6JWED0ofU3NvDteNdJIFIKbbEH0dFniG/Va1EItippVHC8OtlzL9UhD4J
 gZAnmJv5y5ySV5z7oP2oZo/rxLP2lWBGlOcuiu6pmAZU9kBSX2LeHpAlX5MP0XqOBbvp
 wHj2UFdjz3VPrAUrrrtLHsOCmEctnt0B1AoPXSbuoENs0DJVxkB4nUuS1LL9CQHGjCr0
 5W616tlokFmwGYlqLDmnZufjxzsgtZOblcDMACcbrIJwVGT4pL06Oi0Y9RR9SHr+TF8H
 /neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915389; x=1783520189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5gEif2qYHepHJvdWURDByK6avdn/IZiDQubCf5GuVgc=;
 b=ol+bnZZHXlYGKAl05AEdvb0X/8kwimQEtKEUVksoaZ6ecsWIlOQaKp3lAc8IK0SBXF
 XAaOwFKP6bbdgcSVVhjA+hJjpEvqt672Z8CCzk5yLFkqfxKdQii1ynJkCz4DgLW+CKf0
 zcmbkNLvbmtciwU7paVpc+mgU475LMFclJ2ZSmwwGVDMUPDA2fsYCEk6sz26cUt/55s+
 uFLqosrb6EWrgRBC+T1OzOi22UPLyrh6eCtuFawSz889lvxSAm5PWNdLcv9LYVC5ypAd
 zOTkoslzhlz8gW0lQd94USSPqVWd3H+BLVTiqB3l4z54+zsva5t2+Fp3hwPEzlnYdUDv
 R9lA==
X-Gm-Message-State: AOJu0YxHP4JQ/8kMauOkVc7um4s1EynwOGe/q7CszY7jbrXZgQX4trcz
 rVHQIVoi4vYTMd1TegD+PdsC/JC1fwZa6dyNQKujvMr0JVeR47JYJH8xJiJbiDDt7J37ZmfbQEU
 mgjay0VTP+QZ5EJoQaSBPqlBMhxdEmcFY8xhq80eIoKvRpIXTFMKlAFVD
X-Gm-Gg: AfdE7cnlqAR7JTOnUIcM+O04OP/GGNH9oHJPabuNsozTGZWxAQWGfazfaSrmJTfZBvJ
 sMD/dWpKovBmJ6I6m8rVGoHpGUrVd3b08/OWqxykilIwVhl03U2dYcVFv3APH7vRplt0Ynspf73
 K/kdwXuneVMaZHH6+jirZPv++iUostwBdEcFQ0AiErR8yNlRG89hTCsTrAE7VTWyi22byNxbjyw
 PfJUlcR55+8yZW5zbjrSP8z/orf+PjzEUa+xvR66LVkO1JQH6mdv2/JiKzzdW13cIQu1volXz8m
 uToLAUvAzTFhMd2ZlMcN+hOHMaBslTN8myzas8rHT3XE/ENoIfotAaiyhVCNcYGdQlrWhQPB8Km
 rQRDa0dX3GbKLuEdQuce4jI0T8kUSJQnUWaB9iJvWeA908kxElNqTYNkKdG4Cgl/I8WERdBLOLp
 dZvIQq
X-Received: by 2002:a7b:c00f:0:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-493c2b4b173mr23639315e9.12.1782915389503; 
 Wed, 01 Jul 2026 07:16:29 -0700 (PDT)
X-Received: by 2002:a7b:c00f:0:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-493c2b4b173mr23638575e9.12.1782915389013; 
 Wed, 01 Jul 2026 07:16:29 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm53283795e9.0.2026.07.01.07.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:16:26 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 01 Jul 2026 16:16:19 +0200
Subject: [PATCH 3/3] hw/i386/microvm: add uefi-vars-sysbus support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-microvm_uefi_var-v1-3-0652cae6a152@redhat.com>
References: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
In-Reply-To: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow the uefi-vars-sysbus device on microvm.

This is to support persistent UEFI variables on this architecture.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/i386/microvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d4836b5e12..44a5006b5a 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -55,6 +55,7 @@
 #include "elf.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/start_info.h"
+#include "hw/uefi/var-service-api.h"
 
 #define MICROVM_QBOOT_FILENAME "qboot.rom"
 #define MICROVM_BIOS_FILENAME  "bios-microvm.bin"
@@ -751,6 +752,7 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
         "Set off to disable adding virtio-mmio devices to the kernel cmdline");
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 
     compat_props_add(mc->compat_props, microvm_properties,
                      G_N_ELEMENTS(microvm_properties));

-- 
2.54.0


