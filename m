Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259E3CF9C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 12:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sshph-0006W6-6t; Mon, 23 Sep 2024 08:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshpY-0006RF-GZ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:06:17 -0400
Received: from mail-bn8nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshpU-0001XC-Gj
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH/B3wCvFHIQtPaaUcN6TnEfP16PPlcj4yQBxg8W81b1C9lssvZtOSLO0FZjmLVfJb6io4454f5OGknjJQ/eL8dIrucxCkrAuJd8XeBZX9yH7rBjy/isHVMAJMBiQLDDOVZgvviujbZAkNdLNMabJ8dF7uS8/o28rY/QI/lnuZvK3+uhbV7VFcA2tR32D+n/q5J7V8+1HSBE+zpri1OWoP4R/bJCIruIMndYgJcb1ZeMbhcZsyRtUOw0aXvi2Xr79Xq0ItgvL8n0WXCVbG9XLrnwliQs7CWFP0ksf3Bymu0dhhvozB4Oyx1ubKXy57EiK0wrgLPbN9Mb+VpThEMddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAxUNUD4GHthQRA5hLaKShVIx+G4gUtOUcAqDFe0+Wg=;
 b=aQIy2Uw9lO0DAPo0Tgusmkp0wOBbiK3u7ixAnVncLav+7mXap+ePEpLMZFZt2pXE0iQkNwHpQzcM1Aoo91GCHWhVhZRsu2P8CxSwKdaH6uIiN+i5xY4yoSP4/70b873rvqPNCgKfuET26dyxSq1Lerb41vlkjxzrPMgi+VDEIWo3/4ZuAcDpiGPNJRsLDI9u7m8ueJyU8+9JvoN3WJn7Gtm1uzsdjx38bCXlWmL9csyRNkBWOHTT2w3HnuaD77j8YrtK74+1LHpMuxDLA7FJiSpVUwSptIjM/GKHzFwastBVFJ9lrwzJf0N+h1CyhelTr4NSYC1TzjhDObL8yYIRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAxUNUD4GHthQRA5hLaKShVIx+G4gUtOUcAqDFe0+Wg=;
 b=aOvg4Qyy/U1Cmll58Dkv4cCNp7qMmAHCKYbRYQZwRCu4d9bOdTcjS/Jp8atiAHKTRE6P18kwPu3Rw5LT71Fh1LrGCF+/KBgzaB+MZ5woR9QWO/RpfBrnEmy7MnFTfpeROrYF+eIkUJxOYiGnQRWIjfScR23nFwHGlDO985Ch2qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:05:33 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 12:05:33 +0000
