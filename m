Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447CE9537B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaqx-0007u1-H9; Wed, 04 Feb 2026 06:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaqp-0007tl-0O
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:15:15 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaql-0005uK-Lr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:15:14 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6149uTWF391964; Wed, 4 Feb 2026 03:14:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mFxIOziLuzAfQct4wrYOG4KPAureTv1dkLlD8R1nS
 5o=; b=vtr+xtE/NfU/LGaZ/f9Wbvz9RVyVkyfZf55OHq3fhRu80lx1+XxzjhGTP
 bchVUR5bFsoeooG2oiMVX6sE2h/XmDBSQnXI4EOjseK5BmROfJmGj0UI4m7wRQUT
 p9qKbOOO4vxWfo0I628hr/d/EYFMLyCoSox+cfmTFc25C2Empb2bnVF0GqV9H8hH
 oMggQNWngECJFSaYIuNdHD8hwxEGJhAiyG7R3Krv505TFP4D5T1rNXTjkgPSH1cq
 /rG8+RUgmD25Aj2I6TAdwMxBxkXpJp1iDeXTBzYWbuHsIkdzKAMrueBkY9tEOJ0v
 MUIJDsjilbaLoVg2qB2I8kcSMWfqA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3t269fd2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArU1XElBs675dK6ojUfMdeni84SvF9ExVe/bOXOxiyQMNjlHc7wTGZsVSSPaDKsGkRvbY9+TaX4UB+ixbYrzXTQYd8Gt5ffVjDD7dNKABfds2V0TKVHH0fhRaaKV/QBg/J3rNw0jA9vA5YXwI0Gmaw4GZWJVFIoKqeKZ9aKUyCt20ymgG1syE1s66H1jC1mI9/NWc1KJHBieetmRi5kSMvWJcI1HHL9cuMMW0AzslzTvm464f6A28B5gN24zl1fFOZr23KtsygN/joF9W1iVizYlDyCKQIsGgdkj7+6hC2FuNsTJKJ3pAYKz8s0j6xF4vP4bKZxsWX03EkIanTU0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFxIOziLuzAfQct4wrYOG4KPAureTv1dkLlD8R1nS5o=;
 b=WdQRIN05EUKPzmIcmZrH9e5CwJNl0V0h/7H2DT8Ql7P/EpWI1g2Ju/zQhnqNNIZfXOpcsIpQHiJ5hJiV1Ebgawa72rUvLk+RhQNZlCG/aWHymieNKw/GDvV0M1LE3ZJAMbwJ4eujN6zvMaPbEqmcGnr4xdh3Bj9iJb1iBohzJogRM+YGYX+XGYUY5weqEGIOvmRKfAK0vGCkA46NMUjsNf50pu99WD4WY+uSTF2njkiIFnkfQMJs8WZMsBjKeWcUm7IlXCMWVaaJ3CcAdn2pd8XTtgfl+JGzcmO4rNClbUhr/RjjTKSYjgG8y9oGuYxU0Z/G3JX1HJCs8zitl9iR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFxIOziLuzAfQct4wrYOG4KPAureTv1dkLlD8R1nS5o=;
 b=Pe/baw5lo82ppfZ+AtzXBr4OQapNdiFo01PfNh2YdcTSfWcYEpfULuox4U85nmyKYP6RNRKHJArDLX6y8pWlUGsAQHTLhgzYET+1p4yB4gIXnTisQU1FlRHSR+wKeonsmaHamDnoNhL+yD1lSqq7n5l3IyhRp61QEFEsKBHU29oiv0xE1G6uNOaIzb81BaQWXkHPgZK5AsxdNI2+8XnM7bbgmqao6IuADgNX6ewFcg/NnavvZ0tfrhsfl5589Ezi0kUkW4CFmrL6IoSk6+axuKUEDfIIgLSBrG5k+sgkBKGwXL+YZh9hucI6mX3DXr7KsBflWjA02An9HFdVdE51DA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10892.namprd02.prod.outlook.com (2603:10b6:8:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Wed, 4 Feb
 2026 11:14:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:14:55 +0000
Message-ID: <b9b2b48c-aa16-4341-942a-1d59f259e9bf@nutanix.com>
Date: Wed, 4 Feb 2026 11:14:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/37] audio: add QOM module-objects for each backend
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-22-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10892:EE_
X-MS-Office365-Filtering-Correlation-Id: cb46b70f-b3ed-489c-c496-08de63dea01a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVV1NUxaQ2xPc3MrQjZhaTl2eWU2MksweDE1Y3NhdGVWa2h6ZDVhQkdldkNi?=
 =?utf-8?B?cXRjYk9sL2VFNERoTWc0SFpXRDdyRE1BOUhtdFI2NElXVE1JcGFRL2xIREVT?=
 =?utf-8?B?OWxXamdjc3pQOFBhdFp1UUFwNitmb3V5MFdhZHltOUE2MDVDRUFpZmZod2M3?=
 =?utf-8?B?TlVBUXF6L3ZOaWc5MVdsRldTQXh1WnB3U2pHYXFZNUpkdVg5dm83ZndROEMw?=
 =?utf-8?B?ZWNMUlhCbGQwYytDb0w2aHRudlBSYzhGbGYzbDVLTjI0MWZCcHkvdGtYMFJZ?=
 =?utf-8?B?SW5QazZFYzJhK2tIVTAwRU1oNklhL3BiOW1RWjhKMGRVZ1Jud0NqSlB0SFgw?=
 =?utf-8?B?eUpaWG5GUXBaTXcvaUxvNjQxM2ZPWDhOQU5nSm11S1FkalJZU1pyWUNZd09M?=
 =?utf-8?B?OE1NdWMyLzVrd0Y5eVR0T3c0V01QcFVkb0w4RDRmMURTSGg1YzlmWDQyS2lW?=
 =?utf-8?B?M1FqV2dGWnBlVDJrazB5YjlQeFFyREptN2Z5dms4dHlCekxwTWhOdC9xVmlL?=
 =?utf-8?B?NFlMdklEbVJJN0FNVDlHY1NBWGFZUGFtQVBQUE1EUXFvK1JYd1dhQnNnNXVL?=
 =?utf-8?B?K0xNNTBPNDNicnVPZDJuTzJPQ2h3MjNqaSttYStDTDM0Nkx5eGxBMlFhSlBG?=
 =?utf-8?B?ZkhnK1B1OEg3dWVudlpDblZXdlJIbHFPTCtDOVpKUHR2N29kZG1CUkZPS05Q?=
 =?utf-8?B?Q21zZ0JhZWVJYzRFcldVaHVIR0QxSElzNFlKeEljS3NOaGxRYjZYRlBzVFhL?=
 =?utf-8?B?RTlMd0JzUW1RZnZRdUg2TXBDb21tNWVCL015V05BMkY2TlNlZDB3WXFmcDds?=
 =?utf-8?B?N1A0YSs5Qy9weXJyMTF5cmRhSHoxTHNiSTJZOXJmaFJ4MGhPNFIvMGhFSDdh?=
 =?utf-8?B?cVhxZERZcllHWWEzREw5MVI3RXV2UFFjU1JoMVJJREtaVkc1MVF5RXRQZklu?=
 =?utf-8?B?eVo3RXR6WklGQUtoU1o0dzZud2R0NWNtVy9mQ0lBTng5aForZWxOVGZhV0Zy?=
 =?utf-8?B?WkUvZTF0c2RqYVRybjc2TmQycVhQaHZjSjhPaFFGdXRsS2VKcmpTUlY3R3E0?=
 =?utf-8?B?SzNqNnhuWjZibEZFdnQycjNPNmRNd3lUVEc0WXpQczNxZjJMYU9hVUVpRTdK?=
 =?utf-8?B?VDdvK0htK2N6cU9OU3BqSkdydmdYQS9TR255RDlKQk5PL2p3dFVQME5OK1kz?=
 =?utf-8?B?bW9ueC9xY2Q3WjRyelRpRTFSc0JiMmJKQk0zTEpjbmx0Z3IweGhwbVVYNTht?=
 =?utf-8?B?Q3lTZXNyMkxBL1cyYWtFOXd4SGxNOVFtWXI4RStyZjVHR3BFLyt0M1RhT1dK?=
 =?utf-8?B?bTdXRFhuYWhObWhpU0liZk5tNHRMa3l2L0xmM0U5eVp3dk9mRFlDUXdBek90?=
 =?utf-8?B?d0YwajRoRktzdU1HMnRDMmVKWEM1RFY1RHV3czNneVVWcTVmcjhMSDlUbjVW?=
 =?utf-8?B?aXJaRWZWY2FWamhwRzlJaXZMM0dNRTBSWG9ISGl5NVRTb293UDU3N2VCT2Q4?=
 =?utf-8?B?Yjh3VVpiUXpVR0htd1BuenJsQ01ZNmE2ZWZLc2hiR21nVVprZ28zMmgybFRm?=
 =?utf-8?B?a2VibnFGQnR6NUtQQ3RCdHlYYjB3dFd4WU9wREdaK2MzU29XVkFaYXZ3NnZY?=
 =?utf-8?B?bW8zeTFzS01iQWFCVE1ROFRHWXZVUGMrL3poVm9KS0U3ZDhuU3NtTVNId0lk?=
 =?utf-8?B?Nk9GVUpBR3hvS3ZNMStyZWtnYlpoUFcyZkw3SEJzRUVBcjJjbXNoRzdEUHkx?=
 =?utf-8?B?TDFCUHdGbjNGMkU1dHVuYnpsTVV6TWE2TVhoWlJwU2tQVTVEeWJLOTVrcUFz?=
 =?utf-8?B?UElkK0ZGVi9WcVdGaEtjZDZ6NlFadC9ETDlYeFYwNmtJZ3Z6Z1VkN0phd2Jz?=
 =?utf-8?B?QnJKUklnMERBbTNtbm14by9XV05wM2lhenZEbnJoV1ltMUtGbzdiTHdEeHcy?=
 =?utf-8?B?WlJWdkNNc0F1aFFNdnFJeDhQN0pnQnluQTIzeFh6cFhic3Z2UElnc2c0YjhZ?=
 =?utf-8?B?VVpoZmNNby9vSTMrS3NWNnlsbzA4RURNeWtSaVhla1FZUTcvbXhuTkpCVWQ4?=
 =?utf-8?B?UXcrMGFycGYvelZBZzYvS0w0SEYxdnZuSUF0dTMrcmxrSGRYYVhNc0ttZ1c5?=
 =?utf-8?Q?XGGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStYaFZ5VFdSOHhwSS9FdHR0MGZYWUlMd2NxWDB5eElQZThyYU5XSVk0aGd4?=
 =?utf-8?B?VWRUWU1JaEtNTHpYdk5yL003RDFwVlZHQURjcHR0ejh4VE5RUDMwalc3ZW1P?=
 =?utf-8?B?aGsyblEyTW5BK0F1eFFWZ2M5R05rMDc0SjNuakgrWGllOTVRQzFxaHpXL2JP?=
 =?utf-8?B?RnFTYU9KR1ZHMlZjcVYyVEQ3T1M2VTllNzVkNC96eTEyQnJ1NWxpejF5UU1r?=
 =?utf-8?B?Uy9HdUZhV0ovK2FPTU9XdFFVMU1lSDA0a3gxQ1VUVjVUTHltVEVDL2h6TGVV?=
 =?utf-8?B?VkZQNXgyb0VsZmcrVFlidFBRYjVsZnB6aHM1OFE1RDg0cjdNcnY4eFNkLytH?=
 =?utf-8?B?YThBUDVoQTE0ZzExczdTYjZ3OWpLNWZTTVNPOS9lanZQekszemNRa1dlNU9U?=
 =?utf-8?B?Tm1LSmhYeFZaTGlibkdVSzFwM1hHTWpDRWx1VXdEamxSNjQ1QTdSdDFUNXBM?=
 =?utf-8?B?TmNJTHlDTHo5YmFuaDVSZXZNcmJuVFRiMlFudnE2MUljTUp1SHRzdFdtbmg2?=
 =?utf-8?B?a2pMZEN6QVg5clFMbk1MVHgrUzluZW14VHpTTjhYQzdLTnl4NjlpVEhFS2Y4?=
 =?utf-8?B?RXcvWkZqTHI4bGlYVzNlM2xsSkplMkh4QmpUcEg2UnRTV0hmeThEOUJJd1Va?=
 =?utf-8?B?Tnh2dXM3TDdTZzRnc00zZ2JXRFhsUGZta2xkV2NOanR1ZTJ6czd4R3d1YUJ3?=
 =?utf-8?B?R1cyNHNzZDN6cytFaUdYM2Z6ZjNoNUNTR0g3VmdEUU4rd0xybWJxWDJCR05x?=
 =?utf-8?B?SFJWMDRBQlFQajFraTd4UHFoUVM5VTJ1VFpIRm1Fei9NM1QwNWd4MDlzK295?=
 =?utf-8?B?aktZVWltQmlVRVlxRkY3YVFCbTdackZsTTEyazBCNjJ4OElOMUZQWHlHb0pm?=
 =?utf-8?B?RG83b0NabTFnYVBsNElkN2IrTVgzeVBBclRDYjF2eU1vb1E2UlprNnFDODBS?=
 =?utf-8?B?YlZTbFoxeURTUksxTTEzc3pjMUsydzNkTmNPNzBaeE5kRERrRGQ5L0FoU0tp?=
 =?utf-8?B?aGt5Nk9MWGZCeWFhQnk5YmxmQ3V6Z2dLWGl1TklNTUlKN2dDeUsrQzZjUzBY?=
 =?utf-8?B?eENxclhveGJvcHBhTjVqR2ttUHJWN1lnMkcyTlBwYlJuL3NrZy8xeWIxcDBo?=
 =?utf-8?B?RkJJRU1OQTBxdU5zRzlzaWhETG9nYnJoV3htbmxkNnR4a0pZYzZUUXRobUlu?=
 =?utf-8?B?YnZYaVk1RFJ2a3c2Smd5c2Q2NVNzR0dTUk16WkwrNE5vZ3NnZmp5NzJ5ZnZk?=
 =?utf-8?B?Y0c2eDRmSkRmWmxSZVJSdTlQUUVFVkd1YXpZRUt2elU0RmFrd01jRy9oNzY1?=
 =?utf-8?B?QzNkV0VIQlZzOU12RUE1RVVNT3dDYjB2bGM4UnRRR0h5MTExY2Z1Q3B0MGll?=
 =?utf-8?B?bjNCa2RkLys2WW1qWWsxeXp6OElJVVlXci96bWFWTS9jOWxnbFR0d05HR1k5?=
 =?utf-8?B?NVFsNVV0R0c3UlROeU0xYkdURU9STXgrdnN3MHc4dWl3Nk4wSEVCYTNLTTZs?=
 =?utf-8?B?MThYMkVkTDZQc3VjNjZDYkduMzc0U1JNMDZIVndCVzJBSkorS0RTTy9renlL?=
 =?utf-8?B?dWVmSDlhdWI3b0sxZ0RJaXR2bkdYZ0FmZ1Y3SGhPRS9Oa0tnSHJ1VnBjM0dU?=
 =?utf-8?B?MGZEWTQ3clFHRHpVUmRaSmZVaXcrWDFqekNwTi82M2VDeVdZcitaN2lkUDlX?=
 =?utf-8?B?NHpnVnpMWS91QjNGZStuLzFucDljVzBKdjlDRElNbGNka2R3T1VUTzM2aEFR?=
 =?utf-8?B?MmlqVkdLNm1MR3d0WUpPYUJMbU5MSHFGdmRpQWhUQ3haOEhHVEI3bDhsbW82?=
 =?utf-8?B?RVphdTNnME1HcHMwSEdSRXQzSWlad0RYWmFhYWVaV29UeCtPRlhDSHZtd1NV?=
 =?utf-8?B?cDBYZ01CckVBRzJ0bThDU2dVc09vejJ0NmtEWXVXbGV6NlQ1RXpEMVRhUExW?=
 =?utf-8?B?QTcwU3Q1R2IxbmdKZ0tZc1B3OTdLdzVKaUNnSnZxSmlOLzZvWUQ1aWlEeEpr?=
 =?utf-8?B?dXJhaGxPTEtaZDIyclhIVmR5SzE0UHp0QUdFdERYVzlmNDFvTmpCTGJWU1JX?=
 =?utf-8?B?Z1hMRUo2SFdNMXhicE5JcGdLMXUwUHlHNXZaUE9wYmtrVlFNYlZXQ1V4QjI5?=
 =?utf-8?B?R3NHcUliZ1ZnVFVieEYvbDFpQjNBODd0dlZ1dTRaV2pWdlNIUUtLNDY4K01P?=
 =?utf-8?B?czh3R3NOY1JGc1VZZW1DWXZ3aHBEV1gvMm5DU1NJZHNMdTVPT3lJYldhaVda?=
 =?utf-8?B?MGRBQ0tVcFZSUmEwd3RBWEdocm9PeGVvVVprUjM4VmdYR2NPbmRDSE14dFFL?=
 =?utf-8?B?akZlQWNhZXhiMGprWkNGa3dQVjJPend4ckR2OUl0VjRzRC8zY3Z1UU5uWVgv?=
 =?utf-8?Q?f978b8SGV2Dwgj6s=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb46b70f-b3ed-489c-c496-08de63dea01a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:14:55.5381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRBubu3dTCstdiZoOzA9lsy9rzNwjwx4YcOKu4Ffv7/yp6Djd/k7ah8CruKpkHRUXyx1rRP/0QXhA9WhnorQYjuuqR/294lGcNvomEHkW/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10892
