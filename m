Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBFFC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 02:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfI3-0004ks-Vx; Wed, 26 Jun 2024 22:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfI1-0004kU-2f; Wed, 26 Jun 2024 22:55:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfHt-0001zR-DO; Wed, 26 Jun 2024 22:55:12 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R2SZg4003303;
 Thu, 27 Jun 2024 02:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=pp1; bh=WbheO4yWcD2MPqGKUaD0QhtigR
 HUNNLi2XyLYrqtnaw=; b=RWFKBlj2xtXtyl4kT7CE/GtNzQqWrKKoyZNsg8Fd9G
 VTHIxoKouq0VAeDecHKKOTihMmhGakhaNxZGKFXHhZ2ajcHdQUHnoLrmQTiM3yx9
 pPKxRSpN3THtgPir3RZu6tLvV3iyMqHa2nsgUHgtKra08Q3yW3eQU57xmVoTLK+W
 iyZpKU2lAa78B/mLkUk7Unb+Qi8Zdbjax3AKA1E7fx7cd9q836hip7++VtGkLccE
 rkEHSCbCC323wQHqvJZVnRE2guNWqugqXpaO+f/vc9SKUqkfni4i2XP2s8Ia2dZh
 lgZ68U4178rBvrDijls6htsF8AVPhk4xNYjCgWr/RjFw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yax01j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:55:01 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R2t0tU016694;
 Thu, 27 Jun 2024 02:55:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yax01hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:55:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mndv0hXVAc9gIzq45DXKU07j9eN8y9+me0FEWbfF85cdmowl5dUJaVOw4gH9hAIMSQMWMq6WGoMOJiXpHRCPmcEbqK8FxirtajZRaPNYzf4+Aap/pSMv3zH/zArWFFvptil3zUIRetittmQgcg5ll23eLePWrWNsCOVB73Qe69pFM+yioE9MRs99BqjbGwiPRdoKwx0JHw8adDIl6Hf8A78SmWsJUFmZlfIYRBbJMQ2XDTDF2Lmh44D2lPm2xeTGzFIdGpSKTF+3tuJ+efM9CGNloW9BvCFxRa9lqudSu4ylKUh4hZh+2Z1S9U7Y42wrGwARcuoADmoNZ1Y6a664gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbheO4yWcD2MPqGKUaD0QhtigRHUNNLi2XyLYrqtnaw=;
 b=ZR8AkXXAO69azYRumXwpBDdhdga0THLr+OcVVgYfRIfyqO1T7bHEP1Eo6b4LsIN7cOX8ejXW4he5RafLAuJbr/mX4gMAW6W82wMZ2gDN1ETVjgmM60TaeKebEBbT9mujOeQB2gHqJRRZ5g2PvllAk9VNtOp6HVRVqRuPUUbHiuqYJvrj+QrCTYJe+WeJ/BgQo3qPtD7Tf0ye8ruK8eyMBmdDG+AtaVHxnPyS1iNSByKFVsw5l98O/lLyngDNf1VqkOwfiaKhyL+sLoGFnR8QcOzvBNZaR1ZqbHP232ysVGcWdM5e3p/9SUi3ktdqV/hfhc0z/J8RPGDwrZmtXzDn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6)
 by MN6PR15MB6001.namprd15.prod.outlook.com (2603:10b6:208:47e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 02:54:54 +0000
Received: from PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4]) by PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:54:54 +0000
From: CALEB SCHLOSSIN <calebs@us.ibm.com>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "fbarrat@linux.ibm.com"
 <fbarrat@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 Chalapathi V <Chalapathi.V@ibm.com>,
 "saif.abrar@linux.ibm.com" <saif.abrar@linux.ibm.com>, Dan Tan
 <dantan@us.ibm.com>, "milesg@linux.ibm.com" <milesg@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] hw/ssi: Extend SPI model
Thread-Topic: [PATCH v5 3/6] hw/ssi: Extend SPI model
Thread-Index: AQHax6gRoLGJJz+NME+J6SGRZ83q1bHa6xpS
Date: Thu, 27 Jun 2024 02:54:54 +0000
Message-ID: <PH0PR15MB4720ABAD9CCAAB55ED64CA47E1D72@PH0PR15MB4720.namprd15.prod.outlook.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
 <20240626090528.812-4-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240626090528.812-4-chalapathi.v@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4720:EE_|MN6PR15MB6001:EE_
x-ms-office365-filtering-correlation-id: 57431247-a01f-44b5-363a-08dc965485c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uga0s9CTXZk8aw+xfXwSLJQhGDYoNRUN8KARDcAvR6HarxYGOJwFAlzIUW?=
 =?iso-8859-1?Q?Cf8alo80gJlXkui14w9nFEowwITTd1vd6qtNAUwG7KSLj41DtV9vEJyeOk?=
 =?iso-8859-1?Q?SCuoOo79r0iS1K5zgAqqUf3yfTcjUEOzLe60ptvoGJvV0agIMbiOI5y70v?=
 =?iso-8859-1?Q?gzIt/FQvZx56L3KnKoal8GE7ZRfH+AE46QSNtA9obpNAP80ZAWILQ07HcO?=
 =?iso-8859-1?Q?nj4jRcphEZ0GQY/lU9ogsSua2CwENHpmeA8mk6M2v5I77weQHRiY8IY/aj?=
 =?iso-8859-1?Q?UdR9fOjvrFbPekpY2OwH0HKsDwkAwujGjKyV1TF7mH7v5QzywTZXD0b5FS?=
 =?iso-8859-1?Q?R+fD0+5749x3xgP1FM+ZlH3uanHTSnFK5GegHwaKvw48IOEQFySzE0THMi?=
 =?iso-8859-1?Q?9ASY7Z41WrG4JbRr9/OwIuf7xGB2yhIO7qLPt365AN2bdzcNC8Tern9IgY?=
 =?iso-8859-1?Q?UllflzAbsMfhK5wMJseqn4xZ14ZSoyAFHMggGT0/Uypd4zDG0auzUXmW5d?=
 =?iso-8859-1?Q?2QVnp0cVcF9vysStyTIW8ya8VXa2qwNIwsWP7Ywzs8wcKNTIXW3YZxvmoa?=
 =?iso-8859-1?Q?+XSvLcBOi9a02aYSa80U36OC9sQfxEQmewwPlTrvsKmbfYyfTISNDMkB8v?=
 =?iso-8859-1?Q?iZj7cNUNLM6P0haBlXiw8leHiQvwAlMJSOFjOncpuWeoqpvewf9eXKkXfn?=
 =?iso-8859-1?Q?yOc5J+kjm4pAN0EjQdNREZ8c8MiY/IaEt2YKE0zU0tNCZi5bx0ZXRXJiQq?=
 =?iso-8859-1?Q?KhCYBP4iRPBze8tkDRqL+NbnjZCKdgI/kbdTYKSYK8TCr1Z4EoqEIy690U?=
 =?iso-8859-1?Q?FJuIKA0KbhxBMUnUUpwmYAaNsqVhfn1lb2mQAkbKcpET4eZyCb0ryjGndx?=
 =?iso-8859-1?Q?Fwpwhfse+ED1d2KONAajXDXhFTh4aBfy8YayNGJ+U5hlI3VPSTgwJPfN9u?=
 =?iso-8859-1?Q?NcNwVOdASEh8JcnvEjSP2fkR9QJwT4a4Rip0ZZePqEbYqPjdn8CQBBTktP?=
 =?iso-8859-1?Q?JJ3Pd2gROsWr9ZbvZQqk5bNFnyhQUqGXmz144M/+7BK4tV6dIdIHYkcFHx?=
 =?iso-8859-1?Q?+5y1GWLBQ4dQ2yoAkmtS7DqQKFBuzLcv0GVTg3L0nD2tdOZpBG67tNkFJU?=
 =?iso-8859-1?Q?JNeF+JQuCr/frmzNy56uKbR88BbKH17xhiQUrHNQAgL/lfYzvB5exYNDsR?=
 =?iso-8859-1?Q?JcUaoZSeDrlU8cJ9M1CfG3Rh31i7wedB39hsaukZK+8j9JbXWLcL7c05xB?=
 =?iso-8859-1?Q?sMAj2ZckIFSHRTny4N+Bs5aPyHP0KOohrTSgkJS/JI53y2Lb65nAJdYaac?=
 =?iso-8859-1?Q?swx+uwn7isR2fflVTqV2dIDY3fT40t/fcC3UQ1QIh9QDt9REncMIN+2ViR?=
 =?iso-8859-1?Q?TwIcdXPtVgN1g6hJfcaC2zXC732IrzijT37ZjU2shFrBv2f6t+RujHxiJ7?=
 =?iso-8859-1?Q?kL0W58c4m1QlQhJfWHzZqba1svfuHoUpGZZCDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR15MB4720.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9VfOx7MOGUbsoKrroGZXJO/WXxTWlVi5E5BHcolCwfwj2ZDZbTEbYLPu3z?=
 =?iso-8859-1?Q?0RbjrlNB4LXiQ74kkBpexuQXfAxe/HnQN+TkYYuCcQ1udGQ7eH7+O58q7b?=
 =?iso-8859-1?Q?HdhJpT6a9BbCT1EkNnaAqOrmIfAEag4St+tYQhGifdlFePZaiEgE57tv93?=
 =?iso-8859-1?Q?PSqNao98JCFsH/tiCXG1on8HpnHK9g3pBb2FhEeCZon0L8BzDqQ796ncY3?=
 =?iso-8859-1?Q?GhXXNEW5AfURM0/ktoE8BTwyHf+E4qAOFVYJa64CCaCKRqNAOek1bE9WcM?=
 =?iso-8859-1?Q?paJnNqe6T7VN/ynNU26R8bXs+N26X+fH7g7ZzXSBCAuIdKywt26Cu6pxkQ?=
 =?iso-8859-1?Q?yndS8MX9ZYgcsSY2/VQhffEvo6c4ejigcmerFSZQl8Dzs+SfDVf7HbOr1l?=
 =?iso-8859-1?Q?GuJhyDQ3uYSLXICkqc5hjZxPjNTTS8ZIUD4+zJSZW618PVw4C4qCrygCDN?=
 =?iso-8859-1?Q?nlCDGaVgGjGrOfv/bmWK4/fgYyCzZuLdTraWyrWLHI+hwcJk7IRMhBd3rn?=
 =?iso-8859-1?Q?EKvswpWtrgPPeRsYUDRgUQx/5oKBS7s0LHlaCJjLZ2BdnwHqTdT4NSqMbP?=
 =?iso-8859-1?Q?3VeafHnIvl9UBX6tGwhO0ITF8WCslc2+98nCwwAleOAHlUOG3ixBVq2e8U?=
 =?iso-8859-1?Q?WMrYWccN3LJPwH9XE4p1id5JrRc4+8vL4aZCPgqObdeqcmKXLGzB9wUbbg?=
 =?iso-8859-1?Q?9GcOvmZE2GWg++/nEKEDN1wmFMomkh2lJKVVdmY7S8Id5eokE4iw4uVMiP?=
 =?iso-8859-1?Q?gXG0ZaKXhvhJ5fm6UgjgDvgoT9eulCnWVGvA7UhuAv3liBYlCASEycvMf0?=
 =?iso-8859-1?Q?Zkco3hnnoGekHfHR481SKzf9skp7qihy/00OFJfFMliZfMYpmK778MMetQ?=
 =?iso-8859-1?Q?Zq6FqFRpqqdKH8x10NxbrIUmJAX9m73veZQBj8gv7Q4Yqv7RGhaIFHdPKJ?=
 =?iso-8859-1?Q?igibPn/tuZZXL6EdbBjEwud29btXA1MNHXeqcab3uV/QK/IsLmtQNKpN+R?=
 =?iso-8859-1?Q?hTIhNt3vhA5WkEZyVeKWsBTl7nRiHfSrSmb/hDuQ4eC2k2lAXNT+XPvyBb?=
 =?iso-8859-1?Q?wrud0u+2joS/e/F7jEFvNtkxaLtm9RbcXUeCqIKJaJqZhulQBM0uOLjkIZ?=
 =?iso-8859-1?Q?4aku68Twl7PMCYoMH3wubZXrNJGebw6jAOk3zLg0YrkqT6I1HExzAmhACH?=
 =?iso-8859-1?Q?nnUukYxYflEtp5+KB+TmjlLsgA7TIqZ4L1bwRQyw5p7gH7WmV8ZQaT1T5l?=
 =?iso-8859-1?Q?BmhxBSn7/WhZlSjHLWKuuC1qRWmSPoJNoX2tyfOv0QacZPOU7t/H5hgCe+?=
 =?iso-8859-1?Q?WeK0dMhI3FZXfq2VhV1tbTaE27+raGu3o+GxO67R7GGrW8QsOkN6bPXi2W?=
 =?iso-8859-1?Q?GamI3ZfP6mIW0STUxu6/p+3v97E6UubKnzJ/NnwjS32ZANuBU/8fChmlQi?=
 =?iso-8859-1?Q?MDWIq3nSsh74/tfsHn+iU7YqFX5mi9e49xhPgDCsmIAm2n7oPmiEkxIBGC?=
 =?iso-8859-1?Q?TBZ8S4mgCi9NCPPCqaEHq4xCTXraVomMWpKDPBHSY4ndElBstCswBhAHvx?=
 =?iso-8859-1?Q?4R1byRdUVqye7aEIU2nilZnc1IkwPScW8UzgaxoZBvJp7j1s6LB0WD/HcW?=
 =?iso-8859-1?Q?+o40MSkAnGl5Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR15MB4720ABAD9CCAAB55ED64CA47E1D72PH0PR15MB4720namp_"
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4720.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57431247-a01f-44b5-363a-08dc965485c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 02:54:54.5189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAsyYwDXIaX0IGmedElO+ZqfFkb8skfE1UIvo/1CjYFL2HUgCntvHpPR9MvRH3LdcnEtk8+wgI/Y3bTGaPS1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6001
X-Proofpoint-GUID: dXFVnmjOQtv8NQI8Z_Sa9wVoDnRo-D5_
X-Proofpoint-ORIG-GUID: cGYeUi-mrkKv7oYDPMZ1v9flhymg3myP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH0PR15MB4720ABAD9CCAAB55ED64CA47E1D72PH0PR15MB4720namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> In this commit SPI shift engine and sequencer logic is implemented.
> Shift engine performs serialization and de-serialization according to the
> control by the sequencer and according to the setup defined in the
> configuration registers. Sequencer implements the main control logic and
> FSM to handle data transmit and data receive control of the shift engine.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>

Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Thanks,
Caleb Schlossin