Message-ID: <67fb4e59-c71d-aa08-2b46-e2192eb537c9@amd.com>
Date: Mon, 23 Sep 2024 17:35:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/5] Interrupt Remap support for emulated amd viommu
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <a0e0b074-bb1a-4b79-a393-082de9227cab@oracle.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <a0e0b074-bb1a-4b79-a393-082de9227cab@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df5af9b-e45b-486c-6707-08dcdbc80699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjFHMGdLTEdUdyswQW92Nnk2eEE4NkJGWmlEVkFYNWREdnZoVUx2WUg4S0VX?=
 =?utf-8?B?eVJrTjFZQ3Z5Q05mUzVKN21tUUZ6TlQrbkpISlI3R1ozSVJaUmRwa1FjMU8z?=
 =?utf-8?B?aE9MUFJRSC9VQjVKd0tlK2hhWFU5TmxqU29zUjhySHhEc1kxRWo0akl4UEVB?=
 =?utf-8?B?aFZaajNKR3pvK2YrNU5ZNlZ0S1NxYzJEQ3pZRlB2NlJqTmgrajJ3bGFYSlJm?=
 =?utf-8?B?OVdVZU82a25nd1F3eTFjai9oZVczTW50T3BQY1pkTGdqQnpIK2oyTmFacW9z?=
 =?utf-8?B?K0t0TTNhamFrK0MzaEY5eFh4WnRDZTYyWTJGcnFLT21ZOGZ1RnVEZk94MzVQ?=
 =?utf-8?B?aHRiNld6cGI0ZWxCZUpVT3hkRjd0SmFQdnFnR3pwUTJFV1JSQUZGa3lleE03?=
 =?utf-8?B?TFBSQ0p5UFRjWnlsYVE3cytnZUxOS2NGOTNyVFphZHYxWDlWU09VZGRtK05W?=
 =?utf-8?B?STczbFo2dXM0QUJ2YXN1eXp4eWhxbHJrcUI3RzNzZnp6MDVLNmhHTmk0NExp?=
 =?utf-8?B?SVRENjJIbm9RMytTcnNuek1LT0NncGdJYXFqMTVCK204RGxyZ0IxeTZxR3Vt?=
 =?utf-8?B?S1M2TlBpVm96K0xhdWVGUVEyUHpVd0hra0xoZCthQXMvTmFTWnNIT1JuRitV?=
 =?utf-8?B?T29xZ0xWOGh3UFhXaFgxYXNrQXI4WGVYOTFwbzhFc2lieHJFMVM4K2RtMUZ3?=
 =?utf-8?B?bkJpT3oxKzB3OStrcE53eExZalhPQzA3cEZkNm1qTXo2cktlYXVuNENrU2c4?=
 =?utf-8?B?dGdranZOeVBRdEtwM1NBSkpHdEF0a0k0aDkxc2JaZ1l1VW9ZRElTK3hGcnJL?=
 =?utf-8?B?Z1ZkSUI5NCtXQ1kva08rbXlGK3JWVjNwanZVVTI0VmIyV2RWMy9uWlZGYWlQ?=
 =?utf-8?B?bXdhYS9rVjRGQU5yUjRFcC9uMlZQYVc2STJqdjJ6YkVvc3FJbXE1THpDdm1B?=
 =?utf-8?B?Q3g5TzhwdmVuWU0zZThEQjc0emhDd1dMaThNaHB2QTQ5c096NjNPOXRnTW9X?=
 =?utf-8?B?bzFiK29pdE9BWjdGNkMxTlJaR1NETnNDQkVKQk9vZm4wbU9EZVBpay9KUHk2?=
 =?utf-8?B?VVNTRHJyV204aXlaN1hxNkhtVEt1RGFvMnpJTW8yN2xsWHMwVmJxNkorOVox?=
 =?utf-8?B?cDdKRXZpcnk3V0dnWXV3amtTS1ZnSDV5U3hkdVkyNmNDRGhrd2JUNDJwU3ZG?=
 =?utf-8?B?V2tWVEtCTUEvNHJsYmpBWG9oVktsejRIWENRTzQ4U2cxSndLcEE2bTNZcWpu?=
 =?utf-8?B?c3BycGZ0Mk5jYSs1dXJPNkVmRTlZdTJJVXZLbEMvNGNyOTl2L2srVzZiNldW?=
 =?utf-8?B?b0FSRTVqaklhQVRrazBuYkdlMFlqa1E4VXk3c0hFVVhxR2NBUzlMSTJtUW5P?=
 =?utf-8?B?dnRvY2FqYTkxUmU0Tm5zL0J0dXJOTnplTVAxbzRqT2pXK0hIS1ZyTmdqY25k?=
 =?utf-8?B?eVhUSU95NUU2NGl4YnFQL1RMTklNMDEvS0pnTUd6Q3ZPOVZHTWsyK3JHQk9B?=
 =?utf-8?B?SjBMU3ZHVzdoK3IxUVNRekR5OE9aSVBjVHB2NDZGdVkydCtKMzlDVEQ2R3hu?=
 =?utf-8?B?OUFZa3JqTEtkYUcxM21ja1hWZC8vVlI5SjdvdGE5RGU4SHh2VVVEb1B6U3dp?=
 =?utf-8?B?dFlMWlZpMHhQcVUzTkVaalVmSWR6VEVieDlua3ZpREdnQkhpZ1J5MGJNeG9s?=
 =?utf-8?B?SkVNaUVXc1RYSW1uTHAwNEJWc29mWkUwZHFQVFpwdzFEMWFQR1lUSDNTYnhL?=
 =?utf-8?Q?9wJbc2CuLfcvPN/BpnKO6r9otVyoqPDexbJDTki?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB3cmdVN1liQU43Z0ZLdkFRUEVFWGtyMUhuRDJnQzI0YWpRVW5vdzg3STNt?=
 =?utf-8?B?OGgrR3BWWWlEczVUMnJRYTIySUxVSFVJNi9lWTkwNmxYUEN4NWpXc3VCZmRQ?=
 =?utf-8?B?aVl1TTFxdENDY0JXUDN3dElhNnVrWEhBTG9zbStrMGlidHZpS3pNenJpT25F?=
 =?utf-8?B?ZVZOb240eHhQM2tUdVAwNVJwWkJSN3NaVlVVQnVsa3ArWTI4ajAwVXJNRlpP?=
 =?utf-8?B?QmdKbG0wRlVoYjA4NC9lZEthdlZscXJwSkpobE5xOEZwcVRPYlMycE1CUE8y?=
 =?utf-8?B?QUVWMkliRFU5V0R6LzhBL1ROOGtzL2JjNzRZWWJXTjZCMWZMb05vcldHL2I4?=
 =?utf-8?B?WWVZNEwvcWVraDFNc1pYVEQ3eEpGRUU1cURXTUZWeHVOWWVkTzE3UFR6SndZ?=
 =?utf-8?B?enFIaDJmb3VtMWZpR3ZibXNOSVEwOW9URGFnRGVvbkdCbkxyRTg0M2VuMWwz?=
 =?utf-8?B?VmNjdmxjZUlBN05PVkpSa09IWWtQSEpRa05OWm1kRnFnRnJ6eUwyTmdnVlht?=
 =?utf-8?B?N2RmODJ3QmZoLzBja1d5TTFUTXBBWlpqdi9kbndZNHk1cGxqM3p4ZWo3eU5D?=
 =?utf-8?B?dk9rOXhnTWl4L2NYYzlZREM4WG8zcVpyaWxOeEhSbEdGdGZrMUFRWkFRaXhz?=
 =?utf-8?B?Y05ubGhOOGZENEZWUy9LSjVhaDJpSGNTMXdKTitRQVVvY0RyMVkvTjNuUWZM?=
 =?utf-8?B?WjVuWW5IRXZtNXR6cGZYUm1makhSWGsvdkRxWDl5SmViSCs1dHExRVowQWpN?=
 =?utf-8?B?MHBJNm5aS1lyNVp5eWxySHlGL3NJUVJuVTZsSVRLaWtFMEpuZ3lyN242SWRF?=
 =?utf-8?B?d0NNWUNNdFA1SDAxb0J6c1pFL3ZoYW5jaXBYRENFZ0JIcWRnQkdpd29uN3N1?=
 =?utf-8?B?M2lmSFE4bmJVaDN1VkxsaVUzRFo3TEtXR044R1Nvb0t0NDUvbFVPUDV5MXFN?=
 =?utf-8?B?WFJkaE5pbFRlMHluWHBSWXpLenJOdXhFVHZVblhWcW9MRGJvSzl2V0RmaDA2?=
 =?utf-8?B?R1V2dkxQRFY2ODJtL1hpUElSMFRNVXVoc2p4NlJsOFVSbmZXbDArRGpEcG5Q?=
 =?utf-8?B?ZDlLYVgvWEhmYnZrdW9XTTN3OTMySzFsNzQ5OW9KNW4zbDZwUnZQTjZkczV4?=
 =?utf-8?B?MDhkZXJUWDk3Mk42Q3J5ZllEZ3pEVkFPSUxnY3NVQS9WakJnWWJaTFhoenFR?=
 =?utf-8?B?MW1VZ3h6TE1zdzJ3UTJ1dEpTa2dMWGtWbklDWTBuTFBPT0pZdm5obGFqYktR?=
 =?utf-8?B?dy83NGdCWUhyQVluZnl4NENlUGt5d3BWMkt4NXdGUTB2UDh1REFNQWhXeStn?=
 =?utf-8?B?bXNJemVSdlBrUlBLR2FINVd5R295NW5rUWtVclZoaUs2cUtGT0JWMXQrNzBw?=
 =?utf-8?B?ZFAwWWxHYTdZTlp5MStkWGo0d2NKWG1BaHgvUlk5ZE1sTFlVQmZhYjUzQzlP?=
 =?utf-8?B?L1ZVS0pZSENnTjdhTXdHQU1SK2FzQ2k4b1F2Zm1RRUJ1Qld2YURnVnFUWUdw?=
 =?utf-8?B?S0JtOUlURFlDVjlyMFlLVGRnQVdzM0VyRldaU204RGVOMlJ2ejNxS0VldmdQ?=
 =?utf-8?B?UWFJNGtHQnJiay9BT2VYREVBL3V0SnZrVTNKcVpQWnZIMElTN0s4bnpBRGNR?=
 =?utf-8?B?RWx6N2ZsU05kU1dDVEpBM1hUVittaVIwTUJnanpjU2VmV0xwUllqRmxYYm9E?=
 =?utf-8?B?V01Yd0grOFdNZFFQejFaR0JNUjdNenlYMGJYa2hjUGhpak0veUN5ZTlLZ1Ez?=
 =?utf-8?B?WUNDUnYydUpmckpFZjRRRW9vZklrNVdxakN1SUZQeEEwVlJLcmt5dGtRR0VD?=
 =?utf-8?B?ZndsYnJMMnRTa1A3ejVFTzdMa2lIdEgxRkZCeUJMM1FrSGJmMWNoYktZK3l6?=
 =?utf-8?B?QXV0bFRadk5OTzlMWU5FaE1XcDFwSS9WTjZ6c3BYejZPcWFDRk00RWlCMFU5?=
 =?utf-8?B?dGYwdUNVaXhzUDUzSmh6MjR6bU1SZmxjUHh6NCsvOTFUY2laejE2eDFyNGVl?=
 =?utf-8?B?Wml3ekhYT0tSSDdMVzVsZ1hVOGdpSTdhbHloaWxrS1pmazc2eTNPc0Q2Q0pG?=
 =?utf-8?B?a2tsTE5vNVVWbEYwK09zY29raDNBMlJuZlZqUmtraUp4NnRNcHF3dUZzelNj?=
 =?utf-8?Q?QwVFsE7/G0JHQO/tVCwoD5XBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df5af9b-e45b-486c-6707-08dcdbc80699
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:05:33.3445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX/IuNYQL5v6a9N3Npl6USg7KRCi4FxP+Zpj2Ji2381UPwBnRTwjNHsdqhft73RWQ4nFClUSHlFYiH7YPpZgqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
Received-SPF: permerror client-ip=2a01:111:f403:2418::61d;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.417, SPF_HELO_PASS=-0.001,
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

