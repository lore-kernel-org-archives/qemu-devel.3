Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07E2CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5K-0006fF-Gb; Fri, 08 May 2026 14:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5E-0006eZ-AE; Fri, 08 May 2026 14:37:56 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5C-0002Yg-KO; Fri, 08 May 2026 14:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxKkGqmuuIs63zltx+H8jpj467ES8n7KOtXzXPIwM02/dd1mEI1MBXBT8s+WezDQnHMMyNuqu562eBqBXVqNOMW5jJhhPB7rn4QS6pQU4bMuW0kRp674LkGgD0YQxjj1gSGThHorCXr3pSoZo5oyUoBf7NTSm8CgYuxUcEt/qINEivYsL2ZEXgXD9lHmhwEfczFn560/O8hKlN89SFhwDuJdKET/fS+Kyp7djfYOLyaD5jnW2+C77P9qCmEXz3VCSzUFNARwDXurCrJn8gQowPUJfqWeXppPWD/J/rdMStrwRjOT/Lay+WYC1H7lDfKB+UnUON9VOGe/v6QlXvo5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzeKAO+rXcuLDHgcb16pHML/zJ2nWk54OrooHG4hgVA=;
 b=Or9KA3WQ6FMsrXolc7Pj/AxJkQMbBeUESYatqwg4KYveKDz66cuLOTWgo9+YBFa47KRPW9vhOR2nH9tGiONCk46zfCBNijXG3qpU8gqJpX04hJzF5bDDWBncAXmC9iat4uQGtWV/Cb17f8tX+4ZT7CFiVu9cvyAmQXe58WJRvL9CHvywXwMvhFCUJredf9sDJf4lFXwkctI6+Th1C2MNITOKMVCKChsfyRC7cF6WOszt8Kf9N4Hjhc5RS7gaKLWV8bPDhrI0GKztaOTwRJHz7TlugQDiId/B5yy1hCWY4InbdIIUsfBDeUcDlFqHMsydsZrOLoZfQ/+O4w/itPaIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzeKAO+rXcuLDHgcb16pHML/zJ2nWk54OrooHG4hgVA=;
 b=gszBdSVTpMaxoxdwTiSq6obN3yvUfnJgL0y5yfBQa2TLLjxpGyFZjnOzStycrK6u1WQY33atEqA1WCtGJKA19PJDXWRuZmfokJh+wMZq/KgDPMUGUNH8SJlgMoh5aXKNfEGzEwvtehNyuZHx88ohFHdAvscnL6MPYiSr2ijYanykyOuL4bk6gFoPj8f5kSePtKDeq12PayE64jmd6B7k37DxwOt3erxq/y2JUAWCIdRvgvQpa7892e/Z65F1A4KTD3w4eTjaVAV4jRy6WjtBXA+6MHDdm7uFFrjhD3JMOUZ6eCfE1WUlV46CayNd65gA/K0u2TDqIdUNZW1rn/zMsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:37:44 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:44 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 1/8] hw/pci: add fixed-bars property to allow fixed BAR
 addresses
