Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17828C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaiL-0005qO-G8; Thu, 31 Jul 2025 17:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uha9j-0007eQ-NX; Thu, 31 Jul 2025 16:45:46 -0400
Received: from mail-bn8nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2418::622]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uha9g-0000zB-SB; Thu, 31 Jul 2025 16:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV+cwunvpNwsqH3Reblo2dfDovIdikMUDM3RI+LBgJJOZQaR9ZCcAWOkFVnHnrb9S917l43WrvZpye0/jWQ4lHlyOLlU9iSa7/gWAXqysdQyVStjEoFQkmLh6cqcqnNv0H43IH5aRClh1lYr1N8zhUn5QubRMzoGHXoIfZ1SxF1O7TJSisj3yty3uTkaEavntwbMwa9azB6N5n6/knetU1aN+6UMyJmFltEOltGuYFsV/0h0OfldO4oBHu2ER4qAko08ZVoGBl0veBmqaCRk2l/IwO6IWcTGE7qL7qlSMOr9hWJOA6RYhoHjloTzXQCKVDChqwJnhGMOnAk2bcpK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpFh451cPmXPC09GC/6+LpSyT71yI7AaAY3/e9v+cNg=;
 b=GA3HlbYV2e4WfEYFtB7E8zKbmie74alMiuiC4hxU66keOo9DOMrZ/yqEM68U+OgOgU5eSWrSX24KUYJBlvs++9k/aqQJmrGt3Tq0KTa1AMN73EApzQbidztZ0OoZQGsmaBfjPhKkJi7v9IJtWcui0w9eiF/hAbRm4dldPx6PUgsYI6X+Qo5WDoiFEKSarq2Kbm+dhKTuwGyi23LNreuqEs2HoNyydfKaIrO3YXfdfTiX0tM+jkOachxhikjLITILyL8dqbp+9WWgDV0dXwe8oqTEsL31nVTxcowH2nGdfGrNdPsbaO073NwyqXIwkzL8XXlTPu0nroUTUKZlpx36xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpFh451cPmXPC09GC/6+LpSyT71yI7AaAY3/e9v+cNg=;
 b=muz2KQonBnsZ+imP2aX6UsincxSzB2j138SEpbvYRXC2Bv3TFhzJzkQStiXt7lKKTePg5q5/GjMw2N6m1EG1GsdylYvwFsqZtrzS3utRTRv3Mb9sp65T542r0i77dbgNO3+4JqzRgDAlidM5niuwv0olpQPtcxumEsW1vO6yqVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 20:45:31 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:45:31 +0000
