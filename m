Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A6BF588F5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErT1-00023X-F2; Mon, 20 Apr 2026 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErSy-00023J-M4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:27:20 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wErSv-0004pV-H0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:27:19 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K50Gh02997276; Mon, 20 Apr 2026 17:27:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=I2BsP5SBLQTAQpeiN0HjocC1wp2bivqvPEWaeu3vWLY=; b=
 aDat7VIPTaB5IvGN+PjX+EciDNLY/9JpE87Zv7mbWM8luemMWxdYHwg7cMrPuJjz
 WJT9rszDMKIJIE1w/5byHljDUdjaVPUUQBiiy44XGI7eDS7uPK73pyiIR93yWzg2
 rcgE5SQQ8t579isRL+XwksFQDA/vZ1HSmQAn6KK1VyAlE7suiD0uwSSPxW6QlZLA
 WWEBl7cP75BdclXkoV2VWseaTgfou1QRiZy1PCsuVMxDp9OuDLNvWUc54tSgnNpI
 7OVsH8vkoMkudZtutpKFM3Uc/rdr04K8Qb0LLh6ahW5f7dlAG3gyPkNASgcT+vxe
 tyZfGhCr/klz8SkuDwcLyA==
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dm20esfra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 17:27:13 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 63KGQjxT025927; Mon, 20 Apr 2026 12:27:12 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4dm59tt28m-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 12:27:12 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 09:27:11 -0700
Received: from BYAPR08CU003.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 09:27:11 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DM6PR17MB4152.namprd17.prod.outlook.com (2603:10b6:5:2be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 16:27:09 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 16:27:09 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v4 13/13] net/tap: check that user tries to define zero
 queues
Thread-Topic: [PATCH v4 13/13] net/tap: check that user tries to define zero
 queues
Thread-Index: AQHctsrjUu0NVb+ba0uRBQKreogn4bXoFG2A
Date: Mon, 20 Apr 2026 16:27:09 +0000
Message-ID: <2BB4C63E-85B1-4B4C-A013-A9812AE14BF3@akamai.com>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
 <20260318113144.15697-14-vsementsov@yandex-team.ru>
