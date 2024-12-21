Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43187E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53r-0002Tz-CZ; Sat, 21 Dec 2024 14:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53p-0002Rz-VD
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53o-0000NM-4N
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SCHZt+7eq0EguUklsx9a7gyRDzfGwtz5P0zLbQ+Xi8=;
 b=e04Zq6/fgXa0Edj1QbfncAvLtTVrSscA/1YFaUJ6jGiUjBekn5U55XxmaREJzzQFEpPvRh
 c2f68LETc8d7EFq56Rkm3zZvSMr8AuI85SQqiNb0ydXkxnfnlFrLf6kolH7Dal6JZx5eaQ
 VT5s/UsCe/bJfuaQ9pPPqg4+t+F8bjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-WITFYY1hNZKNS23rrFRRyQ-1; Sat, 21 Dec 2024 14:22:44 -0500
X-MC-Unique: WITFYY1hNZKNS23rrFRRyQ-1
X-Mimecast-MFC-AGG-ID: WITFYY1hNZKNS23rrFRRyQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso2016649f8f.0
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808963; x=1735413763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SCHZt+7eq0EguUklsx9a7gyRDzfGwtz5P0zLbQ+Xi8=;
 b=YhaJ5wPPMWhZa7gfhdFejcV3eND3IcRdG1SrjntCEtg7BBej6j/cJNKL3RCBIqnfcF
 1P0nateUM7uly8nKFltS3LZmTMS1sTTYcOcuZqaRrOMzbW/kGDJLzdt1LmRj9JkU0kYH
 7FwJWKqjCDX7iDwlYCH9LoE0S3ctqKbWfAT1YrdBrfaVj2LOP6rSMQ4YHPOH/6e5nqz8
 R+kqEMvN16vrSdQQRwczwTW7/C7aI/qEjSdLD1fxsSoAKzVE+Z0bsfhslIAGv/5YqlzC
 y0lYRNFnaI0hs4lTCkq7krQZWcmH/hXAEUDKgkDzIiDjNpxn+nz23Xl+v65kcrXbjIic
 YTFQ==
X-Gm-Message-State: AOJu0Yy9h074Idr4K7EHdf2Dkvz/oIiZorsKZBgz8MZX4pw58fBykgoX
 fUHNflaJrSCeHkA6AoqrMftUdgGxB/oROsm6e9K084B3+3SmT+uilYR/5iS1gn9tcI1hPYkA7eC
 VJgNzy3sDV2eRikTIJxodLHoRVS0MrPKp29GkiDWNbVriDWftHHI+q96xpR45o3299vviKzUdTl
 fjG9HLJEjSHV+KrDd7QZboKseaE2LLVqti
X-Gm-Gg: ASbGncs7/AYqXj0+LlHSGPUIPui4LCPFhTHXhAzIRGVpNHU7QL1FhMSImI6k958PCpx
 gCWIuBdkYjSzir17qBf1lVxFuMCggO9GyUJh3Bwba+i2dAVmeP7lXQ8piwJkw+yzdnXJ6+qrYqU
 k3DBOnz2WpapzEcH1HU6AzlCsTZbew8h0fONGX51WUEQ31tWPQKRD5xhDWT0JN74b6GAn0MkoLI
 RA6MedxGffC2RNcDfC7kSRDLkli7qKXu1CetIfLDXROMRmOwouzjMs3iDzzBnGiNFF2gSK5mOwW
 WrkHTl3UWJip8RcihCH9hRM9ri+IjGJYj+hEljA=
X-Received: by 2002:a05:6000:186b:b0:385:e877:c037 with SMTP id
 ffacd0b85a97d-38a223f82f4mr6157296f8f.42.1734808963207; 
 Sat, 21 Dec 2024 11:22:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwsiHDn5FIHVUD7quSHAYiTuUOjdmR05qX+N/bzOz3QbzsjL51U3seaZfr4uo5KTiTOuuXKQ==
X-Received: by 2002:a05:6000:186b:b0:385:e877:c037 with SMTP id
 ffacd0b85a97d-38a223f82f4mr6157282f8f.42.1734808962788; 
 Sat, 21 Dec 2024 11:22:42 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c89e2eesm7226385f8f.80.2024.12.21.11.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:41 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 11/15] s390x/s390-virtio-ccw: prepare for memory devices
Date: Sat, 21 Dec 2024 20:22:05 +0100
Message-ID: <20241221192209.3979595-12-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Let's prepare our address space for memory devices if enabled via
"maxmem" and if we have CONFIG_MEM_DEVICE enabled at all. Note that
CONFIG_MEM_DEVICE will be selected automatically once we add support
for devices.

Just like on other architectures, the region container for memory devices
is placed directly above our initial memory. For now, we only align the
start address of the region up to 1 GiB, but we won't add any additional
space to the region for internal alignment purposes; this can be done in
the future if really required.

The RAM size returned via SCLP is not modified, as this only
covers initial RAM (and standby memory we don't implement) and not memory
devices; clarify that in the docs of read_SCP_info(). Existing OSes without
support for memory devices will keep working as is, even when memory
devices would be attached the VM.

Guest OSs which support memory devices, such as virtio-mem, will
consult diag500(), to find out the maximum possible pfn. Guest OSes that
don't support memory devices, don't have to be changed and will continue
relying on information provided by SCLP.

There are no remaining maxram_size users in s390x code, and the remaining
ram_size users only care about initial RAM:
* hw/s390x/ipl.c
* hw/s390x/s390-hypercall.c
* hw/s390x/sclp.c
* target/s390x/kvm/pv.c

Message-ID: <20241219144115.2820241-11-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 23 ++++++++++++++++++++++-
 hw/s390x/sclp.c            |  6 +++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c56b70dcd..2ba66be018 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -149,6 +149,7 @@ static void s390_memory_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
+    uint64_t devmem_base, devmem_size;
 
     if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
         /*
@@ -161,11 +162,31 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    s390_set_memory_limit(s390ms, ram_size);
+    devmem_size = 0;
+    devmem_base = ram_size;
+#ifdef CONFIG_MEM_DEVICE
+    if (machine->ram_size < machine->maxram_size) {
+
+        /*
+         * Make sure memory devices have a sane default alignment, even
+         * when weird initial memory sizes are specified.
+         */
+        devmem_base = QEMU_ALIGN_UP(devmem_base, 1 * GiB);
+        devmem_size = machine->maxram_size - machine->ram_size;
+    }
+#endif
+    s390_set_memory_limit(s390ms, devmem_base + devmem_size);
 
     /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
 
+    /* Initialize address space for memory devices. */
+#ifdef CONFIG_MEM_DEVICE
+    if (devmem_size) {
+        machine_memory_devices_init(machine, devmem_base, devmem_size);
+    }
+#endif /* CONFIG_MEM_DEVICE */
+
     /*
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 73e88ab4eb..5945c9b1d8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -161,7 +161,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnsize2 = cpu_to_be32(rnsize);
     }
 
-    /* we don't support standby memory, maxram_size is never exposed */
+    /*
+     * We don't support standby memory. maxram_size is used for sizing the
+     * memory device region, which is not exposed through SCLP but through
+     * diag500.
+     */
     rnmax = machine->ram_size >> sclp->increment_size;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
-- 
2.47.1


