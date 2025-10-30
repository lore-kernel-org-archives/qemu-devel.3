Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8520CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESIe-0000BU-L3; Thu, 30 Oct 2025 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vESIW-0000AU-CY; Thu, 30 Oct 2025 09:02:37 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vESIR-00026u-4H; Thu, 30 Oct 2025 09:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjeZDShBTcMqy1P1dnsvVjcT87BhX7x7fcOdhlf6ym98pH6HYDeVrN7RlnmEs1Ts5IhMx2SSv+pFojmmuklSmH336Chquv9rcZXVYolTHbCdpPHGK4fq68T3U+Jk7HhurNm2Ixe9iUUEuNp7KeUH6kgNnyhgi7MAPkGuzNAxX3VD3Vqo/FXTAn6y+86mDSVyvwi5MZQ94trqAjTC+TmYDBOxY3ElCu88rO8qUO7mWFhHaYl11B5osMM43loKOmL0Ex/98Bf2mWRIzsPEC92DJQvgvD1pMbF1gapUuFuInuSzQGqsYckLifRHPcYokdBhnKqNviefc5z9pCkCpyck5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liiS6VB6v/4l+avz/umLd5Dwd8RLvvk526Do8bS0XMY=;
 b=A36lnC6mWaCoBgFNPLwxOhRYf1lOZn5gx3egziUkp2gBd0wYIcpRBPgOCfo8gwSLFrao1NgPhR2bAk90kw4lPwEfQJJHqjyOyhRTlggRTVxbSclboPXQSZ279zU6w7C5tbbFtgWZMcMwdtB6gKosYJQSRpLHXZl/gxj/WsTxzkAwj3dj+sNufUWAUzghFKSbGRwKKws3Y4rmCU1482tFSA2yi69ao4diw63ePO13zQAM6Nkt3Z7YqSUALPcq/IFkq5DgU8twCsBcjx/gCT30qZQd6nBza+jmh5mI6xwMOpUbHfD7A/0F+6oOD5UwQnqV2nP3CBkFA3ChufJMQSnN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liiS6VB6v/4l+avz/umLd5Dwd8RLvvk526Do8bS0XMY=;
 b=h6atxLs09qOey/k6DOkvkV4hXImj+nSlOmmrDxNK0cDf+sR/Jzzjanblgk9uBfiZT8cJXJ13/LJvc21+omFJuv/QYs5dh7fxBIsJo1W6KcflpAdhm3ZvF2NCKKHksFUq77g5YHFEPPL19yO/pLfz/BT1rnq44GZ2TNX9lIDEofVZkbH0N2wrN2EoomipMD1HJRGxg/J8KWxguvQnN0IXjKGUtKSgszW3Oxi0RMe1ZqUSjgNuWilBeVUz13AEqHoLROBRtyoBTHMNrAq/HEK4Mc9BXHFABp47554gW/9cEIui0eYo62lbyXLCQpOCweCJsTLYp5bD6uzQyWz+xGE7Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:02:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 13:02:09 +0000
