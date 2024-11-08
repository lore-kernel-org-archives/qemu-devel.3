Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2148CD5E15E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9N1T-0007q5-L4; Fri, 08 Nov 2024 06:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1t9N1P-0007po-DA
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:19:24 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1t9N1J-0001Zr-Vy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:19:22 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A819rRk018828;
 Fri, 8 Nov 2024 03:19:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=oVuCZedeEluskTc
 KsS/wBTjLJgeUc6RZrjsUoTP5jTw=; b=1GaOb9IMQKjrbgg1B9WtmNnmk3kfwcs
 ewE/llqFKqBMdXGpUm5V/la3j9raht0oSt9NCtunXmT0/z/1sb5wabD3SlaMZWHw
 7/V8bvBNVxk2aNcwgbvsAea+atNXN6Q2HhJDh6R32w9Bos+aNDIEJh8asqXTFAoa
 0BcmtOo8aUrtgOaVr8nY2EvbfpABq4hblcFAYP3xel4EniFxThFx39640LeBR8Ku
 ZlHxSNEo81VzyOkf7OuQF76bD8Wr8hsJQhTr1sYbJPaI2OV+SH5xrBGSDfVYjVP1
 U3G8J6zOnlTo9NJhTQCD3N8Y6A2k8OVgRPK6PbCJxoVJ3pZJqfXGWJg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42qw7sf0qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 03:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkZz2LmObrvQyHogwCnrZO4ssBjQuFPDIczMapQldaLJh909sX8albqXsGUvYH0u9UmvYY1zqlfhDnS0vQFvGqkpNJ9G4DziQ9BGWpwMPdFkaNBKVzplN233jHXUssIRgJH6QGyekHfE2CNzv3mNBXwnkB8aDHI5UNTVvcwtlMU7wGh+GIFbnFAFr8pwI2VKLn/S1sGxvmKiOcoaYgcX8tQZftI/CNgrGYEiwLM2A5PRQzZU3wGAgs9g1BH/k6phFUN/tFcinjAkJvB2g4jg0F8u9ppFrZXHzaR+yCg98MiApbL373TCVPoaOLdIyfcqrY8uC13Z+EmPY+h6eQK4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVuCZedeEluskTcKsS/wBTjLJgeUc6RZrjsUoTP5jTw=;
 b=TIPU+S6QQbynCBTz59HcTBRJ94CYfWe9rcd7jP83u5L77rBB7NEPnYmPKrM4O/daBBTf5fl2cslmYdUTgQRe2cd4sGUMLu5vkq5J9WL68VYzoDJA039lVd6EY7U4jbUtNhMQqwej0h3pXAKOAk7hDY1jXBEoc4d0nvTbxwArlRTFgcCAiGXSwPA/TP9yPW086oljZRul6izLEV5Wc+fp4A4YyHOD0nkV6pbIhOn1+Xh21j89z0xAuyFwBTefdGHn31z4PvNgkKkeIRIJBgT1V1mlULGnBMzhtrjprYqAkf0893s7NEqvXuexMf770/ZRNdUteBlGb2BZzSoGycqSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVuCZedeEluskTcKsS/wBTjLJgeUc6RZrjsUoTP5jTw=;
 b=woq53NXcH6rrXudISicDlmY9az7etZywpRKaQFZs/G3Pl8RPaEGJmOhnEfMtxCvmjLilSL6Oa6/ItChNzmhVHyrcUDAzq1bFZjAGwi4lEGzi2JH/w1rqOk5oVhv2QmC9Js2+661T4NHarge3hBdq+kDb7FvmKkpx6vQX5+Nu3IDgysMuuaKMLaiH8MI7FRGqKB3BxRP6gyq+C51wtnh+IzSqrvXej1q6WQO7bihbReIdDeBKH/DqDvLdXzs/73hWojVhOAnE26FwLuyIEmgOLIDTkeW5bvuSochUKJoDf79ETBLeTKamiB0hiHlHt1jBc6QguCwCtoq9fBWO0MdzIw==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 IA0PR02MB9839.namprd02.prod.outlook.com (2603:10b6:208:493::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:19:08 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 11:19:08 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] vga: relax restriction on display width
