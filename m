Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EB4E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhp-0000m4-La; Wed, 18 Dec 2024 05:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0000lD-Q6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhl-0006qI-Rt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ae4dyIyqNtWDwadcWWfv4WjE9ofwvL0jMgrctB+jsJA=;
 b=fDOgy/2aDIKxzt/1asmEFHeSZC4TQT+Ct15Hn6HeJu7y3VmLfkv9UsnKlh9wOStf1KKoJ7
 5kne12b0IpAWHtQrGweIYBW9C6Fk1m4nWPCfuy5J16mJ61usiiyC+Rj2cAM660LSnlusor
 HunvgId0pwNzxj75j43E7Bj7JM9OLVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-SWAtKcE9N3yMk_7jG-NfSA-1; Wed, 18 Dec 2024 05:53:34 -0500
X-MC-Unique: SWAtKcE9N3yMk_7jG-NfSA-1
X-Mimecast-MFC-AGG-ID: SWAtKcE9N3yMk_7jG-NfSA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43627bb20b5so49866365e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519213; x=1735124013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ae4dyIyqNtWDwadcWWfv4WjE9ofwvL0jMgrctB+jsJA=;
 b=M+iEmp/PUxhfPr8b7Vgc9VEL5uQ9FRm+XpB8PusNQTWcOfiEXJzrjEr/v/n1lsUbQg
 rh3f1vYH8qK83n+Tina9l1IguVuS43j73ATMDagQtxYIlG3YNQqEFCsBGIRQgSHPEpfb
 JX56r4n2ipT4+7F+7BNu10n34XPVtCVJyx95WRl8Tr+lPpZT1/NsveJSZ3A0aMBVdXKz
 K/GNdPJ86Ub5rGSkiUbCnOd34Ail5pJ3MLWzLHCci3TYalc75qAhaKfbl/CKfSnsVnsA
 oAhLtoMU796/uySz0ElY4Nu0Nmll8mjYeU91MI7cXy3biLNEr4sIdE0xaiaJh+B40oTb
 C9zQ==
X-Gm-Message-State: AOJu0YxX3l0GsNe8bq1NuvqPgjbOHyv62AYmtS1JAaNonoorb8sJIuPK
 0PwhG/UgZ8h2JpXMNRtDVkDy3v68UQrYLQKipYNBLGjd9Aqk91xO8CxBYi41V+C7Jol4Pn0SE2l
 4GMkVuuQ/L3pa11D8I8rMw+ZoHMu+rMyiG2MKfst859OXDps5d89wU+Z448MVqb1eHMZVvQrRnU
 RXu50SEwHEa2UgbJQFf8oL5SpEJTrTEvGenVQ=
X-Gm-Gg: ASbGncsYcEfe8Sr/Scje0uumwfw8TjfwJI0/vBKo8I29lSBVHzoG+6YdQ1XIt9vQ00j
 xq+LzoBUco/YTTBjFiCmPLbKcIe7oevoSiaYag/7ZUSk+JPk2I6YeBOY+oZ1bN65K/F1l9tfd50
 MOZoqKAQuxpak/tYSpQopnLlxf+7IcyP5rL5kk3lfRHafWciWngnAzSNS08ikWHjADRPpaiVEvm
 OLY6H+7TpdHGxD6SO2NVyz91uVB0gBBuMHeBZnsp4rfTyUa+c0WhFLIGaqekSXmhQSMYew2ruUB
 UR/q84QjyNLndS/IvX65PmJHXEMw+FQ+vT2PH91N9w==
X-Received: by 2002:a05:600c:1d1c:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-436553ea72dmr18205295e9.24.1734519213551; 
 Wed, 18 Dec 2024 02:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXF3ehh0uNXJY4O2vHXQ6p2VO9ez8cXbOSHA6rzJxx/P9i+77iuAsRKWUxmtHhUi5tHuT0rA==
X-Received: by 2002:a05:600c:1d1c:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-436553ea72dmr18204955e9.24.1734519213075; 
 Wed, 18 Dec 2024 02:53:33 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b18f5bsm16882195e9.31.2024.12.18.02.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:31 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 11/15] s390x/s390-virtio-ccw: prepare for memory devices
Date: Wed, 18 Dec 2024 11:52:59 +0100
Message-ID: <20241218105303.1966303-12-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Message-ID: <20241008105455.2302628-11-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 23 ++++++++++++++++++++++-
 hw/s390x/sclp.c            |  6 +++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5a91e334f3..aa06d07835 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -156,6 +156,7 @@ static void s390_memory_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
+    uint64_t devmem_base, devmem_size;
 
     if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
         /*
@@ -168,11 +169,31 @@ static void s390_memory_init(MachineState *machine)
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


