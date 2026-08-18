Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89226C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwB7D-0002D0-J0; Tue, 18 Aug 2026 00:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=683e62043=Alistair.Francis@wdc.com>)
 id 1wwB78-0002CX-FN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 00:07:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=683e62043=Alistair.Francis@wdc.com>)
 id 1wwB76-0004w0-Bx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 00:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787026068; x=1818562068;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pRLKH8eC/CE4lpXluDpeWmnUCQXMeaIH93MGchRkTiU=;
 b=CYvwV8v4QnSs6b4NUIyxUPYkX2F78Qa+2t4XB15a/MxIVB4Dw6WkH+v7
 lt5qhGsxjV8XXPMEWlwvWU4z6Pbf5ENraTmnaF7jAFwcl3ZLGJA7oBUrR
 IHDwxfwNBtLOKh+pi4mjwA60AHgVBj2VuDdaJTlw+bmMWMNoU/5Usl7FE
 gwzroU9gyhbiViHID9+IyoFakfTogJx2s0TysktAn4nSYcYpSVBLeirb5
 LbIvmfYltv5vpUGHwTM3sxep+3sjKiHFzvK0lNzv2TgGClL8dDW0b5Sh/
 CWZy2iVvcaa7nvx0fLJAkNkaZVRylw4Mr7QL8ViAOQYNcYfs1CBfb8d+n Q==;