Thread-Topic: [PATCH] vga: relax restriction on display width
Thread-Index: AQHbFjj1Nfxyz3XohUyo7812be0D9LKtc5Oh
Date: Fri, 8 Nov 2024 11:19:08 +0000
Message-ID: <DM8PR02MB81215C9A0B1F4BB69763B76E935D2@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <20241004083937.73595-1-simon.rowe@nutanix.com>
In-Reply-To: <20241004083937.73595-1-simon.rowe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|IA0PR02MB9839:EE_
x-ms-office365-filtering-correlation-id: 3c5faee0-9e0a-4ecc-2c3c-08dcffe729d8
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pIqUHSRN3kqa5XEnfEgSTAPXRY9WTF2uxqxyNrvPnT48xkbCGkG1dK2Qs+RF?=
 =?us-ascii?Q?1N4E2FpQ7fIue8/eqP3FlW5pKP+wyKWQhqm74q1ArrDwztlHHnZzEYkEaJFi?=
 =?us-ascii?Q?FtFvH5LbdVi3SemYCaKCp1PjgOLoQfyX/zDKvTvkrEtj8k0G1A2Oj/VHrUdV?=
 =?us-ascii?Q?F2BHzurvquc5hhgWmjao8jpTF/vDDSX/xiEg+ouE2Ua9vWUFD77PE5kakDfQ?=
 =?us-ascii?Q?YjAoINcU49RFBQXRABnJkDwheY115ScsWdz63sOIqcs/E6yOvi5lAZCoxsF3?=
 =?us-ascii?Q?Mo8OP1TzUhV1KVPSPlmLc+bfi+p2J1co8TVr+nCk2u9OjUDWkh3gh+vLe3e4?=
 =?us-ascii?Q?J558xXYv6gvOjwhJn7s0NV0oh4eizPtHLaRDjrQCQlwYsbdJdA0l+c5wpZOS?=
 =?us-ascii?Q?sV+yMaF5sPalL8L9c96jZ4tlX3BUGmXmLDg56VRO6VXTYaxgnIMAq0dx65QX?=
 =?us-ascii?Q?hM1kodobtlqtHqTtwhfZbz/q8F/kLs8Hm3/Ln8q/nfjw9LPu8PeV4YTyCsNH?=
 =?us-ascii?Q?c+Ep3GO2ARlq88kNvNmhoAtet0rlWHOw/TmIgZA/1b1iIETfQW4/FoTTlTpN?=
 =?us-ascii?Q?fqYqTW+V1lGJr32FkvW8lYLMIidynLMAIJFvoo9ZkP9DTmy+9Hk0UeCwYwcN?=
 =?us-ascii?Q?7v051zNYJQOgTUKtComOdfLlOcsI38GS/yvu+8tkIwAXCzgNoxXhJzsMOpKW?=
 =?us-ascii?Q?T1ImeXstx7VcDwNeepuJAIGmIUTzVu5Nxd2uGvaPagQ+TiC3Y/HMq5+0Ml97?=
 =?us-ascii?Q?rHg0eDT3sTHXqNIH2QVWZ3/TD8LKbehbywtm9q2VYbFQ5raFD/RdBlwPOq9u?=
 =?us-ascii?Q?LeCAzLAoADnV6bk6gS0GpaecdezVbEXaIn83Oqv+zhhrdIyOoy0KPFktRvcZ?=
 =?us-ascii?Q?AEkrHob9F8N9V10SQT1ifkCS5F43cgcbKV6BoSRUJnMhCw4eaREBLuqoqFuo?=
 =?us-ascii?Q?o92Lgn9/1OESTvVGZbgEPb8DLGEzePkLZgBXnUVWVU1puMQ2RtmDc3tXhnTK?=
 =?us-ascii?Q?RCRShZdPziVcPBbJyxnzhMRyoCHPTUK6+N0GFdynEnSR54tnZblwEtecCsT1?=
 =?us-ascii?Q?WWIkbFBQ/WJFllXZ7s/qmNdk+WuDDup8UhyAbaqlFzjS5s7NQO/00SJy9Rdf?=
 =?us-ascii?Q?5H/eiD3+4pyNN2AWre4Nog5hSFFkV6SjVE0WNgNrSDu/5xVe07oFIBIdiXQC?=
 =?us-ascii?Q?crrlhzjyr73sY/agbVj33p1B5NP/MGfWWD1O4Onflfi3I55z+as10o1bhveK?=
 =?us-ascii?Q?wzy/o9sL85Vce/6wJadxB2ObPajufxD4CCvd3silFTW3Hnx/qeBjRujSb7iw?=
 =?us-ascii?Q?CRO1OF3UnITnoWPb2sqBDgiOpLqAbGjggromSTRxQKT+6u7PJjl8FOxeSf9W?=
 =?us-ascii?Q?x2PoDUE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1HE7BiWNGQ61TIl3S9FAX68sMY80SIGExOnJfIbtvmqJs2FV0xcy/W6FYwRx?=
 =?us-ascii?Q?P2I+YaRdV5uCRGVHrBsw37QTY9nRa+ePXOe+yLYV/pj7hVGW5TNyKyemOeeg?=
 =?us-ascii?Q?ie5KD1ifovlZ+6IRQlEh/uFr1BlCqhK4Y+Hq8RAV+t2CBStfLyDNI43KW8b6?=
 =?us-ascii?Q?VqL8QRuC4aH9iU73CTck2YhhRbVrdWYulbQPNzVQmUCfuKrp2Egw0TN5R5yW?=
 =?us-ascii?Q?C+PzxBmJiV0bDFtOVhMFdfKxormmUT3xHb6xmfmk7qGH/ztnJjNGUQSzVyZu?=
 =?us-ascii?Q?LIg503pdCHsx/KTG+tGXoOHKu5PxzNefgigh6QU5FLkkWVfFQVuTIlZHtQ2m?=
 =?us-ascii?Q?LCb/qbl1+bTbTQCb0mC4oZxAWBoDche2fVvYfzk0bHeMjLnX4ie6MwrJPw+L?=
 =?us-ascii?Q?X4/Qln+z8iIid2KYR+Bd26wRJTdvTXQHjbhRoUqrwVE2aJyJ6n2OHaYYc1rL?=
 =?us-ascii?Q?lwPdiMqTTkRRZWLZdQVQP1uGj7wpqOBsKZi3Q5ULYyk4e8klip7G129yvjtf?=
 =?us-ascii?Q?B1TmJnsb8cDpshZ88FZgUjhM7JzM0faP/IujZtRrW3y4FA2oC/neVDUynkVE?=
 =?us-ascii?Q?AB7gEWNq29eyG0Nip/0Yo1DEYj9z1uzsqyC4qHzXx6CJ6WnSxRc/qfH5gn8i?=
 =?us-ascii?Q?MMM5Is32pfva74m3iYjpGGi/BP7hb8Cwqydeg/jz5LMcklRxpvfdYyyfwiVb?=
 =?us-ascii?Q?PAltwj3CGbWHijVUbo5OJezWR8kcQwIfZ8Z71nfFHStZkkSAouIw8iuCaT3N?=
 =?us-ascii?Q?ZrwQ+VxgODUbdOGJ7XJLgqXoLSq53OEOdY7vIzMKM8YPA/u2bU+ud1Sc+JrM?=
 =?us-ascii?Q?IdhAUy+EF2zB6pTXqP4D0mkmhT6Qbt5wrES+eX6VRjKhjjsjEIhdxOm1bpVO?=
 =?us-ascii?Q?SaThUGTuChtdAvntQ8X0765i6jUjyFFhM2YhPORKBcUaAjGsBx5I4UX+yiOd?=
 =?us-ascii?Q?1Wmz/WX+edSyKh1Ep5bsJ/Jz5o4qLVCezK6oD3n6QVkWEzd/qtm8GDCEmEBe?=
 =?us-ascii?Q?zAJvk/ymvKZhDagMp8NFx0M2cuL1Y4OMoKVxQTdyf3hGtQ8HMuL7MvutudgJ?=
 =?us-ascii?Q?rWwSSbRQtvudkT4qsvXTzPwiLHIs3cQ7yGgn8Ip458p8+sWSiIRYpx8Y7pMd?=
 =?us-ascii?Q?NW6HNAKfIAfncQsVssxDAqTFAe6nVEBK2HVeZqnHgVvzTakuPOfJBG8Qn1/a?=
 =?us-ascii?Q?a4hOUS9eHcIrsR9ZDjuitPMw2StvxsYuNYe/WHuo7eGwcgrsQlwWvZhFv+9e?=
 =?us-ascii?Q?Nr2UPEQ7WEJkEZAz3MzdEPkLVm2kPrxRuJcLvkTFzK12IYgROBQxjWWSO/4L?=
 =?us-ascii?Q?6M1lz8MKBIX8YgsVFuvX182WsyV+aRjhUzvvFHhztLVDlgSxgyV/doRU4Ldf?=
 =?us-ascii?Q?B5Z8OHx4R3YvuTRm7RoCABx4CcxPBboz7dXASrsYS5JhzExQNyVoFDaEJg1O?=
 =?us-ascii?Q?sD1kcidOKPb11QFhi3PlPlf3CJ8UsAzJ8kEFT57tarNEGa7oYEFGzAvtl+MJ?=
 =?us-ascii?Q?yYvxkkpBqnQIdqe+zMAEk9V79c4LMduHt7cyHylZLsPm5focDYu/nkTbwta8?=
 =?us-ascii?Q?KQaMh+MvMWk4bJqdvbvnKNSSu7mjYWkvkjz+hWem8OMu/AE69KFTfEDyvNfb?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81215C9A0B1F4BB69763B76E935D2DM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5faee0-9e0a-4ecc-2c3c-08dcffe729d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 11:19:08.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Rg4K6ucamajhn7JI4x73YIQ+itwofdmuxaebCZHhnp79e1u8VJKuhIstlkgEGfKdyHzGSBeBtPeHg2XjDcepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9839
