Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA5DC87FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsVq-0003TE-2n; Tue, 29 Jul 2025 18:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqjM-0007jP-62; Tue, 29 Jul 2025 16:15:29 -0400
Received: from mail-bn1nam02on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2407::609]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqjI-0002BX-Fk; Tue, 29 Jul 2025 16:15:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvBalWhDTJxnJeNPk1GFLP5TSKfD+oCQorJbpbPCYlPIuRv+sA9xNkPhMtP0RRjC3yk+lH3oPG+n2eQ0q69COEJ/Xz1aUgPnqWQ2u2v8mpDS0k4oPKogYdJtNaOVPOhOWmYYIYHHDQHvKfMHqk+R0+jL+fimvBr0f5ILlP+J24QkVJg5jyc2z7jLX2kzg5bcEbYg+NUoUdtlHmoAA4D9m47jk/b1Ma3c9Ve6MHm/F53WQE5DolNvpTxP23agtByR+smHZcxaZgbtu1xmtTY7u6hQ8spakswcpPcWmyLgIVLB3gXN0IrCutn0eRTvYbNas+4v1VWnRJRHe9nge4+xCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHt6x9amEoJ0LwIbn/PUUl9IkRzjur716pORrpvL5oY=;
 b=Rmtg2rALz6oZMEfpaXDOBSjkglInHK1/w+J1WXNcEaLHHBwwaTfTndlWKROfGPiChC7r0nPp80p+faSVhlBomYmFhJA/JUCsU7+eQlr/eiesCgZijKZPagGV4IylNxYjc7yzAVs2ESVaOKpJcCRKqUbnv14d1Juq0uGvkWmzAtBHvknvFxa9uPACB3D8kkpXaRi22QvOHTm0K4za1bhDYq5/Sbqh5kdas/mbSjXHNfawLTuv/RMYnOW15wDCWCjAzIKnkA1qI5pYZUeO1dOxDfgrWRvqrH1QE6ghwe+WfamSoQbwkB16nJEnzy59zmeyvupNlynsWK/Y+8gj6ulkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHt6x9amEoJ0LwIbn/PUUl9IkRzjur716pORrpvL5oY=;
 b=S30TNeVWzB95943XfnHLm2Io+oAxleuPelR4m442qznGSs7a8xP1JQLr/ffY3Z/UKALmlfdpVN2W9/ItoSoGp9jbVtesPkpkOeUbeu5p6cYLWiXvC0ioMggWuJfomEx9zXDEi/fd5rvFYQlyNTcprTtZhrXtOHl3ro0gpVoiHP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 20:15:12 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 20:15:12 +0000
Date: Tue, 29 Jul 2025 22:15:05 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 22/48] hw/arm/xlnx-versal: add the mp_affinity property
 to the CPU mapping
