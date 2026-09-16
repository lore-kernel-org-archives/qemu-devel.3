Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1CDC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uns-0006RK-Fr; Wed, 16 Sep 2026 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unr-0006Qv-Hn; Wed, 16 Sep 2026 14:56:19 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unp-000632-Np; Wed, 16 Sep 2026 14:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz1wBi16GberN2nw2LJO2CoCEDWE2eApdmFMXoj4rvttxxNGxC5wnyY+KsOgI1pHTGU2i3sM6nRG5JV1mNuzNbODnChS9jjXf6KERD2b4p9ExCapT7HRZtwfDVdLjEOd8flfSUU1FPWwusxRfF1OSY6oek0s8OTlaOwDZxo7MNDWmK2SiogWO4ofVpn0jVKPB58FsrdyE4m0MZ3Zr16lrAtf1vOHFYqUTKAepO/0ZDKIzizMRQmzC8nJCQBt5DXjoBdcu+zJDcT/frm1+ZXWeX+88b3+nxppNoR8DrRo1eXuOdR/yRBVzX5n2KD6Um79VacdSzBU7Of+LofXo3/DTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtxGN/E7aNoI6cMdunbBKMCnX14ycMHQWtXjCKwOimY=;
 b=GUMlYpUlF1T8g8/B/Lm8OCy3EHxTDaMsnIEg3K+q58lG891fu8vRBYncLTI9GS3o7o6RG/C544ny99i6XE6sxbVsD9VLgfaxa86SRFVggjKY4Qw6Wv7DRi0sSbxG188tb1INdAPCicYd++T4jaIJfg7ra/rTGNrE5AYC2/e6pZMK6ej49azO6aqyJFKIri09D6g3CVUbDRQnK9+/zxIFWfErvZnlUOuOMtMscBaXM5+z7gTYa4hn09AIKA/dX5of0AzIh3xa0jJ09WCsNC+HOEsKO4l4t31WqkAAf/MeMm033d262RLtCxR/Z2W/m3lPL+Wn9hYAXCox0fSsWougMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtxGN/E7aNoI6cMdunbBKMCnX14ycMHQWtXjCKwOimY=;
 b=tArdgwZtO2PB2whYr/GRrkLVpz+GlbmE/hHPj64ue5MdPA73CpO6tCI0ldDb1buS6naz4gVU4OfVQzKAM23ohV1P/UkgFEl869uMB1ZVvS0DqHfDiQzPhPFvQjtLlJYpzhx0azaKDrs6JoOmO5SZBV85dtWgPGL3Z0pop6OzSHbeu+0kZ+KqDGvQBp+Li1mk9VtC6tKUhLjtQ1fKPcDhTDyrYIrcAiAJHyBN1VQGq9pb4HpbJWT2bVakAgW0/4bwUhT4MtfhS70Bn/t+uUMB2janfieKBvfah0qBYLhiLkDyP6cXnevulKW8IED0+dvNPNaKyO/gr/2GCMHmHP5faA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:04 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:04 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
