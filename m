Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65DC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526v-000728-1A; Fri, 11 Sep 2026 10:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jV-9n; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526R-0004Am-53; Fri, 11 Sep 2026 10:19:46 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BChKPa4141308; Fri, 11 Sep 2026 07:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ro+n1zxLLrE1H2CYr9lqAM6pcWTCrJuCwmebJrBVm
 eA=; b=K/lbHRpxieQSdbktTB6uzvIAxqZRv32G0YCGWgV73afQtxe2SZIGuu1G6
 Ik++Fk1ryRP9VareyxYxIEXN8Lw/2OzEDizpWZUVz31hvNWO+sZO5uIcVRew5vNL
 sM59ye+bIW0S/bXtARSXuRjTbWOOHAtZ+Gxlo+86CaXiEHy4Hh6ZIYqfv3FJYhNW
 izmE61v2CfTvBHMR5rtMZ/wBd1FMoKEc/rsqcAZezN2Ko2/9HU9uVbyNpCIdo/L+
 QDlS+b1PZPqaPnSkr8ihj49A6Ln7eZ9hTsrYSoaBn/O2GT81FCg/7xzKPYbQoDKP
 VlsHefYvqQWnO0KcvCa8/OKLk13Pg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022127.outbound.protection.outlook.com [52.101.43.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkcyvn7qm-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/+S2M8nmYFuWoXEzDwRDxIGX4SjsdTo8mkCin8l5uSFw8aKF9q0oLXh8vecgkqtVifpePpIXxqAeMgt3t2U8O3QCDFUPoOuHoVatl6nOGFbUv5yQvXmT8i0IA6icr6x3uoaiO5ZBHn7Y7Yv9AaRuMaxJhPDFwf+HfkuKA4FJxLB1mbuNgv/aGsBlc+2zE3ePTZ/T8kf5ooNq9P6E/zUPRQHpIQYRwdUskSowJxgNXBBRziySTlTO3iqd2B5hkx9EPXuyOFoB/AbPpJ8D7Ou3EwPZktRMSjp4wKVpHC0DqoysNw58pBiMzpdM9B3sZDeoi6M/xfY6XBq3JPd51/Fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro+n1zxLLrE1H2CYr9lqAM6pcWTCrJuCwmebJrBVmeA=;
 b=W7aBC1+uz2xsJZRjvICkzlQKjQVleEk7iZ2d5DzrPKIcOtJrpUffMdgq5I+DfePvWvhDnDP0H19dbw2OxpknIyWyORUsOn/QqQxF9yb43Q5poG4YiK2WjhMpZEb0LVpVB1P+KAuVAUow1URCfQ1lHnAj+SSl3boaaD8GhZ7jlJxFmui/AAuRsXKsO6y2WplxVnFZk0UbSudpZBtwysxMCjwsTTeg1QrOhlrU4f5VzCKhQ3AU26y0T7qnBxAVqfizEHHuDZwRDrdV/NcLFmmX9/QJXsT6WsXNlSSBvKat74YYC5DIe2gN9IGqMup9PnHWWVfVXavi0thTCGYbuvPCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro+n1zxLLrE1H2CYr9lqAM6pcWTCrJuCwmebJrBVmeA=;
 b=bHRZmk8WzPe/E2e2+OcmMopwyjVbVZGFxX46HbnCYry9pl2yPzwjpY89Q6sHrG0OCTTXHWXPrb1+hI7QSSokHETdzlSFC5PGtU54NTJvciy7V+utds1meQD8sZG2gwW5Bqq8h2sm9Bo9K7NyY/69AhNRD7j8MfhV+Fii7mZXhQkAMbnDi0fqmhhmBJOguCvwlYs5mkr64lPMlMwM4caJMHjUQX78cqx7V61QRb4YQe3brOx+Esi+kkHhnvSqL6eLHhTww4DudmJxh6EqTcVCgZj3fNn4oAPhsRbEISc1rvSu/To7Eb1xEFr1jWapjvwmMFXaPe9VvuzQXyxrONQ/Kw==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:35 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:35 +0000
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
Subject: [PATCH v2 7/8] vfio-user: implement mig_data read/write socket
 operations
Thread-Topic: [PATCH v2 7/8] vfio-user: implement mig_data read/write socket
 operations
Thread-Index: AQHdQfiRWBCpA4GGm0GZd/DTGMqnXA==
Date: Fri, 11 Sep 2026 14:19:33 +0000
Message-ID: <20260911140710.2348139-8-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: a71c7146-a301-4cc7-1bfa-08df100fb49e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|3023799007|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: ekvwOAdFKxzXtbiTjqzIVmuqrxwBqiEu89gbg6gOIIr44aGJnKVHJw+Tt2Lyq03zhF3PMylMrI+o2g9Adac62qS0gsM5jktsGKsPIxdE7KFFvuDHSQ6fudaSdrVX/3Gdky9ww+NEzUE7wLON4MyrNYoSy1wdhVhFaBvjF+jV0T8lG8pla8xDAo6fx3C5XZqMk1xPzau3H0I3IKkstYQE4+pKEfaztbCCHIRspUQoHjFxSALLDVEEL//3Oh4XbowViBnyFIcMn5HxYDBK5pukLqmkpitKHd5WYYs/qECgCWxOtL9cG1OVWphhmoWQZ3Wne32+86V2d5ZLGWDlKwAFjyrv89slE5VxUWp+rBSSnec51USzxq8Xo9LEzRPHBK8or2OCa31NK95zxgqMULSxa07rxBI4tib9d8yocZ6E1/kQumW4VXsGclskI75+ObwKFJoSGlb8EGWyGd86uuROUkzldpedMFqelCng+dK6psOkVpe+TyD69CcYPJxWOxX3lnZY2K/uQQ0hqcTrSFdW77wNyUdxFrGI++ci0o3GVOMIsM+T2h/YpvKIBjAEtzQgxkZdOPDjW5bWPHYAX+Q4q1ausr5gw1P88a0ZhHwouVmxBqAImkvUr28RZzVnV3X2GqxessLUVSGLS4gEGljBsl0Lilsa+YRXb4j60kNLPPx9LA8RkLQggGQA9go1demApLY/2rNT5Z8PpiJMZeOhj6XBy4tUpSyXiW6JFcNQ0Hs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2M59pLjTqxyi6Gw0z2fEzW/QoYq1fCOfTPM7qOXs5GM93P2bXnNsgORwMz?=
 =?iso-8859-1?Q?XUhWdbPLAvTruFB3qrSccS0X9/xdsnqTMJcLpeP84KCIugZiTwjWGvGt2n?=
 =?iso-8859-1?Q?jlZzqSZ6I5OBugioYhhkjt2bFEbJkuiH0DkDAJq39B3vCdUjTL6sTsHEdS?=
 =?iso-8859-1?Q?tqWHoydtXtI3eCccb1M+5McVD1uDctRS7P3gRXpnJPCZW+CIRWdXenICZP?=
 =?iso-8859-1?Q?ydpNjzKdnugB52Pke/IspK+7xIiYBnyTyef8aEwBHnp09Bm8STc94r3N3M?=
 =?iso-8859-1?Q?mGTRogPWvTVyXxCUYLD4jlnKCj506e1YLwckwYste6CgnkRn8xfDFt7sN4?=
 =?iso-8859-1?Q?HCcc4h3dzDcCar+g7mUru1R+2dLSdx3VgZCeq+pzmaxOrr7EhM4pUVlrDU?=
 =?iso-8859-1?Q?ItbmFBnQbmjhdscq6E4M5drzK7WWiP5nS332TODrIqcYARi5DWJBwK/Zr5?=
 =?iso-8859-1?Q?fmLEMDv9r/olUjh1D5Do88yoFg16MmSLioR3K6zBF0D19bBs+8mG7Xu5+N?=
 =?iso-8859-1?Q?RE/Re+0UtxVk+/ZTnkP1pveSyAQ8ZGPxwh6S2FnHwFALIDm9FguX+166kV?=
 =?iso-8859-1?Q?7Sj+xqcLNmY9/CSeMUTn30rF4tT6eFAqry8kS6z1cAG4puK2mlsacTzSXc?=
 =?iso-8859-1?Q?BcDxdaBPJgu8few8NQxoqVVH0EFpm82YDnsyAPO9HCf9mSwrV/xKd7a0UA?=
 =?iso-8859-1?Q?/Ua6qK3hOJb7LNeZE9Vr5lQUvZCEzSGjbKhvXecfX2WpSn4EiubqlU/8AB?=
 =?iso-8859-1?Q?JqGnUM8rsk5gHyO6XsyvUfigUod9Ki5wvFL482vw5xGQ8hmFxoJpKPNjSd?=
 =?iso-8859-1?Q?Wzc5bWVfdAmXvGcjAA4mLVk0JsZY67FwlH1fR/lvYlG4p2LFdgyu4ZORfX?=
 =?iso-8859-1?Q?W+3bnk2PRKizWOJbbfe0hslW5yua/4WRDNCu50HWKA8hEwK1cWI4jMvBJI?=
 =?iso-8859-1?Q?cqPDzhdW2fZW6yc5jRJS1zlIUC8Wx/OZo+82N1C7ZAXWd0W4stmO7pt7G5?=
 =?iso-8859-1?Q?yn27Gg3d92Lv/qCeGvbtaeaYpiN2B3Ur8ju5yxNczbdGT+TDtZeZfox0Q8?=
 =?iso-8859-1?Q?6PQh0D8gi7x+WnSMRtoHz3sDA5zn+P09xSaP3W9WQ/UL+lsq0NsvBN2FFr?=
 =?iso-8859-1?Q?GX1r6vgQROBfp+oT22oVd/C81N00tdE59lHhx30XZ6j8v5odNHWj9TN44+?=
 =?iso-8859-1?Q?U0psNvzG4OtaeXa5OG89C1jJcJhGjSx2jH2fSlnb3KlegTM+1un3fISKQ7?=
 =?iso-8859-1?Q?H3L9Lpff65J+RmqetrOavOFZyLGdcPCvaXh8aNFtSD/6DIYwT05MdNm1Jv?=
 =?iso-8859-1?Q?rJXEhRblfbM2OS6UrqhnRIk9yWNF3WzTw5UKwHLa1dllR1Rx2JDELg1qBs?=
 =?iso-8859-1?Q?5rjbSn9phyWXrntbrHgQbtGczlwVYPx2ohmaj5j7JMxJl71cnXFjuw80b1?=
 =?iso-8859-1?Q?jCTGSs7741p+foandnKOZ4kP7KBnjHPUiphJpSlQbdPDSfUAvK1IusqBU8?=
 =?iso-8859-1?Q?CY1yiKL4MQu6QiUoDtU6LkQGyCXkA0Qf+Uxap/2NkTiGsEGVtdlgNTzarf?=
 =?iso-8859-1?Q?lO0PF1Yytw9qhrSaOXkFDlkR6OeRRPg+Ts/THPOjNKRQoDeIP9i1rtnPu0?=
 =?iso-8859-1?Q?qx5R9Uh8b2I55jQD0FkAQaLDKc3JKYdwi2Vse5RzAq8HF76v0yW501ex5H?=
 =?iso-8859-1?Q?ColIJ5g8QHxTs6WuxpyT/fEjjbpzDJ6/VYpz+Gt9rkZdNzRE/+8bYZsOK/?=
 =?iso-8859-1?Q?58NEiZpWWKNRsfJng1Ao9PfcgdIYsNIKmjGB8zz3j1OTgmVdAVRz/Ma/ci?=
 =?iso-8859-1?Q?gZM0mtp8BjQqexdDliedLd+AoHcNj7g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ADhrBpyW6ajs1nqzlqiJ0dyDNoz00zh9UlrRr5bAlBqjcmuNDGb6CpBq7wQ4TanPRCnUavPYdEMrN0hkeuscRi2WpxlQGKFPUL7nvjtEvMiyYYLue4e0F5VraUh+ETfOtnF+jBkuZ57uLM7knHfPXy64pBFblmUN0StnaXXNax9LwZ6qQLd7LS5wal9NfehSvpZW4Q8La2fch7t2tuJIW8K1ZKPjYc9z1tS0BAGfo+cxEqL6MO6J/DR8NSvpam6TiTxkdDNF2g1kzrXJJvtmWDZcUeUrNxZiMwEU8g5ya3YMc3ZndbBc1iICagoV0KbR1GXIHlQ0+Mx2FA28zVBBbQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71c7146-a301-4cc7-1bfa-08df100fb49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:33.4198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/XY1WU0ujgctzcGCz1/K7ZSlS8yHacTx0FkUpNf9Yf6+jgOVNeVrBRS6DF/5g4SI2giELR/p4b71ydewTZsoTQHPvxtS9ftYiy4v1dTuA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX+/BXlh/EXhT/
 6+D+aVJj/7Ah+quiyqYdP0j/5K7Ci0+rfZnFvcBAOOe3JOnwPW4I7NhjH7f7uSiUkMNryAkfFmA
 Nb3XGHl4IeyANPbXl6uFrBjsshBhk5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfXw2/s+ENT0VKc
 vBKLpEF1nQV0HLf81bSSyp17JLbKI9Q/po505CwIs5BKQoyTxd2JkXQL3SIRZBJWVH4tSBCQTh4
 mqtoksb6+pJ3Eobq4amEOlH2aUNYoWSpaH1voC22gUlzLF5meT9WL/PecEh0v8eRrimulEKa4Kx
 gSAJKmZux1mB7FUi1OQMNnNiNRwGkzRjv9Mts6KqgMuiTw+Uy8TQeFwlRTqsPHSAlWmO3kJHfQs
 Boq0su6T6PU3afpeNvroiNv5lzjzpbZui4Adh3XvavTi4cw6odGeskxBQCQ8obdwllJDnA4HkVv
 nwVsex4Ipovk4wKQDwgXPRF0KkWdTCaNnLiqkFxpCAMNlEU/r1mtpDps9kuKit4wCm5pty7MtmJ
 7H2qsU5GAdr+l4HA/O+BIg2FBOwDC+3beYvSmfdIHlg/f6ffY0iHueiIFRjBrXnUzuUT6SOOY4o
 j0O1ppul2YAduPO5Xfw==
X-Authority-Analysis: v=2.4 cv=Ae8kjHXG c=1 sm=1 tr=0 ts=6aa40df8 cx=c_pps
 a=/+kXZUEK7Fsqfsk0sF7w8w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=64Cc0HZtAAAA:8
 a=IEzzBjLDI9UtbpY5370A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: CDPYasOihDH2m987JQMzaNB3vXoWHp4V
X-Proofpoint-ORIG-GUID: CDPYasOihDH2m987JQMzaNB3vXoWHp4V
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

Implement the remaining vfio-user (socket) migration io_ops:=0A=
device_reset, get_precopy_info, mig_data_read, and=0A=
mig_data_write_from_file.=0A=
=0A=
Add the wire definitions (command numbers and message layouts) to=0A=
hw/vfio-user/protocol.h, mirroring the kernel structs so feature blobs=0A=
can be copied straight onto the wire.=0A=
=0A=
Co-authored-by: Rafael Castillo <rafael@trfs.me>=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
Reviewed-by: John Levon <john.levon@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c     | 118 +++++++++++++++++++++++++++++++++++++-=0A=
 hw/vfio-user/protocol.h   |  19 ++++++=0A=
 hw/vfio-user/trace-events |   2 +=0A=
 hw/vfio/migration.c       |   6 +-=0A=
 4 files changed, 140 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 078fd8f2a4..6b767e94d3 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qemu/error-report.h"=0A=
 #include "qemu/lockable.h"=0A=
 #include "qemu/thread.h"=0A=
+#include "migration/qemu-file.h"=0A=
 =0A=
 #include "hw/vfio-user/device.h"=0A=
 #include "hw/vfio-user/trace.h"=0A=
@@ -592,15 +593,126 @@ static int vfio_user_device_io_region_write(VFIODevi=
ce *vbasedev, uint8_t index,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static ssize_t vfio_user_device_io_mig_data_read(VFIODevice *vbasedev,=0A=
+                                                 void *buf,=0A=
+                                                 size_t buf_size)=0A=
+{=0A=
+    g_autofree VFIOUserMigData *msgp =3D NULL;=0A=
+    VFIOUserProxy *proxy =3D vbasedev->proxy;=0A=
+    Error *local_err =3D NULL;=0A=
+    /*=0A=
+     * We don't need to iterate in chunks here. We clamp the requested=0A=
+     * size to the maximum socket payload and return a "short read"=0A=
+     * (fewer bytes than buf_size). QEMU's generic migration framework=0A=
+     * handles short reads perfectly, and will automatically call this=0A=
+     * function again in a loop to fetch the remaining data.=0A=
+     */=0A=
+    uint32_t max_payload =3D proxy->max_xfer_size - sizeof(VFIOUserMigData=
);=0A=
+    uint32_t read_size =3D MIN(buf_size, max_payload);=0A=
+    uint32_t msg_size =3D sizeof(VFIOUserMigData) + read_size;=0A=
+=0A=
+    /* Clamp the requested size to the maximum socket payload */=0A=
+    msgp =3D g_malloc0(msg_size);=0A=
+=0A=
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_MIG_DATA_READ,=0A=
+                          sizeof(VFIOUserMigData), 0);=0A=
+    msgp->argsz =3D msg_size - sizeof(VFIOUserHdr);=0A=
+    msgp->size =3D read_size;=0A=
+=0A=
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, msg_size, &local_err=
)) {=0A=
+        error_prepend(&local_err, "%s: ", __func__);=0A=
+        error_report_err(local_err);=0A=
+        return -EFAULT;=0A=
+    }=0A=
+=0A=
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {=0A=
+        error_report("%s: server returned error %d", __func__,=0A=
+                     msgp->hdr.error_reply);=0A=
+        return -msgp->hdr.error_reply;=0A=
+    }=0A=
+=0A=
+    /* Bounds check: Ensure server didn't overflow our buffer */=0A=
+    if (msgp->size > buf_size) {=0A=
+        error_report("%s: server sent more data than requested", __func__)=
;=0A=
+        return -EINVAL;=0A=
+    }=0A=
+=0A=
+    memcpy(buf, msgp->data, msgp->size);=0A=
+    trace_vfio_user_mig_data_read(msgp->size);=0A=
+=0A=
+    return msgp->size;=0A=
+}=0A=
+=0A=
+static int vfio_user_device_io_mig_data_write_from_file(VFIODevice *vbased=
ev,=0A=
+                                                        QEMUFile *f,=0A=
+                                                        size_t data_size)=
=0A=
+{=0A=
+    VFIOUserProxy *proxy =3D vbasedev->proxy;=0A=
+    uint32_t max_payload =3D proxy->max_xfer_size - sizeof(VFIOUserMigData=
);=0A=
+    size_t remaining =3D data_size;=0A=
+    g_autofree VFIOUserMigData *msgp =3D=0A=
+        g_malloc0(sizeof(VFIOUserMigData) + max_payload);=0A=
+=0A=
+    while (remaining > 0) {=0A=
+        Error *local_err =3D NULL;=0A=
+        uint32_t chunk_size =3D MIN(remaining, max_payload);=0A=
+        uint32_t msg_size =3D sizeof(VFIOUserMigData) + chunk_size;=0A=
+=0A=
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_MIG_DATA_WRITE,=0A=
+                              msg_size, 0);=0A=
+        msgp->argsz =3D msg_size - sizeof(VFIOUserHdr);=0A=
+        msgp->size =3D chunk_size;=0A=
+=0A=
+        if (qemu_get_buffer(f, msgp->data, chunk_size) !=3D chunk_size) {=
=0A=
+            error_report("%s: failed to read migration data from stream",=
=0A=
+                         __func__);=0A=
+            return -EINVAL;=0A=
+        }=0A=
+=0A=
+        if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, msg_size,=0A=
+                                 &local_err)) {=0A=
+            error_prepend(&local_err, "%s: ", __func__);=0A=
+            error_report_err(local_err);=0A=
+            return -EFAULT;=0A=
+        }=0A=
+=0A=
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {=0A=
+            error_report("%s: server returned error %d", __func__,=0A=
+                         msgp->hdr.error_reply);=0A=
+            return -msgp->hdr.error_reply;=0A=
+        }=0A=
+=0A=
+        trace_vfio_user_mig_data_write(msgp->size);=0A=
+        remaining -=3D chunk_size;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int vfio_user_device_io_device_reset(VFIODevice *vbasedev)=0A=
+{=0A=
+    vfio_user_device_reset(vbasedev->proxy);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int vfio_user_device_io_get_precopy_info(VFIODevice *vbasedev,=0A=
+                                                struct vfio_precopy_info *=
info)=0A=
+{=0A=
+    return -ENOTSUP;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Socket-based io_ops=0A=
  */=0A=
 VFIODeviceIOOps vfio_user_device_io_ops_sock =3D {=0A=
     .device_feature =3D vfio_user_device_io_device_feature,=0A=
     .get_region_info =3D vfio_user_device_io_get_region_info,=0A=
-    .get_irq_info =3D vfio_user_device_io_get_irq_info,=0A=
-    .set_irqs =3D vfio_user_device_io_set_irqs,=0A=
     .region_read =3D vfio_user_device_io_region_read,=0A=
     .region_write =3D vfio_user_device_io_region_write,=0A=
-=0A=
+    .get_irq_info =3D vfio_user_device_io_get_irq_info,=0A=
+    .set_irqs =3D vfio_user_device_io_set_irqs,=0A=
+    .device_reset =3D vfio_user_device_io_device_reset,=0A=
+    .get_precopy_info =3D vfio_user_device_io_get_precopy_info,=0A=
+    .mig_data_read =3D vfio_user_device_io_mig_data_read,=0A=
+    .mig_data_write_from_file =3D vfio_user_device_io_mig_data_write_from_=
file,=0A=
 };=0A=
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h=0A=
index c478d1353f..ed32d73051 100644=0A=
--- a/hw/vfio-user/protocol.h=0A=
+++ b/hw/vfio-user/protocol.h=0A=
@@ -41,6 +41,9 @@ enum vfio_user_command {=0A=
     VFIO_USER_DIRTY_PAGES               =3D 14,=0A=
     VFIO_USER_REGION_WRITE_MULTI        =3D 15,=0A=
     VFIO_USER_DEVICE_FEATURE            =3D 16,=0A=
+    VFIO_USER_MIG_DATA_READ             =3D 17,=0A=
+    VFIO_USER_MIG_DATA_WRITE            =3D 18,=0A=
+    VFIO_USER_GET_PRECOPY_INFO          =3D 19,=0A=
     VFIO_USER_MAX,=0A=
 };=0A=
 =0A=
@@ -251,4 +254,20 @@ typedef struct {=0A=
     char data[];=0A=
 } VFIOUserDeviceFeature;=0A=
 =0A=
+/* imported from struct vfio_mig_data */=0A=
+typedef struct {=0A=
+    VFIOUserHdr hdr;=0A=
+    uint32_t argsz;=0A=
+    uint32_t size;=0A=
+    uint8_t data[];=0A=
+} VFIOUserMigData;=0A=
+=0A=
+/* imported from struct vfio_precopy_info */=0A=
+typedef struct {=0A=
+    VFIOUserHdr hdr;=0A=
+    uint32_t argsz;=0A=
+    uint32_t flags;=0A=
+    uint64_t initial_bytes;=0A=
+    uint64_t dirty_bytes;=0A=
+} VFIOUserGetPrecopyInfo;=0A=
 #endif /* VFIO_USER_PROTOCOL_H */=0A=
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events=0A=
index 35341994c5..51abd4d738 100644=0A=
--- a/hw/vfio-user/trace-events=0A=
+++ b/hw/vfio-user/trace-events=0A=
@@ -14,6 +14,8 @@ vfio_user_get_irq_info(uint32_t index, uint32_t flags, ui=
nt32_t count) " index %=0A=
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_=
t flags) " index %d start %d count %d flags 0x%x"=0A=
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) "=
 index %d flags 0x%x size 0x%"PRIx64=0A=
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " regio=
n %d offset 0x%"PRIx64" count %d"=0A=
+vfio_user_mig_data_read(uint32_t size) " size %d"=0A=
+vfio_user_mig_data_write(uint32_t size) " size %d"=0A=
 =0A=
 # proxy.c=0A=
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t s=
ize, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"=0A=
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c=0A=
index 257f9253aa..adf451b772 100644=0A=
--- a/hw/vfio/migration.c=0A=
+++ b/hw/vfio/migration.c=0A=
@@ -313,8 +313,10 @@ static void vfio_migration_cleanup(VFIODevice *vbasede=
v)=0A=
 {=0A=
     VFIOMigration *migration =3D vbasedev->migration;=0A=
 =0A=
-    close(migration->data_fd);=0A=
-    migration->data_fd =3D -1;=0A=
+    if (migration->data_fd !=3D -1) {=0A=
+        close(migration->data_fd);=0A=
+        migration->data_fd =3D -1;=0A=
+    }=0A=
 }=0A=
 =0A=
 static bool vfio_migration_check_overflow(VFIODevice *vbasedev, uint64_t s=
ize,=0A=
-- =0A=
2.39.3=0A=
=0A=

