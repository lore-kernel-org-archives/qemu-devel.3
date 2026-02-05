Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F4AECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo28H-0003i3-Mu; Thu, 05 Feb 2026 11:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo28F-0003gX-GG
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:23:04 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo28B-0005GL-UK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:23:03 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 615BvsbE3327257; Thu, 5 Feb 2026 08:22:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QEDeOj5HmtJtfK0MCEuIjIE0/uSFPEB0rxykvebKX
 kk=; b=1TKstFTY6ph7PWEAvB0FTMZdtHTq0WG0yN6qTgSSxMrKlnRSb9JvhnpSB
 a3WdCwVI1UtrYuJlGqTjPDSyPVJfFozlFquV1jIKr51jNRv67zxt7Hc4fpAdkUjk
 NoGWsMtwbGWnrHFr0N7k7L8VpizBHqPeUaJs1RpbgGC0I51zJ36Q3yI3qIG0XK+7
 Vx94KEE5WIBUs9XUjXNEgPKZ8TTYKssiepJylCNJ/OAetLbeYTWiIiYhUCayf1mR
 dT7EkZA8f0cXqye/1Ns/2Bfqq10fHwaCaTniV9zJGMAseqBpx0/PwCMmr9AfIpM7
 va6j07N4EtvAl2CpR1PxyUlOPTRNA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020137.outbound.protection.outlook.com
 [52.101.193.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntjdw08-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 08:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TszvsVs36mO+WmAWCCkJkGAt+ewKKKP9w3LcYdk1OegLetDsxUX6pnAxoLp5+doOhOBj76idTtbPZaD5yQwr24BgXUJk3JlUcNTtQ9G77cdocTdW8cj4WZ72+4HY6MqVvBskL1ZjgVbOG3sSPh6Y0veOm/NuZs4umR7/k6b2YT2LDTpS938tKd5aXrh/JVh/c6BbuFAXyvJ9xNrvqb2H6lNzgkcWkxaVhcewQKJ6hXIihq/BydO+Ws9ovU8Opf43ncOObzN8IPR6mrs965YQDeatH1ZDV3Kmk4vc+INVKGEfccUiRF7E8EU/kdyYDvGFizeDZ3JdvbNRcFdjFv+HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEDeOj5HmtJtfK0MCEuIjIE0/uSFPEB0rxykvebKXkk=;
 b=T3VF0t1ebRBvjCmg6u2bjYJdAwdLeN4PYVMNbaensCVPQh3sP693naxG5CxZbFKy2a8Yy4EuzLtMBtoO1yXQwE/uhOfuxItuUFyKWtAQ9GD46p/JGG6BU+VeRP+wBxpPk5yyLw+1mbRldKzEZvwVX4a1uPEDS28H5tfYhTvlaUC//0JRaMvpnZsKIcZR0FjY40VaxcZVDXx7KLqu6F0TKTZobkU9IS1v4EjpkSI3a1kfhBZlBf42ZEbV/6WFLijqLAA+yo7+PQal2Aj2/cWSteuTc6wU1m/Mz2TRRg+Sn72F/J6nL/JwIWtEE7t4R6Ki2KJJ3Nd+Ktj3LiNnWqzwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEDeOj5HmtJtfK0MCEuIjIE0/uSFPEB0rxykvebKXkk=;
 b=ylX72zIjXgL1+RlkV+v/p7oH3P5CIpA/GOcHoWaj1zeh2A30Zkocj1A/OoFUJnatrEscB/8JEBKvU9UZxZXayJ8tFb7e3X+5ki59ShV2uonWt0//jAyGyAq2rSJF7JZVSljnX+lvGCmVcclWbeffyETOjYk3VL813OSLTIzaG3iuGA9qrzKmnvKmyZ5xdwXwUZIZeJB+fr6ki+jaX4IUAdm4GK1n79rW1v/kpSOlN8djYepenIXXKpK9r5YU7SmbI1pH7wrnDA/ELt0bieytcm+EcC2cZPIp+TvycQUfZDi8DZqdOD3mmw0q2G482wrEd+7ojiFrQaELRjv4Uczhpg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8661.namprd02.prod.outlook.com (2603:10b6:510:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:22:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:22:54 +0000
Message-ID: <a6b42494-4abe-4651-a61b-5a6b3b1c2ecd@nutanix.com>
Date: Thu, 5 Feb 2026 16:22:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/37] tests: start manual audio backend test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-17-marcandre.lureau@redhat.com>
 <f660298d-6a92-4b6f-a113-e0bd239818d5@nutanix.com>
 <CAMxuvawiiAMOfPfO1jdXXXf4b6BxD7X1+AeqmXY0FdGsv+6evQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvawiiAMOfPfO1jdXXXf4b6BxD7X1+AeqmXY0FdGsv+6evQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: fce568bb-717c-4177-d51c-08de64d2d0c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzV4dzNFcUdSRW5hTko3TU13dG54dCt5QmNCdnZkclhFc3U3QklCb3U3TUY0?=
 =?utf-8?B?VjNLb09wZmVaRnVmYTNQRFJoVEV2MVhOTXZZTWdObjdTckIxNnVTMG1iMkVM?=
 =?utf-8?B?VzFzaW1pU1NCcCt4TEJXSjVTL3FJRlBrcUM5bFNISE1xeHBqTEVCNmtodnNy?=
 =?utf-8?B?M1BjOThLR2hCeWYrQk1GOXBrMTVmR29wYVBmTGJpTXUzdUJET0hmZVF1U2dP?=
 =?utf-8?B?bzJHQkNOeWM3R0VZQmhkckI1S1NFcUV6ODZWdk5SQ2doMWdRL0hkQkE1ZWho?=
 =?utf-8?B?dTlMQk43YWZsdzg3bzZoNnA4cGErRUVTdWNOUEx0dXVhRzZVNlhBYXduQ1JO?=
 =?utf-8?B?VldueEpNRDBLc1NFcEc5Zno3VG5mZ3pvVUdDQVkzWnJUYmRxTmxONEdZbE80?=
 =?utf-8?B?anUxWjBlcEJYSDNQeC8vd0htWnB0NlBkTUQyWGxjSDhPRkdLSlVSVExvY2ZJ?=
 =?utf-8?B?S1hFQmlTUlNYT0l1SXhBdGVzOTI4U3FuTXVyWDlaZkxoQUJYMXg0OS9HZ2Mx?=
 =?utf-8?B?dERpUjhFZmdWMFdhOGxhQ2dHZmxXblhRTWFndkxsWlE3YVl5QWVXMjdZMzZk?=
 =?utf-8?B?N3RBd2ViWVFvWVJNUDkvU1Z5a01qWXE3R1VFNndJVXhqaWdhbzl3NUhPclV2?=
 =?utf-8?B?NjVNTndHOGV4RGFaZVVGV0p1RWhvSlc1RjFoUWdrU21Xc0ZVS25ZZ1MvMkFV?=
 =?utf-8?B?Y2xQSFBBd3BYbUQvZEZYOFJkZzFKbEk3dElsRzRDdUp5Y1BIRVFyY0tmQnFL?=
 =?utf-8?B?S1g5TFJPaEZseEVMWHp6WCs0U1FxQW1iTTNjbkpBZjNCd011c0ZkOVBvSUND?=
 =?utf-8?B?bENOcVp4eW41Y04wdHoycUJETjgxV3Z2eGpiSVd1Z245cVBUYjJVZld5M3Bu?=
 =?utf-8?B?K1Vva2tlTC8zMUh0VzFUbUxRanVmZmwybk8vWkNLWWswRVRIZUlUU211ZGpo?=
 =?utf-8?B?Z0dVSjNKMEh6eHIvRm9yNVBOZVdFd3dwMVRWWWU1MHhsL3hqMWxlWTh5M3lk?=
 =?utf-8?B?U21PTVl5dzhNR1BpVTAyczVwajBvOS9UYnp1S3J1VkMyQzBHa0UwUTZSNEl0?=
 =?utf-8?B?bmo5SE5mU3IvMGVyQkcrNWJ0aWlhMDNpTlJDREI3c2ZHVDFhSzdabksrdVgr?=
 =?utf-8?B?MURHaXR5c2EyUmZmdHdURmlCVFpLV2JXb1RmVkxYcEE3eHJZSm5MRVFrMjVK?=
 =?utf-8?B?UnhCMUo3aGRtY2FFVjhjUGNhOXFIaHV2L2JoUUZVOHVLTzhBRy9yV01xa096?=
 =?utf-8?B?ZlR5UGhsNzVwK2RmZ0F1K2x0bTlZS3ozU0pEL1RKNWVjd1ArVHFOcUtrR2tY?=
 =?utf-8?B?cFkxb0t2ZHkwek1iRXltZlpURDBwREFmaE9HTm9raTcvQzBUTVlCNkI5cHFO?=
 =?utf-8?B?bkd3NjVIalVTUDYxTEkrZHRWKzlKZVd0d3pnaGh2YUlhVnQraVBsdU82STU0?=
 =?utf-8?B?VCtUSUZOR1E1bHJ2SkthdGl1eCtBZE11c29VRHozdDNzU2I5bFluc0R3ZENv?=
 =?utf-8?B?UFJwRVZQd3pEYWFjVHNoRGlvdDh1MkR6bU53L3Y1OW9ZSkEyVEVRU1NwT25y?=
 =?utf-8?B?dWhJSnpGVVVUejhaUE9pM0UrQ1cveEpVTnIycnRqK1BBN1ZsMTdYa1pVZVRF?=
 =?utf-8?B?TlRSYllJYUp4aFhXbVRCNFRBKzlxY1hVVHBSdjdDVXU1RmRYdG53dkNkQXRP?=
 =?utf-8?B?d1VYaVQvL3MxcGVWZWpMVjROZjRremwyMlhQa0JnRzB6bkE2Q1loZ3VZR0hO?=
 =?utf-8?B?Tlh5cXNpbzdhQ2xJSlBDOTZMUG5hdTFzNUdhdEEvdXBacFViZ1hURWw2TnlU?=
 =?utf-8?B?ZlB2azJSNEpUTkZCdlZIVU5uKy8zb2hoemgrRlBhcHE5OHdWUnpCS3pER1h5?=
 =?utf-8?B?VGFiVWtWQTczbUJZMFpWcnFqalZWL1ZodU9kWTJ2MkpCdkcvQjJ4MTV2eDMr?=
 =?utf-8?B?ZzVhMUtBRjJEUUdQU1h4SS95YTljK3lsZWI2TE1yYVg3a1lOZlFXajNSV08y?=
 =?utf-8?B?TnFSN0tqR01ia1d5MGdMNUUxWTEzRThacktVdU42RU9JdFcvT0llUXY4M3Fp?=
 =?utf-8?B?WnNYb01UaXE1YXpHUFU1czZJa3ZOZEtRU2VqREViMHhpZ2pJWnkzekxIZ1N4?=
 =?utf-8?Q?FmWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHZkVXA4WWVNTDVhYkcvNmxZM25Cc0tPWnJhalFPMDJuRDVTc2xRZlM3azc2?=
 =?utf-8?B?Y0dYV0d3UjhiUmttM3MwWFU0aS9pZ2M2Q1k2WmNMS2xKSE9zVjRvZEs1WEdy?=
 =?utf-8?B?UGwwRlQwcWo3QzQ4N1RqclE4UzRaME9KeUF3YUdJU3NjS3RiazNzdEw4U0dB?=
 =?utf-8?B?dVBSVEgxR0RmSEJ2VTRPdFBVcmhJbmNURzZIbUdkeU9SQ2JaZlVXeFpZNEFC?=
 =?utf-8?B?b2hndUhOU2tnVTVROERYV29jNVJ6Y09mVXdKbXdhakYxRFVjcFhCV3QzR3JB?=
 =?utf-8?B?b01tWlhVMGZnejhMN1gxS3pTa3lxMUdQRWtjT2NPTUh6NUlHcktqaVR3cDBy?=
 =?utf-8?B?WFhsb2YraWlMUGVNUUdVQmtJZFZnRXVpdkx2WU9zeTBFNTUzbzZWdHA3VDJz?=
 =?utf-8?B?VzNDM3hJSk4rdUMzVEdlbFRMR2VOaGhVZEphNU0yeWk5M1U2YVMxL014Ym03?=
 =?utf-8?B?T3pDdlkyVmtjcVJQSGJVZVBIUmo2RjdKNitNZ3g0cit3M29sQ05PZTNwcm9U?=
 =?utf-8?B?R2pvQmNjT3JzT01rOXJnTW1Cd1dZRUV5QnhxMkxwd3NEUUtlY2FrS1hzelYz?=
 =?utf-8?B?eEhkUkdyQnh2SjRvTnd3eC9zUnlWbWxSdVFobHRWN29YZzJCbEpTNWo4Rldy?=
 =?utf-8?B?dEVNMUJiNGo0UmhwT3ZYYzRLbWNscDY5WEJKTU93NWhYU2RjTEJNSmszTmtX?=
 =?utf-8?B?WWt3U0pQdTh5cE5pWkozTzM3bjVtSUZueFVid1RHNmhGT25iWWJyOFRtZURm?=
 =?utf-8?B?Z3dYdGZwaGJFdHE3bEIxSktYTzhCci90SGt6U05abk84OG0zSHh6QzJZYkY4?=
 =?utf-8?B?WE44dnhpRDhaNHpXZUQ1SU5JWUhTaEl6ak9la1NTWnU5Ykc4Z0N0N016Wnd2?=
 =?utf-8?B?ZUphZFFVMTBiYjBFTTRvMXRCcSs0Y2MyTk55Z04vaHZOb2ZKSE1PQnlraVZL?=
 =?utf-8?B?cVZvOUUvOUpRc2sycEM5eWcwVnQ4azdhbjJTcy9PV2FFSm1DeWp0eHM1KzlJ?=
 =?utf-8?B?R0dBL1ZHZ0xyRk9sYndYQU4rZXJqUDlHWHkwRm5xaENoRHJYaUFhckYrSTVV?=
 =?utf-8?B?c1RQaHAxVU1uRzkyM05ZTE5CVC9nYVc2bCtNdzFlTWFSYTl3T2hKdGJUaXFW?=
 =?utf-8?B?UCtqWnJGbmhPb0JBd25MZjNyRE1YUUtwYkl1bVRpMFkvcTF4VHh1ZnJLN01r?=
 =?utf-8?B?cHcrNDNqNnJkaWpuL0FFU0lCeVYrSmh5M2tvdjYzakFJQVRsM3RpMXFWMXF5?=
 =?utf-8?B?cU14Z3Bjc2NSUnRUTm14NTNURHlhVGlMa0ZYbHV6M21LcmExUEovb3c3Sm5C?=
 =?utf-8?B?aGlYZytTWmg5ZWFMUXJXQmVNZlZLVW4wcDNCb3BYWFVaQllKR3JWSC9yUzFC?=
 =?utf-8?B?cVZTZWlocEhCV2drazZkVTJLS2J1NlpxbmZieHN5RjV0emRETzNVZnhkcDdn?=
 =?utf-8?B?a3dCd3JjOUFKTG9FdUQ0SFdFelhCM3VlZ1VwVkY3OWtZdGZGNUZHTWJvSE5V?=
 =?utf-8?B?eUNaTVFDZDkybUE1M2g1L2R6dVR1UnhoY2NsVHdtT2I3NUlKNnFEVVROQXc1?=
 =?utf-8?B?empucThPakpoZ0xvdmFYQW1WVUpTOWhSeGdIbUdVbmRhL0VOblMvRWJHK3Vi?=
 =?utf-8?B?N1FkcDRaS1R0Wk8xNWtNZGRrNjI2QTYyNDZqYytBTmcrVm85aTZCTmdaM1l0?=
 =?utf-8?B?ZGVVbUNNYmlQa3V5L09NazFXU2MrcnRlK0JGRXJSU05naThTOEpHMzVRUFVi?=
 =?utf-8?B?YmNVQ2pTN3pqOUVwaEtLVmtxUEd5Z1NxSURqVzZWU3A0OXJORHhxUENEK1di?=
 =?utf-8?B?VnpDbk1JUmF0MStKK1cveTBLZmp6K2QxWThyN0xtczM0SE83UDZIREx2UWtj?=
 =?utf-8?B?OEFwOG8wM0ZaMENiT2VyT0crd1VnMmZzNFVNbWpJdDh0eUhyT2JoUWlublNi?=
 =?utf-8?B?R3NRS2RHOE14blNub0k3Wk1xUENvWjNnd3N1dUhJOVNHQVRVUjUvVEphcXRJ?=
 =?utf-8?B?MVR5ejdKT1U0L1lCVEMvcXhBWk1DTm8zbzR1SlV3WmVEUVpsSmtNTXRGQkR2?=
 =?utf-8?B?Nnl3NWV5WXJOQzZDNFFMdjNCUlByVHlDRTFoakhKdHJNOVRVR2NNWk5lSmZ3?=
 =?utf-8?B?MlZ5ZGh3bk02ODVMYUwyaURlaWhnZXZWcUV6S1Q1eWQxYnNBdG4rWGI3dXJy?=
 =?utf-8?B?WG5BakNIdGlxRDFETnkvQmFMcGVvc2JYUFJrYjNndGw1enQzVEhud3dsckE1?=
 =?utf-8?B?TmEveVZrMHdVZ09HNVR5WmdQdC8zc0JNN2M4d0R3WW4wWExPQzdDTWdSY2FR?=
 =?utf-8?B?UnpwZml6QWtFemc4eVdRL2wxREhscm9MdGlRdnZGM0FxZTNCdTZ2VDl6RjFH?=
 =?utf-8?Q?V88gTs6NcOkbZeWQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce568bb-717c-4177-d51c-08de64d2d0c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:22:54.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35Lnt2P/h/ynMXXmWEA2UsgZIZYZbN7593x6AV/mCCky0mJp4aPdADE9DiBw0jbILJErzQheo1YwgGzxyARAJZkw8r1Yu6sKIu4MsxjN210=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8661
