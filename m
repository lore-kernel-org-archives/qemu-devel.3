Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhalR-0001pK-Gs; Thu, 31 Jul 2025 17:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaQE-0000Bx-BP; Thu, 31 Jul 2025 17:02:43 -0400
Received: from mail-mw2nam04on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:240a::60f]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaQB-0003cd-8p; Thu, 31 Jul 2025 17:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6mgAU/3cKH6ab0EgOBJ3XgUl08oAI39y7p2y1dvwTJ65Gv7j9vFAZm+Gxiw5TBVKYWZ43TGlgnyYWlMllcQg/MfDTQuu5JzDfmpGP/Eb9hjF58DlPCkUz4WbW0JdVzdfauAsGcI6fGEvk/NPDM6P7X/cRjft2oni6FnkjvGREJ+xnbiLglzAkn099nDMOd8MSV2gQ16dHTe85JJw2CarBsCw0LbNaIHbyhRUg4jGLMxxERUJCzsoMMm3u666MtJ4cns2L3YWn13Oa896yyS4q/9B72SXV6xW9Vann43ZWSUygikcUOWPl88zcvUgmvW9k/DhEpJaPd36U0/p5TscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBlnw1j/RTMM+wIBwG0kAqGvC8OSpAuuEYOvL8kKZ+8=;
 b=o6kDTwd+hASkKLyoVd2obCFKJPAOAx+rwmGTDlklpK9OX1MIE1C/V7vFzEulc2Ik7hCWfSbCT0gLk8S9/IZ5WMfwWLRCJ0K5Ffxq8uRfnrohC8YPJY/rZzai1vtzje/VRo9OEragTcyqMDUxTouRwuu2cv/49qRc+jINJGMP83haDR65+ruWQfoXgH0zDwf6y/mujGOtcC4SFbFwRH1UHo7KRP6dELYdIWOI7ekXYMnYrh92nN3dC6lUhB4gWWW5nwBqAb9ZKwZgXFhILqfuX+mhoPCjUn2hpN1OQBw/Uis+A6ybZyUFuY8w9dZ+pzd3ztAq24797qX2pXzsgDUF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBlnw1j/RTMM+wIBwG0kAqGvC8OSpAuuEYOvL8kKZ+8=;
 b=idlqUY4Dx6J1PY0/wli+Y32/r0QPqQs7D85jRtxmOciCR5u/vc3l8W85Dkm4uh9fyvg+7RknkJ/vZelCj5KZzM9YUr0lhBPno6P2psXLpiB0BdG+j9rrQXwG+A62fzvFAr6WhQvz3xJKyYQ4JoYjmEb4XLcosMHno7Ks/+Ozme8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 21:02:28 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:02:28 +0000
