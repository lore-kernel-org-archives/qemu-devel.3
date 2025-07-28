Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55573C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 20:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugUoH-0007m7-Bd; Mon, 28 Jul 2025 16:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUns-0007WY-Mv; Mon, 28 Jul 2025 16:50:38 -0400
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2407::600]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUnp-0007cX-IV; Mon, 28 Jul 2025 16:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBBauMwzLYmvOLd7YTsb+6LjhvsQUbR8s4vw6QuZk6ULWuJncB18b8GG+ObgMpxeMNLL+fRxxgqD1s6vqZ6oXTvd8g/Vad+97Vvy55mXwzF2S3cRuTovMIqPW6MfbgIxINWr5XDM7E4R31TMGKDRZ2f9rX0bMSoXpmZr/VOrUBCrFyvrIHi5VDdq04GxlaCAXmbm38wabTgn7EimI5L8/UeAf4m7GQhFhKaHJMgz1yguzppeY34ilDoj7kbE2Cdg1NxWFezbUlXc/0qsmZh7XThCzpMmjGy0kQNHckwuLpLLbKHOgbeK/OFSeHMQroW7TF6ENR7mi4AtGMYZpo7l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivE5AD3/QxEK3lXZ2st+wo39s/DpVAl+u5RsxZySS+w=;
 b=MZF09/yRYgJw/QGMknnVyAoqTCg5ZHFeo4AqGqFhU9rRJCPHl+YETLPhGv5ZeIR8mvn/A1STKpkmCCnoDNwQu6OM2ZnJHKJPu84ypD3DsqM56UHOOrNPqkQjAL6Tb8u+Eg/Aje8hn+FdhxXUWRDxiPwHkKyZqeKxI8PxC064Jrg1+mfZbUOkSqo4HWS41XPs+P/jSIZfckmVZrtLM6lnV1OFEKSVsoikeowfWKZyovzF5lT0JGhi7pvYTUBA72vPkzLht52xcXHPP0fvJx5/jTKUKbmWTBNMNo3IyVc5+xm0M4QV161cxdMiWjleRKisOjXtAYwZbPi1oecvsb6Ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivE5AD3/QxEK3lXZ2st+wo39s/DpVAl+u5RsxZySS+w=;
 b=HJb43Gn9GefGg5fDOExHT0BLqL6agr+t9KzhRdrdWd1B8QoxPqJhWDmnl/51YAwXxA3yAZiWzb5RKwRqDbuiymPRKb5KNnyo0YBQ/WWMckNhAALJ9IHnP4zhZQ2ToiTm54Ek/e2p4MpVTrLKwWbeiNMYsfWV7Sevt9WzMpNdG4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 20:50:27 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 20:50:27 +0000