In-Reply-To: <20260318113144.15697-14-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DM6PR17MB4152:EE_
x-ms-office365-filtering-correlation-id: a8e61f78-2f0e-4f95-c1f5-08de9ef9ab9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6ReIa52rgVHw1XXAOGGz6N7ZWIgTBFyIfEyDnnlygjcxBwc3qpVJXx27pdRUpVBrb3l/EsByL2ScS3QqDvy6VczicL0yL/M7lnaFsoi9SCucfuqRSeMOmluL1YD+Uxl7ZxRwQGslBW0c1u/BpX7KD9si5F1ALCJbqMS6NjEt95Uz7Mo27UWpd+Csp7+2jXJiIbNxh3mPTizWvBJtwlZCQ+sxSN3PXuo+kHUDIK0RW1zAPdAyJzapNts+3avxsaZNbja/AUOo4QPTfljA5B8WXRdlcBRkq07zkE3RekbtzQfdeBrWByvsxVNCFaxr7yq69fHaRU+b2555zEuTdS52CZyAt7u/3VCSkhyGvQhvT9eQh3VBTWWajkj0JqUABfGZx7ufKIYzP9o82VnksfWpJgB0Tqjzc31+ML2m9oNk1GR72fC84NbMEv0q05NrrTlroaWb3tcjxLGcD3/VnDN4G1SPiUHLX+iLZvQFVKPEHVtIvLRTtaC6tCK8ofAuHLWqzBYO+giK4apgO5PS6j/yzqifODS78KcgLbtCzozIa2YNCN6MUtpkk2qeyzrARaVdDbEiHJO9XnLrGqPt3GIeZcYf31H48x3nc7YUToErmA34WdeLvrdJv4O2QqRsHJg4RK1npRFpS9UhR9uR9x9LP0jHIB0yE29J3QdXnVnAkH0FGf3L4R6Y0O0R0kIKGpGu70aR4PTVQ+P6QCIeYL0aQKhXn3MQO8lUAJyE5cLizslxJBmODjqriskMKmBhjdXnqxeIJfhDgmjhJVCRhSF8bhdvJ+WM5KIIVsRi9TmTw2o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VMN3ZaOUljTGlYaW1iTWxhSGFseGtyWlFmaENudWxzeVErRkgxcDlPUFVB?=
 =?utf-8?B?ZTZsM1NvSHFUU0NoaEtDWFlrMDJwY3JzM2NuUkZVeU52eWNvNi90K1BwTFhz?=
 =?utf-8?B?UDMwWDZhb3RaMzZncDZlYUVhK3VJMEJmTTNtRDF5d3ZRZVIxMXVlZmlqS2dJ?=
 =?utf-8?B?YkUzLy9ZcXhaenZPd1o5S2lGWHlRc0hsU3FqcU1YVTB0RFBtbDlVZ0F1ZXc1?=
 =?utf-8?B?MTFQQUNPZTNFZzdkcXp1YmJwQmtJdEhNbGxqaUhaYjFKZWg4Si85NHV4L0ZJ?=
 =?utf-8?B?TE9GamNndUY0STMxa3J0eUVnN2s2OWZsS3gydGZpVVh5bFlrYnpqalM4a2Jp?=
 =?utf-8?B?S1krMVg3V1JicjNBVExsSHRYaDJrVkhJNVllL1E3b3Z4dS8wMDB6UE1EQVkw?=
 =?utf-8?B?dUJYb0ZYRkdPZGRFRnIwNWJKZjJzdkpwU2pWQTJ4ZVFDVGwxUDlQOCszN1NV?=
 =?utf-8?B?VlZpWTc4WmViYldHZ09EN0lUM0lEM2pheXBMV1FOK2pzVGM3OWtySEtHV3ZP?=
 =?utf-8?B?ekFmV1lPU1VLdDF2T2NqNmFkRDNSTTlIQmZKTUhPNkw4TE14aEJjTStTKzFH?=
 =?utf-8?B?dkZ2cFV0YkN1ano1amxMbXlEc2labmIva1R1aExjc256K0lkUVdPcjNTS3cz?=
 =?utf-8?B?Y2R4cVBGZHV1ZHFsTkI1SHBkeVpXTGN0RmtjRjlVT09PYXlRWFJEaWR4dys1?=
 =?utf-8?B?QXl4ZDRhalJpdXM0SWduekRhZ0lOVE0vRy9uSmQxODd4STNNeXpuUVZvWGxG?=
 =?utf-8?B?TkZTR0hJa3lmb2dnODVpUENIT2FaSVFycXpCeHlEdlRFV2FHR1FyYndCVE05?=
 =?utf-8?B?dDUrU25yY2tDeXZ6MTdGU0ppVXVGWVA1YlovaFRUdVB1RFJCSmFQK25xRi9S?=
 =?utf-8?B?VFZLek9RNHJzRjFDbGltWU9BMVJqTFU1RUcwNTFFTndka1Q1dWZJRi9lTlZJ?=
 =?utf-8?B?bzJheFF0clNZcWx5YjN3Tk9obENEVVp6Qk9FTWZFQkhYVFF5L1JmMDV6bGV5?=
 =?utf-8?B?MG1WM1NEWFhTRDR5T0tVdExWVHg3N2h1eDcvbWovaHJxd0ZUYnFUR08rMDc4?=
 =?utf-8?B?TGFOMGlQaHk5dVAzM3hrZHdsNy9IbHB6d2FKY3ZpNDFXdndVeHFjQVVETjVp?=
 =?utf-8?B?QStxUTBvQ2d4VDk1aXpwMnhZQlZFVWFZTmtsM3EyemZLcW5MOHVmSXJldXZP?=
 =?utf-8?B?c044d2FjNlhNN2I3UzJ3U0VNUURlMmcrZVFESXV2VS9LL3JVeFA1d210cTFk?=
 =?utf-8?B?K1JkOWM5S0xwdTNQU3gyRDVwSyt5L3hEK05LVm5GM3dmN3h2RE9EWjB5dThT?=
 =?utf-8?B?aXlqZVJxWHFDK0NycHByb0FaYnBRRWIwQ2hjb2FFVy8rb3hsQWxEbVh0cVEy?=
 =?utf-8?B?WGJpc1hZV1VoVGhNVjJCZlk1dU9BZ3RlNm5DRVJVN1B1azlMemMraFpQNWlG?=
 =?utf-8?B?QVpNMVM3bGNyc1N1aFV5c3FyVTdvOCttenR0RXV5Z3FhaC8xSWpnWDdaSXl2?=
 =?utf-8?B?NXhHK3ZSTnY0S2RrZDFHLzMrRDNtR2xwUSsySERLMHlNZkkvZ0pQNUhYMmh1?=
 =?utf-8?B?TGxZUS9EQWJxOXBCOFM5UEUzTFdoY3JrNCs5VVN0U2p4MitpenZxejdzV3Za?=
 =?utf-8?B?Z0piSG9xakdOc2t1TENldWVpSjBQeXV6TWt3b3Zpclh1YmlwbmxPRWtCakNV?=
 =?utf-8?B?c1BkNzVrK0YzUDh1N0tHNzhvaXFqMmhHcThWbVZMNWlrZWpIY045L05zcnUx?=
 =?utf-8?B?Z1ZiZkE0U2dqNnFFaTJONisrWEowRVJqem85NCtRZS8waEFObmZucTU5bnBH?=
 =?utf-8?B?V2x3TXJoRUU0bDlOQVdUSHpob2gvN203VE9wRS81alU5SXZHWFgwVE04QWMz?=
 =?utf-8?B?RzN1bUZYZ0JGUUVqM0xhL09CSXFLQ2NRQUFVUU8yZ0ZqQ1hHNEp2VStGSStt?=
 =?utf-8?B?b2F6WEVrTnlONU9BamJZVVlGVGl2T2pjaVAvMnFYY0FmYldxRnBzMVBDaVZY?=
 =?utf-8?B?K0REVFJJNHE4Uzl0ZHEyTUozUzRkN3lzR0VaS09kN2paWFBIQkQ0aHFNYUVk?=
 =?utf-8?B?OWtRL0JoVmlXTGpsUTMyQllETWdDNElodmYyZS9iREhzaHNndHlzSFBKaUN6?=
 =?utf-8?B?ZzlXOG9sRDhTK3kzTnZMWkxtVzdYK2dLc2lBUTJOMlJiRnJRbnFQN0NCekln?=
 =?utf-8?B?dlc3YkcwclRhbmJnNWdldHlsTkw2R240R1JmQ3ZoU0dsOXA3UXdwSVl2bXZZ?=
 =?utf-8?B?VS8rMjM5OEhwM1I2V0VqczR3Y3hoMWc4UHk5eHFrM2p4dy9FQ1l4cEtzUW9u?=
 =?utf-8?B?TlVpTENremJsK2lhN0d6UVYwQ1BjTEFLQVRSNkZ5SEJOT3M3SkIyd3ltc2Ey?=
 =?utf-8?Q?knJ9J9tcEX/Q/wQH6GTkVbo1dFCWfSS6EuX/4lVJCaUa3?=
