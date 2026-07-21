Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704F7C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBBU-0002rL-J2; Tue, 21 Jul 2026 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <MBURTON@QTI.QUALCOMM.COM>)
 id 1wmBAy-0002hf-24
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:10:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <MBURTON@QTI.QUALCOMM.COM>)
 id 1wmBAp-0005BA-B0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:10:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg3x72071817; Tue, 21 Jul 2026 14:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=ibLZmW/CEL6pkdoBXwYnhGI0jbHDb+G6ZrjlSvMPRz0=; b=fU
 +IrbARTibBfd5d9rREL/B4iyntwZ4wmeQy7xeB51jQW58MndSODFWfcNSiN6rLcc
 RunN1VJpG02xIANDe01zS4xyY+1SN+obhK66xjgKnc0B+A1Xh9HmyQ6J2OnuKJ2e
 tJ2YMdxi8lMXRDEpj0GqQ+C/ufRWVoo5hQNID4w0mQTKcsflWVkuF07yNYFTAGFy
 Jnx/B0POsRi+AMq6JA+MAwKSjHX67G3Dujoj4luGbtufdIg7QCP7zgvj96127jc7
 2yn9ojdwuwZgLPDztvxHDcgU63o5jHswLrgK39LzFe03BoJU6TNOm/bp76CRqy6t
 y/ErQVJplA62YpbctoJQ==
