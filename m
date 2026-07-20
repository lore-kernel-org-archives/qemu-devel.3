Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E064C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloYw-0006Of-MZ; Mon, 20 Jul 2026 10:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW8-0004ow-3C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW6-0006ZV-Hr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:47 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqBZ0608272; Mon, 20 Jul 2026 06:58:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xzc4N8dvKbD9uXyIYhEfK6UQe18lvcE9RZRcTfQ0c
 AY=; b=YiTksqlvGheGHRWnrSLAHsr0paIeN9wdct37Bb7a6xfKuFsXfxGTgurbV
 z/IWk+nP7EsGHFOg97wb+v2yGtNIqK98O4VgBeqbDbXE0akp681nWsGHcoI8jR3Z
 7QIMiB/d5Z+Hta0SuYUyTpAlcMdpFgRLs92cu9677lyYuQwnXVIPkC/x6I78LDQA
 Wm7TmhJLvNQU1CiuV3mwgQJYrUm6YhpsGixARFDnps5LoR+tsMGeBktxhjsWG9Rd
 Wf47dRpMb0zWjiTYaJXeTaJ9l/VQq/c2AxDpRdaSeYKS6E+3W8dWUsiHupw7cO1d
 8TMXvuZ4h9cFZuq/AL+NrXPzBXgVg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020109.outbound.protection.outlook.com [52.101.201.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8fskdj8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue6AzeY5SmuAMW/nNVqvo3+xHcrWxOL38hd2l8vIC1LV12N1DG0QIieVxzu6nogIPMuDhRQvStbryhPsNyzRGR0r+hoxlyV8ZyXVv28iy9ZTQIsWN3rwjnJ9aC6K49h5IXNYUlGyYq4CAqIT4pTzDJ4ugALiQX7FekGRJmntSbqTU0CXEObrR5h/uQVg/amrDduo2Lp9PmoUbgi5JpMvLM1AP/XbQIDtg6Q79HODHAPpQNEGtRKoi4n97Rvd7Nw5yLLJ8Hyg+LhNcH7sRTxfJJgxof7VEVGegh2JVBK8Nm3o+9IXtkhMTEUUU40VUBYUqJEN7yxUu/H9t+vrqnKP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzc4N8dvKbD9uXyIYhEfK6UQe18lvcE9RZRcTfQ0cAY=;
 b=WeyAnTSzv5X4/yW3p6ryJPX07zw7+O5wNLYzl0bndtENpiI5qIzfzPP6+CwoOHYF+r2Assv4VWmKLp5uHa6yQ8vVdxF9TaqV/UR7yjxc9vByuSW5uBl6a/4UncpdZZZS/MABhHAzau3e6Zc6AMkTj682XoDyfNhnd6KDfqhXFN10ENtBSbG0CueEaISdx+bYfoBLEmoQhtDrwwfhssZUIwU8k8A0krd4OXTdffHRSnD1RNkMIEScE5+vVQ2lExRYI4ZGQAe7U135Mz6A1LQsX3Y2+pIzG138mfch/6AGX8shEc+BYqVmZ0GB9ezE7lAhUmnu47YhUAcNxzCmzEbvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzc4N8dvKbD9uXyIYhEfK6UQe18lvcE9RZRcTfQ0cAY=;
 b=YZ0cG4z2Fd/2gO+3oi2vLvykIIGvVN55Bd0S4qJkZcQElcEcvAD9xX139dpbm1KT1bCDuzG3V8vxecdQtQObwd7RCIGhgizoU9ygnipFW9bRQjXljRG9IE4TJW2RzUB9rcetLKB+wT8Cjcd8fcgt4O6q1+0qqCmuqdb1krIDKCmYRnKBt/BBzDhy4y5uoMQH9fsFllXBYlG0M2zXjFEEJEq63esVMRgsuETrdPQLgNO8DVciS/IArRPFqpNqso7yX441bvVcQsGnvI/tCHr650r/z557qV/iB0iofKr1ysJNrYDw3VJ48CW+20gmZOCfV5HcrAwVY5P9Iz96flS1uQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:43 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:43 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 4/6] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Thread-Topic: [PATCH v2 4/6] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Thread-Index: AQHdGE/gQXaeAe8CpkGp6EoaaO2i0Q==
