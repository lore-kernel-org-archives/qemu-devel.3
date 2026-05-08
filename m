Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA5CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMC5-0005wu-8i; Fri, 08 May 2026 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMC4-0005wJ-72
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:28:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMC2-0004wy-7q
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:28:43 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648EQaU02835077; Fri, 8 May 2026 07:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NfC2V976ASUHItfG7unufd++7RDNAuByNS0bLtP9O
 aM=; b=m/kbNDGH3m+fcmVGZpHn0xpMosc+/8P7EYUnnSQETVYu7Q4sl6VsLaHCH
 Y0rzc+GULHfJ+IKeSf8791ERgJLlnX7qTrwBLayQJkdqR5QYMAMlfx2PNyYRrZXB
 H0LPuiSa0jUzdkWg/tGa4utZM9B3sblTxiya9XHddAma8XmVPqELEPMr2iOrRrcH
 WsZWd8pzh4BpaIzVuQ1aGX9iRSiEpI3CmzGyd/WrUGaAwNj1Y6sySRdeEi+pKDBq
 jkO11bs0Vs/wpoNRstQjF9tK+gNsjuFDKI7430YSysYWyQUotgGpFmsg/+oBptk+
 gVchmXQh4FcB5GDMQi1JL6BlCDHRg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022110.outbound.protection.outlook.com
 [40.93.195.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e074p6cua-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 07:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtjxwjaTCPEw2li+tZuGnUTNZznTwDUKfZvVfaouBnce+qHRYgss9zJQLO3sN9w3qlnQnI/HiKA+yVa/CInbdf67TV9ZClNYKlkAB54AY/QbscSBPNxhBQTTiAkSkD1SgMqaEazeLcu14PivRpezD4e3iLZZB4+wqa28KnxV4fsameWFmx1X9VsS9taSxIL59v/BxaQc9frKrba+Z8Rr9yaQWxvQpqCH3Noe5EETTlnacFJyLJ8WY6GOBvLjb2s6nAyGB8QscOmHNEyyQKjMDjMHzwLrgr2LEC0d+7VY/YLnJvBtLm4w+9+1H++QEt6qr1bX8glmJIAQu/XzULcjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfC2V976ASUHItfG7unufd++7RDNAuByNS0bLtP9OaM=;
 b=FUf5L1t2xoeylYIzJ0MdzdJBe5mZJuDGK9MZmNAWEpaaClL7ITk5cxr7ZdrzB5IUCmNXAKgGzrdNIaPVpL/fYJAhf03LnTGdi5naLxRxAT6QzbysPNsd+oOgA5eLXMQGO+GCE3FUaEPZVmciC9E93FQYyT1uIisKjDFn6VzE7sxBUXfLujCrDa8JzLweaJ3qBxd5Fb2OSVKYmgBh7rjAFZ/OY8Me9VAY7iUuvxPBFziZY5xvKxGGjp+KYGK7rfVOknqEO4lXQt+4AK+RUtXz9dNuthp7heBNzpjdlAiVQcb0BllIFQVxkx+gjX1YLT2LGrvxwlFRxGL7IJEZP3hRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfC2V976ASUHItfG7unufd++7RDNAuByNS0bLtP9OaM=;
 b=RS2MvKr2OFQs54d+cLkK10kFzUUsW6Yg/XqF+tXksMRevLeyywPw6NkQonVlpVDHdFHMoP+lWnFN67bgHjPDFQUnHhe+gdf0Cv9ch8IjcO78TRB82nmiWohc1qVfgomXDBsPCUFkB1Q8ggNfvJBoaoHENLdMOyr9k1TOSX4zyh7TwTbXmrZcBviir6LRf9Fk3TWuKozhetG04DVFyCpaFtBNnGtoNmsArOoKUMyW6ry4s7LBCVBLiEgHq8QszUhniRmHhyMpGMTl+qwlCY94x1YSpYTJnY2csd/CU7Zd6IVKH58ki8BhkOWdI8cZgigqNVSwKBHvM9UFqhCPnGi5hA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9810.namprd02.prod.outlook.com (2603:10b6:610:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 14:28:37 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:28:37 +0000
Date: Fri, 8 May 2026 15:28:34 +0100
From: John Levon <john.levon@nutanix.com>
To: Jag Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af3zEgHy7UMYN4Ow@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce93b0-ab1c-40ce-5a75-08dead0e17c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 1936Esgnm8E/F38s/E8IXd82UrT5ndwnB5lU556g1OHOAzi5q3rOjDe/MPmGYI9LW+fRkttuVvH3IugTAKepOywolAa48jJBFwFiy1TdsqhVPPttCrnqo2MuA+vJVPGDJiuSGpVy9PaLBJv6dHfwEnN5n/PumK6trHQFNvbMhYk1PsA2Tw3CAA0mhQrWLmmp4yhq56X8Ptq2VQADjtSIT/49vHBy86AegPM2xlyI7y6U2UQ6FBN328do4nvYRD6///GNC/GSVkaa9aqQmrWoK5YF7v3asn0b/l2+iCG6hA1NBmx1jSSVce0s/JgSKEd4jS3o6ZN0WV+FEM9u3ld2NqQlvxUtct1OLwljfDpkGJOYuVJLURvTWDJ58Pn+AbWmPDvi3JRUrB1zMWUmrPaPDlKWFrrd+eQt75fhCGDsy7qOTf+n9yLOB+rIUwPCZLwqkrEYPEepQCklMft+Y5a+DkrrwkevLImCllkeEceFnLXvvudzZfcdby7hlkdaeZX7vaxCAZvT0+bzg5I/fw474YKYccA5mPO/ca7zmOG3FSiVggvqAs6LOulqtHLzuW+KdVjEdMyL+QBo0esCn7jn5rte86dCdP3Tp5QbsJ2WNnKgTpoS4/MLSpLDXVnCcIwuundMcHGZAwGBg9S9lTIDNEeVM82lj93Syrc+GxxJkaHvV54F+pcEzE91W/4BgQ+S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERNQmRMUWVPK0gzN3NRbngrOUhTZEZ1SHZpbWUreDFEcW1GajlIZ2RHdXhh?=
 =?utf-8?B?OTlMQTYxYmtFbTgydTdWcHpEYzNSNzFFc0RqeVhNZmtSa3lMV0hQcGdqOVp5?=
 =?utf-8?B?SVZmeEVZK0NUaThEb3laME00Z2QxZ1lNL2lFLzcwL1FuY3djZHNBTnNxZnVj?=
 =?utf-8?B?SHVvUDRTL3dJL1ZNZTJiUGF6U2dJaHVXVU9BN2JlWXF1Uzhya0NFMUxpMUhn?=
 =?utf-8?B?WHRtN0w1UjhXbkx6a2JENVp1R29qcXhiNHMzQUhrUFY1T0hzQmZSYkNqTjMr?=
 =?utf-8?B?N3hmMWVYMDkzcDJwTzJ0dE9ZM1Axd3lSNnMyYXc4QW5CMjFhYjZEeitxRDNG?=
 =?utf-8?B?aWFQV2haTGdadzJxY0NVVEpRMlo2NXhNN2FydEJiNFd6bTdRdEJZZ0w2VXEy?=
 =?utf-8?B?VWRXNUIzb210ZkZWdUpzRzliZUJ3Rjl4VHUrZFF3WHpwa253N05ldWVnTmR3?=
 =?utf-8?B?RHYrSDVaZEJvdkMvUHZGWm5lUzJlQ3hHM2dXYlFla3UyZFRiendHS0hPQzZO?=
 =?utf-8?B?RzdHS3VsQXBuMmo5d1ZDTjdjLytaMytKK3hsZzVTTXBGSEtNWHFTWUdJZ0FK?=
 =?utf-8?B?Ny95TVMyMTYyN1NwQU9GNGNoMDQrdmRpdzF2MFV3OVhzVVlGV1V3VFV1N3pZ?=
 =?utf-8?B?NUdubiszOU9DSXIvWlFYVmRnakZYcUYyZ0FwTEgzcnhKdnI5SFBKbnJnaFdk?=
 =?utf-8?B?UXNHc1VPcXJLbEc5Y2VqNi9LZDJHdEVnZHVTeVlmUUdiQlErZWpXT3JsUHNs?=
 =?utf-8?B?UytmeVVRUS92aW13REptNmo5Vm53dWNMTDB6VVEzampWdGFxRjZlaXk3aFFU?=
 =?utf-8?B?eXB4QXFCYnBNNVdTTnQwcWprb0RUd3ZBUk5rano4MTc1aCtjNElzeUtaeXFm?=
 =?utf-8?B?YS9kOVVYRFVvd0V4Tk5XWU1RM2g5U0p1bEV0dDJsd1pHelhubTNTMThRQWxM?=
 =?utf-8?B?NkdwSGZ2cFJGeVJybWxkQlpMTWF1K050bXRiT0ZhUHVJb05GN3o0UHhnWU5a?=
 =?utf-8?B?b211cEFsRzhITCtqTlUvMTVpMkswd25ZcE9kVTVPdkF4QkRnL0tCV2dJUzZS?=
 =?utf-8?B?czRGSWwwRVBkM3c3cVNMbVVTVGFFS29LVUFpQmZjNjl0YmJTNCsrd1RXcklp?=
 =?utf-8?B?NjVWdWZyeENkbTRQZVo0aHFoQnYyUFBGZDhOVHpIRkowb2lLVWpmUDRPVXhk?=
 =?utf-8?B?TUdlejVuNnJ4RWN4ZFpyeFoyOFNYRExsTDQ3OU1KS2hBaVh1YTBIbGkva1F3?=
 =?utf-8?B?LytnaXYyS011SitndkR2TGN0MXF2NTFBSCtIbDIyeGlLZncyY2dWRTVCdlFR?=
 =?utf-8?B?QlNwazBPWG5DenROU2pvcHowRGNoOW9XS3NWQmNYL0dkbFpoT3FuWno5SkY0?=
 =?utf-8?B?K0J6K1lpYm8zQmxNREc1MVhNZUFxbzE0OWExa2JseWVOUDNIYjh0cm5DNy9z?=
 =?utf-8?B?N0RtbndTcDdjZ0k2VnFIMTRwOTBtdnpCZnl2U1lzTnRnaktUQzZCdWJJM0Jt?=
 =?utf-8?B?WTJYZjVuM0ZFckljbVI1YnN6MnpjbmpMN084MUZkNDlBYlA4WjdQcUZCcTlp?=
 =?utf-8?B?NkJWTmxzNzFLRThEUXVkdTZxRHd0a3dvVVljYU1DQmVQSmNWUjB3RVF1NlBi?=
 =?utf-8?B?bkFRVm82Uk04UWk0SDhUSDJlRUsyMjdJeHFaZ1ZhRllnTUQxcjdpR1o3R2Z4?=
 =?utf-8?B?cXlub0hqRDZycnhMdWg2RTlCMjJnN0k2NDJ4MHRMVHVReTdGdUxGekdnY2FL?=
 =?utf-8?B?R0RtblZxZnk5QTBiOUZmekpjWG1sTzIySmpaY3VLN285MEZ3cnpodm9KWklz?=
 =?utf-8?B?WkJmNXpnMUdscXcrRDF0YVlVNm9IeWVraS8rZGZ5dFk2L1ZhKzhQaFBCL2tp?=
 =?utf-8?B?THZrLzJPcTRaTW1uYVZkNmNVWU9DWmVTSTIrM3NTMUJDR0ErWHZHSCtOMlFh?=
 =?utf-8?B?eXdXUXdMQXF5ZGZNTDB6b09PRXhuRTkwR0V4aVV4NFBKOERJZlVJQ25pY25D?=
 =?utf-8?B?UEFkblhhRU8rZ1JXS2pkazJwMHZIMW1rczUzanNqZlJISDZXalUzVWJlKy9v?=
 =?utf-8?B?VkVZaU0rcTZ0NTBNNEgvWHllbkNpUkZiKys3ZEp2K2ZqOU5HMGpUaHpRakh1?=
 =?utf-8?B?My8ySDlJUVlPYjcvQTV6Rkc0bHlEYk9ZbmdoWXNFZUxtUThLUCtVUEZWSkVX?=
 =?utf-8?B?WkQvN24yTVN5bmx1VlZydGN2bHV3WjJhTGJITWd5YTVHdmhLdlZ0ODc3cTUz?=
 =?utf-8?B?TnpvNUg3THpya09oSTlsMWpKenQxdHRmb0hKRkdHZndmR3dpcE9ZWVF5Ti9O?=
 =?utf-8?B?aFJqZmNSV2ZrZDEwbWpPOStmVE9Deld5OWE4MHAvR2lQK1FLclJ4Zz09?=
X-Exchange-RoutingPolicyChecked: Jaa8Dq3DXxHMdtNtKFvcyfjHDLXEPqJzREqu8PZGdbWINF8upb2SgebGcqYXxMQNIfr56Xkvu35yggDXQvRazzcEa3Ldl9Br1OXH1yvswRIm8moGfKNkvHbG6lvsIyZbH7IU6CnJGMkYldlDGSruJ55E7KbIuZhHy+xTK8DA8LE/5ZkZyZpj5AsWdjUVB65Fw9Was/FRIAP+KFAp+72tBWwK2h25mNeFwqeSnApEo98Sy5lzz9IhXol2nBpM6T143DyHhAuHYE+vPxPmt+qTDKScch0T2bhlaYQ2gRhsv97zW9CSGtfNooZqAhLcJL9cc9YPCW5WCWRcVudl7WLytQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce93b0-ab1c-40ce-5a75-08dead0e17c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:28:37.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvHMATBeuP06DtHmZ2m0D+pP1R1UnUVAlKNVqKldPf6ONy0jOgBVyQb4TgSqXyupY59cdu+/Zoqx9VrGllqz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9810
X-Proofpoint-GUID: xll9k5HK5Ovkde-9puVDz8MLQa8RC4wK
X-Authority-Analysis: v=2.4 cv=C6fZDwP+ c=1 sm=1 tr=0 ts=69fdf317 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=yPCof4ZbAAAA:8 a=99XZRjcFX_u43YNyhWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0OSBTYWx0ZWRfX0FqcNIfTyHbQ
 NmxnFMeQpaDnOOvb7fiS61oHY/Ov3SmS69Y2Kslvkm507Turx+u4kuzI8/sZwFYZmlS5AuYvXyR
 JRsTdYx+yQ3VrsMT+qB+jNtOzokG7Uc25BdnLG/0rOICK3JpQeovTbz8gF2Y3cmEp565wQfeHC8
 9eNjKSO9lEWz4q3gIy77ajwMZdzanI0yEPd1F83EX9mfV/41IhVF8RBAN/C8WJvAt8yAOXqdmU5
 U15eeXLp1zFZrLUDt7fUGsXMNvAc3HFefNCrQtbZ928xS5VD3QcLY79EFWBcB3NNfjfqB6jWX5T
 atdteU7kpMimG5dhAqaTvWEWZAfAjJMRqWS10K25Ki+JfP7rbuR8nINg1yxf/w4BJFAnM3B/Qf7
 U3eUc0rUbGqSOh4AxRxKM5eN4nBHtWlh40vD7x2EiXdUEe8VYN9YCokHZgiXRfu44NvP38EywmR
 /ahjFxZrWjc6M+bOpag==
X-Proofpoint-ORIG-GUID: xll9k5HK5Ovkde-9puVDz8MLQa8RC4wK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Fri, May 08, 2026 at 02:21:37PM +0000, Jag Raman wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a90204ae9..ce2b494086 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4429,7 +4429,7 @@ F: tests/tcg/aarch64/system/semiheap.c
>  Multi-process QEMU
>  M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>  M: Jagannathan Raman <jag.raman@oracle.com>
> -S: Maintained
> +S: Orphan
>  F: docs/devel/multi-process.rst
>  F: docs/system/multi-process.rst
>  F: hw/pci-host/remote.c
> 
> Thanks for the reminder, John!

(Just for context, Cédric suggested this after my patch to update the
libvfio-user submodule for the compilation issues.)

> I’ll send a PR shortly removing parts we are not longer using.

QEMU maintainers can correct me, but I'd think it has to go through a
deprecation cycle first?

regards
john

