Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786D2CFA473
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJaA-0005Ic-Dc; Fri, 21 Nov 2025 00:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMJa8-0005Hw-PN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:21:16 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMJa6-00039i-Jg
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:21:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iib0uLBxVDaVhMNwDI96IFamEMhe9E70sscMz+Ui4PIRedf5HMmS5XlO8z86E9xDLm+dKPzdO8ZJNbnuturhRuPV1/8axgwpkauORcx7aT1utLYMxK8LwOGufDlB4HFuBqeoAmzfsht2UekYbg0gFfDLAqGNdsMkON9wxi4SvHwXHVSbOBiAtxGb5qVlVtNhv/htS7lVnnXvjITSCUOp4QPlTKFyzS+dKJkuMfHseSLDJ0cZtv0Eo3jp54D1gfOAMuRNMpH1Bn9pWRuDZ2LwSXM9lkRD+w8uZaqnk3yGqWNe1wNg7if2+y6rr1vFUF3z1CohB2i06JRuCBp8zk03Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dDhAQzHSDEBsJ9yKEEwQruYJAdXPwGpVy74ESsMYA4=;
 b=TrJvew6XZv6MCHuK4b1ucB04URqOSIorx7P7O28f0gtaoAt2BtNushdbfSt83JS7/A3me31VTtxkjb0NhJjxXapeW0p2iPjuaoShdsD8gNwPNyQekmUCeUg0ZKSPMNlS9+nvkKYunkZ+O7fkstXeKhCE1J+ZVpAcg+uCjAI/toBXqwbyRClziehr5co8YeieSxCOgtA9mAF2AyF8QGpS6+sJYi9OivrwSzRq1JwDXYkdXa/XPhso1hu4v1gFW/c6YUAoZGlb5PNFWE98spZLH1E68WpzUdM0qn4ddHCliItYDz+KgpOe3xVDPtDgHsckvmCN74PWw+xK+jf1beVMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dDhAQzHSDEBsJ9yKEEwQruYJAdXPwGpVy74ESsMYA4=;
 b=n5YA6b6mIzMwksY7HwyNeUMLsbIKyTAqpcZmfr12hsSxHKqd4gjtR0IZIGl68YOwX9qd9mv3NcLvbpAC/dBHmWECwfVtIoSraNtGJQdZ5++Fp9ed1E4qYewx1kNv5cjbTREdBpiXkQF+ylBcy/qvIdBoBb14AiwdcnYrDrN9bD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:21:10 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 05:21:10 +0000
