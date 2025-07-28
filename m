Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF489C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugUzi-0008UQ-Ao; Mon, 28 Jul 2025 17:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUzI-0008E7-7P; Mon, 28 Jul 2025 17:02:28 -0400
Received: from mail-dm6nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUzE-00015W-UW; Mon, 28 Jul 2025 17:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0Hi2zLL4ES120g1sdyKp8roM72pWS70h13/ASVw8gE/eSYF+LDk3e8+NFZ2hES5WvZmXnDRp7YNejV23UdkKunbqM/76735tbROH3up508W8e0yyPhIUzRTizPOZbDKfg+3AEkrueUL9bJxOglOdWATw9ynX4/FXBzzlp2gDyE2dBooU/J0ZFubJn4iEIzL81TKP1Bmf+kh2rd6xvgIvDS13tOoKuhaEunFfRQfvbYe0q3tGtWOzXxBYRMETtH5E2H9auwM9wjrn4q/mWZCzZquHnTKlDuMwEbxjYXjWNIR/9BebXgb9eXEXLB7vnBZvMtentqNggMRNWUgkG1axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r1v09hkHPfuHmWuOa2sCxsecceTCl8IIa6p5XnHGuM=;
 b=X/7FgnSaakBiIE5bFj8PH6rHN895HrXwXWO013gCWO5o/ch3VOCrW6tYOoXZtJJka9WzohYJJjphJ16mHHRI8zJTpzdm95Pya+eLMNVXgkVpsYqIWVv0ibQnMAs7+FtZ9QwSYgn7+YPuqTsYhSrP+II13e1Z6bDfHBNQyFvqL4ogdRC0OgOGhQ8C/LzRDA3GkiP4hAfLIngWjHVo23BfVdsIamfA2TT3gM8occN7sisSfSH+k102E8ztHSvOcWaOYTGK3hj5KdMB7ubjg997CSMZKGdKcmcb5FOaLf8EIKDq6EdYR5jnNioQ3yE06uNdz+SmC0iaba6v8KvYlOBltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r1v09hkHPfuHmWuOa2sCxsecceTCl8IIa6p5XnHGuM=;
 b=n+Fd0qGCq/ehUSptbUZ1LLJ9HPHRBkWHRGjkYKWjtWm4A8DgOVUEv3DhxtevE0kdmicWi04Na2Z+62H3kZs5gXwudQg8muMrxfQCJ47OYkTsjyacXjCLo2Nl06ADvcco0/2qEI2A1gQW0Je+53dw1apUkhmXoEOiBaeSY61Xmh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 21:02:15 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 21:02:15 +0000