Date: Mon, 20 Jul 2026 13:58:43 +0000
Message-ID: <20260720135823.21070-5-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: 5d8937cf-24b8-4e56-e4c1-08dee667029a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zX1xNkI8PykuhZ33K6sNllwSKqGMoyg0wAUsPq2O0mJoe4q8xWoudcQ8regOwuLkfKAuCq6A8qFMqBeFJlNHe3HUUY7NCWsH4M+UJgebYXsIhrwG5KdtlnHhB49D2Z0f9rf+CQMQ+NH1loD7rRWeLoa5KFrXnJEvs4bkaee9/bo88tHxgwWTgXFNS4KPdQVGeXDizQv5Lhn5h4yQVz1aNMfdYxBpeXZqvUTLuRzLx+1abwCnpvYr5yQg8FUNDMQfJAGRFrCm8wSdhyh6X8UKdrTRs2KhwJHFPIkUAetCG+5kLGYh835BNygA6Vrk9zGOpYsFxTA5+kpT4MCrh8FvzAk5CYM4F3NQgjoqWv0D54QGhRm43b0Kg2dCBbLajYqWt2WTdAYaBrX6dSLH6lvIpAEjUAlimI3kDim//fTIcASRp96PSqshhVLEopQ9+VqK0qNBExJecKYH7wAKC6ZXokyPe0rXDHahgN5fC1fYUqWO249jnpzSWVprnqCJdJOWc4qKLgVwoyY9+ZrW9tuIcrwdwiwd/J4NmYhBh4XVr9AZXOyOsIw+aVZ8Rddd6bGB0y3dPJwOA7TPZ+AGKCEiFyuEsxK45rG5wZo9wvnovqUPVqlPaj3K/qcNsvAfZ7fyT84b3lTlKNoRg41e4kWySe/wN9ml5KzBWhD6JrgkZMZPKqT0Bw2eaOg7hcOzxErFEvx90szJVh3U5jW4CrNDJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?awumcNoDIRz81skJTupYMGV+auyh05M97zNtU3ypwAjPGfGlhcCjFxX0da?=
 =?iso-8859-1?Q?MBLVw6FNkIPWgmXKL6fSOQA9LCn70KEIsSQcHHvJAfliwS4nc44LrOmgFA?=
 =?iso-8859-1?Q?1ewhmsVjtNG8RYaBtYf6ZqLPsNLJR7MqL7J7xN5hR5MRV1AuUuVAFouUVK?=
 =?iso-8859-1?Q?Y1LsfVY+Etf+4yWXIXp35vINKtyTt6A3+5OBn9MznEhHQjIf/xJ8KX6eqF?=
 =?iso-8859-1?Q?rgcbTRFxrQMBBVxwvIifSWgWn5JXli9mAxNxdHllX85Af631oDJxoQlBjI?=
 =?iso-8859-1?Q?qt/uoBNP/wu8ATXpz4OgAI+tGhNebQeKnYt68iW/wr2tti612CzW4ki0yA?=
 =?iso-8859-1?Q?lxs7czMFW14guflUu8Bn1x150r2KvGTdAJXgRpkgKIS3zMjAfwUmpsx8x3?=
 =?iso-8859-1?Q?6gaEnxI3qFPSXUAcZcnA0BqODy2WxjnFQf8sRFIguY58owV/b8w8aZ+/wn?=
 =?iso-8859-1?Q?gVrzdGJwJfKr9+9jjt1Ri8QDVZG3bkByGszZwFfYHVFTDOiAT5SLGkSZxj?=
 =?iso-8859-1?Q?3uNbmrTggYdG73XFGCiE9aO8/bzOBzjcKRJyAnSMXwVhXcngH0S0x2Umgi?=
 =?iso-8859-1?Q?X0+Cvy0PBoWHihtzxFfTcZ+8qCLTHnLl09XsxdbGuwXBUg62hLHYISx5Ef?=
 =?iso-8859-1?Q?HWcto++n04mYQxPJ4LTXTs61sVUrNk8eIbhGEYn4ZklCET2vO40O28WmD2?=
 =?iso-8859-1?Q?JZZYP3Fa+S+CqlrAPGvt05bljmmiac79mZFAay1dY5zaedDc7dTdn6XmQA?=
 =?iso-8859-1?Q?UZYwABAyVd5TF6OkpzXxhK34vaAGSY4U8PfaSf7kcygspaYZop9s+3z8KX?=
 =?iso-8859-1?Q?gOQKm+4wMFDPqhDlw65P/UFEcXHbPQ7oRKYFO/EXUKCgKEdM+w+qF00pXF?=
 =?iso-8859-1?Q?r03oiUYTnwMcBGlf1GOc8ti6V2bZn7rmaEC88QG/vPash4PTQ0htoQPkca?=
 =?iso-8859-1?Q?Gis+9sg4A52rJNFlqVw/A2SiKJSG88kzCQA+zLAWgrmZKRBvK1+c6w4sb8?=
 =?iso-8859-1?Q?pTimUuGUcfgstT/dGk0ZYEyJ0GqMPB6V7sG+AGtFkvrIIyRr5diMyi8b7u?=
 =?iso-8859-1?Q?cw3OHbikRbMLqktPqiEt1t6XtDmcsn1rDcW6hJxoqulktTBTTTMjrpeeJj?=
 =?iso-8859-1?Q?XBUZtDXIW0lIM2jxMDiZUnUGEBDwVRJ14l49pyF0/NJdollkKkUNXGm1S1?=
 =?iso-8859-1?Q?cPan87t1xthFovSV2l+ocf6E1BWtiTAhGr5zsKkXg6BHrMmqP8qsm8NKTf?=
 =?iso-8859-1?Q?pvl3vOW5Rm141C5VC1xRuA9jkS8L8SRwBd90CvrZx2bE/ZiWkiJ17qhybJ?=
 =?iso-8859-1?Q?y0hRBfSPBeuMFMJleRXnqLnp47q1eL98hqPVFtEFYbmpD7nu0K1OVcEVEw?=
 =?iso-8859-1?Q?5NzbBNYWxCJUAiXYbUvzhYwy4ZvGvowszUAI0rOzWbcn56T4s8U9pXxQTm?=
 =?iso-8859-1?Q?nweQ2L/4DNYmg3qUIvvK0cvJc/WSFNZH8oYhvgfRx0xRTEaYPXdp9pS6mh?=
 =?iso-8859-1?Q?s542qY7qEPQ1m4ayqoMJEE4n3t0IknXmYU0uOjvUfdEGleZI6sis5FvjD6?=
 =?iso-8859-1?Q?hX6Xs1iNd0Dsu4LMU/1mkOgVOtl7B9FSOHJEdlnD3+5Fo0ZVu4PYj/ZA38?=
 =?iso-8859-1?Q?3EDv+H2pmhCGWVoatcmXjcna/A5XeFTwCkx2vREFxr9CCPjuRq5/z/8XqL?=
 =?iso-8859-1?Q?UfSBFRwLFGXOCg1cpVZg6NMFgX1jARLTNL5yURxCX3kYj5Fsn4swvbEuhM?=
 =?iso-8859-1?Q?ANLAWsQ8AKNImtUcRWaP0B97tjf9hZ1eemgy8PBbQPqCpLw9LgoWnjb+Z9?=
 =?iso-8859-1?Q?Sl22ZZfvEDoa0PQnoSu9DG2RuLMQZvE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oNO4dwlKJ+2ItxWvl9gsMXwHouz1ioqVKc9ifxzgSXtuehnf7AJcLiTGQx+JTPjr16j2JjD5VOuYEZE7U2jKiBYWUfulwDikTEYAsODm29zyxPIylTXlqS1JnTKCX7aXog8TEONf9Ac0WqWGG1HCVRw5LvQmDWNiNY+BVSlmkxVPvjtjDv45OxsmpopUMNLhcLFv7B83JQswJjzr7tSmvS4jz7sXXlSQOHh6YDlYHXCNRpeE8gkRYh197QKVM/m+8+KirzPTrO+7oq1a/Rq8A5X1a3fhmE7tReTsJhHOwUJ+SqxcfwW2ibZfVlmAOu1hHJ6Cd48ULOJTn+0cpa2Acw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8937cf-24b8-4e56-e4c1-08dee667029a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:43.2219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FiAb+rfD6usuDE8U/VUf9aul3rnbb5LRVSdEr/TIeZP+ultydM20jSYqGqJ5uvdnGvQr8PBiLRRfux4r98R5Zunltsh6K2JnWQDicJzRvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-GUID: G81HQDvmROiDm3bJjJGU4CkO-1aF9sNL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX2DKZKTvPC8DZ
 7Q3SRRy3X1GhTsLCQs2WIDZBDotfIX0cq9s/Tqw69loIerWepIMT487Ew+wUp9vyq6qRLukwbQJ
 FySbr2ee+FRR8JVgRbhFoEVCNAS1qoo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX0ubszajCrMpq
 a5Yx/INAI+DcKCAd04SMx+p7FRTkue49j8a7Gg4VpgYMxPYTn6pOAU73Q8CIOQgInR8nNSjJAR6
 YiO1ddqg85zDYmwUP59Weip+DXuhPuBogNqWQIbgGHIBHjPjBySosMc9wBuxSEhVdwebF1qdAbr
 IH5lCbzkNI1ePDJiEpKHcfIrBXYLudgIC1OgQGSZC6/BcFtPXBhwgwsn0giqUIsPQOm1UWMM56R
 Z++xjOsDpKKwdvCqENvVtWpg/frkqNImT2lPGxgfXKasa6wAXPjpQxN+heQf4wAT1FAH+/qlFoJ
 lFha2/H7N2bvNLFXjmYNwVw7JcwO0ZdEuvTSo8r2/0XQ5QhjiOC+j+Ja068QbTRjSmi77A+vgIq
 gL35yjxX3vXnBAfLu3W6NwEra/1dcc1IaiTaepvg4JuvNyk6diBE4opD0xI+sjwF+1S2vciNRN3
 9GrrVCgIH/RVo0jNGPg==