X-Proofpoint-GUID: Ql2NsvXzo61oU6sPZC1GzAzES0zkTsDI
X-Proofpoint-ORIG-GUID: Ql2NsvXzo61oU6sPZC1GzAzES0zkTsDI
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=69832a31 cx=c_pps
 a=wyQZsu7YS+H2q1uHh87QeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=JndJuqGLg7OoDiO99PwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4NSBTYWx0ZWRfX5fwmu3JmN2GW
 DMyrZpYI6xKKwr/Ugb0GMKjTMkYFqcZ5RMFOsxuMVIqn8pehORydmeNpzhsivPE+KS1U1DfyvHA
 lD8x2BQj0z6qwZLwREpaP4IZMA99SddjZ8GfUpovyPyiC22IOA58jlrEa/puRwEmjAu0w3SXJs8
 8pE1Ox+U1gOcGw9FpEPGPG45iUGqKE3zZXjXoCUe6O9rZTM2cuZ/J3AXhgyYkWNvN50ikfYEQoC
 QrSbSTikY1pgWHjz5F5V9/FL2vGqJcG/YxwNscWa+vq0VIXC1cr6u/lLpLDM4SBaLEy9JMEsnWx
 nXlm7yx0pNvD8vf2we9C0WCvCs3Nm9iXtmURHAp4d4KKvEdIH8Z+Ois5xt75Bl7n1nZgRzk+nKe
 /6z1kaFL6lqo23c5Y+nJjJza6GGpMZ4mUsPay0bPtUhHVs70vzULfI8LOHPUPir+VPRXf1GP3FF
 f7kd/S4phQzf9NO1JVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to use QOM and the dynamic object module loading.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h   |  2 ++
