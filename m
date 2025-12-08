Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FBED3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSiOA-0001gk-Mn; Mon, 08 Dec 2025 16:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vSiO6-0001fr-0l
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 16:03:18 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vSiO3-00027m-NT
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 16:03:17 -0500
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
 by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B8JvDmJ3527796; Mon, 8 Dec 2025 21:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=2IWLg64HHWOGe4NyenYTnIXSKFrkHNa+WfDZm60RVXk=; b=
 FFzRa5v3xQQqvJGld8wM+jZjKcTpj0/swDRFlLPFnBUHOppgRnk0WwZAu9txDqVd
 LVKYQrs4bOGGzwIuxekIlSWzBwGk9gyrxd5nJtUgqAqhvwW+YhgqPW/LdiPzo/I8
 J0EtdZj4RnAmW0eSEtOZ9Hd5F6ItwesN4DNwWGviwMFtbqyymTtYtML0M1oEWnDv
 ZYrJDTBLkcalyyDDqktxvuYiVrR1hdnIr1soui5sBjw8bE5DVJoDeJOtW0qIpF6z
 jil7wfu5Bxa+UdjAzo9f6Y5hH3A6Mmn56h997Gxg1BVfhsiujDGJPJLL6N6GRXR3
 c8UhOP2X+uDt8EF3UGky+g==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4avxq8s6wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:03:13 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B8J6weA009290; Mon, 8 Dec 2025 16:03:12 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4avgq98yfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 16:03:12 -0500
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 13:03:12 -0800
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 8 Dec 2025 16:03:12 -0500
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 8 Dec 2025 16:03:11 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SJ0PR17MB6547.namprd17.prod.outlook.com (2603:10b6:a03:4e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Mon, 8 Dec
 2025 21:03:01 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9388.009; Mon, 8 Dec 2025
 21:03:01 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
Thread-Topic: [PATCH v3 0/8] Live update: tap and vhost
Thread-Index: AQHcZIXV5dbTT97LcEKDcr0t/f76ELURcMeAgAZ+boA=
Date: Mon, 8 Dec 2025 21:03:01 +0000
Message-ID: <3CF77061-D885-46E8-90F0-AF3A909C233E@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <a782e506-8e23-49dd-b8d2-d27409c99d5a@yandex-team.ru>
In-Reply-To: <a782e506-8e23-49dd-b8d2-d27409c99d5a@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SJ0PR17MB6547:EE_
x-ms-office365-filtering-correlation-id: f880e7dd-5af9-480c-a5ce-08de369d2c7d
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?R2FGU3l3bFFKa3ljVG52OUJUOHRrT1Jpa1k2OFk4dUpNcGZ6SE9BRlB0U0k4?=
 =?utf-8?B?K1VLYVRvV2RqRmhYNFZqUEJpSjJhNFNQZmRtZEdJbHNkTXlIRzd2OUNkakNF?=
 =?utf-8?B?M2EzOGpLUElaMWllK3JGSkl3SFNOYTRGdTI4dWRJRjN1OHlNT09aVUY4Sjgx?=
 =?utf-8?B?Q2VldXFMbG5WdUJJQ0lTZW1Ua0lkZlpqYTNDRVU0QjlucklXcVMwQnhaeFRi?=
 =?utf-8?B?TEtSLzVKaEVFc2M4dnZKZjB0Y294U0J4cDMrVFBoWDRid0RUNmZOUlZUV2RT?=
 =?utf-8?B?aERXMTBGTVhGOUNrNE1iNUo3Q0dvVVhlSkRyZmIwUlJEL3BOY0pia0UxNjA3?=
 =?utf-8?B?b0lYT1ozaG1MdVM3S2REbWdNZWR1WTd6NWg5blVaT2h4WGN6blNwNjRIZTJB?=
 =?utf-8?B?Rm5hMlc0ckQ2dGtRTDFPcGcvK09WYU1yTnd2L3AwdisvM2RiNVZJS2VUc1VN?=
 =?utf-8?B?S2d2RitiS1JnQ3JtYzRMbG4zWWRWSDBlTnQvODdxb0RJUFpTekI3V3NYaXYy?=
 =?utf-8?B?cnNWdkFxV0JEeG1scGJTd0pUQW5mRDI0WEZNNWgzcktpcXBVaCtGMTE0b2RD?=
 =?utf-8?B?aS9sTHFlakhwN01FOG9WTCtGbWM0enAyLzJiNHZ1eVQybFE3VGkydkZnNlVP?=
 =?utf-8?B?M05zdFdzMGNzc3ZOZVdCLytDR1ZubTNkcmxvK2ZRWmxKS0ZzVFdRUlV3Rldk?=
 =?utf-8?B?cW53bENRT3hQVnVDSGZtaE5yOFREUFc5L0xkOGhFRTFYU0lzbTc5Z0ZkTXFx?=
 =?utf-8?B?ZWdZN3pJeFk5V01yN3R6T1N3bVJqVVlFUHdlSmZRMlNYTUM4aTlqMkMvTDZB?=
 =?utf-8?B?NVZOR1ArSmFPc3BHS1FNYldSMVhrVUgzYmpXbnBOMzhBb0Nja0k5cUJGWmlp?=
 =?utf-8?B?ZFYyM2EzUXozSENUL2tSZ3FWQnFFcUxPWXpaSzN4enZaYUN6M2s2WHFMbnVi?=
 =?utf-8?B?U3NUaUR6MHMxNGphSElhUC9nUGtIa0pYaU5nSStIemFGZzdJMDZXWWFib2po?=
 =?utf-8?B?eEZnUXJ6RHFIY1lMb3RKN05jNVZrVGthbi9mR2ZFSXVGR2hXZ2VuN3MxR2ZN?=
 =?utf-8?B?cUQ3cDQ2eGwrVUpBTlhEelZka3dhWGhwSmVrdisyZEZNenBHbko0UzR2M0h5?=
 =?utf-8?B?RkVsWTQ3UWpsYXduZVNUeFVPMVdIT2hzRm51UjJpaFZEOFd6OVUwSnBWWUh1?=
 =?utf-8?B?VUV6a0txVjJjSVJVTDQzREw3N0dJMEdOaHQ3VTlJYzNWM0tXVjM5dDdTREl3?=
 =?utf-8?B?RGNVbHBuK29TOUl5UjJ0d0hwUTU3bGFlU0NHalB0djEvbWNmY2QxUnBlRi81?=
 =?utf-8?B?SHpoRHRyM3FvUlZkNGUzdW1JbzRkdXVqd05sQm5td0ppdlJBWDZlN3MrVmlM?=
 =?utf-8?B?OEhUNWZ1QkdSUG5xV3BwNG5BL0FJeW5ZTzVDM2JLQ3pJbS8xd1c4Tk5Udm83?=
 =?utf-8?B?Sy9taGtwOXkyM2JINXFtM2N0NFFSNm1SRzhUWTFRcEVKMTlHTGE5eURHNmk1?=
 =?utf-8?B?RDd5K0VGVmhFOFl1eHlDUUhtc3lNZEFqb0oyWjZZUjMzUUp6VUNJSDJkb2Nv?=
 =?utf-8?B?LzlPdlNVaXZrTmRjMENXaEFaem9EN0g2dkk1VVdrM1F6U0dldHZBUW5BUEYv?=
 =?utf-8?B?SmJPVUZ3UUl4NWFqdkxqQ2FzVHA2elZlNU1XOWZNUEhGVHo5NkVUd2ZxeHBj?=
 =?utf-8?B?NE9SMGpzOGxhUUxlWjJ2MDBLTk1hdjZ2dVpBZFBOMmhQczJSN245QzYwVGhJ?=
 =?utf-8?B?ekR6RUFMY1loS3RLVjhTVkp6UXZVanowUk8wRk1Lc0ZTQ1ROT3ZhWEJyaVF4?=
 =?utf-8?B?ZjZRZmliSHUyeEJpTmNkajRMLzNUdEFHMkgzZlEzOUxjR2p6MUx0UFdUVlVR?=
 =?utf-8?B?R2pGb0FzNFl1MGNNVzBlWDRQU2V4UDM4aHNwVFFVQ0lGVkRSc3FvMERrRmVV?=
 =?utf-8?B?YkNVU0VNajNybkYxR0JJdmZRUW40ak1DejU5anpOblhjZXZ6VHJaZjgyNDND?=
 =?utf-8?B?WEs3YmJObUNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU04Z2Y5VDI2QThobzE0TnBDM0g1L2VuK1BkZktHSkdIQWdFK3VvSXk0L0VN?=
 =?utf-8?B?eVZjSDJqRGtwbWpYSmRWbVhGQUNaeWxGWUZ5Vm5NaTVTeTB1YVBoVThlQ2cw?=
 =?utf-8?B?UFhUL2ZscW9Jc0hQZDZsN3l1RElpR0hHWXBsT0s1Y1dSWUFmT2FreWRvTlhF?=
 =?utf-8?B?Qjd5ZjNFNks1aXQ3SmkvQjlycjdsZ01jbm01YndOUlBFMExqSDBoTzZZQW1J?=
 =?utf-8?B?cFhibTBHaHBGSlE0U25rZGluMkNvYjZPcDdtWG4rQ3RpaXhOWENWcEIzUDNT?=
 =?utf-8?B?UTNnYXJRMHZRNUg4VzNSUXh1UlJXdTkxNU9IcU5TSTlFSC9MT1ZFK3FOc1RN?=
 =?utf-8?B?b01hU0Z4bENTMlBXK2RhUlRDcFBtbGNhMDhidTV0VS91eERSbUFvT1dwRjBX?=
 =?utf-8?B?S3pJMGNUeFhtTXlUWUgrL3N4cjdhdFdaZEo1WmxJMU4xRHBCRFVWUmkyRXlw?=
 =?utf-8?B?U200Z1FTbmFpUGtiWjF6M09vZC9zb2VoQ3FKaHFVeVZRTzRPTXR3b0NlUVdS?=
 =?utf-8?B?bEhUR3oxcEF6WENweEVOK2pXNTNqOGNLVURzcy9LK3pXWUd4dCszbS9yajRL?=
 =?utf-8?B?ek1QYUhOTXpaV05xdUlJUXIrNzdqcHFTV3AxOE55ejZnb3IwQXRaQnc0SlQr?=
 =?utf-8?B?SGU2UklEcGFTOThLQk1JVzk4T3ZWeUgxRjRFYkJnWWJyanJYSjR5ODZ5aHBn?=
 =?utf-8?B?RjJjZE5Ec3pXN2lDalEwL0xjMUpSN3hRbktva2o1Qnc0R2JRRDE4RVd6QTJ3?=
 =?utf-8?B?NC81c1Fsem1hUjFoU1dNKy9QY3BpTXppaWFVVXpRdDlMb2YwTFB5KzBXZEdl?=
 =?utf-8?B?TGRzYkZOT0pNTVMvWTBIODR5Z3JxMHhzUERFa0x0Y3VmcC9aRFovU0R2bzEy?=
 =?utf-8?B?Wmd0anh0dTl6cFpUaXdycE9OcmFqc1pBTXJNM0gwa2NGWWNRYisxKzF3YjFr?=
 =?utf-8?B?bkI5Uk5ZckNSOUZSS0xBWXAvcjd0TzA5TGhqYU5PSTRPRnNmMStzOXE0Tkh2?=
 =?utf-8?B?a0wxb0o1WGN2RmJsdWdCYVNIL3ZWT1F2NzFTQjQrNmptTldpU1JOTERiWUtz?=
 =?utf-8?B?MXRaRER2T2gzTDJNK2VPaFFNS1ArQWM0ZTVMdXhaandvTGJIWkt1YkFqUXVh?=
 =?utf-8?B?V3ZUWEw2SnFaM0MvUk0rVWpBRkJSeWw0R2dRSlRZR1ZRbE1yaXdDNjBjd3lr?=
 =?utf-8?B?akYyU3B4bWY3T1QwSDc5UUNOenN6KzZnS3hDbnZNTHVFZUNlVXBIeklzQyti?=
 =?utf-8?B?emRlenhtTWViTmNIRzA1MDd0cUJDSXIyQ3VEMXpyK1g4V2Q2ejArTXY1VmUr?=
 =?utf-8?B?SW9uT3NlTlVleTlra3F6bG11WEN5L1IrOFJ2SWlIb1FwSDBKazE5THlYeEM3?=
 =?utf-8?B?MmgvOU95RVRWODl3cDJrUkNvSkliWTdNeDBBNjR1dUtscS9zRXRkYWpTbG9h?=
 =?utf-8?B?ZndpcGZTZDRONnBkNjRqUGVmeDFhaHgyYWd4SVdYejMzZDhCaWZ2cXp2dHlo?=
 =?utf-8?B?UVI3YWxoWmtOVzNPamdRaUtmUWVlb2pHc1FUOFdha2laaDY5ZndRZDhDaHp1?=
 =?utf-8?B?Y2pOZGV5YWs0T09naFZJVGxxaU92QTlFSDBpajY3a2tnV1krc21zam9GbUo3?=
 =?utf-8?B?WUhDYml4UVphRWRLcnZ2T2F5bzVzSzJuVGk3K2hvYmxyaktieHRFNDkxQUZL?=
 =?utf-8?B?dGM0Nk1DendKcFJRVkpEMi9kUHRFZzRSVnZiVWxVdWJlRzVhWTB2cFVFaGJO?=
 =?utf-8?B?Z3B4R0djOUVGaDNJeVpyZCs4aURXY1l2a2RocGNsVUtnb29qN21MWitiN0I5?=
 =?utf-8?B?aVdwYVZEYXlwajRRSG10cGxPbkpxckV0UTJObDNXUThzUVdEK3dIWTNkQjJ5?=
 =?utf-8?B?djdSb2djQjQ4VFo5eFUyKzgwY1NqU1VrWEQ1Nis0d3E3Z1RiTFpEd1pCcDNW?=
 =?utf-8?B?Znd2bjlVQnJSNTMxM1VTa1BkYzJrb05HTjBpd3AxeHFKQy80Z3oxN0pWbFVK?=
 =?utf-8?B?ZUcyMkc1UGszWHludVhNSjVpQ093VUhjS1k4QnZqL3VEYUJ4MUN4LzF3enVP?=
 =?utf-8?B?eHVZaFBGUjIwZHh4R0VZWGJGYUJ3VjlKRTdEaFJ1R2xrN2xiTlpGdFphTkVT?=
 =?utf-8?B?TFFRSy9wYU1HZGJJOGxSdmgzWFF2UDNIdXBEd3ZnVFVHejQ2d1RhcnMxazh3?=
 =?utf-8?Q?5UujuNKiYBdC8dVa5cgfNI31tdgpwMTUSfXAHLdkEoQT?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOGJLVcG/3H8Sn/UqKNRxRsPM6VZMuVAPCc//m7vhgE1uLHK9vV1mw7mJQcmKff9RpvQWIYcHdTozLhamQUmjrUNChk/qaxzzsJIpzH7wlfwPj/zX4/aF6df1yBCUdvcdROcEQ3HxOJdmjOz5n1dYj57kKHjx3m9d2KQGk0Sa/+UCZO0GCv71DILBl5NvHSESR/ba2WYjI6pnsnzNLuAqvSW4dvOZcVh5bv39NXDde90Z1mz7q8xXIr/gLwwNN9O0cEaVj+JSeGzbmBQ7PgBZZpMsXRoJIV91LdBSSSp6Irt0OvybQahuqgLmd1xjGR3M3fYfWb9dX/tHScc9gKErQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jDU7gICUyG+SPJcyIjF86ZnnR9dXJVrmmGSoJrYWeQ=;
 b=yoHjMT528sEheJwcmeCdoCch+980AX0vEoh3E80ZPLVQrUk2KQ3T0SBNuci/CvoyHm0BRNlOvIF8Up/4wtlvxUmMd9AerXsVhFH9b0G3mdbtR9Mvthryyzd9ZmMSEQIn1OlcaPiPQxnu52YDITgmP2Yw3ZYiFucQ7V06BV0dn2t30DPd21ZnEe3DbwI4MpFugg4M1kPkuna5aybOdtPYIJfCaVHCSjlGT9goBDx6EsiiR8CWHk/sbhXcLa6dZg2v1wf7H7soMw5WrCIndwSD8W9nb1f4/Y1kEeQA6JlWmamJnoKMqytSc+DW300/3V3HVN6G0wOPOUdYxSaabAcIfw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jDU7gICUyG+SPJcyIjF86ZnnR9dXJVrmmGSoJrYWeQ=;
 b=cb2P2wdD1T7yktNWlKjYFlKsWWsFjC7vIdtKUo4gikTJlBOz7pvI4HUW+wV9Rkv2JyVX+vDiw0FhGpsvaY4J4NZ4HC43+fKT8h/H+eyiAO99Lez+pJvtrIDsnYjPDjCFyMP4TVZgv8jNvYmaxQKgyFTMHA0NjlI2JVSV0gD3/Zw=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f880e7dd-5af9-480c-a5ce-08de369d2c7d
x-ms-exchange-crosstenant-originalarrivaltime: 08 Dec 2025 21:03:01.6912 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: hlzT8+0drxzxdYWnD+gevMM2uEhJ7UbBwn2TvT5u6/75ycMHrQLzIv7NqDZSQFbP5idyM9uUnIExczc8kxZNeA==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB6547
Content-Type: text/plain; charset="utf-8"
Content-ID: <A70339B278889240B62AC1527C9713B9@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=796 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512080178
X-Proofpoint-GUID: 2p00M1ERYOhSvvxCfnk1vGVbsOJoFoqR
X-Proofpoint-ORIG-GUID: 2p00M1ERYOhSvvxCfnk1vGVbsOJoFoqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE3OSBTYWx0ZWRfXw4SyaGtxZGNg
 2+/zzrdEqHirNs4eXBjsgrkEP7Aiv/CTwk+VPF9ZHpcgKKF02wdJ6kPtBxO6XIoNykdPltOZIP7
 R3xQcEnRrfxXsCT3zDqYPx+CloLx5bNAbHOC3hwFqgCXh284QkXoK0qUWyE/txK3uoXUxATrFY8
 hNJ2nVPmq3ZyoKhvqjhkJ3VM1QQaqGJeJHKSbRSAYQMuwDMpqc9pnfBj8SNTx+0+7m23GsSMGP0
 wDXKJfLk9/Gr4Vc7xUrOijaDG4RyTTxQQLqd2jKgIEDKGkQnuLhEbFFTi5CBLjDKogJ1q6l4XqC
 rQ1v30u1BP7IqTCIf9pFbiPKfFr0WjhfQAcYcb5d8Bt3k/z6q352NPCcVyez19ZecqiIqhXGNuN
 LBd1+1OPbnh48wV5s+i76hZG6AoPdg==
X-Authority-Analysis: v=2.4 cv=U76fzOru c=1 sm=1 tr=0 ts=69373d11 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=uherdBYGAAAA:8 a=GaQpPoNlAAAA:8 a=lkLXBesX47YbDmGzhb8A:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080179
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCu+7v09uIDEyLzQvMjUsIDc6NTMgQU0sICJWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IiA8dnNlbWVudHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRl
YW0ucnU+PiB3cm90ZToNCg0KPiBbUEFUQ0ggdjkgMC84XSB2aXJ0aW8tbmV0OiBsaXZlLVRBUCBs
b2NhbCBtaWdyYXRpb24NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2hldy5vcmcvUUVNVS8yMDI1MTAzMDIwMzExNi44NzA3NDItMS12c2VtZW50c292QHlhbmRleC10
ZWFtLnJ1IDxtYWlsdG86MjAyNTEwMzAyMDMxMTYuODcwNzQyLTEtdnNlbWVudHNvdkB5YW5kZXgt
dGVhbS5ydT4vX187ISFHanZUel92ayFXdjhnOEpwWkdPbDk2Uy1SWF9UODFkMGZ3UGVpNUMtZkto
S0FVcU01REptZWMzeEtoRmFTdGlpbkUzSUZMeVV3cnMxVVFyZFFndGgzVlUxSFJsYmxSamptVkEk
DQoNCg0KPiAsIHdoaWNoIGJyaW5nIHNhbWUgdGhpbmc6IG1pZ3JhdGUgVEFQIGRldmljZSwgcGFz
c2luZyBGRHMNCj4gdGhvdWdoIG1pZ3JhdGlvbiBjaGFubmVsLiBUaGUgYmVuZWZpdCBpcyB0aGF0
IGl0IGRvZXNuJ3QNCj4gcmVxdWlyZSBhZGRpdGlvbmFsIG1pZ3JhdGlvbiBjaGFubmVsLg0KDQpI
aSBWbGFkaW1pciwNCiAgICAgICAgVGhhbmtzIGZvciBzZW5kaW5nIHRoaXMuIEkgdHJpZWQgdGVz
dGluZyB5b3VyIHBhdGNoDQpzZXQgYW5kIEkgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3JzIGZyb20g
cWVtdQ0KDQoyMDI1LTEyLTA4VDIwOjQ0OjMxLjI1MTE1M1ogcWVtdS1zeXN0ZW0teDg2XzY0OiA4
ICE9IDEwMQ0KMjAyNS0xMi0wOFQyMDo0NDozMS4yNTExOTlaIHFlbXUtc3lzdGVtLXg4Nl82NDog
RmFpbGVkIHRvIGxvYWQgZWxlbWVudCBvZiB0eXBlIHVpbnQxNiBlcXVhbCBmb3IgbWF4X3F1ZXVl
X3BhaXJzOiAtMjINCjIwMjUtMTItMDhUMjA6NDQ6MzEuMjUxNDkyWiBxZW11LXN5c3RlbS14ODZf
NjQ6IHdhcm5pbmc6IHFlbXVfZmNsb3NlOiByZWNlaXZlZCBmZCAxNDEgd2FzIG5ldmVyIGNsYWlt
ZWQNCjIwMjUtMTItMDhUMjA6NDQ6MzEuMjUxNDk3WiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5p
bmc6IHFlbXVfZmNsb3NlOiByZWNlaXZlZCBmZCAxNDIgd2FzIG5ldmVyIGNsYWltZWQNCjIwMjUt
MTItMDhUMjA6NDQ6MzEuMjUxNTAxWiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5pbmc6IHFlbXVf
ZmNsb3NlOiByZWNlaXZlZCBmZCAxNDMgd2FzIG5ldmVyIGNsYWltZWQNCjIwMjUtMTItMDhUMjA6
NDQ6MzEuMjUxNTI0WiBxZW11LXN5c3RlbS14ODZfNjQ6IGxvYWQgb2YgbWlncmF0aW9uIGZhaWxl
ZDogSW52YWxpZCBhcmd1bWVudDogZXJyb3Igd2hpbGUgbG9hZGluZyBzdGF0ZSBmb3IgaW5zdGFu
Y2UgMHgwIG9mIGRldmljZSAnMDAwMDowMDowMy4wL3ZpcnRpby1uZXQnOiBGYWlsZWQgdG8gbG9h
ZCBlbGVtZW50IG9mIHR5cGUgdmlydGlvIGZvciB2aXJ0aW86IC0yMg0KDQo=

