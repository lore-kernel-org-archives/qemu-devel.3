Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2464CC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526q-0006xJ-5s; Fri, 11 Sep 2026 10:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526Q-0006j7-Sh; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526L-00049P-0S; Fri, 11 Sep 2026 10:19:40 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh7K1004863; Fri, 11 Sep 2026 07:19:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=RMwn0bYs3YBcO
 Y31tI3jQdueRf3rdPX/orzP//5PVjA=; b=i2cEXSG7jlvu6XDr+bO/ancvbB0bK
 zSkDgTg2fPdBr3DMYc/87dC46Xk8tnF4f3nWDjKdM3kr37YCXIQYE2Tel50AuLPJ
 KC1UEhVvjcjEheajS/HbHJiF5dqCg7OsPs1DYjqwL/uGxe7q69WCWgmFYEaT3sVW
 hIETJjOq9o29ESM1qxli7eGeEFVX8PZGGDsD8Etr/CXP0Wjs7J68bwCRaXcdnQee
 SUrK4eJobRiuUroaVaSgmhSKo2PM5xPsbEZAzCANyZDfUB1KKhQ9NlCLy8OnYP46
 4HJ1ZX/3j34wrresi/vH+36igoXLFR/NgAp8Kz7IcOPxwxGAVDv6clRbg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157rs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxF0hqqKOBuE8V14WYrQazMcydbEFpJ9P0WlxexMQRV7/KlbvNi9OOvwT/XV1WipAQ4e3lXWOIiwga+pJxZTirlcEYVkV+BwakIZO0zy90NUpJ/H76oWJ43nWX+BeV8KaKtdMkM6EqnkJqZQKGPG70O2q3TJEue3hUJg2ZnECWdYIlraCYd6/Kqoy3kzj2hhLNEZ0PI3G5vj9f2K8a0iJ2jigz1y+nC04shpat22q+f7RMKYgCbg0vb+QppbRgUViBfZdYlkSDCnedtBMpUDe91RGqkvxnVpL9//HyavIRMBY7gcngoAIfHP92yg22EtRHYgcB/t7UpeXFfnu1oCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMwn0bYs3YBcOY31tI3jQdueRf3rdPX/orzP//5PVjA=;
 b=p6v7Rmaj0Xo28OBtNlc/rbD0LnoQDsis2t0fzgc/y92+GafMfOtD1LbxUexvV7rDeB7P7xNg7zPIkQsqMmq6v7wMum0yYMJfO/YcvwdsRWMzUHfcQcLA82M5xHWhYI6NODZGxbLIFYoY7lOxPqD8PUWWo29xXHnMSQp/U1VYaW3srN5E+ZAFEsCMthb0ELfvpp+nNzur/M77zMxqP9K7T5Mr+gT4sTw3Kj3WtDBB65qXfXUpcTsOWfc/SmMfyIjrbm2iYe/HWms4M8pI1/H8/G5xwvk5EKCK31vHrXL3p3e7U4Jyhtc6yDvVs5+3Shp9LOG2TgAu5wwaWEkEQQeeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMwn0bYs3YBcOY31tI3jQdueRf3rdPX/orzP//5PVjA=;
 b=wHDZ5TS8k9lu+TlIZVayJhHtPdI2d84RcFjQWY895rtQQPjFpWbY6BHwWbY5c+1ixXl7liugSzC3fGjRTG2iBZCykmIYYJLZjJoV4rMeE6j3hhTeCTEI7Cagh6ELYFtg2c3lJQF3OnSdH4opGkTZpXCtGAD6PveAH7/wgRSBBd1XFFmd6BXrh+/knQ6vC7Q4Va9nriC5wwSwcyCpLgfGWkqkPcoZSsXvLSEXT2owDMpAgif6zQ/Duyo5MwbWyudF43moWoLnqxN7n974Jz1nbkqK+65rRdZQdg1zSVvRCIpGlBLiH0qkcWVxrOFRG0gKA941rINd/zMIHmsaq5yQ2A==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:21 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:21 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 0/8] vfio-user: live migration support
