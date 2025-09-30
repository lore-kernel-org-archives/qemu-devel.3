Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734B5CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VvL-0001cE-7H; Tue, 30 Sep 2025 04:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1v3VvI-0001bg-96
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:41:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1v3Vv6-0006DI-UX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:41:22 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58U5lWfW2004967; Tue, 30 Sep 2025 01:39:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dKT5MP8gaYRz+YPHxrw99at+tUDniC+gdZRYDQmcI
 f0=; b=v+sy381jwBFfOZpOljV1Dle6h30H92UB5O7lXVbOBPZL7ZS674Yaw0zYB
 dIX+7wDyL5k0Sz7i0nbSEDOh6GbMs76Gsl9JnBKL2M39n8s/YtZsOdq5wcFQyfgN
 dqK5gMep2o4K35kJIixCmBUDOPWC2NWXsawTqs7zKdqykHsvll8Zu+xLalZuW5xc
 S/+Rx9SBeQwNKrdlsfHkF3oaysfhvJIdTFZvJoGAjcF4Rr9xXwVuYJK75/skQ7qz
 QtIgCPPtSNilaxHP6rAaSaRciVETtp75hqp0pk4Y8NQUufHoX5sCOlhXl7a/CkTl
 NtnyiLWhlK0S6ddKwG0wDxcnD0zww==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020116.outbound.protection.outlook.com [52.101.46.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49ebu460sq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 01:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jApeZw3Ez2sqvMej9tif+Ly2K9fgSTxanfjsivFYzxoc6niv5S8DbFRj0kNymCpjZRVgGDpZRs8AxtenXxATUh0SzSOfYtS6PxRiyz49WpKEKckWAhr9byqyUIm68hSkx3yvO9MmUzi7EOvGscn21cEGSRDYqvg7Od9t3QFLSr/xrotEwnHiJHZwEe8Yx8/pNv64PDMs/J1d455x1phxJYQy0tPYWJsEv43z+GlwuB6LvWa372Cz6i7Fdqai6c+is93/9eACzlSj8AR0M3kbh5kZQML5MalQcFqzTHpnAU3jANaW5skG3qE8KAXcLRO/oGutODD90tLmYZwcHfYy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKT5MP8gaYRz+YPHxrw99at+tUDniC+gdZRYDQmcIf0=;
 b=bkuo3y2i+zMT9Yy0vo3FgnN1wgRkg7qUx9KFIcfDIFj0sj+RJ186y+8TOG8d8wpnWdrErqkTq4QbyIntgPofdJUn718fjBcrAEza1dhxg+2cd4WBobIut6BePlDicJkC5dAwNM6oVVGIzOflCIy+T8417EHlHVudhlLMOagfGYJ88w1D9uGDzABzIufifIi2TYU0tf1j7cHL0Ee7AIIGOXgNpDbi7vxP4l1GMwDFypgMw1IfMTud7y8q9UNAF2QIZOPrsjqdFt2QyLN5ofR0uUiHkLt3E17p85MM/UKozdQRzVJw+9dLfZ4D4j9Q4W/4xFiY06iSdOPCpLrj5IsyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKT5MP8gaYRz+YPHxrw99at+tUDniC+gdZRYDQmcIf0=;
 b=ySH24pQ63WXr2kItyypukwWjlL1dZA7YljOXm/BkZA6zYAeqHvB8e5h1SNuhj3KYnS6q0bYWTVmwvn4mHstxKjvi30ojxazkbjbrSHaL1011FUgDY5o0UBqGMYsjV9ooNxB87CAv05QQUdldUFtquGR660yOQpGliJAN/9e5pwDejI4lfn8P9ppz+730bU+xAfz2r+69FhU5Ln9vGPFRMSWb/J1qDrE8K1dMWXYpYQW1hN9AQS4l+ZQcv49aIWxm81IynU2C94Zv+xJ76NzyelQ0gVkHjowbOQNwEJiKfJdgQAN6rGsE36UeWkahii7/QzusYzFms0U5RSmBL0Aw7A==
Received: from BY5PR02MB6755.namprd02.prod.outlook.com (2603:10b6:a03:205::18)
 by DS0PR02MB9356.namprd02.prod.outlook.com (2603:10b6:8:152::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:39:39 +0000
Received: from BY5PR02MB6755.namprd02.prod.outlook.com
 ([fe80::ec8b:b782:6c01:faac]) by BY5PR02MB6755.namprd02.prod.outlook.com
 ([fe80::ec8b:b782:6c01:faac%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:39:39 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Mark Burton <mburton@qti.qualcomm.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Alessandro Di Federico <ale@rev.ng>, Alistair
 Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, "cw@f00f.org" <cw@f00f.org>, "demiobenour@gmail.com"
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Max Chou
 <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter
 Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Phil_Mathieu-Daud=E9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "z.huo@139.com" <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Topic: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Index: AQHcMUJABznzD0AlAEqKBIK2dfm3yLSqYFiAgAEEtYCAAAIfgIAAATX5
Date: Tue, 30 Sep 2025 08:39:39 +0000
Message-ID: <BY5PR02MB67554EC1567F50DDBE28CB83D71AA@BY5PR02MB6755.namprd02.prod.outlook.com>
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
 <8C16C7BF-800B-4BB6-A6D1-4C9DA644E306@nutanix.com>
 <3CD93242-7EFA-4B17-900E-6973BE1D0B3F@qti.qualcomm.com>
In-Reply-To: <3CD93242-7EFA-4B17-900E-6973BE1D0B3F@qti.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6755:EE_|DS0PR02MB9356:EE_
x-ms-office365-filtering-correlation-id: aeef072e-8cc3-4127-1722-08ddfffce52b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+SLuEcx9BYLZk7O6Nde8Fp2Xzj9nMNGiXoAXXvgCHaLs4jvK6YBMjLOfWI?=
 =?iso-8859-1?Q?QyHxRcDkFQgHnQDLtYpuXGlOGkdFeZOzmNisdFbz6E2FBwEd3JYB4EQrJZ?=
 =?iso-8859-1?Q?uNsQDnNC/c27nX/FLGyRtlHymv/+t3n5B24A5il73pwe6P9Gdu8TWH7EF3?=
 =?iso-8859-1?Q?NS9i7IeiTonWByszFdQhzDJJAEOcIbnFjUiL+s5p99u2VLy6M7UjeJMGJ7?=
 =?iso-8859-1?Q?SY7XFX3hrml5Zam91RvJPKmPDIZkj1Kny18QoEXZtXLc1gMEjOO5x+fvHv?=
 =?iso-8859-1?Q?UTCAKvAQJP4KrVoAwYEj5plKSPiUz8pJcRN6CJKVGRn7N+J9Ujmv3p6NKq?=
 =?iso-8859-1?Q?/jdiCZfrZwToZshIvmCazFC33sZGLxEJ4f6fGFk/2o3wAb+KmZYxeQUeWe?=
 =?iso-8859-1?Q?3FUE6ccwn4OdkgMXTvPQS8wZEPkgzcM2G0jRxmRsJ9VmGO91hbz5MDLZ/T?=
 =?iso-8859-1?Q?0djt9qiVXL1zeNCTx3V80PXTVSoH/GGGhj35uDqeJ4Ls4Nj48OSsGBQBjx?=
 =?iso-8859-1?Q?XEcHIpvueSLOeNbz+TkUoas6YbHYbg2OzQI5TQ9dQxX1p1FoVOV/yoDXPg?=
 =?iso-8859-1?Q?NBalWJZk5jdd693fpNOHNwGg2rw665BRQdszgfA5S8PE9cHpx4QSQMZJvd?=
 =?iso-8859-1?Q?v8qbKrsl5/QgPrGTX9wm32a0GpcaRyqTf+uJj8yrEdofTcC6GiGldFTM3T?=
 =?iso-8859-1?Q?a7RpLhNWF0YO7PedbEBVNPHFdcynBViS2qEZXtlSep4raJk4S+LKwDewBw?=
 =?iso-8859-1?Q?J7+o4QOximPxkiZ9T1/Q5XAkiYMy/YPFwiEyCoILagtL4H0SLIO3h/cgQa?=
 =?iso-8859-1?Q?sRZS/9fD9tvm+TgFWkRHVFr59X+ykqjqFmSTUwvWwy904TO1+J/lqzUpQb?=
 =?iso-8859-1?Q?TXKu/O3K2RI+tj6JmOoet0CcaXFx0DfA/5UzfxwnC9b12+UtehX+8GJP+b?=
 =?iso-8859-1?Q?imF3E5PXmECtyNaUbd/KP2+K5JdBADslDfgYL5H3bQfcTi4sNcMzPGiIu5?=
 =?iso-8859-1?Q?KkYb/BfaNEcXaJJF7dUmDmSY2AMn+IQjz0wUidXrI1tgTxdlN3bJeUd457?=
 =?iso-8859-1?Q?hUSQ7r4HymgUtiASMvFkZEtPrP6wGtdfNpiQcjGD1NLMseXQ86DtmAEQc+?=
 =?iso-8859-1?Q?MxnB2Qj2huRnC5WCSx9EzwJ46sL5c91xdHNPWyzizWQKAoey5GnRJGY+fA?=
 =?iso-8859-1?Q?awIQk3bAJE6f1rJrCaIDGk2fGNGTq/czUtPvnNPs5t+gQcKt8RPodfonKf?=
 =?iso-8859-1?Q?S7JtUEPwI0wzwG6kSwfNn7+yhMJvS/eml+iTKgX7jjayDxcJtIDDxuhzbC?=
 =?iso-8859-1?Q?w2+nljmoo/wbpwnTYzAxJEmKBrOKneGOX1AjcUqJhpn5HxS+i4MWffy6MU?=
 =?iso-8859-1?Q?deJJ/wRkySrPa1CC3DNwuMuQGTOf3irLRl6mnjAablDloGDyFhyU/Nv+Y8?=
 =?iso-8859-1?Q?HCba5hvPAFophidnI7kRTb1dSybHMZIzKAiX/ucw7swl5lLsoVoyJcXB3X?=
 =?iso-8859-1?Q?RpoKqukVy9ja6Bc6moyd3PevETE+TKIvStehUDB0pGNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6755.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aieNzWg6tVZoTTFZhP8iKc/cRCCiTgn59eODwK6bN/q/iCPAzTt4jHSPqg?=
 =?iso-8859-1?Q?nGIpZGHcOUtqH1AaCgqMeVpDFsigCPfFdOYRLwvjICeA/bHjo+avmJdeOp?=
 =?iso-8859-1?Q?KjZH0UBybZQ3bXkL3hgTAChNsUvPYV2XLpqkLG3qdEMmBzplvjF+tj/qqs?=
 =?iso-8859-1?Q?8fJU0k0xZ5FZWgxueOW7L3dSnAEYTu7d07SDrBAaEqtSjiWc6hELDILz4A?=
 =?iso-8859-1?Q?oFbjq2mNVCRSvB6tiKO6y5KwOlvjOUwHt42WyyrjrkCNWi3Lysq32Sy70O?=
 =?iso-8859-1?Q?NtNO9Qu5e5DIS7lXBxjStjLrUnbTxYtlNzVbuGgGNHQYWTlJe9hnOHH9bS?=
 =?iso-8859-1?Q?rLoEadD1W0abhtierkB5E5ARZOxIhQ5jBdqRu9lfVagqJU2LXgohe9+4Zd?=
 =?iso-8859-1?Q?onanxhd5dGWHD5VJUyL49P9ZjQ12Hev+BMOs+i7Cj0QvwwFttbGdllk8w1?=
 =?iso-8859-1?Q?Hi3NcgrwGYi6D+GjhRAaFxYR07gQEuyB++3DnFVNMR3MkqRn19r+mtoVyE?=
 =?iso-8859-1?Q?AHN6Toffi/oi/g3KNKJMIuJF5QEFKK1Ipcp4G2WdrEnLgMvdWcCckXfoFo?=
 =?iso-8859-1?Q?lV31oUObXrCnxi+87XOa2AJSZKQDGt/K8HWBb1xn8NzUPxKC/kjg5Z05Ck?=
 =?iso-8859-1?Q?F4pVaQAWZC+SnSQmIoKOY7Cp85b9Bc+yJJ7PfVgkNn0eW87PyKKIorBl/S?=
 =?iso-8859-1?Q?83L/5vVHDE8TUhN0YofF84dGQqrQErRTNhlEBCPHVE7qWHGFoT5QDFVCzK?=
 =?iso-8859-1?Q?TjEEgTalwUaSQHmq/elLV69SH4c98FFPC8N35d6J7WHXtWBO3SF3F0hNrm?=
 =?iso-8859-1?Q?slxdlsCusTkkRGydVaDK4ZrO4SN0nk2xa6dBhL5RBWIx1FYOwm804jATB1?=
 =?iso-8859-1?Q?inKU4jRgw4gJhjZcy8hxMVguCF4EuvBpanuCxXYK9Pr9mWZc1aa8ICo1s+?=
 =?iso-8859-1?Q?7hEFDXAGMvFAqJwwlK4vEdcpoYJk/lcn+RfJxvH/n6z8LYPj0wZoVd4Z3g?=
 =?iso-8859-1?Q?E/yz137Mqi7UYT6iPaQsXFGxwx6B567fGruPwazObFgb8yJ23571gQpBWc?=
 =?iso-8859-1?Q?MyCequcFA3p0Nsv4S8gPAnlHtzkDtzI+g7tZpPve2p7w0gYj6oVyvd+znP?=
 =?iso-8859-1?Q?+AhVIAX6BhVOViUHaUDfAFGEvT+CDkNHBuUCeFAsAtjMQgAuamPrxRyTIj?=
 =?iso-8859-1?Q?Ux2xTxSNEp9U0js9PM/46dCOJV/BNCo5AhQdjEDubtjmnzjkH/P4INOU6t?=
 =?iso-8859-1?Q?hz3E1YyQqZPiFxrr1ZyOkCsp30H2zsYGToxfWQZItdytykUMhxF4wF1DVI?=
 =?iso-8859-1?Q?iNuArGCYMIvwobAYZX6b74NT+kpjnoEq8mcyZA0fLzSTcsusugMgsrp2pP?=
 =?iso-8859-1?Q?1sqxuKVSHBs/zd1HQPp0qqlDdtbzmcdYJVzT8vE/q09bihbuNbA1BQ2fE5?=
 =?iso-8859-1?Q?nUn4p85FFVa/RSKz6uexPjdaKxpnYhgWwg8yC8VbJXijQYk+Em0LtTs/oq?=
 =?iso-8859-1?Q?2+EsdNCIl6ulap3DI5Z26ueK/Lr6prUK3z76019e6OPWDGeKS7CdsNe4ig?=
 =?iso-8859-1?Q?M4RJ+ui8mYSWdtP10HUnf/sryXfn6hYDi9DVmu+dbqMKGf1uX5T2u/hRVV?=
 =?iso-8859-1?Q?sVESdyYtz55CTEBbcPYk0Negdj0UeXByxcFYc8fWg3037HqyEK3xS3ZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6755.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeef072e-8cc3-4127-1722-08ddfffce52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:39:39.7562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfKRT0jHJxX92++m9Y2n525QC4hSZQQ1e0+W/j4Up0K/yJtyU4Z0AcX/ps6KfAFJ758fxOliAeAV3oZnIaVDX3mwa2RTy7yuLhZoWDgMAn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9356
X-Proofpoint-GUID: XNBpU3_eYwbGBuAuU43TdO_0YX9UAKxj
X-Authority-Analysis: v=2.4 cv=J+KnLQnS c=1 sm=1 tr=0 ts=68db974d cx=c_pps
 a=ouQKzlSDvkUBIcrmkWtKoA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=nXA5WNwiAAAA:8 a=EUspDBNiAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=oVUhIcrtHg147PA4II4A:9 a=wPNLvfGTeEIA:10
 a=fGr-7aqQv4RST94IA8XU:22 a=HhbK4dLum7pmb74im6QT:22 a=UhEZJTgQB8St2RibIkdl:22
 a=p-dnK0njbqwfn1k4-x12:22 a=MURpYVOlrLSSKvKaDb7l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA3NiBTYWx0ZWRfX9l45G3CCr/BB
 ihiwLUAH4uMVJ0Dk0TkfJ5XHUh494Ba2Qk7V4PZd2fxAtrF8I8loGWKdbrx2UejOMn5RmL6aKr/
 t6bjr0gwHsCDEncgGL947ztM1lAkeHu4ugPVX46b1cHKKc42/Z+O09saHzFF16LtNqa0ghOnVFt
 dX1FPJa4MSfj1TN5ZRaRBN2r18ODfVI6mrlGG++BaEWszYAhty3U5BBsNJa37kLQivkmduj2Alv
 gc+2OspNp4Qp6jXIGlalmzS+HEFicPTlX7DXbLbls/VlxvoLsKkVq8lazlr+lDcOGRAixN1qdNQ
 z6++EkK8ynUch9ipZSVB/pznVQ7fxOSlE9u9L4Y+5iGAuBtnKeR1graAC+Py5LCizr/xqpWizi4
 WQVkFADQp4UFMYaYElpSRVQmZgbueA==
X-Proofpoint-ORIG-GUID: XNBpU3_eYwbGBuAuU43TdO_0YX9UAKxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=felipe@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On 30 Sep 2025, at 09:33, Mark Burton <mburton@qti.qualcomm.com> wrote:=
=0A=
>=A0=0A=
> The latter, the former requires an awful lot of coffee (though it is poss=
ible).=0A=
=0A=
I'd be happy to give this a go if there aren't other agenda items; I've bee=
n having some positive results lately.=0A=
=0A=
F.=0A=
=0A=
> Cheers=0A=
> Mark.=0A=
=0A=
=0A=
> On 30 Sep 2025, at 10:30, Felipe Franciosi <felipe@nutanix.com> wrote:=0A=
>=0A=
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.=0A=
>=0A=
>> On 29 Sep 2025, at 17:52, Paolo Bonzini <pbonzini@redhat.com> wrote:=0A=
>>=0A=
>> On 9/29/25 15:09, Alex Benn=E9e wrote:=0A=
>>> Hi,=0A=
>>> The KVM/QEMU community call is at:=0A=
>>> https://meet.jit.si/kvmcallmeeting=0A=
>>> @=0A=
>>> 30/09/2025 13:00 UTC=0A=
>>> Are there any agenda items for the sync-up?=0A=
>>=0A=
>> If anybody wants to talk AI (or rather, thinks we should---I cannot imag=
ine anyone *wanting* that), we can do that.=0A=
>>=0A=
>> Paolo=0A=
>=0A=
> Do you mean AI as in "QEMU running AI workloads" or AI as in "developing =
QEMU=0A=
> code with AI"?=0A=
>=0A=
> F.=0A=

