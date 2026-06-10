Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3E5CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFtx-0006nl-J6; Wed, 10 Jun 2026 06:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtv-0006nW-UP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtu-0003cg-GZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yQe8jFKNGhwF30/jRqb6yS5MUXJwqT1DKhcvbjgJxw=;
 b=AMVaQrII628eVt5SlIBknigEV5eUmyoddPTFvCxpZKOamxRuq+6R7URemlBNEbtisKhk54
 Za/Mry5E6FIQXVCciXeTnX7FugltYWmy91708GgJxmoPkjwjF/9Vg0BHp6zWOWFn2WQ95S
 Iq/MlvQcnLRXduPd8psEHHPtMW6yyEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-aPDU4EdsO2GWRGkuXqW6tA-1; Wed, 10 Jun 2026 06:11:08 -0400
X-MC-Unique: aPDU4EdsO2GWRGkuXqW6tA-1
X-Mimecast-MFC-AGG-ID: aPDU4EdsO2GWRGkuXqW6tA_1781086267
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef66cc579so2755169f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781086267; x=1781691067; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2yQe8jFKNGhwF30/jRqb6yS5MUXJwqT1DKhcvbjgJxw=;
 b=jgfUV5WxUom4M2PF2RiHXpuJVpq1RX8T4L8RmNKwIipDXK+FgCiPfhY7KETPf3Fz1D
 BSgEbQHOaWgkxIQUjOqzd+uZxNTKNG/MP6BjHMM7lHBGl/hVXPzNCsMsH691ZnFoAljR
 UUcSXWw/Dem/ysImHEB/ZqED0YXZl9TkHTfENe+r+UiMfhGhcG/f/aphRwKK0l98BXvl
 Vs+lRvod4fib2Xlb4nQqH3PAJV2Xibv+5Ae3AiU3Wfj8XA0ihXp216d8BNL1W5dvCq+y
 wH28yJjrfcFq+uF5xmRdaQ5vvkD5gSor9qU9Yz0gB75eYWADiRvx1VdO6XH7ndsj5V6j
 qVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086267; x=1781691067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2yQe8jFKNGhwF30/jRqb6yS5MUXJwqT1DKhcvbjgJxw=;
 b=Gj5IUsCx5ArhjQJRkPq9N7kNsGSl7973ZKGWK2SLtInl34qnlG/flDWIkxVvaq4eP6
 kpaCyJSHlffOUrsTq2dGIMtjRoB6gXpIiR3d5uEFL1UeMlWSXtbS0719z7cVY8/LSr2c
 eo5D+ZuoHt0h9ail6LqMIJnentfBgPt8XoYAZD7MXuSPmhevMAXQiwQG7jQKFYluvOpc
 flLZInITnsZBhzLA7t2aRThyumvGMwox2jVMl+PXw/GiswsaFxKjYpu8XhiM5WUfALlY
 2OOspu3C0h0+L3mztS3k0vrX/rFbRfFDZM78CY54CRIUry8SdkIxaeKeSuFNlgSqcIgM
 TlNg==
X-Gm-Message-State: AOJu0YyeYJOwowt/IMWPVPhV258TdXXImcAZC3QCzPCgjCLYB51inWHO
 HXHbKD2utIPYEnQUDO1/ISxBG1+XA2NZvKKA0mFflih6xRVLSjj7L6Qc6fxS5nNLTxNn6J8cyYN
 HJ3b4gHaOExzGH5gtXBXzHXlAUON21MmddG6swI3I4RYtdG9T5FrOuaUG
X-Gm-Gg: Acq92OEns8SJNuLYJatjqsMoCwzksIdb8HIbmEgbdG1nT38qX8jglH+vNYaCycEGaa3
 IncjpBQtwrGeFhpjvib1cMcK+vXti2a0yd758V1UYsG2pMrvtS96oy6Lt2OMG4S0F0A3aFuWkGx
 00dkk9xzU/0w743hgIlyBX/h+k3rxBDFlEme2ze1BN4YuXFEWrGbqgYgh7RQ7FocDcMK+gw/SJS
 Lb5vk8MRoHZqyaVJO+CJn0PIgXfwU3SASDOdGjtutbB7neRSr8Zyh5C3qgymHDAv7JCfDOZ2zYl
 aHnfbKbtkkewYP4KU4KzSaJe+7EGkLuOYUQv9ri1agXyYw2NSZo+btxvWhU1C5gknLi1fbGN0SY
 3BkHjKwgHeW3pgICiJ5Fg6GEOmRRsEhwh2OU27lNHJjSzQcwzPqa3z9i+K6n2LHzPp20DgqLR5s
 M9yq49qH1J1U+f7Ln+zNXmXCVYWhw=
X-Received: by 2002:a05:6000:41d5:b0:460:3210:b6e9 with SMTP id
 ffacd0b85a97d-4603210b750mr37873316f8f.41.1781086267502; 
 Wed, 10 Jun 2026 03:11:07 -0700 (PDT)
X-Received: by 2002:a05:6000:41d5:b0:460:3210:b6e9 with SMTP id
 ffacd0b85a97d-4603210b750mr37873289f8f.41.1781086267155; 
 Wed, 10 Jun 2026 03:11:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm73334514f8f.4.2026.06.10.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:11:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 10 Jun 2026 12:10:57 +0200
Subject: [PATCH v2 1/2] hw/i386/microvm: pack device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-microvm_device_tree-v2-1-4fb44730c49f@redhat.com>
References: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
In-Reply-To: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After the device tree is generated, it can be packed, significantly reducing
its size. This is particularly important with the upcoming support for
the device tree via IGVM, which can have stricter memory constraints.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/i386/microvm-dt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index 45fbb5bbd1..14de1312b7 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -43,6 +43,8 @@
 
 #include "microvm-dt.h"
 
+#include <libfdt.h>
+
 static bool debug;
 
 static void dt_add_microvm_irq(MicrovmMachineState *mms,
@@ -326,6 +328,7 @@ void dt_setup_microvm(MicrovmMachineState *mms)
     X86MachineState *x86ms = X86_MACHINE(mms);
     MachineState *ms = MACHINE(mms);
     int size = 0;
+    int ret;
 
     ms->fdt = create_device_tree(&size);
 
@@ -337,6 +340,12 @@ void dt_setup_microvm(MicrovmMachineState *mms)
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
     dt_setup_sys_bus(mms);
 
+    ret = fdt_pack(ms->fdt);
+    /* Should only fail if we've built a corrupted tree */
+    g_assert(ret == 0);
+
+    size = fdt_totalsize(ms->fdt);
+
     /* add to fw_cfg */
     if (debug) {
         fprintf(stderr, "%s: add etc/fdt to fw_cfg\n", __func__);
@@ -349,7 +358,7 @@ void dt_setup_microvm(MicrovmMachineState *mms)
             fprintf(stderr, "%s: writing microvm.fdt failed\n", __func__);
             return;
         }
-        int ret = system("dtc -I dtb -O dts microvm.fdt");
+        ret = system("dtc -I dtb -O dts microvm.fdt");
         if (ret != 0) {
             fprintf(stderr, "%s: oops, dtc not installed?\n", __func__);
         }

-- 
2.54.0