x-ms-exchange-antispam-messagedata-1: Rjd1M+fZvi0gBQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vzl38hQfunfvSpQPN0jrClt9wDWg44Z3ygoLuqaWghHt6DGdmyvPHosSBn76UBDC38zFr1Vknrj8SJS1RomEeHYKjdPmIMG23671Ayfl6Pvo230DZaQXCrH4ztGt6jR48Z3uu3Lqa+puZYtOMoNy5mEAI/YHz2cZKBZDM/bVTSahxks5DL13uW5vDicWAHF7MTUqWOL9CQ0LWliiL3fm4r4JApfIDbu36/4bDbyRrxA0r4XzIxdAZ8neDioQjV8/TIWkUfHurR69UvYkA2ePYzAerbsx3HWRGI1YCKp8qj7lbq0Tp9Wzq788BCDZakhMBAIwFj7IQXNFlX+uITpM8Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgMqY59OK7ubFPweQg7eZsXXykmD58NhyZFCDFqm4h4=;
 b=EE+g6oUgTqMVcIvn6rsu8q1/9gEogRMfj+DR4etKWbbnbsuwr51n3BySXnEgUwNTBfff3W8hAv25eDfK4M1dMAFTeo87G+takyUz5+XrnfLFpNDGdG0mQ/PvFhQku5QiG9oQJruc+iQeFdW/bBL7QGOa9oiJhMLEA9HmWgIYnmguuuV3Aw5YrWAQK7xfjyx0ZBZ4qPlpHem7sIwVVDDBVpKpCt1EHXO0ZvCIqXW7Qm3yE9tqN1ckBPOaTJQ2h2hBJ8NLysTYJjGfZ/uwsROKfUWrLRdNxGfz1WHlOnL3+rikPmicUCizolqjKUtmFGc19+kiD91vR+Y0QqPx4B+lDA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: hL5c2+fOfsAY9rnHSYVDs7sXXANnObRuiuy7dOVFtQiqhi6NePdRXLAdZKRSDcVY71T17WHK1Fvsn96nTpsQxW9MWy+Go2XzrrUlkoMOMqxet1iXKdCto/bkAeN746nx5fl6SI63Wia/r+VWXGgbsQ3QLIIRntr3XOMAyZgwfF5UikMXZpVg4XrRPaBTx2MZO1rU6bL5P9ZiDIfhaXmDEEGdVoZzndy6pFK+ArCewOkuqtuW7qLv4deMJFSoqr9eaUhVUIa37vjou2AnzyXzuQt8JSPmoL1V2mQHeSyGWV7oBBgHrrDTKGt3P3VMqiAqg7+Dnfv7WJo8XaCTRAoreA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a8e61f78-2f0e-4f95-c1f5-08de9ef9ab9d
