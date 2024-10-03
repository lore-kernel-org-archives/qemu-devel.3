Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D99CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLSL-0003C9-HU; Thu, 03 Oct 2024 09:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swLSH-0003BZ-6g
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:01:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swLSE-0005ff-Vk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:01:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935pLJk002242;
 Thu, 3 Oct 2024 06:01:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=+XRjHzJadoJGJVu
 KKIaZeSUtAE3F6YmFJPMaNrk81CU=; b=FLgOi+gDdqUF052+PwitU0MEHHlclXf
 hKCLCUQDemT8EwjzqYCn82y1G/n7vAB3joLJDatFjAlDLghf8ue6Xt+mEJi6ay0d
 6ukO/PVFxv1NOf+TK093YiBipyz7Ih9368+7yXZF6r6+Z8BVDgx+iMTzDwgC4Pvl
 bqqYrfCyHXA8iTyZoYxy1A0Gc+CtN+8FghoZEeBeSVoqYIUOKk0mE9EnDK5w+zK9
 11o/i6kmtbYdZrrJRbE4jZuVuziyhzIhJLMY6DXte0ySUThDr/UZhDODBrVy4l/G
 JaT0UORgV+xH81aX0CromYLGiuYZbgBFvhsDrUb59xXSXSx3z5Dxsxg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4214cpk29h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2024 06:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPg/1yRWdh7oKemqCD9HecpNClbnK0Q5rMANUFuGQhS5EDqegbVNxbOxPkXa+80a5F4PnxUGJ3R2bR4apmJ5IH2YnCj7pvO4LuecEGRb9NhIPmVHXQL0laeFSZzW0zQQ1YHifT/9HIyGPR1RgUUHWWS8FeSP9rTpr18EqxTh/xsyMQ42N465DoW93eLqp3SoqnefjAyluzHs9eqda2W0DmmGZFbjjsP0oTCLc5a26CPWrf5jrHswZ7iSy1ciRi03r73Q7uKxxTGp50I7EoTJ9GXkx+6lV8OWiVJ9TmC/VSvdwdV8SXJz5Y4ICGEILJopiBZirzVFgyA3zgr/QJ2y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XRjHzJadoJGJVuKKIaZeSUtAE3F6YmFJPMaNrk81CU=;
 b=Z/3WxoqLvJyh0gO7hMrQNYJ6827gc531ajSZNXdkZ8cGdC5NwNUZqPn0l/F0lOXDnfsJQS3VQud2OhGoLWvZOKIfZugpq/qesfr3/iDMeNPMghWc4q0CcJ/fliWlh8I6lfO7mhUigGrpPEdJHRADCXDrbqhwqwzUL1WkMlsO0vyNMN1IKmdNk0lMQwa1vVKIv3TNPxohubjOprhJp4qYWdKwoZXu7tnma4oONmIPGUVsep2tkzpDbssUztjI67zCq00Q3ZpsJoBRcywBrddnFn6TnsmRzkc4akgfdTVn34NCsTjJhsKcNVmWi22eHvQmhQiBmCurWO68bki9WviO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XRjHzJadoJGJVuKKIaZeSUtAE3F6YmFJPMaNrk81CU=;
 b=BW8iIMMz8mwx5rd3c449yfDhx/1vDSIAgA28WIOjOyKuuQfnxJ9ezaeA42z//9OcUQ2CpvDuX4Q0H3/OKBTmAd+2KCFBLWRMf0oO1h6nES87tT7EIU/2r9z0ctyv4hJHhvxu9yynKuh1u3J8HG86azU8WO+rEIDOLNmIfZK9cGN499cUWa43b1Z/SBolya9cZ/NgZQa3VfBzbAzs8PY18U1+p+ZFRnoUDp+ec7fOcb5N36ko/IAnrhjRk6t4qYnA/ryGiw1L12v2oy7wP9kGZN8l5hmWFc1SsGnziEgvZl0sO6OtSEWl0oMMdMBnvxRQAXMiAiitj0IypLjG/H0fqQ==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 CH3PR02MB10246.namprd02.prod.outlook.com (2603:10b6:610:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 13:01:05 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:01:04 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, "freddy77@gmail.com"
 <freddy77@gmail.com>