X-Proofpoint-ORIG-GUID: G81HQDvmROiDm3bJjJGU4CkO-1aF9sNL
X-Authority-Analysis: v=2.4 cv=Ifm3n2qa c=1 sm=1 tr=0 ts=6a5e2995 cx=c_pps
 a=9zeqhqFsX+GWigQuve45qQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=Wq__iFXxit1-DUNQLyoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

If the vfio-user server responds with a value larger than max_xfer_size=0A=
vfio_device_get_region_info() blindly uses it in the next loop in=0A=
g_realloc. An value larger than max_xfer_size is anyway rejected by the=0A=
check at the beginning of vfio_user_get_region_info(), however that only=0A=
happens _after_ the g_realloc, and if that value is excessively large it=0A=
can cause g_realloc to fail, so check it here.=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 3d12e8b2a2..008e5cf687 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -170,6 +170,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * The server can respond with a larger argsz in the reply to request =
a=0A=
+     * larger buffer on the next iteration via vfio_device_get_region_info=
().=0A=
+     * Reject values that would trigger an oversized realloc.=0A=
+     */=0A=
+    if (msgp->argsz > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_get_region_info reply argsz too large\n");=
=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
     memcpy(info, &msgp->argsz, info->argsz);=0A=
 =0A=
     /*=0A=
-- =0A=
2.34.1=0A=
=0A=

