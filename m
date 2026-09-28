Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDDh-00013N-QY; Mon, 28 Sep 2026 11:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDg-00012i-0d
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDe-0002kE-6I
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEflM11869208; Mon, 28 Sep 2026 08:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/yPiW38VaqKpIZs32bQnFrg09Tc5/pU7jQHCKiD0l
 Mc=; b=ZcF/9WUVzU+gUWNsGudpr6UJv974olDpBxu9fFJG0E5qZP2kVZWHWuqM6
 A1Uu1onchzbF52trtg0qsiSo4IHypktLb6SYGunB7K4zkjDoWSmJuTyfhwISWIdx
 OLsd2BvYN4iUY+ZMxypxYgepy+qjrhbuwluhA++QhCWqyjiJ0rFMQG2i7Dl7AnLU
 JpZAkX06RZOAKa85tfULlQ1bkTJ4pqMaQIuhkerE/jNEhjS4zVw1is7HcFBRQawF
 +dyrWbkK3J/qBRQlFECSZQpMetJs1a6MUcNncnrHje6AVnYDTUCbppr/YwxpvXos
 81wzWJxm5OlhMl5CkXfR+sBb/8GuQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020126.outbound.protection.outlook.com [52.101.85.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxbk5kr4c-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+xZa7OM32nE56R5VWsDlfuF10j3lRCOr9VvIi+S1LeaCKq8gV3OGlU3VKmkCNSeC609g4LxdN1RxdhaDI2gJ1EFLT1r6HQBHiks1pJYiKKBeDC4APA3TOw5dNe7Xcz3qOi78lCn5kls+lVEyistqf6EQLrKtyXoN3YoK46iJivDCxmOsK+FFXIzkT82KX7I7TLqzOluYD6KklO/HHfNGIykEBO2uHZo36aAJWmm4x24YFhgmpfT3tjfTyaRu0Wx+Zj5UEH18T3knnXJrOv97SDxrlpz63c7FV/zwM0nlqMm8uhr19bPb4x47lm0V173UiF+GpeQdBf/9ZUxxka4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yPiW38VaqKpIZs32bQnFrg09Tc5/pU7jQHCKiD0lMc=;
 b=pcb0Ws1eVtdaHooxPXwXrthP7v5fU82N82FPW4nbwfL10W69u3e+FVPeKrprzFurgMxEg0DxMrtGh3B6IBNoeFDX32VHfi6WXnsp24JTMEZwwk2ug/Q+7p05cHQnXfJeCaCZTz2gBh2MwnjewrXGXvroztVCCfBaMHPmVKR38n11krC3/WRNYE85jXbTrWJBUDI+ZEF6Fqi1A0jrgZCYg7/hwbdyM/+3SVgyWew0xu9t/npFUTcdrrH1Dh4iPqdbKiDoXHz9u2j6DpbRfRook7aazBoLnVAqeMHfmaUJcKVfR/joOWut9nUTD5xHtyQDFKjHhJfX4mVD2iN5qgUyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yPiW38VaqKpIZs32bQnFrg09Tc5/pU7jQHCKiD0lMc=;
 b=CceZw/N4nzwDdW6SV10KHh9lAc2RbWQKjAAbcztzwsrprJ83kVmtgpDIWGM7hKhnY8Lz0jevbKs+7C0mpjPlkAU5W5zl2xYU6ifOmn89QLgpKvCr0JJXP9KS2SZ/7CKsVkm55/owroAVawuPOlyUrLG+AqeErbpp59aWS7iRW0l+EV5dgQBt1AWzxbPHbOwd07/W+XWIfHQH52tqme0I0Tq99YbD+6WGczLJ2XOpDSwylS+ebA9YrgP1QIaXxWeFgCpqMnw7ZXmo4zXkip5CKFVi/KiJK/DyEI8IN+Svpa7wMAncu3tLEA2DPN+lNx88ciFBNv/uvYL2RiYLf8RKmQ==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by PH0PR02MB7301.namprd02.prod.outlook.com (2603:10b6:510:1b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:24:34 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:24:34 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 2/4] hw/pci-bridge: Make speed and width for PCIe ports
 non-experimental
Thread-Topic: [PATCH v3 2/4] hw/pci-bridge: Make speed and width for PCIe
 ports non-experimental
Thread-Index: AQHdT113qem2t8GxZEa6fZlCkjnbwg==
Date: Mon, 28 Sep 2026 15:24:34 +0000
Message-ID: <20260928152431.310363-3-david.vrabel@nutanix.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
In-Reply-To: <20260928152431.310363-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|PH0PR02MB7301:EE_
x-ms-office365-filtering-correlation-id: c535acaa-6a7a-4ad0-2868-08df1d7499c5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|6133799003|10067099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Ta8U5UF94k6zzces3ymf1c6j59w5cun7JAIjutObNre/P2GdrHhHICwVCnmhmUOxo5jYyP+0FCO+zD/uVX4nHhIItXdPOMlKXC57A5UgzNqw8jKc8F+xVOlcsWIod6Js/wSct2u6UwrKF8m3fg4Gpl1c1ChArWe9LD0+k3GQcL22I44dizyEBOInqQgD+Dw83NLbpScH7D+6mS7XpsF0axqQOa1TAAGCaCkxPwk390hZgdZeE6bntcopPcXjYYMzPaV5GlTzfeD1Z6oli1UuYyQkkqax+W5OgOZg3MQ2xR/IZjzDVSdklZK3SX0cQsQvNTTzVkdPwamZUQt6ZySu6b80m6TTY9SBCNqlolr7Zxqm0NScshcV9ff/mnuqSxVkiLxtPR9tsOy4l3P4dY0STaDAbzn6709gxIjHe3O+yPxwiF09963r2nODiPxLj9wD9H/SPbk5iVgCQDDKuuAs33tk1JXPjNdEB0HF1ycoQsWJhjyKaYv2dMm8KHhjq7zGWMcSZSjKERBU2CCzBTU9tXpwqqQSsYlBwyyGccNO/SddT9qEyHfdrTpHOgjxDPWhmNhwp93weY2Y1SaUjLFvkP9UbjWjs6McY2sqtJa2IyHKxdiwZprCPN0+NRwR+3BqzILSbPJ3les40krpcjr98wXcjEbt43tl1dOvRXTFAtOUtSYTOlwIIwWsqz8SZZJfDw70J9hMmZEuNRWevCDlLXxseHLX+GC8/hAiCADZkH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(6133799003)(10067099003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2MK3Drqi1T2sUyBFpChXNazTK4xlwOi5mjdF394ZxqbaWLQlCLe60jpWUg?=
 =?iso-8859-1?Q?9vDe40P/0nfDj3xWp+VVtJA9BfNT68GfBVo0eVdsFFFtghuWwRXXx5bbxY?=
 =?iso-8859-1?Q?wCPxJEyEeK4MUNS4w0y0Fyf99yE3ORyqi9z4ThVywVrEGwMWsJwaOXqBmh?=
 =?iso-8859-1?Q?R94LQoMn66DM0iO1rHxcNfuiWhxDB8j0ulPRnNQ58f+MpQrA2viyERp+3i?=
 =?iso-8859-1?Q?IFhnZxePecQ1EVpy79ym3zp263AJ8wU2clXLVhkw3lIXRMYvu+0t707kjK?=
 =?iso-8859-1?Q?HlatExKG7LsWYvhsCmdN5rYLJ+SCUoGUB/Qo06Y8zuSzs6EXjkfze87+/P?=
 =?iso-8859-1?Q?gAId9HrWOo4QUxFTT//kTTV0ujMx5AVJuCbRbl7rcbzkJJMnbfuXlIbRK1?=
 =?iso-8859-1?Q?xUkzvQt5tln7PSL9d9OXoH9NYrtg3r/g/qJPE2n/AvdQIi28xnfE39WJqd?=
 =?iso-8859-1?Q?URgnId8dhwHeYistfLZIpDZCl2PxldzmRsmyJPsXPbipOV3mKXKJpN1FxQ?=
 =?iso-8859-1?Q?+eNsipPJ/NSxpT+1CS65gRx/vbTQfC7Qoay9YUa/WfqhtOeMr5bOCY50J/?=
 =?iso-8859-1?Q?Mvu0zJ1l/fKp8gtkH23KcqLpxqGMYqewMoAJGqs3SfC46KlYphBX0TB3tu?=
 =?iso-8859-1?Q?3tkJE6PxJFBtPTaKeseHDCso3E+sF7BID4uyLb8fkgfOriwypJk1HPc7q3?=
 =?iso-8859-1?Q?1JVgCQLqruaZ1npIJHZdCDXE98I2fn9slGFRW7R/PIFAZv7TDYWQvzqWw/?=
 =?iso-8859-1?Q?6c7Z48LDrIMJK2aLMVoqPFsgVLi9OIcSgltirQ6XPcKVx3e84vxJYGyd8n?=
 =?iso-8859-1?Q?46m6i+cEElixTTNmHXm8Vb8UYqATvlEAJ1qDcAXhYNnAAr9KxbrYhbNtcf?=
 =?iso-8859-1?Q?rN5MSVUXe5jqouYz5rYw/v/+AhtugnuBGwj54sSW09MajdyKsMt8HBODWL?=
 =?iso-8859-1?Q?xRnbxLzabwjkJONpZW0PNwJ8kqaVRWkqvJYwcNP6oV0PrgRJ5mhVFJTpCf?=
 =?iso-8859-1?Q?LDPCvLSSK0RugaY7Tf+AxUA7OYF9CmwB2eBa88fLbhhJNJ1hBUG/s3GDY8?=
 =?iso-8859-1?Q?XhVAKVCcUNipaBqX7XQcCGelm/Q+6YZtLO1Q/IKpFaU+ukEeMEWDgEr0z4?=
 =?iso-8859-1?Q?QIujgfPCB7lt+jyl0m8zJ2kh7SYPos15kW5+hOI75OSnVoaGFf6YsRLA7H?=
 =?iso-8859-1?Q?BjvIpHneT7lTrqthbZaBJJeoHh8Je0c5HPuAABhBuTNgi0uRLSm2eInd8T?=
 =?iso-8859-1?Q?9UgIIBgee4syU/Z8u9Xyt354ds4jMKHbDu7jjtrqnpyQcLR2s2/LF5ajWJ?=
 =?iso-8859-1?Q?cOCG6vJJUS7x+MB1N2kaKgbIGukELtmQf4IfINbEK0oaSsIVGkrebIs0IX?=
 =?iso-8859-1?Q?GAB+jzhrYjih9IU3Ff4Q1fSGHUxP8UswWiQI+6uEz+IMf+XcBgZpeJTgQu?=
 =?iso-8859-1?Q?V5dHFtHmry9I9H8yxVZ21IxeMAfh29eZ8W0WjSJDQZ2ZAHHN3k7/2zLwni?=
 =?iso-8859-1?Q?reuDq5ejlqu3npXMahFLNGXc4nBm3cfVZl6CgiKwlzXcEuqiTvytirQzGG?=
 =?iso-8859-1?Q?AJSHFs/GCBQhhJkQu130eW60m3Gx6ho3feHHx4UXUuDYwhyecNLCWOo0cW?=
 =?iso-8859-1?Q?oSWIH2pc3P3HejAPM2oPVswWw9UPwepyhLlnbDcUXSzhXSnPv9Xl7cIR/G?=
 =?iso-8859-1?Q?8YX0RvasVTycGcE8dLiRVK1OLoKtBCvJAXh/eY2T0zzOZsltemDgWWAgiS?=
 =?iso-8859-1?Q?V82mJp2pgmPoEh2Si+/tbR0gI20JlYh0Toc5aSJ5s8rdWwQ25Gh4kGUeUx?=
 =?iso-8859-1?Q?gMtIxWD3LFm2m/vwF/R0KO74oBHjaCk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mUTOHZDLGBql4gc6x+b6d3ufiaLLDhewwtDXOihfXzz2aLCqmELNgkraSipLZVh+x5d+O/IFaVjIo9+iSQK6uPnsmHnsMqx7vbkMY9c1MsbVNhtYyLocYBaoDWuaUltAtzgZdgioOINH+cUtLIP4Lh/mmv1DC5apn5ri2tOOzEohNBoJaKZLCKxKIGkqinUdMRELtyf0vnaO/DGZILqxGVkVmlTT6lrnUDpjjOqlZBZHODE2VYuGjP6GW7GVFqnncfQp1OHGkwP0ospoiAdOncnVfOSsu+6k+hHvuc3Fw24pASAvh4hD1wFtAIbCmljbV3dhZDA83jEOAjHf3/almw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535acaa-6a7a-4ad0-2868-08df1d7499c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:24:34.2225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHTeiNWPw2voWjvrXraWhDuJMWR4047y8L3S+JAPTnB8gM54y6SDZNZMcanL4vxREWSvxR5aKyX6tWuoZTuCbBCeQgqYd2tkbDRBBq9ZHMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7301
X-Authority-Analysis: v=2.4 cv=T6EZ3PKQ c=1 sm=1 tr=0 ts=6aba86b6 cx=c_pps
 a=w1Ugl8llyohtshnQLMHy5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=64Cc0HZtAAAA:8
 a=Ttky8AElcTD8thzn_3UA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: PP5_te12DBPcGqhph9bQ2WDzZO_uSPwM
X-Proofpoint-ORIG-GUID: PP5_te12DBPcGqhph9bQ2WDzZO_uSPwM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX7r3U/uyOdneu
 0yTtjxx8J2lpJd85/TCcQtGUliQMPKHm4vvk0ZB1LBOMm0XQNGoJ3vKX5+3AMXHj+CZjMyfAIwi
 btfkUm8A5MnsmJwaCARiW0Gbcmz8oaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX8lM5CXtXxd1E
 OHuQcaJdhn44IClUsCZ6S4CAoLyIDa4Z7IitybWZUgwlEvfvnyD3dB1X+OE0s6FjkJEXZYgT5oV
 a4Dcm9zcIrRbLjuUACFRiOnaOL8hZ5Q8g2g2OTNYHLzFTlgs81bTEWlYVMVyXIi+RWLrGHxN4PT
 mfA/Hagc4ErEez8343ES5xXMGa+yiv4Yx81RsPKqy1jsuwrb+Bm3rIqXGGU+8K3x9mrcmYVQ3NH
 qOJLbiGzYe4w7bD4G4GYmTppeXzR5tO5GeY8EY+SoeWhQjG4kROgku7UIfQR6scMzxPNLl/hJPq
 TZejFaTdVfHEsxaZrXvoqeZeixlb8ued0L7g606F3IC+j9jVoHrT/18joHk+loGHSxd0bGA++Dq
 ggMqftrnOHygLPaMwZAGK0b7JTGy3D3Fe4mP0xumbzNcu+gOychnczsp7O3HimWedT6HPnLJEan
 bukh/iBjIEVePeI7+sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

For guests with passthrough PCIe devices, in order to make the guest=0A=
PCIe topology have the same apparent bandwidth as the underlying=0A=
hardware we need to be able to set the capabilities (speed and width)=0A=
of the virtual root, upstream, and downstream ports.=0A=
=0A=
Promote the existing experimental `x-speed` and `x-width` options to=0A=
non-experimental `speed` and `width`.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/pci-bridge/gen_pcie_downstream_port.c | 4 ++--=0A=
 hw/pci-bridge/gen_pcie_root_port.c       | 4 ++--=0A=
 hw/pci-bridge/gen_pcie_upstream_port.c   | 4 ++--=0A=
 3 files changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_p=
cie_downstream_port.c=0A=
index d9c182e881..d00bbd55f0 100644=0A=
--- a/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
@@ -159,9 +159,9 @@ static const VMStateDescription vmstate_gen_pcie_downst=
ream_port =3D {=0A=
 static const Property gen_pcie_downstream_port_props[] =3D {=0A=
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,=0A=
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
                                 speed, PCIE_LINK_SPEED_64),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_ro=
ot_port.c=0A=
index 5434d693d9..d3ace7f0db 100644=0A=
--- a/hw/pci-bridge/gen_pcie_root_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_root_port.c=0A=
@@ -129,9 +129,9 @@ static const Property gen_rp_props[] =3D {=0A=
                      res_reserve.mem_pref_32, -1),=0A=
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,=0A=
                      res_reserve.mem_pref_64, -1),=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
                                 speed, PCIE_LINK_SPEED_16),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pci=
e_upstream_port.c=0A=
index e86eff099f..61ae3a294a 100644=0A=
--- a/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
@@ -134,9 +134,9 @@ static const VMStateDescription vmstate_gen_pcie_upstre=
am_port =3D {=0A=
 };=0A=
 =0A=
 static const Property gen_pcie_upstream_port_props[] =3D {=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", GenPCIEUpstreamPort,=0A=
                                 speed, PCIE_LINK_SPEED_64),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", GenPCIEUpstreamPort,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

