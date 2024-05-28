Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61877C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByTe-00085U-Ph; Tue, 28 May 2024 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sByTd-00084V-9A
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:11:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sByTb-0000JT-Jc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:11:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SBpBug020354; Tue, 28 May 2024 15:10:41 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DWSTa2+CTaG3V0f/tASK9VcQfc2J2FqGE+ucA0VWLGe4=3D;_b?=
 =?UTF-8?Q?=3Dl3AGjQxAzD2zS35ZP3IDr9+jNAP6OgDsY4oO9CbwUEinYNGVBBwSS5unGnXX?=
 =?UTF-8?Q?xKZxHzwT_RvB1V4wzy11sKZXLOEqwSIOfQ2+LHybvTMPmum7+8abtQky6p9plgv?=
 =?UTF-8?Q?iZdw3K3D3MZX0j_Mr8JagtGfV0n281Noaaa9InFc+Ei9AylEVzR2yK3F6I7HtCf?=
 =?UTF-8?Q?Ww1V1ny7Z4iNZI3FcdYJ_Qz0g8W9JZin+YqQfxGhS0ak1YtTyAgnwcGCwkJqJ34?=
 =?UTF-8?Q?HqsVYF9imfub3wXqzvHukYW8uw_bRwtQT42ZobO2j6VYHeMcMuTVSo78IVm31Y7?=
 =?UTF-8?Q?GWmexcJEdFX3leyDd/09AMM37zn66nfA_kg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7mh9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:24 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44SEmkgZ009265; Tue, 28 May 2024 15:10:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc52b9530-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAdZQ+tyUI+ijejTT9IpeJnlkA9M+RvcnnapdyrDNddP33294r1vFqIgFqGcyCGqHLCmFYYWQ+jzl5Kqu50PksEh/ECkirnGFf0jgQJHXc00nhWB8zTaPE/bnP6C09P/cXAi09cokUznaEDT7QI7Pv2qnhnuAs7OkcTbVIs/OLtWsBjIc+8NVmaM4pYn9H8Bp//xiMR53CIFvSdKwcbC0+3KXncpWEq19Ba2lRTLlvCoNOaX9kB7P7RQQe1RWRQZM+VHSICzMjTl+aTUsLMXPUTgxIKPj6zOJA3HHKf5fAvdduMd9djzJBIwGAlscM5GTJh+TdzZHPOIVKOnrm9XOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSTa2+CTaG3V0f/tASK9VcQfc2J2FqGE+ucA0VWLGe4=;
 b=j1fwRJe+zHQH7BVb6g9IrpYu1D8OpNuR9zovRIc78M5dvk0dkjXxlBjJ3GZZ+HSdfxp4puu7EuyGUYtd0hQDRxJCH3hZ+lSpaVjPP67ck3gXJFMgL4t3NMLip1Y4XCypvplQ3s4obvoT9+VYxbvJGkUTpH5ZC6pdKZ4E7Z9R2FqKfA3KUxeSwcI7KCnWuPRxqcHGqyWOxcvFbt5fJCPXG+argwiexCIwxLUstazVoqf3QRLBJyS5p31CajOxww/OUgQ3+BMCfFsW7TUCdAgHYzFz2zCTBnHtEpJBricmveJgg9bOq10CdAS9gOR8sfNAfUMJLfpJHt3kcXP31kZ+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSTa2+CTaG3V0f/tASK9VcQfc2J2FqGE+ucA0VWLGe4=;
 b=q7AJXnwJPqqfYc/X7rhMJqFPZN3eLGvRqqZCU9nalCpfel4I1zcZ3VMNJ1ogRDXW0PSEAlanKYQU2e2O6/1yHkuHOBCUN4gf9dP/mNYUX4blQerTrMBr87PH+NUNf7JihMFmg7LGpi+OKlOfwkFBUyriPRiDnLp6zgv/BSLlklw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:10:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:10:20 +0000
