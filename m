Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA2C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yv-00089f-Ks; Tue, 21 Jul 2026 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yq-00086s-Up
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yp-0004lx-8P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:00 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARAUs3215317; Tue, 21 Jul 2026 05:26:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hKRZx2MAIFi1tv4el2yhE1Y4l+uM5iZAVyFWHrf/K
 1U=; b=Z4K9TEsNjfDRvVYGo6zBMay1xrSKH1lbtjhhOQISBpY2g2A4BAT1T4RIv
 YBIjeFTbK7Qr8vSIpVJuf1mk3QLqFV9Pmx1tpTfwerUyt254HiRHSOBv+cOS7603
 zGWqoavtJJ03LYYVHOVOytYKzNMwo6MUWKRe0orHYmU60PeDEp1pd+syjJAZ4nyg
 zOCH8K2d7H5yoq5rJWLOiDFIUArselH0RhOY1aaz99NT27meXdBZe4Uj5wR1HTk4
 RNLQX00Zfei/6yjBnoV29cQ7o7xF9mWzey2nIMBTrimxiuYJtducO16Ef0kZfjPC
 b+wfq4kyGwr0n/0xlV+JlmD4Gfzqg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020140.outbound.protection.outlook.com
 [40.93.198.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8eeebs2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcsxynWG+mn1YmFniMWMIoIlC9Pr6k/ePGFzgZcsJ6lrJQY/75kgW/fDdfU1fLFg3c4+WnmrpHpmT4rtvRU15uJzbTgBQQFGByehJakqIGe95vsltsyd4M5835pDDUZBYQan6p6l87J/ixP9qdYY5NdubkiPeggmzThCdR82rltmZw8DP4QHC+XovT9SqHanf9Two4UoAex1EyUtQ3LKPKfVKQF46RJpO0+CnAX/iAmR/a3x4vES3TpZwfTcHGwseCzBgIFDEhMIgNRJ+Q1Xx83g84afUhPEP4PievHwQdAUj83MvPMMHrQLs4UpqtwudicAiEqtz5jGiCETIVd93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKRZx2MAIFi1tv4el2yhE1Y4l+uM5iZAVyFWHrf/K1U=;
 b=sUyq0ervHeiyId/F6nA9hWiGIhQuqP1hXX5aPemoGR0eWDewzrNFHODslvIiikNEkr3x0RK+zvAxeOyvrXX4v9uaG19nI3Q7rnkvE4F2AaaSteR9OMo48K+n758+Trf5Icly4BV2COG6vzjep6rqgqNb94G5ADwhj5cIYb94jGVpUF3D0BXS6tJYlcEmoqr981GzDG4kYh/c/3Ri/jfhcw8F1/SgQSK5jlhayRl5mr/Z6YpPfaslkNSrkve+uLitz0Gi9lAbK4N3BPYESrJLkf0RSB0gNaJ6vB1VFCzKv3M6MFxxQ9aNY8LnQMSfDq1ndfPrbszF6zjDiJJcOHUngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKRZx2MAIFi1tv4el2yhE1Y4l+uM5iZAVyFWHrf/K1U=;
 b=jkeLLQCL+tZE4aguDLwmKaZ3Xvwv6JvAd3+um0XwtklEq2omsOksiF0MaNURglnguBFOtW/+ac0lO1M9/qBpOOhTfDLWfssQyXuZEKJuD5J6yuIuplWdAORspexuEMzAXxfepJ5vIm4Cu1/yXvGIiRMI9+IvEkcieksb0Tv/O2iT4nDibbEmYrJVrqmQo2Ir0dNH/dAqiV3X6j05PmG340mpSf12N4SxiwkKIndPksW+upnM5Uhk+wQDWOWXlPdjVK4ADZmPKjGMP+dWWOR41b24xNZYSEFqzCM8l4XTJFcrz/cdpjYNTz0EKfcxkH0BOYsJoT/cbC2edpmsa+HK1w==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:55 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:55 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 4/9] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Thread-Topic: [PATCH v3 4/9] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Thread-Index: AQHdGQw37tRi5qNrdU+sulKs4rQGMQ==