X-Authority-Analysis: v=2.4 cv=d6ynygjE c=1 sm=1 tr=0 ts=672df3af cx=c_pps
 a=RoG0BMNHDmmKSZcrvsSD+g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=_6F_Gvem9JLtgjso58YA:9 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=GqU8qPd0CwKu8V653-EA:9 a=049jrjqZ6OglmHtX:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: MAM4qnT6Tvo1Qgl1Wh_K1Pa8As3l0vxw
X-Proofpoint-ORIG-GUID: MAM4qnT6Tvo1Qgl1Wh_K1Pa8As3l0vxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--_000_DM8PR02MB81215C9A0B1F4BB69763B76E935D2DM8PR02MB8121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping?

On 04/10/2024, 09:39, "Simon Rowe" <simon.rowe@nutanix.com> wrote:

When validating the parameters of VBE ioport writes the X co-ordinate
is silently rounded down to a multiple of 8. For valid resolutions
(such as 1366x768) which are not divisible by 8 this causes
miscalculations because the display surface has shorter lines than
expected. For example, a VNC client receives updates with a
"staircase" effect.

Reduce the rounding to a multiple of two.

Signed-off-by: Simon Rowe <simon.rowe@nutanix.com>
---
 hw/display/vga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dc..ea659e2812 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -581,14 +581,14 @@ static void vbe_fixup_regs(VGACommonState *s)
     }

     /* check width */