________________________________
From: Chalapathi V <chalapathi.v@linux.ibm.com>
Sent: Wednesday, June 26, 2024 4:05 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: qemu-ppc@nongnu.org <qemu-ppc@nongnu.org>; fbarrat@linux.ibm.com <fbarr=
at@linux.ibm.com>; npiggin@gmail.com <npiggin@gmail.com>; clg@kaod.org <clg=
@kaod.org>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Chalapathi V <Chalapathi.V=
@ibm.com>; chalapathi.v@linux.ibm.com <chalapathi.v@linux.ibm.com>; saif.ab=
rar@linux.ibm.com <saif.abrar@linux.ibm.com>; Dan Tan <dantan@us.ibm.com>; =
milesg@linux.ibm.com <milesg@linux.ibm.com>
Subject: [PATCH v5 3/6] hw/ssi: Extend SPI model

In this commit SPI shift engine and sequencer logic is implemented.
Shift engine performs serialization and de-serialization according to the
control by the sequencer and according to the setup defined in the
configuration registers. Sequencer implements the main control logic and
FSM to handle data transmit and data receive control of the shift engine.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ssi/pnv_spi.h      |   27 +
 include/hw/ssi/pnv_spi_regs.h |   68 ++-
 hw/ssi/pnv_spi.c              | 1045 +++++++++++++++++++++++++++++++++
 hw/ssi/trace-events           |   15 +
 4 files changed, 1154 insertions(+), 1 deletion(-)

diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 833042b74b..8815f67d45 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -8,6 +8,14 @@
  * This model Supports a connection to a single SPI responder.
  * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
  * and an ADC controller.
+ *
+ * All SPI function control is mapped into the SPI register space to enabl=
e
+ * full control by firmware.
+ *
+ * SPI Controller has sequencer and shift engine. The SPI shift engine
+ * performs serialization and de-serialization according to the control by
+ * the sequencer and according to the setup defined in the configuration
+ * registers and the SPI sequencer implements the main control logic.
  */

 #ifndef PPC_PNV_SPI_H
@@ -31,6 +39,25 @@ typedef struct PnvSpi {
     MemoryRegion    xscom_spic_regs;
     /* SPI object number */
     uint32_t        spic_num;
+    uint8_t         transfer_len;
+    uint8_t         responder_select;
+    /* To verify if shift_n1 happens prior to shift_n2 */
+    bool            shift_n1_done;
+    /* Loop counter for branch operation opcode Ex/Fx */
+    uint8_t         loop_counter_1;
+    uint8_t         loop_counter_2;
+    /* N1/N2_bits specifies the size of the N1/N2 segment of a frame in bi=
ts.*/
+    uint8_t         N1_bits;
+    uint8_t         N2_bits;
+    /* Number of bytes in a payload for the N1/N2 frame segment.*/
+    uint8_t         N1_bytes;
+    uint8_t         N2_bytes;
+    /* Number of N1/N2 bytes marked for transmit */
+    uint8_t         N1_tx;
+    uint8_t         N2_tx;
+    /* Number of N1/N2 bytes marked for receive */
+    uint8_t         N1_rx;
+    uint8_t         N2_rx;

     /* SPI registers */
     uint64_t        regs[PNV_SPI_REGS];
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
index 5b6ff72d02..596e2c1911 100644
--- a/include/hw/ssi/pnv_spi_regs.h
+++ b/include/hw/ssi/pnv_spi_regs.h
@@ -28,6 +28,17 @@

 /* counter_config_reg */
 #define SPI_CTR_CFG_REG         0x01
+#define SPI_CTR_CFG_N1          PPC_BITMASK(0, 7)
+#define SPI_CTR_CFG_N2          PPC_BITMASK(8, 15)
+#define SPI_CTR_CFG_CMP1        PPC_BITMASK(24, 31)
+#define SPI_CTR_CFG_CMP2        PPC_BITMASK(32, 39)
+#define SPI_CTR_CFG_N1_CTRL_B1  PPC_BIT(49)
+#define SPI_CTR_CFG_N1_CTRL_B2  PPC_BIT(50)
+#define SPI_CTR_CFG_N1_CTRL_B3  PPC_BIT(51)
+#define SPI_CTR_CFG_N2_CTRL_B0  PPC_BIT(52)
+#define SPI_CTR_CFG_N2_CTRL_B1  PPC_BIT(53)
+#define SPI_CTR_CFG_N2_CTRL_B2  PPC_BIT(54)
+#define SPI_CTR_CFG_N2_CTRL_B3  PPC_BIT(55)

 /* config_reg */
 #define CONFIG_REG1             0x02
@@ -36,9 +47,13 @@
 #define SPI_CLK_CFG_REG         0x03
 #define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
 #define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
+#define SPI_CLK_CFG_ECC_EN      PPC_BIT(28)
+#define SPI_CLK_CFG_ECC_CTRL    PPC_BITMASK(29, 30)

 /* memory_mapping_reg */
 #define SPI_MM_REG              0x04
+#define SPI_MM_RDR_MATCH_VAL    PPC_BITMASK(32, 47)
+#define SPI_MM_RDR_MATCH_MASK   PPC_BITMASK(48, 63)

 /* transmit_data_reg */
 #define SPI_XMIT_DATA_REG       0x05
@@ -60,8 +75,59 @@
 #define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
 #define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
 #define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
-#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
+#define SPI_STS_GEN_STATUS_B3   PPC_BIT(35)
 #define SPI_STS_RDR             PPC_BITMASK(1, 3)
 #define SPI_STS_TDR             PPC_BITMASK(5, 7)

+/*
+ * Shifter states
+ *
+ * These are the same values defined for the Shifter FSM field of the
+ * status register.  It's a 12 bit field so we will represent it as three
+ * nibbles in the constants.
+ *
+ * These are shifter_fsm values
+ *
+ * Status reg bits 16-27 -> field bits 0-11
+ * bits 0,1,2,5 unused/reserved
+ * bit 4 crc shift in (unused)
+ * bit 8 crc shift out (unused)
+ */
+
+#define FSM_DONE                        0x100   /* bit 3 */
+#define FSM_SHIFT_N2                    0x020   /* bit 6 */
+#define FSM_WAIT                        0x010   /* bit 7 */
+#define FSM_SHIFT_N1                    0x004   /* bit 9 */
+#define FSM_START                       0x002   /* bit 10 */
+#define FSM_IDLE                        0x001   /* bit 11 */
+
+/*
+ * Sequencer states
+ *
+ * These are sequencer_fsm values
+ *
+ * Status reg bits 8-15 -> field bits 0-7
+ * bits 0-3 unused/reserved
+ *
+ */
+#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
+#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
+#define SEQ_STATE_DECODE                0x02    /* bit 6 */
+#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
+
+/*
+ * These are the supported sequencer operations.
+ * Only the upper nibble is significant because for many operations
+ * the lower nibble is a variable specific to the operation.
+ */
+#define SEQ_OP_STOP                     0x00
+#define SEQ_OP_SELECT_SLAVE             0x10
+#define SEQ_OP_SHIFT_N1                 0x30
+#define SEQ_OP_SHIFT_N2                 0x40
+#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
+#define SEQ_OP_TRANSFER_TDR             0xC0
+#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
+#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
+#define NUM_SEQ_OPS                     8
+
 #endif
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index de3ffc4e56..f67c2a0ee2 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -17,6 +17,9 @@
 #include "hw/irq.h"
 #include "trace.h"

+#define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
+#define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
+
 /*
  * Macro from include/hw/ppc/fdt.h
  * fdt.h cannot be included here as it contain ppc target specific depende=
ncy.
@@ -31,6 +34,1040 @@
         }                                                          \
     } while (0)

+/* PnvXferBuffer */
+typedef struct PnvXferBuffer {
+
+    uint32_t    len;
+    uint8_t    *data;
+
+} PnvXferBuffer;
+
+/* pnv_spi_xfer_buffer_methods */
+static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
+{
+    PnvXferBuffer *payload =3D g_malloc0(sizeof(*payload));
+
+    return payload;
+}
+
+static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
+{
+    free(payload->data);
+    free(payload);
+}
+
+static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
+                uint32_t offset, uint32_t length)
+{
+    if (payload->len < (offset + length)) {
+        payload->len =3D offset + length;
+        payload->data =3D g_realloc(payload->data, payload->len);
+    }
+    return &payload->data[offset];
+}
+
+static bool does_rdr_match(PnvSpi *s)
+{
+    /*
+     * According to spec, the mask bits that are 0 are compared and the
+     * bits that are 1 are ignored.
+     */
+    uint16_t rdr_match_mask =3D GETFIELD(SPI_MM_RDR_MATCH_MASK,
+                                        s->regs[SPI_MM_REG]);
+    uint16_t rdr_match_val =3D GETFIELD(SPI_MM_RDR_MATCH_VAL,
+                                        s->regs[SPI_MM_REG]);
+
+    if ((~rdr_match_mask & rdr_match_val) =3D=3D ((~rdr_match_mask) &
+            GETFIELD(PPC_BITMASK(48, 63), s->regs[SPI_RCV_DATA_REG]))) {
+        return true;
+    }
+    return false;
+}
+
+static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
+{
+    uint8_t byte;
+
+    /*
+     * Offset is an index between 0 and PNV_SPI_REG_SIZE - 1
+     * Check the offset before using it.
+     */
+    if (offset < PNV_SPI_REG_SIZE) {
+        byte =3D (s->regs[SPI_XMIT_DATA_REG] >> (56 - offset * 8)) & 0xFF;
+    } else {
+        /*
+         * Log an error and return a 0xFF since we have to assign somethin=
g
+         * to byte before returning.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid offset =3D %d used to get =
byte "
+                      "from TDR\n", offset);
+        byte =3D 0xff;
+    }
+    return byte;
+}
+
+static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_by=
tes,
+                uint8_t ecc_count, uint8_t shift_in_count)
+{
+    uint8_t byte;
+    int count =3D 0;
+
+    while (count < nr_bytes) {
+        shift_in_count++;
+        if ((ecc_count !=3D 0) &&
+            (shift_in_count =3D=3D (PNV_SPI_REG_SIZE + ecc_count))) {
+            shift_in_count =3D 0;
+        } else {
+            byte =3D read_buf[count];
+            trace_pnv_spi_shift_rx(byte, count);
+            s->regs[SPI_RCV_DATA_REG] =3D (s->regs[SPI_RCV_DATA_REG] << 8)=
 | byte;
+        }
+        count++;
+    } /* end of while */
+    return shift_in_count;
+}
+
+static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
+{
+    uint8_t ecc_count;
+    uint8_t shift_in_count;
+
+    /*
+     * Processing here must handle:
+     * - Which bytes in the payload we should move to the RDR
+     * - Explicit mode counter configuration settings
+     * - RDR full and RDR overrun status
+     */
+
+    /*
+     * First check that the response payload is the exact same
+     * number of bytes as the request payload was
+     */
+    if (rsp_payload->len !=3D (s->N1_bytes + s->N2_bytes)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
+                       "bytes, expected %d, got %d\n",
+                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
+    } else {
+        uint8_t ecc_control;
+        trace_pnv_spi_rx_received(rsp_payload->len);
+        trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
+                        s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2=
_rx);
+        /*
+         * Adding an ECC count let's us know when we have found a payload =
byte
+         * that was shifted in but cannot be loaded into RDR.  Bits 29-30 =
of
+         * clock_config_reset_control register equal to either 0b00 or 0b1=
0
+         * indicate that we are taking in data with ECC and either applyin=
g
+         * the ECC or discarding it.
+         */
+        ecc_count =3D 0;
+        ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG=
_REG]);
+        if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {
+            ecc_count =3D 1;
+        }
+        /*
+         * Use the N1_rx and N2_rx counts to control shifting data from th=
e
+         * payload into the RDR.  Keep an overall count of the number of b=
ytes
+         * shifted into RDR so we can discard every 9th byte when ECC is
+         * enabled.
+         */
+        shift_in_count =3D 0;
+        /* Handle the N1 portion of the frame first */
+        if (s->N1_rx !=3D 0) {
+            trace_pnv_spi_rx_read_N1frame();
+            shift_in_count =3D read_from_frame(s, &rsp_payload->data[0],
+                            s->N1_bytes, ecc_count, shift_in_count);
+        }
+        /* Handle the N2 portion of the frame */
+        if (s->N2_rx !=3D 0) {
+            trace_pnv_spi_rx_read_N2frame();
+            shift_in_count =3D read_from_frame(s,
+                            &rsp_payload->data[s->N1_bytes], s->N2_bytes,
+                            ecc_count, shift_in_count);
+        }
+        if ((s->N1_rx + s->N2_rx) > 0) {
+            /*
+             * Data was received so handle RDR status.
+             * It is easier to handle RDR_full and RDR_overrun status here
+             * since the RDR register's shift_byte_in method is called
+             * multiple times in a row. Controlling RDR status is done her=
e
+             * instead of in the RDR scoped methods for that reason.
+             */
+            if (GETFIELD(SPI_STS_RDR_FULL, s->status) =3D=3D 1) {
+                /*
+                 * Data was shifted into the RDR before having been read
+                 * causing previous data to have been overrun.
+                 */
+                s->status =3D SETFIELD(SPI_STS_RDR_OVERRUN, s->status, 1);
+            } else {
+                /*
+                 * Set status to indicate that the received data register =
is
+                 * full. This flag is only cleared once the RDR is unloade=
d.
+                 */
+                s->status =3D SETFIELD(SPI_STS_RDR_FULL, s->status, 1);
+            }
+        }
+    } /* end of else */
+} /* end of spi_response() */
+
+static void transfer(PnvSpi *s, PnvXferBuffer *payload)
+{
+    uint32_t tx;
+    uint32_t rx;
+    PnvXferBuffer *rsp_payload =3D NULL;
+
+    rsp_payload =3D pnv_spi_xfer_buffer_new();
+    for (int offset =3D 0; offset < payload->len; offset +=3D s->transfer_=
len) {
+        tx =3D 0;
+        for (int i =3D 0; i < s->transfer_len; i++) {
+            if ((offset + i) >=3D payload->len) {
+                tx <<=3D 8;
+            } else {
+                tx =3D (tx << 8) | payload->data[offset + i];
+            }
+        }
+        rx =3D ssi_transfer(s->ssi_bus, tx);
+        for (int i =3D 0; i < s->transfer_len; i++) {
+            if ((offset + i) >=3D payload->len) {
+                break;
+            }
+            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len,=
 1)) =3D
+                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
+        }
+    }
+    if (rsp_payload !=3D NULL) {
+        spi_response(s, s->N1_bits, rsp_payload);
+    }
+}
+
+static inline uint8_t get_seq_index(PnvSpi *s)
+{
+    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
+}
+
+static inline void next_sequencer_fsm(PnvSpi *s)
+{
+    uint8_t seq_index =3D get_seq_index(s);
+    s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1));
+    s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INC=
REMENT);
+}
+
+/*
+ * Calculate the N1 counters based on passed in opcode and
+ * internal register values.
+ * The method assumes that the opcode is a Shift_N1 opcode
+ * and doesn't test it.
+ * The counters returned are:
+ * N1 bits: Number of bits in the payload data that are significant
+ * to the responder.
+ * N1_bytes: Total count of payload bytes for the N1 (portion of the) fram=
e.
+ * N1_tx: Total number of bytes taken from TDR for N1
+ * N1_rx: Total number of bytes taken from the payload for N1
+ */
+static void calculate_N1(PnvSpi *s, uint8_t opcode)
+{
+    /*
+     * Shift_N1 opcode form: 0x3M
+     * Implicit mode:
+     * If M !=3D 0 the shift count is M bytes and M is the number of tx by=
tes.
+     * Forced Implicit mode:
+     * M is the shift count but tx and rx is determined by the count contr=
ol
+     * register fields.  Note that we only check for forced Implicit mode =
when
+     * M !=3D 0 since the mode doesn't make sense when M =3D 0.
+     * Explicit mode:
+     * If M =3D=3D 0 then shift count is number of bits defined in the
+     * Counter Configuration Register's shift_count_N1 field.
+     */
+    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) =3D=3D 0) {
+        /* Explicit mode */
+        s->N1_bits =3D GETFIELD(SPI_CTR_CFG_N1, s->regs[SPI_CTR_CFG_REG]);
+        s->N1_bytes =3D (s->N1_bits + 7) / 8;
+        s->N1_tx =3D 0;
+        s->N1_rx =3D 0;
+        /* If tx count control for N1 is set, load the tx value */
+        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            s->N1_tx =3D s->N1_bytes;
+        }
+        /* If rx count control for N1 is set, load the rx value */
+        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            s->N1_rx =3D s->N1_bytes;
+        }
+    } else {
+        /* Implicit mode/Forced Implicit mode, use M field from opcode */
+        s->N1_bytes =3D PNV_SPI_OPCODE_LO_NIBBLE(opcode);
+        s->N1_bits =3D s->N1_bytes * 8;
+        /*
+         * Assume that we are going to transmit the count
+         * (pure Implicit only)
+         */
+        s->N1_tx =3D s->N1_bytes;
+        s->N1_rx =3D 0;
+        /* Let Forced Implicit mode have an effect on the counts */
+        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B1, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            /*
+             * If Forced Implicit mode and count control doesn't
+             * indicate transmit then reset the tx count to 0
+             */
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
+                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 0) {
+                s->N1_tx =3D 0;
+            }
+            /* If rx count control for N1 is set, load the rx value */
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
+                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 1) {
+                s->N1_rx =3D s->N1_bytes;
+            }
+        }
+    }
+    /*
+     * Enforce an upper limit on the size of N1 that is equal to the known=
 size
+     * of the shift register, 64 bits or 72 bits if ECC is enabled.
+     * If the size exceeds 72 bits it is a user error so log an error,
+     * cap the size at a max of 64 bits or 72 bits and set the sequencer F=
SM
+     * error bit.
+     */
+    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,
+                                   s->regs[SPI_CLK_CFG_REG]);
+    if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {
+        if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size when=
 "
+                          "ECC enabled, bytes =3D 0x%x, bits =3D 0x%x\n",
+                          s->N1_bytes, s->N1_bits);
+            s->N1_bytes =3D PNV_SPI_REG_SIZE + 1;
+            s->N1_bits =3D s->N1_bytes * 8;
+        }
+    } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
+                      "bytes =3D 0x%x, bits =3D 0x%x\n",
+                      s->N1_bytes, s->N1_bits);
+        s->N1_bytes =3D PNV_SPI_REG_SIZE;
+        s->N1_bits =3D s->N1_bytes * 8;
+    }
+} /* end of calculate_N1 */
+
+/*
+ * Shift_N1 operation handler method
+ */
+static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
+                       PnvXferBuffer **payload, bool send_n1_alone)
+{
+    uint8_t n1_count;
+    bool stop =3D false;
+
+    /*
+     * If there isn't a current payload left over from a stopped sequence
+     * create a new one.
+     */
+    if (*payload =3D=3D NULL) {
+        *payload =3D pnv_spi_xfer_buffer_new();
+    }
+    /*
+     * Use a combination of N1 counters to build the N1 portion of the
+     * transmit payload.
+     * We only care about transmit at this time since the request payload
+     * only represents data going out on the controller output line.
+     * Leave mode specific considerations in the calculate function since
+     * all we really care about are counters that tell use exactly how
+     * many bytes are in the payload and how many of those bytes to
+     * include from the TDR into the payload.
+     */
+    calculate_N1(s, opcode);
+    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
+                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx)=
;
+    /*
+     * Zero out the N2 counters here in case there is no N2 operation foll=
owing
+     * the N1 operation in the sequencer.  This keeps leftover N2 informat=
ion
+     * from interfering with spi_response logic.
+     */
+    s->N2_bits =3D 0;
+    s->N2_bytes =3D 0;
+    s->N2_tx =3D 0;
+    s->N2_rx =3D 0;
+    /*
+     * N1_bytes is the overall size of the N1 portion of the frame regardl=
ess of
+     * whether N1 is used for tx, rx or both.  Loop over the size to build=
 a
+     * payload that is N1_bytes long.
+     * N1_tx is the count of bytes to take from the TDR and "shift" into t=
he
+     * frame which means append those bytes to the payload for the N1 port=
ion
+     * of the frame.
+     * If N1_tx is 0 or if the count exceeds the size of the TDR append 0x=
FF to
+     * the frame until the overall N1 count is reached.
+     */
+    n1_count =3D 0;
+    while (n1_count < s->N1_bytes) {
+        /*
+         * Assuming that if N1_tx is not equal to 0 then it is the same as
+         * N1_bytes.
+         */
+        if ((s->N1_tx !=3D 0) && (n1_count < PNV_SPI_REG_SIZE)) {
+
+            if (GETFIELD(SPI_STS_TDR_FULL, s->status) =3D=3D 1) {
+                /*
+                 * Note that we are only appending to the payload IF the T=
DR
+                 * is full otherwise we don't touch the payload because we=
 are
+                 * going to NOT send the payload and instead tell the sequ=
encer
+                 * that called us to stop and wait for a TDR write so we h=
ave
+                 * data to load into the payload.
+                 */
+                uint8_t n1_byte =3D 0x00;
+                n1_byte =3D get_from_offset(s, n1_count);
+                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
+                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len,=
 1)) =3D
+                        n1_byte;
+            } else {
+                /*
+                 * We hit a shift_n1 opcode TX but the TDR is empty, tell =
the
+                 * sequencer to stop and break this loop.
+                 */
+                trace_pnv_spi_sequencer_stop_requested("Shift N1"
+                                "set for transmit but TDR is empty");
+                stop =3D true;
+                break;
+            }
+        } else {
+            /*
+             * Cases here:
+             * - we are receiving during the N1 frame segment and the RDR
+             *   is full so we need to stop until the RDR is read
+             * - we are transmitting and we don't care about RDR status
+             *   since we won't be loading RDR during the frame segment.
+             * - we are receiving and the RDR is empty so we allow the ope=
ration
+             *   to proceed.
+             */
+            if ((s->N1_rx !=3D 0) && (GETFIELD(SPI_STS_RDR_FULL,
+                                           s->status) =3D=3D 1)) {
+                trace_pnv_spi_sequencer_stop_requested("shift N1"
+                                "set for receive but RDR is full");
+                stop =3D true;
+                break;
+            } else {
+                trace_pnv_spi_tx_append_FF("n1_byte");
+                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len,=
 1))
