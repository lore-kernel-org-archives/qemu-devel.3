Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AFBC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuC4N-0005B2-Hz; Mon, 17 Mar 2025 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tuC4J-0005AY-K5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:07:55 -0400
Received: from mail-bn8nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tuC4H-0008KR-4h
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlLRQjkZlqQgNRwtPoNlBsRSgPg8SjgjApmXBfj7fJ8W4etszZnmOFCjfXrw4GlDnYS1vDVHyZCB/lBvu+1xHmUFexX+ULWkGn/KYTYVXi3gM4zJCrQY+LQ5/q3i0IL6HuXXTIoQA3N1FXU1mWhbB2lmrGbaBQSovrxNudeKKsVfVfXmakN8+cMeuJFUz4FmMIWV4gdQ6P3RlYxyqLOKJwrDwt8GsuJotsVShcAxVJFqVv1z5bGfLryFB9KqXNaxG7q7x4m6Wimmcqu5Fd7xqksmjjDGcNTJUKF611sjVdozLLi1S2ZMAFn0nE655ct1bcYH8tQwc/WyjdMwCnbcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVc6q5iFU3G3crbVzvC1DrLqjNbp4QPKghoqSfyAn2k=;
 b=isiMvgxFgZCdp+MJKhGMp7jr1T3WhkbTEcsJHw8WjhBIo3VMD6QRS3U/NK3W61POZayhKIHu1hTY0i6m8KA9s+GgEj+QUiggLhq+UZJHLsh30/DOweyg2wlDJKa0tANmLWg+pkLY/1ErKJtjKFDue6kDtBLddL2pjPHnwz8a+NQLN7ERI81t+WT6TQhaWsvF5xq8dhDSLcsTm4aa7nfTjlmKTBMRlFv8x1LqmYrPdPSzmfWZ7n67uaEKH1A82AHoViPdpxj0J8IyL6JHbLt7P2v3xSC087HUMWd5Xhhd179MSw/sgL7EIHs99S4TfKXe892SBnh3ZTFyEnXt755A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVc6q5iFU3G3crbVzvC1DrLqjNbp4QPKghoqSfyAn2k=;
 b=S76z2cuUduYsqgxC9hQpfEFePkDUOw9BZB8gQadCh6yvLLyqK7yM3VAt64piWEah4fLsqvtSr+lDIMKB8X/Ii6o7nhc17axpKMJab7D9QpM3GUfF23sCWR/fSotPn3i/bRSsPmMu2IuZ+biO3oT/ki+lfd0rIbfnKNS1lzlPRtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 15:07:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:07:46 +0000
