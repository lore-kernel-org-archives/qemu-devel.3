Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84209CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDidD-0000sr-RH; Tue, 28 Oct 2025 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDid6-0000ks-1I; Tue, 28 Oct 2025 08:16:50 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDicy-0002P2-Jr; Tue, 28 Oct 2025 08:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIziDoxZNmgxyjwdfUEhMde3RAnh0YCBmUpLxSR7Br5mNirDB1jDknlJ/F2TpUtNancTQVm/3HqgcEMurXEJ0T7vQrCTfMJbLvaxExXyep9v4JPNbJdm12bFQN2pUuqfWLLv33uHVJ/NqrIBjH3lfypRQ1pEttcRQUYU5Od64e+aIeEXnfW3Wqt6I8hmIabiaXf4sFXfA68oB3pjwTM81IG/zh9lMxFdZtiC9StESd4VXYDenTqf0/HfU+lVrNjwkkggf2URm32u7qBj5AnQdLByM3W64dbXX/gFYikVuQxp9lT5t690NbFn9cg8Sc/vKMTNmW6qXO/tafwLVdPX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcfsBIZnVXA9iTcdu/8QvbheBXJH9JdrbFsz9/ix+kw=;
 b=pOgY67uAj/79cOAimGr0KlU+CwuXZHAYl+gI4K+65osAp+BCqbDnImasIGX75Boq9ewS5cxFZ5IgzFdP97UmQCC9D/FmhrFIvlNxA2Pqebuml82WsInlaJWGX/yZ6Haf8/TkHU6NRRzrJDLEwg6zdxpMSSIsBWwsZVKbJrUFhk5cEfh+3mGmP87Eb/SXgr7HNh1sHslyoPq+ad8fMBrzswT55fw7TL0dduxprEIXUQ5WGkeEa56z2GGcAsqR5++tp3K7qHVdyXfvTUM2eYH7Iac0yRhkFvt4z23A+Tw6c+y1RBcZUoxIrGK/iCME6487Za4xiWEyMRc6+vWeL/F1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcfsBIZnVXA9iTcdu/8QvbheBXJH9JdrbFsz9/ix+kw=;
 b=e1BfyYJkxgyioN5ENqZYvjHaQjJ3aOKGhL2EumGQkv43DVqZ7VYfM+nCQD/89uHmPHBry4acTst7x7q5fEuMFDB9Kq+1TVxSlzeu7ZTdRntmByCfgCqj54HeJlLn7tV6J+raiIv1RB4xkTDyn4XalDsuPObWl2l/d+IRi/tDHMeELNDzw/G68p8SyeoOxcOg1MuG9IzWvWyPxeUvXCHz1904g+jnTAIVLlSGilemIUUbPQirS+KVMRXrmimXhueh0GXMX4QzGT3JD8RhxmobNudiPYPG5RWjhLXziAo3a/Ly1X7EJZeWHf3ICXYp64R+Hn2csG3KLcUSL0zZ6bk/+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 12:16:26 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 12:16:26 +0000
