Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA27C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yv-00089J-5O; Tue, 21 Jul 2026 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yq-00086i-KI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yn-0004lf-81
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:26:59 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARrlD3214231; Tue, 21 Jul 2026 05:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YQIw8bdie+F7u9LF/7zfZRO4qi+hJBGEYyE6aq78j
 /g=; b=h40b+QmyqOm+76myitEFo/zWy2FID/CgR7nt/DR0N5a9/IaaPEnhbkapr
 HNjO9UWMaiRtD1YQ159ep0617dVS/dUvf9JgelWRvnI+UEg7mq3MO7M98AdR1BqM
 g5fgjqAm/P0rc/Czb2tRnouv+aRt/7ouGHE9Mub9XeR7LjGyYHN/1QzUb0UjTu1b
 hUsy9nXcZcWoiKv0NJ6uQ6mXc0gdF7/w2v4OWbnIQSKDtjlwhX5Cr8r01MjVE8KP
 wFFUP2auyUW9vW77ih2aREIhPc24Zf9nYXln6E8MpHAvzLo9tHxXNQ9vJqR8n1x1
 7xU8tDaQ6guN5lJ6wByHLYBzSTfXw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023093.outbound.protection.outlook.com
 [40.93.196.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xean5-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FArIfyNELe/pnsTYhByCiJf016/6FycEVRzGh+RnV4/7PsZZOj3W9uM9sr0w7RoqWdo6nRwnrEgit791H/u4bpsf6UaZ4DVTAhYu3rRZIoPWW4WVwG0aLNrppt0W/uB+2CWYIYdtEI45THsTKkwcTqVA63GYq+kTmcIjq0I/jGmrNlatqh2lSYmer3NYfuvcS+Kfr1x1F4spYYuryxYt1ALTKfmF+TbDnc7/W5WoqFGgf8rjcgflenLH3p5x0OukdIZ+jK2HNYXkjlTL/JZ0F4l6tIe5MTrFTN8H3IEGggCfqK/VRVYN7eCwtPd321ASUhoeqUgmgxJ8AMKERHfIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQIw8bdie+F7u9LF/7zfZRO4qi+hJBGEYyE6aq78j/g=;
 b=s8g/0ma4vswhex41pqX0MmQcvljMQXPhCF9OfpMHcti0KyVeM9g41e6SBrF2CmRbNPTxdNu+V5bc/yjmt8ViQnrFL2oGOhKSFW4ti9zMWH5XPJpGtQm1DUZY+g1WVr2DMkKCyMpKupXzXyQX6M5+neo+lv92dQj63UvDoOW2ywygl7q0wVllitesvNsaKuQuiwISxZ28rtGGSx1RT6c+qQuBRYxzTmGwy4HySCZEZYv6jfBBkpgq03IeXYyJncMcZByIO5+LqsBz5FtxJEjDcPdAztd5uDR4BPaa8n0ErIbzIdn/wkMBef9woCnTqkbXb5lTXd4loLDa4jt1w4Ishg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIw8bdie+F7u9LF/7zfZRO4qi+hJBGEYyE6aq78j/g=;
 b=BxnII7R8UgT6uegd8tMFGd83rEshqMNB8RWnF9mNvRF+nBT+yJwbe5yLP2P0OoLr9QC0zNPYyWG3xc8XQ2YpVqLizYctJu6EiXob9HJKgw29/bTNHUvGtX9vZLl6xCyQQaGxcHefnM6Xw/hphY2jJnlu36cF8SRTK2VaQLiMiHzmw4ssjC7h0M678i+486O6RinRmsZr2uKVl/XrJfJGPixEqRuWH0sPb9yQVt2/ilKBt8GsimHhJyQlzBU8cM7CY+5ncbnSymqPUBM/DKjJ75jE+Bfa1Cufy7VvoMMGjUgvZ24BxoMZ9burf7sMcK5G8ToXyzxJphC6z75S24SNiQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:53 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:53 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 3/9] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Thread-Topic: [PATCH v3 3/9] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Thread-Index: AQHdGQw2BmMLrXt/3kKJjqk6eLhKPg==
