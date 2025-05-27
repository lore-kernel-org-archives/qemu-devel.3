Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C56C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJrAn-000524-2o; Tue, 27 May 2025 06:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uJrAc-00051K-KN
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:04:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uJrAW-0005iq-NP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:04:29 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R09X0U027840;
 Tue, 27 May 2025 03:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=40kMS7Zf5G+axU/oLvYQWx5QsKOYXBoFakbEydM94
 m8=; b=MS0bVDui11OaKAkUpdUmVvV7vv2BDhz/MIk+89enoQ5wJVJZhAmzwnzkJ
 kAAvdk2QnFQjSz0gv2ksbOHf+g2LJgQqRyyYpEyY61el57DecS6zkuQAyFxXqZjv
 AD33SfZTVDH6FuOfI2Ztx6EW23BAwrNI1Zxg0VuLccvDoL7j09H9eW9yWGw1WI44
 koPFPyYP+SEtLsy0Qjo4t0T50jOplXUVqu0dg6EE7r0Gv32DiQm5yWpNnn90AZ5X
 uzGwOyYI+IUWMcyjuxXUwAbFwFynylgPv6UKgC6rYbAcKNLvDrrzw68FiWjp7wis
 acrYPp95qaxcEaADdiz0/83OVnigA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46udec5bp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 03:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk1WCaGdMeqLYppalzIIFQd7upIgNCyCGO+6mE38st/HzVZqyu1XIMV2smUKg7Xdz4KAtt40ay1x8faZHlVjTfLIL8qeieMa9yGP2CbrCGbAgh1sw5WnkOrsEE10tWQobqXqrDJt5JJul1sq6yTaKZB8ZG4JTGhcEyuAQv8l2yvtPD8eUY2pVi2/sZ0SCRllv8AO/9LTq0XJQTbC1ov6iRTyVQojMuT4u29b+5ZW8cx6Fxh3YEhS0MypEulLXOMjpvczN7ic6KuVw7/dcSd3v95Svrhb6wjUkaONYunOblbO/L5rPXhVe0jPrq7HJRMPWcoM2a+nT8ctSnKRZrChAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOhaYO8bnk2SXioBOYTlRU0Q1cugygogeodgzKL/4IU=;
 b=gdFrZJq9vg5G4IFLxX0bD+KNx7ZF8BgXg6yERZBTdwQcPMP1cj7NRkMTT+nKuJpcr8KM4h3bop6Iq4oi4MaE78bAF3zteAo6yseOyfAANvXvtmx9YzxKH1mtEOhyDGINocaOb96he9uEZrfmFMe9dk7noaYOKXezKYmg8qkfR0Sx7mskBbhcrs5knFeHskXDkrO8h3O5L4yWCO+uT1bY4jTiPQSix3vZFs1M0NiH3kfrH4ooHzwpn9e/5fvvOrZI4xHoyXeriaGviLR96RMBCKRyHnSVVZXQobc2FjCQbQI0PQFqiCeTfZylaxixOHrUFaufFA+o1f7admafH8srBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOhaYO8bnk2SXioBOYTlRU0Q1cugygogeodgzKL/4IU=;
 b=vNSnuItCxcybLti67kdJn2nWBVdV6ihdGw8KwWDqJaoKxmqws/vpCFK/exI1DK1jVjcWd93b3VS3SndrHVFCIcsr4OWEhmCDeudJtKtlanmQiLwO9pty+IrDb9v4BfMnJCh0YLC/Gljq65lqZpaSErcaVh9DWhJdeThPwzK6Wg5qiveQQF68kxnTLtwYC0qfPzAFckhVMUZXy++3vtanrVYNInRJLUVNvXZ3yAAK6wQN7KXbFiDYVLCy3/TJIaCcSZBANR+KLpsCY+bOMpR6PBbqTfpFnVbA9FZqlWq7ODmtf58upUgaBrSdtlIN40XN2yCeCBHbrlxs0t1giymF3g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7541.namprd02.prod.outlook.com (2603:10b6:510:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Tue, 27 May
 2025 10:04:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.019; Tue, 27 May 2025
 10:04:15 +0000
Date: Tue, 27 May 2025 11:04:10 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 00/29] vfio-user client
Message-ID: <aDWOGrQ7Qf7BfBjm@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <ef917520-09c6-40c0-b432-b500f030a2c4@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef917520-09c6-40c0-b432-b500f030a2c4@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::13) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: af48cb0a-cad6-4bdc-0905-08dd9d05d602
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hUPnkdGfVQA9Bf8SUqKWNTte8tpx84d5r6boLK2yMN6XPKQtsYGVM0nSFB?=
 =?iso-8859-1?Q?y9TVXmgX0XyVuH+DB4/Sbp7+keG9zPmYoWCVTg+3CEUIbF21WCpIyRM7DA?=
 =?iso-8859-1?Q?7uHHfFnsbOO3xaTN0Q9rbPSj8FKO4KLxGpAVmI2GOlHPT/KL0Zl2fmO7e6?=
 =?iso-8859-1?Q?AQmiWtQcBvFX6jIKcYi38y062fqIk7rE3smEyWW1bSnAzF+IiOCHpfot2h?=
 =?iso-8859-1?Q?Aaxbj5vjGrbpQQSTlQ6SsOs7NZyJKKOSAQKd7Hktugg2CbxAISp9NuwId1?=
 =?iso-8859-1?Q?PtW1x33IVhSQKIg/vEoHGrJY/UbJPhoswIxHwhPeMUTG+e/jlj+n9e3usV?=
 =?iso-8859-1?Q?PC0lz8qEZwm4FSDQ3qUqElSZWGjj8jgzbS+Q3I0hoEnfwDCKBgcp6vBJAi?=
 =?iso-8859-1?Q?mEz3tEtxRgBKWq8X0VEEkryjBUkzAiyU86yTGQPt6WWbFlTlrfq4ok/UD5?=
 =?iso-8859-1?Q?57FzD7/BYd40aK8FRUk7LXrNrvJy31tOc4AtUuADoB5B1aCXU1d9nJ0y9a?=
 =?iso-8859-1?Q?KqdETYXxijMScumZpNi1MKjGikxtxiz2NGDfC85JVFZ93OatxLNuFt2wto?=
 =?iso-8859-1?Q?abQ89Rf/ik3dhKEi8IVlb4w44kQuFggs2LkvbCJ5kMJfGFYe9yOQZDo11S?=
 =?iso-8859-1?Q?u3k4PY0q8irCYngAYHWd9bQTqZmV3FdYHu1IkARyIcxYI/qEpEqkmyV7w6?=
 =?iso-8859-1?Q?CZiliqZOcpOEb/0hwHI5Tsyl9bUk7KOAjYlMOdJeR7pWlAy08I6IVqSrGM?=
 =?iso-8859-1?Q?9ddUdYm8LlI5S3XV656U/HccaRU8PLGrDeoOoipkl5fDgzszDvk+Ln8ohc?=
 =?iso-8859-1?Q?7zzSgP9NREzfGVGR8d7AQ3mrd5ivNLiap7NJPfTDAHxwLwjte5lo0w7VOG?=
 =?iso-8859-1?Q?V8DU0h9+3s12du4ZkDKuqpbmvJ9nhcULdq1njxVsMDJsPruD4N5+Va/k6Q?=
 =?iso-8859-1?Q?uxKgoARfTiasQA7bwQbNJYIxO2SNW4vBFD9fGZ5Ytv6nLj/gNGQdrrbcTJ?=
 =?iso-8859-1?Q?bMCEjWWwIndY9VkMMu6v6WNoPntt2/suutSCsTOQfaFJjBlVdEzSbSznio?=
 =?iso-8859-1?Q?C7N3smrl6984+t8ZDsFzQy6whqrT2voh1Qel8NBf3CIG2dmCyjXAUIjTJH?=
 =?iso-8859-1?Q?mCt6nGM0cTSSdfwJQYTuW4W9ZerLrUo5Qn3mkyUdwG4fP+w2tt37JqpMvv?=
 =?iso-8859-1?Q?GI4Zr+k56TyV5tASV6JJWnVfL2qlBMKGeAVjZjqBMt2HGIrWK9ZktAcVxt?=
 =?iso-8859-1?Q?Lh0vByd2hK/4CzQQEI+w0u9o5wVuxTzZNz5aXdB3un6YGH0jik+0MlTDFm?=
 =?iso-8859-1?Q?oQ29cFPV+O4ouVLlqqUUs9Dt6OoR/ROkApfwbb2PhsugptjZKymsbjLHvP?=
 =?iso-8859-1?Q?raGS6mVK/w5NZee8bLE5wnbJx7Pp6KujFzkQ3JjmNa/vRfSfPi/rf8eAXf?=
 =?iso-8859-1?Q?lVwSQTrQ2ov3JCtNXre6HlSPogB0uHJXDCxa5YUzey+UYZKQD88a0WWWEs?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eN5oOvrZ2+P9VVSjgfqGZasZTmr9axCEm9HTV66dCuboGd7Vcna7Tvr4W8?=
 =?iso-8859-1?Q?krn1PP54EJFqT7QdsNFIAz2ZmqTNGOAXRXUpg9EYkRII5y3UhL0Ag9awU0?=
 =?iso-8859-1?Q?V+RAeSiNNcWmfHGjC/SzwqFch4KPbrKO10XG77t5VX8UUO9DzhO30V2v6I?=
 =?iso-8859-1?Q?0TpeYBmDS3qc2qgg3o7IwMnznxr2+tmr6lfA+lH2GOqNTNki2/ZIF4tu5+?=
 =?iso-8859-1?Q?mQdcRunxcNnjDZL7KIBhbFg0fp7l4VYhys1uzP5/D0uC8hozRIRIDXSykv?=
 =?iso-8859-1?Q?Kyy6FgNThHcjwTP+WkUm78nyBv0KaM9DnmnMy6oRB+a1shlZ0UTddx5GYc?=
 =?iso-8859-1?Q?UG62cGknPDbcUR+1dB+bbCQSZ+76l9gIzRvPiM1Vud4bywcIOG/es2qV8C?=
 =?iso-8859-1?Q?YRobQLJq3eb/x1IL6l5+ZTcF8YF7cPOaZDRAGRarygxDaLP6iPaeZbP44b?=
 =?iso-8859-1?Q?tV8Pw+7EgY3QLockkknMVTDa0L93eq6trtAAcvhN3H4kw05txuJvjg25Z2?=
 =?iso-8859-1?Q?1i1jZ61fQEfUpRObDL0dVLUDTkH2ch0aCvK/AtrumQOGc0mNOMOxQD3D59?=
 =?iso-8859-1?Q?pgvZlIBxCm46Wu1DphEqzxEOt3LrWCVHcyQr3S+oD93/NSZ/2l4J9MDWcA?=
 =?iso-8859-1?Q?J/4Dz2U8tZNrMllEFOqQtL+T+WI8Ntpzj2LCay/wZ4InDxP9dx60tZMckW?=
 =?iso-8859-1?Q?3Ws/ZLxJiYbi46BxAO/a520nXmqLTPArczRG/xUI/5oZlhUceUcYaUvv+Q?=
 =?iso-8859-1?Q?MjggOAg/TpuifY25iw2s221ospzXlypHbnirEaI11uyNvId5uwG92VrTzP?=
 =?iso-8859-1?Q?S3zzY2WPPYUuN28ZHcCvPWCMXDUz3VrLGnvg6RfBzRBQ35Af0NY0r4yZfs?=
 =?iso-8859-1?Q?C9J6ox9jNnwdUE0ASZc61I3rR760ZSiCdXCnOWCPCpxcQRgWQofXJQyNia?=
 =?iso-8859-1?Q?RieDKYRujQ1/aGejx3cSbrBCNacdxW9z1re7EAD2bHqZSRg2dBYmQdxbBo?=
 =?iso-8859-1?Q?b+QMqGi6g/eg+dKZXBnC1AKSzrDmcA01qrCThTka0DDOrwgtxox6+occsq?=
 =?iso-8859-1?Q?dpjT7W1doDt5qgM96PK1xU3GyU5qmNoRQFQpVGqEE/CyggSMSlRJhH7DRF?=
 =?iso-8859-1?Q?sgxG7FoQy0qaVVfNRLEacBQq5/CfsnkYgqaCjsTdEqm/c67eOMyB9S+rsX?=
 =?iso-8859-1?Q?Ri1kqvAGgmGn0kjjUCPv2/14UxxLE8OW27V/U5lXmaM/ruIfJJMB3DbWSw?=
 =?iso-8859-1?Q?3TPSutyXK+RMVbC7+ByHHrBXnokjlljbLhrgIR5bKnWRlPpYn1IRiRM7Nt?=
 =?iso-8859-1?Q?lp+Vx+IJeMXp0F2E5G7yCOkREkmBYNWeLPDJAlLP58O7OAdL8gpE4WSNPn?=
 =?iso-8859-1?Q?SwtcgJzHxiANaizDW/3haySjd9p2uiKhkHuRl6HdposWGG3jIk0PxuF4wO?=
 =?iso-8859-1?Q?qy9zra7XvPOqPdEzXaJ5xOsyuSLl5t8EUiWsiqgAGnUSTGJ/5xWdkz/zPT?=
 =?iso-8859-1?Q?QnRntbwPoV1BVgY8K1GriiNSbr/ekji4MdQi8usYfVW6RM19h/tBJo2h79?=
 =?iso-8859-1?Q?wkIEXpFYvUE2YDP/0Rnijd21isK0aLEHe8eObeAVd0v0yJB4T0U0IqJQD9?=
 =?iso-8859-1?Q?Wl2dfNH8rzBEswMpNW0d4aVVA31Ftsa86z?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af48cb0a-cad6-4bdc-0905-08dd9d05d602
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 10:04:14.8824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4sKYmy8nfQXfKIfbKUlbbWv+uD0xJ+ls3ibulu7Zo3BRztdiTiZGK5u+iFVGmT80PAmVSx1PjRiqYlqMAJ6hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7541
X-Proofpoint-GUID: GI7_XGPVQcN5EZ5WSSdrMyyouwE_GVtZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA4MiBTYWx0ZWRfX6XPsICGsiPq2
 pBzMeFv/VwJ+Mwj+OhE+qCCzVfgHwTKXR49UUZbNYiLHJHiasPWShisuTKCU7bAp1He6P+55P2v
 uxaDRsP4mz4vjz4iAm4njNm3Yzew8AJ+shiHf+uaIeXSNjA1wLkCNksoFjam0eUio2OIvvoGEIy
 86vblEv6+d6mkfIHGn9hgp0qrZrsveApNDc0yRgNWQzJmPkHnEleVUxld+PPbcMz/OcU4RrK0j+
 KAGLx53LIXEVvuCZHdEJ7ddkFLJuosbKnFcU4jf0m40kVA9B3u5s96B31+O9grvFs7N/6GIIqiH
 a6ZH3ztEEAJg787JmFx0DD9SIpUC3Sa3eEgAgT+39uULgQbFodFiGA5GBRm+07FHLQHEBp0xDbj
 2KFnFfMbWJuugjyE0xO3vC0ZeDmAr6qutvKEiyM8Kc6o+9eHUQBiFDgfSG47dUy1/yXMLc6v
X-Authority-Analysis: v=2.4 cv=e5gGSbp/ c=1 sm=1 tr=0 ts=68358e24 cx=c_pps
 a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10
 a=JtJhbtMZq-o181L33MQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: GI7_XGPVQcN5EZ5WSSdrMyyouwE_GVtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, May 27, 2025 at 11:39:48AM +0200, Cédric Le Goater wrote:

> On 5/20/25 17:03, John Levon wrote:
> > The series contains an implement of a vfio-user client in QEMU, along with a few
> > more preparatory patches.
> 
> I am planning to take first patches 2,3,4 in vfio-next. The rest
> either requires rework or conflicts with the live update series.
> Tell me if you are ok with that.

Sure, I'm fine with that.

thanks
john

