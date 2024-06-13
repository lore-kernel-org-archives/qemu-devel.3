Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4BEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlD8-0006VU-En; Thu, 13 Jun 2024 10:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHlD1-0006Mt-LG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:13:51 -0400
Received: from mail-sn1nam02on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::62c]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHlCy-0002NQ-Rz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6yy/kn/pl5v+rNlAgKCRSDgR1PB+ctUbAqJx1L6pc8kenaYnM4q67SL376IbHCFA/UkOFTE6rp7lzyc/rNMXmEk+6fpO+HMihLusdIlEZdsLhLXXHNP5177gPxt1ao+riH7EZKhX6SQeP4Ix8476dQqeRalFQ1wAGz8UBI/MybOOHo9TY1sqhwOxrCmw3CtaHAk8H0DJGV4HhEFB8YkSOnCpOci1/YDEn/xLI3DxIxuDd7pBd19TyTCiD73M/2tmymrqSrXrGrVV6COgcQZ2vEhXPt/L6URyzYHZrkWmLZ0UcvmOcksHG0012RMioNS1JMOMiPy82wdWE5kYLcDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3SvNk/BUCWuKebjm4hr6MKuhq1m6aO190nm/Q3gLjQ=;
 b=mlHdMbmw8KtjDdM1HJkfER8CLYFT2Wu1Jxk8/Cbt1SuRCoIexcuYs5tSU85tqm+X7WFEbwos5G0TMDvnG5FQToLcQyZnabJLHGSUuDQ5yhLV5wz9KHzz0uWSFsRpftdcFY+ijbaEwaUtDjgujIgMgefJTit/J/bs0AWqTzjP49GlzwJLoeqn+6sqCMI5mhE21I8zl7iQiYHpTbSPRt2se/lZxTJtGJfKss3x0ciUJt0IOc/S2CAaw/Byh2D20rJDLJJTRzrw1ZAqYafMmAapXbrsZDMmAfWDRL+6d2ycAVc4BwMBTuKsNahP+drOAppOevIg+ILvkXlBj9EO5lgGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3SvNk/BUCWuKebjm4hr6MKuhq1m6aO190nm/Q3gLjQ=;
 b=hGGOWRuzSpiEjDIhfsJbMBGSHyStqojC4dmtQlDAsvyn4m7Qslf+56Ynls9/ELXyqQfXJUEEYoaQvlqtMX4axfnAaCErPYAK5nTDExiRNoksq6RZH2LLg4Pw6omFKHYsexWoTCLb+D031HBG2Ou+CXyBPVVBgTiD2czGkpg9kLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:13:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:13:39 +0000
