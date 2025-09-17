Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219CCCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrsX-0001s6-8O; Wed, 17 Sep 2025 09:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyroi-00051N-5J; Wed, 17 Sep 2025 09:03:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrof-0005uV-4n; Wed, 17 Sep 2025 09:03:23 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCuN6r008967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 21:56:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TGbrQM/McNBrLXG5VfeAkh7HnxBCj04Y3QHaSSNnZfI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758113802; v=1;
 b=KheEbi1DHbpSY1QMbJ+q1rYvx7VsHKkiS8/9RjIZiRXMxAyctZqTc0JFtwBvh8PW
 2lKENHULJa8wpzYIeWYz2UROsL+SnDsw7kwGSPlXu9/XzqJKBb1rCwX0ICOzKLFN
 +bu/6ujnuSSLfrn4qTLWAnGGdVIArkbeyzz/ERp0RLdum5ZGDcwG1f7AerWpDS1Z
 eT/ItWkzHgUstvQj7m354JJwf41b5mNhUpi/++mCjMFvFlFs4SP8knmmtBCbZ+A9
 +toIb6vhywCtSILmojmMqKTjF38LQiZl7pw+tcUMM/YYSs4bJsu/2qyrxZEa1CkQ
 LAYO+Em9E6LfJazNVBAXJA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Sep 2025 21:56:25 +0900
Subject: [PATCH 13/35] hw/mem: QOM-ify AddressSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qom-v1-13-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Laurent Vivier <laurent@vivier.eu>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Make AddressSpaces QOM objects to ensure that they are destroyed when
their owners are finalized and also to get a unique path for debugging
output.

The name arguments were used to distinguish AddresSpaces in debugging
output, but they will represent property names after QOM-ification and
debugging output will show QOM paths. So change them to make them more
concise and also avoid conflicts with other properties.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/mem/cxl_type3.c     | 44 ++++++++++++--------------------------------
 hw/mem/memory-device.c |  4 ++--
 2 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1a726b834b02..968594ae65e2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -727,8 +727,6 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
-    DeviceState *ds = DEVICE(ct3d);
-
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
@@ -750,7 +748,6 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 
     if (ct3d->hostvmem) {
         MemoryRegion *vmr;
-        char *v_name;
 
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
         if (!vmr) {
@@ -765,20 +762,14 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         memory_region_set_nonvolatile(vmr, false);
         memory_region_set_enabled(vmr, true);
         host_memory_backend_set_mapped(ct3d->hostvmem, true);
-        if (ds->id) {
-            v_name = g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->id);
-        } else {
-            v_name = g_strdup("cxl-type3-dpa-vmem-space");
-        }
-        address_space_init(&ct3d->hostvmem_as, NULL, vmr, v_name);
+        address_space_init(&ct3d->hostvmem_as, OBJECT(ct3d), vmr,
+                           "volatile-as");
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
         ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
-        g_free(v_name);
     }
 
     if (ct3d->hostpmem) {
         MemoryRegion *pmr;
-        char *p_name;
 
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
         if (!pmr) {
@@ -793,21 +784,15 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         memory_region_set_nonvolatile(pmr, true);
         memory_region_set_enabled(pmr, true);
         host_memory_backend_set_mapped(ct3d->hostpmem, true);
-        if (ds->id) {
-            p_name = g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->id);
-        } else {
-            p_name = g_strdup("cxl-type3-dpa-pmem-space");
-        }
-        address_space_init(&ct3d->hostpmem_as, NULL, pmr, p_name);
+        address_space_init(&ct3d->hostpmem_as, OBJECT(ct3d), pmr,
+                           "persistent-as");
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
         ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
-        g_free(p_name);
     }
 
     ct3d->dc.total_capacity = 0;
     if (ct3d->dc.num_regions > 0) {
         MemoryRegion *dc_mr;
-        char *dc_name;
 
         if (!ct3d->dc.host_dc) {
             error_setg(errp, "dynamic capacity must have a backing device");
@@ -832,13 +817,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         memory_region_set_nonvolatile(dc_mr, false);
         memory_region_set_enabled(dc_mr, true);
         host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
-        if (ds->id) {
-            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
-        } else {
-            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
-        }
-        address_space_init(&ct3d->dc.host_dc_as, NULL, dc_mr, dc_name);
-        g_free(dc_name);
+        address_space_init(&ct3d->dc.host_dc_as, OBJECT(ct3d), dc_mr,
+                           "volatile-dc-as");
 
         if (!cxl_create_dc_regions(ct3d, errp)) {
             error_append_hint(errp, "setup DC regions failed");
@@ -974,13 +954,13 @@ err_free_special_ops:
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-        address_space_destroy(&ct3d->dc.host_dc_as);
+        object_unparent(OBJECT(&ct3d->dc.host_dc_as));
     }
     if (ct3d->hostpmem) {
-        address_space_destroy(&ct3d->hostpmem_as);
+        object_unparent(OBJECT(&ct3d->hostpmem_as));
     }
     if (ct3d->hostvmem) {
-        address_space_destroy(&ct3d->hostvmem_as);
+        object_unparent(OBJECT(&ct3d->hostvmem_as));
     }
 }
 
@@ -997,13 +977,13 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_destroy_cci(&ct3d->cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-        address_space_destroy(&ct3d->dc.host_dc_as);
+        object_unparent(OBJECT(&ct3d->dc.host_dc_as));
     }
     if (ct3d->hostpmem) {
-        address_space_destroy(&ct3d->hostpmem_as);
+        object_unparent(OBJECT(&ct3d->hostpmem_as));
     }
     if (ct3d->hostvmem) {
-        address_space_destroy(&ct3d->hostvmem_as);
+        object_unparent(OBJECT(&ct3d->hostvmem_as));
     }
 }
 
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a4a8efdd869b..165866f10b25 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -535,8 +535,8 @@ void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
 
     memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
                        size);
-    address_space_init(&ms->device_memory->as, NULL, &ms->device_memory->mr,
-                       "device-memory");
+    address_space_init(&ms->device_memory->as, OBJECT(ms),
+                       &ms->device_memory->mr, "device-memory-as");
     memory_region_add_subregion(get_system_memory(), ms->device_memory->base,
                                 &ms->device_memory->mr);
 

-- 
2.51.0


