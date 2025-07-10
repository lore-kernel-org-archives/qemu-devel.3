Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC1C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmpR-0004NP-8j; Thu, 10 Jul 2025 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZmpP-0004Jj-A0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:40:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZmpL-0000NF-4X
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:40:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7PLgI010291;
 Thu, 10 Jul 2025 01:40:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=tLlF56CmqDDajx/q/N2TCNQxeIHuxKNERNmbcuTsx
 m4=; b=v8UbhtYrAVHq7YjbNzjrcRpUctzcwOqLPza3wr8id9Uh99t3AsF0Z/IY+
 xl+zxXwZNjsoytdinVRXiLo0vCRUBAJxADiGFziKROY7zzhqVPm4MTDPUpeIJDEM
 qZLSEzaLScafggwwubEuNUn1Ae4rfyuH0eZGIE7vSOAX1/isU8PgdgQbiQ0aWkLd
 cDh/iBOYSvx0r11j6cit3tVnluD1PeYsp4gnyqzGykZVh0kX6IibzqC3FjD8C0fa
 1Zd5JfqNF7QAA9A+hG/sCCU/2zJPf78GKqMgbh6KnAF30/O4G9/XnxU0o2pKckAy
 Yyy0k3UYtFOYYIhreF6nKhOjP04pQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2138.outbound.protection.outlook.com [40.107.100.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkc5s2qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc8GSiJ0PM0Zf1INUOMfNqdqsKZGjPJ8shX1h/6pIsA58XjC3Om0JfjuHuHy4ATIkhF6LLKkIqeFZOIUfpdXZhPmjPWrxjClgG4zAa2oMXCokWgtspHRhdGLCZ74os5/Jt7xBhmmbnNSZoyNs/6ZvL77AFUQVB/EsbxDtzoSZt6VT4KGCMMSAx6V54St+NkzRC+4kWbR7552R05mV9UEqUtYrdiWWL3Z2GmNiokU+6F+zjVYzNrVWT+U3Ln4lUPWwW8GLG+BuL0By26ktAb2/B2zPUgi0SU7u7RTIEdyHjPB9NxWLLFSGPmyf0XaGEyyX83X6dA/SoLwXccBSP1RaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLlF56CmqDDajx/q/N2TCNQxeIHuxKNERNmbcuTsxm4=;
 b=MCMwdngSFlCBylCeowCF9qj5hOHhEYAVWbeK995cnldtOmCueFZFrS6Y4TQ6XD7rauPsHfSB+MNdNZAEquQfK12eAzhK6jFLKKH4msa18peXWUa+wxXMdRWNZAu0ymRfKRwxPS6jeEMgMtV5KavLmbVz32i8XKxRNWFBfIDm3wkIH81wdgEwPfbCgmNXOj6eff1aKtsBezL+W6ldy758KrMv4j6dPKoL/m8VYJ3l8UtteR9Wot7welF4B4ARAbvJoClV8o65mpbYmlWNlrymUS14Jkh9MneJ8f2c/BCv6MkVK8F9ate12UKXCCZtF7OPAGS18d9fJ1bODtanEnlTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLlF56CmqDDajx/q/N2TCNQxeIHuxKNERNmbcuTsxm4=;
 b=H+i3dAWPF+8enme6D7IsyXRI95ekHzcoL7z9WL+ab+MJiL7rL4RNPI8yfzNJg7yI8OAUS/lqKrXoiNAZR+zsidsevXzfTlOwz3NfSSZOiKz3flxnKYnaSkhtRBWIH3060wgpWcMzyW2gQy2jMAGiTi14L5sE1fiyjAwkj11pBBUambyRcIwmPBjk6BGa3Dq+KAavHc4lb/Hr8G+WlX4BL+z3vYLd7Fd9T/CVaEaRQ+JGwzQV/8KlvyUgpA0fyHa8DaqMTzhd1QsJRio6+UxeIhKKfabLVdoXTbCPe6c9ovA9Vll7GRuWydsMog8qALCGqGkvzqj+DOA4oadt0pnOlQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8366.namprd02.prod.outlook.com (2603:10b6:806:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 10 Jul
 2025 08:40:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:40:13 +0000
Message-ID: <f049b210-9f14-4fcb-bbdf-98408941545f@nutanix.com>
Date: Thu, 10 Jul 2025 09:40:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] hw/i386: move isapc machine to separate isapc.c
 file
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-15-mark.caveayland@nutanix.com>
 <7C9CE1C1-4B5A-4EF0-90DC-EF4FF9BECFAB@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <7C9CE1C1-4B5A-4EF0-90DC-EF4FF9BECFAB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::39) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d09e48d-f0af-4fca-ac55-08ddbf8d635f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVzOEwzaURhWkdoWlpEWnRBWG1hOXVpSVJ2N29WQU9sTnRyOHJBWDB2K25M?=
 =?utf-8?B?VzhiSkI4SUNjMVdNaTNqT1h3ZHlHVVpiU3hUQ3RMZEl5d1p4bUJqK01RN1RI?=
 =?utf-8?B?TFdJVlkrM1FSNWRIY0hoOXNsVXhPUnZodXp0di9FbjFlaEVqRG81SERIVi82?=
 =?utf-8?B?ZzN2QTlaamVKdGZjcnVUeTZ6aDd4dHo5KzFpM2RUcnBWWHQrQXlOcDV3WHg2?=
 =?utf-8?B?clhMYkZMQkVIaFJwOTdVRmVhTHFTTUtBRkI1dTFhSDRyd2FOcXhQUGtZeDdp?=
 =?utf-8?B?VE5zRHM3SWhRNTEzNkgwZHZxeG90WjJscUc4VU1aTCtNRU1LS3ZGVFloWmhK?=
 =?utf-8?B?TVl0R0swY1N0a0JodlhlR0Vpajl6WmpqUWlOSFNndHJtazJ6emZOQTJFTDRQ?=
 =?utf-8?B?bnc0NGJoeDBxTFZWZUNBclBBa3l0STdWMkxzakJGY0d4dy9lSXlYOEgrMUpk?=
 =?utf-8?B?VUh5Y05Jd3VLSzB6elgrdWx2TFlVQ2hjM21zMmZHQ0ZDU1VlWkZUUTR5VmRj?=
 =?utf-8?B?WGVvMkx2WE1qUDJYUEZQSS9sMEEzZzB5YVJtWVNpRUxFYlB3Ny9RS2I4Yksw?=
 =?utf-8?B?WHY0L2lhcGNETEp3a2ZWTW53eWdvTlFOUDRlSGUyUGgvTUpMd252eHo4NUNY?=
 =?utf-8?B?RlNIMCtDSmx3ZWxndTQzdDhkVCs3Zk44REtnMitBYzE5eEpwdi90K2tIU0h3?=
 =?utf-8?B?eFZOQlRwZ3lkUHE3OEZHSm9vbTZUNWVLcitHb3AyVklEYXJiUDBCOHFydm8r?=
 =?utf-8?B?a3c4WWhncnhlMm96RXBWZVBoUmlaWW5KZHZGbWNKS0JVQWZOMWNQUHIrNElV?=
 =?utf-8?B?czNiRXRYZGsyYWdkV2JCb1J0OG5sTUJlSVFueXNMZS95WVlRaGF6MC8yMnJ3?=
 =?utf-8?B?Q3hhRC9mL0RUZzRqVlNSRG4wOGYySjZGNDl1akZuUTBlbS94RzY0VHVPU1Nh?=
 =?utf-8?B?MUJkL1lDbDViOG9NTm9GWDdvVDV4UnAvSDBFWUhLR1dXQ1NqWEE5dUhMNzhp?=
 =?utf-8?B?SjQvcXlFSXBRcGswR3MwRmpxUDgrVmUyVEx4NWhENmlmeWpPRWUrYnZONmRv?=
 =?utf-8?B?RCtDWHBTTzdXUFV2YUUvSHFRQTVGNmtGVlY2VFF6S2hRaW8vdDVvYStWVEFG?=
 =?utf-8?B?MVovWnB0VWVXUEY3OENpK1p6QlJOU01uVndXMCtuNTMzeXNJMFFILzNJMWFi?=
 =?utf-8?B?azRqZkRaU3FNbml1VmdyakxudHdvMzlhcmc3Z2RIY1pXSmYzS0ZvSUliV0xB?=
 =?utf-8?B?dURkSjJpT3BPQVhuT2RKSTltem9PbFNTNWJPYTNxQWY5Z3g2S3RWdHVLdXE1?=
 =?utf-8?B?bzJ3WVRmTUk5RVB6WkNxSmUyVHNqemttdlhGb04wcm9vSkRGOHFMbXo1eXJN?=
 =?utf-8?B?amhMaWV6R0NzaCtZUkRhV1B6QWNQelJYcGJiZWtXdy8yR2hVWmFncmh2Z3JC?=
 =?utf-8?B?TGE2RU1iajJWZXczUUo4bjRrOVFvUGJkcVJ4MmNTZTFrMU0xUCtvWHVWN2ZX?=
 =?utf-8?B?aGVuY0t4bVZpNDNEZEtkcE9TdFY3bWlBelFiTU5DUEkwOFVSdFIvV3lFUTRY?=
 =?utf-8?B?YTUrN1JZYkZ2eTN2Q0tGcEJSZ254cXlNb1kxdXQ3K2pmSTB4ZE9NeUhJV0hu?=
 =?utf-8?B?UEJtcDAvSUpQQVQvclpHREJqTURJMUZBd3ltNTArWWdDU0MvRzZwOWpjN1ZV?=
 =?utf-8?B?QVhrOXhOTklyb1NaQzhnbWdMYk16TWp5Skp2cUgxQkIvZHJVRVNnZDU3Zkww?=
 =?utf-8?B?aldUekVFY0ROakNZN2Rsd1hEQ0RkNk5BaEY0c2JPQUJhdUZqOUFkbjVqOUd2?=
 =?utf-8?B?QXVydlR4THEzTUMvR0dOSTdiUll6TzFMTk1aUDZIUFJvMWlIQ0tGRnprN2Jn?=
 =?utf-8?B?MDdJckdsMFpNYjFaSzZMSFFBT05Jck02RjQ5aTl2amlQbDJoNkl6NEpTSVFC?=
 =?utf-8?Q?zZkrNPwnu/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJrWm9rSGQwMkljV2ZEeTNoaHJ4K1hWOVE2YkVlRXRhMUNjQVUzRUxjSFZq?=
 =?utf-8?B?UWlXeEg1cnVyNkF6R1d1b09UcExYWWRwL1ltSzZOM01oTHF6Smd4bW00OWRN?=
 =?utf-8?B?ZFh2SlZnN2hYTlF6dVdGVU96SXIzU0RDSEVOMUxPYVd6MkJ5SktrcmhOSEdt?=
 =?utf-8?B?RVRWQUw0ME5hSmxVNzEzd2hvZkZmZlcrYTRPL0FxbjlRSENDTnlXSEtQUjFp?=
 =?utf-8?B?L2gzRk9Xd0R3akQ0L2FKT1U0MTJmU0xpNjZySTVDdUpaL3NsN2RRWHFCc01W?=
 =?utf-8?B?dWdIMGtWdHk4ZjJmWWczZ3dVeXBpTTE0a0tScXUzaE9tVWVCaThPWjkwUEpS?=
 =?utf-8?B?SHJBQVVVbkU5SHorWENjMXdyVitzeGh0NXBVc2hmM3RQNjFmZ1Y3bjRaVTcv?=
 =?utf-8?B?UTQwTVljNVdUdGl2aG8rMzBSd0N6TzZldm9QT3pSVGpkZTh6UmtpLzBMeTlx?=
 =?utf-8?B?MFJLOGpPM1ZmTEpxNDkrMmxibzAxWDNlVkdaaUNRcDVtOGpwRWt3TktoV0pt?=
 =?utf-8?B?N0I4SjBrSzU3T2N1NjZGeTNRYnJXVjhtQXNaU21rcnpmRDZPSHpmbUlqT2lK?=
 =?utf-8?B?RWI3dlFtYjRUSVZ3dWhPZmo3V0ZzOVZtOTAwZ09KYTUwVkVVQm9ENmlpb0lG?=
 =?utf-8?B?UWk0ODd1clgwaCsyRVBHc0tiZU1vV0pXVnM5bEdTWU14RE04NzYvbVF1STFw?=
 =?utf-8?B?SzdxTHVERXMyVHlXdTZKWS9TdkFRTk9ZbklmdmFFYkpQallqeFl6WmVaUmpp?=
 =?utf-8?B?ekE1MnpnK1dSbU1pYi84TGxWdVlwWTNPOTZWUWY2VkpWeWlBMU9Cditoazkr?=
 =?utf-8?B?WllOYWowODFaSDFjdlAybmFaRVBOd09lY3Myb0hSQmpVZkJCNzVONk82RmhX?=
 =?utf-8?B?MkFpZzhBNGE2dW54RWhaOC9iVDN1V2h6V2I0VURkdEIzSFBHdTBqeEZScmJm?=
 =?utf-8?B?SFE1L1NpRmJLM2VLcmdhUEl3aFA2cjhwZjY3c2FEOEdFNm5jcFBZY0p4cTJ5?=
 =?utf-8?B?SlgvUVhQL210M0pObkhzcXVUejlpTXpzeUpVQkZ2Rk9ybWUyYTNkekdlVXVj?=
 =?utf-8?B?TlVORTZTSHpLbm1Ha2phUjdBaTdjNndjczFBMnZpanBXQ1RTVHJMaHBBNCto?=
 =?utf-8?B?QWNUdldZd1ozOGN2cXBqZ0s1YjJNcTk1eVdLWjh6Yy9UV2hETDNtZlJ0eWpx?=
 =?utf-8?B?OVZMMEl6M1pwMnk1aE5HSEdYNTNFRFMxNktCZytaMHAvUXNiZlpVL2tTMjRT?=
 =?utf-8?B?NjRXcmptSGJtVmlqSk9HN1JxS09haEFRRi9pMWpEbHBCSDZ6SzkraDF4aHJO?=
 =?utf-8?B?NnJJWFNIWWUwRGhhbTk2YlBNVmZIU1FvUnNrNUJZOURRdXBBSXkyM281Q0Rn?=
 =?utf-8?B?RUxJV0RDdjZPd0J5MjZKa3V3d3lodTNJYlBOTDhzK3RlUGFoQnZsU01QNUt4?=
 =?utf-8?B?b0hUcXBEVWVLZVZDVzdqM0s5SlZYQS9EeVZPRWZQczFFMWRDN21rT2xLZmRC?=
 =?utf-8?B?dHlqN2trWUJ4T3RzYjk3UTNseFlMazJNVEIvOXViTFJLMU1ycHhlbStEOWRS?=
 =?utf-8?B?L1d4ZWJPdTZQb2FGb21Wbm5QVlFiWldJWk1zeTU0NkVpZzJmbHF1cmRiMzJL?=
 =?utf-8?B?UGNub3l4b0dRMU5BMXk3bFdmZGFTYXlZS05kTHYyU3dsVVBuc1dIdnpVM3Bl?=
 =?utf-8?B?dVpqemkwYm5WTXNRVnNzNkprR0J5U0Q1OEhrU1RGMityNHIwMXFaZHVPQk81?=
 =?utf-8?B?NFpZSzZqYzRSdFNVL3VpTERVdnpRZ2dnZ2pNWFhhVzNmQnNna3JZSitFdm9n?=
 =?utf-8?B?L3pTQzVSUVc1VjRoZHNSNGxWL2QvTkFxbG9iTit4NWZQeG01WXNjZXpFZHhU?=
 =?utf-8?B?eTlUNktHY25xWC8rTjZYY2pMVkZyYzQxLzBnbk9RS0tXQ042cFZHdURUQWl3?=
 =?utf-8?B?M0Zpa1BTS1FyY3d0NzkxOU4xcmxranV0ZjZvNkhvT0JLSGx6VTVKeTVyV202?=
 =?utf-8?B?a3RUNEQzQmljajRWU3lCQS9pdTlua3QwOU84dTNZTkUrZjhjZVRBUnVYaDM5?=
 =?utf-8?B?NlY2cSttT0YxRU1ZcDFXUnIzODJ4QjIrQ0lUVkx4eHdzUUxlTklVRXdDRXBQ?=
 =?utf-8?B?Y1BIbFFBek5YSXpJNVJtMzN0TTk2Q3orYjNyV0EwL3JhMUNRSS9oYndPUEVC?=
 =?utf-8?B?SmtrTnpOa0VmZG5ZS1lLT1B2RTJoZUpRdHVMNHhzdTR3ZUVNK1A5a1N0M2Jn?=
 =?utf-8?B?aFRidFUxWk01OUxGNmVrb05udGdRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09e48d-f0af-4fca-ac55-08ddbf8d635f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:40:13.9156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DhWlbzHFukXAeSxUqKq6eB1Anzi2pTcUed1CueNQ/rY0NklgkuLwaFIaX/0sPGSz7EK2xAsDsxkiegBrUIASNnWHGpXKl358cJ2b+oTjp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8366