Message-ID: <b8f4224b-2062-43d1-bd5b-dac2f48616f8@amd.com>
Date: Thu, 13 Jun 2024 09:13:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] i386/cpu: Add support for EPYC-Turin model
To: Zhao Liu <zhao1.liu@intel.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1718218999.git.babu.moger@amd.com>
 <a4d4eaafb69d855a5c5d7dec98be68b3e948cefb.1718218999.git.babu.moger@amd.com>
 <Zmqc8SjlgRlpgoBw@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Zmqc8SjlgRlpgoBw@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 268247cc-58b0-41fc-ce4e-08dc8bb30598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJaRllCalNsSVNSd2tkcWxyWHMyYWJkNEo5Uk9reWxQRmt6Ym9PMkRQekk3?=
 =?utf-8?B?T1dieUhLSk0vM1J0eVdBMkRoNXEyK2trQjlhSHBYQndUTlpvM24zVVhMNk5t?=
 =?utf-8?B?WDhyVHBJS1FYMlQ4TGFOSXNzcitVaXMyQXB4Kzd3ejRwVWFiRjhDTy9wSFpP?=
 =?utf-8?B?TldXTm5WZzgxOHVyNGJNSGJ5Q1M0MEhGU3gremtsTVJkUWV3RmV3bUs2a2ZN?=
 =?utf-8?B?NkV1Z0toNHBzSHhnL21EYXZJYlhRNnpGaEhkUEE5RFJuNmwwS05jQmpzdWlj?=
 =?utf-8?B?TzdsL1htU0V5ZFBCT1NkaysxQmFsRGkyQ3M5Vkh3bWxkbFBOb09UaDZyRFFr?=
 =?utf-8?B?RnRucnd1VVBvUUE5WGk0aG5Pcy9mMi9PRTNDTVppVEpPVmllOW1xYkRKcS84?=
 =?utf-8?B?c3J2L2RTb1pnUHVoY2R0M2pndk1tRjFLNDUwb2NnMk9mNTM0dmk2SzVNa1pS?=
 =?utf-8?B?dS9iaUdselgrVS9OdjVSYTFMRi9taTlIa0FJdFVJYVIxRmFocWFvNHd4aTlq?=
 =?utf-8?B?ZzFGVUdMM3ljRDBGbk5BUXA5WER3ZjM0RVkvMlAyYmNSQjlUS1o2SmU1c21R?=
 =?utf-8?B?K3NaMTlqRFFjT3lJWnJlNnZqN0s3NHAvTENtK0NSWlNBdnlsemt4SVVYZnE4?=
 =?utf-8?B?SnZkUXhWRXg0MDN4ajBqbjNXM0ZqU21NcjVDM01paDdPWDJ4bDcxWWJJSzBr?=
 =?utf-8?B?S0ZKRko5c1dmSXRXcU5mZTJOaWNFSTlpcDNBZEZ4S2gyUHI4TXdObzZRc2ds?=
 =?utf-8?B?eHNPTC8xZG9XZURZT1hqbEdpWU9OdGF4Y2JzVlhtZVF5NXB5TzVsT0lGTWph?=
 =?utf-8?B?bnIzK0x6OHNRU1hUR1g3Tkd2elF6S0p2Q1ZQancvRnNiLzNTSUx2ZEI3dG5s?=
 =?utf-8?B?NmRDSlIvYkttSHM1eEw2UUhKWEovWG55em9hVVFIVlRLbFBMNkZtRmZVUlJV?=
 =?utf-8?B?cTUvZEJVN0RjSHNqTmhLNEtFVm13TDEyM3RkcHVHai9iZ0FtYlBXZ05hazhW?=
 =?utf-8?B?MlhzR1dpeGZLeVZOVXBXKy9IeFNNVWNyN1ljV1c5Sm1ObW0vZGw1OVJqTTlN?=
 =?utf-8?B?TUpoZWZFK2hGblJJbW9aQmQ1YnZFdU5DUkdiOG9Hc29xbDNFSUk4c1lFN1RP?=
 =?utf-8?B?a0tvMEwzTXZocjQyeWRDUGR3M2cxdnVSeDRPVUNlTFZxZHc3Q0dpcXU4WmV2?=
 =?utf-8?B?VWpCTzVHanhRU09PUVJVbWNuRWtxVmZkS1dzZ0hmNy9wZDZMU1hqM3ZzUVpo?=
 =?utf-8?B?eDFMaVo3S2VuOFFYSmVkZDJsWFVTMkRKTFBwUmlIN3ZSY0J2Mk4vNnRWVXpv?=
 =?utf-8?B?WjVvYmhBWHMzT3pUU05XQnZFUHVzaDZkRXFwek0weGMwK294bElvZ2pTUWxG?=
 =?utf-8?B?OG1xNTN1SStabTdCVkdkMW55V1hLM1BGc3hQVW44Z1N4NmpXY1VuYTZsRUNj?=
 =?utf-8?B?VndmcHRnaTNJSkRRenhkbEZiUkp0dmYzUmk1cU14MHhYb00vYnVUNTlyQzg1?=
 =?utf-8?B?NVYzeElZZnhZaHhROXFoOEc5bTd1dTBnSlJlSEtVMFNvTkVXemRUZVhCTnFl?=
 =?utf-8?B?d0hIZ21qSDNvakpLN01pNTdmVndSVlhEZm9jNEx1WXlySGM4WmJodU14RFBj?=
 =?utf-8?B?Q0hQSzlWZy94TURjYnAycnErb3F2Z0lSSzExdGJMVmlxK202OXVpTUZ1RFpu?=
 =?utf-8?B?cE9sVEo2S2Zwb2l4bWgxaXd2NjJaS0Z2OThyVWpBeWEraGlNVEM5TFJvNms0?=
 =?utf-8?Q?hiZVV2pqO8eN/Va9C9LqjAtrfWrgre+Jq/pCAos?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(1800799019)(366011)(376009); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVZNWhTTmVHU0Y5bWJEZjVVcXQzckh0NlJiWE14WGMxVmRGai9wckk3QVFn?=
 =?utf-8?B?dzB3WjlvSjJlVGw5V0VnL29icjVnSFYyT2x6OUx0dWptUTVPZ2hva1Zicm1r?=
 =?utf-8?B?RU9IRUlXRDEvMTdJa0FwVDNkblBVaEZlQVVmdU5EY2V4ZE5jSjBjOXdXZWxy?=
 =?utf-8?B?S3d0MG9TRmRFb0ZVUmdUc1pRQUc0cDc2VzV5UEc2TEhTbXVZRldsMk5EWXhl?=
 =?utf-8?B?TEV3NE93V3h6V3VzK0NnVjNlRGNvZVQ5Z0RiVzI3UGZaaWM0WHF4ZWRnZG5O?=
 =?utf-8?B?bTNlZjVZNnN0YndvMStGeCtwR1lzNW4raVlRL1g0UFVTeGp5bkxXSUJja1h6?=
 =?utf-8?B?bW5UR3ZyVjRoSmJYdmU5SlA4TWE2M2lJOHZmSkQwbU9NR3JsL3NPYWJYV1g5?=
 =?utf-8?B?SlBDNGYyZlBieDBWVnJUa0dxSzU2MFU2elZ3UUIxTFhFMUR2bkozRTlSd3g5?=
 =?utf-8?B?a0pvZzVZS2xKYVZ1SWFDK3JDSyt3N25KVmJDUGJZRmJUQ0J0T3BXK2lhZ2Mv?=
 =?utf-8?B?K1JQQzZzWWF5RGFjOEdlOEdOcG1oS2J5bHpidlZoZzFkdzB1dUVONXFsbHE4?=
 =?utf-8?B?N0s3Q3k1Z0hsc25Cdy9Wc3Qzck9mQXpNa01DVUdvWmo4YjNLanc4S0ZDdjBF?=
 =?utf-8?B?NFppMThLQ1pGUUZEaFVsTnhNOHNkMmJ4cjJYQnJRZmV3VlFWYnhlNjNrNFV0?=
 =?utf-8?B?TTJKMldLTXdoV3MwUGJrd043bGFiWHIzSFNQa29seEN3bVZvWnRqOE52V0kz?=
 =?utf-8?B?b002VFo2MHpkZTVsVStTSmpYalphUUJTREJUd1NHSWwwWmJUcm9pbDMxUzNp?=
 =?utf-8?B?QUgrOVd4UEYzQXJwU3dsZTAxblI4SlRFQ1Z5akNYQ0d1RkszU0p1TXJSKzQz?=
 =?utf-8?B?bkF0aGIvenZFM3ZJL0pvbDNVb2ZrMElKRmMwbkNjM2RtMFJxd0EzRTJBcGtS?=
 =?utf-8?B?d3FsYjJsam5TcjVQVXVEOVN1cmRKWTZYakNSdXdRQzZrMVFYMjhJSTMrdWZo?=
 =?utf-8?B?VDlqRzd6cCtiRUNaQWJkc1plVEJiRXBUMkd1bkgzUDI3OVU3Z0dFZDhqY05D?=
 =?utf-8?B?VTVqZkFCRVVsMTVmdWZCNDJwVFpuVVl4dDNta2puMGxwS1NPdzhWQTdnWkto?=
 =?utf-8?B?K1FQTWxzUi8vRTJ2ZjBrMHhITVVCK1J5TWpZQXRSOEZwY1YyZjZVczRWbjZM?=
 =?utf-8?B?U2NqUXFyd1A2SVpkWkRZVzY3ZXNma3g0WFl4R3hqVUJqTmw4WVgrNlhpZUxj?=
 =?utf-8?B?SFMyaUs0OVpqbU1iQUNCZjZ1R3ErdS82WVhZamxLM093MzlhM01vcGM3U2Iv?=
 =?utf-8?B?NXlhT1pIR0IzZ1YvWUJyTjdTRnllNGx3ZDd1c1NONitqYkpTWUpRbmdkc2Zl?=
 =?utf-8?B?d2RGQWZkaHQ1WmZ0a0pwUmJrUEZzL2dCajFuR0pQQldwdVY2WmlCNE1KYy9p?=
 =?utf-8?B?eG91QU15TG5URTlhVTJ6ZEJJaVl4Z1BBODJVS3Z1TXpZWmF0QThyR0RyQTNB?=
 =?utf-8?B?WExvb2wvYW1rckFWMUNueE9SZmtWZHRHUzZNVm9DR21qUS8zQWZVSnROY2Zx?=
 =?utf-8?B?amUya3RKbmlRanFGZ3ZPdHNUYU9QZU1MTGVUWjBvV29iVEdsZGxJUDBycW56?=
 =?utf-8?B?cXNlVjlNbE84MGZZd2hOaWRCRU1WWXhSREtETDIzZTZmWWwyUFZReE9Cdkk5?=
 =?utf-8?B?MzZia1B0TURlaUFKRGhCcE1Bbkl1UVFuRDByMzBHRWtJWFpueFJwamsxNEhy?=
 =?utf-8?B?VDRJVVp3UmtZMEsxenpiRkdFbUZNQ25reHVKbUZFZXZMVDZ2cVo0REI2NGtw?=
 =?utf-8?B?YlFsNHFpWmNuU1hpVFBnV1FMUjNnTXdWbHdJQUlTYXpXc2NFWVA5Vkx0SitD?=
 =?utf-8?B?NVJyaWNLcjk3cVJPcGsrNkxtdDFLWmlGUHRLVmFrakh2Q2QrU0c3OG94UEli?=
 =?utf-8?B?QmZXUisvaVNBUFlWeFkvV3JFMDE1OElGcXpiS0lWNUJ5R2RreVNMaktZUUpu?=
 =?utf-8?B?a2VtajFNQWY2VjhLNTMzYmtZNVAwQkQyajFhMDJ0T1RYRXhYVnRwbjJaYVBN?=
 =?utf-8?B?SFJGSXFFRXpScE1QdmR1REhKMUFqRWlydVpQdDgrelpEYkRkRjFVQ2M3OHNH?=
 =?utf-8?Q?KjZk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268247cc-58b0-41fc-ce4e-08dc8bb30598
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:13:39.0093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA9NC0eCnROFKMGaaT/pni3dDJ2KoIrLzula03PS6qk/2eHwfJ7oyE9C8lOgZgK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
Received-SPF: permerror client-ip=2a01:111:f400:7ea9::62c;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/13/24 02:17, Zhao Liu wrote:
> On Wed, Jun 12, 2024 at 02:12:20PM -0500, Babu Moger wrote:
>> Date: Wed, 12 Jun 2024 14:12:20 -0500
>> From: Babu Moger <babu.moger@amd.com>
>> Subject: [PATCH 4/4] i386/cpu: Add support for EPYC-Turin model
>> X-Mailer: git-send-email 2.34.1
>>
>> Adds the support for AMD EPYC zen 5 processors(EPYC-Turin).
> 
> nit s/Adds/Add

Sure.
> 
>> Adds the following new feature bits on top of the feature bits from
> 
> s/Adds/Add/

Sure.

> 
>> the previous generation EPYC models.
>>
>> movdiri            : Move Doubleword as Direct Store Instruction
>> movdir64b          : Move 64 Bytes as Direct Store Instruction
>> avx512-vp2intersect: AVX512 Vector Pair Intersection to a Pair
>>                      of Mask Register
>> avx-vnni           : AVX VNNI Instruction
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  target/i386/cpu.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 131 insertions(+)
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 

-- 
Thanks
Babu Moger