Subject: Re: Corrupt VNC display for 1366x768
Thread-Topic: Corrupt VNC display for 1366x768
Thread-Index: AQHbFLkdixseYmY/b0qksh89icazUbJzXCMAgAAOaueAAZMVfg==
Date: Thu, 3 Oct 2024 13:01:04 +0000
Message-ID: <DM8PR02MB81211F01833922F781C21E5893712@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <Zv02EDIKgmq2L0fg@redhat.com>
 <DM8PR02MB81211BB23F192988ECCF4BE193702@DM8PR02MB8121.namprd02.prod.outlook.com>
In-Reply-To: <DM8PR02MB81211BB23F192988ECCF4BE193702@DM8PR02MB8121.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|CH3PR02MB10246:EE_
x-ms-office365-filtering-correlation-id: 6f75b0a0-42b7-420b-f7db-08dce3ab709f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Rg5Fk37flDLxv8pdgY7fUdWaUqlqBQItBaDaLwoVVyyzXu3kukhMMbta3R?=
 =?iso-8859-1?Q?jayJ+62RuTiIAGRR5TGfvlUcem9SPVYFxeqMPe6AjvuQB2WYam8Hr8UQDx?=
 =?iso-8859-1?Q?XmM9Cm/N8E3nJ42P8B/fgYfrIt3ptFGAIfh3xbpy9LrKQMoa1Sag/34I+G?=
 =?iso-8859-1?Q?/X3K74kzT4GdhWetHZ+xc3WWSA4rXeGrOkeFOE8UTWDrO3OSrnxOvxAxM3?=
 =?iso-8859-1?Q?2avuhHLNpfNFRQ2JCGco44KZx24n1J7f0qU27cyaW1OmyFWmsT99MumH0b?=
 =?iso-8859-1?Q?u1ozRO6y+p6N2+oeaf+7SgsqH1VxRA7L5ufCraTyOCuIppEwPNuLK/fH2s?=
 =?iso-8859-1?Q?5+ve7mLABOpCNFpsTCwI+yihWYJJX6HxsRrCHFf0EhXlLqo8zWp2tpz99W?=
 =?iso-8859-1?Q?mJzG9k/Y7EhWi3quRaIFwe4j/rK4Iq+zycjqFDoo/QFsNY6FNQ+WJVbLMF?=
 =?iso-8859-1?Q?QPe4MOrq96WS9Hg7DWwElZ9v1mZtc/aq2m/Z1+bIZpzjoTuThYi8koq9A5?=
 =?iso-8859-1?Q?HTZEz6B2xwVtxW3k5hP/mZXgrSNBDKYP2ht2nQrajolnrkbCmXBXmH5Flu?=
 =?iso-8859-1?Q?UrZH+CD2lsaPkiCMCXwhK9B877Wip7yYNkEdNQ5ZXDM8sgVZ5oz/zgTJc+?=
 =?iso-8859-1?Q?vezI5qOTOHZ7/51cIq9TtyXCPoHZqp0TvYobx8HYlSFkpU22j/WHl56JWV?=
 =?iso-8859-1?Q?YJZXSrkDqxz96o6+go71joMEpxWM5h76/+rE7h9qRrXg/blS4yjA/a0Cgx?=
 =?iso-8859-1?Q?IcOIJ5hV4CBYgubHQwx0cVS0TuBg0Tv9QkgUL6SROUF8FTwRm3AS0BUdNq?=
 =?iso-8859-1?Q?BBK+oOqhae6/7a9rJTWDG71tVCSkgnczOTP0Wu0wwH5NBOPK3diQCBV1q0?=
 =?iso-8859-1?Q?8qhBeg9cbNjc2MoEkVaCwU0+lIP4SOlahqpyuW0VaSO1BPXM6ZTGJn0L3q?=
 =?iso-8859-1?Q?OUUXhY6NxZC+i84131AofBOiqgi8Wdzck5OFZWUH4pNMLvp7X1fJIca2LA?=
 =?iso-8859-1?Q?aGrBDvy16jimyM4KI5iZwtTduwmVVbjLGs0sc8oScWBbdWlCVYx7j9785y?=
 =?iso-8859-1?Q?GrRIU3m5NPg905A79ZUxTfgTqXvMruk7zea/BnrXUESTOoAbQoRKZ3/ZsI?=
 =?iso-8859-1?Q?dRE73ZBVPyYPBs1tx/jxhXmFR3OfiTzbgAHDtobgtoWRn+WBcO1LOt31K1?=
 =?iso-8859-1?Q?LpZGFngRBebgjdJNxe71Zyh19Nlotyfo4nRB6sINzK0836dwFO/oDmI0ke?=
 =?iso-8859-1?Q?bi+SP2Sf9hCpFEYUZEp8U8fiAdd3JYCtj4Bdsw0svYL0/I6v48RlsIfXz7?=
 =?iso-8859-1?Q?jJM6SAZ/9f5Db9svNUG2myCrwqeVZQiDKDlvbNiTCFBuOXltrtE4URt/qp?=
 =?iso-8859-1?Q?HQt5Ush+VGrYC1X5ownD8mX6qnisFt2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+/81RQE9jbzTbC2wlE/tB4htMLroJ0QzRlGjkwaO92e6ejIa6hTatmvxfW?=
 =?iso-8859-1?Q?j0oqXv7VnZiWOqqEY2bj+xuAsB7ysQHLuLu9f7ragWkB8knuZTXc2rF9en?=
 =?iso-8859-1?Q?6vCNUxb4iy7eeHlVpo6GueuTJ3SDsxuPpwaeewOZUu0sC4YLy+JU02rvY0?=
 =?iso-8859-1?Q?XvyK3eIS9Qb6/MFKvLncJhNCvG48/LA2bmfhToQLyo3Zhx4dKlL8ChmGqg?=
 =?iso-8859-1?Q?JjvKv73dA0TdKGuH6U2aKLaUAw4Qd6s7Cc6S+55bAK2ZpsZw4Ykcqtho1K?=
 =?iso-8859-1?Q?ScojmAUvFmd4Ly/gJHz6oTPOHg52011BiFnmpw4ZeXc6PN0rdUMSx/IMRu?=
 =?iso-8859-1?Q?Hb0dbEVSex0hEH+xoXgk0qs9ILAls9uUYYr4yC4j0eX0hX259di9CGzA1r?=
 =?iso-8859-1?Q?m7pSnJz4C4gYto+TA+Nd98nOyOMQgon1trB49I9QW8JlS8Pw0K/9GmsbXk?=
 =?iso-8859-1?Q?Za+SbbfRSllnuB6eynB8b7oiofncnrYKVpHLqh+tqqD8rxg6i82KjXs1jC?=
 =?iso-8859-1?Q?82ehgnyx6Ou4OHBFCZ8TdFeBIAbODfr99yxXKQbFLj/E7O4/kemz3NShsJ?=
 =?iso-8859-1?Q?9o6GUWWIEQLIUAorFt9QqtTCZT919tvd1cwknnoDeiaM3Zq+VlLiP4IVZY?=
 =?iso-8859-1?Q?n4TxR4Z8VZRVMlQUk0L6VE2YyWg+vhIaahwS27E5Wi5Y0J2k7kws70PQ1K?=
 =?iso-8859-1?Q?/cAVF8gy8qcoEm3r0tFYfzVaZcuvCpw1olYpCd8IgSP/MomPe9reIii5N4?=
 =?iso-8859-1?Q?9IMZKgrK6trVCg1rPrCtC0LZGPVy43hQPwdEnffs5eypCET8q6cZJFf9v4?=
 =?iso-8859-1?Q?HLOG8pcIEZ/9wh1KdAN/v5+gWw5x/GZxYJj5VRAqPlSt2qcbyOAla0rABM?=
 =?iso-8859-1?Q?jthXtExGRJl9DGWHxAvZIr9SO0VC9tRcI+VpfV9/CENlcH5nZfnY+VOgI4?=
 =?iso-8859-1?Q?0fwZkEWH0Xc57oWdaXPidMFotxdqTL7DXVbcFjzZAAhLXnQkKMh0SfEihM?=
 =?iso-8859-1?Q?JwGUXOLyn1xQAHxV4DRfUUcnVvgmIDqbE/u2wJPw7tZmsNFnq2om0snzC5?=
 =?iso-8859-1?Q?ILqx251D2Lkk4bzZHiB0UoYklbTY0kBii1O5rUHcY58qyv0c3nUxSf7ePP?=
 =?iso-8859-1?Q?6EebZ7ixRYkmKtWLilgmJA+4Zq/HW2W0Qojsp83E3fyzpr7XNK8Tan8xVL?=
 =?iso-8859-1?Q?6KHe+IwCkEAmhzzIwdDAETZpqIwUU67LmFqOun6ceN/rfe6nZNu8Mt915u?=
 =?iso-8859-1?Q?qNBd+xHEmoDZcwD1qcm0nxEOGzLcTlE9qLGT3mwtkDd85B6zIbqUnzdnSn?=
 =?iso-8859-1?Q?JRfx8nrEaLF1Wi3pzsv+jIughbuFvA6uhZV9qVbw/PPDNrGiy8RwvYlGFb?=
 =?iso-8859-1?Q?epWJ5aEozjwdzbfQdtUIzY2ZXI7z2C09CfXbUiKBbu6T/IAj2Kqtw5q8AK?=
 =?iso-8859-1?Q?5Z1yXo6S5a7tZSRZK8/60D25KBZhfki2eIemWEU7bZH5BK6e3lcNLAQSiu?=
 =?iso-8859-1?Q?HEWbuHGqbFotOUTorTb4jMP1GuszOxfmbmIRwyYQQaxBwXnQ2hTEjlDbxE?=
 =?iso-8859-1?Q?/PCcaui4pMCfFaz9AKB1TTIGNRS2kaVoCNoIBy39iR8D4E/1D51dA/PIrn?=
 =?iso-8859-1?Q?CDDBfApeCb4LghRDAC0gRo1DrKyvUtSFgHC5B2JgpMiNAYD1FTUSIn0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81211F01833922F781C21E5893712DM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f75b0a0-42b7-420b-f7db-08dce3ab709f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 13:01:04.7714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dwvG39+zxkzI7IFSLiypZu7K2F/qYc7zQHhZsFkqi/jox8L3teKoR5XcRUbnVkxiSlBemL+8oXjQE/Y2TgfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10246
