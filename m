Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616F7CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDN-0008LI-TJ; Sun, 14 Jun 2026 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD0-0007Yi-M3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCz-0002df-4n
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYJL+moHp7Nhp/WdZk9yxo8Dl31jRMqPIYW7M964RY=;
 b=MU7J8ELTXLXrhwHnAHJedw94mlbWuvfS8VtcNRwnyJuGKLGRL6kTf6V7sDX79WGMX9gY3z
 ULnuteE2RWvwKMMf0vCpZ3T7kQnBBZctK4q01RDnTTpFOFuORwhU8whZgsxq6kyEL3yMIv
 hiLxE/Mc8PZuHP2aVhFzUXToD+valKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-0wqHOVdEMtGY94OfLQqH5A-1; Sun, 14 Jun 2026 15:09:23 -0400
X-MC-Unique: 0wqHOVdEMtGY94OfLQqH5A-1
X-Mimecast-MFC-AGG-ID: 0wqHOVdEMtGY94OfLQqH5A_1781464162
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490ae0167ceso12787565e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464162; x=1782068962; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VFYJL+moHp7Nhp/WdZk9yxo8Dl31jRMqPIYW7M964RY=;
 b=l01DoVt5AarucxeIcxq/4PpMi06wE+ZrDqOfhvkJkkAV+QjrWTfIKiubcleeGGlF0l
 aR1ZYD7kcdI29cB6MvDoc6BTq2B3Ou2UoJDH3DJryOhkiJYZbzYRk7Ip5lN1fIFyiseV
 TwWx8WwC4A+mS2yITIe9GGRu3Lt+HK1M1o+yvGBsi3QsvrsAKuZgWvcps+IhMO+1Zp0P
 qC9P4f1RaDr0rEVgI0ZTd2H8zAm4py89rjb6tcO4Zdp1El1zRouNBd4GzUKhiDC1t8U5
 24FODgyDQr6wSppr+0Ce46zTUqEctWa0NLCTB5zBIkKQjm5T7WvOq9LYinJ+zxRIQkVi
 2ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464162; x=1782068962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFYJL+moHp7Nhp/WdZk9yxo8Dl31jRMqPIYW7M964RY=;
 b=E1TwM3UTqlz9+fpaSe+nzgRpqmEWyxge2AWT8IUYsXH2T4TGvrnBZfDZi/CQu7uEk3
 eN+CMFWQAmLSqz+8BnmrFmuR5rLQtceSVdfTk9eKmeFIHo2oztUFNWpcHO7AnZxoW1Ei
 kwnPmBtzLvRIqF54HQgbcTdL+PkdwLCPHHeC8OjE468Sn8l0shIM1WPOZ+faOWDOhHVA
 sNSV0FfwiJD6+g2ujKE3Wl0rcGv4c2ALtE3QoqwqJIuyiDcb9+CwZGwcdpowaSCopMX5
 NDoImAwapUYXfMpgNzYyivf1junJ8ZG3CDDW+rU4W85EsEZ+eqhpfv5lxCmzHtJsgYj3
 LnOA==
X-Gm-Message-State: AOJu0YyDd0xikl8D5ipzqBCUjqxYTy/u+K2Ycr48g1zie4FSgZOeLRMI
 sVWsXq3il5vDWFyJgviw0BgzbNmfk+wlLWclYS+/0zVAikwNJ5lLpFvWcfnwpf2O3zy2+y+v2TP
 MD2OAUFz4XDIpAweHr2E9lfZ05mD5elHr4WcgrrKpmDefRyxZiG8Zs3/vy+frPYDHWAHB6X8KbD
 wf3h6MOkh8hi8sh3nF/JRsw25Pb4K9W02Tng==
X-Gm-Gg: Acq92OGGIVQEoq5XugjzyLjrj/nVqYIC4249ulO3sHm2vBunxEe9VobWSqDMrD6pMYe
 h5aVZFWK8ft+K+kVWPH8HscfP+NEK5FP45I4fKaey3OwMxfr+Izt5a+zBog7V7GLW2gw7zKKfEW
 Zxfiiu7tCkxadAGcGfwiI/TsK21t+7FbuylVImRSV0r4J4bwSfyFIw5bNjeELxMd7u+LKFQ0Wrl
 I9eoK36tA4eNyGMaCntFeE2i9EnZJrlzofJjI+U9nABB6vXzwFIC0IYuDTVXuUULChuKP/TPnEl
 PIZXzPpZyTAhf5r8CbOkvU2EWMcSXYCK9/yYKJxWcKa3xcz31VN7XXMa6tXJqa3RwFZ/HYRLkWi
 wGTcF2BKsSG6mmfOYpcH4/ik7A/R85Ovmx0Z9aHBgFE4=
X-Received: by 2002:a05:600c:c8a:b0:490:e0e3:9587 with SMTP id
 5b1f17b1804b1-490ec51f748mr138865105e9.31.1781464162103; 
 Sun, 14 Jun 2026 12:09:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:490:e0e3:9587 with SMTP id
 5b1f17b1804b1-490ec51f748mr138864805e9.31.1781464161476; 
 Sun, 14 Jun 2026 12:09:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037ba81sm178164595e9.15.2026.06.14.12.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:20 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 086/106] x86: q35: add 'wdat' property
Message-ID: <d30189cce17038ecaeaaacbfee9ab2c1a07c80fa.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Used for enabling WDAT based watchdog for builtin iTCO watchdog.
Usage:
    -M q35,wdat={on|off}
By default it is disabled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260303092532.2410177-3-imammedo@redhat.com>
---
 hw/i386/pc_q35.c     | 18 ++++++++++++++++++
 include/hw/i386/pc.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d8fed698c7..6c1e4eff5f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -331,6 +331,18 @@ static void pc_q35_init(MachineState *machine)
     }
 }
 
+static bool pc_q35_machine_get_wdat(Object *o, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(o);
+    return pcms->wdat_enabled;
+}
+
+static void pc_q35_machine_set_wdat(Object *o, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(o);
+    pcms->wdat_enabled = value;
+}
+
 #define DEFINE_Q35_MACHINE(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor);
 
@@ -343,6 +355,7 @@ static void pc_q35_init(MachineState *machine)
 static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -361,6 +374,11 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
+    object_class_property_add_bool(oc, "wdat",
+        pc_q35_machine_get_wdat, pc_q35_machine_set_wdat);
+    object_class_property_set_description(oc, "wdat",
+        "Enable WDAT watchdog support. Default: off");
+
     compat_props_add(m->compat_props,
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 85a74363b5..d4b6d3ed57 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -45,6 +45,7 @@ typedef struct PCMachineState {
     const char *south_bridge;
 
     bool acpi_build_enabled;
+    bool wdat_enabled;
     bool smbus_enabled;
     bool sata_enabled;
     bool hpet_enabled;
-- 
MST


