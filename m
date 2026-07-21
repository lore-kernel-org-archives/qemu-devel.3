Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE7DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yt-00088R-L1; Tue, 21 Jul 2026 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Ys-00087a-Jg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yq-0004mA-BC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:02 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARrEG3214189; Tue, 21 Jul 2026 05:26:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SuI0hrYYG9I1gzQEMTlUIypL69M25bykqFjyWtc8R
 6g=; b=VKhrZYVU1hZLHsCZ3YdhlKxX6mcfpRKM9SKsIsWTEAjrkJAcRkLlNKuW0
 LfJqS/MqWU9rQCzrLRAAwnCRfaxHp5gL0vsxfsu0kGhq865CjmfHbamwjPvT6h2y
 OcNigDZriI2bdg4+NROy2qbHTkRW5gCzqrNsrMvK97y+ISbXzZGW8PSjVXKn5a/3
 CKn/shittlaQxml90J5lP8gfwASXPj0+ew3iD3fwcYUE4M5+7V6XolzP9H0ViiK5
 svb//5XuVf6zBnG/utIRQs1CtESfIXrbctSAOqvnNb/q/S+vKkYqR0QHraKF1ql/
 ByZcebS0GGI3tUUn+eTqdiB3r9NHw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020079.outbound.protection.outlook.com
 [40.93.198.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xeana-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UncwHjxcRzPlLGEBHqv7eh2xEcnza8Ghdb9t4LuWJKumnTbAx/Nd/wJbr7SUgGfF7taThXVTqy8GlSw4u0MpKaAB/QpfYhwvEyX9F/KhANDVNhmZW20tyNl5t+R1/wIUMYDejtZ1uGqg2cBP4RJ21hmreAAEShwGVmGBFq9UYueizZjWloHJvRDb0fJLTSawNkEGaoPADBedHqRaRETZr4ANjRMiLaItlLmCYFLmTh56PtadeZRQZm1GAt0l8p0YqwYyiF0mgin/ukylLbVwQRmzD6fqa94mJdE5c3QnzrG9Gm6myTOGzrhTaxFMjkzEwwHei/mFrPJPhBya5AEuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuI0hrYYG9I1gzQEMTlUIypL69M25bykqFjyWtc8R6g=;
 b=JXaYqKH3PANVfwZ1FixeGKu9ugllFr0IxUn54Uwij31hihfYgJz0cG9F57lbFfhqPGbYGG0AGDqITX5hncgiLbu6+iH3si60lD1Q7+8yU8TToMnJlziFV4XyiOkq7c9693oojTVWgVyRk7zTL6nY+lpaV6+wisPNxQze/M8LhXADEzs40pbs83LtK0KPOlEI7ApaW2HuyKqAOycu58+Zi0ICnVo4Ts1MYyojELGu+HbAey1HqcbqGJ1CF0iQQcIWfl7yQzqgShQFLKNmlB3C/49hP9qIDciGW3WKtwfx0OmXGgWyoq/rS5VgJKzbFwAen8iONbKiGx4bC+lQUaiubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuI0hrYYG9I1gzQEMTlUIypL69M25bykqFjyWtc8R6g=;
 b=uSRi5rbbJz1BabQgZs5H9WoOQfVAwxrOfq+xndV+DJl/XXooFgzH3FgdK38MLS6zBRy9unbeckYg6UC73lEUcU2mCU8wcgcMZDoWosZzNTkExCOBvuyc7mASb0iRBb7krbUSK41g5qLh2Va7XNd0FveJvtY8P11ChcQTf+zz2a9E9d19DLqawuloAh2GCDfZHiv3to4hSOYH0EFtzVaB+2Bi/c+HjhXMI2ri3ZbDP83a0FH/jKOTYxVdNiO3SviS16yisJTpk4Lw5N9WnNm75hQxWNI11lIVGWotvi/KbBK8MM++sIa8FiH7MP794yEgipd/MDDREwaPjGyChWG/5A==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:57 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:57 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 5/9] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Topic: [PATCH v3 5/9] vfio-user: vfio_user_device_io_get_region_info:
 fix capability check
