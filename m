Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BFEC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy7A-0002QS-LS; Fri, 28 Aug 2026 11:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy77-0002Pt-Hz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy75-0008Gv-B1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:29 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDUDLd3069407; Fri, 28 Aug 2026 08:03:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jC/fnCBh5MLd5NGGhSxCv3CofLiAtAVG3M0Wm0ipw
 MM=; b=V/6wzVMsNpCnUzkYv+wjVQGlv7CpEfUuXyHes9VCz/Y55zHcbm7Jcmdl5
 9YD6rFsN7crkxdx4ufm0B7g3NxvRlY/E95E3n9Jd3G9dL5/jSyUcXy1pbsUsVzap
 w9lTvoFbRJSzucMVzHnG9CrI0cqiNpQxZhA96dN7S5eQraOqsTrEaRaJG4Igmdvw
 OcRp9HYuCyH7Jh3/nbhkWxTAzQAg1Rd7mLQBC2zfdJra8hSKOoMnD7o6b/50rgkw
 tC7m0Gxsllxszz0z8DfTAy4Zo8+eAX1UdbDwEvTQEHXYDPPQOmG0RMPMdX4vWQ9H
 B/FVhN5sw/6Ks2iYTDEKx8RBSC4ZA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021140.outbound.protection.outlook.com [52.101.52.140])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gad5ccmvy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPadyGFWfj+e9W3pyYmen5VV1QSxZzSRE23m9PaLaiPx6vgUiyaMqzHe2tBJM1rMmW2knXo/ZdnM7CyPGUh46y6cuLKk8N1ZQdk4eu4hebhrOwO1Oadkn8uDI7o+CBAkntVPhxVqpLalGH9yFTNsXJEuR1v0F7nuiXwe6B38bPheL4m3VWZqL8rbS6OF85+VUe/kQ20or2LHtSjdHaCxEziFzDcKsUvx0h8k71ZSNZL4YMTm+FmRRzm70mEb2jV9AP+S5/XfUhQzjdVXF/PMDFTKOjNE0bbF+1hcC5aHbQgCQA3vbqtQM0SfO9NNa2UgWcVMR5ToliTsmZh8zg9bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC/fnCBh5MLd5NGGhSxCv3CofLiAtAVG3M0Wm0ipwMM=;
 b=UpgL8JitDCsSPOaaPZ5J5FO6PbkeMYGoIwCYunS3N45tzMPgTE3RJmpaOys90VTGxPfgOU5UqTE2qF+D08K4u59DPcrWiQweJCX0dc98hl7vLCjMm1ZcOSpP+SoFkqXHT7GFBgRFr1qxHKYezBrchaDlPtI/8TNOLn3uO7p9HdFS2SZnUiItuSAeeKopTvzwyaA2tXwTTbYSnJQ8JxjKaEVXWtjOMyRxNQ6gIFmgiFNjgT3Yr7zAvFBjA7Jy0LrY+FvFB2xiGHLTqzO9Lo+rPKUv7xP5+SSaqiPKz/ZX3hymI7WiUj+KDDKAJnRogAYxg9s0L26u70Bht7S5WVSkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC/fnCBh5MLd5NGGhSxCv3CofLiAtAVG3M0Wm0ipwMM=;
 b=cPfk1phlTxzXHxe3CEUFJgg5VlMaWsshPH1bSuvroB7p9tjmGvWockagHfHN8WRqbObcnbo6O1KEWYQ/+0K0LIc0VpZIctTeVaoQP66weVzzuTxQbwcXGK1l2pQauxCN+1Ztq6U0N20k1IeINB7KvjxxpQAwHhsbn47LiGQ6nyppCfXt8PuOWotCLdmgEGC3y3phxQUQ4o4JJf7LylswyV5C/gNEHnjmHxU4XM0leYeztEtHmHyo8lhqRH10r9S+LocDCzVGn1pepH8KYLIeefOKB+FBm48ztVwkwcM/tw+wBUL+oiA9IM2TeTAXmpm2pizjG3EeJRI/wgqUZxAgzQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11917.namprd02.prod.outlook.com (2603:10b6:8:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:03:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] qom/object.c: introduce
 object_class_property_add_alias()