Hi Alejandro,

On 9/21/2024 2:09 AM, Alejandro Jimenez wrote:
> Hi Santosh,
> 
> 
> On 9/16/24 10:31, Santosh Shukla wrote:
>> Series adds following feature support for emulated amd vIOMMU
>> 1) Pass Through(PT) mode
>> 2) Interrupt Remapping(IR) mode
>>
>> 1) PT mode
>> Introducing the shared 'nodma' memory region that can be aliased
>> by all the devices in the PT mode. Shared memory with aliasing
>> approach will help run VM faster when lot of devices attached to
>> VM.
>>
>> 2) IR mode
>> Shared IR memory region with aliasing approach proposed for the
>> reason mentioned in 1). Also add support to invalidate Interrupt
>> remaping table(IRT).
>>
>> Series based on ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a
>>
>> Testing:
>> 1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
>> enabled
>> 2. Windows Server 2022 VM testing for > 255 vCPU.
> 
> Tested on EPYC Genoa launching a guest with 380 vCPUs, with VFIO passthrough NIC, using "-device amd-iommu,intremap=on,xtsup=on,pt=on"
> 
> I pointed out a few minor nits, of which I think the most important is to correct the error message on PATCH 5/5. With that addressed:
> 
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> Thank you.

Thank you for reviewing and comments.

Regards,
Santosh

> 
>>
>> Change History:
>>
>> V2:
>> - Fixed non-kvm build issue (Reported by Michael Tsirkin)
>>
>> V1:
>> - https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/
>>
>>
>> Suravee Suthikulpanit (5):
>>    amd_iommu: Rename variable mmio to mr_mmio
>>    amd_iommu: Add support for pass though mode
>>    amd_iommu: Use shared memory region for Interrupt Remapping
>>    amd_iommu: Send notification when invaldate interrupt entry cache
>>    amd_iommu: Check APIC ID > 255 for XTSup
>>
>>   hw/i386/acpi-build.c |  4 +-
>>   hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
>>   hw/i386/amd_iommu.h  |  5 ++-
>>   3 files changed, 85 insertions(+), 22 deletions(-)
>>