+                        =3D 0xff;
+            }
+        }
+        n1_count++;
+    } /* end of while */
+    /*
+     * If we are not stopping due to an empty TDR and we are doing an N1 T=
X
+     * and the TDR is full we need to clear the TDR_full status.
+     * Do this here instead of up in the loop above so we don't log the me=
ssage
+     * in every loop iteration.
+     * Ignore the send_n1_alone flag, all that does is defer the TX until =
the N2
+     * operation, which was found immediately after the current opcode.  T=
he TDR
+     * was unloaded and will be shifted so we have to clear the TDR_full s=
tatus.
+     */
+    if (!stop && (s->N1_tx !=3D 0) &&
+        (GETFIELD(SPI_STS_TDR_FULL, s->status) =3D=3D 1)) {
+        s->status =3D SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
+    }
+    /*
+     * There are other reasons why the shifter would stop, such as a TDR e=
mpty
+     * or RDR full condition with N1 set to receive.  If we haven't stoppe=
d due
+     * to either one of those conditions then check if the send_n1_alone f=
lag is
+     * equal to False, indicating the next opcode is an N2 operation, AND =
if
+     * the N2 counter reload switch (bit 0 of the N2 count control field) =
is
+     * set.  This condition requires a pacing write to "kick" off the N2
+     * shift which includes the N1 shift as well when send_n1_alone is Fal=
se.
+     */
+    if (!stop && !send_n1_alone &&
+       (GETFIELD(SPI_CTR_CFG_N2_CTRL_B0, s->regs[SPI_CTR_CFG_REG]) =3D=3D =
1)) {
+        trace_pnv_spi_sequencer_stop_requested("N2 counter reload "
+                        "active, stop N1 shift, TDR_underrun set to 1");
+        stop =3D true;
+        s->status =3D SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 1);
+    }
+    /*
+     * If send_n1_alone is set AND we have a full TDR then this is the fir=
st and
+     * last payload to send and we don't have an N2 frame segment to add t=
o the
+     * payload.
+     */
+    if (send_n1_alone && !stop) {
+        /* We have a TX and a full TDR or an RX and an empty RDR */
+        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
+        transfer(s, *payload);
+        /* The N1 frame shift is complete so reset the N1 counters */
+        s->N2_bits =3D 0;
+        s->N2_bytes =3D 0;
+        s->N2_tx =3D 0;
+        s->N2_rx =3D 0;
+        pnv_spi_xfer_buffer_free(*payload);
+        *payload =3D NULL;
+    }
+    return stop;
+} /* end of operation_shiftn1() */
+
+/*
+ * Calculate the N2 counters based on passed in opcode and
+ * internal register values.
+ * The method assumes that the opcode is a Shift_N2 opcode
+ * and doesn't test it.
+ * The counters returned are:
+ * N2 bits: Number of bits in the payload data that are significant
+ * to the responder.
+ * N2_bytes: Total count of payload bytes for the N2 frame.
+ * N2_tx: Total number of bytes taken from TDR for N2
+ * N2_rx: Total number of bytes taken from the payload for N2
+ */
+static void calculate_N2(PnvSpi *s, uint8_t opcode)
+{
+    /*
+     * Shift_N2 opcode form: 0x4M
+     * Implicit mode:
+     * If M!=3D0 the shift count is M bytes and M is the number of rx byte=
s.
+     * Forced Implicit mode:
+     * M is the shift count but tx and rx is determined by the count contr=
ol
+     * register fields.  Note that we only check for Forced Implicit mode =
when
+     * M !=3D 0 since the mode doesn't make sense when M =3D 0.
+     * Explicit mode:
+     * If M=3D=3D0 then shift count is number of bits defined in the
+     * Counter Configuration Register's shift_count_N1 field.
+     */
+    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) =3D=3D 0) {
+        /* Explicit mode */
+        s->N2_bits =3D GETFIELD(SPI_CTR_CFG_N2, s->regs[SPI_CTR_CFG_REG]);
+        s->N2_bytes =3D (s->N2_bits + 7) / 8;
+        s->N2_tx =3D 0;
+        s->N2_rx =3D 0;
+        /* If tx count control for N2 is set, load the tx value */
+        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            s->N2_tx =3D s->N2_bytes;
+        }
+        /* If rx count control for N2 is set, load the rx value */
+        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            s->N2_rx =3D s->N2_bytes;
+        }
+    } else {
+        /* Implicit mode/Forced Implicit mode, use M field from opcode */
+        s->N2_bytes =3D PNV_SPI_OPCODE_LO_NIBBLE(opcode);
+        s->N2_bits =3D s->N2_bytes * 8;
+        /* Assume that we are going to receive the count */
+        s->N2_rx =3D s->N2_bytes;
+        s->N2_tx =3D 0;
+        /* Let Forced Implicit mode have an effect on the counts */
+        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B1, s->regs[SPI_CTR_CFG_REG]) =3D=
=3D 1) {
+            /*
+             * If Forced Implicit mode and count control doesn't
+             * indicate a receive then reset the rx count to 0
+             */
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
+                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 0) {
+                s->N2_rx =3D 0;
+            }
+            /* If tx count control for N2 is set, load the tx value */
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
+                                    s->regs[SPI_CTR_CFG_REG]) =3D=3D 1) {
+                s->N2_tx =3D s->N2_bytes;
+            }
+        }
+    }
+    /*
+     * Enforce an upper limit on the size of N1 that is equal to the
+     * known size of the shift register, 64 bits or 72 bits if ECC
+     * is enabled.
+     * If the size exceeds 72 bits it is a user error so log an error,
+     * cap the size at a max of 64 bits or 72 bits and set the sequencer F=
SM
+     * error bit.
+     */
+    uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,
+                    s->regs[SPI_CLK_CFG_REG]);
+    if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {
+        if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
+            /* Unsupported N2 shift size when ECC enabled */
+            s->N2_bytes =3D PNV_SPI_REG_SIZE + 1;
+            s->N2_bits =3D s->N2_bytes * 8;
+        }
+    } else if (s->N2_bytes > PNV_SPI_REG_SIZE) {
+        /* Unsupported N2 shift size */
+        s->N2_bytes =3D PNV_SPI_REG_SIZE;
+        s->N2_bits =3D s->N2_bytes * 8;
+    }
+} /* end of calculate_N2 */
+
+/*
+ * Shift_N2 operation handler method
+ */
+
+static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
+                       PnvXferBuffer **payload)
+{
+    uint8_t n2_count;
+    bool stop =3D false;
+
+    /*
+     * If there isn't a current payload left over from a stopped sequence
+     * create a new one.
+     */
+    if (*payload =3D=3D NULL) {
+        *payload =3D pnv_spi_xfer_buffer_new();
+    }
+    /*
+     * Use a combination of N2 counters to build the N2 portion of the
+     * transmit payload.
+     */
+    calculate_N2(s, opcode);
+    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
+                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx)=
;
+    /*
+     * The only difference between this code and the code for shift N1 is
+     * that this code has to account for the possible presence of N1 trans=
mit
+     * bytes already taken from the TDR.
+     * If there are bytes to be transmitted for the N2 portion of the fram=
e
+     * and there are still bytes in TDR that have not been copied into the
+     * TX data of the payload, this code will handle transmitting those
+     * remaining bytes.
+     * If for some reason the transmit count(s) add up to more than the si=
ze
+     * of the TDR we will just append 0xFF to the transmit payload data un=
til
+     * the payload is N1 + N2 bytes long.
+     */
+    n2_count =3D 0;
+    while (n2_count < s->N2_bytes) {
+        /*
+         * If the RDR is full and we need to RX just bail out, letting the
+         * code continue will end up building the payload twice in the sam=
e
+         * buffer since RDR full causes a sequence stop and restart.
+         */
+        if ((s->N2_rx !=3D 0) &&
+            (GETFIELD(SPI_STS_RDR_FULL, s->status) =3D=3D 1)) {
+            trace_pnv_spi_sequencer_stop_requested("shift N2 set"
+                            "for receive but RDR is full");
+            stop =3D true;
+            break;
+        }
+        if ((s->N2_tx !=3D 0) && ((s->N1_tx + n2_count) <
+                                PNV_SPI_REG_SIZE)) {
+            /* Always append data for the N2 segment if it is set for TX *=
/
+            uint8_t n2_byte =3D 0x00;
+            n2_byte =3D get_from_offset(s, (s->N1_tx + n2_count));
+            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_cou=
nt));
+            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
+                    =3D n2_byte;
+        } else {
+            /*
+             * Regardless of whether or not N2 is set for TX or RX, we nee=
d
+             * the number of bytes in the payload to match the overall len=
gth
+             * of the operation.
+             */
+            trace_pnv_spi_tx_append_FF("n2_byte");
+            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
+                    =3D 0xff;
+        }
+        n2_count++;
+    } /* end of while */
+    if (!stop) {
+        /* We have a TX and a full TDR or an RX and an empty RDR */
+        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
+        transfer(s, *payload);
+        /*
+         * If we are doing an N2 TX and the TDR is full we need to clear t=
he
+         * TDR_full status. Do this here instead of up in the loop above s=
o we
+         * don't log the message in every loop iteration.
+         */
+        if ((s->N2_tx !=3D 0) &&
+            (GETFIELD(SPI_STS_TDR_FULL, s->status) =3D=3D 1)) {
+            s->status =3D SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
+        }
+        /*
+         * The N2 frame shift is complete so reset the N2 counters.
+         * Reset the N1 counters also in case the frame was a combination =
of
+         * N1 and N2 segments.
+         */
+        s->N2_bits =3D 0;
+        s->N2_bytes =3D 0;
+        s->N2_tx =3D 0;
+        s->N2_rx =3D 0;
+        s->N1_bits =3D 0;
+        s->N1_bytes =3D 0;
+        s->N1_tx =3D 0;
+        s->N1_rx =3D 0;
+        pnv_spi_xfer_buffer_free(*payload);
+        *payload =3D NULL;
+    }
+    return stop;
+} /*  end of operation_shiftn2()*/
+
+static void operation_sequencer(PnvSpi *s)
+{
+    /*
+     * Loop through each sequencer operation ID and perform the requested
+     *  operations.
+     * Flag for indicating if we should send the N1 frame or wait to combi=
ne
+     * it with a preceding N2 frame.
+     */
+    bool send_n1_alone =3D true;
+    bool stop =3D false; /* Flag to stop the sequencer */
+    uint8_t opcode =3D 0;
+    uint8_t masked_opcode =3D 0;
+
+    /*
+     * PnvXferBuffer for containing the payload of the SPI frame.
+     * This is a static because there are cases where a sequence has to st=
op
+     * and wait for the target application to unload the RDR.  If this occ=
urs
+     * during a sequence where N1 is not sent alone and instead combined w=
ith
+     * N2 since the N1 tx length + the N2 tx length is less than the size =
of
+     * the TDR.
+     */
+    static PnvXferBuffer *payload;
+
+    if (payload =3D=3D NULL) {
+        payload =3D pnv_spi_xfer_buffer_new();
+    }
+    /*
+     * Clear the sequencer FSM error bit - general_SPI_status[3]
+     * before starting a sequence.
+     */
+    s->status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 0);
+    /*
+     * If the FSM is idle set the sequencer index to 0
+     * (new/restarted sequence)
+     */
+    if (GETFIELD(SPI_STS_SEQ_FSM, s->status) =3D=3D SEQ_STATE_IDLE) {
+        s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
+    }
+    /*
+     * There are only 8 possible operation IDs to iterate through though
+     * some operations may cause more than one frame to be sequenced.
+     */
+    while (get_seq_index(s) < NUM_SEQ_OPS) {
+        opcode =3D s->seq_op[get_seq_index(s)];
+        /* Set sequencer state to decode */
+        s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECOD=
E);
+        /*
+         * Only the upper nibble of the operation ID is needed to know wha=
t
+         * kind of operation is requested.
+         */
+        masked_opcode =3D PNV_SPI_MASKED_OPCODE(opcode);
+        switch (masked_opcode) {
+        /*
+         * Increment the operation index in each case instead of just
+         * once at the end in case an operation like the branch
+         * operation needs to change the index.
+         */
+        case SEQ_OP_STOP:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            /* A stop operation in any position stops the sequencer */
+            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
+
+            stop =3D true;
+            s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDL=
E);
+            s->loop_counter_1 =3D 0;
+            s->loop_counter_2 =3D 0;
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_I=
DLE);
+            break;
+
+        case SEQ_OP_SELECT_SLAVE:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
+            /*
+             * This device currently only supports a single responder
+             * connection at position 0.  De-selecting a responder is fine
+             * and expected at the end of a sequence but selecting any
+             * responder other than 0 should cause an error.
+             */
+            s->responder_select =3D PNV_SPI_OPCODE_LO_NIBBLE(opcode);
+            if (s->responder_select =3D=3D 0) {
+                trace_pnv_spi_shifter_done();
+                qemu_set_irq(s->cs_line[0], 1);
+                s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status,
+                                (get_seq_index(s) + 1));
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM=
_DONE);
+            } else if (s->responder_select !=3D 1) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than=
 1 "
