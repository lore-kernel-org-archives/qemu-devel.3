Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B7C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yy-0008BM-G0; Tue, 21 Jul 2026 08:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yx-0008AM-Eq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yv-0004nT-Du
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:07 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAR8p33215302; Tue, 21 Jul 2026 05:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=800TbBM7CSnykyjkOLAbVq2c53OfVHHyUJiDplMTn
 E0=; b=OGPjsAJOj4QjNWO9CrsAV0pIiZavgyXj4gQXxeY9ge9K2xspFj23utvO2
 0uyLz3WCctAfbWyuaFSC2PPctQqXT6xfejRJs6QX3fdfCzEDaA+/dtVM7u9vWa5y
 F4/zJA+OnQab/dWQtm44ZWQJ2/Gb4ItVctxv5NIvhBA9cWAG5Cjw+TonVTtn9whF
 /Mp2je6M0JeucJRbLK8ZlaTzvM00gHMN/k4FzS0maTv8DewnKR3V192ToU7LmQZx
 zsAiflK0Fw9akJin1HdfbFqJWZzu29rRQRBJi6q/cwJRc+YucP0wSliPMT6PPVWv
 jP5biOaITLeZ7GSOvE3mXV3v1uX1w==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020105.outbound.protection.outlook.com [52.101.46.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8eeebs7-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyH63oNKTpMzeoJ3oX/jo9Bb5lkm832yQpkOFBbMWkqZQuBLgt0s8S1E7I+srdfQDHym2hyZVDhw3d1t3aew8AXOa9O/bj/Ge80cetU0WIB791GFTNMYT/tNZa2nx48bqj+JKsIp2QJpBQxotQnsSFg6rq5oZXk8dWYsUC3HBvM0zrDOIa8D5n81YigfFyvFn+ZjMM4q7ls9rSyXEZ9ia7xhc7S+Rn8a2kc222JzAnuxJVhbUCz2Mdh/dDOSuwmovTjsIlaWKHObOk5HMQIx7uK8HBeL2lxSRKbP+UUoM4UGZh5BbyALvK/aWJx0X3gIiRcJvrNY8novbRIkwyb+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=800TbBM7CSnykyjkOLAbVq2c53OfVHHyUJiDplMTnE0=;
 b=GRRIMYkQGvbgAGLVsxFcKLjyBqKNs1UmrkDwSf7xgPLeV9MBvAfp+aiBrx4rDl2l4xUSNaf6gCDMwSWQ3yMHm/dcxObyfLSHF9tg11a4NjPemz0SkOL/pJix1YNmIq1Var0ArDIRMOo6mHmcs3LSnsvZa1+QqzF1JyWZ5134sBsZpDpShBpQTlz09X+J8cR0W3rEbw3i2OXDyZ6xQiG+xtTz4mQubmIG0t+Z7+AXwKTSKBGU+CncRADrhKcAkWk1s7PMJF7KeCnv6KuxbnA/W8eyvH8xOd5E8y0mJHiOuobGutD9D1/P7Af2JBg43mwEe1Kf5HVshb4O+yyQqTtSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=800TbBM7CSnykyjkOLAbVq2c53OfVHHyUJiDplMTnE0=;
 b=jgJlYuNTOb5jxpIx+01Wavfuszc2ovUtjxnRuhrCX9vWVsqHwfH44nBkCrmQbXZ/FN1BsHk/hY04h8+Gp/FMlwRj9VP/j/8UC4CRnUfGVUNIp+P7NR8A+GYN5mCpUftCpIzwAAV8YVu424pFuM0WUO7DJGAzhIPHUv6FJ5IJNVSu5dCFjNuuN/l2XxBbnsvmxbO74yRRAzW3tiWbRWEwSR3NQtiR1BhAEmIcWCdhV+thwlwwCNqB+jhjvzxktbdmZ1oRxPWScynJ9tYzZn80qme++TO3SEwJ5SMs1JqK+iavzcf2ZK/yjk+7w0Y91DtXCkJ041G5lNfVla1/Lsl6xA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:27:02 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:27:02 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 9/9] vfio-user: vfio_user_device_io_set_irqs: prevent
 excessive malloc