Date: Mon, 28 Jul 2025 22:50:20 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 06/48] hw/arm/xlnx-versal: sdhci: refactor creation
Message-ID: <aIfijIAuTN+uDAsb@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-7-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-7-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: bd38ae25-ae07-43db-3fdd-08ddce18618c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VFU3QwZkQ3UUFjemFUdXJpdWpmRzllNGNYa0g1SXBDZWVRODZETVJsVDFR?=
 =?utf-8?B?QkI4UkVVV2pxNnRLM1ZzYlJhLzNjaGRGYVgyRmJPWkhXNDBDQ0dRdStpSVN2?=
 =?utf-8?B?dGd1VzRaaGJpNUtuWjBUSm1pNVdGT3Q2Y3llUmVQQTNVdFpHOWNHNjFIQm5r?=
 =?utf-8?B?QndDdno4clA4SW9PZVlBWkljL1BPUnM2Q3RsemsvNmlwbFBNMG9RVmllY1VD?=
 =?utf-8?B?S0VyYkhVc3dPUkJSVEhhN0hFNmNKNkRsVy9heVBRdTQwZnhERnFOclhFMm5K?=
 =?utf-8?B?a0R5SHhKWkhKQmlSbmwzQVc1M09aYUJNUWtFbzdUUDlmNWFycy94bS9zSkM1?=
 =?utf-8?B?Rk5LQWV6MjNkdVhicHZUUUNheXlJV3JzTmNUZE9TMnU5bG9aeWd5RFJJUTc5?=
 =?utf-8?B?OVNPeVZqSW5OcmJCcVFVckhmczBKayszU0NSS1VVMHBrcFBUUkFpNU9EVTFz?=
 =?utf-8?B?ZkF2aHA3aUMvM1dnZHNKZ2RKb0gyWmRrYTJRZ1ZkRzYxSVVXeVFDR3lYTytC?=
 =?utf-8?B?UndmaHpnZFI3R0s3bVhidFV3L2ZiVnBwZVlpT3dENGJHcTJISGtuZlo5WnhQ?=
 =?utf-8?B?dXJZREZtMHcrVmprODVtQnl5dkJ6elFuZ3psM05rMmVEMlBJQnZxLzVtMTkv?=
 =?utf-8?B?VG9pcW90UjVxT0g0THRPSnF0Q1RLRVZta3lDZkw3UDM4VzlrMWZSOGFyTk9T?=
 =?utf-8?B?aU9pZFB6T2RqMFJzK1VLOHEvcEhmalk0c3FjNWM5bE50Y2c0UmZaZ0lFQ3Vr?=
 =?utf-8?B?N2VzdGIwSmJCQjRWc0hhTnZwSW1CVmdNZUhKQmE3QWsvbzdkQzc5Q3poMU9t?=
 =?utf-8?B?MkVOQlE3SHBKSUt3bHpoRzk5WkhuQWZ4TVAyOW8rZHpENlhYYUF2Y21WMUhm?=
 =?utf-8?B?Q08zeGI4aHlhN1ZzYmxjQXVPcTF2TGI1d28wZE5BenZVRnlRelgyOVA0a1VT?=
 =?utf-8?B?SFVXc3VzTUVTNFFFTnVmcmo3dkVEY0M3c2RJNU1rZnRjQWsxb3pRSmJ1dWlH?=
 =?utf-8?B?L2FqVGdHVVlHMjN1cFpneXRQcjhqSlFjRnN2eXAyaTV2Q2twOG1CZ05jakxR?=
 =?utf-8?B?bVFPSTQrQ1prMFRnRXFSOVYwekZ1c1NOdWlPK0JnempZL0NqcWxpMVg3T0JS?=
 =?utf-8?B?S09kR0dDT2Q0SmZsaWNzTXZ6MTFjaXpQUFB1Q0hpZ1hxVktKMEtpMzgyZTYw?=
 =?utf-8?B?ejBzN3VacjRWR29uTENueXJDZmdEak5Ra3R6WncvR01VUFVyVk1uN0ZKZ0tZ?=
 =?utf-8?B?ZC91cTVvZThYQkRIUU83OW5wQUpHSHpBMzJVYURsZDZhV1RjYTVkRGtXRFNr?=
 =?utf-8?B?ZWlLMjVieGFmVVFab3VqMCtYY05PanEraDhGRyt2TmFMbFA0QjU5Znp0T3RZ?=
 =?utf-8?B?MlM1WGFJOXpRRXZjK1R0Q3dON1h6elY4N0srVHB0bTYzdWJ4N1Q0WFBsNDdO?=
 =?utf-8?B?VXNGSmgvaEJ2RjlRcjVtK25QTDJJcDlHZHduVTdvMXpsRDhZcHV2SUt3L1FO?=
 =?utf-8?B?a1lvYWgySXpGQ1M0TGVqcW9iOThPQ20xbzZaRnNKdUFjOG1jNFNaeXhFaHAw?=
 =?utf-8?B?S25ZMjFHMGllTTkzVDdoQkt5amRmRzQxUUFzMzZEV3dOSGtjUDJNLzF4ejEr?=
 =?utf-8?B?VVBrQnczdDBaS0Jxdko4MjJCN3R2N3Q4eDBQSXM4eHBJakFidEd4NXprWHFs?=
 =?utf-8?B?Q1lNN2U3ZE5naDJBT0N2bDJiSXpENkQwOW8xRVU1eW5PWlhTcHNCTlFIQllL?=
 =?utf-8?B?dXFlOExyYWhXS2JnNVdac0dPeC9FRUZpQ285MllzbHNnR0JRakpZYnZQaTF2?=
 =?utf-8?B?T01vR1hFUWhyUGpNSUpqKzNuUXFqc3c3cm04SjNlLzh0aWtGVitlYTF1akto?=
 =?utf-8?B?WDgyNERGK1hQUG9BdU1mdXlHMjYxMXZXKytONEJab2s3c3dXdkRvMzNhUHZl?=
 =?utf-8?Q?bTJeP1goIjA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkE1SGlHVGMyM01idnpmQmZwa2ROUXlHRXdmb3R2RmtFSEV4aFlLdy9acTJk?=
 =?utf-8?B?dzBrd3MxUFF3c3FEZExkb3NOS3ZlbGNtcFZ2MTNvd0JCVDhzQ3Z4MXFlYzln?=
 =?utf-8?B?OVRJNmJnT2VScjhEUUs5WUkyUG4wbVh4V21ncjZwMnRTTTYxdFpFa3N5M09N?=
 =?utf-8?B?bHI2U0RMSXY2Uml2NWxLa0hGR1FMa2ZzeXBCVloxcGVxN1RoQUpZUDNSTzN6?=
 =?utf-8?B?OW56WXc3bkNHSm9DbFNsYks5YUlHcCtwUnRiQTQzNnBoK2FpZ2ZJNXdIM1RL?=
 =?utf-8?B?bGpaMXlvZCtJVlNzWC8rTTE1V2srTlRFcTFXUHBNSmVqTXNTWEEvSjZ5MWJv?=
 =?utf-8?B?SlVBUEhBakRDL0plTUN4OUZHTHBhVzY4djE4LzdwY0tISnlTY29sVHpXMHlM?=
 =?utf-8?B?ZGFWWE9wT3d2alhXTTdmNG8rL0IrK2ttL0t5TXM5a2tkcGU2dGx3OWNYL1lk?=
 =?utf-8?B?cVFBVkVLN2E1SzBFcXNOWVVvekdxTDlkekVSbUZjcnpGMnMxeml1bzFoOW5T?=
 =?utf-8?B?Zzg2Nk96NWpRcXZVcGFOZjdzaXo3aVJwcnp5THBRdXZTU0szcjMybDViRENO?=
 =?utf-8?B?TTBYbTZqclQ3Mmozdmc4cnFValIzamsxbzVSOWQ2MkFEbzZOSzBtdDNvS0xP?=
 =?utf-8?B?QkNIK1d6NzM5akc1eEt3dzNod0t6TWdwdVlmd08wYmwzazVRZFNFN2Q5d3BB?=
 =?utf-8?B?NS8ydFNXSmpuZzlIZGNUODlYYk1ZQlN5ZE4waXV1VnNER3o1dWIrY3haL2tl?=
 =?utf-8?B?YmVXNlA3UjVHQW9zR0FQcGxjY2VDZ3l0c2dnQ3pPQTBsK0lCZXFFUzBZNzBY?=
 =?utf-8?B?a1ZwRkVwblgyL1JRYlZWT2Y4dHh0OW4rV2NhNlRQMjlZUXVJdVo1WXh3SXBK?=
 =?utf-8?B?NlZ4a2ljZGNuWUZPNTZ3WXJXczhKWXB6NE96UEtjMkhncFh1dnhUQmx0aXp5?=
 =?utf-8?B?L1Z5ZXZRc0Q5eTZ1QXJuZTFLSGNmMmovK1lJUFJhSEJ5OXFrb1VyTWpVcGY3?=
 =?utf-8?B?VUtqUVNSVjR0Q2U5SHI1Z0xqVWxUUGVTRkdLRFhwNGgvWnFDUThLYjZPUkpE?=
 =?utf-8?B?b24ydllGTUVXOFNoT0Zrai9xbFVYTHZRYndZRUVtekN1WEpSb25lMStnNWFW?=
 =?utf-8?B?dDVoNkZhY0hzbTVpT0wyQUhPSktuZ1NFQkZpek1MRU0rNXZOSGl4WnIrUjRF?=
 =?utf-8?B?b2NGYWhMV3hHeWliSmx5MnNpWHlvRTYvMmxiSGdpUWUvYUphSkZ6QlB6Q21i?=
 =?utf-8?B?cXNPeEZYTE9UUmhZbk55TW1qS2ZnejZnZ2dMZDVFcVJLOHpHUm1CR3ZMNlhZ?=
 =?utf-8?B?UGp5SmExMVNJNHBlb2k4WVlaWGU0QU9GM3NubFlJclVobVhsZ1RRUzJNWmVU?=
 =?utf-8?B?SDhKaFQyWXdlcFhZUnZTMXdFSWRreWFPVDY4MDJYbkQ5WHZkK2ZRRVN2UENy?=
 =?utf-8?B?TCtBdHg3d01CbDQrTUx3b3N5RDNwYjhjU0dMWHNwV0NyS1dUbmdjd2dKV0k5?=
 =?utf-8?B?dlhPMyt2NkVkN1hMMkhnbHJFbjFZV1hDMXZCWDNTNlpYSEVraGErMUcrQWlI?=
 =?utf-8?B?VndCQUNnYndqZEs2L0VaNTZDNGlaQmJvV0NGVTE3K2RWOTJWdE5YYzJkdmhi?=
 =?utf-8?B?Z3ljQlQvVVdGcVF0d1NjZHRqZTk3ejRXRUw2NVZyaUFqNWJFV2QreDFUUk9L?=
 =?utf-8?B?WHNvd053NUhZR2tOTGtCbjAyRXgrRjdWNVlRaUhRbVlucHlNNkhDMFZMRjVa?=
 =?utf-8?B?YlNrcmxPTGl6UVZLOU1rRWJxbWZxVTNxR1pLVWtocXVoUGtiQUxiVXZrRDUy?=
 =?utf-8?B?MDBvSzY2dEtoZ1NOeUJYNjBrSHhNTDlEYitEajRHNWo3RmxPS0syV0pkSlhY?=
 =?utf-8?B?MktBemhDVE5lcCtCVXlqUnI4TjdYekhXOUdKZ3hxUkF1UHdpNVhCNVN5cmcr?=
 =?utf-8?B?SGJmK3p0MnNZUTNGWHU0Vk43c2lRcHFGWlNjcHBNbVlrayswMzhwM2E5ZFRW?=
 =?utf-8?B?R3U4am9WVStnTmFFR0FSK3MwRGN0bDl5bjN6dlYrdWlTMjh0RzJCc1YzbWpP?=
 =?utf-8?B?cGNsdU5OaEYvU1hCRHJrYkNvQ2o3bGdpVXczdDRrbjFVODU0Wk9CRFJkbGlX?=
 =?utf-8?Q?MjxJkFNId8/DavMUA8N43qDY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd38ae25-ae07-43db-3fdd-08ddce18618c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 20:50:27.0094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCMpEDTp3qIjwPNOVqEAWqQ4ntlDp+bcVJM5I+Hw2XyrLctGcZCRZDMCdwyrCiCTZCP8iPol8dwJwh5uvuuOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