Date: Fri,  8 May 2026 13:37:10 -0500
Message-Id: <20260508183717.193630-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:52d::34) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 367e1f7f-9c98-4194-e3b4-08dead30e349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 0pb1G/CMYMLLce3OgjPr7PH4yHgqHV2y3ELixEVaSgl1O22hP0GXcz/ESaWd8bEMxRg5P2vjABtOKcMYabBgatwmiUij+IRPLB8G/8/L578h/S5CcNdXjCPFug1NlF1OuE3DKp6n3m0Rm3X5ijiX/CDxaUsDhUyv01ek7YoDzJjdOoeOmGdW8lZItkucuiIUdikGnBoqad5qDQs5m8UwJ/+BckEGviJ0IDZSl0PAfgHw+8YY+iSAqn6pT3iV6tLjGHOjg4w/JwTKxOSLDYXN1NxVZTe76WX3VWgOfXA1NNgTtpFZxqolrdZqFQDaiK4yQhK/KdT1f2mrn0qFShG3gZ4MsQ3Xfvzo/RcRpj4Jy3vCSZRpsd4qvp23GZZSTg9VCetjC6upCvpsROq6VJ1sPOR6yfJJ4hgIdS/sEnX69kSeeITU0eVh04HxSsWuRz8gLIG+bF1vOKTgP8cy0HFMtP8dK3ptezFpklw3R69X8khdPKuQR3ybmrSxjSOJ/Y66+qB8VW4g1FHz3eJJ31tlt5zTHJdH5j1np0vSFQKS607p76RH2ZmsWk6W4YQXUVVOAB9vNyqTmgUjufUxNkhn8XyGHnXGtLlvnCrgAJe6mmP/tIbPSMaj97w1FqLhTInMckyCypmdNtce30fYTFP2C4U6SI9H6+q8JuWFzSTLgo2dTK3xMYx/rBkjwbL6vzg9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ry/S1oklQYrbDDv5qYtbAmtRiRwsF6EF+zzV4UVIr9/+N56+bWSM9hphlYp0?=
 =?us-ascii?Q?bHj8MkEEdXbQG117itWj42LRxBBA9k0zzL95ZmfeIaL/8Y33qbK3tcHieCBM?=
 =?us-ascii?Q?1ja4H74ftJBp52QETZ18RafcS2NzcB+EslQvOAv62Xxlt+DsmTlfNBsw0HVj?=
 =?us-ascii?Q?Sn4jhEsfdODQ0IcQvd/Or6CtkSmk5+if7g8kE+a3lt6vRnGjCHEiq/MeKTWj?=
 =?us-ascii?Q?HfkfSgy349HwqQmyRn+ST8WSKpey/3GXD5c38kOiOmmQ/Pahze/gEqJGbEHB?=
 =?us-ascii?Q?NmIC22M4NgZmRaUwj5fS+ahHtDst9TJqzPdBUVakAsmwYh1FaZWZUS9eEpBx?=
 =?us-ascii?Q?s+4egGspg0BsO7a7ykp47wV03O9lDsRtYr40+wqV0rAsNuEYPMFA10L+IOpj?=
 =?us-ascii?Q?h662b/OC/ipXYEj0DEuIydHd9JbFVrckDYOnT1C842vioXcx0PVcBgECvvG1?=
 =?us-ascii?Q?F+Q0Z7bJQ19Q5bPHdNOQKiyTGh2ixaa16WjYcsuZ4FGznRgxQZkn3AGNTVrV?=
 =?us-ascii?Q?4nHVO02/q0M10+VYaaoj8chjhkOQLjqsCqjESrpeic0TG7UA8pGr5nJYRkHh?=
 =?us-ascii?Q?O38vb9hVv7scmWM7RgSIir26ReQhNOyDElu0IlZI7m8kNDsI25E2lAYqaeL7?=
 =?us-ascii?Q?bWIjjiLj1bJeptZBwH8c6guzXrKYyh2WR7LeSJuGODwGyFr0KQmFdoP4yAl9?=
 =?us-ascii?Q?pM28ifTnKVeA5zmuAvrx2X6hkJnD93t7YNhjOO3gVDoEI1wpuAx6l7n7G0fg?=
 =?us-ascii?Q?U3Am8cOcWj3eJIG0Ro3X0bk68E0YQiTsjzQKpVINO7ES92ADueo9KTQjDeuq?=
 =?us-ascii?Q?YRNLxBMNxcXckGbqllObz4U8dcDCXuUFpbQOFnEyc4jjwG80GleVykHDqMjC?=
 =?us-ascii?Q?eRGqSpE0PWWh/QDzbsfBupp1tLC50JXLxGHoGqn6LehXixwuoNnpIMM10x6j?=
 =?us-ascii?Q?QmogR2UUkzHmGvx7PJa82i114AYz0vy6XqNmLOox9tdyvaIRQRbEXX/4BesK?=
 =?us-ascii?Q?DOQqeyeHkWW7Bu1UckjHwPR1FMxBrF8F3iiNrr5NUTUepuCoS+O/2yHy2rEN?=
 =?us-ascii?Q?Cs64MvxiGjOS0JWP/OkAyx8kATRi2wQnt5E1s7jPgeW4V6twgvXkylWO45et?=
 =?us-ascii?Q?jfiSspINMvyxMgCw/OyRzGaWLrEe9kunFvpXdhjIJlNTLeYCS6iM1PIpMygh?=
 =?us-ascii?Q?F4OkUvlg3K8e7Pp8nZHExnz3b8aEZFaa2xS7ifzaDfo9jvhAMNFznpDW5O8K?=
 =?us-ascii?Q?bvP/wzbJNXYds92pyOpMgvhu6bTsScYpq4dPNRPs1BJ2aVrfQWeksGxS7e6q?=
 =?us-ascii?Q?OJPoxNtuezXV/l8qcOM4Q402MxsIy64rtMm3QNO/qyglfV8s5ZCvNqgEszts?=
 =?us-ascii?Q?Xig+u2+9PXZ90mnPBVBUuYwKEnJxB8Vwj9drX7QPKVNOsrnJjCbgYY9nbnox?=
 =?us-ascii?Q?2u3JnkJzAFLGq6ZcJBFwA0nxXtkWTMpL2XtJCNkviYpDw5ScU79BCEc5oXjv?=
 =?us-ascii?Q?UU4bWEbDJXLr6ZAqFmk7jqgffbOrKk/jEHn962hc/Hxhqm/Dpqs6EpAar/l5?=
 =?us-ascii?Q?C23Sj8rLCF7DuBMYFmBSOpIekohNIrKUf8VnBQa9ZYySoQ7m40f0MMWAuN6r?=
 =?us-ascii?Q?+T4ka7WnTKocueIhlgX+PnRJXFhu6tw9C4KOhl9atkobJ/nxzBv1A+0iybcQ?=
 =?us-ascii?Q?nwj6/G5KwNozGm1aUFn/2B+r0ld3C2qT7Jcg7hF1sZiwrfm7iJIDeB1gE3MM?=
 =?us-ascii?Q?byNhFppPQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367e1f7f-9c98-4194-e3b4-08dead30e349
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:41.7928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdjBOkoyMNRU2udJg+30J4MYTBrDMQ+ORe98hlReOP7hXjEt4lJRB58m0U3kyfHGzxGxy9qeMzI3oNsDjwVbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=tdave@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

