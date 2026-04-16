Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795CFF8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOio-0005Qr-9Q; Thu, 16 Apr 2026 11:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wDOik-0005QE-9D
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:33:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wDOih-0006LT-53
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:33:33 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GCfB2M1462779; Thu, 16 Apr 2026 08:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8MpTzjRK3Dn4y4RY8p54dstD03slymyEYBz4lyRIg
 es=; b=dAoo7k1fKB9XaW39gEStDO5lqPvcuJLzdasBXHlFYi6gjliviCYBCLjk4
 8X5Jzhn+t6LqdudGF6X1ho7fnI9lae0XRG0o4kWccavEKXqO6X2ploGC77utXw8i
 0AUNIx8NeHTOrQEAgr+TGF9w2w5VKXu68JoOELiiOOOceDrq5TFGUPUT6BHUsb8S
 Hp7nUUeovJhHDXdvXKeOLb5gor11mztghGsrzmE1xyowCDfQeOwNy3sObx5n7shG
 w7BvQmgdc2hr9ZBeY9a9XLX4L0692Adk/8bdg1cD63Oa4436GS/7RNEOpadJbp64
 Nz7cjcBHhtvBK2RsMf1+Z/liVnaHA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022094.outbound.protection.outlook.com [52.101.43.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dh84x9d4d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 08:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/AcRtBPpVEXUDeaV2FbSbnwRYCiPEUsAHOhbjmC8dRAb//mNxT7J0dsbYPUi9gzdfhu9sOYGcdQB7tAXTTvUOM6a/rupLbU8Ll/WqjfzmiVII1SqSq0kElTq9IPu8sxG4aCgQbWE8WZixFjJHP2p3FuPSSWIFYWxYibW0Jodn3vr+ztht493uxxz5bnF90rrYwgLNUoKWL1MZqId4Hdc7jIOimb+Z09H/bU4U6qmeZghvczQo0LgnDQfv+rHRXbyF4hKgFD7BKjRxJ8uuOCGOoPK09t+iKvIKlyQk8J8KdWdkiBcOudmEhtwdRs+ZxR09AvKpYlB+3u/0pD2jFadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MpTzjRK3Dn4y4RY8p54dstD03slymyEYBz4lyRIges=;
 b=AVtkOnArOzIfd98aphTi0mutRMr1kGqNbvY3y2/vRGRQim5cqX1ZEPikvg5bsqHnv0FM3i/qUWJ6MBc2NJCOxc6t6bF4RUaM6XsA7Tc3ckBu63FkVG6RgzXRXSBLcebtSGOI5RXm8fzp5PxPNi00vJ0BSv3FruwHtCAhn3VG9RCI0dhXUM6v12fmbrENDUDVQ4UulY0y6/44Yp/5MBH7XJ/Ea6NZDquE8KLJ6IG67GSGwHbItm87eelTUq8wAJMnhK2VHvb1Q0zXY/I2xretjdF3GfvOqwkaeBLRfTNdCIXqN+KPWFIY8mDJbdcfUho3rpjYqj6esphCVhxfW0IFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MpTzjRK3Dn4y4RY8p54dstD03slymyEYBz4lyRIges=;
 b=JlherYgnIofTMVmnKYikgs6FlhqpRCgUTdhOAyLdsDWXXU1scetOe6ZS2tXEQdflFYXVvilokAyCWkEHTSnAvNs8oFaNCdQJN5s5p3rnbdxqkjDlkEGMswOVOpYlLLN7Fk462j8wcdPGDDBGmjNbo4VfER9XVAqm0zvtx3hiNo4LUN/eB2sOyaEbJDCOy+mhVrfPOTvrX9d1MP5aS5ec4mhkTBKpIlwWFnUZxkCEwvDqi1xcmw+LhPRTUo9ZvWpk8RWwNzR4VR8gZ6pEmHNQ6lgPlDsJTjRYuOunCfbgSI6JpyLzIJW0bAAxr2hNobVpvKN/doDPoHCuKlNL0nTmDg==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by PH0PR02MB8519.namprd02.prod.outlook.com (2603:10b6:510:10c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:33:24 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 15:33:23 +0000
Message-ID: <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
Date: Thu, 16 Apr 2026 16:33:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Content-Language: en-GB
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::23) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|PH0PR02MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 4892d279-3521-41b9-cc10-08de9bcd7eea
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: AoIf5ZQG/mWqEDS/JwphWCs/7MMdDy8pZVWYPEC4AFD+hrZ5nunRutMXcO94nKz0XBFaFDm3TeKrb50Zp5clalKXQj+XPULQ9ADg601V4aEDLRv+x8wn164Q2pQepE1UG/8zUCaoMtF650dB2ibYBgpOZUtH76pIocVkrk12qXnDvGbST//Uk8k53Jgm8H3ejwIvw3J5yS25BPmjtYEDdNtRr9pnbnt5O0n86O6sF5IAf0KY1GaRsdrkS+VpSQAPsw35GSouumHFy8vnD+YA5e796qDokpTL1OFeNMmZpXS22kOt9zr5cJYnhfmfOfkVQRSIbI3xoLmwNEK1K96cmRHPPa0G2GjSfGuXE8f/GOI7zkd8YqPsBeXCYrY/y1nyfInFtAlaFMfJ10H+zWoZzoVqqt3dDo3dOWHUb/EtDS9Q9HBEmm57W+4cpM26T0Ao7ked1/ij0EO/eBy25n9s7KuJGL4EBm73QzkwFYzFLpVP8R+F2F3CgBDbUAsDbIyFBGe8udA7V8vviuEKZwcyWQ2wvTVrCva4k9hT1vXe9FWNs7r3Fi2bgtSOpoAsBGTduALbRHXbd5oIoqGd6MW7PpipcGLShWzkIc2WOXM6MOmS2WY9RyvKhUlMQksnEZ9LeMBZNW17hi5LOSQ2xtRSlR5+TbmtulwI49tbme97CdT7gVuDw3blfy/Rq5BQnvlaSOGkK1iB2b8xC2EQV2LieN5qQx4TstMS1DAaaiKAImw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhVbkRxMG5SK0tqa0pwUWg4SmE2QkhEVDhqSHNHdDQrQmQxNFFmcEJBRlBX?=
 =?utf-8?B?RloxNEQvNnJzRGFqa0dudmxPclV6OUttRVZuQnlDY3V6MFlWZ2RZbEplRFY5?=
 =?utf-8?B?M09idEJydkhyelJOaC9iWWFzbmplRGhmMnd1QnUyODVTaDZ5cEhQQmx2a2Q5?=
 =?utf-8?B?ZUh1ZVVzbzlqYURSL0hGZmo4eWRCVXJzU1ZCcGlLV0pXd1BJc005VXVHOUhI?=
 =?utf-8?B?U0c5dUpiMCs0TVVST0dRRWhQQzJnVm5NOUR5bmxrVFdUR2ZqT0UrSjJtMGp6?=
 =?utf-8?B?cUVHMzZYN25FVTkvYUwwa3lsZXFjMDVtVWRxZ2E2ZXVIOXBPT3BrYzgyaVI2?=
 =?utf-8?B?STFrTDZlQytrWDRyTkFtMUVaWiszN2lUOVFrNkhkTWlOZ25UV0VrT21ydi9h?=
 =?utf-8?B?QkJJc3lIVmhOQ2lkYXM4ajF2VGo4VFJkVHlVbFlycHdZaFdTVWswd05GMmJw?=
 =?utf-8?B?WUlYZ0VvOUgvVWpjajgySkszL1VWUG83dGRpWDNEdnhoK1VGa09NNEFyY0E1?=
 =?utf-8?B?MG1pVEhqM3VMclNUTlhwRzloT2FiQ01Vb0hsOWI0Skg4bERqTFRhSUhONFhy?=
 =?utf-8?B?UWIxQWFCSW5MUHJJNEdMMGdNQkwzT25icmxFeFFpN08wcmQrMUdRN3krVG9t?=
 =?utf-8?B?UmdVNHVObm41MStkZkp4OXU2VVpydkxpY2NjRG5Qa1hFNlR5dTFFU1JYZ3k0?=
 =?utf-8?B?Q1ovN3lvSDNmWWNzazFxelBSVUtvSzJrRjM4NlhPM2dpempOaCs4QjBNK3ZK?=
 =?utf-8?B?QVpOd3hueE5RL29TMi95RXZoaUc2WDFTajJBaXNHYW50WnJQZndhVi9ONnJl?=
 =?utf-8?B?TjdCSjF6a0JDckNRaXBqcHl3cjNJSTQ4clBqbytMWURlNGZKcDUyUE5tR3Bu?=
 =?utf-8?B?ZlY5cGdvdEV1dkE5SnRORmx1dmJsMW9LOWplcjBMSEZxWTFRYnNJVkdYT0Fm?=
 =?utf-8?B?TEFGZllqM05SNmpFNnlFNWp5cWVYVHdNbGNIM2hqOEZNbVNubGlwQ0R4ejky?=
 =?utf-8?B?RDhhSlN1dUt4OURYQjc2Vi9JVDdQamxxMW5yVkVpQXB4QlV0R1p3clJRM2E3?=
 =?utf-8?B?UVN4VGZESUlwK2s0MWxBOG9sRVRwTDE4VldrdW55VDRFMUx5RGFsTVY1eHQ2?=
 =?utf-8?B?bys4RjMwdHRNRXVoWWkwNTFzRjE4bS9nZjYrVlJBRWxxYVhkZlVhVXpyT3hl?=
 =?utf-8?B?K2MwWjVYK01SUHpYUi90Z20xcjZLK0FPRDJJNkh5KzBHMUNRVFFCTUJBRWlN?=
 =?utf-8?B?M3NTUnUxRkhMdkJCVEM2cWEvSUZyMDRQbFBYQ3NQRTZlVExkK1BodDJNSVZu?=
 =?utf-8?B?SXVTc2poU29RODdtWG03Wk9SVDBzeU1XWm1uSkJ2L2gwNTE1cWp1OTdjQUxy?=
 =?utf-8?B?eFVKNUtrVGJqYzg2a1lmKzgzVVViYnU5NkkyUVRiN2g2cTltZXNMV3ZIUDNu?=
 =?utf-8?B?WDF3Z3hHd3QrUm1EaG5hZW52UGE3elBEdC9aTjU1QTV2SkRMUDQxVi9xdlAw?=
 =?utf-8?B?Mm9hcG5hdm15clgrY3g2dk5qb1cwV3NjWk1sYW8vQXJmdUw0QWZUK1BTNVlk?=
 =?utf-8?B?cVVoS0lYWHFpZWtJMDZTd1g3N1lmMUdyZVIxamhxOEk4WWJGRUk4aC84Q2tZ?=
 =?utf-8?B?UG9xTUtMbXpUWXlvckJxcWkzdEdMN1NoRkhpY1FXOGFXbDlocis2OU51ZDBS?=
 =?utf-8?B?dHVOZitLVHVTbHFiYzFSb1c1WkdDemgvRFFWMjdicmNHU0JxNEpsRzZxOFRP?=
 =?utf-8?B?ejdtRHRlUG8zMVlPQW8yWWNhbE5WV2s0UGphSDFhR3hTd2g0SzQ1VmZhZFVG?=
 =?utf-8?B?UTBHc1ZlU3JpNjJVMmR3eDl1L2crRWtvQ2lESUdiT3Y3R2NlMXMrMTFNb3A0?=
 =?utf-8?B?amowdGN5alpPTmo1Zy9LcVk3NVZtU2IxdXBFaGl0bTBNUXdiRHNWc0hHeHNC?=
 =?utf-8?B?MkpnRFc1b3R6VzVyUFBBM2F1T2RvemtrTlNRaFZNdHJRZG5NVTFGeFNLeFFj?=
 =?utf-8?B?YVc5bEZHd1NIV2p0NlR2dDhmK0RTNEliZTFvODdhcXBZWHZLNDZaQTNib2E3?=
 =?utf-8?B?RElQdVh2THM0WVlyaFh6Q2N4aG9mQUcxZUFOY3A2RlIyOEJ2UmYyc2Y0TjFP?=
 =?utf-8?B?U29ZNWVqbUJveERhR1Izd0MyZ2EzY2JMYlh0NFU1bktxVlk1TTJIbDdDTkdD?=
 =?utf-8?B?eW0vMTlWakRjSVdyZHVDRXZoYjZYZUwrY2dQbzBaMnhmWnMzMEREZjV1Yy9s?=
 =?utf-8?B?b1c4aE5WTjdkVnQ0Q2lyNzhmNFRYVURRcFJUNmhpNU5OTUt1K3JPdHdyTmlN?=
 =?utf-8?B?eFZEZUdvaEF2Q1IrelppZm55SU5KV0FCMk9RcUNEalVpbEpIOFgvSG1Qb1ZF?=
 =?utf-8?Q?51tRhXzGi87UUWP8=3D?=
X-Exchange-RoutingPolicyChecked: IhhsZk1KW79RyVgp9K1SR/S3vmHIVhvXr/ozF0gzdMB9RjnxQu1/mHCLez3tk295kTSxNuog645STHYXf4xIDI3D4TFD/Fs9RkdhxLCbDhBqYjWdhJVaaZmgaYugTJzbFiq2ni1T89npEwsMaopkeMLgvEXOYrw6dE8N8X956YY5PERq9qhNkuKim3vsIBN8329b/YLTd+UwbiyBcFAtqEGdtv/ZmmI+EuSRnTzdFyFndyD2cqo8DusTKdtIF1vVjWvZl6uFSJ8kfvQy3i4L4ZpDsg7GhDws9R5nR1QimLXriltaGQdOwQqX6XNbOcoXH78MumBqL6iSth0vp/ftew==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4892d279-3521-41b9-cc10-08de9bcd7eea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:33:23.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYgnQKkLvP3ztS1xM2aSdwsBZK9kRqwy6jFmK9K7g2ZcmbCYNvbWE+XCmrfzZ4hvn1ZIZgBtUglUZtDbQiGzpwT5AwRCqXIP9hegV4yweBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8519
X-Proofpoint-GUID: k8ym-_178J0me6XcGZdyItR398wR0M4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0OCBTYWx0ZWRfX7OjcT5ZYeJp9
 DNactqK6SjklRhg60v/7nbs1iSkt6Om3kLCc4VGk6dL9pK5fyCJEasTKy++bJFpW2CWPjukeFuk
 mIBsaZFrs9VvhUzk6ET2oeS99Kbl3gONYqpA4YpkdV1PeAtEh7NwdkvswIFPKCjYlPveovoyokE
 15oxRUB7Yc8EpSpeyhXDaLIKjlOTbvsTT9ltyVRVfZRwT71a1L5zbyBnnFoeOqh48Q4nMQmp5xg
 RnteRUFKQicQ1EW+TK524EKvxD5czvB9OPxnNfjOMjIoh9pRhLyNIXHXnjtptOcbnzRs4INGD3u
 1IzPrii55qFopJWwszOxLKZWAiAgsCprgewRnjTeIiZBoIApWjL8Orwhj7NfA21QuDlz8+KtDB6
 Y/+gx71+IaJ3NMHwsxKVUxreRFEsPw0hU4PbKwjiHdU6VVvqUl+RvibQHMt6NQutMV313pyTW8n
 FqEUgifxp7feLtS/uFw==
X-Authority-Analysis: v=2.4 cv=a9QAM0SF c=1 sm=1 tr=0 ts=69e10146 cx=c_pps
 a=13WRnYNq68uQF2pe1ZmaJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=gJ3dnZEFHyF1o0uRx_8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k8ym-_178J0me6XcGZdyItR398wR0M4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=flosch@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Paolo, thank you for your reply!

On 2026-04-16 13:47, Paolo Bonzini wrote:
> As discussed on IRC, there are multiple sources of writes and each of 
> them needs to be tracked, and we can say that any write potentially 
> makes the page nonzero.
> 
> But as far as QEMU is concerned you could indeed add a fourth dirty 
> memory bitmap, DIRTY_MEMORY_NONZERO, and turn it off after the first 
> call to the hypercall (hopefully Windows only calls it once)?

I'm not sure we can rely on that. I'd have to double-check. Crucially, 
I'm pretty sure some Windows versions may call this more than once, and 
which of those results it then uses is the big question: if it's always 
the first one, we could stop there, return "nothing" as answer for 
further ones, and be good. If it's not the first one... that's a 
problem, because I don't think we want to do this kind of tracking for 
the whole lifetime of the guest?


> As an alternative to tracking dirty pages in KVM, it would be possible 
> to ask KVM to build a bitmap of pages that were mapped, even at high 
> granularity (e.g. with 32MB you'd fit the bitmap for 1TB of memory in a 
> single page!).  QEMU could use dirty page tracking, and build a 
> combination (NOR) of the bitmap from KVM and QEMU's dirty page bitmap.
> 
> QEMU could also do the same high-granularity tracking, but that leaves 
> out other sources of writes like VFIO or vhost, both of which probably 
> matter to Nutanix :) and which would be stuck with 4k-granularity dirty 
> page tracking.

Are you thinking of creating a new KVM ioctl that would do that for us? 
That's possible, but... isn't good old mincore enough in this case, 
since qemu knows the host-virtual addresses of the guest memory? At the 
cost of 8 times as much memory for the (temporary) data structure, since 
it's a byte per page.

One thing I was wondering about was races. Unless we pause the guest 
while we're scanning the tables, the guest could touch pages as we scan. 
But: at the point the hypercall is invoked by the guest, the guest OS is 
up by definition. So at this point, the guest OS must be aware of any 
memory that is put to use, correct? Even including vfio/vhost stuff, 
since the buffers used to write data into the guest would have been set 
aside for that purpose by the guest. So even if we overestimate and 
announce some pages as pre-zeroed, that shouldn't matter if the guest OS 
already handed them out for some usage (and pre-zeroed them in the 
meantime). What we really care about is not announcing any pages as 
pre-zeroed that are in fact dirty, *and* that the guest OS does not 
realise were ever dirtied.

... Famous last words and I'm not 100% sure, I appreciate any thoughts 
on this.

Cheers,
Florian

