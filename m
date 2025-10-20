Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C3CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAl7c-0001IQ-1r; Mon, 20 Oct 2025 04:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vAl7W-0001Hi-H0
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:19:59 -0400
Received: from mail-westusazon11012057.outbound.protection.outlook.com
 ([52.101.43.57] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vAl7U-0006iO-Hm
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7o+C1Dy7yPiKF8oxYjiwOwa1jtmnqvoD/kmcbwz4h/LYEunoFK7VZ19zab5I+fEK4v+tZbhWHMPFbKrXylRm9thZreJUeDvTUZbMv4KUGOTlQldkXfB1y9oGIotbRZzpili5bJ08vGdHotFesba9O6Ak6Now6GcRyzCoTy3cimBFe4lEDkneIxNT9kkWoK1b3RscWEYcHznHw7JGxQYyW2ISS4bGJOFhVvOJjRDJVlaIpvBP5KYazlom6nHlaBYGibbRofmiUQtHgxBypp1coGB+sVqQjTtZHy1Vh4wnYS+70Qd6rii4tqLqtNo3ijRvpVO3InCrGORwA/sf4VHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb5WZmDfvpPd0Z1YW9iNkIocbaTq33tb8p5PSRrQdXg=;
 b=MmYltCOcLA7HEyfdqjprfSIepzBRr1tSdC0DIBaai8+lCcl8L7usswEeLBm3+TeteGnWFa7dp2/RNwICcGGrE22dMBYlooFAx/FStIAKLzWLkGUpKsOvv3fNd5LSd2Vx2Lkc51f/O/u6OtAq96A0iz4rdMs1exQMb8Suikd7muai1KwqRiLHkM6WH2IMVaPKRSroBf1eLxaLHdu/u+NlYkKeA509hqGLBOIKVAtS718TTU3vsv0ACmGwbCY32d2Bh5n44oRvqrIllBVHoh5Zbe49KRaU0eAy90IVj9nOdMuND+d3ZdJRBYwc9B3LS2QI5YUcdQAN9xKbkDtMa62pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb5WZmDfvpPd0Z1YW9iNkIocbaTq33tb8p5PSRrQdXg=;
 b=RqIcP6OQ2xWxUTtyXt5gWRZ+YXUZnBZpmPJ5XvlDa0HJ1FCvpq9I9kytxqucQVvLLD8RJzNrl/qsbjTFk6ulD6pyWSCagcxhdxX3bzvA4K5zbawNHS0tL7PM45Wof90s+MiCxgxO36BrqUUtHqfdoQjfr+z1mKyINjUjg8Debk6HAtnSDFqTcOmI9zfqn9Qe13lJnWEHyK2zj2v5nPNtVvwgO2FIhEiHiQqbE6SnQfJi2IWG3i/MKIzBuoE59BFi7vzMey6cKTHCkAP4d5syworJrjqkE2ExlN+3zCT638n/lWRSYAMadsu0+x1n3zDrI+XPs8kOoqT62hfZfVy2dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 08:14:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 08:14:48 +0000
Message-ID: <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
Date: Mon, 20 Oct 2025 11:14:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20251017082234.517827-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dc12c7-b64f-41ab-2104-08de0fb0bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGg1VHYwSEpFODQwLzZ2blJveHlKQ2t2OVNhTjErY1VwM1VxN2V6cm1GNVFv?=
 =?utf-8?B?ZHpHY3hmckxFdko2Z3N0UDgvbitKMEpoTy9pRXhReTFpL3NwM2hJZTlnaTFG?=
 =?utf-8?B?WXVNWUJ3aWpoUGF2aVlQM3IwdnNwSzBZZEt5dy8xMGQvU3RuWU4ySFQ1Z29Z?=
 =?utf-8?B?RXdlTzgyci9TWXpLQWdwTXdVWTNPeEV0bGg5U2pGbVk3dlE5YkZDa1JlSmhs?=
 =?utf-8?B?a3VRa1pYU1ZCZ3N4OWIvSG1wVVZ4RXQ5WTFITEUwQldscjd2bVphRE5HRXBa?=
 =?utf-8?B?U2Q5b0tycVRnVG9BMTVadVJHcjIvSWg2RzVIaWdUajNzc0xRY0JjUkYyb2lS?=
 =?utf-8?B?TlNPNVJEK0UySnNNTlBSR3NFR1Zkei8yRWpuNWswbkZYOE9vYy9RTVZPeG9u?=
 =?utf-8?B?MjJ5UklhZGlqdy9aMEFjd1lsR0p0T0FWWEo0Yi9WQ1ZzNlhncnY0dlFzOGFP?=
 =?utf-8?B?YWRoUzlqbzZTKzZRS29kS2c2a0lSYmx5UFZaVitMcFRoYzBsNWxsU1NuNGM2?=
 =?utf-8?B?T1QrR2pNK0pBaWI1enpaQ2ZrbkUyZzZoSmNrajI4a0JPM3cxOGlEVi9peWsv?=
 =?utf-8?B?RHJNUUhWUlN3WE5nZStMYjQ2eENnS1AzclBRQnlWNWRrWWZraDQzcnNlY2lH?=
 =?utf-8?B?bWtDbCs2eVUrd25wcG1pOFhnMzNPN3BncHpWNlpPd0FxU0hVQWE3MTNzU1Vr?=
 =?utf-8?B?QTBxdnlsTTNvNWtOR1RRM2cvbTM0RFd5Mmw3NVpEUFRHODNObXBMaGRLSDNE?=
 =?utf-8?B?OXcvLzNHQ0tQbWI4K1o1RGFub3ZJeVRoV05yS0tMRndiRlFhOTNQc1pBU2pC?=
 =?utf-8?B?ZFBGWERHbXp3a0NOQVZZUW5LT3hsSEtUSFhuZDh2SlhZQ1VvRm4wV1BSNEdL?=
 =?utf-8?B?a1Zvd2doSHVWdEhPUUk0NnkzUHNObXc3eG5OamZ5Rm5vUnZ1eGduczhoOW15?=
 =?utf-8?B?UlVaZ1ZaVnNtRHlTRTVnK3ViL2ZRRldrR2NsUnVjLzNVaGxrUkVoVUVqRmlB?=
 =?utf-8?B?Y1gwRG1qdGIzY0Jyd3ZMZlFNbENOSXRvVURQZVcyVGpkeVoyMUZUaW5iOVRM?=
 =?utf-8?B?bnA3NEk0blpyMEJLVzRNYkVwN014aG94amgyV0VSMmp4bDRXWGxwbjhLL0Zo?=
 =?utf-8?B?ZU43VTZkMmR2ODNMZW53QlJyQnNXMjU1YStmcGprR0RsTWtrQ3NseEtSL21J?=
 =?utf-8?B?STQrckY0ZE9CTm1FalNQZWwyZ2xZbVRtZ2h2YWxUUWVJeWlMMVBLbEM2bjBj?=
 =?utf-8?B?d2NrOUFtMVJpc1hhNHNKQzl6RXRnVDRMV1gxSy8vMm1tWktmMm5ScndvS3BZ?=
 =?utf-8?B?Z0l6K2EyRzZEWkxVeHo5ZUdMQ3hJcVBtVW0xYUtNQ3YvYm9hdzFXcm55Qi9K?=
 =?utf-8?B?dm9XZ1llNUFsTEFwY3lOeStOZ3BHelpZVituUFNWem9XeG12WUlPOU1VbEZr?=
 =?utf-8?B?WGZMTjdzbklwUEcrNnpMMUMwdXVEZ1liR0t1V1d6MzBFSERkQ21TMzFDNDhw?=
 =?utf-8?B?OXI1OUJxOGc1Zk8xcnVMclcxQTBINTJ3aUxLY1QxaDl6VTFUM3d2QjMvaTRh?=
 =?utf-8?B?a3BKVHN6SnVHV3JUNGtKVm5UdTNSSkFvWWcrRHlNRnoyUks3YndUaWt3MFdV?=
 =?utf-8?B?cmlxMWFGaWpjTkt1RktuckZUS0tRUTZaT01vNDFIQmwyeGlEb0dNQWRIMzZq?=
 =?utf-8?B?akJ2SFZva2FOZ1FjeUtaNUQ3b2sxcnBzQTlLRllJaElMU0RvY2ZhQWgwQXh3?=
 =?utf-8?B?akZZWkxaU2ZEN3d2T1p0RkxzcGh6OUxPUDhiQ09rTTZJYlcxMnhjTUVkUjFU?=
 =?utf-8?B?ak40WU8yTllFa2tqdFRPVzJSZFpaZVNRdWxWVkE1Y3VqcWtLWFZzZkNlNHM3?=
 =?utf-8?B?ZGFjVXBPNUNpbDM3ZlQ1WWNSM3g1bERuTC9oZWNvb053VHY3K3QwZW5HYWdt?=
 =?utf-8?Q?+iAIWq3wpGGxhjSBrHIiI1GdV8r8iboS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFVc1ZnSEtvcTNnSzhVYjNQbUEyYUdDaXBoN3dFSjNXYjZnNTRGcWVCUmJC?=
 =?utf-8?B?dGwrSTNJNUMxTWlQQ0dHZTYwa05ibFkrUVp3dW13L2tudVJTTWhKODZsQzFz?=
 =?utf-8?B?ZjhRa0R0YlpiTXFwc0xRQzRLdCs0eEtDdEZQVTNadnVCM2hZZ2R2dUc5Zm1B?=
 =?utf-8?B?bld0bU1SMHRrQzA3ck9xMXc4dmVmTHhlNTFxVlNFTkk4UUJvb1lYdk9OU0RR?=
 =?utf-8?B?cmYzcENrZFBQRGswZlNHTDQrZ3QrNU4wTGhrc1NyN0hTQnZlbG9NWTFJeWVM?=
 =?utf-8?B?RFVnVGFEY2xPYWYrMkpxb1A3MFhXaFRuanVMeHJPK0FWUEFXa0pPWmZkRTJZ?=
 =?utf-8?B?d1FjMkt6VDN0bGdrYVZWdkJaSGl1TFFCZ2w4Z29LZDdNTENreEsxRllKK3ZO?=
 =?utf-8?B?RGlmNVVnVTNyV2xNZFZiMzk0MkhYS3VrSWFIN2FRMTRUc1VaUE5WRnQ0U0VU?=
 =?utf-8?B?NWtnTldhUlMxNDhEeStubzZOb3ovSDZoSWgvbTVXanZjaTdyTTMyQTdiK0Vi?=
 =?utf-8?B?eXBzdVJKMmtsTlBSTDlkUDBZL2llME9td3NIL2YzKzM2RFVjVkFrUjc4bUpr?=
 =?utf-8?B?clh6dlpQZWs0VU5FZjBTUFpBdW4zYXZpQ1lWYlA0T2k0YlNpU0dBMzlpZW5K?=
 =?utf-8?B?Z0Yzc2gvRzRjeU5mOVlGMTVkdk1XVzJwTGZvVTdHZVQ3U1pHVE5PUU9sNVRE?=
 =?utf-8?B?SGI2d3R4NlNVTk9OdHNKWDYyRGFsUFFxeHdpNzBoNE5Wd254eEV5T2JUS3k1?=
 =?utf-8?B?R0QrRzdYaGFna2JCQ1dtOHVwRWlkWkRSZXdmc1VuT0xLNi9Sakk5SnJJYmNM?=
 =?utf-8?B?eEw4SkJtY0hVdm5LRnJrYUdPR1djRCtLeEZEdGphMDdkWk8wak94NGY5QlFs?=
 =?utf-8?B?VHZZam9kLzNDOHRIZmljMXd1TDJKc1RydEdKQTNpQnRucmtBdC9rdVcvUFZh?=
 =?utf-8?B?WVVnem9YVEdEU0NvWGNVQlZkeWFBRUVLUkUzZnluK3hkRFl4MWk5VEZJb0No?=
 =?utf-8?B?bHlyZkNRRGVaWEthTkhyOHRoZEZnY3YrZDFMa3A4ZDQ0SGtmcjJwK2NPWUJD?=
 =?utf-8?B?WVgzWk5DbVJTYkx4TzE3cFoxMDkrS1BXWmV4SlpPcVN6RjlOL1BSRlFwcDh2?=
 =?utf-8?B?VUY2aEZoRlBWNVZZR2g5Ykt5ZmpWN05ibmdpMTJSbWVYL0dRSURKZG8zdERI?=
 =?utf-8?B?RFpjVnZZTmpDYWt1SnM1aVJ1cmUrWm1RUWFzMFk5ZGk2RC9VVWZpK2ZKNzJa?=
 =?utf-8?B?TldMdnI5eFZkMVdNM0VpMDZ3Z252SlExNG9QTTdGcjBib1p1QzAxTVBhWDNT?=
 =?utf-8?B?V0R5RHI1L0VIeDlGQXFHK0F6cHpRSThRclhkRWpXUGt2TExzeGNKQnRWQ1Jl?=
 =?utf-8?B?eDNZd0NsYStTMmQxVi9TUzdpTitibG1qRUd4RUxuNnNraHQ3WWhiNi9ZeStI?=
 =?utf-8?B?b21OcjdKMFFFNVlMQjFaN2dRZm01WXBlWlNHaVVvMGVkaTJ3eEdmOFNFcEwy?=
 =?utf-8?B?VGpPMjNhbDd0QzNRTnlIbkJacko3aXZmcXNKa1I0Y09Kd0d1K1c1VWR3SE1v?=
 =?utf-8?B?VVdOZ1dOYnZEeTVUekJwTzJuemdDUlZadWdNRWdVSU1xc25uVUNWdGxsKzVN?=
 =?utf-8?B?eEhvT1d0WmpudDNjajV1dDRhQytGNjZQZnhUczdqMlhyVDZaZnhWVTZuNDBh?=
 =?utf-8?B?d0xxdG5ZY1NieTZ2VVIreGUzRVFLUkFRUWlFV1UxOW9xc1ArRlBrQ2w5aDlr?=
 =?utf-8?B?eVVaT1ZrU0g0VVkwQmF2K0d1UW4xSjV3MHQvVm1MT3BKNmVSQVpQZUtXOUpJ?=
 =?utf-8?B?SE9NbllSZmN2MENsTXdXY2RRMm9US1FocDE5djYrUU5qb3RLeHZRbTRLMnhP?=
 =?utf-8?B?cWZ6RWdRTitFdzZlUDJORFFEL2pTQWlHRWkxSGdNMGJFNUZDbzgybjdaQmR0?=
 =?utf-8?B?L3RhdUVMcGtxNTFPd0hkb2FndzJSQXE0WitaQjJzNUNEWjBOajIxaDMwYmxX?=
 =?utf-8?B?UDRMT0dPckZTZXdqaW82SHY1R3RWQkZPbzZrc1ExbzU0RWJUdmxNRU14aWY3?=
 =?utf-8?B?UGlYYzA3cXpyelVZc2RPRkV0ejBYSkhwT215VFpwK0hUVGc1cEhJK0R2NHY4?=
 =?utf-8?Q?Kf+qaSgD9YOA73+RUcKNondEC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dc12c7-b64f-41ab-2104-08de0fb0bc62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:14:48.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yKix8i+CrsHTMYt6kXOiAbvvl3JFdR/61RxZNHY132Vy2l06N4oiJttnC2TQDjX4Lg/b2h9MxH9yl1XcgKUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
Received-SPF: permerror client-ip=52.101.43.57;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.448, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

On 17/10/2025 11:22, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> When a existing mapping is unmapped, there could already be dirty bits
> which need to be recorded before unmap.
>
> If query dirty bitmap fails, we still need to do unmapping or else there
> is stale mapping and it's risky to guest.
>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/iommufd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 976c0a8814..404e6249ca 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            /* TODO: query dirty bitmap before DMA unmap */
> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                    iotlb->translated_addr,
> +                                                    &local_err);
> +            if (ret) {
> +                error_report_err(local_err);
> +            }
> +            /* Unmap stale mapping even if query dirty bitmap fails */
>               return iommufd_backend_unmap_dma(be, ioas_id, iova, size);

If query dirty bitmap fails, shouldn't we unmap and return the query 
bitmap error to fail migration? Otherwise, migration may succeed with 
some dirtied pages not being migrated.

Thanks.

>           }
>
> --
> 2.47.1
>

