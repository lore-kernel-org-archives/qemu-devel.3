Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BFFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDo1W-0003pf-NV; Tue, 28 Oct 2025 14:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo1I-0003jD-7S
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo0w-0000Mp-Jg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:07 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SFVX043264077; Tue, 28 Oct 2025 11:01:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=2wLmN/Yq8oLDn
 IZW3mbmfkYwbCTP+ySmkH5lMh0JQrM=; b=uT7RYKq/WJJ2ruVXomwE8UxcJISu2
 oTBvA3b0snRIvt0eIfIFnXt/cT5ssXERMHMWsOZSGVAfOon27dITBhSsg2KWI8pD
 0KFJ4ZC8RenZ2gHt+4VhjDWy3oDzwtFYKzofnVDPIdNRJhCLNdohrgSCgB5u8A2r
 Ow0x4s23opPfmCtl1bjQzNAg5iu+/KRFDR2F0hii4p1+KLjcimTZiHqWDfnmZs2I
 VwDAoAXQZq0xct+kb7AcCQ4eDiMSQmf7CevjmMuF5mmY8N7jnDro/vuign3zdHN4
 sIyoypUG1GqOYBgpQyvuP5yu7l57pSC9onRxclVQe7b2/oWm1TO2XyQPQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021109.outbound.protection.outlook.com [52.101.52.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a30j4gcqt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 11:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1YYch40DVE5X/Ng9+HIOmj5KT+ElZlkJLuJLQU1E0jOF66QfdktV9THVkr0bQYhVP+fXa4rdoySbqwMGAAFXYltfRxkNP8IKIu1ssX2JLMAd0dXX2UCRWxWz4fzBx/zEkyeSll+U5Uoa+G0Wd3/Y98VRfzEtlCchDptRR2BCSI74kiv9OB+JlFDXBy/VFXYEDyeZFtkdOU3h5orXjyGO0rRgOlWX7fcUXRTi8+2y23xAoPkl+Am52KGATp15p3hUS+qMlHorvQmqiH2Ama819SYYmcZUtO/l+YVJk8a5c/V9ZLHNvT+CV3MNiXkHbjgJtD/LRY2DhI38Uqtn1/7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wLmN/Yq8oLDnIZW3mbmfkYwbCTP+ySmkH5lMh0JQrM=;
 b=csKAb04+DMaI1vWyf/hsXAfBIb/Zbi1S5G6kOAhvakJ5ZYmBuN7IwsQmPqMh9bHg0U3HHon5G6puKnvCQSAtF32rMTVKfeJj3qeRV6ddIHtNadXpEYkVd3TIVdy7H6+0nyz3ptoDBTkUGWJfuAXqniRUkJ3+49b6SGr24ECs4L+6snXqoBYrvB4oP66eEw9gYFUlMjfHdANiERUNneCTMHuilquTODMv3w7Zw98hUu07UApLMJNjx1TXnwHbluQAIZUiOFAVjrRYsBbLliQuYIESXvHrq4p7Mt49ymNuu73ZEBupqdqZ16G1jJciC65MAW4XrH5L+1apkQuPCncCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wLmN/Yq8oLDnIZW3mbmfkYwbCTP+ySmkH5lMh0JQrM=;
 b=SxOTiw08sbUDoGmHtZklL2bm3q/Rzn2lqO+h+vuDIdn8Nja07oO1ppQraEWAEFtmh2mV9AqLY4zUtCP7IoahB7Q/SsQ/jgl/B1x5kKC9y0F9Hx78UD3nNix+bUNQ+1mH17WozAr7VFTCU0dBuIoIV3hECPpjgDRWsX9V5PGmjAci+gLId905bAbB3KqRNC54Yqmq3ya4eMhkTBPrxkFn2Xxx8KvNPhlh1rDod28Hap3YFXb0foGERTevmKRIZDinVbjk9EFUCBYdDbMlq993+3eJziCL83BnTF8LhYpOKUtybZMwBDqe+6ZWd9favw0JK+oGLu0ZiTjKYseBfhpxZg==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by MWHPR02MB10548.namprd02.prod.outlook.com (2603:10b6:303:281::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:01:19 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:01:19 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "minyard@acm.org" <minyard@acm.org>
CC: "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, "corey@minyard.net" <corey@minyard.net>,
 Jonathan Davies <jond@nutanix.com>, "cornelia.huck@de.ibm.com"
 <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcSDTcGtSWPs7JF02v94olU9TuQw==
Date: Tue, 28 Oct 2025 18:01:18 +0000
Message-ID: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|MWHPR02MB10548:EE_
x-ms-office365-filtering-correlation-id: 385fdfa1-d18c-41f1-802c-08de164bff09
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wiw5f3yR2jFDkBNEtKd/KZBkkMCs65hfJEfPyzSiiNzveGkGrO1apqzxZg?=
 =?iso-8859-1?Q?iM5XvCwqIPK788mfCv+bh6B1LvBDWUWepKuQE+yDKfLr9WPYl9+d2lv6Be?=
 =?iso-8859-1?Q?c48z6E3jD3HCwh4dnCtsAwaEcdJ8IGBXnNEP5hVQBmLQzfRVLw08ZINUOh?=
 =?iso-8859-1?Q?mPqaQ7L77CyJ2Cfk/eRfYfqrr9HJPPkVW5epoyxqIhs3hg8Cy4AUaUixcz?=
 =?iso-8859-1?Q?ff5W19l+zCSp4ToBMgzyu4aozgcvo+DBwWc9RFzxzYC1Xh689/q9aIdHvI?=
 =?iso-8859-1?Q?Tp7vsEawM11ObL5YWtxA2CS9UEkXG+dDNEyjAfwgG5fdhxgom8f+SVMlEI?=
 =?iso-8859-1?Q?hPV4kKMPsr4x4lTH6JRl6iETqOswiz/4kBpZa9TM/OyKsWtVWXJRlXyjbY?=
 =?iso-8859-1?Q?ccVYk3dteZu4mIGNW0Q3t7ysshM5nILKHONht4t/XWuZjnpA9T48oHvlXd?=
 =?iso-8859-1?Q?1kn4I6qP6G9EyvoV8XRtQ+unFsXm6H0Ebz1ccFqRUoPKIBhd7aUMhI87AZ?=
 =?iso-8859-1?Q?CRVti8j4hAUOdp8FPfskU/CiTvH5JLs1fu7L6e49JeSBQsZmI2fZQB0iW2?=
 =?iso-8859-1?Q?tZf0DWv77UZEaQ3kjIMuJh7HETqwWmdx2kU/8MlaqXz3goIyajL3grbSCa?=
 =?iso-8859-1?Q?Mp67QnfnzrRoh+JI09FdREvqtihVFHfCDqmyJj6hHeBWXfJ9uz41I59fEf?=
 =?iso-8859-1?Q?8ti31rIg2eepfq41DuLcdPRuDnq8DStLQRDMngu0wFYz55ldAMMt+AnZuQ?=
 =?iso-8859-1?Q?dD+esNx6TyWpUjA5RqPa72dSHdheIEzzUQq37VdmfmpyfC0RKI5eyhmdH7?=
 =?iso-8859-1?Q?+kRyCf1L8Q+zU6kvUBdAIErK0L8yE8/R9pQ3umk30zu0N7f5tUyPpM4YfM?=
 =?iso-8859-1?Q?7EXo2NeAYo6UMSp5zO/Nj44TRE9I804F2pp9ktyTVVqDmjT2HqIyJPGhDo?=
 =?iso-8859-1?Q?GNW+rxlsnxWK/JOxWIGS2Ut2Hqrq7zMY4BJg0CsbCt8i9maW0aR0gvjU8J?=
 =?iso-8859-1?Q?hpSNSIs157LGLzVc+OFo5BYxExD8dzSO60ONMZaScFKjrbGSUhUUtswOmp?=
 =?iso-8859-1?Q?55McnbTLarEYGKHWvokcLJlh1/RcY+EwPUZ7UsJOC0sFtFBhxxLFVmo1zG?=
 =?iso-8859-1?Q?FTZbpEbUdTedqwVwJja3xukLGfZo5XNJYpeGG5CqhgYLzQp7uP6ltQpzOB?=
 =?iso-8859-1?Q?hq7lA/uxAlxLBFbPqujnDY8o6W+8Koiue86lfiNirpxpZYRPjEHPd7uQtU?=
 =?iso-8859-1?Q?NLC6mYyRjDEYXpTlXEX9o+CIe+RwwuaqrHYvvm2Uf7PTng/WAwd8mFdIsu?=
 =?iso-8859-1?Q?QhH+duPfUs7poLU7OfQDo0eUjTBqfamPYnHRJTRDGlQZilgn8xAJJmYaeE?=
 =?iso-8859-1?Q?k8l4dMYGn6Lb86nMjuK+jOaejTKTFFMSxSVIFjShZ+oap+LD84ubHvfn9J?=
 =?iso-8859-1?Q?0a8e7wshBws7YHTsi5lqXohrvEQdYeKR7HttQ8VZocLgkPkhslZfR0lKrM?=
 =?iso-8859-1?Q?ZxPmIZmqcfI6Kv5WyZC9hMF+ilsysbO/tFIY0Ybh+F4ftmtzjZzBpucIHA?=
 =?iso-8859-1?Q?qt5Q6RyXnUUSLA+DlK95FVsPfN9L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yZbnLZRnNlW7UKeVlz9W6JiiU+UJnwMdLjwamXlKkPNDxzkRr+duqZxa/w?=
 =?iso-8859-1?Q?p7+M/p5uNBWLWHwk3Y93Yvp7eNWl3t/dqvWx9WuVlVNoPgqK0I3QeRulxc?=
 =?iso-8859-1?Q?IJ7ufBsO1xXq70n0nnBd2cdRN/FftpNJ9CI5T9F80mniGfnEtPdLW3uGVI?=
 =?iso-8859-1?Q?Pmm8oj/81NIM+8OpwQF3vqDZe0ARlKhIuzBaCvlabioFLoDZtSXC70HHl/?=
 =?iso-8859-1?Q?2DxcXirv0o1gkGyeBzb6BpFvZj5SpU4ZAi2TL8aCubJb0mlucnf9IaGNeY?=
 =?iso-8859-1?Q?M03B4UGf31ML2cyDPGNphLT8NJp0tHDHUSNE55UvcRgNCLIyhCtkxVWHZF?=
 =?iso-8859-1?Q?8CMfTpo8hhKFur4hX/6pyOde0j5cPN9lpie8Gq0Mq5R1o8Adp06ho2VJgo?=
 =?iso-8859-1?Q?mMYYPuRW4kEetG5Q4NLOeP+cT2qDLdWQi4dhwQct4QLyGBSBgVSPJiMAiS?=
 =?iso-8859-1?Q?l0O0UbkT4rpwvPk9MrS6fzABQ1hoPAf8mN5U6qWquy3eF5U8NiBVDcRR/N?=
 =?iso-8859-1?Q?O98NwD04RTYmOpAx3woP1EqSI0lK7ifmSRfv+p8CPtL74mgW0sbbELldVj?=
 =?iso-8859-1?Q?NqWWrMTBZ1MAQsxeDfV+Pr7424iq4tlNFTUaQTGmhoq4Ho2PMw0kKx4BQs?=
 =?iso-8859-1?Q?CIG7EhuYZEGIjBYsznYN/oljyFaYvJTVzFr2fWtJob7pxr3D517qCZmdzM?=
 =?iso-8859-1?Q?usyBgviJEXpXzIRBza07ANG9kjpEC2Mo8LuYQGP3wmm3fZ8TKO8ZQ4Six/?=
 =?iso-8859-1?Q?/60lDIi2S8VetqkB781Lih65vokQaSHx9x9JipvuBsFsO1VX8kbB7BUf+V?=
 =?iso-8859-1?Q?99PjOCFh/MaoHlE8i5A8yVO9LBkLPvRykbGIbRIT85KQZXOVoCUPH2O1Nq?=
 =?iso-8859-1?Q?ScRwIyyCSjw22jyu6PBIkFytPttTFOINV2IqaQ4cu5hOiwM+yexrOkcLFY?=
 =?iso-8859-1?Q?hYIyaNNrRJr5Ol9Avk0PiniVjjU7FheLYJkQMDFwRW9hWgch7QsRHgiycL?=
 =?iso-8859-1?Q?II52+u60geaMbrzjQeJMCxsh0wV+b+Y3i/kbsvBfmfmubtwCROxNGnAPwN?=
 =?iso-8859-1?Q?aFm3fmF5R3I+MyvzuiUNsGcEHL9tKUvxz16PTrwjOHnZvjiS8ugApoR0Dg?=
 =?iso-8859-1?Q?j3in1/mpY/uawaxyKBECNL8xT3bpNZZVPYIBNMFXCQYh42+iN2HE7YeeAv?=
 =?iso-8859-1?Q?3Y8tDTwHTv+kVLOwiqDonqUbxc1QGgqg+CeZ6zyheR/MiUBhDzweVEi0ss?=
 =?iso-8859-1?Q?QutzQfSqFxKX2UjRhAg9ko3oF3RYCGHK5LTFt8zWpuoWAL9oMQsdj4mY9S?=
 =?iso-8859-1?Q?T4Ufpk6uG34WAxkYegrZAXTNXuxy+NIUcO4wKQB030IlrukuwTGsdio7x+?=
 =?iso-8859-1?Q?5p5bvcQBvR46TZ/57WYnyVnMOusnv92u9UC8AaVtnEiZxGiPZ5dEW+APmt?=
 =?iso-8859-1?Q?U1yLKDhFJ6yYKN3ZaBxAlFLVaHeaTQW3B64t6f4zUDRj3/M1rXBjeU1Fud?=
 =?iso-8859-1?Q?HbsBDzI3j9me8jDSMrAwijaVj4rkBPOH0BPj1neAAzg1zZgJ5ugHGImRuB?=
 =?iso-8859-1?Q?0Ojt4cAfTYkn5pgXy7U2CzkHQUDZ78jFusGqj+XNmiVqHarFaF+Z2pUSJd?=
 =?iso-8859-1?Q?GWPN+6gqamJoa6WsNM1y9HOIlx8jFTWVnS1AZpxXrhQdlVnn1tinVmVA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385fdfa1-d18c-41f1-802c-08de164bff09
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 18:01:18.9944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCHdMfG024fhui9o+Sl5YMUSTA9MaF1rp8AkYsvNLUGRP23IGo1mIJKn7ZCBwvL9jeTkQuHXq6ZnxCyTkbZJ3KjSVGyBnrfW1KY0TktfOHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10548
X-Proofpoint-GUID: TyX4awx9DMMnDyzEF_tsiZs0KfFB87b8
X-Authority-Analysis: v=2.4 cv=FJYWBuos c=1 sm=1 tr=0 ts=690104f2 cx=c_pps
 a=eErdSk/Sa828lcK029XJ5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=85p40aRc7rCO_LEz8wYA:9 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MiBTYWx0ZWRfX2LUGCxeUlPfg
 jmR0DbqOeXNZP5P5ohCOF+kJHH/OAHPvdl1t5i4zNpeWXu3Dqg2YZGeHcVp9HB+VjaG+2zjGsRV
 RS3+fNgOJpUNpnEnK4LnPCDeb2+Ju9Cw0ahTcm7uSYkjZ7JleJCcBgRxFn6N6BqfpWqoJGUTtxs
 wGU5+LQ82zjXVkvI5DpVbBpkUXw73qGATl5HPUG+waYy2c7vdmzneeqS1wReYPEskkoWFl2pot4
 0oGHwOLygrfHRW3yvARQi6lIH+57ANnas6eHZndvEpbI9P51DaYMRznkqG1D+WitlF0MsmbHXYz
 OSolViaMMtFivDmK4jTzdV+yI/CbwrU+2zVU/nL4uE/65i2kltpZQZa5OVegIV1XJdwqYMLVX/g
 +xZi5znji9eK4DIiB8cUT1OOOsQ2qA==
X-Proofpoint-ORIG-GUID: TyX4awx9DMMnDyzEF_tsiZs0KfFB87b8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001 autolearn=ham autolearn_force=no
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

Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.=0A=
Although there is no real LAN channel, some testing processes which=0A=
require interactions with BMC LAN channel will become easier.=0A=
=0A=
There's another device `ipmi_bmc_extern` which works together with some=0A=
external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC=0A=
simulation can be achieved with `ipmi_bmc_extern`. However,=0A=
`ipmi_bmc_sim` is more light-weight and is built into QEMU.=0A=
=0A=
Yunpeng Yang (2):=0A=
  hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config=0A=
  hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config=0A=
=0A=
 hw/ipmi/ipmi_bmc_sim.c      | 407 +++++++++++++++++++++++++++++++++++-=0A=
 include/hw/ipmi/ipmi.h      |   1 +=0A=
 qemu-options.hx             |  26 +++=0A=
 tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++=0A=
 4 files changed, 567 insertions(+), 10 deletions(-)=0A=
=0A=
-- =0A=
2.43.7=0A=
=0A=