X-Authority-Analysis: v=2.4 cv=Q+KA4J2a c=1 sm=1 tr=0 ts=66fe9594 cx=c_pps
 a=F+2k2gSOfOtDHduSTNWrfg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=J_wQjozBFl0YgKN4rBcA:9 a=wPNLvfGTeEIA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=6_ymQ2YYpKtghglUmqoA:9
 a=hxu4jMRT2exIWSY9:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-GUID: pUviDA-KJIdEmDSSCkFlmQqrqdm-t-na
X-Proofpoint-ORIG-GUID: pUviDA-KJIdEmDSSCkFlmQqrqdm-t-na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

--_000_DM8PR02MB81211F01833922F781C21E5893712DM8PR02MB8121namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Looking at the trace output it seems that the displaysurface has been round=
ed from the start
vnc_client_connect VNC client connect state=3D0x556dce1c1b20 ioc=3D0x556dce=
9e1e70
displaysurface_create_from surface=3D0x556dce104b30, 1360x768, format 0x200=
20888
vnc_server_dpy_recreate VNC server dpy recreate dpy=3D0x7faa59026010 size=
=3D1360x768 fmt=3D537004168
vnc_client_throttle_threshold VNC client throttle threshold state=3D0x556dc=
e1c1b20 ioc=3D0x556dce9e1e70 oldoffset=3D0 newoffset=3D1048576 width=3D0 he=
ight=3D0 bpp=3D0 audio=3D(nil)
displaysurface_free surface=3D0x556dcebf10d0
vnc_auth_start VNC client auth start state=3D0x556dce1c1b20 method=3D1
vnc_auth_pass VNC client auth passed state=3D0x556dce1c1b20 method=3D1
vnc_client_throttle_threshold VNC client throttle threshold state=3D0x556dc=
e1c1b20 ioc=3D0x556dce9e1e70 oldoffset=3D1048576 newoffset=3D4177920 width=
=3D1360 height=3D768 bpp=3D4 audio=3D(nil)
displaysurface_create_from surface=3D0x556dce140de0, 1360x768, format 0x200=
20888
vnc_server_dpy_pageflip VNC server dpy pageflip dpy=3D0x7faa59026010 size=
=3D1360x768 fmt=3D537004168
displaysurface_free surface=3D0x556dce104b30
vnc_client_throttle_threshold VNC client throttle threshold state=3D0x556dc=
e1c1b20 ioc=3D0x556dce9e1e70 oldoffset=3D4177920 newoffset=3D1048576 width=
=3D1360 height=3D768 bpp=3D1 audio=3D(nil)
vnc_job_add_rect VNC add rect state=3D0x556dce1c1b20 job=3D0x556dce0ea1e0 o=
ffset=3D0,0 size=3D1360x768
vnc_job_clamp_rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce=
0ea1e0 offset=3D0,0 size=3D1360x768
vnc_job_clamped_rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556d=
ce0ea1e0 offset=3D0,0 size=3D1360x768
vnc_job_nrects VNC job state=3D0x7faa42de53a0 job=3D0x556dce0ea1e0 nrects=
=3D1
vnc_client_unthrottle_forced VNC client unthrottle forced offset state=3D0x=
556dce1c1b20 ioc=3D0x556dce9e1e70
vnc_job_add_rect VNC add rect state=3D0x556dce1c1b20 job=3D0x556dce217810 o=
ffset=3D0,0 size=3D1360x13
vnc_job_clamp_rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce=
217810 offset=3D0,0 size=3D1360x13
vnc_job_clamped_rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556d=
ce217810 offset=3D0,0 size=3D1360x13
vnc_job_nrects VNC job state=3D0x7faa42de53a0 job=3D0x556dce217810 nrects=
=3D1
vnc_client_unthrottle_forced VNC client unthrottle forced offset state=3D0x=
556dce1c1b20 ioc=3D0x556dce9e1e70