Thread-Topic: [PATCH v2 0/8] vfio-user: live migration support
Thread-Index: AQHdQfiJ+FulvFelYU+iY5QEIW2fEw==
Date: Fri, 11 Sep 2026 14:19:21 +0000
Message-ID: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 011b72ca-3eb1-4e79-1e79-08df100fac6e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|3023799007|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: Liu9peM9IqoJRH57vlVK9FH59RrcJZzF9TSxqH2obrbYdJaG2oojKCRVTSad4drornzoXlAc1RreRiwAbyvAs6L4PtMiv41zzrPm7NE4EINHfbE/kzjKT6KNiN0KlO3KiZeYRsvC3hV1Ld5OE68cZsT4X3GhoMl38csVkueGBNTUTFCxW9G2HgWmYABYZuG9poBDZuwC1p/AU9ISKzMzgMfFgixX0DxSwyW2PqW5TeYIcpDGpZRDvpEDqwAKlaKfEtdvSt3lYr8Upz13/VraQuPRmzHCjtAdygdzhLzZopEa4mxaZsEW5cmcBM4+1u/14B66IBsEHCgAn5yGOq8TlzbYVLXzXBrMBuWupWNNs20qEXj1oor0EIPSwKnbOFj7jbatBXJrFfOvGXkdUTD5sd+LKMINHzmztRIAhIuG13rtbBcNVAa0zodnuvcHBrf9c43sMXBbXxdmgo0GlBL8ILQVA28r4MPy3ujClWPkm8ntYlcqb8yUZenvmZuLFjVvUB+ZwrGyZeShWo9yQol0mK9Q2qmnM594l+iVaklU6vb9lI9L3m3x+5SBx8nnbMU1EtXDWdnXNtNmhcfSU1Az9nm4+ICsKDStyTqV+RRJ+ajGGgh1FX0WJSByX7FLCIUrWW+VXLIxM6f93rTuRUMZzCl04gboD4QSdk2ArpoPpzs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bn4PDOFyPyGbJPnmmCvxZ0PrMx/pRg4NDQoWWrwu5dmyVpdLRzycgF1CsS?=
 =?iso-8859-1?Q?PRGYtWC3Bald2v51m1AmzyTtEQz7GHo1JvQzwibRko6oj0jSXvvvVVTFml?=
 =?iso-8859-1?Q?Kqeaiq+EFWlRE8efXNyEYDIAfteCuxljBQyXfu3eu9eHtMrdXzqpejndU1?=
 =?iso-8859-1?Q?aOnG8cxrNjaJYbSmgbfqnI5R3jzNoaufoAQO97ZCBlxd78rckNkjKWQAix?=
 =?iso-8859-1?Q?X3sD65OeX+wGkhKsIRWERqtqYEUDja1q3n2SA1dQSyCqO3b2t2EdSrIvOR?=
 =?iso-8859-1?Q?mWgmJycyjN/kWMctcR+lkjqhJz0/SX84TChLOtgvEJotPt6S7JYuA+NEqZ?=
 =?iso-8859-1?Q?AcQs+7LW74gNzj3PiKFmJAYO3vIbRb8vqMPs5b5802cUa8E3zK8Pq2Eq66?=
 =?iso-8859-1?Q?Wcb2SQIMcEWm5ZqjHNl69vX2MfeQA8ECjzPMBnUFwC7KkVLAdXM9QKebmA?=
 =?iso-8859-1?Q?teqGtMSwspyZ5DNzt9aHbU3beM7dGHTwXz+iEW4fjX6U02/zeP6VB5AKlo?=
 =?iso-8859-1?Q?tSlxHUtcge5zv0jPPtvYd+x6nVikemLHqJzZwjvTeFb6iSqMpD1DTX+fbN?=
 =?iso-8859-1?Q?VslzxjyE7DebLEYAvRjTLZPdnmLQvdB0cuy7kN+l8TKhcDd3nLTotQ+z4V?=
 =?iso-8859-1?Q?NpGMi9hlOU7ZRxFkAOzSU4H+i1WULj2GWzbqLw1u3E2TiRj3+P9yD5kzU9?=
 =?iso-8859-1?Q?JvFImQhyhUxCYLnbyjF9kb2CuPees6vtfNTSGbuVy/660AEDx9aHgtyc7/?=
 =?iso-8859-1?Q?uoaNYrFJdXuR3ro5dMOEZE05oLyq762tmCdQAoRMtaSCRcB/Ixx/ZfVIQN?=
 =?iso-8859-1?Q?UtCSWe9CzWQAncE28QNge1KXL6pgzsA1y7kjPIhqCR+E62jEkC/OfUu3lS?=
 =?iso-8859-1?Q?Tqc8Tc6gN+dyLT+Fs4TdpOF7vG1ebk6TjVPIuufHDsqr9HoGJEpupi+536?=
 =?iso-8859-1?Q?aOIfOeN6neXVPtGrxMA0VYWQkubRygVkK+yU2NGQE97qaziq+30CP/E424?=
 =?iso-8859-1?Q?znVWcyy3hTDMX3zsxAaA3dDH74ZbVxuwSBO86XOHAcfl4h6DJdtRxavPqP?=
 =?iso-8859-1?Q?QS6zFHVXQUvD3iN1SSBk2n5RRg4T1yyym7fGXW/AQSFYngU1iWAVE/cYSi?=
 =?iso-8859-1?Q?SbOJKmBacADSVAujj0xj80s/ZbVeT/AVL4AgumMtQQmyiQ53yy9vmmBydO?=
 =?iso-8859-1?Q?pnb6syrJNAVdTV7CveExUsXZt6VovUSbTwxHFepK3+lQCRA173Q6iCvyaY?=
 =?iso-8859-1?Q?WI6C55WYMgpv7QUJUIyKSPDDLDyzZpprhbVPjV+IQoMLNVs7kU4uqW+Jof?=
 =?iso-8859-1?Q?eOMG8C8aPAN3y8HODcpAXtSC7FYdcSyQh2frk7keFFkq0QdWuXsk7d9XcT?=
 =?iso-8859-1?Q?zHcniWks4ndxTJMAoGltALMCoPybj/iFj/Nx+hQDdAMqfMXr7VZackDjdr?=
 =?iso-8859-1?Q?8mfOCbZunwOHx7DlmRi8DJVzQ8L2+DvIebrKs+DJgDqhmzwKgXZudAPZ/d?=
 =?iso-8859-1?Q?4NSXNK4NFk1lhfLz3CmiH04o24JwVGEQ9VDpZmka7mSDdTtQxk/Q6BufD6?=
 =?iso-8859-1?Q?+Gj2Ec8ZTaNabfGCMlIrXzwRF9ekZINsS4VGzsglYg/DTmlvw0OTfKFiyq?=
 =?iso-8859-1?Q?e447IBE2EfGKpm/TsPpKzpT6IhhCVRf45dqkg6lfNfb3V6qqBVOb5+VKzM?=
 =?iso-8859-1?Q?zklQ5uGX8VSV1ctDSh6xbRZ5DLegF581X/jcntsz2UBcqH/JG2E1SXUQEK?=
 =?iso-8859-1?Q?6wyBkScOew/yHuv+6rSoAlCg1MnBeZXPGcFt2ezqU8heMlDOh8Og/mCTg7?=
 =?iso-8859-1?Q?7SYW9MLlaeQxkSvlNwCxDv7C0qfCB4o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bjFQlvKWdGbR6xb+gr7GMqvta0aeNTeJngDEn/tR3LnAba0cTHX3ZbWSRgLP519e2OtcUH3yETKMJ8O2kzOC2wKoCk+jc61xfRxIycSkJD6KvAgKBnLYB17PrXvlI6LmW6ldcsphpv7/rSbgamYg227yg+/4IlxtaGBtUlAOBURqSXPB2snBpWqtfFHLCAZ3vF5rQXnOXluNAlcMFRtdJp/NG3wiP3RxO0XVnHUNpP/yvfGkxRyHqW3Eiu+Hl/kBqmjHzYh7h/9c9xEvcPuT0beQJNNLBLDKVY1DOBzdP9sShSgPI04G8PppFGXNdniIulkdFKGNaNa/LBe/GHitqw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011b72ca-3eb1-4e79-1e79-08df100fac6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:21.3294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQhEZZZ5ik0MSOTuIFqQKQc3NUYS3a8wKpw9tvUf/Ft5cjYvlAhsXRtvw9KhqfdprGdGfUAnnUtQ23Vj2NbZfSVpmi4zLuxR3OlcqOnTbxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX0hpjF0PxUK9c
 zExJrBo18BS1R1EG1POoIV7wJ8ntLNEQGIlgYz9dufaeEVbR1QpfO0DNh8ENuoZA4JoHvWPA0d/
 a1GIZlbaWqYuhW+80K0/KF1JYh20kQLrilf/S40VhxeMutGGCVvL9+2Tzw//KO4a1TTRmLfM7Dc
 gWwprQjYcaZ2wMWiOpNrTPdrTh8+3vg6CuykRi8PKI6pFbIDMkQkrUu/k0W5fUMMV0j3d35YRFA
 QWJpgbxXOfukjTt3amSFwXGDrBY8Q9x5HfBdtyC2L/WMGOY/SDGhZbq4aMhqGKl8qqHj/pdgMug
 mtfvRqb1/qlYBKhBTLrdkryriA7BKbjEYzwV+jVG9UpwY7r6Sg80H7bT85YfugUVUHMxid+laAI
 K7YmQQEutFS8Ayyb1XtYUMiOK+IVKbSaHUM9Ren3/OnoaZzzZu4C16Xy3q3UCwGQetKEhzoGRHs
 wHb4WqxlHd7tpF5DzyQ==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40def cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=yLxAKQgpAAAA:8
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=gG_EBmXQ0LRa6ASj_y0A:9 a=wPNLvfGTeEIA:10
 a=pu3MsO4jS0LNTy4EJMSl:22
