Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB335C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7V-0002d1-NM; Thu, 31 Jul 2025 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTJG-0001Ym-0n; Thu, 31 Jul 2025 09:27:02 -0400
Received: from mail-dm6nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2413::600]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTJC-0000f5-Og; Thu, 31 Jul 2025 09:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NygicF7AJP45U120TjL8i7jfZDQCgjX7ozGJBNgZpA+T/uJqGURBPmDGmEm4M8kX9eLntkHHKnn0jjSOcAtlcweslAwqrwfw0CswTxlSp7ImgJcH1VaUKdoRduHak5JkwrsJ7JVCp9W0XEhoxieUUsYwIZQsID0MpIqjDhfWijJOdY0ndixunDpWOUq7ox/ic+fA8/F4toTCAyeTCmLgFWDq7rl453SZn6HobYLyHXs8qz7ucibVK9EBh34PU8mVAM84vVF4jZhrdzPn8x7de4A5OBMIDUkDPpC3xY2X/Yu8BG90VvC1GeRrbNPQIwW4dmrxuMGtC6DNjPjdLUkW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygjKmIuUo5+FBHy/a2fB/CfvewE5fR3Os6jd4Ens3EU=;
 b=NGNujRdcy5AxeGRY0SOjx4DT4diiWkgjLIYa4BcGxMzUeWC3FRelL4jsHFL9l7gkPo5xErAgQy4yUfnv5Jppe3Vwysrtu6T5D/uljKqWGU9AVFrI3eUF2pZQzdGzdAXy+3jhYZHZv/HONmw7EMvRu5zWIdLSIZ02lXBVV5It4bxrb3D271YfNmyQZ8BzO8WLTFRTpGL08QzZ85LTD8/GjNDnsS87eO4f5ENo9FlFJZthQg45X8IeF7+0k7eoqD68Wcuytz59fkDJYWt30cmYFQ23roU7/gsjpZQLv+weM+xjHCJ5ampz8OFpaPJijoNjKR5ukd+4xao3LUiaVaNnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygjKmIuUo5+FBHy/a2fB/CfvewE5fR3Os6jd4Ens3EU=;
 b=Re3O0xo2xz2qohQ+QGSY5tD/TLx0QgJoY8pGaUH9hP/09PQPvZo1gHtrlvORE8gh5/r5ZNuPBneILT0mYam9aBNj9/fQlYsZKFPxzHVAa8OtAuxLbT6BsgE4baxMwUr8X/H/VC8nH43t0lnX/nm44ixYwJZnxg+pdhtOnoXWkvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 13:26:51 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 13:26:51 +0000
