Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C64EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treex-0004Od-Ep; Mon, 10 Mar 2025 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0e.v1-1f1809525b724d30974b587fa46d1235@bounce.vates.tech>)
 id 1treeq-0004Md-Io
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:10 -0400
Received: from mail186-3.suw21.mandrillapp.com ([198.2.186.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0e.v1-1f1809525b724d30974b587fa46d1235@bounce.vates.tech>)
 id 1treen-0005La-He
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741617934; x=1741887934;
 bh=D8pjLz1P43cjnB28y4d+UMASewJChwKWZNDkhhJymtM=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=SLK41gsP9e4/+UHsXs/FBI6xKKKK6ArJNu3TtfQMD7pVdOhgkBSP+smkpuQG/0NLV
 9g83sZoXoRizWvlCJ28lny0nKPx5lPFg8ZLR4/7fGYrsiISHCW3xtIlN4Ab1W2aI/5
 vOy3lKImpIirNKxQeVhEqywpdCefWQOc1zdPT6dO5UZdbM8HA5Fp8BzN2IHB5gjUjA
 nqcYyKCR1imlNjeRFUkVPzzJrVwNPBZVZe4lLuAHq8Uf5OQXIqWjlyi9Wx7yJ+Ur4w
 ilfngcOtKpr6D04NsDtipIXq2qb1NhEQdmEx0VvZetR8xmtaCx/BZZE8vjNcIrT261
 Rj3QF3Mz0GN1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741617934; x=1741878434; i=anthony.perard@vates.tech;
 bh=D8pjLz1P43cjnB28y4d+UMASewJChwKWZNDkhhJymtM=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=ANzBvICEauVO5w0HQPEqkzGD/y5vlB2Hm81O1juShsFHCeE5BRwguDyPQpdlgBgni
 kFdkMoFmLBQfxGD56nQgye7f/eCOdvlTYSfz8A7IbCpccoJeDB2aUSHtlFDeh2FF/y
 7Gg8PFoibNP4ewj9sQtyM9Kx8EelrFk7GxEI1GuziIm9qs/nppXZpDbUG641RiVKrc
 vED/6G+M6qqp9XeXRQf+16eap59KvwRWQPrWoIC00PsZeSlEtGXA9HpPk2U0B22FR3
 xEYApb+SY729I4BSsI/XrCJGHN2k72gwetYKXiE9q0HGSA/vDKPR34V2QXf+FyB0T+
 MtIuxg9/GOp0A==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-3.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4ZBKSZ1lHDzDRHyB6
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:45:34 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=201/3]=20xen/passthrough:=20use=20gsi=20to=20map=20pirq=20when=20dom0=20is=20PVH?=
Received: from [37.26.189.201] by mandrillapp.com id
 1f1809525b724d30974b587fa46d1235; Mon, 10 Mar 2025 14:45:34 +0000
X-Mailer: git-send-email 2.39.5
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741617933291
To: qemu-devel@nongnu.org
Cc: "Jiqian Chen" <Jiqian.Chen@amd.com>,
 "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20250310144516.28828-2-anthony.perard@vates.tech>
In-Reply-To: <20250310144516.28828-1-anthony.perard@vates.tech>
References: <20250310144516.28828-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.1f1809525b724d30974b587fa46d1235?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250310:md
Date: Mon, 10 Mar 2025 14:45:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.3;
 envelope-from=bounce-md_30504962.67cefb0e.v1-1f1809525b724d30974b587fa46d1235@bounce.vates.tech;
 helo=mail186-3.suw21.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

In PVH dom0, when passthrough a device to domU, QEMU code
xen_pt_realize->xc_physdev_map_pirq wants to use gsi, but in current codes
the gsi number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
wrong, because irq is not equal with gsi, they are in different spaces, so
pirq mapping fails.

To solve above problem, use new interface of Xen, xc_pcidev_get_gsi to get
gsi and use xc_physdev_map_pirq_gsi to map pirq when dom0 is PVH.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Acked-by: Anthony PERARD <anthony@xenproject.org>
Reviewed-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
Message-Id: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/xen/xen_pt.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index e2bd4c7d41..9487f68f2e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -766,6 +766,57 @@ static void xen_pt_destroy(PCIDevice *d) {
 }
 /* init */
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+static bool xen_pt_need_gsi(void)
+{
+    FILE *fp;
+    int len;
+    /*
+     * The max length of guest_type is "PVH"+'\n'+'\0', it is 5,
+     * so here set the length of type to be twice.
+     */
+    char type[10];
+    const char *guest_type = "/sys/hypervisor/guest_type";
+
+    fp = fopen(guest_type, "r");
+    if (!fp) {
+        error_report("Cannot open %s: %s", guest_type, strerror(errno));
+        return false;
+    }
+
+    if (fgets(type, sizeof(type), fp)) {
+        len = strlen(type);
+        if (len) {
+            type[len - 1] = '\0';
+            if (!strcmp(type, "PVH")) {
+                fclose(fp);
+                return true;
+            }
+        }
+    }
+
+    fclose(fp);
+    return false;
+}
+
+static int xen_pt_map_pirq_for_gsi(PCIDevice *d, int *pirq)
+{
+    int gsi;
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
+
+    gsi = xc_pcidev_get_gsi(xen_xc,
+                            PCI_SBDF(s->real_device.domain,
+                                     s->real_device.bus,
+                                     s->real_device.dev,
+                                     s->real_device.func));
+    if (gsi >= 0) {
+        return xc_physdev_map_pirq_gsi(xen_xc, xen_domid, gsi, pirq);
+    }
+
+    return gsi;
+}
+#endif
+
 static void xen_pt_realize(PCIDevice *d, Error **errp)
 {
     ERRP_GUARD();
@@ -847,7 +898,16 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         goto out;
     }
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+    if (xen_pt_need_gsi()) {
+        rc = xen_pt_map_pirq_for_gsi(d, &pirq);
+    } else {
+        rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
+    }
+#else
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
+#endif
+
     if (rc < 0) {
         XEN_PT_ERR(d, "Mapping machine irq %u to pirq %i failed, (err: %d)\n",
                    machine_irq, pirq, errno);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c220cc8449..822fbacdf0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -23,6 +23,10 @@ extern bool pci_available;
 #define PCI_SLOT_MAX            32
 #define PCI_FUNC_MAX            8
 
+#define PCI_SBDF(seg, bus, dev, func) \
+            ((((uint32_t)(seg)) << 16) | \
+            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
+
 /* Class, Vendor and Device IDs from Linux's pci_ids.h */
 #include "hw/pci/pci_ids.h"
 
-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

