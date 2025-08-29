Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C02CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNEw-0004sm-VU; Sat, 30 Aug 2025 11:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urx05-00011Q-KP; Fri, 29 Aug 2025 07:10:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urx03-0002Eg-CL; Fri, 29 Aug 2025 07:10:33 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57T8ixFv3583241; Fri, 29 Aug 2025 04:10:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DTBMwvu34fppXRzoyxi5gANLwJeNeLlVFf/LmRot9
 64=; b=W8tvl52juai+dg88VIjRvzB4jYYQu/D3MLE1+Q3xV6tcdcxdtGqL286Ls
 1BvGpoioPwbPyvn7979cSSbzQk7Kaetgk0FQKxPDHp+h0MqcwluipEyTWn6lVcbC
 lu2OVKZ7XKIpulYdscpfrRlNoASXwCTQZjYbMaiXdHyRZ7VS/8yDaVaVgl+m3QA+
 hvBhLOaX6ewkOym+KdB5nezl7+tZV78NTgdinId0pB9hsfNGa4PFYVUrEMtjoMaJ
 c+/ePGREcAmPr0R3ECy4D6cSEN1C8aayQD/WcOe29iFf8oEmVqjbmBLr6gHq3Cmc
 MUvyKunStlQLpOjZw4HyimDZcvA+g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2092.outbound.protection.outlook.com [40.107.95.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48u6v18jh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 04:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4z8BCfz15EEvFgr58vScjSOHqy+NeVESqjdVibLKdJqUlNixyRvk9BUi0JsaPrfPgf+o6raYqwQv/DRHPgqEm+Kc5z7MaHK0CwqNIQNZs/LXSiAsjmU5vNa4R5n5fdBMmS2q2EeNq8qabOPHSsy8Gqp1c6uHV3lhxAQMW0qiWXssimenKlLU976VeON5669Fw3whu1CBXgJVS7G1MdMDOMCA5rs8LPLTjRtKWg3Xl8tshL1p+mmKh4q8LbIWdQzmhKBLI4WR3ctomgdcgDVJqPMgTyUMGfadGJtAZM0A0/ziFbMrRgWBS4pbdaaYnjhIeZjKxbjNOHFqY1N0Ed4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTBMwvu34fppXRzoyxi5gANLwJeNeLlVFf/LmRot964=;
 b=QHApIS3jdg7La32GJ081skaojdmQj40+770CJakQXRT+THVTCwYyutdc/8vaFnZ2cBy6aPuiBVGMu0zqjS8cG+V+Avcq1pmyxrETlVGceEK6zvlCrZrcXrDU8v7RssIEb4J2QFIoZyP/M07KG8ijz3cOB5Jx8nu4Gmjurs8L6FNelk04ug37IBnmgwmsF42yEDTFB4KvxmB7JjncYYIqWnpZXutstZuZXfwpi4y8DK0d9sOviQKn0GEoJyw2VGeDWtPaK3jieYT+lqyj73711eDKBrkD6q4kFL8ZxYFz8hj8TTP7L01Tzc8MebOe4sjjgBA4EBghHKRqwp2COeL3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTBMwvu34fppXRzoyxi5gANLwJeNeLlVFf/LmRot964=;
 b=sS8nPfbgduYhwSGNNxFsc9T8IXPpL4zvPyDck5PRyVl48++cgtHv7uwgufoUt9E8GHY1NYi4qiX+XxT/yYJmMOiDUyhwbqe8HZ21eNbE/Klpv3VuCdhzyLJhKNlVnAcDlRV1vznjS9NIgu9+rnTlmeBOImgNXqMRWErQffYDkw/FLCE1AHMFPrOlW5jp/CFFo4JfJIX1x+8lj1t030qrKQU8wYi3h0wEvoxc4f+B/t2EsshCx1804k+pIzC4qG9XJCFjOyz7pNEt/Jftf08J5kA3dVtyPWsYpIZsabXIMuPhvEuZhm1MQ9oPkT6++I9ziq2+erVTo4aC7V+N4hsYKA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB10059.namprd02.prod.outlook.com (2603:10b6:610:19c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 11:10:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 11:10:20 +0000
Message-ID: <4bb2c920-f86d-4d99-9b3a-30a7d6afd074@nutanix.com>
Date: Fri, 29 Aug 2025 12:10:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] vfio/vfio-container-base.h: update
 VFIOContainerBase declaration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-2-mark.caveayland@nutanix.com>
 <8ad7794c-97a8-456c-8d52-a80f439659bd@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <8ad7794c-97a8-456c-8d52-a80f439659bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0151.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2c1f5c-fb7e-47d9-2381-08dde6eca4b0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHBSRGUxK3NaUTl4d1M2Z0dhSi9JMzNjaFFrTTZpZ3orVC9sVzZTYkE3am5k?=
 =?utf-8?B?MTEvb1cxcDRTTFRqdytZZkN5YUt5Y3I2a2tkNW92V3RIcjFVM0ZSTVBGdzd2?=
 =?utf-8?B?WmxiRitNazlWbXpsaEU0Y0h3cHhSZmZRRXVwQTZ3czNsampIK1RrQ0RkbzR0?=
 =?utf-8?B?ZHJJeEhVcUVXeUpNK1E2UXZ1UHhOSGJQemFJTGJoSmxXRDhzRlVuL0x3dXk2?=
 =?utf-8?B?cGl5M0luUU13WXlRUmpQSFA5d21nWXBRcVF3L3ZnYU9LYlpuUSthODFBRnFi?=
 =?utf-8?B?STNTNmxncG5DdzRFZzE2U3JGUGtWYjFlcnNaRExXUkhWeWpEdGM0ajJUc2xx?=
 =?utf-8?B?Vk9xWjNiVHNWM1p0TDllYzRPRUR5amVObjBneUFiSWhEQWhVMzVGTmxEaFVL?=
 =?utf-8?B?VzJmUUlzU1A1bTZ4RW13dlUwQ0pBOEUxczRONHpyd0RBR2N0bWpiU3FuR29y?=
 =?utf-8?B?Z2F2d0wybHhoVUpoWm1CL2VPbkpPbU5kRFBDRTE5aHlWVjdaTmZNV00ySXV3?=
 =?utf-8?B?MVRRMEl1MktkUWdONDY2WUNVWm5mNUNhelVHUVQvdy9qM1V5WFZMU0RnRlZt?=
 =?utf-8?B?VUNlVVo3SlB2ZEhodFFEZHdUWDlPQjUyeC82UytqaFI2S3JmSnFYN0l1UXE1?=
 =?utf-8?B?TDU1anV0b085UHhpVUtxektKaHdSWDVSUm9VUzVoMi9wTlZDcEU3OTFTSnVF?=
 =?utf-8?B?NkN5UU9QWnhuaWRVV0J5TFI2YldkY0lxSTMreFlUNmxyUUFEY0dFVnpUU1l6?=
 =?utf-8?B?cGtDbmlQcTg4c3gxVmdlL01NbXNnOTdramllazMrUVQ2UUMyd29URURlZ3FX?=
 =?utf-8?B?RTY3ZlllYy9pckd1QnBSVnZ2S2tDcGl3QmVDWm55Y2ZYaDE1c3FFa0djU2Rz?=
 =?utf-8?B?M0tja0s3MjJsRitjOXRCWWpxMW0yYlFiR3RXdXVJRVZ2dkNyY3J0MXZ5aDBB?=
 =?utf-8?B?VlNkSG9GMzRZSFdkSWc5LzVNdXhhbkdzKzlhb1FZZWNLZ25LUjRSTytzMWlv?=
 =?utf-8?B?ODhUcURDckptQjVwTkk3ZFFLM1Q0ZGtIcmh1SWQ0aHJUaGhJYU9OMGNzT0FI?=
 =?utf-8?B?aEs4ZzdLNEl3MXVKcFJpMW9HNkYvS2QyOHVjR2tBV3hNVEtuSVp1c3JCaDRI?=
 =?utf-8?B?bmk5bDgvcmplSTZQQ1R3STJSSGpaM3d0TEk5ckEvc0JScEJzTzYxNTZKRXV4?=
 =?utf-8?B?ZDNyNElVeWtaZzhLUlpJOGRZeGlYZXJPVDF2WGtSblBtOCthMTgvOERxRHpH?=
 =?utf-8?B?QlZiUUg2OXpocnpwWUkySURhd1hqbjhSUGRlSWw5KzVuU08zTnJDTHFxckRi?=
 =?utf-8?B?d3VSalRSdWxMdnpyN0VHcjA0aVVFZEZjNDljZENNNFI1OW90UUFRb0t4MXg0?=
 =?utf-8?B?Sm93VEZnUHNWT2VJendrS1BsN3RMMTRYdHdGcmJQZndTRXFXdVF5Z0k3MGJR?=
 =?utf-8?B?Y1E3TGpVMDNaMnBxZ1VNSzFtYnZQS2lLWGN2YnFYSGRrbHUxL21XTTM5cWpL?=
 =?utf-8?B?WmZJaGJhT1BZUE56L3c3bCtlclowZ0VPNGFZWGJ4NkVOcXpETXg4SHVSQlZC?=
 =?utf-8?B?UlZMTlRKRHF5d3FQZFMyVUt1aklxT0dabVcrcnZwWWViQk9UcTd0VmwwMjJ4?=
 =?utf-8?B?NUt6ak9IZ1hNS2w5bW1QZE53aEFKTUFwZ2tic0QvT3B2NTgvQk5BVS9odjI3?=
 =?utf-8?B?NkNnc200RUcraWJlVXFreHg4Tk1CZExNaWp6ZmY1VU1xOGJSVHZESnRpTmow?=
 =?utf-8?B?Q2FHZzFhMDJWZU1RcWtVcnROckZnMml3aFl0eXRaR0x6cHM5TFJEYmZVM1N4?=
 =?utf-8?B?OFkxdVFDM3lPRmM4ejlyUUVpR05UQXJVbnA2MmM2Y3dkOUtYbWxoalY1Rys4?=
 =?utf-8?B?Q3ZIZWtRenBUejA2enBNTitWdUQxemxkZkwvZldwSngvNHZYL2lEbWJYb3pM?=
 =?utf-8?B?N1pLUXg1QUdMTUtleGRFQXZvellGRUc5bWxRN2t6clFqYk1razQrNUdlQUJU?=
 =?utf-8?B?YmNDN05veElBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3p3V2h1OEYzTFE0aHJiY0NOcHBKY3YrUUo4ME1HNC9sVU92dnJkamswRXRu?=
 =?utf-8?B?N2hwaXRtL0dDQzcyODBSUWdRY1hKdnZpTnhQQmh5UHN0dVBYWVdBaG4yVTJF?=
 =?utf-8?B?VG5FQmVlU0ZqcXE1bWxab2lBckp4SW1RL2VJNC9XOXg2Ym82cmhiK0dvOCtm?=
 =?utf-8?B?WVI3bkZDSU5IRGt4OEdSVGd6YkpPSFVNMC9sU1NqTFpoaEpJcGQzaUVZQmhs?=
 =?utf-8?B?MW0rNDhnNDRZUXg4SXBaWm1zVm1zTzkyN0xjR05tdGtuNWVoaXRNNTdFTzIw?=
 =?utf-8?B?ZFdGVDlTeHZEMVRvY0RrdGduUnlkY0IxY2ZVSElCeTJnaHNnajlvdUlWc1hO?=
 =?utf-8?B?MFFiUzlISnNzMnF6THA1SWZ2c25wUXpoeS9SNWxCZFBsS2ovNVNubUh5UU9J?=
 =?utf-8?B?WFlBaGhoWWJCbnF3dUxya25tV1RPWllseFJFR2E3QWd6YWJVQXlITDZIaFVn?=
 =?utf-8?B?emVJaGdRK3FITWsvdExPc2dGd2FjcXh4RERkS0hESFd1K2NuUEF2RXRYUDFU?=
 =?utf-8?B?bHhid0xpam85cWZ0UjFLeDlJRGV6bjJFM3FJOW4xSkwyM0ZxRzJoNzFZL3N5?=
 =?utf-8?B?UkIrZk1HZkxmQUVXMkFDWGU0TnR2YisrWlE1TjVoRDBPdVQrNTY0R3RmVXdD?=
 =?utf-8?B?d0ZOMTlKNm55SURJaFFNRGkyNi9yaFBKaXNmeUs2RWlpOElpREFuTTU1YVZT?=
 =?utf-8?B?eGhhVmRsRVUrNjd6ZEJWWm84cGEvWFZJeGlkMGNWUCtzZ0xpcWh2aHViQWsr?=
 =?utf-8?B?aFlsVjExZnNRT05JM1dTNWF3MEh2V3NoeTB0MFpSRlJCRkNEL1JqRExTcjdy?=
 =?utf-8?B?Wjg1dlNmbEZVK2xTS2I5R1FoSVhqRGd4WGtzSlEyVHFsdWw4bC9tYXpMZEI3?=
 =?utf-8?B?WFdBMlhlME50UHR1SEc1Z1F2TGlETHFlMXMwM0UrNHRpWSthUXVZMjhQaFFv?=
 =?utf-8?B?VTFlZWlYcHluaHQzUTR2WUphV3VkUlBKbUVFaTVyMnRtMmZVeTVOOGlHTEZu?=
 =?utf-8?B?TjdCU24wamo2VlpGL3d4a0s1eVJ5SlBLMFdJRCtHa3U1TUh2NG1OMGYvUmkr?=
 =?utf-8?B?VXR0K1NIUDc0RE00ZDNaR3I5NTRkUDFrcWRnTHJFT285TlNlNGQyRC9YeWJX?=
 =?utf-8?B?Y3lvSTQwVlVoZHlEWDNzRlJweUUxaXRkbWV6NlJaNThhakhhYmE4WC9INDVS?=
 =?utf-8?B?SE91TnAxSUJvZnVJYWZtSGIxdzNaVkMzOS9zc1J1SFJpRkFnNnBBenpYZnhW?=
 =?utf-8?B?T0NKd01LTXVrWDBSNWlvSWdYZERtWnY2ZGxWNTIycVNvWDVHTWF2SmlpclFu?=
 =?utf-8?B?UW04OGNJbkVoejBDWm5OQnNFVWpxNk5CS0tmRDBMQWpJV2s3U3VIU0xhWncy?=
 =?utf-8?B?WWduU2JOVzl4Z0pJelpIZU1ka0MzSjdyRzkwNGVZUTlMZ28wS1hHcUp5b2Yz?=
 =?utf-8?B?bWRvR2RQYWEvdTFKLzVoZnFUWDloMUNqRmJBc29xMC9SbGNLS2tHTlZUMCts?=
 =?utf-8?B?bTdtTS9kdGp6Mk5rWURKRFFtSFZFazVUYWNiY0hHY3J2Z29nQ0ZScGVuN1hG?=
 =?utf-8?B?Q00xODl2QTYvUjgra01GOVpuVnBHSDU2N1h2VmZWbUpKY0ZKTHBMRFQ3Y2pm?=
 =?utf-8?B?cWMwQytjVlBUbTVWdTlycnMzK2k5U3JBZlpmcUJKa0M1bHNYb05oR3A4aUhZ?=
 =?utf-8?B?Rm0wQTFIalMxS01rSnhONFhXRXFWanlYVHlEWG42cmJQRkxKL2lzSUpwNWxm?=
 =?utf-8?B?NDZUWmFOMWh6WmRObWZsZWZuYnQzeG4vOXFWOTRZZlR2REh0VzZDcmZsRE5T?=
 =?utf-8?B?dWFuOHNvUFVtV0E3Ym1oTHlEOUY3cUgzQmwrN2VUdFRkU20wUnR3cTJ0R3Fp?=
 =?utf-8?B?ZFB5REptYjRIRFBZVE50MktMQWw1NkdIaFoxL0lUMWxVYUdTcGllWjF0RVVR?=
 =?utf-8?B?TnYvYWo0dkcyYUlvY1owczd5dmVUN3JnS203MU5MSWV4Y0pJY29kR205LzU4?=
 =?utf-8?B?ZDg5TmplYXh2YkpnNjhrb0ZlOVhGOVJQazh1MXpOR2lFT0RqemJpUThtd1NH?=
 =?utf-8?B?bEc2N3VxSGdXeFVwZG9PYkZYTlFvbTNaYndlREl1MlNEZU13Q2E2S2JKZjJ1?=
 =?utf-8?B?V1YxREp1US9SK29KcnpNWHZlb1lhclFUOVovRExGMUhtaGp6Vm45Q3RXN3V5?=
 =?utf-8?B?S1JDSUs1dFBLZFVmZXZ5SXNCTFQ2bGdKU0NzWWwwS3RkWkwzZk9uNWpKNnI1?=
 =?utf-8?B?c3lhRFVRazEvRTZCZ1NvUFpJL3NnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c1f5c-fb7e-47d9-2381-08dde6eca4b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 11:10:20.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2+T2jme4e4iDJbrUePUwXnsIg9TVUpaDDBofMIpltf88vMlwmi/yDE7vnTaVxNH0/awpZN7+GV599BYKdEGPNrb14nV+jAI/xZIDjPhkxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10059
X-Proofpoint-ORIG-GUID: 1otlKsSeqeoTPl2vWU4eLNUP99-YP_3i
X-Proofpoint-GUID: 1otlKsSeqeoTPl2vWU4eLNUP99-YP_3i
X-Authority-Analysis: v=2.4 cv=B5C50PtM c=1 sm=1 tr=0 ts=68b18aa2 cx=c_pps
 a=793Y01VNg1gv70ofVcud0w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=-nCe5k8qGLeeAvFCX7AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA5NCBTYWx0ZWRfXy1g+1i494Fbl
 99uwXkRW3tzAYhaumQXhbzcj+xWzHSRF9ljZ4c2OI41fdHPVnv9DTwp8JrnyJ0Nor588gtrgsfH
 87xI8igy5p+jMK2+X6NFDEr6WA+UyvfaZ+VoFPkm9Y6WG5ogmNzTuTTuOHSJRFTjjjZ5Td01JyK
 Z+vGsbggPGZGPA1YBdqtaD63SuGrafttVx/S9uPXoyY158moF6pt20ffmoOFbeLkGQBXwxatHEf
 hxaOp+k1QB0YMYIUIsgFPqIr48NGCoJMz+KENs+fpdyRl9QtHt3ZNCIWzoAnhpcJKlZcRsNfYqT
 WyAyyMFbDdaVPcbqbH9N53EU0ihjdgRXJFNGNk/wRwJLn8T0pQfU3G3D892MQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/08/2025 12:56, Cédric Le Goater wrote:

> One more thing we could do :
> 
>> @@ -105,14 +109,11 @@ vfio_container_get_page_size_mask(const 
>> VFIOContainerBase *bcontainer)
>>       return bcontainer->pgsizes;
>>   }
>> -#define TYPE_VFIO_IOMMU "vfio-iommu"
>>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>>   #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
>>   #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
> 
> These type definitions would be better placed in the header files
> defining the other software structures to which they relate.
> 
>    TYPE_VFIO_IOMMU_LEGACY  -> hw/vfio/vfio-container.h
>    TYPE_VFIO_IOMMU_SPAPR   -> hw/vfio/vfio-container.h ?
>    TYPE_VFIO_IOMMU_IOMMUFD -> hw/vfio/vfio-iommufd.h
>    TYPE_VFIO_IOMMU_USER    -> hw/vfio-user/container.h
> 
> I don't know how possible that would be.

I can have a look at how feasible this is if you like? This pattern 
tends to be used a lot elsewhere and feels more intuitive to me.


ATB,

Mark.