X-Proofpoint-ORIG-GUID: lMvIxn-Jjf9_q9b9B3tvBt_KJK7Gnw9s
X-Proofpoint-GUID: lMvIxn-Jjf9_q9b9B3tvBt_KJK7Gnw9s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX/TTB8pucf4Xq
 h3Zv5x6BmGZtGYWbeurEH8DQ6qJIz6ZR/YfY9iaxzkSyTwI3MUIITMHgLgxLyTYmNL4+YPNwsIq
 60omfu8pi/5+eQj+iZT4g+GktZs3OuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This patch series introduces live migration support for vfio-user PCI=0A=
devices, built on top of the VFIO v2 migration interface.=0A=
=0A=
To avoid duplicating the extensive migration logic already present in=0A=
QEMU, this series reuses the generic VFIO migration infrastructure=0A=
(hw/vfio/migration.c). We achieve this by abstracting the hardcoded=0A=
kernel ioctl() and read()/write() calls behind the existing=0A=
VFIODeviceIOOps table, allowing the vfio-user transport to supply its=0A=
own socket-based implementations.=0A=
=0A=
Kernel VFIO transfers device migration data through a dedicated data_fd.=0A=
vfio-user instead uses its already-established UNIX socket. We introduce=0A=
three new wire commands (VFIO_USER_MIG_DATA_READ, VFIO_USER_MIG_DATA_WRITE,=
=0A=
and VFIO_USER_GET_PRECOPY_INFO) for streaming migration data and querying=
=0A=
pre-copy information. The protocol documentation and dirty-page logging=0A=
behaviors are updated accordingly.=0A=
=0A=
The corresponding SPDK device-side implementation is available as a WIP=0A=
series:=0A=
=0A=
https://review.spdk.io/q/topic:vfio-user-live-migration-v2=0A=
=0A=
Current limitations:=0A=
1. Peer-to-Peer (P2P) migration states are not currently supported by=0A=
   the libvfio-user server, so P2P support is not included.=0A=