Date: Mon, 28 Jul 2025 23:02:08 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 08/48] hw/arm/xlnx-versal: adma: refactor creation
Message-ID: <aIflUPXm86mjJPHp@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-9-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-9-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 239a9343-e24b-4b7c-2b7d-08ddce1a07b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2FwNUFIR3lqR1FzaS92SEZ3bGY2S1JuMkxpamliazB0RnU3dlp3dzBHdk1L?=
 =?utf-8?B?Rk55TWo2QllvY0kxSGRJaTN4ODBFbEc5Nlg4U3N4SXdMeU5rNnFJSTdITmdU?=
 =?utf-8?B?OGdBV3pmK2tjVXZVRng3VnoramNUSjY4elFPQi9hNHdaNGlmOGFVNENwNVZk?=
 =?utf-8?B?VTNkRWc0ckViZ05ZWXBzZXNmS0Z2ejNBNkw0ekRDdkN3cUVTdythZ3daYnd3?=
 =?utf-8?B?U29wUVNQN05HQjBpN3lIZXVjdjQzb2w4QU1YTlRhbnVyQitCTVpVa09QU1Ir?=
 =?utf-8?B?UHhRQ0QxUjU4R0hPV2FVVzRjN0dyalZNSEt0TmVTUnkvbE8xT3JmWk1aTTEw?=
 =?utf-8?B?QnVhbEZmMmVGQzkwSUxVT0N3THRMYkIra1llM050K2JZNit3QTl5aFNZa2pU?=
 =?utf-8?B?bTJvK1lGUWNPdFo5ZGc5SmJjejl2VFlac2tZb2hPVUdmOGhqWEh4UDRSMnBa?=
 =?utf-8?B?aU82UncwMTEwM0VlbjR5dGlaOWc0WjluM3V5UzJEbkVQT2hUck1LMWN4NzB3?=
 =?utf-8?B?NEVPZWhKdjlGenBKTDVhMlIrai9CRXVVWGJYZ1JxQ2k5bHovYmgvVFZyeWJq?=
 =?utf-8?B?OWIvNnJOandmaEhpdU1vODZmaDNCekIrWWFOaExzQkhkT2E4VmQyM0ZJcVRK?=
 =?utf-8?B?TXVDOURxNEJEbkozQnh0bmV4eEI2OVVrWXJFUjYwYmpZdkpFSStvbWpQa1I1?=
 =?utf-8?B?ZGhVbnBxbFE0YWhqWnB2VEtiaVRNV2J3MlpRekIrdzEyUVpXS1dKMmtIYytk?=
 =?utf-8?B?WHFCN0g1U2xldzBmTVB6aEt4R1lac3VCVU5sQ2wyMTJLOU1hT2NhVWNqRkd5?=
 =?utf-8?B?THFxVjNRdGphMzkwMHExandpcVRtMjBVYUFkUEhtVXFabDFSeW1BZ05vYXhB?=
 =?utf-8?B?TnBkZTQ5ejk4OHFLbjlsclRwYUJJY1NDOUNWTlNVOExjT2tWL0JVVmhmUjk1?=
 =?utf-8?B?UTVXYndtbGUyNWxZVW4vSUFUeE84Slphd0tvMzczcXBFUmovMlpTM1Rob29O?=
 =?utf-8?B?cDM0TDJHYTdzQm51OGVnQlNwY0FGWTZjSHR5ZjRiVEIzOVFxaE15Zkk5Zllx?=
 =?utf-8?B?anl1MWRGc283RXVoUGdVaEZEUzZGNTlqT3BHSDk0WHgwaEMvanVrbmRtb0FC?=
 =?utf-8?B?V0UvY0l3cE9IOUx2MVNtQjh6Ky9wZXZFQU9YVkl2b0EwNzZXM2tXWXBINlZr?=
 =?utf-8?B?R3pLUkVTREw2cG8zdTJoMFhZUTBjL205YVNZWDZMQVpULzZtYWdwNW5tNTAz?=
 =?utf-8?B?a3h6OWhLOVVkcnllV01lUEVBTGtENGx1RnROSkxpUk1kMXh2SGtyVWxwQU1v?=
 =?utf-8?B?L2pZcGRMT0ZHNU1BUDRtZEcwWDE3MzJLRGVLWk1KdUVMbmtCWXFUVTRRUWRM?=
 =?utf-8?B?SVpva2s0Y0s0S3NCY3VBUUM3bDdTeUo5eDlzT0VaakYwdUFkZ3hsQUZNeGwr?=
 =?utf-8?B?SkhCaVBiS2YyMEg1V3FvcURMSGZPZ3Fpc3ZNSklFUjN4SGJyZ1U5M2VrMWho?=
 =?utf-8?B?ZVlTYnE5dWsybitVSXdLTEZ4QzZ0RzF4eDZNOVVRbmpNTHAwRlJHU3pOaGxL?=
 =?utf-8?B?SHRkWnl1aGphTDNKcStyYmtoUVhKT2tnd0gvaW9DZTJuaWMrUXNqcmlVU09Y?=
 =?utf-8?B?a2ZHaDZmeXQwRlJzRjN0YVBvRXJNTVFrQ0lGeFJrL2pWSXJBRDNjcytNVVln?=
 =?utf-8?B?dHd5a0R5bWFBZVhqck9YdU44VE9GODBFZ3p2VzlCMkVBSElXdGtWbE1jajVt?=
 =?utf-8?B?RHZXcFNDL3ZvTVN2UVZNMU8xWjJyRnVGTEh3a1Uwa1g4cEdGd043TEQwNm1B?=
 =?utf-8?B?Y09GR1MyQU9YTjJzM0ZBTGFLR1RlRjVnNlhxSWFUVHR1SWtTc1RLTlZXai82?=
 =?utf-8?B?bXhTcExWOHJSbHptUUhLTy9lSys3cEtFdnB2YWh5ZnNrbStSeW9TUzd6WFp1?=
 =?utf-8?Q?6vMLe/RVemA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STAzOTB3K2lXQ2ZwTUVmbE9MekxRalVwYklPTzFldFVHbStNc0ZaT0pjb1Zi?=
 =?utf-8?B?MS9JMmJ0c2JQSzFxc0VoTFNyditYVlUrZm5JTmpzQXpDWUNTWDFaNHNSL0RR?=
 =?utf-8?B?V0ZVVkZNaStDYzZid3ZjQVJ0SGxmVGZOaGZpR2FmRkU3MVJMek9ZbnFGT29F?=
 =?utf-8?B?T2dIM3BzSmdJLzV0eVBkN0l3Y3A4dnRLbkcyeC9wVHlXcFp2NXFnWU9pVnUw?=
 =?utf-8?B?cTVJSW93STdVZDRncElzTExTeXU0QjU4VzlrQXZMeUJHS1FhYTVmZjlkWjBF?=
 =?utf-8?B?cDhWSlNtbXc4b00xN2RqWkhOVWFSZVVNUjBRVjI1MWh3THZCZnIxUHRENnZC?=
 =?utf-8?B?Y0twby9pd0c1UTNyZXJCM3gvNEQwRU1RN0xuUW1pYjRBMWJtdmtwZUF1TjE2?=
 =?utf-8?B?YUVyTGZTY2NVdk5yc1JlLzdRRG9xREZ5K1JOckQ4clJvcHY5ZDY1YjByWVdK?=
 =?utf-8?B?NWpMNjFLZkxKNis5TzhvY2J4VjY0VUlZZzA4QUdoVDRyRzZOajllUnlIdkU5?=
 =?utf-8?B?T1ZncVNHWTRIMkRzK25UaG1kVGJEOXFjTGZXNEJFMVFDaXlmWW05cGd5dkRL?=
 =?utf-8?B?bzZLMEQ0V2dYWnAvbmhqYml3M3BwTzU1UFZXUEIvYlBnRjZVbXF4UUI2SkVF?=
 =?utf-8?B?NExZK0MrblBBSzRlYXE4NXFKejdjSUxEc0FPVXVFU0FOb0ZRQXNTYjJMRWdW?=
 =?utf-8?B?VTUvU1d4ZjVKUWIwV2xmTFozcGVQRGx5cmY0ZmFsdGtTNnhvb2liUER0UnhX?=
 =?utf-8?B?WFpkckhWZmszUW5qTWRPVU1qRGVzYm9qYzd5clFCZEIvSk5kTjZUSFVKZGs3?=
 =?utf-8?B?RW5qejdkalVLVEpGQ1dkcFJPWGlhKzU1eUcwRWxvS1NrTFQzWWNnRklnU0dB?=
 =?utf-8?B?MFY3NjN1UjFKQ081a0JZRVFnd2ZLMWRiMVkxUkRZZS81d2o3c1NJd2tCZVpp?=
 =?utf-8?B?aHpOMmJDQ25kYVBwS1NaSk41aDJvL2E1Zzl0Q0IvWU5zMWZmQ2VRZFJxeC8w?=
 =?utf-8?B?c3JaZmZIcXJGNlRZdmNZcTg3NHUvazBVR0ZxdUZSZW1DaFo5eExwVkt0Tnc3?=
 =?utf-8?B?SVJoaDQzVlh2K0QrYzZYenlhWWVjbG4ycVI1aWFlSytPZWRZMVpjbVhIZmxT?=
 =?utf-8?B?eDU3aWNTUW15SW5iR3A3eVdydXBSQS92czRJUlFiODR6dGJhQU5XUmxEMEd5?=
 =?utf-8?B?eXlKa1VINmxxdzFNZ3M5UXVJZkFvcnM0MXgwdlRoNGl1QjZqMGNyUkI3VUFJ?=
 =?utf-8?B?ZlpYb0FsKzc2OVVqYnFwbnI5aEtMa2JpVk93amJJU2pobVN0NkF5ZkpVdG1C?=
 =?utf-8?B?WXdmekdnRTlET3JNMDIyQ1J2V0FqSittNk1lZDBhV21XMHNxK3k5S1RaMDVQ?=
 =?utf-8?B?WkJDSzVNcG5EZWZuYkwvMkRyWU9meEtRa2Fkc05XOUUrcXM3UXRoUU93STRT?=
 =?utf-8?B?aG53dHdGUmhzeHRXa1NaYllXRUpKN0hIYTdwUHBiZW4zdkRCbVlaVmgxd2FK?=
 =?utf-8?B?MmhxS1RaR3pYcGhWdk8rRTBsamhIdENvcUhiR3dub0QvQzM4L1c3L2V1Z3Mv?=
 =?utf-8?B?cW9mdFlNQ29PbGZlb280ajI4ckxuamxKMi9ERUU4L1VoampvZEtpY3ZxQ0p1?=
 =?utf-8?B?aFE2TktYRHEzYW9Kd1dLWWJvSDFJMkJZc2kzdU0xMlFreGRmbWpON2dZbGpk?=
 =?utf-8?B?TFN2M1Bsak9BUDZra0hjUmhMWkRkMHpwOW1RRzBmK3g0cEpMcFdod0pLbStI?=
 =?utf-8?B?bzhMbG9vbjJQdWJINXhMVk0reXFhd0NqR3VLZUhhaWxMYUJ3RzhIVU10S2lj?=
 =?utf-8?B?MnRNU2VGcFhDWE1nNWVGYXpjY1BqWUVPTVphdCtKcjByK2sxM0hYMXdxUHBS?=
 =?utf-8?B?b1FqZGVVZ0loRlZ6ams3S0hza0VISnZiQkNKeU1QYzJIN3pCUkNpWHA0R0VU?=
 =?utf-8?B?Zlpjb1ljOXMyVWxpSU1la05FQUY4dytLcXhEUEJGNmd0bXM4Qmg4Y1hDWWJJ?=
 =?utf-8?B?UmV0cDRLSmMxNW9Ic0ozaXpMT2pnQU9Mc05KWEpHNUJZUFZzeDVtb0xqbTFZ?=
 =?utf-8?B?cFF3S2pWUVpNQVBrU0ZBVTNpYVBOV3hTYmhFYWNUd0xTRzdVaDZHbDJTZlho?=
 =?utf-8?Q?AFyPBHiRNbr0xkx31k6gXfjp1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239a9343-e24b-4b7c-2b7d-08ddce1a07b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 21:02:15.2692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxFB/QFpxfYfWkitk+z3VJ4LDGUlnDul8KyPpjUYwwgmOlQ/UrIpgiVvlVEYG1R5ISOeNap2fVQBB7RZlsOAXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Received-SPF: permerror client-ip=2a01:111:f403:2417::62a;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:50AM +0200, Luc Michel wrote:
