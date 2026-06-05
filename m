Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E47CD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFv-0006Nz-Ux; Thu, 04 Jun 2026 20:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFo-0006Js-3l; Thu, 04 Jun 2026 20:17:41 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFl-0007yG-2Q; Thu, 04 Jun 2026 20:17:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAJ86ZSkGLdgDn3rDtNxJSdqbdRyf6vcHvvpZZSo5CtO7353PmopvnymXYDO9dfEC0UXt8KfPkMkAv8pgIE4PVDyAqKgDa/QFqnJR6I3YE6geb19cQYttNJq+nz4BWjr5TZESRJQrxya6NuESnUdBXXFQzXH/ohagT4keY9PDIDvTLSZoVMqeVv1/F0h6EPAXRps6InBOg00Qhn/GQfcIhGdfu3tyBhXMe4+TzPm8oh3kZAFnx07iF1MUWOVuhxPUeg2lrOAbwveVvlbMEcMGourFDCyZGDMktDK6DU7Tna+D6OKntDryo5Wp39xIOHN6dSEQ1WhB/h0k1IMZoXUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkAj9ZY0UOhtCnOro9dVhATlditlLS3e8YO7tQkIb6Q=;
 b=PTiy+Jdvs7qW/J4LbrGhySEIRRBELPbpGh9yCA5Otqsj4COXbE5oxKzAhoAf6Qihd/1/MhTCLzp3ve8QShGOuRhQloFwA+WEZKx0qo5/Ot5sUX5TFYHv78nJhWRlddq5YX0uqzBO+oXEFqZX8fD8JhjaepwOL0sYxBCVthIr64m0aFiSZgaJmgLyZ2KC/PYKAVlr8rhpHeeiOYvG0jlmfwO3s6Ero31R5odzqGIEVc0cm1arb86ab8OP+zvywWLc7m/S5P1x1jytWmr7tFQOqnvLZNlqQPVZ696N9otMs29+/ky8YIG7A9EMt6fsgcXE8ryjNx+c6eBG6uiYwTmpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkAj9ZY0UOhtCnOro9dVhATlditlLS3e8YO7tQkIb6Q=;
 b=YhCZRVXy8Uf/SGOpwqQx5idDR/R8mS57sCXwxP5y0oGaT/qZsQVwmQjSy4vOKMFyyHaija3JQ3j4wvymkAbaN7Uxb1+tpwai9FYa4BbdwxfqBUcWf/XDKMjp3At9itpDBCmyv2ADYqxgB3NAjJeCe3rGvsDN9uU+2L24ZQJxlI9wUmTDMsg1N2sOxpl4nSPJ61+ZVfK4C0N+RrwqsvAr1rHbe36qgP8j3/qqHb/nMJUDMv1xYVF4aneR3YjYubDilKZcgbzdlU6kUPo6J+ODg/Fjk+Co4kPYLvZRZw7ISLulkSfgupTTspIkQSNXI6/eGPAvkHv5ySpIaU0PVG6jjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:25 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:21 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