+                              "not supported, select =3D 0x%x\n",
+                               s->responder_select);
+                trace_pnv_spi_sequencer_stop_requested("invalid "
+                                "responder select");
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM=
_IDLE);
+                stop =3D true;
+            } else {
+                /*
+                 * Only allow an FSM_START state when a responder is
+                 * selected
+                 */
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM=
_START);
+                trace_pnv_spi_shifter_stating();
+                qemu_set_irq(s->cs_line[0], 0);
+                /*
+                 * A Shift_N2 operation is only valid after a Shift_N1
+                 * according to the spec. The spec doesn't say if that mea=
ns
+                 * immediately after or just after at any point. We will t=
rack
+                 * the occurrence of a Shift_N1 to enforce this requiremen=
t in
+                 * the most generic way possible by assuming that the rule
+                 * applies once a valid responder select has occurred.
+                 */
+                s->shift_n1_done =3D false;
+                next_sequencer_fsm(s);
+            }
+            break;
+
+        case SEQ_OP_SHIFT_N1:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
+            /*
+             * Only allow a shift_n1 when the state is not IDLE or DONE.
+             * In either of those two cases the sequencer is not in a prop=
er
+             * state to perform shift operations because the sequencer has=
:
+             * - processed a responder deselect (DONE)
+             * - processed a stop opcode (IDLE)
+             * - encountered an error (IDLE)
+             */
+            if ((GETFIELD(SPI_STS_SHIFTER_FSM, s->status) =3D=3D FSM_IDLE)=
 ||
+                (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) =3D=3D FSM_DONE)=
) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed in "
+                              "shifter state =3D 0x%llx", GETFIELD(
+                        SPI_STS_SHIFTER_FSM, s->status));
+                /*
+                 * Set sequencer FSM error bit 3 (general_SPI_status[3])
+                 * in status reg.
+                 */
+                s->status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1=
);
+                trace_pnv_spi_sequencer_stop_requested("invalid shifter st=
ate");
+                stop =3D true;
+            } else {
+                /*
+                 * Look for the special case where there is a shift_n1 set=
 for
+                 * transmit and it is followed by a shift_n2 set for trans=
mit
+                 * AND the combined transmit length of the two operations =
is
+                 * less than or equal to the size of the TDR register. In =
this
+                 * case we want to use both this current shift_n1 opcode a=
nd the
+                 * following shift_n2 opcode to assemble the frame for
+                 * transmission to the responder without requiring a refil=
l of
+                 * the TDR between the two operations.
+                 */
+                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
+                                =3D=3D SEQ_OP_SHIFT_N2) {
+                    send_n1_alone =3D false;
+                }
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
+                                FSM_SHIFT_N1);
+                stop =3D operation_shiftn1(s, opcode, &payload, send_n1_al=
one);
+                if (stop) {
+                    /*
+                     *  The operation code says to stop, this can occur if=
:
+                     * (1) RDR is full and the N1 shift is set for receive
+                     * (2) TDR was empty at the time of the N1 shift so we=
 need
+                     * to wait for data.
+                     * (3) Neither 1 nor 2 are occurring and we aren't sen=
ding
+                     * N1 alone and N2 counter reload is set (bit 0 of the=
 N2
+                     * counter reload field).  In this case TDR_underrun w=
ill
+                     * will be set and the Payload has been loaded so it i=
s
+                     * ok to advance the sequencer.
+                     */
+                    if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
+                        s->shift_n1_done =3D true;
+                        s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->sta=
tus,
+                                                  FSM_SHIFT_N2);
+                        s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->statu=
s,
+                                        (get_seq_index(s) + 1));
+                    } else {
+                        /*
+                         * This is case (1) or (2) so the sequencer needs =
to
+                         * wait and NOT go to the next sequence yet.
+                         */
+                        s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->sta=
tus,
+                                        FSM_WAIT);
+                    }
+                } else {
+                    /* Ok to move on to the next index */
+                    s->shift_n1_done =3D true;
+                    next_sequencer_fsm(s);
+                }
+            }
+            break;
+
+        case SEQ_OP_SHIFT_N2:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("SHIFT_N2", get_seq_index(s));
+            if (!s->shift_n1_done) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not allowed if=
 a "
+                              "Shift_N1 is not done, shifter state =3D 0x%=
llx",
+                              GETFIELD(SPI_STS_SHIFTER_FSM, s->status));
+                /*
+                 * In case the sequencer actually stops if an N2 shift is
+                 * requested before any N1 shift is done. Set sequencer FS=
M
+                 * error bit 3 (general_SPI_status[3]) in status reg.
+                 */
+                s->status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1=
);
+                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
+                                    "w/no shift_n1 done");
+                stop =3D true;
+            } else {
+                /* Ok to do a Shift_N2 */
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
+                                FSM_SHIFT_N2);
+                stop =3D operation_shiftn2(s, opcode, &payload);
+                /*
+                 * If the operation code says to stop set the shifter stat=
e to
+                 * wait and stop
+                 */
+                if (stop) {
+                    s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
+                                    FSM_WAIT);
+                } else {
+                    /* Ok to move on to the next index */
+                    next_sequencer_fsm(s);
+                }
+            }
+            break;
+
+        case SEQ_OP_BRANCH_IFNEQ_RDR:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", get_seq_index(s=
));
+            /*
+             * The memory mapping register RDR match value is compared aga=
inst
+             * the 16 rightmost bytes of the RDR (potentially with masking=
).
+             * Since this comparison is performed against the contents of =
the
+             * RDR then a receive must have previously occurred otherwise
+             * there is no data to compare and the operation cannot be
+             * completed and will stop the sequencer until RDR full is set=
 to
+             * 1.
+             */
+            if (GETFIELD(SPI_STS_RDR_FULL, s->status) =3D=3D 1) {
+                bool rdr_matched =3D false;
+                rdr_matched =3D does_rdr_match(s);
+                if (rdr_matched) {
+                    trace_pnv_spi_RDR_match("success");
+                    /* A match occurred, increment the sequencer index. */
+                    next_sequencer_fsm(s);
+                } else {
+                    trace_pnv_spi_RDR_match("failed");
+                    /*
+                     * Branch the sequencer to the index coded into the op
+                     * code.
+                     */
+                    s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status,
+                                    PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                }
+                /*
+                 * Regardless of where the branch ended up we want the
+                 * sequencer to continue shifting so we have to clear
+                 * RDR_full.
+                 */
+                s->status =3D SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
+            } else {
+                trace_pnv_spi_sequencer_stop_requested("RDR not"
+                                "full for 0x6x opcode");
+                stop =3D true;
+                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM=
_WAIT);
+            }
+            break;
+
+        case SEQ_OP_TRANSFER_TDR:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not supported\=
n");
+            next_sequencer_fsm(s);
+            break;
+
+        case SEQ_OP_BRANCH_IFNEQ_INC_1:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", get_seq_index=
(s));
+            /*
+             * The spec says the loop should execute count compare + 1 tim=
es.
+             * However we learned from engineering that we really only loo=
p
+             * count_compare times, count compare =3D 0 makes this op code=
 a
+             * no-op
+             */
+            if (s->loop_counter_1 !=3D
+                GETFIELD(SPI_CTR_CFG_CMP1, s->regs[SPI_CTR_CFG_REG])) {
+                /*
+                 * Next index is the lower nibble of the branch operation =
ID,
+                 * mask off all but the first three bits so we don't try t=
o
+                 * access beyond the sequencer_operation_reg boundary.
+                 */
+                s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status,
+                                PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                s->loop_counter_1++;
+            } else {
+                /* Continue to next index if loop counter is reached */
+                next_sequencer_fsm(s);
+            }
+            break;
+
+        case SEQ_OP_BRANCH_IFNEQ_INC_2:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index=
(s));
+            uint8_t condition2 =3D GETFIELD(SPI_CTR_CFG_CMP2,
+                              s->regs[SPI_CTR_CFG_REG]);
+            /*
+             * The spec says the loop should execute count compare + 1 tim=
es.
+             * However we learned from engineering that we really only loo=
p
+             * count_compare times, count compare =3D 0 makes this op code=
 a
+             * no-op
+             */
+            if (s->loop_counter_2 !=3D condition2) {
+                /*
+                 * Next index is the lower nibble of the branch operation =
ID,
+                 * mask off all but the first three bits so we don't try t=
o
+                 * access beyond the sequencer_operation_reg boundary.
+                 */
+                s->status =3D SETFIELD(SPI_STS_SEQ_INDEX,
+                                s->status, PNV_SPI_OPCODE_LO_NIBBLE(opcode=
));
+                s->loop_counter_2++;
+            } else {
+                /* Continue to next index if loop counter is reached */
+                next_sequencer_fsm(s);
+            }
+            break;
+
+        default:
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_E=
XECUTE);
+            /* Ignore unsupported operations. */
+            next_sequencer_fsm(s);
+            break;
+        } /* end of switch */
+        /*
+         * If we used all 8 opcodes without seeing a 00 - STOP in the sequ=
ence
+         * we need to go ahead and end things as if there was a STOP at th=
e
+         * end.
+         */
+        if (get_seq_index(s) =3D=3D NUM_SEQ_OPS) {
+            /* All 8 opcodes completed, sequencer idling */
+            s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDL=
E);
+            s->status =3D SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
+            s->loop_counter_1 =3D 0;
+            s->loop_counter_2 =3D 0;
+            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_I=
DLE);
+            break;
+        }
+        /* Break the loop if a stop was requested */
+        if (stop) {
+            break;
+        }
+    } /* end of while */
+    return;
+} /* end of operation_sequencer() */
+
+/*
+ * The SPIC engine and its internal sequencer can be interrupted and reset=
 by
+ * a hardware signal, the sbe_spicst_hard_reset bits from Pervasive
+ * Miscellaneous Register of sbe_register_bo device.
+ * Reset immediately aborts any SPI transaction in progress and returns th=
e
+ * sequencer and state machines to idle state.
+ * The configuration register values are not changed. The status register =
is
+ * not reset. The engine registers are not reset.
+ * The SPIC engine reset does not have any affect on the attached devices.
+ * Reset handling of any attached devices is beyond the scope of the engin=
e.
+ */
+static void do_reset(DeviceState *dev)
+{
+    PnvSpi *s =3D PNV_SPI(dev);
+
+    trace_pnv_spi_reset();
+
+    /* Reset all N1 and N2 counters, and other constants */
+    s->N2_bits =3D 0;
+    s->N2_bytes =3D 0;
+    s->N2_tx =3D 0;
+    s->N2_rx =3D 0;
+    s->N1_bits =3D 0;
+    s->N1_bytes =3D 0;
+    s->N1_tx =3D 0;
+    s->N1_rx =3D 0;
+    s->loop_counter_1 =3D 0;
+    s->loop_counter_2 =3D 0;
+    /* Disconnected from responder */
+    qemu_set_irq(s->cs_line[0], 1);
+}
+
 static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned siz=