Message-ID: <aIkrye7kwF+DYBb1@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-23-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-23-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: f562eded-aaed-4f89-bcea-08ddcedc9f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Skc3S1hvUnQvL1NLNUpmRXFwQnM1K0RZcHdxVHNidm5tQ0hyZy92eFZJQ05P?=
 =?utf-8?B?R1l5TE5sSXJmQ1lIcHVYRThLWnRpLzhRQ3FXSDRVZ2F0K2s4UUFtUmZDY1Qy?=
 =?utf-8?B?NksrSGJXSENxN3VjVUlONzZuVTdKMHg2anlyalVpb2pKMVowQ1F5aFBXUGhM?=
 =?utf-8?B?QjdiUkFnYjBNR0lyK3dINDVBYWdhVjJzWTRxU1lxNmExa0o0SlV6WkFQZ1Ir?=
 =?utf-8?B?L2FrY0ZWSzJGbmxKUDFaUnpHb1l1TDZ5MEFsWEpoUWdqQ0EzZXhMNXNjM0xt?=
 =?utf-8?B?aWdRL3htRFN5TzkzRTNGNGxuQ2VUT2h6RHgwd2RWSXRYNjlCVWZCR09LV09C?=
 =?utf-8?B?WmFWM2t5bnAybHd5eXN4bVhhWFkvc2g5U3AzKzBoRmYyRWR2TkQxd0tXV2Mw?=
 =?utf-8?B?a04ybHZ3bEJWZ3FiTlFTUkxUdWVMR0V0TFJPTEZibFFWY05TQnRrR3RwckFS?=
 =?utf-8?B?b1JITDNaclBFeVAxMGY1VFA3dFhBYldjc0c1Mm9Oc3VaMGU5SUt6TG5rNVJr?=
 =?utf-8?B?amhOajExNDFyNEVZdThVQWZhYWFyYUhra3dJaU12a3J5ZHdybEcwcUp6a3dr?=
 =?utf-8?B?TVUxaGsvRUw4VzMwdW5KRWlySXBkZVhzZHppMzVkdUdZNENmZUNYNytCZU9D?=
 =?utf-8?B?OWdTbWFNTWxKcVVXTkZyeHZ2eEd2NHNkRE8wWTQyNG55dW5EMGJtTGtaWFAr?=
 =?utf-8?B?Z2l3YmJjcjdROExQeFlPM1FrVDdQV2x5L3VkVVlaMklWK1k4U1RxOWdySi8r?=
 =?utf-8?B?NVB4eGhpaElJRUpoOFlLSEh2NE53eVpMb0QraHpDdmNTVzgxT0ppdHZXbWh4?=
 =?utf-8?B?ZGo4N1N0UUQrM01wMTZ3MHd0RW56MUpnNy9pWUJ4UCtoRFFpckpOSVNFUGw5?=
 =?utf-8?B?Ym1RU2ZwRUlJZ0ZoK0tqTjVvemNhcWJrMTBwbVc0ZWtPa1lZdGxWSDhXN3pn?=
 =?utf-8?B?S3lZbURxYmJ0R0lrZUs2am1GTisyRXh5eVQrSWI2QTNuTmVMZ3JRM3F0OEl6?=
 =?utf-8?B?ZHNwWVlEV1FuMnBvVWZhbjJpU0JtNzBVYVVGcURkbjhJaXB3VGhHM2ExMkxs?=
 =?utf-8?B?RG4wWnE0dVJScTR4MDVEZ1JLUlVqQU1meXB2N2prZ3pTTjcrci95OExjVVVh?=
 =?utf-8?B?cHNJNkZObDdQQWVEVXk2UXovblVjckVqV1ZIcFErRnhBYnVhanlXVnhjU2xH?=
 =?utf-8?B?TEk2eEN2QXI3VzUvM0tVUWtNaTE0Ti9zMlVobFdVenVwajN4eVQveWs4cWUv?=
 =?utf-8?B?aHphNC9QQnZJN0JQUExkUlpwZW41NG1pVkhZT0dYU0poOUN3Rm1xVHU4KzRH?=
 =?utf-8?B?V3Q1RW1OYkhRWUVOc2FxR2oweHljSzVJWVM2RE9uMUNhenl6azdJNUtQQVRk?=
 =?utf-8?B?K1hSdDNtUGpiRGxxWXhVNTN3TzRJSjkwUE1zaUpUNWVENm5vd3pVUWVTK0F3?=
 =?utf-8?B?eTI0WnpuelJPOTFMK3NvQko0VnRnanNtVUlvSWowRGNVSGM1Wk9yVktOblZ1?=
 =?utf-8?B?YktTY0xrOXZGNWc5QnkyZTA0Z09UaE1RNzRGaEQ2Q3Ardjd2T1o3UWRNVHRp?=
 =?utf-8?B?VVhBY1hZMk4yK3ZWTUpYN25RcWg2dVA1V01VTmxPQ2FjelpuSDkwb20yQ2Zs?=
 =?utf-8?B?cE1pZFNUaWwxTGU3YjJHZFRBNEp5bWhHYjZoOWk3bkFLeFJKcWR4dVkwbWFm?=
 =?utf-8?B?UDVENzEzYXJOOGdMUmpUdTV2Z3c0bEZ4OStJNFpKUlNjd0Qyd2RXZ3BLTU8y?=
 =?utf-8?B?Qi9LUUdab2tJYmFZK3NkWXl2UEo5Q2NkWVlEM1JoRmRhSzNaRXkxY1BCd3V0?=
 =?utf-8?B?MmRTTk1yY3M1M2x4VE1jRW5CbVNQSjlqTnVoTGlUS09CRGFDaW9XVGp4RFgr?=
 =?utf-8?B?am90ZXFCRDBTbC9pMHFGL2huQ0tJRGFTZEZYck00dEZJaExCWlFvMkdDUlgv?=
 =?utf-8?Q?K+c80KuSBOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRyZzh5Tkp1UGF6Q1dIM0NyV0RhQ1pJb1NiREZVR1UzL1JVWUE0cUM2NEtB?=
 =?utf-8?B?N1JXdWlWL2MwS2xjWmFIVGdNa2hydGtsZkRGT1JiSGxOS0JWOEl5K204eTkz?=
 =?utf-8?B?WGxlSWJZTGxVekZ4ZGZoUVRXM0tXYXhWWWduUjZYQWRERk9zeFh4a3B1TWdS?=
 =?utf-8?B?dVM3SFkrTkdKKzIvckVycjRIVXowV0EyZFlodTNZUlRRY1pHUnVwUXlxS2pO?=
 =?utf-8?B?OWhvWkNldDFKK0wwemZKTjNKOHpZclQxQVRub3VHbEttV3RUU1NON0RiUXEz?=
 =?utf-8?B?eVBkS29kZHFKMHJPdHZncXpNaWtTbFM0MmN6UHZaQ0JvUTVYSTBoOE9EaW9T?=
 =?utf-8?B?eXc2VVFveG5ybmVBV0ZmWnVCcVpoYk8yS3J3cnZ2a2ZWWlV4aW1oak1xOVhJ?=
 =?utf-8?B?VERkYUpWbEtXVjRtU0s3U0l4OFlsd1RNUm8wOHpjQjVVMmRSRzhDS1RPeEd3?=
 =?utf-8?B?Mnora2hTT3VNeG5lcXFTYWhaSTBSeGFGMytoYzFZUXpzRXNFcExTaTJ3QkFU?=
 =?utf-8?B?UElpYzhwUEcwSEN6YVg3YllyZGxJSUNGTXZNVXVmQzU4OWNaWk9NN3ZBNmNn?=
 =?utf-8?B?dWhrWnRsc3daLzlEMXQwcEpRQU55ZGh4dXNrNEpyMTFOZTFrQjNNUitKZFFs?=
 =?utf-8?B?M3ZyY1JNbUdidU1GdTlCT25lbkR1azUwYlRzZ043M1NOamZGajNubm9sMHlY?=
 =?utf-8?B?Z2lleUszUmtkNU1zUXltQW56R1hZUU12dHh4QzAvc0RVTE9DSHVYZll5R1BH?=
 =?utf-8?B?UFhRWTA5OFJmQ3lLTDVqbGl6RHhtMEhLdXllSW9tWkRDR3FLL1NuZGk3NzdS?=
 =?utf-8?B?Rkl3V2d6OVlETTFESmxOdlFsQ3hTQklRbWZyQ09xQTJXaFlEV3BzMm5tVzl2?=
 =?utf-8?B?SUZCaEpFd2xXeWFteTN0UCtIcVhvTVJEdndoY1hCcGlGWmQ0azk4aTYvKzMz?=
 =?utf-8?B?UTZqV2pqalBWU3UydHZ1V1RyTG1JbXFFUGhxWEhZOXhCcXJoaXpXM2k5N0Iz?=
 =?utf-8?B?ZTZRRWdPMENTK3FUSk95REVGcTQzc0ZUbWhxSktncVdVOWhaUjZwUzh3N1lP?=
 =?utf-8?B?QkJlS3FOMzJVUmlxSjBxNkJGMHhrT3l6eExZUlJud2pCdU04aGtOSldpNWtO?=
 =?utf-8?B?Q0Q3SWplbWRPRC9vOG1ySk5RRGdEOUJ4Z1VmeWJmQnBiN0RRcHNJMGhJS2hU?=
 =?utf-8?B?K3h5TzRxdjZxMTdBeGpzcnYyekxhYkpDalhvQ1Zwd0FhekU1VkxlcGhpN3ph?=
 =?utf-8?B?aWJVcFZrT3Z1L0IxS2VvejViWitnb1A3VHpLRVZQa251YXRSTXRiWUV1elBJ?=
 =?utf-8?B?ckhVRnVRcmVTL2k3MVcwZnFDM1dLOTZlcEM1YXpMbFgrQ3FIVWZqc1JvZzJr?=
 =?utf-8?B?blpwUnhQZk9SUGJBWjFKOFZHMTFJcmc0aXBiVGs4TjhqSHpobWtSUllUODN1?=
 =?utf-8?B?OUczTC9CMlJ5dnFzRVJoMHJCSDJSWWorRmsydlFiWlYzQitHeGFaSDVBK3RO?=
 =?utf-8?B?MUZaT1k3T09HY0FabEh5ckhpdmNKK2g1N1p0aDZ1ajlnYVZ5NUZReUY0dFN6?=
 =?utf-8?B?SHFVUXZ4cTRLTDVEV01tcDFwRkw2WGt1alJzYnRHejAxKzJUREV6NVBacnFs?=
 =?utf-8?B?TXpEWk45ZUhFUnFCRE8rd2Z2UHVFeC9IYzVDYVFURlVYRG9uYkN2WmFzRFNM?=
 =?utf-8?B?MWYyNkdud1ZoRENXQVNiQ1dWbnI5ZXp3cDZvNzhRaS9aY3ozaXBYdHNMZkRl?=
 =?utf-8?B?Nmp3bVI5M1pwUXJwVmFjeUpJSDV4Q3VMOVY0Zkk3cjFxTXZ3ZGFUMzRybDRt?=
 =?utf-8?B?MERPUDNIc0xCODRHZ0p4WEtWUk9uaHRNN0ZxYkNQcWc4dXBOK0hjTFYvMS95?=
 =?utf-8?B?TXl2UE1kdDkwTW1vUWhXNldZaFhGbGJLWXFZdkpKR0plT3lDODc4d2pOZ2tU?=
 =?utf-8?B?WE5tYmpuZ2tzRGRTRXhUMklNSmhVSk5sR2E3TVE2Qnl4NStwT1M3OEFqcVds?=
 =?utf-8?B?bjB0WmhYdUg3NXpEdHJPNm5VM2ZEbVVSS3NvK3lCU0plQlJTL1RmZ2lzS2pp?=
 =?utf-8?B?cGdtS1B1b1hpZDRUbklxK3cwYmxHMXhjT3RhTGorSlA4dDZPS3hTdVFiRUR4?=
 =?utf-8?Q?IeP6i26get5MIsU6YGDoVsMrg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f562eded-aaed-4f89-bcea-08ddcedc9f46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:15:12.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTdiJONxYTKfTzqqeRVMWLzp4qzBJvo1gqYXLrWwH8UTxOuADWOpSRA78ydciz4CqSycglkZwEknbH2i5Q3vDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
