Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5914C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526r-0006zp-Gx; Fri, 11 Sep 2026 10:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jS-9e; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526R-0004Ad-0b; Fri, 11 Sep 2026 10:19:44 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BChKPZ4141308; Fri, 11 Sep 2026 07:19:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HXgyYwzVL7A6g2JnX4s3e5ZItrY0sggvfib2TmVd1
 CQ=; b=LF/qswny3sEB9iZnEcQM2LHvSjWGZsXgMJyk9c+MeljNXZd1VThnr9KBN
 hVNuB0zmelC7/1yjczVr62dTiWtGxK8CpOMHhXoUsP8LbzxTuX0XfROhsC0CX52S
 WAZyBXwsQiG1XVgQZXWk6YlAecBg5S5S4NlkdeQdHAbkMRmyAsnu3KbZ4xy2w7gl
 4DCpJ9NrBY9d1DD0dAOB490Gbet6Omt3ZnrevFz+SKAWqS3F8Eh3l++Z5sn/FJ32
 cKcIowOU0QdKs3E8P6/ZpoEwpqJhpwQr7nc3+F5rxkfmmt4e0+dRRv2oSuzhDUMd
 V/6fMpp84dwOkUtcZ2bly8T+KqMVA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022127.outbound.protection.outlook.com [52.101.43.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkcyvn7qm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkPmQcL1FKM1RO76W/SLMXbbavPI41+Pc048x+UPRyVXwHzAoKmPSIfjewgwzYh+zAN+6AD59MFuHSJ485ClXOzFy8cybNTF/bxxryCazRWotuS64rOt/2ruNT39HxcOa0j3vPaSbeGCQprnCqRIr+C6h8w+3ZWmPaCyoQB4z9hdpaIeSvAyJHOiJ6UYpEDgf5EUr+XyOawi0k4NSw9xeHAjm+N/9rby6RY65necWBsXUUmNz3KDq6w9eIafIRY0ZzBqJefd5IaE79Ny/bGLshPcxLoNnyiTFQsLw22z1XaShljW4Bshy/iT4NiYs9YxtToPrFfWMN50Wg0/fLnc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXgyYwzVL7A6g2JnX4s3e5ZItrY0sggvfib2TmVd1CQ=;
 b=Z4nwo+pGGtTCDwWvk5BAGfDMmKzo5d7tMuVBG1LHN9VPwQC2IwdIgtrdxAI2y0NDwivNwMKfQnAaYreGBSyHb5ga8bIBQIw7MrCezAYZh8Kvl/DRgZxaiDbIfi+Bv8fATPBgotpGhg3iRtYoDNcEzjQEdf69MtqYdEi4F7msqi4WpSnLEuM754X+hWbp9EhthhXoShTY7MUE9JZmqt7WemYMiRbDtJzTDu/DG5odlmBIvLfZ4RiRe1NeLRFXlCCTziUc12JfBi5esce2IrZKSmFeDyLsFO6UTIwbRI3stTs4WPr0+4/RoIphD3Q/oHB69+YLNTva/JeY83cfsbL0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXgyYwzVL7A6g2JnX4s3e5ZItrY0sggvfib2TmVd1CQ=;
 b=YdPW4dt7afwsiesbPYjfByt0O0bFXXDrl5YlwU6xO0YZ9byYOv/TtiUxyYz4MVwiOTx2igSqzz5v+snsEasvmU29dlLu/uyMxI+Gzhb6Ego8tPQZ7wpbLSy2LNUJRjsP48Otch205OzE0hL2b6j0I6eS1vUkzpaAGcYcQBQGUe8xyZb+mODpXkTBCDxcuFcu5AGQmR1Isk2p2WrIgE6AEJ4gtHTARP7sgUpi+tcn3oCoWQaWi1diUyZh46yRvQejF0wusTGV4GzZ9ODlYMVquBa/JQ63A4kg4S9otyhXYe8rC1k3NopVi9ErHu9mHR4c2oeiJ/201mMplgDuvCSoYQ==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:32 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:32 +0000
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
Subject: [PATCH v2 6/8] vfio-user: enable DMA logging for dirty page tracking
Thread-Topic: [PATCH v2 6/8] vfio-user: enable DMA logging for dirty page
 tracking
Thread-Index: AQHdQfiQgIvRT0MhSEi/dBXbR1OtnA==
Date: Fri, 11 Sep 2026 14:19:31 +0000
Message-ID: <20260911140710.2348139-7-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: d76c1c07-eb2c-4acc-da22-08df100fb2ce
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 0BqXHQxyURYpNK0AF1iuxKoOWjn2ItUw12ayBUqxAAHqNaArOVkTC9PsF1lbARyv787sOeps7tX+uOdiSuPuezBJRQU8/k/OyDEmz0AgIUiufoId7dkX1oQ2tJ3YOj+434RNqvezpu9t33IJuqVfR0Z0cB6NPYjZNPTI4itxzcNKKIaEoi4RSPfH8nCdQpYeyALZv+TVJSb/rk6c023Z1UDvYjvNB5GLWrOiSH7MFnUdghzfkO2Uc1C8FXwdtQgpnyamrni5v8jvg7tI7/SecC5dSYOKbEmRdobNraBiSI/IsmJozlVVZf8MJb2ekqqe909WoCV5/ccwvminQCP8LwH3LfG19TkHPodoVjRWILSgeoXmOd53147U0YPy6M9bare65vTlwij4hBo9jYzgNSLS/qpZRJw172w4GBp/VqChYFrhxh+cVeZ8uTdTRMSCAhmZ7G28F0U0AqHaeCXIUqEzpFn9L4DaAJTvMim4JAqnU5LmTX3Cus9EqZJVsRTEF8AlcH4LJyLsvCizBMUDh/GoCG3b+gtLoeON3+BPNZhxzRHzPW/ro++xFM3bqDaQyAx2I3OCBHy7vHlE9F9K+Avx8swF7AIpH6v+tkIFtpfzfAi/DbGNfSy40j96EJu7R5Idt2mRssk/uX+xSDKe0neUW7gFddl3SPGuV675tECgiOtck0cvqkWfm9x/CS5u4i5yCNd1tFaF5jZebV8lFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?89Tvm3L50CKiJBBwbPU00kkSImD28To+ysX4ujKTKd069Du0m3vbPhVNBG?=
 =?iso-8859-1?Q?D375H1kld/UxwA9R9bhbal6mEShSXLms3WqH+qxDACTC1ZedFQ+gH1yEY6?=
 =?iso-8859-1?Q?uKsvlqfGEZQxE5FptGYsA4JTvUFz8apYqLLQ+WmkmxLoGbjhXS5SjIl0Fe?=
 =?iso-8859-1?Q?3+JH1oaFQBfxj10ORRwcGIYsPWVZdPfBs8rjuM/8pe4DI5xEa5A1reKc9W?=
 =?iso-8859-1?Q?I8BdGxOaErpqC86wB6wS8/3n7HoJomrEAvetrxGllMoXGJ2/vyedRPuE/2?=
 =?iso-8859-1?Q?0PEW5ep0AHRgxqGGdQlo6DTWvJ6OpLgIcXIra9hHH8HodZl54fdTbFJ8mY?=
 =?iso-8859-1?Q?KoNRB762JD7aRqmRoGAwa0mPNZTe6cawxA4kQiGO+j6XgPFBmqouXagJKu?=
 =?iso-8859-1?Q?ji4oUjrgehxwf0fLiATdxehuBxoSxKCtI8SKLjUihaONyllvyUdnHVbDZz?=
 =?iso-8859-1?Q?kIv+YDrIjqNMtWCnp5aqRqhiL8ukVVnfm8KmooDiEXZ1F/WNS8MJUkRRnk?=
 =?iso-8859-1?Q?NsunML0MyBYfgrgc25QLFqx3PdJVvN7qPGvYV4GYJgGArE/S0Ou/qow32H?=
 =?iso-8859-1?Q?b81a8P/gVPvi/Hxg6XKXaQmjWeaSkXI2ld1yTCJURQNnJi/Xnif0qkyBk3?=
 =?iso-8859-1?Q?BxYHVgAQAr4CRm3X5/uyh/PIEqUiiMDrE63z0Lx1+/IMg18XEt531zppnA?=
 =?iso-8859-1?Q?u3h4P+51J8BHrT1qBwdgvndDB9Y4qOP075frW8HxGR7hHfwVpUujeKa37I?=
 =?iso-8859-1?Q?Oapn5/VCjLZfo+AmEM4/jjBdO6Xt2yoghtofg/539elpo5JhTL1IemJVVf?=
 =?iso-8859-1?Q?eFW9JtceUZyv0vNcjMdIGhE+VeJkf63po2Nrp0+WDs57sinGWsERuVKzq4?=
 =?iso-8859-1?Q?iFegFSBYYCDUcUOJ0POBeG5x2iaLN4dyzRWOhVohtZEkAF/qLI8MIFqjEx?=
 =?iso-8859-1?Q?ryH1lJNZUggUSFw6W9aEJmsEW0mhXmu51T8+IJZZKtjlcS5H02jPJx/XyP?=
 =?iso-8859-1?Q?SE8eoa52sRliYiYvP9Z6nAuJ/YtHmXRXPSE9PRP+VIET3rkVLfxyqG4pOW?=
 =?iso-8859-1?Q?MlFLEdCVJH10t6pkO/KHPjYHee2rfXLpG8F7mC/uZEjt4eYXgw3Z4qzGh8?=
 =?iso-8859-1?Q?GffN4dGLTfcY2+JWeSG49tCFtAxVD+l6PigtY2fQTQRnBbJ4FQVUPVUSsH?=
 =?iso-8859-1?Q?yXq+udTkICN6rwY2R2SY/PMxAQHl6kqWR8xJMUrZR9r8I2Dap5Ma2aENy4?=
 =?iso-8859-1?Q?l4jnhzH01VPy+LYaErFi2r/yqJrC3jQFyl95TJbb+yig+y+jRZLLpiX/vF?=
 =?iso-8859-1?Q?ChSzMR6AbYrjSkKgY886amiWGXJTzzNFPLQvZ1YUawH5LHjchlIYbQx16+?=
 =?iso-8859-1?Q?2iGHSeD3fyJS3aQ8Q2LdbCj5XqgirqpinGjqpFkJLRu2tgGP6zKYldXnl+?=
 =?iso-8859-1?Q?AIpHXG5sxZp7XPle8xJFqs2I3Ivg6kB8E6o2mSXhdQXt53WbTYkC1ZfKbj?=
 =?iso-8859-1?Q?f/HoPDlkNbqQmBq+Vu80AkDqWOIYvQH32SJ5vWNvKNIbZt5BJM0QvvX8Cy?=
 =?iso-8859-1?Q?pXs00uw27IKmPha2Kpa0zpNjeu6kRaULV+iNBDE9vL9A8staHH6X07YPa/?=
 =?iso-8859-1?Q?hlS98p3TKXdefOTU9pt9f9LLusELcd2/zLGfdba4TLrsutztLYtLwAoIwG?=
 =?iso-8859-1?Q?FMABwzU9ho+1NpKcJxwy/5Ca5hpbcSi8T7MHCtUl1DM06s6HuLy65qK4SH?=
 =?iso-8859-1?Q?RypmijJjmaVN89+HBSeO3YiQMECiXizBwziMUnNNaUHaZt2LGcfiTOeYnp?=
 =?iso-8859-1?Q?F6T6D7NqKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QKOSBailKBZSGfuncsP7x9Sfp4HuIeAFUHbXfKrF1aihb2G4Yt0vXwwayVtwC553yGT9lUJcIm3WJqKRkPpffwwWbYv3PPuHgkAVISpUetNSZKzjsCXft/p/H45zUAMH4F9jVnXv3zRS8rshZiqO0vRDILGM29qCFGu6proA0V7/mPGc/apimdBbVXysyTlVErmAFPpfj9/q+ub9ZXtPaFkO0xA+KxeZOCXVB/x92Fm+kJcy5ogbZs/5NB3VOYUu3kHRpfMk1VdRuz2p/LbS1yTQuBABQn1MR/FnMpFMHa+DxIhfhNDDccdWBRjNY5sjLlQfTp7bQ70I29c8ZuLKiw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c1c07-eb2c-4acc-da22-08df100fb2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:31.9725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VR4iOLZj+hMj1qhC74yWD8PVjGTFmChGuZFzdYKFu5wX57GZGKmgzvPAAyQ7qr5nvZnOecTJmAr8484VnDNgV9b542YFE8ed5F9VV6hpgFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX2MCytFRfDupO
 6xtPqeNAHlvGnA3KhHL8KCMMqkNtLRY+r+091ENxQkRsdM30dNp8wucpDukZjHQbE1TaSdxHzvY
 Kq3g68NrnpeWciwgyIKwBNGmiYVsfAw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX5etRodNbuJZW
 KJqUzwFmg9BypO2+h/MFfTP4n7OyuuoWDTa/CK/1M+spi06ccHfPBdBoT2eD2BCIHU4LdD3DUYY
 RZI8TUgm66awOXMyhweV4e+FSPhWZdI3Iy45RQShtv2zU85HWqTZrhbHMI4g18egipuWjJI3Am5
 K7s+SW2rSF1qV/In+t+7wjoTmPiUAeWZCEQ8TVom9Y9tx3yY53eOyjByfhO+eI+CR+gL+FD11Af
 GxoNzIRAta4AoPhh89ErY4uA0siPaG7HNbhVFigpvQ85hhTA2m7kJ8uUpVNeruZ7fXPXmQYFLvi
 3J3UhwFGXBQMI/Asj+ziupM9JVsP99N62ZXofn9zF07ToPhEAxd6jIbXC3YkAJ+tEnmIfjt4kMw
 hYxJnDrD2Zgv1WtqgdOdFJHwPbC0DZStrhsvc3GRPGasSa7BoYg6rfIYt0qowtM1CQs4DRCD2nT
 AQ6xDt7fbB2wlRPldlg==
X-Authority-Analysis: v=2.4 cv=Ae8kjHXG c=1 sm=1 tr=0 ts=6aa40df8 cx=c_pps
 a=/+kXZUEK7Fsqfsk0sF7w8w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=64Cc0HZtAAAA:8
 a=2bJf0PUoz3_qUPpsRd4A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 3hVQrZzHMwql8PjfcmnG695QVB1IGO4d
X-Proofpoint-ORIG-GUID: 3hVQrZzHMwql8PjfcmnG695QVB1IGO4d
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

Forward the DMA logging features to the server so QEMU can perform=0A=
device dirty page tracking. START/STOP and the feature probe map onto=0A=
the existing device_feature message path.=0A=
=0A=
REPORT needs bespoke handling: the kernel struct=0A=
vfio_device_feature_dma_logging_report carries the dirty bitmap by=0A=
pointer, whereas over vfio-user the bitmap travels inline after the=0A=
report header. Translate to the wire layout, size argsz to include=0A=
the bitmap, and copy the returned bitmap back into the caller buffer.=0A=
=0A=
The server only tracks dirty pages for ranges it has DMA-mapped. A=0A=
range it cannot translate (e.g. firmware/MMIO regions never mapped to=0A=
the device) cannot have been dirtied by device DMA, so such a report=0A=
is treated as clean rather than failing the migration.=0A=
=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
Reviewed-by: John Levon <john.levon@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c     | 77 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/vfio-user/trace-events |  1 +=0A=
 2 files changed, 78 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 1a01e748cd..078fd8f2a4 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -74,6 +74,66 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Fetches a dirty page bitmap from the server for the specified DMA loggi=
ng=0A=
+ * range. Over vfio-user, the bitmap is appended directly to the wire mess=
age=0A=
+ * instead of being passed by pointer.=0A=
+ */=0A=
+static int vfio_user_dma_logging_report(VFIODevice *vbasedev,=0A=
+                                        struct vfio_device_feature *featur=
e)=0A=
+{=0A=
+    VFIOUserProxy *proxy =3D vbasedev->proxy;=0A=
+    struct vfio_device_feature_dma_logging_report *report =3D=0A=
+        (struct vfio_device_feature_dma_logging_report *)feature->data;=0A=
+    uint32_t report_hdr_size =3D=0A=
+        offsetof(struct vfio_device_feature_dma_logging_report, bitmap);=
=0A=
+    void *bitmap =3D (void *)(uintptr_t)report->bitmap;=0A=
+    uint64_t nr_pages, bitmap_size;=0A=
+    uint32_t wire_argsz, msg_size;=0A=
+    g_autofree VFIOUserDeviceFeature *msgp =3D NULL;=0A=
+    Error *local_err =3D NULL;=0A=
+=0A=
+    if (report->page_size =3D=3D 0) {=0A=
+        return -EINVAL;=0A=
+    }=0A=
+=0A=
+    nr_pages =3D DIV_ROUND_UP(report->length, report->page_size);=0A=
+    bitmap_size =3D ROUND_UP(nr_pages, 64) / 8;=0A=
+=0A=
+    wire_argsz =3D sizeof(struct vfio_device_feature) + report_hdr_size +=
=0A=
+                 bitmap_size;=0A=
+    msg_size =3D sizeof(VFIOUserHdr) + wire_argsz;=0A=
+=0A=
+    if (msg_size > proxy->max_xfer_size) {=0A=
+        error_report("%s: DMA logging report size exceeds max_xfer_size",=
=0A=
+                     vbasedev->name);=0A=
+        return -EINVAL;=0A=
+    }=0A=
+=0A=
+    msgp =3D g_malloc0(msg_size);=0A=
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, msg_size, =
0);=0A=
+    msgp->argsz =3D wire_argsz;=0A=
+    msgp->flags =3D feature->flags;=0A=
+    memcpy(msgp->data, report, report_hdr_size);=0A=
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
+    memcpy(bitmap, msgp->data + report_hdr_size, bitmap_size);=0A=
+=0A=
+    trace_vfio_user_dma_logging_report(feature->flags, bitmap_size);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
 static int=0A=
 vfio_user_device_io_device_feature(VFIODevice *vbasedev,=0A=
                                    struct vfio_device_feature *feature)=0A=
@@ -81,12 +141,29 @@ vfio_user_device_io_device_feature(VFIODevice *vbasede=
v,=0A=
     g_autofree VFIOUserDeviceFeature *msgp =3D NULL;=0A=
     VFIOUserProxy *proxy =3D vbasedev->proxy;=0A=
     Error *local_err =3D NULL;=0A=
+    uint16_t feat =3D feature->flags & VFIO_DEVICE_FEATURE_MASK;=0A=
     int size;=0A=
 =0A=
+    /*=0A=
+     * DMA (dirty-page) logging report needs bespoke handling. The kernel=
=0A=
+     * struct vfio_device_feature_dma_logging_report carries the dirty bit=
map=0A=
+     * by pointer, but over vfio-user the bitmap travels inline after the=
=0A=
+     * report header. Translate to the wire layout, size argsz to include =
the=0A=
+     * bitmap, send, and copy the returned bitmap back into the caller buf=
fer.=0A=
+     *=0A=
+     * START/STOP (and the PROBE) fall through to the generic path below: =
the=0A=
+     * server only reads page_size (same offset in both layouts) and ignor=
es=0A=
+     * the ranges.=0A=
+     */=0A=
+    if (feat =3D=3D VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT) {=0A=
+        return vfio_user_dma_logging_report(vbasedev, feature);=0A=
+    }=0A=
+=0A=
     if (__builtin_add_overflow(feature->argsz, sizeof(VFIOUserHdr), &size)=
) {=0A=
         error_printf("vfio_user_device_io_device_feature argsz too large\n=
");=0A=
         return -E2BIG;=0A=
     }=0A=
+=0A=
     if (size > proxy->max_xfer_size) {=0A=
         error_printf("vfio_user_device_io_device_feature argsz too large\n=
");=0A=
         return -E2BIG;=0A=
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events=0A=
index 503e1c82d4..35341994c5 100644=0A=
--- a/hw/vfio-user/trace-events=0A=
+++ b/hw/vfio-user/trace-events=0A=
@@ -8,6 +8,7 @@ vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t =
flags,  bool async_op=0A=
 =0A=
 # device.c=0A=
 vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags) " argsz=
 0x%x flags 0x%x"=0A=
+vfio_user_dma_logging_report(uint32_t flags, uint64_t bitmap_size) " flags=
 0x%"PRIx32" bitmap_size 0x%"PRIx64=0A=
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs =
%d"=0A=
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " i=
ndex %d flags 0x%x count %d"=0A=
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_=
t flags) " index %d start %d count %d flags 0x%x"=0A=
-- =0A=
2.39.3=0A=
=0A=