>   audio/alsaaudio.c   | 27 +++++++++++++++++++++++++++
>   audio/dbusaudio.c   | 26 ++++++++++++++++++++++++++
>   audio/dsoundaudio.c | 26 ++++++++++++++++++++++++++
>   audio/jackaudio.c   | 26 ++++++++++++++++++++++++++
>   audio/noaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/ossaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/paaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/pwaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/sdlaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/sndioaudio.c  | 26 ++++++++++++++++++++++++++
>   audio/spiceaudio.c  | 26 ++++++++++++++++++++++++++
>   audio/wavaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/coreaudio.m   | 26 ++++++++++++++++++++++++++
>   14 files changed, 341 insertions(+)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 06f5160e8df..29f5864be69 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -241,6 +241,8 @@ struct SWVoiceCap {
>   
>   struct AudioMixengBackendClass {
>       AudioBackendClass parent_class;
> +
> +    audio_driver *driver;
>   };
>   
>   struct AudioMixengBackend {
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 814820e2864..881f3d0349d 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -27,6 +27,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   #include "trace.h"
>   
>   #pragma GCC diagnostic ignored "-Waddress"
> @@ -36,6 +37,22 @@
>   
>   #define DEBUG_ALSA 0
>   
> +#define TYPE_AUDIO_ALSA "audio-alsa"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
> +
> +struct AudioALSA {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver alsa_audio_driver;
> +
> +static void audio_alsa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &alsa_audio_driver;
> +}
> +
>   struct pollhlp {
>       snd_pcm_t *handle;
>       struct pollfd *pfds;
> @@ -945,8 +962,18 @@ static struct audio_driver alsa_audio_driver = {
>       .voice_size_in  = sizeof (ALSAVoiceIn)
>   };
>   
> +static const TypeInfo audio_alsa_info = {
> +    .name = TYPE_AUDIO_ALSA,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioALSA),
> +    .class_init = audio_alsa_class_init,
> +};
> +
> +
>   static void register_audio_alsa(void)
>   {
>       audio_driver_register(&alsa_audio_driver);
> +    type_register_static(&audio_alsa_info);
>   }
>   type_init(register_audio_alsa);
> +module_obj(TYPE_AUDIO_ALSA);
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 96d4fa3f471..789d72f6903 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -26,6 +26,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "qemu/dbus.h"
> +#include "qom/object.h"
>   
>   #ifdef G_OS_UNIX
>   #include <gio/gunixfdlist.h>
> @@ -44,6 +45,22 @@
>   
>   #define DBUS_DEFAULT_AUDIO_NSAMPLES 480
>   
> +#define TYPE_AUDIO_DBUS "audio-dbus"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
> +
> +struct AudioDbus {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver dbus_audio_driver;
> +
> +static void audio_dbus_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &dbus_audio_driver;
> +}
> +
>   typedef struct DBusAudio {
>       Audiodev *dev;
>       GDBusObjectManagerServer *server;
> @@ -711,10 +728,19 @@ static struct audio_driver dbus_audio_driver = {
>       .voice_size_in   = sizeof(DBusVoiceIn)
>   };
>   
> +static const TypeInfo audio_dbus_info = {
> +    .name = TYPE_AUDIO_DBUS,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioDbus),
> +    .class_init = audio_dbus_class_init,
> +};
> +
>   static void register_audio_dbus(void)
>   {
>       audio_driver_register(&dbus_audio_driver);
> +    type_register_static(&audio_dbus_info);
>   }
>   type_init(register_audio_dbus);
>   
>   module_dep("ui-dbus")
> +module_obj(TYPE_AUDIO_DBUS)
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 7a03d1dad86..f1902e55262 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -33,6 +33,7 @@
>   #include "audio_int.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   
>   #include <windows.h>
>   #include <mmsystem.h>
> @@ -41,6 +42,22 @@
>   
>   #include "audio_win_int.h"
>   
> +#define TYPE_AUDIO_DSOUND "audio-dsound"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioDsound, AUDIO_DSOUND)
> +
> +struct AudioDsound {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver dsound_audio_driver;
> +
> +static void audio_dsound_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &dsound_audio_driver;
> +}
> +
>   /* #define DEBUG_DSOUND */
>   
>   typedef struct {
> @@ -694,8 +711,17 @@ static struct audio_driver dsound_audio_driver = {
>       .voice_size_in  = sizeof (DSoundVoiceIn)
>   };
>   
> +static const TypeInfo audio_dsound_info = {
> +    .name = TYPE_AUDIO_DSOUND,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioDsound),
> +    .class_init = audio_dsound_class_init,
> +};
> +
>   static void register_audio_dsound(void)
>   {
>       audio_driver_register(&dsound_audio_driver);
> +    type_register_static(&audio_dsound_info);
>   }
>   type_init(register_audio_dsound);
> +module_obj(TYPE_AUDIO_DSOUND);
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 7a3fcaedbae..48a466ed532 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -27,6 +27,7 @@
>   #include "qemu/atomic.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "jack"
>   #include "audio_int.h"
> @@ -34,6 +35,22 @@
>   #include <jack/jack.h>
>   #include <jack/thread.h>
>   
> +#define TYPE_AUDIO_JACK "audio-jack"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioJack, AUDIO_JACK)
> +
> +struct AudioJack {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver jack_driver;
> +
> +static void audio_jack_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &jack_driver;
> +}
> +
>   struct QJack;
>   
>   typedef enum QJackState {
> @@ -691,10 +708,18 @@ static void qjack_info(const char *msg)
>       dolog("I: %s\n", msg);
>   }
>   
> +static const TypeInfo audio_jack_info = {
> +    .name = TYPE_AUDIO_JACK,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioJack),
> +    .class_init = audio_jack_class_init,
> +};
> +
>   static void register_audio_jack(void)
>   {
>       qemu_mutex_init(&qjack_shutdown_lock);
>       audio_driver_register(&jack_driver);
> +    type_register_static(&audio_jack_info);
>   #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
>       jack_set_thread_creator(qjack_thread_creator);
>   #endif
> @@ -702,3 +727,4 @@ static void register_audio_jack(void)
>       jack_set_info_function(qjack_info);
>   }
>   type_init(register_audio_jack);
> +module_obj(TYPE_AUDIO_JACK);
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 4ed9d2156c5..e6e8bfd3323 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -25,10 +25,27 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "noaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_NONE "audio-none"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioNone, AUDIO_NONE)
> +
> +struct AudioNone {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver no_audio_driver;
> +
> +static void audio_none_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &no_audio_driver;
> +}
> +
>   typedef struct NoVoiceOut {
>       HWVoiceOut hw;
>       RateCtl rate;
> @@ -138,8 +155,17 @@ static struct audio_driver no_audio_driver = {
>       .voice_size_in  = sizeof (NoVoiceIn)
>   };
>   
> +static const TypeInfo audio_none_info = {
> +    .name = TYPE_AUDIO_NONE,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioNone),
> +    .class_init = audio_none_class_init,
> +};
> +
>   static void register_audio_none(void)
>   {
>       audio_driver_register(&no_audio_driver);
> +    type_register_static(&audio_none_info);
>   }
>   type_init(register_audio_none);
> +module_obj(TYPE_AUDIO_NONE);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 6ad20ab1876..eb98cc62e9c 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -30,11 +30,28 @@
>   #include "qemu/host-utils.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   #include "trace.h"
>   
>   #define AUDIO_CAP "oss"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_OSS "audio-oss"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
> +
> +struct AudioOss {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver oss_audio_driver;
> +
> +static void audio_oss_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &oss_audio_driver;
> +}
> +
>   #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
>   #define USE_DSP_POLICY
>   #endif
> @@ -772,8 +789,17 @@ static struct audio_driver oss_audio_driver = {
>       .voice_size_in  = sizeof (OSSVoiceIn)
>   };
>   
> +static const TypeInfo audio_oss_info = {
> +    .name = TYPE_AUDIO_OSS,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioOss),
> +    .class_init = audio_oss_class_init,
> +};
> +
>   static void register_audio_oss(void)
>   {
>       audio_driver_register(&oss_audio_driver);
> +    type_register_static(&audio_oss_info);
>   }
>   type_init(register_audio_oss);
> +module_obj(TYPE_AUDIO_OSS);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 0c06a397195..cf67a9f7593 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -4,12 +4,29 @@
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   
>   #include <pulse/pulseaudio.h>
>   
>   #define AUDIO_CAP "pulseaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_PA "audio-pa"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
> +
> +struct AudioPa {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver pa_audio_driver;
> +
> +static void audio_pa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &pa_audio_driver;
> +}
> +
>   typedef struct PAConnection {
>       char *server;
>       int refcount;
> @@ -931,8 +948,17 @@ static struct audio_driver pa_audio_driver = {
>       .voice_size_in  = sizeof (PAVoiceIn),
>   };
>   
> +static const TypeInfo audio_pa_info = {
> +    .name = TYPE_AUDIO_PA,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioPa),
> +    .class_init = audio_pa_class_init,
> +};
> +
>   static void register_audio_pa(void)
>   {
>       audio_driver_register(&pa_audio_driver);
> +    type_register_static(&audio_pa_info);
>   }
>   type_init(register_audio_pa);
> +module_obj(TYPE_AUDIO_PA);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 30f717ccacf..3c2fbccaea4 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -13,6 +13,7 @@
>   #include "qemu/audio.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   #include <spa/param/audio/format-utils.h>
>   #include <spa/utils/ringbuffer.h>
>   #include <spa/utils/result.h>
> @@ -27,6 +28,22 @@
>   
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_PW "audio-pipewire"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
> +
> +struct AudioPw {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver pw_audio_driver;
> +
> +static void audio_pw_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &pw_audio_driver;
> +}
> +
>   typedef struct pwvolume {
>       uint32_t channels;
>       float values[SPA_AUDIO_MAX_CHANNELS];
> @@ -847,10 +864,19 @@ static struct audio_driver pw_audio_driver = {
>       .voice_size_in = sizeof(PWVoiceIn),
>   };
>   
> +static const TypeInfo audio_pw_info = {
> +    .name = TYPE_AUDIO_PW,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioPw),
> +    .class_init = audio_pw_class_init,
> +};
> +
>   static void
>   register_audio_pw(void)
>   {
>       audio_driver_register(&pw_audio_driver);
> +    type_register_static(&audio_pw_info);
>   }
>   
>   type_init(register_audio_pw);
> +module_obj(TYPE_AUDIO_PW);
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 707110973ac..cc05c1d4531 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -28,6 +28,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #ifndef _WIN32
>   #ifdef __sun__
> @@ -40,6 +41,22 @@
>   #define AUDIO_CAP "sdl"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SDL "audio-sdl"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSdl, AUDIO_SDL)
> +
> +struct AudioSdl {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver sdl_audio_driver;
> +
> +static void audio_sdl_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &sdl_audio_driver;
> +}
> +
>   typedef struct SDLVoiceOut {
>       HWVoiceOut hw;
>       int exit;
> @@ -491,8 +508,17 @@ static struct audio_driver sdl_audio_driver = {
>       .voice_size_in  = sizeof(SDLVoiceIn),
>   };
>   
> +static const TypeInfo audio_sdl_info = {
> +    .name = TYPE_AUDIO_SDL,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSdl),
> +    .class_init = audio_sdl_class_init,
> +};
> +
>   static void register_audio_sdl(void)
>   {
>       audio_driver_register(&sdl_audio_driver);
> +    type_register_static(&audio_sdl_info);
>   }
>   type_init(register_audio_sdl);
> +module_obj(TYPE_AUDIO_SDL);
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 8197b8b0b47..6a3d93efd51 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -20,10 +20,27 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/audio.h"
>   #include "trace.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "sndio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SNDIO "audio-sndio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSndio, AUDIO_SNDIO)
> +
> +struct AudioSndio {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver sndio_audio_driver;
> +
> +static void audio_sndio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &sndio_audio_driver;
> +}
> +
>   /* default latency in microseconds if no option is set */
>   #define SNDIO_LATENCY_US   50000
>   
> @@ -555,9 +572,18 @@ static struct audio_driver sndio_audio_driver = {
>       .voice_size_in  = sizeof(SndioVoice)
>   };
>   
> +static const TypeInfo audio_sndio_info = {
> +    .name = TYPE_AUDIO_SNDIO,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSndio),
> +    .class_init = audio_sndio_class_init,
> +};
> +
>   static void register_audio_sndio(void)
>   {
>       audio_driver_register(&sndio_audio_driver);
> +    type_register_static(&audio_sndio_info);
>   }
>   
>   type_init(register_audio_sndio);
> +module_obj(TYPE_AUDIO_SNDIO);
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 7db2d1f0dfd..bfa249b18c4 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -24,11 +24,28 @@
>   #include "qemu/timer.h"
>   #include "qapi/error.h"
>   #include "ui/qemu-spice.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "spice"
>   #include "qemu/audio.h"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SPICE "audio-spice"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSpice, AUDIO_SPICE)
> +
> +struct AudioSpice {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver spice_audio_driver;
> +
> +static void audio_spice_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &spice_audio_driver;
> +}
> +
>   #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
>   #define LINE_OUT_SAMPLES (480 * 4)
>   #else
> @@ -325,10 +342,19 @@ static struct audio_driver spice_audio_driver = {
>       .voice_size_in  = sizeof (SpiceVoiceIn),
>   };
>   
> +static const TypeInfo audio_spice_info = {
> +    .name = TYPE_AUDIO_SPICE,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSpice),
> +    .class_init = audio_spice_class_init,
> +};
> +
>   static void register_audio_spice(void)
>   {
>       audio_driver_register(&spice_audio_driver);
> +    type_register_static(&audio_spice_info);
>   }
>   type_init(register_audio_spice);
> +module_obj(TYPE_AUDIO_SPICE);
>   
>   module_dep("ui-spice-core");
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 46460a5d573..480da5048fa 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -25,10 +25,27 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "wav"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_WAV "audio-wav"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioWav, AUDIO_WAV)
> +
> +struct AudioWav {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver wav_audio_driver;
> +
> +static void audio_wav_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &wav_audio_driver;
> +}
> +
>   typedef struct WAVVoiceOut {
>       HWVoiceOut hw;
>       FILE *f;
> @@ -214,8 +231,17 @@ static struct audio_driver wav_audio_driver = {
>       .voice_size_in  = 0
>   };
>   
> +static const TypeInfo audio_wav_info = {
> +    .name = TYPE_AUDIO_WAV,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioWav),
> +    .class_init = audio_wav_class_init,
> +};
> +
>   static void register_audio_wav(void)
>   {
>       audio_driver_register(&wav_audio_driver);
> +    type_register_static(&audio_wav_info);
>   }
>   type_init(register_audio_wav);
> +module_obj(TYPE_AUDIO_WAV);
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 997017a1e96..882e47f8c25 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -29,10 +29,27 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "coreaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioCoreaudio, AUDIO_COREAUDIO)
> +
> +struct AudioCoreaudio {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver coreaudio_audio_driver;
> +
> +static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &coreaudio_audio_driver;
> +}
> +
>   typedef struct coreaudioVoiceOut {
>       HWVoiceOut hw;
>       pthread_mutex_t buf_mutex;
> @@ -673,8 +690,17 @@ static void coreaudio_audio_fini (void *opaque)
>       .voice_size_in  = 0
>   };
>   
> +static const TypeInfo audio_coreaudio_info = {
> +    .name = TYPE_AUDIO_COREAUDIO,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioCoreaudio),
> +    .class_init = audio_coreaudio_class_init,
> +};
> +
>   static void register_audio_coreaudio(void)
>   {
>       audio_driver_register(&coreaudio_audio_driver);
> +    type_register_static(&audio_coreaudio_info);
>   }
>   type_init(register_audio_coreaudio);
> +module_obj(TYPE_AUDIO_COREAUDIO);

Still my previous comment re: s/parent/parent_obj/ as per the style 
guidelines, but otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


