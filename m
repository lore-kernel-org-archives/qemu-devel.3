Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E83C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 05:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTaW5-0001Zf-2m; Tue, 16 Jul 2024 01:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sTaW3-0001Z7-0l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 01:14:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sTaVx-0005u2-5i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 01:14:18 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FKD9fo032191;
 Mon, 15 Jul 2024 22:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=KRjqiixKHxy/0/v
 d1kY/I/SkA87ginNGBnSf3dYicbM=; b=ICjjQledtcjp5Hu+F4eOEWojdHvjNYP
 6XdSFk8TUMdKt6SbyXyHJSITZqLqZlnCeChtXguoSu39MC5WWWcOoDduQ/UbHi51
 H9SeH3WgE1cGftMwxkR4ecaln87BngwBfJ3Q4I62B530UL8MBYV3I4rFBp7J2zU0
 BpsWvtoiXnIMmsTdu1fb+1kacCCDNySA1q6j6VMrXz/39vzxRyq4P5p49sgbeQQJ
 XQr4uvA6+nHlXwuHAGMSLDjZjzrnGMA9H7AWKMzWj55xf3zitTSZNUbG7/DRtTAr
 kREpuUXILMKfq9D/4izhlAEP3gBCS/dYD1v8wCO6ZD2n8wv6je6MQKQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40brwcw1q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 22:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aizg6nyI1jJ2lsxLnVFcfP6bPQ1aypcLlPdH3Uc+iph04uYlo3j7QzfFJmyh94T6k4S5moAez8tC4RlaDRkjyNLFAxtbWQeYsH/W7uepvZ0F1nVoz9h5ElfJb5UwPNwqtuX4WjGq/CCQiUkD91/ZhTBDWbPzuY53lklqOMRnzp/y3UWzY+rjBg8e3VubUIcAUoA8rK64zS5SeKTMXbRARBDXbeM+qwPrkZ5sAWEe75rxxP7VBN4sHhC7CjvVGStE1fESxKLBkpncDZQlJziIw+rDAMXkdpoPXxLVhW8VaLsFKrogNkLutfLj2CJ24rFxiU3drCXjsy3D1wW6ozKLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRjqiixKHxy/0/vd1kY/I/SkA87ginNGBnSf3dYicbM=;
 b=Qdloq+XTGXSalp4/fs7hgRHd/JQIOdPzjQ5O/i95J+x+LWpGYlh+q6sMD1VBpPDPw8ndPp6ePjPFXgRRfp3gIJnkcvqRHD3UxXNBrMzN2kyMk4XzUFsOlLCFKfx6wofW3+JCZPjdHg8DrApLR+y7DBkrY/kLs6dKri5YVjKyAiWlliN+QjzGoVt4YGr2HUDLjqvmQecVIJBJcQRPOWp1dlk7OwxZHf5INlbJ+OuYKyt5P7hFSh9Bz7WjAyzMbyIyKaUEZ7ZDLdoPRbUkKhMXu//2rsv2T6bhO7qB9CeEeYP7quTz3pXYzh85Pcklra5TTcQFfhFCnMXmeE/LbaHK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRjqiixKHxy/0/vd1kY/I/SkA87ginNGBnSf3dYicbM=;
 b=YQCf+mEvxsOFZ1rveciLl77FCi1YUaFoBmUMm9qtHgSmaZeWTEl58sKYb9JdDdH9RkC++1/5Ij5g7v3Ducuc6cJHsDK63qUL71FNpcvnFH7+bVc4IDRPnEP560ZX9vytVpvkKMJ2nlZfpKBBHC1+QMdutSdkkbo5w+wul1kNwS060jSQcUjmDFRQLVfMqSMKqg4HMGy8MbH5ojkBbzin6yk48PknLx4vK6lMs8wYSQ0pg12Tx7hBjofsGjM07RETeyaTQZozzL/ijbVvLEGvjV76WrfPTKFdHjFzlUi0VIb9Jyvmq2H16k5EPaem7l6vCjD4jddznNrGyyy695eClg==