-    r[VBE_DISPI_INDEX_XRES] &=3D ~7u;
+    r[VBE_DISPI_INDEX_XRES] &=3D ~1u;
     if (r[VBE_DISPI_INDEX_XRES] =3D=3D 0) {
         r[VBE_DISPI_INDEX_XRES] =3D 8;
     }
     if (r[VBE_DISPI_INDEX_XRES] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_XRES] =3D VBE_DISPI_MAX_XRES;
     }
-    r[VBE_DISPI_INDEX_VIRT_WIDTH] &=3D ~7u;
+    r[VBE_DISPI_INDEX_VIRT_WIDTH] &=3D ~1u;
     if (r[VBE_DISPI_INDEX_VIRT_WIDTH] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_VIRT_WIDTH] =3D VBE_DISPI_MAX_XRES;
     }
--
2.22.3

--_000_DM8PR02MB81215C9A0B1F4BB69763B76E935D2DM8PR02MB8121namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Ping?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal">On 04/10/2024, 09:39, &quot;Simon Rowe&quot; &lt;sim=
on.rowe@nutanix.com&gt; wrote:<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">When validating the parameters of VBE ioport writes the X co-or=
dinate<br>
is silently rounded down to a multiple of 8. For valid resolutions<br>
(such as 1366x768) which are not divisible by 8 this causes<br>
miscalculations because the display surface has shorter lines than<br>
expected. For example, a VNC client receives updates with a<br>
&quot;staircase&quot; effect.<br>
<br>
Reduce the rounding to a multiple of two.<br>
<br>
Signed-off-by: Simon Rowe &lt;simon.rowe@nutanix.com&gt;<br>
---<br>
&nbsp;hw/display/vga.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/display/vga.c b/hw/display/vga.c<br>
index 892fedc8dc..ea659e2812 100644<br>
--- a/hw/display/vga.c<br>
+++ b/hw/display/vga.c<br>
@@ -581,14 +581,14 @@ static void vbe_fixup_regs(VGACommonState *s)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* check width */<br>
-&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_XRES] &amp;=3D ~7u;<br>
+&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_XRES] &amp;=3D ~1u;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (r[VBE_DISPI_INDEX_XRES] =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_XRES] =
=3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (r[VBE_DISPI_INDEX_XRES] &gt; VBE_DISPI_MAX_XRE=
S) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_XRES] =
=3D VBE_DISPI_MAX_XRES;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_VIRT_WIDTH] &amp;=3D ~7u;<br>
+&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_VIRT_WIDTH] &amp;=3D ~1u;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (r[VBE_DISPI_INDEX_VIRT_WIDTH] &gt; VBE_DISPI_M=
AX_XRES) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r[VBE_DISPI_INDEX_VIRT_WID=
TH] =3D VBE_DISPI_MAX_XRES;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.22.3<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB81215C9A0B1F4BB69763B76E935D2DM8PR02MB8121namp_--