X-CSE-ConnectionGUID: R3WZ1fknSRyhQYXLmL29SA==
X-CSE-MsgGUID: WeQr7DF7QeapEoS5JfHY6A==
X-IronPort-AV: E=Sophos;i="6.25,230,1779120000"; d="scan'208";a="154356499"
Received: from mail-westus2azon11012038.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.38])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Aug 2026 12:07:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVCN/lY+7n6UJSDiM/xWIdzB+O1co1y5So1HQlyMjU0gf0p1LaqCyAE0/LKz66uSVbPIfNg2r6emcxaurLZTPL7JXsjYXMMbZYkycKV2kM0XzCis+dgAc6plYEhLhrFlfeCWBLwk+pmOOqn8Gj0LNqxXY5uvvl84I9EeqQqSoRJbIMw9aI+bKT4ZbPjAO40w/obo3GlnR3w8jm2knrP19qscPz2TupKQxdX6Ch2wf1An6xXmGEZVAdEUIjOqODCnvNIfho2hxXMRLrxKu+UctZdAnk84ron2mh9kbKczA0BC4I9ung8hq3KCrBYZuVWnVvQI18mbFVvSTFH4mqZKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRLKH8eC/CE4lpXluDpeWmnUCQXMeaIH93MGchRkTiU=;
 b=B7bUsKdkSHOeiIaQkHWeIwT3STT5zrab3OkzK2sxQ4Migbg9c99RwmdTQvZgnId9KXZeXDqlrqmmakdjFzSEGx5bSt14ze9KOCu8GBws9HyIiFXuVaqQSU7TozMvP6N2VA24Aci9LOWwkgR2H3+YL2jQiUPZf7rJm4QyBLHfFz7Yo6UTMXloH5sAz374fKgMJzdVpkaz+0yC7CipLkOdiT06IC2mLRn2Sj9B4iuzDbKlBaxLzC/fzENrlCBylciCXxvqwbIOHLJpiLqWAOIAPhcs3tizYV9ta7BEB2P/OJF+cf2d1lrQr8m22ahsZ9Zz3pDu0OwCWoyabKxJ1G3HXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRLKH8eC/CE4lpXluDpeWmnUCQXMeaIH93MGchRkTiU=;
 b=mLy4NdKAgv3pwYxWc7YCX07Wiu39aEP4vuRqEtkSF8UG+yWUiF8R3Mgl7aDVj8QgV3T4KSAEjxHoW9skctqZx2pfjkfzo5s2833uDwNSAmhiDPaDc86kESGcPQniO0+bzfoz3G6E9DBPiCKr/Uibyf73yC1DIodICAxcNXT+WG8=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by BY5PR04MB6598.namprd04.prod.outlook.com (2603:10b6:a03:1db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 04:07:40 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 04:07:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "tangtao1634@phytium.com.cn" <tangtao1634@phytium.com.cn>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@mailo.com"
 <philmd@mailo.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "armbru@redhat.com" <armbru@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, "michael.roth@amd.com"
 <michael.roth@amd.com>
Subject: Re: [PATCH v2 40/53] spdm-socket: convert SpdmTransportType to QAPI
 enum
Thread-Topic: [PATCH v2 40/53] spdm-socket: convert SpdmTransportType to QAPI
 enum
Thread-Index: AQHdLV4SAq6rwbPyW0uxjPVHuH2mfrajM3oA
Date: Tue, 18 Aug 2026 04:07:39 +0000
Message-ID: <7aae3f31e9d4eb21c32fc6da8ba8cd88e9da0474.camel@wdc.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-40-cc9396b9c18c@redhat.com>
 <627091e1-a307-4afe-aa3f-15593478c5a7@oss.qualcomm.com>
In-Reply-To: <627091e1-a307-4afe-aa3f-15593478c5a7@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|BY5PR04MB6598:EE_
x-ms-office365-filtering-correlation-id: 503cf003-2ea5-442b-7dae-08defcde3ec2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|376014|23010399003|7416014|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: c9Wfqx1nl1busrCgargjS3kTh4jWehR3Ah1B67nY+bC9kyAgcPnA+C7zSucEm+oMk3BnDpBwUhA95l8t0Z0uC7o6+ocREnYHVD+lhbbQbfzKsL7bZyKiLleudvpvKleiSfoJVSTfnHgh8Z0InJLg/ENjNMp7zTlZDjQV8iwST3BZmJNgPhVN0FiEutGTaEfsC7kh9RhtmDlxjnIvke7yN9urC05IxC6oLdNegAMyvYmMl+4SX/pnyAsor4VJGoZJ7vpinGwABMhS9wfVSneyN6t6Vriqc3zvomCk506ejsS3UMEfBbpbws/Ro7gAOZyPzfgNN5Ztklk1godaMSHNZWQPvWaCTXEYol0NXAVDq9NY8xq0npZAhItKMvwVNUd4vlSDTzwdBLQnkNbBVceqPM/hCkF/AVaaDOv08H7UQ4fRfjCQSfGvU9/CXxJ4QSpteWstQ80/pgAiIx3LD8WmXGPez/boAzBQBAtKArorhYWUIN4uEsaK7o4Djybi31E2ERL5R+K+lbhX7lqd1xP1+lc1S714++z60GKMyuyN5KhyRqv8iH9lds/tFIUw8ZdVAk3YQm87WdCEeCMySlFarYC8MS0qWXkxf6E+t9khg/as40wo5RkaJFltbT1hTnOH+8fNRG5vBzQR9JLrl5/K8lju2RsZGWsJsfE9gyv/uLH3i060/5+8EJdf8nsSd7VWDmwA8+OA00U9IXFB+tDe7lQYjihd1EonITWA2xZW/4g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXl5NnljODJHK2VJV3hjTDRtcVhOMVdITm5LMm1oYTk3VXV2VklVb1VnSHNY?=
 =?utf-8?B?cE84bmxsQS9zTXI4ZjRnWWtzdjNyb2N5d1RSOXNZKzdlSXVORVkzbWFNT05w?=
 =?utf-8?B?V012c0NYSXhpK0FmOGpRZkE1d0VhTUpQeTZJNHJWa0dBQitzZGk1SVV4bDM1?=
 =?utf-8?B?SjQ0dmRicys4eVE0Y1Blc0Z4Q3pyOTdWWmRhenhEbU90bzErbmVTeWNIU0My?=
 =?utf-8?B?UGM3aGVackpXT0hsSE5oZjZreDlpUjVFU0RDbnZ1TjhvMnp1MlZBNC8rc1JZ?=
 =?utf-8?B?N3U4bThiM0VGUmh1UkZGbWRlWEI3eFJhUkZMckVsRWk3bFVPalZHVGM1clFJ?=
 =?utf-8?B?NHJqcmZmVDRWOVBhdmljZWI1T2tRQ2JsMEF6V3FMMk5nOFF0T3d6QklCWjM4?=
 =?utf-8?B?QTJtS0FHUmpNTmNXM2k4VzdWclpEb0ZiZGhncHRrdWJFMzlZYTZmWmlpam9I?=
 =?utf-8?B?cTNvd0kvMzlRUStYeklRdGNrTEdtdlhtUVhTL01nNzV6WlRaM0tITXgwRmE5?=
 =?utf-8?B?NVNUNFVTWFROWWJ0ZStHZWxNVk1iaUJNeWl3YnNxOHFhZ2RDUkthdCs0MlpU?=
 =?utf-8?B?Q3BiejhvOU91aEVqV1Y2MFJZa0c2Z1JCTmRkU1cra2FMd0lFUU5JZ05yOFYw?=
 =?utf-8?B?ZmhqWFlWVFJLTHlzRHh2SGIxWVYzSStrZWR4Y3dTKzNDNlNzdzFJTzNaOGcy?=
 =?utf-8?B?WHljVkRWaXB6Tzg0V25qWElGWVJ2OVE5em95ZC9POUNOOHVGQU9oYnFidGVh?=
 =?utf-8?B?NzE2UHU3VzlJR3QrTWNQMm51N0h3aDdHM3E1NFVuSFRIbEtuWDFsK1gxK1VI?=
 =?utf-8?B?SXZJckd0MVVZK1Vmb3FWNzB6emRUemFJaGJZK05XT1VlSGdHTmVHODkrSVFj?=
 =?utf-8?B?RGoxMjhCZ21XWkJvSDAzYkR0QjFrTnM0dWZES25VQnlQVFAxbjhjakZOcGF6?=
 =?utf-8?B?V2ZuWk00ekI0QTZ1djFFZGc4YzlHTVlCN3RRcVE4eUE3ejQ3Q3RKcDV4Mk81?=
 =?utf-8?B?d0lLOXhJR09hcDBWTjYvcDg3cHpUanZvVlptRmhHV2JyemlZdkx5blB6Mnli?=
 =?utf-8?B?dW0xZTFxcGtodlNqcmNQSWg5SnJzdnNWSjBrRGIvSFMwZklzSTBEbUwycWtF?=
 =?utf-8?B?YlVoTHQ4bDRId2ZyM3lRdjFxRG9XV1BBSm9rTU1yVlFCalc0S3E1cmZOSkRE?=
 =?utf-8?B?K21ZTEU0UWJUSVFPU3BrVEIyeTVDTG9VNjhLTjlzMzBYZmhMSm1jK0Z5aDVy?=
 =?utf-8?B?VW9zaVlsSUhaNG5uZmZ5d3lqclVFR0NnQWhrZWl2WUFudG0xVHNiY0dSUWFm?=
 =?utf-8?B?VkJvNkpmbXFnWEs0bUhFOENSSkYrUWNmUXIwZDdTNUFucnlvYmw1b3lZVWRU?=
 =?utf-8?B?Mm1QYnVHVWY1NHJuV1ZxRmRJYXNmTnRTOTBiZ1gvazZkeFNnLzRPZi9HaHdq?=
 =?utf-8?B?VS9DTERBc1hzT2RkOGRUd2hmM1l1eGtYWHNZRlNCQ1Foek9KS0d3MUNDdmk4?=
 =?utf-8?B?VmxwTHFzRVlwZ0wrOXE5cFBCV2FvOEpERzZHUE96N1luKzJkdERhYXJEUTNt?=
 =?utf-8?B?M2RyRlFzRkErT1JMOVpLRGJ4aStDTkE2OThHb1B5VDJOVC9uaFNWaUR0eDdE?=
 =?utf-8?B?WG82KzcxNkRNMDdhWDFQYkNLZjAzV1JYTy84OExjVEFCK3hBb1NTc2RYUTBa?=
 =?utf-8?B?Nk5GNzVCdnlqOFM1ZUVoMmdKQzlpbHdqTWRCTUtLTTlBK29vU0pjWTRWMHhC?=
 =?utf-8?B?WStVTVVjWkQ5bng5WGNrRUt5bUxOMXBjVTBKWjdOTnU4dXlLK2Nlc0wwSlpJ?=
 =?utf-8?B?U2s2aVpIdzJ4UlltNklEZnJqRHhxamUrQ3ZJOURqWlYwMlNpaE1KZUdlR1Er?=
 =?utf-8?B?L0VEWm5jc01TZ084MCswV3NOT0hYRE9uYmpSYThZNS85ZWg1U2hYaEVFbEs1?=
 =?utf-8?B?VjJud0ZWSlJneW15ZlhrZ0hnT1gzYTNhOEo2d2lwb1VodzlJTzdkVlFHbnRv?=
 =?utf-8?B?UkJCb3FlTzMxbWtWT29XRmNOaXh4cDc5KytvYkhsbmFyODVIbWhGek81bTd0?=
 =?utf-8?B?eGUwLzdjekR1WXpUMmlQU200SVk4eW1Yc0VpYThqb2NMUUNoWFh1clg4eUZv?=
 =?utf-8?B?WHc5SmpMMkhsZkZFdk5RYnkydkk2aU9zSnNQa1NxRTVKbWU4b3pjVHVCQ0ZJ?=
 =?utf-8?B?djU2WkNHTGV1aG9zeHVvV1dxT0VYL0tJcTZicXBpQXIvNUxQMTBZSFM0UUp0?=
 =?utf-8?B?Y0VvYkI5bXFFeDV4b0szNDcvMGZCZ0xaWWJjRVpkMVJhNWpiZmdnWlQ3dk83?=
 =?utf-8?B?cEFxZGRGV1pFWlFtSjhlSDZldjZFUGhaclB1eUlMKy9hOVorSW1rOEREaWYz?=
 =?utf-8?Q?s4gRZ9jt1O7iJP2XtbMIkVsgidcEMCIOvnHPM4BLQFEJw?=
x-ms-exchange-antispam-messagedata-1: krUSz5jx473oo5PDqzUhDZyDIci9CuSf9ow=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA3C9957EAB16F4DBB78AAFFEC96F2B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VDU3Aj1YKjpfkTpDa7lR6zCN9IVO+W+6DNBiGdUZAxtXMjyf6n7pwpqXGFiji4rDvyaVQI6452FND9lOYARM1jpiAW1wMCKMYQfFe5MTZGdZvt4tk02Oo4FpIIfAK6BTkokClujRkrvjvA3ft70wBlDMJLXfzHfSDXHhG+JrfOUwMdS5lpkvN1+JXGA42NIkOcDethMPo0moMbaDZAf2LLWq2j2aOUqM7/Nk2IQHBIIvMppfEIyAC8mSUjcVyskPpu8AdH5IsovaDIcM5hQKIFfYu10hpQVKdKmp4i36IUshLZJu8GQdHz0Jc3ctKcR+j1AB8C4g8XZ0YaHNEYXzcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8uFSMsvYxCAQNjJ9rf72SF689Lx2EfW3uRNlTgny2bZ5JqLJockeVuk+8KaGgO7XyMQ4/cYBkDdtQL468kET1xth+hugUZWNwdaKzUGDBjn3hotla4tEhahlPErSNMGT8VOBCkxQY91xl/Lk4vPtV7B27DK7gSqhVZkjPA8urG/PSDGXMbzGyjpfyX1PlVag7AHYH1U/5K5PLnEwzxqwowFoEwU8ci199etU7HClcTltbwYrjE6lx0VLaVwY1y0SsWpXA+DrDl3KbTG/giTT/qD8exlDwtpo4XftETEdUfJ0gXxu6Ho+vKHIeaLR6gvXSiRAD6BY3G8Fpi6oqKeHdOrRkr9r6VpXrsSbEUexzOFP8Ngyhvegvo+7NJOUcjkL9OXGmTjXxgAAeRzYn8xZklO2L/0R2pl8mIrialBwe8ERwXVHPLYelmXnbg6puEw/InoEYIGdxvAPqrh0ODk3BuvmgDHtJ+A1hJFGkNoBEUIcaKF3ZzWRPG5XC5LeWY+RFBuusbPbF2zHn4R1logjPYovPb4Z78mtYiEGgi7BWTbu7JqfoBG4XnE8Exyvr/wmSvjlQDa8DIGciok/7M4O8hHkUOMjsf69bpxlbKjKpDlQXviDDWIi/yn0SmZjzJ7k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503cf003-2ea5-442b-7dae-08defcde3ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 04:07:39.8437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avrEqX9jahr7NPx7FqHxnDvPaI8dDjHORcWYEZYIQ3IsmxbWB8X+E+r/DJs1CQw3FodFzA7IlM9n/GO7r0nvEzPE7P3abNXzN1W3IBCdAl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6598
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=683e62043=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA4LTE2IGF0IDExOjAzICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gT24gMTUvNi8yNiAyMjozOCwgTWFyYy1BbmRyw4PCqSBMdXJlYXUgd3JvdGU6
DQo+ID4gUmVwbGFjZSB0aGUgaGFuZC13cml0dGVuIFNwZG1UcmFuc3BvcnRUeXBlIEMgZW51bSBh
bmQgUUVudW1Mb29rdXANCj4gPiB0YWJsZSB3aXRoIGEgUUFQSSBzY2hlbWEgZGVmaW5pdGlvbiBp
biBxYXBpL3NvY2tldHMuanNvbi4gVXBkYXRlDQo+ID4gYWxsIHVzZXJzIGluIGh3L252bWUvY3Ry
bC5jIHRvIHVzZSB0aGUgUUFQSS1nZW5lcmF0ZWQgZW51bQ0KPiA+IGNvbnN0YW50cw0KPiA+IChT
UERNX1RSQU5TUE9SVF9UWVBFXyogaW5zdGVhZCBvZiBTUERNX1NPQ0tFVF9UUkFOU1BPUlRfVFlQ
RV8qKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMg
PGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiA+IC0tLQ0KPiA+IMKg
IHFhcGkvc29ja2V0cy5qc29uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKysr
KysrKysrKysrDQo+ID4gwqAgaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCB8IDI4ICsrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoCBiYWNrZW5kcy9zcGRtLXNvY2tldC5jwqDC
oMKgwqDCoMKgIHwgMjMgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoCBody9udm1lL2N0
cmwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiA+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgNDYgZGVs
ZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3FhcGkvc29ja2V0cy5qc29uIGIvcWFw
aS9zb2NrZXRzLmpzb24NCj4gPiBpbmRleCA0NzNiZTJhYzU4YS4uZGJiNDUyY2ZiNzIgMTAwNjQ0
DQo+ID4gLS0tIGEvcWFwaS9zb2NrZXRzLmpzb24NCj4gPiArKysgYi9xYXBpL3NvY2tldHMuanNv
bg0KPiA+IEBAIC0yNTIsMyArMjUyLDIzIEBADQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJ3VuaXgnOiAnVW5peFNvY2tldEFkZHJlc3MnLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICd2c29jayc6ICdWc29ja1NvY2tldEFkZHJlc3MnLA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICdmZCc6ICdGZFNvY2tldEFkZHJlc3MnIH0gfQ0KPiA+ICsNCj4gPiArIyMN
Cj4gPiArIyBAU3BkbVRyYW5zcG9ydFR5cGU6DQo+ID4gKyMNCj4gPiArIyBTUERNIHRyYW5zcG9y
dCB0eXBlDQo+ID4gKyMNCj4gPiArIyBAdW5zcGVjaWZpZWQ6IFVuc3BlY2lmaWVkIHRyYW5zcG9y
dA0KPiA+ICsjDQo+ID4gKyMgQG1jdHA6IE1DVFAgdHJhbnNwb3J0DQo+ID4gKyMNCj4gPiArIyBA
ZG9lOiBQQ0kgRGF0YSBPYmplY3QgRXhjaGFuZ2UgKERPRSkgdHJhbnNwb3J0DQo+ID4gKyMNCj4g
PiArIyBAc2NzaTogU0NTSSB0cmFuc3BvcnQNCj4gPiArIw0KPiA+ICsjIEBudm1lOiBOVk1lIHRy
YW5zcG9ydA0KPiA+ICsjDQo+ID4gKyMgU2luY2U6IDExLjENCj4gPiArIyMNCj4gPiAreyAnZW51
bSc6ICdTcGRtVHJhbnNwb3J0VHlwZScsDQo+ID4gK8KgICdkYXRhJzogWyAndW5zcGVjaWZpZWQn
LCAnbWN0cCcsICdkb2UnLCAnc2NzaScsICdudm1lJyBdIH0NCj4gDQo+IFRoZSBjaGFuZ2UgaXMg
Y29ycmVjdCwgc286DQo+IA0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPg0KPiANCj4gQnV0IEkgYmVsaWV2ZSBTUERNX1NPQ0tF
VF9UUkFOU1BPUlRfVFlQRV9VTlNQRUMgd2FzIGEgbWlzdGFrZQ0KPiBhbmQgc2hvdWxkbid0IGJl
IGluY2x1ZGVkLiBOb3Qgc3VyZSBpZiB3b3J0aCBhIGRpc3RpbmN0IHBhdGNoDQo+IG9yIG1lbnRp
b24gaGVyZS4NCj4gDQo+IChDYydpbmcgU1BETSBtYWludGFpbmVycyB0byBnZXQgY29uZmlybWF0
aW9uKQ0KDQpJdCdzIGluY2x1ZGVkIHRvIG1hdGNoIHRoZSBlbnVtcyBmcm9tIHRoZSBvcmlnaW5h
bCBzcGRtLWVtdToNCg0KaHR0cHM6Ly9naXRodWIuY29tL0RNVEYvc3BkbS1lbXUvYmxvYi82NGNm
OTk5ZTgwMzdiZDNlMGZhOTVmNjkzMzJmZjRjMWQyNzdmNzA1L3NwZG1fZW11L3NwZG1fZW11X2Nv
bW1vbi9jb21tYW5kLmgjTDI5DQoNClNvIEkgdGhpbmsgaXQgc2hvdWxkIHN0YXkNCg0KQWxpc3Rh
aXINCg0K

