Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C062EC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VNm-000363-7t; Thu, 03 Apr 2025 20:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0VNk-00033o-38
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:58:04 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0VNi-00066j-1M
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:58:03 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3feaedb4085so788784b6e.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743728280; x=1744333080;
 darn=nongnu.org; 
 h=content-disposition:mime-version:reply-to:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P+veuDLKnB9Y+XeDOwWyjxdGvtvgA1MZ/LGhVA6zY+k=;
 b=HB5Qw/mRyY/qAU4Yezs78yam9Ex1uZDRTZyFHhMDJ0Kfzyy26psVvgVIixKJUuV4Bw
 lCXxss2Yam89VOhPu3+coFlkfls7MBl70dDdMAmPiTR0axhyM1IfeVM4XcoiR8Lecbuc
 j6TD89U6ZAHXWFawYaToYOqI4daGnxyWx3u05hbQ9IVGtLVjn0kGMmT9rX4gkbh1nXfR
 +cBZc9003AJFLBW8z/tUXObdZgtOPhmdE1IWa7CwbUxPtXQJ0hicQzNMzEZpqb93uEo1
 Em94TkWYl2BMissxWPHhntsDwax/Nkc56GqX5spmydKHECt9ZqkWX9RY1G2V6u6i0BAU
 sNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728280; x=1744333080;
 h=content-disposition:mime-version:reply-to:message-id:subject:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+veuDLKnB9Y+XeDOwWyjxdGvtvgA1MZ/LGhVA6zY+k=;
 b=tPA1tUyUfEtCOpHBzI/NYoGpj/U0usUOMA5ofTZNZ8lybRbPk8z9wsyJOKcdokANoC
 JPBCx599tk8xubDKN3g0TRWUEAAwm9sujrUqvg0jc6GurIGXHXHr2Z1OcFGNM20do6H2
 YJ9qKM4Pp7lACblirENIDAaOT3LFuDV8beF/cELjr5mXJgyeMrbwwt5vuHr58RguB3ma
 jYudtNFjpuW7/ynZ5LvGWLKsZgJjr0wSDA/A6DKXLsRcb1sT/G7CzA1AGLEVKf6aNNC9
 YJ9McNhv/UWQny4rI7CoPKm6yeAczgiqkDk9YJ5RgjbUURJ67kb3M0X1JP7R5OxxUwGJ
 fm5Q==
X-Gm-Message-State: AOJu0Yw9vas+Oa6MOI89kGqNNB3C6o0Iv7ULvUsIxC/Rvz+IK+vNuijj
 JLQx1eeIZw7kyxTJye/zQkVg/bpeb2ejhPDIVEgeOcEuSh1Z4AE4uuoe8L8SjPOMg2KlC/Ir7lN
 i
X-Gm-Gg: ASbGncuxXZmp3QuI68wSpLY0wfKwyNhNgBWwwIMgH35d1CDyrAa8ODQ3I0SFzbLQ4Bc
 fUKRb4vXVGcT+AEcdooY6Y6yp17YflYp7EsS/JzbEr3zX80696raunb8toySiJ7SrLBajeelaLg
 u4iciV9OZIR/QSmwlwYdMD/3H1tJ3OtR0D03g7PXTiu0gkXbzBPV6UuW+f3+wB1wjnfo+EwwGWY
 qeT1lN9ltRH/mz6hRMwht961xRJMop/3oUXIX2+c9CmyAMB0IiDdKz0UcR3FE3x7AOkiTs7OuGk
 eaKn57OG1OEplZm3n6Z3BZHbombD8Ha4vJeT5kH1mO8fz1xH
X-Google-Smtp-Source: AGHT+IGrpoAPFYejFfXQHnGfom3OZ19uM1Es3r++4DlVSaL9pzYkEch/jMmDDGLRgvXQhbSIWoEclQ==
X-Received: by 2002:a05:6808:80c6:b0:3f4:1b67:f074 with SMTP id
 5614622812f47-4004558f006mr919698b6e.7.1743728279447; 
 Thu, 03 Apr 2025 17:57:59 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5413:2ba6:c80b:5b46])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff9d849sm419921b6e.29.2025.04.03.17.57.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 17:57:57 -0700 (PDT)
Date: Thu, 3 Apr 2025 19:57:49 -0500
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ipmi: Allow multiple BMC instances
Message-ID: <Z-8ujYWA8yBATtYK@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=corey@minyard.net; helo=mail-oi1-x22c.google.com
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow a system to have multiple BMC connections to the same BMC and
multiple different BMCs.  This can happen on real systems, and is
useful for testing the IPMI driver on Linux.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
I'm working on a fairly extensive test suite for IPMI, the Linux
driver and qemu, and this is necessary for some driver tests.

 hw/ipmi/ipmi.c            | 1 +
 hw/ipmi/ipmi_bmc_extern.c | 5 +++--
 hw/ipmi/ipmi_bmc_sim.c    | 2 +-
 include/hw/ipmi/ipmi.h    | 1 +
 qemu-options.hx           | 9 ++++++++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index fdeaa5269f..ffd972f78b 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -110,6 +110,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
 
 static const Property ipmi_bmc_properties[] = {
     DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
+    DEFINE_PROP_UINT8("instance",    IPMIBmc, instance, 0),
 };
 
 static void bmc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index d015500254..11c28d03ab 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -488,7 +488,8 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
 
 static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
 {
-    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
+    IPMIBmc *b = IPMI_BMC(dev);
+    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(b);
 
     if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
         error_setg(errp, "IPMI external bmc requires chardev attribute");
@@ -498,7 +499,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
                              chr_event, NULL, ibe, NULL, true);
 
-    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
+    vmstate_register(NULL, b->instance, &vmstate_ipmi_bmc_extern, ibe);
 }
 
 static void ipmi_bmc_extern_init(Object *obj)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac7120..c1b39dbdc5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
 
     ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
 
-    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
+    vmstate_register(NULL, b->instance, &vmstate_ipmi_sim, ibs);
 }
 
 static const Property ipmi_sim_properties[] = {
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 77a7213ed9..4436d70842 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -183,6 +183,7 @@ struct IPMIBmc {
     DeviceState parent;
 
     uint8_t slave_addr;
+    uint8_t instance;
 
     IPMIInterface *intf;
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..186433ac13 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1120,6 +1120,10 @@ SRST
     ``slave_addr=val``
         Define slave address to use for the BMC. The default is 0x20.
 
+    ``instance=val``
+        For more than one BMC on the same system, each instance needs
+	a unique number.  The default is 0.
+
     ``sdrfile=file``
         file containing raw Sensor Data Records (SDR) data. The default
         is none.
@@ -1137,7 +1141,7 @@ SRST
         is set, get "Get GUID" command to the BMC will return it.
         Otherwise "Get GUID" will return an error.
 
-``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
+``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val][,instance=id]``
     Add a connection to an external IPMI BMC simulator. Instead of
     locally emulating the BMC like the above item, instead connect to an
     external entity that provides the IPMI services.
@@ -1151,6 +1155,9 @@ SRST
     simulator running on a secure port on localhost, so neither the
     simulator nor QEMU is exposed to any outside network.
 
+    You can have more than one external BMC connection with this, but
+    you must set a unique instance for each BMC.
+
     See the "lanserv/README.vm" file in the OpenIPMI library for more
     details on the external interface.
 
-- 
2.43.0