Thread-Index: AQHdGQw44wk/nalIyEO4gjaHm6OE+A==
Date: Tue, 21 Jul 2026 12:26:56 +0000
Message-ID: <20260721122643.30985-6-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 92ee9612-2b67-4c7b-e119-08dee7235b39
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|6133799003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: 9IS9PYHhzazOWDtnPkRQJDQ2nhm0iotOqaaWRN3/qjc6USTjhhR9/WPsEv7yvZYJyt11YjGIXmud2Gu3aeGKpt5/3ECvvrZ2tR3fmlBm2jnAsFB12X+LDLali1VareJ/z5njqVXLS121oX5izfP3tiV88c4p+ToWsGOY0EJxWTm9g67yNVGrJqAgtFi2O9kWwS11FwQ0Go60mQ1lc2via0FMGv1aSlIZoxkxt0hKVLiEd1zsZfy9zZlgfV48xA10FbqeTLIoAll/JTrgJB97BrGzl5I5akwt5Zp9gnj8BvnWtjY+cSELHZ6bi2T2HkjICQE99gg1lQyglz4XB3/8HBG8eTA/qNgHQy6IPSOOdD2aZMFMpL9sraJetOr8mas1hjir19PRCsbmTjPr+UM0z7DNLYbArTHVzbM7N6FJNa1Jl9egTmHAGurJQvEN0Dga2fzJyJQCOF4t9AKySTrJaFvBUxq62Uqa1+jiPGm147JVPjUx6MW0NlDnm9hg/gXJIn5vq1qRrpdCp8tXByA+bJgJ7vGXMGzur9Yjq+YokBuLQ3NU8JjCTtmy9P2eSp5qsBSMwNL4X2sVqojgDO7JDiY4iQvyWqvUsKyLTskI8IeK4lbF9xJYgIZS+Y6OVf3VJSgMRbpgryKbj5oJr7Nxk6nPD7ARKAobNUm9BvjEC4D131/SFQqK46G3FW+EwJyDIHYSAFJ28O037W8yKSCL/B5EO1xYuIemiyK3U7OAZOk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E+qAPtsKAgXYbI3UhPkWZq7wXX/IhPjaHd63EnRVSJvWCxgNgvcsp+jm7M?=
 =?iso-8859-1?Q?v7jrMlav6hJZI6ouB83ED9ySaBSU0tokGPttMGrTgen1q3eqTHE1ZwGoHR?=
 =?iso-8859-1?Q?gwJ90aBapN8dTbql2IdvC98EZiBpOpCmNGmxat1PMdD3jRR+nSd+F/6PBe?=
 =?iso-8859-1?Q?ns/70q4n9V7+WPn1REmFUFWupll3G286S99ofKNGuvojNuxai8d7KaC7Ul?=
 =?iso-8859-1?Q?nb28rt9AheVQazAoHyfrNXPLJYj0jA8XxxjknoBbhAXf3LCLMeABA6L6Ac?=
 =?iso-8859-1?Q?/4Nit7SmeRVV7ujw/9DWhRN9vMKPw2ovbb9geu+vRBoPiPHd9vV3ZfD0Ep?=
 =?iso-8859-1?Q?J+RDhzwK0MNTSDG3c1tByInS1ym6K2O/R32socr8wACrJE/vCf7Hs/92+E?=
 =?iso-8859-1?Q?YBnCJ8L7aNeQ6vUJwyPmsUnrL+B6e5IW8Y4/n5I7ePYdzlvNpWiN0a60n7?=
 =?iso-8859-1?Q?ucQg1NImgjNZMKphamyRfuIaj7uu/hSUajMsSUU+OkD6TTUSP7LBfPrrvQ?=
 =?iso-8859-1?Q?uXaAHfnLdPLcZ3tCu74wvnvLhyEiIG2hQA1yMf9Tv6LhDyauif5sq97fNN?=
 =?iso-8859-1?Q?kuFIxiczvfTYjVNF6VEZVyr7DAINktq95TWjeMhzWGh1r0+JUX7Rr99/2q?=
 =?iso-8859-1?Q?f4KJ9E702P/tNNarhDQz2iUeWkyW29p1LF1FAz3NhtHQQBYAsJRt/lu2ub?=
 =?iso-8859-1?Q?aT6jA+UmHay91i8WbIwX3MC5ivE0fV2dvqGsKEYkRB2KBbn4xlT9woGybZ?=
 =?iso-8859-1?Q?9Z7qOMgj2AmTffIF7SsnwqbfR2EgPU0yNn/iWWGCa5vQnnZcGKLY7+qNYf?=
 =?iso-8859-1?Q?nGfdSm8oRcNTLZa4qQZe2AetQiKFTX+/9vQAu2FzQy+WQ01mW5KnyeJbkl?=
 =?iso-8859-1?Q?n4VhoBozUTWsFEyNPU07Ja8pV/nX/AyiDFgNM8Nm7r7HXE6+6+pNL3jw9+?=
 =?iso-8859-1?Q?+IUPaWxcuVyuFdOEL+hOOy16jVlk4iLSGQBmSJvPcdk+5iBicnA190iwas?=
 =?iso-8859-1?Q?LngE/klaAhS0grYsoMpuYo9oydWovsxa/mJcm0BZsYRKqzna6uplNRzJqO?=
 =?iso-8859-1?Q?a0aXt96M9GfPN4RPe6XW/0NCCst06VEnvkyjQXnwWjfnHZwTGBcPozMNdq?=
 =?iso-8859-1?Q?7tG2tp9R70NNGUwf8/eJuoC0CEPVQ48XaNcumJeaYTJmgby+Rz831GRNp0?=
 =?iso-8859-1?Q?dvhpMSdNff4MsvqRDdnKd7nIQ5myGusX1ODb5L83vbauhvzZiXxbOnvZwV?=
 =?iso-8859-1?Q?0N39ysq6h0AclIdgVzNaRskdBRm2ve1PVXFZqG+GXsHiSUbWoyGPSVzLlo?=
 =?iso-8859-1?Q?oHXHcl57X8RzN1u22LYurjoTNpbSPeMCPet6AFzidVVIbS+KhtcsMlJ9aL?=
 =?iso-8859-1?Q?Vvk0Tay/vRyhPzYe8Fwbe3S4ri1dGlq6PweRwsU94kR/1kAEIpcETshms8?=
 =?iso-8859-1?Q?3eTRMNgCTf+WDZaf5gJdyKvMkwZnbJtlc5K3KvG/GI1PjglorfCw5BMuFs?=
 =?iso-8859-1?Q?eSfm5fYxpInIqtQgQ2Q7n4HOz5EYJ0fJhC77kVUdVQAx/zAO8fhcMn8PnT?=
 =?iso-8859-1?Q?CSOaDrCVQNAnx5FdUxlBtF1aresBc9dBLrjjn6LN4GWIuB+FOJ0Di18rpd?=
 =?iso-8859-1?Q?HAMzeXxr+YcXiG+2nu8Q6/uL8hVSPggfyfxdkGTpYoC/hQ5BmYW/UmIhBk?=
 =?iso-8859-1?Q?kJ1HKl5rlMM38NldEWJmzWlImR653IsIzXtST9eU+1bpqarhMzGI0pVmLz?=
 =?iso-8859-1?Q?wTIsCLQag0i0Jwr/DV1LBc9Fa07aujYfu5U3zA/ASGv/iCXAB6669E6WDq?=
 =?iso-8859-1?Q?xEGLFeu9tgcCTYZXMuSbVX8hYUfk178=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pOWLVLSShG3vJxv349q1cxiUzBAfxgW9rOgg7u1Zc5sQWpp8zrGwZ+uENAvJJ2yA1Q9EuJ9N4mHdacvDkmN7hEdEnh+9yA2ngENW4/sNcVTn7RPv4TjUkTBkPpR9NwKezIwLJWb8W/ocWgG8Ybf2DpFZEmc09b8mtEDHc59NbKblbdEQwetR/DBRhFLFnlgj+NKVXv/CM4OTNu/t1jhAKYtOHVrxTOKWCGFoy1dhOurVFIzaAj4tTw4JEdMG/oDHSe5yyIwmU4VdPtz/XBhEmTiri/bpBBnkjjVUwNB7elliPi7TwHnLw8GoIZuAihz7Uk/JCGXrPhi7K5tA4fTfxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee9612-2b67-4c7b-e119-08dee7235b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:56.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6J4A+S7WCGNWAQqqktAoqmZ7rfoIXY4UHa33GHJZy4cYpHJpb87ggP+oQSN7r1/xLhmVC2LHXuLIitHulNtyIE4hGg9Z+NMsRESku1ixXiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX3YEpl38xZteJ
 kly7hrdZn+x6mgoz+zh12ivuozL3m+FMHn5BNX0w2BM00Oz7ZKnDT7ni49SzugfhQgBV3Z3E3f/
 s0sTal2yFurIXYZT5DVneaX3JnEwskg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX3IP1HtRuek+p
 FA4kvHXPgZQokRjlkqKMp2Iq64HyXHRlH+HYoh9OC9bUJaO8mRNSlCi4fHbuUmps7ooDw3ka64V
 sE08M+xjYFUgePWnpzZd1Bp73opLybzfPpXh5YwMnb2FLYzUNpJK9A94DmAY4BEgw9VHztznt7W
 o4vtqw2uOjT8SRWdj571do4xF3SfEyvpTwKYAit9Zx9yZF6cwxddi6k+KQt7CdLMHYHK/qY/B8J
 lF8BaKV3Xg/wWYvbLzrsyODfmZafQi6+75NGl0N098Elw+UiBNrwMEuTGyA1bxOylUOeLNN9AvF
 8Ut3SqImtVecFh4RPWbfXfmikqIXft+KejfNOorzQSNkuvGcVWtNbXRvVfKmGv5NK+DH6+XvT09
 YRW5czdP7i0kOHAM4YLoWVX0rF9cNSCHOSZ7iWbCTKLlA8pey81ODt5HpUM4TVp6QiYTeq3ti2T
 9Jf36poyUUjeTuqXO3Q==
X-Proofpoint-ORIG-GUID: fP1mzPf5wbV0o-PA-HU9i_8c7LMNrKT6
X-Proofpoint-GUID: fP1mzPf5wbV0o-PA-HU9i_8c7LMNrKT6
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5f6593 cx=c_pps
 a=iFZJ8MWJ1PfqyJABywbvdg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=omYdixH3HiAqfKGu9RAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
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

The existing check for PCI capabilities misses the case where=0A=
info->cap_offset =3D=3D info->argsz, which results in accessing unallocated=
=0A=
memory. Fix the comparison.=0A=
=0A=
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO=
")=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3865=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 008e5cf687..3d0dbe8406 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -214,7 +214,8 @@ static int vfio_user_device_io_get_region_info(VFIODevi=
ce *vbasedev,=0A=
 =0A=
     /* cap_offset in valid area */=0A=
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&=0A=
-        (info->cap_offset < sizeof(*info) || info->cap_offset > info->args=
z)) {=0A=
+        (info->cap_offset < sizeof(*info)=0A=
+         || info->cap_offset + sizeof(struct vfio_info_cap_header) > info-=
>argsz)) {=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

