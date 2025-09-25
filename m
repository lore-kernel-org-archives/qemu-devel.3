Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC055CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFW-0000cW-6Y; Thu, 25 Sep 2025 07:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEb-00071X-Vi; Thu, 25 Sep 2025 07:34:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kES-0008Uo-LC; Thu, 25 Sep 2025 07:33:59 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAtG8q1851329; Thu, 25 Sep 2025 04:33:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=r1Bu7HX+wHgHobUmfHf3yNGMr7kI4YMDd8QXMSl7x
 T0=; b=08C9/U/x6s4IJIWyJawf5+myD7RhdNb6YKNt/D0wC5YzbKEf0HebVfTdC
 9YynAMase+nKXVpeNXSreMWNz9L3n5fQutSmDLv40CNNuApVi1N8IRr2GlvHD9hY
 7GEDQDWPQK72drgz7OSJl+PD4VYUpEZl+eB8iY0tR0LBqvgRFo4x2vajM7waZjC2
 QO9fDT2SEnbgJN3o5FvJ40QDzvz3mpV4IFYVwAKOvyclWvyoOKD3fJUvlwVO5WBx
 c9LUhpo6Vc0Uye+6qzfmUKTCu7TsSVzyhwfq1vex/n9fThimZK97vtCpn0u3bX0Y
 0NIK/HifnwOu6a24PjLGI7J2kOrZw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavg3-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTMGqipIqcOczwMzkrPoAH5km6BkXeqcm5GauCw/+btgvSP5SWT47/j9huOosPo30W6XilD6reJ7H8++Sewb+CHtJPrTY8v8J879NLtz40NKhBFX7NK3I28DcoSUQs+TTxjLZYVl01wveSqw3VG/IBU4c3KvjCkXpZFJ3gMgW165zBitGIW8ck+oVHLrUeL9uDDtH7wM+rt+HMlZI0LOS5KvKA8QZ6qn9h0njrHOOd6QtR7fLXv7qVIAsTh4mfFh7hxOurrOlgqWwZRlN89dRhnJZKPqHgVXEs9WppegCBZ9uZOiPz/aXBuiT4NHwv+52HU8vGPcLJDKHayn03ITxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1Bu7HX+wHgHobUmfHf3yNGMr7kI4YMDd8QXMSl7xT0=;
 b=x+OuxKm6qiDFwu3OkAXt0jtRDztKAb6z2MSXoSNctfYVUljIi8OYML0zGtXAJCHHgYA+MbRZPyxqFLF37X10lT2afQDe27SMIYRRkgEeOKQScVub2Kq5Bj3wigSJyy3c1oPyaAS5hCmYCxKf+g8yoBfUs/hrlAjKM/Yya5XV+puDwmybJapzSb8FNiyGq6P6sIZXSb3rnX1M1fW2xV2ZwkOT6S2jd3Nm2f/1VH76a4NyKHVD/2SV5YeMYnto9z55lrdZBXqpWUaQg3pbwKklInztR3C46ui4L2ZlUBBE0zwNLOvMxc7/IodstJbolhufuprQKm18qKRlA2hboVrKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1Bu7HX+wHgHobUmfHf3yNGMr7kI4YMDd8QXMSl7xT0=;
 b=ayT9A6JdoWU6wrUXRQk81dnwSNTV3izvYITNzBeLE42eZS+uiiNHJuJoBBpj1I5Gp/2JFeLL4PGS5idVp3WPt83jdpDuWf4WSYG7y1YJlLJZTyBxMrGo6nW5QUO1gYnE5HlvqQUgrQ6RY9mCToGgp0Wkh6erZaHfD9I2EpaIsZ8KBy2PFYzMs3iqksIOKIGiy4nKtUmbvOZtcJgKTuHf1rUtg24eEBtue5EqD9F+pvG7GAFwwf+qGjbyO/6mLOBjFW/TeAlqtdqSMVZL65bNY9XN0iXmUqVAcC346gGovWe7hlb3iw0ri4fBBWRqFSqbijYym2jIoqRaoZgkAxNyrQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 26/28] vfio-user/pci.c: rename
 vfio_user_instance_finalize() to vfio_user_pci_finalize()