Date: Fri, 28 Aug 2026 16:01:58 +0100
Message-ID: <20260828150313.1883999-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11917:EE_
X-MS-Office365-Filtering-Correlation-Id: 48def68e-98ba-4ed5-e152-08df0515815b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /Ira92vhdB6PuZ5vANMhrxNVUtIPgx33CYVaKzGWof4DHTcUXlcrr9F6ubmu35tIX6fZN6iiq+/Y7C9q7SCIvUbaZS3G9daKit9tqy5+O9bRyLXNihQV8C+CpvPSKa/zr8BZCCVgvt+IB7UTbaCMbpBe+s3LiQaRwpRZWfXH8A/eXt07XNlFXw8G2dnpr2hPp5co61hsLLMMJ1fDuNRu5v0ekIaXcmgn7sWWnRAsAulMFIvrhXyJw5sSz/+h0NmYNMb1Y9enAl9kRL6nGw6zRhbPACXcJ2FiTGsAAE+2TJLEyUspRpEcO/3RXu0c7yKZKgpW7BQiAA31EIkmCK6YPWG8pM/WWpPNsgRoiv5i6Tj04fqlU2lZJdYnpu7Cb5K8pKE5L00zrV2rdnVUOnrIGdEjY+3RC3daK6zQhPZOUkS9+Sumi9Nl+xsNBHWNbPJx1H3LB0JPU0beviBqoB3cBgbgbg4zA2JfuNtiUbrROlJRd6fUa8YxhaEGlLn76ZiCcs3Xbzijpzcr4zg48RvbhEsl4Fs+il42b0GKj/K87TKalMUSbHzvPcoeeO1WfJgwQg6k0H575vlQEJXG1wkla+mXp0iw+u1AbIXkruigR7WtGKt2BzckqikGdI9Dgsa6T0iyMJxrv/w0kGynDqWRasgDTk1Lq0v8laGz6lFEPXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?feo8uXdxGju+JHjwobrD/pBV/VvzmSYfy6l8myqOuSaeAUE1DT+1+zA+VxE7?=
 =?us-ascii?Q?/4GCtnF9Jt/U/B7nYM9EVEFyyPL876CtFWMucVscduydIQ9hJL4kd157sMlf?=
 =?us-ascii?Q?q+OnozJ2ux7g5adeEA6kk/LLbVzrIV2bqIu3qrxvQNISt5AgewSYJCj4Cy5Q?=
 =?us-ascii?Q?3wL/J7YvI62DG189nBBGJxCjaKtmMuXzZn8Y5fecIG6viXTmWCAMtSLYYc1L?=
 =?us-ascii?Q?jFHHxoUVDASmZL/HZRLXUgGLOOn4awyffCVmqnrT+0AZd5KsRyIxSTuUCfT9?=
 =?us-ascii?Q?RVxbhFY+J68sW37jPWct3l0V/23MoagLNRhAqHVi6leNCYDHVsxLPLSiRRLo?=
 =?us-ascii?Q?ON5RC1kxKMawLy+8/ii9JHNMjdIEBe5/MFpIlavTmwm+T+9p7dBDgPsA3TYg?=
 =?us-ascii?Q?TuFdJykaMtPeStAUxAuPyhzZukL/HTILMqBhFCskXsbJkEOy0T4DPRl00Oug?=
 =?us-ascii?Q?G4bONqxcW7FU/47mtbFHNhjVepNRK454wPolDmkenVJMtSU6U4dN3QnQH31T?=
 =?us-ascii?Q?T/WH3sGtBTCQykba+ZWzgp4B5tlGnhnWgx5B9x2duQfKg68c/ewZizbMZydp?=
 =?us-ascii?Q?uydStoOlLN2NGhJ96NGuRRUm4n5gYFBaCsITNM9LvSxczeAT2/DqqUuDgXFL?=
 =?us-ascii?Q?PTbZCizBZOBnRI9VR6MZJmjZx6yTv3OlPFWXVQbMFk/XSWkVKXawE6ZVe6FT?=
 =?us-ascii?Q?SnxsVWz+4oNSl7PWb2PolqdViyPOgWS1F1W2Xno2SpIW1ftIeIFulbPUoF9V?=
 =?us-ascii?Q?0CqU33OMijnONzfb646dt1SJ5WUvTmwQYznZpktSnSR049wD4sieBYTdvVE9?=
 =?us-ascii?Q?YXGbK9D1Wj5+AIOAGxe/1D+a6Tj5sGMaHRwnmgVKXw5q+qrLK//vmTvbISjk?=
 =?us-ascii?Q?rMbEjiYRbNLisSMSwNm+dRy7gl9E0fir/G2/cIXIwAxHeR7Pe0X4RXf8zX+7?=
 =?us-ascii?Q?2EYZ6Nob/FEQYXdyu//+SdpuFO/BZLo+ZBGHErqXdGuAWzxEGPj++4uHZ2JO?=
 =?us-ascii?Q?53ireOCkaj4r5O5+yU3jRlCv2TcJcWXkw2adHxHjh4YTsxyl7YIsb/+zLiyK?=
 =?us-ascii?Q?DR4/YJDhS+AdUrWo7z4MVm3nPvIU6JoAvIM6oayh8iHCSEcUcFYOW1rRuh2P?=
 =?us-ascii?Q?WIQBFThvj/fFnpD/a7ufCr0LCwMlhq4aQkqCxkEsLhc9MyHZ0A1zYEWoaJIV?=
 =?us-ascii?Q?P+S/+7xtlTS0CFP4OZAlV85YonB9o+vxKKctS2aqQW77eIuBjZC8v9sfY7e1?=
 =?us-ascii?Q?2HBxdNqM+WhpLOqiyEH3k9aTDmvtF36IUlQuGfN2IYZ5d/PsNkaY0U6rsU2X?=
 =?us-ascii?Q?cogs0/ZRTycrfNGwMelUXPUMk9KxbxGjt/bGMbJmnMstw+Ceakxpa3FMOxBT?=
 =?us-ascii?Q?lDMaFMi0aqweYO9pSsizcF7IgGkX7WelSC/zXLXB+J7S65rkgeYzpC+lG/lN?=
 =?us-ascii?Q?F84/OozLg+t7V9eWZ+M966Ba3W3b638oCnUIKUW4kNoL+6D7qLRZ+BZzkAwc?=
 =?us-ascii?Q?QV3lccLE3kEFERNBTeN8bEFU//YLIg7M5U5b5NTqPzJ7OmJHCbFrq36K2Vka?=
 =?us-ascii?Q?z/XNGg8mgGPL77+iwM6/JID/7s6n6TE3rhohegDucLN2lLpkcwfahFA+Altu?=
 =?us-ascii?Q?ogQJ2gvc1mcoWnjogcAPmAXqBgJ1nvXhlAAaNIQEvt5CxYSezAhy3fgEUs0M?=
 =?us-ascii?Q?oDhnDP+HALD6hSuacAKBhr5iPjVIU60f4M05CygQFQC704sqTd7PkcLN6dh6?=
 =?us-ascii?Q?tAOClzcPJB8HBzm2MYVLP6AR3f+C/ZE=3D?=