Received: from IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12)
 by IA0PR02MB9438.namprd02.prod.outlook.com (2603:10b6:208:40a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 05:13:54 +0000
Received: from IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616]) by IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 05:13:54 +0000
From: Sandesh Patel <sandesh.patel@nutanix.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>, Dexuan
 Cui <decui@microsoft.com>, Alexander Graf <alex@csgraf.de>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
Thread-Topic: More than 255 vcpus Windows VM setup without viommu ?
Thread-Index: AQHazD8hTLL5FHwLqEGHw53bjlsZbbHjJUCAgAIG04CAB2mXAIAEmSMAgABCUACAAAfygIAHa5YA
Date: Tue, 16 Jul 2024 05:13:54 +0000
Message-ID: <0957DDAE-1214-4502-BC03-1A18D02B613E@nutanix.com>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <3bb7c269ab0a13fe4398d2c7920d2f6bf8e86d47.camel@infradead.org>
 <7BBA47BD-AC3D-4F12-A860-AD3F2B509257@nutanix.com>
 <39b92288418839e9cdba447705a44a8e216dedc3.camel@infradead.org>
 <b37283824ff4b7c6cc3a0c51199e6aa9b4b658a3.camel@infradead.org>
 <2cffab2dc20f99ab0c0391bbf5076113cf74411b.camel@infradead.org>
 <ACC111A2-A3BA-49C9-8EAE-C62ADAA74FB7@nutanix.com>