Date: Tue, 21 Jul 2026 12:26:55 +0000
Message-ID: <20260721122643.30985-5-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: cbc53356-898f-40a1-7e7f-08dee72359db
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|6133799003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: bjikmcmfP5szq6GKPt+1wntjE/LLBHmPcrwDGd6jH/++QYT1KyC5SabupWZIoRcOH+mMJ9pBeHUbXTPOwI4FA3wEv87vk5fSrfHLmHCetj+Ov75tpplEFUQC0t8NL9B8xhQXtALX1TvampcytcGCVRjomKIX3jcqSdISlLFn12Rc7nTWHDio/eH2tkspWLbx3/cRxLRZaeV2y1dbo5vXudxVIHSYHPUGIPjLJ1okxTSy3UvdeipAFhXBRYXpuLBzck6iAxJqBDXlOoGD9oi8SFyCfbybKlnMPxG5dDjCP5roB8wStjK+aABeRbp/6J2/rwsitTkajZ/VH3OJUputNvvGUAS8XWYhzVobA1/svk5GsXTDNPm3sNBRAwtvfUjx3RY2SVRtl+CsJ0SzqECDKEUvsFQS2bQ4hMAb9v0aGCbz+rupyBxSaiJPjCA06TZ8BhIa0MuBer5sKWbE9kTUJbyPKkgM0Dl0UwqAVSf3C9Y0GG7qdL1mti34Y5nq6JE4bfKHnaT1ND9JVRAIGFpWgu733r/nkfSptJkOEV0+M7VVP+ylNFoH6T0Dp3HYHPOh6GRmaEiw/37EaMnc2moTnDPLyjnnsBfuvEWcrTsETVCOz1JIhrWdj7OnFPY/2G0DvS/9hw08l3BGxujJgpVu49qntL/RKdS3zqHwChTM7XaVnacHfg+kDGmaaOM8GbQ5y76SzDxjyiXLOwh4mKGjIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GWAf4FgQWElVEIUDYEHxkPR/m59KfhmUO/vALmbIJwd/sOORuixHZSXAq1?=
 =?iso-8859-1?Q?fzq/EkHrGmHQDGeV8aOL9po8WFlUkFkhG6TUyjuGks+otwlTjS81F5xDF+?=
 =?iso-8859-1?Q?O3B/kL8HLGnnNY3NvXxaIHFVGGhHjEaYWmAzyxGSg4fCeWfHkXCEHzEFqD?=
 =?iso-8859-1?Q?39AXetEsXBt80mjviUGt1jdU2zAcqQ0r3iy1HW9gm+x8RL4g0YU7TBIyi9?=
 =?iso-8859-1?Q?5yLbPKU0cX8hfLga216ZzyETZ+5ZzNDb2sCM+OEZ6Yrj6SQmaaLs9Xs7wO?=
 =?iso-8859-1?Q?P3RMV8FqtVzj0RkNUPavwdlQtH1D/IUJr+1xy9S3gpBl0IVVLFLldLsu3h?=
 =?iso-8859-1?Q?2trrZCjoFR1fIe/T96MgsK5BncKmAiehwp7LLw1C2JAKFwLYJ2bwVLAoel?=
 =?iso-8859-1?Q?f8qD6SzP6GmwFp9pm4W0XsfjmejoA49kWmeeyoCEgipgdfKNeOUPmgND6W?=
 =?iso-8859-1?Q?R0YsNkFIUhF5GcxJS72CwPhlO/GaN21HigIDHkiXeQcaRn3IoM+D4HtM+4?=
 =?iso-8859-1?Q?YCdfKj8H50/+xauSmbPi3Q17BnZKEIJH+mHjLZDLV9QUu4/ogxgf5mqbzY?=
 =?iso-8859-1?Q?bNKWQ8iKUZOjTlCDf1MDb6/I5qUH0QERxGGWUjMHrlCd9wbfaljlm+gURU?=
 =?iso-8859-1?Q?6x7DUiXRtrYToJGmBo40PFjmQGfJyS9gq1x5M3OTnn80sOJorF8kZ92TJ9?=
 =?iso-8859-1?Q?lrV0rvPXW/egA8jKPYeLwJr4SY3Sne7ZJa4SPmh3vBKU06lBftQrIQKeDy?=
 =?iso-8859-1?Q?9jXJ01pKoEQfVk191zC6s8uTR9WYouxIiPrhfu0XJj2MK64lmPGyUBbLDf?=
 =?iso-8859-1?Q?Lh2ZNrwS6cnm39N+0nZV3nq95zIB1/nBt5tGMJ2hzeVI3nY4SSpFpmsR9C?=
 =?iso-8859-1?Q?HUDT2juIDesDVZZlDcX440UQHZFO/0AUkZ8v89TFFbjau4cCQDwJZytm9M?=
 =?iso-8859-1?Q?x0zEzRxfbR30Mz3TI1caK6EhlncFxDeT8VR3vkdo6g3b7AFfi9/PTkbJUU?=
 =?iso-8859-1?Q?+/QD2qMNtvS0TKh9QWizKhbUHE31blqF6itrREPYQ32Ua1igfDtevXgv4c?=
 =?iso-8859-1?Q?tDL9W66MWzZ5iY9E13UU8Z0fh8zcf7GoBhwC6XlpUepMCIxxKhnY7FDClf?=
 =?iso-8859-1?Q?9vY2IV3UWLZB9JOQ0xIHrQkNxa9/tkLhM7X0X6Uwpp65yYYldyL/NEzaxa?=
 =?iso-8859-1?Q?07gkLNgtCXEQF+P1MV+RKms3aH9pxLAi92hEsWmYiwyNdhe322KlDU9LVs?=
 =?iso-8859-1?Q?eN6krSkIfejG0Eu7tnyLvf0Oll1vax+BHu5WfMBZQqfnkOHznBVyFu+NM4?=
 =?iso-8859-1?Q?eo0j09cHCqIR7YFENkqB4WTy5V8a0NWe1CeAI0woYVqqXrDeGpfDkGGyTt?=
 =?iso-8859-1?Q?EBfDRaSIyvxHMfJmOEhwiT5jT5u7w3zr9kxBV3dJHsaV6UHtptF+dvLpuf?=
 =?iso-8859-1?Q?+tT+77JZ0l/e5dBW3n0m+jPFcmcFgZFhsgp7n8+8U7AOUh5nglVyVll/IC?=
 =?iso-8859-1?Q?VetpqdbE/zRBVEePoztU78PCN8TK8MKLREZq8jRfU7Qe6fadnd4MNQ8hpW?=
 =?iso-8859-1?Q?qJf3KVFDrNCucwXPkzc5n+b23ZfHL3Ub2oKPw7VqjjS0BwJWP1OpCWNZeD?=
 =?iso-8859-1?Q?7MTqhDHN2eqoctMJ4yLN/Win2bmD9HKVALj9BnqkrsZ6ELEgnreFHFTqHf?=
 =?iso-8859-1?Q?1CXXhUqCjnKltImv5bV4EK/m+25soS9MqPIXBd/H7teLxfH3WwZq/2hjZI?=
 =?iso-8859-1?Q?jEa5m8lEsUcpxqa1GDplnT9OdNuRRzFTNd+GiZhwjO0QiPTBdPw558o8ki?=
 =?iso-8859-1?Q?EQMziJu2eou/dP52hjEKe0ziB7PCwrA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aFgvWEtXIvLjAi3Z8X1hYpvc+Nw/h4cc0ouBJoW++qnIr2vNgu/3G+4psY/552ShPuQw67lah6a6mS600LJ+tb6l/hhPgQ2Ik9adlI45Xj91qFfxzTOeC0L4KbMF83PnT9lJv9GGjmbR3m9iQRF5k0EbY0kunsiMwTnTtVSMzyY3Nr5oRNqANIXmREWY2W9/YRXWLRJJDqZzporIBKH7LZb8wXA0VNpsZCa+5TWk3uzIfFHf+dBYUGOkHazNQfro1RhyDxCFU6wqvbaLrYcpPqz9iWaQ4oM/gduhYRVhKw2iu18lTAYqmloiRhoTgBG/ARtZLwrc8PMU/6iVnfO0Tw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc53356-898f-40a1-7e7f-08dee72359db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:55.0445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FO3Kn0GNlvmZEh+0zDhdWFG5VlC5ra11MO08FqGd4JBC9kT+agvLyto9DQH4q+EpxHvY9tr0FvNa9IPxPCQbXwwpZsGO2Zvd0skjq38El4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: pklShFR4GjSeqJUtSyO6L5iJCENIvtY7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX0Y4VgY8D+z9i
 9IOZmt3TFNdaWupKYKKOf8wtbU30zIblta6lPtDRGLI4gGg3as/QBybepICDQGoYCQfFRXHAUKe
 N2DgSFURIlFERr8BGeadHbePB2injJE=