Message-ID: <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
Date: Fri, 21 Nov 2025 13:21:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
 <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:820:c::23) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b14a575-0911-4b6d-0cf5-08de28bdc799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW50ZUExcmdKY3ZuMmN5UkZ6QmFYRFJ1NVRNRFRVeTFvOTEzaEZyRko5dTVS?=
 =?utf-8?B?Mk1IdHNUQXl0R01qVDJuek1rU0hHbHdUcHFzNUVldTNQMnNjUytIaXV5aGp0?=
 =?utf-8?B?OU4zcGY0Z3h4a0hEYmZNYjl6Mit3dkx4d1hQcSsyZEx4TXNORE5oUC8zeHJB?=
 =?utf-8?B?bmIwcHh1QTkxYmlLQTlnZ0xHWnJQWEVmWVQvckRPeGYvYmxaL3RXNllIWXJD?=
 =?utf-8?B?aGhmYktieXBWbitGUHVhUU44d21HNXdJYlBiMGYxeEM2NWkrdUR3RFRQNFVC?=
 =?utf-8?B?ZFlFdUl2c3ZFYkNXSFIzakFYdEx5UFR1T2RhL1lHY2VjSDZqNThjSmtjYnlk?=
 =?utf-8?B?TTNrVkpoelRiclNlT2g3V3NjbVloeWRZRW1BNmdydDNhOE50QzlsUXRMMGZF?=
 =?utf-8?B?KytsbVdVcmJZT2g1YSs1Y2R3d1AxaVRpcjBIZTlLd0c3aTh5a0xQV0VxL1la?=
 =?utf-8?B?Q2lWNGliYzJ0aW1Xd3RQRklxSks1U1FoM25veHd6c2dycnMrZ05GbVVrY25q?=
 =?utf-8?B?c0RKRUppYnY2c2hJbkNkTldhV3MzVEdGSDNEM1dpR1BtN21walliRm85Mm5N?=
 =?utf-8?B?YnVNOE53YkVWZU1QK0FNODdkcTZCcHZwYkZuT3RGNlZ3NFh3QkRBbDRjZ2Rn?=
 =?utf-8?B?QyszSmJGQUwyLzFVbGRWdlhYQkpWZEdBOFlHVjBJdnJkQy9BdVduYkF0cWYy?=
 =?utf-8?B?bHh3azZpUG1CVWFQTk1zV3FYUnppZjFSeFJUc1BFTTV5aHhnMGh4a2NyTmp6?=
 =?utf-8?B?SDNWcjJ4d2QyM29URHVDb0hycmVFcEY2NVlUR2puMUhabmhOUkg1MUZENTFl?=
 =?utf-8?B?RG9uSXZVV2JGUGxHN2ZoYkZ1cFV4dm1BN0pib01NWUtFbDRTeXZ2VHdBdXZF?=
 =?utf-8?B?bnZsRWlTNUNDSXNqRDgrN0UvSHArNnVFV05XSEVUQ3pjRTJVV3pBNTRzenR6?=
 =?utf-8?B?VVVCTytXQ1VUdTNqZ3F6dUFsYnJMWmxFeE9WSVMxVHBVSzRhUjhEU0dEM05Q?=
 =?utf-8?B?Rlg5dnB0UFl4Ym1PUTR3TTZGQlNvL2wzZXBJNE1vMUx3NUJsQmlFQkticHRZ?=
 =?utf-8?B?am9yYUV3ZmVRamRsSzAzWkdUSHVvWTl0UjM1LzIxWkVtWUxJeWo1bUd0V1hi?=
 =?utf-8?B?NjA5bHUreUxkWVBRZi95a1U2QVFQTTRIQ253WjZJSmJCb3NqZUNoM3BsZWNJ?=
 =?utf-8?B?L1QrRUdVaXBpRFNTcGRRbWJUai80cWE2bzhnblNYT0hKT2pRNUdOVDJzRVY4?=
 =?utf-8?B?QkdwUHQ3bDE0QTBMbWRGVERkMW9QTDA2TEM2ejV5REVaTUNzY0hYOUFvUVl3?=
 =?utf-8?B?cnQ5QUdxeVFsU0VjTjNobmt2MkJqWTVpQlNKdDBsOUlGbnM5cXBpSDU1M3F4?=
 =?utf-8?B?bVFraFdEbW1hNXBqcHl1d2Y2am9Xa2kzajNmbFFKaEV3eEFESTdjb2dURE5M?=
 =?utf-8?B?RnhBTEVMSTRpUjZ5MUxPamdiQUlpbFZLUG5NbjE3V05RaEZCMlpsVVpNSDNh?=
 =?utf-8?B?cmtRS1Q1YTZHeUJ5QW9DVFZoYTlTR08rbmNpL1ZJUFRkSzl4bmlhLzR2bFg2?=
 =?utf-8?B?ZUVFUkRhdEJkWkV1dGhYSFFtajNsZVJNYVRhVWwwT3RHaC8xR1BpSm5QSkdp?=
 =?utf-8?B?a3hLUGZZQ1RPNjVVVEliQ2MzcWFKWm1FdWhWOExHVko2dUF4YVZSZUV1cFhi?=
 =?utf-8?B?Z0NKTCtXeEhPazJZYWtGaWh4c3dNNDdyQ1JMcFo2L0w1b3Fnc25RZ1VDQUUv?=
 =?utf-8?B?RTAyZlp4cFRxTS9hZEtUWDZVMmpBaWo4RmNHRHBCdG9HL2RRNWRINTNia2hw?=
 =?utf-8?B?Zmw1RmU2dFlod0lWN2QyQjRHZGMrdWZ0V1hyM2x6S0RJK0JPRWxPa0s1czFl?=
 =?utf-8?B?R3dnUkloakZ0OWlVR0YvVVZHekVyeG16NHpOU1hLS2F0a2tudmdjNzRrY2tW?=
 =?utf-8?Q?ZmBTzwxZPc4oVz/TYS9q63TZMaLr1JJV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0Nvbkc1UnRoUXdpVSt6VXVWQy9KUGd5TEQvZ0w5S2JQRjBvWGhzM0tSaHZt?=
 =?utf-8?B?T1dxYkpNS0gwcFVHUGlNKzdDUnArRDJwTTcvWE03QitSaytRZ3oreGYzL3FR?=
 =?utf-8?B?UVQ0S2NQVzBCZTE1K0VNZDcxTXZoMFg5K1NiTmIzQ0pYTzVuZkJMZC9reWNi?=
 =?utf-8?B?WHZPdjhxRTZ1ckFtQnplVmVDQi9EcEFBcFF3RWpRc0RXcmlRSkttenVaazVa?=
 =?utf-8?B?cUdsTzNPTTVudDdqM2lzMUhPeTd4MmVUdFR6cnhzdW5sdHdwTTdZaDg4U1h4?=
 =?utf-8?B?SUpvZWt4OUZ1N2FjTFNBc09MWDlZSlYyWHptaXB3QW55V28xYW85UFlTaHBi?=
 =?utf-8?B?aUhaQUpDWEJtN2pPamk2ZW5Wc3pTRklrSkNXMTE5WS9iVmpFQ2VSYS9xUG53?=
 =?utf-8?B?MHBjOTY2TERNUS9wbVNocXdLc1FKdlB5NlVMd0NUcWpVZFVZUmIrazNjOExv?=
 =?utf-8?B?RGtZUk9talE5alBOYk1GMDhQOWpyelhuUW1rNHg0MUEyUVZMVTNjSjQ3emc2?=
 =?utf-8?B?QkNOV2JDaFdmTHhZRTkzejN2cTQ4UlFhdk0zakhOa2UvQU8xbWpjVlVqTm40?=
 =?utf-8?B?M1BWNFFBalVTZWtvUVphZGlLTUg2WThTQUdkUEhneWNQRXc1MFQ5SFdSdmg4?=
 =?utf-8?B?WVdkU0FmMEFnMXRQMzU4ZS9CRklBbEtpZlhUaFdicWhEWm1UdUM3VU5waGU1?=
 =?utf-8?B?NENMdmdtMGtKdmRBdzhLLzdDMXQ4Nkc5UklyZUpTRDgxcEE0a2VmUHNncUdo?=
 =?utf-8?B?MHpDZ2xEWGQ5b1YzQzg3TEtrdlE0dTNZWk1KSUc2c1BDZk9TUGtINXY3b0tj?=
 =?utf-8?B?R2lFdW5rNW5PRC9VZVJGSnl0ZWZNV0RvZy9aNXo0UDBuOWkyc291dHFENHpU?=
 =?utf-8?B?MGtYaDdaZE1DM0Y0YklyNm9MZDViU09GaC84MmQwaiswcWVKdkhGdU5JeHVn?=
 =?utf-8?B?RVBCYTlGbTJzdXdobk5hM2Q3bEsvNU9sU21BQ05qYnJTbldBTlpXQzRrNFg1?=
 =?utf-8?B?Yk9KL2loMVl3V3JKcm41dThmVys2WTJTSEhWN25ERVJvZkRtejRMd0RoUlFD?=
 =?utf-8?B?Y0JTYkp6OUxVc2gyNFRSVnZZemVCRUMvN0RDdnByajBLNCtXQUx1Qkd0K2NM?=
 =?utf-8?B?UjFqcXppaTBRWlFZQjNkdEJqSFNweWlUQTlLc05pMEQvWlpRdU93Uzl3NW5E?=
 =?utf-8?B?b1pMZlpQdURGM2RzajZBczQ4WjVKMHNPZFY4R1dWcXB2ZjQwUnBsVjIrUGps?=
 =?utf-8?B?blB4TFBpWXVzQnBTOFRXZ3IwWFJRMUhrTkxTTGdDdXNGWnZZWlo4VnIvQ2Ny?=
 =?utf-8?B?S3JXbnYzMzc4N1Q2QUxYckJIZlF6MUJHSTRQVzVyeDFIUzM1NitXUmp5Wm1o?=
 =?utf-8?B?c1JQUmZITzRpSXRwZnFxYnkzS2dPdWpaUGkyTnhrOXlTWWlMcktmT0JpWm5H?=
 =?utf-8?B?UXd5QURqaXk4c3E2ZUpubjEyWTczajVQM3M0V01OSHVnMDdsN3Q2clhvSVNr?=
 =?utf-8?B?SEU1Y3RZVVJzbEh2QVVULzRkSE9RVmtLY3BuNmdvTkxXWGdSVEc1OENLR2Rt?=
 =?utf-8?B?Tm9wdDFxOXphMmczK21ELyttbDNwOFNuV0MyQktvN3NwZm4zVXRUcGZmRWdL?=
 =?utf-8?B?T3JCZzNhVGV5NS9CSURBbms5UkxHS2huTEh2QXBFRzlKY2JlQ2pzUE8vVjJw?=
 =?utf-8?B?QVlucjFqeE1idWo1ZWFCSHo1bm42aitERUp6OTdjMVdDelJDK1FXcDJxbFZi?=
 =?utf-8?B?L3NzdVloK05vZHZnSlN1UXduREsrSDlXTEZBL29GSGwrSlpsalRZUS9zeXcv?=
 =?utf-8?B?bHc5Vk5nVnBNMEVNRSszNVkybHdRM3BTY25mbVgvNTlxMUdJNUlrODVsVkRM?=
 =?utf-8?B?RzAxSTNwZFBRQVU2TFFUYzJQSUJhTjhXbTRWMldXVFpETWpiQmdLVVljOEVQ?=
 =?utf-8?B?c2k4bjNIakUzekZoUXNVVWw3Zmc2ektwdVA0Z3psaVQ0TlAxVUxiNlRZZGFt?=
 =?utf-8?B?b3Z4U0kyQVJpMTN4MEdjTk85dytKcm5iOG5UVTJVV0R5b083bk5aNUJ6Qzk3?=
 =?utf-8?B?UDlJRTFIb2puS3AzSlFHT2t6amVickhYVFd1cE0rbG1VbUFyYmtOY3dqUmpr?=
 =?utf-8?Q?sp4+ZRMg14UawlDGhK8bGCGoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b14a575-0911-4b6d-0cf5-08de28bdc799
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 05:21:09.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCkCOVme+N2By2LND9OK2YBYhhV/nZuKW75ZaUCk+Tbqz9/HffUsH8gEq+dSbDm3fSIzH3ugBV4vDPHbGBQyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/21 11:39, Akihiko Odaki wrote:
> On 2025/11/21 12:14, Honglei Huang wrote:
>>
>>
>> On 2025/11/21 10:56, Akihiko Odaki wrote:
>>> On 2025/11/21 11:47, Honglei Huang wrote:
>>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>>> user pointer mapping for blob resources. This allows guest applications
>>>> to use user-allocated memory for GPU resources more efficiently.
>>>>
>>>> Changes include:
>>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>>> - Enhance blob resource creation to handle userptr flag properly
>>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>>> - Add conditional handling for userptr vs regular blob mapping
>>>
>>> I don't see the added conditional handling.
>>
>> Sorry, the additional handing is replaced by the fixing of value check.
>> I will correct this commit message in the next version.
> 
> Not just the commit message, but it also questions the utility of 
> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_F_RESOURCE_USERPTR. 
> Neither of them adds a new functionality. They should be dropped if they 
> are also replaced with the fix.
> 

