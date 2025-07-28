Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4769C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRCz-0005an-R4; Mon, 28 Jul 2025 13:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRCp-0005SU-Iw; Mon, 28 Jul 2025 13:00:07 -0400
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2009::622]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRCj-0002Ht-C6; Mon, 28 Jul 2025 13:00:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsExT8o1N7U0yfQ907Y/odpnuBaBVewxWE6YtH8ULCuZbefFbInoF3XKgz8VyAMpCVKjxKJhtfeLkX3bwaYuxXpE65YGs3dDI4nEO6CdECWBPGv6Vn4rwfQuz9W9nOyFpA3SZnCj5Df3K1f9zgrMaZ1CUfSU83pFFNC1zqKBxOLJjzPPhDNBj0l0XMDR1j8UHRd00oVLmKoIoRCPA94dTmZq7WXS08KsvoAk9hjZ5Okz4lu4GeccduhWWx3L7OFNzeGLPTbt75wwS7EOttID8nN/Noe8nVL8NNLA9THDjY1kGw85cGQ7NoZ1r7qNuclUXvlCJmJ+IcsDg63H+f2C6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOMjMicu5Solq7SMF182Viomg73zfpEXbGGRbf4pzyw=;
 b=EI34bKf9E7X8A5RuLxgM6s1lhoyIBerLf/axxIGEX2DuZoR2MRifzP65awM+2SAh2UK1SrYzqJjWXO5Ic8zYZzZKBY4FkFwXwWEVmGrQsGBZ9E94lKWOvmlpOf0mEMl3jzIPUH3BKnNWymlZy4FZyIPSRYrt+js6e8DCDbLkF0lKubl1fM0uLi4ceuxcCMgt8IB39pnm/VlvpUQF63xZxIRn23Mv2RABd46UQqmAOYaDuPm8Fdo4C/V1H4swcw0uYNYNcd5wZD+1GGwgOnWsNnQk44Jf9jr1zZzuHHGgywTI+bKmivhYhqrHzVv99xBcpxvEMM2iLG6eG0VcHo3Pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOMjMicu5Solq7SMF182Viomg73zfpEXbGGRbf4pzyw=;
 b=v9dIw0UemabEy06yxm3NyZag5ZhmD8gjP7isRhPypUyP9Akxcm8vm2Q3By+DhrOjU/BWoqgXdyy9pHQBr6+u4RhzSTiMN4zkIHLn46pHceTQbeNQ4Gs3/cCo+7U/vV0rm6xUSMYKWUtzUE6zM73mViz5Z8u0Bt2qivBCdQsZ+NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 16:59:50 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 16:59:49 +0000
