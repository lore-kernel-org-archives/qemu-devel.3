Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3DFC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuLH-0004W5-7u; Thu, 10 Jul 2025 12:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uZu3L-0006gc-FH
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:23:20 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com
 ([40.107.220.63] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uZu3H-0002Ic-JQ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWfDU1s/0OZvGQGLmqdVTLnI+JS0JK3zeVTMSPMbNcYY/h69mAhx5ohnK0ZTxwKGryYk3Hgn8J+mi/ykeRRue5F3TtGDQtXok1OsUcNxGDXmPt6azu6dI9oqKQOYclb+RCbH6qLl/U3FyLgMfIwlLG3HnjRQRMICPJggy1PrSWYveVi2EjkEBXsj7+LWQD13ignQvsIotLODxDme0S7BAtRQuaPec1jeig0SpeTH/j0b0J90k65HNlLqK+dNQIlKgdJfYEvMHXvxTuXifyURMJVgBd6ZrwPx76Quxvnk+mHeZ49d5ZQLZ+H+UwxXGm82pSnxwmQP2aAlpwMWJrdDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvDDt9Ws3zJfi+OxUzq4eITsXZGOp1vvKfBCN+o0qH0=;
 b=VfV6/Y4i5lKaDGw7qrXAXqmrIC1tLdxJqwCoXoDldux+uV78x+ybBR6M7jKb9iUlgL/INhMEMT+jfzlO2J9pY2sSqlNZ0oBtyP9vd9/nCaKUSWbkiJwOjt6wVBiRKIoMJwp+FQC6FQjBHiYuQb0my1ylQzJ6T6AZAQTPs0yX/lvNNZd2Kgfvn1AN0DAocCy9GoH6FU5/Al9E7Ukp0e8DcmZMdW/kMFvQyIFSKrDdU7E0ij2YWrtps+KjqbH841yHb6h1TSmwC4kNYmQEO97T1Q/g/gBLV5D2509zGF0hBKvK0KOg4CeIp6fOY0M77VEC1w7z0JXLpEsQa/PbOAnKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvDDt9Ws3zJfi+OxUzq4eITsXZGOp1vvKfBCN+o0qH0=;
 b=a/ItZ1JHRLK/wtQOmsJeUOayW1K8Mm35PxybYjXrbnGjBLFypuRI/NDicV7+XE+TMHoMXqbAAkHpeuJ/JFE6EvIHcaG2WmWMQwW3U1+2M6wb269MKLL24aa5yaIQd8ZV8xMzNgkKJ0XjLxdkZONS9+FnxGf5F9drYASqTfiv5KA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 16:18:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:18:07 +0000
Message-ID: <e5b7a35c-8a56-489f-9f72-3fac963ad4ab@amd.com>
Date: Thu, 10 Jul 2025 11:18:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Add TSA feature flags
To: Xiaoyao Li <xiaoyao.li@intel.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
 <8ba851bc-e7b3-461b-9bfb-4d7018771f0c@amd.com>
 <de97d1cc-69c9-4fcf-aa7d-3989475549d5@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <de97d1cc-69c9-4fcf-aa7d-3989475549d5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:805:66::36) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba65192-1f84-4149-be5b-08ddbfcd58eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWx0eEg5dW45SWE3N09oQ01WUkVLQk5LZmxVcFFMMGJvb3NZbUhxb3d0eUFM?=
 =?utf-8?B?SUF3QU1GQ0RKaWRPQk9WdlhNRGh3ZmxadXhVT0xpSWx6WW9yRmFOaEZnTm94?=
 =?utf-8?B?Z284ci9oVDJ2N1Fzdk85SlVWczYwQWY1ejhueWZGUGo3OWlXVkNTL0sxZTV5?=
 =?utf-8?B?YnQ2YVJwSG9Da2xvS3dBcXRQOGZGNm1BT2JlT2FWeUViN0Zra283MVJJSmpl?=
 =?utf-8?B?bVVsMmlwa2lYUGo5SlhHTDNzOFU3OHMyc2ZVS2JUd05YNDEyOFQwR0RsS1gw?=
 =?utf-8?B?eUEyZTZCL1psSmZobG44REwzYkx4TlZxOStFL1hEMHJaSDZPUUJvN200MHdK?=
 =?utf-8?B?MjdnRUJFbUFsS1dsNW1CZERISXVCVFArUzZzcVJEM0xnbXF3U1dmbDBXR1FZ?=
 =?utf-8?B?NEtoRTZmQXN3MzQxYkhIaUwzMVJ2Y0xBQ2Q1R1JGTXVyNTJyWkRwV1I5ZmZP?=
 =?utf-8?B?WUR6UnpkcG9DYThEblZqWXJ3VDVCNG04dVZtbitaQVZFc3U5eXdNWWxyTEdm?=
 =?utf-8?B?cEp4YmlmUTlpN2hTTW51NzZBdGlibXpVWm4zb3Eyak5zMlJHVEFyb09ETTBV?=
 =?utf-8?B?akluQkhJcnd1Unk3M20zaWRXV2pzZW1zREtPYUNDVktoUmp0SWNDbE5tbm5Y?=
 =?utf-8?B?d3FxSGMwZE5MRnRxWXZKVWJLYWZIYjNsbTZTOHQ5R0NDcGxlSW55RTNqVThk?=
 =?utf-8?B?TUd1M29CenFUdHhzT1MyWndJdkg3Zmh4SGN3SjU1alMwbjFZR05QVGthYUJF?=
 =?utf-8?B?WTdiRENCYTdabWFNb3JKZGVwRG1ZS3ZGVGZTZVFzODJKRFN3ckkxb01rSnZJ?=
 =?utf-8?B?QTNhLzZ0cmx1bDJTamQvL1hGY3hjdjdpeUxnRzBSMndxYjYzS08weW10aDlS?=
 =?utf-8?B?cGhDeThFeVc3QnZCUys3b0gyYnMzbTQzYXdHYnhUZnBEcjJDblVlbFVuTlJ1?=
 =?utf-8?B?TS9HbzNCQmhmTzRsM3crOVk1Q0dhZUwvVFJYSXdMV3JUQmNTNG9DUGY5TzZt?=
 =?utf-8?B?QnY0enlqTXV1bk1kT2MydzhNdjh6TndNUDV5VW1tcGVyeDQrWUFMZEMyRUpj?=
 =?utf-8?B?NUZoUHlqWFhMLzNEMDBIeEpTL3Mrbzgrc0Y2bG1tYVhyVWhBRTdYaHRzS0tF?=
 =?utf-8?B?amZkMDJ0R2tHd3ZGWnpLc2lHcjcvTDJOVklLQnRZNzR3Rkk4L25DUlhOQVZI?=
 =?utf-8?B?MUtyRlNINld4TGxuZE13bi96QWFLOVVQVGxkWTE0amZVNTlXalpzQVRJYmxD?=
 =?utf-8?B?d2wrcHhXN3BNQnJmRStEa3J6UmhrcytBdHFycFRKYkNWc2d2Tm4rT0xObmox?=
 =?utf-8?B?blVaR2NIL2VhRHZIZmREL2htRk1ORkdvWkVaaFNlREF1c2JoS3plSEE5cFFH?=
 =?utf-8?B?TVNEbEF0bmxWeVpFNUVuYjdrMnFRK0tLY05oYUU3QjQ5TmhxUGdaZkF2NHBM?=
 =?utf-8?B?SlRsZ3daWUNiYkcxL1dIbVVrTkYvOVcyVUhBVGNJMjBkODZDTVp0ajdKazBo?=
 =?utf-8?B?enR4YWN2NmE1ZVZ0MTJ1dC9mMklwb2pCQXNMVXQ2L2Ftdmx0UjR6ZlBRNkJL?=
 =?utf-8?B?cVRSNmZFNE9ONjFrU010WURpQUdiMnFBS2xZc2wvNjVDN0pXOUZNUVd4STRl?=
 =?utf-8?B?dDgwTWJXQnNNUUVJZVdOaktKZ2xmRUUwNWc2WkVPZUlKaXYwZUVkYXRYMTU2?=
 =?utf-8?B?M1U2N2FvR2p1NXVZaHRYdThuL3hhenhRMUZpQmhsaE1wWUhhc0JUQjdTZTQ5?=
 =?utf-8?B?NHhTWGZJWGtkZlh4dVlycVljK0gxNEVEc3hZNW5xdWRXb1ZJc0hiMUxkcE1F?=
 =?utf-8?B?U3I0eWtsK0JHYU5DSU1pSHMzd0U1U25Mdk9pVG94blVONUlUREl4MkVkcFI3?=
 =?utf-8?B?OEIzS2VlU0tvYjZqcWtQYW91SUxaZnpmaW5MY1FtWERxTThZaUJoaFFPVkxV?=
 =?utf-8?Q?GCR0z3/rdfw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZLWVpGK3poZVk4aUJEQVFnclVacVc5eFUrMUczUVk0UE5oV09WbEVVSFox?=
 =?utf-8?B?clBXaHN2dU54VjNkUG9XYSttMDl4b2UxMmR4dG9yMWJ6UlpMZVVvcnd5YXNH?=
 =?utf-8?B?enEyd0JqSVlJbzgvMTNQWkkySUsxNFpkeHhIa25nZmJXOEovUEdUa0RDRG5P?=
 =?utf-8?B?TXA0RVpwdXZtc25HMkFjVUsxMHpyOUlzQjl5Q1g5YUJ2RHlGajNSRlZnSEFS?=
 =?utf-8?B?ejZzR3JWaXN0ZkJZdWpMTjFBSzk0Ly95YTdFYUd3djhISzFvZjRZdnBWYUZQ?=
 =?utf-8?B?aE9MUlhiQ3RwcmJwN21zMjVpREdTdzlid0NVZG0yRithdHRlMWVDUDdJVTFX?=
 =?utf-8?B?R290aXp3K1JOZ2drSURaK1l0alhENzA2Z2xBbkRjQ3hIdEJvMDBqbjdvODU1?=
 =?utf-8?B?MFNXYVpwZFo2UzdqZVM5bW9rL3ZEd0lPUlVMNkovSVpNK0I3QkJzMHJtc0V3?=
 =?utf-8?B?NmdpbHdhNkxoaHk2WUZtYm9KaUxuZVJpRmFnL2NCZTh3STFnZUVJcHk4NU9y?=
 =?utf-8?B?b2YyWnhLQlZBUHQ1Ym96UjlUY0htU1ZjMmNOR2padklvMkJiMW1FWXJsNjE5?=
 =?utf-8?B?QmtNWnZ0Z2hjK3NhT3VEWTdyVEVhQmdyN2pWWWdkQjVELzUrV2VEK2IrdEo0?=
 =?utf-8?B?cGpTakd0di9vaS9jWktiZVlhR1lkdTFzdDE3QVErazBnWEUwT3huWFNReXdl?=
 =?utf-8?B?VW9vc3JQOC9zWmpMLzd5aWlHS3c5K2EreENmMFd3aXVOdDgwRTJzOFV6emY5?=
 =?utf-8?B?bmdMNXVXcWR5cld4bzQ0RlNZNzRLU1ZVY1NNOHArdlVYQy9qcGdyL1ZJTERH?=
 =?utf-8?B?cG1JbVZFYVJ1TS8rWmRubnNQaDVvRkZFSFg1dUVTd2piVUU1aXlyQ1ZRdHlN?=
 =?utf-8?B?TjNHUFRrd091Rkg4c0RGMzZvWDNpZzFseWdZaE1tVlhwNnNaSzdCc3dOQVNz?=
 =?utf-8?B?UFp3U0FReklTZmY2a2p5TkRrWkc2amdOeUVkQmltY2I3cDBnUTE2ZW5IOFBP?=
 =?utf-8?B?dDZCcjh1Y3VVVzZiY3VKU3Z2Nzl4QUYxYmFUR2F1WnR1Z01zNEY4UUhOQWRs?=
 =?utf-8?B?RTJRYlRKV3NUK3FFSHNXRUdSNGh2YnNhR291djM0T3pzZ2djQy9KdHg4RHJl?=
 =?utf-8?B?QStKWkx3ZVNubFEwYmNxU3dVdTVoNitSbFFCOW1lRVhaZUsxNXF1VlI5cjdM?=
 =?utf-8?B?ZjBJdHpSZmNUbHUxNXdnMy9sRFZiZXpjZWNHenhVckJSVlVTUTUrRHk4VkRo?=
 =?utf-8?B?Q3E3UU1GZ3dBYUw4OTk3L3NtdHNNcjlRRStGQndrVzR6ZHFWOUYyYmJnWXVj?=
 =?utf-8?B?N1I1a3VFeEtHNmg0RGFLL3pvMjFJMVpxUSsySEx3TXh4K3hITVZtdnFyYnpp?=
 =?utf-8?B?VUVnZGI5RWtKcjRsRTd5aUQxd1JBdnFqMHU1MHBrdjdKVmdycVA0Mjk5UGpL?=
 =?utf-8?B?ZkxkVjQ1R2xKa0wwMnZ0L2RScTBSNElJNXkzZUU2OHh0RVpTZzh2cDZvd1lV?=
 =?utf-8?B?TFZqT3dFV3UrbllhQzFRL0hYcVVQeDJrNCs4YVFSSzJzVDV2TnRDMkNRM1VT?=
 =?utf-8?B?SlNYSXo4YW44aXkrMXNkajBlZUFKNGNESnpIM2JuSENVVVNTc0JYbmIzeENP?=
 =?utf-8?B?RDhvUW4zRUNoZ0tpSHVTaEFJU3hrUXdwc0tLdkMzQ3gxTHEvWkdmUFB0M2dx?=
 =?utf-8?B?VVZqd0ZudHZ2WkVEQWtmRDJydit1TGxHa0cxWVpyL0NiTXFSOGlBUWdmTExt?=
 =?utf-8?B?ZGNaYXV2N3QvK2dWblFHL0ZoOTV1cjFnODlJbVlkckFTLyt1UTdlaC9ZSmkv?=
 =?utf-8?B?UzBoNUVHK3VHSmNqWmE4d3d1WFNCdStncUNZRTA4REZoa2VTQ29pb3pLaUNC?=
 =?utf-8?B?VkZ0K0FpMFNMUXVnZkhlQ21MOHJXUnRRd3Job1M3U3Z2ZnNKcjl1SU9jUzM5?=
 =?utf-8?B?KzMzWDZhVTREdmFTbi9odDYyY1VlYlFhWUNneTRudkVDejU5alU3T3BwTFR5?=
 =?utf-8?B?VlZLNVRTdXVaSXAydEROaFllM0R4TlFiY1pnRVVYUHdYaWlKTUpoMUpPeVVo?=
 =?utf-8?B?WXVtNk1CZ25oZWYyR2V4RElBRUNTSnl5RnNkdVNiTUNzSktQcUVWK1V2N29V?=
 =?utf-8?Q?G8lQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba65192-1f84-4149-be5b-08ddbfcd58eb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:18:03.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cYoXiTwQTbFfsL0VoxaT5JZEGbXmd3W3ALSUqkzLaCXPV5S7f0cn5mFPR+94pWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