X-Proofpoint-ORIG-GUID: EJTL2ugFmkg7y6DJoV87XCPhVMYOqXL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNCBTYWx0ZWRfX9vLWajfTJlMp
 bhT3Wboe/rAJCSEPsS0hQw5JUZdTlK4jAmiHLi7ki5Og/J+Z4upxuf81k72GkfAqhg3SsaRaWeG
 438Tx9T5BUqEvaXa4E0RHpeaVgAV/PSFwTdKZ0M4Kf5CkyyjIj6/u8CEC0ygPHVwI/ZCcGERXO3
 KldD/cf2s1ysyildR1RgPNawNXd0JSrqp0aq9EefcF2dwu950il3+mbuga1XOEhL1FBn1h+VYok
 ZrTJYGFVL6FyPLHbpwBR3enqS8HlFj2plYaPH0zbVy4zPiogXyKnH2CNGWtq9CaykiTDg6y6J6q
 OIlvO+6iO96zCzdz+T5blfI1nsUC+DgXm8kZ/BbpDXDKSpUO0+UFhDd7FoPwIxmahE/azGsZLHS
 ffY/rtpYwCk6lUwmzFG7h2HVvGUl539XUWVmCe4DbeAo8RUWdRwutNLOH+CM3BMokeX8+JyWdGZ
 jldVJSDOK+vDmbaMkWQ==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=6984c3e1 cx=c_pps
 a=XDlTrAgoJ4DEJsetPJNxqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=iZtt8p4I1zLmIxWF3fcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EJTL2ugFmkg7y6DJoV87XCPhVMYOqXL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/02/2026 12:47, Marc-André Lureau wrote:

> Hi Mark
> 
> On Wed, Feb 4, 2026 at 2:38 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Start a simple test program that will exercise the QEMU audio APIs.
>>>
>>> It is meant to run manually for now, as it accesses the sound system and
>>> produces sound by default, and also runs for a few seconds. We may want
>>> to make it silent or use the "none" (noaudio) backend by default though,
>>> so it can run as part of the automated test suite.
>>
>> I wonder if it makes sense to have some kind of qtest audio backend that
>> can write the resulting data to a file for tests like this without
>> generating audio?
> 
> Yes, we could have some tests using the "wav" backend. Although I
> think this is pretty limited. I'd rather leave that for now.
> 
>>
>>> +
>>> +# manual audio test - not part of automated test suite
>>> +# as it relies on audio system
>>> +executable('test-audio',
>>> +    sources: files('test-audio.c', 'audio-stubs.c'),
>>> +    dependencies: [audio, qemuutil, spice, modinfo_dep],
>>
>> Does this test really need spice to function?
>>
>>> +    build_by_default: false)
>>
>> It took me a few seconds to see why the test-audio executable wasn't
>> being produced, even if it has to be run manually. Is there any reason
>> it shouldn't be built by default?
> 
> No, I thought if it is manual it should perhaps be that way, but
> that's also not a good idea. I will change it.
> 
> btw, I also fixed the test so it can run with -a wav,file=output.wav
> (the test currently requires input handling, which is not handled by
> wav)

This sounds great. Did you manage to find out if the spice dependency 
above is still necessary for the test? I don't build with spice by 
default here, so I wouldn't ordinarily be able to run it.


ATB,

Mark.


