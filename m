Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF30D0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4KSF-0000Xh-Kx; Fri, 25 Oct 2024 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4KS7-0000X3-OU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:34:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4KS5-0002It-Ap
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:34:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTcqI013078;
 Fri, 25 Oct 2024 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ihlzQxnVmhxlIYSSgoV5cp09WP/xTTfsa5WwDa3+NAA=; b=
 ZALfDM3pT5YEBQdGqLx5WWjbKjm4oKE0hI5AeoogjAycEYxKvOy5TE6cE7QiyDDe
 A1mok4mNv7i6tm1lXS9IOd8soFwHvXC5adQSwQy5P1RNWQf6124tnoxphxyZB5yn
 t7pr9wA0fsM/suAnXn70BEt6ZcoscF2zK+XZfHYt9tTtlX5jsl4hsJ3hOTAdU/1/
 GMqiGMAiFQvnMebItGIZK0cFgM5cJMQ4IyQjLNTvIBm2n/Sj8J54tP45KESZI9S/
 LDMQw/y6VQbe5pyvnq8WRgK1F70rJRBXycgFNBKh7nYIKHfZphAHPSy0YwwZFL7G
 PNuobT07ep9dA96OLGieTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr46y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 13:34:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PBrVQL039178; Fri, 25 Oct 2024 13:34:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh5r9v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 13:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPvMwv6yyr+fszrpfB+ij8qQvuXzwXTcr9qxIpBjonK+KpXdMhW3dpJAHnsxf+wWgrNSFx8LrwLbrfzFqU8ocs01zfBjpualqZm0pUiOdIhktge0Fq8Hkzf5J4mIJy1O2MvAvcUhsohX9i5/W0pbzkPdMS38Ysa/oiMM3/F8Z1LnWaLB28niaUIQYxEEvlR8g6d02WEURGyGocf/CfIMNuoYXuJgLbGwqn0VdaSKE4N1bLYFecQaZk4jSTZQe70CJaYT17l7INHOB9JcqH0MKNbVJIPn6zeWr7SneWy8C1nvN2+EoBQgjBBT0OZyRXiTcmAhJMyMz3vBq4PsT/kwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihlzQxnVmhxlIYSSgoV5cp09WP/xTTfsa5WwDa3+NAA=;
 b=Bc/B3hXEHv+hO5yP0sPydyQjYCHjHpNQMBSU07U0DVA4rH5GXDxzg6vEVhOtw/4dQ3OXTeFTvKlmBR7khGt9JSIsoLcbgAv3DzYpkv3+BHH2tYfnQNaqYoltLQzvAkhf1jJeUCpSkHBCfGsxqIfdDAJv5bi30E70E4hqi+zRe9OQKtm97YynmbZjVB7/Ui2B0ZGfrfA+PSCRIpnZ2HuLa/BJFKBher+ZLN8dcuR53PVTA3A35AapFU5Yc5D5CaZv8J+keYPk2fmeYRfHujQJWFB1kDkJK/BOzutEjIFYRINZ6PBeiBYbpMpYJTnvSn/fPwg7AivL06QL0CkEniE99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihlzQxnVmhxlIYSSgoV5cp09WP/xTTfsa5WwDa3+NAA=;
 b=V1rcI93K7RJR8avIF/KNQg6Q9+QfU+U0RqDqD1eRf3LQYM3QOgB9YjPg5R/QtwNpJC69ngbyBvjeRYLDuF4TV8y22Di+ja7hwhpg39ViFWJfJx8OR/aFT0k6bk+D4OREjrNmbTbfIrLjr6LHWcd0+oJExXR2slapm0IO3bV/kQ4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB5832.namprd10.prod.outlook.com (2603:10b6:510:126::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:33:57 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:33:57 +0000
Message-ID: <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
Date: Fri, 25 Oct 2024 09:33:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zxta2w6iu2n_5YBa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0138.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7437f3d4-17ca-4bc3-6da6-08dcf4f9ad78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ry9JMWVDYlh2NEh6aHRaMG9VWmFzK1lNQU1FdDNZb2lOOHhnRlVpTm9nQVA2?=
 =?utf-8?B?aVNGVzVxRUFxeUVsTzM2eks3VzcrRGhVa3UwNjhSQ0xXY3JqT1l1VzhQeW1Q?=
 =?utf-8?B?aXQ0b1UxeDNUWWZUWG5FRU1WVWRyTUlta3JsallDc0gyUDA1MnZLeDdUN3J1?=
 =?utf-8?B?by92Y0U1bldPWFBveElyQVBGS2UzdnE5YlNKUUsvWTdiNHhxOG1lNjhnYnFV?=
 =?utf-8?B?THBCTEJ3cmgwQWFNOGdYdnFLYkxwcGtyaDJ3Ylo1aWN3enlqN0hha1JpRWpH?=
 =?utf-8?B?Zy9WQ2JXQktFbXVzNW1uNDRpY0FlVWtRYkVGRDRLQWY2NlgvRWlxOVd0c0xY?=
 =?utf-8?B?am5DYnFhT2pSZ2Z6ajBpNHVOYytwMGs5ZHBSTVdYUFNQbnE4UTR0VXpyekhH?=
 =?utf-8?B?Tk96SGxDc0lyTGxoOFRFU0FPUmRFZTZoT1l3QUs1TTVxOU1XdnAvbCs5SEJM?=
 =?utf-8?B?WGVYdVIzZkdrVGdEMnFWYTFLcnlOeXJaTzVxRW1OZ3A3M0ZIcXR3RXIycmVy?=
 =?utf-8?B?emZaN29WZWVEQ0RVdlR0U0JFZkNWbDU4b2kreGcrelMzaDJrZ0FEbXNkTmM3?=
 =?utf-8?B?SWVUVlVZbXZDYlBUOUNSS2Qrdi9TTElBS0hlcWVHQkJhb3htajFBLzJ4QmJC?=
 =?utf-8?B?elh5bEhDMEJ0NG1uUC9UQVdZQW5jd3NsU1oyWmhHekxsdk5kOGgvcWFBa1Zr?=
 =?utf-8?B?ZCtVTGZOZHRoZERQeFcvb3ZlSCtxVmNHYVluaHdRbFpkNEM4OTV5T3UzUGNE?=
 =?utf-8?B?cHllWDcvcFEvaWFwR1hmRVBxY204b2VWLytobEVEd3hrZnoyckJwandZWUs1?=
 =?utf-8?B?L0t3QXR4Q0IyZUE4a1Y3Rlk0N0w1SER5NU4xVUVCdTNqK0x4b203ZjdJZWRr?=
 =?utf-8?B?bjZBWWdqSmhaOU1NdW16Z1FRdldDWnM2N25Dc09veFNqdzdZNmNzemplSUtM?=
 =?utf-8?B?bHZlTTh6MW1UdGFxODF0My8xZ2doUlZVb2RSZ1FKYTBBcXBrMnE3SUN6MEIx?=
 =?utf-8?B?bVRQdlY1MkpuZmJQLzlKSUIva05LenMvL0JWNjlqT0RFbExTTXJ4eVV1cDN6?=
 =?utf-8?B?U0wwcWdEeE5zNm5rMWxnaE1rN1Nuc043aDRrZXh6OUlzNkdNSWhXVkRhUy9Z?=
 =?utf-8?B?bmdBZ0l3d21CNElnQ0Y2REF2VEpramlQMHVDZzQxZnV0WjlWWlBrZ2k0RGFO?=
 =?utf-8?B?blp2NG1WcEJldGpWdGFhMlV2NU94b1FCT3NlVmFpSU9QcXBvN214L2tMa05n?=
 =?utf-8?B?cjBaVlNyeXIrSEhCSHpELzFDUXB5NFhqVU8wNzBMUmR6clVmTW1BampxMFh5?=
 =?utf-8?B?WDlVSFdqZnVlTVFGMDVFSFNIQXZ1dFgyMWJpejI3c3B6S3J4c0ZwN1dlZ05Z?=
 =?utf-8?B?Zm54bzgxNzVNN1pkaWtsdTB1SCtlV1BOQ0xHeUVvWEFEK0VmdnFOTjkxUERR?=
 =?utf-8?B?UzBvS0R6WGpzbEs0UHc2VEdGMDNYTkF2RlFqNUxvOFU2cEhjNHJXL3lPL09s?=
 =?utf-8?B?Q3lYdmRyWmxxc0NwZnQ1NXpsRytrcEJUaDlFSjZCcDhZS01SZURPeFVsK1U3?=
 =?utf-8?B?NUtmZHJWM05ZblNiVVNsOVlvZTRyVjdzMEJtZFN1TjdJS0ZMb3RvMnZLeGdF?=
 =?utf-8?B?MjFEcDVxMWxDdUprRVhHZjVyVXlLbVVTR2RqRUFhd01tVERhM2pwcTBrMUpS?=
 =?utf-8?B?akx0SWFYL0FFdGoyZTN1bXliQ1hvZGpoV0N2WkV3M1FrcEMrRG8zMEJGd0dX?=
 =?utf-8?Q?5nOXxoqwQmB9HvsKuydo6Qm57A/93IWHbEkbLJD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE5IRzNsS2t5eFZYdWJnS2dRZ25Dc3Zpc3ArZ0ZzczZLdFlwVDJFYVNlRXI2?=
 =?utf-8?B?RDNZOWtBcytUKzRGYnRyL2J1V1pOT1M2ZE42UDBPaWZwZTB0dXJBTUkza0lS?=
 =?utf-8?B?d0JERkNCREpialRDVC92cjd5Z3F1YTYwdkFxanVYYnNHT3dmWTRlRmhCZkc2?=
 =?utf-8?B?TTN2Q3I3RWdBdFNRNlc1UDdWMjBEWHpIdS9KMlJzYTZCUzVBTDRRWEU2ekZF?=
 =?utf-8?B?RXI1c2lTWjl0L0F4Y2dTYzc4Tkdpem11cDJGSXhMUGQxYmN4QjVNczhIWG4z?=
 =?utf-8?B?OHVaaG5ER29oK05zVHIrcllDY0s2bjJaTVZMMlVBMVV2YnVucDJEN29LcjNu?=
 =?utf-8?B?VFJoTEtyZTZuUVRzbW1XUXBnc2xtYXBSUjZZUlpWSkJPWWJCSGFwVm4wazlW?=
 =?utf-8?B?SmlGbllRSitlMXpUdmgzSm92NmFGcVd5OUU1Rk1xbmIybGk0WjhXL1J2TGh1?=
 =?utf-8?B?M0IxQjZPZjlOdjgrYWYrUWt6OTBqSG95R0tpaEF4Z2lrWG41Q3R0R3hHdGtl?=
 =?utf-8?B?UmgwRDlTMVBsRnRBNUVwcDJhb0RhV1h5VEFWQTZaTmVUN2JXSm5YR21ScWk1?=
 =?utf-8?B?TEJ0SzFzYU9lbVIzK0xYT3cyejRocTVIczAvWEJoWUJROGcyU1ErSmJ6eWlL?=
 =?utf-8?B?QUV0UlZUMHljZjRFenIxQ2d1elQvaXBPZVJWQWs5cXljNVlTRENmSWlyaU9H?=
 =?utf-8?B?WGdvZlI1RXZEVzN2aFd6aXhDODFCMmFJLzFiVkEzR2dPajFibHZFaEQ2WERT?=
 =?utf-8?B?bE9lR0NJRWJUamgvQXp6TU5Sa25FNHdZV0k3MUxHcWpXQ3FqWVNPQzBIbHJB?=
 =?utf-8?B?K0JLRHRTVTZzNVRIVHdLRkI3U3lrMmdpQVJtcG5HVFF6dTcyK1FPWUpYbGpk?=
 =?utf-8?B?OWwyRmtuSDJ1UWF4anMzSmZ4N3NiZ2VORjJ2NktnRm1NdmtZSVFRYnpJb1dB?=
 =?utf-8?B?bWdPUzJvaGpHd29McEtJUFo2ektyODN5ZU9SZ1NJNzdLVWl1Nk5OeVhqS2Jj?=
 =?utf-8?B?NmM4SHc3T0ROWjlPWjFiUTA3U0NtK1Y0SVN2N3hlL24yMVora3J0ZTJhVUFl?=
 =?utf-8?B?alNKNFdibzBVcW9PQVNNM3VuTW01ZjFndXhBaVBnL1ZWYWxVVzVobGtaMko2?=
 =?utf-8?B?bGlyN2VGTXVMaEdaVmlRMjN4QmpUVzdFUHhMN3BxcDVCN0ZyTkUvM2tqWUV2?=
 =?utf-8?B?WDJXMjhPNnkvYWtTZDlLb0MyY3N0M0NmNkRIdE9zbEgydnVnZlluZSs2UGYv?=
 =?utf-8?B?U0x1bUpHM1ZXbVQzdWV1d3BVRW1uVndJRlp2UVhhYU5wQnZxQndURGZ0eTVo?=
 =?utf-8?B?N1N0QUZNN0h0eHhxQzZCeXhGK0hiekpTZ25lZ3NZbUdoV01OVnlvRDU0MlZa?=
 =?utf-8?B?eHdhL3pXQlRZMGljNHgrTzBmOWtGVFBwclBYNDQxZWh0TUhOV1FBZkhtYklB?=
 =?utf-8?B?dUdXZkU4NGh4V3ErUnIxU2RnU1FjRlZRQWREQnZKcVQyRDJFMlhxQ3MvY1ov?=
 =?utf-8?B?cmlJRlhsRHhCOWRsVmJsdWZqMG4vcDZHUWUyd0laSFY0R3VZUWlHZDlscW1w?=
 =?utf-8?B?c0pvS29MTGZaeFV6NjhFc0RTWndObkw0L1ZMTHBzdGpvdE1GamN1MzJPL0Q3?=
 =?utf-8?B?WjJ0RFBQRWYxWkRJSGw3QU1nUDdoNjBCMnQwR3RiNmY0TEJIUUFNdFlud3V1?=
 =?utf-8?B?Tmd0SnlVcXBvUmtIdGJIU0Q5K29xSUpJeDhtRXJicEJzOW0zdHhDK2h0M3Ja?=
 =?utf-8?B?MDlsMDFuTVkyT3pzY3JnYStEa1ZMZlV5UWhwMzBuclo4bGxUcGZ3TXVpLzJa?=
 =?utf-8?B?eHB1Qi9udUZ2T01DMUM2VUJtcXpsRXhGME9xcHhOcEpOTGJWZlh1R0RSOTdz?=
 =?utf-8?B?R3lNNEcza2pkOUIydkhDM29jZlVZRFkxMkVwVWRWVjE2ZGxCWmpHeFlLdWV2?=
 =?utf-8?B?Q0F3bW9CVWhqS3ArTzRLQ3YzWkdtcHpEUm5KS1ZVLzc5dEFtZTAxN3NLZkx1?=
 =?utf-8?B?U2kybGdFdHpuQWdPdjRVZ1VQUHo2YXU3RWQrRVd0aFA2M3VkUFBtQzRoUy9j?=
 =?utf-8?B?TlFJZlZNR2pOR3l0Z0xPbnpmbDRIZVU1a1JVWk1RazhiVDVjY2M2Wmo5bGZ1?=
 =?utf-8?B?cWVDL2tKR2hNYXVmSCs4NlU1S2FNeWttYXpRa1JINWxMUHdQdU9DVzloMjJV?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: waPDkPe/EfMH4ICdkVV6SAFb7xw0ZeHPLl+nnQ9+U/dXskpRUlked7/R8E+DWA1tU4eXZ3zxt58EYp0bUPUJXfsZ/EjKwcR/cXC8JAO40g7NwxPLwfC9qUPuNdb1KCt6xmHDBp/OjX3eZS8oo9JRmKRtk/pTWgqwj+jALUJ7HTnyTob/Xv7l5oAK8cbzEwSAAp74fqcSfKwb1RA2k9qUDqRqXT2NAIX1VwbbXtuexd2DDQ3t3/GRBRrW5xSlHW0YH9cQAjaiXrEdJIODZOO5CrXI13+/GT9mQtggjwixhTAROQCp+DMEErgt3ag8E5d8YurVrUDvP1wKanqHuLKeQJA+ra0q9uk4mcBy+Ue7hgSPOHkQ5nBRgp44SKuRuMlfXjFyr/YEsZDC+Npm/CDx4CBzfEWmiELze5SpQ+CWj6CZYqTI9TcZbDFI1OyzsKH8I77j9cERutmqLqxiBnInXwhPp65BEiAlBu+BTm+3BtW7iqNBtrpxuiMPWbpAqw4PF0DxnBVums+KQmbh2m0aUg7BSPCqo08CeRJbFeQp/b7jBDVe0UFgTD5iOi6R7lAT4DjIBFiOOPh1MqvaNJw662l5P2oE+8k3NFiSbMMQuBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7437f3d4-17ca-4bc3-6da6-08dcf4f9ad78
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:33:57.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4X1fcYZQQXEmYzD2O1fStQx+n4o/uDCNcH5Hy78ORvZ7RoDZ5IrzMr5dY2aCjHK3JJSzXF/ccEN6qqzj4SU2UwYW0lPjKZRzIo3IO86LgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250105
X-Proofpoint-GUID: q3z26b1HYmizD80Ru9FL1L8JUq2I3WbZ
X-Proofpoint-ORIG-GUID: q3z26b1HYmizD80Ru9FL1L8JUq2I3WbZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/25/2024 4:46 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 24, 2024 at 05:16:14PM -0400, Steven Sistare wrote:
>>
>> Regarding: "what you want is effectively to execute monitor commands
>> from the migration stream"
>>
>> That is not the goal of this series.  It could be someone else's goal, when
>> fully developing a precreate phase, and in that context I understand and
>> agree with your comments.  I have a narrower immediate problem to solve,
>> however.
>>
>> For CPR, src qemu sends file descriptors to dst qemu using SCM_RIGHTS over
>> a dedicated channel, then src qemu sends migration state over the normal
>> migration channel.
>>
>> Dst qemu reads the fds early, then calls the backend and device creation
>> functions which use them.  Dst qemu then accepts and reads the migration
>> channel.
>>
>> We need a way to send monitor commands that set dst migration capabilities,
>> before src qemu starts the migration.  Hence the dst cannot proceed to
>> backend and device creation because the src has not sent fd's yet.  Hence
>> we need a dst monitor before device creation.  The precreate phase does that.
> 
> Sigh, what we obviously need here, is what we've always talked about as our
> long term design goal:
> 
> A way to launch QEMU with the CLI only specifying the QMP socket, and every
> other config aspect done by issuing QMP commands, which are processed in the
> order the mgmt app sends them, so QEMU hasn't have to hardcode processing
> of different pieces in different phases.
> 
> Anything that isn't that, is piling more hacks on top of our existing
> mountain of hacks. That's OK if it does something useful as a side effect
> that moves us incrementally closer towards that desired end goal.
> 
>> Regarding: "This series makes this much more complex."
>>
>> I could simplify it if I abandon CPR for chardevs.  Then qemu_create_early_backends
>> and other early dependencies can remain as is.  I would drop the notion of
>> a precreate phase, and instead leverage the preconfig phase.  I would move
>> qemu_create_late_backends, and a small part at the end of qemu_init, to
>> qmp_x_exit_preconfig.
> 
> Is CPR still going to useful enough in the real world if you drop chardev
> support ? Every VM has at least one chardev for a serial device doesn't
> it, and often more since we wire chardevs into all kinds of places.

CPR for chardev is not as useful for cpr-transfer mode because the mgmt layer already
knows how to create and manage new connections to dest qemu, as it would for normal
migration.

CPR for chardev is very useful for cpr-exec mode.  And cpr-exec mode does not need any
of these monitor patches, because old qemu exec's new qemu, and they are never active
at the same time.  One must completely specify the migration using src qemu before
initiating the exec.  I mourn cpr-exec mode.

Which begs the question, do we really need to allow migration parameters to be set
in the dest monitor when using cpr?  CPR is a very restricted mode of migration.
Let me discuss this with Peter.

- Steve