I'm currently struggling to follow where the width parameter is taken from.
Regards
Simon

--_000_DM8PR02MB81211F01833922F781C21E5893712DM8PR02MB8121namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
span.EmailStyle20
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
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Looking at the trace output it seems that the di=
splaysurface has been rounded from the start<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_conne=
ct VNC client connect state=3D0x556dce1c1b20 ioc=3D0x556dce9e1e70<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">displaysurface_c=
reate_from surface=3D0x556dce104b30, 1360x768, format 0x20020888<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_server_dpy_r=
ecreate VNC server dpy recreate dpy=3D0x7faa59026010 size=3D1360x768 fmt=3D=
537004168<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_throt=
tle_threshold VNC client throttle threshold state=3D0x556dce1c1b20 ioc=3D0x=
556dce9e1e70 oldoffset=3D0 newoffset=3D1048576 width=3D0 height=3D0
 bpp=3D0 audio=3D(nil)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">displaysurface_f=
ree surface=3D0x556dcebf10d0<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_auth_start V=
NC client auth start state=3D0x556dce1c1b20 method=3D1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_auth_pass VN=
C client auth passed state=3D0x556dce1c1b20 method=3D1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_throt=
tle_threshold VNC client throttle threshold state=3D0x556dce1c1b20 ioc=3D0x=
556dce9e1e70 oldoffset=3D1048576 newoffset=3D4177920 width=3D1360
 height=3D768 bpp=3D4 audio=3D(nil)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">displaysurface_c=