Date: Mon, 28 Jul 2025 18:59:42 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 02/48] hw/arm/xlnx-versal: split the xlnx-versal type
Message-ID: <aIesfpiGNAgy6UGv@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-3-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-3-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: eb73eac8-4098-47e9-0819-08ddcdf829d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVhsZzNvbjJ1TEsvRU41N3VFamIyWE53ZDUyZFFuaHhQSkU2ejlNUHBjVjZP?=
 =?utf-8?B?RHFwaThWelRCOElRQ1JIbHMxTHpqL25oSDEyTHZOM0R6Snp4N0hwbzE5NC9n?=
 =?utf-8?B?U3ZHL0RiOVdoZ2hNc2I0WFNWeElPSXRydHRtbTliemhiVnFqUWp6MktEL0RY?=
 =?utf-8?B?dDBKeUUrOVRVZWtFbXlFUnlJR2xCTHFWb1FTbEFSWW1zUWtjK0Ywd2w1aFZy?=
 =?utf-8?B?M29vSEg0TUF4bzRSUHE1UzZ2NnMvRUN0UWNEejBhTFVIT2U3NzZiVVIybGxo?=
 =?utf-8?B?aXlpaCsvOU45NVVoYy9LdHlGckozNkVmVmIvbGZKSWhvZDIzdENkb09PeDZM?=
 =?utf-8?B?OFF2VWh1TDVZWlB6Vmp3THhrOTlrTXhlcUpXR213L1pjSnE0WEo2ZEhIWk5v?=
 =?utf-8?B?OUdFd2hoNHNXOFkxZmo1eUs3YjhJY1lRL29ZaTl6Y0sxL1dBL3o1WFVnTFJT?=
 =?utf-8?B?aWp6R1NBUEJqdjVGRVBKcVFLV2NnOEVvcE5pVE44eVpZR256NWEwaXBFdUda?=
 =?utf-8?B?c2pmUjI2WkFQQVFBd0xiTlFkcWp0NklBUFd3aEJRZkV2V1FsS1NxK0JXZUR2?=
 =?utf-8?B?OTVXcWV2VW9hT1o2TnhvamFZVEVtd0ZueVpLdC9HOS91MTBoQ05HNG9TSE5i?=
 =?utf-8?B?Z3JWOXFSU1I5eWFieXVJZGxQS241Wm8wckRERkV6QXhnbzFKTnpCS1VNT0Zr?=
 =?utf-8?B?L0lFOUJwRjh5K21jTUJsOGhCc3VBV01XMXkwc1REWFRyenFCY1EyS0grenJH?=
 =?utf-8?B?eXRiL2xqeHBGYkhGME1oS2txSm14VlJRbGZTd1R1SkZyRFlaZFJEYWtuRnFv?=
 =?utf-8?B?MHVHVmtrNm1GUkYxVG03SS9zWDhOYXZvdFR2VFBjWS9zVG5qTjF4bWxlUjVG?=
 =?utf-8?B?NzRIeGE2bENwT3AxV1BtR3E3S2s4TWptWVRoNWZkQ3pOSXB3LzkxL2VIelpu?=
 =?utf-8?B?MWhkNThoeXlJUHk1OFRSUHBHODlqU3VCQWR0cDBacmgxNWhndEw1QmJEZFln?=
 =?utf-8?B?VVpTK2tUS0JqQi9kcXhldy9jRDJacXFjMU9wT2szQWJMbkk0bGJTQXZHVVFu?=
 =?utf-8?B?cHJLcTM2bno4Zm5yQXNpOVdVeXRIV3BubE5iQWIzcDdrYk9ack84TWtvT1dm?=
 =?utf-8?B?OFFTcmcwSWFDZWU1SWxUdDJnTHhEUlVVRjZLekJ0akJvMVMwcHlBT2Y2Zk1q?=
 =?utf-8?B?RTBWbWdkR3RqWGFCNnBha2RiWHBlM2w1VlVFeWtJU1hEaTc3ZUYya0hEUHk0?=
 =?utf-8?B?R0VodkJGeW14OUd3clZoMUg0NjQ2MS8xblo1RG4zMmMwWkZWSENWcFgxU3dR?=
 =?utf-8?B?cHJLb2FReU43dUFxd1BLRnhmUjRKK1JCdnNhcXJwMTdOR3YydElORDRPZlB3?=
 =?utf-8?B?M1dQZzVHcEFYS2dpYmo1SXFKUmIxa0p2ZHJGR1BBMGZZZVlPc2x0YTlIQVIz?=
 =?utf-8?B?cHVUZ2dpOGNkSWZCSmhwalgySWcvRm1jcHZxeU1mWURCVGI0ZU0vTXZvK1Ny?=
 =?utf-8?B?OWtWMTA2UDdPMkIvclBIS0trZDVWZlROdnN2RGZiQmxJVGY2VHExUnlhVDRX?=
 =?utf-8?B?MjdhVFpPV2VmYnlRZDFLc0lWTDB4YVkxdVUwdVJ3YlFSN1FQTnNkZHZubmhV?=
 =?utf-8?B?SUJUNTdoUWpTSS9Xem9BZGJsQ21vUE10K2Fwd203UUJTK1k2VXBKUUFjc3VY?=
 =?utf-8?B?bDhoQ0FMNlpiTmtUandybC9OQlZUcU1YS0VvTXZZTUxQK2t6RmtiQmVPRVdR?=
 =?utf-8?B?QTlJOVJMT2N1ZFV3aU5VVCtXU2puVS81dzRmcDNpb1JMclNsNWdOeWlEMVRV?=
 =?utf-8?B?dXg5bExLekg2Zk9nZkdlNGtXR3krbyt4bkQ4dW0yamMzN1BKZU1MQXlCczl1?=
 =?utf-8?B?bEZZb2ZzREpUTFpLRFJqOCtJUVVjZ0MwS1NpdGxwbmZYNmxxNSs1cFFENnR0?=
 =?utf-8?Q?nk4xvKsWCBo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZTOGl0SmI5M1BnSUZFcWg3OHQ5RGFBN1lMZ2E2MERVQ3B2R2wwVi94MEQy?=
 =?utf-8?B?cG9kN3l4bUM0TmFhVHZWYjBFZk9ZcUZkajdBUm1FODdQVmZPcmRzZXlYWDlt?=
 =?utf-8?B?bUNwNXhweE1WTW1ZdHVhVW50OTNrUUdrVm9qeDR1UnZsNm1RMmFjVVNVUWFM?=
 =?utf-8?B?QXV2aGtIYVIxWGhWZktwcmRwc2NGNXFVZjgwOW0vN1dDUmVMbVhhVEk2ZmJl?=
 =?utf-8?B?djNkYUhhUTRVZzJuMFJlSWprQ0JSYnBuVjNGdXpMTmlCTkszQTF5aVBRbWsz?=
 =?utf-8?B?bmxkSnNmRmVDWEJudEt3YXQvYkJFVFpFVVZialJyamhtNXZIRmlKSURFWit2?=
 =?utf-8?B?dFhiOGphSTVHQk10QWZZVjVDUTUyOFkzK0Q4WkM4dUU5Y0xGZ092Q2NUZWNi?=
 =?utf-8?B?NUZBWGx5cE9xcThsUzR3TjY5MTA1WkhkR0pDSmwweFdhak1Wa1d4VUNLUzgy?=
 =?utf-8?B?Sm5WNU80aFI4bU1vUmpBWnN6aWJ3dlBJUmhtYkFZMW8wWmE3eGdCV2ppZ0Nx?=
 =?utf-8?B?a2ozMDQ2QVFKWlBGZ2I4REdrVGNSQ0xCMnRNS1JDeFlPYXBRSFpkUEI1YnZt?=
 =?utf-8?B?blhYR1dQYzE3RGpOcmIwTDdRcVVEMFhlS3FxaGVjc2lUcXVXWkk5QnJFMXhT?=
 =?utf-8?B?d20zZ2dEdXBlcnQ4YU9DajQvYVJQWWlQTWNpbnZrblVtU0lBeVBNdENUNkJD?=
 =?utf-8?B?RUM2b0xqcnNEZjFEQTZ5Nkw2NHdEZWlLSGlRaVY2TndPZm92RS8zS3BpUk10?=
 =?utf-8?B?TSs5Vkx0NE54b3NTMFZZQW1jUk9ueklDdE1qSFVxdVF4QU5MVkhCbEcxbEtu?=
 =?utf-8?B?a0NIWE56QnZMWHRJcG5pb1BTbTlUcnNhZWFMRkRRWW9jRVNFNE1XVTJaOTg0?=
 =?utf-8?B?WklCekNneWNCTit1a3FZRW5JamlwOWZmZUdITSttZDBoR1g0M0doelpHbWxD?=
 =?utf-8?B?M3grOC9VUGtFNjcvajJFajZ3Y0thb1lqWlE5VFprV3U0clAzUS80TE9iRkp3?=
 =?utf-8?B?ZU84UzgzZ0JBTWtwQ0ZRaXJseFU2Nk90YklrUVZwc1kwazZZdFdJZHIwSm56?=
 =?utf-8?B?NUlwdUt5M1FkdjQyOFlRZTdqUm1MOHpDcEJ4ZmFHTG5hQ1JkZW02NllRc1d3?=
 =?utf-8?B?cjRTL08yaDMyRDg1d24rTzgyb1k3QjVPaXM5bXpnclFSckg4Q2pCQmVYVXlq?=
 =?utf-8?B?WG9mRWttNUxHOTZDNmZuVHEwUDhqT1dLS3p6VFJDT21LMjBEMnlsUDZPSnd5?=
 =?utf-8?B?blIvMXZIQW5DaG5QMUJNUldaeWxId0F3TzVtV0hiaktsZENEYko1T1dqZHJP?=
 =?utf-8?B?Qk1tYzhxT3ZnZU9wVUgwd2NsRWtpOVMveityRW9aeml3Mjk0VzlhWC9pdUhJ?=
 =?utf-8?B?Q1NBU0htZmttbVNENEViMjB4Rjl5bkt5NTVTa3BoVmliRFBCMFpjMFNnOXhJ?=
 =?utf-8?B?OG52NmRCQnF1RWZhMVp3ZlAyWWhVSWdFc2E3ZVNWZ0l5OTRKVlhBUkxUWUZE?=
 =?utf-8?B?LzRxbEF5SXhFOE5xcHVwem9aQmd0Sll2SnFlSDYyblhsQTYyK0xZYkQxckVJ?=
 =?utf-8?B?aVdha0xHREtTbHNucHJHdGl5MlNlVVpKcDYzUXFrTjMxLzFrSlY0cjFBUEhW?=
 =?utf-8?B?WkxnR3hBL1JIVjZxbmYxRklxd01LL1hwMGlyUmtWeThWbTFPN0FNS1oraE8w?=
 =?utf-8?B?d0kwUmRJYklTZmRKdWE3Y2ZZRElvRDFkaXVVSmswM1JwaHB6ME5aNmtlNjFU?=
 =?utf-8?B?WGhrNzUzSmZuaXJ2R1J4MTFsWGQyQjJmRzFBSEFNOUlGRGNFRWdyVzhtVURG?=
 =?utf-8?B?TlVzR1V4NStNOW45U3MzNHRxWldHdW1MT0tUaU9aUkdmZkgvVHZTaUVIeHdu?=
 =?utf-8?B?eWc5WTRISER2TDZlbEZkZjNiQmdnQ2ZtMFd2K2FCZCtYVjEyQ2hoTXA5U2Va?=
 =?utf-8?B?SDNySkYvWWE1YUloYjhpQ0hUeUNROUdCVm50UDZQa1A2c0pkQkxqaGJoRTJ5?=
 =?utf-8?B?MHZBR3JpTEhEbDN3M1NKVmMyNlpTNjdwU0FRZkRlZ1g5N0E5MVEvMlB3ci93?=
 =?utf-8?B?NkZQNnhwbzFGbWxBa2VPYlFjdEpiKy9YUzE1TncraGZrdGdNd2JGYk4wSDBH?=
 =?utf-8?Q?Ihlzm35WqNj0al3Soa4gUACbG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb73eac8-4098-47e9-0819-08ddcdf829d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:59:49.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+vHNE0HT0Zcub2YQJVaRBAOM7vXNU7N8ug6+QtbWU0zaXzru1sLqCycTcoiMHo5HI1S5MNfRZl5RQODlwyjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
