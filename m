Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D92CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnm9-0004Yq-7n; Wed, 17 Jun 2026 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnm6-0004YU-TK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:45:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnm4-0006Z5-V7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:45:38 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8YZ1p1054287; Wed, 17 Jun 2026 03:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qj2SJcy/q4ZqyTQOGxPKihxga0YV2f22fkgw9sGFF
 2w=; b=LaG5UolOto+zD57BYV/qTobJTPgc10EBChT8Fs3XyPh+pPQdQvx50PE/Z
 3VWUvLybUnZ6UeYaOGuJQ2P1cNRry2xvBouzCPJki6DR4Pt1ahw6YR6ngBXbY8pj
 rIAeCzSTVXbLc22h6QgOx1o3T3Uwp7Vi0RzZl3vwFpP7Q2eSmAiMhOY+TOGwuPad
 +7pS+sCEHucVGrDIT8oL1tNdFXUD0jIF2lQuta81zXMfSlvUg0/W54pr2ULWNVeb
 4fG7HBx9vJIBNaw4XuJ+oodIK9iGTpITInuHU1bw+3Xl23wzBmBwOgK9zNZvxQXp
 61jAsPIgrwSnZJRMD1kBnMW6bzgmQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021117.outbound.protection.outlook.com [40.107.208.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4euegh9grk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 03:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2VHLp2juhz/tH5pr48UPXniInz5GjWNdvGdyfUsn75jcM2bTFdXWURKsKm73jxMHMI9o1DnLOxYy4guQmg2Xh6fXgSrqTAUMzFvuzP7Dd/wJYHYMXJxLvR8rBAvh6gTbdxLPHLHVdoiu6c3UcXj5tUEoOB5AdVIXDx5JlkyX45XNYiUfsbUqOGR5CMrtux0v1dnPIBhocAtQ0XyDm3HtnO0WEN8lsqu5xwe4lzFF3PJI2gCPzTzIyk71ogy/0Q/V9ZJODXZZGaaTimyd/nnfgWezWCYo8R+VOjbKPAw3s0K9cQVsssIR+jSlbum0NEaGjTt5HZjkmhaNIJPddwZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj2SJcy/q4ZqyTQOGxPKihxga0YV2f22fkgw9sGFF2w=;
 b=WVzteArhnd+vzyS5n5K5i4fk/oicVwWcfHJ+6tXdI4fVUdZAsWCrD4oT0E260JRtHZ1MvAGxxVa6HHBjMPMrwqQZehyW7eldlO4mJjZS5irMffwOnuE9G4HtjXbUkwVlUnJCUcr7wDPjQOSWzMvnHm51cBxrzA9v/t1Pu0I9AUMK7fAPVw3kbxeMp4Uqf4hSLva49s1jrXkN+CMBB4MJM6KPniVp4GyI9bwRAgIUTiarSVX0pm5vdeUBXBJ/20t+2UmTqOn5eB7Ql3tR3gf81u9x4Y1m4QFVNNA6xum8Jm4IUQanqdBhxQmdlNIMV17PFPAPo1el4NxJ3fLjzvZOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj2SJcy/q4ZqyTQOGxPKihxga0YV2f22fkgw9sGFF2w=;
 b=pCfR2lWy7r0Z5qZq1j8pi7N7bSVftQCgV7V3AiHCHg0tQdSDip5JWYY/Tv7A5zKeGJ5G4nmB8oi36LlHg8QgengRkqTBO/lyxTF9sat10zaf8K7KgLer/cqIk58I4ts3JxXb6gAvJ9Y23ogLnoanUOET9GKAghafHyvPEdkgDx2pDgRMeBzBvkvytbOpqhxeVDjBitPvfGs5uaOXLY/uPWApCtmURqH+NwvgJ1M2ELzR+j4euwAPafwNR+P7T5PPEtFsB1ohQH9E5iQQm3gLdO8E+qbwsNXpDSzdXrV+tlYrfQSHp77W20Bgz4gsqBkhvGCRb8lq47WI7YzzaEUcew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8374.namprd02.prod.outlook.com (2603:10b6:510:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 10:45:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:45:15 +0000
Message-ID: <8c8f1663-9731-43c3-a541-c609cd2806ee@nutanix.com>
Date: Wed, 17 Jun 2026 11:45:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-6-berrange@redhat.com>
 <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 389f7f2c-57bb-4bea-b49c-08decc5d83df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 98deQLo21j8zbgCWicWr7rmnNzRtnPJreWfqtNWVLEmM/w5Ry98XPyv+uG+hUGR7BCjCWRloKH7WzdLFctuFpj0ihuHQTAgetr2jcBk2BZdfzY7mBXp5PdoVwEPWTJkO/R83aGDKL+qhE30MWy1udZ1NV6fdkstD6N1w19WROvVl1/uGZ/pI+ltxPOHL8ek6JzQejsd3VRhIVA/5x8Gntanl6+vEuBkcQERezt200+dCblDC6RSNci6mMADKiJjhE8hS2ywm7QLB36WNC1JimvBe+51/A1I0ppAgZeDvWou0MHGKYaT9Ml3/TKqsDgEv9oqTlVv7+gKstQn/Dqxc1uoPOLQdTGUly8fcGvOiByotbOG0OLaOyAyXsxxW1dH/XsDfp2HBXmUBvqA1zXGaajDljoOwA2gqpvSbD/GrhR1L9JijaATGBIOzQTKBgoOMKJ2iJXgHg/81s4FNJ7uRmvmNKbkcvYsclXpK3nlUkdGgInQAi0fkiX+cStQCY8J/Jiz/VUpNduufesBbcZ8UaFthYaS2yAhKhcovgjpI5XXvCbZU9wBLlSyfR/OjDN0I4VwVdVmZCeLtJ2lWfb1HRNsssUS7a4YUZ+FPlGImZUR65hawhXQz7IKytGTJxVJtYxSHOoE4zhsrJ5uflGAXx2H6dqIo4Rp6mXSCab4E2J0CpWb7xx+tr31qT+X2g2Je
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVnVXVwVVNyNjVkcnJKVHQzT3FKOHRKSmREOXB3eXJ3TWpERkhHSFU4b0ht?=
 =?utf-8?B?RmVvQUJId2l0eTFIUllHT2NySXdCOWdZZE9Fczk1UTJkWHcybEJDdnVZVzdU?=
 =?utf-8?B?dnlZYjdWOGZOMUl1d2Y2MUx0VWh4VzVXV0kxTHhiLzB4R09IVWJRRTdJaith?=
 =?utf-8?B?ZUlERXFKeHJtd3lMWGhkVTNMa2tyZ1Y5dG11WEdTa09aSXdsbTgzaGY0dVl2?=
 =?utf-8?B?RjY5ZmpWM3hFODc5SUcyMGN2WC9xMTk0WmtNM0Yvb2VpVERJZ0Q1MGdCZmk0?=
 =?utf-8?B?Vm45N2dMT2s2d1pIT0oxT2w0bkM1WCtvRzhoUGxqN09SV3dsM0tYcWhEZDhx?=
 =?utf-8?B?Qm04TGF2REg4RkVFdXVubEw0SURhZXk2aFZDL3hrb09zcnFMdGZFSXBWSUx4?=
 =?utf-8?B?aXFMYS8zS2Mvc1prMTBUdzZQclZsOVNveHN5ZC81OUZNd1RYZFB3UERnNnNh?=
 =?utf-8?B?T3RKZ256S1BtZ1AzWEt6cXBvd2RYRDhzQVVCNFh2SFVqMXFCTUVHcHdlS3Jj?=
 =?utf-8?B?WWNCdEgzK1V1UG52ZFRPRUoySTV0RzRMVDZQcHdScEY0cFFFVzF3bXRZNFBo?=
 =?utf-8?B?cW9kZnluaEFFZy9rcHFQVGJWV0o4UlpJRkJKbzVTcHRXOVVvVXRHZ1MzTytm?=
 =?utf-8?B?amIvbThPVjJLQ2R6RzFTMG5kTHA5aFlCRWIzY3F5L2tpWGVYUU90endCYm1U?=
 =?utf-8?B?bkwwKy9HZzR5S3ZDdnNabGpIV1pLd0JNZXQzQm5NaGR0WXZWemtzT0t4TlJw?=
 =?utf-8?B?L1JQNjBjZEFxMENYRjhDS0lnMEpmWUVzS0ZWSXpKQ3VNMGlkRTZPU0pxL1I2?=
 =?utf-8?B?Wnhwd0djS2thb2FiK2U4WlJYTFBEcm1TZjVwaDkwUXNmZENQOEhpZlB0L0ZF?=
 =?utf-8?B?UnNVVlp1WUg4QVM5WnRKN1hPV3lYbFROd0YyVUs3YkRzQjhVQ0tVWFdPaUEv?=
 =?utf-8?B?VHFqZEl5YWhyZS9OL3FBZ2o0Rk9aNkJTM0FncjZBY041RGFXQ1NBOWVkbkZq?=
 =?utf-8?B?MzZqZzFtTzdyVGtCK2RxcUxUNDMvTlc5Wmdka3NLQTJxdEhDUVJDdjVxc3Bo?=
 =?utf-8?B?dXk1eGpuN3dKeVkvV1N6WEJjY3l0Uzd2N0xOS3Y4ODJwdHpHUE0xTnNJbHpl?=
 =?utf-8?B?dXdvTkZRYno0SFdraHdmNFhPd1JlUStIckVzSitBVy9JL3g0S1pENmh4WGFs?=
 =?utf-8?B?VUI1c3BzaWdHYWNoWmhHVFc2bDVVayt1Ukhqa3NQdTRGbWFJSVNMMjZxelhp?=
 =?utf-8?B?Mmh5bWZXOFRrY1dBV1lWcldiRU1MRk5ianFTODNRcVpsZDZ3b0tLV1loVitI?=
 =?utf-8?B?dGZBeVdsYWhVVm9uSVdFR0lRd0R6anJvRys4cnFFL0hvcE0xV3Izd1A5enQx?=
 =?utf-8?B?cVAveXE5bmMySmprRHdOeTVZN2srWUhPdi9LK3g5VlFET2lWODJRV2dJUFVQ?=
 =?utf-8?B?aEhmSjBvOThDRnorSHZlUFQvK2xNRDNsYnB1ZXpYR2RIVHBrRml0UVpsMzVW?=
 =?utf-8?B?Y2llT1g2UXpyZVFHenZHSG83cmRXLzVqK2ZjTXFISU1EV2dwMjBVb1NYdlZw?=
 =?utf-8?B?UW5SbnJVdG83SW1UNXp3OVJaNFBVZGZoeDdDUUFnMjF5WlVIeU5SUUNQeFZP?=
 =?utf-8?B?TlBGWjF2SWVMdUdqN1pZRHEzYWgwR1ZxZWQ1K3J4RFdidHkySUZzT0QwbXFQ?=
 =?utf-8?B?WER5NGtQZXVWSmRabkdkMGlHVjJlUWlzMmMzL1Q3U2VNVHpMZzhlamE2aFdT?=
 =?utf-8?B?aG9Ld1VYcmFSbzJGczVZVGZsNFJKMzNJSS96a1JRbVBueVloNnZCSFpnNFBu?=
 =?utf-8?B?aDVQNUNKWEJoZXZySmhuK0NXUzl2eWwrTHI0QUdUaFhoTUllODQzNytvWTZO?=
 =?utf-8?B?bS9ZWnBiVTF2U2RiTXh6Tys2MXJRR3NxY01SMlRSY1dHbnFhaFJtdHA4YkV4?=
 =?utf-8?B?YjhNZkt0V3hrZnhGSGVtTkR2MitPQ2ZSOVc4UitsY1VSckdmcTJRNjNpRk8z?=
 =?utf-8?B?L3VkdnRTMkJSM0tuZlRDVms2OEU3SU9CNVZzaGViMi9EbTBhQ3lvdUp3WWZC?=
 =?utf-8?B?QUd3ZS9uSEswdHZoMThZL3dsZk1LUy9rK2R1VXFkNEVIaDhxYVhWQTczRmlN?=
 =?utf-8?B?cStxQ0ViVlRpMkcraWxuUlhXZ0lnSitKd0RGWWlEb1huQUI0b015TGRWUEVQ?=
 =?utf-8?B?U095UnVYRm9BWFI4OEprWnBmQ3dDdS95NFNyWGZ3M2JWQ2taNVF2clJFc3hY?=
 =?utf-8?B?MDd0L1B1aERLTGVJNHpNekdvQmFTNFd4NDlWb1dRcUk2WkVkK2k2THEzYzNI?=
 =?utf-8?B?ZFRhZllGTzU1TVRZY05Ya3V0dGtvbmpXazhVb1FoL1c2M0p6R1UvOUJYckgz?=
 =?utf-8?Q?ECFo5gF1V+KE4cew=3D?=
X-Exchange-RoutingPolicyChecked: K5rEI4scnr06arXa7kSZhAkWTEnuXFSXLakcrTcAdOsvGOI3gDEs++hIvLWkx/F/66UEsADlYnvuSlaZEf+bki32xAXoQRYhm0DRkMNh6Kv1q9pfFqk53Ydi+iA+dMRTfqLyZ43DEbKN5ouDHEIn0gh4sm+u/PfHDVD4OMHZ0m7OPfUGa+4PqpgdShXJMwRYRJhxTXKwQmGKhhituM6jO48BhmWUi9TzI0K255iQPqgtF8JFwZwkLUmaVvreOfw4Jpx30Qc6834pghSCL43beaeL3PknUKSLIpxy95ZZchDSFp6/J1/Vb99htrQuW/+5i+vEFcMqdIR23txt04ECFg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f7f2c-57bb-4bea-b49c-08decc5d83df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:45:15.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwaKxyxGsIlZ9T21q+M3HS/I1p272gEQ0nMgc5pSKvuVih0NHT6tdOYRJhvVIjJX1x1ZBwue/CMUChw2O9LC2dQLVm/Ufy7nzFLfoyIOJ2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8374
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX1erEI4LNz+pK
 6/d0XXRlaK5e6i6ezMY/GB/17ilGX2ojPU8pXkTxdiRCjXe7oLgM7Db1KAN/5hVlaiWihCPc+3p
 Kg5A8fy1KKFeQ8KkeH0OvsDVmto5cdc=
X-Proofpoint-ORIG-GUID: q4EGpf6cQhFZZXSBoUGOSWRvkpKlid4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX2w7+LKK2lcpO
 VP1DUiI7LVEcW8AkVQkr50PYiGnWqMyVtzblPnxPpseRkkmBhaBrsmLaQrDJbqafSAsWlaJ+MKn
 eu7dlhnJaNS4sbKsl0BYtr1JAjJUxRosymMdgUaNckpfNri936jBRGAIhFK3D5jlrQVp7PTNUiL
 4aNHye1Iw6F29W6IBZImXn1uKv3nSziDqDkKDONYt8WkX4OSy4XSCFCvguZMbSgTvfMMwf+1pTg
 GgDQvAaYqsQU60LKWgA7YFcL28jMvY/ApCqP5ObkDBYCVCzOX9pW9VlCyPWXE/4vihB6loMkKK8
 nwPE0gNlL/fmHTBnw4TQCDPqMkWxxbqWqXnCJodRtSaiDXbw6H2zM2rkGb7I3nXhLWUuTrY/tgL
 mLR2xmthSLrQn2JuO3Z+zKSS4B3CPhirYrPg0ruIyGLnf5sj+R/72mhFf/1hKVuwtanbMf5x64T
 1blmvIXp+kFRfV72LHw==
X-Authority-Analysis: v=2.4 cv=csSrVV4i c=1 sm=1 tr=0 ts=6a327abc cx=c_pps
 a=fJIB0T+C2yAfE4P2TQxPqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=20KFwNOVAAAA:8 a=QmcCrT41svQQLY4hiI4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q4EGpf6cQhFZZXSBoUGOSWRvkpKlid4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 16/06/2026 17:22, Peter Maydell wrote:

> On Tue, 16 Jun 2026 at 16:57, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> Prepare for the move to dynamically allocated IRQ objects by
>> introducing qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
>> functions which call through to object_new instead of object_initialize.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   hw/core/irq.c         | 35 ++++++++++++++++++++
>>   include/hw/core/irq.h | 75 ++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 106 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/irq.c b/hw/core/irq.c
>> index 106805e241..e943c87b81 100644
>> --- a/hw/core/irq.c
>> +++ b/hw/core/irq.c
>> @@ -49,6 +49,13 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
>>       init_irq_fields(irq, handler, opaque, n);
>>   }
>>
>> +IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n)
>> +{
>> +    IRQState *irq = IRQ(object_new(TYPE_IRQ));
>> +    init_irq_fields(irq, handler, opaque, n);
>> +    return irq;
>> +}
> 
> Isn't this the same as the existing qemu_allocate_irq() ?
> 
> (I have over the past few years occasionally been trying to get rid
> of existing uses of qemu_allocate_irq() and its cousin
> qemu_allocate_irqs(), because they are persistent sources of memory
> leaks. The function returns a pointer that the caller has to deal
> with and remember to free, whereas using e.g. qdev_init_gpio_*()
> makes the new irq objects children of the device they belong to,
> so they're automatically freed when the device is destroyed.
> qemu_init_irq_child() similarly.)

Indeed, this is another case where we'd want to use 
qemu_init_irq_child() since then it automatically gets cleaned up when 
the refcount hits zero.

And your point about the similarity of qdev GPIOs is also valid: in 
particular with Marc-André's recent work on property arrays, it feels 
like we're getting closer to being able to converge everything IRQ and 
GPIO-related into a single refcounted implementation.


ATB,

Mark.


