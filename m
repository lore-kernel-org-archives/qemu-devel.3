Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30433C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSI5-00025p-OG; Mon, 14 Jul 2025 19:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHY-0006WV-48
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHW-0005gd-CY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+T4n/gyfgbuHU+PmGwWi6LsepOZQGnOvAjcmjnojCQ=;
 b=NBy8DVFHtT7JMr7PdUNRHFgZsVQ873NTEYC/V9nkhrbjxV/tMT+XOvgc9ILxJmtLckUokE
 acFTq8ttQUOperuNHu2iJF9WLzaZiKDxLjbc4tfo6IXnMBWE8Veq1RHAJWvKE6+t5e+L1J
 1PJTrsiOtB1+SbZW5Q73zjn59WHUUYM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-04OvPCcAMJCOoaSM6B_z_A-1; Mon, 14 Jul 2025 19:08:19 -0400
X-MC-Unique: 04OvPCcAMJCOoaSM6B_z_A-1
X-Mimecast-MFC-AGG-ID: 04OvPCcAMJCOoaSM6B_z_A_1752534498
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso3441357f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534498; x=1753139298;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+T4n/gyfgbuHU+PmGwWi6LsepOZQGnOvAjcmjnojCQ=;
 b=S3lrHrwL/wBV+XJTQvIBzadaZDnK7gSHHCyLwVwj6Z4Lv1q37nTzVg14PXCwAAylIt
 Gj+k/h2W0akdkaSPhc1ZNhb2cSyyw03K8IZRzWjC008ko13/QC07gOVzvq0yEXgfbXT8
 qkG3Tj75kb1Mm5AilnvVt4lHtJgQfM5SGyCinRjfWWoq4nOs9WsOpL3U3G4GQSK2jnpl
 D/N87bDBckqBKfANXiLz8R2fuSQfGTdo8hdsAVb6LkoLqfgXeu4P+TWOHabT6/8OIXpR
 NoBYiTJJCFox79V1HBMBJhxkJ+Q+ISmVB6qT9v+9+BY4MSU3jwq9DVnOIBgBdVdgGSFo
 bOQg==
X-Gm-Message-State: AOJu0Yx0H7rQ4uF5wWY9bx99HO55eCJqNGRf2gKnnOS9Lq+7tbcSNbtQ
 Ug9ibcdoKlEVsArlKu7M63iGnyJKJl8/6SSg+8UISp96ZFbpD5jn0CRQhGvrO36EokCS+ozwO8j
 0Nnnry6kKfpMa3QJ8n3HqicXF5Y3hnObZynGBSs9XrjnWElM9V0ot15ALDEezrp51uK/T0cgcaG
 momCfUDXUQ2xlzQe8bXuw6DItPtOtMRClRbw==
X-Gm-Gg: ASbGnctlH0SoZE0FdfR013w71UYzP5pHpduIeDU/o5V0jgmgm7EYvPzXsHwpmGi1Idx
 vRTwffiE3T0G69/n2yHNNOL16EDu9yIU9sGaaEe8ifp5zX5xws8tQC6n0SvEL9n6EX5hF8zXe8L
 aLnCusmrEk3dRA4UQXbScKQut7k5VVG6+28fi+nTKc0KBvI/QOID/Yw/CZ3BTJslHksyMv9mqUc
 /7KyqP7HPh0kOfyW67U1JhFWAHIqQ1J2MF8ANpjVW8UD7aPSdEDbtzaKZsaZEj/aMfqunDZya1K
 ksVMMe+L3UISQ3rA7hOACKjUYbkqRW/y
X-Received: by 2002:a05:6000:41f7:b0:3a4:d83a:eb4c with SMTP id
 ffacd0b85a97d-3b60a1bb314mr270557f8f.57.1752534497665; 
 Mon, 14 Jul 2025 16:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0R+AIKsrHi0wk6hYpVH2t1ggU+X8vweYfpslqXjcCUC9jlwFDrgBMZy8Q0GbHPgH4a5zZwQ==
X-Received: by 2002:a05:6000:41f7:b0:3a4:d83a:eb4c with SMTP id
 ffacd0b85a97d-3b60a1bb314mr270532f8f.57.1752534497187; 
 Mon, 14 Jul 2025 16:08:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd29sm74051385e9.34.2025.07.14.16.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:16 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 47/97] hw/i386/acpi-build: Make aml_pci_device_dsm() static
Message-ID: <f2ecded93928bec88b322d126044c5e5f8d69237.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

No need to export aml_pci_device_dsm() as it is only used
in hw/i386/acpi-build.c.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-2-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pci.h | 1 -
 hw/i386/acpi-build.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 6359d574fd..ab0187a894 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -36,7 +36,6 @@ typedef struct AcpiMcfgInfo {
 
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
                 const char *oem_id, const char *oem_table_id);
-Aml *aml_pci_device_dsm(void);
 
 void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 61851cc840..f59026524f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -338,7 +338,7 @@ build_facs(GArray *table_data)
     g_array_append_vals(table_data, reserved, 40); /* Reserved */
 }
 
-Aml *aml_pci_device_dsm(void)
+static Aml *aml_pci_device_dsm(void)
 {
     Aml *method;
 
-- 
MST