Received-SPF: permerror client-ip=40.107.220.63;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/9/25 21:57, Xiaoyao Li wrote:
> On 7/9/2025 11:02 PM, Moger, Babu wrote:
>> Hi Boris,
>>
>> On 7/9/25 05:49, Borislav Petkov (AMD) wrote:
>>> Hi,
>>>
>>> I *think* this is how it should be done but I might be forgetting
>>> something.
>>> It seems to work in my testing here.
>>>
>>> Babu, double-check me pls.
>>>
>>> Thx.
>>
>>
>> Patch looks good. Few comments.
>>
>> Is KVM aware of these bits? I didn’t notice any patches adding support for
>> them in the kernel.
> 
> Hi Boris,
> 
> Besides KVM patch, would you please provide the public doc that describes
> the new bits?

Here is the KVM patch.

commit d8010d4ba43e9f790925375a7de100604a5e2dba
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Sep 11 10:53:08 2024 +0200

x86/bugs: Add a Transient Scheduler Attacks mitigation

Here is the public doc.

https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf

> 
>> I recommend splitting this into two separate patches:
>> a. One patch to introduce the new bit 0021_EAX_VERW_CLEAR.
> 
> It also needs to be a separate patch to add it to "EPYC-Genoa" as v3, so
> please make it 3 patches.

