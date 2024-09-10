Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C5CEDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so599-0008Lx-Q0; Tue, 10 Sep 2024 13:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so596-00085l-Kq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so594-0006Sj-1D
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LImbA6gvISjcEBYitgOa52PU03DSH0+RHu7yPYeYS6s=;
 b=A7x00SQkKB3S5RVnnm+phi69w2UaMD4crV+L+fEn/NCnpycD3OWiMsWTiri7qUUNcBx34w
 nF9Ysj714BtveCLuE9OR0KRVYTTbiPO1CJyTlRwJ7GGbSkbMR5M074Hbg251KpnD5YAvRw
 UKhq3wrng+F/ikLnN881fAr7iVTOM9Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-i1OslwssPNqXaN1kR6gVjQ-1; Tue,
 10 Sep 2024 13:59:13 -0400
X-MC-Unique: i1OslwssPNqXaN1kR6gVjQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8B5019560B0; Tue, 10 Sep 2024 17:59:11 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B704619560AD; Tue, 10 Sep 2024 17:59:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 11/14] s390x/s390-virtio-ccw: prepare for memory devices
Date: Tue, 10 Sep 2024 19:58:06 +0200
Message-ID: <20240910175809.2135596-12-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 25 +++++++++++++++++++++++--
 hw/s390x/sclp.c            |  6 +++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 08156f0682..0a9d25620d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -126,7 +126,7 @@ static void s390_memory_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
-    uint64_t hw_limit;
+    uint64_t hw_limit, devmem_base, devmem_size;
     int ret;
 
     if (!QEMU_IS_ALIGNED(ram_size, 1 * MiB)) {
@@ -140,7 +140,21 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    ret = s390_set_memory_limit(ram_size, &hw_limit);
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
+
+    ret = s390_set_memory_limit(devmem_base + devmem_size, &hw_limit);
     if (ret == -E2BIG) {
         error_report("host supports a maximum of %" PRIu64 " GB",
                      hw_limit / GiB);
@@ -153,6 +167,13 @@ static void s390_memory_init(MachineState *machine)
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
index fac09816bf..fe4216a10d 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -162,7 +162,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
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
2.46.0


