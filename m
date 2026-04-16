Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F8F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsG-0008DA-DX; Wed, 15 Apr 2026 21:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrv-0007yc-IW; Wed, 15 Apr 2026 21:50:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrt-0007PV-13; Wed, 15 Apr 2026 21:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCWR5g61wSIzQnGW7GY2MhdyygdCgIASIPvhVKlSlNBesB/0PhEQScWsHC1ihzz2A3o1nyvIr12kfGsMi5IwR2//NgCNtJwoVE0Fwr41CSqtKuGP4m1P5AS4/16n2s+dACrlezf0FfYClW++t+66+XAzXgpZKawwwjsR9QTJ+ae4Jvn6yxMNsSwNmEZ+kFbNREC3WTLIP+SpZT0hwRTkpofPcAwD72h9S5PZzxckzFAGVRvq2b9boGgC7GxHJGJ+Q1ovtl+//YrW1W4IeMte713n/jnkwot1l604WDf7g3O38X7xLoB++DFQelYptyy32icrWOjwcZ6M0OJIwL96fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAsEwYhTEgnwpr2wb5WWKVJuSUOpQQQf3sYOcHjK3dY=;
 b=HnWphBhwPkC8NPpzobpEp2XjtnPJp1c4dn0//OrQuAfg1/t/j8TSG2UCeX17J+Ufyu5An2UA1DKObVBPZomyUNTN9Tmt0V1AWwTiAloTdpi4WTHHwYHgBrGrkTsemXZPhjnGbqCBKjkBtnBvT5yeckcwxXBcqGX7JF9bXrWbOlimzolNndpionisbpez0e+Yasb2LS4i3clpd6kcOGndvsRyMLl+8iY1Ih+LB2YrmDU4LEXSyj07239Z4ujE+9pxZzLXaJNhdImAaU93UKIQrZPgHPHQzNzaSYB/VCzkh1jJwaGBF1fYaKLT9giFaMVi6LnbrbaMtqwBWjf5J45SbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAsEwYhTEgnwpr2wb5WWKVJuSUOpQQQf3sYOcHjK3dY=;
 b=PfNS/YNZsAQUn5eykSuTasL9peS+RvaQZqD0iINCU10fHVa4s/8AdVqZg4SXk9+hz5R8kbUoEq+qugtCKWGNy9Rr/t5WC+irRm6+Kry3yUO/b1huqnc3+6GtvtHuxwcW5zGyueeS6n/U7yrACQm8rUxGptY4imP4vgfvWwclZZhs3sc56DRoI54FL15bDXItAYJjILSX1W1crXV2vUS03FHthN5h0B+6synGyYMD1Xoog3qRdgR3oqcbgvBqnjSXhp/SjVn8NChjNtLxKYpTrndiaHRbDZ5AV7jiKiFM6BtQz3dXoE2uvsfnpQgbJeExska1KgYj8tH7FzKwy/RYVQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 11/17] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v3 11/17] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHczUNTxi7u6u1JKU6aX9gks+CZZg==