x-ms-exchange-crosstenant-originalarrivaltime: 20 Apr 2026 16:27:09.6152 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: TWuSaRQ9gRcV+SIGUm4qqAUKjVb5AWEbxZwXxrYW4st9hWyI7HE0/52iiVIG98YwfkM9mxwfTpYhMJyxcpXZ2g==
x-ms-exchange-transport-crosstenantheadersstamped: DM6PR17MB4152
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C2A5829F27C9E4AAE3147A41FC2215A@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=639 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1OSBTYWx0ZWRfX1FY2VRg5DMfq
 3KWk8JewpGvtSSrJgl61tsaxc4xcEfWlPDuQ9pRQGCq0Lk5+W5ENZCO7tZcCKoGGkHfBBGG10xD
 kiuDmXPbNhXbn6UDjUHDesEqF9UK4Xu4jhcterifahI5WZWeOwb8WwS39F/Ub3NupkDOFk3gqat
 KL79fgl15MdBQPGNezhWiAPTXxC8aJ0AHLKLlMQMMn0zF9B0we/WxxEL+QeO2zLONgmC6WdWFJE
 cKrvJEkUm3wW6h9qovjU+E8tANQ5eQN1jnlXCiVF+jIJK7FaoOrs/d4l+Kutc3iVbKXCQ5fWkwp
 VUC+tFrd9MEkUkQVF0XA7C+r9CYGhThRro7XJ9bUCQZ7bRaTRj7qWFZ5lWxguyC4OmoEXHS+aI4
 9zPirK3f+6d68YYtRtErmJPj8IZQgjiduDK5OQRmZERv0MHja/nKvqX7KF0Lk7Yfb9GRA3Ldtu6
 AEnwJL8RHqPR4jQldKA==
X-Proofpoint-ORIG-GUID: aw0jpB1lhVrjCbxHzrYNL0KsNgR2AZ8b
X-Authority-Analysis: v=2.4 cv=WN5PmHsR c=1 sm=1 tr=0 ts=69e653e1 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=6R7veym_AAAA:8 a=X7Ea-ya5AAAA:8
 a=-WHWfsiIMl2oK7jVtBkA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: aw0jpB1lhVrjCbxHzrYNL0KsNgR2AZ8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200159
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
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

DQrvu79PbiAzLzE4LzI2LCA3OjMyIEFNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSIg
PHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10ZWFt
LnJ1Pj4gd3JvdGU6DQoNCj4gQWRkIGNoZWNrIGZvciBxdWV1ZXMgcGFyYW1ldGVyIHRvIGJlIG5v
bi16ZXJvLCBhbmQgZm9yIGZkL2Zkcw0KPiBwYXJhbWV0ZXJzIHRvIGJlIG5vbi1lbXB0eS4NCj4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnU+Pg0K
DQpSZXZpZXdlZC1ieTogQmVuIENoYW5leSA8YmNoYW5leUBha2FtYWkuY29tPg0KDQo=

