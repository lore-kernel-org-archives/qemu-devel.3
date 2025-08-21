Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39051CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5go-0004VC-8V; Thu, 21 Aug 2025 09:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up5gl-0004Ut-O9; Thu, 21 Aug 2025 09:50:48 -0400
Received: from mail-bn1nam02on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61e]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up5gh-0001dn-Ic; Thu, 21 Aug 2025 09:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrNhB2me1DAzNAor5Miw2JdMJaQVVHivGi/CUOo9kNX6HdvIuTvLwInT4NxeuZcJm8vYVuaIkhH6h4dWbsxl/xSvFyGbR6v9hAOKpDNZWDrVRvnAdgLSttNqMG7K5fP0S9CF1Y94axs7OgCthuXi+BtwmcH82WCzIrbNX0Ay5HdpPFsG1sTwyxXLreXyu8sEQW+89HJxM/SrNIRaC7n6m+ksRTr/r48shHgzAzXLQfquhCIR1Ypv1Wfc0L7EMVPWGGQiawr9lxlQ1dGCG+I71+U8wn6PABRmn1/EWU0GKnQ9L1EzJHqjzYViBXyW19PgyzXkrSnZzdR8g6TwzjauXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QYLU8mTPv9Ju+uSWFM/MygIhYcRN7ig5iuxcMBG7ho=;
 b=jPe+1JsLDM9/HCy6lPAZ/hvM1SdUrVxLPz9Dl+qAeZ3REjcy2pT3Y/YbpJEFCRMafySzZWs9ioW/0wWYU8iySuyHI3PmlrxJifmhXbXZDJxw1ztdip4fWpdGZq+9KDbAT24TvrEPy9+hMy/DyzyGuKJgyIr7BKWljjXGqQN+1VcdAaXsWxYXtyRW749kyxPOxKbgIK57AW0pPXjjh1tOD8f3G6JLCHAT+vnLE5lOvWu/OkFJlMUwoD7iDRF3Hcv/Xi1ZodoFlQ+7+krI/2o8sq0TZqKHo/yfgb9T8f0eq0u8BXsScC1P67fnBF2a00CAz/1I7wi5xAqio4GcMlQqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QYLU8mTPv9Ju+uSWFM/MygIhYcRN7ig5iuxcMBG7ho=;
 b=Dv2svGTGlB+aYu4gtG098Fq01CdlkVxG3fSzFnmpXOz3Q61ftHIhZCxjI1kWr6yVLybCwWpwSbxK0uihri6lP3Nspa+ErWddxhNw/Tij7cBcMEL6x9EfI7FpvSPsYrJSlt5M5DU2x4AgQ0Oipr2jdeW9g4D4tF7drzhuilSJuNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Thu, 21 Aug
 2025 13:50:34 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 13:50:34 +0000