Message-ID: <f0d4b6af-a3eb-451d-b131-62addb72f3ef@oracle.com>
Date: Tue, 28 May 2024 11:10:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 08/26] migration: vmstate_info_void_ptr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
 <ZlTRgsNatkvsLKpL@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlTRgsNatkvsLKpL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce5b30f-3815-4f4b-2b08-08dc7f284a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b21nYnp3OWVDcVM0dXV4VHdSSlhuNThPZ2lqS0tJUXo3QUJMYmpXUEhGREMv?=
 =?utf-8?B?M1ZjLzN1SnNycmU3V2JYK3lFK2piK1g3MDczQVZEOHFWb1F2b04rSXF5a2c3?=
 =?utf-8?B?RmIydmhJZXhDb2ZoSjdjSzZ4dXlIemZxdzdhZWpsV1kzeFFXdjlYaERNeGx0?=
 =?utf-8?B?SDNRUjRPaXRWZ3N6Mm9GMWRUYUFCU2RNTnhVeC9aWmhmRG5PYTR0RGxUY05H?=
 =?utf-8?B?R29lOWo0SiszSEVnU1dsOWQ2WHg3RjR0aHBraFNoN1F4ZVBWcThpR2RjY05l?=
 =?utf-8?B?M0R0Ry85Z1hkN3phc0ZOVTVoNEJYRktNS25vd0RJc1Rxb3JrbnhGdVFXQ2Nm?=
 =?utf-8?B?R2pZbm9IY2MvQUwxYXlaTVM3cU9Hdm43WG42czR2c0RZM1JEMHhveWxrRmtp?=
 =?utf-8?B?Rk5QczFRUjJBMXRRYmN0V0VCMWJ1Nk5OQzFKU2wyMEtzSWNRM1dWdnl0RnJF?=
 =?utf-8?B?emlIVnFyNlZJTkZJOW42MHVIWm9zY3lZN0VPU3BLQjFUNWdJQ1pISnFaWDhB?=
 =?utf-8?B?RzkvL2RCYk5uNFRwM0JOaldhYWQ2RzlzSDZ0d00zWENOWjdOU0pvak90enlt?=
 =?utf-8?B?NzlUZnQ4SzFydEtRZzFDYUVSTzhwZmY4czlEOVpXOTFBNVBvdDV6QjZzK3JI?=
 =?utf-8?B?TmJOUnZWQVZnVzBDL25xMWhqUDExSnJVNklKaHRzM1FXN3VSZnprYndJcXIw?=
 =?utf-8?B?RnV4SDczTFZyQjViVk45SzJETHljNnNGbzVJNGNHb0hJYjdsRFZmd1lWZG1j?=
 =?utf-8?B?SVl1Vlo0NTRWU0ozN2IvTE9nVUpWZWU5M1piMTBlM0lPcTR0T0FUMmZxOGgv?=
 =?utf-8?B?eDZrSFNPcHJEdGlIaTMrMktYNzRPd1JQQ3JFZ0l3RnBzRFlmL1Mybkt2cFhW?=
 =?utf-8?B?RlVSSmo4S1hLUzEwbUowYlBBTHNrSlBmZWxwd0kyWEhaUlRlL3RzTVJTMzVR?=
 =?utf-8?B?dDJYeWE4UDVOMnMwMVJhMjc2ZDA5N2lNK0tETjFIY1kzSmRTVTRKRkEzK1Zy?=
 =?utf-8?B?YmdxYWo2djZnSEZQdm1ZeWRpcW5JODJ0RXM4UzZWRHZhczFLbVN2WFFhRHMy?=
 =?utf-8?B?U0o4a0JHeGdGQXpmMElLZ09UU1cvNmR1T09IeWdXaUhoT3VXNGM2WUlyUHJq?=
 =?utf-8?B?Tkt5Qmozem1LTll1L1V6TUp3TTAvV3lOWWVLYWdSMlJQRHRseVJwSVoxaFdi?=
 =?utf-8?B?SU9PQ2Fkd3ZKUnZ3WGI4VW1kY2JFUXhnS0J3dXZydytSNHZoUGZMZUUxN0M2?=
 =?utf-8?B?YjN2L2J3M1hKK2hwYUhjdEVzcHJOV3M3Z0N6LytURU81d0VmNjdGaGNaS2pT?=
 =?utf-8?B?UzloMDQzaG5sZlNJTGVoZTl1cHVOZEdvYXBNUStZYWlaakMwdTdxQUdkbDdk?=
 =?utf-8?B?bTBCMXRXN3c0YjAzcmhaa29PWXAxVnBYakRqdWR2REVtV3ZmdlUwUkMrQ0Mr?=
 =?utf-8?B?RFVjZE5XV21vRjBBc1ZlUll4K1F1SWNITTVIOUpRc3o3ejJ1MllXRVhHUEVv?=
 =?utf-8?B?aHdmTTFJOWpHbnRmLzNoeEdpaDlZZ1lZUGpwTWRKdjh4bGJTU3NobGcrSE1L?=
 =?utf-8?B?SSsva3RoZFFDOTcxTVMyOElRb1d5cFY5b05EdDk3MUxUVDljaFl1Q3J1RjNl?=
 =?utf-8?B?TkRpcjc3Tm9TQTJRcUplTmxZQzBqZ01xczhrbFp5WXpmaWx1N2JKL3FwejdX?=
 =?utf-8?B?Mk44Tm4wU1JhMWRuMWZTbEJJY1ZoNTNZVGZrdGZlem1ieGFwTkNhNVNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VpTktuYVJzVXUweTEycjV0TVczWkNBTndWUTE1N1FOTnRqYmlJV0RmQVZ0?=
 =?utf-8?B?enVCanY4bk9uY09TZjQxKzVrQzRTOE1VeFIxRTc1cFRIWTI4RUNmVk56NjVO?=
 =?utf-8?B?QzFCOWhYZUdGUjV1QWdtMjV4WU9qK2cxV25Vck5pZDFSTlpya2hxUFA5L0tO?=
 =?utf-8?B?Z0tEVFBGYnJYR3NsekRvWUF5MnVUSktzNWp5b1dQa01ka3JkdzhEemRZSTBH?=
 =?utf-8?B?RjRQakF2cDZwZ1pYdDBlaVBmVEhYak13a09oUjhnNUo0dDZZZFVoYjllOHEy?=
 =?utf-8?B?Z3NuOWNob1lTVWFzYTB5dUNYdGJpYTFhQnZDNytOZmVCT3owL2dUekZyMk13?=
 =?utf-8?B?SkNsSC9oYnUwdzNFdnBMaWQreFE3UFlwSTZwVWw4c1RPR1ZYVDRsZmJTZ011?=
 =?utf-8?B?Tm1CaXZDUHBCSk8yUzRZaVVSME51UFdFbDhLTVBGL1YwdVAvNVpwZmxUSGRJ?=
 =?utf-8?B?Tjc5TDd1UnprWnV4NmgzbGIraTJGcklqaXdYcHFWTFdtMVBkR0pTY2hOa3o0?=
 =?utf-8?B?M0ZhZVVsRTFxUTdjRk9qZXFGNUZ5SnRNNnA1R1ZXdFJoTnE5NEJiVHprMk5V?=
 =?utf-8?B?VEtrOFJtN0g0d0pBeFZKNFpzdTNWNGU3aDFYTEMxZ1E3WTRnMWdhZEs3TzZN?=
 =?utf-8?B?YTg4THB2QkV6bXpDcWthaVlxeEdvNzlTUDY3a0hFZWY0UWZWRXI3dUM1K09q?=
 =?utf-8?B?aVBLWGlKOEMxbmEzV0h0UTRCMFg0cEloZDJ4bDdLOC9TaHdiS1VRTitiNHRh?=
 =?utf-8?B?aHBJZkR6NHRoQ2RvZGw5ajFsOFl6LzJUMWgyd0tNeFdQaW9VZkdXNUN5V29Y?=
 =?utf-8?B?dUtzNlZmc3h6M1J5WE40RTVuMFhkYitETE50eEJTUGJ1L3ppUVJGZDQ4d2py?=
 =?utf-8?B?RlIyeFc1VmQrcWExUS8vblUwZnNPREFLTzBLY09zVTFYdld6VjBPcjdoRkNV?=
 =?utf-8?B?ODMvZmMyaUZyeng0cWRVQlcwZHh1ZkgrRUkya0JoVCtaVDhmOHNZdXFiNWlU?=
 =?utf-8?B?RlZ0ZWYybnRXOTMrTFhITURPcGp6NUhrL3dqMmtEdTVEMEI4QnlhZ1FWTmxZ?=
 =?utf-8?B?T2pQWGd3QXBRc2E5cC9penRsanROWVVDS0ptcFBLeXduWVJxWEEyUlFXRmFF?=
 =?utf-8?B?Qk9lNzFXU1E1U1BxVjF3VUovcjdhZkVVdEJIK1d3U0Q0R3ZsMjdJQTZIV1dQ?=
 =?utf-8?B?TDZHakJDMWtLRC9aL09PeGY2Z2JuTnVZQ0dxNGs3NURXakxLK0tFWnVQMnRX?=
 =?utf-8?B?ekVWdlZ4ZWVDM3kvZUFGaDhIQzlZd254RWwwNTJDcUVibjNNQ1ZQajFDNjJ5?=
 =?utf-8?B?YTl5UGhkVFNhN1RDQ0xaY0dvYWcybHN2Q1FhN0o2TGdhZWhrY0FMa2F5eS8r?=
 =?utf-8?B?OHVMVWhtSHV4MUlwcGJuZFFPZEtaRmd1VTBEWmdiVEFiVHJ5VmJQakdKczJT?=
 =?utf-8?B?THYyWlZkM21Xa1RSRmpsK3NUMjhNTThpWVZ4QUNHZ1IvVWMyZURhNkRFTkpY?=
 =?utf-8?B?SHNpT3h5SnM3SDZ2Zys1eFFiaUpiVDRMcjkzc01WcENWSThHa2JSc3BvYkQw?=
 =?utf-8?B?azFJYitMVEZXTnE1eDVzNTBsSm0wN1N4R2xEck5Jazd1ekxxUW5jK3Y3alhR?=
 =?utf-8?B?VFpvdVZTNmZJQmd3SVRRMmhkTkR2cFJSUlBwMTBPYnVIeitKOGtyTU9Hb25C?=
 =?utf-8?B?V3NMbnd0SVdwWkhqWURaRExaSzA1dE9XY1EzZzVJNEpFRU94MVl4eHY5d0JE?=
 =?utf-8?B?WmxndnV4OEVEcHZGMm55SjdWOGFhRXpCQkJ0dWlPYTFJREpCSHZXZTVFZDQ5?=
 =?utf-8?B?UlB2RWd1TWdVMzBxVzllWWlDVldKRk50Rjhsemh0MStqMk84TmRnc3Y1cm0r?=
 =?utf-8?B?MmIwWGFyMTZMUG1WOVIyTzB4aHJoaW1IWlpnamxha1ZSNXpNeWZQd2RpUDBW?=
 =?utf-8?B?am1yOFd1VTJmUEZRWXc0dkxNcmZJZzRqYlk2Y29LdU1SYThhdlV4aUNqaHYz?=
 =?utf-8?B?bWkwN0diNFNQaW1BV21ZQ1VkdW84QjhuRlBrOWpnTGlqTEc5K2xxa09kSjFE?=
 =?utf-8?B?RzR6M28xcTU4cy9xTFRyLzljRk54emx2S3hNVWN2by9teVowelNwdWhCNE43?=
 =?utf-8?B?WE1EV1dHMjVNenJYK3VJekV6a3VyTStDTmp1c2xpcm1ITS9BMU1ZM0Rjb3or?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IlHnchcaqlqyrJQxfOT7wN+6VK/ke2dCy5YIDkH8VXM2QABWV4G7ereRoiEhWroUzDZVm4s1GWh9u9no+Ne2JWQxYcc/maT8IRjy3TG1G7/gC3LxjWNsY0I/2sOqkicc0CHnWZg20p363x+9mXCmLkv9xTx1ep6OobPEgdxxamiCNevtW3YwcL8Qbxhq5xBxBIX5QCb7pzgfTq5ELgCSeSSZds9JU2zugnMKm4LXnzad4pfqGHvUO5l5tBHDDaIrHRvxkWJixTqyM0qk2IBX28FA+fWKPqw5Z74JI7r8lSSj/hFoIz2drTBiRFz18GmTlgiWs71veuK4wNbK3NRA88MfQCX4yNXdc/aeFSODDq/ZPtfRtK9zqAPK04pZy8oxd5D7w7EOik+yisy8YZJC7VneBYVKYa8UO6xfLxZvEJzveco0bjfIU5bgmALxRgw7qdrA3N1JubZfym0DhuVMXhB+hAsQu/Nyzrpvg0yZ4kFZPGxCm2fhl05MYzEG/0XoKGoqkuveaAyc0QL2yWSnoT6uV9IpX7NEVy5e/9ZoBN7TJje8wzO8nB1/2jT0Adux/QG9ZYi6Z1lxd/YOBLw9l8mMf/SosmXo64G/Wd2DT1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce5b30f-3815-4f4b-2b08-08dc7f284a8c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:10:20.6983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc09L3L7FdrGRwl2Ncuy2NvDks26pJdU9r0XTZyRCxfZ4ljVNiMX6kva5hYQP9HaReN3AMcLoDkzcLRmE1GfxlacHcihuyVh3/YlDiXfVBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280113
