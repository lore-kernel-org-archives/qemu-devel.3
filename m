Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A24DC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjx5-00032V-Lf; Thu, 12 Jun 2025 11:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uPjx3-000326-Qy
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:34:49 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uPjx2-0000ck-1I
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:34:49 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 55C8cNPE019368; Thu, 12 Jun 2025 16:34:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=K+yDkRzota13sRV5L/qODzV+ejFBRbFSM5qzAVeQssk=; b=
 Bkm+u9VL7Km1dkFApqFYvQs5xSVNFeJnmVPa8hAN0Up4Jx9OUHpOo1rqdAsodzd8
 P/nzlKD1BhHQ6nHxVICHFnizE+OBic//7bw4HSpuZDoDb1+Kedn1pyxs1y6g5j6G
 Ug2oOOl6uRd09s3gvPloqqA+4fcp6p36cgHPQxsnjmofpxZVnomnNvZC5LjKVew7
 Chj55gmwD8B8Aptk4lN51gh6s8MSJshiN48Bj5VG++qJ9FrTqdW5+WGlqlCmX6yn
 AZaP2M+LyvxiUzrlm2zGbM/3yuDJIgEmwHQtEBW3754mCc+CdpGoNodOwbxnRQ0a
 yISNwhGQcyyDxatBGnA1Cw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60]
 (may be forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4750bb643s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 16:34:41 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 55CBSJFH001551; Thu, 12 Jun 2025 08:34:40 -0700
Received: from email.msg.corp.akamai.com ([172.27.50.206])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 474kdbesba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 08:34:40 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Jun 2025 08:34:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Thu, 12 Jun 2025 10:34:39 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SJ0PR17MB4446.namprd17.prod.outlook.com (2603:10b6:a03:297::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 12 Jun
 2025 15:34:37 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:34:35 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "beata.michalska@linaro.org"
 <beata.michalska@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "Tottenham,
 Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>, "Glasgall,
 Anna" <aglasgal@akamai.com>, Junyan He <junyan.he@intel.com>
Subject: Re: live-migration performance regression when using pmem
Thread-Topic: live-migration performance regression when using pmem
Thread-Index: AQHbw1DYBGrB/0pV9U+SV8KgfbE6+LPQ0FMAgAAvg4CAASnIgIAta7AA
Date: Thu, 12 Jun 2025 15:34:35 +0000
Message-ID: <D700A742-535E-43FB-A602-9FFA4F1DAA99@akamai.com>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
 <20250513161036-mutt-send-email-mst@kernel.org>
 <cac9c790-c195-4d06-b3ac-894320ccbb97@redhat.com>
In-Reply-To: <cac9c790-c195-4d06-b3ac-894320ccbb97@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SJ0PR17MB4446:EE_
x-ms-office365-filtering-correlation-id: 16db17f6-6193-4d97-e0bc-08dda9c6a2d0
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NTUxZCtDTzBJL0xaaFZuRTU5VXBmNm5Xa0Z1RGxPUU5zTlJ4eUJsWlJYZmNu?=
 =?utf-8?B?NHRoR3ZrUWJ5Yngwd2htOEVORzkvRTJja0VzRElnYVpNamYrSGpGTnVJSlgr?=
 =?utf-8?B?TDZCa1VzWnFsaTAxTTl1RDU5TEROaWdoU25jcVdCb3JDWWlxb290Um52TEJw?=
 =?utf-8?B?T3ZpM2VKNGs0OXhTNWdLazRMelpqL01GZzlVWEpXQTdBRFBOUlRxWGVoK013?=
 =?utf-8?B?ZlZyY3JUaWZyQThrNDc3RXhDTlU2WS9kSmxJeUNMaDY3Vm5ISVk5VjI0R3V6?=
 =?utf-8?B?cS9NMUdBQlgzZG5RMjUzc3RYMTZTQTgxZk0zODZoTm9XVWd0eW13ZlZVd1l6?=
 =?utf-8?B?MHB3Y1ZhM3pwUlpyVENvR1BvYTRsV25RTnRkMWxvZWdubWtnSEcxQVZjYS9N?=
 =?utf-8?B?NzFIWDdPTVczSUZaaFVJWWlybEdybDRMK2NaanNZNk1ZZExyYkxEbVU5UFBt?=
 =?utf-8?B?a29RVXdWRHVpN2d4RmhpcndzOWFBUnAyRk5Lem9aRTJGT2FVeUtHZEFtTjBS?=
 =?utf-8?B?dEcxQUNDK0ZtaDBrSHZDR0Zad1R0OC9zVUMzTjJQdm5wREpieVp0OE9NYmRy?=
 =?utf-8?B?R3h6ekk4S1p3ci81K2FEUG8yYlVhN3lHL0xsMk1lME9GT2x4Z1hrSGlXcnFM?=
 =?utf-8?B?RU9MU29LRGxjNHhRU1R5eXFTckdQalFkQjhlR1hkZEtOMkJzRktmbXpzc0tk?=
 =?utf-8?B?YUI0b2xNcXFiei9BQjlMNGhKeFo1NDQ1RVowZG8vRFNtNXlhR3lKVXNGbUZy?=
 =?utf-8?B?Z3dWSHMrblN5MWhNQlVtb09hdEp1aTJhb21nU0Z2NTFKdTNJeHBGbkhlT01v?=
 =?utf-8?B?bVkrT2NXY2ZIdmhma2tDK1gyRldOMEtraWFPYmY2c1hzd2VKMGp1REtDOWk0?=
 =?utf-8?B?b0FLQitOSC9xUVdCQk1ja1FsbjdnYjVGbjBiYW94c2hWMlQ2cHZEQjd1VEZy?=
 =?utf-8?B?bFYvWVZTNTRQOHdLQS83UUZjMUhVaTVPbUl4d0ZaeXhVVm1TWVhhMHlnRlpK?=
 =?utf-8?B?TkVDcTF0NG16TW1YUVNvZ08zc1doUkU3d0hMbW1UUmtPbVZ6c0xKUktlRDZM?=
 =?utf-8?B?NTlnQ2xIWS9FNDRUVjROSENWMmNxWXduaTNyUmUyT2dzVE5yYzZNWDA1aGhZ?=
 =?utf-8?B?ZDhKR3BzQ1Z6UTROd09nc2FTMGVRUWNQTDZmYis0QkhJbVVKQUZmV1dZVy9X?=
 =?utf-8?B?QW9LWlZqVG9CZHM0Y0xGZGtVWjVxOXNsZXpDMGIzS2JVRWRkWkJNZjVTNW12?=
 =?utf-8?B?aXZ0L3Y1M3ZsUVczSUNucjdiZGhUVjNqeUpGT2dqdm5JbVU2d3ZwUlJqMlhm?=
 =?utf-8?B?VnFYZWc2R0Fxb0U2amZDODNJRFVLaTFrK20zS3VqYUFIbGxyRWlVbGMyTUhn?=
 =?utf-8?B?b1BKbUV2aXdPM2E0K1hOTFd6NndvUkdvWGhsK08zR202RU56cXdLOFBIWlZZ?=
 =?utf-8?B?YVQ5WlZCZFAybkxOR05NRnBaNFhZZzFPSDlXeXlnRHRReHd2alpqRlVaNnQ4?=
 =?utf-8?B?L0lpWlJTS2tBd3NtbDVJaFNuK3NPVThCMmJRWEZuN25GVHd6VjAycmpxOXkx?=
 =?utf-8?B?THE4MFZkYUxDQzU0dkxkQTZsQ3RVcmlxbnpoT3VHUm4vNEkvSFQ1TFhWZVFO?=
 =?utf-8?B?NnVzaHQxR2djSjQ1RXFBNEQvNTFMeE9GUGRMUWFDZitqQmJscW5sdXA5b0ti?=
 =?utf-8?B?VHlkYUJTd2lZaVVSWGlQVVVFZ25wTzBQZUFMK1ZGNWtCb2dVeENZZkQ2ZUlm?=
 =?utf-8?B?QTNHQUJDMTczL1J1bEpZYUV3aGdRK01TYlhvVzFNaU53NGk2RVVOVDIxbGM1?=
 =?utf-8?B?SjBzZVBSOHVYYWtVWlRGM2s1dTc3VnZoODVMV05VMFdOSTlZcW5tWFNHTTF6?=
 =?utf-8?B?SEZpb0lna3BrZnpXTDdBM0RQZUZnSjU2UXlZcm9xWHNicE5WN2pOejhJeTdp?=
 =?utf-8?B?WDdTNmx1QitoRlZvcEpTMEo0OVV4Y21rTnVuVHNUQ01EVmdUZFZFaG1XZHJR?=
 =?utf-8?B?YWxtVms0VktBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhhOEozV01OS0tlWEkzbGhESElDZ3NFZUFiZmdvd2NsSFFNTGlCN0xiNjRT?=
 =?utf-8?B?YVVnWHhpTVFrNUc4anVHQWkxN3l1WnM1WE12elVES2MvTjl1VVhHZkkwaEtJ?=
 =?utf-8?B?RlRPdGtPNkRkMmd5WGJsdHFXL3RWbHRwcFFXcVN6SjhWTzdzd2pLS0QxSEk5?=
 =?utf-8?B?VksybUJSd3JtQ3BPdzJ2bU5Qc1pqbS9hS09waHNiV1h1M0lTaTIzQmlrbHBG?=
 =?utf-8?B?Q3kwWGNBbGdMb3puOTR4V2kxNWs1SmhyREpJUnM1MHhVbit1NDlmN3NtREFm?=
 =?utf-8?B?eUdtZVBzZjloMFEvYUVPcFpvZ0dMZXB2blhGc1ltUGE2NUIwUnY5T0RVU0Jz?=
 =?utf-8?B?MXZCYkRITEZOYkdJeUE3N3ZTaktLMkQwTzg3WjFCdm1KVzdON2VBTmN4WmJh?=
 =?utf-8?B?L2pSMjFtVDZqY1BtSyszM1EwZFcyVzZIMGNOT2UvcFhnUXN3LzZqcjdmSDlI?=
 =?utf-8?B?RFJMK0FReXVCcE1UVEs3eU9iRmdrZnYrZnM2QkJQclhGTFZHd3Y4SnZ4N0Nh?=
 =?utf-8?B?N3AzL2ZtNVAwR3d5Z2lWMjY5NXV3TmpPbmJrWEZjb00vL1EvVC9xMkdpMkkr?=
 =?utf-8?B?QjJBbVNiemFjOC9MVWI3WmRzL3c1UmVTS2JZMDBvd2NJSFVIeWNiWHE0SlFy?=
 =?utf-8?B?ZktUaFExOWF0QlNWdkloMFVveElRZnJKUW1yN0xBWmt6V3k2UkxqcHZ6ZFpj?=
 =?utf-8?B?L2NsN1kwS3ZmMFZrYjh0QnNkMjhvbEhpa0t0M3pPOC9oZmlvekt1RGRJaGhm?=
 =?utf-8?B?ZjRoUVNNU3RPNkMxZXZWcFh2ZUJmdlVucDl2Rkdzb281OWI2T3ZzZnRsVkJE?=
 =?utf-8?B?Uk13QStuZnoybnR5eWdLTmUvNjZxajBGVVplSm5ORUJXeVBuNzdJVlZCODdp?=
 =?utf-8?B?UyttMW53Vk1vUmJWSHZSN1Jmc0lKQUFCcVlYTEdhbTBzVk5oQ1VBL2lhS25J?=
 =?utf-8?B?NUhXTFkrQzI1bjgzdnk2bHZVTTJ3SDZhSHFCZy9MR0swcHhQWWZjRmQ3dFFD?=
 =?utf-8?B?QkQ1QXlMWGhhY0tQVE9UQkJFcm9rRHBRemVyeEpLcWRpZGFjczhzcGxXOHly?=
 =?utf-8?B?SmRQNUFIcVM0aDdPQ3JPelZKV3lXMkRxNGdFSm10Q2FONnRFSmNiSnZEUjdz?=
 =?utf-8?B?QU9nOFZrSFpxZkt0dUxzR3BsVlZKNFdoYktuVzhkRXZnanVrUUo0Ty8yUmpa?=
 =?utf-8?B?MU12b205SC8vU0sxS29qemNDVzZEa3lXMnZlM1pJRDZTeVlwSEpjQmJCZkI5?=
 =?utf-8?B?UVV4SkJmMC92d0RHbzRrRk16RGs5RitJdnFsbVk0WFBwQnpwZW9IVDZPZjBl?=
 =?utf-8?B?Y1hFc3VRUGZXOEZlZkx0cjFhZkhDNzU0UUowUWcvMENMZzFXam5jemxjNVZX?=
 =?utf-8?B?QllzYUZlMHdvcnkyQzczNmhjMzlxbVlFcTR6N1ZiZUNTQm5jMnovN3VSa2ZT?=
 =?utf-8?B?a0JPL3ZIRXhRbTBDVE9PNUpUT3VHemVnZXdwYUNnY05tYW5BNEhkOWZxOTRQ?=
 =?utf-8?B?ekNqRjF4RFhFbkNjbTdaU09KZ1dseUhQWHQ0WVVrUHE3UmhJMkNVdEVsOHVC?=
 =?utf-8?B?VlBvZHpqZEJnZEE5VXFMN3dadWwwS00ra3pmN25Lck5pZzF2WnNSNmRWMnNT?=
 =?utf-8?B?aDliKzNtVFpjTHZRWU5LSVphMWtVMGFLdTk4aEdzSWRPUHRhbWdqNVBlVk5E?=
 =?utf-8?B?bkc3U3lQZWgralVMcTJsMlp6M1FUaWZHbDk2WWcxNTBrZStHSit4WkJFaFQ5?=
 =?utf-8?B?WDB0VFVkeWVyN1o5OS8wZ1ZMQVY0UlJ1WEVHUVVEd2dvMlg1aW1lZlY2V3FU?=
 =?utf-8?B?Mlpmb1daSi9yWXBXVlZVU0QxQTVYdExlbjRISG5oL2tjM2tucGdlY2tEQXE2?=
 =?utf-8?B?LzEzZGtwSnhGb3VJdktsREtmZXpTSTQ2eXR3OHlKNlRncXRjTFk3UHEzdGlV?=
 =?utf-8?B?VWVkeHVESUNhQjZEZnJFb3kyem5yZlJYK0VodTd1akkrVjBXZkNMVHBabm14?=
 =?utf-8?B?ZDBmeW1hdlNsd3pnK3FZTFVIeTlHKzRENTR1RzFkbHpXakt4eElPMDUrSXEr?=
 =?utf-8?B?NFhUNVd2NXFBeWx3OEVNSUtmU2thY203cmwrdm9RNXoxUDV2UzZIOWZXU0J2?=
 =?utf-8?Q?sDJQGUTbbChi15bgBcL/GpKYl?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6f6C4YW60p3h62tUB40oVfVKQWownAysCNbkfHAajVGU0mg+wMYi+3WS6GM8dVVuSNqFfOGGCcFVt/aTPSF34I03YzHMAuOkt6YxL3+71q6Mjbzqs/GEDtVV3wMBnXjQUYgrDCZaecHtaHAe65mh/ck5mWO5PqZy61m/M4RMFcWeVUzogdkNYuUbi6BlkXGj0J2N8I2SIxxhlwGkYtPwrUK1lXYEx3Aiuvvd8izlob48z5HoDPvqosmnqy1GW5A0prUFt2Il/JB891tZ/EqQiKAnbr16NWxtN7odDt0NZG738EFgyvayA6dtnT0FyLLMEzGp3WdBiMS4dSAySl8fg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PttHmaBpALx6A7Ixz+1LmyGhR24MYHzhCb7SPobys8E=;
 b=qHeJGOJOzKmodMkDTSOnSr1mYubRsyHcEsSg0seKmbtbxQNRTpeVfuVD+kNTtS3SZiwy/UxPZkPlnXQASAHqCg35EcVyCWi2rlP9cyKHXUfhE0ON0QmE8iTJIvkmjcpux6tSL6wUVgtweZHQnBzlzZFQZikGEOeoeoDhOdgy2hisdld80OuF2m84140O4Lj+oxqBGVXBytBD5OsEbkubPSNbBQB/xZg0Tl9oMBvU0iRaUVXTOEdR/9X1W9A2pp2MpfWUAqdK26f7WLfQT+ov2DeMtWzh1N0v5LK5DJIyuhioUCjeZ1HMc6/GQgQbTKjEV0gzp2Kzb9edX+r2SeB+RA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PttHmaBpALx6A7Ixz+1LmyGhR24MYHzhCb7SPobys8E=;
 b=KYUVGHlnNxwmkYA5ZXx4y/jW3iAZ41hoO5akPqvgrFTd8hJWxRoXioUlUBHyozSmnirQIS2RnNLfk7iKtPqXoC4EhjET/Ze2MriMckmt0rnm5DIRvIDP5J7pj/ajsE+z2O2EPHmD2+doeY1TNgHf25vsciu6eX0nbXaatx5+uYg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 16db17f6-6193-4d97-e0bc-08dda9c6a2d0
x-ms-exchange-crosstenant-originalarrivaltime: 12 Jun 2025 15:34:35.6620 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 6KBxFTLsLRsBzAAAJrlYE5t9FjEMVsxNWzbkn2VcearfWXi3tr8VzfX5dxLXnMswVhwt82TAwtmhR1HwSfqyRg==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB4446
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <402C762A97A87846BF0D89B16A166ACD@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506120120
X-Proofpoint-GUID: AuX5rIeUKw7vCt61tOH84Guok14ow58B
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=684af391 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=g1y_e2JewP0A:10 a=20KFwNOVAAAA:8 a=WzjQX8Fx5E9lm21ouUkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AuX5rIeUKw7vCt61tOH84Guok14ow58B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDExOSBTYWx0ZWRfX3Q6LghqnszNU
 nUkaEGrhn7u9/rPjNbkWKhiJPx8FI/Gr/8z6cXGP7AS1bkb5v6GRFRUMjwPeJknKyXnIUf7sddM
 mvH/UUMR3n9d1YSt3WV6/TQmr4Surt850V5EDYVHXT6HsQw5GNC1l3JpfbDUQSy3YABGXzlq+c2
 3oRplzA637dZ1ej86m52FI5rtvwJA9SdkH8/8eQ9QizQsNwLGvdtP7HlkMrUwWlvfbhJcxaNvzH
 L0eu0fXFNJLsP1cYvDuNIdM0bpig3n61QWSwRWobKaK5HJcPZcn8Wr3qiZeER7pW3I/y9eRk7p0
 s5XvKBSaDzrQyXFvMjme1PZAY+rQWFCDhRDsfREgcDIA2CW06h9G5BwILX84z/etjDMBGjmAEVh
 qWHanzlpwRCbFS1ZZg2YpdqH0xJUF/RO0CUoXdTsU5Ko/UEfSXP193iVfwLFO4a5/RiXwVvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=981 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120119
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

T24gNS8xNC8yNSwgOTo1OSBBTSwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0LmNv
bSA8bWFpbHRvOmRhdmlkQHJlZGhhdC5jb20+PiB3cm90ZToNCg0KDQoNCj5CZWNhdXNlIHdlIG5l
ZWQgdG8gbWFrZSBzdXJlIHRoZSBwbWVtIGtpbmQgbWVtb3J5IGRhdGEgaXMgc3luY2VkDQo+YWZ0
ZXIgbWlncmF0aW9uLCB3ZSBjaG9vc2UgdG8gY2FsbCBwbWVtX3BlcnNpc3QoKSB3aGVuIHRoZSBt
aWdyYXRpb24NCj5maW5pc2guIFRoaXMgd2lsbCBtYWtlIHN1cmUgdGhlIGRhdGEgb2YgcG1lbSBp
cyBzYWZlIGFuZCB3aWxsIG5vdA0KPmxvc2UgaWYgcG93ZXIgaXMgb2ZmLg0KDQpUaGFuayB5b3Ug
Zm9yIGNsYXJpZnlpbmcuIEkgdGhpbmsgSSBpbml0aWFsbHkgbWlzdW5kZXJzdG9vZCB0aGUgcHVy
cG9zZSBvZg0KdGhpcyBjb2RlIHBhdGguDQoNCkluIHRoYXQgY2FzZSwgaG93IGFib3V0IHNvbWV0
aGluZyBsaWtlIHRoaXMgdG8gcmVzdHJpY3QgdGhlIHN5bmMgdG8gb25seQ0KcnVuIHdoZW4gaXQg
d291bGQgYmUgZWZmZWN0aXZlPyBJZiB0aGUgbWVtb3J5IHJlZ2lvbiBpcyB2b2xhdGlsZSB0aGVu
DQp0aGVyZSBpcyBubyBiZW5lZml0IHRvIHN5bmNpbmcuDQoNClRoYW5rcywNCiAgICAgICAgQmVu
DQoNCi0tLQ0KbWlncmF0aW9uL3JhbS5jIHwgNCArKystDQoxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9taWdyYXRpb24vcmFtLmMg
Yi9taWdyYXRpb24vcmFtLmMNCmluZGV4IGYyNWViZDk2MjAuLjI0ZmIyOWYwYTUgMTAwNjQ0DQot
LS0gYS9taWdyYXRpb24vcmFtLmMNCisrKyBiL21pZ3JhdGlvbi9yYW0uYw0KQEAgLTM5MzAsNyAr
MzkzMCw5IEBAIHN0YXRpYyBpbnQgcmFtX2xvYWRfY2xlYW51cCh2b2lkICpvcGFxdWUpDQogICAg
IFJBTUJsb2NrICpyYjsNCg0KICAgICBSQU1CTE9DS19GT1JFQUNIX05PVF9JR05PUkVEKHJiKSB7
DQotICAgICAgICBxZW11X3JhbV9ibG9ja193cml0ZWJhY2socmIpOw0KKyAgICAgICAgaWYgKHJi
LT5tci0+bm9udm9sYXRpbGUpIHsNCisgICAgICAgICAgICBxZW11X3JhbV9ibG9ja193cml0ZWJh
Y2socmIpOw0KKyAgICAgICAgfQ0KICAgICB9DQoNCiAgICAgeGJ6cmxlX2xvYWRfY2xlYW51cCgp
Ow0KLS0NCjIuNDAuMQ0KDQoNCg0K