Yes totally agreed, it is my mistaken, I shouldn't mix the code for 
fixing and the code for adding new features in one submission.

Actually this patch set are for another components upstream test, for 
the sake of convenience, I have added both the fix and feature here,
that is a bad idea.

Will split the fix part into previous thread.

And for the check value fix thread, will send v4 as the final version.

Regards,
Honglei

>>
>>>
>>>> - Support guest_blob_mapped parameter for virgl renderer
>>>> - Fix value check issue in virtio-gpu
>>>>
>>>> This enables more flexible memory management between guest and host
>>>> for GPU virtualization scenarios.
>>>>
>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>> ---
>>>>   hw/display/virtio-gpu-virgl.c               | 2 +-
>>>>   hw/display/virtio-gpu.c                     | 7 -------
>>>>   include/standard-headers/linux/virtio_gpu.h | 1 +
>>>>   3 files changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu- 
>>>> virgl.c
>>>> index 07f6355ad6..c927275c79 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -705,7 +705,7 @@ static void 
>>>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>>>> sizeof(cblob),
>>>>                                               cmd, &res->base.addrs,
>>>>                                               &res->base.iov, &res- 
>>>> >base.iov_cnt);
>>>> -        if (!ret) {
>>>> +        if (ret != 0) {
>>>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>>               return;
>>>>           }
>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>>> index 43e88a4daf..956dc811fa 100644
>>>> --- a/hw/display/virtio-gpu.c
>>>> +++ b/hw/display/virtio-gpu.c
>>>> @@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>>>       size_t esize, s;
>>>>       int e, v;
>>>> -    if (nr_entries > 16384) {
>>>> -        qemu_log_mask(LOG_GUEST_ERROR,
>>>> -                      "%s: nr_entries is too big (%d > 16384)\n",
>>>> -                      __func__, nr_entries);
>>>> -        return -1;
>>>> -    }
>>>> -
>>>>       esize = sizeof(*ents) * nr_entries;
>>>>       ents = g_malloc(esize);
>>>>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/ 
>>>> standard-headers/linux/virtio_gpu.h
>>>> index 00cd3f04af..b85e781a2d 100644
>>>> --- a/include/standard-headers/linux/virtio_gpu.h
>>>> +++ b/include/standard-headers/linux/virtio_gpu.h
>>>> @@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
>>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>>>> +#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
>>>>       /* zero is invalid blob mem */
>>>>       uint32_t blob_mem;
>>>>       uint32_t blob_flags;
>>>
>>
> 