X-Proofpoint-ORIG-GUID: pklShFR4GjSeqJUtSyO6L5iJCENIvtY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfXz0l4tD6FIVEc
 ombuF39kZsxUs1tlvwlZ9Qt1LRPNUieaAWyE4qPx0Qe0yJSTDk6hGpnMXHcFidA9kPS3pJhzCpN
 RA4KQeegKyKGkKcnck9noDdiKukLDHsW4sBnC39CwC1DN1XOFjkX79HOaQ3CaAajsgT/5EoWLoG
 6h4XAcqYUZIjOtRZTSfKPUb/m8ufnjZxNgTafBGd2yW5rok38MLkI+dbDe+dBKEcOAGf2B6LKsR
 cojYnbDmKNITYTDxEm2wTc4mG5DvQoQoGhFbv+dQXzYytqOvmpj1IlzXJqQF3tsQlMD24UaS8FO
 EIvzISvGkIKfH0dsR1XoZhs76tVeUjtEAGDP+sw5CnAwU0a/93l9OYhZ5SG4o3PtII3wMuvCHv9
 OBT+Q/QObDh+BcmGgLdEfTE+4jjVXJ0fyshbYeeMY6p6BwNE5AF8pscKbClYq3P0WflhERfWsXO
 pAS9hU9QhgZcnm8PQow==
