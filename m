Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D18CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFG-0001mK-Cv; Sun, 05 Oct 2025 15:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEf-0008H6-Rk
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEa-0006Uc-ST
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dOCKC2S0m2zbzh2H7cOU9of3P5ijZS88mc28+6tUt50=;
 b=Yew6rGyE4wKRlIBwvIBZPP0Dwc6lthEEOLDfNTNBd4gAqzZrZ1zgLTUkehacg/CCJ5TIDc
 wAsIfTnea8pHvKjTta0GBYxVQpk6WSuUlEhNXYbcgp31XjB8u43BPBR8Ol06/rsYDuc7W1
 kl7CJCxOS0d2/GScjIrkO7EDXxNR4sQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-IHcidCO2Mtavujls939-7g-1; Sun, 05 Oct 2025 15:17:19 -0400
X-MC-Unique: IHcidCO2Mtavujls939-7g-1
X-Mimecast-MFC-AGG-ID: IHcidCO2Mtavujls939-7g_1759691838
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso2219180f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691838; x=1760296638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOCKC2S0m2zbzh2H7cOU9of3P5ijZS88mc28+6tUt50=;
 b=nryl6RM27/u5csX+TW1ZHQAmcep02mA4Yz/in33AH53Co0hVhXTZlLPildXOmyWmyD
 Gk33DJRsXJ6RhRkYmvCl7Pk31CXnj2GCZegZridAHpNtNN+ni7Yp1yMmdRlcKvN8+kj2
 aLw4Y41Lx1RR5YSiPJlFGw+lBQW1C54yRBUTrjKmOzIB75vmbGGtzpaellph1qJhAbN+
 Pl4+dFJZrWgvbK2ZRiiWuROxUWa7I8DBU6D4cKmGtws5dyKZRefX14ItOHvrkbLPvAL5
 hm2wRKO+TPHY/6BOPjOh4ws1PcHIEAjT53vKwlt0+Wg4rKtFR4GxYPP3duNQCYRRzhDa
 L5UQ==
X-Gm-Message-State: AOJu0YwyOHYAYdNBX80ZCI1lY4aK3hvyp6zGmgk/jfWlOSfjHxujKL77
 N5z++mium62BqNxKXSy9pP6YUfWtHX6JC3GoeRpgefAa39qT36856R5BL/tKU92NtpfBb8Zrqik
 BO0Va9+AriFqigEK19k7cy2Wkgl2+1epBu0TfkMnBvXYQpyA5kXdWoeaB3gjTliIksO5iAdO/mJ
 qwr1YiRDiMeuv/NfgPvN6IbQaL+L/FfY9UIQ==
X-Gm-Gg: ASbGncvAXlg99fJiQLaekGrqGJqdhFo6wq4a5twy8my2iAihhRi0XzwUos7XuebozAH
 gOUFfvQEDMlITP4yJklcWy/vIazWWML24jhrgpY04kn/5+wTP5aGcl5R0QHK78JeXHb5D5lXbw7
 uP38rkeD8Fm1Cwo1rV/cEnjnunbTTyeCtM/aWG+fLsrk8fe8adZVBigH7LrzkNh8mTlcKZygZax
 /ztj1tIvysHmQU9NJvVfeO7ZHhlAzljYhe/mn8Nu6kuiwCPbEYdcMewSZ1J3txi67FjOlZsGdnq
 1xfu+rMj03w83MeJpfl6zYjo7yp/VsRFVEQvfYQ=
X-Received: by 2002:a05:6000:230c:b0:3ec:3d75:1330 with SMTP id
 ffacd0b85a97d-425671b037amr5855601f8f.52.1759691837881; 
 Sun, 05 Oct 2025 12:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAOXcUYCeB2FcO8USs1GdU7SBrgkIqd+6HNRwNmXnCWamr//pWSH1hwgv4H/Pqzx9zML1Kug==
X-Received: by 2002:a05:6000:230c:b0:3ec:3d75:1330 with SMTP id
 ffacd0b85a97d-425671b037amr5855584f8f.52.1759691837364; 
 Sun, 05 Oct 2025 12:17:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b005dsm17262051f8f.25.2025.10.05.12.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:16 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 peng guo <engguopeng@buaa.edu.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 33/75] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <d1193481dee63442fc41e47ca6ebc4cd34f1f69c.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: peng guo <engguopeng@buaa.edu.cn>

When using a CXL Type 3 device together with a virtio 9p device in QEMU on a
physical server, the 9p device fails to initialize properly. The kernel reports
the following error:

    virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
    9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22

Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
device was overlapped by the memory window allocated for the CXL devices. As a
result, the kernel could not correctly access the BAR region, causing the
virtio device to malfunction.

An excerpt from /proc/iomem shows:

    480010000-cffffffff : CXL Window 0
      480010000-4bfffffff : PCI Bus 0000:00
      4c0000000-4c01fffff : PCI Bus 0000:0c
        4c0000000-4c01fffff : PCI Bus 0000:0d
      4c0200000-cffffffff : PCI Bus 0000:00
        4c0200000-4c0203fff : 0000:00:03.0
          4c0200000-4c0203fff : virtio-pci-modern

To address this issue, this patch adds the reserved memory end calculation
for cxl devices to reserve sufficient address space and ensure that CXL memory
windows are allocated beyond all PCI 64-bit BARs. This prevents overlap with
64-bit BARs regions such as those used by virtio or other pcie devices,
resolving the conflict.

QEMU Build Configuration:

    ./configure --prefix=/home/work/qemu_master/build/ \
                --target-list=x86_64-softmmu \
                --enable-kvm \
                --enable-virtfs

QEMU Boot Command:

    sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
        -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
        -hda /home/work/gp_qemu/rootfs.img \
        -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
        -kernel /home/work/linux_output/arch/x86/boot/bzImage \
        --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
        -object memory-backend-ram,id=vmem0,share=on,size=4096M \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
        -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bc048a6d13..eb36d50589 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -837,6 +837,7 @@ void pc_memory_init(PCMachineState *pcms,
     hwaddr maxphysaddr, maxusedaddr;
     hwaddr cxl_base, cxl_resv_end = 0;
     X86CPU *cpu = X86_CPU(first_cpu);
+    uint64_t res_mem_end;
 
     assert(machine->ram_size == x86ms->below_4g_mem_size +
                                 x86ms->above_4g_mem_size);
@@ -978,16 +979,17 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (machine->device_memory) {
-        uint64_t *val = g_malloc(sizeof(*val));
-        uint64_t res_mem_end;
+    if (pcms->cxl_devices_state.is_enabled) {
+        res_mem_end = cxl_resv_end;
+    } else if (machine->device_memory) {
+        res_mem_end = machine->device_memory->base
+                      + memory_region_size(&machine->device_memory->mr);
+    } else {
+        res_mem_end = 0;
+    }
 
-        if (pcms->cxl_devices_state.is_enabled) {
-            res_mem_end = cxl_resv_end;
-        } else {
-            res_mem_end = machine->device_memory->base
-                          + memory_region_size(&machine->device_memory->mr);
-        }
+    if (res_mem_end) {
+        uint64_t *val = g_malloc(sizeof(*val));
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
     }
-- 
MST


