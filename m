Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB7EDF150
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqrA-0007Q8-Gt; Fri, 13 Feb 2026 05:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqr7-0007Nn-FF
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:57:01 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqr4-0002As-HP
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:57:01 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9F7Hw3534700; Fri, 13 Feb 2026 02:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hYYrkuBuUgT9TWInM9bgYYOF3q8V/Mj4yQEcUOhqr
 /E=; b=O2rrExCfboVLYfN8rA4S59S65sfHIpMRY81ChWur9nORKX8wIlroGDffv
 +fR7XQg1AGFe+2PbUdVVGrcq6spd3br6QLt86DcO1PS367cdZhQ9smgpLj8SNT/2
 ejRWTQ+heVMKWToM+WjxH0WREFonD+t0pkxYkaiIemmY2ox37pwLEjId+G01BqKR
 /9PN/lCSbPld3cFuBE9hu8098GH6f4Ib1ySggbelgEmkEY4A2mBPFyU/9jpAH7sg
 jNupHGYnweEjAVPiJ5+K92nH7nn70S9+7aYDPZJgShYnuBFk/zBfQQ0eJH+rlHu7
 iETKK0SGB+lZn1KLgV4/Rpvc34Hvw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020125.outbound.protection.outlook.com [52.101.201.125])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d73bc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:56:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpTU/0y078xrmZU16GJq6U414ZTAc6os/gJMJkThBZui2kEhftZ36AEENuf5uHpoZr92M1b+4FyYUxAmCPFd517EbDfw1yUsOLKRGrOPagbYxDsKi0M19O5MbodI3HzC1TFxrNVuvhTuNa6hTnYzSGpu1h3mDZPgMVpUUPecbNMY2NWhpLEggkuJ/dwl5SoCnluY5swESiCEyvn16LgxWVdzrktmF0woL7C3/cbbtfY1/u/OO0VJBCyL4P3CAYnJ6r7UrLETDtL9vAGQWFmvHOi3kzQ551rNYWKeGQLJ0ny3guu7KS4c3bQkciBMgvDE712TyQvdJ9ZqceHqLoWJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYYrkuBuUgT9TWInM9bgYYOF3q8V/Mj4yQEcUOhqr/E=;
 b=R1R27QfiIznP4fBgJxPJhD8++wBzYMRcoOHsEM+nPb5I5PrCeEhjwKZAC2WLNPypaHyrn83RLfIvMq3sU4Q0T9KBGK3M7O3mO1F8aMffgcL62rhRdUy/dF9ec/asFHbp9qOHySjEJYKN8dgw5ghH7w+ICTVFvQWoJt1eTlvfJWSi/I2Vvi6JFAjY4tZlEbXqp5UIX+fgGuaRvGI7sboG+16JT8Pzoar8fE1xKMa1K6WCeMZJbcj9s5QbzGMD6Vsf93hbYWAbQ0V/9H0Gn1oAsimruuJFtEQCiokmKHs9liL0XjarLUqges5pNpU9xU4mGqjfbEM/MZao6igsNm/M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYYrkuBuUgT9TWInM9bgYYOF3q8V/Mj4yQEcUOhqr/E=;
 b=wE+jXjE+vMdtabX76ol8qgZIhW1GQbzoIhNQ3ZoIAoK/Lx1JgENpEjZKst3Ze/7MI+4NfW+jPua7YnW+BLRkxkytxt0L8/19eji0F3+TT/MYeIdZlDGYjtp7yt/ivZKVu99v9tVgPUq2w5u31al+bZJAQrxqEK5PJiK+Y8nFCi11COpYfXLo7GlF5xLfSS0ANVZ+38yRWCTvde0THYYwLJz24kVwDIfj1oc6chOHxtO1huDzgUf3za1itYoKI9Hr2sfoRsxH1pNXiluxqyg8VHmKiCYfqWGvUjaD69ggNwpg/XQDkUPDKyL2Si2IKfpw4Hiu3mKKlngNapwHrVO0yg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11162.namprd02.prod.outlook.com (2603:10b6:8:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:56:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:56:46 +0000
Message-ID: <9fbdc0ff-4f81-4f4f-919e-4fac56d4dd4d@nutanix.com>
Date: Fri, 13 Feb 2026 10:56:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/43] audio/coreaudio: replace custom logging with
 error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-20-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5304be99-3e77-49dc-cb88-08de6aee94f1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2FsTzM4eXZlVGxXbldkMXNpM2pUeGxZa2lhQnhCb0NhVUhoMnVNK3FmRDVy?=
 =?utf-8?B?R2VKN0tQTGNabTQ4RER0cWcxNXZQZlNlaGZVekhBWGNjT2V1bTlJTWtDcHJp?=
 =?utf-8?B?dnVaZUY3emhEVDd1cjhnVHdyN0Y0WjFYcnNOUGVPcHNzWkhtcDdzdkdGbnRr?=
 =?utf-8?B?OUsyc3VVUVljVE1TNHBZdGtKNVBrd3ZVYnNhUDRObzdLaDR5Nis1dG1rUVM5?=
 =?utf-8?B?NnZvRVVJNEF6T1prRitHeDQveFhwYTRjNUZ0TFJnWURIekJ6NXhsT2E3ckhw?=
 =?utf-8?B?Tk5uQ2FGbG5nQmFScVozdm9UaURPUUxEanZueEFjYUtuRnRESWVlKy9ucEcv?=
 =?utf-8?B?RllCYTFhV3dTOFBsVGFqemFxK0c1amZBY2dhSzF2TmVFc2ZVTFpDRjNpK0J2?=
 =?utf-8?B?dUQ0K2wyU01xQzlOZGNYSVJUZ1NFdXAwcEsxM2tZN1VxYytMZFE1MU04cmdL?=
 =?utf-8?B?RFBFSTE0cy8xWGIzTit5WWxVUi9icDZwY0p1VmhTT2x4TmlydXRJbHV2bGRn?=
 =?utf-8?B?QmlZMEJJRFhqVHhxb3ZYYlRJWllrb1RySE1DV2ZGbDZaOUZGbnlPMzRPalVX?=
 =?utf-8?B?NUF2QXFnbDZ0WUpybS9DVkdMbzl1STR1clRWZ0M4TXJKbS92bTQxZVgyaW0r?=
 =?utf-8?B?K3Jwa0Z1dnZOYjd1dzhSSjdnbUt2cGE4bGZ0T3c3cUpMMFJ5ZHNvekNJdFAr?=
 =?utf-8?B?VkFxQzBBUUF2TmlQSk1Ec09SN3cvU3RjS2lMQU1xK2N4NmNjMHpjVzZoYU92?=
 =?utf-8?B?V3BXNk1kT0VsN2VwL1RkVUpkOFA1ckZpb2N1R2p0SnNKNldIUVBtV2xqbzhn?=
 =?utf-8?B?WjlDUEg4VXR2Sm5DOE56VDFsdnNITldudWRCQ2FpN2NSbmFHTlg0SjB6aG9J?=
 =?utf-8?B?UXZ6REJVNGQ1QVgwdkwycWFVOGhyZHFuaUozZXBPVTFqVnEvU1lNcnJZNUVa?=
 =?utf-8?B?dVM2d0RvZUE2M3ZQUlh2QjRjdWtvNStJaXorVUFSUmJLUy9Zc1o5MzhUbWJK?=
 =?utf-8?B?QzlQeWo1SHZzM05ja0l6NUUxcCtidzR0aVZBS0ZmR0lPUnFOcG1GK3QrdGdK?=
 =?utf-8?B?Z1UvWXdwV1RHTWtWUTMzZHlFWkJrVWxJTmovSytvTUdyZE1BU2lUMjB2blVC?=
 =?utf-8?B?cmpCeFdhU2RMeWt1S0xGNjgxdW1OOENNNGtOWmdjalRhbjlKMUV1aklaN3px?=
 =?utf-8?B?dmJ6ZndBeWZNTFgyVjVzTTRCOE82dHpES2ZhUytNaWhBL2pFbWU3a1lQZEtP?=
 =?utf-8?B?aEtuMEJ5MWNneUZzcU96eFhVTjlRMGx6czRUV21uYXJGbjFZWkNRYnQ0eEtT?=
 =?utf-8?B?Sms3RkdvOHE3bTNtTjBUNVk1ZGtPbzBCYzVCMkNWMkR6Vm1nWFlaWVRBMmZF?=
 =?utf-8?B?VmoydVYzamtzK242ZHFxKzIzV2JCajMxM2dqQUJIWnZscFo5R1dNdVN2TDRH?=
 =?utf-8?B?ZlMzUTJhUUpkbUNFSm1YNkJ5QzVkUjRVaHdpY2ZkTW0xMnA2V2p2VGVDZXhO?=
 =?utf-8?B?by9EdlZqS3MyWS9oYzN0R2RiT3RZWkVTM2ZIWUR6Zm10NXUzKzN6UGJZWUNp?=
 =?utf-8?B?YnFFVDhvWTNVVzFuY3VaTXFXeTNmdEZnbWlOb3Vvbk9FS3REYXFaRmpqV05l?=
 =?utf-8?B?cjhwS3k1T2NKcGZ3SGZrMDhqWDB3UXZRelZCV0VLVWdjSUtkT0VvVy9aWklP?=
 =?utf-8?B?NVpHZ3Q3ckE3TE1OU3FzRzcyclN5eTNlR09kN05WTVZlUVJpWjVyQ1Axb05B?=
 =?utf-8?B?cnh5RHNKenY2S2diTEhrSFIvQ280TnUwNVRTLzI2aHFRdExmaVcwbVJuZkpS?=
 =?utf-8?B?V3piWXAxekN0QW9pUFkxcVJqL2U2Q3ZXNjBUWmQwek9HZjFMN3NjS0pZZVI3?=
 =?utf-8?B?YlRBRFFKaTU1QWxmb21JMFY1UzFuRzJXZjhPMlBzUEdlaDZ6anRVZy91RFpB?=
 =?utf-8?B?czN3VmtacllPSytjUU9PWCtYRzVKZCtWeU9KRjNsb29DNzRqVjdTZXRUUkFs?=
 =?utf-8?B?bFdvakw4YW5rSk9nY21NUWU2dkU5cFJhTVlObldsZXA0Y3d1QjNiaW93Tzg5?=
 =?utf-8?B?SHpXZGU0SzJ4OC9kQUUvUXh2eW4yUHFvUXpHb24vZzc3SUduTFZBVFcrejZz?=
 =?utf-8?Q?NG68=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHJkNUJucEMwMW5rQjlLTk1aMmxsKzVPTkkxYmZ5cjJRdUhPcTYwbE8zUWhI?=
 =?utf-8?B?VElrODFSNWVhSG10TU5MazhCUjFZUjNRMWRxa0hNYXFRRXpGNFhDVmdlQmNF?=
 =?utf-8?B?a01hc1JQalQzYmd2azMycXFuS29sUmpkQVJKOUZ5SENQZEl4REFHWFlEV25J?=
 =?utf-8?B?VDE0d21UcG53Rk5MeGV0L0V6SjdETzNEWjJSVk50NlNTQkxnaEJJZlN5OTh1?=
 =?utf-8?B?V3cxMTUzVFZDQ1l2enE1eG9ZT2FPSHlITzhmaXcxYytubUplY1RwTG9hc1ZJ?=
 =?utf-8?B?TnhlZmd4YWtpcjBSVG10OUN6QVAwWm4rK3h2QWFvN1doUmtZYTNDckJ2akZ4?=
 =?utf-8?B?UTRtb0ZYTXBoT3lORkoydEhhNWVkUHRqUndEVHl6aWY4Ky9ETVlJbEdzK0pa?=
 =?utf-8?B?Z29XZDIxS2YvSThSTnJDZU5DY3VBQ1I1alZ0WXFrdjhSanRrQWZpRFRPZ2Vj?=
 =?utf-8?B?RGlHdldmWDhCcTk0cTBHQkc4M0VTeUZtYzZDUDUyTzFoenBYS0JsRzRKVkVw?=
 =?utf-8?B?dXpsejNwUDJZZ0J4YSs0Q1kvaVprRVBxT3NUd2FxNmVsMk1wRmk0Y21BNk5T?=
 =?utf-8?B?SkZZSjlRUUNzcWo4SEgwQVNId0g1ZE91Um5wK1ljb3dHS091bHo4eG5jY1Nx?=
 =?utf-8?B?cFcvS1JmaWxMRlhFQjYrcnlxOXZmZ3pFNFQxdUdGNnJpTkE1ajdYeVNzNDQv?=
 =?utf-8?B?MnBCSmw0eXFCMUpkUXJSVzVJRVRTMWJBZmx6UllHZWVETDV4dlZhaXJEbEw4?=
 =?utf-8?B?aklhKy9NY0c1UWs2bllkTWF2RE9HM2VYQXNyUlRkMHM5NVd3dlJTUWNwVE9u?=
 =?utf-8?B?RTlaemI5NWxzY1RmbVlYS2JFaUYrMGladHVkeUVycUxSQmloMjFTRTdIMEJt?=
 =?utf-8?B?QXZkMDdrdmNSUW1FMDhteWFmcHBLcTlhRzZMTTNGbXVOdTE5Mis2cTRteGRE?=
 =?utf-8?B?SE5oL2czM2NMNmdVTm5CZlEyNktrb2c2Y0lPVEU0ZzRwK0dNQWpkcDNaNk42?=
 =?utf-8?B?d29WYXUxQUpheGNFbGhGTjNSb2Q5SGJRUlExdmNqYTZhTTFadlV6NHYxcVFK?=
 =?utf-8?B?cEh2Y0E2MEw1MGQvNzlRR2V0MlBqNHo1VHJ6Q0h6T2w5b2p6K3ZBVmlEZUUv?=
 =?utf-8?B?UWQ3SlJYS3J2U1Zna0s5NzlGOG1VQUVyNlhudGpnSGdXQjExYzByTHNydHl4?=
 =?utf-8?B?Z2l4Vm5CT2hBSXNSaC9QaFVRZEhJNXYyQWhXRW9BNHhNeVB6dmpXak1zNmYv?=
 =?utf-8?B?UTAvVlBKQ1hSenBpamxZN28rQzBuelV6MDdTRGxaOXFIZ3VUUFU1ejBBblR2?=
 =?utf-8?B?WlpFTnRvRnB1VVpTaW95dGxtdC91UnF1TWtsb25jMlM3cFBIZEZGaUg1cGN5?=
 =?utf-8?B?ejRUeEhSMDdpb1hMejBZZ2xMeTVoTXduM0hQb2tRdUhINSt3a2g3M2pNVDdY?=
 =?utf-8?B?WlYzbFdIbkMzQ1dQK3MxVkRTbnBZUjNNTEo2Ukl6bnNWT0hpa0FTV3dzKzc0?=
 =?utf-8?B?VXhHWmpYTkMyanNBRFh2TGRBbUY3MmdHVEF6WGxBM1N6MTA4eHpPdldidHJz?=
 =?utf-8?B?cURlMGQ3Sm5ZMW4zTW9UcVBRN1hLbUtlaGNtU0ljQU1wRXR3bzh5NEEreTVM?=
 =?utf-8?B?SnA1bnBTVXVYMnBMb3RPRUtTV05SZ2FiNUhEREEvOUdSTlBEM3lGeWQxdTRG?=
 =?utf-8?B?YldMa0JjVHR1ZFBUUGpZZ1picXZXaTlZK2hxdG1sc25YeHd3cnZXZ2xVaUlx?=
 =?utf-8?B?bEJ2all6QlZtQnlTTkJxbFlRVVFRa1ZqT1NTU2ZyUW82blY1STFYYWN3UUVr?=
 =?utf-8?B?R3EvWDV5Q0RMckU4K2QrYkkvNmpNcTduam8wYmIzTGNHVks5ZUswL2RTbWE4?=
 =?utf-8?B?NjMxWnoxTkhReWF0aXkybHhvQ2V0Z0VLaW0yUUt6UWVUd3NZcExkc3ZwSFJv?=
 =?utf-8?B?ZHZnSFltWjVTclB5TmNjTHRHR2xPTWNDank4SVZsejU5ZUowY2R0MmhrQ2h1?=
 =?utf-8?B?OUJBZXJqWnhFTDZKclpQVW1NaExTOUtkMnNRcGVKV3dRVHNtdXRFZk4xNXVw?=
 =?utf-8?B?RDNtK3pFNU91cWdFMXpmMWV3eDBNN292QmdobmxEaXpaODk3cUI3WGxTSXhu?=
 =?utf-8?B?RHlHT21LWmx3NjlleWx1Y1g1QklMZGp0bmE0NmVmN1ptdHo5QTZlY0x1TjlO?=
 =?utf-8?B?N0dlTEV5WnVuLzd5YW9wdCs1dUpCcDFRQm8wQW4ycG5vM2JrMUNJRS9rOW4v?=
 =?utf-8?B?aFVtV3JjT053YStDL01sTHBCTUFrTGE3QW9DQUErb1dCQXMwTTd3SUx6WXJt?=
 =?utf-8?B?UnZmMjJPNEQrSE9UTHBPcDIxUXh1MlVtTlBrVXVNUHJHWGIyRXZOd21XaUZQ?=
 =?utf-8?Q?1F9SdgR2IktoQhLE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5304be99-3e77-49dc-cb88-08de6aee94f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:56:46.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck1+O+/XA1FqFPSe60LLfIVQf/snQojm3dxb9TsvRtXLA7Gr3jz6IW8USR51ni2JOanKbHqPFoAs6Ms3I04X7wQZBeyFpOO9Zg8d5K8Dvek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11162
