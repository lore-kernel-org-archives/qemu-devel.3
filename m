Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C91FC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHyA-0006TD-7x; Tue, 23 Jul 2024 12:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWHxu-00062m-TD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:02:18 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWHxr-0002oB-GH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721750531; x=1753286531;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Rsw+UnN52TFdAYvp570S53Uef9KSHEtr6KlAhi+O5ak=;
 b=BPI4UKOKK2HQZAAfQfTbp5PddTJHUOUH0uRly51dDK4dLVpnXukajXrq
 iyf3cWGnS3Pml1BDZLc9z/7K3oslsxv/MyJ0D+pz2hAuwQZX3RFaX4vjJ
 jxJgRJq1MeBOzJhM4EhlRaZp0qxhC/cLXNeVjHtHleHY5u5ncaqtF0sSw
 WLtKQ5CFBYUmweT5cL6anFrRvdSeUYHYYD5EjZlHWKTcurGZcuahPfooM
 NC9NWO+GRpZHWq7clv+eSkw4Thqt7nzrSTfeGjelOAmd6TGFZSXmhujPO
 /93+wtSeS5v/Dsl6Hi1cjZic4YFv2f3lUm9LeTxC0SSR/EoXGcJGq+aB/ Q==;
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; d="scan'208";a="17196866"
X-MGA-submission: =?us-ascii?q?MDGBLzXocrH+VH6Wui1hswfr9CaYUVW2T7d1iK?=
 =?us-ascii?q?JkCEcpPnNGrB3EJi/U6hAfHfIU377hRT8Udnagxus1Ut9da9b2Lr/lH4?=
 =?us-ascii?q?GfE3zelY7oKG2IoTwYVBM9kLB2hUBHPgHDqFE7h4LbBVboZBWQa+0TNv?=
 =?us-ascii?q?t8G7yJ1Pv927chQ7DEQn2MIA=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 18:02:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ1fD7kLpwJ7vWBFyJnR6krVkxQVkLvYfzbKjUwjLNXKu+ZgyCe9Ump7fAeddUR9cQOJaFk5GaPydKGVaV3pMmQwLXS7TXPsomDll1qUmrybsgi1lzHRcBEm3E2UkwE295c30IODPy1f9bWaxE+McsLQsGaE92yLiPP7i3QAmbYKCjmtLXjLIsNThgEekRhRs9D4fgxYT5TAMjCS5kDs4smcSaV/S+YDYXiIBB7c6xDgxHh1fnv0SEeBecjSToWWIxo2pZ2VI+pSTTNngpSz96ZJO3paoRNw64wMUJjBSXC1tl55WQ2k9nLzsmqb6SPD7X/Kvv0yi7qClNyb5II9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rsw+UnN52TFdAYvp570S53Uef9KSHEtr6KlAhi+O5ak=;
 b=ycXKKMQsRYWMhY/zOi85HekytJN4UeXsSRl2s+ftRa8lsrfhGBEIst5HWKrIq+QTwIYw+87YKyT7I0agTDiIv97dVEHIZ1ZT35JCmX0aXMmMxr4gU9m2Ex0aQHfM1nhIbFgMtylc8k5GNB78ooJ/sSlx5RtU4aXAoR9N8693SNvrLfKSme7dmSvR5ivrKEvE5PLTJho2aN/Fk0124FIfnKyAg02fgDdLLQsUTaphM494lcYzyoTHRHN2mQ4oDIqhS2Kq3pysGNH6CxIQA3o0Pp5MobaD780dYHOVD7G6Qfb8nSvvmnI0vjIZmUlkK9CbB9U9Dt+wG7eLFzOTOQ3H9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsw+UnN52TFdAYvp570S53Uef9KSHEtr6KlAhi+O5ak=;
 b=S7KDNd95b3XY5xbrW2n4HuVdtzs1EE81iZLexjwXzvZ7n5FXBXN1ffrhhnofiU0oNPSGKWDNNXh0P/iEJxqOEqopM+nFot7CG+JOv/orUPz+CbseCleOBefpbxWTK8Pq/AG6XImFHDR8+LkfG2NdbC+1ZIi83Z6fc+ouvA8LjbHUfjD1zcHGQ+Npj1KxVTdbMiGgNnEqCsefIyHChWPl+bFioOUcpz9tOnpUOZVcdCZMOJqdl6WzrZCmPlRreT51OanHuOB29DMCevfWnN95mo1IMrdD4WkfvmB8njvyLh1dwiPAzhDARTKTHIGAPA5ldpIYHyN8EjfsUssJozM9qQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9055.eurprd07.prod.outlook.com (2603:10a6:20b:546::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Tue, 23 Jul
 2024 16:02:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 16:02:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Index: AQHa2Os92r050du/y0KH7fcUu/AiKrIEgXOA
Date: Tue, 23 Jul 2024 16:02:05 +0000
Message-ID: <8bc5a4b9-9b25-42dd-aeda-8140a81e1505@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-5-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-5-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9055:EE_
x-ms-office365-filtering-correlation-id: 14ab15a0-bbdd-4d64-26d3-08dcab30cc95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dVFsUXVvZERZeWFZWmZvbldVdkJuVWZyMTFnZ3E4RlpBUkdNczRHdFFzTlZG?=
 =?utf-8?B?dENtVUZFak9EbjdIdldwR3JsdmdoNjd4WVkvK04rNml1RXJqbmk5ZXBMWkpE?=
 =?utf-8?B?U3pTYU93VHdnaGlFRTFCSGhwMnRpYk1mSktodDBCeS9YbkpKdzRCZGQ3TFJH?=
 =?utf-8?B?MmhiaGJXWHZnNXpzb0FBRVJ6WnR5Y1ZZOGhSK3pxRHdBNEl3ZHYyUjhhY29u?=
 =?utf-8?B?UCtvNHRUUWZiZzZITVozUTlhdUQvdkRHVWhjdHJqMk80Zlc0Mm5PdXBXNVY5?=
 =?utf-8?B?RzZNaVNhQjJ0bE5sYUpPR3dQZGpKQjZPeGxrZXlQMFoybVdGTE1yOCswS21U?=
 =?utf-8?B?S3g3NExNTmdtck1uMjZCbDV1eXhJaGpDb1hWTXlCMlhHVFY3VTJPT3BhMTAr?=
 =?utf-8?B?Nlc5SGk3aUF1by8raUZOa0F4L2VQeU80b3VDNzRpYU5kTmk4Nml3czcwcnYv?=
 =?utf-8?B?WkVuN21NTDhmZ25KZmZPb1FvV2tVb3g3ejRSc3ZZL2IzYkpZZi9EYWRrWnNN?=
 =?utf-8?B?cktWLy9Zbm9ERFBKNVh4NTE4ZHBpbkhMN08yUThQc0MzYkdIZGN1OUVMUWNR?=
 =?utf-8?B?V1BZa2x5UkxML0VKc0dnRU1jWXZnWHJGUDhXV0hVZXhnUm5jUkdXaDczbXNM?=
 =?utf-8?B?eCswWU9GV0o0Q2NlSnJLb1ZyaDVJb0NpdnUxbjVrbkxOZS9JbHhVYVZoU0Iw?=
 =?utf-8?B?RXlVL3FqL3MxZ2xsZnFzR2FvWkE4NG9ESTRBclk5YjBPWlBnTjd1SC83QjNZ?=
 =?utf-8?B?RW1aWmU5VWhlQzhtOS8ybEk4RTFtVjJoVUp5NVRtbjVtZ0lYYnVoZVNoNmc1?=
 =?utf-8?B?cXBaOUFQUkluaVJWTFNKRVNiVVNrSSt6LzNPQnAwWE9ybFRwenBwOThZcWll?=
 =?utf-8?B?REZkUG43Z2w2aE8wZmZZblFFOTVMeThtUXVYa2MxNURzWHhOenkrUC9SYTVG?=
 =?utf-8?B?M2d2YU5mU3l3MkpJaUZOQnJBVnVDQUpKSk4wL0ZXQ2dhaXRpVUY2TFVjanp5?=
 =?utf-8?B?MHpTTzFjbzc0WklTTnlHWkxqdjlEWVRlQ3UzNGtidU1hRlQ2WXM1SEg1WkNX?=
 =?utf-8?B?L0tmU3l5L2p3em1wVzZ2SDZYMFhGNndteWVUSWtwYmxvM2dTVFVlQXU0WkNU?=
 =?utf-8?B?bXZFb2IvZkVZc3BnSDJ4MG9RL0dnemhBOVlrOUZLaDJSaDRHcitKVVRpL1JF?=
 =?utf-8?B?V01YUWNlSWFBdVJPaDNiOEVUdmtzMFl0MlorWTYrQm5SazYxWlBxMG11SG1y?=
 =?utf-8?B?dUlTdGdmMGZwdjl0U25ZajVEYmNyOXhaQm8rZVVJNCtsTk5zRFBRSXp3YmdW?=
 =?utf-8?B?MldFcC90QkRyT1F4bVg3T2o2dC9VWHNCcnc2akxZNEUwT05pS3ZsdHhIUjZU?=
 =?utf-8?B?NjhZM1NhQlBOMnRoRlhBRWxRaWpUMVNpZURabkVZWjZyZ3BIK0pXNTBiVnhC?=
 =?utf-8?B?K0JISkl5aWs2RjRPaDZFRlpML2wzMDVxUDk0dzI4WC85bnFxNVRySWtNaTJL?=
 =?utf-8?B?cXJqNk9kNXZTM3d1WFgzR1hIbFF2MDZ1MitmaFdrVElCYk4zZGptdUw5V0Jp?=
 =?utf-8?B?OE9KTlJLdTQyaFVXNUFSWVdqWTROQk5aN2xuTzV0eHB4WjFhUXo1TE1iSHF4?=
 =?utf-8?B?SzhmdlI0RXl2cDFvNU9PeVFBNVdJekhKbGpSVXVYT09PTm4yYWNtZWhRVFZi?=
 =?utf-8?B?SFVXdEI5aXNmNFcrd052ZG81aHhpRXVZazhhbEh1WllUWnJmRFRrMG9JeCtS?=
 =?utf-8?B?ZDNYeTVMZTRrQWd1TkE2YVpFdlBvbkRTOGVCa2hLRkVmS2o4ZGxCTXpZZUY0?=
 =?utf-8?B?dmRzQWc1ZVZtckc0c0ltVUpVTTRXK243RkY5MUZhTmhOMjJkYWtFNStDZk9L?=
 =?utf-8?B?Q1dVT0tvSDRjL3RycnRlSVBaMEE2SmxFZjhHb3JPRXplZkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHp6NGNZUnRtWFdZWi9nSWY0OVRhRlBiVGFLOVlqOHA1NnVXSUxVdS9CSTIz?=
 =?utf-8?B?ODhhTmVjT3F5QUZTN1F1ZGJYWldKMUNBZDZtNFB5M2U3c0hDWHhveXlzSEpr?=
 =?utf-8?B?WDZXWWh5RmlZNzhUVm95M05KSDBicG5FS2J6ZW54UVhVVXNJZHBPR1UyWEJW?=
 =?utf-8?B?VnlRanp5V09qTzg4N3RINTlnbDk1aXJWcmxmYk91NzhxSFFvWDE2eXRiR2Na?=
 =?utf-8?B?VzhYTHBSN1JuY0p2dDlNZ2RLNmRLUEdBWkY2Tk45UHdCaTIyYkI5aXJyYWt6?=
 =?utf-8?B?azh5SnlsbXJ1QVZMNkY5WThCZGtFcytZOHhQM1hlUlNZOEJQak5vUjk2SUFa?=
 =?utf-8?B?dk1LZThXYStEaXhSR2pCWmZjVm1EWVUzdDZhMlNkdWdxaXgxWmVhU0NCcEM5?=
 =?utf-8?B?RVlreVRzQnFibG1LZ3NvdTBxajQvN2srZlUvWVVaWlhLZXVlaGRGWTVpZDRz?=
 =?utf-8?B?MnZGck1vandrT3dURmFNN2thT3JqWnJwR0cvU2ZXUnJCRmJHNUg2UUpxSnZh?=
 =?utf-8?B?L1J5NzRNTSsxRng0ZmFPYUltU3htSVc1U21jQ2M4Z244b2xZZHhPWEh3Zkh4?=
 =?utf-8?B?Q2RmRVM1NnhmRFowTURYMUg2N0FtS1Nqa0MyWHRDTVQ2WkNualdTU1d6SkRs?=
 =?utf-8?B?UXZ1MUl0NnNqbG5lNDJPV0p3a3lKUHRqQUNvdTJCdDZ5UDdHaVRZMmphazdk?=
 =?utf-8?B?aWM2cWEweGNFUGloYUNjU1VxQnJ2ODlVYXllZkJOdDFlM3RKYzlyQm81SnV1?=
 =?utf-8?B?NzJyUjVSc3poRGZsaFNCTHJnSzIwclpCYlNyK0I3K3hHMndJWUJRVVptem05?=
 =?utf-8?B?NGZoNnhoRDB0THFTUWdsV1NDSXVCdkZaV29XTmlrYk5LakhMZGo1Sy9ZMXB3?=
 =?utf-8?B?SGdYVlAxR05jTHN5M3FXOXZXTTVNZE8yVXpQQWpWSElVbHViancrU3dsdkRv?=
 =?utf-8?B?NEFRTFR0UlhEcEQvaGNUeTVSUVBzKzdoK1haMVVVbU45MkN5Zm5LK2xCUHlP?=
 =?utf-8?B?MWFTVWVOYnc5eHp1azluSnkrRXdGblNRMVc2NDZpMEJ4NEdZMmpuS216ODlU?=
 =?utf-8?B?Y21paHVKTFI2QnlkUUR4MUV3N3dGbnRxeHh2NllSTHRXVkRVdnp6SXVJRjY5?=
 =?utf-8?B?bGkvME5oSlErSFBwWHQ4TUVjOUZ6RjFjcG9hemxZRGVHb1Rsc3J1YUgxRk5K?=
 =?utf-8?B?NG9YUVNLeG5oY0t6WVFnRS94ZW5TaEZQeEhkYVQ1TGN0cW5VTlMrN1d4SXp4?=
 =?utf-8?B?VXl3MG1nZXBVUHpBN2RuRmFMajNBTEwzMmJiWm00a2YyU3FtRjgzWjhINktF?=
 =?utf-8?B?a1hueEFKSFF2R1hINVpxTFY5bGVqck44NEN5anJVWlhvY1QyZmpDTmxYYkhK?=
 =?utf-8?B?M1pXMzhnenFrM2luVFZTOVp1RnVlREpOQzBYTVpuVDZxM3VHZEZCOHJpNFpV?=
 =?utf-8?B?VG5rM2VWNk1hZHY1M3FPdlJ6OEJ4TjBHM2xZbXdodThpREFES3MzSnRXUTFI?=
 =?utf-8?B?dFd2bVh1SzJoZW5MMkVDMWloZjN0K2ZZSWVPRnZFMjRxbVNQRDJua0RnU0g0?=
 =?utf-8?B?a1FqQmZpcVRhTDZyUHRWTU12WGwzSnp5a2s4SzF6VVVsTm1lWVdDYkxVRFNW?=
 =?utf-8?B?eVI2bWtyRDhJR0Ztcm9SeFZOTERZMHc0aGxneTJ0U0hESnFZRm5WTVExN0ZO?=
 =?utf-8?B?ZGFNR083UW5nK2J1SktieTF2aXlpc2VUZnpzOUdnWkFway9KSytBcExZR0s1?=
 =?utf-8?B?Wi9PdktHTUhnV3JqeldCK3VKTVBzb3FCcjM5ZHA3YU5JdmRpQVdTazRoaUVV?=
 =?utf-8?B?ZjduZGpLUnlmVkUyQy9aRzg3TzR0UkpCZGVHZ1dyTnhXK0lVdkt5N1FCVVYy?=
 =?utf-8?B?R1RQb2syQkR1NTRrVkFodG8yVUlKNHdZMTY4SlU1UVQ4cTBSWXBrSEk3enVG?=
 =?utf-8?B?RmZGaUFoSnI2TFNtNEgzMGtXUTBWam4vKzdhVWpxK3YyZXlIVzFRa3QzeFds?=
 =?utf-8?B?ZVgzbTlIbU5VQkUzeEgrV0VPS083Q1BMeWNZdEdCeWFyZXdCQjJUT1ZGUGJN?=
 =?utf-8?B?Y1d0eDBEckh0eHc3eTlkc3VjMTJIM2hZTmVDUUhDc3g2RkkrVzN2cXNDVGN0?=
 =?utf-8?B?Um4wbml5OU1XdmY1VDI4NHZuMUJrZ1JubkNKU0JqcjJuRHVVaHdNeWxFRnM1?=
 =?utf-8?Q?Y7CmW0D+36MRqXZKwpmX+10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73512E8F59D78644BB94DC95B39A496E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ab15a0-bbdd-4d64-26d3-08dcab30cc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 16:02:05.8436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPx/0IzP0i5SIdgdNafWMU7pfszb42zQkddugF3htw0xyWt2TQXkR0H23PIbD1Zbt0PwnJMJUU8/pvIER32J66Y5Wsf7T1UyTHtJnd3yUKkjc1i5uuzq6QUQW7/axoey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9055
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNl
bGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPiBmbHVzaCBzdGFn
ZS0yIGlvdGxiIGVudHJpZXMgd2l0aCBtYXRjaGluZyBkb21haW4gaWQgYW5kIHBhc2lkLg0KPg0K
PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBtb2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxkIHNlbmQg
UEFTSUQtc2VsZWN0aXZlDQo+IFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB0byBmbHVz
aCBib3RoIHN0YWdlLTEgYW5kIHN0YWdlLTIgZW50cmllcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTAgKysrKysNCj4gICBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4gaW5kZXggNGUwMzMxY2FiYS4uZjcxZmM5MTIzNCAxMDA2NDQNCj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPiBAQCAtNDQwLDYgKzQ0MCwxNiBAQCB0eXBlZGVmIHVuaW9uIFZURElu
dkRlc2MgVlRESW52RGVzYzsNCj4gICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFX
X01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfCBWVERfU0xfVE0pKSA6IFwNCj4gICAgICAgICAg
ICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0K
Pg0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0FMTF9JTl9QQVNJRCAgKDJVTEwgPDwg
NCkNCj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8
IDQpDQo+ICsNCj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAgICAgIDB4
ZmZmMDAwMDAwMDAwZmZjMFVMTA0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRf
VkFMMSAgICAgMHhmODBVTEwNCj4gKw0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1BB
U0lEKHZhbCkgICAgKCgodmFsKSA+PiAzMikgJiAweGZmZmZmVUxMKQ0KPiArI2RlZmluZSBWVERf
SU5WX0RFU0NfUElPVExCX0RJRCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERfRE9NQUlOX0lEX01B
U0spDQo+ICsNCj4gICAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBp
bnZhbGlkYXRlICovDQo+ICAgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gew0KPiAgICAgICB1
aW50MTZfdCBkb21haW5faWQ7DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggNDBjYmQ0YTBmNC4uMDc1YTI3YWRhYyAx
MDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPiBAQCAtMjY1OSw2ICsyNjU5LDgwIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9j
ZXNzX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVzYykN
Cj4gICAgICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPg0KPiArc3RhdGljIGdib29sZWFuIHZ0ZF9o
YXNoX3JlbW92ZV9ieV9wYXNpZChncG9pbnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEp
DQo+ICt7DQo+ICsgICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSAoVlRESU9UTEJFbnRyeSAqKXZh
bHVlOw0KPiArICAgIFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQYWdlSW52
SW5mbyAqKXVzZXJfZGF0YTsNCj4gKw0KPiArICAgIHJldHVybiAoKGVudHJ5LT5kb21haW5faWQg
PT0gaW5mby0+ZG9tYWluX2lkKSAmJg0KPiArICAgICAgICAgICAgKGVudHJ5LT5wYXNpZCA9PSBp
bmZvLT5wYXNpZCkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lk
X2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwgdWludDMyX3QgcGFzaWQpDQo+
ICt7DQo+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPiArICAgIFZUREFkZHJlc3NT
cGFjZSAqdnRkX2FzOw0KPiArICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4gKw0KPiArICAgIGlu
Zm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPiArICAgIGluZm8ucGFzaWQgPSBwYXNpZDsNCj4g
Kw0KPiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPiArICAgIGdfaGFzaF90YWJsZV9mb3JlYWNo
X3JlbW92ZShzLT5pb3RsYiwgdnRkX2hhc2hfcmVtb3ZlX2J5X3Bhc2lkLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmaW5mbyk7DQo+ICsgICAgdnRkX2lvbW11X3VubG9jayhz
KTsNCj4gKw0KPiArICAgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90
aWZpZXJzLCBuZXh0KSB7DQo+ICsgICAgICAgIGlmICghdnRkX2Rldl90b19jb250ZXh0X2VudHJ5
KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPiArICAgICAgICAgICAgZG9t
YWluX2lkID09IHZ0ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsNCj4g
KyAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFZURF9DRV9HRVRfUklEMlBBU0lEKCZj
ZSk7DQo+ICsNCj4gKyAgICAgICAgICAgIGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFT
SUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lkKSAmJg0KPiArICAgICAgICAgICAgICAgIHZ0ZF9hcy0+
cGFzaWQgIT0gcGFzaWQpIHsNCj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAg
ICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsN
Cj4gKyAgICAgICAgICAgICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0ZF9hcyk7DQo+ICsg
ICAgICAgICAgICB9DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0K
PiArew0KPiArICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4gKyAgICB1aW50MzJfdCBwYXNpZDsN
Cj4gKw0KPiArICAgIGlmICgoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJf
UlNWRF9WQUwwKSB8fA0KPiArICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZfREVT
Q19QSU9UTEJfUlNWRF9WQUwxKSkgew0KPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgibm9u
LXplcm8tZmllbGQtaW4tcGlvdGxiX2ludl9kZXNjIGhpOiAweCUiIFBSSXg2NA0KPiArICAgICAg
ICAgICAgICAgICAgIiBsbzogMHglIiBQUkl4NjQsIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNj
LT52YWxbMF0pOw0KVGhpcyBlcnJvciBpcyBub3QgZm9ybWF0dGVkIGFzIHRoZSBvdGhlciBzaW1p
bGFyIG1lc3NhZ2VzIHdlIHByaW50IHdoZW4gDQpyZXNlcnZlZCBiaXRzIGFyZSBub24temVyby4N
CkhlcmUgaXMgd2hhdCB3ZSd2ZSBkb25lIGluIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2M6DQoNCiDC
oMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgaW90bGIgaW52IGRl
c2M6IGhpPTB4JSJQUkl4NjQNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAiLCBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwN
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1
bmNfXywgaW52X2Rlc2MtPmhpLCBpbnZfZGVzYy0+bG8pOw0KPiArICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgZG9tYWluX2lkID0gVlREX0lOVl9ERVNDX1BJT1RM
Ql9ESUQoaW52X2Rlc2MtPnZhbFswXSk7DQo+ICsgICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElP
VExCX1BBU0lEKGludl9kZXNjLT52YWxbMF0pOw0KPiArICAgIHN3aXRjaCAoaW52X2Rlc2MtPnZh
bFswXSAmIFZURF9JTlZfREVTQ19JT1RMQl9HKSB7DQpOb3QgY3JpdGljYWwgYnV0IHdoeSBkb24n
dCB3ZSBoYXZlIFZURF9JTlZfREVTQ19QSU9UTEJfRz8NCj4gKyAgICBjYXNlIFZURF9JTlZfREVT
Q19QSU9UTEJfQUxMX0lOX1BBU0lEOg0KPiArICAgICAgICB2dGRfcGlvdGxiX3Bhc2lkX2ludmFs
aWRhdGUocywgZG9tYWluX2lkLCBwYXNpZCk7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArDQo+ICsg
ICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCX1BTSV9JTl9QQVNJRDoNCj4gKyAgICAgICAgYnJl
YWs7DQo+ICsNCj4gKyAgICBkZWZhdWx0Og0KPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgi
SW52YWxpZCBncmFudWxhcml0eSBpbiBQLUlPVExCIGRlc2MgaGk6IDB4JSIgUFJJeDY0DQo+ICsg
ICAgICAgICAgICAgICAgICAiIGxvOiAweCUiIFBSSXg2NCwgaW52X2Rlc2MtPnZhbFsxXSwgaW52
X2Rlc2MtPnZhbFswXSk7DQpTYW1lIGNvbW1lbnQsIEkgdGhpbmsgd2Ugc2hvdWxkIG1ha2UgdGhl
IG1lc3NhZ2VzIGNvbnNpc3RlbnQgYWNyb3NzIA0KZGVzY3JpcHRvciBoYW5kbGVycy4NCj4gKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gK30N
Cj4gKw0KPiAgIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2ludl9pZWNfZGVzYyhJbnRlbElPTU1V
U3RhdGUgKnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURElu
dkRlc2MgKmludl9kZXNjKQ0KPiAgIHsNCj4gQEAgLTI3NjksNiArMjg0MywxMCBAQCBzdGF0aWMg
Ym9vbCB2dGRfcHJvY2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgICAg
ICBicmVhazsNCj4NCj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCOg0KPiArICAgICAg
ICB0cmFjZV92dGRfaW52X2Rlc2MoInAtaW90bGIiLCBpbnZfZGVzYy52YWxbMV0sIGludl9kZXNj
LnZhbFswXSk7DQo+ICsgICAgICAgIGlmICghdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MocywgJmlu
dl9kZXNjKSkgew0KPiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICB9DQo+
ICAgICAgICAgICBicmVhazsNCj4NCj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfV0FJVDoNCj4g
LS0NCj4gMi4zNC4xDQo+DQo=

