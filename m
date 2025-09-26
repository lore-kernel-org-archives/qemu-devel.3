Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B86CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29zt-0000FT-1l; Fri, 26 Sep 2025 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v29zq-0000F5-Uk
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:04:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v29zl-0000Vp-LI
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:04:30 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58Q7L85B1580156; Fri, 26 Sep 2025 08:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6M1N5UhxJihCBm5B5FXjJULxMSgdMu4rmqD8s2Zuq
 Mw=; b=DMRE/VUQuB9BJ0CRcneo03nJQsgWLAVN8897jR8Y8PFI+Mlqk5J52Qx+J
 RiMTQTFp7Jj2Sm22jRomSt4ix7Z9AeSjCKGk8X4ZJZV4IrsWrByLrERguFGfjBEQ
 2yRTStI4SFsotNfCLrFnhcnBvs2MDEqKDh+IHum1f/25ED6JyUJvobEnf0nOY3D5
 i7CG7t0WN4fOtC4YPCrqlJm829IY9XBscVnOgYQGJxv6p/e9Rk6wHq9GFOcoWK+6
 WFkgWcvTB5WsYH3SvS7hmrZIMZs7HOqGJsbZ5wf8DAqu6E+Tr+5+HSmt2Rl3ynKY
 Ymw/oIRlUCdS0nlzGuC9rEWsqL4VA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022089.outbound.protection.outlook.com [52.101.43.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49dbre29rj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 08:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq7++4RKNJr12uAPURtf7llenWJiGFiWTFDMtz/k9NIYkj5gJy75s/+84NJXM7etKTWonfc7MZJxNVZgEDpJF8elumog4Ag//jd+aSx/wMH5kpNWloPzjMAl8mcGvysaM4B4q+hvmWdyiwQWfOgqkG479Bq7bVgpaazEh5IXFO0oGoNhLTxbX1LNYIpdokMGGNjH37YZhntjwQEHqhfBi1kQ57HP9vd8dEkdqgCyLegCmreDvWec/SJcbZ8lsh/9GH2jlOwuuJkwyQJklEgKjr2jgnJb5ZirzHho4qsU9ZWxJ8LcCiVLpGN/+fq2DhoCOizUWXBiI4Vj2srfjTBbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M1N5UhxJihCBm5B5FXjJULxMSgdMu4rmqD8s2ZuqMw=;
 b=if845AUNL0YF2yM6oQA1rvF+lD2XxLSrxHakUNpIecMS8VcfozmTQFEo5C8WLp/6CAASBurYHqAGr6mXyg0cS50KzZLx2IQF8iBcQ/2HyayjOsgevt7z3xsj7XP2YGZ5qOHbDybDOTgBw3Mjp/G2qqbglG2M92bUczEON2p0ggNUbRtedSU2k1GrnvNOTcz12E6zrnKV58CmkcbfMO/uStjmPSonbRyOvBj4AZqKhbEQUAlrXMoZaKqc09Kl97lX6XfOGT1lki0KxuxllFAELI+UjfkA6sTgBfEOOGqZJzc40ZqBFzi3Cka044j8t1W7LD5I7OnDyt5/FIkaTnWVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M1N5UhxJihCBm5B5FXjJULxMSgdMu4rmqD8s2ZuqMw=;
 b=xBnrTC0A6Y//vSmieQGYM13+jKspocGzOlc6r4bUt+6GeCvCkC0Nov4/QNdyvpUI4OjqIeKKk3k86gQlBOqm7Ft17oCc8JGWUyFwnrYczmbYKCCqogS6ZbIhg+qWK3lphngSVMvB4xYhZtqmym2WucCztuBItQkEcL5VLgN4zt+6OXzUgj3NYVpi/5N1+32Aw05GQpfMbn2J8QEqcH3s+5YM/abt22n4rq1CKKSPI+oGXbK7yztdHcm/21KzHh6DT2XRIGqsrHaqo8SHpHdh9l264Ky505dgE+Fv3c0uoliONxg4uTgSCh38wCErudc+yHfZ5oQbib0yOmvDC3qKNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB10589.namprd02.prod.outlook.com (2603:10b6:208:535::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 15:01:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:01:28 +0000
Message-ID: <0c125c3e-001c-40fc-b2d9-7ef3c1d0451d@nutanix.com>
Date: Fri, 26 Sep 2025 16:01:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host and
 -cpu max
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com,
 philmd@linaro.org, jdenemar@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
 <87wm5lo37q.fsf@pond.sub.org> <aNaJl3J5dZEt6n4_@redhat.com>
 <70ff12c0-9ed7-4c19-a7cb-d14a5176d3f7@nutanix.com>
 <aNabaxWyioLXgfFH@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aNabaxWyioLXgfFH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a932798-84e7-4d01-4e0c-08ddfd0d91ed
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmRYV0trYjYvSlYvdDN1STIrSTFNZ1BROHFoOEdVNUVUNm5mWnN5Vk81ZC9F?=
 =?utf-8?B?NEpxZUptYmNHbEJtZkFtM2NBUzc1SUN0V0xmWkF5QUNUWm9UVDBGRTEyVWRn?=
 =?utf-8?B?TUQ3Unk0K3JxZzdUWlRQZ1UycWIybFFDSi80aXZoYi84ZldRRFZGNHl3MmVZ?=
 =?utf-8?B?T3VXWWdCU3J0dWVTTUNxRTFWRGhoU1M4NzdWRHZGWDB0bVk5NURRbnJxemxs?=
 =?utf-8?B?SjZMZkZQWDJEa1crRnZjaTE3UUxxS3hjR3AyQ2FKazJoaXpmNTVhamhMZFZi?=
 =?utf-8?B?Qzc4ZTlCdDlvcy9LYll3RHBNYlNzakQvbDVrbEd5cGIwTTU0YTdmYWh4aVV2?=
 =?utf-8?B?UDAvQ21Rald2VXREU1Zoc0RPd2RiSEw3OEt0WTNNclpFZUtYQ0lRZDVCNlR6?=
 =?utf-8?B?M2xzQnI5M2UrZUZ3WS9GZDRTekhhb1RqV3JSNitXQld6YVhZNkMwZUNweHFM?=
 =?utf-8?B?VFFXRE1ZWEVBT2RBT3ZTWTNYWUxacXhrQUJkblp4alRaQ2pHQ2Mwd0ZDQmtO?=
 =?utf-8?B?SlVLNHU3YkZrcElDM2JzcklLeVhBK0t4a3ZSZmtDRmpTa0hNMG9ZbVNGS1NI?=
 =?utf-8?B?RHcyZTZEWEFiMHN1dTR3Z3dxVzVUYWJncm96QXlHbHU4RlBIc2xoeEM5Z0hS?=
 =?utf-8?B?QituRHJRQ0dPKzlBRE8zY0NXbzV0YWQvVk9iRDZkajBBWWFMVmwza0Y0Tm8r?=
 =?utf-8?B?VXpDdnphdm4zU04yVEV2YXk4RnJxV2VzeFpnNzFLUnQrNzhvN29SMjdpWGlj?=
 =?utf-8?B?b3FGQko2TEE4MDh2MFJRMkh3YjRpK0FTeTBtVXNhcUY0Q2hiaytlSCtzRm9o?=
 =?utf-8?B?dE9Vcy9GbmFjUjJUQ2YwUlBQSkE5NXZESFJqU0hYSnZrdzJFSDhXSWpadVhE?=
 =?utf-8?B?RU52SUt4VGJFYXJqR1NmMCtMcFVEY0lkRGpUSlFYU1RQcnBLbUkxbnJydENE?=
 =?utf-8?B?OCt1QXU5K01ESWo2QkFmNzVxbFBOMlo4WVF3cTN5ZVp2ZVBxTzdWYjdSQ1oz?=
 =?utf-8?B?RTJBRmFSU05XSmJXVzdIaU1jNXdrQ1U4ck1HckU1RHk4SDJtbVJZTjk1czN1?=
 =?utf-8?B?VFFoTDNCaGN2WnJQak5qRXFhNjFuMEFyK2t2TXBoRXN4VEVDeTRtMnM0ai94?=
 =?utf-8?B?MEx5NmdWZ3RkekMrYXg0M1VKZ1JMNUtEVVYrSHhXU3NSMzY1c1FISHFJd3lL?=
 =?utf-8?B?cm9pQUFHTjBKWkl3L0hma3lkRE9haklBUkVuMkVPbDI0bnFUMmNaZk9JR0w2?=
 =?utf-8?B?bnduYUJVQnFpQTJJYlRDQ0dQeVE3ZXFmRmxJTkg0bzJrRU8wMmtMNkNCNGpM?=
 =?utf-8?B?SUwvTUZ3TFNiZERDYyt0a2RGc3FKem9WL3MyTUNTdmd0RHRDU3hrcHB0N3I4?=
 =?utf-8?B?akdRNTVYblRVdGUvYmY4djN5VCtQVHdvTG0zTnZZMEU5VTQ1cmM5UWRxR1pX?=
 =?utf-8?B?SDNDQTRwVjQzd1RWeWRBZjRScER0am11NFd5dXRySUFEdHpsSkdOUHpVYjda?=
 =?utf-8?B?a3N4NjN6TG8xTU1VSnNqQjVjekc0NS9yQ0xIUkFsN2Mrd1JSRGJBZ2x6WDJR?=
 =?utf-8?B?eTRCVnhrQTc5bjhwRlFEeVNHRXZ3MXpJOWIyaWlVWlJ4SHdQZ01YVExPUTNy?=
 =?utf-8?B?K21va0lpT0t1TDRlRlFSdnJlS2pnZ3VTSnRIb1ZMMFR6K2tqVXluTkFicTJv?=
 =?utf-8?B?NFpTa3FsUzV2ZFJDYVljYTdkTEtGaDVsTjYzQ1V1TmVFU0RrV1hKYnpqZFJL?=
 =?utf-8?B?aURHRVhaaCtEbXh1ZXdPVUFwSUZabjBuZkNFdmZuSVRIUlgrYitGQmJPV280?=
 =?utf-8?B?VURtME9tOXAybXVJY0dRT094b0QySTh6eTloMFNiaWNka1N0dlBEejN1a1Bw?=
 =?utf-8?B?Y2cyUENMR3Erb3cwYlY5a0gvVHdzTWxBdDRaTG8yL2pndzRVbktQUzdSaVhS?=
 =?utf-8?Q?xtPcyFVUQ84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0J1amZmbEN3RUQyc0ZtVExvRjA1cXpYK0NidUxyRU1zMFNaSzZWdjFBMUtU?=
 =?utf-8?B?RHc0OW5sRzZsQW8rWGJ3bEVIdUVOR3BmTVIycWZIWU1RUWlRVkxlMmwzTVpq?=
 =?utf-8?B?WWJya2xGZzVsMjg2aEs2dVBRckE3QXNvL2NvSzZlM1FJdlFVbjBnQW0zZHd3?=
 =?utf-8?B?bC95SnE0ejArbDhxMTZ1UXc3SHZxbTc2VWlONmlIcEpWOTJPN0lXMk9UUXd6?=
 =?utf-8?B?U29vQjVrM0x4SG5MSFkvR3hqWk50Wk4wcjVSODBXSW45d2xjcEF2Y2c3ZXBT?=
 =?utf-8?B?TWhveU5JUDY5Z1g3TnRKV3NQamNJVmt3blYzZmlRbTU0cWVXUlhVZUZzd2lK?=
 =?utf-8?B?bUJ2N29HL2NTK0FzOG1td2REczErNnhBcUI2ZXlIeFVjbHpMSGlrRStkNE5m?=
 =?utf-8?B?dUJaSWlZVFlOWW1BNk1qeFhGSk1iR2dEQmtyM0d0cnBKVXIxVTBRVGNxNzRT?=
 =?utf-8?B?aHo0Mm5qUEhIcFZjcWpwcmVhSFVHQW9tK2w2Q1NIUHZSdkh2akhyV2pMbVZF?=
 =?utf-8?B?a2RFV2FzTURkU1F0a25JSGY3TDB3UzFOUFlyWGZNZU1rZjN5VVd4RVdQL3Za?=
 =?utf-8?B?a0s2SjMwN3l2VlVoZ2x1ZysrYm9wTEZ6cTgvSVJtU0RyY1BaYTJBbHFsKzMv?=
 =?utf-8?B?WG40S0JvdW9nN2piaStZVW52a2NSaGRFS3VKVUw3dCtkT3p5QkhXZGM4aUUy?=
 =?utf-8?B?L3VuT1UwRHE4MkJhK0FTbElKdkEvcjNhelZkZ0t3M2NnbHFaZ0NTNG1TeEZo?=
 =?utf-8?B?KytHYkdvRjlqMlhGbkxRS3JZL0FBOHpHa0V0Y1BHdzdhMzFINkZrUThYWnRu?=
 =?utf-8?B?NEFWVHl3VXRuTFdBTStxYklNbmtFaVlPZFMwMnVDaGsraUU2eTFlOG1MeTFN?=
 =?utf-8?B?bVZHbUVtWi8yejZMK0JsOU5STWhza3dYeUk0NitBZVhUK0VMR3B0QTFQWi8v?=
 =?utf-8?B?MHE1T294bksvNHhiY2ZmRC9PSFlDSmJqY2RLNkJwYk5hcEQ1c3oxZFRTNitz?=
 =?utf-8?B?WS9DcHpJeUI0VVVubGNnUU5VUG94SW1Rb3orVERMa3haU0xSNnlsaTdmczV3?=
 =?utf-8?B?NnJ2OWdRblV3ckZZWGNOeGY1Y3BFbnd2bDV0c2dlbGlGQ0d4VzQ5VkJRd1Q1?=
 =?utf-8?B?aEdkYXdCc2pEelFkL1ZjaEhBT1EyM2tpU2Jzb2EwMEQzOGNrVS9lbFpJdGxQ?=
 =?utf-8?B?K2dWek5OMGpKdmhaOGlNQk1CZHY5UFhCTXVNdGsvUmxPa1Nmc29sbkJUSUFX?=
 =?utf-8?B?MHRKM2ZsdEU4ZFZSRzA3ei92S1ZiTFhNelRqUzBaSnp3RkdvSjFmYm5ZUDZR?=
 =?utf-8?B?WFhJcFFUVW0xWmRkQzQ3RUJHMmxHbndtVmlnc0Y3cmYzdHpFdTFvV3dwTnVj?=
 =?utf-8?B?clFZR3F4dzJ4LzNSeUVtczBaekNheUdFQXl2Z3JFT0duM3FWVm52aldacHBM?=
 =?utf-8?B?UE9ab0p5c1BuamxTNUNtaFdXWk01Wi92d2U0cDBhQmVUWjFyQk5GWHExSmtS?=
 =?utf-8?B?K1MzRGxXdjRZdVRLVU04S2lKdFY2VHZHc0lXL0NaMWVLQjI5ejUvdS94OFZn?=
 =?utf-8?B?VzVyZnp1ZFpYYzEvVjI3TTFDemx3dmE4dUtyZXMybEdJYy9RbHFXajQ5NmZG?=
 =?utf-8?B?bTdRbmV1Q0tGZ2JDTXVvcWJMODZDelpXOEVZTWI3d2JFbzRXZS85dDAxRE1y?=
 =?utf-8?B?SXZQb09GMThkK0lhQ2RVNVlRTDIvQWxOMk40eENsZHVSOXB4TjdrOU1nb2t0?=
 =?utf-8?B?RzZmRzhrNTBhT3BwcSs3VmhqYWI4eFVBajMxSzA0aVorc3NSSHNPV3MyYzE4?=
 =?utf-8?B?NC9KS1dKeC92Z3YxNmNoRWFyVVJsb05HakhpTWg0R3F4Y2IxRGxRVXhtUzBh?=
 =?utf-8?B?cExoT1NpVEtPQWQrVnVHNnEyOWdZRlBzb1RocWNQOEJueUxoclpWck84WjlV?=
 =?utf-8?B?OWV1TDhpTnJmS3BTcXgzdjU2Y1cyRzVxZm12K3lqYm9LL1d2enRSZXg0SW96?=
 =?utf-8?B?ZHkrUXZSWUw5U3VhMEVHMjRPbDQxUDlSOHFHQ3cyUWtTY1pMcXpmWUMrL2da?=
 =?utf-8?B?QTdoUjBvcVV4ZU9CQXpDRGNVcEdmVnhLNmdQVWp2RnF6ZWUyeEJXdi9HZG0y?=
 =?utf-8?B?NFB3bExjWWFCamtTUEkxdWdTYVN0V1NzVXhPanE4VXJHNkNWa0dyRmkvUnhz?=
 =?utf-8?B?cG9Fejg5c050V3ZPdEREbE1jMy94VW9rWGZyVWEvUm9yZWdmUGJCQ1BxZEJ5?=
 =?utf-8?B?bkFSLzNWS1BsRGxsdmNWd3RTeUl3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a932798-84e7-4d01-4e0c-08ddfd0d91ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:01:28.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNDLTUumobNObusIRdJmsFjkxshnd3mV50VQEeRdGQTi76hqLxZK7iNFVtxEiBRuxVCjOPer+qAgamm1qujLyYwP2MZhOLLdm0qKIIctuyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10589
X-Authority-Analysis: v=2.4 cv=GOQF0+NK c=1 sm=1 tr=0 ts=68d6ab6d cx=c_pps
 a=ebY7fRpV/2+SmvP/Q3YtXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=DjgpRKvh4HdIWYhnZE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 64J_TTV6UrsFPL5jqB_NjqKA1HWiwcsD
X-Proofpoint-GUID: 64J_TTV6UrsFPL5jqB_NjqKA1HWiwcsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEzOCBTYWx0ZWRfX99LLAtbAf3s6
 FkYg1zXdqxGA6zLRsSOdfceR3rsUrzHN4PHUq3098HruSE9kYJViPPEUVgc6+/25+rRguYuzYki
 MFk5rFwnLvBXisZjaIi3DpY96OrDVv476hdjF2/WtxvLbQ1qH+zOAKl6Hrcm2oqKjxm9LVnlLrO
 zLODiaRKAYHFYIdQQcfhZtll51MifY3cLaM8owvqFgACURvAYivC3hzeXsDMRAchs+bIwfxwKcz
 qCjf0qd9NSoF5JvGWQ+bBj3CCrXbxFPPLZ7/sz3lLG0gq1bjL6QDYWB5OTyrD0HIrINn6xcLJzP
 RxWL6Ovxzpza+hHfNaUM9PZjGrV7eYcgV/xS7+rYYuyWOvQ8f5R+dJhHJJuPNPquxPNbk9EVtxA
 EiPqC3G3OojNcfJUejCjAZ1eN9NFDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/09/2025 14:55, Daniel P. Berrangé wrote:

> On Fri, Sep 26, 2025 at 02:49:00PM +0100, Mark Cave-Ayland wrote:
>> On 26/09/2025 13:39, Daniel P. Berrangé wrote:
>>
>>> On Fri, Sep 26, 2025 at 01:36:25PM +0200, Markus Armbruster wrote:
>>>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>>>
>>>>> Following recent discussions on the mailing list, it has been decided
>>>>> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
>>>>> it is preferable to disallow them and use the existing valid_cpu_types
>>>>> validation logic so that an error is returned to the user instead.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>> ---
>>>>>    hw/i386/isapc.c | 27 ---------------------------
>>>>>    1 file changed, 27 deletions(-)
>>>>>
>>>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>>>> index 44f4a44672..6c35a397df 100644
>>>>> --- a/hw/i386/isapc.c
>>>>> +++ b/hw/i386/isapc.c
>>>>> @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
>>>>>        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>>>        int i;
>>>>> -    /*
>>>>> -     * There is a small chance that someone unintentionally passes "-cpu max"
>>>>> -     * for the isapc machine, which will provide a much more modern 32-bit
>>>>> -     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
>>>>> -     * been specified, choose the "best" 32-bit cpu possible which we consider
>>>>> -     * be the pentium3 (deliberately choosing an Intel CPU given that the
>>>>> -     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>> -     */
>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>> -        warn_report("-cpu max is invalid for isapc machine, using pentium3");
>>>>> -    }
>>>>> -
>>>>> -    /*
>>>>> -     * Similarly if someone unintentionally passes "-cpu host" for the isapc
>>>>> -     * machine then display a warning and also switch to the "best" 32-bit
>>>>> -     * cpu possible which we consider to be the pentium3. This is because any
>>>>> -     * host CPU will already be modern than this, but it also ensures any
>>>>> -     * newer CPU flags/features are filtered out for older guests.
>>>>> -     */
>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
>>>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>> -        warn_report("-cpu host is invalid for isapc machine, using pentium3");
>>>>> -    }
>>>>> -
>>>>>        if (machine->ram_size > 3.5 * GiB) {
>>>>>            error_report("Too much memory for this machine: %" PRId64 " MiB, "
>>>>>                         "maximum 3584 MiB", machine->ram_size / MiB);
>>>>> @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
>>>>>            X86_CPU_TYPE_NAME("pentium2"),
>>>>>            X86_CPU_TYPE_NAME("pentium3"),
>>>>>            X86_CPU_TYPE_NAME("qemu32"),
>>>>> -        X86_CPU_TYPE_NAME("max"),
>>>>> -        X86_CPU_TYPE_NAME("host"),
>>>>>            NULL
>>>>>        };
>>>>>        PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>>>
>>>> This reverts the "smart" part of recent
>>>>
>>>> commit e1e2909f8e74051a34a044940f90d4650b6e784a
>>>> Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> Date:   Thu Aug 28 12:09:44 2025 +0100
>>>>
>>>>       hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
>>>>       The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>>>       possible to specify any CPU via -cpu on the command line, it makes no
>>>>       sense to allow modern 64-bit CPUs to be used.
>>>>       Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>>       handle the case where if a user inadvertently uses either -cpu max or
>>>>       -cpu host then the "best" 32-bit CPU is used (in this case the pentium3).
>>>
>>> What is written here made sense from the POV of use of isapc with
>>> qemu-system-x86_64, but in qemu-system-i686, both 'max' and 'host'
>>> where already 32-bit CPUs IIUC. Both this original patch and
>>> the new patch block them from being used in qemu-system-i686
>>> which feels wrong given the justification above.
>>
>> I tried stepping through with -cpu host/-cpu max on qemu-system-i386 and
>> it's a bit confusing: I think we end up with some kind of custom AMD vendor
>> CPU but with LM disabled. I can't easily see a way to understand what
>> features are currently enabled?
>>
>> I must admit I'm struggling to see the usefulness of -cpu host/-cpu max for
>> isapc given that older OSs can be quite picky when it comes to hardware.
> 
> But x86 CPU vendors go to ridiculous levels of complexity to retain
> historical back compat over many decades. If anything, I'd be surprised
> about the opposite - an OS that didn't work with -cpu max.

It's not the CPU vendor I'd be worried about, but the OS vendor who may 
for example execute CPUID and become confused if it returns an AMD 
vendor ID instead of an Intel vendor ID.

What do you think is the best way forward? I'm still not convinced of 
the utility of -cpu host/-cpu max for isapc, so what if instead of 
mapping them to the pentium3 CPU we follow the standard deprecation path 
and emit a warning on startup, and then remove them from valid_cpu_types 
in 2 releases time? The advantage to this approach is that if people are 
actually using -cpu host/-cpu max with the isapc machine then they would 
at least file an issue in Gitlab and make us aware of it.


ATB,

Mark.