Date: Thu, 16 Apr 2026 01:49:55 +0000
Message-ID: <20260416014928.1279360-12-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 1e67438a-694c-47f6-d674-08de9b5a7598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: GZon0+FovbGB10fEyV1GrcEzrND1GHCiLu3wzri+XYSxJUgMTFCYDR7AaXJ/ZTLOUAvQWG8E8JQm/8igiGy7ofZ/aW0JjRDcqcSCoikK8wPGK8W4cl7n/lHbzpAmkoLzmCis7x3pCQ5rgJsGGDMYo+azLWmx6rMcJAyiLxHdya50H1WjUOrg6Bi1DLzqVF+jHdGwA1r+HGLV8FKf/ygfXg9TuFy85o4E/Wo+q25936tgGDWZPnhnEAYBXAM9umiByvkhBZmLuFQJIewRugvpq1ZKFWS9agsYxvWzzr1aJd5VY7/1ckB+tm039wY/6qaAiDxWtWhsMwB9rB0Hj8qOSwBvoI780kFoYad4kTWXxSltGxmnBs+Jb48jqiuBU8Th2J+LeS/2a6y6P6YL/lGYeOzCd0L8AX5rpcFUj72CWu9IPRPb31+arCIh/NHV9Im6ik6RrEeMYeU6GuFfrPa4vgMeN+IPPkv5yGgMyVVoa40iX27eElku04U2cot0mJrp8ZuOS3Vbv8c/NgJeawp2NzlQxBV3kW44aFiis0KBc1YD8bMMimO0ZOWjY8VKk12WsuMawm1urDW5zeU/uqEgtBcHRIESI+N2jBXbg9BD/7dQWnUjjiVb58mAbe/s6DAZh5x8jmXNFKq6aHU1xl3ZUC79LqEoV3JRFkpROgBAifJ0HTup0LxZ50SD6cJWul+ECdqpLNADCJj+322il5KnfQ2hbq/dUz9RhlzlWEewtj2pVQF7Wswz2juH/RZ9E0TojAdwbtxKO0LjCHMX/35urart83igesNkyo3ym7hXd3iSBEsWcnUH3g0YuZkJt0C4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cOXvS8DYBOpKixOQdo0Rol+1K1rwc3FzfMTAMZE5DuyRZKzGPfpWtaMYy6?=
 =?iso-8859-1?Q?ypbcwoLwgF6Dpmfj+G0/9xRtU4edu9Gycu5AOkQyWYlJ1XOjkGFR8ti3E8?=
 =?iso-8859-1?Q?+CZp8ull8qKa7aS3TxG1+bA6HgU2qurnQbF+XvSnS9FxkMioimRN7tt5UD?=
 =?iso-8859-1?Q?aHxYR6dKYC4SHqKBJHzDDL1DuGERDDOdES4PT2gKJuFvP6EjpjDxzDhjBC?=
 =?iso-8859-1?Q?ZYwoMAkYBdBakf3/Hnf2KkgjIC9CWlL8/OzdTcv8h8NeO+lL22nT6sZ1VA?=
 =?iso-8859-1?Q?yVI6kiK+CVMSMFwDACqXD88xvqME/3odKMeBYKQGY/rf3lOEYRTaMP+U8z?=
 =?iso-8859-1?Q?Ci/B5qLnel70juBDcbCnal+qCNWxwMLddp0reF4XMoMxsW6H6KHa/93tJL?=
 =?iso-8859-1?Q?bddoakI7UtigTb9zUEQ3AAqtLsg4pEFDUXCTObzlFL750bXK76lIIb4i8D?=
 =?iso-8859-1?Q?3QjiP7GT1KZkNpEBMgiYN3XjFZtxcVONm64rPgYW5Wr/99bFclr4hkkhHR?=
 =?iso-8859-1?Q?hd9RQ0AbG6XNUA4YmyXredMNoa3jShOP92eI7llBGcd0orTPJ56vB4SGFx?=
 =?iso-8859-1?Q?ROJReOenSP74a5sEoiJV51Wx5Mh2xnt2+R01uXg/bK/xrx857F099Rail/?=
 =?iso-8859-1?Q?g97cXguEqE8XINgauGg/KGEvAsDA6SmjSuwwPfTZrvvNCuZB7TrVyT6gsh?=
 =?iso-8859-1?Q?ZfKOPuSF9X8Yendxd3cNrJMpZ/45fdECjDYhlxAVDFog6qNt1W0bPmp7N8?=
 =?iso-8859-1?Q?NY6kVs+VsQAt31tZ4vmbMw1HDTgTBLP+L/XtJiWS0y3OUd5qSv+TU9yvuZ?=
 =?iso-8859-1?Q?Hnl55Fcg7h7ICOOpVO3PQEeui0r1ksWlPZIT0R29WYvpCBFEZtpz4Gx3Iy?=
 =?iso-8859-1?Q?8bbkEFFWABjFK7AM7eAg9wu555xskvkywknTqypJ6qidb6iXoCJ2HKfopg?=
 =?iso-8859-1?Q?EAluZnGmvqw3rdQQS8trdHIMW4WiZZ39pmU2b27LbmpEigH4L5dgqZbPCF?=
 =?iso-8859-1?Q?Xwhfssu6wnoJJPAcgFX/yTucFQ96v/H2EazmWRVE9XkRGCxaOMfnsR7jfo?=
 =?iso-8859-1?Q?KGVz2qV4WfQ8xSnM+6ip2pg+VMsCVkpwWAAOsHDnLWuu8mXlcYdDHl9dtb?=
 =?iso-8859-1?Q?+ABE2x9Z74EcpAf+e0luGJzG4Ia/AlUd1SAwQQlAG88KnZzlCzlb1DQmEu?=
 =?iso-8859-1?Q?cne4UO++feO49eWjI9YzkNazq+H7Ifpy2EJz3Am85YPK1Yams5WFnJ+Sa2?=
 =?iso-8859-1?Q?IRxO5lLmqnzJiQuS4oRUu2T0jHi01DVmB4dmRYvuO6tW879gH6fUwUCIKC?=
 =?iso-8859-1?Q?2yLr7+MDy7OIMG0TKEyZIikaWJuwOEet8gn76+IwPOufQ1rryxXkfJOyKB?=
 =?iso-8859-1?Q?AJU5FzZ7g3lVCQXmuX2R77TUZIOdE1vp9vAV+mjhE8t30L22BgCGgUNAnm?=
 =?iso-8859-1?Q?iW+p05xcRRGAYBTFPkVOxlVZ0RmUFWwuP284XXDhdVoRElBkeUtiNMRQwA?=
 =?iso-8859-1?Q?yRP3ckMPMfdKhiV6reikfCPgWzC+BdMljApet2azPd/+YV11DySblLTjJk?=
 =?iso-8859-1?Q?tsQHaOSz0UwAMPtXbnpawQI4QVuQG3H+WEkyxve+TTOe87XXM8ETxeFkyO?=
 =?iso-8859-1?Q?HviyN4lSDVtXoaIAyrC+5zFyxZkiWhvxUOnS+fh6m8CSYuNB0cbKbAKp5C?=
 =?iso-8859-1?Q?K6Za8Od6XWufnlT6ltBfQD6AGFzi7IKUPTyBN2Fuv2ADNCSwtc+Zqm1J8k?=
 =?iso-8859-1?Q?UWwfIf4Sqwj2F4ReCvozGezgW4Yn6V0IyMH2vSFjrvsVIP1T+nspzyjzw8?=
 =?iso-8859-1?Q?nSNbfZIpCw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ggiZAXpSkMKjl0PLils/Vm4RsvYXod14Cqa79/cb1cq4y+EHF5M9mnvi9x7UHNrHFhzeq4zDm654fRnJxMRJ1dLA2pCRmFQhtwdZJx5JkYYoYTX7sIWe6ogUk/OJa3ADDJyQsPENW87es/7ka1C9/6ScIbPD7WgEzfN67QeCzzQKUYgcck4gCd8XSDh1IV2Pj/YR/7LE62R/W7tLQLSaWsWZHK80TbpCwXSyJVUEOEBlVni4rBWyJRIbpnzgKct3PDrxXP3+iDJ9OAF5M30YlnYEiH0CV4cLaK+IxPSBEEsmzmcUz+fbT2F5PBwRWEOSIPRPfLr/3hR1JFGfgkpKFw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e67438a-694c-47f6-d674-08de9b5a7598
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:55.5335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mbohS5RJgtf1QQGaVESfU1w4KCivEhanNX+2nhMkbmAFJrE0w3U3DL2b30+bFFvFp3K/jPYOOPwm/QXs6kddLNamNEAOJzYrM/IZ75ofEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 712de9d50e..af8c080c60 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -63,6 +63,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index d93d227e6f..3db1c25e4d 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1463,7 +1463,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1471,7 +1472,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1761,7 +1764,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

