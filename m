Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C557CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 05:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNm4O-00045V-Fz; Tue, 25 Nov 2025 00:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNm4J-00043r-Kp
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 00:58:29 -0500
Received: from mail-southcentralusazon11013055.outbound.protection.outlook.com
 ([40.93.196.55] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNm4H-0007lb-Fq
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 00:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osNv+R06rqs3132tk6qG3f30f3tROkpwd7HnIGgDiXS2WnLaKwNiKvyMCsjhdNr3p2In+wKPFEVfG7Cj6c41IVA6/7tkURuN9d53tL7w8fOWIHkSGZ/bBiAOzLVyJmtBnNn6G66ABO3maPhT934Da3sP+C80Njm3f5I8snozUMr9xKgfUQv02pEVumj0UWANToPQHCW8NORO8+l8YiJYs2xntw70mn/krM77gxcINeocOPE2WhAQ7+lYCVaL5Lo5RisvCaLOXLAmOlkrLFUofNfVPe4Bv5HtVecRokuQdCTuQhlJDG34p4cArGIPA49cv/jPFfOXCLuA/j+28Eafrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp7PmfHpYscqbCVHlA5y7E833aZjCHN6Pd3piBvwsXQ=;
 b=bMYN2SiKLIY9VoXQIiGUsgnDZsr/dVob9v1fL/J8VTMiAd4Osh6XLTjoLjPGg8PI2zv1MV6HdBQeTI2+rTSp3iJuZMD6DjG+0U9k+C2JEtAAHYLOybmV5hU8q2iYIrrYl+kZeIRV5YetQwedyOhGuH38VsfyymtKD04UGtKP0SfWfKGahDA1PGZdwGRB/6wmWMXuxPkKnyLTuxJbiorR8+TgP5Ba72hgHfL+yj7DlNFbhq/Jv7wx0pAWq2elN8oNRhf7bBktz7i+N2k/5VRdu8UmhwAvAzcoPM3momSVgQSiOazkVOZml6JWSGehGnIScCJKb3aJSP5aQzfD0pR9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp7PmfHpYscqbCVHlA5y7E833aZjCHN6Pd3piBvwsXQ=;
 b=DTXhAXL1ausX8htRbM9SSraAN96FeRb0xslmBy1lCtPhhSbLSHv5I7lKZq+K8VlobLxZA94xNH7OJBlBC+ajY2I8XvvE3Qths9lV/KeJ/IzdEsyUOxEKH95og41phbkJIfzxURK3ggObShYTU/WesF07xS2xDkwwDWEnS39djKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 05:53:19 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9343.009; Tue, 25 Nov 2025
 05:53:19 +0000
Message-ID: <4f9eda65-ef9f-4aee-8c69-09f5930d6a13@amd.com>
Date: Tue, 25 Nov 2025 13:53:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
References: <20251124032423.227712-1-honghuan@amd.com>
 <20251124032423.227712-3-honghuan@amd.com>
 <5d48ae13-eb21-440a-a604-9f90a8e9c11f@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <5d48ae13-eb21-440a-a604-9f90a8e9c11f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0075.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::15) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 3240183e-1dd0-4cbc-0d3b-08de2be6ef4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXF5TjlYNm1IaFJkMTRadVJCWVRqcVZvTk5qZjQ4UC85bDA5MTZXQTlUekEy?=
 =?utf-8?B?RWRaL1VwY0daRCtzeUJSVlBHZUNacUIzbWVkNGhxMzlmbnBqblpwZkJjbXhG?=
 =?utf-8?B?OWpIR2IrOXA5M1c5RFoyR3ZZa3MxS1hDc2pRODI4N2RhN1B5Z0p4NTdpNUpu?=
 =?utf-8?B?SFVUNGQ2ekluVmNSQlRUZHNVSXBNUDB3eUEzT211Mi9GNHJEYTZCVFBuV1V2?=
 =?utf-8?B?ZUprNnJQS1dPdmxLVmY5czJiSFV6dUljaFlMQm45a0d6cDI2REMySlIra2dB?=
 =?utf-8?B?Q1l5QzZVVDE2Q3pVTERmME52MWlwaDIyZDl6UmJLVWJJWFd2eGJFb2I4UE1l?=
 =?utf-8?B?U1hqSVh0cHR2dXVCYjhLN25jM04yL29xcDRpVWZCRk5Pc0ZSNjJsRFViS0xF?=
 =?utf-8?B?Sm9YY3pXVXRVSHBYZ08vVlNlQjBnNWxpTWNBNGpvcVRIQ3RNZWJ5Tko0TGxF?=
 =?utf-8?B?T29EeCtiMVp6a25HVzUxOW01UzUyRnFVTlJEaE1nbDdRQi9zdCtVNDkxSys2?=
 =?utf-8?B?a2x3UmFSazBZcm1laWlzU1Evbzg2QU1rUU9oYk9XdUY2ajZsbXljY3BDZkxj?=
 =?utf-8?B?Ri9jTURjMXFEbytSdEpqWGthbUowNjNWOXlVSmdoMUhzays4SElGM1h5TURN?=
 =?utf-8?B?ZGZ0QlRobmxTL0NuSHg0T2lpNHVOL3FTdkcxMGdsTkRJMFJJWStFNFBWUWVF?=
 =?utf-8?B?am03c0ppdE1oSHRySVVmNHZxNklqOXpjMTBlNi9ma25iU0diWlorZzE2cFk3?=
 =?utf-8?B?aGoxRG1jRkd2eWlQU2RqYnEvblNPMW5lRzRKMUlRSGlnNDcrd1RFTDZvT2Yv?=
 =?utf-8?B?NFg2UEVXc21UZDNETFNET1lmK1lSdTNHSzdhTW52UUdCZk5xZHJ5akVyNXpB?=
 =?utf-8?B?K2FINXMrQUNGckxqTE5VU2tvQlpBY2UwRGF1U29XMC9GSzF6bTE3MGQ4ejRP?=
 =?utf-8?B?Ui8yQzRTQlZsa2VjRmE0eStXS2dPbVhEaEJMZU5TZi9JWmJJY1ZXeTdCaGVo?=
 =?utf-8?B?S1VaZnZPa2hSVjBlbE9XMnN6bXIrUFJ2ejRobnRkYkk5MjJZcjZpNFNtenNY?=
 =?utf-8?B?M1NqVUQwbFhvSG1QSVZXcmxjc1ZIWi9tcWxVcnBDS1krQm80NXVybUs0dE01?=
 =?utf-8?B?NmdTVzIvUUVBbHhrZ0FWelZDbnZucGcyakZzQnc0RW5BbGVhQTcwTzBFWEM0?=
 =?utf-8?B?MUVUT3A2NjFwZGxUR3owbDlWNXQyU2I0ZlZXMThQMGJmUWtDQm5tWUFWcm1N?=
 =?utf-8?B?SWVIa2huZWNGZlgxWmVab1grVU9xVWVJSGdjQUFtaFUvU2h3bDJKUThUUWEv?=
 =?utf-8?B?TTVwWkt0d1ZabkNwL3RVU2Y4NEV4QUYxSDlmcUhGNTkxcjUwcUNORjVnVWVP?=
 =?utf-8?B?QXdtdDNzVGFxNnJ2ekN0SkFlMGViT1pNeEVWb1FRTWxRNjFyUDRFS3FGa2hD?=
 =?utf-8?B?RW9vdlg5dW1HdjYxOXl3ejZ3NlJoVTB3WnJuc2JOV3Y3U053RWFQbmNzbFho?=
 =?utf-8?B?V3FyZGE5VDZqUzlLaW5xeStEeHZCeGI3eERFM2VhZHE3RDdKV2dNNDZVSHdP?=
 =?utf-8?B?WXhKRmdGR3Z4Q2pWMVo0YXlhaXI0a0FsUUlrd3hXZnJVZHFVaVZGMVVUWk9K?=
 =?utf-8?B?anVTWlNhbzhGMnE4RTgzdFgwcGU2VVlER0o4Ujc2T1dVL1F2eUIwTVBweFVN?=
 =?utf-8?B?dWwyTVcwVWxIc1BPSmRpcW92OHpVN1NFbmxvQTVaVGVXMm1ZRUhSMytTVEgv?=
 =?utf-8?B?bktMVTMveHg5WXR1QThrYUI0bWdJQzdFNVI4MklQQk10bWdHaWpvMlRvVG53?=
 =?utf-8?B?ZjN3eGJkQ3k4WW0wRnBEZTM5d0FVNXBlR2ZicjJyamd6UXRxdTdpWmxRYU9F?=
 =?utf-8?B?SFBXaXEyZDJqZXJFY0dGNUdUaDZ4RFhpOHlkUFZLMU15SDdzc2xGU2Fyais0?=
 =?utf-8?Q?nXcerw5U97qUqCD9oKQBEOFfYQP/8nnw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpTWWZtbVE0ZHJjc3JXbWZCZzYyYUYxQ21tM0ZRR2RRQ1NrVjh6R1EyWjFj?=
 =?utf-8?B?ODk0cE1MMlRnRUw0NytlVlY2L2ZjOEJhSkJGYnN5SzdkOXVhOHRGOFFFcDJ4?=
 =?utf-8?B?b0VicDlKUzlPTlFJcXgyZjZDZE1lT1NYZ3RNWUY2Yk1GWGxmYStncHRQd3ov?=
 =?utf-8?B?REZKc1JVTDM0MG9VMHkrdk0xckUzWkFubWVzUFBseS9GdFB2amNIZUpKWktm?=
 =?utf-8?B?eWF0OUFmSXpZOHpRdW5wazFVeFlSSzhzSEFJTmI4UnlOTG5QQzJWUG51OHJz?=
 =?utf-8?B?NDdOOXJHMjRZbXNOQUdWM25QZkFjOTE1dktlcXRlTjVHZEhDOGRycjJ0ekF3?=
 =?utf-8?B?T1FURWp2c25FWlZCdjJqNk8zOVRQQ2d0REViODJtc0tQLzJkVGNXM3ZlWlcv?=
 =?utf-8?B?Zm5pdlc1RG1Bc0dab3VDWW43M0tlQW9nYnRlZEYvV2I0ZWp2TDBNSXdJalh0?=
 =?utf-8?B?YTVhUHl3N2g0NW1vYTQ5cWpibUZUNDc3amROYXBLOUlnWFZsYjRmaWYwSDRv?=
 =?utf-8?B?NVd2RDF2ejFYaldMdUttSWhUVkNudEo3L1VoTDZsTUY5ckQySGFLK3daYThM?=
 =?utf-8?B?NmxCR2ZpdC9yU1F1cnE5SitZUDE0WkpVSXBJaXJTTmpTSm0raXFSNyt2Qy90?=
 =?utf-8?B?MlFhWjV5Y0VZbmdqMnE1dzhOcTBXVytzSythV2VtVUlhaXI4S1lUZm5EWDVQ?=
 =?utf-8?B?NTFKNytlTTczOSs2Tk80TldVeHdxQ3JIem9LZWtFdXgrKy8waGVLSTlzM2Ra?=
 =?utf-8?B?NEpKWWpDcksvTW5WT0ZKcHl3STBxLzZuT2hFR1ZMYlZESlBjNmxldkV5YjZ1?=
 =?utf-8?B?RGpDTE1KakdrNkJHR1ZpVDdNUlk1aHV4Qm84dm9vVTZsY3FUWjhLcnU4Qmov?=
 =?utf-8?B?a1JIVi9FdjlwYkV6YnVsaFpXSlRQcGNQMTBWSEJIc1dGSUVDNEJnWFR2WGg0?=
 =?utf-8?B?b2g0RkUyaDQ4QTJUcUs3YTd0bzdHQnYwWVVmOHJCNTUzcE50Q2g4THVRRnFS?=
 =?utf-8?B?dEJUZDFKSlJpdHRKaWNteGdCeUZHd00vWWcxNVc1TUFIalh4SVVVc2hvYzBM?=
 =?utf-8?B?bmFJbmVIOVdtdjN6TGFkUkM0a0FnMDI5TlJOSmhxa2lzaGNSSUtHR0JiTjlh?=
 =?utf-8?B?VzZRSTRMSEVNaXNtcmFTaFMxaGhnMU9aUEFmdUVGKzhRazRnM0Yzbk1ZUGNM?=
 =?utf-8?B?RldlZXhVTDRXNFBGV0ZMaEZsa1VoWVhqaWU4QVgrUnNnQVMzd0doRmRQRHJ1?=
 =?utf-8?B?anVLakVZTVBrclh1RWJSNXFweHRjRTZkNmU4UDlVMXlwVWE3WkFzdHFOQjNw?=
 =?utf-8?B?WWd2TE9BbTZJTENnN2tIOXZnbk5GQWR5YnFuYjhJdnpJQlVReWxaemdVek5G?=
 =?utf-8?B?UGtMdkNCQXFXYVJkU0RxMUFQTmtUeThITGpEd1dlYTBualhDSS9GWDJOUzV5?=
 =?utf-8?B?TVIrR29FVzJYSm41SXZnRVM1bGJaZUJzTTJtNHlVL29SSFIzVi9oNExTZ0NO?=
 =?utf-8?B?L21jM0w5Q21PYnZ1UHk2TEYzb0FPUGVuYUhxdzFtYmRkVSs4UzIwcHRlSWh1?=
 =?utf-8?B?VmdrRHRBQ212NWdKSGIraG5aV3ZyMTJzenM0L3BxUXZDMVIrV3NjUm9FRjRl?=
 =?utf-8?B?MDhQVk1LVjBscUhVN2x4SFZlR1RTUXU0NG9jRXMra1MzT09mVDd6a2pSYWlM?=
 =?utf-8?B?aWQ3UWgzWXhVajZXNS83ZzNTaUNkZDZ2dGZZbnQyT3F4cU8zYzFIanJTRzZs?=
 =?utf-8?B?ZFJnMU1LT2xZaDZvOVB4cldWQnhTL3VrcklKd1hySlJSVnhjcTc5b3RFbStU?=
 =?utf-8?B?dW0rOTlYRmVyTFRJMUhGeTZYWTlyM01pTm55anBoYlliaGJNL1VwSDNDVmNU?=
 =?utf-8?B?QUlzRXZqSE1FVEtDUnFrS0l5emJvRlduRGR6a2tUVVVGZktQRnBWNGtSYzJY?=
 =?utf-8?B?cys1TTY4YU90bmpLeUMrcnpYM0Ezd2prM0tKSm94L0ZRdmZZeXY4bGxkM2RO?=
 =?utf-8?B?NGQvRjZFRVU5clJnYk9DWWI3S053eWdLUGdTK2dMQ05Ddm53QXg0OHBtbEJr?=
 =?utf-8?B?T2lUYU56Vm9acDArNnhkR21nMFEzVWk5bS9wOHBmTEQ3Y3orMC9OamdnWE1w?=
 =?utf-8?Q?O0x+NiJhDEQ+0sz/xKHK0yr+l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3240183e-1dd0-4cbc-0d3b-08de2be6ef4b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:53:19.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tTbg+OV6A+M82I/CXp1KAlwfvJOpKeRPklwgCX6ixDxRKQZHVznT2CxtG4SCEJnhWHg7qu677wmQcRzrCYicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
Received-SPF: permerror client-ip=40.93.196.55;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/25 05:31, Dmitry Osipenko wrote:
> On 11/24/25 06:24, Honglei Huang wrote:
>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>> index ed5ae52acb..ea2928b706 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>   
>>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>                                           cmd, NULL, &res->iov, &res->iov_cnt);
>> -    CHECK(!ret, cmd);
>> +    CHECK(ret >= 0, cmd);
>>   
>>       vecs.iovecs = res->iov;
>>       vecs.num_iovecs = res->iov_cnt;
>> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>>           result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>                                                  sizeof(cblob), cmd, &res->addrs,
>>                                                  &res->iov, &res->iov_cnt);
>> -        CHECK(!result, cmd);
>> +        CHECK(result >= 0, cmd);
>>       }
> 
> The ret < 0 part looks okay, but ret >= 0 feels dubious to me given that
> this func doesn't return positive values.
> 

Really thanks for the review.

How about split patch 1 and patch 2 into different threads, for the 
error checking style I will submit a another thread, maybe change the 
virtio_gpu_create_mapping_iov return value to true or false is a better 
choice?