> Refactor the ADMA creation using the VersalMap structure.
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  2 -
>  hw/arm/xlnx-versal-virt.c    | 28 --------------
>  hw/arm/xlnx-versal.c         | 72 ++++++++++++++++++++++++------------
>  3 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 1fcc2b623da..4eeea98ff34 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -15,11 +15,10 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
> -#include "hw/dma/xlnx-zdma.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/nvram/xlnx-bbram.h"
> @@ -75,11 +74,10 @@ struct Versal {
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>          } iou;
>  
>          /* Real-time Processing Unit.  */
>          struct {
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 09f87dc76dd..1922a90019c 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -202,37 +202,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_zdma_nodes(VersalVirt *s)
> -{
> -    const char clocknames[] = "clk_main\0clk_apb";
> -    const char compat[] = "xlnx,zynqmp-dma-1.0";
> -    int i;
> -
> -    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
> -        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
> -        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
> -
> -        qemu_fdt_add_subnode(s->fdt, name);
> -
> -        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addr, 2, 0x1000);
> -        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_rtc_node(VersalVirt *s)
>  {
>      const char compat[] = "xlnx,zynqmp-rtc";
>      const char interrupt_names[] = "alarm\0sec";
>      char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
> @@ -556,11 +529,10 @@ static void versal_virt_init(MachineState *machine)
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> -    fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 062f9a91a6c..97cd991be10 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -28,10 +28,11 @@
>  #include "hw/arm/fdt.h"
>  #include "hw/char/pl011.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/net/cadence_gem.h"
> +#include "hw/dma/xlnx-zdma.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -58,10 +59,20 @@ typedef struct VersalMap {
>          size_t num_prio_queue;
>          const char *phy_mode;
>          const uint32_t speed;
>      } gem[3];
>      size_t num_gem;
> +
> +    struct VersalZDMAMap {
> +        const char *name;
> +        VersalSimplePeriphMap map;
> +        size_t num_chan;
> +        uint64_t chan_stride;
> +        int irq_stride;
> +    } zdma[2];
> +    size_t num_zdma;
> +
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -76,10 +87,13 @@ static const VersalMap VERSAL_MAP = {
>      .num_sdhci = 2,
>  
>      .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
>      .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
>      .num_gem = 2,
> +
> +    .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
> +    .num_zdma = 1,
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -484,34 +498,49 @@ static void versal_create_gem(Versal *s,
>      }
>      qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
>                       sizeof(uint32_t) * map->num_prio_queue * 3);
>  }
>  
> -
> -static void versal_create_admas(Versal *s, qemu_irq *pic)
> +static void versal_create_zdma(Versal *s,
> +                               const struct VersalZDMAMap *map)
>  {
> -    int i;
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    g_autofree char *name;
> +    const char compatible[] = "xlnx,zynqmp-dma-1.0";
> +    const char clocknames[] = "clk_main\0clk_apb";
> +    size_t i;
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
> -        char *name = g_strdup_printf("adma%d", i);
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> +    name = g_strdup_printf("%s[*]", map->name);
>  
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
> -                                TYPE_XLNX_ZDMA);
> -        dev = DEVICE(&s->lpd.iou.adma[i]);
> +    for (i = 0; i < map->num_chan; i++) {
> +        uint64_t addr = map->map.addr + map->chan_stride * i;
> +        int irq = map->map.irq + map->irq_stride * i;
> +        g_autofree char *node;
> +
> +        dev = qdev_new(TYPE_XLNX_ZDMA);
> +        object_property_add_child(OBJECT(s), name, OBJECT(dev));
>          object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
>          object_property_set_link(OBJECT(dev), "dma",
>                                   OBJECT(get_system_memory()), &error_fatal);
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
>          mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps,
> -                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
> +        memory_region_add_subregion(&s->mr_ps, addr, mr);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
> -        g_free(name);
> +        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, irq);
> +
> +        node = versal_fdt_add_simple_subnode(s, "/dma", addr, 0x1000,
> +                                             compatible, sizeof(compatible));
> +        qemu_fdt_setprop_cell(s->cfg.fdt, node, "xlnx,bus-width", 64);
> +        qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                               s->phandle.clk_25mhz, s->phandle.clk_25mhz);
> +        qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, irq,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>      }
>  }
>  
>  #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
>  static void versal_create_sdhci(Versal *s,
> @@ -970,18 +999,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.rpu.cpu[i]),
>                                   &error_abort);
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
> -        g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
> -
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.iou.adma[i]),
> -                                 &error_abort);
> -    }
> -
>      object_property_set_link(OBJECT(&s->lpd.crl),
>                               "usb", OBJECT(&s->lpd.iou.usb),
>                               &error_abort);
>  
>      sysbus_realize(sbd, &error_fatal);
> @@ -1161,12 +1182,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_gem; i++) {
>          versal_create_gem(s, &map->gem[i]);
>      }
>  
> +    for (i = 0; i < map->num_zdma; i++) {
> +        versal_create_zdma(s, &map->zdma[i]);
> +    }
> +
>      versal_create_usbs(s, pic);
> -    versal_create_admas(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_xrams(s, pic);
>      versal_create_bbram(s, pic);
> -- 
> 2.50.0
> 

