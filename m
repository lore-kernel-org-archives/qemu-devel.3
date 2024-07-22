Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EE3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVglv-0004em-70; Sun, 21 Jul 2024 20:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgky-0000dD-V3
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkw-0005tZ-AX
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZSgHsYIlqu62oOYqEz8U74/NNGfq5BqJa6TiXLGU28=;
 b=OcqIcppQgn9nNoyYnoSsa93RdS8P774FhhmOuf6LN6/UwS543VvgLL3cjdCe/RIQPTpnof
 j2CMUaGcdsc8wz+bK7cVR/CyIA2fmA6q1AUahaezeDXyBHOOLyBZOqsNBcUCMvYgNbV0u2
 aLsgubz7/Xce7dEIE8MKvzOw2mOXxCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-umMXAXSzMQSgGtm0IOBoUg-1; Sun, 21 Jul 2024 20:18:20 -0400
X-MC-Unique: umMXAXSzMQSgGtm0IOBoUg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-368448dfe12so1083469f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607499; x=1722212299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZSgHsYIlqu62oOYqEz8U74/NNGfq5BqJa6TiXLGU28=;
 b=LP5L0wZ0byR0bvUmClnInZGPDUjujrPYt6Ln6zKKgOHXOZQQwNayFBhj8pGheKgoNr
 rd6S5AGVo5TB1t7pJDmO1gHURFgVdKcBerhHcyInrOBO2Oo4VGzJpMtIVytmktDpNWMq
 AGAlZJgXv+5N7U0s71dxqzDnjGprxSsggHAqxUkh3WtNYsiUzwhRFTYGmVb29+nqg8ar
 NtCQsuUd4GIlaFrnNXviWRKubS5pVd1tfLMOf/hBt3kRbhqLuP0erKkxcUWz+MlBPPVx
 5P1VP/FEvGF2uxHHICqnWquubcgOSMgRdVsEi90hIaKqjhbL18gJULlWXIO8SOEvnohE
 M9Ag==
X-Gm-Message-State: AOJu0YxwUPRx10+xjKb845zsE1G6bwSQGMXk4fU5kFN0wHK0ZGw+8a1j
 4QxZzntIz53KlXKSc+MFxwj8NvnESjAmrvUzPf2DLhx5uSJpZ9It9R/Evj9+6l2HLAG0+K4gWKj
 lSocCxHDhlpyhp8Vl+L2/hJ/D1vdLN/ZtP03MknDzat1Js2NM7U6iSxOW2eO7z0V7r3g9QKElIs
 +rXVsFRrU+TSebppFlH97SkW9QYU7paA==
X-Received: by 2002:a5d:64e6:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-369c6cbc6demr2625268f8f.16.1721607498865; 
 Sun, 21 Jul 2024 17:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK+6zlxyCwXaMhJ56jglivt3PF1+NKzmfKZuVzKMpYafUXEDe0ATnhcD1Ak/Im0bxZDROBow==
X-Received: by 2002:a5d:64e6:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-369c6cbc6demr2625249f8f.16.1721607498350; 
 Sun, 21 Jul 2024 17:18:18 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eb6b0sm7011291f8f.90.2024.07.21.17.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:17 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 41/63] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <d2d94949ccff8415cd16201a1606a1f14aa0f604.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
results in start of the CPU scan. Scan figures out the CPU and the kind of
event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
method with the call to method \\_SB.CPUS.CSCN (via \\_SB.GED.CSCN)

Architecture specific code [1] might initialize its CPUs AML code by calling
common function build_cpus_aml() like below for ARM:

build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, memmap[VIRT_CPUHP_ACPI].base,
               "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY);

[1] https://lore.kernel.org/qemu-devel/20240613233639.202896-13-salil.mehta@huawei.com/

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-5-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h | 1 +
 hw/acpi/generic_event_device.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index e091ac2108..40af3550b5 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -87,6 +87,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
+#define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
 
 /*
  * Platforms need to specify the GED event bitmap
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 4641933a0f..15b4c3ebbf 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -108,6 +108,9 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                 aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
                                              MEMORY_SLOT_SCAN_METHOD));
                 break;
+            case ACPI_GED_CPU_HOTPLUG_EVT:
+                aml_append(if_ctx, aml_call0(AML_GED_EVT_CPU_SCAN_METHOD));
+                break;
             case ACPI_GED_PWR_DOWN_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
-- 
MST