Introduce a per-device fixed-bars property that allows users to provide
fixed PCI BAR addresses for PCI endpoint devices.

The fixed-bars property cannot be supported on hot-plugged PCI devices.
PCI BARs for the hot-plugged device are programmed by the guest at the
time the device appears.

Property format:
- Comma-separated list of BAR entries, each as:
  barN@<addr>[,barM@<addr>]*

- Example:
  -device vfio-pci,...,fixed-bars=bar2@0x6b8000000000

- Multiple BARs:
  -device vfio-pci,host=...,id=dev0
  -set dev0.fixed-bars=bar0@0x400000000000,bar4@0x410000000000

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci.c                | 108 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |  10 ++++
 2 files changed, 118 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00d..054fc2c0fa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -50,6 +50,7 @@
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
 
@@ -81,6 +82,7 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
     DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
+    DEFINE_PROP_STRING("fixed-bars", PCIDevice, fixed_bars),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -218,6 +220,103 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
+#define FIXED_BARS_ERR "fixed-bars: expected barN@<addr>[,barM@<addr>]*; "
+
+static int pci_parse_bar_token(const char *tok, Error **errp)
+{
+    int v = qapi_enum_parse(&OffAutoPCIBAR_lookup, tok, -1, errp);
+
+    if (v < 0) {
+        return -1;
+    }
+    if (v < OFF_AUTO_PCIBAR_BAR0) {
+        error_setg(errp, FIXED_BARS_ERR "invalid BAR '%s', expected bar0..bar5", tok);
+        return -1;
+    }
+    return v - OFF_AUTO_PCIBAR_BAR0;
+}
+
+/*
+ * Parse fixed-bars=barN@<addr>[,barM@<addr>]*
+ * BAR type, size, and alignment validation is deferred to the allocator,
+ * which has the full device context needed to perform those checks.
+ * On error, sets *@errp.
+ */
+static void pci_parse_fixed_bars(PCIDevice *pci_dev, Error **errp)
+{
+    Error *local_err = NULL;
+    char **entries = NULL;
+    char **parts = NULL;
+    const char *endp;
+    char **e;
+    uint64_t bar_addr;
+    int index;
+    int i, ret;
+
+    if (!pci_dev->fixed_bars || !*pci_dev->fixed_bars) {
+        return;
+    }
+    if (DEVICE(pci_dev)->hotplugged) {
+        error_setg(&local_err,
+                   "fixed-bars is not supported on hot-plugged PCI devices");
+        goto out;
+    }
+
+    entries = g_strsplit(pci_dev->fixed_bars, ",", -1);
+    for (e = entries; e && *e; e++) {
+        const char *entry = g_strstrip(*e);
+        if (*entry == '\0') {
+            error_setg(&local_err, FIXED_BARS_ERR "empty field in list");
+            goto out;
+        }
+
+        parts = g_strsplit(entry, "@", 2);
+        if (!parts[0] || !parts[1]) {
+            error_setg(&local_err, FIXED_BARS_ERR "not '%s'", entry);
+            goto out;
+        }
+
+        index = pci_parse_bar_token(parts[0], &local_err);
+        if (index < 0) {
+            goto out;
+        }
+
+        ret = qemu_strtou64(parts[1], &endp, 0, &bar_addr);
+        if (ret) {
+            error_setg(&local_err, FIXED_BARS_ERR "unparseable address in '%s'",
+                       entry);
+            goto out;
+        }
+        if (*endp != '\0') {
+            error_setg(&local_err, FIXED_BARS_ERR "trailing data after address in '%s'",
+                       entry);
+            goto out;
+        }
+        g_clear_pointer(&parts, g_strfreev);
+
+        if (!pci_dev->fixed_bar_addrs) {
+            pci_dev->fixed_bar_addrs = g_new(pcibus_t, PCI_NUM_REGIONS - 1);
+            for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+                pci_dev->fixed_bar_addrs[i] = PCI_BAR_UNMAPPED;
+            }
+        }
+        if (pci_dev->fixed_bar_addrs[index] != PCI_BAR_UNMAPPED) {
+            error_setg(&local_err, FIXED_BARS_ERR "bar%d specified more than once",
+                       index);
+            goto out;
+        }
+        pci_dev->fixed_bar_addrs[index] = (pcibus_t)bar_addr;
+    }
+
+out:
+    g_clear_pointer(&parts, g_strfreev);
+    g_strfreev(entries);
+    if (local_err) {
+        g_clear_pointer(&pci_dev->fixed_bar_addrs, g_free);
+        error_propagate(errp, local_err);
+    }
+}
+
 static int pcibus_num(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
@@ -1473,6 +1572,8 @@ static void pci_qdev_unrealize(DeviceState *dev)
     pci_del_option_rom(pci_dev);
     pcie_sriov_unregister_device(pci_dev);
 
+    g_clear_pointer(&pci_dev->fixed_bar_addrs, g_free);
+
     if (pc->exit) {
         pc->exit(pci_dev);
     }
@@ -2369,6 +2470,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         is_default_rom = true;
     }
 
+    pci_parse_fixed_bars(pci_dev, &local_err);
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
index 5cac6e1688..3e46876985 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -179,6 +179,16 @@ struct PCIDevice {
     char *failover_pair_id;
     uint32_t acpi_index;
 
+    /*
+     * When fixed-bars property is in use, fixed_bar_addrs is non-NULL
+     * and has PCI_NUM_REGIONS - 1 elements (bar0..bar5); each slot is
+     * either PCI_BAR_UNMAPPED (no fixed address for that BAR) or the
+     * fixed address for that BAR.  NULL if the property is unused/empty
+     * or the map is not yet allocated.
+     */
+    char *fixed_bars;
+    pcibus_t *fixed_bar_addrs;
+
     /*
      * Indirect DMA region bounce buffer size as configured for the device. This
      * is a configuration parameter that is reflected into bus_master_as when
-- 
2.34.1