Received-SPF: permerror client-ip=2a01:111:f403:2009::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Hi Luc,

On Wed, Jul 16, 2025 at 11:53:44AM +0200, Luc Michel wrote:
> Split the xlnx-versal device into two classes, a base, abstract class
> and the existing concrete one. Introduce a VersalVersion type that will
> be used across several device models when versal2 implementation is
> added.
> 
> This is in preparation for versal2 implementation.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
>  include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
>  hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
>  3 files changed, 50 insertions(+), 8 deletions(-)
>  create mode 100644 include/hw/arm/xlnx-versal-version.h
> 
> diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
> new file mode 100644
> index 00000000000..46eb165a2bd
> --- /dev/null
> +++ b/include/hw/arm/xlnx-versal-version.h
> @@ -0,0 +1,15 @@
> +/*
> + * AMD Versal versions
> + *
> + * Copyright (c) 2025, Advanced Micro Devices, Inc.

nitpick:
s/2025,/2025/

Otherwise:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_XLNX_VERSAL_VERSION_H
> +#define HW_ARM_XLNX_VERSAL_VERSION_H
> +
> +typedef enum VersalVersion {
> +    VERSAL_VER_VERSAL,
> +} VersalVersion;
> +
> +#endif
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 05ed641b6b6..1f92e314d6c 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -1,9 +1,10 @@
>  /*
>   * Model of the Xilinx Versal
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -33,13 +34,16 @@
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
> +#include "hw/arm/xlnx-versal-version.h"
> +
> +#define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
> +OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
> -OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
>  
>  #define XLNX_VERSAL_NR_ACPUS   2
>  #define XLNX_VERSAL_NR_RCPUS   2
>  #define XLNX_VERSAL_NR_UARTS   2
>  #define XLNX_VERSAL_NR_GEMS    2
> @@ -135,10 +139,16 @@ struct Versal {
>      struct {
>          MemoryRegion *mr_ddr;
>      } cfg;
>  };
>  
> +struct VersalClass {
> +    SysBusDeviceClass parent;
> +
> +    VersalVersion version;
> +};
> +
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index a42b9e7140b..4da656318f6 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -1,9 +1,10 @@
>  /*
>   * Xilinx Versal SoC model.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -918,11 +919,11 @@ static void versal_unimp(Versal *s)
>                                  gpio_in);
>  }
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
> -    Versal *s = XLNX_VERSAL(dev);
> +    Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
> @@ -953,13 +954,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
>      memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
>                                          &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
> -static void versal_init(Object *obj)
> +static void versal_base_init(Object *obj)
>  {
> -    Versal *s = XLNX_VERSAL(obj);
> +    Versal *s = XLNX_VERSAL_BASE(obj);
>  
>      memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
>      memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
>      memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
> @@ -973,28 +974,44 @@ static const Property versal_properties[] = {
>                        TYPE_CAN_BUS, CanBusState *),
>      DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
>                        TYPE_CAN_BUS, CanBusState *),
>  };
>  
> -static void versal_class_init(ObjectClass *klass, const void *data)
> +static void versal_base_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = versal_realize;
>      device_class_set_props(dc, versal_properties);
>      /* No VMSD since we haven't got any top-level SoC state to save.  */
>  }
>  
> -static const TypeInfo versal_info = {
> -    .name = TYPE_XLNX_VERSAL,
> +static void versal_class_init(ObjectClass *klass, const void *data)
> +{
> +    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
> +
> +    vc->version = VERSAL_VER_VERSAL;
> +}
> +
> +static const TypeInfo versal_base_info = {
> +    .name = TYPE_XLNX_VERSAL_BASE,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(Versal),
> -    .instance_init = versal_init,
> +    .instance_init = versal_base_init,
> +    .class_init = versal_base_class_init,
> +    .class_size = sizeof(VersalClass),
> +    .abstract = true,
> +};
> +
> +static const TypeInfo versal_info = {
> +    .name = TYPE_XLNX_VERSAL,
> +    .parent = TYPE_XLNX_VERSAL_BASE,
>      .class_init = versal_class_init,
>  };
>  
>  static void versal_register_types(void)
>  {
> +    type_register_static(&versal_base_info);
>      type_register_static(&versal_info);
>  }
>  
>  type_init(versal_register_types);
> -- 
> 2.50.0
> 