X-Proofpoint-ORIG-GUID: bFkf5_XkpjiCixmLsmUDoP25LtEfwU6U
X-Proofpoint-GUID: bFkf5_XkpjiCixmLsmUDoP25LtEfwU6U
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f0370 cx=c_pps
 a=kB/eTyLYv2HckPafvHZuPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=njkWeBufDIUr-Q0t-jwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NCBTYWx0ZWRfXwFYQBrxCCpGW
 sgK4L/6jR55D//yInIYGj3MPoNbJfYLGlCF5nbbYEMBANaNbZdgHimFKxj36mE6spdCjkCTR22y
 k+1Gc+aiXCx0hM2wNWYGVNJ0uikMiXZa2TFYnNaI7q77QFiWFtj8IO07EJTcx/4Fkdn4Bk5lH40
 IAfSDk+V+F4Iq0aHLYDFIr2cKfqoh1EzAhQ0tezRwPTXn5IL1qBqegl0iDDOF2RbAlV+ml4bN4Y
 Afzzj9AxFts3Dp2CDL+/q8Es/8Ss4HeoVYY4VdCsOf2dI5URYpYM8BMC0itqH04xD9eCN3l/20A
 0nT9kd7897eG8Wo6jz59ahCvx1z6G3Kr1qUvTz0PV4K9I0K5flc5r3036QWMhpy7nMHNO5UOQlW
 QTqgJtnsgOo6Cpc2o3+Hxdiy29oh8YaZETHp/i/hEffrbfRU3m+Sw1oEm0nQIZna0yikzS2foja
 RVUXc3hfeewbyBODhOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The CoreAudio backend uses its own logging infrastructure (AUD_log,
> AUD_vlog, dolog) and the AUDIO_CAP macro. This approach is inconsistent
> with the rest of QEMU and makes the output harder to filter and
> configure.
> 
> Replace the custom logging with standard QEMU error reporting:
> - Use error_report() / error_printf() for errors
> - Use warn_report() for non-fatal warnings (buffer frame size
>    adjustments)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/coreaudio.m | 124 ++++++++++++++++++++++------------------------
>   1 file changed, 60 insertions(+), 64 deletions(-)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index af614144bd1..40d7986b1d7 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -28,10 +28,9 @@
>   
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   #include "qemu/audio.h"
>   #include "qom/object.h"
> -
> -#define AUDIO_CAP "coreaudio"
>   #include "audio_int.h"
>   
>   #define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
> @@ -157,7 +156,7 @@ static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
>                                         result);
>   }
>   
> -static void coreaudio_logstatus (OSStatus status)
> +static void coreaudio_logstatus(OSStatus status)
>   {
>       const char *str = "BUG";
>   
> @@ -207,70 +206,64 @@ static void coreaudio_logstatus (OSStatus status)
>           break;
>   
>       default:
> -        AUD_log (AUDIO_CAP, "Reason: status code %" PRId32 "\n", (int32_t)status);
> +        error_printf(" Reason: status code %" PRId32, (int32_t)status);
>           return;
>       }
>   
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", str);
> +    error_printf(" Reason: %s", str);
>   }
>   
> -static void G_GNUC_PRINTF (2, 3) coreaudio_logerr (
> -    OSStatus status,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(2, 3) coreaudio_logerr(OSStatus status,
> +                                                const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_log (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    coreaudio_logstatus (status);
> +    error_printf("coreaudio: ");
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    coreaudio_logstatus(status);
> +    error_printf("\n");
>   }
>   
> -static void G_GNUC_PRINTF (3, 4) coreaudio_logerr2 (
> -    OSStatus status,
> -    const char *typ,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(OSStatus status,
> +                                                  const char *typ,
> +                                                  const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
> -
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    coreaudio_logstatus (status);
> +    error_printf("coreaudio: Could not initialize %s: ", typ);
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    coreaudio_logstatus(status);
> +    error_printf("\n");
>   }
>   
>   #define coreaudio_playback_logerr(status, ...) \
>       coreaudio_logerr2(status, "playback", __VA_ARGS__)
>   
> -static int coreaudio_buf_lock (coreaudioVoiceOut *core, const char *fn_name)
> +static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
>   {
>       int err;
>   
> -    err = pthread_mutex_lock (&core->buf_mutex);
> +    err = pthread_mutex_lock(&core->buf_mutex);
>       if (err) {
> -        dolog ("Could not lock voice for %s\nReason: %s\n",
> -               fn_name, strerror (err));
> +        error_report("coreaudio: Could not lock voice for %s: %s",
> +                     fn_name, strerror(err));
>           return -1;
>       }
>       return 0;
>   }
>   
> -static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
> +static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
>   {
>       int err;
>   
> -    err = pthread_mutex_unlock (&core->buf_mutex);
> +    err = pthread_mutex_unlock(&core->buf_mutex);
>       if (err) {
> -        dolog ("Could not unlock voice for %s\nReason: %s\n",
> -               fn_name, strerror (err));
> +        error_report("coreaudio: Could not unlock voice for %s: %s",
> +                     fn_name, strerror(err));
>           return -1;
>       }
>       return 0;
> @@ -378,12 +371,13 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>   
>       status = coreaudio_get_voice(&core->outputDeviceID);
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                   "Could not get default output Device\n");
> +        coreaudio_playback_logerr(status,
> +                                  "Could not get default output device");
>           return status;
>       }
>       if (core->outputDeviceID == kAudioDeviceUnknown) {
> -        dolog ("Could not initialize playback - Unknown Audiodevice\n");
> +        error_report("coreaudio: Could not initialize playback: "
> +                     "Unknown audio device");
>           return status;
>       }
>   
> @@ -394,17 +388,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>           return 0;
>       }
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                    "Could not get device buffer frame range\n");
> +        coreaudio_playback_logerr(status,
> +                                  "Could not get device buffer frame range");
>           return status;
>       }
>   
>       if (frameRange.mMinimum > core->frameSizeSetting) {
>           core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> -        dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
> +        warn_report("coreaudio: Upsizing buffer frames to %f",
> +                    frameRange.mMinimum);
>       } else if (frameRange.mMaximum < core->frameSizeSetting) {
>           core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> -        dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
> +        warn_report("coreaudio: Downsizing buffer frames to %f",
> +                    frameRange.mMaximum);
>       } else {
>           core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>       }
> @@ -416,9 +412,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>           return 0;
>       }
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                    "Could not set device buffer frame size %" PRIu32 "\n",
> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
> +        coreaudio_playback_logerr(status,
> +                                  "Could not set device buffer frame size %" PRIu32,
> +                                  (uint32_t)core->audioDevicePropertyBufferFrameSize);
>           return status;
>       }
>   
> @@ -429,8 +425,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>           return 0;
>       }
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                    "Could not get device buffer frame size\n");
> +        coreaudio_playback_logerr(status,
> +                                  "Could not get device buffer frame size");
>           return status;
>       }
>       core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> @@ -442,9 +438,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>           return 0;
>       }
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                   "Could not set samplerate %lf\n",
> -                                   streamBasicDescription.mSampleRate);
> +        coreaudio_playback_logerr(status,
> +                                  "Could not set samplerate %lf",
> +                                  streamBasicDescription.mSampleRate);
>           core->outputDeviceID = kAudioDeviceUnknown;
>           return status;
>       }
> @@ -468,7 +464,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>           return 0;
>       }
>       if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
> -        coreaudio_playback_logerr (status, "Could not set IOProc\n");
> +        coreaudio_playback_logerr(status, "Could not set IOProc");
>           core->outputDeviceID = kAudioDeviceUnknown;
>           return status;
>       }
> @@ -486,13 +482,13 @@ static void fini_out_device(coreaudioVoiceOut *core)
>       if (status != kAudioHardwareBadObjectError) {
>           if (status != kAudioHardwareNoError) {
>               coreaudio_logerr(status,
> -                             "Could not determine whether Device is playing\n");
> +                             "Could not determine whether device is playing");
>           }
>   
>           if (isrunning) {
>               status = AudioDeviceStop(core->outputDeviceID, core->ioprocid);
>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
> -                coreaudio_logerr(status, "Could not stop playback\n");
> +                coreaudio_logerr(status, "Could not stop playback");
>               }
>           }
>       }
> @@ -501,7 +497,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
>       status = AudioDeviceDestroyIOProcID(core->outputDeviceID,
>                                           core->ioprocid);
>       if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
> -        coreaudio_logerr(status, "Could not remove IOProc\n");
> +        coreaudio_logerr(status, "Could not remove IOProc");
>       }
>       core->outputDeviceID = kAudioDeviceUnknown;
>   }
> @@ -515,7 +511,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>       if (status != kAudioHardwareNoError) {
>           if (status != kAudioHardwareBadObjectError) {
>               coreaudio_logerr(status,
> -                             "Could not determine whether Device is playing\n");
> +                             "Could not determine whether device is playing");
>           }
>   
>           return;
> @@ -526,7 +522,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>           if (!isrunning) {
>               status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
> -                coreaudio_logerr (status, "Could not resume playback\n");
> +                coreaudio_logerr(status, "Could not resume playback");
>               }
>           }
>       } else {
> @@ -535,7 +531,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>               status = AudioDeviceStop(core->outputDeviceID,
>                                        core->ioprocid);
>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
> -                coreaudio_logerr(status, "Could not pause playback\n");
> +                coreaudio_logerr(status, "Could not pause playback");
>               }
>           }
>       }
> @@ -576,7 +572,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>       /* create mutex */
>       err = pthread_mutex_init(&core->buf_mutex, NULL);
>       if (err) {
> -        dolog("Could not create mutex\nReason: %s\n", strerror (err));
> +        error_report("coreaudio: Could not create mutex: %s", strerror(err));
>           return -1;
>       }
>   
> @@ -594,8 +590,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>                                               &voice_addr, handle_voice_change,
>                                               core);
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_playback_logerr (status,
> -                                   "Could not listen to voice property change\n");
> +        coreaudio_playback_logerr(status,
> +                                  "Could not listen to voice property change");
>           return -1;
>       }
>   
> @@ -606,7 +602,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>                                                      core);
>           if (status != kAudioHardwareNoError) {
>               coreaudio_playback_logerr(status,
> -                                      "Could not remove voice property change listener\n");
> +                                      "Could not remove voice property change listener");
>           }
>   
>           return -1;
> @@ -626,7 +622,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>                                                  handle_voice_change,
>                                                  core);
>       if (status != kAudioHardwareNoError) {
> -        coreaudio_logerr(status, "Could not remove voice property change listener\n");
> +        coreaudio_logerr(status, "Could not remove voice property change listener");
>       }
>   
>       fini_out_device(core);
> @@ -634,7 +630,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>       /* destroy mutex */
>       err = pthread_mutex_destroy(&core->buf_mutex);
>       if (err) {
> -        dolog("Could not destroy mutex\nReason: %s\n", strerror (err));
> +        error_report("coreaudio: Could not destroy mutex: %s", strerror(err));
>       }
>   }
>   

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