Received-SPF: permerror client-ip=2a01:111:f403:2407::600;
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

On Wed, Jul 16, 2025 at 11:53:48AM +0200, Luc Michel wrote:
> Refactor the SDHCI controllers creation using the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  5 +-
>  hw/arm/xlnx-versal-virt.c    | 43 ++--------------
>  hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
>  3 files changed, 83 insertions(+), 61 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 007c91b596e..4a7a2d85aac 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -14,11 +14,10 @@
>  #define XLNX_VERSAL_H
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
> -#include "hw/sd/sdhci.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
> @@ -103,11 +102,10 @@ struct Versal {
>      } lpd;
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
>          struct {
> -            SDHCIState sd[XLNX_VERSAL_NR_SDS];
>              XlnxVersalPmcIouSlcr slcr;
>  
>              struct {
>                  XlnxVersalOspi ospi;
>                  XlnxCSUDMA dma_src;
> @@ -154,11 +152,14 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>  {
>      g_assert(!qdev_is_realized(DEVICE(s)));
>      s->cfg.fdt = fdt;
>  }
>  
> +void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
> +
>  int versal_get_num_can(VersalVersion version);
> +int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 18a3ea169d0..99ce84d5a46 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -282,36 +282,10 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
>          qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
>          g_free(name);
>      }
>  }
>  
> -static void fdt_add_sd_nodes(VersalVirt *s)
> -{
> -    const char clocknames[] = "clk_xin\0clk_ahb";
> -    const char compat[] = "arasan,sdhci-8.9a";
> -    int i;
> -
> -    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
> -        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
> -        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
> -
> -        qemu_fdt_add_subnode(s->fdt, name);
> -
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addr, 2, MM_PMC_SD0_SIZE);
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
> @@ -562,20 +536,15 @@ static void efuse_attach_drive(XlnxEFuse *dev)
>      if (blk) {
>          qdev_prop_set_drive(DEVICE(dev), "drive", blk);
>      }
>  }
>  
> -static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
> +static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
>  {
>      BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
> -    DeviceState *card;
>  
> -    card = qdev_new(TYPE_SD_CARD);
> -    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
> -    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> -    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
> -                           &error_fatal);
> +    versal_sdhci_plug_card(&s->soc, idx, blk);
>  }
>  
>  static char *versal_get_ospi_model(Object *obj, Error **errp)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> @@ -643,11 +612,10 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_gem_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
> -    fdt_add_sd_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> @@ -666,14 +634,13 @@ static void versal_virt_init(MachineState *machine)
>      bbram_attach_drive(&s->soc.pmc.bbram);
>  
>      /* Attach efuse backend, if given */
>      efuse_attach_drive(&s->soc.pmc.efuse);
>  
> -    /* Plugin SD cards.  */
> -    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
> -        sd_plugin_card(&s->soc.pmc.iou.sd[i],
> -                       drive_get(IF_SD, 0, i));
> +    /* Plug SD cards */
> +    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
> +        sd_plug_card(s, i, drive_get(IF_SD, 0, i));
>      }
>  
>      s->binfo.ram_size = machine->ram_size;
>      s->binfo.loader_start = 0x0;
>      s->binfo.get_dtb = versal_virt_get_dtb;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 5dccf231942..b963a05935b 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -26,10 +26,11 @@
>  #include "target/arm/gtimer.h"
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/char/pl011.h"
>  #include "hw/net/xlnx-versal-canfd.h"
> +#include "hw/sd/sdhci.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -45,20 +46,27 @@ typedef struct VersalMap {
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
>  
>      VersalSimplePeriphMap canfd[4];
>      size_t num_canfd;
> +
> +    VersalSimplePeriphMap sdhci[2];
> +    size_t num_sdhci;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
>      .num_uart = 2,
>  
>      .canfd[0] = { 0xff060000, 20 },
>      .canfd[1] = { 0xff070000, 21 },
>      .num_canfd = 2,
> +
> +    .sdhci[0] = { 0xf1040000, 126 },
> +    .sdhci[1] = { 0xf1050000, 128 },
> +    .num_sdhci = 2,
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -71,10 +79,22 @@ static inline VersalVersion versal_get_version(Versal *s)
>  static inline const VersalMap *versal_get_map(Versal *s)
>  {
>      return VERSION_TO_MAP[versal_get_version(s)];
>  }
>  
> +static inline Object *versal_get_child(Versal *s, const char *child)
> +{
> +    return object_resolve_path_at(OBJECT(s), child);
> +}
> +
> +static inline Object *versal_get_child_idx(Versal *s, const char *child,
> +                                           size_t idx)
> +{
> +    g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
> +
> +    return versal_get_child(s, n);
> +}
>  
>  static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>  {
>      return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
>  }
> @@ -422,36 +442,43 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
>          g_free(name);
>      }
>  }
>  
>  #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
> -static void versal_create_sds(Versal *s, qemu_irq *pic)
> +static void versal_create_sdhci(Versal *s,
> +                                const VersalSimplePeriphMap *map)
>  {
> -    int i;
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    g_autofree char *node;
> +    const char compatible[] = "arasan,sdhci-8.9a";
> +    const char clocknames[] = "clk_xin\0clk_ahb";
>  
> -    for (i = 0; i < ARRAY_SIZE(s->pmc.iou.sd); i++) {
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> +    dev = qdev_new(TYPE_SYSBUS_SDHCI);
> +    object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
>  
> -        object_initialize_child(OBJECT(s), "sd[*]", &s->pmc.iou.sd[i],
> -                                TYPE_SYSBUS_SDHCI);
> -        dev = DEVICE(&s->pmc.iou.sd[i]);
> +    object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
> +                             &error_fatal);
> +    object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
> +                             &error_fatal);
> +    object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
> -        object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
> -                                 &error_fatal);
> -        object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
> -                                 &error_fatal);
> -        object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
>  
> -        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps,
> -                                    MM_PMC_SD0 + i * MM_PMC_SD0_SIZE, mr);
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> -                           pic[VERSAL_SD0_IRQ_0 + i * 2]);
> -    }
> +    node = versal_fdt_add_simple_subnode(s, "/sdhci", map->addr, 0x10000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
> +                     clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>  }
>  
>  static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
>  {
>      DeviceState *orgate;
> @@ -1064,14 +1091,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_canfd; i++) {
>          versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
>      }
>  
> +    for (i = 0; i < map->num_sdhci; i++) {
> +        versal_create_sdhci(s, &map->sdhci[i]);
> +    }
> +
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
> -    versal_create_sds(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_xrams(s, pic);
>      versal_create_bbram(s, pic);
> @@ -1091,17 +1121,41 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
>      memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
>                                          &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
> +void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
> +{
> +    DeviceState *sdhci, *card;
> +
> +    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
> +
> +    if (sdhci == NULL) {
> +        return;
> +    }
> +
> +    card = qdev_new(TYPE_SD_CARD);
> +    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
> +    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> +    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
> +                           &error_fatal);
> +}
> +
>  int versal_get_num_can(VersalVersion version)
>  {
>      const VersalMap *map = VERSION_TO_MAP[version];
>  
>      return map->num_canfd;
>  }
>  
> +int versal_get_num_sdhci(VersalVersion version)
> +{
> +    const VersalMap *map = VERSION_TO_MAP[version];
> +
> +    return map->num_sdhci;
> +}
> +
>  static void versal_base_init(Object *obj)
>  {
>      Versal *s = XLNX_VERSAL_BASE(obj);
>      size_t i, num_can;
>  
> -- 
> 2.50.0
> 

