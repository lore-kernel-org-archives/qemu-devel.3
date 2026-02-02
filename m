Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE068E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvce-0007cx-Ub; Mon, 02 Feb 2026 10:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmvcd-0007bw-B9; Mon, 02 Feb 2026 10:13:51 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmvcb-0007Wr-Tk; Mon, 02 Feb 2026 10:13:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as7LBNj3HZJK6VaukKzajSwZIC4x/hjc7VDD7ltk1kK2EAh7lpDg3piVxOHm1YOJXScFfLMsTs4/tt4g3euTovpLzhZXuUohB8UREOZ6w7pZ5VvjvKFGDkRJ+Nucrp/NHUkjlzOCVomItG0VfWpLXvlJRUNHI93xQnvHfkS7C6DDhE4H2/inx7fVlQS1p60iHNHcXF6+l6raapYIG921uauJmMcJBqYUnkakjviNrhv+dBygdBKzUfqD8g0o2RtCkNiJuCzsiv+Y2+Onn7NPLEvCuSIuMghIn2znP2/BGBRHBisUrxoi51Xhlsh9HXyLQapzJBFph287fdsi/arGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRYiyCWryCbDVQDeEJRvC1I7F7v0BIpShTkwiJfdEmo=;
 b=tu+cfdgJSXIlTr+h5fW/ayaTP563q/TNhmUCw2Uv7y8/6kR+hjvoDseuCYmNbh8l+2Ygq80iXDzEe2cIW+gvQSVecH0o71FZWFe45kcY2vnsVYhHCQyMjj0rHWL+BZaX/T1pzZgv41oJYEHEdH/2bPzYbJ2N6qMvg4TtYdRCCSBN6GbpwJDyZuxyrimIJSF/1jx7ATjlUhiK72HkX6G4ldlilfMBaobpwZvZpoEWBF8xxM3QDbBeISi1A7k6/5TRWnBc69LAiFRG5E0OUDhkXHNKJXAVOpWrlmZtISXc36uY/yKcXXwE85AvbRpttbxNeyUK2N+iG/SaybBFounKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRYiyCWryCbDVQDeEJRvC1I7F7v0BIpShTkwiJfdEmo=;
 b=kvDSqmBnizO+GeWpfPg++OlsuJ4CHQLuvKRMlhDX8yEPHxe6Aym4wQZKG0LvN4dlSiMCjwnpcRFbY2eQm7mjjC8p0Gh17VjNDOf5F4gJLJE6m0S/yPxfYRIosrPNVCwD7ngCToowk6dfl6QpphqvAgpr29t0JF8/vqRUvDMRDCyWBCkPjvTLM0cf/hJwOlhZikOB0x++dmUMHL0ZNyL758NG6Qv+BNhdEFP4YSHiTM/u4+i64KZFQBKszGQ4FMXywUOjLPI2iIiOx6v5Zia2mDO6zjo6nyRCfXugb8MzvsOvCqRb4vTQO7Pz/mFlU0R906oNZbJdpkJ9PV6qqTqjDg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:13:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:13:41 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHclFSdCZdQrBjlSk+1lv+0pW4egrVvhAUg
Date: Mon, 2 Feb 2026 15:13:40 +0000
Message-ID: <CH3PR12MB7548911D59FE0D50F5CA20B4AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
 <20260127103328.255382-3-skolothumtho@nvidia.com>
 <00839884-7871-4207-904c-c9ea9228048f@kaod.org>
