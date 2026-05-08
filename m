Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D249CD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLML2-0000xA-1Q; Fri, 08 May 2026 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMKy-0000wj-9N
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:37:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMKw-0007HC-Cm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:37:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648CIMDV2957444; Fri, 8 May 2026 07:37:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Hn/B7HWrv/G82DbmpKcsYcb3LdBF6ayMV+Gg84Xbh
 6U=; b=ZjDlR+gwdcjfHMAlqvy8XE02+zUiT892VLzyYu+ej1H3wJxqm+yJLqeBs
 yC4D0sB+wpdX+VYRNHG0eJY1uhHyAjCqeMkomZ1ePy88b4vMfoMR+2efeUdzLUAv
 y9wyX0L9Kx0JuIwNOcxJI1fA70DHNz383W8IWiSyux4I8qqUKIw9i3XK2eILAftM
 FAbn3x4SCLx2sxzjr6wSo0lAwp9IRdCs635alOwR1hemHd6m9qPB7ntcuNQ6okIb
 jRP0hRr4TYejTVsoU9ET9Ka1ydXM+Tuo6BPIimAyO+FCP4azRjN+I5gjkOZxlYiG
 MmJdHo7i9NLPiIT6z+YX3rMnAmOxw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020072.outbound.protection.outlook.com [52.101.201.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e1fqj8c06-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 07:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDGiBd1q/TpwU99tcyICu5lgTzPexlKzb8kcsbEiRF3ZfjLCImy4l0UgY1qDb/Es8x424t/neAyYoqf6mf2Kb+nURkosAEmhdR9Hb6y9irCTnxTy/mjlWeHFBpBkDeJFDc0tQbR5SF34wjZ2ZUg0/xt5a1EI3bG98+UMpeNTWE8fRQg5qTSKNG9K1rvXYBcZtQCBAYTx0WYcFRD7S52IDMjLMLNe/zNrdqKBMmjAYoIaimupeDQ9Gqf61XhreJLildeIekawO46NMlNSEjcbxWg/ilnm5uMn3AGAKV2wSIyQH4StZ1S8Um5DQQJJzviUbaayqLEjlueqhuUTKnMjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn/B7HWrv/G82DbmpKcsYcb3LdBF6ayMV+Gg84Xbh6U=;
 b=Gg2W5g5Z7zrQg0E5ZP6byDTdCEqCN4LrDFJaTW7mSk4sEoB3kipOlJTP/84AauusPvrkgZTUoIyozrcDRYlCgjmDghuKUV+p17nqZsq/+7wysO8YAwyyBLg0mCwTz3DzVHvDxB+oe+iPOs90UukrAojtgJZM4wrQf9FmFyNYKYntggEhOof6ZMZACBrfnm85QEz9cLFFwxDp+/7j1hufPbHovJ40w/II1tmElHXYjH2XudZHXjdlN4ooUDEC6+/nj5l5/Y6KEt2eK8xe91fYuNFDvDieL+i4xSJRF7P/S5xN4BW+14fOm2YOxWIppJ28qo95tM5Ia2+zRmKG7KSWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn/B7HWrv/G82DbmpKcsYcb3LdBF6ayMV+Gg84Xbh6U=;
 b=h2deIUJFKVlpOmdxTUmWE65iQABDCYy/0K3UZnowIslTDnYq/PQw0nPBp75f+ttoOD4JgU8KR4J/pdX5GPQFMRepYkSF5AHZg0V6WcwQdIEpArcy0OBXndr51sYrVNEZ2wProOaewbABptX9GGRwjAcr3luRarOQvU8xRXFlb74nmsliXbETq26zSnXVuome59IVVRRWEj0OoAiTdI9+Ib1mXx0oO2MfrM32yEVF3fgyOBWB0OjODRtb0HLwqSFqXIJYHS8X21N05okIp4GTszpM6w409vHwUMdY/C2sVVCXqACnijk9xFG7M5mBDeJB4bXrVSYwqFOjlF4zqvoi2Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN6PR02MB10702.namprd02.prod.outlook.com (2603:10b6:208:4ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 14:37:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:37:49 +0000
Date: Fri, 8 May 2026 15:37:46 +0100
From: John Levon <john.levon@nutanix.com>
To: Jag Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af31Oo6gXE69c7eb@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN6PR02MB10702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2633ae-596e-4450-9a3a-08dead0f60d8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: uIsxlQDw2bGBfTEfsGD6NJZ3wtBJdM57A/9Qvv4y02SbpLzmvgI5GW+WGoovV6W+EjWq0TSjrFBCGntDmDxpHBIkPl1mkrWwZ9uNDEHknkc3tWiYSXU/3KzywvC8HVTYL59zxQIPsa8//3Qg12QdY4ilG66PZqehks4bu0PUlgwLOVBDL9C+UE/QZT6+yy1w6tQMLnqRzUuh6ejs464ua6YwwC8I0iRFBj9iN2nMnVz6OIqp24HVLchapCqi783x9bqSbq0wUwexm+8/Ed2QxFel0ne7lLoktCgGE94EcZ1P0XL3X2JsoFzWujU25NXigIK/N5gQ5ZNi4V/+IfLNOQu+emfWTrpaxHNZQRIIMbxMU1VPVXSVJLQoHKRPfY1L/BN/z3pwDuOeh5EHU4bWeDhZyHLsAb3WxZoUcDPGDDNLnnkKDkPziBDOUk513kThG/EZ/lZXEOcVErKC0uRlKHy5vhBICifsRxwrV8U+PZbsTjOlBi5CDK7/ywJ7CnrxbHeHq7j6ek8zYp/01J/GL6MMWUuiyMgrUT36XkaFWH9/zvc97/ekeHO3CiZxgKbsO6tOADrTmpwNyAY5KWZ9nMnj6nv0SjNaYWnPxQi/R0NA94w5k5hQmKPfw1FNTOmjoss+NWLO7cR8XFmvjXqejqKeFxaL3zC457FLuDHvKfG6XSAB1Ek6FWy0jP0fwWdF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUI3cEl6Q21mRUtPSUFHMTZZV1c3WlVYME1mZFpDNndqbEpLSjRPSlZWQ1B0?=
 =?utf-8?B?YUEwbGpuQ3BhMTA4Q0kxOTlDM215TlI5azVsbkVCc0JXUXU4cUowa21WNGtD?=
 =?utf-8?B?Mjh1U1hWTzkrMFpqVmM4MjZOSG5RNUg1NnhZa01abXB4QXIrNXNCUEdrSjJy?=
 =?utf-8?B?SXBlL1NwTHdZR0VOZnVUVVNYWjdmNTJJekpZMHZWYUhYd2NoQ2VaQ0ErQzhW?=
 =?utf-8?B?cWlTZFZ2aDFRWW05SllRKy9CbC9YSWJvMklVOExOUzAweGc0M0FQQnJRREpL?=
 =?utf-8?B?ZnRuRjBGQlkvTVJ4WjRkaHE2Y2kvbmVPYW5aWjluQkF1UEJ0dnpRRFN0OXRk?=
 =?utf-8?B?cCsydkN6aldQVHFCN3c2M3Axd2I5S2cvcjcxTTliZk5nQkVjY2lJOERqT2VE?=
 =?utf-8?B?YWREYkxUeC92YnV3M1VvZHRzV3FCRTdnZ20rajkxRHE2NkFJRjNUd3dVNjRq?=
 =?utf-8?B?Q3g2RlRRL1I3Qm5xdCs0NWVwaTFPY3ZuNVB6NjdRMVh4a3ZTbnFLSGptbUhQ?=
 =?utf-8?B?d2VFUktxRWx6WlJUMnlUSlpkZDVqWTMrRWJnaEJXaVorUmRRS2ZRdHk5QVYv?=
 =?utf-8?B?RzFYNXhGQ1R4TndmZ2s1ZVRFYlJ2K2w1a2xBV1pjVXlRNmkwMDVsQytFQWVF?=
 =?utf-8?B?Wmpha0x4VnhrSHNSR3pwUDBxbWo5R000bmQweTNaUkxFbG5ZS2RxLzJTY3pN?=
 =?utf-8?B?Vmo0cVBUWVJxZDJlYjBhL2xYa0lhMXltNFYvK3VnMk96dDNGR3ZVT2hTNlhn?=
 =?utf-8?B?ZlB4aGc5UEluUExrMTl0U2NjS2FWQTRZN3duUVNFZHcxdU1CT3A2cWZFQmNN?=
 =?utf-8?B?eDYwelpYQWc1S3lJWmp3WWtPd1hmdlFidEMzNlhXcmdteVRuYWwvVU9KQlp1?=
 =?utf-8?B?QU51bGpMUWFyOEdrV1g0NjYrdnlRTjZFNXBrcDh2RXN3aFVrVGg0b0FLMFNl?=
 =?utf-8?B?TzNvWjFJLzR4bUt5RVNUWUErcjB4ajhkZWxhYU9XOEZ2eENTcG54cWRQRzgw?=
 =?utf-8?B?YjZrZERPYXJvM0krV3F4OXp0MU10WU9mdHpIUjkrSEdEMktWWE5Nc01YNU9F?=
 =?utf-8?B?ZXhSUm1ldnRoSFhYQmxkUGppSFowU0w3S0cvT0pYQlNCU21HSTFjSXBDVDhJ?=
 =?utf-8?B?SGF3Q0JSV3U1RCtBOUpiYmd4aGhxZ1JGeHlFSUR1NUcwSTdlNlROZjN1NWpX?=
 =?utf-8?B?b0o5cTIvdGhibnA3RVZsQnRnSXczaWNiSFMvRFRWSng1MXgraWh0SkV4S3l4?=
 =?utf-8?B?Q1I0UDA0RFQ4dXdlZzg2eW9GKzdzVlBsdXppYnVyeTZsT05kVm1CRTg3VUhh?=
 =?utf-8?B?c2RmQndJejhGMG5TSWpJTXFwY3UreU9FWmZabHZTYjlOWWdHNkpmTzduSmZF?=
 =?utf-8?B?MjhWTDVPRTlZd1V2RGxDZFR0RE5LZUpxa0RtSEhNQlBEM3B0YXY5WVRlUEth?=
 =?utf-8?B?UHg2bmZkRkQ2STFoSHAvenYzRkpValJaM05wU3VudHZiVXdXN0FLaG9haU4z?=
 =?utf-8?B?ZzdXTFkrNGFLMXFMZ0xMOVlQRWp4OWJ5dW1zOGQ2WHdjd2xUeEZBQUNPWm4z?=
 =?utf-8?B?bExJN2VkQmlwbXovTlBSeEhsM3VCV21VSE9LN0hIZGRTQkFFMlJQQXdTdm9G?=
 =?utf-8?B?enl5SkxBdmRDVFlQMm9MbktadTNJZkxEYVVjcHJjQ0hMeGlvQkdYUE5QR2Rr?=
 =?utf-8?B?dHhZQWNBT2k5aXNlRkVXN2dqWnhwdUI5djJsQjExekd1bVBYcVpiUVlpS1Zr?=
 =?utf-8?B?RllwcTIvWHNjcm5tWWEyeWtyRFVESUUxYWg1RTNzOTlxaUFIb1pwZUlEbFg3?=
 =?utf-8?B?NEdqeVFLMnpHNTl2MnVnVFB2MmYzNEw0M1g1RjFtRnJzRXpYUzAvR1RhTmRp?=
 =?utf-8?B?a1dYcE0xanVWb3h2TkFTUnlSaTVnUjMwdGdTZVpvMjY1MDJsSVZodDlrNk1B?=
 =?utf-8?B?cVNGZ0xIM2xVU3B3OE5KT2NkajJ2b0s0OTZWMllqSFI0bC9EcCt5VVdnTEFp?=
 =?utf-8?B?MjY4dlZsN24vNlRhM0Jqcnh2T01NdkFxc0NEZElXd1I0eXh0a3ZSakVpbFZj?=
 =?utf-8?B?ZU80MTRMd0VVOWlOZE4wazRHNFRhZVQrSjVaYWN4SGx3Z3RFNFJhc0pTMmVQ?=
 =?utf-8?B?ZVRRSW5qZ2NaTC9EV0doQmVab0VadjlrYlUxQ1RQMkNLTzY3U1ZSVmFHR1hW?=
 =?utf-8?B?N0tsODMrZnd2UHN1RlYrc0VIejc0MmE1VDFXUE80WlpGWmJJbHh1a0dSOGti?=
 =?utf-8?B?Q0prV1p4dXpOaDBCa2duZHBLOWhRU0lEaktMSkU2amJTOFBZQmlaUkZKUGtk?=
 =?utf-8?B?ZzJXNDRQRjV1K1dRSDlUVXhNNmljVlNJakhXOCsxY3hWTHhqR0xjZz09?=
X-Exchange-RoutingPolicyChecked: G+Swv1F+/iApPmRUEfn5kbEMghdMk3NiiJsyeQ4cfJhmNdYTfeAo+0nE6239xF3SoetPnryGcNoFf5Ny32S6MrM020rWd7dwovjSH02YEx1m0GE0LD6Ty/e04BtdNnHF1zIboUVpbn6Axk4VhNyf5/ZRCqE8kSVuAWM9Tlm8IAA+aGirKK608IZOxMnikHGfkywOG+QmX5+1pS6hJaJ61vcQdWrBVMS4nJwDDi8KnfoKIHrT0zkllgX+Zd/46Cepy9RdY3Zx5oGCEG/AtNrSSqBLdvBOvjzsy4wg4CvKD5O5OGH3MDPxcHi0z5svB8CffTNU1SH2NGAPxF3Z8v+8Vw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2633ae-596e-4450-9a3a-08dead0f60d8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:37:49.5194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkTtH61onfeXDvEuYvvu0rKErrofTZ6m0PnTdKLVJivcVsZDG1wzYkinwdvADjOr/i+6abeERy28KxP47P/U8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10702
X-Proofpoint-GUID: 7SnYHF1K4QhfVV6c-VBiDxwTWlM4dkfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MCBTYWx0ZWRfXx+QhetmDPtxg
 v1Q4Ob5/9PeTDpHalJhpU/Hkfd4/p2yQrjyOSfyhH1UYKNS7yRJMb1efe6D8vcXi+Lu3CH2U5M0
 wZTs4QnJI7N3JKKhARJIJrhH1P63GTVD0oav0g5wlf8owXuVR+/b+2L5FDwN3kyMV0MhfKv8q1o
 uBpWynhgyLB8/1NWpCaLrKXVdGzCm6wcfaJDOsSzZKZR/CgcrodI9aUN8AyomaFCdMj5yTYXKue
 onpsuAXV4sXh8JeIgHRs6bOx/DIq+G+knGmUsLQotpq4bwWk+hui8DpgoCj3DaV+Q5iJuJh2kmQ
 1qHCwjpaw5btkDJmQ0d30D2bg84YpapjZk1k5c8QfMU+KR3Mn8y1KZ3P/txlsgHqN4Zwl1iyCbL
 GKpgibwC+Ns3Iaqnmze2noy+XMLAfOdqPGBP6fRAxeOU7/EdYVuzlOj7Qx+vHDFkEKLs/tyhrp/
 0db94/cNJqDM7B4ztnw==
X-Proofpoint-ORIG-GUID: 7SnYHF1K4QhfVV6c-VBiDxwTWlM4dkfD
X-Authority-Analysis: v=2.4 cv=H+7rBeYi c=1 sm=1 tr=0 ts=69fdf53f cx=c_pps
 a=IBJHqVCGmmUWI27oiwGTEA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=f83k_sWA7oiijhE3CpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Fri, May 08, 2026 at 02:33:59PM +0000, Jag Raman wrote:

>> QEMU maintainers can correct me, but I'd think it has to go through a
>> deprecation cycle first?
> 
> If the code has to soak in a deprecated state, I think an “Obsolete” status
> better fits it as it’s replaced by vfio-user.

Are you saying you and/or Elena are still maintaining the vfio-user
implementation in hw/remote ? As I don't think there's anything happening there
either.

regards
john

