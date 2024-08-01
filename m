Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042ECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSi3-0007qb-RA; Thu, 01 Aug 2024 06:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZSi2-0007pB-CM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:06:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZSi0-0006SP-Ic
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:06:58 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47182MIY022880;
 Thu, 1 Aug 2024 03:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gJKvuC9b7VCJ1ITFZYGy6UQObHZwPk+/WtqSRM8hj
 PY=; b=DRxgd8rmbG1OOw0YpnUyVw/SxZO2GwZH3dxyKpJdtADyH7QOSEIVR8Hyh
 kxM5V1OaStkAhE7GRbFpdZdtD2JQAlv80k3vi0McUO5mKcEzDO5oEDUy8HVbxO6s
 NYGH+ZZrhOfCGXoGTLmKjye0H93+HbOZ+GZFkuAYjo9oGMCbpKTldVbfyHewUbHI
 h7+n+76VpActb0kybgkerOysuC2Z23Mx5j3RkxT3q/jPrrUYuB3XldGTmkhSrGPS
 dqVmME4SyuOZzcEOPj91hW8mAjYyIlVlhyPkEYotPhw4AH5Oo70KIApEsieup7aT
 JD9kBEKlhBgiGvuzHyrKJTkZsSfMA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010002.outbound.protection.outlook.com [40.93.12.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40q9cguy3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 03:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KudQRjOiJ1fuAbquhMVUwOdtFQP27I2mumKPLT4zWwDWQLwM7vC36CEFxf6DawgHgu+oLVM5km+ikfH5JElG/4z3ltVTpBPH/oPzGg14uyyY18DJA64fS/4gITGgWnZqxmNdRe6K7QB9slv5Ni6Ap8AuQxH77TGtVQIAu6KJPwThoqfzNYEadIFglRx495ycvrB4rnEChJLriMFh1/6Gob+5UQ80ur4zn12wA/vyigyBpueqfU0JjmvUOadxmRKLgtyro+9IH1NNqZQXoNQeK1EIFaz/4KdHbSZReLFrnWT7GRlU4aBoTyyifpjyqeCaYLfuIX9Ws+apDCg85faZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJKvuC9b7VCJ1ITFZYGy6UQObHZwPk+/WtqSRM8hjPY=;
 b=ukr7MF8YL85f8zESR9y3hVF/UbN49v2grsm3YkU73fqjghEgXn+REcdz/pqt5XDiOfqmBUTKSYKawU6ILKrIZB5/HglPT6IDhHspeIz19HbrsN0qsK9hR/50Ghr1yMI0rBs8L3mXDCeriZFchsLmWChDmkVMWh6GsaZCQ7Q5vQOpKPi5KSizeAF9k9uw4tiaRs4Pl+S41d2AtvdJS0I2aLz4Qe0j/rZgkXedAPdZc2brhUDjjxrShzfCLhj5QuZJWCOHoEsvT7FinSyeOmhK95Pph2yDL2FF14oG+wINUcobqYkzKxgHBpDhRQBqykhmLdQrSET6l99rerMcSW20KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJKvuC9b7VCJ1ITFZYGy6UQObHZwPk+/WtqSRM8hjPY=;
 b=WsIqGFwGV8T4vc0QZG6J7rPTgBttSuIhytgzJ24zZmyEIGJUcP3P9a/pLEsR50wdW7R6hAsqXeULNHYeH4rd7QxepgIMrhkrRkuQdB451Ltk0R6BFqzja45q90s277rAzFbD20wvGa2BbbNVe6v5WhHM2G6s0AoaVf/kTYDlIeCidWDL5z/qB+h2eGC3yErLDSujTu/6VEKWKT1e6n3aktOo4w9zhoqVlWOiEeDxLmafl7tEAbzaavMuj+V264S+mYL2ihsmSIMt7B0TbTvTJIpW6VplCLcZrwZrKtGA9y6dSUn+SKN7hB0fEWXsXwQCdiacYy6E+CsDKpE7QBt2vA==
Received: from SA0PR02MB7386.namprd02.prod.outlook.com (2603:10b6:806:d9::19)
 by CO1PR02MB8491.namprd02.prod.outlook.com (2603:10b6:303:15a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 10:06:35 +0000
Received: from SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564]) by SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 10:06:35 +0000
Message-ID: <d7de1729-e497-4913-be8e-8938e83b3a2a@nutanix.com>
Date: Thu, 1 Aug 2024 15:36:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Xiaoyao Li <xiaoyao.li@intel.com>, John Levon <john.levon@nutanix.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com> <Zqn6mNuCH4/HJoO/@lent>
 <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To SA0PR02MB7386.namprd02.prod.outlook.com
 (2603:10b6:806:d9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR02MB7386:EE_|CO1PR02MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cdfe50-f6c9-40a8-cbf7-08dcb211a00c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|52116014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHR2cDhsckMvU3Q4SWhOSWhhVGU5a29sT2ZiaGtWUlBMZk1kTDNheThCNm1F?=
 =?utf-8?B?M0cvM3BEUXJIYlVZaEp3ZTU2ZEl2RTJFL1AzVTBlTURGN01FZTh2SXQzNXMy?=
 =?utf-8?B?U0pJelpmN0RjT2pRWm1mY0Q3Nk9OSFFHWnRySHlXaTlVYjh4TzF2TGJzOFJu?=
 =?utf-8?B?RTZyM1VvOGZCMFZ1VFVydnlFM3U3TXlxQkRDdzh1Njg0WlhzS3dpTWlDLzhO?=
 =?utf-8?B?bDF5WWxTZjYzQ3RITVNSbXNtSGFnTGFBK21FWTZZbUN2ZUZ3NCtmVTZSY0V0?=
 =?utf-8?B?YmhlalBCME94eW5xVmNrd2FWSndZRGMxckR4YzZBZDlTbHIyQ1l2Z3huODJD?=
 =?utf-8?B?OFI4cU50eTdwb1BNMFpuNWJLTk9IUmI3czRRS3VBOTFoVXhwUTdoeUFXaTFq?=
 =?utf-8?B?ZVMrRDJVa2Y4ajRLSHE3TjZVMG51TWxQQU1KczlyQ0JNOHBoQUpGdHlsR2lu?=
 =?utf-8?B?T2NNalZ3eFErMEsremsxZUhaZmNoWHN4YjlBaGtFd0I1OU5ZOTIxTzBXbEZ2?=
 =?utf-8?B?SnorVlR3TFF4NC8yMW41OGwvOUNMTnpmenMwalp4V3QrWHo2S2lvZjBKZlND?=
 =?utf-8?B?T2FST095YjRhcnJKSGlaL3dBRzhwWTh1aU55M0dFWUNkbW93UnljS0lIQWxC?=
 =?utf-8?B?QlRIc1VRQlVRVklqa1FmZTBsNnR5TUI1SUZDZEUwbW5QaWd5YnhKQ0o2cElN?=
 =?utf-8?B?bk8zY3Mrai9rRDRLVjRlTi9YM1NjZTVkN2FmSG9ybC83aXBmaW5wUUJxQnAy?=
 =?utf-8?B?OFZ3TnZJaWFmem1QaksxbXFRMlF0QlBiSThzUUp0VVRObWdhKy9tZnRMMFE3?=
 =?utf-8?B?dkxvV0NRWHhQSnRobjhWNFBEYjl0TWJjeDcrNzlMQnp3S3gyY2dzYkxsenFM?=
 =?utf-8?B?bStGOEpuTU43Y3FocjBHRU5xbWhkQ1JEOE01K1ZJSnRpOE5jM29uNWZVNzlX?=
 =?utf-8?B?aFQ1aGU3cU9sVVRHWFRPVE1DQmJjNDRSQjJoSjQvWUxzT0Q3WXhOODFOZ0gw?=
 =?utf-8?B?cGVPMUl1SE11U2FTbEhRMzlCZlRENzllR01pYW5IbG1qMjNpdmNnUzdnN2h5?=
 =?utf-8?B?UEUyTzlxTDBKZm40djUvTE5QR3AzdSs3QlVmd2VibWxVeUR0VzJtVk9KS2k0?=
 =?utf-8?B?S2hPUWt0b0lOeGtVcS9nZlBCYldFVC9aOFVEVXJDQ1VUVVJ2U3JEMDRUbkds?=
 =?utf-8?B?ZjFhOXIwcWVRc24vMHI5SS93ajNlUXlTVUVhYTlTOGFEQ3EwdnNFeWdqUk5G?=
 =?utf-8?B?L054OGpSWlFVS0dSckVNSG1hWTdIVHh5M2FTUmFsZXY5N0F3enpyMFZFNXNN?=
 =?utf-8?B?VklHeFh0Z3R1ZzNKM1A1OWxMZjQwSmpZTjR5R3JySDNWSExGYytaNDNsYmFp?=
 =?utf-8?B?cWtZSElGSGZOVVRDS3BFNXNMc3ZtMWFxN2NsZzlyNEN0Y0w3RTBpNVNjZ1ZO?=
 =?utf-8?B?Q1BidWhybTBKakR4ckw1R0l4cXc1VWkyWFhodEhibUowZGx6eHFJTzROaWdZ?=
 =?utf-8?B?UytsUEZvWmdGS2haUitiUHY2cXN1N3JDRUtUYmRURlV2MU9GdEdIenBGSmhO?=
 =?utf-8?B?T1ZjbzBKVDU5TDdFZXdUOWZYOHA5ZFhVbDljYno3VGRpd0c2Y012MkR4eTdX?=
 =?utf-8?B?SnBxSHBKc3lIamJFaWcvQmVLODJQSHpSNUJUR2lGU1pvR0lXUG1jekw3bmxM?=
 =?utf-8?B?aUJnVGYwVG9vT3p1YUR4cUhieWFOMGpOWENxWEcxQ1Z6R2ZDWmVyN1ArdS84?=
 =?utf-8?B?L0p2UGdZaDhaM0tCbnVlNjZqWGpjVXIzK281dkczTHdrU1BlL295dXNxa0RW?=
 =?utf-8?B?ZEZMdVVkQWJ6L1ltVWxpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR02MB7386.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFOdzVBUDJ2YysxMTM0eXdnQ0grYWRzbTdvNWRhamlCOEwrSUdlV1l5YnJi?=
 =?utf-8?B?WXB0eVdQa09oVEYvQVQxQ28rZTY1Z3dROUJkTkRLZExYZndiMlhQUzZ1SUdw?=
 =?utf-8?B?OTZGd085bzJIT2wvbU5vdkEycDFBdlF0dnhDWUNQaTdxQ0hTbHZPUG9vZGpM?=
 =?utf-8?B?NkRTODIxL3VTRjFJWElEaHpGcnZKdWZseEdWNVBORm5vR1dKRWhKNHNoVk1n?=
 =?utf-8?B?aENnTWFWYWVUZldyQnhJUDJzNytKdDVCRHlZd2FwRzl6MFk3WVp6R0w4U1Nk?=
 =?utf-8?B?K29tcGFwc0dOMXE5MG5hUWxwaGhJZGNQN29qdEUvRkkzMmlDakg0eEFJeEpi?=
 =?utf-8?B?YmJOZC9rYW5PVGpmcEpweFhIdE43eFNadHp4WlZzdmF2YzVHaVZ0ZllWdzFO?=
 =?utf-8?B?eUJLaHpieTIrdDNJN1pFVExhU29acmRFOFBoR1VtdjV6OUJ6bEdJVGpUNWls?=
 =?utf-8?B?Y2ZlWFlISzNTRjJWb05qcThVeHRIRnI0QjVFV1pFc0QzWVlrMS9XYjFPeGl0?=
 =?utf-8?B?dTF2MC9tbkdoK2h0VkdQMFk2SWRhT25ZTDRDcmxZOExIZTRWZ213UXlmSlps?=
 =?utf-8?B?clNsbWpaK0xnRnFPZFBDV05aVzFabGd3Z1VUR3BVenRDSGVzaGZCblZEUjdw?=
 =?utf-8?B?d2hXSVhHNFhRS2J0ZCsxdGhrTnNsaFV5eldpNyszdkVZZDZySllhdjk3aDAx?=
 =?utf-8?B?d3V6SzNtTjdGUkZRbUl6eFFlc1M4enJEMmliNmV6d1ZPdXd1bkVnUWxCa2FY?=
 =?utf-8?B?VC9PTVJ4WGVTU1U0Mjk3cmNlM0YyMEYxVXBnU2NzMHJjQkZqT3RheTRRZU9X?=
 =?utf-8?B?bDNWcE1zVGQzWGhxRWpmNzhqUHFqQm9EQXJuejVCT0dnZ0FrYkhuZW40T2xo?=
 =?utf-8?B?aVQySG0xYm1jemdSaHZGUkVHWE1tbkI2dUZ4L1pCYTloZ0xVeGlXYzNUcHZZ?=
 =?utf-8?B?L3pNMUFZM09RbXhNU0FtbE1ZSlJRaFJLTGpFUEYwMmRIMlp3TmY5MWNQY0No?=
 =?utf-8?B?VUtjd1VlTjhUR2VUM2lOKzBCOGZTNVV6NGpTUEFaQTlNcExKOEp0TG50Y29N?=
 =?utf-8?B?R1k2RE5RbCt2QXhPRUhYVFNHM2ZxZWVvc0xaTXExVDdubkowNkFKb295Qzl3?=
 =?utf-8?B?RjkxaHFjOGw2Q2ErVTFzZjk3R0g4VkNjRGFsZ2t4U25YV0d0QTRVbk5GUGdw?=
 =?utf-8?B?QWVkNFRWYjdMazdSL2JrQ3VGWXNkTkh2UStpa1JKSG9DWWtOd2V6bkJQMC8w?=
 =?utf-8?B?MFl1MWpSbGhGWXk5SmNBeG5DNHdYdGRsUEF4UXNsT2daMkhWczBCeUJCenRx?=
 =?utf-8?B?S2F3RWZLK2tiWG9KVzZ3QzFwVVVVampDWEI5Ylc4bVZpeDczajVTczVVQm9G?=
 =?utf-8?B?VHdhejBQRzd2eWxnWWc5UlFiVjRSZUp5NzFlY3pra2NXR0xDT0RoUkpaRUdG?=
 =?utf-8?B?Z1lVYnBsM2Nna3NoOUdBMUFpOUdNZk1RL1hpWnFQNExzQVhaaExncHI2Wk5F?=
 =?utf-8?B?Wmo1K2J2LzM2TjZkcHU3SDBpK3lLQktxT1NIUDJJTDBrRHZJcmJ2NDBvbGtS?=
 =?utf-8?B?NHNoak4wYzA3MkZQNjJpNmpleE14L3g0OERneHdFNVB6Vk5UMml4TkVZclBN?=
 =?utf-8?B?L0prRTd1UFNSN3I1ZE8vWUpMYkZTeEM0c3ZWZzY3ZVJkMHNVLzZyK3lGSzh1?=
 =?utf-8?B?TGNTMnVPbHZ3M0hnRU9yL29FdkVNd0MvQVZNVXZNN2hqZlBybEZZTTcrei9G?=
 =?utf-8?B?Ykt2NFdrQnc2dFNSWW5wMkJrbVpSZ255eGNBMnE2Q0dkSDhqVnZqWFJNczZH?=
 =?utf-8?B?cVVMcy9zMklqbnoyRzE4OHVRREhxaXZWbkRuSUZjMWF0UWwvMzBtc096NEdP?=
 =?utf-8?B?YkxVV3lJY2ZaUytidnJUR2tkOVZjREtjNzc4ZUNJcFZhWkIxbnZYZ3YyeTdZ?=
 =?utf-8?B?ODlNZ0ZybGRtbURKQlovT05Ld2d1NVdPazhHMzZFanZRUUxhN0JEUTZQSExQ?=
 =?utf-8?B?emhmKytkeVNKblN1b2JiQW11Z3B3Q201bDc4akVTSStNUWQxMnNOMUxFOGYv?=
 =?utf-8?B?QXVWb2tjUmY5M3dvZHdqQ1NlaGE3WFpOWmgzaWhvNmFSeHhueTFtNnd3UGVt?=
 =?utf-8?B?OUFXVmdaNVBycGxoVHNTWi90b3FsL3RNYmRKalZjd3Q3TnhIVzBJY1FWSnVP?=
 =?utf-8?B?VE1KNHNzVXNGU1pxQ1hiQTMyUTlJbE51TEdITUxVYTE4eW9RZS9JNlZjZ3VO?=
 =?utf-8?B?Vk5pTXljb04rYXZQS21wNmVEK1lRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cdfe50-f6c9-40a8-cbf7-08dcb211a00c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:06:35.2793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys52T1G8SWSqRc1QAOzTXSCldfaiV4+MTdbs8bS80iEOrBMeYyKBNkJJO4as6e2Z3dwIEk84nmwjQM/nKEdNR0CDNlC2hbxkqgWpowaLjF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8491
X-Proofpoint-GUID: kAW7HkNFbdq-m9QsTXwL54HkiOLvcslq
X-Proofpoint-ORIG-GUID: kAW7HkNFbdq-m9QsTXwL54HkiOLvcslq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_07,2024-07-31_01,2024-05-17_01
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


On 31/07/24 9:01 pm, Xiaoyao Li wrote:
> !-------------------------------------------------------------------|
>  CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On 7/31/2024 4:49 PM, John Levon wrote:
>> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
>>
>>>> Windows does not expect 0x1f to be present for any CPU model. But 
>>>> if it
>>>> is exposed to the guest, it expects non-zero values.
>>>
>>> Please fix Windows!
>>
>> A ticket has been filed with MSFT, we are aware this is a guest bug.
>>
>> But that doesn't really help anybody trying to use Windows right now.
>
> For existing buggy Windows, we can still introduce 
> "cpuid-0x1f-enforce" but not make it default on.
>
> People want to boot the buggy Windows needs to opt-in it themselves 
> via "-cpu xxx,cpuid-0x1f-enforce=on". This way, we don't have live 
> migration issue and it doesn't affect anything.


Yes, that makes sense, I will send a updated patch by tomorrow if no one 
has any objection with this.

>
>> regards
>> john


Thanks

Manish Mishra