Date: Wed, 16 Sep 2026 13:55:50 -0500
Message-Id: <20260916185554.917526-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916185554.917526-1-tdave@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:d3::19) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: af0e2cbf-b3a4-4b1b-f9f1-08df1424284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6DqfVu3XfdcQPnv7cJj+AqMw4GQfV88hhJjIM5Qvc2V0kfIm1O/Rfvo8GuI/QyvpkCZXYuKqULfUJ6KMtcrNO3kkOgh5BDoSIS4MM92Rx2FvjLacsfvl9Pki42RqiKISnCCZZEhxjKwtnIfBoYZ+m/TpKlJ2aPVRm//mgwBtjvUdcj6ywYwYMEx0MZET1ZI7PTcFqPXT5i/3ewNlw0SRB6YT7Uo44+sKmqZY3OXPDDC7xERirOxpwDOp/UnUZ3OzThh6g0IjZPXtqU2xL47OxDZyqCi0idT/V9lueXS2iaLy37NGyGtundlNloJnWMqzlZmQsuQRJVZZxmldjocnlDBZdH5nfpLwzd6zelj1WXogoqhfNYti1ML7vbeH3yMCECGpRToBTk6xOBAXAg7Y7c7BVpZbkQ/+o9/e+LY0MdeMSBEzbA6JW25gFK/ow3QwsZUaTOaM2NHYgqBGz8sjYMRkNIKrvueICbRLF/NEyapgDkzf0CqwLDKizkJ6yF0c8Y0ULjndeBc9ibo7m0W9h+csYi5f8SjdZjAByrmDvbD5N0dV7yZfN4B10G8KMWVh+jfPwpq3wrO7rvl3UU3E7AZlmL8LZ+q5kkst59g1DaylqcJEhbxx10gshGulS3wUWwCNdzW7maKaqqS9NfHB+EP52s3hiHKoVODYUAseU3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiNKEXLgpRwyaQSh/iI7soDX7NV2DPXqqzbMK4IasdP7chzzHwVL/zIWjMff?=
 =?us-ascii?Q?56WXRUW326yInXoam0v23xYFxFdxs72ilXIbevJGvxbFDpNBJ44LI9R2cRkA?=
 =?us-ascii?Q?hFrrgORLwbUhdTnPo82RKZFT56deg0wkr2IujtMkU2hk4tWI56L+CyupWY2V?=
 =?us-ascii?Q?PjRq4uvp+Yq66NlvDDYTx4DnNSGr0UpCm+CcMu7rDAJMduRqdFF1HGERU5h1?=
 =?us-ascii?Q?VkE/CkXi8pj95ZV5X7E3g+n6l3aabis0lS78Z6Epn4SGx2L6PXAtmjAJnk/l?=
 =?us-ascii?Q?XVNGglSqEYGZp0ao5F+YybAMvya3Zif7NrOCpFtdlzMw8CMagut1OWm8VFJO?=
 =?us-ascii?Q?HzwoNjKuws/UreGnYJrLsoA/m8sON0dp+ddi9R/gFniOYh62twHEoNmb4Kro?=
 =?us-ascii?Q?QZ3iFylBJhkO2Jqq/xMhyb00Gi0foxyJWmomf1RxcDHzGDJSjbOr+xvpOgou?=
 =?us-ascii?Q?hBxEyFP9+al03rVJezmN9j+HTyNAx8fDW4TQLK/l0Nd96xqkz8Cian+QRb3J?=
 =?us-ascii?Q?U+rHskXw+V//tC5eGoDtcfJ4UtyNldwb+vh2ybaS4KeR3yj9oNMLkq2y+LHt?=
 =?us-ascii?Q?hOWLZ46Ygc5izX5tK64V2kT5l8cvXDKVtuvWUKx7bgOQcFAfq8l/NwAO+JwS?=
 =?us-ascii?Q?m7OJ0o5AQ1OA8/fHR32lqD/iSEjKjevd5CGX880FxTwk9RH7nqymYkwE/Cu1?=
 =?us-ascii?Q?EAy/ZTIMgdjpkqgbC0CtXm+WV3U/jKXj5O9cQFBkogTapKl1Czz9MSrUD5uO?=
 =?us-ascii?Q?Uo7QrnNYxMI56Macn3sCPWXu/OWoatODqxx/qAJh2IdqynIpHUaUHA0PZAYF?=
 =?us-ascii?Q?aoJ9rzYPiuNhfgtu6BJh7FZmIFjoeR3B7dAWr9yF0cste3lXkrCp1RVnx8oZ?=
 =?us-ascii?Q?w8HFq2pp00cF1vmzb0XsAhjboffEhbjD92mSfjeUCUlVChRCC0otmUd+P0DS?=
 =?us-ascii?Q?/2iLRJnU7pd7yutGYrigGYhuEWBpVK+gAmkZadY2deCj9P0ikGB0T4sRJqsG?=
 =?us-ascii?Q?eR0ZJ/mT3AE9Z3qDZQrqRsTwLGzpfx6BPeynzJwzYOQaxugM6QA7ISWmG6HZ?=
 =?us-ascii?Q?iatAU3JXuUqPL2IgJG+JQfnO7aZiJvvPZI9pXs9MQXsmSF094+ufBYohTWeI?=
 =?us-ascii?Q?BaBkhQG9nOHAZJgjdcnidMBt2+eymQ+92c0cWCxurlfS4RAzlhpECtzgjEI+?=
 =?us-ascii?Q?ZSEJU/Nkm4fIRuY3vdyvlgf09k3pZEMCO5NIGz3wbJ4VhrAQr7ZEVXZbRlwr?=
 =?us-ascii?Q?WuqczZIjV6TeS5xV+9taQM11UQutbRlJPjvbKuCP+SB+QXPzWLWinKosACRm?=
 =?us-ascii?Q?uZ0B/JO1x9hYRESXoO7WFGLtkbDJA391FB3ug/a46INPZMF5GUKuF8fG7VJt?=
 =?us-ascii?Q?dF9xBWU3oCqMX4MCCt1pz7Vg44cBxb5ZGeBq72ANIvoSTK2lxMMq8Cvjde2u?=
 =?us-ascii?Q?1SYLz3CgaJ+KBRw6skg8mQski3+pMICt+OT8AV7c0phpoOTyeaJ+R+l8hRaE?=
 =?us-ascii?Q?udMNp1Lc7VnPJn2zWmgCV8MkjU2hxomOJ9FxIJBLVWQVthoyxvOfUoI2ehVJ?=
 =?us-ascii?Q?3G+LQHvpaI/XyaKfZ70Nuc2IkNzyk7xDwkvMsm1MD6Zi13CMxY+xOJZvFypy?=
 =?us-ascii?Q?L+Ud/SIJq7zbqyV0P/UwziNji+ULFJYcwaaqzbb5wgLu18cPwBR7ycKL0/FH?=
 =?us-ascii?Q?v75S9JJzgO9IeHRFDW2JMITxT/uWnplOsrwg0/KJcY/n6mg0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0e2cbf-b3a4-4b1b-f9f1-08df1424284f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:03.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMT6urOM32nTeMVuWK4psudYkwJH7Ko2AHBfShhpp9hJDeR+SRDmUfAoUpNCQpmNhdDVva7zUCrUnyi2YXA5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add fixed-bar-N properties to PCIDevice to allow the guest address