2. Device state pre-copy is not yet supported over vfio-user. This=0A=
   series explicitly strips the PRE_COPY bit from the advertised=0A=
   migration flags, forcing the generic migration code to execute a=0A=
   standard stop-and-copy migration.=0A=
3. Backward migration to older QEMU versions is not explicitly handled=0A=
   with compat properties in this series, as older destination binaries=0A=
   lack the underlying capability to receive the vfio-user migration=0A=
   state.=0A=
=0A=
Changes in v2:=0A=
- Use vfio_device_get_feature() for migration device-feature operations.=0A=
- Add a guarded vfio_device_reset() wrapper and route all reset callers=0A=
  through it.=0A=
- Add guarded wrappers for get_precopy_info, mig_data_read, and=0A=
  mig_data_write_from_file, and route their callers through them.=0A=
- Preserve the separation between capabilities and callbacks in the=0A=
  kernel VFIODeviceIOOps initializer.=0A=
=0A=
v1:=0A=
https://lore.kernel.org/qemu-devel/20260903130833.1437632-1-hugo.komatsu@nu=
tanix.com/=0A=
=0A=
Hugo Komatsu (7):=0A=
  docs/vfio-user: clarify data_fd and DMA logging behaviors=0A=
  vfio: route device_feature through io_ops=0A=
  vfio: route device_reset through io_ops=0A=
  vfio: use io_ops abstraction for migration related ioctls=0A=
  vfio-user: enable DMA logging for dirty page tracking=0A=
  vfio-user: implement mig_data read/write socket operations=0A=
  vfio-user: enable live migration for pci devices=0A=
=0A=
William Henderson (1):=0A=
  vfio-user: add live migration to vfio-user protocol specification=0A=
=0A=
 docs/interop/vfio-user.rst    | 132 +++++++++++++---------=0A=
 hw/vfio-user/device.c         | 206 +++++++++++++++++++++++++++++++++-=0A=
 hw/vfio-user/pci.c            |  13 ++-=0A=
 hw/vfio-user/protocol.h       |  19 ++++=0A=
 hw/vfio-user/trace-events     |   3 +=0A=
 hw/vfio/ap.c                  |   4 +-=0A=
 hw/vfio/ccw.c                 |   2 +-=0A=
 hw/vfio/device.c              |  84 +++++++++++++-=0A=
 hw/vfio/migration.c           |  79 ++++++-------=0A=
 hw/vfio/pci.c                 |  31 +++--=0A=
 hw/vfio/pci.h                 |   3 +=0A=
 include/hw/vfio/vfio-device.h |  57 ++++++++++=0A=
 12 files changed, 522 insertions(+), 111 deletions(-)=0A=
=0A=
=0A=
base-commit: 55347990687e7bc5b6b0d624f290025726e8fbfa=0A=
-- =0A=
2.39.3=0A=
=0A=