Date: Thu, 21 Aug 2025 15:50:30 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v2 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aKckJoXa4mVB9iSS@zapote>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-3-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820082549.69724-3-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7bf53b-98c6-43ba-dd60-08dde0b9b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXRvcUQ2QmxlZTFGd2tUUmRGSTZhOHJmd3RnR2hlQXJjQ1dnK3h2SVMwbnJ0?=
 =?utf-8?B?Zm8wZ0VoYm8zMWpMZGl4RDJKQnFqcExzN3c3ZzhBZmU4TnkwTSt3TlZyWE5t?=
 =?utf-8?B?TGF0KzYzazZpRytqTGpYem1Pam1ORWx1dElxMDRzYmNGTUtHQTRubk4yaUMr?=
 =?utf-8?B?Q05kN0srY3hGN1g0SWZqQ081MkJQdktYaHJDMXZUZFB3QkovemtVcmlUWkt2?=
 =?utf-8?B?YjFRbk5EdnlqYmhEZmRRS1FxMHlVWDVJY3Fya25KRFhZRGdqd1dPTWEyaVJo?=
 =?utf-8?B?NkFDYzJTRERDSHllNEdTWGdwNUhucUFURk5oWStzUU1tRk45eTVzKzJNcXhm?=
 =?utf-8?B?N0hmaHZ1SzBDUEdVUFMzSC9iSXI3cFNEeUJKR095N29qRStjZ2RoQTFUQkdS?=
 =?utf-8?B?Wmx6Z3hleEJCZjBWdGhwYlV6dk9adWdEUGJibmV5RUg2UDJKK0hFVTRBcThk?=
 =?utf-8?B?eUtCYW9LZm9QOGl6a2R2anh2RnA0aDBDTGxWd2ZLWjcyMUwxalkyOEhnN2Zn?=
 =?utf-8?B?SkRqZHFTOWluSkV6VmdCN2swTHlEdFpwZGI5LzdDamNBLzdJcXRWb0xUcEd3?=
 =?utf-8?B?WE16Vlk3dXVyT3V1M0xTVlc5OUhCaUU4SmRaSHRHUDY3Z3N1VVN0eGdjSUNH?=
 =?utf-8?B?b3N4Q1BET3VWNkRDeGx1ZDd1YVA0TFlKNFVNL2JmN2tEWllqdGppbmIram40?=
 =?utf-8?B?bmNXVDJXd2VkZkVua2tDUU1RUjBtYWVQNXNUSlk0L1JrSURBTVdSQ3U3ZWh1?=
 =?utf-8?B?TUt6enFqWUZ0N3JQSDBlOE10NVhSYXpEdUxZUnQyeFlUSWV5SnNMQ0xWZDZ6?=
 =?utf-8?B?aUhKMXhWWUdLWjUvblUzb3UxelUwZ2x0RkJUdVBHSzBqMDIxeEx3TUhqMnZr?=
 =?utf-8?B?cXl4bVN3ZjdjRjhIWXNuUXJCQ21VSUY1c2ovWW1iRFp0Y0FsY281S2FMZWNk?=
 =?utf-8?B?bGRLeUZyMzNLN2dNYVJlRjBjL1p1WmZXV0daRWJyQ3FUWmIxdVFjNjlXWWlj?=
 =?utf-8?B?Y3VDekhkR1U2YjFTOTdLdU9NVUFySk1Oa1VOcEl1TCtDZnBLMVRWbDBQc1hD?=
 =?utf-8?B?aHl1YnhMNDcrY2o1YVJNOE1sOStrdDhOTmlVSnhtNzlFdEVqQThLbk1DZ0VP?=
 =?utf-8?B?SkZIMnJoeG5zKzd1VUNtZGE5Zy9XRGNCL2FyMXVmbmxWblhaTlphb252Y01p?=
 =?utf-8?B?cGJxNXFEWVRya1E1amtLWjFqeDgxaGZYRklaM2wrbXlCdnZTWUtySDFuc003?=
 =?utf-8?B?KzRNb1ZiNUJUNGFhV3NIMXBXS1dUbFBnUUNzbUFBbEVHNzZOM09rT0RoR1Zl?=
 =?utf-8?B?dVFKazRYSEhIc0RPZFg5b0tGbDI0cHB3OER4ZUtUOWNsWFljcTg2OFV0OTdp?=
 =?utf-8?B?VDhXaDNQK3NWTGEzazFxQ0pkL0t3M0VZbzR1Zjc3a3NpNUNUS2tpZU82Yzhr?=
 =?utf-8?B?NTA4VUEvM1ZFenQ3QXVSNm5ud1VDVkswVUx4SllDc05ocVZodDcxYmEwNm1Q?=
 =?utf-8?B?MVh6V2JXL2NNMmowZ2gyWjVZNWt1YlMxM29jRkE2Q2V3bFJTSEZSMC9SRjRk?=
 =?utf-8?B?aUNpMVgweWtiWEUzemhYR2wxeHNmTFhtWXp3YmQrd0Z0V1JVR0dRdDVhZFNT?=
 =?utf-8?B?V3p0aVAzcWNoZjhQNGxlcmxkNGpyaUw4eGFVZGF6aEhQYjBBbmE4NGM3ZUI3?=
 =?utf-8?B?RzdqK0hLMmxDdTlzYk44YzNmNHZvVEFrQVczemJMRUhQU2lTNWo2dFJmbVJ3?=
 =?utf-8?B?MlV3TVhOL0RPdjRFUm5zS0lXZWpKSUVvVTkwQkpiemJEMGlsUFZGWmZseURq?=
 =?utf-8?B?MXdrT0hvU2RwQjV6VG9XbUptckJJRTZzQ2N0Q0NQcHR0MWF1Yk5UemJxa0ZL?=
 =?utf-8?B?dDVkV2V0b0l1VEM0SzhDWSt1L0lIR2NHMjdhcFozRk55VDRoRVR6aHQ1Y0F3?=
 =?utf-8?Q?hJgdFH7Rl30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZXRHNadUFpWUpveGk4YzFxOW9uNG1zWk5kNUNoem5aSC80UkNWVTZiajRU?=
 =?utf-8?B?YjVEVmtDL1hweDNnbVZWZnVyRnNBaTlvQmUrbUVGZHdlZ2ZsMmp6VGxDelFm?=
 =?utf-8?B?UjdDbjh1MWlSbnkycTE4QWdrazYvMHpSM242M05mblhNRXo0S1ZjcnNIOGl6?=
 =?utf-8?B?eWNCdDFFZFlVYW1aaysxaWdMMTF0MTZOZVk1a1hiNS9mQUtpMExWbXhlNDJt?=
 =?utf-8?B?dWFEeGw4T0RpOXRTR3VBaFd2MEhPTnpsb3BvalE0cmRSaGRleW10ZzJZc1pp?=
 =?utf-8?B?dnhVR3lrWlBHZ1FYeDJwR3pyMElPK3F5NUd5cWxSMHBnZTVNakNla2VJeEZk?=
 =?utf-8?B?WEtRZWs0eFA2OGFNM1ByeDI2S2ZQYjJnaTlIRUZDRWNNdXZHNTMxd2wybUNI?=
 =?utf-8?B?emtLNkZQUjQ3WXJ6MFBicHBMeHIwQkVxb00ySkFVWmFMWEZoSWlUb2pzYjdx?=
 =?utf-8?B?YUc0WXNGdXFXN0FhZjh6dm5vQUdxMnBqS2dVdHppOEF6N20zWTlVV3dDWm9J?=
 =?utf-8?B?c2FYNTVIbHgvYXpTNTRWL2h0ZWxyR0JwZ0tNOEJGc05MY2pxeGE1bGdqU1JJ?=
 =?utf-8?B?RTdsMFB2d0lZWWY1MFlTWG1LOUV1dll2K1lTMUhkNlAwd0JBVUpjY295eGUx?=
 =?utf-8?B?NklMalRtU1lyVkd5S3d1TC9jT0MwRmt1N01SRTR2dWdaSzZOcFFkT1FoM3E4?=
 =?utf-8?B?dTJMNTIyemdoSitGbFN6bEFGWHFOdXpmQmNVTGZZSDQ2UE1iWDlWYm50dE9F?=
 =?utf-8?B?aHorU2hQejEyRGwvNVRyWFdZMmNQYVd2Z09hbVVrSnZUQ3lYQjQ1elpjSEJQ?=
 =?utf-8?B?RGRJdmhsR2s4THZWbk10L2VNNnh5SndzQXVmRVF3b0Zya0dXWW8rUXFmMEFj?=
 =?utf-8?B?MUFINVBBQ0ZmcEZUOWJSWnF2ZERnQWkzT0w3M0hScUFCdGxxVGsyV1NVQXk5?=
 =?utf-8?B?RG4vMnJUbUU1dGlZNTduUHB1ZmJ1ZnJkUFhOZWhYMW0wcGYzczRYN1cyMGpu?=
 =?utf-8?B?VlZVc0h0dTdjS2U5Z0Zha2F0SUdvaCtmMlBHVXBWbTA4ei9DMTVHRE9ITkRI?=
 =?utf-8?B?Q0N5SVpnd2d4MHgzQVpHbWM3bnhSQlBCNkFXZEVJWlZDdk9yaklFU3UvenJO?=
 =?utf-8?B?K3pxcTJ4TFJlL3lLM05GRzQ3SHJzQnUzbGdvZ2VUYk9sSitVUXNaY3FBNk45?=
 =?utf-8?B?SVhnaFQ0b1BxNklOMU5tampTZE9xUUJoOXJlUVZRZTROaVJZOW9hZUpFTkIx?=
 =?utf-8?B?US9NWldLN01PQUJIdXo5M0swdXpEZ3dXOEorMVViUGIxWStIK3lCLy9Uby9u?=
 =?utf-8?B?Z3VDQjY2ZEN1Z1R6TWE2cEw0cWF6aXlBRXY0ZnRnSUJRaGNjK3VYdXNZVjNV?=
 =?utf-8?B?M0FpTWlsaVN5aWdSbjZkd2RPcmF1N0RZeEpwaUtLdjE3T29nckZlK3ZUejZ6?=
 =?utf-8?B?MFptOUhZUFgvLzVSR0djdXB1RnBmcTE4alNyVEVOSzJvcVVLcnZNWGJlblIv?=
 =?utf-8?B?Uzg1QWFjdUFaV1NRakpnaXdoNnU4ajJIeDJEc1dRU3IzSVJEdjVXVDJCdFJS?=
 =?utf-8?B?dHEvNEhUMkN4blNtZTRTRWljV01xNWsvL00xQ3MrYlpuVGN3cVFQdUY5M3Ev?=
 =?utf-8?B?ZTNwR1ZJZENOZTNVcW1oUTNuN2ZJU0hQUlg2K1R0eGhaOG42a0RRVk44WXBw?=
 =?utf-8?B?YVdJQm01NjN1WlhTbyswOUROT1A4ZDRRWHU5UTAva3FzcEFkcVlzMVlrdnBs?=
 =?utf-8?B?dVJTaXJFNGd0YWtPdTBwMFAvVnoxNFRPV0NVeTVPOWFMQWJHZ3RmSnJacldw?=
 =?utf-8?B?aHF5QXd2em1YRytPaktqOFp4cUNUaGEzbE1uYTBDQk91V1h2UEcvWjNmdVNU?=
 =?utf-8?B?NXdYcXFsRnd6eE5HRzB0Q0xyT3B3MFdFWlRDQlFQdFlTbVZxNm5wWitVY3Zy?=
 =?utf-8?B?c3BrVlZhUTlDL29oNlN5WHExU0dqcGtCbkdyM1JJeHkzelJtQjBQalAxdXNP?=
 =?utf-8?B?ZTVRTFE5M0gyTnlXTHIzdlprMEJoejU5M0N1bDROR09RVGExd1ppb1pscGtq?=
 =?utf-8?B?MGJzZmdVYUp1ZWJ4ZFpYMWJSNW1LaWJDeUNNVFY2RUovTzZEZSs3OGw5YnZh?=
 =?utf-8?Q?AamA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7bf53b-98c6-43ba-dd60-08dde0b9b339
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:50:34.6145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjmUSdS4bQiHI6CkqFKVcxIJJ4+eU244f/7FQ8g4vyt6amhlsgmSUFQ+F3zZKEnj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
Received-SPF: permerror client-ip=2a01:111:f403:2407::61e;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Aug 20, 2025 at 10:25:01AM +0200, Luc Michel wrote:
> The following commits will move FDT creation logic from the
> xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
> passing the FDT handle to the SoC before it is realized. If no FDT is
> passed, a dummy one is created internally as a stub to the fdt function
> calls.
> 
> For now the SoC only creates the two clock nodes. The ones from the
> xlnx-versal virt machine are renamed with a `old-' prefix and will be
> removed once they are not referenced anymore.


Hi Luc,

I was trying this but I see this on this patch:
../qemu/hw/arm/xlnx-versal.c: In function ‘versal_realize’:
../qemu/hw/arm/xlnx-versal.c:945:11: error: unknown type name ‘VersalMap’
  945 |     const VersalMap *map = versal_get_map(s);
      |           ^~~~~~~~~
../qemu/hw/arm/xlnx-versal.c:945:28: error: implicit declaration of function ‘versal_get_map’; did you mean ‘versal_set_fdt’? [-Werror=implicit-function-declaration]
  945 |     const VersalMap *map = versal_get_map(s);
      |                            ^~~~~~~~~~~~~~
      |                            versal_set_fdt
../qemu/hw/arm/xlnx-versal.c:945:28: error: nested extern declaration of ‘versal_get_map’ [-Werror=nested-externs]
../qemu/hw/arm/xlnx-versal.c:945:28: error: initialization of ‘const int *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
../qemu/hw/arm/xlnx-versal.c:946:12: error: unused variable ‘i’ [-Werror=unused-variable]
  946 |     size_t i;
      |            ^
../qemu/hw/arm/xlnx-versal.c:945:22: error: unused variable ‘map’ [-Werror=unused-variable]
  945 |     const VersalMap *map = versal_get_map(s);
      |                      ^~~





> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  include/hw/arm/xlnx-versal.h | 12 ++++++++++++
>  hw/arm/xlnx-versal-virt.c    | 11 +++++++----
>  hw/arm/xlnx-versal.c         | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 1f92e314d6c..f2a62b43552 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -134,21 +134,33 @@ struct Versal {
>          XlnxVersalCFrameBcastReg cframe_bcast;
>  
>          OrIRQState apb_irq_orgate;
>      } pmc;
>  
> +    struct {
> +        uint32_t clk_25mhz;
> +        uint32_t clk_125mhz;
> +    } phandle;
> +
>      struct {
>          MemoryRegion *mr_ddr;
> +        void *fdt;
>      } cfg;
>  };
>  
>  struct VersalClass {
>      SysBusDeviceClass parent;
>  
>      VersalVersion version;
>  };
>  
> +static inline void versal_set_fdt(Versal *s, void *fdt)
> +{
> +    g_assert(!qdev_is_realized(DEVICE(s)));
> +    s->cfg.fdt = fdt;
> +}
> +
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index adadbb72902..69f3bb401b9 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,9 +1,10 @@
>  /*
>   * Xilinx Versal Virtual board.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -695,14 +696,13 @@ static void versal_virt_init(MachineState *machine)
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
>                               &error_abort);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>  
>      fdt_create(s);
> -    create_virtio_regions(s);
> +    versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gem_nodes(s);
>      fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> @@ -712,12 +712,15 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> -    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
> -    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> +    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
> +    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> +    create_virtio_regions(s);
>  
>      /* Make the APU cpu address space visible to virtio and other
>       * modules unaware of multiple address-spaces.  */
>      memory_region_add_subregion_overlap(get_system_memory(),
>                                          0, &s->soc.fpd.apu.mr, 0);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 4da656318f6..7bb55751e5c 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -22,10 +22,12 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> +#include "system/device_tree.h"
> +#include "hw/arm/fdt.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -917,14 +919,42 @@ static void versal_unimp(Versal *s)
>      qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
>                                  SYSBUS_DEVICE_GPIO_IRQ, 0,
>                                  gpio_in);
>  }
>  
> +static uint32_t fdt_add_clk_node(Versal *s, const char *name,
> +                                 unsigned int freq_hz)
> +{
> +    uint32_t phandle;
> +
> +    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
> +
> +    qemu_fdt_add_subnode(s->cfg.fdt, name);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
> +    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
> +    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    return phandle;
> +}
> +
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> +    const VersalMap *map = versal_get_map(s);
> +    size_t i;
> +
> +    if (s->cfg.fdt == NULL) {
> +        int fdt_size;
> +
> +        s->cfg.fdt = create_device_tree(&fdt_size);
> +    }
> +
> +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
>      versal_create_uarts(s, pic);
> -- 
> 2.50.1
> 