Date: Thu, 31 Jul 2025 15:26:45 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 34/48] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Message-ID: <aItvFYFnwvannW/x@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-35-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-35-luc.michel@amd.com>
X-ClientProxiedBy: DUZP191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e444ff9-4658-45c3-ec82-08ddd035e8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFVDOE5iaElrb2F6SUJuSDl6TWJ6a3c4aFJzbGFFSUpseTJqeWFJQjhxaENB?=
 =?utf-8?B?STRIZUNST3grcU1MU3R4TTVpZEdQeHhSdjhLL3dBZkREMTNmWFphMW44YTlU?=
 =?utf-8?B?Mzh4RElJODd1VzdoZ3VIazF4RGZmSmZ4T25kTFRRZlpMSUV5NTU2VUpMTS80?=
 =?utf-8?B?eHBMTGtoeFh2TzhENEsxR1ZDUXo2OU1aaVFxY1NnT0xrdVdGM0xwZmlLWEFG?=
 =?utf-8?B?U3pGcDRWb2FHVHljWTB1RmdEeTI2U3FEQys1SjhzK1JPNTE2ZkN6azlFcXV4?=
 =?utf-8?B?SlpwcXgvRmRMeU1jWXhZOUxjSk51aExYQk9jeGNkZytHU3g4Q1NhOTIwOW1y?=
 =?utf-8?B?WlBjYXA5QjMrb0hHQVNnTTZaODJxSk9odWNDMngzcEI2TTJrRWRoYit5WWNy?=
 =?utf-8?B?ZEloeFMxcmhVRXZsSjhEbFY1ZllpQVJQTFRyVEQxUzRJY1pPeVdLUC82Wnc1?=
 =?utf-8?B?a1VYaFVURC9ZSjNpM0JFc245YXY1UXRhUElmWVlFOVlEQWxsTEhFVEs3a2hl?=
 =?utf-8?B?NklPYzl5cjFtYjNSS1ZBTmNZMFRSQ05rT2ttd0RpVzBGekVyVHNJQ1lheno3?=
 =?utf-8?B?ZWZmTzVpUTJVeWRwNkM2OEpLanoySFowZ01VZHhYNUkyb0NURmtCalA3ZjRh?=
 =?utf-8?B?YzhYMDlncXAwUnVUbVR6amVnNjFLbnY0Tmw2ZjRaVWVSNzJvd1NaK1VKbGtM?=
 =?utf-8?B?S25lWGtpVjVkeDNPWGJEei92a21NSmhGMzJPblh4cWJMY043ZGJVbEtDTFAx?=
 =?utf-8?B?UnZJbFZPZllCQjB3S2NlT0NYY2xOTjllQ2ZLUGlySm5MZlZaM2EyRi9RWGI3?=
 =?utf-8?B?NHczUUFJeHZQeGpPYnhldjZocmpOWGpIZGhIM2Zrd1A5a1VhbGE0WmZuRW40?=
 =?utf-8?B?T3F5c2EzMTgzNHdEclY0c2Mzb3Q3NVVQZHQ0UU0raytXaXhyVjNLUWRMZjMy?=
 =?utf-8?B?YXVkbWhKcXQ3a054NkNQWTJJTzI5WGJaakcrWmJYSXdoK1NPbzlxTFBCUnpC?=
 =?utf-8?B?eDNGMWpZSXBuaVp0cDk0Nk9JSnJVbHhvSUNWaWRzd21kdXRhVTdCbyt5dCsr?=
 =?utf-8?B?WmcrQWJPMjUwdFRBYlhEdlg0WmZucEtsaHRiODIxRDhWZzRORWRzMlluWWJo?=
 =?utf-8?B?aGJtK3N0Sk9JU0FOTFFkaHMwWTFvcUhTMGlHR3hKUWdKR1JpU1RJbEJoOWdl?=
 =?utf-8?B?RlFTdldIbTZNcGJOTVBJNWNhclRZaXdOempGU2syVnBMYks5YkdPWkNTVElF?=
 =?utf-8?B?TzY4TFY3SkFySUdNM0pjRjlnUTdCZ1kreG9EZzF3czg2QVhPdi8zdWRYelJB?=
 =?utf-8?B?YjZhRi8rTmlZcTg5dWNqMkZGNmdEOUJOZXZENjRQd3FyU1IwOHJQdWExSGpo?=
 =?utf-8?B?bm05R3BuSzdpS2UrdWRJM05EYmU0VXlNMDFuYkhEYVhVeGxVVFJ0U3RpdXk1?=
 =?utf-8?B?ZW1XZmYyZlBLOGVXdllKaWlnV29qTGhEWDdVSUwwbUNTWGtkT2Y4REhGKy9M?=
 =?utf-8?B?elJCVXhLaDlxS1gwRXQ3K2FhSHV6MVNNTXlhUjN1N1pCTUlDNXhhVitSSlpU?=
 =?utf-8?B?M3lybjRRcm9tb0pIWUphRnJXK21YY1pPWW1ZS0tYMTZXeFZxNXcwUC9PY2hF?=
 =?utf-8?B?YWZCNFlibHROR3Z3RS9oczV2SDZYcW11YVdGZWV0WStxdHVjS3liRVo2aW1u?=
 =?utf-8?B?SFh5UEJ6cm53MWU3SkF6WXZzY3Q0YVV3TUdIODJra1QxdWg4Y0lTNWpkMlho?=
 =?utf-8?B?TTRyOVR1cUF2c2pHdlJXZWZOd0hVSk93T2R1T3lXcm1MZjUwLzhTRWVLam9l?=
 =?utf-8?B?TFhPNHBsNkZYVkZPTHBGRm9oaGVXUjBpaWhPRjZYa01xdmoyQXJuSGt4MklJ?=
 =?utf-8?B?WS9raXRrOXlZZ21WWGFIZlhyTm53ZngvK21ndHVoZDZaVE9PSFE3Ykc4SWFQ?=
 =?utf-8?Q?bJtpAHYaY58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVduM2ZvNGZpNUwrYXc2L3RrODdRU2trOGEwbWFIbU1CSjY3aVFJRTdYVmlk?=
 =?utf-8?B?QS9Ma0NFdFlVcVFLTlJ1UTVkRUljemh0RFR2Y3hXLzZWVFVEK2pLcUdmb21Q?=
 =?utf-8?B?RWVUbDJvL1BZMjZCZVRQbkpENUxiRWNLZHFWd0RtYmFEL2VQSXBDdzZQZUd4?=
 =?utf-8?B?ZHFVQXpqOWRhVDlLNXpJelVPSXBsNTBzYmIwckFmc2xJVkViYVJDUklSMHpi?=
 =?utf-8?B?U1Q4c0NxMzlxM1NpaXg5NG9TRzRaNmxGN3F1SGgrbEhELzJVdWpvcGN2eUNr?=
 =?utf-8?B?cWRvWG9aRC9RN2NZd3diZVlENDc1QTF5ekRKRGM4UkI1QkF4bCt2UTZGRWZ6?=
 =?utf-8?B?YTllNjR5NEh3aGxncEVxazhWcTZ2ek5sNmhpcVJkS1F3c3FuL0NDUFY2QVZq?=
 =?utf-8?B?SjRoL0ZuNVZGdlFaK3g5d0wvd2hXZXJYSEM1TjJqTW9CTG5BNUVac3hOVThY?=
 =?utf-8?B?dGtWUFZSSDNzNjRBa3I5OEEzdm5YcDJyVlhrYyt2dWRvNDgxaCtrcXkrM2tw?=
 =?utf-8?B?dUU2czdFY1NyNTNNN1RINVBHVlBYVmRGbHRrNHlOTXk0M3VlN0YvaUh3anU0?=
 =?utf-8?B?bDZHazJTRTZZbHhKZWVuSmVtdE5NVllKRG5pQXJCVkVoTnpRUG9jeWJPYUMy?=
 =?utf-8?B?VldVUzB3UVdVRzdCZU4zdHpGTVd4Y2VFT0ZqUWdlYmY0ZVJXd1Nkcy9iNjhW?=
 =?utf-8?B?ZnZHMmpvdTl3azF1WmJjYUxLdlZmbFN2NTdNM05HMmduY29wU2tzLy80ZFlW?=
 =?utf-8?B?QmxWNWtNQWtJUDZvVjViSWh6Rk4zZ1hIYmNHSTRvWHR6VDRZR3pzTTRFZDdD?=
 =?utf-8?B?MkY0QTZNYzNJS2VSeVNDeTc2ZGNydTQ4Q01RalZ3NW9DVEtkRVdteGg2bWo5?=
 =?utf-8?B?WGNnaVBZQWVKOXhxOGJnd3FHMks4N0IyUjE5OTZKdU5GdnNvUWgzSGp6TEZB?=
 =?utf-8?B?UW9IbS9rcUV3L1RmOWpmVXdmV2tmWVBYWTIyN1J5ZVQ2TWU4UUZieWFlN1hV?=
 =?utf-8?B?UzJ2MTFXbUpmbDg5Q1V1dkgzMVk0eFk1aWdKbkxFMmFGR1dCOUpYVHZrUHg2?=
 =?utf-8?B?TVdxeVN2UUhRNDk0dlhnMGZkblBhdmNGRW5RTmJ0MXN6VEFMK3BlQWtyZUd0?=
 =?utf-8?B?WCt1RFhpVWFsakdUMTJpMWIvcmdKM1l2eXM5NG5OcHdYbm5vcjNSQUJnTXEw?=
 =?utf-8?B?NjQwbGpCSDlWZHlOeVJ1dE5VZVlQcnhVUTEvTHVSUHJBN2JMVkJoakx4cnI1?=
 =?utf-8?B?SjVUSnhqWU94dFRKV2x5VzZ0dExqQkkyRDdZUVdPMjhkOXRyc3VlYUZWVWhI?=
 =?utf-8?B?MXREd0gxTlhCbnJLRzVJMTRVdmhkeU8xRlNDT3JvbThsZ2RuWm51UktNeEtI?=
 =?utf-8?B?cTlycmY3WDJPYzkrNUhRdVpoSFRHdWNsb2dkYlhxdU84YlhnZVU2YkdsSDI2?=
 =?utf-8?B?b2N0RmM0VnhWYTdrUEd0c2psRHNnN1ZxVm9RUzR6NDhQNzJ4RDJ3U1MwQ05s?=
 =?utf-8?B?YnYwTzdibm9Qb2V6a0YwZEhxVUdFRGRtOFUzeVNnQk50c1dFcTdjblJSeGdW?=
 =?utf-8?B?emFPMDlNRVAwM0J5cTJRcHhkaEpjV256TEZrUy9LaVFKNEY2eUVEa0tpYU5t?=
 =?utf-8?B?UkZOcXQyR2ZrY2U3eUNZbnRTZWVFaXllYUFEekVDclhvTlJNUnVXRjhPeHFL?=
 =?utf-8?B?ZVRmSDF5QTJ3bUJselh6cEZqWkFnYTZNTVl4azd4OGhBR3FiTW0vVnpKbkli?=
 =?utf-8?B?TUJ5cVkwSGpqM0lrZVExZUplTUlFVGdpSXRHa1h2VEYzazR2VlRoaE5UK2lr?=
 =?utf-8?B?U25JdGRNaWRFNElQVU1rWXdkd0YvNy9hMi9JL0FsWHRtck1yeGhxVEg3NUx6?=
 =?utf-8?B?MEFqSnZTYldhLzhlZDdxWVBiVnkxa3FxNGZlcWkyN3lJRTM2NlpxNElTSWF5?=
 =?utf-8?B?MHlYbWtGbUphc255R043aElxeTRubzQ1eVI2dnpKRm1xV0ZOOUlhbEV4SWF2?=
 =?utf-8?B?eVVna0RhbjF6cERLdmNvS3duTjVmRDY3TStzYncxNmJzN1ZDUURldm5SN1N2?=
 =?utf-8?B?M1VDYmxJT1dsSHNyU1lZcGJOQ3BhRVVqWWNzTjdnL01vVnFRRjNjNHpKVUxI?=
 =?utf-8?Q?dhneqKdZ0sioiXXnrWz7yAJYL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e444ff9-4658-45c3-ec82-08ddd035e8c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:26:51.7184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTEqx8m2WQZytygDyFCngQPQbCqBNlNNie+0m0kdlgim/5V2ouoCBPX/TQWk1ekZw9mb8j5CbfBGaL+srgZCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