e)
 {
     PnvSpi *s =3D PNV_SPI(opaque);
@@ -50,6 +1087,10 @@ static uint64_t pnv_spi_xscom_read(void *opaque, hwadd=
r addr, unsigned size)
         val =3D s->regs[reg];
         trace_pnv_spi_read_RDR(val);
         s->status =3D SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
+        if (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) =3D=3D FSM_WAIT) {
+            trace_pnv_spi_start_sequencer();
+            operation_sequencer(s);
+        }
         break;
     case SPI_SEQ_OP_REG:
         val =3D 0;
@@ -111,6 +1152,8 @@ static void pnv_spi_xscom_write(void *opaque, hwaddr a=
ddr,
         trace_pnv_spi_write_TDR(val);
         s->status =3D SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
         s->status =3D SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
+        trace_pnv_spi_start_sequencer();
+        operation_sequencer(s);
         break;
     case SPI_SEQ_OP_REG:
         for (int i =3D 0; i < PNV_SPI_REG_SIZE; i++) {
@@ -143,6 +1186,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops =3D {

 static Property pnv_spi_properties[] =3D {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
     DEFINE_PROP_END_OF_LIST(),
 };

@@ -192,6 +1236,7 @@ static void pnv_spi_class_init(ObjectClass *klass, voi=
d *data)

     dc->desc =3D "PowerNV SPI";
     dc->realize =3D pnv_spi_realize;
+    dc->reset =3D do_reset;
     device_class_set_props(dc, pnv_spi_properties);
 }

diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 4388024a05..7fa27ebade 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -38,3 +38,18 @@ pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRI=
x64 " val 0x%" PRIx64
 pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PR=
Ix64
 pnv_spi_read_RDR(uint64_t val) "data extracted =3D 0x%" PRIx64
 pnv_spi_write_TDR(uint64_t val) "being written, data written =3D 0x%" PRIx=
64
+pnv_spi_start_sequencer(void) ""
+pnv_spi_reset(void) "spic engine sequencer configuration and spi communica=
tion"
+pnv_spi_sequencer_op(const char* op, uint8_t index) "%s at index =3D 0x%x"
+pnv_spi_shifter_stating(void) "pull CS line low"
+pnv_spi_shifter_done(void) "pull the CS line high"
+pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t N1_tx, uint=
8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t N2_tx, uint8_t N2_rx)=
 "N1_bits =3D %d, N1_bytes =3D %d, N1_tx =3D %d, N1_rx =3D %d, N2_bits =3D =
%d, N2_bytes =3D %d, N2_tx =3D %d, N2_rx =3D %d"
+pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t tdr_index) "%s =
=3D 0x%2.2x to payload from TDR at index %d"
+pnv_spi_tx_append_FF(const char* frame) "%s to Payload"
+pnv_spi_tx_request(const char* frame, uint32_t payload_len) "%s, payload l=
en =3D %d"
+pnv_spi_rx_received(uint32_t payload_len) "payload len =3D %d"
+pnv_spi_rx_read_N1frame(void) ""
+pnv_spi_rx_read_N2frame(void) ""
+pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte =3D 0x%2.2x into RDR =
from payload index %d"
+pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
+pnv_spi_RDR_match(const char* result) "%s"
--
2.39.3


--_000_PH0PR15MB4720ABAD9CCAAB55ED64CA47E1D72PH0PR15MB4720namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
&gt; In this commit SPI shift engine and sequencer logic is implemented.<br=
>
&gt; Shift engine performs serialization and de-serialization according to =
the<br>
&gt; control by the sequencer and according to the setup defined in the<br>
&gt; configuration registers. Sequencer implements the main control logic a=
nd<br>
&gt; FSM to handle data transmit and data receive control of the shift engi=
ne.<br>
&gt;&nbsp;<br>
&gt; Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
Reviewed-by: Caleb Schlossin &lt;calebs@linux.vnet.ibm.com&gt;</div>
<div style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family:=
 Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin: 0px; font-family: Arial, Helvetica, sans-serif; font-=
size: 10pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"margin: 0px; font-family: Arial, Hel=
vetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
Caleb Schlossin</div>
<div id=3D"Signature"></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Chalap=
athi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, June 26, 2024 4:05 AM<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;qemu-ppc@nongnu.org &lt;qemu-ppc@nongnu.org&gt;; fbarrat@li=
nux.ibm.com &lt;fbarrat@linux.ibm.com&gt;; npiggin@gmail.com &lt;npiggin@gm=
ail.com&gt;; clg@kaod.org &lt;clg@kaod.org&gt;; CALEB SCHLOSSIN &lt;calebs@=
us.ibm.com&gt;; Chalapathi V &lt;Chalapathi.V@ibm.com&gt;; chalapathi.v@lin=
ux.ibm.com
 &lt;chalapathi.v@linux.ibm.com&gt;; saif.abrar@linux.ibm.com &lt;saif.abra=
