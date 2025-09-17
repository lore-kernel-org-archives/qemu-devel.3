Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9768CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrl5-0000YZ-Vu; Wed, 17 Sep 2025 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrkw-0000Nk-6z; Wed, 17 Sep 2025 08:59:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrkt-0005CD-Cv; Wed, 17 Sep 2025 08:59:29 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCuN6o008967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 21:56:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tPY4+EI/R0lfb/HHDdmqmqutVmQUXWIyf5YSX6d+Nrg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758113800; v=1;
 b=eJtUuI0y0LUOY2dC6/fCaR+Bh0ijW4fQbJ2sQmiYy/YrVI6YmvqM7/Jwd4NxnUxo
 ipjTF+BMIwcDGGphE4huoKwcn7iPR0U+nKUb90tHwGqjwGLjYkm5AM0og9m6+eWu
 liiy2zLmYLSyGL7hGZ8FQ1MIynzLCMgPyiL7ARtm5JDfwPkwiHBq7jvp9laZv5kJ
 kaAC8NktVMWu+fnle0EHp0AL10+dZoj2G22yiOHGy96UUUkRPurQJuFlpdBP5ORs
 SpiFdFVM4c3Ma0cO6NDNCNe90O50OHySYO0GI/Sjl1uMfuKXYGZDXV69iiT4e0jL
 +iIFDc9A8MiqeVblBq+z9Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Sep 2025 21:56:22 +0900
Subject: [PATCH 10/35] hw/i386: QOM-ify AddressSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qom-v1-10-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
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
 hw/i386/amd_iommu.c   | 5 +++--
 hw/i386/intel_iommu.c | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index af239390ba04..541b9a8c89e1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1494,7 +1494,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
-        snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
+        snprintf(name, sizeof(name), "as-%d", devfn);
 
         iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
@@ -1522,7 +1522,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                  "amd_iommu", UINT64_MAX);
         memory_region_init(&amdvi_dev_as->root, OBJECT(s),
                            "amdvi_root", UINT64_MAX);
-        address_space_init(&amdvi_dev_as->as, NULL, &amdvi_dev_as->root, name);
+        address_space_init(&amdvi_dev_as->as, OBJECT(s), &amdvi_dev_as->root,
+                           name);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
                                             0);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1f40d904326e..5e6d7d510e03 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4221,6 +4221,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     vtd_iommu_unlock(s);
 
     if (!vtd_dev_as) {
+        g_autofree char *as_name = NULL;
         struct vtd_as_key *new_key;
         /* Slow path */
 
@@ -4263,8 +4264,9 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
         vtd_dev_as->iova_tree = iova_tree_new();
 
         memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
-        address_space_init(&vtd_dev_as->as, NULL, &vtd_dev_as->root,
-                           "vtd-root");
+        as_name = g_strconcat(name, "-as", NULL);
+        address_space_init(&vtd_dev_as->as, OBJECT(s), &vtd_dev_as->root,
+                           as_name);
 
         /*
          * Build the DMAR-disabled container with aliases to the

-- 
2.51.0