X-Proofpoint-GUID: _JwpB3nNaQjX6TNVUrrtQwXJ5It7HVlF
X-Authority-Analysis: v=2.4 cv=EdbIQOmC c=1 sm=1 tr=0 ts=686f7c70 cx=c_pps
 a=QqCAsN/TGWvFZZtLSKJFCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=pGLkceISAAAA:8 a=a11wUHQtswmm9JBoJ78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3MyBTYWx0ZWRfX5NY6xjawhUVC
 qSnNXNwDfMKwi+MRTpkSFxVPt3+8mJVbFRMgapROyMPNdENg4zMuMe0Ga2Zt7z87RT9H3ZQ8MPj
 lU9jXoMNQjQp9bMupe/aE5aNKlohGuLb1wiaSd8lG00pq6uNrXDUhhANs1B4RaytBy0/E0OJxXx
 V3Fg9ZQKyjoTHagYDKgMj4vA6dZGBP1KsOePmzgRRnSTNaBAAKw6kqNTFnQ6CROQd9bVzB+IEwx
 gq02WKSEr0jw61pSS3Uq5oBZSRSUOwNsHzTCxCRrWdUgmKM8yRXTgDUOOZV7pu2ipRXltiBySKJ
 F/nu+K5944Mcq0bO4BkwIGSqO9juxmyt5NQgoNSeBZZD3V4B7V/gboxgzIkuLGhhxiFx7uhOcPN
 PUhwlTwNeQ/BgWIIBRYvxsUiD/60pCHej7zOYY2i8UT+T1Zm5sMs5sc2nPTlr9Q0gn9wohbC
