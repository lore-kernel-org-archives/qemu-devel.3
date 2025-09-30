Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C84CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vlq-0004kw-0A; Tue, 30 Sep 2025 04:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1v3Vlm-0004kR-CG
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:31:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1v3Vld-0003bR-Bz
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:31:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58U56IZB858992; Tue, 30 Sep 2025 01:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B8FZwmiicFmSSZJ+5sDakiDcyeSsfxgo64L2Fkowz
 B8=; b=jIYfD8Lz5m0hjqGBj09qzPSR4RNjXPxz8+4MepmTBi7zmcKRxcANkaE+F
 VzrTYr17eX3iwyy3ABYYdnspyPwWsnQKBQ28cLhnzAkiX2lf6iaa4YBNyidGAEzm
 2ix4JpsglPtvsCRS+MMISC6opAlI1iPG/qDM2CeVnItPQ3kMFUIjnTTHAYO+KDWS
 OapC/onHqtobFENhflQn99FzA82v3XFLqqJJxGBxdO5OsRAp+seKCbJ8QuKkQ7is
 f1YdNevduBibWjAV3nHkup3o5JcIG2mF2PCNi4Pd/vjH/GLGQeZaBjzHbpfLhrNX
 KjcSpVfblabIaGjSKkUzWYootZ+KQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021082.outbound.protection.outlook.com [52.101.52.82])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49fxj1hptq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 01:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9vunS7UUxJI2T5c8KJ9maE6SIHPbxPPFj1PNUJFb7woSHdhWsC4nEV76L9eKzi92vyBnkdEAVJPXClUvNzdJHojGhF0DcwLG3Ko/goyT30EZev0wpFIwwmBvZeZFljet1K3E2jzpjRAGylpgok+JOl+mQEodw+LJsrce8zru3VfEnAlwA4tXdfBv6S4UBKxHvnr8paQFmEgFC5+Z9cVeu88xHREbnC3sMUGOsC2z1MKTUkKCzKTgZr+C8EwunP1lnoKRlvDNc9cjfC1NvTmDsxpxhGWgVWK94yr+8eSjXmgi6qrpV+/bfYFJJ8g44iV+mJjXq6Zvul3pUYNnccwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8FZwmiicFmSSZJ+5sDakiDcyeSsfxgo64L2FkowzB8=;
 b=RbR0k1E56/0jBvgBIuhmKPEDYh4DCrABjV++JQyPTa7rCg8KFcx6dHY0v2snDAuxku7FwFORI1LfCMkPtk7oZP+S94URVoE8CJQSDP/ZWCQOfLJUbP6GrdbXzCk+rPrM6NkWcBinezRT+1nSHrSfu+z/U2HqWvlyVG4ggkK2+3ehEp2Zgyezpxanw4JAb5n9u3upHyWeJ0uvbboRoi8kHRV1tx8bWR5zGBpZUi/y/NwW2KTSfF9P9fECuyD3+upyxF5lgqHogWSIF0nqyjtEYAM2aM7oimOysCZ8ZavtVEQAEfe+3jXyoKCvFB6h1aaTq+xRk3pkLKxtd457dexIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8FZwmiicFmSSZJ+5sDakiDcyeSsfxgo64L2FkowzB8=;
 b=yg00BKZC9lyuqOlM5jts2Wvfpw3v316krqmboRDPJAZwqM3pntc79InAOHs/u+BV8Ur74jumtQvHf2k4Unp/gzyvNVJNOUvKMpHjzCpS1Qpr4+fnxJEBL3peE11JV9BxJX0VlZ09l8wXN+FGrrptZV4YSPO2wb3oAxb92R1CzqK0r8+OQGqYIAbNnA3Znmq1Rcv9kv9KXk2nchl5tVgeIs+ibrgDnt6cL1w6X0VyIgXKP+7ram6LIGtWWtGvVZCohvAtNgM5AqjgsCRnFK7U9defMzS9hq9Kpl59zqvkOwH/bK2EXqoDM/RIIbJLLWBnVVzMjwaCqC154v+b6tXkbw==