reate_from surface=3D0x556dce140de0, 1360x768, format 0x20020888<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_server_dpy_p=
ageflip VNC server dpy pageflip dpy=3D0x7faa59026010 size=3D1360x768 fmt=3D=
537004168<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">displaysurface_f=
ree surface=3D0x556dce104b30<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_throt=
tle_threshold VNC client throttle threshold state=3D0x556dce1c1b20 ioc=3D0x=
556dce9e1e70 oldoffset=3D4177920 newoffset=3D1048576 width=3D1360
 height=3D768 bpp=3D1 audio=3D(nil)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_add_rect=
 VNC add rect state=3D0x556dce1c1b20 job=3D0x556dce0ea1e0 offset=3D0,0 size=
=3D1360x768<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_clamp_re=
ct VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce0ea1e0 offset=3D=
0,0 size=3D1360x768<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_clamped_=
rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce0ea1e0 offset=
=3D0,0 size=3D1360x768<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_nrects V=
NC job state=3D0x7faa42de53a0 job=3D0x556dce0ea1e0 nrects=3D1<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_unthr=
ottle_forced VNC client unthrottle forced offset state=3D0x556dce1c1b20 ioc=
=3D0x556dce9e1e70<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_add_rect=
 VNC add rect state=3D0x556dce1c1b20 job=3D0x556dce217810 offset=3D0,0 size=
=3D1360x13<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_clamp_re=
ct VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce217810 offset=3D=
0,0 size=3D1360x13<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_clamped_=
rect VNC job clamp rect state=3D0x7faa42de53a0 job=3D0x556dce217810 offset=
=3D0,0 size=3D1360x13<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_job_nrects V=
NC job state=3D0x7faa42de53a0 job=3D0x556dce217810 nrects=3D1<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"background:#F4F5F7"><span style=3D"font-siz=
e:9.0pt;font-family:&quot;Courier New&quot;;color:#172B4D">vnc_client_unthr=
ottle_forced VNC client unthrottle forced offset state=3D0x556dce1c1b20 ioc=
=3D0x556dce9e1e70<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">I'm currently struggling to follow where the wid=
th parameter is taken from.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Regards<br>
Simon<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB81211F01833922F781C21E5893712DM8PR02MB8121namp_--