X-Exchange-RoutingPolicyChecked: CEs+5yI0jmDHqnQB1ZeOW2XI+9n9J2vi7OzRmrFR90wsfgV8JfQ/OQb43J8eEZzQDaTl+HbJvrr1MyobR/piLL+FC69pqiVHZEx22c+EKN4rAvmPyjL0fUe2AbkI3btFwQXBZLrCkcmnAUh3vVgG6tg79ddDPe6q7uMNuAf0FbL2l/8rElX8g39gWD8LwGawKfzJgFKAo1IQ9zcx3czd4uL7NAN8cGgtoVa3B1buTX3cnCQAZ5wKuJQ2Hs6HjyNourytUANdPVPXtqUCbsnUu/Jtjg5ttK4r8chNTz4wpqUWvqmfV6yTgru82brJjfqkWGM+SX+l7wjM5Yctu8bToQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48def68e-98ba-4ed5-e152-08df0515815b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:23.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwhBnT+rh/9LwuxNiJbqX+yNXW91uSAdS/U2g2XrTJhYgs59WD9Zgh+Pgy55p0ht1mEn5G8ZpvImthrTiNJqhhSHptdyLaSs7oyd7KaSb5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11917
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX32xddYKjXY/h
 LdPJRnjjQjbULZNmUBAme9eIEvznP9GZx3cRHNOY5fh7fQDHI3WU4llrrtGi+iNdbYZ04oEKF9Z
 /hp2BDkzXvnOH4LD4Mpcst7ZBjkSzBI=
X-Proofpoint-ORIG-GUID: 2RKOpnRspoWd6Jue-byhjCtRm7q-ZHDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfXypCB1pNFkmNe
 E7RV9obvHyXICP1ZYv2pol37v/lPUSHNqb3DlsolblcI6XpIQm59UJ3PZjn86pIfCmDwVbyEu6q
 ctgCL2IwjV7bTg3J859s1fXyeHkn2WW8djVUn4zR5rmjvgpZk/QoYK2+oO6aIDIaI/gaQYuiTf/
 8isIYUAyNZ6ymELmLdHbBSC4+nVrN84vkixYD0SgC5DAXWu4IU75NfDUc6A8ceHRwmjMzJSq4Vy
 Ut8PeVGeRBip6QjaPvS80nDDe/qRknsPcjnrJzwfw9X7/EuHzOOLqAc2mf0F5sdlhm1SAyR3Fvd
 ziqVw28bJyDsw5DGHxBVJ/pRX4dt7/7UfRZ+DZH1wkrAgzqWs31Qi2m5M3PhI305NWgFEqwCJjT
 KHhkqmNZv4uXbeZAxC2FKGEt55QijmjlZB5umOJ3H/9jWA7t0XfpZBniEvD438ZjzlQqRKCDyPZ
 C1rfAKZDEvwPgiM3qGw==