Date: Thu, 31 Jul 2025 23:02:22 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 46/48] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Message-ID: <aIvZ3pFqwFQNwEnH@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-47-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-47-luc.michel@amd.com>
X-ClientProxiedBy: DB8PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::37) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 420ef1b3-46ae-48b4-92d9-08ddd0758ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGE2U09CZjVCQVhibVkyMEVSWGRPeGxWTGEvOG9WYUJtSjcvVlM2cFV0Sis0?=
 =?utf-8?B?alh4Tkc2QVpYdDN6QzAzUVZSWVpQY0gvUWFLeUcvMkFxUnFwcXI5dkJkVVdK?=
 =?utf-8?B?TFdOeFQzWVJVWGtaQVBGTUVGM09PMXFUeFFEWThWbndIclhxYjBqTHV4a3g3?=
 =?utf-8?B?ZEJyVm4vWEhNc1hoSWVGZXQzdnpRcE1NSVJiaVdDMEhObzBidTdWVllaTlRU?=
 =?utf-8?B?bzljblU5UDRsSHhEOERhVHVuSEJ6ZFFHQm15T3FtZGhGYU8wWTBkb0ttc2cx?=
 =?utf-8?B?KzRiS1l4ZFI3ZExOc0Q1NHA5OW9hNWVQcmh1eHVXZlJuZUFZSzVZKys0Kzg4?=
 =?utf-8?B?K2JYd1N3WlN5cG0wNjFMNFBld3RpS2ZjMURtZE1RMWovQk9VYkpzRzRaaDR0?=
 =?utf-8?B?VGxCRHJXYVFmdHFLanVtWWgrUnFuTnFzOFlGVktUc0h2dUQwV20ybFMxVEZ1?=
 =?utf-8?B?UW1hVzRCem1KWm81NHIyaWVnd3ZEWGphTjFCc29jQS91dUNkUjVpVWtNWUtq?=
 =?utf-8?B?bWNJWmlKUnhlK0lqMkI1WWhvdDMrS3FoZXQ4RytudzhoYkRXVE1jNnVUaklz?=
 =?utf-8?B?SDFhUFNsdGIvd3Z0ZkRrcnB6ZlRtOFJWSXZJL2E3NjBmVTlDZExaNUI4ODhC?=
 =?utf-8?B?Ly8wQkZ1bnZNK3VtbU9QTFg5NnhyRGJnMHZVT0wzeUh4cnpjRlQ0SGl4VC9S?=
 =?utf-8?B?L0Y2eDEyNS82MlBnZzRSZ2ZmL3RNNTFrMDFhOTI2eXR3djZOYVZkajdsMVRX?=
 =?utf-8?B?ME9yb3E5Q2ZkeWUyV1doaUd0NEdRWWdCVlFuaTFUZ3RlaWdnVjBXeHB2eUhE?=
 =?utf-8?B?SXNObmlxNkdVY01takEzSTA4MFZlcTlaczFTSmZQZXRmSDBER2VFZHAyNWdY?=
 =?utf-8?B?MWtVNU9DNmhkaEd3bzVnWFVHbGxRYnVqSWdOR0RtWkNqdEFHU0NNY2k0SVBx?=
 =?utf-8?B?MlJ0N1hqd2lCTEZta0NKSms5S2JpWW15SU9OUmMxdk1rMzBKazRTOUsyWno2?=
 =?utf-8?B?UndVenhQLzFldEoySEZUZndtc1J5QzRPN0lXYVFRZ1BtcEN6UXFXdG5Qd1lN?=
 =?utf-8?B?ZW5nUGZlZ0t3enNIOFdGQkthdkxIbXA5MjZjbU04SGFWZDY4YkVMMzZrOS9T?=
 =?utf-8?B?NzhOVzNBdURRalpGSzFDN3dQWHhNbHEwY0V5QWJQbzJqbzNnRzIva1MvVDhF?=
 =?utf-8?B?b1RjVFNEd0RGZHJNQW5EbXpSSDkzQXRmV0thTEdFT2xNanh5bTd0cjdDOWx5?=
 =?utf-8?B?MTI3YkV0eU0vbXJCMWRKeEI0b0h0ekJuVk5zZlJhOWg4dlZkQmZvVElCR2ZD?=
 =?utf-8?B?OGlWY1N0SkRoUG9XTDRiMnNEWmNFeVpxU3p0R1I0WXFCM083RW9OMTlMUll2?=
 =?utf-8?B?K2VWbDZnbDRLQXNxKzJ0cmhsNmJGb09TQzdkajZhYWZjbFlud3lDSVh6emk3?=
 =?utf-8?B?UGoyUEFmbE5tWTRVUi9ISlJuakF2SnltODduUWc3WGFBUXQvc3JMa2taVmh1?=
 =?utf-8?B?bXJ5YjNESWdLZ2RaTWpISDdzM3A1NE5WTTlSZTVHZUxPRU1FYlZKSld0R0FV?=
 =?utf-8?B?NjRXM3JwYTFVQkN2RFUxaHQyRnF0WDVCNElJTUI2SVMwZ3dQNlJrZklwS1pO?=
 =?utf-8?B?OWJ1UzdmOGhJbytMSEJybFdIdHBXQkc1d0RSUDhkNUlLOW0rK3VmN1BnV0xN?=
 =?utf-8?B?d2J6SEVhMnRDY2tnZUNUMEFiZ1JUbkNMTXlnMkFnUkJXTU9FQlZtaU1BbUd0?=
 =?utf-8?B?eE8zNmloNXpFQ1BMaDBlczM3cHk1WnFhM0xCMCtodVAxYWpld2tZVHRiempz?=
 =?utf-8?B?SHhaVjUvZmtmaGxSOXlIYkwrSVVtQm1sRGU2L2pReHBKeDlOdEErUm1jNWZR?=
 =?utf-8?B?dlF5VjBDQ3d4bU5DUC9XNUdQaVJmb2dkWmZsZ09JejhJKzFweFkvS0UzSTRN?=
 =?utf-8?Q?/sNKITCLmuE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTc3SVVRbG1QYTZtTldTZG1ucEVpYndsdkQwRTgzZnlYa1B6emN2bUIyZlhi?=
 =?utf-8?B?b1NWNVR3YXlTUlo5RG9SUlpPNkJlWTdNM2V3NlhwOEpLR0Zlc3pETkYrNStk?=
 =?utf-8?B?eFNFeXcwS3BzbGFsT09MUUNrOFhvNE96cTA5Wm1FYmEwUy9IY3lxQjRobnVw?=
 =?utf-8?B?cDRJTGZEelFmL0RKSVpEaFpZaEgrTWxXK3d2dHlzRHUzUUIxdVg4M1Q3M2lT?=
 =?utf-8?B?NHZrZWRWcHBndHZmOHRqS0dFMVhlVW9wUThuZFN5WmdUME1JVVYxd0sxNXdM?=
 =?utf-8?B?VS84Tmhad0tnM0RkREdCUzRLekkrSzJONWN3M2pIMkl6TkpHQlR5V3pqRElJ?=
 =?utf-8?B?Ump4WVk4SHBGNGZVT2I2cVBzb3Zwbll2N0N5L1Arb3p5ZVlMYkREUXV5VXAx?=
 =?utf-8?B?MWZrOThldWJ3WEM1dFp4SVhxbnRtMkg3THhWdWxEVzVPUzYwL2VLSWxRKzhN?=
 =?utf-8?B?Z2h0UUhPc1JNZ0R6MTBNbFEyMkt0SWtvUk1IOWlWeWtWUW0xZW10NWtGOUpy?=
 =?utf-8?B?bmY5SmxSWXEzVjA4aHNOTnRMRVF2RGxyQlpJbUlBM1E1Q0JvaUNSSUhEVVNC?=
 =?utf-8?B?THV5MGJaRlYyU2V3S1ZQVU1DTXBOM1hlOFlUdEljUVNMRmw0Q2dycnNxc0E2?=
 =?utf-8?B?aEZqdFdyd09BenRwMXBhSlZvYUoyUHF0NFk3ZUNBYU5OM3BuU0hnYmlBQ0Iy?=
 =?utf-8?B?dy9ONTRpSm5GZW9BeXFKNHRrQU9iSEZWaWg3bjloN3g2dVVidmtVNmNVUU9L?=
 =?utf-8?B?RGJ1V09lTFE4alpEZEpZcGovbktHK1ZyUHhqc2FKdVVYV2ZuNkJQQ2o3cklR?=
 =?utf-8?B?UFRkOWF4aEVxSXNnZDRhMGRBQ3VldFllU3FySDJ2NEZKbDVXUTh3cmNxY0tl?=
 =?utf-8?B?c0JpY21ab1JJcnBOdEZPdVdxbnE1bTBMT1U4Z2M4YkJoVHVFam9aVngxZEhU?=
 =?utf-8?B?Tzk0Tmt6TzJ3MUZuTm00c1FUUXV2OTIrTkNyYlZEOElsSnVHT21hZjFJQWow?=
 =?utf-8?B?WW1PV04rTkw2NE5JdmhiR3FIODFWRGkzWFdDYzJyTmk4bGtRdEtCYjBxVHNI?=
 =?utf-8?B?Tm5HbE0zajVnM0x2V1o1WnFjejRaSjFTMGppSXBGZ3lrWVF6djdCZkhicEpY?=
 =?utf-8?B?M2ZvcGl4eElqUDBLdXZLZndOUjdNbFFNY2JjTFN0dXpDOW11U2s2TlFnMVpU?=
 =?utf-8?B?dXZaOEdhMUJ0VGlQNTZ0UHBqZkJEVDJPdGtqeHZKZDF2cE9MQkM4eU9TMmk2?=
 =?utf-8?B?QXhrZVBLMk95MndoMHhPbWwxSWpHVS9CeXZUTWRkdlY4Zlk2R043NitaZnMx?=
 =?utf-8?B?QUQ3SVZYZThMY2FYY1ZPTW1Ta0FKRmxYRWxnd2ZmbVJxSCtzV001U0EwUzlF?=
 =?utf-8?B?MjV6QndOWlRhM3Qrb1FKbkU2Zk12NzJzb3ZQZDdjY3BrbjNpaEZZUHU1T3lQ?=
 =?utf-8?B?OW9QZjBPazYyUUxrSWhON3hxSHFOYi9FNUUxS1V5ZjNvYXprblpVOFNna2k1?=
 =?utf-8?B?eXZFazk1c2k2NXBTcndZRUJ5RDhaajBhc3RGNFY3R2plbDl4VExwK1QwdE1n?=
 =?utf-8?B?Unp0Z2FxODVHTmdsVHFSZWtOd09uY2x3aVVFSDlTR2c1RXEyY3V6T28vUkVQ?=
 =?utf-8?B?bmoyeFlNMmtFK3ZJaWVQQklRc3BqeU5IaFNsVVFhNjF4US93TExsTVFaRGk2?=
 =?utf-8?B?REhlTDJkR3pxN3NDbitUWDhVTzRPTXFDdU1vTk5VVXVmeGM2Ly9mSmF0d3JM?=
 =?utf-8?B?cStPV2Rvd1JOSFM5QUhnSUc0RzA2OUx0RWErYzNxY0xMWW1IYXVYR3ZzQlV1?=
 =?utf-8?B?QS9EQkZHM2M1RHpLRkRDc04xQnp6SnJHYko0M1ZnVXhqTXhtRnlJTUVXRDFs?=
 =?utf-8?B?TnNJSExPS01lSEwyVlRUdmlyRks5MFoybVBsOVNPT2NCcWFVV3RtemZ3eFll?=
 =?utf-8?B?dHRaTEJSRzRaaFM5MWtCUENZQmxGWm51WmcycE1wbUlDOHA0aEp6MDNDUnQz?=
 =?utf-8?B?SThteUdDTms4Q0hlNzJ6bXRUK1BPMGR1eHAzNDhBOFN2d1h1NEt0VjVZNGFq?=
 =?utf-8?B?Mlp1Q0RpZEpWZ3pyWUQ1Y0tOQzJENXR4SGgyd1U5SjZtUGpUdHNpT1hldDJQ?=
 =?utf-8?Q?Q7mfAMF7xluDDPSOgBW1ZusAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420ef1b3-46ae-48b4-92d9-08ddd0758ec6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:02:28.4820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUWDHDLMtkNoHDyDPV1b4qoHO7WqjKiDiWH51kKvZAjXanpIhXosbvGwRUakisu7TZ3BAqiOxLolcVl8aWaH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
Received-SPF: permerror client-ip=2a01:111:f403:240a::60f;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:28AM +0200, Luc Michel wrote:
> Add a note in the DTB section explaining how to dump the generated DTB
> using the dumpdtb machine option.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index 94c8bacf61a..5d7fa18592b 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -63,11 +63,17 @@ Users can load firmware or boot-loaders with the ``-device loader`` options.
>  
>  When loading an OS, QEMU generates a DTB and selects an appropriate address
>  where it gets loaded. This DTB will be passed to the kernel in register x0.
>  
>  If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
> -for boot-loaders or firmware to pick it up.
> +for boot-loaders or firmware to pick it up. To dump and observe the generated
> +DTB, one can use the ``dumpdtb`` machine option:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
> +
>  
>  If users want to provide their own DTB, they can use the ``-dtb`` option.
>  These DTBs will have their memory nodes modified to match QEMU's
>  selected ram_size option before they get passed to the kernel or FW.
>  
> -- 
> 2.50.0
> 

