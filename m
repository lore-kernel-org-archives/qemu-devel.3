Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2EBEA3C55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoXz-0006Db-Qi; Thu, 09 Apr 2026 08:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAoXv-0006D2-14
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:31:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAoXs-0007Wt-H8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:31:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397Dm6s3196937; Thu, 9 Apr 2026 05:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IJF+aXVPZvLdqSDQMe/zeKDjEfdNRolH+JpdPytaL
 kc=; b=qZCbzLPsbH7KUY2+zeSfgUfjJE+FuAyaufKsBrUDs5omUn99InyTdq3lT
 bWEx7AUYswy7NnOsZK3MkMRiByoTxzYjmg9c3SLdu4DQzSQcd4e/m487A0A15SWD
 TYfRj6WnbvOlO3qESuiLeUenUc3IVnFeIcW6SV1weEImPzjYwC4f+ngom1Kx+nlZ
 PY94COz2Kl7dbApzowdgAZ47C6hanfZrpixqFpqxWt59y6JAR/wnHta4ZWHhnKxJ
 nItP7JTGy1nerSqwOauAAAjfxNIm0D98sjDTXoibeQDjwp+igsZeQaErDBDqlNGl
 +FI/oh1gbhja4bWZXSVy4SBa4sGJg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022093.outbound.protection.outlook.com [52.101.53.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms479fv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 05:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHFsqD2CgoroddJoG+GYhN9PDx21gxKfdGVubi+Dj340dcUKpy3k/8MXfjzSk5PGu4pswVubXL64sfNLQxo5ionFzsPXinMB6aaxdD4e3CSUYE7yvi5g2diIDHSdVZTTYizB5G/UU1jgeRSpy0juw3le0YtzfA+NcALgPFKm+oLiFLzYzcQ2jaEZGsiCN3EAfXh02C864twM7cmJCasgrV7kHhZDkXHV4wxi3fM2XHGXPOizvvMcpkFf4iLlo78EiM9asYgNcEi4zEUIjvUuRMxAF85B+Tb+XGvzpONiSHgS95NjV9wtslsDgpc3T14yjzJtmEuaNFVduFY8hodYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNayOQpBwM4M2wJ/jOw0QXG7vZsw92xz3ljT9Om6wuc=;
 b=NDeb2rknYXzj5oboC68bOGFhmJa2SFmIPoJXcT53nW9l4JGbwKcLKrW+OynWUIoZqLPgu+RWPBjDgyTHUnAG+VTvBRQYeNZvdhYwYasr3LYN1CyqrE+Hg37aIe5euLkG6XKZVTUzTZUDnET6lWD6VBwWF8R+f+bwK6Sn13t1T7cq1uvN+gRjFcyGxQPsyTuPVn0+T1cFIIIDMM5GE22Yd21POoCPfj5IWjLfh3l6qpO/do6qhjamyRPCBGCjHgDgfjAh/sLpKOeVjgWbXnqo8fER+tNs+wbgOpAdZxDcavFhm7OY0CgiHSS0LDAiIUqFMACGsVS5ldu83rGlyqv/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNayOQpBwM4M2wJ/jOw0QXG7vZsw92xz3ljT9Om6wuc=;
 b=ZQhrntbKvHm86Hl38PuGY/kqVI9bZ6r2QeSob5JWcdCNrn9NF3CwyfGyj9yY26ey/Y7NZ32YGVnL644R4Uj0dY8yWcU/fbLo6ur+xM/o1h7SDDdkau4UJqd1rfygDEhcOzRMKhRXlcjN1mgkSEPwV+UK2/8qtMuBiO/BotW4PrdiGMZfJai+zCf+WSCuASi5KTxf3SyZoQ2KI9fOEPi7SZs6v/wdCCSpTEb3WuXSm+IZjxUZhVyo4/Uz1rpxUQ0cw3KZWeM0yi0y47F69pco5b1JAU7s5n6HS5jd6pXzf/5/mppM266Thx05O4mW9nXE670LdTWWL+k3o0ZMwXR6xQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CY8PR02MB10185.namprd02.prod.outlook.com (2603:10b6:930:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:31:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 12:31:32 +0000
Date: Thu, 9 Apr 2026 13:31:22 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 1/3] vfio-user: support VFIO_USER_DEVICE_FEATURE
Message-ID: <adecGoLC4Txe18Fm@lent>
References: <20260409104756.465294-1-john.levon@nutanix.com>
 <20260409104756.465294-2-john.levon@nutanix.com>
 <6c5a98ca-2ac4-4239-b3aa-30e5572f2c72@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c5a98ca-2ac4-4239-b3aa-30e5572f2c72@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CY8PR02MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd6ac01-a690-4010-f95d-08de9633ee34
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sHslVGPkiSbvUCpG9tkevac9G5o0o7s67bs65yNKc9L23ERK5a2UrDxlidlf0pPtHEfK/ixrjdmvEduhl/j+00FsMk4fOM/RAzOndCzzaf2A4J4WzMFdj8gBD0lND3PqSNEbbEShiwiDb0xZqjH1FGdTtu01Cy93Dt0yogKcm2ZyLUywAVY3nVct98RKSykD594Qw4Cp36aGzm50OrCmzymQR+BsBrA4tkX/i0dIw6ZGQXUWxQZr+e7STP1jDfT1on2SG3bI8cmNIkWljr2+s25DMH9pUdgTqIQxArzxmm4XyaxDbVArGw1ysNBgybd53NS6cWE77BXfMZqPxKk6ubl91iPTRiOYiddMKwWWxMEz2kWm2pcW0ZU47rYnGdCTB6Tf9+NaBMp/faziTE5800DyN/od5r2F7OVGlZhbUVyz8g6jiVGN5yMZREtmuRf2weXugBkMTSRcugk/8maaxiI9mKxDpz/EbYeO47iVIioAqfuZD5th4kDyXUw6Aj/Zl3CFsYTs2nZ6MmrKwiF0HAVtJPa22PL/1wrSAJpdZVlc19PKtS/0tC4SP/9YoeU5ekNsE+jTPrLOPlD6RbAkgwGni2BTbf8IKeovgCULBLAtDYWqRxAm6TQfTFe4Jze9jou4JJOe7HPgKqYaHqHPAdXTGKcj+kgKTasGCMy7rY+kw4eW4lo7p2uGtRNl+tWUClpplbLVtM6ieB5Wh9P992QXtwaa0KFN62AxK0RMViI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q/clUE78G/lL1JHS7XB9NoTbz1O9NZO7V26LYQKN8RSM+AeU9bDJFfZRtf?=
 =?iso-8859-1?Q?kHlvAn6ock6zYPdgDSeFx1AuVGZ9eV7Z/dIP59VNB6aNiNuYl9N6IT0EB0?=
 =?iso-8859-1?Q?iQSMt+1PKsz+GSTFSCwxPKnORZUwK/dsVXLTTjxHYT4PJOe70FcS1YAF2l?=
 =?iso-8859-1?Q?3k+k2wysEo5Bz8wAi61kuRXX2G37XZJdvoZOkHQHtfl8Er4fYhr+pPq6l9?=
 =?iso-8859-1?Q?+Xb0IfrECglRqmXVKOn48s1TSiV96OgS1jlB7wO84CiRYfWNZ0M5F+FDnk?=
 =?iso-8859-1?Q?WxxcYpO0IhoT8EMqzewS6mP6Gbtq4dg7aK3eQ9mJ+/nLYNoBRH0tKbgpEV?=
 =?iso-8859-1?Q?tojFVI6/ZKCGKonp84NsVnHqM+KkyWtH0Y+krA1VyU0KCNwjLO33TP+C9W?=
 =?iso-8859-1?Q?Q3mJiyETCUu5KtyzONQlcuNzV2t2eblxhDfQZ048lr2qoVvMhjjzaQVJdu?=
 =?iso-8859-1?Q?MYYxDjFKy1O/kTWTpcNgXLNXNLYSOg0bQJOiPkza82NYtK8q+diHB4krR7?=
 =?iso-8859-1?Q?MuyVqueo3U6WxOKgl+oxpVhjwtjr9w3XHQIDODzfAh6k/PYw7VnQVokilh?=
 =?iso-8859-1?Q?QbqfDc0N5uZuVKdopOCTmx3SnO0cJd1aWVbvNDB0jVCnnjS1IqplrTsqDu?=
 =?iso-8859-1?Q?R+zeVDLHCNmsYVHjYwWLSGv/0XjxF3T4H1BUJKbGSBvNZHzKz4QmeJLGZa?=
 =?iso-8859-1?Q?rWhZG/Cyoi6CDkqmjfduxcHdGpzAswARk5qMUk9MSOM+2friCbGZHlrERt?=
 =?iso-8859-1?Q?sJZ4tjDSTgDgegCy417YLjt4+Tj6Yb+/8UnZAEavSrLSd46+SXTlNBhWao?=
 =?iso-8859-1?Q?K8GplKZrvy4UV9BJETto2SpJY8RzQJSv3/1ocXqkaL9LQwfmOxbfN7sB60?=
 =?iso-8859-1?Q?7oWlX5BYdlbuaEPYq2pT3+c1ghAVq+Ipx/VU7OS+fuDEN8XJS8jbwrDzmX?=
 =?iso-8859-1?Q?LdWg6T805Eo19Ou2i2QNeoBJI4jhppeyPNi0sd8qVm1Y8xCJYD72p7Gt22?=
 =?iso-8859-1?Q?k0mYMLyOZtmC4EWRSUT5u/RAziCpC+EXZJjSgEl+2Nxg9RbRl8rBT0qcbf?=
 =?iso-8859-1?Q?HqtpS5l9hvItm3Nh2nMYYKERtbdwpBuFKww9MIuy5+24IXuP2MaWXzKW3+?=
 =?iso-8859-1?Q?hWkmZADSwbzMRjh5Ucpw9hSzZ1iv39t00LFFqgjG3Nf0Omb+r9W+wJaxP8?=
 =?iso-8859-1?Q?i/zgBWUISf+vnJeY2N74MIRZ2i3SgmiQv30+ZwUfOkw0jTdSZkr8DfP/Xy?=
 =?iso-8859-1?Q?RHk0OgpVagZ+pDkvxNCLXmkcZXlTx9N9L3EF19RO12bE+w2lap+cqlGoIo?=
 =?iso-8859-1?Q?4drS4+OaznWEgpYAHR3r2z+jjip2SDNZaOOTfCDMiRqAE7BIrc4hKtWjqS?=
 =?iso-8859-1?Q?1OTE/dKqfllZZFqYOmIgBw9jYRgyXeCl43ejOvJSZ25QmHJAWUWYloyn9e?=
 =?iso-8859-1?Q?Feg7HlAKthzRHfZBKDYXBeRM1GWav+FLudYSZ1iJF4ZntBKs1CZAv/Bc+G?=
 =?iso-8859-1?Q?+zq8OwwV5Wm+BdciVoJagW/xo1fXkYCo/3JUWXR6VpykSadcppLOq/fTo3?=
 =?iso-8859-1?Q?sow1JI76c4XXHqDyPwFZ1SElhcT8GTOYc7cig345q/FtrnR13gcg6bibM2?=
 =?iso-8859-1?Q?2WU3Y3DWM1sc5I/AmXO4PDrsNXGHmQK7BEpuu7AH6AUyWgZ8vNQvMRYKs2?=
 =?iso-8859-1?Q?lr0XCOa5lh9Ml+VAgkOLYLKOxjwPx8QIotXo/8l3SrM12kJPEgbr2DPkwV?=
 =?iso-8859-1?Q?UeyalBoovEHuB8gTZUd7GnkcnHkOtcBwbwm/yCz7YRWeMbd7zJAoAGJLu6?=
 =?iso-8859-1?Q?x2BvSt55kQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: VTyMWOgxNwde3kv+oNgnO4U1ehxSaiLFA0hSkFsQJN6KvruCCYhiYPV8K+UYy1hlogeoVgQ6OZfCLE9+J3itQTLsaHAFtjj/AXUhrBNd6ApnEbbMteQNUPlpBLjbkPlxf1ldwtGHCx7cKvI/pRcg7xu89gH0iLynCM1gtv6E/koqP9gHVo/1dxNDN+Y97dsu9pCSptemiW1AhNb0BR1KHWXQFblw6dsI9jP1+l3YMmK8NOPhX+30ZZ9ZZy87SGngxIoxbwyJJ2fYfGHQPV1aXRC9OtViqkgs9ECq1y404PyiGacyBMGEHEtQ0+FcJ7IhZ2Phr0mmwYOPKdYAreLf3Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd6ac01-a690-4010-f95d-08de9633ee34
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:31:32.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkLzdAlAkuHSV3nv9LS0XY+IAPmEmQAfW3he3sDiFFHHUiYyAWc0cwKWKRsXlohvE0U93cSX8x8IP4CVHngqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB10185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDExMiBTYWx0ZWRfX6YFtKTyw8mvM
 rSWuyVyAPHC//P11kNFbOTpEjN6Hg8eg7ExPPH4uOntu74+wZOEDVhydn7zFLdOJ3k2c7AeA8Zk
 ZHV3WMwvcEPZlArW1ppKfAKcT/JwPo/vMdIwbNwZenY2/4rDgKTRZ4eA8WunL/AkrYJKVV1FYLZ
 l1EuTY4LYPQ5jLGri5V8XtFltmQdH+FNkCV1Q8xVO7f02DaDNlo85e9FCp6XzQgkIp5T/cDLUJH
 64lZoTs6i2wJYytCiJoee3zRzKMXTVXMe+6j3SJGLQbJtA2+L2MNEnJJzLTqMgbH8HWcqeraS9h
 onD2+HrbHsIKtOLFIROuhtNC39ZFHZKgyk04yKw1eL4GZagOai85dPdMol7r7f4Xn1UyYqQmxsy
 lS7mkuSOzWm+UFOVoCOdrhiKDDXaik81FKFArL6wfkcf1eNEOyYWfE5G+3sf6KdIrH8uRqmn8J1
 1YIWrdzDDxJ9OYGeSvA==
X-Authority-Analysis: v=2.4 cv=M4197Sws c=1 sm=1 tr=0 ts=69d79c29 cx=c_pps
 a=F9xFoPyAMX64h5WOW3qpxA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=7vDEnmPYfHSCWbD67y8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 4MWbR9oNG2PZELkszeX9LyGU9C6plmK6
X-Proofpoint-GUID: 4MWbR9oNG2PZELkszeX9LyGU9C6plmK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 09, 2026 at 01:50:58PM +0200, Cédric Le Goater wrote:

> > +        /*
> > +         * Client expects ENOTTY for "not supported", but the protocol may
> > +         * return EINVAL (which should only occur in the case the feature isn't
> > +         * actually supported on the server).
> > +         */
> > +        if (msgp->hdr.error_reply == EINVAL) {
> > +            return -ENOTTY;
> > +        }
> 
> May be this is not necessary anymore with :
> 
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_20260409114312.1704062-2D1-2Dclg-40redhat.com_&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=v7SNLJqx7b9Vfc7ZO82Wg4nnZ8O5XkACFQ30bVKxotI&m=lpMrwUH_bH0I_KS0ucNhIf9acrnTdwuaRPGfJXRAj2yImpt5jpWGpP82gP4MJmRZ&s=9mI6zaw_Kt3ZLTto-WtxWPFKpQrqx-H7KpgUyvxnWEQ&e=

I think it's still necessary in general - ENOTTY is what kernel vfio returns so
we need to align for that for any other use cases.

> > +
> > +# device.c
> > +vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags);
> 
> missing format here ^

Oops, surprised I didn't get errors with this

regards
john