Date: Thu, 30 Oct 2025 10:02:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <20251030130208.GP1018328@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
 <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQGXibWAiMpXAQlF@Asurada-Nvidia>
 <CH3PR12MB7548FB14A0D0F08688DE9CCDABFAA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQL3gNT+1Ehgi1pn@Asurada-Nvidia> <aQMVT5BN6kLq6+cJ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMVT5BN6kLq6+cJ@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: f22299df-851f-4876-123a-08de17b48931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q6T8luQUvmAg0mKrrie7k0AaL2BNbRrynSHZeL9Zk7LtZ1j6buXks5V8ImWK?=
 =?us-ascii?Q?ZmrfDbZ7lLNIRIe+isA47JVHgWShBmhBF0x61kGgZz0FWmpBiabmGSlPccu/?=
 =?us-ascii?Q?R9KRG2TCwYkyXxdry8VTy4P5bcXBE+gdUwKzCB7yyz/s3MdttKAiuGXB7hb6?=
 =?us-ascii?Q?gEZRI8najyFjXCI9YvYDeEO+x3sMFlvzrlmfO6X8GykVu/dDTcVQI91drSA0?=
 =?us-ascii?Q?q+EECdBlVUM8uqM1cLRW7q92BqAP4OIcYPmNKyvUSTxcIo71gJDSSCPZzW20?=
 =?us-ascii?Q?wOkprJ4+nfR/UoiieILqI73h3BhRKU9iK/hGfW9CBGhcZ8V22e/jMEVlV7Ks?=
 =?us-ascii?Q?5GVWM/GAk3SGHIoMguIz5fWBSzSH2KA5C4z70lwBRO3DxrXCUGUrkhunFq8O?=
 =?us-ascii?Q?tAslpSkzupj5R+pFUmlRnh7QqO5a2+u3c3DJiDsaeNldN4YcY6tbMMcyRp0G?=
 =?us-ascii?Q?T3aCVUCM/aFkC/wes1BA9Ue0qpDwX5TRjMdUsFY2tvR6GvsI0ufmAihpTKc6?=
 =?us-ascii?Q?AAJw4j+epaRq73/meLk/EqEVWiy6lUlV81nNvAo/caKcTu1k+sXk+dV8BnfN?=
 =?us-ascii?Q?LvWwYreg8wsjIUrWxgHtC2DJMx4WuOQaFkvw2e/mKtuV0+vbMSSq9vuDHQb1?=
 =?us-ascii?Q?RzQjubhs9DazEIEvTyyVeOvwxu/huoUoCxo9v8WEYEGBSbTud+OcqgChVqJm?=
 =?us-ascii?Q?/8DUAcn1j7vTQEbXyANG4w7n3HgIGZwccQ5sefpJWP9S/9HG4LNk7oGFNeHt?=
 =?us-ascii?Q?QcPHwKqXQjPT4VbmJLOX1/DI5gwd/pELMl6DvFPc8Fa8dqK/pfsR/xjQXKah?=
 =?us-ascii?Q?ONdIOj3WPPzhbPpXLzoNG0RWGt3XkW3vC7e9i5CbK6IdpqQ/COod56ammjLN?=
 =?us-ascii?Q?+VT72x9mhLL4g97itKngZZs4eJ5p2sWXTEOU6tIYOAUN3V6lHM6SZ3Efevsi?=
 =?us-ascii?Q?3ZZfXlnJP8vVYGq+xQnKvYXTwwaM41MRar6pCXzdCD9yRn89hua8afyMazkR?=
 =?us-ascii?Q?1vIjBkn6fMlomgWpsM00+gNvA4kyfB8wSKaNbspny0OzRRwf3fJZNX2ftKrb?=
 =?us-ascii?Q?pbfzatgu7tvJPujGdiunBzW8WdfZUD9s1n7FIoPtIGmQSt3KdbnuIEdnTUcI?=
 =?us-ascii?Q?IdET8R5oZwphS8yGJWezyq2W9d1zD2+dbOcMhmI+xHdHPOiH0sf8zHDVZBEt?=
 =?us-ascii?Q?U27H7Qn0fhj4KbDInO9ocPeCFrNLFCbCOV9KGAoeCrmcOJxOg6CTNXg+JV2s?=
 =?us-ascii?Q?wnm7ls0tNfUhjv0FXhyTQZfUwNy3AsC9Dnn82S/JEviRFVyt1UvyXFF8a8h9?=
 =?us-ascii?Q?H91y7dPkzZ/lVF17LvdAPKWg7RA8jjdv4EOd08xoOmIIOiRp7uySxMmXVFSe?=
 =?us-ascii?Q?1p9Vh549t/sp39B5OaDYeFa8fsBBxizbPWkOMvK1rhDxKHtO3x7z8Ha9YQoz?=
 =?us-ascii?Q?29lSkKB7WanDUPLsaSF8nCgDjGysuwDz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?agz0YiG/F99yINNoKD2Bfcx5wRZbzLoEan7KANaV+CZ7kGmkN94pkGTPL2Yf?=
 =?us-ascii?Q?ZAEnX+0hiddaC1RUYcVhJgdvDqPXohhXWFhSgVHjty8xild4PvO9JlWEjEUL?=
 =?us-ascii?Q?iGwWxLnUiafawhp8jDaWiOaEH/CwQdRsJ4313O67xKLJkthtOFcGTWW7qJ4x?=
 =?us-ascii?Q?Blzh7rdwXI9efkHFx4pa7AqKfja8xANKbRlAekcLBWjzEbCgWhL+5wie4HwI?=
 =?us-ascii?Q?+Bmu2TFtQrOHkSEwIeTAuNjBMasOyZwk/tyLh7uNpEGVhYjS34HIBjM4OSCW?=
 =?us-ascii?Q?RIbuGk6lc2Pm+GBH84n8SkokRJesgFpA0qIujEU4y5STII4J6iQfWKahYZAC?=
 =?us-ascii?Q?0iDjUdVpMtkHfS8iKtwfeBHj9PZNOIBY65kI/0Y//JIRYOLBJHDG7UP/QnQN?=
 =?us-ascii?Q?MQRkO440s1xC4W3UdzwI6kgOLFgViahgsw9nw50RLzxDHBSZlwpH8QTXMLwp?=
 =?us-ascii?Q?k1WWEjSsykufp1Ud4zzOoKeS6kenSeufcNHKQhF7W48+L+YbZz2CDy5X7uDt?=
 =?us-ascii?Q?TmFBa/9h+ZzcRqoX1jy763UOxqIyfkFgEW+CuFm7650uXdY/k3cY7cTiVivv?=
 =?us-ascii?Q?22DBVDW/asTZuNXafs+1RPjOAIsqyVNmftH9/TjC9z65UpvqGOpWeyI/iAC8?=
 =?us-ascii?Q?ZZZLHo9aFORJDo4ZrvsNTwrvfsaD6hy/9REBOH99KNWnWXWaYoz6PhTB8mfL?=
 =?us-ascii?Q?03gEPc1I/nk9Y0/EbiuDETuOHZV9rZ3MNd0Rc81eP2GwqGKOWRHrnHnAMGfG?=
 =?us-ascii?Q?1no7NN3cuebBtHXV4Mi2uPEiA07NCkn8mw1CB0ydhEdesUgNBIx9CZYycP9V?=
 =?us-ascii?Q?a5eRIO3rJp0ZHxsCYFvHMg8hkoxXGPYWc3/5ztSFtM55K3M8sr5P4R00cHU3?=
 =?us-ascii?Q?jl75glKnfK2gOsLLNvGMGjthiIM8Z4RlPy7xzbffe0c9ug9fheCfRGuu6o3r?=
 =?us-ascii?Q?BcrBsM59bANVwFXeoOOTNYkF6aAR2qkMWT8A0ZnwN8Ca9zw4HphHTxcmZIdN?=
 =?us-ascii?Q?JtoCfd+dkUmfAXt63lVshwyax8dZv6KialoLgaG+NriHJE8cmq4uQHDzP+zX?=
 =?us-ascii?Q?kcJHIDNSjy49mR6SCRYWiV+Bn60k+eObHDZZL89I2lKxJ1F3XKknbVVLTdRd?=
 =?us-ascii?Q?NSGQQ5tyuPte90ntc7kKehbkCHtlAh7VPAs7b+KrGFopMVjf54sZhDV+vvgj?=
 =?us-ascii?Q?7I7GWPUHfW4flPzbdQbJIa7Ks6nh81HzKDUcZt+ru5Ii7jxFF3Gw8I+dviRs?=
 =?us-ascii?Q?nFTII87aGLYbwbmFyw9k0YsTbmMKiJzSYW/ERyZygRdrU9PMiP8QF1QqeF8v?=
 =?us-ascii?Q?qk3LSK7nzhVQ31xJ3ZN7jgJ/KxZK80bWZ0mTWhxtILfVtk7On9+DJhS6BEND?=
 =?us-ascii?Q?bJcIbTnsOmpINoMRzhQVEvA/RULeBEC9x3FB1LgGt/q1l0RCn5qpdjHjs3vF?=
 =?us-ascii?Q?EWp8bfDkfzLYZXlHmzEdHfgwU+2Nkqg5U4FXmAOifZG58rGwlAAiDjNcY4gJ?=
 =?us-ascii?Q?9fIjIkC3X4FtYv5m3J4VyPJGEGjm2/DiLs5wUp2eE7JIX94pa4+Y3IPqrqk+?=
 =?us-ascii?Q?hHQHFWpserhU/KJorFI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22299df-851f-4876-123a-08de17b48931
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:02:09.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7+Iq0utLCeXfmX9KkyLtLfRPQU+eJL8GSQ7u1f522vKONgY5YUkICh0xEKg5bQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=jgg@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 12:35:43AM -0700, Nicolin Chen wrote:

> However, we have CPU like Grace that doesn't have S2FWB..

Those CPUs basically ignore all of these cachability attributes.

Jason

