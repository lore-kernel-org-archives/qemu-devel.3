Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547DDC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZP3-0004lc-EI; Fri, 21 Jun 2024 04:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sKZP1-0004lD-Bc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:13:47 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sKZOz-0001Oq-6A
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1718957625; x=1750493625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/A+TnM5LFmuQaWU1n+Dz1Ro9BINahAxesUMI2B3X+4Q=;
 b=PeGunMlXv3bgiNes7vDrkNVBd481RclMSRR3INoNQik5FQMVxtMKGv+b
 Fvh6LZQw0GmGtdll3HidoFvmKjxIk6Rh9f5gLP0tUC1NjeCDpdHsWL7O3
 9IHQpMui+51OzyoCjrAYUulY1E9yBB7XwsvSQ0LexpHbpJ9IoX0dzpRaj
 eD8LAdDk7abxYd+QkzdxGLJCTkJJFykNIwEZlixa5O9AKfCcJTDvHOGNM
 FPc6thQ01LYxsz6ir/qWfXHfDMG4zlajb/KwSFOPWbCIPKhT7/Qxms+Yc
 M/WmEJKSDUUjCrBzKKfkDNwAoaQcbmnCqcPYJQqcCmJSAJRsvDSdwPJYM A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="123177034"
X-IronPort-AV: E=Sophos;i="6.08,254,1712588400"; d="scan'208";a="123177034"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2024 17:13:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n37yadMS5yT1T1djHcXqbEdynVDd5mOMa+vNpPAfyHVq5eizmKpXtivUjQ6m8f5pUGRvc8K6UYyM3B0AfBqfGvtAz7XIt3bRzewsimMEZX7zryEqi3i7wZNCRchaoAu/tc/xyBsgWIrreoHU4sJuOJiZNfjr+Ajq9vrw59zGngo6sRgc3qgyxWor/K8qT1ktNN4fqriGp47LODs6tfWhkjBklZcPbhaBnupJCxn6HWFTE1jCMKzwQfZ8oKmjXH0zJc9bbSJmwZIKCykDs8Hbd2y1UqpJqPgnJf0bwAtevL+onnduYWQGfC++yb7nC6ldl7Hve+BKei44/5TsGrhuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A+TnM5LFmuQaWU1n+Dz1Ro9BINahAxesUMI2B3X+4Q=;
 b=FN4Flenf50eYGLBkTczvzER80IBIAexNGE7bRX3GxOhSI7k4QySMcO6oZ/0S1sy28+kbA0UJZEYZobBwKsms+NNpGKhjECCjxC65HkjnOPlRNspfjaaaMtjXlF6DN9GMQttVapwCiHkcA+YG2ofV0ASjle2dkfX1MdvJ9ktKJt4FVH9yBUvFfPiDVFvgSYrD/+ZH1EpL4UL2Des/aR/nbPK1ggbpVkapiwJcn2n7WLvZu4AqQ5VUkB7SHu02WIDvToVCyE9rRWcXlH3xPTMsMtPXf6dNeSzY7l7q0i08Akqd8FDwSF3X01n7tOyKpID7FZNdD9XLVLOdsDhRaNYsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB11398.jpnprd01.prod.outlook.com (2603:1096:400:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 08:13:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 08:13:35 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Thread-Topic: [PATCH] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Thread-Index: AQHaw6l9131qGRmVGEqONDSJb93q/bHR3n4A
Date: Fri, 21 Jun 2024 08:13:35 +0000
Message-ID: <258a78c8-dad3-40ff-8ccb-c3d1c3822131@fujitsu.com>
References: <20240621070317.9670-1-philmd@linaro.org>
In-Reply-To: <20240621070317.9670-1-philmd@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB11398:EE_
x-ms-office365-filtering-correlation-id: 1b72fd47-dedf-4858-cce7-08dc91ca0c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|376011|1800799021|1580799024|38070700015; 
x-microsoft-antispam-message-info: =?utf-8?B?d2dLN3JTaDBEK3hQdmxlVXVXaXJsZnJ3dDh2cXpoNUd2SWNqSGRiWHRoM0kw?=
 =?utf-8?B?VjN3UmNzMXZueWxHcWV6OWhwQkNmazE0eXZlUERXUzFrSjNpWmtJMnVKZ2Ur?=
 =?utf-8?B?R3E3UC8xb0NoaVhCZ0Q0YmhGVjBVOGtpSEtnQlZmWEUxNlkyeElJVTA2R1Va?=
 =?utf-8?B?NHZBa2hFbmtDY0Vlbmsrd3R6RnhHanFDSHdjTHJoUld5VnRIdkJ6bDVmazlo?=
 =?utf-8?B?RHRVMEg3SXlDK1VkRUhTejRqQjRkR1VBVFd2UE9CS0RsR252M3BVYTRFRDZX?=
 =?utf-8?B?QkxFM05SRUZ5SW1DaTgzd0xiYW5ITkZwOE1tb0hhZE9MMzRmaStHZnpvM1lS?=
 =?utf-8?B?aGtwanIvc1lVLzhTbmxoNHF2TUZPRjg3OG5yc2hoRDB3QkI5SFVYN08reXVq?=
 =?utf-8?B?VG9kVzF3OEVjZ1J2d2FsdnVOaWF0akhTM1MyK2FzMEkyS1hkOFFCZjh5RCtT?=
 =?utf-8?B?NTBIaGJUbDhidStJZmhlNmV5WWJBcUJpVjBqT0puVjB2ek5EamNrQTNPclY5?=
 =?utf-8?B?T2s1Y0hkc1Nja0VjTGJGT3E3YU05ZUNJNlQ3QkhiQjAyNjBrbUxPWGRuYUJj?=
 =?utf-8?B?ZE5UT0E5S3diSjdOaHZ4bndxR0dTR3A5T3VIWDhKNS9nUFZ3SmZPa00zS0xM?=
 =?utf-8?B?a2tNbktvYWxGZlQ1MFc5WmNHeWhMUzVIb0xBaXRvaGVyNTJ6eGlmaE5OK05M?=
 =?utf-8?B?SHVTWmlGUzNJZE5RcXpJb0tmWnNJQW1wWERvaWd1eUF3NUtYTENqb3lBbDZv?=
 =?utf-8?B?ckw4MTg0WVFHT09GbzhobWdFdTRyRHpyRFljbFFlMWFtbHZwNXdMK2Vvckdr?=
 =?utf-8?B?S3JEQUlUN1FZMksyZVIvY1JNbGhmYlZ5emRQbnFzaGxiSVM0dFlXRFBDcEd3?=
 =?utf-8?B?T2hwT1ZhRHd2My8rMVNrUkNVNWE4eFdwWnVORmRyK1JWd0g0Mytna1BGTFZj?=
 =?utf-8?B?RXJLQ012L1hoY20veXFaVnphTHZtN3UzdkN6dDZTdXJvdTluc3h2ZXJlK3ln?=
 =?utf-8?B?WlN1aE56d2FzUHAxWTIyTmVKam5yWDRjaUlKUzhVTHhrYm0yZS9pNG8xNEVw?=
 =?utf-8?B?NnU4YURlVU54WTJEMEhzVEFicmxIbENZeFNlT3kycGpVQ0ZCUm5zaDc2bXc0?=
 =?utf-8?B?VDNPZGc1VG90cnduQnBtWHNiOEtxNnhTQWhRbDduRVVoRVV2ZHRWMDBqUDZ0?=
 =?utf-8?B?WHp4N0Zxd0oxUEZpQnlQVVp5aG52NTRBVkU4c1BEQnBTWCsvaGZDN1pWa3Z1?=
 =?utf-8?B?NElRQmpvZHRveDZsZWJGN3d4cGJ2ZHB1RWliM1lLeVNOdVhXRFI5cWhPY1VO?=
 =?utf-8?B?WGQ5UjViYVNoWmNLVUdXVVUySWVHcmlRdjRqZjhxM0dUeFVBRTV3MkdMQkVm?=
 =?utf-8?B?Vmt2a05BS3ZaZjVSWVNIZnFLUmFjY1NFWUpyOTd0Q2ZwRFp3ZHZHcENTSnFS?=
 =?utf-8?B?Ymt6L3V5T0paMndTYzBQdHNTcHVnb3g3dHJNNjNhdHJFSkZkcDhIVkEvZWtD?=
 =?utf-8?B?ZnR2MWhYWnhxR2Uya3k3M2h1MDZYSHNTU0tqTStCb3F3THQ5VE1WSjZNa0xO?=
 =?utf-8?B?TWtwR1ZMOUMwUDlIY2xzOENWTVdMKzlKbEJqcjNmOWJYeTVXd05YeDQ2VW9h?=
 =?utf-8?B?Qm1oRVJXMlFCSnlDQjJnc2xac3g2Ylg3bFU5ZnB6NExQYk5nWVZiZVIzbmRY?=
 =?utf-8?B?cFNWVGh1NlkwZ0plYUx1TDlpeDNSS05kY2lrbVorL29sWGMxVE9NcDlZOHBi?=
 =?utf-8?B?bDBNd0Vxd0tNeThvdzh2akEvTUR1cXdxUXUrUW1iazQwdUFnRk4zSXBqV2Fm?=
 =?utf-8?B?aUg5ODVCem9OTkFtUDh5VHJML0M2dGJrS1U0Wm96Y1phQ0ZaTXduOWJPV29J?=
 =?utf-8?B?RFg0T2tXQmpxaVZKWitGS20rejFSRXBFa1VzY2Z2ZG1EQkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(1580799024)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXRqejdBdkk3Y1BKaWpLR3NRNnlHWWNwVDljaEFUa3M0QWM4YkRBZmkyRkls?=
 =?utf-8?B?a2t1SUMyWk9HeStscWtrUmVUanNVc0xuSENKMGVvTzR5eHNPWHJTZ0dTbVVM?=
 =?utf-8?B?a1M1cHVvUThBMUJrYWVGOU5KQnk5cGQxQXV4ZkdSM2duNmJ1ZFcvVTFvTGF3?=
 =?utf-8?B?MFYrb2Y3NDd2UjZUNENhT2pMbm44ZkhEUzNQZ1AxM05WeWUxUk0vZXFQZDZS?=
 =?utf-8?B?dVVETENSdWFaRWtJNWJHQjNvNHJTSURKUXpyRXlSamx1bEE4dlFwOVFyZlI3?=
 =?utf-8?B?THJiWDJycUtWU1M4M3V2eVZhcWdwVEFUVS9sTzE4emtOZFJ1MzJSS3RFS1pk?=
 =?utf-8?B?RlByNWJnRCtwY0JFYmhhb0UrdUpPZ2Njb0xsRmkrVWw5MmpXbGtmQVhyZHdk?=
 =?utf-8?B?UWZkekQwU3FBTmQ4KytFNjUvaUhXOHB1K2cxYWhPVElXK0VSVWVCNFE5WlFY?=
 =?utf-8?B?S2RmbHl1SEtpRU9JblBOSW5nYTFPWk1SSW5CYXd1SDcvRXdBQnhHT2tyNGdU?=
 =?utf-8?B?M1pVN2ZtZkN1SlBhS1AxTUdXMzdwcGRYWnlGZUp2WURDaVF0WFE2anM5YnhG?=
 =?utf-8?B?RTVab0xUNjZmYlFNZXV4dkd1OHJzOTJBSDZMWC9IaThoMUpzVUpwRFJWY0R0?=
 =?utf-8?B?NE1hZllmbFZMeE5yT0oxZ2duNmxUNExXcWFObURZWHpVOU5nRTdTbDliKzVJ?=
 =?utf-8?B?MGJGRHRhMnZPVkJWMWtib3dzS3JsbzZ5YzdNNmVSS1BSQjYwMU0zUUw0RU11?=
 =?utf-8?B?bFVwcUovbTEzOHVtaG9ESFpPUURKOWZEMmRGdVRwdC84YkN2bXpTZWV4MWZL?=
 =?utf-8?B?OGx3TnB4Z1pXUHQ1N1VzVDlMS2NTL1NOWjJBTlp5NTVqMTVrS2V6Q1c2ZVVz?=
 =?utf-8?B?K0xNZ1hFVjhWUXlBcWtSL2U2VVU0SlQ1a3B6MndKbnAwTVNmYXNtMDVNUHNY?=
 =?utf-8?B?U1h2OEVJZldvTG0zeEtxekV0SUkyVE1KNEJocUwzWVBSMlh4V29KM0RzRkpP?=
 =?utf-8?B?YVY4RzJScDI0ZytuYXh1ZkRoaVlWL1BlL1Y3SmRuUW1kSEFmOFJPTytwVGhu?=
 =?utf-8?B?VGFZWjFOVUcyQkM3TnJBdlV1MEEwc1BLUUlpT3VUKzRSN0NEeUR2OFN2Sm1U?=
 =?utf-8?B?OU4wNmZMZ0hjSHc5Zld2MGhQT2xEUmFtTDlFem5LbkhQeFZubkdzeFlBZzJV?=
 =?utf-8?B?UTBsTzBIaSt2NlhFeWZnN0Frb1MyU3ZWc3JxMVlNSU12VkY4R29mUGpoemQ1?=
 =?utf-8?B?b2djdWN6ZUxZU0daOGVaWXdvbkxPMCtHQ2wxdUowVzZlZkVyRVlyMjBTN3h5?=
 =?utf-8?B?MFFDSzJKWTlibVliaXQ1MHZuTW5wL3J3NXg1eDZQRmFXZkg0d3NoeVIwcmRL?=
 =?utf-8?B?a3RIR2EwRCtISFlBeEloanByazdsWXcxb3k2Tm9IMFByTlJGRUl6OGRPTWxB?=
 =?utf-8?B?MVprTzlNNFpzOVY4dlJiWkw5bTV4djZVUFc5cFhYOHZIZGRQcDJERldNVXZi?=
 =?utf-8?B?dktxLzd0Z1BaM3JOVEIycUZVaHVOdW90T3FYTjAzWThmS3IrZ2d3QTRBek9F?=
 =?utf-8?B?d1RDQ2VQaGxDMEQvdERtSkRuRWF1cDBYM3ozY0YvbEdTaWJxK3J0bVNhaEVY?=
 =?utf-8?B?czFkM2t1djFFRG9JTFdWbGd2cWRmeWdPTUVRRTZkQ1lkQWhkaGFqS1dUR2RD?=
 =?utf-8?B?dDVxUlJ0a3BrNGNXazVUR0pibEFGbUEyTE04N3BqclNjZ1JuZzF0eEpOcFVn?=
 =?utf-8?B?WnlxSDBDcDU1eThNQnR4ZTJFMnB2N1dsSkxVckZpZDU5VjVvSlJPZ0NvSDBN?=
 =?utf-8?B?L0ZLcVIzaXJxNENBam1nejF1bnludmVQRWEzZHlGOTJwQWV1QlcvU1N4QTB3?=
 =?utf-8?B?TUVjZEdpdWNidlV3ODFMcWVhWExvYmp5QjlKblFJMlNNYi9pTnhhUW42L1Z5?=
 =?utf-8?B?WEI5MWVXT2crOTVDeGpjR3dsaWhLL00yMXdXMUR3UEJMUWJYNWN4Y2RvZU93?=
 =?utf-8?B?UHg2WHB1NU5TaTAxV2Z2SkhSNmx6VkRZdnphYkZhcXhkTks5alFsaFZxU2cw?=
 =?utf-8?B?TVJuWTY4QnNGeDNjN21DV2pDMTRzZElYemZtZXM0WDUySCtJc2txRjNKYXp1?=
 =?utf-8?B?YTdKV3lnamZtS0VDb1JEZzdXYXpscDFZWjdvajZGNTFQaHFSL2drd0ZhSkxt?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2A6836668140A49B1C65F9D2B300BA9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LMJWGaQpsfoh7j2LxwP4yDWpfsRztAAqpjyRtV44jJdlhka5JugjZYi5q+wEPFMSrS0GnS5G1Q046nPWqIm0uQgaxOsGFwun2JHF+mlQbZONXS5FZKFqlXdtKxJMOUvfyG8gA5BOsVsbrP2UzO+5dOkfyJNZ4JTGINo5/WcyykdHwlkBSFAJJFu3EvtJSIEK78TbU2p3rP+0ZqzCAYSohBlbpsWeNlHECH+0Kixne0noJ//HulghV5WPsAwlqgT548oosehh0sE3vOCCOw/dq7F64nIKDo/Xo2T6JBSccym+FtpM8KunhSEUXGQquR0G/67JRIKPfvj+Es+vVbs4qdqyepWPvITFnfZCT1E8+gfl3QbBYtu9sTYSzj0qL9A2OOY2fDdHxtqEizwT40wJM61iHfVcQTa3Mo56MA1gFFx4Bk4euaQeFVb7mtgAmuPdgbHefQTKfBRa/rC+oLOpTzyZHAXH7E2n9yYNKIWsedPA2LS8HBPqVSLrrVSxa4A6tmpwAkZd+bf+w6ugHe0hAcv1+MkTO7jgdcOJGg83H/oHIzDESFDZITIvJsK3I3UacCR5meP7NsWkrFPlJGi/wGFrWHFEqzaYnRUrO2xCmEd9trzQz9/qUI7fPqiC33dw
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b72fd47-dedf-4858-cce7-08dc91ca0c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 08:13:35.5362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1X1KnRMZbp8mUmcrxMHOdrHY9XWyuJ7Tb6lCOeEUQek7dj8VDMGIup0+3lNMDnKN9aOVpx+nZ+yjE14K/XzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11398
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDIxLzA2LzIwMjQgMTU6MDMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiBMYXN0IHVzZSBvZiBWTVNUQVRFX0FSUkFZX1RFU1QoKSB3YXMgcmVtb3ZlZCBpbiBjb21taXQg
NDZiYWE5MDA3Zg0KPiAoIm1pZ3JhdGlvbi9pMzg2OiBSZW1vdmUgb2xkIG5vbi1zb2Z0ZmxvYXQg
NjRiaXQgRlAgc3VwcG9ydCIpLCB3ZQ0KPiBjYW4gc2FmZWx5IGdldCByaWQgb2YgaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoN
Cg0KPiAtLS0NCj4gICBpbmNsdWRlL21pZ3JhdGlvbi92bXN0YXRlLmggfCAxMCAtLS0tLS0tLS0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbWlncmF0aW9uL3Ztc3RhdGUuaCBiL2luY2x1ZGUvbWlncmF0aW9uL3Ztc3RhdGUu
aA0KPiBpbmRleCAyOTRkMmQ4NDg2Li5mMzEzZjJmNDA4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L21pZ3JhdGlvbi92bXN0YXRlLmgNCj4gKysrIGIvaW5jbHVkZS9taWdyYXRpb24vdm1zdGF0ZS5o
DQo+IEBAIC0zODgsMTYgKzM4OCw2IEBAIGV4dGVybiBjb25zdCBWTVN0YXRlSW5mbyB2bXN0YXRl
X2luZm9fcWxpc3Q7DQo+ICAgICAgIC5vZmZzZXQgICAgID0gdm1zdGF0ZV9vZmZzZXRfdmFycmF5
KF9zdGF0ZSwgX2ZpZWxkLCBfdHlwZSksICAgICAgXA0KPiAgIH0NCj4gICANCj4gLSNkZWZpbmUg
Vk1TVEFURV9BUlJBWV9URVNUKF9maWVsZCwgX3N0YXRlLCBfbnVtLCBfdGVzdCwgX2luZm8sIF90
eXBlKSB7XA0KPiAtICAgIC5uYW1lICAgICAgICAgPSAoc3RyaW5naWZ5KF9maWVsZCkpLCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gLSAgICAuZmllbGRfZXhpc3RzID0gKF90ZXN0
KSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+IC0gICAgLm51
bSAgICAgICAgICA9IChfbnVtKSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAtICAgIC5pbmZvICAgICAgICAgPSAmKF9pbmZvKSwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gLSAgICAuc2l6ZSAgICAgICAgID0gc2l6ZW9m
KF90eXBlKSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+IC0gICAgLmZs
YWdzICAgICAgICA9IFZNU19BUlJBWSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAtICAgIC5vZmZzZXQgICAgICAgPSB2bXN0YXRlX29mZnNldF9hcnJheShfc3Rh
dGUsIF9maWVsZCwgX3R5cGUsIF9udW0pLFwNCj4gLX0NCj4gLQ0KPiAgICNkZWZpbmUgVk1TVEFU
RV9TVUJfQVJSQVkoX2ZpZWxkLCBfc3RhdGUsIF9zdGFydCwgX251bSwgX3ZlcnNpb24sIF9pbmZv
LCBfdHlwZSkgeyBcDQo+ICAgICAgIC5uYW1lICAgICAgID0gKHN0cmluZ2lmeShfZmllbGQpKSwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAudmVyc2lvbl9pZCA9IChf
dmVyc2lvbiksICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFw=

