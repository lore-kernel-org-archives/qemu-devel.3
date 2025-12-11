Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5969BD41D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTlcL-0003sm-1L; Thu, 11 Dec 2025 13:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTlcH-0003qm-6R
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:42:17 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTlcE-0001A8-NG
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:42:16 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5BBGF8ni745380; Thu, 11 Dec 2025 18:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=jZMyJ3jjFyTVIrUEf4eLNAV/wHieraeB98w52QPhRV0=; b=
 apXSVNhSsAQFZiO6WqX42m+B9iDYYMFKdgwK3I0ojnxT3m+v1Us2ycSpYngdH2nE
 wFFUq9Igaz0m5xGd0tLFFrojKc3h+suoe3YPu3G9Rt7QL4o/REY5WW/pbvXoy1Hc
 00TfGeEzAts118HZ7cbW0bFJac57nJAgrgcN7qpqccY6qfwvmT2osAibCQuqDHsW
 LFftmJ94PRHgGvEf2ADFinVCoIR7A0iHMVtmhgdAm2dlhJ09KE7w/AZOGsd9/jMe
 2sp1XHau8CxYGCcqnTJI27I7NwuCKF8x0hob6tOYgnKhx2Q48Ky7z2d0BbUGAqpV
 ikB5b1Jfl3yKJphaeg0iHA==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4b01a29mah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 18:42:09 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5BBHDa2X014060; Thu, 11 Dec 2025 13:42:08 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4aw292vudg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 13:42:08 -0500
