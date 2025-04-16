Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B3FC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiH-00041X-9l; Wed, 16 Apr 2025 20:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiF-00040h-Vn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:40 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiD-0006Or-VR
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:39 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c3b863b8eso121111a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848152; x=1745452952;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49avEtiZIVlE7rTwMZWJA3fLdy8rYAc28zmvPcaf/6w=;
 b=AwOiw8YNN5X8my3zMtsrrd+anpWT7JQ5Yjikj/ObAjHulfj4B9x5q/mKCio0ifjBsv
 8i0yyRQG7maUB+QdVHO1lmIUIc3pnSou5+jeu5CFTj8k9y9S+R2hUS6BbnooAf1yDrg2
 HDuRrjRoIO0vBpmZyOtrIHu5dbuchLQxjwcnAtaEhJE0msb3BBcwAhjwpYLBkQYxZMAU
 qJFnWEBHfzlEViK/RPezwajROVlpNj0A+eUQjn3tJtfyBdJANzqK0r8OgbzHlIqmBobI
 lIM8mYgy3GzzWCs2U6X8529sI4Qh9OCtbiiLYdmY5du0HUbRMkiKJQjXIQ8mf6cAVcgf
 cBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848152; x=1745452952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49avEtiZIVlE7rTwMZWJA3fLdy8rYAc28zmvPcaf/6w=;
 b=CenCnNdgXjpHDvEKq3MeOdro1OmSoW+Zo2UMNq9zGAK81I2JVi7dc1HCums3LH7Jk7
 c27FfZ2OfTbjrytMZsPf/zso142nRJhZe3adTIBYyojdS5JkSuP4Az3nc8F7koltlxrj
 Xsqy4iQBnNvqXssraITkkG5wYW65EANt2JQX9U6wHteiSRf9j3lpJfwasW+1CQ6DeDeh
 nArXysJXowxL5I6u1jdVH9CWKsmhtp+9OkHRriwb893z6nUokTqazZJsF+TeQ47JRSoj
 D6akHGy97uE0/1pIhizMA1hHspWtkpa8JjOrNkLJc39Nppkh7FB+rTf0ssX58cei1k2y
 vPjw==
X-Gm-Message-State: AOJu0Yx/c590RteNQI5miMr25YbC4Wz0zBDQYA1yFQmq3Dwv2/fFQDJn
 at1ZL34lD9K7P533jvaSGXIq++z8d55kyK81yN1IzkQbNQAuVSpgbIyMyHiz/Sp6pes6KeQWUDl
 v
X-Gm-Gg: ASbGncslENo6rT3x2jDSmK5EnwCHxYdPyFAtysd7uh3l+7Lm/4OVRMCMf6m7JdBh4PC
 B7Ff/qQIXM3pAxHmFbs2SfOaCNZvDYOwfXXtQ+CuRbu3mdi5EdtgPLPGQW8UoMu5PNLN5Hyk/MX
 B+ZWgsdUDVlPjKwOy2xmy3DnKuXHLsmdJE+xVK+adqBt23lDIWl6cSiiKggx6geHrrbZTrnwNqY
 U7291WAQqovMSLPRsg9EDfSUQKDqzy9UzyHolwjvB0EN2mSml6Nw0AbPXw6mDHZlbtxA82PKa51
 N73GG8SLdU0e8PYRMo1/EErrQW0kBdxUphQ=
X-Google-Smtp-Source: AGHT+IE9xZ44XXptAnG9EIXn01uqmprDVkzfH0o9US0W+qTgZW62LurG/Ok+6tGwSv7Ig6PZolsrRw==
X-Received: by 2002:a05:6830:6288:b0:72c:32a7:8830 with SMTP id
 46e09a7af769-72ec6d2735cmr2481008a34.26.1744848152335; 
 Wed, 16 Apr 2025 17:02:32 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-2d096cdadd3sm3576836fac.32.2025.04.16.17.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:30 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <corey@minyard.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 1/6] hw/ipmi: Move vmsd registration to device class
Date: Wed, 16 Apr 2025 18:59:05 -0500
Message-ID: <20250417000224.3830705-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=corey@minyard.net; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It's the right way to do it now, and it handles multiple instances
properly.  I need multiple instances for some testing I'm doing so this
is the right thing to do.

Tested by doing:

   (qemu) migrate -d exec:cat>filen.mig

before and after the fix, then:

   scripts/analyze-migration.py -d desc -f file1.mig >file1.json
   scripts/analyze-migration.py -d desc -f file2.mig >file2.json
   diff file1.json file2.json

with no differences.

Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 hw/ipmi/ipmi_bmc_extern.c |  3 +--
 hw/ipmi/ipmi_bmc_sim.c    |  3 +--
 hw/ipmi/isa_ipmi_bt.c     |  3 +--
 hw/ipmi/isa_ipmi_kcs.c    | 12 +++++-------
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index d015500254..3e9f8c5a50 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -497,8 +497,6 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
 
     qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
                              chr_event, NULL, ibe, NULL, true);
-
-    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
 }
 
 static void ipmi_bmc_extern_init(Object *obj)
@@ -528,6 +526,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
     bk->handle_reset = ipmi_bmc_extern_handle_reset;
     dc->hotpluggable = false;
     dc->realize = ipmi_bmc_extern_realize;
+    dc->vmsd = &vmstate_ipmi_bmc_extern;
     device_class_set_props(dc, ipmi_bmc_extern_properties);
 }
 
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac7120..bc0ddc52a9 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2187,8 +2187,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     register_cmds(ibs);
 
     ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
-
-    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
 }
 
 static const Property ipmi_sim_properties[] = {
@@ -2212,6 +2210,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, void *data)
 
     dc->hotpluggable = false;
     dc->realize = ipmi_sim_realize;
+    dc->vmsd = &vmstate_ipmi_sim;
     device_class_set_props(dc, ipmi_sim_properties);
     bk->handle_command = ipmi_sim_handle_command;
 }
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a1b66d5ee8..474a792c9a 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -117,8 +117,6 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_length);
 
     isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
-
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, dev);
 }
 
 static void isa_ipmi_bt_init(Object *obj)
@@ -147,6 +145,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
 
     dc->realize = isa_ipmi_bt_realize;
+    dc->vmsd = &vmstate_ISAIPMIBTDevice;
     device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_bt_get_backend_data;
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d9ebdd5371..94bbe45d35 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -72,6 +72,10 @@ static bool vmstate_kcs_before_version2(void *opaque, int version)
     return version <= 1;
 }
 
+/*
+ * Version 1 had an incorrect name, it clashed with the BT IPMI
+ * device, so receive it, but transmit a different version.
+ */
 static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 2,
@@ -119,13 +123,6 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
 
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
-
-    /*
-     * Version 1 had an incorrect name, it clashed with the BT
-     * IPMI device, so receive it, but transmit a different
-     * version.
-     */
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
 static void isa_ipmi_kcs_init(Object *obj)
@@ -154,6 +151,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
 
     dc->realize = ipmi_isa_realize;
+    dc->vmsd = &vmstate_ISAIPMIKCSDevice;
     device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_kcs_get_backend_data;
-- 
2.43.0