Thread-Topic: [PATCH v3 9/9] vfio-user: vfio_user_device_io_set_irqs: prevent
 excessive malloc
Thread-Index: AQHdGQw7F4mwznNxzkKj/3V1FBz9yg==
Date: Tue, 21 Jul 2026 12:27:02 +0000
Message-ID: <20260721122643.30985-10-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 0c7ed4e9-f192-4146-248e-08dee7235e5a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: O5g79+rpsNyvod5YKJEDmQuqQGQJxAdybCQKwEJInVwvrPa5oN0RspP4nz7mtwCoHnL6RHPXcstIT3YJ7J8kZ/1rZ18R3hF8bZnM2SqZ2DtFMBcj6ov3kwvRboCNjRp466kbQo9igv62Skew89oanVZk4rMoJ79MJiBcyDEk7Wy3ay1fKSq9IdxSH+rJ64xAbs7xIUrqXKgvBqBpC8LMGr5uCAmHBLsaC/5PGnTEO58TZMDd0tiOCvgpn1eVEzLe2oCtnUZIVNhGx+pF4YqgxnWvmYM15+QaX5U5BPQzIltWh4YfczBF8B5NT/Nl40Dn5kU17w231MwP0y/I9RvSf8wLP+utSoqUXCv5ieAcqMtBgwpa1lAg0/6TEyoKviRv0r82MDQ5YBPl+zEvTBChaLaFGcwauh9jpGHnfV/7w4845MtDPLtj1DP3YKzLk1+9ky+HbAzpH9+B5y3DzGcX1YwJC5O0ApMY5wyejr57/TiEov/Vr6Iafae4jiaC61IqD4lvrJHQg2+EINcZvKJtZTaQnDbKUtBExVuHzv98rrofHWUGHsGf7Crk0Py0O0QEPCuOWVp6CakGA8XOS/fvlLBZB8efk40rTdDieMoAJMWVG564xwp9riByPd5e0OydoHrKAsDr5YdZTqTnPmkWNu8svC9+CFe7XnSl/uHOBAec1IoIgIvN/1cVRpqTFngmwzwhsjwrmhFx6j0A6cFL1RAb2PoL1MYkVXiVWiKv6Fw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rN/og+D12bVujjQcE5xkgHzQAKMaCJZ4wUj5/EGTxYqwiyNMcyetnEABwJ?=
 =?iso-8859-1?Q?v3MOB9bRgr5x3mzLd3XjWwsGi9srMklQEAnTRX3W6GbkrN0IclHnSQqavG?=
 =?iso-8859-1?Q?vSueV0XXmDMOgsphHIWOeUwQJs0xxxDgz9sSoRF513RHjxp6byGZanAcNU?=
 =?iso-8859-1?Q?ERF3My87RRWTb/FiGXXWmuQpMK/UBD+jp0pZkgiScFSH9jvayP4eU4zM29?=
 =?iso-8859-1?Q?hYZk1Wt0tJPgjvfvQYVzNkw0f4VDV2hK9P/cwNG+HGmD5NntFyFj5q+w0R?=
 =?iso-8859-1?Q?83jyXZnY5pjfarhX1qkl5KgLJhOjZEWC46WM42AfAFkITdJHv5GseLreQk?=
 =?iso-8859-1?Q?/Lmqd57He1CIcnqwTWoX722V4oaYGYUwCmwxQ0AOezhRlSOdd28dGk9cjW?=
 =?iso-8859-1?Q?nv3zCqausGYuimAr5fy8iXKCLmTi889HB/7ew+YMIXDZdvQVZIZ2o0TKEV?=
 =?iso-8859-1?Q?1gqDZkx0Ah9mb7dd+Evwyd9KBhTD30J7XwFsLzeRIzovu1MwnDKVuP1kuq?=
 =?iso-8859-1?Q?sgVu8OESFkn//p56AKgoPCeQDHpnxKe7OIJx81t7tFoaS6DVpOAbRv7cB1?=
 =?iso-8859-1?Q?dql8oWAp8potqE4vSaPP6XOflQ/KWrGmcQTUwdcnZ1lwQ3gh/oYLhgj7U4?=
 =?iso-8859-1?Q?HWG6OTGFFrEPNjFiaRc84vbftZG4al3/1uSVxT+WcCqsqTac3tnyW4FrE9?=
 =?iso-8859-1?Q?oeuMGjlfcFuCED0BtlYHUO1omeO5m7kLkXVfXLEfxygRt69eVPtzgsnHnm?=
 =?iso-8859-1?Q?GsFoXRAxS434dQQdOZVfaP3MQrk9doGNEAHwVOjEZ4SuC+hBFKnIKRyAYs?=
 =?iso-8859-1?Q?c5HJd3/IVb7F9eurC1SL3Ts0w/lJIlolWYwdiXRU6FFJhsv9pP826UHjVt?=
 =?iso-8859-1?Q?e5//XLmMnnyxRg0Qt/q4N04f2sicsYgJUi4Dh2NVn6G6GMY4o1k4werPOK?=
 =?iso-8859-1?Q?mFhDFhEiYgmK2/voZzygzDvARWBrzR/m2xB4QkuzjzgCaQDvNE3uRokYqz?=
 =?iso-8859-1?Q?IXM06fg2qBvhh43aL6se2AeFbHkEXrRfpWffqlcwXpMYtirNg/35GFpB/1?=
 =?iso-8859-1?Q?nXxGi3kCoPBQVEipl1y+WDuhGHU5TMj9y/FpbyITccqfmmbwVCfI0AGePe?=
 =?iso-8859-1?Q?MbTjj9zuREeSMitV8/1dNajxb0gSYD2RWon8FYVWsbnqY1QIEWx4BhlF3V?=
 =?iso-8859-1?Q?rRqG6iYz9Pc2vaK0LOj9+N7HTKtDs45hhz6ve79x9afJYeXwY/Sx2ywYof?=
 =?iso-8859-1?Q?/kovJvR+BqqKl3ZWbxOkaMSjN6sRewCUsmK8Ia7rYWhLhillElvtmPHt72?=
 =?iso-8859-1?Q?qCh4tJ2aWnvYa2dCD60/XdyiRLSonm4ePTcTQlDQcuZ3NSznISO0Xq+eTh?=
 =?iso-8859-1?Q?gBgVx4KqQs7s7R4AtNdNlLsOOTBpGqWxqpqs8crlxeoj1Jb7MwATVu8+CK?=
 =?iso-8859-1?Q?9qNV+I3Bkk/4La1zHwv5i9ip9Va+HarvfAK/pyv4fKypNBQnWRGqVmbrjo?=
 =?iso-8859-1?Q?YuXje8eZxZATIRyJd/HYYPr86prBLn/fSOZgsv1q8Rnkk0pJ3NZJ8cwic/?=
 =?iso-8859-1?Q?xX3c+UV8Ff4+ybN56VOSx2b/zIxVFRe9CE4F6+5KrP5R4tWxRxc1OeVFqJ?=
 =?iso-8859-1?Q?94FFzNxaFYvo9VaMWK96H7g2cZoFYtcmGLykNupblulWMHDoQJv6x5hAUX?=
 =?iso-8859-1?Q?pq61bUvEDcWaOWiRL9pG4bsHEO/UqVg8THrtxi+0qx0hSsxuRZRnI+ivgz?=
 =?iso-8859-1?Q?C+X7J47NhBIyFoTt6zE0klJGtmgk86KTknPIHVEWBBtZPfY4gsa+d+o1J9?=
 =?iso-8859-1?Q?jgsdib9smfNbhdRSm+yW3pHVm20Veek=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LU//bgMLk0VFgUO3YE2unUM8aSqi1EMFVYox2ucTdaxa78u8B3BLp72ZbBR/1r5YDX1SsCAdVF8TC9mpXuqMAoTo5t5YUv5AL/TvbciweECyQwJvoNDluiiZWGPQyp8pKzj4lFZ29L/FUpsXFhXw6CHX1BsSUYOteho5GZC/49ha/4etxvxD+GzwhMB14kPDJimLQCpS+tTIUOVQa8OotfyyuXAEsrWRBPhnJp/9hRQcW6EwGAFxOjKNHKVJfszXjtkJTZ3cLe8eptQ1nRmw1RMWzUDUrk209veZxjGFu9SChrFrDiGRyAAUgOq3kzb1GPWxk/3Zsz+YGFiKuBgYEg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ed4e9-f192-4146-248e-08dee7235e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:27:02.4889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdWCSlommNx1fwwOZEEcqipNr0EHQEFFQizUGAnAyjo/Qb28HLs3c5DNLChFfjbc0mrGyaDCo9ah76kaEQWqW5YqCE1Uden+PkOUCP8lkqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: uHF8CsQA_rj3MCYmtrpWq69aM5wJOc7d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX5v9t8L+7SCbM
 SWcSnwYjEQ77p+3fHHgPEYaR9j33fO3fIXAlN3W/7IMawez+APpKBpuQx6cie0GL1PM/ieVo0Mh
 FaRhTjp6jdkuw++vk7GFfQaIWhZKAlA=
