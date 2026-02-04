Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D569EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAO-0007a3-Pc; Wed, 04 Feb 2026 14:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA9-0007BX-2v
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA7-0007qq-Gv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/0ttN4H2vp0exnhXPyUpk99AJqN6xsIyjQacVDV5Q4=;
 b=d2Uir6C8kvtbtsTZxrSrusdevNw3i1vKluahKacpyKA+rwX3HSee/SzNw8DoZax75aWhfm
 OJoJfRA2FHlZoHp10DesWTexXPu9mxKgudD4uiAQycRNYusAXLb70iM3KqiKOqYd/JhW3j
 6Rp5hmH3OQYAoejgZ+FkG/qBUvRQC4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-icfqYxqSNnuPoPWupmreRw-1; Wed, 04 Feb 2026 14:03:37 -0500
X-MC-Unique: icfqYxqSNnuPoPWupmreRw-1
X-Mimecast-MFC-AGG-ID: icfqYxqSNnuPoPWupmreRw_1770231816
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4359e322f30so12695f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231816; x=1770836616; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N/0ttN4H2vp0exnhXPyUpk99AJqN6xsIyjQacVDV5Q4=;
 b=NG0IiqXrLtlYGokG3mq0RmGkBi6FIprcckzNscZeRJZnLmaN47aGYNzCGOEVDjZXvt
 2X3nTm871M082pZwIJJb3fsP4JsXj2n/kCshp1/vmB3fdskfT+LQWz3M4ocNcjDOHAYD
 8EpO8aIkvhlBaPuGC2vpvUx1R1by4A8O+3LooAbPncMjuseQ2lD6xnpzz0ZzrSKd1a0i
 sDMI2i7oiwHO0vQ3oIuoH0xBFad92myvzjAuiaBoy0M4lvf79/Z+rXzuGeIt4/l9Xz5G
 cZLkgtgz9j6IwYby5qjhEg7q737+vQIbFcF5FXftYXhEPqhcMgHehXr1M3eJxQqSMwZa
 vOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231816; x=1770836616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/0ttN4H2vp0exnhXPyUpk99AJqN6xsIyjQacVDV5Q4=;
 b=cDvyx9ztvdRiIkgBWAiGoluJ8XxuRCOvJGSBifT8BDpv2DTaOz6hiYGSG4wYJEMUpg
 WFTgnmTthOnA2GBe7d1gZPvaKdeZOPgdO1ZkgW3L9bsq6SBzVe3yagqBnO6ZamP69gA2
 86MY8JHpeuqVtDAm8e7aILEdk4TglDcMb33EaZlaCc5vGHmEbEizC7D/hlXP/ZvqyBxE
 wWCikaUY2aJsH+zZ2BO2Rx3zXOmpKnf+1+t5iefsp/3bL5sEVRnQwfMatUHBiH5bH1S6
 u+QK9WbaS6Z1epSFVm2s615gyAXsbtiJDgcva7e6Vjz+oYHUbZfAdS3vmR7LhU5z5S5/
 LWGQ==
X-Gm-Message-State: AOJu0YzsZNSpyR7yw42Fbu29FkRljQt8u09TEDXFE1PSDgjVKcEv5LPm
 N/3jtnIR+mv1HfbfPomJee5LZIOWGBwVEWEgMFYNUp+ADQD5mOCxXy0YXK+SuNvgK1cuUEeMOKu
 Hw4VRsCC1sG5vpASFS+NqmddSHwGdibCzR1W5yFXK15qJ0p83lcOTbwkzbHCnknROxPXCLOkIW4
 K+Cue0Bm+lishYI71H76RSb9G1cHKL7K9X4A==
X-Gm-Gg: AZuq6aLt6xusmpvGWO6P3xhjh+6nuMLOskfV+FLQcdEDvMLNZbXJy5bfS47KSYyw7/s
 PKrXFJJ/wMic8myTnn0+XYxn2KcOfuhuh0FzXmoSvngXuhFs2NISxcFI8BiDaL3z41bXYtC0oQl
 23xvrauO2SF1fBOmLisUeFJmorux/n3jOSYpcIcdz8T4L7nGqLhd07nQ28by42JsBQ0q06KhWeV
 i68OFGUNh1EzIr27KUbP60q/I93nOhdRRBc5QFvbtYrBvXodNSnagF7JZ2Jm+KIX415G79D37kX
 mjdlUCnLdeQM0hI2zYmot9xY9Yy7NH0lAfUlQbkqYRQlMRyrulcHxjP2f/ZGpcDAcjarqDwdn5l
 jUQiuo/l4mWl2Z5x/FEPg9fhcJ/hUOW6XTw==
X-Received: by 2002:a05:6000:26c6:b0:436:1e6:e1e3 with SMTP id
 ffacd0b85a97d-4361805a039mr5973307f8f.46.1770231815783; 
 Wed, 04 Feb 2026 11:03:35 -0800 (PST)
X-Received: by 2002:a05:6000:26c6:b0:436:1e6:e1e3 with SMTP id
 ffacd0b85a97d-4361805a039mr5973249f8f.46.1770231815183; 
 Wed, 04 Feb 2026 11:03:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25683sm8186598f8f.6.2026.02.04.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:34 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 19/51] x86: q35: ich9: add 'wdat' property
Message-ID: <d945feae9e6d186fb9180a760165b4c6e0ccb3fe.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

it will be used to make QEMU generate WDAT ACPI table,
that describes TCO watchdog in platfom independed way
and allows guest to use generic 'wdat' driver.
To enable it use '-global ICH9-LPC.wdat=on' option.

PS:
On linux wdat driver takes ove TCO watchdog if WDAT
table is present, hence 'wdat=off' by default to
avoid guest visible change on existing VMs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251030123750.136175-2-imammedo@redhat.com>
---
 hw/acpi/ich9.c         | 5 +++++
 hw/isa/lpc_ich9.c      | 1 +
 include/hw/acpi/ich9.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2b3b493c01..08a01aa1aa 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -321,6 +321,11 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
         acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
 
+    if (pm->enable_wdat && !pm->enable_tco) {
+        error_setg(&error_fatal,
+            "'wdat' can not be enabled without 'enable_tco=on'");
+    }
+
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
         object_property_set_link(OBJECT(lpc_pci), "bus",
                                  OBJECT(pci_get_bus(lpc_pci)), &error_abort);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 51dc680029..2bf6becb5f 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -832,6 +832,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
 
 static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
+    DEFINE_PROP_BOOL("wdat", ICH9LPCState, pm.enable_wdat, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 245fe08dc2..c84e17f9f6 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -69,6 +69,7 @@ typedef struct ICH9LPCPMRegs {
     bool smm_compat;
     bool enable_tco;
     TCOIORegs tco_regs;
+    bool enable_wdat;
 
     bool swsmi_timer_enabled;
     bool periodic_timer_enabled;
-- 
MST