of an individual PCI BAR to be explicitly specified. The properties
are available for PCI BARs 0 through 5 and accept QEMU size
values, for example fixed-bar-0=0x40000000 or fixed-bar-0=64G.

e.g.
-device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...

During realize, validate that each specified BAR exists and is a
memory BAR, and reject fixed BAR configuration for hot-plugged
devices.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci.c                | 43 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |  7 ++++++
 2 files changed, 50 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb..775fef1beb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -89,6 +89,12 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
     DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
+    DEFINE_PROP_SIZE("fixed-bar-0", PCIDevice, fixed_bar_addr[0], PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-1", PCIDevice, fixed_bar_addr[1], PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-2", PCIDevice, fixed_bar_addr[2], PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-3", PCIDevice, fixed_bar_addr[3], PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-4", PCIDevice, fixed_bar_addr[4], PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-5", PCIDevice, fixed_bar_addr[5], PCI_BAR_UNMAPPED),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -228,6 +234,36 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
+static void pci_check_fixed_bars(PCIDevice *pci_dev, Error **errp)
+{
+    PCIIORegion *r;
+    int i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pci_dev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+
+        if (DEVICE(pci_dev)->hotplugged) {
+            error_setg(errp, "fixed-bar-%d is not supported on "
+                       "hot-plugged devices", i);
+            return;
+        }
+
+        r = &pci_dev->io_regions[i];
+        if (!r->size) {
+            error_setg(errp, "fixed-bar-%d: bar%d does not exist on %s",
+                       i, i, pci_dev->name);
+            return;
+        }
+        if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+            error_setg(errp, "fixed-bar-%d: bar%d on %s is an I/O BAR, "
+                       "not a memory BAR", i, i, pci_dev->name);
+            return;
+        }
+    }
+}
+
 static int pcibus_num(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
@@ -2393,6 +2429,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         is_default_rom = true;
     }
 
+    pci_check_fixed_bars(pci_dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     pci_add_option_rom(pci_dev, is_default_rom, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..fc5f50a1c4 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -187,6 +187,13 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /*
+     * fixed_bar_addr[N] holds the guest address configured via the
+     * fixed-bar-N property for memory BAR N. PCI_BAR_UNMAPPED means
+     * the BAR's address is not fixed.
+     */
+    uint64_t  fixed_bar_addr[PCI_NUM_REGIONS - 1];
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
-- 
2.34.1