Message-ID: <af8b9954-3ca7-4b78-a9ec-e1826bd306b3@amd.com>
Date: Mon, 17 Mar 2025 20:37:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] amd_iommu: Fix masks for Device Table Address Register
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-5-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-5-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: a7477e69-f042-4dbd-b348-08dd65657990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wi9ZU1J6S0ViLzRUZ1FCOThjTS9TY3Vyb1pyeVBxQWpyRTZ0R2UxbCtYNFp6?=
 =?utf-8?B?OXlOZEZCUTJja3B3dVpmSzRPU21LOFYwNXljV0ZUay9nZlg3NUxFdkt1MEFt?=
 =?utf-8?B?VUZFYXFnUXQ3MHRNa3V5c2ZUUENMdjZEdVd3ZzRKZVRuTnlxek1YdkZDTGxj?=
 =?utf-8?B?dzJXc0NQTlgxTkFIYU0wdUZRb1IyQ2lLRjFIZS9UVWtIdTQ4d2ZUZ2dCcTVS?=
 =?utf-8?B?R0sycXIvRC9HSUJleTdJaXJtYjlvVWduMkNxK05wY1ZrekZsUHM1bUYvdUhT?=
 =?utf-8?B?dkl4aTRrekg2M2NiWWl3czJCbnFtemorZTNrRW1CVzlYVGM5Z1BRZVZRRGdh?=
 =?utf-8?B?SjR5bEMrdjM3V0Z1d1VaZnIyaWVaOE9IbWlNSUVESlV3UHV1cllFWldTZEFo?=
 =?utf-8?B?S1lWUVcxcFBBSkVYZlg1SEZlckh1OEJuRWlyU2pHRWM2RUhRSHp3Y3ltYzZ4?=
 =?utf-8?B?cU5Vd2hDVGozVERnYkNkOS9peEllbCtyL29NeElob3NTeFV0OWYxWFlHYThv?=
 =?utf-8?B?V0Yrcjc3VTBkcHNQSERJOTZnOFFubmdiWC9mRDkra1ArdWg2WlBQZko4YUlk?=
 =?utf-8?B?TVNxY1lweklwRURvcWFCT0JxVW0zNmhrRFZ5eTdBckpkNUF5alI4d1dlZERV?=
 =?utf-8?B?dzRVK1d0VUY4b1RsMlNHWkkxNi9rT1dPdkNZSXBlV2FsaTBJdTArNm9Ob0Iv?=
 =?utf-8?B?aUZ2YjREaUNhWFE5eC9UVGRicUtRbFhGOVlGd0dCS1dlTkhNOHNMU0RPejNr?=
 =?utf-8?B?Z0l2WVdJc0JCckJwUzhrOEczUmd1cDl2bTlhN21rYWhMNUlWRkRmNndLRWcz?=
 =?utf-8?B?WWM5ZFlrOHNlMzBBN055NTJpNEFmU0dyd3AwMXJNOUNZRkRwM3Q2R2N0NFMy?=
 =?utf-8?B?VWNFVEhLMEU5QlFQNkJmZExPdGVrUkl1WEp3bXAxRXR3eG1lS3JYc0YwYjc1?=
 =?utf-8?B?dG82R3lPZVlhL3hxemxYdVZTMXMwV25UVnB1dWJTQ3BNTHova2pHajZTT01w?=
 =?utf-8?B?MXdGNFJNVlF5SURRaE5jeU81bS9YMXlmQUswSW9FSERLcjdPc1dEUmErRkZX?=
 =?utf-8?B?QjQ4SElCSmcvdlhJcGhXMGdJOFcvS2JHRkNpZ2N5cG5YMEdqcWtlMS9DZGVT?=
 =?utf-8?B?VUVCSTlHUU9tZjZOeVc1c0tmUzJ6UWVGOFJnVnpXYXp6TjhVTWF0Z1d1YXlP?=
 =?utf-8?B?VjRiemNWOWJBaGJUdFdjTElqYUN3WVp3aVZjK3ZZbDdPdHJudVBpaU1nTzZE?=
 =?utf-8?B?a2ZVYWN1QU15aEgzYzBORk5FaytmbnZORTFoR01oRDdFZW5tS29yRTBGTXpa?=
 =?utf-8?B?WW56N29jbno3aUtUcksxUGUyTm1qajZkRXhySkpBK2syb0ViZnhWUCttUllD?=
 =?utf-8?B?RDVHMUZkczlRVFBiY0ZXQmxkMnVKeXlyZjRlZHhGWWNFVlZTVThFOVl1UDd5?=
 =?utf-8?B?VlB5QVhQZ2Y1dnl0OXIzbFM4NDdXZlZLZS9uenN4Y2k0WDBucWtUUWxQL1Fo?=
 =?utf-8?B?ZDhIV2J2K0dwOFZ4VXVnUWtwa05FY0dHNVJJYVlKbnZ6V2FtZEJtVU1teDhl?=
 =?utf-8?B?WmhTanhvMTQvdGtUa3BBVUE4a21yTzdBOHJlVHQrbjJHVXc5ZTdDWnExWngz?=
 =?utf-8?B?M0cvajRQaktvZ051VkxlUlE0T2NZMWM3a1VBTFh3RmpPdXVRbllVejc2MkJF?=
 =?utf-8?B?b1FhbmFjMVdCM0lLU2szZEpFOGhac05LSzdSNVI0bHRiOStxajFRczRWSjRp?=
 =?utf-8?B?WDhVSVFWNldVODRDUXYyc1A5N3BYcmdJTy96UnhGZXV1bktDMnJQTG9sYXpR?=
 =?utf-8?B?VDBob0J5alVOS2JZRThyN1JBZ3N3czV6U0tSRk5oNmRBalNYTlE4S2ttNGlE?=
 =?utf-8?Q?rqgnw7QWj2Tf4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNlTktqSEJqYisrWFE3SHVWUU9BZ21QVFFxZ2hWdW41QVF1WnpPUkVldEQ5?=
 =?utf-8?B?ZlFEcEI4Z1JCUzhNSFBwOTF2eS9pekVjZm5TMnErZWlCMityb3RrS1NIdTZs?=
 =?utf-8?B?QTZwRnFJNkU1UGViRWdlTy90UVhpUUV6ckE0eE5ydFV1SWVNVFBpRlpIb1Vm?=
 =?utf-8?B?Q3ZRUEx1bUhnNzlIcTVoN0lSL2pXbjBUV21vUHBHVHhqcVg1a3FMM0RTM2Vx?=
 =?utf-8?B?c2IwU1hZZGdSSTdyNEdKZEgrZmZ5aXlBVHlmdkxoYXhYb1pWcnNOazRxeFJU?=
 =?utf-8?B?bFVueWdjS3gvVmVMQ2tRQ05lV3lPN0RPbmZxRk95Z2FaVjdoNDk2di9Tbnkr?=
 =?utf-8?B?ZGZjT2syRFMvazc4UHhMMFpISjJLWjhBQnlZM3NROWdJRUNnZ2FCYmo2QVZx?=
 =?utf-8?B?Z2hXZXJGQ0pkamoyZ2JQcUc1OTI0OTNhKzVDUE9xT0hPVnlwaHd5T0RJcGt1?=
 =?utf-8?B?WnUvdVY3ZktPbmU3T3AyOGdQTTI0UVJwcnpxVDZhMEhyWDdPL3gvdisyeUoy?=
 =?utf-8?B?Z1lETFFUdnRHeUtva2tBeGtkNkovTnFYUHRCa2N5STlRL25pWnNOM2N5WXUz?=
 =?utf-8?B?TlV4TThqcHhkRDd5Y2NqT2FDemlyekUwSFYrbFNmUkJISEExdWh4eGpnZDlq?=
 =?utf-8?B?cTE4Z05KTjNJWjZhM09NZlhXWmhUejlHbGVZMWtFdEUvdlA1Y3lpU1BGUzI3?=
 =?utf-8?B?N0ZBN0RZMzFlS3lDMmJnVEliY1IySEFqTHhtQmQxZkhPSHpkL1dLclZKYXlp?=
 =?utf-8?B?UjVGbXY4VmtKN3dtOU1yS1FMLzdYazhjT3FWMDhPcGwxaE85djQvOFRJTTkr?=
 =?utf-8?B?dktjQXg0Y3JoaU8vLy9nZFlZdU42bHZMRUhZbWVJbUY3U1lZWGh2bXVFRWZ5?=
 =?utf-8?B?WmxPdSsweTVMYk0xYTUveEpBUW44U0Vpd2libTN3ZzlBcVk0U01uS1YrVGdn?=
 =?utf-8?B?V2tJNnZBRXlDbE4rSW0vVlBHQ2VuS2FHbEcwZHdnZG42cXg4aTFuZXJtUWRa?=
 =?utf-8?B?aUJJUFNtMUxwRTdSYjFnWlMrU1g2L2VYSmVZVVVFb3hzQUowWkY1WExtVHNy?=
 =?utf-8?B?TjJkQnpvTlRYWmNFZFNSWWZ2U2JFUFRsUXJjWVVFYnZmN2xsNlAzczdmc2Y0?=
 =?utf-8?B?ZlREV0ZyU3p0Q25rVURtVzY4VFd0VTdZeUhJaG1NOHBxczhNcUEyaXpXNFNM?=
 =?utf-8?B?bzFVelZCNFBQa0syalpWRVZ4aUNwaThLaFh1a21WQTNTMlBBaWlkUFdRUita?=
 =?utf-8?B?MEdSNW1SVE9OTGtYdVhpS0hiZmhoMXBGRVhzTURIZHlzTmd2dXc5U1FxK0JH?=
 =?utf-8?B?dDMwZUNFNEdCdm5ydEoyRFNRN2xMdUd2OWZZaGVxN3RKZWRTVU1JWWs3ejBL?=
 =?utf-8?B?UFpWM0ZFMEhYWlh5N2VNUWhQTE93NVpEUjRnSGpHV2hpeGNNSlRtL1Vka1lh?=
 =?utf-8?B?MjF4VkIzWnFvQ1BRV1NWVGQrOEk3cWZoM21OSndkRU5KWnFXRDlzTkdpVmtP?=
 =?utf-8?B?UGVjdHBJMXlVMjBEWk4yV2UyQnNCUTVFN3lwdklxNlNjMkN0YUx3a1lXMEFu?=
 =?utf-8?B?cWltOExQSjl4SHdHbExLM1IvQktib2NOSy9rMTc1U1NuQW5mZUlDZ1Nja2xI?=
 =?utf-8?B?VGpoeW9Mdm9lT0laa05VNTRYN3BZb21vRGJMZUdCL0U2UEdpRE9jSUsvb2NP?=
 =?utf-8?B?K0p2RGZTVno1STRJQmlMTGNLcFcwYmlIY3BVSEovRjdmT3o0YVE1V3EwOTV3?=
 =?utf-8?B?MCt3ejN2a3hmQkhZbjkxUDR5Rk9wbDR2NnlabkZzUENjUXl2U05KS0s3OU1s?=
 =?utf-8?B?MldnSEhMTVNXTElZMFZDMFB6UHRhNFRqTzV5NTlEV0U3VUlrVHRLUXZrSWtZ?=
 =?utf-8?B?OTVGaXFiNVpZZUpwWWJwY091Nkw3bzk2cVY4QnBIdlpmTWhOUHpHd3dVK2U1?=
 =?utf-8?B?WjY3eHFwaG92V2p5TExvS1piVkRzRkdPSkEvb21YLy9hK1FrN1ZoWjVUOUEy?=
 =?utf-8?B?TDFNbGM2UmJUOUpnVG9WQ0M1ODVEaFRCd0xNY0VHc29teDJMeTRKcVpsS1B6?=
 =?utf-8?B?OUk0Y0F4cTI2Z2tRS1B4NVBwQXpXekxtZ2l3QmxnUi90TzZ3RWhsdnFYWFQ0?=
 =?utf-8?Q?fL5QLw3pmLLLCjPq7evd1NYSU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7477e69-f042-4dbd-b348-08dd65657990
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:07:46.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in+LmgccdeMs16kxSTbtYpsfhArlTqMwYFifJXJH/jcoWil3I1qowPQhUbsHamdWYhBwm2d8CjnkPCUv4ZF5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
Received-SPF: permerror client-ip=2a01:111:f403:2414::61b;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alejandro,


On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The size mask currently encompasses reserved bits [11:9]. Extract only the
> corrects bits encoding size (i.e. [8:0]).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 8d5d882a06..2c5c8c70f1 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -68,16 +68,16 @@
>  
>  #define AMDVI_MMIO_SIZE               0x4000
>  
> -#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
> -#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
> -                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
> +#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
> +#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
> +
>  #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
>  #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
>  
>  /* some of this are similar but just for readability */
>  #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
>  #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
> -#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
> +#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)

May be update AMDVI_MMIO_EVTLOG_BASE_MASK / AMDVI_MMIO_PPRLOG_BASE_MASK as well?
(I mean use GENMASK64 for these macros instead of they referring to some other
macros).



-Vasant