Date: Tue, 21 Jul 2026 12:26:53 +0000
Message-ID: <20260721122643.30985-4-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: e03b82d0-36fd-422d-ce59-08dee723591a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: lGNmneBQ96y/RmprXTXzuGEV4tlw3DEf20TBz9TXw6E9ss32A6Q7UP9TF45LtfdiWwV7FTtdoCmPO04X7fImmtkC7oNQTgn6784RurI/4f5+1mCFPyJVOsQquRSZEn8snj9ar2nEdP4oBdKTmG2kU294OIWrMs5sfMfxHvjbzz82A1loOOGTLd6Ln++z2MGWG4GoaUX24a71gu3V29xpqAGZkwHm+DkJflmTgz12vMly350T6wpiS4Phwp9ZzGy/58ujuhyO3uE9wJhd43yOx7Bycb0T3uSydtCZRW5zl6MbD9fhcnjvnSHeGNqNWoF34rFsAHChDChU4nzrf6kkFWrD4bY1JL5EBz7i7+OkZxxQPqo1IbAZW+KFzwbOz8ne5We8+6xMRS3+iXFckUfSK413z3vCJZMRAI8jx1B1VWcskqoF0pkzVdKo+stTD/F3OzNYgmfNr6redUn7uAufENS5HG32lWw9tjdB7YsPhdNsgDA29yBGO6GHzcPSg7mrdp1tuw++cPhzmD73BSWl/MsobA5rQ8fh9OPcojGGHoJeY8vt+AYwNN6SshJxrIiA3LmQquwVOzVe7zBCzeF+9zDHRJjroNPwnJ5+HcQLBFQ6oBhvxv2XY40SXsDEo3Tb1w3FMUIfbSjKv4i6R+uqIzPN1hbDg4Of1R9sLaGbtM9mT22pol4W0ULD/17LTUYkmSXUZ+pQ2i/nwlx7OeQiuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5+9JXFPCH/tK38MEQkAmu0Nr57I/AFtas6esPUMBB8MhPa+SnazSi3O107?=
 =?iso-8859-1?Q?iG+0nvrfIdRcqt/PPxKfmbcPzbzTlQMOJsmVNaXZn1eMUsoZJWGW61V1pD?=
 =?iso-8859-1?Q?Nbb+xmMNpYOqndDbRbEMWoubcsYXIWwtI3cuvNVZHXymdQXj6hqYNi1ui9?=
 =?iso-8859-1?Q?dgg7OaZmB/gbaQoxKrPlL7cWrYUfkNXRx6lgcLJIlkA+JckK57R/L6d+6O?=
 =?iso-8859-1?Q?I7E5PNaTzT2c96bdp7f4atSt2v7eQ8bmdKtX9XQfq4OEHTZLXdw5cE8nEt?=
 =?iso-8859-1?Q?1+MA11t5sC3OyvEExKSmvj8pgHcgpHk6MyPHnGggVTt9VrfntUIW507p5W?=
 =?iso-8859-1?Q?HGjk2knoUOk/YZ3LI8Pj41tA69HGIChPHXeZUSGyRgIaHLmne964493U7o?=
 =?iso-8859-1?Q?59CZ+dA4TMMEGtJWtJoBmii8UkBigizZJG05K8o9T9mneXobECXG3dlKqh?=
 =?iso-8859-1?Q?9sBXSUI6braJahAyzVwe2ymLbAJsKyH1jwPbt7W01zDXoATxRo2X/VpaxJ?=
 =?iso-8859-1?Q?wryKNfwABQfvIFiqUgErYvpp6wPC7+XII8XJL0S8nOExvcb0lg+rrfecT/?=
 =?iso-8859-1?Q?il66EWWMaFL0a6/CafltRs0/PDb4Nm9euXtim1dN2Q+V6PgBnC1BhgiEdW?=
 =?iso-8859-1?Q?G6bLTLaRRj/wwamguLMO+Uhwo9t/WOuC9hL8fDy1w+RnB/8A9zhfJl764u?=
 =?iso-8859-1?Q?++mB+JRIgFQbeSYQML8XBJVAaaEwyrC1AWC5mfDQk+PlS4Lun54yv6RsWV?=
 =?iso-8859-1?Q?LLFZxtX7FLYYDVv7yNGFB5XCBvnKTBXbxsmUoEwX9EjZVOb+te1GP+yruR?=
 =?iso-8859-1?Q?g+Jx8Htq0LXRrXVhSyHGgmz3CgYgejSgxNyanwQsUlNsH4NJwkBzjljZrS?=
 =?iso-8859-1?Q?dd2rI6DuaP+vk+v2ad16DSMAZ3x1f6jV0JYcQ7kLG/hg1Kdw5IEJ5AAeAR?=
 =?iso-8859-1?Q?k1vG3kpZeNIoBBPPm/Rs/3i0H+eIJbIpkuE4EKZSWoHoqQRIcp+lWoViK9?=
 =?iso-8859-1?Q?OhSd60AqwQnD0SdZ3aq3X/Fk08u8nm4rold0fTGw38yNiD1O/tTUsReRo9?=
 =?iso-8859-1?Q?gRMeCSFiSNu9s0L3bSHQEsyeMi3ZndaOjkM8hUPEC2E6FjpLi0tOFYEjae?=
 =?iso-8859-1?Q?EU8+fE90dNW2X8d7RPxiVsG+mxCLV1LoV4QuFuJaT0mvcEZrw+eba5ypgf?=
 =?iso-8859-1?Q?jkLk4vQ4mCrhhQxHl3ZC9R4RXT0amCOS/kHTamX25ANfcxXTzgfBVmrnIB?=
 =?iso-8859-1?Q?7a2+OLnVpPzbc08yKbbve+1vJV60IPomKig5QZw1Wo2WxwZRdWiGGuTLn6?=
 =?iso-8859-1?Q?LLrzqHtc3Jxi4+UX3tE3qvmkpOkQ9BoCas70kR9hslrXuoIwD9UKp+URNZ?=
 =?iso-8859-1?Q?jv99C7AYxOXHX03v4ahEotFTLyIFZPR6/LyYdX5tlGFl5TLnYaPfYb4mQZ?=
 =?iso-8859-1?Q?GunQ5XcaVSJaTywgsDXh7wYFRD6OY0elaZiklVmct96kng7n+nHKqgamgT?=
 =?iso-8859-1?Q?z5X427ZBVqomkmSki3hpTpf7mn4OhX4+S5rcU6nagGQhT8bDZA5MWeYQuX?=
 =?iso-8859-1?Q?IYvAv+xHtN50AqgkQsRsxXcL6C89HVE5gcLKO2wyHxfhvtTHyjL8RM8Pip?=
 =?iso-8859-1?Q?WwqwgO5tL7eArzYtj1X/Ip1iKjpb1CNySwaEl7H2kFUG8TJFyrJSEZo63R?=
 =?iso-8859-1?Q?pWWjATKC97ibk4vOKN91vIqyzJarJTKrIRaCgksSeRkhANqcwJfyjcfg7M?=
 =?iso-8859-1?Q?eNyisHDpzZJxoXNhBXW+tv+TzqXfCE7prbbx23LurtJw8PgrWbqRv2HC/i?=
 =?iso-8859-1?Q?uLf7rran8rtQYXR3xlVA7wZD3s4+y1Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mOiydqtdPzwdg0b2FZByTVOD+ov15gdr3lmRQ/AIYVFw0uwbPqEC77t4KocNNqE8+NQZsmfUwroonCJBC4GvOVNXNUOOa4FgvF8Eck1S78YyCBwQtbG3IhfWCKedfpF8fuOwAi5Za/fr8xloUDJK/bKb1YbKPi/xG0Lg48QW758fwg0pw6Nq9DiAuCOOFKs9mJixpRGFzQCvBYKr7RSrqLuMyTDo2g6zc5vUla2eXkLofryo6PvliPBFylDspa6MB28h3bfE99Yw8YzSpTCGXjX8q4fO8WDISwKfK4y6vNSJVdaQldZsAbUHg/bpa0lltz69WNj4p6Z4QVwi7FFLFw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03b82d0-36fd-422d-ce59-08dee723591a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:53.7579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EGOGaGIwj+IDZ6GevbOybcyJWM/KCSrGAxsLyXbuIhal5OvkjhqlQ4ubDaf4YNg5lvcTIzRwdl6K9UmVt8tMYYE84TGedsHnKHFOI/AW8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX3vqBUo97ntpM
 N+kK9OR9vw2pp7H15480bU4noaYE92qIuzTZzS/w9hE6sIDkrN5PXoJe0VZN8GgmtuNG/BG3eF+
 rhUNI1eV4Ejm9wOpcQOFuYvTtViiohk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX5W3rgXbuu0+l
 Wkt81g8bkFAzLRdDosywr0h4jrLUOqfxI7NFyfuNER242wZQzXW+pNt4v4y+9m1ZhmMBYuQjXZV
 zL1HkkrQlWaCwgB/eAg3Phibm15D/dTTJFXo7upf6k5/f63rALrmKd5hwWxNBmL5YbpBvZ9cG6W
 Mv1se0Lsl211IbMoUshEZuRhATfD/sDtkAPhK96yH5mYUZPiQ9i3dgbYxZbeyHRUL4DctJdi6M0
 x1ndh6B7ZhCOBo++d4MMRO4RhEbctFD9qq61MIcpasqJT2DrN5FpSXFpguTOhIoZla8Vk2P4e1P
 N0/CWyExVrw1ZeHarnKiFbxTxA1hd4YP2g0xF7yol+vIGe+2KKtEwZjOZwG626B6nT6KsZ8ft0F
 WyzyL9sLFQIE65HAa1/OZE7blGqU2S2ns4RJ+q7mSKL6c2hFQmN4IxA4pdjlIOEkwv4TNLUZwWu
 VoYKCvBHIWS/A5jNB7Q==
X-Proofpoint-ORIG-GUID: Wwj6-SWZFDoqxHYyvu7agkrTJ6OT9QL7
X-Proofpoint-GUID: Wwj6-SWZFDoqxHYyvu7agkrTJ6OT9QL7
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5f6590 cx=c_pps
 a=0mOrEJ06uaCo+Tyi64Ng2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=kwlPqA7JoD2zeNbm8cgA:9 a=wPNLvfGTeEIA:10
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

While this isn't technically a bug, it's highly unlikely that the=0A=
server wouldn't be writing an entire struct.=0A=
=0A=
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO=
")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 8350bb2c01..3d12e8b2a2 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -165,6 +165,11 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
     }=0A=
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);=
=0A=
 =0A=
+    if (msgp->argsz < sizeof(*info)) {=0A=
+        error_printf("vfio_user_get_region_info reply argsz too small\n");=
=0A=
+        return -EINVAL;=0A=
+    }=0A=
+=0A=
     memcpy(info, &msgp->argsz, info->argsz);=0A=
 =0A=
     /*=0A=
-- =0A=
2.34.1=0A=
=0A=