X-Proofpoint-ORIG-GUID: uHF8CsQA_rj3MCYmtrpWq69aM5wJOc7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX7JQmUcaY41Yw
 Gv8IAzp/InAAXQYFSf1rRReBUnDm/39L6wC8zSY3CTDE05yHu2GuKtYWSWvkol+Tmo4pGK9/Pii
 eT6AcUwJ0F3+OzM1HwoQVC4R6mdvMlP8GZUbCDkXW8ELNq6s++dHv01MmbC0jPV9XDRb0+US4r2
 /P9+M9zfhja2jrxXNrB+n31VP9jqInHzQDMh6Sir1OszaxhhKXLjigfbndxt+GIRmvoi/elzCRB
 2odZF8u/mB+aQFrkl8UcibEqksg54URntD3wUYYrKA6saUE2VdHSumkafhpV2H1Iy6d0/4rkhML
 0zU/9OK9MEC9uNkaAcT708MeSTbzxRLdM+L7IZKed9FC68gfMX5TsFAD+lX9cmWihKQKEcdgQM9
 7oGHOCtMZd1d6Him321KuIzFEl+RzAABsquS0iNmv+d460ZbeqrHV1C8wzrdPqwUXCtl136nSRM
 6giGRt12H4oJdzbnUfQ==
X-Authority-Analysis: v=2.4 cv=Itgutr/g c=1 sm=1 tr=0 ts=6a5f6598 cx=c_pps
 a=b2ykEmuCBAXBKoHv9pAjeQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=64Cc0HZtAAAA:8
 a=QaGxouVv4pGw2sT49KQA:9 a=wPNLvfGTeEIA:10
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

This isn't in practise a problem since irq->argsz is not externally=0A=
provided, it's a good hardening step nonetheless.=0A=
=0A=
Fixes: ca1add1696 ("vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index daac0e21b6..1a01e748cd 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -297,6 +297,11 @@ static int vfio_user_device_io_set_irqs(VFIODevice *vb=
asedev,=0A=
             error_printf("vfio_user_set_irqs argsz too large\n");=0A=
             return -E2BIG;=0A=
         }=0A=
+        if (size > proxy->max_xfer_size) {=0A=
+            error_printf("vfio_user_device_io_set_irqs argsz too large\n")=
;=0A=
+            return -E2BIG;=0A=
+        }=0A=
+=0A=
         msgp =3D g_malloc0(size);=0A=
 =0A=
         vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size,=
 0);=0A=
-- =0A=
2.34.1=0A=
=0A=

