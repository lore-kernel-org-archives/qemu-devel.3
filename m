Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C5AD6ACD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIY8-0003fw-VL; Wed, 27 Nov 2024 08:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIY5-0003fE-IE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIY4-0007iV-3o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJrhS8Qk1ShMNFRxlemP9veo4SdCGzL5pa49imArvN0=;
 b=WVJ+u7rbltc+0OLz3iKlnblrk1vYbDj90j0yGXN7XEU+NW35b62NUVu2CagcTRzN3GVzsF
 suMmhbef0IeaoX63qFHbaJFRhLtJkU1gOshPfdQPlLHTzHTRD7/hH1F51lU1RsNKtwdsZs
 t27V5V53JvD03wg7F/W71XuX7PHMH4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-vZWrfruuPDC5hnc2ekfLjA-1; Wed, 27 Nov 2024 08:57:42 -0500
X-MC-Unique: vZWrfruuPDC5hnc2ekfLjA-1
X-Mimecast-MFC-AGG-ID: vZWrfruuPDC5hnc2ekfLjA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a4ad4798so17092855e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715861; x=1733320661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJrhS8Qk1ShMNFRxlemP9veo4SdCGzL5pa49imArvN0=;
 b=sCzsXQXxy1y2FGglvTdDg+MyLK7zUmpELpDft/1ARRJTnt3D1cY+/IJO+zoP+S5Oio
 KDT4fICids+locIZytm8CQ36pktN8cIyxwhBM+qvThevKthrVjWYVvfbatEi8RRdrzAL
 ea6LeCgf+2oVbPpYxT0odhzE4w7sB9cTeEW0Mi7z1MUbhI6E+aX97qyK75GeF0qlpn/Q
 HiTVekYkUsi5s3z+jKKqZfQvTVAhts8skmr4N30+lFtLZkRf0cl/EViWmBMuCYW8SJpc
 9HDUQwYJFySfPAjA2lNp8QGNRGmsa0TdkQTu18ia5PFWkh0z6gpAUzLOWSHWxk7D7XPy
 x0MQ==
X-Gm-Message-State: AOJu0YwTCye3+gCSfa9hnPrC8Q4TmDm0dRZLUMYeLuRSmH37Rzl5Io0u
 UBP+zPixpHn70OriAOGB7/pj2IJHAQSFEJ3c0UgVye4jrFL+LWOSJ76kg7o+UO6RZVJmKi7uoXz
 HWu11H8BOKbSyHfeIhILpOEQrfIDOxcI/soxEppciZKZqHR2Y67KX2sCzdXjJ0lTdPCzRvqpu5g
 J/yNryIVBXIKAnHQCm6j4P9eGavnyeNGer
X-Gm-Gg: ASbGncvVEZEcxTpZgF0gEWPeIh8ydirInbJTNWH7loArvTZWBwld94BsY44xkNOr10v
 FHx/wVGTa3m61w8JtCfsKPC+jzkV0nbu2hf6EDytO1n9JaZN+eHCX1NrVqwK+MyB0Lv1exdRXzi
 7sQ2vw5zIoW1jfui4YlextwFWdpfdLBGAgfaqbNHqQA/aWcg5zc1qZh95RLuJzD6s9kVc5XoV5P
 pEXzE47Bi/3HPAOGs+glDXhZv044EPbhIR3ngjWyup3
X-Received: by 2002:a05:600c:56d7:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-434a9de8d3amr24432445e9.26.1732715860897; 
 Wed, 27 Nov 2024 05:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELN1x1hmuo8yUsYGRVwB9aTk0Dg6sfAIxKvvrxbnP0P6rjOTRz9ZyWqqhd/yqJjLk/8dIptg==
X-Received: by 2002:a05:600c:56d7:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-434a9de8d3amr24432225e9.26.1732715860541; 
 Wed, 27 Nov 2024 05:57:40 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7804fbsm22358165e9.21.2024.11.27.05.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:39 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/13] Revert "hw/acpi: Make CPUs ACPI `presence` conditional
 during vCPU hot-unplug"
Message-ID: <f2ba6ab6212b656179c4f4ce68ee74a500c409b0.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

This reverts commit 2d6cfbaf174b91dfa9a50065f7494634afb39c23.

The patch is supposed to be part of ARM CPU hotplug series and has not value
on its own without it. The series however is still in RFC stage and outside
of scope 9.2 release.

On top of that it introduces not needed callback that pokes directly into
CPU state without any need for that. Instead properties and AML generator
option should be used to configure static platform depended vCPU presence
state.

Drop the patch so that corrected version could be posted along with
ARM CPU hotplug series and properly reviewed in relevant context.
That also helps us to keep history cleaner with new patch being
against original code vs a string of fixups on top of current mess.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20241112170258.2996640-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/acpi/cpu.c         | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e7de77dc6d..c3ca0babcb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -158,7 +158,6 @@ struct CPUClass {
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
-    bool (*cpu_persistent_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 9b03b4292e..5cb60ca8bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -233,17 +233,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
 }
 
-static bool should_remain_acpi_present(DeviceState *dev)
-{
-    CPUClass *k = CPU_GET_CLASS(dev);
-    /*
-     * A system may contain CPUs that are always present on one die, NUMA node,
-     * or socket, yet may be non-present on another simultaneously. Check from
-     * architecture specific code.
-     */
-    return k->cpu_persistent_status && k->cpu_persistent_status(CPU(dev));
-}
-
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
     CPUClass *k = CPU_GET_CLASS(dev);
@@ -300,9 +289,7 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
         return;
     }
 
-    if (!should_remain_acpi_present(dev)) {
-        cdev->cpu = NULL;
-    }
+    cdev->cpu = NULL;
 }
 
 static const VMStateDescription vmstate_cpuhp_sts = {
-- 
MST