X-Proofpoint-ORIG-GUID: jm3wsMwCbDtkp0C96APqNKlcaUdqOoK1
X-Proofpoint-GUID: jm3wsMwCbDtkp0C96APqNKlcaUdqOoK1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/27/2024 2:31 PM, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 08:55:17AM -0700, Steve Sistare wrote:
>> Define VMSTATE_VOID_PTR so the value of a pointer (but not its target)
>> can be saved in the migration stream.  This will be needed for CPR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> This is really tricky.
> 
>  From a first glance, I don't think migrating a VA is valid at all for
> migration even if with exec.. and looks insane to me for a cross-process
> migration, which seems to be allowed to use as a generic VMSD helper.. as
> VA is the address space barrier for different processes and I think it
> normally even apply to generic execve(), and we're trying to jailbreak for
> some reason..
> 
> It definitely won't work for any generic migration as sizeof(void*) can be
> different afaict between hosts, e.g. 32bit -> 64bit migrations.
> 
> Some description would be really helpful in this commit message,
> e.g. explain the users and why.  Do we need to poison that for generic VMSD
> use (perhaps with prefixed underscores)?  I think I'll need to read on the
> rest to tell..

Short answer: we never dereference the void* in the new process.  And must not.

Longer answer:

During CPR for vfio, each mapped DMA region is re-registered in the new
process using the new VA.  The ioctl to re-register identifies the mapping
by IOVA and length.

The same requirement holds for CPR of iommufd devices.  However, in the
iommufd framework, IOVA does not uniquely identify a dma mapping, and we
need to use the old VA as the unique identifier.  The new process
re-registers each mapping, passing the old VA and new VA to the kernel.
The old VA is never dereferenced in the new process, we just need its value.

I suspected that the void* which must not be dereferenced might make people
uncomfortable.  I have an older version of my code which adds a uint64_t
field to RAMBlock for recording and migrating the old VA.  The saving and
loading code is slightly less elegant, but no big deal.  Would you prefer
that?

- Steve

