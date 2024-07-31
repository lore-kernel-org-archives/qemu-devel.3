Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D2C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9tZ-0002xT-P4; Wed, 31 Jul 2024 10:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZ9tW-0002sx-Aw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:01:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZ9tR-00030C-9V
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:01:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VACwlU020696;
 Wed, 31 Jul 2024 07:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=odvU2XBEAYgmSV9KJ+OGiizUYiEff3Pibx7mnQgZk
 yA=; b=YmYUw8U179OSOH0TR2hbpccrQVtQEhGtFOfijIffgLFzd0VSDM6CifStn
 uD1fG1vFVDd5Vv/xw331vQj851L5ojx3IKxUhkohs2rMQpSEj5aX7/inv5SbU+b2
 h2y5ILBPU8VkEjPAuoIAFH7BqbL+nC9y8/XQgzP2Z30Bb/JWEcm4moR6mhLDe6qa
 e/zNVSY3giLmVWoXvMZX2o80tQONUZUmu4vA0zKRYqIZfFBekXkPgXBnn88gIGbC
 h+srGL58QiZMDsMPABG93H5L7IKt+KG+NLzSJ+U1uCq40ifRaGX1pMr8OKBqFz8s
 PqfGZWd0JzruheExk1HGTE4FZdz/Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40q9ch1p6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 07:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBQPWYy+fNW+O1WMKS6j502NkXTw/fCH/4Z0DZqy3F+ptPga/nm8+7aALHAZ86ceKXrcOBxbEKas4+OM1urnWvbyjawFpshbTbhBAzVexA/YFS8lroAQWuo3Gt6uk5NH0bjUQPF9uJ35hrQVl9/vxcc++8DTaU99O2cNf94cMcSQdVtIAOTMjfPSAXGPSU5MeibRYa1hix3AGYqsKC4/dxTdjWiJ6qAMNQ3pwP7jgeyrFiLph1bxGY85dUmboXEZUZ2YLq1v6IHaos98KvvaIJNT5kopSQ19oesS2mxT3k5Dymp+loqT3fXIuiJbuRBhN3PFVlHJqnvwHKPB1h5kGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odvU2XBEAYgmSV9KJ+OGiizUYiEff3Pibx7mnQgZkyA=;
 b=Ui79sy3UobUdEqlCCQckV4HEs4a+RDGLqYizyOKM8uC+wUcLFab4sAOjhluCVDIh4+vf6fCpJfnSP2d0G39TaK/GuN2MdhUrfqZvEa99wTiLkSHdoY2JZTOl7TrW55HhKu0ZYuZ90Wm5J/8Fe2JvMqmOYv1f7FpFunMLKG3dpQwLd4isBDtkS3vEL3ihLh9+vxH1ol4QT0jGF9gx44ZKcnv8xlSIixmweiR7X4bFFpGTnR7mhz+TrXKTOcgVt8c4Ml+H4tAkEHehgjZKc7G32+9FBscqtW4DagoVMs2cgXlXKFccpENRmu2pbg7adinbaDznndYktzQozCA/1QhsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odvU2XBEAYgmSV9KJ+OGiizUYiEff3Pibx7mnQgZkyA=;
 b=WtYuKJJJ3FV2WsyNeUZmQILTCD2B9TCJwI8v4Jz/a6lH5lMpCAkq/IVGaKGpAftgakF/OsSjqthcbE8v31vZ5gMQ7ZiHRsQIj6mfRONCTn23Cjg/fz6XeGP2cEJtZWL8TZUIFjq8azs0G27PuHTrMcFvR3dDSJBqT/okq7AAI5Exz+fxQsE6PRdcRSpHmpIhp/u2lo14Fmg2C0/umfbokVkxG+oh4Jqd+3rqeT5UmFmuiD21DyebLFKBJ/SG8dPzZE5KmF02adq0DcCsEHmiJxZ1ikK1wJ9lQTkXpuwzeVrLJ9A4mYvZwTD+hwLh+eKFliUkeGA/cBbbeNmYMjfx8A==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SA3PR02MB9345.namprd02.prod.outlook.com (2603:10b6:806:31a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 14:00:53 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 14:00:53 +0000
Message-ID: <3b8b0b28-70e8-480a-8a6f-8b1d7af1a3f1@nutanix.com>
Date: Wed, 31 Jul 2024 19:30:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, John Levon <john.levon@nutanix.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com> <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
 <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
 <96caae6c-5263-4b66-ab72-65f34dc63c17@nutanix.com>
 <20240730133958.1a3ff13a@imammedo.users.ipa.redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <20240730133958.1a3ff13a@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|SA3PR02MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: c533dcdf-5682-47ba-072b-08dcb16930dd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpVVFFPdng1UTBKZlA5Y2xIM2NuZytHYzl5S0wzNnZON2o1aG1mRUE0cG43?=
 =?utf-8?B?NmlVRnRxNTBWYVFTOERTRjJKM1RLN1M0QUcrMXU4R2NqNmZQM21mRU5XNFZO?=
 =?utf-8?B?WUFIOWRHV3JoOGZrU0pvYzlYbU9GS1lvTy9XSmhGSUpnd0g4aDd2aTB5NnJF?=
 =?utf-8?B?b1ZPRUN4SDE5YzFLaXBYSHF3WjdoWlJ5SWQ1REVuR0p1Ujl6Q2d3NzlBKzNu?=
 =?utf-8?B?MjRhMDVjUWxyVGozeHluUE5OK0ZsSk5mZ1A1WmFRMnlUNXNGTFIwelJDRWhz?=
 =?utf-8?B?dzJLYXc3MlpaUWM0dVI3akdjLysyWXpKMU9FVnBDdUQ5TjBTL2MyeUxQMloy?=
 =?utf-8?B?eUR2RjZ4OEQ4c1NidzhmVVpTY3RrVTBhYytWZERzRmpQUmpEMjhaWFliTVBh?=
 =?utf-8?B?UjlXSmxqTnVTRUxBRUlLVWxKOGRQTmtZQkhWU2prTlpIbncyOXJGUmg1bnRM?=
 =?utf-8?B?TzgxbW1MNlVadGM1OHNCbGRCd1E5V05KdFZ5dVpMaGhhVUNRWHhCemZHQ1Bu?=
 =?utf-8?B?YkMxeHMvbXhFZTZTdEN0VUQ1enBmQ29uVGxCMjd3LzE5ZUd3UG9uZTAybCtp?=
 =?utf-8?B?TEVLUEtVeHF0N3E3ZzJxUUFmREFGZUtYUmFtKy9qZ01qUGN1M21HTmt6OHdS?=
 =?utf-8?B?KzFEbDNBOWpMTm10SHZQc1ZJTUJvSzZuTEQwU1h1QjV0UTA2dmVoNk4zVGZu?=
 =?utf-8?B?d2VWOCtEVENaYWk4MnNtbkZkYnN1S3F6KzYzQmMvWFgvbmdrRGR3bjVQQ0FK?=
 =?utf-8?B?RXVhRW1IZzVHVXd2dUljTWtoMFR4M1pnZkROTlV5byt5OTNoRndiejVOeFpB?=
 =?utf-8?B?YkEzejNaS2VkYjNhblg4V3B6ODh3NWRld3VIOEtZbVlpcG1nQTFVV21RbjVE?=
 =?utf-8?B?ZXJkOTZzTGRjTGpSNHpFWW5tQjNVSGwyTVFWSTNUenNLRFNWeS9Nd0IwZ0No?=
 =?utf-8?B?MWJ3amx2Q29SVFNiQ2t2emI4V3lUcUtBSy9ycmJHZithb0g4NmhhclR5NXVG?=
 =?utf-8?B?Z01zbTZCZVVvWmtVMG1GZ3J2T0RLbmF0b09YNllnbkw5K2lPSXBPQ2RoNm1r?=
 =?utf-8?B?YkwrdlFoNnFsYVQ1UXV6alZRNUxYU1dnUUlOcW9JN2t5L0VEbmVIQndsb2Mv?=
 =?utf-8?B?Y3UwbDdBa21EaCtUVmg4NUUzSU5lSlk3aEp5V3EzbE4vaEFwdHFWZkY4WHJi?=
 =?utf-8?B?cGt5ZVJlUnVPTnRBNEkySlUzYWRsdGxBS0VUa3FXbE9hRzhQRlB1SjJ6NDhD?=
 =?utf-8?B?Lzh0Q3V6dzBhZitvNmg5WUJqZFdUd1lnTTdNLy9vQTZtd1lMU01veXd4T21M?=
 =?utf-8?B?eUNLUG5xZ3RZUDgwSk9Yb3Z2L3ExZjJhblZzMk5jcG9DSEk5V2RHSlpVYVhJ?=
 =?utf-8?B?SnNBTGY3M1BSMXZxTnJHMDh4eUdzMXRJZGxXdjg2S3laV0ZkTWttMXJVbTA4?=
 =?utf-8?B?M3JwYlpzU0YvaWxRak16MGNKQko2VXgxdmdMb1lKRHlZZjdFc3NIdkJFcmZP?=
 =?utf-8?B?VnFNZE9TM1FIVjk1Tjh4aFQ4M2ZWRi9CdkNPanZwVlp4T1FjUzYwYjhHY2FM?=
 =?utf-8?B?VEhDanVFRCtvMThJekNweURJTVkvUEpQNlN5RlRVSThMcFE5SVE0RDBwOElZ?=
 =?utf-8?B?eFd1ZXU0bzQvdmhkNVFING0zVUswNWxreDZoZ1g2QTFZalpYdDBYbkRNVkFS?=
 =?utf-8?B?WkJEZnZROWtWMjJQM3hseExHdjRkbGVXOURqR0VQTVNKbUJrMHhGTzNjYnQv?=
 =?utf-8?B?ZlVhS21EeHJ5OFdOanhnc2puY0JXeWZDd2dUQ1kyK0QrSFZROTVPUTJnbDZB?=
 =?utf-8?B?bUJRa1RDVlUva2xxL2czdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2NyT0dHMDFlby9QL1JaZGdYck5wanlxN3BhQ2pJYVdlbmJ3TWF3bWZpb0FV?=
 =?utf-8?B?TUlaQlRadDhTdCtESWJQMklTOE5ERGRmUTFEdkRlaVh0aEYxOUMraVNCTEtH?=
 =?utf-8?B?SmRKTFgyNjUwWE9vNmRzZksybThDa2w1TUg0MlN0Ukk4dFQrTjZza0ZGcWc4?=
 =?utf-8?B?WTVMSGk0c3FpVEpMUkRyNW5VcUZXbXpMdE9vaXJHSCtjaHk3Sm5IOFNQTmdG?=
 =?utf-8?B?MWcxVzVVK3lNY1VxREpsdVFKV1IvNUlDSTZuRGZjNzh2b1UzNWd4WnBXWkJS?=
 =?utf-8?B?U0hjeVVGYjNwWjl6RE5oQVNrdkdyMlRPcVJPZUs0UFo0eHU2UkgvYU5OQkti?=
 =?utf-8?B?NUdrMmJwUzdySFJVVU5FaVFHbEZ4Sjc4aStTZ09IYnhJODBLczdrWG5DS1RP?=
 =?utf-8?B?SVRtbUNsdjhVd2c2ekQxS1oxS2hmd2lIakNFUE03RUYxQkdxRFhsRE5TS2sy?=
 =?utf-8?B?ckJXVTVCeXhpT0tDVlFTK05zRklKTU1zZiszdXpVK2Jia2JrTDZiSHA4ZnJ0?=
 =?utf-8?B?QS9teVptNyt6N2loVTVGaVZTVEJSQk5VeENaUkdlVzFnbzFqNjJFM1R4R0w2?=
 =?utf-8?B?bllDVm1Yd1Y1V25kcU0xVC9EOUJnclRxbHliTEtuNzFPYzltb1hib3k1QzFO?=
 =?utf-8?B?RlIrb1BUTjNtM2FXUGR2QU1zZEZvaUFhOEJxeEJqUTlIbzQrMXNlRGMvYjQ2?=
 =?utf-8?B?enlpNnhWYXhrVFc3NjVmc0xHWXlwS2ovOEFpNFNLK0RTZFBhVlVMZFhONWFq?=
 =?utf-8?B?aXZ2U0R2bHJlMmZkKzQ5N0ZCeEtEemNVcUtMdkVKcDY1YVUvR25pV1Y5TWU1?=
 =?utf-8?B?WGNRc1hGbG5yUkZkZm41c2hZY3k1cFo4VE9CdDg1Vzk5bVJWTlpVRjNGeWZr?=
 =?utf-8?B?Vk45cjlyUlpPZ09yRnhhTUJLTzZwV3VEZUt5V2NFTHp0TjV5L29nQ2J4cS9l?=
 =?utf-8?B?VjZrbFBrcTlOdXBPbTRCMlkxMHQxalN5c0RhVjNLbko3M0FOZjU4OGFBd29u?=
 =?utf-8?B?K0JlOVhRNFpIRUNQZEJ2NEN5RlY4SHZ0ZjN5cFVuK3JYOEFsOTcvd3JaZUd2?=
 =?utf-8?B?MFI4aS9NL2pDUjF5cUd4b0dLZGw1Um5tWE9oZ0tzMFhSS0M3ZEdPaE9XaDlv?=
 =?utf-8?B?bkdrZ3d0Qjk3bjRJWE9BdjgvdDdGZTJVdnRNTkJUV3FDMGNudmdSaTFZOVlw?=
 =?utf-8?B?TlVlUFB2eHJpaVJocVMyMlVyZWtxUTJiR0phK2lxK0ZMRGRWQzJYNUU1OWwy?=
 =?utf-8?B?cmxTNDEybTJDREVjRGpDUTI2aTVWaTBwYUJUODlVZWZDSGUyRm12cFc1UG9j?=
 =?utf-8?B?MGZLL2xFS09ZV2R1bXNuZEtKQWEwbnpDbmoyU0x1OGNEWnVjTE5LU09ZM2tY?=
 =?utf-8?B?aU16enVJQ3RIVDM2SzhLWURhR29neEZtU2VWOE5sL1k0cVlPci96WFFqQTlj?=
 =?utf-8?B?SDloY1hqdGFzdTNJWXp2U0gvTHlCUUE3aUVNZUZwS1N2N0dnMzN4R3llRE1C?=
 =?utf-8?B?VVYwVlR6NjhnYWtUdG0zWkloRU9DeWs1cDhlQjJvUTF1N3NiSk4vVnlDMlVP?=
 =?utf-8?B?cU5tL3RzcE0yQlk3RzdMZkl0SW5yRTRrQnBaemp6SCtFNmN5dm54Q0xTOTZo?=
 =?utf-8?B?WTJFWGtSQmgvaW1PRVRQcHdwL2IvdjBRMHJMMlF0L0JneE1adkphSFVkZjZO?=
 =?utf-8?B?aWdKV0szN3dLMVF3cGZzWFZ2Z2hBcnhqYzhGd05FR3YwbmJWc3BOYmxhRjNV?=
 =?utf-8?B?SkVnZUJqaTZZS0ZZZC96S0MrcFR5bHRaeE50VU1rRlZCZ1dRNWVkR2ZpT3V6?=
 =?utf-8?B?TWQ0dnNHei9EVWtCUHVpbU9TQ2NYL05WNW9ZVVl3YzNjM2VwOCsvdmxJd1hv?=
 =?utf-8?B?R3ZaYkNqMG8rQ2kxZENkSUxyUHNTbWxXSjdOZmtzZVd3MWtjVGkzN0UyVVpu?=
 =?utf-8?B?emJKSVdTMDE3cnIvYVNTOWErZmF0WkNueURvN1NxVzVvYjVZTmZuUi9PeUNC?=
 =?utf-8?B?eGpUcVNzTjdvNlpwNStmSXd0UDFZcHVWWThGMGppRk1lYkFxdWJiY3lGM1dt?=
 =?utf-8?B?N2cvS3d6azJrQVZWblBoWC9zbi8xQnMrRjMrY21ORDRsOW1TZzFDNzNmTllz?=
 =?utf-8?B?Q2R4V21MZzN0SDllR3NUMlBEODh6U3hhSEpOdHhweUR2RjdOZkxDV0NFQjdS?=
 =?utf-8?B?TFM4REZDdlF6Q1VGcTdTMDFmYnVGOWhOUWNiZVdmVkFkSnNhQUdkaVVNQ21a?=
 =?utf-8?B?VllvdHhtTkhwYkhuaHJSbnpKc0ZnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c533dcdf-5682-47ba-072b-08dcb16930dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:00:53.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aae8HaMKr9wib7f+X3mqjQVpMIR9Bd+tXnZAzv07I47uZngO7C8HpJUx6O7AbyfsBVPgXDZjhTdaA25LnrXOSalkqLSmCpN2iiZieOTN2jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9345
X-Proofpoint-GUID: 9fr5J5UBQ2jTN6Rzkz323xh0k84SBr03
X-Proofpoint-ORIG-GUID: 9fr5J5UBQ2jTN6Rzkz323xh0k84SBr03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 30/07/24 6:39 pm, Igor Mammedov wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Mon, 29 Jul 2024 19:42:39 +0700
> Manish <manish.mishra@nutanix.com> wrote:
>
>> On 29/07/24 7:18 pm, Igor Mammedov wrote:
>>> !-------------------------------------------------------------------|
>>>     CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> On Wed, 24 Jul 2024 23:00:13 +0800
>>> Zhao Liu <zhao1.liu@intel.com> wrote:
>>>   
>>>> Hi Igor,
>>>>
>>>> On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
>>>>> Date: Wed, 24 Jul 2024 14:54:32 +0200
>>>>> From: Igor Mammedov <imammedo@redhat.com>
>>>>> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
>>>>> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
>>>>>
>>>>> On Wed, 24 Jul 2024 12:13:28 +0100
>>>>> John Levon <john.levon@nutanix.com> wrote:
>>>>>       
>>>>>> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
>>>>>>       
>>>>>>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>>>>>>>> to 0xb by default and workaround windows issue.>
>>>>>>>>> This change adds a
>>>>>>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>>>>>>>> case extended CPU topology is not configured and behave as before otherwise.
>>>>>>>> repeating question
>>>>>>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
>>>>>>>> that supposed to have it?
>>>>>>> As i mentioned in earlier response. "Windows expects it only when we have
>>>>>>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
>>>>>>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
>>>>>>> to 0x20, so we starting seeing it with SapphireRapids."
>>>>>>>
>>>>>>> Windows does not expect 0x1f to be present for any CPU model. But if it is
>>>>>>> exposed to the guest, it expects non-zero values.
>>>>>> I think Igor is suggesting:
>>>>>>
>>>>>>    - leave x86_cpu_expand_features() alone completely
>>>>> yep, drop that if possible
>>>>>
>>>>>        
>>>>>>    - change the 0x1f handling to always report topology i.e. never report all
>>>>>>      zeroes
>>>>> Do this but only for CPU models that have this leaf per spec,
>>>>> to avoid live migration issues create a new version of CPU model,
>>>>> so it would apply only for new version. This way older versions
>>>>> and migration won't be affected.
>>>> So that in the future every new Intel CPU model will need to always
>>>> enable 0x1f. Sounds like an endless game. So my question is: at what
>>>> point is it ok to consider defaulting to always enable 0x1f and just
>>>> disable it for the old CPU model?
>>> I have suggested to enable 0x1f leaf excluding:
>>>      * existing cpu models (versions)
>>>      * cpu models that do not have this leaf in real world should
>>>        not have it in QEMU either.
>>>
>>> If cpu model already exists, you'd need a new version of cpu model to
>>> enable new leaf by default.
>>>
>>> For completely new cpu model, it could be enabled from the start.
>>> i.e. workflow for enabling that should be the same as with CPU features
>>> (or as you said 'endless game' of copying base model and making it look like
>>> should be according to spec,
>>> but that's the process we currently use for describing CPU models).
>> Igor my understanding was that there are two type of features one is
>> real CPU feature, yes those makes sense in CPU models. But on other hand
>> there are features which are emulated ones i.e. kvm-*, these make sense
>> enabling regardless of any CPU model and we usually use machine types to
>> enable these. Does not this features makes sense in 2nd category.
> I'm not convinced that it applies to any CPU model.
> I'd say it's risky to expose new leaf on CPUs that don't have it to begin with.
> Also what about AMD cpus? Do they also support this leaf?

Hi Igor, No AMD has different leaf for this purpose, i think 8000_0026. 
But should not AMD platforms or guest ignore it in that case. This flag 
was anyway getting populated earlier too for nr_dies > 1?


>
>>
>>>      
>>>> Thanks,
>>>> Zhao
>>>>   
>> Thanks
>>
>> Manish Mishra
>>
Thanks

Manish