Date: Tue, 28 Oct 2025 09:16:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, shameerkolothum@gmail.com
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <20251028121625.GF1018328@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 337854c6-b80b-405c-5cad-08de161bd12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IDN30Ai9gfHNvvV9TqNjWwYtk67nDkS0hbr3afA28CsLQpPlXfDSAZvEUSRZ?=
 =?us-ascii?Q?mcRwJLCfyLj5lYYwIfYNwQnodJvWCcTGrWW/Udz0yPWRllgVx0vLZGvvyaSL?=
 =?us-ascii?Q?MkplU3bAqfJKgoMyS/FXw+TKlxvfJiy/Cbh7WMM7rcX5IKErsgWRNg5aJUb0?=
 =?us-ascii?Q?2qfQkhCdcW94lJn6v1iAPum2agKIKJSld9WKquk3ICKlz7Hm7zVWfDk8ieby?=
 =?us-ascii?Q?ODYTbaucDGMWsL3oeOrrrwoKkimy14DmFpT28M3fV+atHZLPuRCi8BGJ1nV/?=
 =?us-ascii?Q?dssIuY1LLgv0oNyVIqCQ0X4/h93ZLrJML1WJaw65U+2dQ3smY8vZ5lekt2vN?=
 =?us-ascii?Q?eMJdBNxYRsCAB0i4sa2+xx28UHRgBJRkEydu1+jRrpULpCD0RCh/rVpZjWc9?=
 =?us-ascii?Q?tqaiy5XFebxesuZogXOfTS7CRpZZnaQxILVde6ZEnwDlzhvmdh6yDvRUzbTv?=
 =?us-ascii?Q?IzquYe6S+CpwBAt3MGxNL0L/6zchgdjKHz63U/BJFFofC8kyd9erZUT+/Fcd?=
 =?us-ascii?Q?+C/f7jnjcLYK8Pwhto+70HZlmvXAUGzq536wTcEwGMP/mrVQUwX3PsUsoxEP?=
 =?us-ascii?Q?o/PgvvlqqWmnXoJ+ZA68ZX6+84ED36uK2Puamncb9GdAKCuWxx5mlHQASan6?=
 =?us-ascii?Q?8WQgc6NENMiU5sHECBtIm7Rh2u7vByMdPQSuhxZ925NjouZtiprLajmgXcuH?=
 =?us-ascii?Q?q1vi9Frg/fnc/1CFJUXuzMv8UrpXRCso8Y+FVD8Zn6R3bKfdEWFWkpKVifm3?=
 =?us-ascii?Q?PvzlNgdu3olUsMweyCviEH/WsFfM63G68XwbZpsav0u8uqYaWu6wXbYPfcxP?=
 =?us-ascii?Q?dFTdjkmXLC8BmSTK8/TIqTb/YWcaBZtmma/mOD9RUK52x4vNX0mh1P3PrvLH?=
 =?us-ascii?Q?ObKTPJ7RCqG/XgEzCy7YWkh9zr95RrhHcbLxeoFEpn/0q0lCM1Z+TOOd6rzu?=
 =?us-ascii?Q?oeU3LpG5Clv6nJcBPhuLdZFU+e/AHhqZBo24uIaXzWYiP/91CgFhWCQwD6z0?=
 =?us-ascii?Q?cE/zoBQZ3Woqep3OJH2fxfiEPV4c0MR7IfRd1NymYGNkBnyFOtdC91Kt0q+Q?=
 =?us-ascii?Q?BzDTOYStaJ9EgJy9Xen6SWCSd13dJZQPtc9N0Z4lMYgpLFhNAQudlUy7K1P4?=
 =?us-ascii?Q?obGvoeSJA6InuYTmrF6VqXRm09fIimX74igJxnvT09mXuTiMHY7Ssfzj1YlQ?=
 =?us-ascii?Q?B60Pf8gHLKz01rAHpprp9nAoaqhgjOyB5VlrqeGmHzr1xHP2SyQyVSVqGtAz?=
 =?us-ascii?Q?jU6VNjrT5EIb6QYcOS1fDKzh0ZJj93t06bEciUaVnmYgYwBgpa7W8rKKV81K?=
 =?us-ascii?Q?E/wxMYS2crGbQhW5O/cAW98Mz3gAb+2vMiA05o4mFjj00iGkouu9rhHcjmbl?=
 =?us-ascii?Q?ydJ2+ryJ+0j1YYrJTLZ4OvigECoJAnjxWCIpuNpCbckCyQOM/yazGfPthzOP?=
 =?us-ascii?Q?qo3JZGWyfBkn3bYqDTuo95ARw2n3IqGD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+T1vmyd316y9oDN0aSKvgYN9nuzQGdbdtYyj4+AY8bSSK2i4FJ/Hdha1uxIy?=
 =?us-ascii?Q?Jum2Sf7jh8vjrq0782OD7IKTkGVFDydCGA4w3wFa6hty+mWNC2FSwgtoTMwe?=
 =?us-ascii?Q?wlm6lrp8wHdtTzL7PCsAt8k24OHHQtZPw8SAh1whKjitkSNnZbCM4qCayFVc?=
 =?us-ascii?Q?lnsv+YfTH6MPmaGW2gSW2ZZFYkTrXktYQ4dCcYqyzXOSyj3fi/NXkXl+Rz/L?=
 =?us-ascii?Q?4e53mGhxLD3oYD/WFz2RunJnwoR4XondWO7iqUgXu6ncP/0ZY9GI78yWZNlG?=
 =?us-ascii?Q?OlulK93x5yCvEnaLOadkTmGcO881uqDY4I+epxrC9iWqnQtYmvxvwPLRjogB?=
 =?us-ascii?Q?/dF6x4ybBePKAb9RZGTzTJxp1k8W62+Bs2/xQsC20wNuPEQ1Jg8EzL3iFfue?=
 =?us-ascii?Q?wtTJOFMgYUfqZz1p3MaMb0Aia37nkwWHFc3fkhi32925QtrLvyfOUamAzR6T?=
 =?us-ascii?Q?hIxTJPCv1FW7oGoF29PjRQVYSyuMDtvNs3Iincy9/7/yUncjym5ahNTOBCLT?=
 =?us-ascii?Q?uDKc9RonSSJi+E+F7/CrkKZdsdMrt6uzxU/P0PXWry4uONVoeeD3pS95P9A2?=
 =?us-ascii?Q?HxlJqHMENmjo3+VZrATRzRlpl9S5iZNr655WB00vCfmVfMcbXSDeBYIXBt/c?=
 =?us-ascii?Q?f1yyPgXWTASshkoB1K7WWz5nLMj5zYaSxjSdcKtn/D4W95kW/px63hkd3J5o?=
 =?us-ascii?Q?ZLrWfTV+BTdO2xNYYp2ALG2fiuGC6421QZ+3ZpMXHeiKTOVbPuR0htw1dx66?=
 =?us-ascii?Q?fc9D8Due4rnYQqsyNJ8Z7Qh87x6irEvSTFdyi1uGPUOH+UiJqFUO93OrDh6P?=
 =?us-ascii?Q?nW65RvGiMdDxVp11xifefbSCICbQS2BjiS3na8gZ/wDWS7+Q0KuzfveCfsB8?=
 =?us-ascii?Q?fmnkmpmUSlepIszXKTGEWk+PuV7RU0cs5oDaNz7mk7/JqhXeWuM1XKK7iF5D?=
 =?us-ascii?Q?9trr+AQ7Oml5fjFuE4aGNGwpgyRteL6NEHVedeMYgZ6vdcviiLVvqQ6Lrghz?=
 =?us-ascii?Q?VwEuJx4tukBkvFbrNYtVhGZuY+8cszsmdsbTjBWuCUiPx2iqrmNw1oL4jV5D?=
 =?us-ascii?Q?DHewqzbOpr/qhoS9J7pN9yZ5Ex/9Uf0VuAlMGWTTTzGiSGZD3p8sWWYfCCoG?=
 =?us-ascii?Q?D4GKOvDUEdvKW54zfBceSPHcwitvfUGIat2JEr9BccwaIoCOjYKV6yfFaQtW?=
 =?us-ascii?Q?M9v3/gcV2Mde27TqMo5b3t7+9x9l8sU8WEUcqwCUSD97CqDSI9OfjGr/elgI?=
 =?us-ascii?Q?BBXX4uye7Cg+BSebDARBUWZIoHzUqFIJxovzaiLWfhS6fU7bsLNs3JpEolFn?=
 =?us-ascii?Q?cGJ4zrFhzE2Etn4JUymM2kzDliX+OJRoBBOYnaAg14L0Plq1RAxqf7fsRrD0?=
 =?us-ascii?Q?7Ugu5tfkO0xQbT7EECC8Kyzr/VOmGKD3lBsHvYs4F+bzPrcOccM/p70zRhK8?=
 =?us-ascii?Q?28GjbwewnldH2e+bh5UPzV27qmShPf1e+FQeNQ77ybK2/kvRM6QBz5+yLpmG?=
 =?us-ascii?Q?mA1ZfRtrVzPCzOqbj5FBsSAyIBTEBRukJsyh2qi0pu148ULwBOZmF/T4E/AE?=
 =?us-ascii?Q?ChdSIfTwWh8Twdx6VnU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337854c6-b80b-405c-5cad-08de161bd12c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:16:26.3909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX2eyzeaACsxHeCpzNyhPHyEKjvNIM2t3PifGkQDbPwyl1z2F6DDlyCJ/yA6iQrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=jgg@nvidia.com;
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

On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:

> Hmm, that sounds a legit reason, though adding the ATS support to
> the emulated SMMUv3 isn't seemingly a small effort...

What is "emulated ATS" anyhow?

Jason

