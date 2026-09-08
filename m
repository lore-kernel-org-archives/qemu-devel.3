Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCD3C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yRD-0008Ri-JE; Tue, 08 Sep 2026 12:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x3yRB-0008RO-NZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:12:45 -0400
Received: from mail-westus3azon11010000.outbound.protection.outlook.com
 ([52.101.201.0] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x3yR8-0003bg-J6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMC0VwNx5iT0FnBckv/JYM8IHKT8cHq/tr2oGdhZ/YSGhFXcs8AYk3xkd9v6iwk+zWorRADuzgsVuo2U5+uKdqePFNoWMQR2VaMuAUCjhbH1YxbWYXL/7hULRM8pNDkNM6MOrfqmg7KTam+sVSxhATl4iIpDnXEGyaoFJrFx9f9a11JaF1gOqXUClEoNZtq8asgaMrv4xD9YITJvmJSBBg6kFhkGizFFRLfXx4C7fE+rd8YZmEYuQFOckQ5/R5ucW3a+DZzJxUSEqP8ruw4Gebg5BXt2GdZmLXv+atv5rDTBnV5en7FvuPUXA/4jSdWzZqytRgOz+MjNgFgmV3Vyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSrXjdkw5+wB3p+wqUYlaxamIOxn78V3L6s7gMDD5II=;
 b=viaDJUcG4Bd0d+FDRwk3CDsUW/dJPX+kOitu1d0ZeTLkLp30BAAkkPtWRJ5SRiQ85LK8d+l90fyJe9e9hMqCdRv5rvfBo2xzEfVOnW9twG50uGVfoTxVzhnbGUH8Gt74AzVMysK9QFFYseonlT1lR9AkmxtLXnSsc+E32Sts7DpHBM0xiN07QblsYKwwTLnCXp9RUf8zGPGrrLLgwCtp9gGx+LXUysdCx++6OeXO8A3jkW8qVl3zqdTzYlMRoNcK8JKQQ1yl0AuAPLVVaUsyLMCAZyhV+LN+XSHhed1E2zz2RYYWsRQgG/BjZLL09guPiMIlcESTafr1SOsFemUuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSrXjdkw5+wB3p+wqUYlaxamIOxn78V3L6s7gMDD5II=;
 b=ptZX+Z4efdd+4AYgubWDYPsEeXnmOsvbeeoI8Q120HHzAwfv4wpH68FSFkoCqbkomqPJGVWBmX/vHjn3qrt9PAFedyyr+2T6BAa1LxRuoSDXBburq120T9wHzKQHwv5FhorZPkotX1Ke1yKu882lPEGmm81tTZl11xvNfTwicM4ueRiEAf/pFd1XHtf+N2brUx4IlSvz6/9jH77ILWmlGvZtlWsQztCp4Y7q+il1Gn/jJmAVL0TuEGUyl9cfJ0t0NH9+NbQkIPZGyOADsyMEw42u1enIksjR3gXTV0x6TmZifpaSa28oa8ci0JJ+HEX9MnibOVH5XwjYKWu0dt4q1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 16:07:33 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.008; Tue, 8 Sep 2026
 16:07:33 +0000
From: Tushar Dave <tdave@nvidia.com>
To: alex@shazbot.org, clg@redhat.com, qemu-devel@nongnu.org,
 skolothumtho@nvidia.com
Cc: jgg@nvidia.com
Subject: [PATCH 1/1] hw/vfio: thread vf-token through iommufd bind
Date: Tue,  8 Sep 2026 11:07:31 -0500
Message-Id: <20260908160731.1658621-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:806:f2::27) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5b6659-1e36-4bf4-300b-08df0dc34ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: BHWZuRDhvW6ovDD4wjGiAo6ojBwjk3Xh/YIcImmc+WgrcZckOL0vm4z/ymherfUg1kcenqjLUvYnH308fkpULRnngCiV0WlX32u9vQLP7ZQz+GEZMjZ3oWFEtg+f4ldKaYLc325QeTpSz4l/67S2jiokt15dPFTq8kJyqVRexiMkMCWBPMGiLyQ3JCCXx4yEZnAzrmnEcgMZ2Pyb6rFqElCr3A3Fjj7i8cFn6ZpgkqpHpGbY69PpGZwzvbXtcEkY4/5FQ2hchW07snPwsWpmMhWojcZKIeY+t5Zwv/JBAOy0wAcbeHOZK1yrWYHW6wUJje54PrYkyDzOrNdAfbOXtJSxhOIM1dBef2HwE5P60Dpvt3N9VR84l8B8jTaN/441C6EtR6qmpy8E1E6JGxyuIl5ASXHnRJGzlsz7WVhxnzcZMaKZaw4OAMkQnatxxdOKmYFTW9xpVRxAJ4nkxvoSeCtqqSHY5YyVu8pipTEsZonn2caNHxkTzLyarJacY4msHKR6z7aLbyud87sefw3DGjrly3P0gkDp1D0UUNzCIFUGSVOcbEDAW6bRDqSwrVIko8AyiigZdt1m8zTkecuH27YQBmmi016i+oTBTk5v5m7pNpC8UfONgsQqdQu+X5JJVXv4BkgR6YMW9HQurSo6yfIyjMauw9jkTjuV56EmGDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xpTJrx1nVAjh/ANPEJvoI6g+XNdJnL9r62TTDEmDHZUXy8bfdU5bNfvBbYzt?=
 =?us-ascii?Q?TXfeOoJWuk2jgUHst4cRbPiABXesZap57k8CBXqfhhzOUdR7THQm/eKHIjhS?=
 =?us-ascii?Q?GlRrPWYq5ur67cY4jWshDfvYH3CO2n5kZgSqG+1tPubabc1kkc6F1rKS+MZ+?=
 =?us-ascii?Q?Dm9ffs8tIGDOk1SGMKJX4g+0hAmbIGcbGnUEKGqAkrxIUN+9kFp2iv4xOpcP?=
 =?us-ascii?Q?FHzkwUNKgyk62AJf6HZBtpuYCL8tOqILRyzikhqPPTLV/EdyUKSrjVA4aq/3?=
 =?us-ascii?Q?PoG4BN3tPZL8cvqmO+v1Ndwc4VCSeiJlOzylFmmZqAauBLtpTmxbZh3Xccjc?=
 =?us-ascii?Q?EikzHnHbxHCfmz8PpuSFw2J0ql3MoGH90XHa9aNIr/KVSnizvYtvbV7rWMsP?=
 =?us-ascii?Q?OsGXQ+I3Fkoyr5yoJIsu7gaMJVtCX3g1+8NZyy+jd3O6EHrQzbM7GqqEdmUB?=
 =?us-ascii?Q?oXmtH8+Tq4Okp5IIileqLOI26PxxVmUujDDv3+PBevwtFKtKoPJXxdFZ2WCf?=
 =?us-ascii?Q?ITUxEstjuDHGRGwsem7MD19Pd3+fWScwMPfCD2BbxFZcwTDDF9Pqq4xT3sfC?=
 =?us-ascii?Q?jeIC4k9Y0Ryw9XJR7cwdO44xDnTlqdeLYa50wQO9e3pFtcRiw8xI/DokyVjg?=
 =?us-ascii?Q?kdr8Nswr5ur8Qq7G3q2nhdQaXNErLxI3zk2xPb/qwtSklvyNVM3VGYvGNVFe?=
 =?us-ascii?Q?+tCkPQdvRWJyvwLrW1+ykEm+zihzMZJeNkTFAzIAj2cRjUi/+qpervFRRyVz?=
 =?us-ascii?Q?/OkyYxQ4/S9A7b4s2lZj4joK2I+xYy9tfbDXIXvRcUOjtrcMQtUliA0DHUSq?=
 =?us-ascii?Q?1gTdgZWXHucKWM+PSsKrhSHcYl/sy1J2ug6TBiXnAlr0WybJZ6vE3gWhZaKk?=
 =?us-ascii?Q?brrW683PbMczSdBH6CC9Ds1wRUr8i5ziNP7fu1wRjhG5/nWd/bAOHaRiD+mM?=
 =?us-ascii?Q?eJ4ypt65wPkjKVgsjiReVU7P+PKSZyieXY3RMibaM/8sGOxsdKxvU9NULQKd?=
 =?us-ascii?Q?p4ZUWnCA3d4dJSf8SAFgT9sgIxeillOmOezl/XJRpMHwLDcKyxjptA/m2iMJ?=
 =?us-ascii?Q?1KwPIOL5tdPAwuyNms0RrzGZW5gwmQ2hI3hfCP1hoqweoX4jZ2fsmacgmlKA?=
 =?us-ascii?Q?+T4EYS3aRVoDOrQfffhiCLU83hQNVX8W33eFpmDRbhnySVOL4HYJmKmaoxv4?=
 =?us-ascii?Q?ZsjlvYiNobQzMRd30ziuFEy8L7ODNqPIDNYMrudyNTfEEsb2jNk8USlk5Q1s?=
 =?us-ascii?Q?G8XptCcwXbVQNZqvNFD13ssbI6zqKq3XbfDum3DVrwmQ4+DcyGDQnrP6v/Mv?=
 =?us-ascii?Q?LA9OTvL7KPJwCOdWiBTGIPtj4tsRon7NVcd7NJNGdYAiCTqfLRwV3vAbgOqf?=
 =?us-ascii?Q?Y/f59qvBCxqz7IjX69ZNgc2oKUpaT/vNYLO331CwMoayj0GGwCh7Jir2rD4k?=
 =?us-ascii?Q?4+88mTM+HzT7EPYNnvQv5NjHkqS39QxaaoqZSO4tD9EIdICOQRcq2Rbxze+7?=
 =?us-ascii?Q?BWVcBx+N+KGZMNIE9uQ8IaHkEfwfX5nYFeF+Ww3h+GwVHedYyZYvln+T6igT?=
 =?us-ascii?Q?8/7RugbovadjirVlxA40fpIZJZiwk6SM7NMyp46sqIVhM0idzMUu7n+oi2vz?=
 =?us-ascii?Q?eMA2DVLO5pP3z4OLFQ5r+355lqSRtGxk106b6TPH4QcXCe4oZmEYhmr6kwXz?=
 =?us-ascii?Q?2GQQYPgPeHZNSHkC3XqaoV1zmEeHP6ipmVvwrwI6fNrV28c5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5b6659-1e36-4bf4-300b-08df0dc34ae3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:07:33.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH18eDWp2XfeJ30P02lmbaac9jchRKe0MJr44sL0rA2WiHJuA3lkP2JjyOyAX3490cFJFai5+X0pM4cHua8TRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
Received-SPF: permerror client-ip=52.101.201.0; envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A VF fails to bind through the iommufd/cdev backend when its PF is
bound to vfio-pci and requires a matching VF token.

QEMU currently initializes struct vfio_device_bind_iommufd without
the token flag or token UUID.

Pass the existing vf-token device property to the IOMMUFD bind ioctl
for PCI devices.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/vfio/iommufd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 242644aa00..de482128bf 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -155,6 +155,7 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
 
 static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 {
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     struct vfio_device_bind_iommufd bind = {
         .argsz = sizeof(bind),
@@ -180,6 +181,15 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
+
+    /*
+     * Pass the VF token when binding a PCI device.
+     */
+    if (vdev && !qemu_uuid_is_null(&vdev->vf_token)) {
+        bind.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
+        bind.token_uuid_ptr = (uintptr_t)&vdev->vf_token;
+    }
+
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
         error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
                          vbasedev->fd, bind.iommufd);
-- 
2.34.1