In-Reply-To: <ACC111A2-A3BA-49C9-8EAE-C62ADAA74FB7@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9017:EE_|IA0PR02MB9438:EE_
x-ms-office365-filtering-correlation-id: 098cba2c-d9f4-4177-50f0-08dca5561668
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUJEVkZ5Ky9OYWRGbHNKMFdYZHB2MElDUnhrT01CWnIxMGhFN1dRQVF1ZVNH?=
 =?utf-8?B?dytybTJoSENhNzNlNDlvcHgyUThsWEtDTEhOak1TZCttMVBTWFlFcGFwZEJs?=
 =?utf-8?B?Y3FRZkZ3MnFBcXc2M0RWS0lDSEdkT2NnZEpiU1hMSDg2YzB0d0RhaXJ4NFZa?=
 =?utf-8?B?T21US1JpSGxORGVVanBNak9BWnFNd0NwMHg3VENPb3lHSHQ0cGlOUnQvSXk1?=
 =?utf-8?B?VHk4dkpvaTBCa1VwcmI4Vk9JcTlpR1JEMXRIdkU3L05DbHU1WjVPSUtPL05p?=
 =?utf-8?B?bWtwMVB1YytTSWp4Vk9vVTQrWHcvS21Ja0hyUVF2M1ZOMzE1a2trWGxrYnpV?=
 =?utf-8?B?azFNSlV3UkZzZTVNS2N3Nzk5OTdOcmMrbFZxNUJlS1habE5OK2R4TjRqeUdP?=
 =?utf-8?B?WUtNbkRnM1dwbGNNejVMTFJ4THQvUFpCaDBZM2JyOHVSaEVpMEFZc2dMWWFh?=
 =?utf-8?B?bHhzcU9PV2ZQVnhVNzRtNUJBeGpBQk5QeE9Td0Vkc0FxVVVOclR1RmRQOEwx?=
 =?utf-8?B?bjFBcysvNURBTGR3RkFkTDhMV2Y1VkNpSmpiL0oxSGdmV08wQ0ZDVGliZ1FF?=
 =?utf-8?B?ZnNzVmJscGVBOE9yQnF3ZXYrM3drWVpEQmRPclY0TnFDOGcxcXhlTXJXbm4r?=
 =?utf-8?B?aFFjZVJoZVhNRXp1MHZSbXl0VVplUmgzd2U5Q1dpVkxPT2ZOdkF6NUV2RU9l?=
 =?utf-8?B?YXZTaXNkV2hEakhNZ3ZTZ3JpaXRNN2ZQczhWWUxpaXluOTMvZG85QXRha0Vu?=
 =?utf-8?B?S2NyL2NJQ0tOaWNPUW5uMW9WZlZyWGNOaHF2Wk5DWDVYZUFxaUNoTVlnUzZo?=
 =?utf-8?B?VGhvTWlVTXBLOWhjc1hXRUw0UGpYUWZXWUUvNjl0NklDNnlaOGxhSzUxT3ZE?=
 =?utf-8?B?UlFrL2F0UTFMaW94K0lCQkFzNmhLK3hVSnZlZVV3MG1keit5elBZRmFPby8v?=
 =?utf-8?B?WUprWWs0R2dDMTE0MktxVnljd2hGOEdvbHlWYmdjNzlZV3p4QWswcW5mMGtO?=
 =?utf-8?B?Y2pUa242VG42SU9rNVBzSzg1akdLdjFZVHJLbGdJMExOaDJ6Q2xrZk1iVWlV?=
 =?utf-8?B?QUhKM3B1Q3FwbnFtSzdQMTEzN25Vcm93aW1hZElXb3Y5eFhCL1dIZFQyMmVJ?=
 =?utf-8?B?Rkh3TmVxQXJJWnJSdThrS2M4WGp5UUNwaTVJOXcxM1RWZXowMzF1UWJISDRN?=
 =?utf-8?B?U3prMGgzWFdMY0prNWFqeCtRazdOVmFSSXJRb0dFTnlUUDVSMGxVTFlKL2Uz?=
 =?utf-8?B?aFAyOENYMExqZGYzSnNqNUdYQUxZRUNSVGlMaHN6Myt2VUJXTmRraEtxS3pn?=
 =?utf-8?B?eXMwaG9IMERoVGU4V25ickRaY2s2WWN0QXMxS2g4QUVYR0RJekVLZ0svVFBz?=
 =?utf-8?B?M0tCYUtvdTIvUS9Ea1VOcVJJRnhGUFBtU3Q2Nm9kam9QdnlJZ1dTR1dVZ2FE?=
 =?utf-8?B?Zjg0VGxPUVl5RWExT3FHa2t5a3BCVzU1YU41TTVqSGxONG11ak5YcWkwSVZv?=
 =?utf-8?B?TERtWUdOWjkwdVBaRFJoM3Q5NU40RVdWdEx6WGJvRDNjVWg4QU8ySC9mV29J?=
 =?utf-8?B?TW1UcFR4SUEvUzJ2NWdUOElDdXc5RE92dzA3T09TN3JuR0lNRVJZSjE5ZzAz?=
 =?utf-8?B?ZEhYK293TkdZczlQWDFZQXZJenpFOHl0M01hcEJFNS96NC9CQVJIS0tUeFI5?=
 =?utf-8?B?NUhjclBpUGpFWDhuaWVnRHFjQTI1ajRrY3VORnQ3MUloczhjMUNYRk5hZmhM?=
 =?utf-8?B?RWZmMUY0WEdIT0xzZnlFazcwbzFDK2x3TlV2anZNMjJIZ2QyeG0zWWo5eEs3?=
 =?utf-8?B?MEVaeXh6YWhFVjNlZEtyQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR02MB9017.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmJFOURsL01nVERvU1htck5wZ0pVYnE0eXgwdGg0YVhWeWxMSjZwVDhHcUNY?=
 =?utf-8?B?NmhVcDdHSWRkaVhNQUZQSG9FY3JRbHVOQ0NYYU9TMlBuVU9yVnVjOHlDSCtm?=
 =?utf-8?B?L1FueTYxL0hBNm1BeGloVnB4TDFjNXpUNk1LUEsvemdHQkMzVTNMMjdZRHRx?=
 =?utf-8?B?eUFPbi9hQnUwc1ZxZ3RZUWNDR1YrSjdkS1BGMmkwV0YyN3k3ZkxSa2p5Z01V?=
 =?utf-8?B?azNQcDRWenU2RnFKS2JKUXBrMWlkcWpZZlJwaEJ6dkt3YUpheXQrVVdjR0FG?=
 =?utf-8?B?QXliVFZnOUNyVzhNeFNDckQxb2V5cDIyRSszb1pCYVpJMkJkZzQ4ZFRaMzNB?=
 =?utf-8?B?Z3dqOVJtbE5waURWU3lnTVU5SU8valU2V2VOVmh3ZUMxaEgydk9od25YMVFo?=
 =?utf-8?B?UkhNTHZJNHBEM1FhYzZQZkc5VW9HVFBVaUl5bkIyMi9Dd0dVRitNbWVsaksz?=
 =?utf-8?B?SW1Dd1BSMllWYmlrK2VocXd2Q0dHTkpVREcrTmFvVzkrVDFxZnFVNi81d0Yv?=
 =?utf-8?B?cGdWOVBQaEtsZitqT1cwOGlyVVVQbDN0YXE3UzJDbVFTTXIzdHhlbC93VDN1?=
 =?utf-8?B?VjIwdVlhMTZ2ODZHR1VSR1lBUzlKVEt6UVM1VmNhTHpwNWNONVVaZEtsMWNN?=
 =?utf-8?B?VXFrUTdPWVlEV3JRYmo5MXVwOFVGUXkydW1SVWNXNHdneXJRMnluSHByZ2VC?=
 =?utf-8?B?M01VUHZubHZ6ZEdHTUZBTzIrL1Uya0s3ZjEzTTdKNHpzcHBDd3ROdW5FWita?=
 =?utf-8?B?V3ErbllucXB4enp1dkFmSjVibWRzR29ORWpSNDVLbFRiYmdDSlRERlZkVm9Y?=
 =?utf-8?B?cGF4VThva2Z2YU9UREF0ZWVabHJKL1ZVc01YQmExeHVHU2RURXF3NGNmazB1?=
 =?utf-8?B?R0c0b1ZYR2d2aitUczdFU1BZOTlnVFJzMUVINCtNUllxbEovbWdocTY5RTNB?=
 =?utf-8?B?d0R6SHFrNnozTTFBenFjY043SmNpOFh2TU5sUUxtT1F3R0ZCcm5qOUxHK2dy?=
 =?utf-8?B?R0YveWd2QmM1Skx4eFQrMjZWeUJObGpucndJdGU0MXJjK3dDejBYanBTTGsv?=
 =?utf-8?B?SjBKL0hIUDhpZ29UUWZOYkFCZGcyQUZzejVVNHg4YitnZmxrK2N1eVJDRXhQ?=
 =?utf-8?B?WjdHMFIzNVhLMHdueDVNZmZiWlNnb2xHcW9hZWF3RnJRTmZQcnlSYnZJMWR4?=
 =?utf-8?B?eGJmSXY3VkwwZndvbEVPYjBUbmxxbG1CdmRCYi9CZnBDNmJVOGh0a0MzVDlX?=
 =?utf-8?B?Y3FGSHlWeTZ4bE9Ib1BobmRKbC8wdC8wU0VzbU05NFBFYnZNRnZlckM4cnd2?=
 =?utf-8?B?enhUMWw2NThsa0F1eXgxczlxazdaWVZQakdlUGZQNFFHSE0reGpDZ2FWejFN?=
 =?utf-8?B?Y2N5azhyaVRmYXphcE1SNmxtMno3TGN5Zll3eDhLSzZPRUpwSDZNUUgrRlln?=
 =?utf-8?B?dXZPS1B3ZkZheEFPSHpLYVVrejdpbXlyTlpLWWdNNHVqMzlmaFZhVVo4REZ4?=
 =?utf-8?B?eUFnV2h6QVBhSFRiWnA4blVtM0pldUFrd0VBU3RFbW1qNjRUVEV0bFNua2pO?=
 =?utf-8?B?VlFTOTUyemw0RlhhZGlWeDE1Q3IyV1oxWExzUlI2TEJNWlRMbVJxdzZaYVlO?=
 =?utf-8?B?Z2htMGhzQmFpKzBBRTNrWlEzRGpFUDJYb2xwWUh4azVnTVpzUjVpblBZVWFN?=
 =?utf-8?B?TWpsdm95ZUlzY1h0dFdTSEpXamEyd1hLVVhmdWNFeVBpZ2hvMlZjbXZWL0V2?=
 =?utf-8?B?Mk9LalREZm9RejlLT3ZLYUMxbzBTM1JGWXZmc0VSL3hvbFNzNXZoMnZCWWxr?=
 =?utf-8?B?WUFPK2lOOHYvcWVoVk1aclZTWUxmbzQ0bmZRYkQraVo1ZjRDa0xnOWxVdHl6?=
 =?utf-8?B?cEVPeW5razNIWitGb0J4djhnbThONy8yVHlibkJnZHVucGZLd3hmOGtqbEgv?=
 =?utf-8?B?MUMzdXRnVkovRXJGOU5QMC9qQXFoSDczTWdONUFPamtjVndzMWVTbTJwZlYw?=
 =?utf-8?B?QnVaLzMxS1V4MUQ0R01ETFpjU1JxTUVvbDN3Sm9FY3NJczdBWDVSQmZGc0dO?=
 =?utf-8?B?S1hTSWZQZllrWGt1RWJWU1hMUzM0bFRISkI1TVlsY3pBaVYxMzNJOHhvUUp1?=
 =?utf-8?B?bVV1NVFOcDdybHF3bWJCM0ZNY0F2Q2huZVRrZDZDTHhXejdkL09RNUQwWnhh?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_0957DDAE12144502BC031A18D02B613Enutanixcom_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9017.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098cba2c-d9f4-4177-50f0-08dca5561668
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 05:13:54.1093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4IirJ4yiDTurkWHnjyk1ZdpDfQk15bZtFeV9jXSZOEttvpYqSW0Z9mhvKNZf1813fRs44lVfoayvSfHHHpCxdzfVf1tJnb6YenLwoyqtkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9438
X-Proofpoint-GUID: dy_Ug4oha87JM28IViC5UrD5ZHQWFATU
X-Proofpoint-ORIG-GUID: dy_Ug4oha87JM28IViC5UrD5ZHQWFATU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sandesh.patel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_0957DDAE12144502BC031A18D02B613Enutanixcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9uIDExIEp1bCAyMDI0LCBhdCA1OjIy4oCvUE0sIFNhbmRlc2ggUGF0ZWwgPHNhbmRlc2gu
cGF0ZWxAbnV0YW5peC5jb20+IHdyb3RlOg0KDQpUaGFua3MgRGF2aWQgZm9yIGFsbCB0aGUgYW5h
bHlzaXMuDQoNCkxvb2tpbmcgYXQgdGhlIExpbnV4IGd1ZXN0IHN1cHBvcnQsIGl0IHNlZW1zIHRv
IGxvb2sganVzdCBhdCB0aGUgSHlwZXJWDQpDUFVJRCBsZWF2ZXMgMHg0MDAwMDA4MSBhbmQgMHg0
MDAwMDA4Mi4gUUVNVSBrbm93cyBvZiB0aG9zZSBvbmx5IGZvcg0KU1lOREJHOyBTYW5kZXNoIGRv
IHlvdSB3YW50IHRvIHRyeSBzZXR0aW5nIHRoZQ0KSFlQRVJWX1ZTX1BST1BFUlRJRVNfRUFYX0VY
VEVOREVEX0lPQVBJQ19SVEUgYml0IHRoYXQgTGludXggbG9va3MgZm9yLA0KYW5kIHNlZSBob3cg
dGhhdCBhZmZlY3RzIFdpbmRvd3MgZ3Vlc3RzICh3aXRoIG5vIGVtdWxhdGVkIElPTU1VKT8NCg0K
DQoNCkkgYW0gZW5hYmxpbmcgc2FtZSBiaXQgKEJJVCgyKSB1bmRlciBIWVBFUlZfQ1BVSURfU1lO
REJHX1BMQVRGT1JNX0NBUEFCSUxJVElFUyAoMHg0MDAwMDA4Mikgd2l0aCBzaW1wbGUga3ZtIHBh
dGNoIChuZWVkIHRvIGNoZWNrIGhvdyBkbyB3ZSBzd2l0Y2ggdG8gMTUgYml0IGRlc3RpbmF0aW9u
IGlkIHdoZW4gZW5hYmxpbmcgdGhpcyktDQoNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9o
eXBlcnYuYyBiL2FyY2gveDg2L2t2bS9oeXBlcnYuYw0KaW5kZXggMDRjY2E0NmZlZDFlLi5iOWU3
NGI3OTEyNDcgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vaHlwZXJ2LmMNCisrKyBiL2FyY2gv
eDg2L2t2bS9oeXBlcnYuYw0KQEAgLTI1NjcsNiArMjU2Nyw3IEBAIGludCBrdm1fZ2V0X2h2X2Nw
dWlkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2bV9jcHVpZDIgKmNwdWlkLA0KDQog
ICAgICAgICAgICAgICAgY2FzZSBIWVBFUlZfQ1BVSURfU1lOREJHX1BMQVRGT1JNX0NBUEFCSUxJ
VElFUzoNCiAgICAgICAgICAgICAgICAgICAgICAgIGVudC0+ZWF4IHw9IEhWX1g2NF9TWU5EQkdf
Q0FQX0FMTE9XX0tFUk5FTF9ERUJVR0dJTkc7DQorICAgICAgICAgICAgICAgICAgICAgIGVudC0+
ZWF4IHw9IEhZUEVSVl9WU19QUk9QRVJUSUVTX0VBWF9FWFRFTkRFRF9JT0FQSUNfUlRFOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQoNCiAgICAgICAgICAgICAgICBkZWZhdWx0Og0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9oeXBlcnYuaCBiL2FyY2gveDg2L2t2bS9oeXBlcnYu
aA0KaW5kZXggMTAzMGIxYjUwNTUyLi4zODQ1ODVhMWYxNjUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4
Ni9rdm0vaHlwZXJ2LmgNCisrKyBiL2FyY2gveDg2L2t2bS9oeXBlcnYuaA0KQEAgLTQxLDYgKzQx
LDcgQEANCiAgKiBUaGVzZSBhcmUgSFlQRVJWX0NQVUlEX1NZTkRCR19QTEFURk9STV9DQVBBQklM
SVRJRVMuRUFYIGJpdHMuDQogICovDQogI2RlZmluZSBIVl9YNjRfU1lOREJHX0NBUF9BTExPV19L
RVJORUxfREVCVUdHSU5HICAgICAgIEJJVCgxKQ0KKyNkZWZpbmUgSFlQRVJWX1ZTX1BST1BFUlRJ
RVNfRUFYX0VYVEVOREVEX0lPQVBJQ19SVEUgICBCSVQoMikNCg0KIC8qIEh5cGVyLVYgU3ludGhl
dGljIGRlYnVnIG9wdGlvbnMgTVNSICovDQogI2RlZmluZSBIVl9YNjRfTVNSX1NZTkRCR19DT05U
Uk9MICAgICAgICAgICAgICAweDQwMDAwMEYxDQoNCg0KSSBhbSBoaXR0aW5nIGFuIGlzc3VlIHdo
ZXJlIHRoZSBXaW5kb3dzIGd1ZXN0IGlzIG5vdCBib290aW5nIChndWVzdCByZXNldCBpbiBsb29w
KSB3aGVuIGFkZGluZyBodi1zeW5kYmcgaHlwZXJ2IGZlYXR1cmUgKG9yIHVzaW5nIGh2LXBhc3N0
aHJvdWdoKS4gUG9zc2libHkgYW4gb2NjdXJyZW5jZSBvZiAtIGh0dHBzOi8vcGF0Y2hldy5vcmcv
UUVNVS8yMDIzMDYxMjA4NDIwMS4yOTQyNDgtMS12a3V6bmV0c0ByZWRoYXQuY29tLw0KQW55dGhp
bmcgc3BlY2lhbCB0byB0YWtlIGNhcmUgaGVyZT8NCg0KUmVnYXJkcywNClNhbmRlc2gNCg==