Received: from ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 10:42:07 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 11 Dec 2025 12:42:07 -0600
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 11 Dec 2025 10:42:07 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SA1PR17MB5555.namprd17.prod.outlook.com (2603:10b6:806:1ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 18:42:05 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 18:42:05 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: "berrange@redhat.com" <berrange@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Thread-Topic: [PATCH] migration: cpr socket permissions fix
Thread-Index: AQHcWk+Ww41l0upbvEuzSutbKZyWdrT9TVYAgBRdCACAAZRjgIAEq6SAgAHbjgCAAs1MAA==
Date: Thu, 11 Dec 2025 18:42:05 +0000
Message-ID: <3DC0D610-FDC3-47CC-83F0-BC9CD470E972@akamai.com>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local> <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local> <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
 <aThwdthSF30NygY4@x1.local>
In-Reply-To: <aThwdthSF30NygY4@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SA1PR17MB5555:EE_
x-ms-office365-filtering-correlation-id: 1370a130-b88c-4d25-943f-08de38e4fba9
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VS9YNFJrUWdHU2paU0dCdjRmeENlM3BRZ2VMbzdua2xMV1RWeDlTOWtwU2NH?=
 =?utf-8?B?N1JuV1EralRGMGxCV0hmMFQ4MEZPVTY2S0ZIZjN2dXl0SkdHMTNpdjZDZHZW?=
 =?utf-8?B?dkZvM0NJYWZWME5hajVYNTRKTXpIUlBwM2dxMXdJY2xPd0s3ZnhianlPQWYx?=
 =?utf-8?B?c2ZQYkEwWG5vZlZIWGZ1WkN6dVVEc2VJZWVVeStmVGN3VWNEN0s1cUx2SFFI?=
 =?utf-8?B?NVZReWdvZUtXOS9NOUh4MWxPWlRrOXNyV1JyNXRHaFVTTjBXZEJEY04wanp4?=
 =?utf-8?B?WUxnWHRISU14K1pSamFDckdnVU1oMjNYSFllZXJHYW1lSUJTWmNVN0ZBbzA0?=
 =?utf-8?B?cmcyYjRYUHUycG15d0VvZGw5a1p2NkxoRnRpY1Mvb1diTVEza25hbnhBV290?=
 =?utf-8?B?L0xrQk9ma3lTSjFvcFUrc09vb05FMmRoWGorSmRQT2pnM2ZFaWNWc3hDTjl3?=
 =?utf-8?B?OEJxL0pmdnpHcHVicmRKU2NxQ3A1YlhMclZmejI3TmhEeXViODNoZnZ2QnZI?=
 =?utf-8?B?ekVvVWc4TFBKUkFxYXRlRHJMRWtrTnU5Z05vdzVMZFNuTkcyU3REd2I2NGdu?=
 =?utf-8?B?RnRKNGpqWlpkMHhUTFJKVHUzSTJJSzlJeWVsTFY4ejRZZ0VVZUsxMGtzR0pU?=
 =?utf-8?B?amhFYmdBU2FMQUtXMzQrZHBRTy9tQWpSM05ySGJjVnErMGtmKzA3aVFacjZ5?=
 =?utf-8?B?Z3V3VzhId0hmR29vUjFCS1FuSmU2OFVQcVJ6aDNtS3o5NXpOMHF0Rjl1V0FK?=
 =?utf-8?B?cWtDVDExZXJPZjRCZGpaS3F5YjJuU3RzeS9MYTg4U3BiNDRaUDVWekVCM0Qz?=
 =?utf-8?B?OTVLM2NxU1JDZG4yK1JoRS9OcDViWVYvZWQ5TjFjMEF2YlRkYkRkVzVmakw5?=
 =?utf-8?B?TTNiRE10b3lkS05Xa2V6WktnK0RXZ1Y2SXZkVjR3bXJ1NFRlbjVVakJzMWFy?=
 =?utf-8?B?eDhVVVBWOFJJUm1UUHdwU3VhYzNEVnJCcC9RV0RJWDJpemdCWHNMTUJnYWQ2?=
 =?utf-8?B?RGswVTZ5clVoWFlwWFlXZVZiUUVlSk9vSzNmR0JlTHZ4TndCdUg2UE55bmZo?=
 =?utf-8?B?T3N0WUd4KzVkTEgyMU9nelJMdm92bDVRMkFBVzJPdmJBTWswQlZFaVNKcEI3?=
 =?utf-8?B?c3pTRVBKTVNtUU9wT29MaTJQbjJCOU1RYUpqa05Ua21NUmU0NFlDY1I1Q3dH?=
 =?utf-8?B?aFBLMjh2OEZ5Q3ZKR0MyenhNRktDWTNwNzh5M1dLU29WZkNmZWt0akRvN2Iz?=
 =?utf-8?B?MWdMSE53RWR1SmZPK2hjNmpmaTREL2ZUN3A4OHBCNGRLM0tDQXlCOUFyaSsy?=
 =?utf-8?B?QlcwWDhiR0pzcXVJaGhtb2lZNzR3T1V0L3JFUVA3M1ZkdUpBRjFzUnVDcmxi?=
 =?utf-8?B?YmhzT0cySGpLZE1yOGtaMWxhZXZxRU9QUDNEaWNtSzROUlB5bjhhVjVOaEJL?=
 =?utf-8?B?cFhWY2RJK3pqeGdoV2pLOEVnQkRaeDlTVWJzQSszK3Vmbi9US0pQb1c0d3p4?=
 =?utf-8?B?YkU4dzVpbDgxcFAzeSswM0pBUHAyMGx5VWh1aFVodzR1NG1SZjVkOUUxL1Ja?=
 =?utf-8?B?WWFscXFtaWwwT3UvMWZkb21OWGJJOER0a2pyL1lEaUVIcHBtUElWUzZEbGhC?=
 =?utf-8?B?dW9JM3JwUWtKQjlWc1ZOODRqZ3RCbmJHZDJ5aUpBbjRNQkI2NUdvSjBodnIw?=
 =?utf-8?B?dVdNdjBUSHplRWRBelRpQ1ErYUdFQzhnblo1ZWpTU2kyK3RZY1ZqRks3dXQ0?=
 =?utf-8?B?QkR5WHErc1NnbEdpb1A4a0FYOXRRZ1BqNUFRQ20yd0ZpREU4Qm5KSjNpWFVx?=
 =?utf-8?B?cXZXazN4blRhWjV2SzFmcCtVMHZjRDFEczluWllxNTBJbVVOUHZBOURFREg5?=
 =?utf-8?B?V2oyMndoNjZBWnBJUE8raXpoT3YzeWo1a1pIVjVXbzBEVkgvTmFqeDA1UmhM?=
 =?utf-8?B?MUJET0x3dlNEUXlsd29Vd2grZWFXMzBUQ0dMSWNXbjRUclBwR3p6ZVZuc3dz?=
 =?utf-8?B?ZU9oZmYrajlyb2s3RUEybVpxVzF4SXlHdXlReEFnTlJYTC9wNWVXVThWQ01I?=
 =?utf-8?Q?mnBZGv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1p0QkwrTFUzYkI2NEhHQjVKSkZSTjJwTFNGc08wQ3hkSjRXVUVpV202cEg1?=
 =?utf-8?B?VHRRU2dkM3hiUktZdG9MNVJublhVRnNIZTFjdm5INW9aRDU1ZlVKL2hTL3Vs?=
 =?utf-8?B?SWhHdGdOQjZ1VUxkR0RnQ0M2NFVOVFVHTll6dlZ2K2RvOU5SVUJjYS9HSlhz?=
 =?utf-8?B?Uk5Db2JOS1BWUTBOdEdRM3ovMk5iR3Fpa2d5djVwWmJReWR4VGZzaTRMRUhj?=
 =?utf-8?B?blZpVHBCcFVhNmthbnp1ckNtT2tqbUhzTWNRMGtZSDE5NXFCU21jenh4c1Vz?=
 =?utf-8?B?cGJKei9telZCQ0oybHRTQnhWRVJFbDZqdkMxZlkyKzVCUkFQaVM2V3FJWmFi?=
 =?utf-8?B?WEExQ2ozWVdSajRiV2RvSzRBTVQzWXZqOEdtaUpxM1I2T2JYbVZHay9YUVU2?=
 =?utf-8?B?OHlkMmp0QnVXcGJZMVdOUkdKS3ZOcFFKbkJMeGx1cVlGaEZqYkZGYmVrWG1x?=
 =?utf-8?B?U2JEVlg5K1hLS3lpU1FKemp3V1I5cHZ0dklDZVZMQnMwTFJTbVkyY2EyemhC?=
 =?utf-8?B?RFdYYnUxRFF3ZWFKZVhPSnpQQSs0ZDRVS2JyUHI2Z1JNeEZtblFtSEtGUmx5?=
 =?utf-8?B?QkRHWWUrTEllZjBseURJTFZZV2F1WVo0aWtUSUJIYi9QcVhKcjJ0SzNhY3Nh?=
 =?utf-8?B?WG8xRkFobFdydlVaY05HcUIxR1FpL0hucFNuL0ZhQjJIN1RmUUMvRXJNMHMw?=
 =?utf-8?B?a21XRUFoaXk4ZjQ3bFcwenlzL3Q4bTJQV3EvWDQwK2JSZEZLbWNzeDRLZWE3?=
 =?utf-8?B?WU1tQno3bS9JLzdLK1d6Z3VoTHFIZUVSOWdsWjExYW45bml1YnRmVnk4RU9o?=
 =?utf-8?B?czFJNExQcjlBT0U4Qkp0Q3BhZThhSVF3RHFhdkVDcGFlMHprdHoreVdxWVBY?=
 =?utf-8?B?aUhRWldaL1oxMnZ5U0JQYmRwNVd3Y29scjhvTWN2VkkreGNwQXZGWHdwamUr?=
 =?utf-8?B?K1pyVUIwUDRYa3hxNEFIYUUwS1AwdXNsNTdyWG1mSFJMemJLaTU0UjRXMjBK?=
 =?utf-8?B?eWUyckZvSDVta2k0N29STTV4Z2Jod2xVMnBuNlQxQmxxRWd5SldzS2hMa05R?=
 =?utf-8?B?QTRyVm9vak1RaXVkOG51RDUyd0lOdGZ5ZzliV0s1Z1MrRGtXOWNUTDU4TC9m?=
 =?utf-8?B?cFQzVlB5UGtCQTBpajFkTDdva1AvSTB5UDlWb21IQTFiSlVZVGVrSnFCSVZP?=
 =?utf-8?B?QmFRZ2c5NDMvTWJNS0docmVadE55OGpKMVhnU1VjQUpnZVBwYVlmN1FRMG1J?=
 =?utf-8?B?WlFWNzUvbFBRVzB1TDNIS1lBTEE3WUN0TlA2V2YzaFpDK2pMTVpVUXQyWU4r?=
 =?utf-8?B?bU1xeWRmSm1jMER2SElpcEpXY2p5VjE3L1M1UXN5WU9KVU5ndWM0WTYyRXV6?=
 =?utf-8?B?aVlBOFkrVDUwMURid2JpR20zcUVhUkVzQy9IdWt5eUNOM1Z5T1BHM01IVDg0?=
 =?utf-8?B?VU9Nc0xJeGpwRFhPZmxSSGtnQmtJVU54R1VieUduRWVmWmNqZk80OWdCNnVn?=
 =?utf-8?B?Vy8zSTRnR2JxQXljOVd6Z2JlWkZheHF1Qy9lMlJLUUU2TzJhNGdLSXJqckVu?=
 =?utf-8?B?RWxrRHhPWXEzMm5PRml1bnhDRjI3ejF2bEtlYzhmNzR0dXpydTlYcWtMYkpa?=
 =?utf-8?B?VXFEay9jZTg0QUY4aFo2ZW9BeHYrbE5WRjNROGF1WVh2Y1JyRHZOanNRN2Fw?=
 =?utf-8?B?Nk1MeEl2YXZqQjQyR0phV0RaTzdMVlFPOE5lUGZMY0NCUCtCcnNJcjRxZ3lr?=
 =?utf-8?B?NWZEQkE1aXJTRklzY3dFOUtUM1hNU1ROa3NtS3dPK2FCS0NwZ2ZaVjUxZXlC?=
 =?utf-8?B?RXp3WEZ2cUxWZU9rMFpaV05qanNITnk3Z09JSVVmZ1NxU0VLaXo4YmdHakd0?=
 =?utf-8?B?RE5OSEFlbmZmM0FPVDFya09xOXRFaVlBSzRUZUp5VVlSVytQSk5MYjNSWk1F?=
 =?utf-8?B?UEdCOVFSYlBlcXRnN3c0dVFKN3ZGLzdBMDROTWF5Wkt0YklpUEJwU3FYdlhx?=
 =?utf-8?B?Ly9UVThxNFBySjN5OEhicERobng1dDNyQnllemhCZ2R2bUhKZEpic0dmNWVy?=
 =?utf-8?B?V1B2cG1weXh2STRPWC9OZWJXRnl0eEU0LytPWHVvdjN5UEdCejFXQ1hFWGxa?=
 =?utf-8?B?ZDV5TUFQenB0OG9sL1BFc3M1MmkwcWpVdk5PZkVucUVDM25PWWJTbDhDNVpv?=
 =?utf-8?B?Ri9Qb0JBZ2xFSEdYTFBRWktiTUZ1ZFpXNmdoWWhQMWJYbGFTdlJEVXhTOW9T?=
 =?utf-8?B?OEhrSDRxOGQvbkVQL20zaHRuMFNnPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKekwESHvQkeJOgF7YkoUFRSIsupyr+9yze1RkG1RLgBZwJ0kP4m2i6H2AmtN2lGToAvQjcKsiD+upkrD85v3qvpPxb+UUgDcQII+I2t8e1kjxFW0fngWTcCV1QlCNCdsGSn3A6Xo7yemdqr8lZAdp7HjF/5HoT5FWsM50oIILyLB/86M+3qTokodCQhH6Sv673veLXT7UGs8TVADHwVnZWrY5RwFAy+k3H0eDMkjp15KduDVnrY8ErEd/Fy71mFObKyFq58cKuQUbSP/O2du31/t4129w1THvWMdNoDhEz5GwDdmY1zBiivWtEY/vz0HWeCPzalMJPw10HK0yegYQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrhzv5BTtFX01GOGOdH2CngdBS2R7rtIR0iDOmsAngA=;
 b=j1nCzHTYTvY+i8kDIk0Xh9uFfQupjxYjAH1gM5o02xXPGAitkGGOXxJcdTrtYukpBwym6xCOnGGpagnCeQxcJhpt6nsum1xTATqghLBo/WniXni3pHUh159Gj7tNRNjISi9gA7aonq/F2Pwo6wr+S8canXAWDkNc35Td7HLxOTCI0AiTBrUOT8Z1gVzqAEHuHElv7lj+KgqnxBJi7U4YB/+N2t55rjnVxcQmIlNgjG+FLz6tzv1Wo/LiS1AsUq00fyWunjlpquuaS1Sy+pWWVgn4jmo2fbXDWVKLeHadxA9WRhwmmG1b3a7Tm96WQgOSL8VCKofj4ekES9CptpzKfw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrhzv5BTtFX01GOGOdH2CngdBS2R7rtIR0iDOmsAngA=;
 b=RgikokqmkxOdv7boTGhXAbiMkMuindG4b6JaGRuBy26SU9FO5MNEEWzm1diR4ppra3kGzMwIAsBiJ5FWMcd77rGCaowSM+/ltUhEFJLXkk9Qqob8DNXXJIevnaY81fBbpEsQmTSsGsDInaOFT43fPQNpys6MHx8pSC20wDSGrKk=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1370a130-b88c-4d25-943f-08de38e4fba9
x-ms-exchange-crosstenant-originalarrivaltime: 11 Dec 2025 18:42:05.8587 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: +hnJ3SyaMB5Oc3EuJgtgNBeqVi0ILnE0zXGdZ8RrB5NOfyXUvlVZ9jC0HdHqMH39xR7HWD8CUHB37HnwaI4jAQ==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB5555
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF97C443DB66246A9A5E0C003430141@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=904 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE0OSBTYWx0ZWRfXxi84R/Y/gkw2
 e3b79YFZk5aX7mNwBeke5Z9W4/P45XGfXG5pt3bm+7rqsNidtvj95zlvvgNEpydUyaLwPNuqOAg
 8EG9GdDDxkrkrjDpKAuV+K2NucwgYUgfj6WiuMVFh6sB0qDR2jgIan9eDklh9px1X0rajwhEEgC
 ga/XqSlIVq2F+kT6QndFkiaYVT31AHIKQ7myBilN3F0MYOOczRbrvAS5XnBNJTQxiFiRT8+GBOM
 Cf9smlrpzKGgvdcPDaFWEcd2ZxQTlwHUNPBOixVJdYOyEQ98mzxFt65cmCiRH+56Pkr3IlISuiB
 UaHmcGAfZr7d6+4bBXNOxER/Bti6WnOhxFs7X40MpbNXiV/IIr0YJGurlZY4FztZv/EPwdWA1wa
 QC4xUEmRD7rvyPREw4nILnEucToihw==
X-Authority-Analysis: v=2.4 cv=D8pK6/Rj c=1 sm=1 tr=0 ts=693b1081 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=mkHXZ0Mcnl2pg6XeXy8A:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1AYGAMkRYAdNlgTchHNbI11C27zSrDk0
X-Proofpoint-GUID: 1AYGAMkRYAdNlgTchHNbI11C27zSrDk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110149
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCu+7v09uIDEyLzkvMjUsIDE6NTUgUE0sICJQZXRlciBYdSIgPHBldGVyeEByZWRoYXQuY29t
IDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20+PiB3cm90ZToNCg0KPiBPbiBNb24sIERlYyAwOCwg
MjAyNSBhdCAwNzozMjo0MVBNICswMDAwLCBDaGFuZXksIEJlbiB3cm90ZToNCj4gPg0KPiA+IE9u
IDEyLzUvMjUsIDEwOjEzIEFNLCAiUGV0ZXIgWHUiIDxwZXRlcnhAcmVkaGF0LmNvbSA8bWFpbHRv
OnBldGVyeEByZWRoYXQuY29tPiA8bWFpbHRvOnBldGVyeEByZWRoYXQuY29tIDxtYWlsdG86cGV0
ZXJ4QHJlZGhhdC5jb20+Pj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gTWF5YmUgeW91IGNhbiBz
dGljayB3aXRoIC1pbmNvbWluZyBkZWZlciwgdGhlbiBpdCdsbCBiZSBhZnRlciBzdGVwIFszXSwN
Cj4gPiA+IHdoaWNoIHdpbGwgaW5oZXJpdCB0aGUgbW9kaWZpZWQgdWlkLCBhbmQgbWdtdCBkb2Vz
bid0IG5lZWQgdG8gYm90aGVyDQo+ID4gPiBtb25pdG9yaW5nLg0KPiA+DQo+ID4gSSB0cmllZCB0
aGlzIGFwcHJvYWNoLCBidXQgSXQgZG9lc24ndCBsb29rIGxpa2UgaXQgaXMgcG9zc2libGUgdG8g
Y3JlYXRlIHRoZQ0KPiA+IGNwcnNvY2tldCBsYXRlciB3aXRoIC1pbmNvbWluZyBkZWZlci4NCj4N
Cj4NCj4gWW91J2xsIHN0aWxsIG5lZWQgdG8gY2htb2QgZm9yIHRoZSBjcHIgc29ja2V0LiAiZGVm
ZXIiIHdpbGwgc3RpbGwgaGVscCB0aGUNCj4gbWFpbiBjaGFubmVsIHRvIGJlIGNyZWF0ZWQgd2l0
aCB0aGUgdWlkIHByb3ZpZGVkLg0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVycy4gSSB3YXMgYWJs
ZSB0byBnZXQgdGhlIGluY29taW5nIGRlZmVyIG1ldGhvZA0Kd29ya2luZywgYnV0IGl0IGhhcyBt
dWNoIHdvcnNlIHBlcmZvcm1hbmNlIHRoYW4gdGhlIG90aGVyIG1ldGhvZC4NCg0KV291bGQgeW91
IGJlIG9wZW4gdG8gYSBzb2x1dGlvbiB3aGVyZSB3ZSBjaG93biBvbmx5IHRoZSBtaWdyYXRpb24N
CnNvY2tldHMsIG9yIHdvdWxkIHRoYXQgcnVuIGludG8gc2ltaWxhciBjb25jZXJucz8NCg0KVGhh
bmtzLA0KICAgICAgICBCZW4NCg0KDQoNCg0K