Date: Thu,  4 Jun 2026 17:17:05 -0700
Message-ID: <20260605001712.1823737-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6514a13a-72ec-4130-81f0-08dec297cf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xMzhLKtJ8mfm4bc0UdJ+kHemaR6OswFxZT4affiBfMfyC84hXOgTclGOKgo7p5vtZ4q4BtY/gU1J7plrVA0zU51IPN1EbPz5MA/hbOodbjlaGigKSnSP7CSfQbukKtvXTdJu6ENEqO+tNuXVkGCB48I/IkJaQ8MbqvStsdJRSGwCyxw9gHBiipZSu/j5hWsVwBA7PPO2hLG4U0iWHn5/K48OcU0qx3PsVKhGTmbAv5wW5Ef2qjv+A5jiDsN9AtXAfFaM8RslSDwYo7Q3X6glIBlkhyRvKAYGRsEDOuEI4nxQXKJ9lE683CSISYsCXNYi5QjP0s33+AqNGADS9j/WY3KDnZSpNmyiCYBD2m9WILfuxLvCT7e2DPO2Scn0kYoMofJzQb35CJJs7gzS6kZJdqhJYK1Lo4D3bUlVYc+XBII6SEqabV/PNuwlgJTRyrZ4OT6/rWnLVvcfCgaMZ+M/OQVOYlL27QgKk7cvWpNP4oWIcNm8V5jytRljMLw8AJUQsVLM0P8YLPv/xzqBflLgyn6klW6UJoeJMe/cYauYCrK+zAgpMxHZqrFjlRJIc8YX33vQ9rcZAXqsenSYKkec9BtTib/vzHRRqBd3ttVElnc1P/4lW9c2RhdfwoI0/0u5l1mlwOTXMGjOmjGeOQiQsb+8BG4HbpldGn0BzunSwxxtucnyuylqh3QDKwGpmfM8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlUO78vvAppOQgoJ7Rp6gn6W8VKj06/X9JRDxjZ+uJi0aqfsGc5xjWleBHkm?=
 =?us-ascii?Q?hl7wKzniZCodzjnserPiJTkWPMJfqdzy76AFAWBbzrc1X6DaOL9gYcVsmyC5?=
 =?us-ascii?Q?lqtTd8tX79cm/MH53TbccTIaRQUS3kGejz+LEkUbZhuTOzW22/fFpWpL1zfr?=
 =?us-ascii?Q?QwQUTVDk9Id7ZKdyOzsw+D7pAMBzuWR7R7hHA+Q0M6xxNu7IFKgIv5GgXcEd?=
 =?us-ascii?Q?3y6iekp64Ui3ETiRESQFh7HabCNV468v77bDcDJsM1Xv4GRaVB8rfvo3iqAN?=
 =?us-ascii?Q?jBZBX4ut7j6FNWiqWMyPQptaqQXDMw/pnVDkrHy58X/XjOD6C7KQgFvBo3Ma?=
 =?us-ascii?Q?WM2w8a3hBUZvK0D5JggtlRFJMG9V9KxHU3dSn+Y1YpO2DSuJz8i9UnJadvCi?=
 =?us-ascii?Q?Aar3yVCGed6NXZ+Lb1p9qPnbwflKleGqd+Fm7JjPBfXHAl3Qrv7j8aKY9lOG?=
 =?us-ascii?Q?6UYkPQUEUwdanNd/BXb2KObxMxxWd024f+LXUd96OheGzCqO6Of2pylEaYQo?=
 =?us-ascii?Q?3w7OnnTtX3gWaNvQrth176NliGl8l9uootxiLvfxqRUbnYl7OQgoUFYMEc9z?=
 =?us-ascii?Q?Z9xezcXLX5P3Y+wPxfNM7yy3PcGfmIHYE0lvdoSQeUbm0isqSpUKT2X4+gRo?=
 =?us-ascii?Q?y6KOIvhnd+wBBX9VmmgXTp/91jd3ywoCma6Y+1hsg9LU02xg2RDFWQneTJgZ?=
 =?us-ascii?Q?NWZxxhPGIF/kmoBbuiSWSxJYKA02oTj6dLcNek88BfvwgPTR0tafnvDVEqMs?=
 =?us-ascii?Q?eAKrZNWd2OodabvhVvusI15zphUWnMRV2b2WbFMaKjqGHdy6T6RhMEgLsO+x?=
 =?us-ascii?Q?VSX0Kw7Mx4RtW2Viiw+8fLhifvLCHJ1ypeFM837eXI5vB5Rdtvw+sUUbGr2N?=
 =?us-ascii?Q?V2XG+auoAykDK9enVe+Iu4ni5v7SJx5OwZpdBt1mXt4RYS3ft9jLDNBhMWkr?=
 =?us-ascii?Q?wbv1kjsPQmtLHfiIxUM1IrJul2mWTN7PUcODsk/ExCfewaVE4SU+KmUOWr9U?=
 =?us-ascii?Q?rmO05Lg2JDjqFxK5mzdSxY2XQ8ABxLkxrDM3vxRE552AaoBTuWc5t132WacA?=
 =?us-ascii?Q?ECqZPLVvURsFW9oJJ2dAcshTRZMtK/3M+28any1WZGL/tOpRKNFRWbS6dQ2l?=
 =?us-ascii?Q?IOwgbUodI2t7aGdJCQ7rMWv1JAq+4S10WF0Xd0QK8Z73PXoTKfBMSSZj+hi+?=
 =?us-ascii?Q?3GubP/okljpoCfpm9viQW0KhyFHS4sI+zLB9f3Epfq2Lx4x5Ogj125v8j7wl?=
 =?us-ascii?Q?f4gY/on0ouDfRAExnFhhmKYfSInw9jfPNy/MT5XHeKahMVTHyoYDlnJbsRhj?=
 =?us-ascii?Q?NaJV8zKlI4IYal1QVRYooQn9moy6Mh3zIasglYFHqRvkbhIW4Yz+nBhhC+gR?=
 =?us-ascii?Q?ycSr9HQL3YJuMVPrCoToENtvnYPfv27KiC7yABOKn9hCksVczk9dYWMGX1Y2?=
 =?us-ascii?Q?wdjDH8UY0bHZDDI4/yJjRvkYT1R2h9XC4iiMj519IFYMCYhaF/QpFBEb6lDX?=
 =?us-ascii?Q?YlJsFdBoTZmJrKPns+ej5djBXHluaHUSjwy5zRNa0jBiWlsQct6eao/BVoyL?=
 =?us-ascii?Q?CEYUW9R+KFTzTdHlHiRA3E/+UfoDqX9x/7F8PMszMBiqnn7C6f2fVzB09K1P?=
 =?us-ascii?Q?MGHKupqPnF7eeW63mbU+2jrUA2GucJxYjmCa/AcbrILdY6Cy72Dgwrs8gpoy?=
 =?us-ascii?Q?04YXRSgHI7CHNe3TGWyXI7LUrTTMZOYAvYDYVCS/UuVZeEjVpVXJ+lwavdE8?=
 =?us-ascii?Q?CSnLQqIUkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6514a13a-72ec-4130-81f0-08dec297cf92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:21.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXgyY6+IA015u/RLA90Lzi86hNdXjtswwx1Qo6eUZhTcZa7Lqy9Qu1KhDpWHD2bp4617DnWirHrcM/6hzW6ROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nathan Chen <nathanc@nvidia.com>

Add a statement to clarify that the host SMMUv3 must support HW-accelerated
vfio-pci device assignment when setting accel=on.

Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0c65dc8c91..6b5035e11f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
-        "configured in nested mode for vfio-pci dev assignment");
+        "configured in nested mode for vfio-pci dev assignment. Please "
+        "ensure the host SMMUv3 supports nested translation before "
+        "enabling.");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
-- 
2.43.0


