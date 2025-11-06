Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A4CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH12Y-0008RI-Gu; Thu, 06 Nov 2025 09:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vH12K-0008HW-8i; Thu, 06 Nov 2025 09:32:29 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vH12I-0005kM-Pz; Thu, 06 Nov 2025 09:32:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCrrEGq+klA099tqSB39J0SNT5YYonxeivgegWY4fLfSKZlrXu/AuOSh7Bmmyci5IuPaEC+HOiMaj2I1Fwm7e0H3ZV1VhqduQC2jTyW5+WHevsZTYJA9jO7t4nE8Kzccwur7/m3OqaQ5GciHlJka8dZ2D43zlv5BU6MssH/M/Oa+N9KHroM2tb3Vc/lcv5oawuTNjw9aA/X/rYQGI1gmoESgp1r6FUZ7C7CtjTgsrwjGWP8tlm8rQI/M5UP/HKlNzTBzijH9kc38+eQCAQB1IX8aBHJoro0lXCP5wDZzCRpkV7XlVYE0BBeVVHgLiU5byWp3qzSbmm85RaSTktzyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLlF/ad8zk6lcydux00sHShpnkC7mO4otg4FXl1zFVc=;
 b=qaRWgg4AI1E2vkHAOx3cCuFpapZe+dSrD91rBXdueEjyrI8aeK4efuq7lIk2NH5eYPFn/1H+ZziMLVjAs4DcJlHUkprTfxbMpHXLoKhD2drmpBVgwPMEQ5HmNGOeLCDODS1aBLzQ24+Xd2r6o5hpJ0/LJGDou93jq1kPKadNkxg6lkA6TN1ddEE0sXpayfO2xzsybQxK7IvIYuAPNz4GY1i9tTohu0Xt09AQPXAsyc+fsRU7Z6Sites+KmBPZxeP8Ex7l0CubOdlw9gXCV2wH/xQlF+JnTIsgSz1G9udTCaN0VJmDQ++xDX5OJjFIywGbgdFK8gwIkhf06snmbkGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLlF/ad8zk6lcydux00sHShpnkC7mO4otg4FXl1zFVc=;
 b=uMR1ZSKgQlohOGh7gw0u7iUPVXwc9753RfYcw9Q4kfKjjIhjydZNk4BUccV7AqrgQPb/2n5ILrPzexBsXiYC7RhdR23tpb4mmWWOUizQtO2TWWbSX+VLTDm3ATNKJcIFk4mlxo0XdWFJyDYGJZ1m90cL09oLasfXhzdcNpZYf3dPYkpXrvVlsnitTFZe6b2GdsVbahlDhOrWY4rrpGLWbzR4VwHSnJdAGoPWarPXFPOQS7y3mzmImlyN7ECV3h3D0i3Rz9h5tD97BGyFYW2CN/eKgJ3lxT4oNS3DQb6+BnNdwiv4V25jqdEFIBrl2hR/DdmhGvmMo1OMmjnmdTFo5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 14:32:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 14:32:18 +0000
Date: Thu, 6 Nov 2025 10:32:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251106143217.GA1732817@nvidia.com>
References: <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com>
 <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
 <20251105185816.GW1537560@nvidia.com>
 <f0c5945d-ec24-4bb9-827c-c3e57abdea36@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c5945d-ec24-4bb9-827c-c3e57abdea36@redhat.com>