Date: Thu, 31 Jul 2025 22:45:24 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 42/48] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
Message-ID: <aIvV5NiaiRIWYXNh@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-43-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-43-luc.michel@amd.com>
X-ClientProxiedBy: LO4P302CA0012.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: cde1e195-fa1f-49e5-3de6-08ddd0733092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBpekIxRHlsdTUwL1BwUTEwdlhBWExIbVg3aU54dzRndVNXMlZMSUIzWnYy?=
 =?utf-8?B?TE9BdDE3MllYbC9sdUJ3MytqL0ZDS3Y1K2lzNXNsRWl5Rm5pekJRRjcrTEpC?=
 =?utf-8?B?dWlSd2pCVnJ4aVAyWVJsZkZqY052K21zNVBFVGpORHRBbmVkVG5ZcEw0d2Vt?=
 =?utf-8?B?VXZ0MEM2NDM2RjdqcFE1Z0JBV29kYmh3ZEIvVStvK1JWK25kOVhXSXNnK2Jj?=
 =?utf-8?B?QUxJQ0kyZStNU0J1QjlkYUVvN05yM0dYVFlsd1NSSVgvME5ZbU50eC9GbGM4?=
 =?utf-8?B?aGJtemNUUGY1TWtOR3lQUFlZbmF0bzU2c1Z5VmJDOCtTWEdlMTNOaXIrdkdP?=
 =?utf-8?B?OHNXVnlIUlcxNTZDbmxobmZ3VXM0N0tIOEpxNkw2Z2FUdFUzL1g4dTVrRVla?=
 =?utf-8?B?M0d5SkEvT0FjcFpQT0d1eXd3eUpidjRzS1dVcWE2Tjk5ZUhRV3ZDT2pkbXBs?=
 =?utf-8?B?c1d5NXR6Q05BMWFPSnFIaTZtUlJHaWhCeHFLNTBGVlJTMURXaytRMG9Ec0NU?=
 =?utf-8?B?aVU4aFJySlZEeUdTdUtKY0JwcVR4TWZLdlk4Y3NBbUVWU1ROK1RqM0JqZVZU?=
 =?utf-8?B?MGhjN0hYTDVtSllTQ2hkMzRRci9FRFhTblFRdkswN3lpRWRGcSszZ0RBNTgx?=
 =?utf-8?B?ZVFBTG1XT0o3dFdWQVJpTENWZmtOL3ViYlFnTVlxcTFxWk1Ta2JaWElac3FV?=
 =?utf-8?B?WE9wM1lvNVhJZytwYktFdWZoS0tyYWRva283MzRUbmd5aklrU3UxczI0YStH?=
 =?utf-8?B?eGV2bkxtZUNqQkptVCt6MW9CbFQ0Wlg3TUxjSGV0N1FUL0dQL2pNZ2c1VjUw?=
 =?utf-8?B?Zjg5NW1LcmZjV0p4QzNuV2VVWWcrWTRPWGNCZ05JbDlkeENGendqLzZSck5G?=
 =?utf-8?B?R1ZDZXdRUHhWMmhiMTMyTk1YRTlraUJMRjdJS2x0K1NBQVRVRHJaNHFFek92?=
 =?utf-8?B?RGlueVpJZFVXN2FyRlNqWW9OSUtOdGxWVll5OVdVUkw1UTNJQVVKNEFMMjA1?=
 =?utf-8?B?NkRvL0hKV2FwS0lENjJkVHVmOGpTVDM0dE03Z1V6RWxncUwyYmpteDFuMlBi?=
 =?utf-8?B?M1ZQK2xJS1VhamtQNHRKcXl2UnRZOUNOZXpNeTh0UVU2N3RvQmZMMzZ5aDVh?=
 =?utf-8?B?TS9ycDdlZkloQWdmYUZyOG1Gd2VOTlVTQWVNQUVkL0t1Qmw4ZnRhU3VCRHZJ?=
 =?utf-8?B?ZTJRVU5BbDQ1QWdXWGtsZklGa011ZUYxN3lIUVNTT2RBRUFTcGRtVUNkdUl1?=
 =?utf-8?B?c2RiS0tuam9KWlZodURhbVk4amZOMGp6UGhncFFYd3NqNUV4UHpwS3ZTc2hH?=
 =?utf-8?B?M3lYZGlwdjJVc1R6dy96QnJyWktQTWlRTUJ2dEsrZ0RzTTExT1N0d2ZMWHpN?=
 =?utf-8?B?UG4vMStiQWYzc1c1eTdqOFhBOHBXUm8rZW1DaG5Nc3Y4VlU5OThZVFZuU1R1?=
 =?utf-8?B?emMzaU9qMEgyd3dDTjcyTTMvSllvaXRXQVpEY2dVdkVyUWZ3THBTT0NTblVa?=
 =?utf-8?B?czBzTUlqWE5nOWVwYk5Hamo4eXlyTEJBTEg1OXNTUElzTnZZK2N0d3hscG1C?=
 =?utf-8?B?T005V09helVTbnlGR25KbjMwc2R3eFgzN2RBcGt1WkR1RnNYNDBYUmNLTHB3?=
 =?utf-8?B?TWczZnNpSXZKMzVlb2pVUFI5UExvR0huK2tHQTUzd3JZMWZ6azhpWXcyb3hR?=
 =?utf-8?B?Mm1vZExhZmtkVUo4dFVyMTF0c2k4Sk45eDZJWVQwY2kvN09sNHkrQkVjL3hS?=
 =?utf-8?B?WEhxcjR1VmEzOFowaUhNVHZOZGtBY3UzRUxPZGJBSTBOSExRZVFkVFJINndz?=
 =?utf-8?B?V0tYcGgrSWlCNnhJMEFKZmJsVFM3RUg5ZHVjOGJKOGhEc3A3aWhVWFFVWTdi?=
 =?utf-8?B?MmVsdWk1eDRrTmlBNmJLeUwyQnA1aGRSYTJnVlc5cW5HZ1VlSXlrVEI3NU43?=
 =?utf-8?Q?yk1yQv5vVngkBNoEvq65XYzMA7mbcCCU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXF3bk1pUWNrckdjVk1JcTd1SHd1RDlHSUQ2cnRnU294dlFhcmplK014MGh4?=
 =?utf-8?B?Y1lETzIrVFU2bUJzeEtudktETkZQVVpuNUU5NHBBbW5lZ2tRaks3clI4WWht?=
 =?utf-8?B?WkRTdExuZlkwTlVrTjFFZ09kbkxkUHpzUmp0Q0NMNmdSUHVGSHFQZ1EzSVMr?=
 =?utf-8?B?d1NIT0ppRU8xS1ZpRTZpVERkNXloZW9Jd2xxNm16WGZDOE56M05DbWlGMDJ6?=
 =?utf-8?B?b0taYmtqTXBhdTN1Y2d6THBWWldHTWVWT2xXMlduVkNmOXhqcE81RUFEWGZ5?=
 =?utf-8?B?NVhTVmpPSUlad2U2VzRqS05kNzdlZkM2S05pTlpnNGtFNG9YdGF2T1dLb2Z6?=
 =?utf-8?B?bnlVcFNLVmovdjd6V0VSV1psNmEvWDhjZyt3Z05la3UwY3JSNGhibTQ1RDVK?=
 =?utf-8?B?RFRLWG1tNWpJamZwcXYzUXlzcnduOFNYY1RlSzY2YXVXblI2SWEwemVkOFln?=
 =?utf-8?B?dmFtOWZwU0djY1ZVUGlJSVNPb0p3NnFJMmtoc2RaeHFQU3p2aTl1QUdYV2F6?=
 =?utf-8?B?MmpTdVhVMnVvNHlSOStYMmtLT1pRSDA0ZzdtLzVXVXhMM0R3OVhhUThtQytW?=
 =?utf-8?B?Z3ZrZzJGcmJiNzNtZ2NLbkprSy9Rd3NxZ21GbWkrM1plUUd1YWh4L0kwWXQy?=
 =?utf-8?B?TmZSY01NaVJucHlYYm1kckY0V3JSaUhMcDhYOWl1enlqZVV4eHhPUnArZFNm?=
 =?utf-8?B?NThldi9HbW5XKzVlRXVja0VTbXF4elA5enYwRmkrY0g2elBjSTFtSXNRNjRk?=
 =?utf-8?B?SzVkWnIrZmx3UWtaY2RXV2dDTGNlNDd4VmM4em4vRnhWbkk2RFYrcHhpRWxw?=
 =?utf-8?B?cW1nK1QwTkh4Z01HNEFDa3hMNm1UdGlmUlZlUUhIeEdUdWZHNTdiSW93alls?=
 =?utf-8?B?SVlaUHpxWWR3eVZZbUlGYkVQc1orUE9lQytyeVdoQ2dEWjNPNjliNzVJSE5x?=
 =?utf-8?B?ajVISHhpYnRCS2ZNZU82YndwVFNldXRUYk9QSFNZMTN4OEVjdTBMQTJTdnhu?=
 =?utf-8?B?VDc5RFpOalQzNEVXUkNGZGV3Z0NtcXBPNU9XUVJFMVp5S2J6Z0RGemFQblo3?=
 =?utf-8?B?ZmwvOXNNYTRPNHp6NEMyMWkyd3huc2ZhVytWT04wWE0yMkZxS2l6MmVheTYw?=
 =?utf-8?B?aGJzQjFFZGF1TXFtWEtVYVBsQWVQNHNzUk80aW0rbFNWNG9RKzFOMGFuQ0xn?=
 =?utf-8?B?TXdjZmhGV1FFQWtkOFhBdFJ5aUNjZlJVSzhXUzNMWWFjZnoyY3JEU29oQVV6?=
 =?utf-8?B?cUdPcUpRUGZ5aWNIYjg3QmU1Z0IwQTlaWHErb0VuOVUvblJtZ2E0RzBvMnVx?=
 =?utf-8?B?RllLMEhNQUFmZEtjdGcyYzliSlFZbHVKc0NKZ1JUVkoxcXdkakkyMm5ab0Jh?=
 =?utf-8?B?bnRmMHdjdy9mc3NCN2ZsYzBSMGFRWm92VGhVWGFpeFcwNnhqR29IaytTbEpZ?=
 =?utf-8?B?VS8zcDloNkNPOHYrd1p2VWd1MzRPcitHMHBQdjF2UDJMUFNKcXZIWUtUMkNa?=
 =?utf-8?B?T2Z6cUd0VGs0VUZNb1NEeCtrSk1aWWUrRjhMS3BKQmFhcFI3MHFjdEQrUGQ4?=
 =?utf-8?B?eGR2UkExRkxVczZScW81ZmlZQWJWUFlVd1RCc1hQc04vazNrRjFvdDloZU5o?=
 =?utf-8?B?dkh6YkhibTQvbXovTTVZSjBvWjRvS2M2anVtMUZqL2tJcFVxVnNuK2xhbjd2?=
 =?utf-8?B?YWo0KzJ3N1dVUEh0Y1I0Vi9PZzdpRU5ROU5wOVlGU1kzT0YzZmhzNzBkWVhD?=
 =?utf-8?B?VDBFYzYzTEhRc0RQWWJhSFY3TWQ3WkkzTGxWd1hFb0FXblBVZHVjR2NqQzk5?=
 =?utf-8?B?RTU2a0JwWjFlR2RTdEZraVlWd05TK3kzV29aY0pqNzRCR2pYdlJ5OXVQdVVp?=
 =?utf-8?B?ZnpjWlpOa1pkV3RiSlRFQk1FQ04rK0s5M29Va3cxMVQ1L013eWFYTEdzczI5?=
 =?utf-8?B?OGQ1NVFJNkZFZWZSN1JGRGJYelhpNmhiTWIrbmNUcEtiS2RKSVVaSTIvbWc2?=
 =?utf-8?B?NGJsSUpPMCtkWW1zUXRyQVc3UUxmZGdiZlNuV1B3bXhnQmxWZFhsNGsxWmxn?=
 =?utf-8?B?U0ZaTFVNalhUcE95MWxwL2VqdWtnNkFPOTlMdlFnbHRkMVRDRDRxM1RxTnhR?=
 =?utf-8?Q?6ImkZZ2dqEG5MR7DCurebkUQX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde1e195-fa1f-49e5-3de6-08ddd0733092
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:45:31.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyOkvSerwNPYFzlx5eIiA5dm90D52ii5jJT2HFSPGTsw/ME67o6Tek074co6KA/XOh/48N4UX1Y22pys+vhkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
Received-SPF: permerror client-ip=2a01:111:f403:2418::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:24AM +0200, Luc Michel wrote:
> To align with current branding and ensure coherency with the upcoming
> versal2 machine, rename the xlnx-versal-virt machine to amd-versal-virt.
> Keep an alias of the old name to the new one for command-line backward
> compatibility.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 26 +++++++++++++++-----------
>  hw/arm/xlnx-versal-virt.c            | 11 +++++++----
>  2 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index c5f35f28e4f..2c63fbf519f 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -1,21 +1,25 @@
> -Xilinx Versal Virt (``xlnx-versal-virt``)
> -=========================================
> +AMD Versal Virt (``amd-versal-virt``)
> +=====================================
>  
> -Xilinx Versal is a family of heterogeneous multi-core SoCs
> +AMD Versal is a family of heterogeneous multi-core SoCs
>  (System on Chip) that combine traditional hardened CPUs and I/O
>  peripherals in a Processing System (PS) with runtime programmable
>  FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
>  
> +QEMU implements the Versal Series variant of Versal SoCs, with the
> +``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
> +backward compatibility.
> +
>  More details here:
> -https://www.xilinx.com/products/silicon-devices/acap/versal.html
> +https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
>  
>  The family of Versal SoCs share a single architecture but come in
>  different parts with different speed grades, amounts of PL and
>  other differences.
>  
> -The Xilinx Versal Virt board in QEMU is a model of a virtual board
> +The AMD Versal Virt board in QEMU is a model of a virtual board
>  (does not exist in reality) with a virtual Versal SoC without I/O
>  limitations. Currently, we support the following cores and devices:
>  
>  Implemented CPU cores:
>  
> @@ -72,11 +76,11 @@ A few examples:
>  
>  Direct Linux boot of a generic ARM64 upstream Linux kernel:
>  
>  .. code-block:: bash
>  
> -  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
> +  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
>        -serial mon:stdio -display none \
>        -kernel arch/arm64/boot/Image \
>        -nic user -nic user \
>        -device virtio-rng-device,bus=virtio-mmio-bus.0 \
>        -drive if=none,index=0,file=hd0.qcow2,id=hd0,snapshot \
> @@ -85,11 +89,11 @@ Direct Linux boot of a generic ARM64 upstream Linux kernel:
>  
>  Direct Linux boot of PetaLinux 2019.2:
>  
>  .. code-block:: bash
>  
> -  $ qemu-system-aarch64  -M xlnx-versal-virt -m 2G \
> +  $ qemu-system-aarch64  -M amd-versal-virt -m 2G \
>        -serial mon:stdio -display none \
>        -kernel petalinux-v2019.2/Image \
>        -append "rdinit=/sbin/init console=ttyAMA0,115200n8 earlycon=pl011,mmio,0xFF000000,115200n8" \
>        -net nic,model=cadence_gem,netdev=net0 -netdev user,id=net0 \
>        -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
> @@ -98,11 +102,11 @@ Direct Linux boot of PetaLinux 2019.2:
>  Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
>  version of ATF tries to configure the CCI which we don't model) and U-boot:
>  
>  .. code-block:: bash
>  
> -  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
> +  $ qemu-system-aarch64 -M amd-versal-virt -m 2G \
>        -serial stdio -display none \
>        -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
>        -device loader,file=petalinux-v2019.2/u-boot.elf \
>        -device loader,addr=0x20000000,file=petalinux-v2019.2/Image \
>        -nic user -nic user \
> @@ -123,11 +127,11 @@ Run the following at the U-Boot prompt:
>  
>  Boot Linux as DOM0 on Xen via U-Boot:
>  
>  .. code-block:: bash
>  
> -  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
> +  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
>        -serial stdio -display none \
>        -device loader,file=petalinux-v2019.2/u-boot.elf,cpu-num=0 \
>        -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
>        -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
>        -nic user -nic user \
> @@ -151,11 +155,11 @@ Run the following at the U-Boot prompt:
>  
>  Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
>  
>  .. code-block:: bash
>  
> -  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
> +  $ qemu-system-aarch64 -M amd-versal-virt -m 4G \
>        -serial stdio -display none \
>        -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
>        -device loader,file=petalinux-v2019.2/u-boot.elf \
>        -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
>        -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
> @@ -225,11 +229,11 @@ To use a different index value, N, from default of 1, add:
>  
>    Thus, a file backend should be used with caution, and 'format=luks'
>    is highly recommended (albeit with usage complexity).
>  
>    Better yet, do not use actual product data when running guest image
> -  on this Xilinx Versal Virt board.
> +  on this AMD Versal Virt board.
>  
>  Using CANFDs for Versal Virt
>  """"""""""""""""""""""""""""
>  Versal CANFD controller is developed based on SocketCAN and QEMU CAN bus
>  implementation. Bus connection and socketCAN connection for each CAN module
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 5e47a20922a..daacbfb984e 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,7 +1,7 @@
>  /*
> - * Xilinx Versal Virtual board.
> + * AMD/Xilinx Versal Virtual board.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
>   * Copyright (c) 2025, Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
> @@ -24,11 +24,11 @@
>  #include "hw/arm/boot.h"
>  #include "target/arm/multiprocessing.h"
>  #include "qom/object.h"
>  #include "target/arm/cpu.h"
>  
> -#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
> +#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
>  OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
>  
>  #define XLNX_VERSAL_NUM_OSPI_FLASH 4
>  
>  struct VersalVirt {
> @@ -53,10 +53,11 @@ struct VersalVirt {
>  };
>  
>  static void fdt_create(VersalVirt *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
> +    const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
>  
>      s->fdt = create_device_tree(&s->fdt_size);
>      if (!s->fdt) {
>          error_report("create_device_tree() failed");
>          exit(1);
> @@ -70,11 +71,12 @@ static void fdt_create(VersalVirt *s)
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>      qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
> -    qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
> +    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
> +                     sizeof(versal_compat));
>  }
>  
>  static void fdt_add_clk_node(VersalVirt *s, const char *name,
>                               unsigned int freq_hz, uint32_t phandle)
>  {
> @@ -346,11 +348,12 @@ static void versal_virt_machine_finalize(Object *obj)
>  static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
>  
> -    mc->desc = "Xilinx Versal Virtual development board";
> +    mc->desc = "AMD Versal Virtual development board";
> +    mc->alias = "xlnx-versal-virt";
>      mc->init = versal_virt_init;
>      mc->min_cpus = num_cpu;
>      mc->max_cpus = num_cpu;
>      mc->default_cpus = num_cpu;
>      mc->no_cdrom = true;
> -- 
> 2.50.0
> 