X-Proofpoint-GUID: 2RKOpnRspoWd6Jue-byhjCtRm7q-ZHDc
X-Authority-Analysis: v=2.4 cv=Me1cfZ/f c=1 sm=1 tr=0 ts=6a91a33c cx=c_pps
 a=gYwftH0Zntp9Uye4m1fzyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=62B12oWUieRLuCsQAtgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This is eventually intended to be a replacement for object_property_add_alias()
which uses an object property instead of a class property.

With the advent of class properties, it is possible that QOM may attempt to
set or retrieve the value of an unset alias property. Update the existing
property_get_alias() and property_set_alias() functions to use the null visitor
if the alias target has not been set, and property_resolve_alias() to return
NULL for the same case.

This ensures that unset class alias properties accessed e.g. via the monitor do
not cause QEMU to crash.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  11 +++++
 qom/object.c         | 106 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e24f0a2b2d..1c51944786 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+typedef enum {
+    /* private */
+    OBJ_PROP_ALIAS_CLASS = 0x1,
+} ObjectPropertyAliasFlags;
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2283,6 +2288,12 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name);
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index a904f53ed6..873083618a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -34,6 +34,7 @@
 #include "qom/qom-qobject.h"
 #include "qobject/qbool.h"
 #include "qobject/qlist.h"
+#include "qobject/qnull.h"
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
@@ -3039,14 +3040,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 }
 
 typedef struct {
-    Object *target_obj;
+    union {
+        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
+        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
+    };
     char *target_name;
+    ObjectPropertyAliasFlags flags;
 } AliasProperty;
 
 static Object **
-object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+object_alias_get_targetp(Object *obj, AliasProperty *aprop)
 {
-    return &lprop->target_obj;
+    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
+        return (void *)obj + aprop->offset;
+    } else {
+        return &aprop->target_obj;
+    }
 }
 
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
@@ -3054,10 +3063,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_get(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    };
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -3065,10 +3082,18 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_set(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    }
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
@@ -3077,15 +3102,27 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(*target_obj, prop->target_name);
+    if (*target_obj) {
+        return object_resolve_path_component(*target_obj, prop->target_name);
+    } else {
+        return NULL;
+    }
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
 {
     AliasProperty *prop = opaque;
 
-    g_free(prop->target_name);
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
+        g_free(prop->target_name);
+        g_free(prop);
+    } else {
+        Object **target_obj = object_alias_get_targetp(obj, prop);
+
+        if (*target_obj) {
+            object_unref(*target_obj);
+        }
+    }
 }
 
 ObjectProperty *
@@ -3110,6 +3147,7 @@ object_property_add_alias(Object *obj, const char *name,
     prop = g_malloc(sizeof(*prop));
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
+    prop->flags = 0;
 
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
@@ -3126,6 +3164,50 @@ object_property_add_alias(Object *obj, const char *name,
     return op;
 }
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    ObjectProperty *target_prop;
+    ObjectClass *target_class;
+    g_autofree char *prop_type = NULL;
+
+    target_class = object_class_by_name(target_type);
+    assert(target_class);
+    target_prop = object_class_property_find(target_class, target_name);
+    assert(target_prop);
+
+    if (object_property_is_child(target_prop)) {
+        prop_type = g_strdup_printf("link%s",
+                                    target_prop->type + strlen("child"));
+    } else {
+        prop_type = g_strdup(target_prop->type);
+    }
+
+    prop = g_malloc(sizeof(*prop));
+    prop->offset = offset;
+    prop->target_name = g_strdup(target_name);
+    prop->flags = OBJ_PROP_ALIAS_CLASS;
+
+    op = object_class_property_add(klass, name, prop_type,
+                                   property_get_alias,
+                                   property_set_alias,
+                                   property_release_alias,
+                                   prop);
+    op->resolve = property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval = qobject_ref(target_prop->defval);
+    }
+
+    object_class_property_set_description(klass, op->name,
+                                          target_prop->description);
+    return op;
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