Date: Thu, 25 Sep 2025 12:31:34 +0100
Message-ID: <20250925113159.1760317-27-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d44b7c1-93cc-47da-31bf-08ddfc275d17
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzc1UjBYMnRwYVpPdnFIdHQ0Z0dGRk8waytvbWgxYnJuSzlLOW5pSm5WVFQ3?=
 =?utf-8?B?aFU3ZGV6amhUNVFEMzdzZmYvc3BRZmIxUlNqSmlwaTJueGM1NjNWNTVtNWpu?=
 =?utf-8?B?S0ZNM1g2SVo5aWhqd29ZM2FKeDFGK1VkZGdjTFNaaWIvQW9TUjd5WWljZDlD?=
 =?utf-8?B?dEl5akJVYlg5K0NWQ29adWI1OXpQRTVLeGlCUmlqYTNGeHIxS0xxcTdWWWtJ?=
 =?utf-8?B?L1BEVFl3QU1Ib1FQWm1pL2hHbzdPSVhGQkNuTGZURkhJdldXZUlkZDNwUFhY?=
 =?utf-8?B?NWJjRHNRMVdSNWVqUXFQTnRzMkVPQzMwQm5taVF4WGtETCt5SzZMbjcwSnJO?=
 =?utf-8?B?SGZLdFQ1T2VsMzdWQUwwTHhBdC9jUlRTR0Rzbnl3WDRKWVRteW1KelVmcU9m?=
 =?utf-8?B?NW4vK0tveGRIemRmRjJqajBONGN4YWprS2p4ODBYaDhHdTVwbWQycWFFSWVM?=
 =?utf-8?B?YXB4UEJjZldkWDNQaUpCRU5VUUl4a1lRdkVKYlhyRU1mWjBJVk5seUM3c25T?=
 =?utf-8?B?Skd5aDA1V1BkRmdGaWJ3VHI3NXdwbjFSTFhXeWdCQ2NwUUduaFhPalpMVmpV?=
 =?utf-8?B?d1RBdGc2ajZQbkw0eXJFRmpWOU4zZE1jZ3g5cUxpUEs1Z3V3bGxRMXFlSlVB?=
 =?utf-8?B?a0pjaDUrdWhzOXVEcVRORWxiQUtKS3NwVTZDYldxSmNlN0VubFZYdjdDTDRh?=
 =?utf-8?B?Q3ZyeklYOFRYNVdudkptQzFnQTVFQW1adzhRSEZZTzQ2ZFVSV04yem9xS2VT?=
 =?utf-8?B?RmhTbDVNcWJ2blJxaG1hRGtDNS9BeUVYcTNENnBoaDJBKzFQTFJzNGpBelN2?=
 =?utf-8?B?THlLeDRsdTlNbUtBcWFjU0dUQkZBTDRITlpYbENmdDF3Ykw0SGxrWG81cHE4?=
 =?utf-8?B?VzFCLzlMbWZPdnFFRFYwK1E3Q1Uxem1iREdDRjJWM3BwcStueDYwWkM2TW5x?=
 =?utf-8?B?ZGZLYWxqZEFXZUlqaWRwVUpjeEE4U0RkVEpDTWFBUEhPV3J3Z25LMWNBYWVN?=
 =?utf-8?B?Z2d4UFJYb00wMUN4c0hPU1VHUVJseGo3S0tqUmVRUGJaMTlabTNMTE84cWEv?=
 =?utf-8?B?RituOWI0L3orTW9lQUQ3eUtiVm5hR0kxdlpJaDRnWnhORkpqT1BORjMyMTkr?=
 =?utf-8?B?UEZYM0VJRnFhYXJ6MEJub1VmdjlCL3NJaFJsS0dPVHlHOEhWRFE4Rnk5U3ps?=
 =?utf-8?B?MDZVdGNjNlg0QXY0WW55NGFJL0hZRWpVeGZNUVZja2ZaTnJwcDRyS0dEQkFz?=
 =?utf-8?B?cVA5c0JLdVJtM2JHbTJydTFueWczc1NKVU5ZRzJMLzlnNEFZTzFyWWlYNlhU?=
 =?utf-8?B?Y0NiSCtZQ3FmT1VoUkZOc0Z0M1RKQVV2UjRQRVlZaGdzbGZMWDhaM0NPL0NG?=
 =?utf-8?B?Zks2YXJteTh2RXpVQTIwVzVLNjhwM1A2U2J5Y2xucFdrWk5Za1VSSlcrUWZW?=
 =?utf-8?B?L3R6bjJrZGVRVUlpVjMya2RGaVY1N3ozdUh5MU1OSHpKQlRBTjdkZ2Zldi9m?=
 =?utf-8?B?RUpYWWlZKzV5Zjl2RXgxWHdVeFo3UkxLNFppTzc0Z21IU0xMcnB6MjhuVEZJ?=
 =?utf-8?B?WDBBbXNxQThHV1ZPMGNNeTBKOVY5SWZjUkNLaHZ1azV5T09FOENiY05Rc2k1?=
 =?utf-8?B?WGtHQ2R3OFI3dVh5ZEJuR1lCeU5OL0dSbTdKZldzcjJMSFZtT1c0aHFRNW0y?=
 =?utf-8?B?V1J4R2h0dmg3aVZUeDI4a0hMcE1SRFRrOEhlR0gwMUh4K1g1TFMyRm1wd2lw?=
 =?utf-8?B?V25kVzNLSTR3NzR0MGRjODZERnQwSkZuazRrL1czdXRFQURISzZxaEU2YUlv?=
 =?utf-8?B?bjRNWndIdVJuclJMdmljVDRDa3VxY24vM1ZLV29lbTF0NVRtaHJFTXNueXB5?=
 =?utf-8?B?SFBKWll5SnVPMkFpc0VvUjVpSXU4blQyQWFwcWxBMkZnOHQ4MXBEZEtuSFYz?=
 =?utf-8?B?ZWxRUENtbVBFRGdtUzQvR2FCdUZnOEYycE5qcFpBNW9hd3ZxM0lUSVlzc1VI?=
 =?utf-8?B?ZlpTMDd5aDZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE94YlM0dGNRVjlnazI0UHJUeHhicTJvRStWNElKaHRjRjE2a1p4aVpVWTVW?=
 =?utf-8?B?UFZYUXh0WjYvaFRBbGYzTWREc1ppNHVFNGlDN0ZqRWl3SGJSR1R2dDVHY0Rj?=
 =?utf-8?B?djVTa0lRQWhYNnpMdjN2eDdBVFYxNEwwZVBpYkVDTGdEa2YrT3d2ZWpoTjg5?=
 =?utf-8?B?MWhaMzRvZVNhdW9PZGxtcDBCUWZnK3ZoUFVIYWZmRFN1Q05EYXNlQlJhYUFy?=
 =?utf-8?B?UmxSNHRSK2F0WWEveDltMmE4Y3A3aWx2UXUxb2NFUHZhRFVZRjNpb1pidXVl?=
 =?utf-8?B?NjAzTTF0bGw0eG1NYW5UN1dGMTJGNXB4WW5UaEg3U2QyQnhjdDN0UW1PVWsw?=
 =?utf-8?B?c3lOTDNoUDRVNDBKOXd5N1JBTjFxeS90YUdMcnRZQVBncTJkSGcxaDA3R3hW?=
 =?utf-8?B?dnpVTkRrZEowd0EwSjVmSjlMU210VndMZ2QvY09DbGgyd1lBdXdlZk1WaDJu?=
 =?utf-8?B?VklyZ3MzbmJTaTFVU0ZNTE43d3pQL1BJcjNQWU1kZ2xZSUIxQVNGcVIybW85?=
 =?utf-8?B?WjAwcUpJOHJSRXhZNXc0RmlXYllHNUgzVFp5VXVqdXdjeFVLalIwdjRBNUZL?=
 =?utf-8?B?UUl3QzNOSTZqZ3dSdzF5bXMxbFVQN1hteld0c25NWTFhNjJMdk4rVUJaa2li?=
 =?utf-8?B?cnY4MDBxampReCtXMVVBdEU2VkRmczlkRk9SUXNPb1JGWEl3b2tjOWd4aFZh?=
 =?utf-8?B?dmF2aHVDNVlMdW5rYkZ4R1FBMVhRVnZEU0YxYi8wVHBDeVcxYWQ2bWwwVDFv?=
 =?utf-8?B?WU12SmRjRjYyY1hQamNNdUFWTkRMMnJQeVozMmlUblNsOE1BK0hwM3k3WGJa?=
 =?utf-8?B?aVV3V21YOEZ6MW1kTHFlNC9rRFhOY3NvR1lFV0w4N0FEa2dqUjk3cHFlQWJB?=
 =?utf-8?B?Z0s4TzlLU0tvQkJhdnZEeVo3cEIyRjAxQUF3eFc0V0JIR3FSeWQwZW9UdmVW?=
 =?utf-8?B?WFkwWGJheTlPZHBiWTBkd01HdzVQdDcyWEJSY1hTcHBSL0NPZE84WVFjWFJX?=
 =?utf-8?B?QlZUQlBlVDMrSTI1KytwbE0wdE5EQTl5TGowL08yd3VUNUlLbjJzckUzT0lO?=
 =?utf-8?B?YlFZTUM5d3ZndURZL3NPVXN3anRTYjJDWDJOd3hWMnhnZllYbWpJaVV2TE1z?=
 =?utf-8?B?OGIycDFlZTFTYmpFc215bUMvR0xkaHp1Qk1sV3hqcUtLeWZwRTJoUmFoTzdp?=
 =?utf-8?B?bEtidVBWWXFtbU5iY1RYSGNZS1FOMjZpbjBOQmFKWmw5R3BzZHpNWFNqZ2ZO?=
 =?utf-8?B?VGJJdkJUQSt4b0NpN3dwMFI2RFRVQ094bURabVUyaE5Ob3lWRHZBejFCMThE?=
 =?utf-8?B?R1piZ2kxR3VnQnRIMk9YMjFWSW9UbU9OME0yQThnM1NYMEhVK0twd1lJWnht?=
 =?utf-8?B?Z093czMyeVBlanhrUWtUYk5kSm0veFhVc0kwS2UwaGJzZW42SVRkWFJ4UUZy?=
 =?utf-8?B?VFlmbnhseW51VGx3aGlOSVgzWWZzeG9qMW9tdHM3aXdtaGtabEt1dU40OUNM?=
 =?utf-8?B?RS9WSGJJUFVBa3l2T3U0dXZnV0xicHlxTXlBNWFEQU1Ed1AwL2RKQXBObGRv?=
 =?utf-8?B?aG4wcStCNjlDMGR6UFNncUFQNkJKd29MZ0Fkbk5EUG5SSDBZUnBoTFFFQjdo?=
 =?utf-8?B?a05SMm9HUDRSejhXTW51ODZyVThQWk5PQzQ0UjZSam9tTndCa21JUTlaT0VV?=
 =?utf-8?B?Umt5QnkvaElmdFRJWVI3R0YzSTFnSmh5MGplSnpDUyt2Q2lFcFpvZE9WcnRV?=
 =?utf-8?B?VUNTTTVyeHJWaGRmU2N0Vkt6Qk80aUR6UGhGbEtLcjBETW44VUM4cHBFb2N3?=
 =?utf-8?B?RkRLUnJ5ZnBYSmplWVZ4OStsV2o1ajB2QTVJU3ptaUx2dVpPbWlUUjRpVzNB?=
 =?utf-8?B?QWRuNlNid2NkVmh4aEhhTUxYRjJMOGZWWlNqWTRhTW8vTGZyODJMOTkwV2xl?=
 =?utf-8?B?enFRajUyMjhPVTFYMzZyTW1BZVUzUEVCYnFCTDV4UzZBV01TU0tSQXNRK3Er?=
 =?utf-8?B?ZnRjU05yYzBsbjRiWFIzVk9OcGNPdTBTQ1pFM1pjOVNRRU9ubExtUHV4SnBE?=
 =?utf-8?B?dDFmSWhna2J3QW0wL3RESWJoMXVNc3VWUGhmZW41TVUrcmZJNlQ3RnBFVHN5?=
 =?utf-8?B?MXdOeXU3NzlxalVHQlBxSVVRY1ZJbjNQdjl5WVYyakN0T2hGNHhWRVpMRmsr?=
 =?utf-8?B?RWZLR1NpbWQ1ZDNpcmhnYmVwNlpXOUV6dldSczFwL3Q3TUJvYzBYSGJJTFl5?=
 =?utf-8?B?OHk1bytINTMwbVFvQXFXY2VPaWJnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d44b7c1-93cc-47da-31bf-08ddfc275d17
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:35.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM1yiAsf+ix2RkhpaoFQMd/UEdIPWsq329GmOKmJGdVxkJTnzYphb32JMgbAj6wyloKalVjryGHXwVuy01CI6uoOstNb2yYkBeDoblxN7NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXy4R0QUVt4u97
 lzD8tLhVWnSlB+vRwkkq94ufGrzlU/Gm8Xf7PBuaCRMByTRJjvGfr7yUJP51LNlkOuK04VNFEbG
 U0Z1leyMC+2jyGoLWJg9I0ww2enOHWZq9XV769g+WAxVKaI06CdPERqL1kuKidJxDc7DLmP9xQy
 jGCK1+prSXTKi+do4GV/cTu5UHmj//Pf+UpEqnHMujAeAc5k8ETw+eITyja25MdSxbiCK1EkzL9
 eG6Akb0gCKSaxcvOrjl5z3esLieIjbnHd6mIqd1AuCP3dlTmduCu47eBh14hUH0Am/WRliPbdjA
 JXKvs8r6VF8cM8XJ3+koJUJx7PGPI62qD027KE099WLYU88fi9VG31c5pd7Wd4=
X-Proofpoint-ORIG-GUID: jn757UP6VbyLwYHxyv-1Dc0h7tCnJ3Ll
X-Proofpoint-GUID: jn757UP6VbyLwYHxyv-1Dc0h7tCnJ3Ll
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52897 cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=VO-VGI-_H-TUAJbT1awA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is the more typical naming convention for QOM finalize() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 52561900fd..d4f5c7b9d7 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -370,7 +370,7 @@ static void vfio_user_pci_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static void vfio_user_instance_finalize(Object *obj)
+static void vfio_user_pci_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -469,7 +469,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_pci_init,
-    .instance_finalize = vfio_user_instance_finalize,
+    .instance_finalize = vfio_user_pci_finalize,
 };
 
 static void register_vfio_user_dev_type(void)
-- 
2.43.0


