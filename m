Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC95CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4eFb-0007Ni-Fs; Fri, 03 Oct 2025 07:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v4eFN-0007MY-EB
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:46:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v4eFC-0008T9-Jm
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:46:46 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5939TJkq597345; Fri, 3 Oct 2025 04:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RFeY78oNGWkSmis3w+Q6NXCo8tvR3OCbGiHJpJ5xi
 EA=; b=aEcKP8Al11kneVEuX97xIrpJAlN4ap2QgqX2vlWTO5UBOWj3CkDksI3V3
 gp/Oq0PSTLXNqIH2g21kPd72uo8sIfrSqoIwNtJxFJnsgX1O9irzby2VKg8O7/oZ
 hHDWd1qQ3Apqu7HYB092gsRzcbM/v7hl3VLego17S7oSUELeHZE40cbl3uoR3xwY
 Uk+s0lnepfTiUvn08taKu2MjcT5rYfYYNXJoPN2kFi1nC49A0wgP8yc3P8dPsrDD
 VpGFA5T+RGPoUL6NJWfuyEP6pJEHjVEB/69jrHPr8lCHmN9KOPdhj7obISIfDJeJ
 o3xwTFW0KNaKPRode7ZqxDq5GCMkw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020097.outbound.protection.outlook.com [52.101.201.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49hn34awr6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 04:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf1xwPEMcXyYUgvXFYq1vY2DFPNkwmpUAobVGQVKkBY5kdQNchxkGG3jC5oz9oj2k0OHBrvWyVxAd1PrgDGcnUqzfsD5GbhPIlhdJzeVadkjM4duYTmkWmk5MJbzbfDkMeubBRlY2tlB7f3+MSXSFlcze6sV9G/DI7oAHPA9xsuEEIVAtIpioeFKy7XXFrsGKv4zp5VmBvMHDDmp993YoaDvnWzqKBEFuBzt7Lpc1soRmYw0dn/+Gh19BGHnnVWvxvyFOHXZWp1ASVlHo0ap1EsO0OK1jQEVFrb5lpn9vSirs9D45VWJkFRERsNcavK54eDatbP4JIC+dkpL5Ja/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFeY78oNGWkSmis3w+Q6NXCo8tvR3OCbGiHJpJ5xiEA=;
 b=DHpd940b8viIuQoD3PHiqqoP7WsEe4iLGOfD3TwrlDzVUZRHd7IRxgFfIead7IeveheE0UXp48/ZQ14f84xueRMiL38F9kjW3sLlppTYxJ4ubADS+YLSnIU1Y1b/p/E5cAXraHFt7r8udupaaHdIFpgeZhTA6fORX4msCSLowdNRwJMqVEk2jmcx4UcmwufOFI35QDiImvRzWYbEc62mQcwOyJzgdktAQPOahT5tUiZnz6bsGeDr38pSVz39BQ/NS7/fBPcMegkcq1l1cc9XYVk8m/awT5kkUmphMd053zlpTmEwOXDRJOEelDePc+IjFLyEE5hTLhwrCOzXxSuSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFeY78oNGWkSmis3w+Q6NXCo8tvR3OCbGiHJpJ5xiEA=;
 b=VxLzCjVNT56t1tIiflSc6+X160Q8LCE88BiGS7T6En7Y5Ys6gn8w7GpJcBV6l7L84FaNaNsgTVO+2ZDziDozDqAkxhAedw2rEaDEvIzUYo2Ddji8++rdGmECXEg/2MPPS1Qa9Hfxtm1OJo8mzKRMI35gsekKZjTpqJg+cKuUrN27Gjf3NU94XGzTjbTAlplGMW46+0tGPiP8TdzDzU4W98/w/nq7gkUJp7liut5xgudgzX4urVi5sSdFRBjCx4L5bMDMkSYK0rsFP4Rp3SJhGCr8zl65QYUCywI21hJ2fS2pUPXOHScPEfCQ0HZrK69de7UHl/jzdnG4Yh2eft+qXg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6554.namprd02.prod.outlook.com (2603:10b6:610:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 11:46:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.013; Fri, 3 Oct 2025
 11:46:17 +0000
Message-ID: <8f358e5b-2a31-4ad8-8861-3f762d2b42e5@nutanix.com>
Date: Fri, 3 Oct 2025 12:46:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] isapc: remove support for -cpu host and -cpu max
To: Igor Mammedov <imammedo@redhat.com>
Cc: philmd@linaro.org, berrange@redhat.com, jdenemar@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20251002151316.0a546cd2@fedora>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251002151316.0a546cd2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:208:134::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: b04ae8e3-ee20-4521-feb8-08de02727688
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzNaZFU1Z1RDRGFhNEJPQUozcm9PN0ZtalZmcnlCSVFlNE9STlNDb1FSVEdu?=
 =?utf-8?B?OG41Wjd0U01mUEVmZ1dST1ZLL2pEUnc3NWZYZlJxNUI2ZzBSc3BxczZPbGdD?=
 =?utf-8?B?VkVqMU1OUjZMcDJTQ3VWM3UzVXpHQjlHaktiNytLSGFkZ3NkcTVkckEzdy9S?=
 =?utf-8?B?Nk5BbG8xS0lzMFkvWVFiNTFLb1F0V3htaVhJVmluMTlXQ1BjeHZBZ2cvaFVm?=
 =?utf-8?B?RGh2NnZvVkhIZHA1YjRLYjB0OTFuQ0NqOEpIcU9LODU4QjVQN0RuQkpRTnBt?=
 =?utf-8?B?ZHZMSXk3bEd0UGlqVEl2WEFpTG5lWmxKSDZ2dElOYzZDb090MmxuMldrNi83?=
 =?utf-8?B?bHQxeTJ3ckhTSFZPVVhFK0Vtd1NCY01jMHdWeWx5RWxQUjFxbWdYTTNKK2c5?=
 =?utf-8?B?Vlp1aTcrTUFqb1M4MnR2clVWUmp3Z0NaOFFsYVRwcWpGUzMrUmpSYndVaDlW?=
 =?utf-8?B?Vk8vYk0xaG92K2YzT1hGM3RxZ1pGVjEvTnN5amxzanJzbFM5UHVOeU0yN0Mz?=
 =?utf-8?B?MmIvd1hxWVhVR052WHdEVFdQc3pGczZzcHZkRUk2UUM0c2ZBcElsWmE1NTAr?=
 =?utf-8?B?V3lKNFppOWtsYzBKb21DdDJOeXRsb2dwbi9XYnJkYkJwUWlKc1daMDVqeFJI?=
 =?utf-8?B?WkgyOHNQQTFCby84c2dudVdDRjFZTHdqUER3NHZnQVRRU3k0bGZVTVVYdUFt?=
 =?utf-8?B?SHgvSnNScEg4QTJ3aEoxSW5QT2NLNFluR1pWMmFyeHlFUkJtN0RmdU45czY4?=
 =?utf-8?B?OWFZYnlQRTF5dldrazlXRkFwWWdFdUNnWEk1OGM1V3p4QlVtSHFiSEkraUhX?=
 =?utf-8?B?Uy81bERLQ3hiZm1kUkVpcGt5N1ZzOHErbWl6WCtJVDFkS2loamo4aWpNMzls?=
 =?utf-8?B?NllNMk5vN1NtM1Z4N1FPd2hiOHMxK016cWh5TEJpREI3RDRsYmthdENkVFQx?=
 =?utf-8?B?c21Sb2pBbENuU250UHlUcUxDNDhrclFMQm9jRE1tZzhodGJndHU2YVJMRWZ5?=
 =?utf-8?B?MEJCSHhsYzdjN3IvWnRxR0xPNkxFUmdEUXF4dUg5c0FjcVZJVWN3YjZ0SHVB?=
 =?utf-8?B?Tm5XaGdJK0ZtUUZVRnBwTkNQbENqYldpaWZDc2U1Q1dOdlh0b3VhTWlxOXk1?=
 =?utf-8?B?eGhhZ3NucUQ5Rjg1dlp5VmgzS2ptMVMwZEw0WXpqYjlRaGNsdVY2bHpUajJq?=
 =?utf-8?B?enlLVnNralp4NktRRVhxUlhBR0ZFRnJUbUNWbFE4SFJnSmhDZXl1L3k2Uk9j?=
 =?utf-8?B?MGdqTUxBeCtSYkJTQWRHNG5DWXc4NDJHb0RqbmZHdTg3bGF4b1c0L09ReVpx?=
 =?utf-8?B?TVhDYkVOZWtDQ1lzcDBTVkpDczREMjB3SGVnVVJWaFZvdnNIOVN3ZmJ4NHRX?=
 =?utf-8?B?UUEzM01Ed3ZUY2JwaDRSMzJudFptb29QU2hta0FqaE11VmFBcElIdG0ySTlr?=
 =?utf-8?B?MmtPSHRqNkMwTmJUUXgydVhmdFlicDV3QUJ0dDc0RWJXL29YbkdsdlNjdll3?=
 =?utf-8?B?UzRSVCtpTU5XZzRobUJMekwraldXUXJaT2JRSFFCNEZZOVB1UTV1Q3RTUU11?=
 =?utf-8?B?aEduVXdubWRNcDJ6ZnJJV3NFanpYcTRsS3RBcHhwc0JhMko0bEVGenh5MjNn?=
 =?utf-8?B?elA1bG1JTVlnTjVIZE8zZzZwWjFySWNlR1FGMWVIL21lVnN5eko0bC9iZlhv?=
 =?utf-8?B?bStTWERLQjlXRkl5dE5TVnZRYTE1aFNoUlZhNkhNMThSZDM4YXJzOWFoanNr?=
 =?utf-8?B?RkRiOEI4UzVkM2NacUhnRkRYM1V0NWozalBhb2xKeTdRTThMZkVNdm1jZFVJ?=
 =?utf-8?B?Z28vaWQ4a0d0MnlDOUlwazRCSmc1TzhvVmtZZk16MnA4bGZFVEtOYm4xQ21h?=
 =?utf-8?B?d3A4U2FkSE03RDlQTmlkbEhEYytKa05PTlErV3dDZEJPOVp3ckJyZVJkdkpx?=
 =?utf-8?Q?ZdC5EFZNBCQZSEHj+KP+oCj0eGO4M5Rg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODBtVjRvbERucDdJSkJ1VzhXK3o5d2xkQ2NiMW5pdTdwR3hDNytkZlhXM3dW?=
 =?utf-8?B?bzFGSHdKRWpNMjNkdWc2dW1jNjdBcWRlS3VJY09yU1NlQVZUVjNxQWh5dHhu?=
 =?utf-8?B?bXZjcGF0YzNCc2dxc0tNWEhiNExhdS9hTEwrZDl4amNBV0ZWbVBSM01PMFBr?=
 =?utf-8?B?TzZybjBRaFd2alNVTmNzYS91RGthUFphUDJzTkIyTFZsR3hSSHNrVFlUeURv?=
 =?utf-8?B?dWN0ang1YmV5bWU5NW1oMjF3MUkvcEhXc2ZBeWhJdDVqaE4xNTlSNVhJRWhk?=
 =?utf-8?B?V0dwelk2M3Y4WmZQSzZKSzVwWFYxY0IvcEpYQW92MTlQMXVTdW43WmtnVVNv?=
 =?utf-8?B?dDZ0OXZES0R6bXk1UmQxU2Y3aFZHSHpwODMreDltYmtGMmpsSjNSdkFPMW41?=
 =?utf-8?B?WHU0bnpsMVNHT29PUFc1NktUcXpLZm0rc0gvTFZPeTVVZys0dTVKSEN2VCtt?=
 =?utf-8?B?aUt5QUNyRDUwRTdyRjJraDZBdlUrazd6V3kyN3FET0I3Y202WWlFc3hoTjYr?=
 =?utf-8?B?NXN3SjJVc0JuWTNzc292M1BxaDBqVHc5YnU3aTI5b215d2lFcDhWOWxoM2Vm?=
 =?utf-8?B?bWF4enpCWVl6dTZhbE9tVWQwZVNvckVuQktiVCtxalF6Q21sWUR4NjZ3ZXhl?=
 =?utf-8?B?d2dsQ2tiTnd0dWxZeCtzZktIQWxDV2d5SW8zaXFSb1c0cFZBV2NhcVlxazJ5?=
 =?utf-8?B?TFBlajY1clpFY09VWFlwWjRNYkxTUFhQRE1ramYzK082eG9hYkh4Z2FDdGNQ?=
 =?utf-8?B?R0Vpd2hGazIvQVVkTTN0SU8ra1VoZ1R2SmdpaGx5VXZvMG0vbTkyZzJoQzJD?=
 =?utf-8?B?b2EyNFdPNVRhTVVtUmk2S3hjZVlteFQrM2Vzbk02OFpQY05nNmhBaE9mYW1z?=
 =?utf-8?B?L2x6d1orUE1mRzlnOHVnKytZaU5BV1VwSG8zZzhNOW96S0lYQ2ZjMlVjaWR2?=
 =?utf-8?B?QmZBZ0FZZng0U2NoSVpmK3c3eUU3NnVFbWhGUm9DZG5kSGNJU20wUHdhNjJ1?=
 =?utf-8?B?RCtpSm1RcVEzWFBycTlEZ3lSQkQrTDdGVjZmZ0NaTXVRdWlPR1pwZWVuTy9I?=
 =?utf-8?B?Y3JoNFpSYmNoWWZlNGZsa0ZJNEkxeVREYWdqVUNLcWJmZU1DMnpBUTFVNWY2?=
 =?utf-8?B?cXFCT2N4MkcrakRTcWxEdmcvcmpxc1oydkt2Qm9WQW9ONHhlN1NLUkI2RkZp?=
 =?utf-8?B?TGN1RW1aSEpZNENPZFh2RXB5OXUyZi9LVEJaRHlsOUZBZmRWUXpFV2tJTkRU?=
 =?utf-8?B?Q3o5ZG1XWWs2ZW1URTFQUVU5N0kwSnBkRFBFc0puNXJMSzU4S1dGWnpRaTNi?=
 =?utf-8?B?elhkcFQ5NXI2cVJBZlg5ZTFmWmZPd3F6QjlWajV1S1VSMHlKemxYelArNklM?=
 =?utf-8?B?ME9uN3F3OHVXY1NLT0ZlT1h4R0NEL0RrdldJM3I4YW4yeTJ4UWR5eVlGcThR?=
 =?utf-8?B?dnlkK1R1OG9UbXVaMG1MKzBTSUh5OFh5TitIU0k5WWZYL0dKV1lVMnFKZ05i?=
 =?utf-8?B?eXp5OFRpZnMvRGhoZGt5Y3crbnFuWmw5dURsMWVOd2w2SFBoOWR1aDlxYmp2?=
 =?utf-8?B?RW5CRVZZbEp1WDFoZ1pDS1NkV3AxbkdzVnFkaDVXeDlteEVtbEVLenkyWmlQ?=
 =?utf-8?B?azNXbTF4dmp5TG15U0crU1NIRytIejR4RFJjQnVsaVV3cWpHWnQyMDJBVE1K?=
 =?utf-8?B?ZGphd2VESmZEczNrWnVqV1plbzJrZWc4MHlSYXprZENYalcwcitFVm5HSCth?=
 =?utf-8?B?ci8rMlRFVnlBY1QvQno0UjRtQTAwQ2pIZkNWdmZmeTFEVWp3MkNSekxud0wr?=
 =?utf-8?B?NFI3NTQ2dzgzQXdtVHp3amwya3g1VFYzbDNJbEhmUnJBbUhmUlBDeUtSdEp3?=
 =?utf-8?B?ZXg2YnRZRXJqc1cwUFFqZnZXYWhYVmFlOGF4M05CRER2ekZjWDZtYUVWTWt3?=
 =?utf-8?B?aWs3Vk1HZGNVWDFSaEI5SDNBbUVCUm5nWVZZbWc3bFlCR2xUbE8waVhDR2xM?=
 =?utf-8?B?dHhMQUgvWWpWenZrcXFNUUpndTRZSmUzamVIQ3VhZ0hkdmVmQzFxN0F2TmJ2?=
 =?utf-8?B?Mk5wcGk4T0Nuc1QrVXQ4YlZURE5BK1pKSEJET3ZIUWFsVkVLalBQRW5rcHRD?=
 =?utf-8?B?WnpTa2dRdHFrMmdocGx2VUY3d3ZLUTZTaTBxc0hNRkNLRTZnbEd0N3E2SGQx?=
 =?utf-8?B?VEE2MUp0Z1dYS3FxZTBjY0ZqTGx0N3hwdmVST0tYOXpWNGhYVllsWWNoRDF6?=
 =?utf-8?B?QkVXNEI2WU5jVU8zakVKczRZTHJnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04ae8e3-ee20-4521-feb8-08de02727688
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:46:17.3408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbXMDeyOcOGcLBMUy/Cefi0rvz2auz00HMr1R6bWWC5F5YBNG6MBIspJemR7lB6HJxzSK1p/7i81bSM+7A3yBdSgCm4Uq7c5XXv4e919qv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6554
X-Proofpoint-ORIG-GUID: cVuWzx8uM4m_vs4xedJV6HlOeHLX7VuA
X-Proofpoint-GUID: cVuWzx8uM4m_vs4xedJV6HlOeHLX7VuA
X-Authority-Analysis: v=2.4 cv=QNhlhwLL c=1 sm=1 tr=0 ts=68dfb78f cx=c_pps
 a=dY44fPPHiqsl/jBMM45sDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=kUBdiErUbZDux5nBr3cA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA5NSBTYWx0ZWRfXx2LJ/XQ/5H+J
 Ri+zec9sNF+Z8eGy10cDHS6w6Isde8d70+WuISpi/4lkGDl75w5Msb2mDbUPlpLBQywZijl83vx
 dLMPHdMqK9ymgUMxVnrnnwWlTbiFiVcB/9Ncz8E/UtRiZzejp2z4vQAljSWMjiM+0PJEwJQ+N5E
 3Z2Koq85zw3ozkTtnAXM176QnhWoYJ1zU9+AXmfOZ+lp9O5UvJzCyTIAAmWtMxWnrLF1DBmSq/p
 +ycOtEZmYsCScSqHQDnx8wC4c8Y2RlaTzjet31Z0LgxACLmfamL1Kc9TXf71Jz20vKSoWMkL18R
 tQjT8lkIB2o7bm/LuAh7i2hBKkyv/ztmUww7ZyNirDL48TARFd+sWK4z4pI98AXxs+BnnzHJccb
 noYlxcyK3Ry5HBMDR2j7vTy8y+oK4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 02/10/2025 14:13, Igor Mammedov wrote:

> On Thu, 25 Sep 2025 17:03:18 +0100
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>> This series removes support for -cpu host and -cpu max from the isapc
>> machine as suggested by Igor, and then updates the "Backwards compatibility"
>> section of the documentation to reflect both this and the recently
>> introduced 32-bit x86 CPU restriction.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> so, taking in account discussion in this thread.
> 
> I'd 1st post only deprecation, and once it is run out
> this patch.

Regarding deprecation, do I understand correctly that you are happy with 
the current restriction to 32-bit x86 CPUs added for 10.2, and it's just 
the -cpu host/-cpu max you want to go through the deprecation process?

> With that:
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks!


ATB,

Mark.


