Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9154CCF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 11:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svxEV-0002Fc-Ia; Wed, 02 Oct 2024 07:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1svxET-0002Ep-BO
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:09:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1svxEQ-0005xM-Gv
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:09:25 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4923pvA8010892;
 Wed, 2 Oct 2024 04:09:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 proofpoint20171006; bh=71z1488dpkgywFQkZKprQMaiKvlK0KpBCiypCmm17
 78=; b=YY8BRsMcxwB5RAxrr0ZGpg3Oq6PY4lLa2GFCoHLMEn/fk1D67uqGNYEOj
 HWQ5Uh6XVTFiRM9CAo+C6VkW94pKhX+yhvidYnlYddjspibvO3EAzIQk+bndfcXc
 yKy5M6zj1yFx2TCqkwubMwEQLmIKROabxgjmcqGG5K6MCG6rNm4Yql9gbGa87Lnd
 nAomq1J6vhWW2ooe3KiYysBzwvoAAZlsGguvI+l/wcsEoVBoGPu6lnx6ObiFaVil
 qu6D655ct+pKgWsOa5mHiYeVS7PXVETjPdsQOQo70m3AMkvKIobmkLv5AfW0B3dW
 xDngjGeb4ZKOoz/jG+o0p4FTQMmkQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41xhc0he4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 04:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgcT8EcCio8qOIos9xQqqyZm62w0QnlgstJ1CE37q0QJY/VHLpjwEog0m26UX7L9nrZBoiY+p4TZXKfVOXHOBLlKqrpqL3335pL8Mja9N33AuM+N/9rOhgA/LtdQCAXBl243356oCKDlwnNVOZdVN7BcHCBlZYYzuqHwabBqzjoZpKvN/g1KQ3pyHtP2tLM/a5hYJwXMy/phGy/ce4l4R+STZeY/Ck0hulcx+f2w50bal/Y9uXH4UTB/GMPJrOPpQ2sNlkrE5Hai8t89RcjG/PtluOuHjkfaRBNojyV8y9cN+RLQJlYcTusP6jBGAY9kJqAO7DY94ZDbguJ8ibwHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71z1488dpkgywFQkZKprQMaiKvlK0KpBCiypCmm1778=;
 b=YwJcTgjyLWDIRte0TUPJ4Us/avTrSyKgWLTYmesv0gpw0r7sVsYL+fjlCwgE10ZacB90RLC9VvwQj4xIbKo4/TmKbscHMClamio9LB2ueSMw8gzXgyqGxPoWhPtSV0/p6SXQClgTYpT0fZmuvuRef/qMgcu2Z948yLm3mr1iieNTAqhe2yHgRcSG6mBOFwm4hCnyJhhjmdzsKKE9cpmRveG5qtWw7EPI0OEEkYohhioipks/9ciDzjWERlIT6W2i6naNB5AWutZ6E+LzcYl+9JDC+ReibOVTgaszHPKkqscVUhNMjSYQc4BKSYD8xN3pGPuG/TGR0dMhjIuYBv6VQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71z1488dpkgywFQkZKprQMaiKvlK0KpBCiypCmm1778=;
 b=weM34vdYOE6G0EO879E8Lb8wdxgJHRAkWnwNt8Gxx9I+CBzEDRlTthXF1ue/Ww+MmIpSbRwFdJ1PlADRAyqPxXKb3aXGC8lCF/OmLPSdfm8G4uxDf6ac/iPwyAkT/LoWOe6aQ/8SukcANtT4bWdY+dBuRr45lj8rYZVJwpFwSC6HmWrCH9qXmn0rR9YzA9Eq8UFYDKAxiM8MVcEe12yD+ooyttds3ilkFEJ1i9CtZE3qhqzXUyZokRCr05rmBKCkW8jfjEJLTqtQXFRNWqZ7rlVLo7hhijAouMY1QZUBzPrHflIBlbF0bA8WbD+9hz8LEbPsLzQNihknCEnBD/ahcg==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 IA0PR02MB9217.namprd02.prod.outlook.com (2603:10b6:208:437::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 11:09:13 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 11:09:13 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: QEMU Developers <qemu-devel@nongnu.org>
CC: "freddy77@gmail.com" <freddy77@gmail.com>
Subject: Corrupt VNC display for 1366x768
Thread-Topic: Corrupt VNC display for 1366x768
Thread-Index: AQHbFLkdixseYmY/b0qksh89icazUQ==
Date: Wed, 2 Oct 2024 11:09:13 +0000
Message-ID: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|IA0PR02MB9217:EE_
x-ms-office365-filtering-correlation-id: d87f264a-297e-4d3c-89df-08dce2d2a5dd
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PgevQV/hhGhV4XITT+5RcSpwrIaqqcJMDElbrCBIvGsYPQZTcJuzb+rahUQX?=
 =?us-ascii?Q?y8qNG6ZyFhKIJKlagzAGFaawFUPQD7t8leH8wbBcuBLrk0F39Oqt6TqpE8sf?=
 =?us-ascii?Q?xH5/hcvdK0yKDF4qNzsE2oV9ASgN3Mg147Ly27FKrc/u4ag3XGFBbjuZQKwS?=
 =?us-ascii?Q?YTGCxTpjA78xHQFAL3nY111DO1duXoLFCc2iBnhL5UvXx1oEZBPH5BIsFdvH?=
 =?us-ascii?Q?RDnx94wBwZXvfR0nCIqABrR4wf/oxJjeekoL4iwT/KFGbjhGSSAmOldTJGwl?=
 =?us-ascii?Q?MDN+GwEIqAULWd2CWHV/HB2ZJvRIdMat7NvWww3eD8Jw1+4afOJ/pfgPiSl5?=
 =?us-ascii?Q?ViZIxF5JiVO8RFEKDGRGCPdSonYUO6tD0qKjQWCla0b4Ab+2ZF/s3apXRHW6?=
 =?us-ascii?Q?kGtk9EKNiD9tfucHE708KfC2aEK1ECGEdC82DQcAw7Ly/HlufyXy4q26Jrc6?=
 =?us-ascii?Q?33J736ItULw2K31Cu3qacBIDQY53IEY8TacSUe20lo9Fzj5HCZ1g7VadVKk8?=
 =?us-ascii?Q?YtYQTNUKDesY9JL/9XAZ07kGJYZhJFi0jVqAcYv7rZ9unE6xVUpwKv0hQL8i?=
 =?us-ascii?Q?xgX9gv1uqPdLDW7khsAdP4OzzEmgioG0LNZCkkurFi+ZAsGKbquysheXUcz8?=
 =?us-ascii?Q?2C7xzigRfosn8DAF5W2hqcBz0a2tMo6SVHtWEvByXo9PeS38pzx6ANs1lVyC?=
 =?us-ascii?Q?UYuNVNb6X1Mk1VlagP8VaUfq4ENQxEyuwfu/J9EdcLV9wbGfvKXyie7ndRNl?=
 =?us-ascii?Q?+0m9SPn0HBQb1/G1OBFauPjxFOcQgI4tNQhbXv8ietZKTOzFDpArjl2ws5kp?=
 =?us-ascii?Q?F6AJLfrBr5dLkd9KVyrDkn3eURw4LE9GUjm1anYPBE6zmEfDGHibbRxzkap7?=
 =?us-ascii?Q?Vmf6owjSxOKyTXc/Lqr3FsyXTq6e3myN6b/nyIcqADryKyhh4L3dCXwcAcMA?=
 =?us-ascii?Q?XUJA5ZvKGqPP9amZgfCSu7qDlpeVm46nW0PpTY5083tvXp1M3MWGaQM3rRLC?=
 =?us-ascii?Q?gKb7S0OA9DADxJWAftUeCrR9vcZf24l3Nv8iFsPtQ7Phu/SEH0htEdmmkyHw?=
 =?us-ascii?Q?0JuZTJyALBz9UWHHRZ/prnfeALcImnpn/tf9JQKKlyDdSbW+xggU1/e+okuV?=
 =?us-ascii?Q?H9pLmPN7VHSlPO6eAw4YxNZAUy7seOsTG+OFiXbk3jKxXLKtQ3DsS6rqj/Zz?=
 =?us-ascii?Q?aVox6cmBVwygYOt0E/P0V0tCaX00LNwtibFDyQ7AKKSHrjfHdjraKp1Wkc71?=
 =?us-ascii?Q?Wo/QdkGXIAeOMlkJkG69SHLtibJcXJAqcxxNl9YWyJCwRQBbhRZPqXfFDR1W?=
 =?us-ascii?Q?xMNZdAw3todbE35+dhnWHyt1Aq8LUrXcq8M+FvP/M05fuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uc6UWiecU6/hoAROLEI02zuxnpbyqfNYsm/8a3b4ZtsfwUxoM5Hw78oV2QXF?=
 =?us-ascii?Q?vEWKz3OS+bstMxK51HFOfWejvnd1/PWThRrVEclkLhQVfarSYoxmWn8BGKcq?=
 =?us-ascii?Q?cWLh2UIOxtYjPRwVzi6aXnvioTFw5n+iCik09ayLjOfmNHtB2fH9SnAYRFy1?=
 =?us-ascii?Q?JK5zdVOW5crsq3CEWqAtf+ghzZEJHDH/MZ8FhJva4I3RSUT4lAvjzbtsca93?=
 =?us-ascii?Q?LgaH+jEdNNJ+bIXspjQfyLWXfSmS1bPCDE1Ra+J15B4OcZul0uY5gaHG7urW?=
 =?us-ascii?Q?YYK5B5l+IxWV5KJ5sjZRIhQaEyfczUrMAmM4KV19xoiGp/GQ7A/elzb80+e7?=
 =?us-ascii?Q?K+sG8I9V287SN7wLh5rD11yFCobMphFINntgLrYGQQI+tm94S5WCrHRW8ide?=
 =?us-ascii?Q?2QWZhOzlH/PaPVZh0IFNScaG0Kbj7cDFrOF8T4+qbQYJPVkxXZfaPl/2z43P?=
 =?us-ascii?Q?09gKrZjfEPFggB21eRi/FRpZSvCRfGXjs77KBVdxqBp76XjvUGXwAbp+/5Bk?=
 =?us-ascii?Q?xpJk9cTBALIHNiExnT0+68+oH4QMq3Ojj/LPYFVJmsi39h6enQxc4rH/L8qZ?=
 =?us-ascii?Q?e9eR3Jxs2imUWxiHh4oIt56h/E0cTZtPExAKNy/9GyomM+OnsNWQCM8vajui?=
 =?us-ascii?Q?JrbkTGDXNX8kvp5ckMnwM/wFy/vHz34jEAjVAorStgdQ86MR7efOJ7wPPEiF?=
 =?us-ascii?Q?vzt+RjJNqPbhA9vK4tiSY1I0sKUfh/Ag8UoE7pYMwud5PWbhTZMZrtG6wah4?=
 =?us-ascii?Q?MTotUGVZMB//Lo6v/ixdu4/d/P5kq+HiZTsXV+q17/YKCO50FOfdFzhl+yAy?=
 =?us-ascii?Q?CgiZarYOrzplEgMq7Jw+pGJW/AcIT0M1gSEQECVvuTymdkKU7a5yxqM8VphL?=
 =?us-ascii?Q?VnwuE7VPhV9GLOtZgEm0v9rgD1Ms6GuifjjPSTdelyjTDR/tA3lmLe/RzbQ0?=
 =?us-ascii?Q?XPOTZDFfDe5xCwfdJXUX6Rdfe7px6nnImH7iK2OpJk1E1Aoif+YAj1Db1Mqk?=
 =?us-ascii?Q?7rNUVA5k2yDFeGvmkvQ7eq16UsxWZkzZOpD4DmB38j9sIRSpjsnviTfAdoy0?=
 =?us-ascii?Q?67w+AAecSD8czJNMnF8JiURV4dOkbar7UmJxoCXVIrJDAbAyAJzZq3JNxZPS?=
 =?us-ascii?Q?87S3aYq8AHwpaZaNMnKbAv2xw3/TUMSxPw/KbE7pA4J8v7SxJqAMLDPrPDYD?=
 =?us-ascii?Q?N/8CJN7ovDHU5GdDhk3/9KUa6GXEvjrGSUg8RunAhKvWmZq9rQfyLeGfiUge?=
 =?us-ascii?Q?NPOkQIh7GUXMtqatGywBq45XuXFJwwo30ldu7lBsSwXgDuTiFttFfNewgL+X?=
 =?us-ascii?Q?fzs+UGfeVechSe2+sZedrKe69Y52uO4MQVM6VDb6lrkmbMMH3e+KqvNwmupZ?=
 =?us-ascii?Q?3P6oSbfBbBwRNA697yf/7h1j5fyv+pccpP860qCOCKPN07GwXNvAefBZJbE7?=
 =?us-ascii?Q?UPFxpyUl23Rjsc6FM8eLJqkN+uI7r4AsXzF/gdHdqkC8cUPnZtFYUE6BnLkD?=
 =?us-ascii?Q?Xg4bjoM79V3wv+8o0qEsM6tP0/KzGuWVzfHf0I17q9Pnm7gzNPzsb0QSWnlB?=
 =?us-ascii?Q?Rj+nUCXrlWMk1T5FRlT2jFBfef6ys0m/en/9LeEdo9AYO1VDSQg++gFXesgq?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81217D61C42562572F8AFFB093702DM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87f264a-297e-4d3c-89df-08dce2d2a5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 11:09:13.3036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cz4jbr/ZKLnQi6A6f2qEIFMn9IoBU8YSXvgdz2WLOW2Wt38+B4VIg2NbW8hliMjJ8yc6QlT4zxFFdWOp/f0ylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9217
X-Proofpoint-GUID: cjzGStbszWiy_Gv_GFSfW4MoF266LQJv
X-Authority-Analysis: v=2.4 cv=c4P5Qg9l c=1 sm=1 tr=0 ts=66fd29dc cx=c_pps
 a=pibkrh05mLzxjy7FsoIMmA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=Whb59SEoU0rz2FoLLZAA:9
 a=CjuIK1q_8ugA:10 a=IHemDPjtaPEA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=Kh-a4WSMz0grNPHia0cA:9 a=bGBKuXt5qAe99do4:21 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: cjzGStbszWiy_Gv_GFSfW4MoF266LQJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=simon.rowe@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

--_000_DM8PR02MB81217D61C42562572F8AFFB093702DM8PR02MB8121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been trying to track down the cause of a glitch that affects guest VNC=
 consoles when the resolution is set to 1366x768. This results in a "stair =
case" effect where each successive row is offset to the right by a handful =
of pixels. I believe this is related to the fact that the horizontal resolu=
tion only divisible by 2, not 16 which most others are.

There was a similar report many years ago, with a proposed patch

https://lists.gnu.org/archive/html/qemu-devel/2013-03/msg02732.html

but this was never committed and the code has been significantly reworked i=
n the meantime.

Could anyone give me any pointers as to where the problem may lie?

Thanks
Simon

--_000_DM8PR02MB81217D61C42562572F8AFFB093702DM8PR02MB8121namp_
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
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;
	mso-fareast-language:EN-US;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">I've been trying to track down =
the cause of a glitch that affects guest VNC consoles when the resolution i=
s set to 1366x768. This results in a &quot;stair case&quot; effect where ea=
ch successive row is offset to the right by a
 handful of pixels. I believe this is related to the fact that the horizont=
al resolution only divisible by 2, not 16 which most others are.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">There was a similar report many=
 years ago, with a proposed patch<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://lists.gnu.or=
g/archive/html/qemu-devel/2013-03/msg02732.html">https://lists.gnu.org/arch=
ive/html/qemu-devel/2013-03/msg02732.html</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">but this was never committed an=
d the code has been significantly reworked in the meantime.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Could anyone give me any pointe=
rs as to where the problem may lie?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Simon<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_DM8PR02MB81217D61C42562572F8AFFB093702DM8PR02MB8121namp_--