In-Reply-To: <00839884-7871-4207-904c-c9ea9228048f@kaod.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB5710:EE_
x-ms-office365-filtering-correlation-id: 866a69dd-cfd4-48dc-0aee-08de626da616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+zganvbDxfCT8AiDdMRTeYQyef7C4b/Xv/IZCgAbb2KHXG1+oBUnP3DtQy?=
 =?iso-8859-1?Q?PYRdx3bnbA+FPi232QwHNLjFw7oaDfdjZHVXc3W/zFl+woifHY58kkwjXJ?=
 =?iso-8859-1?Q?1xYtXWVrKfu3A1yoSuQIT51IPSW2n8q/By8x2vbXlC3S7fXra7FZmnBY60?=
 =?iso-8859-1?Q?8g1QmtCDA7iiT6+SODR0EJHJWan2rMnH2qngSS8e1hmgUH90d0OP3Ud3vv?=
 =?iso-8859-1?Q?rl9V56Ob8g9UvrtlACuY812POzhbRqsNBmhyiwz85Im5B0try1OWhSbHGR?=
 =?iso-8859-1?Q?YEJs+hbZ+hwgO6Z+aq4UxL4GUviDeFU4FOmvWV1tJrE1qQ+wVVVipe8aAj?=
 =?iso-8859-1?Q?8uFTz3Gzk+jRUq9/pjt3Gce59MYXixk1x8ESimEhtlCKmYKwWNSsyMGLeH?=
 =?iso-8859-1?Q?B/swTuR9bYKPzFn3vzzBqdwEyjOiLCjfa/EI9gRhLXI1UVXqekL7yVbw3g?=
 =?iso-8859-1?Q?qeOcP67ApATLvRP8q1n62KELLuhTBbo1y8GlnqnvRmEUS+CGWM3+SLs4Cg?=
 =?iso-8859-1?Q?tXvtVZUklmZ4txrdz6l886CdglZunO9WiZVywU8cSYE3GByjWJ1b/wsGBn?=
 =?iso-8859-1?Q?aAUI0kEb2EFwdAVh+kslbAA6bLbvw8vFJPpVFtaHz5PBNysz0LlPtn+YCi?=
 =?iso-8859-1?Q?FXDUy31MiLnLSnLORDA353j9kCfamYC4eNQSd4nBuOstXdAdD2X9DCDU6J?=
 =?iso-8859-1?Q?fEtyfrTReZIEqiaz8bRe3CIPDX/oLcbr8g5fF47r2GEzd7ZxBXUeP+IrJ1?=
 =?iso-8859-1?Q?TZSJcRkWcW2sdqLe/bhDDB0phVdPbuq3jMbGQCcTMury7jc2q+X+VcqLdy?=
 =?iso-8859-1?Q?y4uVbu2J/4j/HWlb8lu74h89UYeMdF0Vsivvo7q3kW8rToF0nPvv2kawJZ?=
 =?iso-8859-1?Q?wQhkea0gwgn+YWGpSPckUzSxeHxD5CSnwxtSCC2+VWleKt2HDm5YX/qhVg?=
 =?iso-8859-1?Q?gkYzgadlpj2E4tXrtYngL1sK/R7qxxDB6ombkRmrpDRkMVdY8b/wHgRKO+?=
 =?iso-8859-1?Q?S0MdGuigbevpSW7HvcacF/MmRwOCVpI9QAJkx2GozSa0b10fMHpt3rXrJK?=
 =?iso-8859-1?Q?s7z5FqgJW2WoTDppTxPTry2LbiTNxemDl6cgC7fOB+yW5RdGX3tqGPEx+j?=
 =?iso-8859-1?Q?OwTzVKpnaExXncFGLymfCWA9JdOD/m+gk8EtuSh6gaKlGrSeexovxilGWC?=
 =?iso-8859-1?Q?AZnRl+T0anbFF3AC7p6jb46DEpM2yVsHItlRSsDpAqYl7ZlJ5FyyWCWn7Y?=
 =?iso-8859-1?Q?mhmtgaCX2IY7fGcLKrZEC9f6crR7RbuRFvvsBg74HpAApsujS+d2HmLsU6?=
 =?iso-8859-1?Q?jhx+u4u/dWP22z/yZ9XK2TCZYD8D2uxKaCiy6bSIBe57MsZJ/naxfAf168?=
 =?iso-8859-1?Q?NtnLZa8NPET6+aBcStTZQI011EnwfmWP/3ovT0FvGJ0WWlfjnlNNpYdCpO?=
 =?iso-8859-1?Q?DqAAPZUUSO9noT0JNXjHxW29wd10L5bpUGzCvs0AeyJDMHpxRVqJBCnXai?=
 =?iso-8859-1?Q?7oBLY6p19mWuX+p+Ko72puK4gdRRdlLPVJqPDCToDEvqz2BxckPYth7uYC?=
 =?iso-8859-1?Q?uzsQ2j+1lMW6UXolz6Lb1bFBkRYuPchC9gb67zshbjpUb7uURGGOaVE8GI?=
 =?iso-8859-1?Q?1worgkuYOsfPvB3KBJ0JymQjH005LMmsx/nJRk3pWwtG6uoQta0jLsoeFf?=
 =?iso-8859-1?Q?Nsma8qd/WVOeZpLRTa0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vq/+lCF1/kwtzgS19pIqHSRkRFsAITcE+Ol3xiAlMDY4ead13ZkR0pFMz5?=
 =?iso-8859-1?Q?sETE3As7N7KJ/juQ1IeKd5HeucneNb6lxpf9wp+pzKEROZJ9oor3iOK9Tj?=
 =?iso-8859-1?Q?V5Ztk1Dr9MEXstYedo7PvCOfdE3hjjGwHXHZ4wfbuFk9zee7uU9oHkyvDD?=
 =?iso-8859-1?Q?ekyhYTB1D0QRSQIPe1MsyJHrV7jYlziRFrvOdVqFCKqJDCigBgInE2LtwO?=
 =?iso-8859-1?Q?hE4e36pLUDpAfEjwJDWjhD8diFM3+/jVO6+QjWwIXPtjaXCq3KLqbnjfiA?=
 =?iso-8859-1?Q?SSUKYYiHiNHBBVgxGj4HcI3PZZaH1N26EPikB7fmNm9HT8GvB5aWPskVRb?=
 =?iso-8859-1?Q?PGBSoc7CfK/XwNTlrMPak/5+drHhz5lo4JnHrsfO6vU7/jVtYdYJN2qrmn?=
 =?iso-8859-1?Q?L2AMOnoGDjv0motC+6niV5jqqHOMYOZg3MtJNYgmGSANd5rwrGNqY//4Y4?=
 =?iso-8859-1?Q?a2DCQWYerINcQgmPGL+kE+IGRJnZMFfN3MAaBmZbf9BrB2wAIW+vjTI2E8?=
 =?iso-8859-1?Q?KR6dvBnhiKiwHljv8gCrKAIHVZKV9UOSEHeNSmyr5pNnAKnOtyiixqPhjZ?=
 =?iso-8859-1?Q?mt0YaPK2WMO+BHStXzIAhtiQGFwLhh8BeZJyhvtzD/odHRQNinLz60Qlre?=
 =?iso-8859-1?Q?EWobqmOZPxWGmoxDP0RI3Uq9e1Uo/rs6KVUdJrqTYLnNpITfTEgZerpq4H?=
 =?iso-8859-1?Q?5AOuqKj5jZOgNlk3zM6kKGST9eMIaW2vN5p5Y5SD4+6QGc/0e5TrKYPSI8?=
 =?iso-8859-1?Q?qwV0DL6nlzH76JiLmsUm6kPzT/90g0BIK0jK45iR2iynIfc/CZq5jHur0z?=
 =?iso-8859-1?Q?kWCepvl2fF3FXXOGMOswlmiqJ0IHXaFT8E5PQBuDGBAWgVCRKBjyBlEV5A?=
 =?iso-8859-1?Q?yEhvj6DaCU2SirEvsQ7KODfFVmrmNUTiVQIYC1cqPOQKd+7qrxcZKvXHWU?=
 =?iso-8859-1?Q?k34HXNjDPORcLXGsK4lfqPgiL4PqsEQuhV6BYZDvdfING/3JPNLAQBfyhf?=
 =?iso-8859-1?Q?Djwpo6TsoRts6Om/ofaI0zcA5ybDTprcWRdd68m8WspiofarqNU4dKf62z?=
 =?iso-8859-1?Q?yf1wwIsX4QgdZhG+hk52Tsn7UKNXSukB4ezo23S66iaZwqWGIBwVz6M/0d?=
 =?iso-8859-1?Q?QXS6IHOB21uOJvKh4KVTVkeE6Z5/wlP+m90QP2HOMh3hqL2+7Yc2vXMsGZ?=
 =?iso-8859-1?Q?4ZEPXN6Cfoj0iGS3/ZaGgp1ibHFyKSmhLEVw7s0S5Jcypzn71fvKmhjGqP?=
 =?iso-8859-1?Q?n+nWj7xxuXAIDKI9rrXB2si74rMEX9+49ePiIf3EYNbM1zs0f3FK72pkt1?=
 =?iso-8859-1?Q?uO0V9lyvm0P1yPQrGNntgEzGPY2kT9WwCf+nRdhgtiiZEHYPkrX6ggTm5F?=
 =?iso-8859-1?Q?s9J5cWC9Hmx2KEWAzGFNsARZTGo7r347fR/fZsRyqsflez429+BqKqy9vz?=
 =?iso-8859-1?Q?TqU5C1LRQAMKfX3nCvCfOlHRBuSDsetbw5JCPoZ2RRU5kIcwwdfbaPea2b?=
 =?iso-8859-1?Q?838YYuqrgoVpVs41ARO0cLOvpPss/DHCaukAlpka5cNoaaY5EKXz4STVbl?=
 =?iso-8859-1?Q?dBGrHFjxl97kf7o1WW/yHdLiWHgx5c42k9JEeqOtWMH4DMXGnqmola9weg?=
 =?iso-8859-1?Q?uvRnktJhqtKUVefKor8/GuBFq+8PGfR3FX7kPdN45dETYO3Z6T/lLOK3vP?=
 =?iso-8859-1?Q?NS1dIu6sh1YrSfEcRJPq6a2fVfN9F1swYqUUu217YUFbgQNd5cVt7N2q9U?=
 =?iso-8859-1?Q?67lnDnzLILdMUGSol1eljDHzwDA/9GRvlos/RkJZI02TKEMyxKLgqtTWte?=
 =?iso-8859-1?Q?QeoNvwLWxA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866a69dd-cfd4-48dc-0aee-08de626da616
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 15:13:41.0053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14EKEUORJ7PRvcs/d0LOoumJeEkBccCIJvJYVGW+QDbAiCU5zC44i7Xrqab/D9S8b+/f9Oj4QMmieHldckZONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: C=E9dric Le Goater <clg@kaod.org>
> Sent: 02 February 2026 15:00
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v3 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices

[...]
=20
>   static inline void smmuv3_accel_init(SMMUv3State *s) @@ -80,6 +82,10
> > @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd,
> SMMUDevice *sdev,
> >   static inline void smmuv3_accel_idr_override(SMMUv3State *s)
> >   {
> >   }
> > +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>=20
> This should be a static line:

Oops..will change.

Thanks,
Shameer