Received-SPF: permerror client-ip=2a01:111:f403:2407::609;
 envelope-from=francisco.iglesias@amd.com;
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

On Wed, Jul 16, 2025 at 11:54:04AM +0200, Luc Michel wrote:
> Add a way to configure the MP affinity value of the CPUs given their
> core and cluster IDs. For the Versal APU CPUs, the MP affinity value is
> directly given by the core ID.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 5a08ad07b28..35c32de0159 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -88,10 +88,18 @@ typedef struct VersalCpuClusterMap {
>      size_t num_core;
>      size_t num_cluster;
>      uint32_t qemu_cluster_id;
>      bool dtb_expose;
>  
> +    struct {
> +        uint64_t base;
> +        uint64_t core_mask;
> +        uint64_t core_shift;
> +        uint64_t cluster_mask;
> +        uint64_t cluster_shift;
> +    } mp_affinity;
> +
>      enum StartPoweredOffMode start_powered_off;
>  } VersalCpuClusterMap;
>  
>  typedef struct VersalMap {
>      VersalCpuClusterMap apu;
> @@ -196,10 +204,15 @@ static const VersalMap VERSAL_MAP = {
>          .name = "apu",
>          .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
>          .num_cluster = 1,
>          .num_core = 2,
>          .qemu_cluster_id = 0,
> +        .mp_affinity = {
> +            .base = 0x0,
> +            .core_mask = 0xff,
> +            .core_shift = 0,
> +        },
>          .start_powered_off = SPO_SECONDARIES,
>          .dtb_expose = true,
>          .gic = {
>              .version = 3,
>              .dist = 0xf9000000,
> @@ -565,23 +578,31 @@ static DeviceState *versal_create_cpu(Versal *s,
>                                        size_t core_idx)
>  {
>      DeviceState *cpu = qdev_new(map->cpu_model);
>      ARMCPU *arm_cpu = ARM_CPU(cpu);
>      Object *obj = OBJECT(cpu);
> +    uint64_t affinity;
>      bool start_off;
>      size_t idx = cluster_idx * map->num_core + core_idx;
>      g_autofree char *name;
>      g_autofree char *node = NULL;
>  
> +    affinity = map->mp_affinity.base;
> +    affinity |= (cluster_idx & map->mp_affinity.cluster_mask)
> +        << map->mp_affinity.cluster_shift;
> +    affinity |= (core_idx & map->mp_affinity.core_mask)
> +        << map->mp_affinity.core_shift;
> +
>      start_off = map->start_powered_off == SPO_ALL
>          || ((map->start_powered_off == SPO_SECONDARIES)
>              && (cluster_idx || core_idx));
>  
>      name = g_strdup_printf("%s[*]", map->name);
>      object_property_add_child(OBJECT(qemu_cluster), name, obj);
>      object_property_set_bool(obj, "start-powered-off", start_off,
>                               &error_abort);
> +    qdev_prop_set_uint64(cpu, "mp-affinity", affinity);
>      qdev_prop_set_int32(cpu, "core-count",  map->num_core);
>      object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
>      qdev_realize_and_unref(cpu, NULL, &error_fatal);
>  
>      if (!map->dtb_expose) {
> -- 
> 2.50.0
> 

