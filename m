Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A29FE7DEF7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmw4g-0003dv-NZ; Mon, 02 Feb 2026 10:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vmw4e-0003dR-QI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:42:48 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vmw4b-00060f-U2
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:42:48 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 61260EZ81496779; Mon, 2 Feb 2026 15:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=HjboaNb0VTgCg3d5lO9aQp2gIjo9PFhGWQ4daWA8C3M=; b=
 NQPm1QyuRGB1QtvhvVpeSG8zT15MqobQouAz4C1Xtg5k1q8vO+0Z8xNXJpd+pG84
 QbWYHMSG2paOb9IjGswiF2Xj9+A0CbC5j+cJjt80fc32a+sAawVOuI3IDhi/pWgP
 KFtZXEILLCh7wOHAXYzspXyY0PedDoPFkf+jDiowRUc/ipb4FoNFXQYUYYJFb/Pz
 xnwPcjVpfGoBcTgELASdASsLCdeptMnDKEtdcLYvbj3pR+hU/H/K9HdFAiiSkAK1
 P5OR/4SwQArdDbHwJb3J1JSQTaCR8s7VXKsTDQHYIOl9p2grNdPdeF3JRD6pD5MM
 mnp5foOQWozlcGUOh23WjA==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4c1uxqxk1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 15:42:41 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 612FLJnu000974; Mon, 2 Feb 2026 10:42:40 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4c1dy2xpxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 10:42:40 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 07:42:40 -0800
