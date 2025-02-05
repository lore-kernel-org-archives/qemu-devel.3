Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC00C02193
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 02:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfV3z-0007HR-Ic; Tue, 04 Feb 2025 21:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfV3x-0007H4-VB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 21:22:49 -0500
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com
 ([40.107.92.62] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfV3v-0001xu-9v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 21:22:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+k8aXv2ciuV3qh1T/G0kuWDA806SlLPdX3zZM/L25mAEaEzm1XL/Z3DgO/BLd2BBp4uU9Phoq60Y1Yv9QKeVHf22SsvkGWlKb7Noi+kuqLeUU2M91pv/1rzuJIVUFcm4Gr6GVI73KcebKSpWoBdyn6HeBZPT0iTdrfX7BYAwwYbYZD4O+c4x1EqzP2//+YJzyXlyJzjVC6hvGJ8xhekYLBmrZ5NbAu47crjByNoSMaJtt5FoOaO4naYckSN7krckm+DgDgz5sz83czUMiukX89AFK7FIpe6aRAmAwqizkWHRMUYzpqj7ZuCCx8qoF93opmPUbNOR2maV4uAZuwZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed55bryHlIwfQCFz+31rU+G0Brzk8d4BbzczS++fMCs=;
 b=FMCNktbf3Sjn98JpGHfa1WIo+91GI6OF9A7yKT1DrgveIkyzULwv0FaiTsZkUrPxpGuba4jSR0+QLbMPk3VKpNBjTVV0OyBxeNGqukUnSnbdLZHoWmgIwMzCnnZbiY1ra1DILGQ/jh0UsC6JMTl0kHeVnYDhUF+bqcJ7v0AQFmoZvUBsw+BPChbMZTte+JtF3Uw9AybQZ0SAikfB7e7zjscfve7mN3e8sgTRxiop16VFsX2vn6Q7ARFR9FMmrO2molOcsSfyN3V9grEVTIkBrogdaK3uEPEnwrX4MPAlNeIcNIbb9yQ5b9lYqBLlAXJxsW2BdbknFonkDgnM9lyjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed55bryHlIwfQCFz+31rU+G0Brzk8d4BbzczS++fMCs=;
 b=BcCyQDq+QrT18zmoJCeJtyofZnk2xJDJDN8zmP4fwjmJ+JRglNBX7+oiwuXLP3EsCI4xsv0Mh/koFKe45P8atuZ6do2e7ahyGswv6JPmUdAXKM/v06qXu22Xq+wTTIi5Rt2h7KlFVosLFwviDEDLA2FBnoinHhqM4jnuXGyORok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 02:17:35 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8377.009; Wed, 5 Feb 2025
 02:17:35 +0000
Message-ID: <9ecffa7a-f4c6-45a5-a066-84826ccb55dd@amd.com>
Date: Wed, 5 Feb 2025 09:17:26 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, Ruihui.Dian@amd.com,
 bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
 <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 14275398-6b07-4f3e-b557-08dd458b4126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzJrZmU1bGJpeWR5VWRyODJra2hlL01tRHgyeEhzdXpmTGNmQUNocFB2VVNs?=
 =?utf-8?B?Ymw3VmFIck9PKzlSZVFTNUlHUklDeGc4K01vaVRzZ0tiNlNmU3F4V1phcVJE?=
 =?utf-8?B?WkRENEwyY0JSSGxMbzR6UjgzNVp6OStvZVJLTTNkbnRHT28wdmxSektCNWt4?=
 =?utf-8?B?cWFFNDVSNGNYMm8vSldhN1VjU2xhSUpXNm40d0M2WTF1ekpYTmhKd3BrZVpt?=
 =?utf-8?B?MG1YTmJIcHR4b3YybXVTcUJ1RXFRYXM5WFJOUVEzTXc3bURvU1RSQkZCRGcw?=
 =?utf-8?B?c0FGNmw3RUtUejEwTTkxdE5zSmRjdkFvN0tlU0xjb1EyelFQYmhvS2E0QktU?=
 =?utf-8?B?S2NyZUs3VEtOZzNGbFRHT0I4NzFwaGd4cGtqWFBmalBPT24zOXV3aXhWSkk4?=
 =?utf-8?B?T083VUhkVWZ1dmVLZnJmbW9ic21iZVBtdDA4MXloTjlLRFoyWVZDWjUvZW42?=
 =?utf-8?B?VXJSK0FpVmZjQjVQVDVKT2FhbThML0pKZVE3UWtxVW5hT1g2RUFrQVpWVlk0?=
 =?utf-8?B?K1d4Y0p1dDlRRTlsZlVkbURNRFlFV1BaRm5tTmtGNUIvUWU5eXFmMUlWQy9Z?=
 =?utf-8?B?QlJVMFRlRVJVeVFqSDNyazNvQkhZV2kxTG90bnd0MmFFdFVoaVVvY3JJTmll?=
 =?utf-8?B?TWkya0RadWc5S3RzRTVCQy8xOEx4Q25SdmhzcUduRWxzSUpWbWh5U3hsZnBH?=
 =?utf-8?B?cy91VUZDZFZHOXFYajR6NmJOWEIzaytKMkxUem5oYVN6SEJrR0YweW1hU1Z5?=
 =?utf-8?B?ZVpCeTIzdVl5d0tLemdrZU1ZU1dJcERFM081QSsvRWFpRmlRVkxWZnJVOGxB?=
 =?utf-8?B?RXUzOW1tRy9KNG5PS0doL2JpRHpZOS9LKzEwMzhLQ0FCMSs1YmtpWHVEaFdm?=
 =?utf-8?B?YUZZT3ZuYmFJYnFlVnFXMHlEUjVETmtXVVZybW1PdGprQVp5V21wL1RoaEhH?=
 =?utf-8?B?bWlTalpJeXdRY1dVUlpYb0VYVVQ1bGtLRGhMTE0vOEZVeEZxSTFhM0s5TktH?=
 =?utf-8?B?MGtNMGpkSi9zQkR5TEowWXk5Mkgxa09OU2VJSHB0U0JwTUVqNzlvelVtT1lw?=
 =?utf-8?B?RmNMQ0dNcTIxc1dwSWo3WVNGKytlaG1GQWxzdUVTTE9RSGxVb3pVYVh4SzFY?=
 =?utf-8?B?ZHJoaXNSY1JWbE02Z2NVZjhwZGZqS1pKQjdWWCtiQlBISWVhZWRVbUFOcXVZ?=
 =?utf-8?B?ZGFTL3l0K3JIUGlNQzZFQjR5bmtJYWtGMDlhVEdtUEt6WmduR0hkd0RpMkh6?=
 =?utf-8?B?dkowQjRCbDBCQUEyeEVrNGRGdnd1dGJweGozZEwvZEE2M0V3K05wYjYrR1B5?=
 =?utf-8?B?UXNvSHhxeGZqQUEwT0FOa1lLdmt2NktvVE90WE4yZlRvSVlmNUxCZFFjamtK?=
 =?utf-8?B?NjdVVWNETlhUWkN4elN4TG9Sd0J2OWxoaHpISUhZVVVxUmdIa3pXaGdTN2Z4?=
 =?utf-8?B?eldGS2ZUV1dJVFJEdmY0MnN3MWtNYVBoZHJKZm14MnMwNkF1UUc3aVRRVFVT?=
 =?utf-8?B?L3Q3VEZVbFc1OERYZmNUbUYvYkFJS3lvSGJhcXVhMW81cFZFTE43WWRseXll?=
 =?utf-8?B?dnd6M2hKeHl1MjR6anFGVVhQRXBtZERXKzhDQkQ0anVsTFNaNTZVUG95ajhV?=
 =?utf-8?B?UlJHbm1XOGVYMEpoSk9wN2haQVM3WjdnZG5ETkNxVEpRQkI4YUdqSVo2T25v?=
 =?utf-8?B?OFlQeWhMZmdsRnYwSElRUEpCdjdaSG9hdVI4TGI4a0YyMDZoMVlpZlNrOGpU?=
 =?utf-8?B?enFyM2Z2dy9IeWMrVGsrcGdTY0VnZkM0SFVabGVTN0Y5QnBBZC93UnhIVTlQ?=
 =?utf-8?B?R2diOTVQbFBzTVRzVFBmSUtxZmJTcVM3Rko2ZUljemM3OTcralF0bVlpemxa?=
 =?utf-8?Q?xECBK7i/Db5M/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NExMVllORGRHK2FBNndPdFdkRHhFZ2ZFckdLZkt2bHFhdFhkU24vUXRHd01M?=
 =?utf-8?B?SGo5aXlVUHd4V1RNQVVNL2VLR3Btc1BOT2sxTzd5OEpEUy92NU1XVFFJWWVZ?=
 =?utf-8?B?a25UWi9XNG1SSWdRVEZNSGROUlY5V05mSHprUFI1eUpOTFhTK3dWeTVRSnBP?=
 =?utf-8?B?RExRcUtoSUhjNjJiUFB1ZlZDb2FSdEx6SmtpNDA4aVl6c1VhT1AvYVMySlFL?=
 =?utf-8?B?SDNadXpJeC9KSlRORkpjSU9pb3J6YWNneVhWVmlwaThrV2hNNVFxQjY2SXlG?=
 =?utf-8?B?WVhXdmZoUTdKblVRNXh0N0c0aXdFaWZuUjdCa0t2dGVUYitreXQyUHVndnBG?=
 =?utf-8?B?dVh2UEFKLzloOGJ4Tkw4TDl6YzBIZHNlT1UyOXNsLzR2NGdhSXgzUmZOV0dO?=
 =?utf-8?B?T0xMZ21HM0lmYVBPS0lzZ0YvcHlJTmdpb1hXbllyNURYTTcrYTROajFybkNW?=
 =?utf-8?B?ckdOcmhYY0NlKzJZNzBjTEFhVlNFR2hoaXp2WDRyWnVQNktSa0h5YkcrWFI0?=
 =?utf-8?B?cFFmZDlLZkZjRjM4ZkR1M0xFQmtVNTQ1TnRCZTk2ajg4T00ybURleVNuU3JP?=
 =?utf-8?B?N1R2VVdleTZCVjlBK2xmRFZnT2hwVWdPN0tsRVhlZUtMaUpXWjc2YzBXS3h0?=
 =?utf-8?B?UE5qcWkxSkxaU3NscmxVSWh3NXRSNlQxc1RqR0NVUk0zRVdUMGhXbE52ZENm?=
 =?utf-8?B?YmQ0L1greDZHQzdRSk5WVkNGOXdZamt5ekZZOENod3ZzcFA1ZmFrNGNINGxJ?=
 =?utf-8?B?d1JDMllqTnlJMXlMYzluU0hNVVVka0xvZFRzd2R6Mk1VK25OMkRPU2JXKzQ5?=
 =?utf-8?B?aDRSREJjMzd1UnhUR0Fid3lDS0k2V3FFbXF1N0VsUHJ3Sm9vR1NLODJXaHM3?=
 =?utf-8?B?eTVtOEZmZWp5RStxZ1VGNnhiTjZwRjZVaEgwWi9sYkxEOVhidUtXNnZYTFRK?=
 =?utf-8?B?VnZhWHRkMWJ3bThZWWNEMkxldlZReU1IdnVYcGVsWmN2d09paXFuTkN2em1t?=
 =?utf-8?B?N1dCZUlMQnBnVVRDSTdMQVpaMyt1eHFWUUUyZUVKRGZHVXU3MEFvQm43UVky?=
 =?utf-8?B?SVAvUGlDZGxnTU05NFAycHRqL2srQWg3OUtFODJ6czdUdGRnQWNvNHdkYnR5?=
 =?utf-8?B?NkY3U2FncTduanhPSlFuUjFEclFTU0lWc1dCWFdmcWNTKzRQM3Y2ZitXMTV4?=
 =?utf-8?B?cWNZdjRXVzVFd3ZyTW96a2RiN0pqYTJQMnlqN0xjSGZNL05URW9SdWlIUWpY?=
 =?utf-8?B?WnRCRHQwa3lacXlSQS9HbTJ5Y0N1UWR1U3NqVDJqVldnT1Z3cjI0dTVKcEFk?=
 =?utf-8?B?NFh4Z0s2RFhlR2RlL2JrWmR1Zmd4Z0MxQW5NTnpzK3JXTGROc2psR24wRHVt?=
 =?utf-8?B?N0xRdFpwcGdCMkJTQVZJMXlPM0NMd2REeUpRdlJlank1elpSd2VkNWQ4M0NB?=
 =?utf-8?B?cU5rRkxtdXVWYmtrQVlLdm1lOXRYUThHbDBzalJPbktBdzQ0RHVMenZtUE5v?=
 =?utf-8?B?RDZZVmY3dU02OFB4SFNRcVZPbGtod1phdmVSUXNhK3NYdU43KzFyMU5aN3ZJ?=
 =?utf-8?B?MDVkSzh1d2JZZnFlM1cyRnZlTy9DblpTOXJnQnVMcXQrSnBzeFFIbVh3aTh0?=
 =?utf-8?B?Z21hLyt4cUordVRTbWhRYVc0cWtTb0RDNGMzRW43RGxQYkpHd2RqQ3llWlRB?=
 =?utf-8?B?dHBLZGR0WXM5L0RraWpJUmdWbk1lYi9FNnhzck5NZ25CS3Y3b0lOY0ZHQ1VX?=
 =?utf-8?B?cGVPcXlGSWpCL21NNDFYM25CcXUxWU96d1hpQ01wWTdXSk9udjRTWGxRZmM3?=
 =?utf-8?B?Z2pCcElvcWVuUjYrOCthczlWeCs5andNdHEwbmZqRjJ3MGlsVUlhU3I3Z2F6?=
 =?utf-8?B?QTBYYjhpdGtaTFNIekF3UFFrS1k2VkVzODI3QU5iN1VjSFU1Q3ZGa2NlQUN5?=
 =?utf-8?B?a2ZBVTJRc25GTnRqMnlxRTZNZEM5NFlvMnJBTDRSMFhFMkN0ek91b2JSZysy?=
 =?utf-8?B?VXBMNFV4Q0s3S0RlZHJDc0gzMVJJZDdFZFR4djVweVVjaFBScERKNW1UaS9p?=
 =?utf-8?B?UHBFWVZNbHZqR0RFQWJNNHE2bTJ2VUFkUU8xUFZIWHZFdE92Zld3Q2lramsx?=
 =?utf-8?Q?LRmoNF7Jg7ktRL8+8Ksm53wbG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14275398-6b07-4f3e-b557-08dd458b4126
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:17:35.6308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x68GTioie3U4KBREpHDnuCm8GiP2VybqPFROlNd3zS8sqE47mYNGfA4+hjftrwtHkE9nwcqBMA2BBKBzu/i/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
Received-SPF: permerror client-ip=40.107.92.62;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



On 11/21/2024 6:42 PM, Joao Martins wrote:
> On 20/11/2024 07:31, Suravee Suthikulpanit wrote:
>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>> parameters for MMIO registers, device table, command buffer, and event
>> buffers.
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 13af7211e1..3d2bb9d81e 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>>   
>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>       .name = "amd-iommu",
>> -    .unmigratable = 1
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .priority = MIG_PRI_IOMMU,
>> +    .fields = (VMStateField[]) {
>> +      /* Updated in  amdvi_handle_control_write() */
>> +      VMSTATE_BOOL(enabled, AMDVIState),
> no xtsup ?  I guess you are relying on the dest command line having xtsup=on
> like intel-iommu
> 
>> +      VMSTATE_BOOL(ga_enabled, AMDVIState),
>> +      VMSTATE_BOOL(ats_enabled, AMDVIState),
>> +      VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
>> +      VMSTATE_BOOL(completion_wait_intr, AMDVIState),
>> +      VMSTATE_BOOL(evtlog_enabled, AMDVIState),
>> +      VMSTATE_BOOL(evtlog_intr, AMDVIState),
>> +      /* Updated in amdvi_handle_devtab_write() */
>> +      VMSTATE_UINT64(devtab, AMDVIState),
>> +      VMSTATE_UINT64(devtab_len, AMDVIState),
>> +      /* Updated in amdvi_handle_cmdbase_write() */
>> +      VMSTATE_UINT64(cmdbuf, AMDVIState),
>> +      VMSTATE_UINT64(cmdbuf_len, AMDVIState),
>> +      /* Updated in amdvi_handle_cmdhead_write() */
>> +      VMSTATE_UINT32(cmdbuf_head, AMDVIState),
>> +      /* Updated in amdvi_handle_cmdtail_write() */
>> +      VMSTATE_UINT32(cmdbuf_tail, AMDVIState),
>> +      /* Updated in amdvi_handle_evtbase_write() */
>> +      VMSTATE_UINT64(evtlog, AMDVIState),
>> +      VMSTATE_UINT32(evtlog_len, AMDVIState),
>> +      /* Updated in amdvi_handle_evthead_write() */
>> +      VMSTATE_UINT32(evtlog_head, AMDVIState),
>> +      /* Updated in amdvi_handle_evttail_write() */
>> +      VMSTATE_UINT32(evtlog_tail, AMDVIState),
> Are we missing:
> 
> 	ppr_log
> 	pprlog_len
> 	pprlog_head
> 	pprlog_tail
> 
>    ?
> 
> Although perhaps excluding it was deliberate given that these aren't actually
> fed with PPR log entries, only register initialization. Given no PPR entries are
> generated it's doing nothing useful.
> 
> Out of correctness this is guest initialized data, so perhaps it should be
> included such that it doesn't suddenly see different values on destination. In
> theory you 'just' need to wire in qemu a VF generating PPR log entries for page
> requests, so the log will eventually be what you need to migrate anyhow like the
> event log...?
> 

Thanks for bringing up this point. I'll send out v2 with ppr stuff.

Suravee.