I prefer not to add it to into CPU model yet. Adding that requires testing
of quite a few combinations (SEV. SEV-SNP , migrations etc).


> 
>> b. Another patch to add the new feature leaf FEAT_8000_0021_ECX.
>> Also, don’t forget to define tsa-sq-no and tsa-l1-no in target/i386/cpu.h.
>>
>>
>>>
>>> ---
>>>
>>> Add CPUID leaf 0x8000_0021.ECX support and add the TSA CPUID flags.
>>>
>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>> ---
>>>   target/i386/cpu.c | 20 +++++++++++++++++++-
>>>   target/i386/cpu.h |  3 +++
>>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 0d35e95430fe..b889de61ed9d 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1274,7 +1274,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>>           .type = CPUID_FEATURE_WORD,
>>>           .feat_names = {
>>>               "no-nested-data-bp", "fs-gs-base-ns",
>>> "lfence-always-serializing", NULL,
>>> -            NULL, NULL, "null-sel-clr-base", NULL,
>>> +            NULL, "verw-clear", "null-sel-clr-base", NULL,
>>>               "auto-ibrs", NULL, NULL, NULL,
>>>               NULL, NULL, NULL, NULL,
>>>               NULL, NULL, NULL, NULL,
>>> @@ -1308,6 +1308,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS]
>>> = {
>>>           .tcg_features = 0,
>>>           .unmigratable_flags = 0,
>>>       },
>>> +    [FEAT_8000_0021_ECX] = {
>>> +        .type = CPUID_FEATURE_WORD,
>>> +        .feat_names = {
>>> +            NULL, "tsa-sq-no", "tsa-l1-no", NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +        },
>>> +        .cpuid = { .eax = 0x80000021, .reg = R_ECX, },
>>> +        .tcg_features = 0,
>>> +        .unmigratable_flags = 0,
>>> +    },
>>>       [FEAT_XSAVE] = {
>>>           .type = CPUID_FEATURE_WORD,
>>>           .feat_names = {
>>> @@ -5835,6 +5851,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>>           .features[FEAT_8000_0021_EAX] =
>>>               CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
>>>               CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
>>> +            CPUID_8000_0021_EAX_VERW_CLEAR |
>>>               CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
>>>               CPUID_8000_0021_EAX_AUTO_IBRS,
>>>           .features[FEAT_7_0_EBX] =
>>> @@ -7934,6 +7951,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
>>> index, uint32_t count,
>>>           *eax = *ebx = *ecx = *edx = 0;
>>>           *eax = env->features[FEAT_8000_0021_EAX];
>>>           *ebx = env->features[FEAT_8000_0021_EBX];
>>> +        *ecx = env->features[FEAT_8000_0021_ECX];
>>>           break;
>>>       default:
>>>           /* reserved values: zero */
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index 51e10139dfdf..8b2703f41b73 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -641,6 +641,7 @@ typedef enum FeatureWord {
>>>       FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>>>       FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
>>>       FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
>>> +    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
>>>       FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
>>>       FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>>>       FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
>>> @@ -1101,6 +1102,8 @@ uint64_t
>>> x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>>>   #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
>>>   /* LFENCE is always serializing */
>>>   #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
>>> +/* Memory form of VERW mitigates TSA */
>>> +#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
>>>   /* Null Selector Clears Base */
>>>   #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>>>   /* Automatic IBRS */
>>
>> We need to define tsa-sq-no and tsa-l1-no here.
>> These definitions can be used later when adding a new CPU model.
> 
> Add them later along with the patch introduces the new CPU model is also OK.
> 
> 
> 

-- 
Thanks
Babu Moger

