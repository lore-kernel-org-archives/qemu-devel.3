Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A75C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cKJ-0005j0-1P; Mon, 21 Sep 2026 07:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cKE-0005gr-Mi
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK5-00080A-6d
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:45 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAhRul932481; Mon, 21 Sep 2026 04:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=m5SNFoHnPUZCyGNTsFIpWVJZXeIqOu76/NcaePJeJ
 6E=; b=qiLzSFjV9+PM5pCF/cExyHmv9FD7rGQcZ0kaPOuAdGzdLrnxvXQpriThP
 ZiG5e526qVutcbhVhc41xCbsSfasCc1J+0Ud5XhXd3lm4o5zGCZC2nOFbAm2S0VX
 iuAqP4xETI2gi6uvHObFQOVZwAjdhPbx3jtZmR5R0mM1FWTXYuhcfy9mhjaffj3U
 Aux64PVvSf1InfjT8PASnSHtj/buFGODMP3Bz+2BQXFhq769sFs+No25rSCD+AcO
 IGA3B2sCOm5Wqvj/M3R6hl+YLRJf6jVQ+yAbu5BXHlR/cX2+afXd9Za1R3sOG06w
 LjD7I7EU9JIfWRQc0oex5uEdvhQAQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022083.outbound.protection.outlook.com
 [40.93.195.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gssxwk7tx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSYm5cktpAgGaKxSI8WpiG0j+t1ZlWKiFEPY6JuLu9YQFAOVaUBlMW0I6OkY++gx1SBtKE+cE9IpI50yoFczIg3wrjmvlTE3lYpMvgkS2Qx6pQTbw0aPeKlENbnobkP6Sgr3dFGW03gwp94Dbhrd7SKAuk/HCvj/ZxbUGa2NPzgU6cTQ0wxE/uoO+IAIUGjB4g2etnr42EOKSiTOzbWJoXkAbu+g0xVpO51CO2tSETAkj8iSHlTHmlfZruasvkBjWqv2CiN+l9nRfdjUYJQjURdL1MM5JvfumoU/5793zH5Z+n5XuaXTNQsPsIM0yGva1m7g2iN4LDg1ZpbIANLN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5SNFoHnPUZCyGNTsFIpWVJZXeIqOu76/NcaePJeJ6E=;
 b=nxDs8/brVd+26IfF9Zuvb/A1RZtUEwp2AxPbi1EtSEbOEtZsiYSWyL/CgEYC6kS72Lz5hGPZggkOY0loGJvgWQON1TC/tHyz4sdhfkZEU7+1WF5z8AExm+LAP3kvZuksu4pMLRE4vMFLM6SxCAONXvc2axPJswu32KQCfXew+ZePeAWNCgqlb4UQiJ3ipA5W8lx23fxWUtCnwHBxfJtWzbgXYxeS14Snu2rITqW3qnVq55bAZNGmDOU7JTGretl6TiF8Auc9sImmwYFfQRPXgnfMsMv+CNUFg6uggW8A4Cxsa827vcNsRtrIqYAO+k9udTd+iQEdpKBK3LX4IOROGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5SNFoHnPUZCyGNTsFIpWVJZXeIqOu76/NcaePJeJ6E=;
 b=dF4gM4Dym7DZsBRyfsDWjauIJSoOvToVfAQ2z8hT9jiJLdd6OfECGZYyPWs6N+xOEj+9ir3qxE8LzH8Ts9Gkw/N/FPRKX437YWNuanl0CZ9sKy9ueFQzr67LTUiq3fBZU7+EnkRxk7pAI30bAnvd4JFTH9r2PV6giWgLbbLDTl14UIPIdRJJxRFJNIz++rLHszaRhlf/7PWQ46EqRVrm3TDGRkJZY+T+uUs6pfOjANSIvIVSdfwaTBCg4rvSYjf0Nprz5Tvc01cwsiYPLFf3kuf1pWzb5BHV/WHISjtBQZ5rW2gpF+w4UsL3IEUPly+BVcDOmS9DCmkVIb0UVD9chg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object
 props to class props
Date: Mon, 21 Sep 2026 12:35:14 +0100
Message-ID: <20260921113559.1299740-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 8136e396-f6a6-4a13-e839-08df17d495a4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jjxZVqa9n2dbwwwa1+GCEJjXfVz+p+3pA8XfvHVdHhBwkNVsjYA4wdUAXAcXi4BcUpQvvEPU7J21odgkxXJIXQ4WyFh8xYYFs7JO+oA8LOuYa7oWglFoQeZ9oTeVdkXlYj0ao+Q9/JTyILK27tc65beZyIWBl7Hjw8Gh1wik8Ctx0K6t8T0t0SX8hLeJywsx0uloIujAW3Kr6DLHvqKH3BZEe+pzyR8jS1Rovkurxn/0YMugMOZPIr3x3rgUYaLtVgUVxpYZpIE/w3JJcHCYTETOF1nMWzo7yhehVlBOLsTE9U4CM12xN7e14dIDIQnX4iXBs7lhXT8hv8eRdXq+UX793a3tMkZ8zIYTlTz7l33FoZ3NR4GN+WuQJcaxkCkx36sSCxZVsPRQM/7ZKv9Wu0hsdq3WmToVS9scM5j/zjLo8eHQ1GW9EIEveXk6GKXsfUJqpu6iE1shb658eIysR+s+TINv2t0brzjyMDC5oLiwNwlunsPhx/mO9IaxHNZF6cq3Wx0AtoYY03Lo+i5IGpQagzgupku1jisYfInCsvVhCdpcqF+eQcwaba6goycUaawY54oqRXEQaT1zV9k9Yd7i5qCpSCYR82AJQBSe2rc6VEeIa2iEe0L/A4yCEl35z9P8wnfnx00pLVnuqtONeeGHUloG9UqWLvdKAI1tpMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snk4bzVrenhjdmxZeFpyS1F0SlU5NEVNam0xTDRiZDRkWmdRRTBrRUFuLzBP?=
 =?utf-8?B?TGZWTEF0SVh1c2tlS0JJb3BHTlgxbXc4VkhuT2Y2b0tsOEt6ZGpzZkNaWXlY?=
 =?utf-8?B?eTNYajQ3cDM4YTlqZTUwb2p5VjVPNldzaFlDbUYvYUpYekMvYlFSbFZuRFBk?=
 =?utf-8?B?T3E0T3dkQjFnVFJBUHk4dWdXZTBGOGhWMHN4V3h2K1docXd1S2NzY2NTTDdi?=
 =?utf-8?B?SlRYaHk3Sjh5Sjk4NVhYNE9pVmUvcnBGejcya24yQTdnYktwWXZZYzZvV2dr?=
 =?utf-8?B?RndzZXpCWkhiUFhGNXZwejRTVllUTXJ3MHBtT0ltbjFCM3IwZnlKQ0gvRFl2?=
 =?utf-8?B?NERzbzc3d0tSNUNxbjN5ZHJtWGRNWERvazd5K3NxcnppWWlXNGhWUkZoekl4?=
 =?utf-8?B?VEg0eVJYN2xMZEI2YktCSkVyYTE0cm1qbzMzTVFqeHVmUWZodGlaRE8wMXUz?=
 =?utf-8?B?WXVtL2xIUnBNV2RMV1lNcEZlVUt3QjJQUUMwZEp4cFNHMCtUcFUxSWV1Wm9R?=
 =?utf-8?B?QUhWMEJlTENrcXlxRDBnQ09RakQwVEVFOFNxbkVHeklkN0dMOFUrRTkveUp5?=
 =?utf-8?B?Nytvb1VTRHN0QWRoZXVFRExEcGtGc2t5VmY2UmIxc25BTHRVSkM2WTRUeE1L?=
 =?utf-8?B?dXZ6NG1SMW5oN0lJUk50eS91WmNteG44aklPZ0p2T2tKTm15Y0ZKM0JnbFZy?=
 =?utf-8?B?RG01TkwrVk5NRU1IRUZHTTJuanlvNVlYamZsWnYvRlFaUm0yWmt4WjVVN3E3?=
 =?utf-8?B?eEkxT3VGOWh5eHM2TkpYZ0x6Nmcza2ZROVVGbU1ONzRBSmoxOEFSSk9vaTB2?=
 =?utf-8?B?Sit2emRYVjB6UjU2Y1ZQb1VKSzFlWXRpYXhjeEdaSk5hVzEyZTI3bW4yNEVh?=
 =?utf-8?B?dlNjUm9MU0dxaHpFZnJZMDYwaGsvSWJOUlBvQmdOZlczMGt6d3llNGVRVFB0?=
 =?utf-8?B?M0sxWHAzanJZZk5vTXNBMVNLU3lYMVh0NlFXa0tJVTR4UHk1Q1Bmazd3c2xu?=
 =?utf-8?B?d2NyWDdyUTBNRkdoV3BISDU3SkdNUzh4dllSTTFQMWtwODNHSVIvUEVTSjdQ?=
 =?utf-8?B?K3ozdEQwcFdmV2dhSHhjNVNvQ1NkZnlyK0pHOW1aTDZxRlp0RnBxQUpOYWpx?=
 =?utf-8?B?R0J6emRmRTg3RWJJWHc5RUU0NEd3UmdtNFQ4aUUyZG45dGQrbmhYbXhzbmM5?=
 =?utf-8?B?ZGxmUFBCcDFWaS9xcXlUVnllcVdHeXA1bG9CU1dmK3NxVHl0RHBPcjJwMEVO?=
 =?utf-8?B?d1N3TkhVZDI0VnBkeHhTU01yWGFHUEFxM0k2QU0vQldXTzBwMnZ3bGIyakJ4?=
 =?utf-8?B?N01aU3Y0VC9pOHhDS2ZiM2tYYVVyTVlsWVlwOW96Ymh5RW8wRzgvZVVmN2tX?=
 =?utf-8?B?Y2VqYmpMS2RtakkxRmQzQmpDYnhvd1ovNG8renpoZmdIbnVsd0lkTmJvRzFr?=
 =?utf-8?B?YnZsbzZUdi85U2NjQkRFanFGM29DbkJkQkYxOHdlRGYzT1lHOGN4Vm04UVNu?=
 =?utf-8?B?VnFDRlFpYlNMcU0zVFdOWHFmMjlGN2lDaEl4R2pINzdTeWF4WDJDaFNnV0hk?=
 =?utf-8?B?VnlPWlluV1VacEw0TCtyZVArTHhIM2ZKdmNSZXpwOXNJdXJ5M2F1ZExkQXZk?=
 =?utf-8?B?Uloxc3JzR3F2eGFtV0JkS2JNc3AwcE83b2ZwNXQ4aFRBMlZOK2hZWjVZUnQx?=
 =?utf-8?B?L2trYklMaE9Mbmd6TjlWN2N1Tm5iTWtEaFB1V0MwQjBGc3lPMUZiL0tZQmgy?=
 =?utf-8?B?eWpJWitldlU0N1hiT2FkOEhyRlZFaW1yS3k4ZHo5ZGlwMFo4VVlLd05ZNk5F?=
 =?utf-8?B?V2JwQ2RqdCtHK1J0SFJKUTRGa1VxNldyWnMxL005bVEzMDF2UVRBblBmWkNJ?=
 =?utf-8?B?aDZ4b05rc00vRElibXBGRHljclFyMHVDMGoxMWUyTUNxS1JZK29qQnlibDJU?=
 =?utf-8?B?eUR2T2UrdSsyY0hEY0dVb0V5MVk4NDNVUWRzRkl2QVJ2dlhZOG12Zzg4Z05T?=
 =?utf-8?B?Y3pWVEZJL1RyM3Q5M0g4SFZKQmJ5M2RIbUdpemhFeDBCMThEQnBPRncvQmF6?=
 =?utf-8?B?bkdyaVhWMXd6VVdEak1Wc2hlWThBWkR4TllYOGJhL3ZMN21CUEhtU1N6UHZK?=
 =?utf-8?B?T3B2WCthbklxYzF2QmFNVysyNFh1ZW5qU3AzVG5VQnJWTVRnVjIxeWdQRWxu?=
 =?utf-8?B?U0RXbys5aGpxTG1JbVkxNGxpdzIyOFFCWkEvU2pCWFJCTU1qZTRhazF1Sm1S?=
 =?utf-8?B?cHVOTTlBQ1hhWkZOcGNZQzd1cmg2ZG5WWUxvY01zL0lZNVF1MHZiQTJrUEVy?=
 =?utf-8?B?STBXMDFuVWdCMkNKbXRBMHBmTGR0b2VmTnlWTStHcGcyTG1CUWVRU2YzU25P?=
 =?utf-8?Q?2k0JHbmsoOG6wiUc=3D?=
X-Exchange-RoutingPolicyChecked: swtUOJ/BwbHmtvRjraj4i/1lnRNlX4o+w1T7JdFZyIwWsNKQN35pgtqfJe9ln/gZUWgf0thjMaUeGJvvSy1QhDus0X1KTIy+2KvUzeAlUPch3lv41/eSdXzGo5dk2Nng95oo/3Z1KT0mDiV7z3B73f/M/cp7kM9A0hgE72a+vPX0jnx738i0IQ02l0GlluSIqR6dPlGSka6DfVjZ5OUKJYIlbUEb8bM1+2Ud0eBxbnPPb/PkrmreDqxZbpDfabGz0RX/EDXpFAdcpy31ljNr9M8faMY4w0WpKSc1+KnaOUu5KREhT7HENX/xrvJRlAHFK8XV9IMJlgy4hVz7r5J9pg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8136e396-f6a6-4a13-e839-08df17d495a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:32.3248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaWvWoGT8rCVmi4fVxn0Xeml2ceIyAiSfFJa/9+ZopTK9HsicUl1br1+leoBvhLOY6roYX6i8Rxu4wkAIr3fBI7wN/VZak12ghcrJOitLXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX9bQ2HIlumrb1
 Ez0URrA2/3/oatv7+c0ETpZsgpOy9ttlekc0opMujTv7js3qUWjtmHY64w7GvE1OyZn4m/q4Mez
 uWjPJyfzPPR+wCrkU6bTw3zoQ4JoVKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX2ggp2EE8dgO3
 1Tl1VlSwKKxmYo8gce1wBopYz2YAaTckgenINfOFhdpVnemtvLGNor3J3kp6fxbt8HhIBv5dJ4g
 4A4XRU++TDwgiE596YduhQnL1h/odmAGSXYNMHr2U21fSPXIUthdd5S+78SomZt0vQu6qC5NZ+r
 kgdyUEhZs+5z4dte6lFqrOHoL5aKQ1PdseYM84b4ejnF28eKaA7ukk1AnEWLapcNo3lYNMNIIIB
 qstpgD5y1Y0UyH11SpzoKXD8KMar38iJAQnE8cp0JxkncKWtnw3CR1oyQRsR1cZFjemgejGsESE
 m4/FGpttHwuiKraPhy+gM3mJYm44RFsEdAJ2L0q6R1bxcQwfJYjwIG8BG0JB8m7/iZIrx6PNkgr
 koTDsVQLZetABoOv0cxWsd6r6NRI6cuO4ZZZq6WSGTQrgYDDVG/JrpsfeGJN5jqUliFl42LnMWX
 1FoM7rGhHrnOHhbBcSQ==
X-Proofpoint-ORIG-GUID: iXAgWgMi-DjyznDicrPD2FqofjHxU0bq
X-Proofpoint-GUID: iXAgWgMi-DjyznDicrPD2FqofjHxU0bq
X-Authority-Analysis: v=2.4 cv=fphJ914f c=1 sm=1 tr=0 ts=6ab116c1 cx=c_pps
 a=qXrkyhrtrlo5bn8cMY6OCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=8Hp0nKSQPNhna13KrZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Now that the pflash0 and pflash1 machine properties are class properties, if
they are unspecified then QOM returns an empty string as opposed to returning
a property not found error.

Before this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
Error: Property 'pc-q35-11.1-machine.pflash0' not found

After this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
""

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 8 ++++++++
 hw/i386/pc_sysfw.c   | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index cbe88a1788..8edec62a1a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -40,6 +40,8 @@ typedef struct PCMachineState {
 
     Object *alias_pcspk;
     Object *alias_rtc_time;
+    Object *alias_pflash0;
+    Object *alias_pflash1;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 37d199f2dc..b649f184de 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1800,6 +1800,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                    offsetof(X86MachineState, acpi_dev),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
+    object_class_property_add_alias(oc, "pflash0",
+                                    offsetof(PCMachineState, alias_pflash0),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
+    object_class_property_add_alias(oc, "pflash1",
+                                    offsetof(PCMachineState, alias_pflash1),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..441e777191 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive");
+    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
     /*
      * The returned reference is tied to the child property and
      * will be removed with object_unparent.
@@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
-    char *prop_name;
     int i;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
-            prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
-            g_free(prop_name);
             object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
-- 
2.43.0


