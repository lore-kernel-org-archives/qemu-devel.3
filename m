Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B07CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VXF-0006eD-QO; Tue, 30 Sep 2025 04:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1v3VXC-0006d9-EX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:16:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1v3VX8-0007VG-Vy
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:16:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HOAd032523;
 Tue, 30 Sep 2025 08:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=sKSrdytshb5tqif1g8ksdl3wY9PJqF9CpptTdvcdU34=; b=fc
 vc0MtEt9CvysLeOfQq279pJKqmbrdr4BiM3jwcfu5rdmgNao2OcefwBPy7spl8ZF
 nt1vpdNx0aNCYiHoErF/0DnUb2Y+tKKP0Pk8fO2NiCTTucwnTW6j9v3FoR0Lhw8n
 9X1wPOy+zzJrLblJ9FL5mCWfF84XoQ6DMFWlgyrCv5FkUiUG5LLlyZpqz/9oyQfk
 WVrIcwFyK1mJsBNzVgrHrMDZTxTTXLonlRORX+5W6YvyEhxGRElvyhmZNUH5fxqA
 vvzjhsVW8JuVaeSFapCzmXnqArf657FVM6eLoQfi2wc/zN+YicVj4a5+KhXIE2jT
 I/hQRGeQg1eBfIWrLPpQ==