Received: from BY5PR02MB6755.namprd02.prod.outlook.com (2603:10b6:a03:205::18)
 by SJ0PR02MB8387.namprd02.prod.outlook.com (2603:10b6:a03:3f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 08:30:34 +0000
Received: from BY5PR02MB6755.namprd02.prod.outlook.com
 ([fe80::ec8b:b782:6c01:faac]) by BY5PR02MB6755.namprd02.prod.outlook.com
 ([fe80::ec8b:b782:6c01:faac%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:30:33 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alessandro Di
 Federico <ale@rev.ng>, Alistair Francis <alistair.francis@wdc.com>, Anton
 Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, Brian Cain
 <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "cw@f00f.org"
 <cw@f00f.org>, "demiobenour@gmail.com" <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric Blake
 <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, Alyssa Ross <hi@alyssa.is>, "iggy@theiggy.com"
 <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 "mdean@redhat.com" <mdean@redhat.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter
 Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "z.huo@139.com" <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Topic: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Index: AQHcMUJABznzD0AlAEqKBIK2dfm3yLSqYFiAgAEEtYA=
Date: Tue, 30 Sep 2025 08:30:33 +0000
Message-ID: <8C16C7BF-800B-4BB6-A6D1-4C9DA644E306@nutanix.com>
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
In-Reply-To: <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6755:EE_|SJ0PR02MB8387:EE_
x-ms-office365-filtering-correlation-id: 94a9758f-12d5-47ef-311c-08ddfffb9fbe
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZmtDRzB3OXpTbHg5aVZjbnhBT2lwbDlmNTg3ZFdyUGYrZ1NaWUJXVVl0ZHRJ?=
 =?utf-8?B?N2xTYytCaTQ3UVZnaGhWL2hCeHErdktnM3JMZ0VGRGMzOU9pbVFBaUxiUVor?=
 =?utf-8?B?WE9jS0pxYXJWck1iYUwxaUw0QkRMelg3eFdhNDJuYS9YTXdYSUV1NEI3eC9t?=
 =?utf-8?B?VXk2cStBSWIzb2FOZm1aQk5SWVQyalNZeWpxUGRxNG4reVRpSHFRc3ZhaUtZ?=
 =?utf-8?B?OHhpa3E4eEQyb29ybTBwcExGeDBYUS8rcjk2SzlTQnlZcnhFWHNjOVE5b0tw?=
 =?utf-8?B?TEtrRTR4OFpxSGZSMlp3ZGJ5bTJCNFoyMTh6UGo1UjFEUmVMdHF2Z1dRYmJh?=
 =?utf-8?B?T1ZJUXZ5YTVMS3JnUFhSVzIwZWEvL2tySHBlUFNYVmpBam8wTk41cTkrZExQ?=
 =?utf-8?B?SHBXNzQyekpHekh0RzdZcXJBeVhzanFCS1V3eVpSMExkeUxaaDVkMk00YVkz?=
 =?utf-8?B?dXk4UGphWVZiNzNrSnJkSkJyTUJOdlVHMUo1d3Flc1VzNDZzTFZ2QStONEtK?=
 =?utf-8?B?amV6RkkyVFR4amcvSEpaWWUrZzdMdUxFeXZqcTFITjR3RTYvbTQ0dVVsSzdw?=
 =?utf-8?B?Q1JTNSs1eGV6L3V1MEN1Vjg5MTFNbStnYkQ2TmVXZGFYb0NRb1RNcUFNSWtG?=
 =?utf-8?B?THExSkszZWdja1dSK0lxcXBWYVplS214eDZMM2lRckxuZUhXVWdaNTBSbFRy?=
 =?utf-8?B?ZUlYRHFqa3hWbzhXVlNUTTdhanhjLzU0MVpEa3N3clhFeFZyVFpQTWU5WnpK?=
 =?utf-8?B?V3BWSVAwL091N25rOUlQbXVyU2tlZjBlRVNjQ0lnTEFsSnNKN0M4RWpEZ2Na?=
 =?utf-8?B?VEJ1UWtMS04rdmhMME5Mem1MYm5sTVhjdWV0cDZjeHJtVCtOdmwzK2ovMW9R?=
 =?utf-8?B?ek5sdW9mSDlsNzZqVEordmowZXpHT0E4U3g5U1FNaWt1M3V1eHF4ZTVuamJ0?=
 =?utf-8?B?bjBRQzlvT1plbEN6V3A3dktXOVhRK1lweWVJdnlkU2ZER0J1RENzeUpTcEVo?=
 =?utf-8?B?WEJWTU50bTRwTnZtZ3BWNERYZC9RQTVrQmRMa21wMFF4S1pzSDdvQWw1WjFO?=
 =?utf-8?B?ck5sczFYd29rNHFITkFVV1gwMVhCQUZSTlRDNzRWOXE3WFA0M1NESmZ4ZDhH?=
 =?utf-8?B?c2hRb0xoSlhwUE1rSU5IdnhPQmtiWnVTY2VRZGFEUUludWYwbFl3SGJmMnd6?=
 =?utf-8?B?YVZhTXdvUTF0TWVHaFA2c2FVZDB5Y011V1UwSHcxUUFYaGdRVDVFV3B2Rkt5?=
 =?utf-8?B?Z0orcE1Wd2tobUdMOHR6cko3QzMvaTZsT0d2dWxSaTF1ZUE2ZG0ramZPdU51?=
 =?utf-8?B?eTczSTNiK05hdkhPeXlDV3JIcW01OHlEcFVka3ZTRHE3SVdzTGhhWmhuV3o3?=
 =?utf-8?B?L2ZGQmxlVXIwVDFqRGErUmYwRUFzYnY5L2hwUlRVemx3WUdUT3BjaXZmemV1?=
 =?utf-8?B?ZWRkRmFhYjhTbEFEdllyeVltcGs2NVFzZkFuZUxxWmV3VFNKcFVoclhUSUpK?=
 =?utf-8?B?NDlPQTNOSHQwMXBoM3R6Mi9TbjFjemVTemJXOHY1dncwV0hYdnVmR3FzZGs5?=
 =?utf-8?B?bzVwK1NyZlg3d2JmOHNSNVlKNUNjRGJYZnpOM1ZRZ1F6MXUySnp3K0E3OHAx?=
 =?utf-8?B?ekJYV2tqUXBIU2pJMjRiMXJtT1MyQWE5NHdzMnZpSE5LendyU1dNckZacnFC?=
 =?utf-8?B?Rmc2UDlraE1CTnovUFdQUW9sTG14d0xtczBSTTIxcWdadkFWeTNZczNqVWpr?=
 =?utf-8?B?SGpkT3VDYzBMa2E0VzJqYXVYTm43VFN0NnpWeHJ6ZDh0alI0Rmc4SXh4Qys3?=
 =?utf-8?B?SndyMkN5YlRGd3crcWttUkx2V0tUSXc0a3ZTbzl2enNZRldBalhaUitKRzNR?=
 =?utf-8?B?QzVUdm5GaXpBanFiUVpqZ1RQdE01T1Y0aFBXSDBVYVJhTzNobXBWRFBvc1h1?=
 =?utf-8?B?OTdZOGNBQ3F4LzNEeGZwNUZGM280K01UR3VLY1pzMnluTkxqSjJwWFIvazF3?=
 =?utf-8?B?QVEvWUVFSFF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6755.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFFGZitzUk1Cd21ReXJaVFZLa2JhQ1pYSEVkMlpjUFYrbzNlNnFHcy9WektU?=
 =?utf-8?B?SVFRaDM1ZWVPM1VhanpMN2svT2tscHVTWHVTd2ZSbThmWW9uSFZQOFRRbDcy?=
 =?utf-8?B?MEJPOWhraVowMDY1VDZwMFFpc240Mm05TTNJZjRCTzJZYzBhL3pLdFVPQXVy?=
 =?utf-8?B?TjhiMHBSN2s2RFhweUdHU3o4V2VodkFXS09EQVdvT1RSR2RkazNZR3h3OEQw?=
 =?utf-8?B?RGJMME1reDFVRXFxcjc2eTB5alR0Y3l5Rm5yUFpRZDlYdXlEV1hrTnB4MmtC?=
 =?utf-8?B?Z3IxMGdMYVh2NEt4UW1DSzB3Uzcxb2xiVHErUHRKUktsdGV2M1FSNVRXVUlH?=
 =?utf-8?B?aFR6ZXVBRWRVakY2eWdLOEpQNjlXUjErdWg1SDdZTi9CaHhLQlg4eVJKZGlv?=
 =?utf-8?B?Nll3bmZnNzdmajMyazBmYmhUWCtCMDZGbndYUkJ1eWpnb0lPbGJKdGQvQ0FU?=
 =?utf-8?B?Q0tCcFljek1oTGRtd3lkcFd5RG1nbys4b1lHR0FOSWFmUEw0emlNSSs3NDk1?=
 =?utf-8?B?cXJJNnpJc3dGdzZvZkl4aUo4MkIwdWNZOXBMYmRvdHQ1enppMGx0T08weEVM?=
 =?utf-8?B?RGpxLzZxeG45UFlzeEszOUR6QlF6LzUvUFBKd0pTRlVyS1RkSjgvLzc1MDdK?=
 =?utf-8?B?MXJUZHpsK2dXUFhWdzQrQ25TNlM4c2RLTjdDWEtlM01haTFrcFlabGh2cHg5?=
 =?utf-8?B?ZTFhdmNadWU3d3Z2dE00MS83QlUxN1FaeFFxdGwxZ2s5U29KRHNRdmNlT0U5?=
 =?utf-8?B?a1Q4aEkzS3puWHRYdHhhd2JRZ3p4VmNCUmRuMFVFcUtuTHlpRXRWcENuZEtn?=
 =?utf-8?B?S2NqTnh2bDg2Qy9yZkhIdmVSTWxqaVE1b0MvcC83V0k2a2VzZTduamhkd1hr?=
 =?utf-8?B?aStRbmU0MERpZ0FZemRsSFB4L3EzcE1DQlZsTlhHTDFrem5ybnZXV0ZTNEdx?=
 =?utf-8?B?bytRbWFDRVNKNk9IaFljQ1ZDQkI1bjlnV2ttUnVwbzV1VkozMkFWZmg4Q3hV?=
 =?utf-8?B?eGkvSTRiSHpLQ1lqRnQrdVZ3Zy9sdGp1aHJVaWp0bFUrREttNXR4UFNWTjdm?=
 =?utf-8?B?Mkt3aUNxdWsxbUVvMVd1Vkx2Sm9rQ3VRcjZpSVhqWjJGT1VRVkRVVzluYnkz?=
 =?utf-8?B?ekxiNnI4U2VJWm1HYUpVZnU0L2xyN1RieEp4d0k0TG90bXg4ZjlXODZGcDgy?=
 =?utf-8?B?VW0ranFuVk1qc2N0bGFEVEFrNlBXeWszL3lOemgzOEF4dDR4NnN6VnhCS3Jj?=
 =?utf-8?B?dmNhZ0M0WGluYUZZdVpBMUFOWVphVXQ4YTJ1VlFHeTZlaDM2SVNQOExpcTZ3?=
 =?utf-8?B?TEplTkhnUlcxTUU1SVkrKzRoSWFWL0c4SUY3OHp2VjUwNEhPVUJmOXE5YlRL?=
 =?utf-8?B?K3ZSTmowcVVwaTJUOEpGNmt0NnpmVUtlNUlaRStKWUJvelpJcWdWWHF5MmpU?=
 =?utf-8?B?OU1HeC9OVXR5NDB3S001dVN0L0RDOS8wT1JBb1FFV0gyTlR4TTI1eENLWlBw?=
 =?utf-8?B?a3pJSDF4YWJVWGF3azhzeVZPQWpwWFNPT0hmeGpaSkNqTituRmdqT2s1d0tY?=
 =?utf-8?B?dWFVcm1KcmtmLzlKeXI4N2tUUkFPL2tPMVVPWGhKVE9ueEMrN1c4c3ZQNGNP?=
 =?utf-8?B?Y3lmYUVwMUl0dWdQUXBCaWNib091b1pWWVlFMFZwRGY3TTBBcVB0RzdTRXZ5?=
 =?utf-8?B?V2VqbUlMcVNmUGltaVN3bmx4L0J0aVNHUEhKNHpHbFVrTU5XMXJ1Z1BhWXdx?=
 =?utf-8?B?VW5SWW1mb0J3enBmd1ZpSGNYMC9hZ2xtWmVhK3lPWGNocnpPdGtYVEk4Wmtp?=
 =?utf-8?B?anNQOXloMk5RVGlZbXh1T2Yyc2JHWUhBNUE3Y2ZHbGhOeFF3czdRanNlcVpj?=
 =?utf-8?B?Zk83RklKYVlveEdYbUtQU09acUU0UElQekxNdW96R3g1ZmhnMkZQTGNOWnVO?=
 =?utf-8?B?eVJJd0lXNVNJREo1ajFaUUFXRmRISWt2WTg1Q0tvUFpaa0k1K3lyWWY4QkJQ?=
 =?utf-8?B?Z1cxTWlvY0IxNjV1d0N6cTJmWlgvcGdubkJhOXBmZzMwcDl1NDJaNWpiQWlR?=
 =?utf-8?B?OFQ1eTNmdEdvN2c1elBQODhid1g1OGR4OXA4ZkxQZEttcUV2V2FpSFdmWDl6?=
 =?utf-8?B?OEhkdWdnaHVTMGVwQVJPWEU1dDM3RElKYjF0L1h2UEQ4Qk9MblArNEtCWEd5?=
 =?utf-8?Q?uRmg2ezLwvONJCaguVlowGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76304C8A026270499340F65A1F8DBFDA@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6755.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a9758f-12d5-47ef-311c-08ddfffb9fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:30:33.8138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVaQ4YlXiaTM/B5B6r76tktPGmTdyNPEVARkbHow7EtO8JEslpVsChqj4ItajlZP+1QzBNen7IZodlYj/0k0bB9wTqoo+Yi7slasesmjhBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8387
X-Authority-Analysis: v=2.4 cv=a4Q9NESF c=1 sm=1 tr=0 ts=68db952c cx=c_pps
 a=+c9WoxDyotZMqfRYVVLQHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=nXA5WNwiAAAA:8 a=20KFwNOVAAAA:8
 a=HNCZiIP7s0SHarI-8SsA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=HhbK4dLum7pmb74im6QT:22 a=UhEZJTgQB8St2RibIkdl:22 a=p-dnK0njbqwfn1k4-x12:22
 a=MURpYVOlrLSSKvKaDb7l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA3NSBTYWx0ZWRfX2QdjljeTwcQS
 6kgepTTLlvllfC3mNMMxC6f5inOC8Y+THTGRqqHQLEEb0ICp5n1oLHljO8CV1dQtDERtCZlkVYM
 AmQAPKkWQd4xE79ZlL3iyjzCHfeG5CDoUg0UPsrXjG6gpqC6A970YrGjOK1+qbxiy/1Nwrp97C1
 mCFDYcZADerMwcPTQSAx8BSETQhBCOSDMBhtU+E/BPVfSQLTjgFnwxnEXeLI7vSv1XUdDHlAhva
 WDCbWAx0KvbB2ZDiY8UxzdKUq3sPz8zu/RS0f4SZXibf1fj+OA1H4MsCyDHLLy8wWfFh5eT5Gxd
 lQ1coH6e6ry7trrHcqJ70wO6jT8k0j5EY4TAJodIqBEzYceffnxX2hwf/+Jh2TjSeDu0R1dR1ZO
 1Ug5+IsQCTOd3CTNKZa2IXJqy5+ZTg==
X-Proofpoint-ORIG-GUID: JcMbdkRqBBVboBEe9_jLRM-eeuFpNzE0
X-Proofpoint-GUID: JcMbdkRqBBVboBEe9_jLRM-eeuFpNzE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gMjkgU2VwIDIwMjUsIGF0IDE3OjUyLCBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDkvMjkvMjUgMTU6MDksIEFsZXggQmVubsOpZSB3
cm90ZToNCj4+IEhpLA0KPj4gVGhlIEtWTS9RRU1VIGNvbW11bml0eSBjYWxsIGlzIGF0Og0KPj4g
aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZw0KPj4gQA0KPj4gMzAvMDkvMjAyNSAx
MzowMCBVVEMNCj4+IEFyZSB0aGVyZSBhbnkgYWdlbmRhIGl0ZW1zIGZvciB0aGUgc3luYy11cD8N
Cj4gDQo+IElmIGFueWJvZHkgd2FudHMgdG8gdGFsayBBSSAob3IgcmF0aGVyLCB0aGlua3Mgd2Ug
c2hvdWxkLS0tSSBjYW5ub3QgaW1hZ2luZSBhbnlvbmUgKndhbnRpbmcqIHRoYXQpLCB3ZSBjYW4g
ZG8gdGhhdC4NCj4gDQo+IFBhb2xvDQoNCkRvIHlvdSBtZWFuIEFJIGFzIGluICJRRU1VIHJ1bm5p
bmcgQUkgd29ya2xvYWRzIiBvciBBSSBhcyBpbiAiZGV2ZWxvcGluZyBRRU1VDQpjb2RlIHdpdGgg
QUkiPw0KDQpGLg==