Received-SPF: permerror client-ip=2a01:111:f403:2413::600;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:16AM +0200, Luc Michel wrote:
> The CRL connects to various devices through link properties to be able
> to reset them. The connections were dropped during the SoC refactoring.
> Reintroduce them now.
> 
> Rely on the QOM tree to retrieve the devices to connect. The component
> parts of the device names are chosen to match the properties on the CRL.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 5151822ad56..796b4911a02 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -1473,21 +1473,50 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
>      sysbus_realize_and_unref(sbd, &error_fatal);
>      memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
>                                  sysbus_mmio_get_region(sbd, 0));
>  }
>  
> +static inline void crl_connect_dev(Object *crl, Object *dev)
> +{
> +    const char *prop = object_get_canonical_path_component(dev);
> +
> +    /* The component part of the device path matches the CRL property name */
> +    object_property_set_link(crl, prop, dev, &error_abort);
> +}
> +
> +static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
> +                                           const char *name, size_t num)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < num; i++) {
> +        Object *dev = versal_get_child_idx(s, name, i);
> +
> +        crl_connect_dev(crl, dev);
> +    }
> +}
> +
>  static inline void versal_create_crl(Versal *s)
>  {
>      const VersalMap *map;
>      const char *crl_class;
>      DeviceState *dev;
> +    Object *obj;
>  
>      map = versal_get_map(s);
>  
>      crl_class = TYPE_XLNX_VERSAL_CRL;
>      dev = qdev_new(crl_class);
> -    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
> +    obj = OBJECT(dev);
> +    object_property_add_child(OBJECT(s), "crl", obj);
> +
> +    crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
> +                            map->rpu.num_cluster * map->rpu.num_core);
> +    crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
> +    crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
> +    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
> +    crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
>  
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
>  
>      memory_region_add_subregion(&s->mr_ps, map->crl.addr,
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> -- 
> 2.50.0
> 