Received: from co1pr07cu001.outbound.protection.outlook.com
 (mail-co1pr07cu00100.outbound.protection.outlook.com [40.93.10.88])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3h3je-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:09:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtqJe72iKl4i9ejba6mdk2FkpRUMdGbsNYCNympSLlNP5Vx07aUce5A6C6Wdz66hS8nyMnmLSv499sj08SJj49GaKM+JkvGuGN2vi8b+/7mpyZ6I+9Bbq1Q6bB4ktk5w8SO9KBOHJ+/Sd1mo1UxktH5BjGZOdRMZGhjVVMq9mOPjJZlqNSQvphBjIatc51bOU8FKNc4jOdtqTyiPyD/saSmDexrz//NpavEUyJMEp8l34HPPWGvTvzDlBmdnqplWH/2aDVbevtpIOtsDxVPyF64+YSHou9ZmWUFQrAyCALFgL0pRpC2zSbWbakDVv6PH/Fb5s1b2eipDFbOX8Z7qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibLZmW/CEL6pkdoBXwYnhGI0jbHDb+G6ZrjlSvMPRz0=;
 b=CleMbFd19eY87UVY47kCBbH6WsJV0V7fU0nsRBqR1C++mlmtGg1DIUp06Hg3FVVduWltB4PEuf83eG7jII0T57tRtZxBH/351NeblR5fsWml/MkN3i63N6pFhyIl9p/iGkDkhJ8fM+UeZsSJJ4pymU5R+Gazhgad2WuEbBxWy4alYRzrASzfh1xvnC4qrBOwJiccBe5X7O+Eli/nKDW1ED/3HcFj2XgNfkVEE1gK1ZHQzZtMjW28VdqtPJ04By251p1vZKACLRcSfDxs0vZxAPKzaZfKCgQxNTMw9JVWkW/OeUstIRBAsYzXwk1XSu/xxaKwcgzQu0zjRu6YE8GfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DS0PR02MB10990.namprd02.prod.outlook.com (2603:10b6:8:293::18)
 by SN4PR02MB11706.namprd02.prod.outlook.com (2603:10b6:806:1ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:09:35 +0000
Received: from DS0PR02MB10990.namprd02.prod.outlook.com
 ([fe80::f1e6:68f1:dc9:fc43]) by DS0PR02MB10990.namprd02.prod.outlook.com
 ([fe80::f1e6:68f1:dc9:fc43%3]) with mapi id 15.21.0181.011; Tue, 21 Jul 2026
 14:09:34 +0000
From: Mark Burton <MBURTON@QTI.QUALCOMM.COM>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "cw@f00f.org" <cw@f00f.org>, Daniel Barboza
 <dbarboza@qti.qualcomm.com>, Demi Marie Obenour <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric Blake
 <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>,
 "helge.deller@googlemail.com" <helge.deller@googlemail.com>, Alyssa Ross
 <hi@alyssa.is>, "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh
 <imp@bsdimp.com>, "jacob.oursland@gmail.com" <jacob.oursland@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 "matthieu@minio.io" <matthieu@minio.io>, Max Chou <max.chou@sifive.com>,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, "utsingh@redhat.com" <utsingh@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call agenda items and host request
Thread-Topic: KVM/QEMU community call agenda items and host request
Thread-Index: AQHdF62YDJ8M9W+eHE6CLX7CYw76N7Z4BbUA
Date: Tue, 21 Jul 2026 14:09:34 +0000
Message-ID: <E81AEF88-70FD-4800-A51D-2274D5BC78F0@qti.qualcomm.com>
References: <87v7aag722.fsf@draig.linaro.org>
In-Reply-To: <87v7aag722.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10990:EE_|SN4PR02MB11706:EE_
x-ms-office365-filtering-correlation-id: 2989d009-dce2-4577-0835-08dee731b161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Kas0XuVp1arHfnD97uLnLViGwM9wJZERKGlrFXCJvfNOf+VHuYykPCt9lVsFY/1jM+gKcoj7Cwh8/A3oyzD4Wkc4GZV18w0P2BWOkj6nvqtjK9CYINo78LNgZ6XSutbhMdPrwZgUw8cqjA3EN/jhGEIHbu5wmTA59puR/pWKcz/nACdiMkHaBZpAHLS0RlZ/XoWZfKw8KuUoASqxs+8MAQQySFaXBxf5gh6G2oMglvJnv+I6JJHB2G5CIlo26wHCbcBULO4wvIr/ydZ49oRzc0ISrh96ojfffg6iZuUPg38CV8aei2VQR8yUivqnZo9ct4Fo8urxp489mb2UuDgiVzCO/upg/mYKFelVAbCfaOKIBTgXro1au1ftbgDbJp+uqxKEDWij3TguWBHFHgBakL8iBsdS3pW8yFWmMmYHx+N0TiEWcoklMuevY2wbXDwAhw/WR55NGBUZzKjoVMKdvTVwYdKPr+lbQWvBHKU2glnpObJ1HIqKtuHfStx1n10mK7sDUXrkXEgPYidT/Z8AWh8898dACGtyfIFUaKnfz0Ja9srNWmGLfIQsVaq6A8BbzCjjaZ4Q3VT54R3TB7a1LiucZYSqZH2Hkx4wen+TaK3iNUoXORGxYgGtAabAYvm14uk5q1nK8VCF9zDN5dnGgkYi1HQlaNqK68D0fZr7vLIn9HmxledsHz8fVhts4jLtb1kst1/rI7o1jyCw/VxSjJnUhgCiNhr65fUn2JXoAnw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB10990.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJMcmRkYU9nSW9UbnN4cmxZeHRPeC9BbTJwU2tRc1ViU3FuUWgrTWRKbExL?=
 =?utf-8?B?Z2s1Tm5XZ2grczRreno0SUgva2N6TUVEbjYrSjdxMkwwOGQ2Uzd2a3MwNm1o?=
 =?utf-8?B?ZkxndjVhT3NKUmtrQ0x3Sk9PM0oxSGtjbHlQOUhZSHlJaWhnSjhIcDNrNVlx?=
 =?utf-8?B?M3poMnBmeSsyZy9uV1dKRjZQampOTEFmVW9FbVNUbVo4ZGtGZ0oxYU9SV3F1?=
 =?utf-8?B?ZUFnZU4rMGNtamZISUhMc1BsMUZVSlNvWFViZE9DNGJ1WmtxQ0tjRFlwaFZa?=
 =?utf-8?B?bjZ0Y3N6ejkwZ1VBeFRFNEUxSERBYk9aa0J0SmdZUmdaeEE4clJmOFZTT0t4?=
 =?utf-8?B?NVpCOUdjZ3ErZVg3RnU4M1FhKzRUMHN2TkVWVlVjTzlub3hKdCt3ZTVIUHdj?=
 =?utf-8?B?TGVxcDVHR0tjbm1ycW1IQU4wd2JrVTVQR3ZTUnhXMDB4cVB5VVFoLzVGSUxw?=
 =?utf-8?B?UnFVTFdIQ2RVVnYzRk5BT0R1U2NzY1dEYzBrNkc2SmJrVUEyVVlSOEt4SHBo?=
 =?utf-8?B?WlRTUENQbWFHVEptSWpmeW9OYzZ6eGpJaTdUNWRHbmF5ZlhGMSs5TXB1Sktq?=
 =?utf-8?B?anBucXpsRXU5WlE5TmZHa0lmTHM2RWNNazQ5RllCWHRrOFRLT0FYMEkzMGRJ?=
 =?utf-8?B?VFhwSGkwOXAxUElQenRZb2tzbDNmVmRqK3BxZi9SamtWM1NPbmI2WjFNWmZt?=
 =?utf-8?B?THdaM2htVk9tWGZXSkZDaDhNRkFGNWQrUlYzU0FNSTZ1VWlDcXVpNUVJVjhn?=
 =?utf-8?B?cEkrZEpBZG5jYUlqeURxM3gzWjMzMkJFRjc3MUZneitGVWhxVk9CYmJkRitW?=
 =?utf-8?B?NGN6TWRBUndNZk45bi9xZWhkLzBZNldsVlkxcitIWUJWUFBxbmc5REJJejR3?=
 =?utf-8?B?MnY3Nk1HbmZvUGF1ZXhFTi9lVEliQTNkZUZmcXpXd1d3ak1rRkZFcnVsTXp6?=
 =?utf-8?B?Nm5YWW95d0JXZGUwRnZ6YzhBUVJ0Y1RWRTIxT1ZTMjh3T3M1VTFMR3lwY1I3?=
 =?utf-8?B?NlZtRW9IL1Vzc0pyQ0xBOUNVNWZrSFE3RWJ5aXQ1WWhpUDA2NzZ3MTFpcmFP?=
 =?utf-8?B?aEZQd1JJQ1llVnltSDRrUUxadVJuZnFsOU1FYjVOMjFLQUlTRFMwT2c0RkdM?=
 =?utf-8?B?ZU1QUEdPUlBuMEVPeWprUkJhdzQ0YnVFUm5PSWc4Qk1INC8wd1NkSGsya0tZ?=
 =?utf-8?B?ck1lMi9XL25uZC9BNCtKUWFKZkFhQ0xreEdpZGozeTlSR2cxcHJXeUZ0Q2RU?=
 =?utf-8?B?Y2I5K1pXUUdKV3RKb1NOZU40M3RpT1lmcGlWKzRxaGE0YTBlMks0QTZrQjU5?=
 =?utf-8?B?M2NoL1JnT09pL1JuUjFvNHpuRS9vSkZJanFsZndvK2gvU20xcUNyUDNkQytl?=
 =?utf-8?B?RWJpTkJMdGhIMlR1ZXd4UE15TldidVRTb0xJNFBzYTQ2VzNsWmlxdytyVlZv?=
 =?utf-8?B?aCtEM0Q0a1BERENIZEY0U0lmMDJ3c2tzSTRhVFZpNU1xd040SGZiaG9iUGV4?=
 =?utf-8?B?UXVGNit5S0c4MGdNWUtpU0E4bWVVemJ4b21aeE9yc3FWMUZiNzkvTXUxa0Nt?=
 =?utf-8?B?dGFCV2J1TzRKMmVCTURPenV2VnZ1TVV6N3dJd3NDOXJ0TUFaazhFZGhSYkFM?=
 =?utf-8?B?SlZnbElramRCblVDdEZ1MlN3YW5iVTc0N29sT0hKUGRORStCU2tPcTVUQ291?=
 =?utf-8?B?bktaa08yREpYMjdKMzg4REVYbkdzSmNRT1pQRnl6NnVCeW8yeFZKNXF2ODAz?=
 =?utf-8?B?ODBZRTQ1WDNqcnNxS2ZFbUExaDRjWW8yM29wczBOemNkd2lDSzVORjJGNU9p?=
 =?utf-8?B?OFdoWkd1NWRpTEg5cUMyN2g5OG05TXhLR2k5c3pTUUFRMFFqNHpzVTlzWDNQ?=
 =?utf-8?B?WU03dnNxRFlCVDRQRCsyZGtHYS9PRE5HS0VaUDBOSGdEYnhmRFUwYUQ5MnpK?=
 =?utf-8?B?RnZqMVZ1c1poT3dMYmdud3Q3Z1ZXV0VxR2d0RERtcE03VDBaU3JqUnRWckJk?=
 =?utf-8?B?ZlZReGl6UW1iZVVpcFpGRHlSR1o5SGxMSmFYSXRYMVZNMDFQV20wQldQMCtC?=
 =?utf-8?B?SEl6WTRlMHFueGJjOTFTV1VRcVoxSER5Z3MyQUtENk56RWJVZGRrcjJEOGVC?=
 =?utf-8?B?VkZVamY2SnYzOWdraDJBUVBvbXMwdng3NlQ3SFpVT3FIVjdjUktLaEhKdzlH?=
 =?utf-8?B?NXRmVHM4NzBhYUpvZTNEeXJGcTZLeW5vSDlCVSs2K2M0VndZRDl6VTc4Smo0?=
 =?utf-8?B?Z2ZLY0ZVdncwbHBEdXFqYjNvb2pNT1BQTzF1RUtVSDQzVSszK3FXNnExUlZ6?=
 =?utf-8?B?VmVHL3dFY1JUejFSOXNHQUdiS3gvb3RnbjQ3Ylh0bXo3Z1VJcjNwUmhmSjA4?=
 =?utf-8?Q?acD5TSgv5G3nJDJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <897E6AFC5AEA1E44B4C95102B1660E18@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X6C3FAB2eJPh2EfKj5h1HfYskNtHD9Cmz3H76iumUfykaeuMyBaD+6DTQ7XGdFwYnxzTUafbJnaNtg/ZfLoQ0JaQtnzqLq1lkJj3gs0KCe+NaudMilKdK+F7+6lMq4lWV/GT/yqxsg7ZDveV1TsliwOiY4aESQbBqr188PnJzxM0mWit/whaLH+xS6AacYzK6K0DUT48ZJLfUqaTIFkzPul0CEC5qMKfzdUWzhqaZo9i6TqCqJH3FOctq7DhvZZhENhSKnjAvgEFIz1FyaA5vCz5TL4DdCrQ5aNATXRz5mtSNNIdwZkmAnprTli/J/fHrnDJn7vW/8mWIKpVZO1edQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NjT0apySIgwzQryFqufXE2liK5f6iiB83ubGPQSgEWn9jbWqENDg7mq5IE+u4VDWrijeiH3gUsS6WafHdbf+4KMnoJj1QNZpDbt1aKt9uX79n0dhL0HFlsYcpSabHHCJBWMT1NNb8oJsTAsw7pkrmhLr0LgtVMiYpphUgUoV6FIiQdsofs3pJtWCMxM2raRQBeEFWdYhWHAmkG0xgW442DzFsu80yv6zj2DBNV1xoMul631YGDg6RUCeysJR6zifOz00cCfTVaDSfxHRJfZ7OxtRcxgmoyjmxnwR0xYaEGHW2q2ckHxfOrG4tCXrmB3JOWYSxM0NMiWSbo/Opwa0uPxRZuCqP+4/mwlszzJTEufCWPJXA2xCmFadhJfnzNvo1tJTohsCJSDQomuf0R+2I8kKfI8pQ5ZAFczyRONFK55+aFrBKwE8P+G8C1csEuoX6e9LjaxHKTnOrIkXp3N8E+XevPA0rS79P0ca6092lQjPndnGpHDsIDCXRO0KFLM0saNNK14iS2WZPZodg+0D1b+uzeHeKywAGBs57p8XQE94RFSbWAsGre8+2QypTCMv1msz4QtGxmbd7+DI1UxtO4zEHPhjdnHBKut2N7XytQWZN3TnO2WgpVsWV1gfZeOM
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10990.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2989d009-dce2-4577-0835-08dee731b161
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 14:09:34.8263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qg0n0jQcLK3W+ECrUoMGf7dkT0zuDAb6/Ow8eqiP2TVieu1OM0k/0PUHJjnRbXLb5ziqZ+KcJFkj4xCvISafdCl4LMSclf0mqUZkDgAENKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR02MB11706
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MCBTYWx0ZWRfXw+HVN6FNOopn
 yI5Kq7Rtbs3DuDm4IZ5X0Tu6ZNDgGQvwLkL6Y7Vgro5UtnZUKCPl92Pdps+gPr/V8qDRZgzXtXb
 zOBTdkYr7ZHxnYWPbpvH60zqhOjpLYzwqJR1hnjXVLC1dEmCDbg5d+oyeKQ1Un9eb7/Yw4aAcZz
 hdSxaSRb43dPllRo9E8mcpOg2ZNTikk7xusButxKYGQyzu23Qggf0q+9SSEZ/b8ZZwUEbTOAwU1
 LYJlWNHzRXWAq/2fTuNFvEyLc3WJ6A1XxclUrye0vrs6arPZWVl7ZdTLJyevqrTPPJicnzwzMzp
 SL/GvVw/w2xc8ZVM0AgpwV1+Y8rwdiGbnt92wPXNz30V29BxhVdbbtYGZu7u40HAr8cYt8pAW3o
 CGQHDjXHwDLEUKa8YNv+AJQkruxMAOkF+CA29SiNAy4JxC4nPpYj97/gugqUPtIjHfn9PZooSqD
 NfDkt0QuMkisNDYAr8w==
X-Proofpoint-ORIG-GUID: so0vtFmRIpPtW30h8PsZBKb9WRfrCeRz
X-Proofpoint-GUID: so0vtFmRIpPtW30h8PsZBKb9WRfrCeRz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MCBTYWx0ZWRfX6SYtKlA9iKd6
 WiHddh3RAXAcAgB79RA3V2/qtBv1Ei74DrHQZfonfbpkEkZr7gQ0FJElUXUJ+X4Bj0e6RMZpKtl
 7UfoErarkuCVFLYyvt8JpY+HHJ8ybyE=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5f7da6 cx=c_pps
 a=ZeJWheVnG6sFMQCuVbF+sA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=nXA5WNwiAAAA:8 a=KKAkSRfTAAAA:8
 a=-aPEJqwakmsKeLF5d2wA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210150
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=MBURTON@QTI.QUALCOMM.COM; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Tm90IGVub3VnaCBwZW9wbGUgd2VyZSBhdmFpbGFibGUgZm9yIHRoZSBjYWxsLCBzbyB3ZSBjYW5j
ZWxlZCBmb3IgdG9kYXksIGxldHMgc3RhcnQgYWdhaW4gd2hlbiBwZW9wbGUgYXJlIGJhY2sgZnJv
bSB2YWNhdGlvbnMsDQoNCkNoZWVycw0KTWFyay4NCg0KDQo+IE9uIDE5IEp1bCAyMDI2LCBhdCAy
MDozNiwgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+
IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0u
IFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBl
bmFibGUgbWFjcm9zLg0KPiANCj4gSGksDQo+IA0KPiBUaGUgS1ZNL1FFTVUgY29tbXVuaXR5IGNh
bGwgaXMgYXQ6DQo+IA0KPiBodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQo+IEAN
Cj4gMjEvMDcvMjAyNiAxNDowMCBVVEMNCj4gDQo+IEhvd2V2ZXIgSSB3aWxsIGJlIHVuYXZhaWxh
YmxlIHNvIG15IGZpcnN0IHJlcXVlc3QgaXMgZm9yIGEgdm9sdW50ZWVyIHRvDQo+IHJ1biB0aGUg
Y2FsbCAoYW5kIHJlY29yZCBpdCkuIElmIHdlIGhhdmUgYSB2b2x1bnRlZXIgdGhlbiBhcmUgdGhl
cmUgYW55DQo+IGFnZW5kYSBpdGVtcyBmb3IgdGhlIHN5bmMtdXA/DQo+IA0KPiAtLQ0KPiBBbGV4
IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJvDQoNCg==