Received: from bl0pr07cu001.outbound.protection.outlook.com
 (mail-bl0pr07cu00103.outbound.protection.outlook.com [40.93.4.3])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr3nfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 08:15:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbfOCdvJkyBsy3vgL4I+qlLSgfydRKai45b6wtx/Tt5F2WDzNp3oYP3nBi7Hw4paJXu0CSscuyh3A3ioe6Gg7ICVnnzGwgp30SyUao8Q0iV1ym6/3mFZ5VLMlf/RTM4m9zhKBsJNUllSzClnikAPqLmKOHFSw297jLNxGeh0j2B1DKjeLPKCgobc3+ozfpm7UKvW5yftjYrK6xo0cdh6hYd3rtHKBNaCmbJyJ8LdMm3coKIs/TCDCJKJB0lR/8W1Z0dFLZbOrwaE3qt6kZ3LQW+U50pcgvY18zRqc8dglT59cVM7Cw2ExrP1GoAJ3NHrYTO/wF0qNlFDjgr/N7EmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKSrdytshb5tqif1g8ksdl3wY9PJqF9CpptTdvcdU34=;
 b=RMU0AnmdFt8gs1mECbyHaXO+NB+S1xMwjtr0v/GzdtZVbHBQQeVeDz7egq1cqqfWl29cEOdK37NNL4Jn6/ycucN1FbG0dKnOuo709zJJzJ6Q60vA5JdEkdbPB2QjfVtvrfF9sRrdYxm1TFjZGpfaXQriFr1gzYrhFj/z9q2mPSNnATtU01xKeHbe35afYcuKu/lQ72hv6cFmTq6E0WglRfyVAcY86JUybpSaUvQiYCbX6Mwu02mcdIqc7ZDqmz3FdMCMv7zkeEcQdnwG3tnk/sQ5yguhedxJuX+aTGXkZhEl5XgAnodFZfknANBBnMUEOfMAgUlnGwe2hVvtZ9pIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by PH0PR02MB8599.namprd02.prod.outlook.com (2603:10b6:510:10c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Tue, 30 Sep
 2025 08:15:37 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9137.021; Tue, 30 Sep 2025
 08:15:37 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, Alessandro Di Federico <ale@rev.ng>, Alistair
 Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, "cw@f00f.org"
 <cw@f00f.org>, "demiobenour@gmail.com" <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric Blake
 <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, Alyssa
 Ross <hi@alyssa.is>, "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh
 <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
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
Thread-Index: AQHcMUJAXYUnLO8GtU2nYtvz+EXxQLSqYFiAgAEBcSyAAAByAA==
Date: Tue, 30 Sep 2025 08:15:36 +0000
Message-ID: <533EDFC7-8233-4164-9791-BACF096E30F3@qti.qualcomm.com>
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
 <87ms6cz7bs.fsf@pond.sub.org>
In-Reply-To: <87ms6cz7bs.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|PH0PR02MB8599:EE_
x-ms-office365-filtering-correlation-id: 0c9c0206-5283-4d94-d741-08ddfff98929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VH0kyrKXX5X5e8JXaNyyLBBL5UynhKI+lBMnz/iwqivX8O6qLC2j5+cCIH?=
 =?iso-8859-1?Q?/7tVFhFe76MumrfCxkXzQ8/2yvmwtU4ZzqeJ2cOeEkjUTUgAaeUfS8P+cO?=
 =?iso-8859-1?Q?safk00tas7gJQDWKDdwTwwblBVOW450ommibi81cB+ivoVFm8MxTiQpQu/?=
 =?iso-8859-1?Q?HOpzEtd6ljDXJooig8Oac4f5ViJVnE6SQ0cFMmbPIxMF/JJ43eV9FX1V/j?=
 =?iso-8859-1?Q?WFa3HVTgJ1EmZMDL4bt7kuzkqrRs2xmtMW8xwAudkMg3VNKG3YHSrwzkqe?=
 =?iso-8859-1?Q?hsfFxVM1NGTxHZKs5pBxk9DsoyFcnkf0ZAEUnRBhz+xmBfCPUyvqSH85Td?=
 =?iso-8859-1?Q?GhPU+8JYIo99zKkjS6pPIzicL1rUeMtbDZqHQsRfbIc51K3dmHLs8bFPF0?=
 =?iso-8859-1?Q?5YtsXSbJ6Vg025CQTXG7bs1bI9GfDkrxZqb8GG10uMFlBrQpVywqTBmPIK?=
 =?iso-8859-1?Q?P5GfQacInWQiXBZ5UfnjcegivvJ6ybeyhwGCYYf0yI+G7Qt45s1ItKMtrF?=
 =?iso-8859-1?Q?QfoRZrzWayzsqcOTyd+61rNVVS09MaBaIYzY/Z43XlniqDR8AoUR+BwySe?=
 =?iso-8859-1?Q?uY4LVuBjOv+GRG8Mr+rRPW0lqZwJ/lFi/YhKBceL9yxi/hKrM+Ns0yHI5Y?=
 =?iso-8859-1?Q?WcKEHKuKRKLkcK8m7VHkCLSJuQVF0wSxYWX9BOdiVFWNeXT+FZ5JnHTedj?=
 =?iso-8859-1?Q?/2ywk9SCJoI7QMxy7K67sr7PFNPFDRxbIC00Kqn/+7co/cqjJoUjgakU5t?=
 =?iso-8859-1?Q?GivMtXvdEPf1USkBqnD2iR70DXe91Re4u3FGUVWqWHJH+7ZJ+sw/JDxFSn?=
 =?iso-8859-1?Q?6ofGIMBZfmY2xd6jF+5zfaiAcfsE/9bD5U65ZoDHtABRJ7g5pGU+5Dzsiv?=
 =?iso-8859-1?Q?YxMN9RV0D5cFKTS7mroCTs175WjbbrKtx0y+Y35zf41CxpttEJr8MH2cjo?=
 =?iso-8859-1?Q?2M8zRfW6JuIl7lm03HMqSnrxRP3IdtIK1sf7YmiSkoxhJoosHsijpQ4Uom?=
 =?iso-8859-1?Q?xT8BUorA/rEOeNCo6UA4Ch6DX3zTqaOaYqDlubjaSenbXrIYMhMFdt1Xt5?=
 =?iso-8859-1?Q?VBNloH9G4h+pneGMs25riW5xmWOKpKDDvuKI11ywslGkeyQeTW3bkCl17g?=
 =?iso-8859-1?Q?yPLwaOezYZqBu34xBQ0EGsOfsiscxUe8S4QzStEW5wmKRZ77w9JbU6gvSF?=
 =?iso-8859-1?Q?c1pEf6W+WUoLP2in/O5V4YhAzp2GultdiLo3Iloc84bbxSTbA/muboxppG?=
 =?iso-8859-1?Q?Wooh1Vofe4LodU8XZFnocxlpe1CIR5ONinlYMDmq9nzmJia5rCo1exu20H?=
 =?iso-8859-1?Q?Kfw0QqV7+6lmMFY7HhttiwWx+IS0aKguXfYS5KZdCAzb+hEaw/2LlJVRhe?=
 =?iso-8859-1?Q?Ck2MCwibg+vmcUnC0dVkNOmYrOwJm11ZnwyH3r75zg1hZMsE/M/Sjf/zP8?=
 =?iso-8859-1?Q?XAXf0RHGsxXzXex1KCFahqoXytk3PjGeeaPFigfPMNlq0GnrKl4lAmxhUr?=
 =?iso-8859-1?Q?BZTRozBEtnfmG8DSzlhlQk4hKfWHNQgfVc9h4QjBeQJlib8FakdFY5RcBk?=
 =?iso-8859-1?Q?BHneBmu0nJFxmI+jQO9Qe26ERKEn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ckj94050w6XaWLEZLPChPTMNIolUnA7DvuerYtjP3X9NuoEPu5YTpv4KjV?=
 =?iso-8859-1?Q?4lRBmZj5/uMcelGyQdH71evDvGjc5VVZEaUnwegy9s6hbC67Y+Xag/ICBM?=
 =?iso-8859-1?Q?2xN2Xm69onFoFr7uwv/JCPFwBCpvv5eaeVi/bg1ivp9jK9eu8dud5uk7xb?=
 =?iso-8859-1?Q?snLzJlcCiTEStKgs1TyJpsuwXj4nL3ZXCZrph5y8YP0qfNH49LSRNuw9cJ?=
 =?iso-8859-1?Q?Z4V2hFl69NMl4FfukeVzyNgQDEi/MPCT5Tr+hmb140Am7k+jXHjqOM5UXP?=
 =?iso-8859-1?Q?4u/Y7/qSVvpO5scx6tE5En4yF6knhbcu3whKs9qNK6zCk91v/tRpOSbsRh?=
 =?iso-8859-1?Q?a5zHGw7km2qwhguSwW90abqS7blGDSk4NAhe8VdJ/55i6umCJ85LCxzV5v?=
 =?iso-8859-1?Q?Mu7UgilX2a3Z+xoQtPiGsKtbnF6i+yQ5wVhtoa6oQ/QUkBP7aROq8mPK5j?=
 =?iso-8859-1?Q?G1rYLOLRf3gSCxdK/PvdyAawow5TNMtcqvTkh5uBx5+HopxOW6Tn7w6oWj?=
 =?iso-8859-1?Q?z2n1FnGmNSXF0ufXe3RZ8cdJ4Wj+2PGEU2BR5n8PEwJu8tmRZOzdyPBQA3?=
 =?iso-8859-1?Q?Yzkc33rpYRZe+421hd/aR8vnseN0kQIFijZfcBI4xziz7Ayag3PTQuAPz/?=
 =?iso-8859-1?Q?SxNO+qeEaHr6vwqtl5hTqVo8159Nh4I6M+kTujFS5z4vc4wN+2SR0qIosU?=
 =?iso-8859-1?Q?gMrRp2V4aYr5JQ2AwFxmxNl4Bu8S+J3/Ed2RG4xS/9/Wgd2zJ+J4MGk6lG?=
 =?iso-8859-1?Q?BzapNaodRxaPCMIaHdr517dLpKtVsQd+f1KLSZvFT2GaaAM8QZQy4cfn8H?=
 =?iso-8859-1?Q?HmpfbUVfTvSrUt9no/dhgoDTKTV7MCHTeeYOMtPp+8w5CV6qsCvNwlu+0f?=
 =?iso-8859-1?Q?D4m23vZ8BC2yvKPGxTxStKsMauFvd4lyo07/kHnobe5mdE8Rl96jss19hp?=
 =?iso-8859-1?Q?Axp0dt5Hv1SLLSLqtxquK7QQ2qS3bBi1Wa56OUgGzGnsZ7kOoWsTaDm4yU?=
 =?iso-8859-1?Q?asnHe4t05La6+fXlJfglZ3sGcmlDqketRWdHLxJsAotwjz/m6gZsnzKiOS?=
 =?iso-8859-1?Q?uBuvpalBPQAbgjqyaYKJXrU3yRN58wDjmgfoH+xTDkV8bm0XhaVXiSzsjw?=
 =?iso-8859-1?Q?CfapegvDHzfw63786DBw1zPa3m7RpnIwyva/Y6kQHUWVQR7SDajlkFuPtM?=
 =?iso-8859-1?Q?YLbhlinsax7IcHAqyaOXxatlUtEKXQN11GIFZ0qQtyUwV4B1A1rbv36LUf?=
 =?iso-8859-1?Q?SswgC45MDx+qZBchzAfN+x8HdBaHcrvn6+WAM04HwZ2oOPUPw9rBu7oFNC?=
 =?iso-8859-1?Q?ykqY5PKiyRR73aBiX43iJm9/NPlBpn+e81W3HMVQy0Rt1/JYOv6JWTFZuN?=
 =?iso-8859-1?Q?f7nJT/xeeEgMwDbvS8uoaU/7apIQiLyxE1sMs49VTNBHMbru5FuEoFBbim?=
 =?iso-8859-1?Q?paFKEc9BNF83qM1ho+y83EsqdMSaDVV4Gna5fwxxal5BoiJfdPxHkBBQOX?=
 =?iso-8859-1?Q?Wt7hl0mlYy4ssSE0ipdsojfD5JtWLdhgOnqsqdTQVNMD/uxJr7xHG5hHsI?=
 =?iso-8859-1?Q?aZF+1HlWDo6bRimAwBIXMfhM0pstfAfSiX/re3NvirEV7wvKThWsOO7eQi?=
 =?iso-8859-1?Q?0ar8oSjh2C+ieDV+B2qgyALeloZob1eVgmZKkDbzi3SGDTKwhasdoCMA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6B665A6F55A8AC4C86A6D2285550F8BF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zi8q0IpVF62tFs0YsoIYUj+aq3atrHOx5gPF2EFf5oyxQNeaoNrzBNbQiovkBYiOrUGA0BQZoPlMiKqBwVFvEswznfZkTYJUVz/lIEbz/QYBq0ospMuWVY9HMDZ62pYUc4aS6YwqHdTOhFKQJM68kcOPluP+Z6TMzPDoULL2IAD3o4DrIRAN4Vgt7qWvZm6+izbHtCOfMzC6S9Zz9edWslX9Id9u5P8arwVqtSeiEKrKPjCKYHuyVq1fUs6JRJ+156i2jG5yPAEGRePKqJBLOthhlpLfPCvLnu2J2oWKZ4kU+lD5s/jEQjWaGk6/q1Z2F4J/OKqkSq2L5lkGmXuCcYYapmacF5sA0feeTIaDYpFgbiKixttz2GsZP23ysX+a0iJHCh3xjalV1BxbIZ7bfSKO1XsQ9OGKKxLnHoD1qq6v8EaFeY1EkTxsT9lqSsgQIJjm2WW/pjRVeAXHb/WSx3kOvn73w9CZe1JViWGDEC2AZyWYWQIAUSsgeBgDSomXV0EQNz1hXpIib0WAr9xK87xeP6pBUuiRfp5mDFJqQZOfTZ/joPWrkmhPQJUSLonNZP0TBmMnVUlivjBEtKriCN3s/OkJ90hDZO0ml9YH8PkpT96eVrQxhE4OMQFxkEj5
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c0206-5283-4d94-d741-08ddfff98929
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:15:36.9195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRKX3H+rnSimTbYtvZQ6yfgJXSwW4Pei2ZROh9zofN29KIrrDIWUTrBpu/h8B0stMNzqnAHX6j7nhDk6Kyu4rjZAlvNNdyQLyDAalFLfabE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8599
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX5PASJnf8MGLx
 AdMw4bFZWm6f9QjMkdFX0LbAcYK2+TeteAlILZf08XMhlkbumuH8vsu0dyxuYsF7rTIRmls3Ekn
 oi/D6EszQMUiMwwEBCCHiiiln714QO0JsuxmCiTH/J++RLcc6wHwqWO7L3cVmoJFu0hMI3+dJu9
 G5SIaVPx9jpL65rI7Xx4D7Opw70+QsS/mvhwPm5VAtu5mAVidL2LbzA4v6GfLrVky9FmsldFViS
 uydOF3VN0sL34Mc1emaniloole1Ocz73aTmvZtGrI9vWV328hL06JQDDjQyLJ8rmX0SaK4P0gIz
 eKazyZ+N6hHaKil/zbmiRPclggkQIjawve9CdBinddLaHbR/czpVV0MdL+/TgIYIAiAj0YbEgiv
 H01tqTshh8kvl3Y0lQjOObUXPH+NxA==
X-Proofpoint-ORIG-GUID: 8NXCinau3nWBBZvx3ZXOwg5pOYkNF6l2
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68db91ae cx=c_pps
 a=DaxP+68tKO9/WKKUw4C7Lw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=aXQmYNs0L3p_luhRpy4A:9 a=wPNLvfGTeEIA:10
 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-GUID: 8NXCinau3nWBBZvx3ZXOwg5pOYkNF6l2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Hey, we could add a discussion about whether we need to expose the BQL over=
 the TCG interface, and in the end, you would be RUNNING back to the dentis=
t, begging them to pull your teeth out :-)

Cheers
Mark.


> On 30 Sep 2025, at 10:13, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> If anybody wants to talk AI (or rather, thinks we should---I cannot imag=
ine anyone *wanting* that), we can do that.
>=20
> You're offering to make my dentist appointment this morning *not* the
> least enjoyable part of my day?
>=20
> ;)
>=20