X-Authority-Analysis: v=2.4 cv=Itgutr/g c=1 sm=1 tr=0 ts=6a5f6592 cx=c_pps
 a=PBbaNSpV8Z2umfVkjBDg/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=64Cc0HZtAAAA:8
 a=lJFH3X02AGBvrhoyKgEA:9 a=wPNLvfGTeEIA:10
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

If the vfio-user server responds with a value larger than max_xfer_size=0A=
vfio_device_get_region_info() blindly uses it in the next loop in=0A=
g_realloc. An value larger than max_xfer_size is anyway rejected by the=0A=
check at the beginning of vfio_user_get_region_info(), however that only=0A=
happens _after_ the g_realloc, and if that value is excessively large it=0A=
can cause g_realloc to fail, so check it here.=0A=
=0A=
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO=
")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 3d12e8b2a2..008e5cf687 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -170,6 +170,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * The server can respond with a larger argsz in the reply to request =
a=0A=
+     * larger buffer on the next iteration via vfio_device_get_region_info=
().=0A=
+     * Reject values that would trigger an oversized realloc.=0A=
+     */=0A=
+    if (msgp->argsz > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_get_region_info reply argsz too large\n");=
=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
     memcpy(info, &msgp->argsz, info->argsz);=0A=
 =0A=
     /*=0A=
-- =0A=
2.34.1=0A=
=0A=

