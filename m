Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D5BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tudXA-0001Jb-90; Tue, 18 Mar 2025 16:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1tubSp-0002JW-Pi
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:15:00 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com
 ([40.107.244.69] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1tubSn-0000W4-4o
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+ctj1WbRuRuuCz/huAN87WWuUDwCZhjCDEbuFHEp9UiiC6hlqllfNuUeGIRnifeU/xoF/0R9eP692TBAQ8DWir5P1xl7FzoBieb16YHAvWMrH6s7tS7vLhmDMKDSIQViKI0kucK3sDhGR2eSX1y69iJ2irMbaYEChoR0VwaRITS/RYz18nNJUyGJINmlJvDVi35LoKl+mKGvHlYBYvBZS16arK29VR1+IgEyrsJuMqKYU32/YerrIP5yQ/nykIfU8FpL1jpwhMFCZlHJNMToeXnbIL7d9XibEH5ujWNQSbGAYM8XRVeaDNjsmQ6YzQWQ6nBQ2ANxNFOf7lake7TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+0PkykZAY/24QmjGLJnG3pPTmM9XqLtRjK1+X2A7b4=;
 b=BFtZd9Xse+mZ2y9G4USIrMDoIqBfH0qDJL0FhhXDr5+viT0eDx3qr2ZlNfy+HW1becDWBuEuySC9HVllFtv7B6azCN4yLNMwslAxrdgApj4/VVFgFj7kUmOl8COf6eOQFTznnYt6h4f8T7+e07fM/cuHNFrr1OGFS/oWtkL+B6Y2kb67M5Marks2wbob9vlzMoKI0/KBY+QqlJz17PRDHOCycAgnWKgPcxbzEBFcZRnbKch1wZsm2N2g97HMrPMRmtj28HVw4IONhcbD1Nmg8CkCRljCsKNpQYtYdSxvxWx/Sg3UCA5Br/8Uc80HPLczY6xmpprMajI/bHakjcH6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+0PkykZAY/24QmjGLJnG3pPTmM9XqLtRjK1+X2A7b4=;
 b=QBTytF36ha7aejS3ISV51lKi3sH7LF+334ihfr1icDLqIPsl5jOpaFzK8h8xiP8iXxZOjrr6ZQa/0ROJf8FMiPxKh/y6/9cy7Pw+fSDauiC4squEpk+Y4CuWMofJOrSGK54WjTcM5rVe2jHz7R1uNIhZg7BIXYcxIrmIgjkVHHEu3DE/lsHorfUfh2/vXw788yJ32CT+YLev1FecmaoWm8UmWnHuPvGlC4RYriUTK50ZdE4JqtMsbcpdb2P0+f/bpKQfgFS4nQEAwhQ7mw+GrYlTpvxaoniHxMOnndJjka9aAeG7wpYCl07mnrGrw4gR/+lCOtKuyhSkmdHnpfEOBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 18:09:43 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 18:09:43 +0000
Date: Tue, 18 Mar 2025 18:09:26 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com, jasowant@redhat.com, 
 lvivier@redhat.com, leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
Message-ID: <m7p7ubuyfhqxhcxqt4qs6rbi24pgxtnbq52maqpdom2da75g7e@laluifinsegp>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
 <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
 <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b2fc93-f6bc-4575-d088-08dd66480edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007|27256017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1JJVjVuQmZYcEl2MjNwb0Z2L2hyVkx2OWVnRW9weXpmTXlkYVlQdVVnc2Nx?=
 =?utf-8?B?aEpSRDBnNlBzM1U0dDFyRjF5aVpsajNWMVZ5L2U3RWYycThSVFlEdzBsaGVs?=
 =?utf-8?B?bGRYdFBsSzJFN1dBak5lQk9jVnBUMUI4NUxjWSt4eWdBRVA2ZGphWmxJZUJy?=
 =?utf-8?B?ZmMycGEzdVFnbGRUR0RsV0ZGN25ZNnVtQnpwSnN5dXBja3VwLzRtUWltaHhG?=
 =?utf-8?B?WjA0SG9Wek5VWlpOMFZwR04wV0h3cVNLT3E5U0FVQStwWTNpOVI2dGFaamt0?=
 =?utf-8?B?eXlSU1Awc2dlUFl4QXhDYjQ2a29pTjhHYW80Z3hUWFlPZ2dwemE4Rzg2cWl0?=
 =?utf-8?B?MmlLb2UvWWRUbXZpaWdrYy9KZHFyYUY3cjdiclQ3blZ5cHpIZXBiZStSQ2NP?=
 =?utf-8?B?K2pPN1hFYUVxN25LWDAzVGtpREphRTAvbmZrdEhHcmRyUUU5VnlXRW54TTJC?=
 =?utf-8?B?d2pYUVVjRnZtK2FnZys5WWdaUGp4bWFYOGEyb241dDZVTFBjSHdGaEJBUi8y?=
 =?utf-8?B?M2x0VlBBZFNsYWxsdVlPYUtQazV2ZG5Way9TeVZwRm1YUzZGVzlrZ3lUTUgy?=
 =?utf-8?B?am5XZ1Q0OTRpeWtkUmpnL21DSmlsNXFZdGZmUDlkbElWNlhCK0p6VElPRXh1?=
 =?utf-8?B?Ym5Cb0svMjIzSWdaKzZLOFZHQ1NySjdCQ1FiWU1MWjlJRERET2dJYWZVdDVM?=
 =?utf-8?B?eFlqSE9vWTRDQTBpa0VHaHEwNzE2WXp1RGdCTEhXeXhNakU4eFRtWDc5N1Zo?=
 =?utf-8?B?d1cybEphWkFwbVFUUThUSjV5aFROaXlvV0tuTVRjQ2IxK0dXVEFGUW0ydm4v?=
 =?utf-8?B?NURWRzE1OFFmY05ETHhzZEZUM2ZmV1E2cTR5Q2ozWGJiWlVvU0lXbHFyQVhN?=
 =?utf-8?B?ZG1wZDBuUFNTY3A2Z1YwRkIzcUs5c1hEZEs5c2Z6b0ptSmpubGpOT0p4OGoy?=
 =?utf-8?B?V2Y0L2xJQzNmS0VHS1NmOXBJcVkrUEhLUVVVUWFHQUZ2TTVYU2pkWWxpS0xN?=
 =?utf-8?B?a3JwTEt2MHZUaWt1TEwxcG1kU2drT0wwNDZiYTlEaGlGRGtUUzE4SXE2RGtT?=
 =?utf-8?B?M01LSjlhVSsxbC9WWlFMQzV5RjZoclZmbEltVzhwYU5xVStWRXpmanpmbkp5?=
 =?utf-8?B?YUp5Z1JWOVFnOVRPcjNNbFVGQVBsY2hRd0NzazlNTm1Mb1loakY1NzJySnVv?=
 =?utf-8?B?T21WMEtsZ1VmQ3ZPenVGUXdhWVRFVGxZejFValJmTktEcHZvSkIzWVluc3Jj?=
 =?utf-8?B?OW9NLzNRZDRTekQ2M0RNYmxha1dyWTAwSnFtZEluaGhqanBmd3hWN29xQUcz?=
 =?utf-8?B?emk3NTNoWlVOT1RSVnpSSGRDMjdvMk40NzFmTkVVYWRreHAzQ0ZQZUNsVmVy?=
 =?utf-8?B?N1dZekwyZU91cFNJc1Jvbnc3NUhzMGcxQStsRlduMzNRclZ1Q2FWVzhaQ0NQ?=
 =?utf-8?B?bTBYU2hzYVNyQnBTZFZsWlZqS3BGbWJERnlKeUpuRENiUkcvQTRtNk5KeTNY?=
 =?utf-8?B?TFdHU0xUVTVJT1VJUDBuNStZSW9sOFNza3ZVSDg1Zjh1cVNNMDVqSzdreU9K?=
 =?utf-8?B?Y3V3dkUvWkpqSmNJakhqUWhUeTdwVGJmci82ZWZPQjRTSm93Nnp4VG9OWHVH?=
 =?utf-8?B?NVNLRzN2T1paczdmOXVzWmwraHJHSXFEaHZubWplUm5iOVMrUnVydzBmTC9v?=
 =?utf-8?B?aTVVeDYvZ0lyUDZUbWx2UUoyZ3N3UmRFK1dRYk5DWnVoQUNtQ1djZFl6VEdQ?=
 =?utf-8?B?dllobVA3aEtiRTlLODlFenRiaFNhNDVZZkVFNEVUcTd1Z3c2cWpEa2RuQTdD?=
 =?utf-8?B?V2R0eTZoWlQxakhtajF5c1BOeWZBMFd4NlN0UlRNKzRxSGhvYS81N2xDRnJx?=
 =?utf-8?B?MWkvVXNDWjRoNFUzMWNVbldDVC94L0xWZktMTGlUT1RGL3BFSzJEOXBQclkr?=
 =?utf-8?Q?Q3yqaQzblo3zYICPrROPbNpNQu+mluKe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpjeXp6Q0dHYXdMNWdodU9PcDJ0eFNUd09DRnUzQWtRL2E5dmxQUUZTTUpu?=
 =?utf-8?B?V0UxODJiODFsWWFNeXhUczFqc2JpSVJ2QTlmaEZEZXY1NFlYQVBPaUM1T05u?=
 =?utf-8?B?NzFrempUa3dwMFc4Z1crNnd0ZzRKbzZIOHZ1ektIUWwvQTJVTFFpNUZpVGU3?=
 =?utf-8?B?cjlGUDRYdTBpVkl6YzlDVTYwK1I2MmIzU1JmWGhKOVIvWFdsaCtoSjVmeS9H?=
 =?utf-8?B?UEpKM0svVTNNdFNMY3QxZG1HQUNEcW01UjZDM1FUN2doaXB3S2M1Q0ZESFh1?=
 =?utf-8?B?L1hzSU84NUNXYkkzbUl2SmdLTmRWYktDTE1EbVI0bU8vaCtvcnN2eWU0YU1K?=
 =?utf-8?B?dEVBSjBuR1JjSDFvazlTOU0wQzh4YkcrOUloTEZ2UGZrVGlGMHJqb2IySUlW?=
 =?utf-8?B?cTg2c0JPVEpvbXZ5VmR6QWx4V3g4T242Q0NDU0x5WVlML2RtZUEyOTQxallq?=
 =?utf-8?B?OWM4WkxwM05VeEptd0UxYXhrNkZWT2FvanJRUHU1OUk5Q0xuWVNzeWEvU3VI?=
 =?utf-8?B?ZnpFbjhPdHBDRzJVcGNpVkRGRWdYNXkzTThhcWZ3NWJRL3V0TjhpV3VSaU1v?=
 =?utf-8?B?NkFzbnVKbEVpTGhWc2hWMHJIdzFnQ2pqVDJnaHJhZjdwUDNrK3NYeGdwRVF5?=
 =?utf-8?B?bVZ2b1JNb1hXVHVvVTF2bTEzQ0ZUSGw2T2xnMHRyQkZxMG1acmRCY2tlSEpr?=
 =?utf-8?B?VXNwUDYrL0FTdy9pSmFvQkJjSklXa2tPQWZicHdKaU94MkY2ZDlZWEFROS9u?=
 =?utf-8?B?VzhiSkgxRURYdWljQmp4T1Y2T3g3cEV4S2cyUUQya3NSN29xWjVJTVI4MHRZ?=
 =?utf-8?B?aUE4L3JET21KN2hVRkRDaDJlZm9FeTdwN0NpSWplaDRubjdhY0JyMEd3bUVQ?=
 =?utf-8?B?N3d3WWpJTG1QLzBwRWJUNlY0UVpKejB0VVpWMm0yZmI5NmYvNjhRa2xlREhL?=
 =?utf-8?B?RmpTNU01Zk1PaDlZaTl6ZnRtUTJ1eVpaWStCTEdkcDJ4RTlCMFB0T2t1QUlB?=
 =?utf-8?B?czRnZmJHWEhTaGltWnZOYlMxYWdtaXV6aDd5N2VHd3k3WXgyaXFqVFZ4ZVlZ?=
 =?utf-8?B?dWZWREVYdXJseEFCWW1aS0o1TitpZ3hDUks0UVVDZDhvd0pTcThVd1NrckpQ?=
 =?utf-8?B?RUdRdy8zeTRvWnd6Y3dtdGY5M0lQTUFBeFZ2cDJsZVdGRzJOeTluU0M1cDRM?=
 =?utf-8?B?dXBvZzdYWVRwZHIvUFBFQ05NaWtueWFZNUxwNnk0a3RzWFRjcEpTTFRDTTR2?=
 =?utf-8?B?YzdFbnlXVEY0eWZZbHViZ2FZQnlZYmlzRUdoSVFxTmc3RkVLZHEyclM5c1RC?=
 =?utf-8?B?MFJqZGkvRWFSSmFvWnovSWs4K1piaGozemZRR1dSYXRLSmJwVTY3ZkxJay81?=
 =?utf-8?B?RkZSMlZ6cVdObkx0VHVpQ25WejFZZ3BDMWFVUVdBR3EyZlZaNmZBMzNIK0N6?=
 =?utf-8?B?czVBQ0ZPaHREUlQ1VFVMdFQ5dForZWJQak5EK1d0Wmx1NHZEcG9jU0NPc1k2?=
 =?utf-8?B?TDhoZVBMbEZCOUp4RmExRDVYcmRzMncraDBpS1g5NVdOY00vZndaT010ck9s?=
 =?utf-8?B?RzhRVElYVHVwZ3YzRzVlNWNJMHlhamM4ekRpQTN6UERWZ0R6QXZGUE05dkY0?=
 =?utf-8?B?Vm13Q2tVdEMzdFMwNnNGUDRHRkZ0eGFiS3RSUzl1RVV3R25hdi92MkRzczBV?=
 =?utf-8?B?RnVHbTAzVlVsS2c5Rjlkdk01SXplWFZ4eDZxZUpJb2FvTFA5d3IrRXlXNGZj?=
 =?utf-8?B?N1ozUU9UTmFLdWY5VnJ1NWF3UStHMDhrc0ZnWENwbTVXN2ZPVFlFT1ZCRGZa?=
 =?utf-8?B?amJsL2UrbFNkcUdLb3VvRC8rdmsrclBZKzdwNitBMWpPd0h6Y0Z6U244Z1N0?=
 =?utf-8?B?TC9yemxkQ0ZHV3RzejRPN2FDZDcwM1lQYnpZamM0M0Jic0NOclY1T21QTDZw?=
 =?utf-8?B?dy8vTGpZSVdGYWx1aXQwSDUydkE1bXJ1RXpaNkRvUThLVTdxY3U2WlFCZ3ZP?=
 =?utf-8?B?SklkM3JZanRYSHRJcEJrTVNvU1IvUUVUZ3NVdlRnalVJRXhGR2F6Vmt0Si83?=
 =?utf-8?B?YmgxWmdRS2NzTnBTNXIxLzJwRDBJZkh6cEhsZXBWMGlVVnBVTVJ4a0pvR0Jh?=
 =?utf-8?Q?q0gdlqnYA9+qij+fGpR0t0jeW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b2fc93-f6bc-4575-d088-08dd66480edc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 18:09:43.1825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hpcXPBHyerRzG2KnPPxM1/OrAtYVQtFtr5NahsVLK8OeMZTIe4LmjqDgJBeR1qaQk3OMpUUNjxtifV31JMpcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
Received-SPF: permerror client-ip=40.107.244.69;
 envelope-from=dtatulea@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Mar 2025 16:27:30 -0400
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

Hi,

On 03/18, Lei Yang wrote:
> On Tue, Mar 18, 2025 at 10:15 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 9:55 AM Lei Yang <leiyang@redhat.com> wrote:
> > >
> > > Hi Jonah
> > >
> > > I tested this series with the vhost_vdpa device based on mellanox
> > > ConnectX-6 DX nic and hit the host kernel crash. This problem can be
> > > easier to reproduce under the hotplug/unplug device scenario.
> > > For the core dump messages please review the attachment.
> > > FW version:
> > > #  flint -d 0000:0d:00.0 q |grep Version
> > > FW Version:            22.44.1036
> > > Product Version:       22.44.1036
> >
> > The trace looks more like a mlx5e driver bug other than vDPA?
> >
> > [ 3256.256707] Call Trace:
> > [ 3256.256708]  <IRQ>
> > [ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
> > [ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
> > [ 3256.256715]  ? __build_skb+0x4a/0x60
> > [ 3256.256719]  ? __die_body.cold+0x8/0xd
> > [ 3256.256720]  ? die_addr+0x39/0x60
> > [ 3256.256725]  ? exc_general_protection+0x1ec/0x420
> > [ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
> > [ 3256.256736]  ? __build_skb_around+0x8c/0xf0
> > [ 3256.256738]  __build_skb+0x4a/0x60
> > [ 3256.256740]  build_skb+0x11/0xa0
> > [ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_core]
> > [ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_core]
> > [ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [mlx5_core]
> > [ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
> > [ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
> > [ 3256.257226]  __napi_poll+0x29/0x170
> > [ 3256.257229]  net_rx_action+0x29c/0x370
> > [ 3256.257231]  handle_softirqs+0xce/0x270
> > [ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
> > [ 3256.257238]  common_interrupt+0x80/0xa0
> >
The logs indicate that the mlx5_vdpa device is already in bad FW state
before this crash:

[  445.937186] mlx5_core 0000:0d:00.0: poll_health:801:(pid 0): device's health compromised - reached miss count
[  445.937212] mlx5_core 0000:0d:00.0: print_health_info:431:(pid 0): Health issue observed, firmware internal error, severity(3) ERROR:
[  445.937221] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[0] 0x0521945b
[  445.937228] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[1] 0x00000000
[  445.937234] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[2] 0x00000000
[  445.937240] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[3] 0x00000000
[  445.937247] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[4] 0x00000000
[  445.937253] mlx5_core 0000:0d:00.0: print_health_info:435:(pid 0): assert_var[5] 0x00000000
[  445.937259] mlx5_core 0000:0d:00.0: print_health_info:438:(pid 0): assert_exit_ptr 0x21492f38
[  445.937265] mlx5_core 0000:0d:00.0: print_health_info:439:(pid 0): assert_callra 0x2102d5f0
[  445.937280] mlx5_core 0000:0d:00.0: print_health_info:440:(pid 0): fw_ver 22.44.1036
[  445.937286] mlx5_core 0000:0d:00.0: print_health_info:442:(pid 0): time 1742220438
[  445.937294] mlx5_core 0000:0d:00.0: print_health_info:443:(pid 0): hw_id 0x00000212
[  445.937296] mlx5_core 0000:0d:00.0: print_health_info:444:(pid 0): rfr 0
[  445.937297] mlx5_core 0000:0d:00.0: print_health_info:445:(pid 0): severity 3 (ERROR)
[  445.937303] mlx5_core 0000:0d:00.0: print_health_info:446:(pid 0): irisc_index 3
[  445.937314] mlx5_core 0000:0d:00.0: print_health_info:447:(pid 0): synd 0x1: firmware internal error
[  445.937320] mlx5_core 0000:0d:00.0: print_health_info:449:(pid 0): ext_synd 0x8f7a
[  445.937327] mlx5_core 0000:0d:00.0: print_health_info:450:(pid 0): raw fw_ver 0x162c040c
[  446.257192] mlx5_core 0000:0d:00.2: poll_health:801:(pid 0): device's health compromised - reached miss count
[  446.513190] mlx5_core 0000:0d:00.3: poll_health:801:(pid 0): device's health compromised - reached miss count
[  446.577190] mlx5_core 0000:0d:00.4: poll_health:801:(pid 0): device's health compromised - reached miss count
[  447.473192] mlx5_core 0000:0d:00.1: poll_health:801:(pid 0): device's health compromised - reached miss count
[  447.473215] mlx5_core 0000:0d:00.1: print_health_info:431:(pid 0): Health issue observed, firmware internal error, severity(3) ERROR:
[  447.473221] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[0] 0x0521945b
[  447.473228] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[1] 0x00000000
[  447.473234] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[2] 0x00000000
[  447.473240] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[3] 0x00000000
[  447.473246] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[4] 0x00000000
[  447.473252] mlx5_core 0000:0d:00.1: print_health_info:435:(pid 0): assert_var[5] 0x00000000
[  447.473259] mlx5_core 0000:0d:00.1: print_health_info:438:(pid 0): assert_exit_ptr 0x21492f38
[  447.473265] mlx5_core 0000:0d:00.1: print_health_info:439:(pid 0): assert_callra 0x2102d5f0
[  447.473279] mlx5_core 0000:0d:00.1: print_health_info:440:(pid 0): fw_ver 22.44.1036
[  447.473286] mlx5_core 0000:0d:00.1: print_health_info:442:(pid 0): time 1742220438
[  447.473292] mlx5_core 0000:0d:00.1: print_health_info:443:(pid 0): hw_id 0x00000212
[  447.473293] mlx5_core 0000:0d:00.1: print_health_info:444:(pid 0): rfr 0
[  447.473295] mlx5_core 0000:0d:00.1: print_health_info:445:(pid 0): severity 3 (ERROR)
[  447.473300] mlx5_core 0000:0d:00.1: print_health_info:446:(pid 0): irisc_index 3
[  447.473311] mlx5_core 0000:0d:00.1: print_health_info:447:(pid 0): synd 0x1: firmware internal error
[  447.473317] mlx5_core 0000:0d:00.1: print_health_info:449:(pid 0): ext_synd 0x8f7a
[  447.473323] mlx5_core 0000:0d:00.1: print_health_info:450:(pid 0): raw fw_ver 0x162c040c
[  447.729198] mlx5_core 0000:0d:00.5: poll_health:801:(pid 0): device's health compromised - reached miss count

This is related to a ring translation error on the FW side.

Si-Wei has some relevant fixes in the latest kernel [0][1]. And there is
an upcoming fix [2] which is pending merge. These might help. Either
that or there is something off with the mapping.

[0] 35025963326e ("vdpa/mlx5: Fix suboptimal range on iotlb iteration")
[1] 29ce8b8a4fa7 ("vdpa/mlx5: Fix PA offset with unaligned starting iotlb map")
[2] a6097e0a54a5 ("vdpa/mlx5: Fix oversized null mkey longer than 32bit")

Thanks,
Dragos
 