r@linux.ibm.com&gt;; Dan Tan &lt;dantan@us.ibm.com&gt;; milesg@linux.ibm.co=
m &lt;milesg@linux.ibm.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v5 3/6] hw/ssi: Extend SPI model</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">In this commit SPI shift engine and sequenc=
er logic is implemented.<br>
Shift engine performs serialization and de-serialization according to the<b=
r>
control by the sequencer and according to the setup defined in the<br>
configuration registers. Sequencer implements the main control logic and<br=
>
FSM to handle data transmit and data receive control of the shift engine.<b=
r>
<br>
Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
---<br>
&nbsp;include/hw/ssi/pnv_spi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; =
27 +<br>
&nbsp;include/hw/ssi/pnv_spi_regs.h |&nbsp;&nbsp; 68 ++-<br>
&nbsp;hw/ssi/pnv_spi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 1045 +++++++++++++++++++++++++++++++++<br>
&nbsp;hw/ssi/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 15 +<br>
&nbsp;4 files changed, 1154 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h<br>
index 833042b74b..8815f67d45 100644<br>
--- a/include/hw/ssi/pnv_spi.h<br>
+++ b/include/hw/ssi/pnv_spi.h<br>
@@ -8,6 +8,14 @@<br>
&nbsp; * This model Supports a connection to a single SPI responder.<br>
&nbsp; * Introduced for P10 to provide access to SPI seeproms, TPM, flash d=
evice<br>
&nbsp; * and an ADC controller.<br>
+ *<br>
+ * All SPI function control is mapped into the SPI register space to enabl=
e<br>
+ * full control by firmware.<br>
+ *<br>
+ * SPI Controller has sequencer and shift engine. The SPI shift engine<br>
+ * performs serialization and de-serialization according to the control by=
<br>
+ * the sequencer and according to the setup defined in the configuration<b=
r>
+ * registers and the SPI sequencer implements the main control logic.<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;#ifndef PPC_PNV_SPI_H<br>
@@ -31,6 +39,25 @@ typedef struct PnvSpi {<br>
&nbsp;&nbsp;&nbsp;&nbsp; MemoryRegion&nbsp;&nbsp;&nbsp; xscom_spic_regs;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp; /* SPI object number */<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 spic_num;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 transfer_len;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 responder_select;<br>
+&nbsp;&nbsp;&nbsp; /* To verify if shift_n1 happens prior to shift_n2 */<b=
r>
+&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; shift_n1_done;<br>
+&nbsp;&nbsp;&nbsp; /* Loop counter for branch operation opcode Ex/Fx */<br=
>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 loop_counter_1;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 loop_counter_2;<br>
+&nbsp;&nbsp;&nbsp; /* N1/N2_bits specifies the size of the N1/N2 segment o=
f a frame in bits.*/<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N1_bits;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N2_bits;<br>
+&nbsp;&nbsp;&nbsp; /* Number of bytes in a payload for the N1/N2 frame seg=
ment.*/<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N1_bytes;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N2_bytes;<br>
+&nbsp;&nbsp;&nbsp; /* Number of N1/N2 bytes marked for transmit */<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N1_tx;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N2_tx;<br>
+&nbsp;&nbsp;&nbsp; /* Number of N1/N2 bytes marked for receive */<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N1_rx;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N2_rx;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* SPI registers */<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 regs[PNV_SPI_REGS];<br>
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h<=
br>
index 5b6ff72d02..596e2c1911 100644<br>
--- a/include/hw/ssi/pnv_spi_regs.h<br>
+++ b/include/hw/ssi/pnv_spi_regs.h<br>
@@ -28,6 +28,17 @@<br>
&nbsp;<br>
&nbsp;/* counter_config_reg */<br>
&nbsp;#define SPI_CTR_CFG_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x01<br>
+#define SPI_CTR_CFG_N1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPC_BITMASK(0, 7)<br>
+#define SPI_CTR_CFG_N2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPC_BITMASK(8, 15)<br>
+#define SPI_CTR_CFG_CMP1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT=
MASK(24, 31)<br>
+#define SPI_CTR_CFG_CMP2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT=
MASK(32, 39)<br>
+#define SPI_CTR_CFG_N1_CTRL_B1&nbsp; PPC_BIT(49)<br>
+#define SPI_CTR_CFG_N1_CTRL_B2&nbsp; PPC_BIT(50)<br>
+#define SPI_CTR_CFG_N1_CTRL_B3&nbsp; PPC_BIT(51)<br>
+#define SPI_CTR_CFG_N2_CTRL_B0&nbsp; PPC_BIT(52)<br>
+#define SPI_CTR_CFG_N2_CTRL_B1&nbsp; PPC_BIT(53)<br>
+#define SPI_CTR_CFG_N2_CTRL_B2&nbsp; PPC_BIT(54)<br>
+#define SPI_CTR_CFG_N2_CTRL_B3&nbsp; PPC_BIT(55)<br>
&nbsp;<br>
&nbsp;/* config_reg */<br>
&nbsp;#define CONFIG_REG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x02<br>
@@ -36,9 +47,13 @@<br>
&nbsp;#define SPI_CLK_CFG_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x03<br>
&nbsp;#define SPI_CLK_CFG_HARD_RST&nbsp;&nbsp;&nbsp; 0x0084000000000000;<br=
>
&nbsp;#define SPI_CLK_CFG_RST_CTRL&nbsp;&nbsp;&nbsp; PPC_BITMASK(24, 27)<br=
>
+#define SPI_CLK_CFG_ECC_EN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT(28)<br>
+#define SPI_CLK_CFG_ECC_CTRL&nbsp;&nbsp;&nbsp; PPC_BITMASK(29, 30)<br>
&nbsp;<br>
&nbsp;/* memory_mapping_reg */<br>
&nbsp;#define SPI_MM_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04<br>
+#define SPI_MM_RDR_MATCH_VAL&nbsp;&nbsp;&nbsp; PPC_BITMASK(32, 47)<br>
+#define SPI_MM_RDR_MATCH_MASK&nbsp;&nbsp; PPC_BITMASK(48, 63)<br>
&nbsp;<br>
&nbsp;/* transmit_data_reg */<br>
&nbsp;#define SPI_XMIT_DATA_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x05<br=
>
@@ -60,8 +75,59 @@<br>
&nbsp;#define SPI_STS_SEQ_FSM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPC_BITMASK(8, 15)<br>
&nbsp;#define SPI_STS_SHIFTER_FSM&nbsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(16, 2=
7)<br>
&nbsp;#define SPI_STS_SEQ_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT=
MASK(28, 31)<br>
-#define SPI_STS_GEN_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(32, 6=
3)<br>
+#define SPI_STS_GEN_STATUS_B3&nbsp;&nbsp; PPC_BIT(35)<br>
&nbsp;#define SPI_STS_RDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(1, 3)<br>
&nbsp;#define SPI_STS_TDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(5, 7)<br>
&nbsp;<br>
+/*<br>
+ * Shifter states<br>
+ *<br>
+ * These are the same values defined for the Shifter FSM field of the<br>
+ * status register.&nbsp; It's a 12 bit field so we will represent it as t=
hree<br>
+ * nibbles in the constants.<br>
+ *<br>
+ * These are shifter_fsm values<br>
+ *<br>
+ * Status reg bits 16-27 -&gt; field bits 0-11<br>
+ * bits 0,1,2,5 unused/reserved<br>
+ * bit 4 crc shift in (unused)<br>
+ * bit 8 crc shift out (unused)<br>
+ */<br>
+<br>
+#define FSM_DONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x100&nbsp;&nbsp; /* bit 3 */<br>
+#define FSM_SHIFT_N2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x020&nbsp;&nb=
sp; /* bit 6 */<br>
+#define FSM_WAIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x010&nbsp;&nbsp; /* bit 7 */<br>
+#define FSM_SHIFT_N1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x004&nbsp;&nb=
sp; /* bit 9 */<br>
+#define FSM_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x002&nbsp;&nbsp; /* bit 10 */<br>
+#define FSM_IDLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x001&nbsp;&nbsp; /* bit 11 */<br>
+<br>
+/*<br>
+ * Sequencer states<br>
+ *<br>
+ * These are sequencer_fsm values<br>
+ *<br>
+ * Status reg bits 8-15 -&gt; field bits 0-7<br>
+ * bits 0-3 unused/reserved<br>
+ *<br>
+ */<br>
+#define SEQ_STATE_INDEX_INCREMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08=
&nbsp;&nbsp;&nbsp; /* bit 4 */<br>
+#define SEQ_STATE_EXECUTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04&nbsp;&nbsp;&nbsp; /* bit 5 */<br>
+#define SEQ_STATE_DECODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02&nbsp;&nbsp;&nbsp; /* bit 6 */=
<br>
+#define SEQ_STATE_IDLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01&nbsp;&nbsp;&nbsp; /=
* bit 7 */<br>
+<br>
+/*<br>
+ * These are the supported sequencer operations.<br>
+ * Only the upper nibble is significant because for many operations<br>
+ * the lower nibble is a variable specific to the operation.<br>
+ */<br>
+#define SEQ_OP_STOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<br>
+#define SEQ_OP_SELECT_SLAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define SEQ_OP_SHIFT_N1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30<br>
+#define SEQ_OP_SHIFT_N2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40<br>
+#define SEQ_OP_BRANCH_IFNEQ_RDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x60<br>
+#define SEQ_OP_TRANSFER_TDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0xC0<br>
+#define SEQ_OP_BRANCH_IFNEQ_INC_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xE0=
<br>
+#define SEQ_OP_BRANCH_IFNEQ_INC_2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF0=
<br>
+#define NUM_SEQ_OPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
+<br>
&nbsp;#endif<br>
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c<br>
index de3ffc4e56..f67c2a0ee2 100644<br>
--- a/hw/ssi/pnv_spi.c<br>
+++ b/hw/ssi/pnv_spi.c<br>
@@ -17,6 +17,9 @@<br>
&nbsp;#include &quot;hw/irq.h&quot;<br>
&nbsp;#include &quot;trace.h&quot;<br>
&nbsp;<br>
+#define PNV_SPI_OPCODE_LO_NIBBLE(x) (x &amp; 0x0F)<br>
+#define PNV_SPI_MASKED_OPCODE(x) (x &amp; 0xF0)<br>
+<br>
&nbsp;/*<br>
&nbsp; * Macro from include/hw/ppc/fdt.h<br>
&nbsp; * fdt.h cannot be included here as it contain ppc target specific de=
pendency.<br>
@@ -31,6 +34,1040 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
+/* PnvXferBuffer */<br>
+typedef struct PnvXferBuffer {<br>
+<br>
+&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp; len;<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp; *data;<br>
+<br>
+} PnvXferBuffer;<br>
+<br>
+/* pnv_spi_xfer_buffer_methods */<br>
+static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvXferBuffer *payload =3D g_malloc0(sizeof(*payload));=
<br>
+<br>
+&nbsp;&nbsp;&nbsp; return payload;<br>
+}<br>
+<br>
+static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; free(payload-&gt;data);<br>
+&nbsp;&nbsp;&nbsp; free(payload);<br>
+}<br>
+<br>
+static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t offset, uint32_t length)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; if (payload-&gt;len &lt; (offset + length)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; payload-&gt;len =3D offset + le=
ngth;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; payload-&gt;data =3D g_realloc(=
payload-&gt;data, payload-&gt;len);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return &amp;payload-&gt;data[offset];<br>
+}<br>
+<br>
+static bool does_rdr_match(PnvSpi *s)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * According to spec, the mask bits that are 0 are=
 compared and the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * bits that are 1 are ignored.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; uint16_t rdr_match_mask =3D GETFIELD(SPI_MM_RDR_MATCH_M=
ASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; s-&gt;regs[SPI_MM_REG]);<br>
+&nbsp;&nbsp;&nbsp; uint16_t rdr_match_val =3D GETFIELD(SPI_MM_RDR_MATCH_VA=
L,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; s-&gt;regs[SPI_MM_REG]);<br>
+<br>
+&nbsp;&nbsp;&nbsp; if ((~rdr_match_mask &amp; rdr_match_val) =3D=3D ((~rdr=
_match_mask) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GETFIEL=
D(PPC_BITMASK(48, 63), s-&gt;regs[SPI_RCV_DATA_REG]))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return false;<br>
+}<br>
+<br>
+static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t byte;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Offset is an index between 0 and PNV_SPI_REG_SI=
ZE - 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Check the offset before using it.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (offset &lt; PNV_SPI_REG_SIZE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; byte =3D (s-&gt;regs[SPI_XMIT_D=
ATA_REG] &gt;&gt; (56 - offset * 8)) &amp; 0xFF;<br>
+&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Log an error and return=
 a 0xFF since we have to assign something<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to byte before returnin=
g.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;Invalid offset =3D %d used to get byte &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;from TDR\n&quot;=
, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; byte =3D 0xff;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return byte;<br>
+}<br>
+<br>
+static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_by=
tes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint8_t ecc_count, uint8_t shift_in_count)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t byte;<br>
+&nbsp;&nbsp;&nbsp; int count =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp; while (count &lt; nr_bytes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift_in_count++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ecc_count !=3D 0) &amp;&am=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (shift_=
in_count =3D=3D (PNV_SPI_REG_SIZE + ecc_count))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift_i=
n_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; byte =
=3D read_buf[count];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_shift_rx(byte, count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;r=
egs[SPI_RCV_DATA_REG] =3D (s-&gt;regs[SPI_RCV_DATA_REG] &lt;&lt; 8) | byte;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++;<br>
+&nbsp;&nbsp;&nbsp; } /* end of while */<br>
+&nbsp;&nbsp;&nbsp; return shift_in_count;<br>
+}<br>
+<br>
+static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t ecc_count;<br>
+&nbsp;&nbsp;&nbsp; uint8_t shift_in_count;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Processing here must handle:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * - Which bytes in the payload we should move to =
the RDR<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * - Explicit mode counter configuration settings<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp; * - RDR full and RDR overrun status<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * First check that the response payload is the ex=
act same<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * number of bytes as the request payload was<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (rsp_payload-&gt;len !=3D (s-&gt;N1_bytes + s-&gt;N2=
_bytes)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;Invalid response payload size in &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;bytes, exp=
ected %d, got %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s-&gt;N1_bytes =
+ s-&gt;N2_bytes), rsp_payload-&gt;len);<br>
+&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t ecc_control;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_rx_received(rsp_p=
ayload-&gt;len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_log_Ncounts(s-&gt=
;N1_bits, s-&gt;N1_bytes, s-&gt;N1_tx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_r=
x, s-&gt;N2_bits, s-&gt;N2_bytes, s-&gt;N2_tx, s-&gt;N2_rx);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Adding an ECC count let=
's us know when we have found a payload byte<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that was shifted in but=
 cannot be loaded into RDR.&nbsp; Bits 29-30 of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * clock_config_reset_cont=
rol register equal to either 0b00 or 0b10<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * indicate that we are ta=
king in data with ECC and either applying<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the ECC or discarding i=
t.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_control =3D GETFIELD(SPI_CL=
K_CFG_ECC_CTRL, s-&gt;regs[SPI_CLK_CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ecc_control =3D=3D 0 || ecc=
_control =3D=3D 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_cou=
nt =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use the N1_rx and N2_rx=
 counts to control shifting data from the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * payload into the RDR.&n=
bsp; Keep an overall count of the number of bytes<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * shifted into RDR so we =
can discard every 9th byte when ECC is<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * enabled.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift_in_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Handle the N1 portion of the=
 frame first */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;N1_rx !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_rx_read_N1frame();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift_i=
n_count =3D read_from_frame(s, &amp;rsp_payload-&gt;data[0],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; s-&gt;N1_bytes, ecc_count, shift_in_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Handle the N2 portion of the=
 frame */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;N2_rx !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_rx_read_N2frame();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift_i=
n_count =3D read_from_frame(s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;rsp_payload-&gt;data[s-&gt;N1_bytes], s-&gt;N2_bytes,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ecc_count, shift_in_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;N1_rx + s-&gt;N2_rx)=
 &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Data was received so handle RDR status.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 It is easier to handle RDR_full and RDR_overrun status here<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 since the RDR register's shift_byte_in method is called<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 multiple times in a row. Controlling RDR status is done here<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 instead of in the RDR scoped methods for that reason.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_STS_RDR_FULL, s-&gt;status) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Data was shifted into the RDR before having been r=
ead<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * causing previous data to have been overrun.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_RDR_OVERRUN, s-&gt;statu=
s, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Set status to indicate that the received data regi=
ster is<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * full. This flag is only cleared once the RDR is un=
loaded.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_RDR_FULL, s-&gt;status, =
1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } /* end of else */<br>
+} /* end of spi_response() */<br>
+<br>
+static void transfer(PnvSpi *s, PnvXferBuffer *payload)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint32_t tx;<br>
+&nbsp;&nbsp;&nbsp; uint32_t rx;<br>
+&nbsp;&nbsp;&nbsp; PnvXferBuffer *rsp_payload =3D NULL;<br>
+<br>
+&nbsp;&nbsp;&nbsp; rsp_payload =3D pnv_spi_xfer_buffer_new();<br>
+&nbsp;&nbsp;&nbsp; for (int offset =3D 0; offset &lt; payload-&gt;len; off=
set +=3D s-&gt;transfer_len) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; s-&gt;=
transfer_len; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((of=
fset + i) &gt;=3D payload-&gt;len) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; tx &lt;&lt;=3D 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; tx =3D (tx &lt;&lt; 8) | payload-&gt;data[offset + i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx =3D ssi_transfer(s-&gt;ssi_b=
us, tx);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; s-&gt;=
transfer_len; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((of=
fset + i) &gt;=3D payload-&gt;len) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(pnv_s=
pi_xfer_buffer_write_ptr(rsp_payload, rsp_payload-&gt;len, 1)) =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rx &gt;&gt; (8 * (s-&gt;transfer_=
len - 1) - i * 8)) &amp; 0xFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (rsp_payload !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi_response(s, s-&gt;N1_bits, =
rsp_payload);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static inline uint8_t get_seq_index(PnvSpi *s)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; return GETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status);<br>
+}<br>
+<br>
+static inline void next_sequencer_fsm(PnvSpi *s)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t seq_index =3D get_seq_index(s);<br>
+&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;stat=
us, (seq_index + 1));<br>
+&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status=
, SEQ_STATE_INDEX_INCREMENT);<br>
+}<br>
+<br>
+/*<br>
+ * Calculate the N1 counters based on passed in opcode and<br>
+ * internal register values.<br>
+ * The method assumes that the opcode is a Shift_N1 opcode<br>
+ * and doesn't test it.<br>
+ * The counters returned are:<br>
+ * N1 bits: Number of bits in the payload data that are significant<br>
+ * to the responder.<br>
+ * N1_bytes: Total count of payload bytes for the N1 (portion of the) fram=
e.<br>
+ * N1_tx: Total number of bytes taken from TDR for N1<br>
+ * N1_rx: Total number of bytes taken from the payload for N1<br>
+ */<br>
+static void calculate_N1(PnvSpi *s, uint8_t opcode)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Shift_N1 opcode form: 0x3M<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Implicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If M !=3D 0 the shift count is M bytes and M is=
 the number of tx bytes.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Forced Implicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * M is the shift count but tx and rx is determine=
d by the count control<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * register fields.&nbsp; Note that we only check =
for forced Implicit mode when<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * M !=3D 0 since the mode doesn't make sense when=
 M =3D 0.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Explicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If M =3D=3D 0 then shift count is number of bit=
s defined in the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Counter Configuration Register's shift_count_N1=
 field.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Explicit mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bits =3D GETFIELD(SPI_=
CTR_CFG_N1, s-&gt;regs[SPI_CTR_CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes =3D (s-&gt;N1_bi=
ts + 7) / 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If tx count control for N1 i=
s set, load the tx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N1_CTR=
L_B2, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
1_tx =3D s-&gt;N1_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If rx count control for N1 i=
s set, load the rx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N1_CTR=
L_B3, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
1_rx =3D s-&gt;N1_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Implicit mode/Forced Implici=
t mode, use M field from opcode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes =3D PNV_SPI_OPCO=
DE_LO_NIBBLE(opcode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bits =3D s-&gt;N1_byte=
s * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Assume that we are goin=
g to transmit the count<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pure Implicit only)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_tx =3D s-&gt;N1_bytes;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Let Forced Implicit mode hav=
e an effect on the counts */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N1_CTR=
L_B1, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 If Forced Implicit mode and count control doesn't<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 indicate transmit then reset the tx count to 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_CTR_CFG_N1_CTRL_B2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SP=
I_CTR_CFG_REG]) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;N1_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If r=
x count control for N1 is set, load the rx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_CTR_CFG_N1_CTRL_B3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SP=
I_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;N1_rx =3D s-&gt;N1_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Enforce an upper limit on the size of N1 that i=
s equal to the known size<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * of the shift register, 64 bits or 72 bits if EC=
C is enabled.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If the size exceeds 72 bits it is a user error =
so log an error,<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * cap the size at a max of 64 bits or 72 bits and=
 set the sequencer FSM<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * error bit.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SPI_CLK_=
CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp; if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;N1_bytes &gt; (PNV_SP=
I_REG_SIZE + 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_lo=
g_mask(LOG_GUEST_ERROR, &quot;Unsupported N1 shift size when &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &quot;ECC enabled, bytes =3D 0x%x, bits =3D 0x%x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s-&gt;N1_bytes, s-&gt;N1_bits);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
1_bytes =3D PNV_SPI_REG_SIZE + 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
1_bits =3D s-&gt;N1_bytes * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } else if (s-&gt;N1_bytes &gt; PNV_SPI_REG_SIZE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;Unsupported N1 shift size, &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;bytes =3D 0x%x, =
bits =3D 0x%x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes, s-&gt;=
N1_bits);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes =3D PNV_SPI_REG_=
SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bits =3D s-&gt;N1_byte=
s * 8;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+} /* end of calculate_N1 */<br>
+<br>
+/*<br>
+ * Shift_N1 operation handler method<br>
+ */<br>
+static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PnvXferBuffer **=
payload, bool send_n1_alone)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t n1_count;<br>
+&nbsp;&nbsp;&nbsp; bool stop =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If there isn't a current payload left over from=
 a stopped sequence<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * create a new one.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (*payload =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *payload =3D pnv_spi_xfer_buffe=
r_new();<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Use a combination of N1 counters to build the N=
1 portion of the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * transmit payload.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * We only care about transmit at this time since =
the request payload<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * only represents data going out on the controlle=
r output line.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Leave mode specific considerations in the calcu=
late function since<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * all we really care about are counters that tell=
 use exactly how<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * many bytes are in the payload and how many of t=
hose bytes to<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * include from the TDR into the payload.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; calculate_N1(s, opcode);<br>
+&nbsp;&nbsp;&nbsp; trace_pnv_spi_log_Ncounts(s-&gt;N1_bits, s-&gt;N1_bytes=
, s-&gt;N1_tx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_rx, s-&gt;N2_bits, s-&gt;=
N2_bytes, s-&gt;N2_tx, s-&gt;N2_rx);<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Zero out the N2 counters here in case there is =
no N2 operation following<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the N1 operation in the sequencer.&nbsp; This k=
eeps leftover N2 information<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * from interfering with spi_response logic.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * N1_bytes is the overall size of the N1 portion =
of the frame regardless of<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * whether N1 is used for tx, rx or both.&nbsp; Lo=
op over the size to build a<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * payload that is N1_bytes long.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * N1_tx is the count of bytes to take from the TD=
R and &quot;shift&quot; into the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * frame which means append those bytes to the pay=
load for the N1 portion<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * of the frame.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If N1_tx is 0 or if the count exceeds the size =
of the TDR append 0xFF to<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the frame until the overall N1 count is reached=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; n1_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp; while (n1_count &lt; s-&gt;N1_bytes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Assuming that if N1_tx =
is not equal to 0 then it is the same as<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * N1_bytes.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;N1_tx !=3D 0) &amp;&=
amp; (n1_count &lt; PNV_SPI_REG_SIZE)) {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_STS_TDR_FULL, s-&gt;status) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Note that we are only appending to the payload IF =
the TDR<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * is full otherwise we don't touch the payload becau=
se we are<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * going to NOT send the payload and instead tell the=
 sequencer<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * that called us to stop and wait for a TDR write so=
 we have<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * data to load into the payload.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint8_t n1_byte =3D 0x00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; n1_byte =3D get_from_offset(s, n1_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_tx_append(&quot;n1_byte&quot;, n1_byte, n1_c=
ount);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;l=
en, 1)) =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n1_byte;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * We hit a shift_n1 opcode TX but the TDR is empty, =
tell the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * sequencer to stop and break this loop.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;Shift N1&quot=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;set for transmit but TDR is emp=
ty&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Cases here:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - we are receiving during the N1 frame segment and the RDR<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
&nbsp;&nbsp; is full so we need to stop until the RDR is read<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - we are transmitting and we don't care about RDR status<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
&nbsp;&nbsp; since we won't be loading RDR during the frame segment.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - we are receiving and the RDR is empty so we allow the operation<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
&nbsp;&nbsp; to proceed.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-=
&gt;N1_rx !=3D 0) &amp;&amp; (GETFIELD(SPI_STS_RDR_FULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status) =3D=3D 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;shift N1&quot=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;set for receive but RDR is full=
&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_tx_append_FF(&quot;n1_byte&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;l=
en, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xff;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n1_count++;<br>
+&nbsp;&nbsp;&nbsp; } /* end of while */<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If we are not stopping due to an empty TDR and =
we are doing an N1 TX<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * and the TDR is full we need to clear the TDR_fu=
ll status.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Do this here instead of up in the loop above so=
 we don't log the message<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * in every loop iteration.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the send_n1_alone flag, all that does is=
 defer the TX until the N2<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * operation, which was found immediately after th=
e current opcode.&nbsp; The TDR<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * was unloaded and will be shifted so we have to =
clear the TDR_full status.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (!stop &amp;&amp; (s-&gt;N1_tx !=3D 0) &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (GETFIELD(SPI_STS_TDR_FULL, s-&=
gt;status) =3D=3D 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_TDR_FULL, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * There are other reasons why the shifter would s=
top, such as a TDR empty<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * or RDR full condition with N1 set to receive.&n=
bsp; If we haven't stopped due<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * to either one of those conditions then check if=
 the send_n1_alone flag is<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * equal to False, indicating the next opcode is a=
n N2 operation, AND if<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the N2 counter reload switch (bit 0 of the N2 c=
ount control field) is<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * set.&nbsp; This condition requires a pacing wri=
te to &quot;kick&quot; off the N2<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * shift which includes the N1 shift as well when =
send_n1_alone is False.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (!stop &amp;&amp; !send_n1_alone &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (GETFIELD(SPI_CTR_CFG_N2_CTRL_B0, s-&=
gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_re=
quested(&quot;N2 counter reload &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;acti=
ve, stop N1 shift, TDR_underrun set to 1&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_TDR_UNDERRUN, s-&gt;status, 1);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If send_n1_alone is set AND we have a full TDR =
then this is the first and<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * last payload to send and we don't have an N2 fr=
ame segment to add to the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * payload.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (send_n1_alone &amp;&amp; !stop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We have a TX and a full TDR =
or an RX and an empty RDR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_tx_request(&quot;=
Shifting N1 frame&quot;, (*payload)-&gt;len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; transfer(s, *payload);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The N1 frame shift is comple=
te so reset the N1 counters */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pnv_spi_xfer_buffer_free(*paylo=
ad);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *payload =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return stop;<br>
+} /* end of operation_shiftn1() */<br>
+<br>
+/*<br>
+ * Calculate the N2 counters based on passed in opcode and<br>
+ * internal register values.<br>
+ * The method assumes that the opcode is a Shift_N2 opcode<br>
+ * and doesn't test it.<br>
+ * The counters returned are:<br>
+ * N2 bits: Number of bits in the payload data that are significant<br>
+ * to the responder.<br>
+ * N2_bytes: Total count of payload bytes for the N2 frame.<br>
+ * N2_tx: Total number of bytes taken from TDR for N2<br>
+ * N2_rx: Total number of bytes taken from the payload for N2<br>
+ */<br>
+static void calculate_N2(PnvSpi *s, uint8_t opcode)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Shift_N2 opcode form: 0x4M<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Implicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If M!=3D0 the shift count is M bytes and M is t=
he number of rx bytes.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Forced Implicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * M is the shift count but tx and rx is determine=
d by the count control<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * register fields.&nbsp; Note that we only check =
for Forced Implicit mode when<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * M !=3D 0 since the mode doesn't make sense when=
 M =3D 0.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Explicit mode:<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If M=3D=3D0 then shift count is number of bits =
defined in the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Counter Configuration Register's shift_count_N1=
 field.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Explicit mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D GETFIELD(SPI_=
CTR_CFG_N2, s-&gt;regs[SPI_CTR_CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D (s-&gt;N2_bi=
ts + 7) / 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If tx count control for N2 i=
s set, load the tx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N2_CTR=
L_B2, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
2_tx =3D s-&gt;N2_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If rx count control for N2 i=
s set, load the rx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N2_CTR=
L_B3, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
2_rx =3D s-&gt;N2_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Implicit mode/Forced Implici=
t mode, use M field from opcode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D PNV_SPI_OPCO=
DE_LO_NIBBLE(opcode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D s-&gt;N2_byte=
s * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Assume that we are going to =
receive the count */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D s-&gt;N2_bytes;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Let Forced Implicit mode hav=
e an effect on the counts */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_CTR_CFG_N2_CTR=
L_B1, s-&gt;regs[SPI_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 If Forced Implicit mode and count control doesn't<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 indicate a receive then reset the rx count to 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_CTR_CFG_N2_CTRL_B3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SP=
I_CTR_CFG_REG]) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If t=
x count control for N2 is set, load the tx value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_CTR_CFG_N2_CTRL_B2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SP=
I_CTR_CFG_REG]) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;N2_tx =3D s-&gt;N2_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Enforce an upper limit on the size of N1 that i=
s equal to the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * known size of the shift register, 64 bits or 72=
 bits if ECC<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * is enabled.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If the size exceeds 72 bits it is a user error =
so log an error,<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * cap the size at a max of 64 bits or 72 bits and=
 set the sequencer FSM<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * error bit.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; uint8_t ecc_control =3D GETFIELD(SPI_CLK_CFG_ECC_CTRL,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SPI_CLK_CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp; if (ecc_control =3D=3D 0 || ecc_control =3D=3D 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;N2_bytes &gt; (PNV_SP=
I_REG_SIZE + 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unsu=
pported N2 shift size when ECC enabled */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
2_bytes =3D PNV_SPI_REG_SIZE + 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N=
2_bits =3D s-&gt;N2_bytes * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } else if (s-&gt;N2_bytes &gt; PNV_SPI_REG_SIZE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unsupported N2 shift size */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D PNV_SPI_REG_=
SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D s-&gt;N2_byte=
s * 8;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+} /* end of calculate_N2 */<br>
+<br>
+/*<br>
+ * Shift_N2 operation handler method<br>
+ */<br>
+<br>
+static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PnvXferBuffer **=
payload)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint8_t n2_count;<br>
+&nbsp;&nbsp;&nbsp; bool stop =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If there isn't a current payload left over from=
 a stopped sequence<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * create a new one.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (*payload =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *payload =3D pnv_spi_xfer_buffe=
r_new();<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Use a combination of N2 counters to build the N=
2 portion of the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * transmit payload.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; calculate_N2(s, opcode);<br>
+&nbsp;&nbsp;&nbsp; trace_pnv_spi_log_Ncounts(s-&gt;N1_bits, s-&gt;N1_bytes=
, s-&gt;N1_tx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_rx, s-&gt;N2_bits, s-&gt;=
N2_bytes, s-&gt;N2_tx, s-&gt;N2_rx);<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * The only difference between this code and the c=
ode for shift N1 is<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * that this code has to account for the possible =
presence of N1 transmit<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * bytes already taken from the TDR.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If there are bytes to be transmitted for the N2=
 portion of the frame<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * and there are still bytes in TDR that have not =
been copied into the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * TX data of the payload, this code will handle t=
ransmitting those<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * remaining bytes.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If for some reason the transmit count(s) add up=
 to more than the size<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * of the TDR we will just append 0xFF to the tran=
smit payload data until<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the payload is N1 + N2 bytes long.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; n2_count =3D 0;<br>
+&nbsp;&nbsp;&nbsp; while (n2_count &lt; s-&gt;N2_bytes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If the RDR is full and =
we need to RX just bail out, letting the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * code continue will end =
up building the payload twice in the same<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * buffer since RDR full c=
auses a sequence stop and restart.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;N2_rx !=3D 0) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (GETFIE=
LD(SPI_STS_RDR_FULL, s-&gt;status) =3D=3D 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_stop_requested(&quot;shift N2 set&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;for receive but RDR is full&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stop =
=3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;N2_tx !=3D 0) &amp;&=
amp; ((s-&gt;N1_tx + n2_count) &lt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PNV_SPI_REG_SIZE)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Alwa=
ys append data for the N2 segment if it is set for TX */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t=
 n2_byte =3D 0x00;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n2_byte=
 =3D get_from_offset(s, (s-&gt;N1_tx + n2_count));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_tx_append(&quot;n2_byte&quot;, n2_byte, (s-&gt;N1_tx + n2_count));<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(pnv_s=
pi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D n2_byte;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Regardless of whether or not N2 is set for TX or RX, we need<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 the number of bytes in the payload to match the overall length<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 of the operation.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_tx_append_FF(&quot;n2_byte&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(pnv_s=
pi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n2_count++;<br>
+&nbsp;&nbsp;&nbsp; } /* end of while */<br>
+&nbsp;&nbsp;&nbsp; if (!stop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We have a TX and a full TDR =
or an RX and an empty RDR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_tx_request(&quot;=
Shifting N2 frame&quot;, (*payload)-&gt;len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; transfer(s, *payload);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If we are doing an N2 T=
X and the TDR is full we need to clear the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TDR_full status. Do thi=
s here instead of up in the loop above so we<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * don't log the message i=
n every loop iteration.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;N2_tx !=3D 0) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (GETFIE=
LD(SPI_STS_TDR_FULL, s-&gt;status) =3D=3D 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_TDR_FULL, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The N2 frame shift is c=
omplete so reset the N2 counters.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reset the N1 counters a=
lso in case the frame was a combination of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * N1 and N2 segments.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;N1_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pnv_spi_xfer_buffer_free(*paylo=
ad);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *payload =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return stop;<br>
+} /*&nbsp; end of operation_shiftn2()*/<br>
+<br>
+static void operation_sequencer(PnvSpi *s)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Loop through each sequencer operation ID and pe=
rform the requested<br>
+&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; operations.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Flag for indicating if we should send the N1 fr=
ame or wait to combine<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * it with a preceding N2 frame.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; bool send_n1_alone =3D true;<br>
+&nbsp;&nbsp;&nbsp; bool stop =3D false; /* Flag to stop the sequencer */<b=
r>
+&nbsp;&nbsp;&nbsp; uint8_t opcode =3D 0;<br>
+&nbsp;&nbsp;&nbsp; uint8_t masked_opcode =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * PnvXferBuffer for containing the payload of the=
 SPI frame.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * This is a static because there are cases where =
a sequence has to stop<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * and wait for the target application to unload t=
he RDR.&nbsp; If this occurs<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * during a sequence where N1 is not sent alone an=
d instead combined with<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * N2 since the N1 tx length + the N2 tx length is=
 less than the size of<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the TDR.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; static PnvXferBuffer *payload;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (payload =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; payload =3D pnv_spi_xfer_buffer=
_new();<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * Clear the sequencer FSM error bit - general_SPI=
_status[3]<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * before starting a sequence.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s-&gt;=
status, 0);<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * If the FSM is idle set the sequencer index to 0=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * (new/restarted sequence)<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_STS_SEQ_FSM, s-&gt;status) =3D=3D SEQ_=
STATE_IDLE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_SEQ_INDEX, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * There are only 8 possible operation IDs to iter=
ate through though<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * some operations may cause more than one frame t=
o be sequenced.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; while (get_seq_index(s) &lt; NUM_SEQ_OPS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opcode =3D s-&gt;seq_op[get_seq=
_index(s)];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set sequencer state to decod=
e */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_SEQ_FSM, s-&gt;status, SEQ_STATE_DECODE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Only the upper nibble o=
f the operation ID is needed to know what<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * kind of operation is re=
quested.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; masked_opcode =3D PNV_SPI_MASKE=
D_OPCODE(opcode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (masked_opcode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Increment the operation=
 index in each case instead of just<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * once at the end in case=
 an operation like the branch<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * operation needs to chan=
ge the index.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_STOP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A st=
op operation in any position stops the sequencer */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;STOP&quot;, get_seq_index(s));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stop =
=3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_IDLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;l=
oop_counter_1 =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;l=
oop_counter_2 =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_IDLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_SELECT_SLAVE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;SELECT_SLAVE&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 This device currently only supports a single responder<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 connection at position 0.&nbsp; De-selecting a responder is fine<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 and expected at the end of a sequence but selecting any<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 responder other than 0 should cause an error.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;r=
esponder_select =3D PNV_SPI_OPCODE_LO_NIBBLE(opcode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&=
gt;responder_select =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_shifter_done();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; qemu_set_irq(s-&gt;cs_line[0], 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (get_seq_index(s) + 1));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s, FSM_DONE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
if (s-&gt;responder_select !=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;Slave selection other=
 than 1 &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &quot;not supported, select =3D 0x%x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;responder_select);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;invalid &quot=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;responder select&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s, FSM_IDLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Only allow an FSM_START state when a responder is<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * selected<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s, FSM_START);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_shifter_stating();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; qemu_set_irq(s-&gt;cs_line[0], 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * A Shift_N2 operation is only valid after a Shift_N=
1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * according to the spec. The spec doesn't say if tha=
t means<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * immediately after or just after at any point. We w=
ill track<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * the occurrence of a Shift_N1 to enforce this requi=
rement in<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * the most generic way possible by assuming that the=
 rule<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * applies once a valid responder select has occurred=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;shift_n1_done =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_SHIFT_N1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;SHIFT_N1&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Only allow a shift_n1 when the state is not IDLE or DONE.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 In either of those two cases the sequencer is not in a proper<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 state to perform shift operations because the sequencer has:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - processed a responder deselect (DONE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - processed a stop opcode (IDLE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 - encountered an error (IDLE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((GE=
TFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status) =3D=3D FSM_IDLE) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (GETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status) =3D=3D FSM_DO=
NE)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;Shift_N1 not allowed =
in &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &quot;shifter state =3D 0x%llx&quot;, GETFIELD(<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SPI_STS_SH=
IFTER_FSM, s-&gt;status));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Set sequencer FSM error bit 3 (general_SPI_status[=
3])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * in status reg.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s-&gt;sta=
tus, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;invalid shift=
er state&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Look for the special case where there is a shift_n=
1 set for<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * transmit and it is followed by a shift_n2 set for =
transmit<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * AND the combined transmit length of the two operat=
ions is<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * less than or equal to the size of the TDR register=
. In this<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * case we want to use both this current shift_n1 opc=
ode and the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * following shift_n2 opcode to assemble the frame fo=
r<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * transmission to the responder without requiring a =
refill of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * the TDR between the two operations.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (PNV_SPI_MASKED_OPCODE(s-&gt;seq_op[get_seq_index(s) + =
1])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D SEQ_OP_SHIFT_N2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_n1_alone =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FSM_SHIFT_N1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D operation_shiftn1(s, opcode, &amp;payload, send_n=
1_alone);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (stop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; The operation code s=
ays to stop, this can occur if:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (1) RDR is full and the N1=
 shift is set for receive<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (2) TDR was empty at the t=
ime of the N1 shift so we need<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to wait for data.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (3) Neither 1 nor 2 are oc=
curring and we aren't sending<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * N1 alone and N2 counter re=
load is set (bit 0 of the N2<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * counter reload field).&nbs=
p; In this case TDR_underrun will<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will be set and the Payloa=
d has been loaded so it is<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ok to advance the sequence=
r.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_STS_TDR_UNDERRUN,=
 s-&gt;status)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;shif=
t_n1_done =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;stat=
us =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FSM_=
SHIFT_N2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;stat=
us =3D SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (get_seq_index(s) + 1));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Th=
is is case (1) or (2) so the sequencer needs to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * wa=
it and NOT go to the next sequence yet.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;stat=
us =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FSM_WAIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ok to move on to the next index=
 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;shift_n1_done =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_SHIFT_N2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;SHIFT_N2&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s-=
&gt;shift_n1_done) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;Shift_N2 is not allow=
ed if a &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Shift_N1 is not done, shifter state =3D 0x%=
llx&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; GETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * In case the sequencer actually stops if an N2 shif=
t is<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * requested before any N1 shift is done. Set sequenc=
er FSM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * error bit 3 (general_SPI_status[3]) in status reg.=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s-&gt;sta=
tus, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;shift_n2 &quo=
t;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;w/no sh=
ift_n1 done&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* Ok to do a Shift_N2 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FSM_SHIFT_N2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D operation_shiftn2(s, opcode, &amp;payload);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * If the operation code says to stop set the shifter=
 state to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * wait and stop<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (stop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_=
SHIFTER_FSM, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FSM_WAIT);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ok to move on to the next index=
 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_BRANCH_IFNEQ_RDR:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;BRANCH_IFNEQ_RDR&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 The memory mapping register RDR match value is compared against<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 the 16 rightmost bytes of the RDR (potentially with masking).<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Since this comparison is performed against the contents of the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 RDR then a receive must have previously occurred otherwise<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 there is no data to compare and the operation cannot be<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 completed and will stop the sequencer until RDR full is set to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 1.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GET=
FIELD(SPI_STS_RDR_FULL, s-&gt;status) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool rdr_matched =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; rdr_matched =3D does_rdr_match(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (rdr_matched) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_RDR_match(&quot;succ=
ess&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A match occurred, increment the=
 sequencer index. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_RDR_match(&quot;fail=
ed&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Branch the sequencer to th=
e index coded into the op<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * code.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_=
SEQ_INDEX, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PNV_SPI_OPCOD=
E_LO_NIBBLE(opcode));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Regardless of where the branch ended up we want th=
e<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * sequencer to continue shifting so we have to clear=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * RDR_full.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_RDR_FULL, s-&gt;status, =
0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; trace_pnv_spi_sequencer_stop_requested(&quot;RDR not&quot;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;full for 0x6x opcode&quot;);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; stop =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;statu=
s, FSM_WAIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_TRANSFER_TDR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_lo=
g_mask(LOG_GUEST_ERROR, &quot;Transfer TDR is not supported\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_se=
quencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_BRANCH_IFNEQ_INC_1:=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;BRANCH_IFNEQ_INC_1&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 The spec says the loop should execute count compare + 1 times.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 However we learned from engineering that we really only loop<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 count_compare times, count compare =3D 0 makes this op code a<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 no-op<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&=
gt;loop_counter_1 !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; GETFIELD(SPI_CTR_CFG_CMP1, s-&gt;regs[SPI_CTR_CFG_REG])) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Next index is the lower nibble of the branch opera=
tion ID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * mask off all but the first three bits so we don't =
try to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * access beyond the sequencer_operation_reg boundary=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PNV_SPI_OPCODE_LO_NIBBLE(opcode));<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;loop_counter_1++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* Continue to next index if loop counter is reached */<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SEQ_OP_BRANCH_IFNEQ_INC_2:=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_sequencer_op(&quot;BRANCH_IFNEQ_INC_2&quot;, get_seq_index(s));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t=
 condition2 =3D GETFIELD(SPI_CTR_CFG_CMP2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[SPI_CTR_CFG_REG]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 The spec says the loop should execute count compare + 1 times.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 However we learned from engineering that we really only loop<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 count_compare times, count compare =3D 0 makes this op code a<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 no-op<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&=
gt;loop_counter_2 !=3D condition2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Next index is the lower nibble of the branch opera=
tion ID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * mask off all but the first three bits so we don't =
try to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * access beyond the sequencer_operation_reg boundary=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_STS_SEQ_INDEX,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status, PNV_SPI_OPCODE_LO_NIBBL=
E(opcode));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; s-&gt;loop_counter_2++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* Continue to next index if loop counter is reached */<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; next_sequencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Igno=
re unsupported operations. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_se=
quencer_fsm(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } /* end of switch */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If we used all 8 opcode=
s without seeing a 00 - STOP in the sequence<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we need to go ahead and=
 end things as if there was a STOP at the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * end.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_seq_index(s) =3D=3D NUM=
_SEQ_OPS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* All =
8 opcodes completed, sequencer idling */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_IDLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;l=
oop_counter_1 =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;l=
oop_counter_2 =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
tatus =3D SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_IDLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Break the loop if a stop was=
 requested */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (stop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; } /* end of while */<br>
+&nbsp;&nbsp;&nbsp; return;<br>
+} /* end of operation_sequencer() */<br>
+<br>
+/*<br>
+ * The SPIC engine and its internal sequencer can be interrupted and reset=
 by<br>
+ * a hardware signal, the sbe_spicst_hard_reset bits from Pervasive<br>
+ * Miscellaneous Register of sbe_register_bo device.<br>
+ * Reset immediately aborts any SPI transaction in progress and returns th=
e<br>
+ * sequencer and state machines to idle state.<br>
+ * The configuration register values are not changed. The status register =
is<br>
+ * not reset. The engine registers are not reset.<br>
+ * The SPIC engine reset does not have any affect on the attached devices.=
<br>
+ * Reset handling of any attached devices is beyond the scope of the engin=
e.<br>
+ */<br>
+static void do_reset(DeviceState *dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(dev);<br>
+<br>
+&nbsp;&nbsp;&nbsp; trace_pnv_spi_reset();<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Reset all N1 and N2 counters, and other constants */=
<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N2_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N1_bits =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N1_bytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N1_tx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;N1_rx =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;loop_counter_1 =3D 0;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;loop_counter_2 =3D 0;<br>
+&nbsp;&nbsp;&nbsp; /* Disconnected from responder */<br>
+&nbsp;&nbsp;&nbsp; qemu_set_irq(s-&gt;cs_line[0], 1);<br>
+}<br>
+<br>
&nbsp;static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigne=
d size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(opaque);<br>
@@ -50,6 +1087,10 @@ static uint64_t pnv_spi_xscom_read(void *opaque, hwadd=
r addr, unsigned size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D s-&gt;regs[reg];<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_read_RDR(val=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(=
SPI_STS_RDR_FULL, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (GETFIELD(SPI_STS_SHIFTER_FS=
M, s-&gt;status) =3D=3D FSM_WAIT) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_p=
nv_spi_start_sequencer();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operati=
on_sequencer(s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp; case SPI_SEQ_OP_REG:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D 0;<br>
@@ -111,6 +1152,8 @@ static void pnv_spi_xscom_write(void *opaque, hwaddr a=
ddr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_write_TDR(va=
l);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(=
SPI_STS_TDR_FULL, s-&gt;status, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(=
SPI_STS_TDR_UNDERRUN, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_start_sequencer()=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_sequencer(s);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp; case SPI_SEQ_OP_REG:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; P=
NV_SPI_REG_SIZE; i++) {<br>
@@ -143,6 +1186,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops =3D {<b=
r>
&nbsp;<br>
&nbsp;static Property pnv_spi_properties[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT32(&quot;spic_num&quot;, PnvSpi, s=
pic_num, 0),<br>
+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;transfer_len&quot;, PnvSpi, tra=
nsfer_len, 4),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_END_OF_LIST(),<br>
&nbsp;};<br>
&nbsp;<br>
@@ -192,6 +1236,7 @@ static void pnv_spi_class_init(ObjectClass *klass, voi=
d *data)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;desc =3D &quot;PowerNV SPI&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;realize =3D pnv_spi_realize;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D do_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp; device_class_set_props(dc, pnv_spi_properties);<br=
>
&nbsp;}<br>
&nbsp;<br>
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events<br>
index 4388024a05..7fa27ebade 100644<br>
--- a/hw/ssi/trace-events<br>
+++ b/hw/ssi/trace-events<br>
@@ -38,3 +38,18 @@ pnv_spi_read(uint64_t addr, uint64_t val) &quot;addr 0x%=
&quot; PRIx64 &quot; val 0x%&quot; PRIx64<br>
&nbsp;pnv_spi_write(uint64_t addr, uint64_t val) &quot;addr 0x%&quot; PRIx6=
4 &quot; val 0x%&quot; PRIx64<br>
&nbsp;pnv_spi_read_RDR(uint64_t val) &quot;data extracted =3D 0x%&quot; PRI=
x64<br>
&nbsp;pnv_spi_write_TDR(uint64_t val) &quot;being written, data written =3D=
 0x%&quot; PRIx64<br>
+pnv_spi_start_sequencer(void) &quot;&quot;<br>
+pnv_spi_reset(void) &quot;spic engine sequencer configuration and spi comm=
unication&quot;<br>
+pnv_spi_sequencer_op(const char* op, uint8_t index) &quot;%s at index =3D =
0x%x&quot;<br>
+pnv_spi_shifter_stating(void) &quot;pull CS line low&quot;<br>
+pnv_spi_shifter_done(void) &quot;pull the CS line high&quot;<br>
+pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t N1_tx, uint=
8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t N2_tx, uint8_t N2_rx)=
 &quot;N1_bits =3D %d, N1_bytes =3D %d, N1_tx =3D %d, N1_rx =3D %d, N2_bits=
 =3D %d, N2_bytes =3D %d, N2_tx =3D %d, N2_rx =3D %d&quot;<br>
+pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t tdr_index) &quo=
t;%s =3D 0x%2.2x to payload from TDR at index %d&quot;<br>
+pnv_spi_tx_append_FF(const char* frame) &quot;%s to Payload&quot;<br>
+pnv_spi_tx_request(const char* frame, uint32_t payload_len) &quot;%s, payl=
oad len =3D %d&quot;<br>
+pnv_spi_rx_received(uint32_t payload_len) &quot;payload len =3D %d&quot;<b=
r>
+pnv_spi_rx_read_N1frame(void) &quot;&quot;<br>
+pnv_spi_rx_read_N2frame(void) &quot;&quot;<br>
+pnv_spi_shift_rx(uint8_t byte, uint32_t index) &quot;byte =3D 0x%2.2x into=
 RDR from payload index %d&quot;<br>
+pnv_spi_sequencer_stop_requested(const char* reason) &quot;due to %s&quot;=
<br>
+pnv_spi_RDR_match(const char* result) &quot;%s&quot;<br>
--<br>
2.39.3<br>
<br>
</div>
</body>
</html>

--_000_PH0PR15MB4720ABAD9CCAAB55ED64CA47E1D72PH0PR15MB4720namp_--

