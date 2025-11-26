Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A2D1118C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJsx-0006Xe-6T; Wed, 26 Nov 2025 13:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vOJsv-0006XS-8A
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:04:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vOJsq-0003cb-CN
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:04:55 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQEmWNm956473; Wed, 26 Nov 2025 10:04:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=AHInLQODrrHRFWz
 Hrss6ThAzLBtEVdNS1x5s+O4XSoM=; b=vPJJCtFhpOYMLGlvHPGHUm8vnUhPlaJ
 m3E96gNekunTT8LvxdAB1ULPfhQpucAZi8+Jb1N2or75871mimlamzFNuVz9ASFA
 8cFFPr/VTsYkp9gohA9rA3pK+gPsS7DXHrooWjBTBTLhlYyFpYYxNhgmEyVtQWdD
 Id0auBHVqG7KOsHNjdvShSnkXlYjKZvh7JImBlUzfghYh+dv1NoUQL1fny9c6qig
 mscJlSubuqiwGf0nG6aPlcQpwhgSoU3i+EW72jn4ou2N9p2tXb/C8lzb3I73IVWA
 PeEQxN+V4JE9G1vo/+G//XliH8yFRyvHrLwhZc4wh2WEEp3XPRKwHoA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022113.outbound.protection.outlook.com
 [40.93.195.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3my8d56-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 10:04:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9HB946D8hMltNHwgUgZEookr/X8+hmt3V/5BqQMuW5Tdg4RRcG4sXuVpnWw1tUFKNDvHcrDAV3lO5PusNbjj7VWbtmp0Ct1lLnQ3hf8vmwydtn0nlD5RRabJT5dz89DlB3/wUH1jIRtE70KlPEqJW8Mh/zidxejgvbMbAtezmNTxOUt/fqX9O/fm6wcdW6Hmx08TBxQewXJ5kS7By1uGaW3M4zGYDfB7j8wL/3Kfkc1BWSy+1Ny4MG8HDceRoLOexzJzjTOOWGbN5SksrTbsdOKyjdQAuErpVeWO+FIprta2Kz5whnwEC8L6alcB8SdPZakaN9ViIhlqGP7L4mdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHInLQODrrHRFWzHrss6ThAzLBtEVdNS1x5s+O4XSoM=;
 b=KgPu+9b6CEfLrHNg3NsmaD8yPm7Qz920D7D1zuVfcY6pnLkb4ZMrjAHoJy4w2z+brW1b7F99Fr/7GtNPCJCI4a3H+XkX2mcxf8DI8oXbJSg4HFOJ4lRBO/qiANFUrohzjez3vMA2W2iLDml8INNVa/dDOCW+PngnVyEJqimp9PkstVEDXkTB+9YgBxkneKc0kPZAL0FhZ+fpAAbTHeIiRBt6HU2rkWzcSmuByqhrq38ViktPu18mH5tHoa7INnIo0XKo6CRTOk2eC/HeVJ+8gxnKFUA+DIN9xEhXRbAmn0nHUVZuWAJfYuMqS84CyuTd/RJ1GX2KI9IqPAb/gNZlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHInLQODrrHRFWzHrss6ThAzLBtEVdNS1x5s+O4XSoM=;
 b=NvSceJ6+jOD+iRPtEQ2mUm0VhHMrvGDW+Y1Zkkr7eEy9KXVxFsk0ww4tO06YElvz+hhRmh9lG12eipsSHwQGJdu3FQZzeFllXl57F22TzSVVl9kIwuc8dJrpKdFB8EQnKUqcANUVGDxnQmVpFe2O/CcJGIHwPdfY2o6Ij4Wzn5ZL8OzcAvV9Vuf3qLGeAzdNLDowihK2faMtFihrfMET110Wc4W35Ckvhif0MR9C8EUKR5xsfxpwGbm2jrU1LK9Rn6zlxYnL8yBiT+HY26nJ31+T0rV9wHgoViKZhMLXxg9GMuE3VtkpafTTRXZ2FxKPiUvbwFGFRlRkK86IbGZSsw==
Received: from SN6PR02MB5038.namprd02.prod.outlook.com (2603:10b6:805:67::23)
 by SA1PR02MB8850.namprd02.prod.outlook.com (2603:10b6:806:1fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 18:04:28 +0000
Received: from SN6PR02MB5038.namprd02.prod.outlook.com
 ([fe80::9bde:f9f0:aebc:51e9]) by SN6PR02MB5038.namprd02.prod.outlook.com
 ([fe80::9bde:f9f0:aebc:51e9%3]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 18:04:28 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "corey@minyard.net" <corey@minyard.net>
CC: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Jonathan Davies
 <jond@nutanix.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcSDTcGtSWPs7JF02v94olU9TuQ7UCeIaAgALzN0I=
Date: Wed, 26 Nov 2025 18:04:28 +0000
Message-ID: <SN6PR02MB50384A7A5B522A5F58C444FF85DEA@SN6PR02MB5038.namprd02.prod.outlook.com>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
 <aSTF7QFuXGhNzGce@mail.minyard.net>
In-Reply-To: <aSTF7QFuXGhNzGce@mail.minyard.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB5038:EE_|SA1PR02MB8850:EE_
x-ms-office365-filtering-correlation-id: 0ccc2d69-4bcb-4793-9cd1-08de2d163e00
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7yupUG+EeZ4J2z+dZXINyXdtV+uiy8gDtz4/hpfhPIRRZ+nt+38W+SJUFS?=
 =?iso-8859-1?Q?VEs8a+gD12oxyCcHnlCc0D6aRu3ktb+xkfKPU59iFBPdALkYv/RGUm70sf?=
 =?iso-8859-1?Q?QJi6QBsSMUCKR8Lo42g1Y9eg/s1xGs5735/sJQNmylcnR02EqoGfc6lN7p?=
 =?iso-8859-1?Q?E88AETbwUBTem6kZL7YvyIwleIbCmEhd257yHrD5DSoI+sjjFRrVsNmIRg?=
 =?iso-8859-1?Q?8JTLe1SOYYsKA6ah9Uc3Sk9bKd+mPBdEBWzih4NLJg1Bngxo6aUXfqjC8f?=
 =?iso-8859-1?Q?h9jK85cIrWSox95N6vuZbQgn2Mn3ogDenMp2JmZ7UtoPLXoNFnq7IHwNeA?=
 =?iso-8859-1?Q?OjHFAhMk6o4AfJK2PYJ3OWjUEouaaQmHzQGh5NA2PtVKbQko7m6/UMXMhq?=
 =?iso-8859-1?Q?IV7dxkpsOkhN77Q3Hd7HvHPXQJW1qn11iCpTS5WJl37ZzDgCSihq8rQMX9?=
 =?iso-8859-1?Q?8A/c2P5q8DpHRN+eEFV2VWtqweTXEVo/LsqtONcuXHmrxnPJKNWN2a/2b4?=
 =?iso-8859-1?Q?IdHiq+o6NIn6XBSPgu1qFocptQKm4tjSnH0L4CwyKnuASBVa3rAtgBQgyt?=
 =?iso-8859-1?Q?lPFVsl9eXnEo9X2ZAwohMuEIh//UgCMoECAS+qUvJP5V7T0v6F7HAiQ9T6?=
 =?iso-8859-1?Q?SBubZySzRmGjmvSYSVcIiXzxN4PxHcx1qOAS4VnIxE4X7ZPsK65YRcAn31?=
 =?iso-8859-1?Q?D5gna9CnQfwdc/n++0MJ6jysUfZESdbDJU3iUYlL37YX4Ie3FnpExpXUe6?=
 =?iso-8859-1?Q?i4ZRjdaPSBWg/AJcrabOj1Fi5wyiqqcTDLMMn9tR229iv6DB8sHaAQD8tp?=
 =?iso-8859-1?Q?z2Z7+SrYNJz87ae1XdwqrO76fzcklxxoDNCg9Sp0yC1WLYqC5Y/98Z5Gvg?=
 =?iso-8859-1?Q?sXEaDdcY1ySjpyPpwK6d7Hp7TmgnIRVEOGxWZ+9G12+/raQm5ETD6ILQVU?=
 =?iso-8859-1?Q?zDL6196dw+nFskY83C5ROW/Lcw/OvoUte7/uwcij9rnJFn5MZtm254pseE?=
 =?iso-8859-1?Q?nMsli3kGI/OE0qssgJhjrd+A2lJFi6tRg67zst85NTEIFrexb1h7rCvwX/?=
 =?iso-8859-1?Q?TlFNXBUPZr+XtBMyj81Jlj61MIYOmqOivpatybFZMNmAT/u/a+lSgtySZH?=
 =?iso-8859-1?Q?f7p0EybI0W2IatWwYJnOA2K2JOOsY/UUIYwFEvKYWsd6MLc8vPFmNdAhct?=
 =?iso-8859-1?Q?xBGkOKw0kGjGg2iCDr23FDvBfbLb+V70WtjLesFUW8R713Yak3uNRzV6yK?=
 =?iso-8859-1?Q?B7PTlcDddGk6oyMlIsWPXNLCwLIsHu7/MJ3zweB6Iirnx5AaEFgb7J1/hs?=
 =?iso-8859-1?Q?zufh+e/LuKi92Rur+93TUNtjD67VlDyUhqQ5RUuQ10phGmKY33Vkrd3uJ3?=
 =?iso-8859-1?Q?3QpzMuILcUT8dK0RJ4/PnpC2R3P/yrZLUz9ZxzV6TsrCjjcj96a/eMCstX?=
 =?iso-8859-1?Q?OeTFAErLwmHG52+v3yK3NA2m2BC4F7fwuuX67X4k8Tiuhra69zUUJ3bt63?=
 =?iso-8859-1?Q?cYmL2EJnPTnQFAnpG7ZIixMtsUalemV87SB1FPnrygsquKBci7C5nxNvvP?=
 =?iso-8859-1?Q?cp4qCP/qAF8bsJ8xvHHAT4P4QHUw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB5038.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7WdsKONHV+n9UOxassTv5Cw1+Lgrg3kY7V6ty6ox1eJx3JSzkEcvmtGUst?=
 =?iso-8859-1?Q?1Oz5d46qumfS4Lt22vmPwRmCHScuTTcd/MlYVhFalVsx9AbA7i7mAILPJz?=
 =?iso-8859-1?Q?vzXghoIJ1bUX1KA7AlbI7N1bFt52c0dAFDoMQ4g3iz8fE7/FEAt7JjkXJs?=
 =?iso-8859-1?Q?4JZWkOSSP5pi4c+9qt7rZv4VgHli3zYdPSlI4XhO0gkixP7NfYbFoe4Gzl?=
 =?iso-8859-1?Q?hdu/uy86ob3ry1cQnlNw62doY79WGMiWIIO1kB/OBmc8VezCjtgMb7E9fU?=
 =?iso-8859-1?Q?mkp4NI4ozfKZo/Cw54AwXbacfHtNA7ksAe6bud0E1AwfBhXET6OC8IcbAp?=
 =?iso-8859-1?Q?jw8m5xXapg8UV7ZiozzXau6m0LFMrIdfNAkITv+xMGorYJ6d69N3za88U/?=
 =?iso-8859-1?Q?ExjjCOHZucCVNk0vo4P1UkkZUaOq85IUK4ff6zKeZxfn6fZcN7v/Vx633K?=
 =?iso-8859-1?Q?3I/rD6l0D4AmMqYHpGET2rH0Dbf0fQDVpJ9NUnQ2+glW4lv9ds7aEKU7iK?=
 =?iso-8859-1?Q?FMy/1fHqZieVk+43YJCX/PdKWjqZiSWO4+56byprsVYYBvqRMavO1ch/oU?=
 =?iso-8859-1?Q?ccRpDwGauM1xpw1kM4Fd82RKF1yJN727H47dH3Mk4hzHoYdBqx6R/7O1yH?=
 =?iso-8859-1?Q?SZCFnZOwZVWTKcsnooQO8GW/VWuaeoxNCNdCiPDOpYG/YBmmwz/6WBHgkQ?=
 =?iso-8859-1?Q?kp0tRd9stloasZDKHciE37UV6b6VVoEfVlmHaKLmzf6DZzw8CHKPQRZfKl?=
 =?iso-8859-1?Q?MJgnem1qjB41rqK2APJ3T+1U9EOm0/vef8seAmvTYTWdhTgnMZX+fqiMM9?=
 =?iso-8859-1?Q?KwLZ0pIzAESwfyDOco9OtJM5OwaXHjRVN2NyQRd9mENgDd4OenDlVEDvTR?=
 =?iso-8859-1?Q?9kn6ctVhuGTRST81BKPQLE2d7P/saXw+aD3Qg2m6rUXHJ0K1JIKs+ddWo9?=
 =?iso-8859-1?Q?hyy9s5PtBVVdhMm65tnEJfH9tppDYL1r4Ki/PL55UpFVKfbTlPZxenaHUY?=
 =?iso-8859-1?Q?oHNeQdib8+KzwEq5K74E9PPOeHJ/u4GDyRS/2odQJWf1hstDWipUdmYcO7?=
 =?iso-8859-1?Q?iT74wM3pryukFUT3o9IiZrJ/7Q1vS7bsNNM4dKQlxxQ/JYX84Flm8K6v3D?=
 =?iso-8859-1?Q?k5OGj7x2RXHpRgYoFjThjm9aqEaziHrf2bTlvuVk4s2M3ELGwdqrlQSjAm?=
 =?iso-8859-1?Q?yuxKKQInGtQ5Xna3Ynfhh35W4GJLZ6HYPxHJ0AZ32Eg01OszOretEk5EtL?=
 =?iso-8859-1?Q?Gta8NMGmDW0j1+CJ6Q5PVAPtvSEWbMnPGZzd9Sh7nUEQx34Kf6F50ZlZFr?=
 =?iso-8859-1?Q?gyS26+61yzTC1w/mdzCJUCO0Qpsp5Wkeq0rMKQG+kCTdzJw28leVlCQTJo?=
 =?iso-8859-1?Q?7n6sZxY55RZ3G7LtDHWdrAPqKemz8poeHAlL8hZZms8tNRfs9F8uZmTWzP?=
 =?iso-8859-1?Q?g9Em4MmIYKQ3SAxjcNi7nEciBbIFdsYAIgfFn/RCAKsKfmDrJ3p6VWhprZ?=
 =?iso-8859-1?Q?WcWQMVHx/1g0IJXjHcChrAJmOnSXeFDyLKgauP3xL4ajeua2HTG4+Xypcc?=
 =?iso-8859-1?Q?8oX1oYWgMGZZCM0H1/QpPC293IRRO/wqXSpFYZsnI+ZhEWFijkN13XqmbU?=
 =?iso-8859-1?Q?lvefniN9w+ZInCDRKPdv0tvPh74h/hyJTs?=
Content-Type: multipart/alternative;
 boundary="_000_SN6PR02MB50384A7A5B522A5F58C444FF85DEASN6PR02MB5038namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB5038.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccc2d69-4bcb-4793-9cd1-08de2d163e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 18:04:28.5787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RChqPa1IUkt++/DnoTctOVs49yNh95XaEBpPOfo+ZcnWpREDN5C9TWCtnv7vsSS+jnaLPRBjJbYYl7/rvY9WyopHAGLnVDuQTbl5QJNdaAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8850
X-Authority-Analysis: v=2.4 cv=b8+/I9Gx c=1 sm=1 tr=0 ts=6927412e cx=c_pps
 a=39fn0iQLwZAYlIgUf1ob7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HL3alpDKAAAA:8 a=64Cc0HZtAAAA:8
 a=N54-gffFAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=Yeu6AIbcFjPz14ARe8oA:9 a=wPNLvfGTeEIA:10 a=QQtVvnIgaLdorl6FZWQA:9
 a=W_1WgY_zTNvWvNh4:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=KRX0AkppOCwXZa-dNZoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0NyBTYWx0ZWRfXxiAavxbdH33U
 ywhlqwV61Q/YIITsIG70dapMbIqjFTItOcWpNs9nI1kyYaB0KnE/jwbHn4/Xrw7Ky2A6OiDn/+J
 8Nh20E7BZA5//MPer1foxuJINjgMtf0iNZTfrULRGOWGIRz12NvJNMBGYJ+1u4YtjOlX61pr0/C
 2fFj42nGqezCHEyNKebGPd0gsoXxd7I3QQlEiBcsvnjbOPbe8376Oaju11FjjOicw59jK2eiJ2f
 0rDX8mJPgOCeLaoqPYgU+WBSgv6PmDQEwZnsB1R6J5UbRZAjXvWBgieZOOMevKxcNBGd/1CzNkB
 Mv4YW965cSMyAK1Bn1dS/kwWoFCMCPGVSoXULk6gM0WtyYlpyanT5ZdHoQE6zkuYcnlfx8ZQ6nB
 pLgkmmq363S4B0fW8dCJejoxXrNcUQ==
X-Proofpoint-GUID: unX8mU85aVnsL0nFUImlCHSwSvqzZOui
X-Proofpoint-ORIG-GUID: unX8mU85aVnsL0nFUImlCHSwSvqzZOui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

--_000_SN6PR02MB50384A7A5B522A5F58C444FF85DEASN6PR02MB5038namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Corey,

Thank you for your reply.

Please add tags or take the patches into your tree at your discretion.
I'm not bringing the patches in any place else.

I haven't tested migration between a version 1 and a version 2 device.
I'll do a test and tell you the result. Thank you for your suggestion.

Kind regards,
Yunpeng



________________________________
From: Corey Minyard <corey@minyard.net>
Sent: Monday, November 24, 2025 20:54
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: minyard@acm.org <minyard@acm.org>; farosas@suse.de <farosas@suse.de>; l=
vivier@redhat.com <lvivier@redhat.com>; pbonzini@redhat.com <pbonzini@redha=
t.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <ma=
rk.caveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>; cornelia.hu=
ck@de.ibm.com <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config

!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

On Tue, Oct 28, 2025 at 06:01:18PM +0000, Yunpeng Yang wrote:
> Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.
> Although there is no real LAN channel, some testing processes which
> require interactions with BMC LAN channel will become easier.
>
> There's another device `ipmi_bmc_extern` which works together with some
> external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC
> simulation can be achieved with `ipmi_bmc_extern`. However,
> `ipmi_bmc_sim` is more light-weight and is built into QEMU.

I apologize for the time on this, it slipped between the cracks.

These both look good.  I can give a:

Reviewed-by: Corey Minyard <corey@minyard.net>

or

Acked-by: Corey Minyard <corey@minyard.net>

or I can take it into my tree if you aren't bringing it in any place
else.

One thing you should try is doing a migration between a version 1 and
version 2 device, and between two version 2 devices, just to be sure
migration still works.  Assuming you haven't done this already.

-corey

>
> Yunpeng Yang (2):
>   hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config
>
>  hw/ipmi/ipmi_bmc_sim.c      | 407 +++++++++++++++++++++++++++++++++++-
>  include/hw/ipmi/ipmi.h      |   1 +
>  qemu-options.hx             |  26 +++
>  tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++
>  4 files changed, 567 insertions(+), 10 deletions(-)
>
> --
> 2.43.7
>

--_000_SN6PR02MB50384A7A5B522A5F58C444FF85DEASN6PR02MB5038namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello Corey,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thank you for your reply.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Please add tags or take the patches into your tree at your discretion.</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I'm not bringing the patches in any place else.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I haven't tested migration between a version 1 and a version 2 device.</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I'll do a test and tell you the result. Thank you for your suggestion.</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Kind regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yunpeng</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Corey Minyard &lt;corey@minyard.net&gt;<br>
<b>Sent:</b>&nbsp;Monday, November 24, 2025 20:54<br>
<b>To:</b>&nbsp;Yunpeng Yang &lt;yunpeng.yang@nutanix.com&gt;<br>
<b>Cc:</b>&nbsp;minyard@acm.org &lt;minyard@acm.org&gt;; farosas@suse.de &l=
t;farosas@suse.de&gt;; lvivier@redhat.com &lt;lvivier@redhat.com&gt;; pbonz=
ini@redhat.com &lt;pbonzini@redhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-=
devel@nongnu.org&gt;; Mark Cave-Ayland &lt;mark.caveayland@nutanix.com&gt;;
 Jonathan Davies &lt;jond@nutanix.com&gt;; cornelia.huck@de.ibm.com &lt;cor=
nelia.huck@de.ibm.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN=
 config </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">!------------------------------------------=
-------------------------|<br>
&nbsp; CAUTION: External Email<br>
<br>
|-------------------------------------------------------------------!<br>
<br>
On Tue, Oct 28, 2025 at 06:01:18PM +0000, Yunpeng Yang wrote:<br>
&gt; Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.<=
br>
&gt; Although there is no real LAN channel, some testing processes which<br=
>
&gt; require interactions with BMC LAN channel will become easier.<br>
&gt;<br>
&gt; There's another device `ipmi_bmc_extern` which works together with som=
e<br>
&gt; external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC<br>
&gt; simulation can be achieved with `ipmi_bmc_extern`. However,<br>
&gt; `ipmi_bmc_sim` is more light-weight and is built into QEMU.<br>
<br>
I apologize for the time on this, it slipped between the cracks.<br>
<br>
These both look good.&nbsp; I can give a:<br>
<br>
Reviewed-by: Corey Minyard &lt;corey@minyard.net&gt;<br>
<br>
or<br>
<br>
Acked-by: Corey Minyard &lt;corey@minyard.net&gt;<br>
<br>
or I can take it into my tree if you aren't bringing it in any place<br>
else.<br>
<br>
One thing you should try is doing a migration between a version 1 and<br>
version 2 device, and between two version 2 devices, just to be sure<br>
migration still works.&nbsp; Assuming you haven't done this already.<br>
<br>
-corey<br>
<br>
&gt;<br>
&gt; Yunpeng Yang (2):<br>
&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel con=
fig<br>
&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel con=
fig<br>
&gt;<br>
&gt;&nbsp; hw/ipmi/ipmi_bmc_sim.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 407 +++++=
++++++++++++++++++++++++++++++-<br>
&gt;&nbsp; include/hw/ipmi/ipmi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 1 +<br>
&gt;&nbsp; qemu-options.hx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 +++<br>
&gt;&nbsp; tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++<br>
&gt;&nbsp; 4 files changed, 567 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.7<br>
&gt;<br>
</div>
</body>
</html>

--_000_SN6PR02MB50384A7A5B522A5F58C444FF85DEASN6PR02MB5038namp_--