X-Proofpoint-ORIG-GUID: _JwpB3nNaQjX6TNVUrrtQwXJ5It7HVlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
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

On 08/07/2025 18:36, Bernhard Beschow wrote:

> Am 4. Juli 2025 14:09:41 UTC schrieb Mark Cave-Ayland <mark.caveayland@nutanix.com>:
>> Now that pc_init_isa() is independent of any PCI initialisation, move it into a
>> separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
>> I440FX in hw/i386/Kconfig.
>>
>> Note that as part of the move to a separate file we can see that the licence text
>> is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
>> ("VL license of the day is MIT/BSD") so we can be sure that this was the original
>> intent. As a consequence we can update the file header to use a SPDX tag as per
>> the current project contribution guidelines.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>> hw/i386/Kconfig     |   3 -
>> hw/i386/isapc.c     | 169 ++++++++++++++++++++++++++++++++++++++++++++
>> hw/i386/meson.build |   1 +
>> hw/i386/pc_piix.c   | 148 --------------------------------------
>> 4 files changed, 170 insertions(+), 151 deletions(-)
>> create mode 100644 hw/i386/isapc.c
>>
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index eb65bda6e0..a7c746fe9e 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -96,9 +96,6 @@ config ISAPC
>>      select ISA_BUS
>>      select PC
>>      select IDE_ISA
>> -    # FIXME: it is in the same file as i440fx, and does not compile
>> -    # if separated
>> -    depends on I440FX
> 
> Yay!
> 
>>
>> config Q35
>>      bool
>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>> new file mode 100644
>> index 0000000000..5ac077a860
>> --- /dev/null
>> +++ b/hw/i386/isapc.c
>> @@ -0,0 +1,169 @@
>> +/*
>> + * QEMU PC System Emulator
>> + *
>> + * Copyright (c) 2003-2004 Fabrice Bellard
>> + *
>> + * SPDX-License-Identifier: MIT
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "hw/char/parallel-isa.h"
>> +#include "hw/dma/i8257.h"
>> +#include "hw/loader.h"
> 
> Is loader.h used here? It seems to be unneeded in pc_piix already, so no need for copying it here.
> 
>> +#include "hw/i386/pc.h"
>> +#include "hw/ide/isa.h"
>> +#include "hw/ide/ide-bus.h"
>> +#include "system/kvm.h"
>> +#include "hw/i386/kvm/clock.h"
>> +#include "hw/xen/xen-x86.h"
>> +#include "system/xen.h"
>> +#include "hw/rtc/mc146818rtc.h"
>> +#include "target/i386/cpu.h"
> 
> i8257.h, mc146818rtc.h, and probably ide/isa.h can now be removed from pc_piix since these are either instantiated in the southbridge or not used there.
> 
>> +
>> +static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>> +static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>> +static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>> +
>> +
>> +static void pc_init_isa(MachineState *machine)
>> +{
>> +    PCMachineState *pcms = PC_MACHINE(machine);
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +    X86MachineState *x86ms = X86_MACHINE(machine);
>> +    MemoryRegion *system_memory = get_system_memory();
>> +    MemoryRegion *system_io = get_system_io();
>> +    ISABus *isa_bus;
>> +    GSIState *gsi_state;
>> +    MemoryRegion *ram_memory;
>> +    MemoryRegion *rom_memory = system_memory;
> 
> rom_memory isn't needed any more since system_memory can be used directly. Same for pc_piix where pci_memory can be used directly (see pc_q35).
> 
>> +    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> +    uint32_t irq;
>> +    int i;
>> +
>> +    /*
>> +     * There is no RAM split for the isapc machine
>> +     */
>> +    if (xen_enabled()) {
>> +        xen_hvm_init_pc(pcms, &ram_memory);
>> +    } else {
>> +        ram_memory = machine->ram;
>> +
>> +        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> +        x86ms->above_4g_mem_size = 0;
>> +        x86ms->below_4g_mem_size = machine->ram_size;
>> +    }
>> +
>> +    /*
>> +     * There is a small chance that someone unintentionally passes "-cpu max"
>> +     * for the isapc machine, which will provide a much more modern 32-bit
>> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
>> +     * been specified, choose the "best" 32-bit cpu possible which we consider
>> +     * be the pentium3 (deliberately choosing an Intel CPU given that the
>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>> +     */
>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>> +    }
>> +
>> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> +
>> +    if (kvm_enabled()) {
>> +        kvmclock_create(pcmc->kvmclock_create_always);
>> +    }
>> +
>> +    /* allocate ram and load rom/bios */
>> +    if (!xen_enabled()) {
>> +        pc_memory_init(pcms, system_memory, rom_memory, 0);
>> +    } else {
>> +        assert(machine->ram_size == x86ms->below_4g_mem_size +
>> +                                    x86ms->above_4g_mem_size);
>> +
>> +        if (machine->kernel_filename != NULL) {
>> +            /* For xen HVM direct kernel boot, load linux here */
>> +            xen_load_linux(pcms);
>> +        }
>> +    }
>> +
>> +    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>> +
>> +    isa_bus = isa_bus_new(NULL, system_memory, system_io,
>> +                            &error_abort);
>> +    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> +
>> +    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>> +    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>> +    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> +    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
>> +                                   &error_fatal);
>> +    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
>> +
>> +    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>> +    pcms->hpet_enabled = false;
>> +
>> +    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
>> +        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        x86_register_ferr_irq(x86ms->gsi[13]);
>> +    }
>> +
>> +    pc_vga_init(isa_bus, NULL);
>> +
>> +    /* init basic PC hardware */
>> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>> +                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>> +
>> +    pc_nic_init(pcmc, isa_bus, NULL);
>> +
>> +    ide_drive_get(hd, ARRAY_SIZE(hd));
>> +    for (i = 0; i < MAX_IDE_BUS; i++) {
>> +        ISADevice *dev;
>> +        char busname[] = "ide.0";
>> +        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>> +                           ide_irq[i],
>> +                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
>> +        /*
>> +         * The ide bus name is ide.0 for the first bus and ide.1 for the
>> +         * second one.
>> +         */
>> +        busname[4] = '0' + i;
>> +        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>> +    }
>> +}
>> +
>> +static void isapc_machine_options(MachineClass *m)
>> +{
>> +    static const char * const valid_cpu_types[] = {
>> +        X86_CPU_TYPE_NAME("486"),
>> +        X86_CPU_TYPE_NAME("athlon"),
>> +        X86_CPU_TYPE_NAME("kvm32"),
>> +        X86_CPU_TYPE_NAME("pentium"),
>> +        X86_CPU_TYPE_NAME("pentium2"),
>> +        X86_CPU_TYPE_NAME("pentium3"),
>> +        X86_CPU_TYPE_NAME("qemu32"),
>> +        X86_CPU_TYPE_NAME("max"),
>> +        NULL
>> +    };
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +
>> +    m->desc = "ISA-only PC";
>> +    m->max_cpus = 1;
>> +    m->option_rom_has_mr = true;
>> +    m->rom_file_has_mr = false;
>> +    pcmc->pci_enabled = false;
>> +    pcmc->has_acpi_build = false;
>> +    pcmc->smbios_defaults = false;
>> +    pcmc->gigabyte_align = false;
>> +    pcmc->smbios_legacy_mode = true;
>> +    pcmc->has_reserved_memory = false;
>> +    m->default_nic = "ne2k_isa";
>> +    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>> +    m->valid_cpu_types = valid_cpu_types;
>> +    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>> +    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>> +}
>> +
>> +DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>> +                  isapc_machine_options);
>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
>> index 7896f348cf..436b3ce52d 100644
>> --- a/hw/i386/meson.build
>> +++ b/hw/i386/meson.build
>> @@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
>> i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
>>                                        if_false: files('amd_iommu-stub.c'))
>> i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
>> +i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
>> i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
>> i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
>> i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index c9d8a1cdf7..8d0dfd881d 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -71,12 +71,6 @@
>>
>> #define XEN_IOAPIC_NUM_PIRQS 128ULL
>>
>> -#ifdef CONFIG_ISAPC
>> -static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>> -static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>> -static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>> -#endif
>> -
>> /*
>>   * Return the global irq number corresponding to a given device irq
>>   * pin. We could also use the bus number to have a more precise mapping.
>> @@ -373,111 +367,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>>      pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
>> }
>>
>> -#ifdef CONFIG_ISAPC
>> -static void pc_init_isa(MachineState *machine)
>> -{
>> -    PCMachineState *pcms = PC_MACHINE(machine);
>> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> -    X86MachineState *x86ms = X86_MACHINE(machine);
>> -    MemoryRegion *system_memory = get_system_memory();
>> -    MemoryRegion *system_io = get_system_io();
>> -    ISABus *isa_bus;
>> -    GSIState *gsi_state;
>> -    MemoryRegion *ram_memory;
>> -    MemoryRegion *rom_memory = system_memory;
>> -    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> -    int i;
>> -
>> -    /*
>> -     * There is no RAM split for the isapc machine
>> -     */
>> -    if (xen_enabled()) {
>> -        xen_hvm_init_pc(pcms, &ram_memory);
>> -    } else {
>> -        ram_memory = machine->ram;
>> -
>> -        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> -        x86ms->above_4g_mem_size = 0;
>> -        x86ms->below_4g_mem_size = machine->ram_size;
>> -    }
>> -
>> -    /*
>> -     * There is a small chance that someone unintentionally passes "-cpu max"
>> -     * for the isapc machine, which will provide a much more modern 32-bit
>> -     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
>> -     * been specified, choose the "best" 32-bit cpu possible which we consider
>> -     * be the pentium3 (deliberately choosing an Intel CPU given that the
>> -     * default 486 CPU for the isapc machine is also an Intel CPU).
>> -     */
>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>> -    }
>> -
>> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> -
>> -    if (kvm_enabled()) {
>> -        kvmclock_create(pcmc->kvmclock_create_always);
>> -    }
>> -
>> -    /* allocate ram and load rom/bios */
>> -    if (!xen_enabled()) {
>> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
>> -    } else {
>> -        assert(machine->ram_size == x86ms->below_4g_mem_size +
>> -                                    x86ms->above_4g_mem_size);
>> -
>> -        if (machine->kernel_filename != NULL) {
>> -            /* For xen HVM direct kernel boot, load linux here */
>> -            xen_load_linux(pcms);
>> -        }
>> -    }
>> -
>> -    gsi_state = pc_gsi_create(&x86ms->gsi, false);
>> -
>> -    isa_bus = isa_bus_new(NULL, system_memory, system_io,
>> -                            &error_abort);
>> -    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> -
>> -    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>> -    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>> -    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> -
>> -    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>> -    pcms->hpet_enabled = false;
>> -
>> -    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
>> -        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>> -    }
>> -
>> -    if (tcg_enabled()) {
>> -        x86_register_ferr_irq(x86ms->gsi[13]);
>> -    }
>> -
>> -    pc_vga_init(isa_bus, NULL);
>> -
>> -    /* init basic PC hardware */
>> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>> -                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>> -
>> -    pc_nic_init(pcmc, isa_bus, NULL);
>> -
>> -    ide_drive_get(hd, ARRAY_SIZE(hd));
>> -    for (i = 0; i < MAX_IDE_BUS; i++) {
>> -        ISADevice *dev;
>> -        char busname[] = "ide.0";
>> -        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>> -                            ide_irq[i],
>> -                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
>> -        /*
>> -         * The ide bus name is ide.0 for the first bus and ide.1 for the
>> -         * second one.
>> -         */
>> -        busname[4] = '0' + i;
>> -        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>> -    }
>> -}
>> -#endif
>> -
>> #ifdef CONFIG_XEN
>> static void pc_xen_hvm_init_pci(MachineState *machine)
>> {
>> @@ -839,43 +728,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
>>
>> DEFINE_I440FX_MACHINE(2, 6);
>>
>> -#ifdef CONFIG_ISAPC
>> -static void isapc_machine_options(MachineClass *m)
>> -{
>> -    static const char * const valid_cpu_types[] = {
>> -        X86_CPU_TYPE_NAME("486"),
>> -        X86_CPU_TYPE_NAME("athlon"),
>> -        X86_CPU_TYPE_NAME("kvm32"),
>> -        X86_CPU_TYPE_NAME("pentium"),
>> -        X86_CPU_TYPE_NAME("pentium2"),
>> -        X86_CPU_TYPE_NAME("pentium3"),
>> -        X86_CPU_TYPE_NAME("qemu32"),
>> -        X86_CPU_TYPE_NAME("max"),
>> -        NULL
>> -    };
>> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> -
>> -    m->desc = "ISA-only PC";
>> -    m->max_cpus = 1;
>> -    m->option_rom_has_mr = true;
>> -    m->rom_file_has_mr = false;
>> -    pcmc->pci_enabled = false;
>> -    pcmc->has_acpi_build = false;
>> -    pcmc->smbios_defaults = false;
>> -    pcmc->gigabyte_align = false;
>> -    pcmc->smbios_legacy_mode = true;
>> -    pcmc->has_reserved_memory = false;
>> -    m->default_nic = "ne2k_isa";
>> -    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>> -    m->valid_cpu_types = valid_cpu_types;
>> -    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>> -    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>> -}
>> -
>> -DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>> -                  isapc_machine_options);
>> -#endif
>> -
>> #ifdef CONFIG_XEN
>> static void xenfv_machine_4_2_options(MachineClass *m)
>> {
> 
> With above comments addressed:
> 
> Reviewed-by: Bernhard Beschow shentey@gmail.com>

Thanks for the review! All the suggestions look good, so I've included 
them in the next version of the series.


ATB,

Mark.