--_000_0957DDAE12144502BC031A18D02B613Enutanixcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <DF9147ED7CD3264EB6C01EEC80AF5D71@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJvdmVyZmxv
dy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQo8ZGl2IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13
b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNw
YWNlOyI+DQo8ZGl2IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5i
c3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQo8ZGl2IHN0
eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7
IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQo8YnIgaWQ9ImxpbmVCcmVha0F0QmVn
aW5uaW5nT2ZNZXNzYWdlIj4NCjxkaXY+PGJyPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+DQo8
ZGl2Pk9uIDExIEp1bCAyMDI0LCBhdCA1OjIy4oCvUE0sIFNhbmRlc2ggUGF0ZWwgJmx0O3NhbmRl
c2gucGF0ZWxAbnV0YW5peC5jb20mZ3Q7IHdyb3RlOjwvZGl2Pg0KPGJyIGNsYXNzPSJBcHBsZS1p
bnRlcmNoYW5nZS1uZXdsaW5lIj4NCjxkaXY+PHNwYW4gc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2Io
MCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1z
dHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogNDAw
OyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6
IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3Bh
Y2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlv
bjogbm9uZTsgZmxvYXQ6IG5vbmU7IGRpc3BsYXk6IGlubGluZSAhaW1wb3J0YW50OyI+VGhhbmtz
DQogRGF2aWQgZm9yIGFsbCB0aGUgYW5hbHlzaXMuPC9zcGFuPjxicj4NCjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIHN0eWxlPSJmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7
IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWln
aHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogYXV0bzsgdGV4dC1hbGln
bjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1z
cGFjZTogbm9ybWFsOyB3aWRvd3M6IGF1dG87IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRl
eHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiPg0KPGJyPg0KTG9v
a2luZyBhdCB0aGUgTGludXggZ3Vlc3Qgc3VwcG9ydCwgaXQgc2VlbXMgdG8gbG9vayBqdXN0IGF0
IHRoZSBIeXBlclY8YnI+DQpDUFVJRCBsZWF2ZXMgMHg0MDAwMDA4MSBhbmQgMHg0MDAwMDA4Mi4g
UUVNVSBrbm93cyBvZiB0aG9zZSBvbmx5IGZvcjxicj4NClNZTkRCRzsgU2FuZGVzaCBkbyB5b3Ug
d2FudCB0byB0cnkgc2V0dGluZyB0aGU8YnI+DQpIWVBFUlZfVlNfUFJPUEVSVElFU19FQVhfRVhU
RU5ERURfSU9BUElDX1JURSBiaXQgdGhhdCBMaW51eCBsb29rcyBmb3IsPGJyPg0KYW5kIHNlZSBo
b3cgdGhhdCBhZmZlY3RzIFdpbmRvd3MgZ3Vlc3RzICh3aXRoIG5vIGVtdWxhdGVkIElPTU1VKT88
YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjxi
cj4NCjwvZGl2Pg0KPGRpdj5JIGFtIGVuYWJsaW5nIHNhbWUgYml0IChCSVQoMikgdW5kZXIgSFlQ
RVJWX0NQVUlEX1NZTkRCR19QTEFURk9STV9DQVBBQklMSVRJRVMgKDB4NDAwMDAwODIpIHdpdGgg
c2ltcGxlIGt2bSBwYXRjaCAobmVlZCB0byBjaGVjayBob3cgZG8gd2Ugc3dpdGNoIHRvIDE1IGJp
dCBkZXN0aW5hdGlvbiBpZCB3aGVuIGVuYWJsaW5nIHRoaXMpLTwvZGl2Pg0KPGRpdj48YnI+DQo8
L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
aHlwZXJ2LmMgYi9hcmNoL3g4Ni9rdm0vaHlwZXJ2LmM8L2Rpdj4NCjxkaXY+aW5kZXggMDRjY2E0
NmZlZDFlLi5iOWU3NGI3OTEyNDcgMTAwNjQ0PC9kaXY+DQo8ZGl2Pi0tLSBhL2FyY2gveDg2L2t2
bS9oeXBlcnYuYzwvZGl2Pg0KPGRpdj4rKysgYi9hcmNoL3g4Ni9rdm0vaHlwZXJ2LmM8L2Rpdj4N
CjxkaXY+QEAgLTI1NjcsNiArMjU2Nyw3IEBAIGludCBrdm1fZ2V0X2h2X2NwdWlkKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2bV9jcHVpZDIgKmNwdWlkLDwvZGl2Pg0KPGRpdj4mbmJz
cDs8L2Rpdj4NCjxkaXY+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyBjYXNlIEhZUEVSVl9DUFVJRF9TWU5EQkdfUExBVEZPUk1fQ0FQQUJJTElU
SUVTOjwvZGl2Pg0KPGRpdj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBlbnQtJmd0O2VheCB8
PSBIVl9YNjRfU1lOREJHX0NBUF9BTExPV19LRVJORUxfREVCVUdHSU5HOzwvZGl2Pg0KPGRpdj4r
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDtlbnQtJmd0O2VheCB8PSBIWVBFUlZfVlNfUFJPUEVSVElFU19F
QVhfRVhURU5ERURfSU9BUElDX1JURTs8L2Rpdj4NCjxkaXY+Jm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgYnJlYWs7PC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj4mbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGRlZmF1bHQ6PC9kaXY+
DQo8ZGl2PmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vaHlwZXJ2LmggYi9hcmNoL3g4Ni9rdm0v
aHlwZXJ2Lmg8L2Rpdj4NCjxkaXY+aW5kZXggMTAzMGIxYjUwNTUyLi4zODQ1ODVhMWYxNjUgMTAw
NjQ0PC9kaXY+DQo8ZGl2Pi0tLSBhL2FyY2gveDg2L2t2bS9oeXBlcnYuaDwvZGl2Pg0KPGRpdj4r
KysgYi9hcmNoL3g4Ni9rdm0vaHlwZXJ2Lmg8L2Rpdj4NCjxkaXY+QEAgLTQxLDYgKzQxLDcgQEA8
L2Rpdj4NCjxkaXY+Jm5ic3A7ICogVGhlc2UgYXJlIEhZUEVSVl9DUFVJRF9TWU5EQkdfUExBVEZP
Uk1fQ0FQQUJJTElUSUVTLkVBWCBiaXRzLjwvZGl2Pg0KPGRpdj4mbmJzcDsgKi88L2Rpdj4NCjxk
aXY+Jm5ic3A7I2RlZmluZSBIVl9YNjRfU1lOREJHX0NBUF9BTExPV19LRVJORUxfREVCVUdHSU5H
ICZuYnNwOyAmbmJzcDsgJm5ic3A7IEJJVCgxKTwvZGl2Pg0KPGRpdj4rI2RlZmluZSBIWVBFUlZf
VlNfUFJPUEVSVElFU19FQVhfRVhURU5ERURfSU9BUElDX1JURSAmbmJzcDsgQklUKDIpPC9kaXY+
DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj4mbmJzcDsvKiBIeXBlci1WIFN5bnRoZXRpYyBkZWJ1
ZyBvcHRpb25zIE1TUiAqLzwvZGl2Pg0KPGRpdj4mbmJzcDsjZGVmaW5lIEhWX1g2NF9NU1JfU1lO
REJHX0NPTlRST0wgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7MHg0MDAwMDBGMTwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+
DQo8ZGl2PkkgYW0gaGl0dGluZyBhbiBpc3N1ZSB3aGVyZSB0aGUgV2luZG93cyBndWVzdCBpcyBu
b3QgYm9vdGluZyAoZ3Vlc3QgcmVzZXQgaW4gbG9vcCkgd2hlbiBhZGRpbmcgaHYtc3luZGJnIGh5
cGVydiBmZWF0dXJlIChvciB1c2luZyBodi1wYXNzdGhyb3VnaCkuIFBvc3NpYmx5IGFuIG9jY3Vy
cmVuY2Ugb2YgLSZuYnNwOzxhIGhyZWY9Imh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIzMDYx
MjA4NDIwMS4yOTQyNDgtMS12a3V6bmV0c0ByZWRoYXQuY29tLyI+aHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9RRU1VLzIwMjMwNjEyMDg0MjAxLjI5NDI0OC0xLXZrdXpuZXRzQHJlZGhhdC5jb20vPC9hPjwv
ZGl2Pg0KPGRpdj5Bbnl0aGluZyBzcGVjaWFsIHRvIHRha2UgY2FyZSBoZXJlPzwvZGl2Pg0KPGRp
dj48YnI+DQo8L2Rpdj4NCjxkaXY+UmVnYXJkcyw8L2Rpdj4NCjxkaXY+U2FuZGVzaDwvZGl2Pg0K
PC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_0957DDAE12144502BC031A18D02B613Enutanixcom_--