Received: from CO1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 2 Feb 2026 07:42:40 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SA1PR17MB5139.namprd17.prod.outlook.com (2603:10b6:806:1c2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:42:36 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:42:36 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Stefan Weil" <sw@weilnetz.de>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Thread-Topic: [PATCH v4 0/8] Live update: tap and vhost
Thread-Index: AQHckJZEtI/bI5eMI02lYSB4PqSw1LVpLZKAgAZLnID//8bugA==
Date: Mon, 2 Feb 2026 15:42:35 +0000
Message-ID: <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local>
In-Reply-To: <aYCvexnciB7THTkr@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SA1PR17MB5139:EE_
x-ms-office365-filtering-correlation-id: ae8b977d-c251-4a69-a5fe-08de6271b033
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Z01EeEtRY1IwS21qdWE5c3NXcnNsU1hFMk82WTRuUzRha1REUDhtUmVDZ0pO?=
 =?utf-8?B?YTl3a01QQ3dmeUhMTTVCYUZVYVJvb282Y2Exa3RJZHNINVZjd3pDelVHbjBh?=
 =?utf-8?B?Nkx3M2FKY3lHdnZZSU16K09vL0NXdUdid1dXdXh6RlJJalA1VTdEbVpuUFhE?=
 =?utf-8?B?dVhSTHBqQ3RPSStpc1ozUFV1U012a25kR3hsWEE2RXVkeVBMajFNcXpOa2tw?=
 =?utf-8?B?SHF2RlpSUmJtbHd6WERrOFBCaXo5TzM2VWMrQXE5VTRYR09acjVMK0x0Vmcx?=
 =?utf-8?B?WTdXVzFhZGhLcHp1RFZFeEdoSVA5UTlYTmF4L3M4TjI4aklYa3gzMWhmNzlj?=
 =?utf-8?B?UHcvRVF6dU9RbjNva3ZZZ0pwemNSNThFbllncGdOdnFOZzg1amtUdDlNKzdl?=
 =?utf-8?B?c0draFJQcVJaNHlFekxSVjY3QWFsa2xyUFBRcWE5NVY1RzUwaHhoT2p1VDB0?=
 =?utf-8?B?SWNLNmg0eXRORGtqY3pJTTkrWGJST1NRNmUxaG1oMXJHQmkzMVhzYXpVV3Y3?=
 =?utf-8?B?R0VWQ1NRTmx0WVdJb3NCWEY2ekdWUXgySDZCLzJjUGU1aW9wOVlKTURoYVRo?=
 =?utf-8?B?bHdoSDNmNmhZNDNiNFAyVzJFN1Nqd0xMYkI4L0gwa0Q3ZkNkVDc3MzdIREo5?=
 =?utf-8?B?SVI0UERjYTFzVlBGUlNUZE5KelExZ2owYWxhcUpMdFRpTzFabTgydE80LzU2?=
 =?utf-8?B?U3RCMmVyUUN6Nk1VdGs0K01zRUVEdkZaMmNydWkzUlRTRjUreGtxaUdlb3Iy?=
 =?utf-8?B?Z25oV21TbVNEUzEyTGtFdkFJa0dxTExkZnI3S2h3cU0xbEpRWlVXa1ZCM1Rw?=
 =?utf-8?B?emxqRjZuUlAyRkN4cW1raXIwTGFySlZLcHVwclo2TWQzRGZPbEFMSGV5S3U1?=
 =?utf-8?B?K3ZlazUzS2V3dzA5Qkw2K1pTY3ArS2tMTUsxdHAxS25DR1l0VFVhcmk0QW5U?=
 =?utf-8?B?am85UEhyMXZVVmFaZGRNUjBvRUpxSld2QlR3L1FvTUU1a2N4T1FUZHZkQm5x?=
 =?utf-8?B?Q3Z3SUdOSkNBTmkvUDQ4NklzNUlqcGtjZFg2SHFQRzBhalo2b3FnbzdLL1VO?=
 =?utf-8?B?dWFNeXVhaFVDc09maDJEKzhhRGFUMWJ2N3R6NDFJK2xxbEJYb2hoY1p0VVFa?=
 =?utf-8?B?RG9DZlVjN1FRUitneXhvVWVaMDJwcTBXQmZZWGk4c2pDS0JTVkV0VmNGc0Rn?=
 =?utf-8?B?NHYrR1hiU2hjT1MzcW9ya0t3Sm5XaDhyUzBhSytxWldGaFU4eWUyZUtsQnEw?=
 =?utf-8?B?ZDAwaVVYVXJRZm1hUHZ5blNMT1lEU21yazZYcEtadWxvMklXNmxDK3JYQ08y?=
 =?utf-8?B?MVRSdzM5dHU1VVlBTDVQSGpLaGY3MUV4SzhObmZLTk1kci9aaFpEdXBjUFho?=
 =?utf-8?B?cmtkT3h1a2tPT1Q4M3U0MFFoYU4yeitwcGVLVkJLa0x0U1MxV1BLbjl1cmRq?=
 =?utf-8?B?dGY2V2gzRzlBK1hsZktrVWRPMVRKVE9GUDl0dnZpUGhzYTN6VFFXeVNGdGEx?=
 =?utf-8?B?RFVkQ0g5dkNsWWJmN0tYc01IQXBmUDJ6UHRyMFF6cTIwK1h6eWoySGtQM3NX?=
 =?utf-8?B?R3MwdmNyeDFxUFR4MUlIajlubGgySHZuVFFaenRGZlhxNDd5cTh4ZGl5SUJN?=
 =?utf-8?B?c1dGTDhaaWl0b1QrSlNDUUZhVmdKZnNadlNUM214TmMrblBSeVlhK0lxVjAz?=
 =?utf-8?B?bm9zYXpDMWFNS2xXT2xpdlFEVjlYTWZkMS9kdEk0WjJFdnhwbVJkd1V6NUoy?=
 =?utf-8?B?eDRqWXp6VmQ4NGQwN1hkTXVxaGJDQmFBTTBLMU42UCsrMmpYaXp6UVpzaUVD?=
 =?utf-8?B?MWFheFBldjN4clllL3JjeUNQYWNVemExSXY3SmYxMkR6bmd0aU44QlNmNDN6?=
 =?utf-8?B?elE1NXJ0Tk53eXNlNEh2NWEzQ3hrYUJ5V3ZhUWZTbzJCd0JvelM2a3JYbEF2?=
 =?utf-8?B?bFc3YVQyekFrRmtyQ3NNV0FpVGt5QUZYMURHaHFUSmdmcUtyekNqZXVWTnVZ?=
 =?utf-8?B?VUtXZ2RwcWNFSFcvR0ltVHNKNVUwSS8xc0pjYkRQbEhEd0plaTRTWWplOXJ5?=
 =?utf-8?B?Yk5rcUVra1NUNnpTYWFQeGFIY3ZCWVF0cXZ2M1F3eE03Rmp2R0FQNVE3QlZK?=
 =?utf-8?Q?XnIbLOiX9fj+jl5gdpIG2pvRo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU9oK08rNTMvczQ0UVhVMXQyN2tYMkxIeXYvbVVMS05QTHRjZFd4RGVGekhx?=
 =?utf-8?B?TVo0VUl5d2RERkJQNzZPV091MHJLUUx3SXFPaW5lOVBYVVpkWDBFeFRLZi82?=
 =?utf-8?B?VlUzSVErcU1jSlEzenptdkVRc1U0VDB1YUxmTTlzY09GemtYR08yUU9ENDlQ?=
 =?utf-8?B?K0Q4TEw4S1lSajZIcXdYdE5QVHhZOThKVGFBM29UT0hTcWlzS3g4Z0RwWVhy?=
 =?utf-8?B?dGROYXY2Y2hDUnVRWW1YTDRtcnVLWnJnS01ZbS9tb0xiWlBpdFhTWlF2eW9P?=
 =?utf-8?B?Q0oxcUhSMHlTaHhLRGNJME1UejU1eDZUTHZpRjVDQlFEa1RIbE9qUHBGYjZF?=
 =?utf-8?B?ZFRHcUsrTU1NMXQ0L2hOanl4Wmp4SThlUCttYTdteDlaTzlaRkw3SXd2R0U4?=
 =?utf-8?B?Znc0b0FmUDdITW1paXBjdHI3ZUx0N1dhMHlVWlB1a2dSVFA2NGg0OExaZUJk?=
 =?utf-8?B?cEVOQ3o3Nkh3Q3YyVkdMRVBRK2s4NTRTSFhhb2E3YXBKVzdtMkVKdzR4aUxo?=
 =?utf-8?B?ZFI1TVhPa1RRZ2QrWnFVdlNSYTdpT080WWV2TFN4YzB0Zjg5anVVTFh1UGJh?=
 =?utf-8?B?anlkQUo1Z2RuMnN5ZHRibGpSU0cxVXJxbDNIbG9ENmhwQVhqN0ZnOVAwUlJo?=
 =?utf-8?B?a01IeXppell5cWZ4cERXRWFxOG1LeDh5RHBHalRVWVBNM0RibTQ3UWkrSFN4?=
 =?utf-8?B?endxNGkwaGMvSnZ5NkpQSGhxQVpMNytGa3dxaktscWxiVlp0NFVZZWFScFdE?=
 =?utf-8?B?YWZxTVk4dWlqZGlGNTdNNUFqZnVBZEdvNzFHMGxSV2xQKzkyanhVT0J6eEJx?=
 =?utf-8?B?b2xxdjJjRS9jTmRzanZVZVdpZjRReXoyQ2VVbnZjc3RFOEsyblB1USsyY1Fa?=
 =?utf-8?B?MjRPYWJmSVhMZTFYRWVhWjRYQzNMZTZHbDd0c3pPMkVpSmZpUDF4S0RMRDVk?=
 =?utf-8?B?M2JBTUVtVVQzMEp5VVN3V3NYSjRDZ2RIUkx0SVlRVXFuTGs1SGNOQ3h0ZWZI?=
 =?utf-8?B?akFGWW4xVGY0MzJqRkJub3ZwL1FLamhKZUhCZjJQdURRaWRjdlhzWEkvbEFR?=
 =?utf-8?B?amhUN09MZ09CdXFIU1BnMVZaek5COWRvWHVmWWMyNXRhN3lrNjZkRVIwckZr?=
 =?utf-8?B?V0JJOFN2NUpnZkR2eDR4Mk8zK09HMGcwelg0emFhV25LQTJxMUpPck1PUVhM?=
 =?utf-8?B?cjBzTTI2Sjcrd2JEVmQ3YmlxMDQ1R1JGSWxWeHlOTVVYa1A4L0FRVTRBRG9k?=
 =?utf-8?B?d00rOWFwOHJNd1VmcWl4TmRYdnN5K1JHQ05VdnljMVVScXV3SjJCeXN5QTFn?=
 =?utf-8?B?eWZuUnRzOHhpWFlvMEl3cVVHSGVTd0dzYjY3eW9acDQxMkJCaFdHYVZvaElt?=
 =?utf-8?B?U2taWDJmMk5MazdtNDU4SGM2blFxYXZFMURDdFVNL1NQdWE2UzJJWll4bG0w?=
 =?utf-8?B?eEpFSVdac3ozblk2YklFQ3NCWmcxMW9vdWhyeGFDa1FmclZyb2RZSlozeW9x?=
 =?utf-8?B?c3FKTnBzRVhyNU1BdFIyNE5YNWFZRFhFV1pJM3lDQ0p0aGlOT0JnRGJHRzVM?=
 =?utf-8?B?OE5CVENrZTNzZi94ZGlOK2RTQkpwTWhjKzR5N2RpUXUwL2hsMklQZHpnZ1dW?=
 =?utf-8?B?SkpJc1lnWTVMYjNJUDYwWks5OWZrREl6MWhSanpsUmgyVmRCV2FZSC8ydFIy?=
 =?utf-8?B?Uit4Yk9ueWNMYytGRjE1ZldpNjhnc3pQbEN5T2lwWms4aG9SUFF0OE4rOTky?=
 =?utf-8?B?eFBJQjJ3b1lIcGVMSHV0aFZwYVd2OFJTL25NaHVqTWNEbHh4QkhiTk9Fazk5?=
 =?utf-8?B?MC9NM092YjNUeE5QNS9RaEhSVG1OcGxsUHNybDNIamFrQ21ZU1lMUlY2cm5I?=
 =?utf-8?B?bHU2Q1dDT3R3djJKbW4xL0gvekZJU2lNcnlYR2xmUU1TNGJsTHV0VVB1RHox?=
 =?utf-8?B?R3k3KzU4TGxkMnRrWGZsZUk2NnJiSHBpMVMwemZjNVNoeXF1STEzSkhjVXNo?=
 =?utf-8?B?ZCs3SDcrdDk2WTVGem1IVkdRMW9Nanp2NnRZS1ZQNlEwTjlKT21VZjIvaEZ1?=
 =?utf-8?B?NVBQeCsyLzFKdVRTLzZ6Vm9KRlZDUlJ0Y2xQNU42RUV0czNQQzNoOGlBQVNM?=
 =?utf-8?B?d0FoeGplQjMvUWJZd2RkWGREbWtFSlBFOUtrR1J0V1EyZFdlOTFrOVJJSFA0?=
 =?utf-8?B?WlR5SzVqVG5JNExiZ0tWWVp2ZDZwMWhRSGkrdmRPMEd0Snd3eEtiUWdXWEMv?=
 =?utf-8?B?Qlowd2ViUENPaUlnakJaVzMyRkxFdE45NEluMWQ3THB6SDlXdG5JQkxjbE1x?=
 =?utf-8?B?QjU2dGxVYlRhUjF5N1NkenRvQktrZFNGOC9vSFZkSE15SGdEV2VhMTIxYUdV?=
 =?utf-8?Q?b8mMxdO+BikgO3pCepS8P2DjPuOcXTmt79qSMyWCjoHDh?=
x-ms-exchange-antispam-messagedata-1: 8nOIjhVP4etnjg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY4mggmItI7lic+jp2o0kIqHXseGWkd+mfu3n26POwXLc/Hex3tl1R3FARWhr7QihVf5UvJMoeL7IrdpfhvBdz4WF0qw6AYH7UHVEnVIuFQMqKX2MXFOTA2JcYfw2KK3jH740OfFqLP6B1R3DyB4Vu8q8I7rZuIzu2XL5UXB3JWObB1kFpL/dY+nviKaX22dzr4rBLfsu62pbnisEn1F3Kg5MfdF4Ay09w5JglM6KR9wC6bae8QEFdTINLY7d86PKD7G4Jx5AVvlquYF8fhsmnmTRummw/0JODBnEzJujQu7IkcMJDEoKMVMzuxLG9icISEZIli2ARqGL+nIbjYaRQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++6Pd+5z2NYYKW1E/mkHAWoNFvoziIndYE4ae4New7w=;
 b=RhMyEILSpE2wD233/uNbL/OzdyUHbmYja/r62Vg2AByAJM6LVsMmF9M5G8kczaIwmRo/45d0IvUt1mAwM9CaOibw5+6GKksbI193K+DUFaPhYTFCqZXD2WrWkBT6b8Jn88dw1aupL2iitPc+xzchjU0EFscEGK+d7xl4L3QxCB4qhY7Ca/EBmBaNwlsztvJD+rcby6tGYwauuvs9QMZSFcPH23pDt9uKf+/aEEU8dEYUpYrtG1OG3lV7b/IPhUcc4Ew95uVhm3t3Z/IaGhthGiSK/LxrXIO2IWhqEKphx2q/IeIf05FYhWefhIHvTuC9bnk84/ddAR7P0tu0FsNPxQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++6Pd+5z2NYYKW1E/mkHAWoNFvoziIndYE4ae4New7w=;
 b=m7Dss/YFSGLxsdliDNDtyrMwVFcMJeJmfcc2LU7p+ctMNHjM+7cQrUxkFKmN40xXkYd0dcDi2ZBOU2oYz3ywgpDwZjmczF02gaY43iynUg/rVK90hFtsesdh3WPF3R1qmH64c394Mr+K1FzH4NXMjOUH2DvyNi5vKCkIMFFzTtw=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ae8b977d-c251-4a69-a5fe-08de6271b033
x-ms-exchange-crosstenant-originalarrivaltime: 02 Feb 2026 15:42:36.0168 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ijNpbzCSvvBy2zF66W1hwLCPCb8XAK/fdjEvXubbqdVz8Ck2h3QVRFu0IU74CwtaN2mBfiPo181Cai6WANSYlQ==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB5139
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <14181793C436AD4AA77C99BFD9820F6E@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=763 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602020122
X-Proofpoint-ORIG-GUID: I2Od98WgYBGPxoW839pS0Ew-LZiSaCGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyMyBTYWx0ZWRfX8Uckiq15L/eu
 FjC9BH8Jid208glAgdqCziIX5hv18dA+P7vtunw18GWtl6FhQkfzEI5mFigzi08+nnCHtV0bSEX
 qtWrK9ypIeuia3hRaDMz+CxBC+0G7fkkgrKJEm3H4ExONRGTQkBp5QGG2awQ4wl2TvAF/CJdkVo
 wSpB0SvSuNzBAOnDlaxlGVgcHEqKMe6zI64VglT23g/213tILC3RQAfLSRRPxANO5x/0Qmhok7A
 4dVL8FbcEy43+lNs8FRSYqaQCAypaeYfrEo65LqTMCK4NKVboaaV5Keh0sJV9lrHaTb2jjOcwVl
 ShvkdIk0lZc/ObcoYA/sLf5poFdUhKS59FZCTXe3vSzg0IVWnUSGslxJUuvnKFtdn0+ECcQ9ZRh
 5YnyJO0/EqmiH0ThOt9tVS+NkpMUVeihrO3zW7wnzT1tbO7tIRX8sV6eEZP2oLMXdMBy90HypNT
 k0dEZWiHvOxvJSjRikA==
X-Proofpoint-GUID: I2Od98WgYBGPxoW839pS0Ew-LZiSaCGq
X-Authority-Analysis: v=2.4 cv=DopbOW/+ c=1 sm=1 tr=0 ts=6980c5f1 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=6R7veym_AAAA:8
 a=xmyCnxE4edQpKIv8vEkA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020123
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
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

DQoNCu+7v09uIDIvMi8yNiwgOTowNyBBTSwgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5jb20g
PG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbT4+IHdyb3RlOg0KDQo+ID4gVGhlIGxhdGVzdCB2ZXJz
aW9uIHdhcw0KPiA+DQo+ID4gW1BBVENIIHY5IDAvOF0gdmlydGlvLW5ldDogbGl2ZS1UQVAgbG9j
YWwgbWlncmF0aW9uDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMzAyMDMxMTYuODcwNzQyLTEtdnNlbWVudHNv
dkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOjIwMjUxMDMwMjAzMTE2Ljg3MDc0Mi0xLXZzZW1lbnRz
b3ZAeWFuZGV4LXRlYW0ucnU+L19fOyEhR2p2VHpfdmshVDlhODNmY0ZnTmh2N0RnQUFmRklOYi1G
RTZrblZwNTN0NWM3WGtDclk3NmpBaG1HeFp6NDJZcUhJbFB0LWVWX2hoN1YtT2tzTWVCTXN3JA0K
PiA+DQo+ID4gYW5kIEkgcGxhbiB0byBwb3N0IHYxMCBzb29uLg0KDQoNCj4gWWVzLCB0aGFua3Mg
Zm9yIHJlLXJhaXNpbmcgdGhpcy4gSWYgd2UgaGF2ZSBzaW1pbGFyIGZlYXR1cmVzIGJlaW5nDQo+
IHByb3Bvc2VkLCB3ZSBzaG91bGQgYWx3YXlzIGRpc2N1c3Mgd2hldGhlciB3ZSBzaG91bGQgc3Rp
Y2sgd2l0aCBvbmUgb2YgdGhlbQ0KPiBpZiB0aGF0J2xsIHdvcmsgZm9yIGFsbC4NCg0KDQo+IElJ
VUMgVmxhZGltaXIncyBzb2x1dGlvbiBsb29rcyBpbmRlZWQgc3VwZXJpb3IgaW4gdGhhdCBpdCBo
YXMgbGVzcw0KPiBjb25zdHJhaW50cywgYW5kIGFsc28gd29ya3MgZm9yIENQUiBtb2RlLg0KDQoN
ClRoaXMgd2FzIHByZXZpb3VzbHkgZGlzY3Vzc2VkIGhlcmU6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9lZjdmZDQ3YS1mN2MwLTRiY2EtODIzYy0wNzAwNWM1ZjE5NTlAeWFuZGV4LXRlYW0u
cnUvDQoNCk15IGltcHJlc3Npb24gZnJvbSB0aGF0IGRpc2N1c3Npb24gaXMgdGhhdA0KDQoxLiBW
bGFkaW1pcidzIHNvbHV0aW9uIGhhcyBzb21lIGV4dHJhIGNvbXBsZXhpdHkNCjIuIFdlIGFyZSB0
cnlpbmcgdG8gc3RhbmRhcmRpemUgY3ByIGFzIHRoZSBwcmltYXJ5IG1ldGhvZCBmb3IgbG9jYWwg
bWlncmF0aW9uLA0Kc28gdGhlIGJlbmVmaXQgb2Ygc3VwcG9ydGluZyBub24tY3ByIGxvY2FsIHRy
YW5zZmVycyBpcyBzbGlnaHRseSBkb3VibGUgZWRnZWQNCg0KVGhhdCBzYWlkLCBib3RoIHNvbHV0
aW9ucyBzZWVtIHZhbGlkIGFuZCBWbGFkaW1pciBpcyBkb2luZyBnb29kIHdvcmsgaW4gdGhpcyBh
cmVhLA0Kc28gSSdkIGJlIGhhcHB5IHdpdGggZWl0aGVyIG91dGNvbWUgaW4gdGhpcyBjYXNlLg0K
DQpUaGFua3MsDQogICAgIEJlbg0KDQo=

