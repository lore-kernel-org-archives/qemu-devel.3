Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B9CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62xz-00044C-Ff; Tue, 07 Oct 2025 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1v62xw-0003xQ-1S
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:36 -0400
Received: from mail-westus2azon11012012.outbound.protection.outlook.com
 ([52.101.48.12] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1v62xs-0002op-RY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArwCeA0Go1YzqfQsWiwRn1w0+QvTKPhrUVHILRXnatQjfxwFQtzk8BmqQ2OkO9FJW9/kDUwIVjf6kPbwmromXIhEhYj/XH2VP2fTP+gvrFN51UUBTR7JMSbWLrIj372XMjb9cye9bZNvFeVW7lCC/ImNa2fu48Qe3so1GCznbBa7/Gz79MXwLu9efGTV1DtmwyO8CjJkMRMRCjJnQfImAnjaWK+AcpzjD7qFjaJJfuMn4Jzoo2a3IwHLRoKw8ZjAufGSFAGosKQgvBNQGC9FCxHdvGUEglMOYKE0hE+wf2jMuFqfUBZ7iUxh5oyUtGHhvcJBZZw2ScZPjivmvwAypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2/bCSrPIRESRIbIuJfTrqagWrCWt0SgfDTuf/ylC4c=;
 b=I/2zryEo75t5O3Wfz4gTnporJzoB0I3OUGOVCdODTq8y2vf1vYP12CScb/7FsD3meir/136+aD4H+IWnXT4HYoPRagX4Sq7zlibCqAqz2q+9uMgdmSAG4CbQQZ12HiD53o4ysbs6NYaCP58/12DW/NFup2x64TwNzS+49QmzUCd4+4eiX2yyCBQjOb3OBcz7NOdtBssHtUfG7ZNR7sIASx5dDUFNVb1h4iUGUBqlPKeUXg2SXj8DIjqmqY++JsHxVFUAR0qKmXzpnd7MjFKBIpEEg0DF+w5FmZ1NZOlU4gQmtwQ7mVsy4EMtypc7juimDevlmTsbiUiiGFogqZf6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2/bCSrPIRESRIbIuJfTrqagWrCWt0SgfDTuf/ylC4c=;
 b=tuEouc3+4J318Fub4GM/xPbCEhdId6VcmfeOQeGRVFaDx9ZGif/ZkkyCo+m5QxRJKuMdwEZr6Lh90XnJx/Y3AxbmOITQMivW1tSYcE6gU+5b8P1/lXre86Z0D/LmpgPcSBc+Qqz3a31cMNYKfF66/sp0cCIvB7BLpI+Q8KLdWo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 08:17:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:17:26 +0000
Message-ID: <f55efeab-4579-4dd9-b88d-bf321492ce2f@amd.com>
Date: Tue, 7 Oct 2025 13:47:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org,
 Joao Martins <joao.m.martins@oracle.com>
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com, sarunkod@amd.com,
 Wei.Huang2@amd.com, Ankit.Soni@amd.com, ethan.milon@eviden.com,
 boris.ostrovsky@oracle.com
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
 <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
 <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 1345fe49-9c97-4548-d2dc-08de0579f334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXdCamlyL0NJVThsTisrSU5GSGQ3M0sxSU8rckFjWHFSblVGMHBvb1ZDRFZV?=
 =?utf-8?B?ajJ5bXJtWmxvWElFczljWkNlZEdSS1hKMkVxUkNZV1hLSmZtbkw1bGdqY0FQ?=
 =?utf-8?B?K1hGcjdmVG0rczVXK1N1djJ3RFJLQ1VacEpya2MyOEdLZ0JpcGE1Uk10cUVY?=
 =?utf-8?B?amIzOGpadW5MS0FmZDRCNXBYamI3dFBFZWpya0RhSHN3cC9idGlPY0lUZjJF?=
 =?utf-8?B?Qk5VbVltaGc2OXBqRDZGY1Z3cnlxVjFGQ1VRTDUyVlhTMlV0bTlmc3BMRGRs?=
 =?utf-8?B?SjZGN1hZdUYwM1RCdHhBV09CN1hRNTFPaklqMEhiYjc4RTdHbUV2RUFBbENO?=
 =?utf-8?B?Z0ZWcEc0SituZHVVaSt5eTdpbDRQUkIzTGpTUVJDNjRrUmx4Y0JJaDVXenNY?=
 =?utf-8?B?TXJnaHl2OXJLaXltSlIwNU1Qc1h5dnUwUHFEcWdJYmpCRFpQdTZpNHo1TGxL?=
 =?utf-8?B?RGkzdWtxL0lMYnJGS01aeHBYSkRETWxmNTRIK1pMM3NiVzM0bEpZbm0vWGFP?=
 =?utf-8?B?SjRmWjBYdGExZkl1aDZmN3IvcTFnTmtXRVRoUTBSOHd3VGd5SWVxNytKMDdw?=
 =?utf-8?B?cEV1RUZoMjhIWk8xTzhxa29PUzVZTk5IVjE4QXp2Zkh6SUVrekVMcjI0VVZU?=
 =?utf-8?B?RmtQTnhGVGJFaTFTWHJzS0NWMHlPbmNJL3VIOWdQZlI1VG8yQXAxQzhhTXhw?=
 =?utf-8?B?TVViaWo3eEFnR0FCRVZRbWNJSFZ3WFBzbTdRYkxGbzdmc1ROTlJnUFJJdGpw?=
 =?utf-8?B?ZUhVQmphdjJrcFgzVUQ0dGI4TWhsVElLQWV5QmFOTVBQTFhZOWZXYUMwQjN6?=
 =?utf-8?B?eXp6STI1akp5cUNUK3RMRzg3QThiV2pKU0JnOHp2K2Fmc1hldTBTQXVzVHNw?=
 =?utf-8?B?b3ZFSnVxQkc4a3hnUjZaLzFxZlRVV25xWXVsZkYxM2pGVlBxVys3WEdaY2Fx?=
 =?utf-8?B?MWY2Z0ZDakREODFiRG9KcnkrQ01jTG1QMExoa1hTYVBRc21kVVI2dGRlRVcy?=
 =?utf-8?B?M04yUTI3bTNsdVJjZ3g5d0NYcm91SWtvWjkyZHpqYVBOdEJvUlp3d2h2MUxV?=
 =?utf-8?B?K2lLbjFmaDZYLzE0L29oRC84L3RCeUpXMGNhMmhyenpkeENNMSsvZ3Q2VXJT?=
 =?utf-8?B?YUY4ZGNINUgrL01TSUJhaTF0clloYjZudlJESEdwVTdpQklpbGhpU3ZLTmts?=
 =?utf-8?B?dEl2RDFKdTViRkF0R2lYV1NkTThrSU02dXhOYW0vQm56KzVFMUlCelhpL2Rj?=
 =?utf-8?B?TGNBRFBpNWcrcDBONk9nS0duMTlrWTJHWWJlRkY5RVpBSWlWM0JQaXU1bFNN?=
 =?utf-8?B?cUNZd3AwNUh3Vmg2RjhjVnVhYUovdjBrMFg5LzRzU0tJQjVqYjE2MXQyVSs4?=
 =?utf-8?B?Sy95QTNQcGlLaHZ6L3AxSS90bGZNc3J0bGMyMWprT09yazZMZktKclF1bGl5?=
 =?utf-8?B?L0ZzVFA5aUV3YjZxL3ZBKzdCa29aQnl5b2RaaDR2OWN4NGJpalA0SFV6ZVYw?=
 =?utf-8?B?M1dKVzRzK0xxZHRsNGFBMkVTUXA1c0U4UG9vbVQxaUVzMEdjdkJpWEI0dmZG?=
 =?utf-8?B?RTNXZXlYMXV0RTFqWHVqV3R6N1JPNGh5MytyaDFQL2czaGdubTJSNjBPUjhj?=
 =?utf-8?B?RFhRUlIwS2Jic1BQK2Q1b2pRaVg0Rk1DdXI2eWhmNExERGJEN2NHZEtpSlNy?=
 =?utf-8?B?Um5GWGdpVFlwc25abkZmQ1M5UWZBR0J5STMwM1pTN3BHc1N0d1FTTmZJL0hw?=
 =?utf-8?B?c1RySTdoVXRreFBJZlRnMmVTcDZMVEJDUXRUdnZnaWFkcTZ5YytMd3JYU3g0?=
 =?utf-8?B?Y3FRN1VhSkhkazBnMWVSMVJaQWh1S1I4TW15dmVLQm5jY2piOG50eDFwZzhm?=
 =?utf-8?B?dHk0V2QwM0JjQXRJdEdoOElReER5NUFVRlovNStOeXVQSDY1ZVNTNmxYMWpO?=
 =?utf-8?Q?uNe7iQ1N2PzrVbXEBVgKfiMlVhpYMnWm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFlOHZacE80c2Z4cmNmRkZQSks0eGU0L3FlUVZkcU5DbHVQazlPVzRvaXZV?=
 =?utf-8?B?RDR3UU5DSlN0dEUyMExTWUllZWsrd29XRU1mYXluNFFJK3lSRzNIYnJ2R0hp?=
 =?utf-8?B?QkJQRjJzR3h2V2NLWE9rRC9GWE9OY0NvR3JiUjNVZXlPbmlXbEpkalViT1BG?=
 =?utf-8?B?QnRFUmhHTkhNK1FSRkJDMjVoS1VkMVlnRUZ1a2lwZ2c5aU1WSktNOWU0Vldz?=
 =?utf-8?B?cm9Hb2FaMmRFbmpPcHUvdEZhZFc1V0xtcE10Wk5taUhaYThDTTZvbmtQNUow?=
 =?utf-8?B?akJvMU1FZUw1RTBaQUM1d2dWZlFzMmhJT2hvYVd4V3IzaVN3dFJHMm5QS1Ra?=
 =?utf-8?B?YWtlQ1YreXFBR1psM0ZkZjBFNmw3ajFFazRDUTlUaVBzaWdhamo1N2lQTFhS?=
 =?utf-8?B?UmxkVU9TVERBZmZia0VYcUlsODAzQVM1VFpac1lpTUJPSWF6amZCaDFyNGUz?=
 =?utf-8?B?QWhMNE9EeGRXNnRyYmdTUGxwbkx0ZWNBbmdSTk9XZXZOcGFvWUpDdjJYSkdW?=
 =?utf-8?B?dHRXQkZBSi9pTEFvTnUzU0hGZ2llbjAvd3IxNXN6YU9JZW1pVWhQVWdEbXVB?=
 =?utf-8?B?RXMxcmtkUGhGWDN2UFBFMHhBZW5kK0pyMSs3YkxtcVlTR1RibDROVm5IaEpI?=
 =?utf-8?B?bEhtTXlDaGh0R05YS2dTYmpvVHFRSE9QQUl6Tko0YW0zTEs2bkVHNWhLL0tq?=
 =?utf-8?B?RWt2NzhWMWoySTZuUzhTT0czcTVYZEJzZlNiU3ZxYndpQmNkUVVLbEwxeUo3?=
 =?utf-8?B?bk5UNU94ZHVhR0hTQVBGdjk1T1BGR0lQU0czQlJIa1o1N3lEcnJ5aTNyN0dM?=
 =?utf-8?B?ZU9zaUlLUFFiNmlIdlhrKzZzR0pneUhOeGJlc2h4QXBFekQya3NNTlNsWjN1?=
 =?utf-8?B?cWtxaXZTNXovcUc0ZkVIL2t3WGpnWThIakZOR3RGc3BJV2M2K0Z3eXJORVlX?=
 =?utf-8?B?UXBqS3psbEVrUU9YQW5MQ24yRUdHaFNTME1QL1czVGl1bHdqWWZEWTdiNVYw?=
 =?utf-8?B?S1dZaUJ4RFZwVXR0aGhHUXk3d2p3dExrMUZKTVNiKzQxM2R5SXYxbEZEUmdp?=
 =?utf-8?B?M2JKVFFsT3lSeEUzc0QvWmtMRk5NMFBFUnRZMVRxUGIzU0lIV28wUHNHM2I5?=
 =?utf-8?B?aWp5OGROYmpnVmNkSVV3czVTOHhwN1ZsTmFyd0R3SXJ6OHRLZFZEYlVCS3pk?=
 =?utf-8?B?MTUwUmpwUENFMEx1enFZd1ZWSWErbmloTVNEQ3UvOFZMTWs5ODE4RUFRaTR3?=
 =?utf-8?B?dFVBRjNKaWhUS1lrbGhOTFc5YTB0R2hDcXpSd3dVdElZWUNMdXh0WXpNNVht?=
 =?utf-8?B?aTYwbkQyRzhyVGdKa25WekpBdDZsZG5uMi9kMmpBeUtaQnMra1VCWUw4VUZn?=
 =?utf-8?B?NTRXaVRCWXhacnJBYmp2SjYvSFlueUpOVWFTMzljclpoMjZjUy80ak1tWXNF?=
 =?utf-8?B?QXdZSUNtYllMeHhnYlRZeFV4Mmo4QXJFcFhRM2h0bEY2Sk5XeG8wUGJhMG1H?=
 =?utf-8?B?ZjkrQW43Zk1ud05XVTh5bWd5YlhpdTFqMm80ZTBwbmtVZnFSWVlKV0szazJI?=
 =?utf-8?B?aDFCN3diaXB5TjRzS0xhUWlabElmVEFNSXQ4ZXhHd0xMdW9sL0VOZFMxTFFq?=
 =?utf-8?B?SCszNDd2bTR1Q0tLcXV3SEJwdWpaaGs2bHBKcHJCZ0diaTZFRVNHRmNheDU2?=
 =?utf-8?B?bnRlekwyb3IxS3NnMlJOVm03Vi93cTU5WWI2NXNrOU4zNGRxQjJiVWJKVU1u?=
 =?utf-8?B?UE5Obkp4QVIrcDFsYWUyMkNyMmp4Z1ExTkVxUW1QTG9rS2p4a1Rrd0NST3la?=
 =?utf-8?B?amNzbVpWZmkvbFFVREZyR0xTVnoxRmRFckJGc3BMU3JRSmRBME40ODNySmll?=
 =?utf-8?B?cFBjSEthSXpyVjIvRnR4YnMxcE53cSt3YUFydnNMSDdnU3NSSmpCZjNaUVpl?=
 =?utf-8?B?MWo2QkgxTDJabTlUOS92VHZwSmJMVlJNYVlBZnZqMkk3NnhXUFVrWjZleXpy?=
 =?utf-8?B?WUFyejlDVWYvT1Z0QTErWVJtNG1TczdYTkpJWFpkby9ublJWVkgzeGpqcEMr?=
 =?utf-8?B?OU1kV0lpTkdTMXNtQ1BSUW9EMEthcDIyKzdOOXdxQXA2V2dHTlRDcVNhVzhD?=
 =?utf-8?Q?ac2rDg8FQ1b9pU4rPqUOG5PC3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1345fe49-9c97-4548-d2dc-08de0579f334
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:17:26.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mssgw8xEWE95+mGQhiVLt0KWdg2Qm3/NH9oHPptfjuvm7rufwPy28VHs1zr/ZR9S4+Xv6mxiZEs827nBnlzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
Received-SPF: permerror client-ip=52.101.48.12;
 envelope-from=Vasant.Hegde@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cedric, Alejandro,


On 10/7/2025 11:15 AM, Cédric Le Goater wrote:
> Hello,
> 
> On 10/6/25 20:44, Alejandro Jimenez wrote:
>> Hi Cédric,
>>
>> On 10/6/25 12:07 PM, Cédric Le Goater wrote:
>>> Hello Alejandro,
>>>
>>> On 9/19/25 23:34, Alejandro Jimenez wrote:
>>
>> [...]
>>
>>>
>>>
>>> The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
>>> Since this series is about to be merged, should AMD-Vi be considered
>>> maintained now ?
>>
>> It should be considered maintained.
> 
> Great :)
>>> and if so by whom ?
>>>
>>
>> I volunteer as maintainer. Assuming no objections from the community, I will
>> send a follow up patch updating MAINTAINERS.
> 
> Thanks.
>> If there are additional suggestions/volunteers for co-maintainers, please
>> reply to this thread and I'll include them on the patch.
> This series includes a co-author who would make an excellent reviewer !

Ack. Can you please add "Sairaj" as Reviewer.

Sairaj Kodilkar <sarunkod@amd.com>


-Vasant