X-ClientProxiedBy: BLAPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:208:32d::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 589b94c0-e113-471c-f3d7-08de1d4149a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zEj8/AN1mgr19GDQlmlVqnvBT1dUqmvU2LrJs74Wz2pAvH6gq8cfrKcKMlC3?=
 =?us-ascii?Q?wbKILepODRMJdbC/kC2wL6J2KUeTQHotHG2vg9YzsMFwNcHn8nZnBsEERpPb?=
 =?us-ascii?Q?DNp+r+rZ6Ler50WyFn51jPNdRLiBGCt+wLw3TSUPL7cRu46Bh+Jpd4D2Io0G?=
 =?us-ascii?Q?VMA0u6j9/EnscpLb5pxL1igQ9uIIAGHMoZUZOJOZL78TFONgn+T3PujPzVUo?=
 =?us-ascii?Q?ax+aTQgp0PXE/oUG3oVKW2YkJX8U7rFpm7uPJRP7OXCDowDLEz+N4GvtYyc/?=
 =?us-ascii?Q?u5qLSF9QU74OHWrLi1Mktf9XkGm749OW6NXtRagYmBIc+80y3nGCTTXk8uqu?=
 =?us-ascii?Q?UypCfsSqOVO9aN98znFDbhYdHWPrdV/P4fI1j1OLfHqh6+xhgSywKgZeutFG?=
 =?us-ascii?Q?R0oL47Bqr0A5GfF1eXecedde075GbwFHm1DRig9KEW67182YHCDHHhrCWnaG?=
 =?us-ascii?Q?NvonSJJ58zrICB2Onkdx9gzDaFuRfOeIesq4MiM2RlReitdviJb5jf6MUDkR?=
 =?us-ascii?Q?DUVbgoP+o5T+ROd3AB6V/yR7/aomp+ZMI3neSppEbP25C4e789sehx1uFSjm?=
 =?us-ascii?Q?DZSZXJilKniarTgV44WMbuxFzcsXbqhY7DHhSOjTyP0mVDavm5DPw1T40dJj?=
 =?us-ascii?Q?N112ONp8faxKJuxzja0wUrO8GK2Tqa50iF50EIRVTsXxAAVibCSjujbL9UPJ?=
 =?us-ascii?Q?/z4L+lB9I105qeVzDqKnliZofvA6I2mMJGuRmpvXbcOVMW7YSWyw9CYZo9x/?=
 =?us-ascii?Q?UG4v0reXLGP/cAqAyFj3JR0BojtGlNjwE+ewVYKmerG/bkhdK7FtCsGsqhIz?=
 =?us-ascii?Q?EXRX0hyt67HiP1LBKLOBo995i4M2wLWvvyEeL9HM3Mxi0rTVEnv113HQQju/?=
 =?us-ascii?Q?ZE67DBvi1QTroDCWbMOJmlnDscVtPIp8Ich1SX6Ztqwsf5j9zDtamhWCnWU7?=
 =?us-ascii?Q?fmwCqvk+388wLaCZ6ERBIVATl7usWEMz+9gGXw0qAtjkjyQUmR4NWLCgk+Io?=
 =?us-ascii?Q?5BWQ//tFoKe3Nopghd7K8u7haYP1+j2Jyp4lD67RyizTERK0RQDUPm4hKw3O?=
 =?us-ascii?Q?S3xR6ZhTYvlRqfBYangEGx92s079z522H1OGIMnmtGpQ2I7KNF/jEyoJkMdB?=
 =?us-ascii?Q?/3p0ZzjBTaFAJS+6sGgRu9LgCNdQkfMTbuZeELoDHf0LliK4pRb3H6aaCmUo?=
 =?us-ascii?Q?4N7sdXkHWGY0+SBDJP4dxHDuuk6aEQsij0gsYU6eX4harikNhFgCwXeEL6sk?=
 =?us-ascii?Q?ui0JXO3lkyzY6T6sKfm+K5qQdRNsEGByc+VLQ2AP1vSAdCH7OTzCrc+4tsR/?=
 =?us-ascii?Q?q7I7OWpDyvbSoAICogXe2X9NldYWCVVpe3h7cHzzi+BlSEj6sXwem1z10nGQ?=
 =?us-ascii?Q?bGRNjq1wA1OODhE+yFO35JZLmgkMT4JLEfdtz7VjJWfTit+WTh5AQyDhkupR?=
 =?us-ascii?Q?Nrc7+Ia6jCNhBI48awlWM7VJRb0mkbPv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYL4nUrIsaM+UjU0IfFUXZLTO+a82HxAZtEbBWgqplQbnO+0hQXWI/u6Ys3u?=
 =?us-ascii?Q?DOZi5om4u8qf6J8n5U1hg0CVgKP+LSRG9gRwoIC6zh93WjehXiXLs5Tl9yNX?=
 =?us-ascii?Q?elp4jmEHj93LmIYewV4GjeTH+6ZGoKCRp9V+xNUsZKWzwyJa/6tnVGkBKH77?=
 =?us-ascii?Q?UKKCuUYkTUwQqKFmO3UUZ/vYgulCVMlfu/fW5UPV1LrfzgyixMzFH6Sbiy6l?=
 =?us-ascii?Q?jbY7oDppWJVKIZ3njfY0vQ8thJnOtotyMArOzkDkX7E2pRx1EcJbfqw4xVFQ?=
 =?us-ascii?Q?lwAdne4UjS8wu2f/qy+pN5g3qHkTQAXLnFnnS2xA8ffW/UVIJEWHY5NvuSEq?=
 =?us-ascii?Q?ZXZoVmDbFieJkU9L0enjIVaYkTUPLkfjbeVxc37H5KTtF4GCOWIhxqFb9quK?=
 =?us-ascii?Q?sPOl5bfrvD2OmWd1sMYJruCsMXaCi2/xJfnbY0jfJRkArpE4LkUnD6aTJ5C2?=
 =?us-ascii?Q?/TOuIr8iOTOS/vZPzji7yE6K3HN+MFzKvm1ZHfL9rCrFNySGmAxo/S5ioPYD?=
 =?us-ascii?Q?mWJV81Zy30kbW01/cs7T8T0XNX83V1OTv8PR0IhEd8bhNctHy8B9ToEohz20?=
 =?us-ascii?Q?JRK5omqeM5GW5CjouW9C/DO3bb7t5nFR01cYn5rcq5EwmrauCVXRGgdPMbDh?=
 =?us-ascii?Q?M0XwFkB3DFRYwmIFcLDUWnaPRKImIIidP2uZbWzyDyVigqiM9n0CfXtKSKVS?=
 =?us-ascii?Q?lFqZTDjScQ5GT9Tdmj+x4Ey1PWqMdb0xNkiCIUt9DcmBOuV9aq9UWuQX2QZa?=
 =?us-ascii?Q?nEy8wtcf69sUF77XCdH5wIjejbz9i4xPQ5LFu3XhCJg7CxBHr3v52OW4KaPk?=
 =?us-ascii?Q?ZZeTzh4TJbjeYg0UzK2S2Po+1cgbNOEU8NnsIImhM/1E5JZWS6COgJSyqrGh?=
 =?us-ascii?Q?dcgXUcV1jW5zu0bOhGdZnRl1VwtKdPQximGZHw9YIEvgkGgfjuKDbIMlKx3O?=
 =?us-ascii?Q?bSFkB4c8l6fKwWrIXKVAyNEDqdG9PtNK7p+XJfQTJp22PhSjQHLP1UlnhlBS?=
 =?us-ascii?Q?yICq6T2tkztsp+FsKP9GJMOUTykT03Skzs271+X8FRkHQHl4sLCVvSXAnn7b?=
 =?us-ascii?Q?MyAZjeVwlMKCe9fUOXqwluDHHHQ6W9TX7doOjdIXU9e8Dg2kP+s8LyE33JVR?=
 =?us-ascii?Q?WXs5pVSjFMdCqTng8IEc6iIkmX9qQMGJ+jHFricEEPaEKmZPi7ttM4hq4++O?=
 =?us-ascii?Q?I52/Cn0edHUD7EkJVRHtLyhpmmq7UdUXUuH7qtrA3l6Wcz/od+jYbv5yB6GP?=
 =?us-ascii?Q?9T7Kw+4QF5lC/XQIy7CuV6+pEiyi0yg4NEqe3jw8gaAUJgdEMl/RBvvXiWzv?=
 =?us-ascii?Q?dtjmdwpMKbdFD8bhooYm8jJeE0URpw6p7NGbPY2xzBHHdaxTojGMSuxzjBzL?=
 =?us-ascii?Q?rfneX1+Dp/+p8zhJOl1LjAVBAFVFkv0RXvivlM+dUQMgMbLmP2o7FtMmvf5e?=
 =?us-ascii?Q?B+0sehhGxYMhM7x3J3R64FP+/GQWwR8zf+lne9DOUOJdr5Mob7CwX/7S5+PO?=
 =?us-ascii?Q?pND9Zmw38pJ08XDjfv9790ceAT4zQn/AAnF9lnzLJmTeo6x/kAc4khCUNH9B?=
 =?us-ascii?Q?iYthPz+CZ2L9kfIrkUI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589b94c0-e113-471c-f3d7-08de1d4149a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:32:18.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXP79gGmj3njQ8Xq9Uz0Mtfw0RV48vZmjCgwZAsWD1YpyssQv37fw8NLsdxEguo7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=jgg@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Nov 06, 2025 at 08:42:31AM +0100, Eric Auger wrote:
> 
> 
> On 11/5/25 7:58 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 05, 2025 at 10:33:08AM -0800, Nicolin Chen wrote:
> >> On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
> >>> On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> >>>> if the guest doorbell address is wrong because not properly translated,
> >>>> vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> >>>> See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> >>>> vgic_its_inject_msi
> >>> Which has been exactly my point to Nicolin. There is no way to
> >>> "properly translate" the vMSI address in a HW accelerated SMMU
> >>> emulation.
> >> Hmm, I still can't connect the dots here. QEMU knows where the
> >> guest CD table is to get the stage-1 translation table to walk
> >> through. We could choose to not let it walk through. Yet, why?
> > You cannot walk any tables in guest memory without fully trapping all
> > invalidation on all command queues. Like real HW qemu needs to fence
> > its walks with any concurrent invalidate & sync to ensure it doesn't
> > walk into a UAF situation.
> But at the moment we do trap IOTLB invalidates so logically we can still
> do the translate in that config. The problem you describe will show up
> with vCMDQ which is not part of this series.

This is why I said:

> > Thus, the general principle of the HW accelerated vSMMU is that it
> > NEVER walks any of these guest tables for any reason.

It would make no sense to add table walking then have to figure out
how to rip it out.

> But anyway you need to provide KVM a valid info about the guest doorbell
> for this latter to setup irqfd gsi routing and also program ITS
> translation tables. At the moment we have a single vITS in qemu so maybe
> we can cheat.

qemu should always know what VITS is linked to a pci device to tell
kvm whatever it needs, even if there are more than one.

Jason

