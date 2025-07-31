Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976A5C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaos-00084u-Fy; Thu, 31 Jul 2025 17:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaXC-00012a-AR; Thu, 31 Jul 2025 17:09:54 -0400
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2009::622]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaX9-0004bp-Sx; Thu, 31 Jul 2025 17:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGqHbuADaOa5ZGfLED8959TbsbXN8ju032DIyHHuPqFFNKY/clSs2QXXOg9zqQM3vcXynT1oXM0j8uGrpaJ8sc/jGmLjWeQNrU3JCaFMED0Ayy1yQ85XK0uzMzdKaWHCle2qSobzwa68aLbpYv4dFHNEDZzflffH366zgZ5AJxGr9T8yuoGprHdIuHCsjRo7aBznMggyqhiS5EF3BLuNMsUm372p1rMMHTmB9docV3ofwfjyvBb7VDVa2uoWgg/Vq2ZT4Zh4uh7N2HCPFkdwz+T9ZEKSwwxzv44aqf4UcaK66Y2rWOXYv2s/KlyI5YTAfR6eS2zec+PKCbo7EpunoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i+QGPtrncXiva1lli3+YIWGn3WH860lNtkUP1Af2HQ=;
 b=TmcQesQa7rGjaE5TJSbzQbLvYSWtz+XotKuVYuwBoIoviWFmbTrfhd4cXv5MueL2RBoE4aFXZlcQ4N4JCTuLeLQ7RwBZa9tmUQv9gdqT4/RBOVsn2r0Vyzq0iF5xH0QB/WK65QErDsiEn6/SiEvzr1vM/hYB2DcdxmQCi1+j7B74n4anCDo6Qig0ql71YHOWxwQjS2ld+EhJnGhL6FAWP4jouEa64nhDImF+htzMK1gJurQ07Za65J9dMP3/stcXNCnmZFXTcNHtYjsRryRJmkyMl7I8m01x83i+BUNApr5CpZT5y6Jpivqz9WN9IF6JtX6hywd7Th1NK7bIzdNzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i+QGPtrncXiva1lli3+YIWGn3WH860lNtkUP1Af2HQ=;
 b=2Lf56jOk+YhnaK8Qr0UIxIHp/Rc5dZJvqE2sVRTkYNvceS3Jf9YpQNANiMkbLeY9nmNNqg0OiykqnUg+yzLlaEk8nipekMw/XtBNPeh7Rt/daOdVFUezYsW0dP4QbVldaMOBCH6pZc/k5DfL62uAWBMGexFpHtpjgTa33JGRmxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 31 Jul
 2025 21:09:47 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:09:47 +0000
Date: Thu, 31 Jul 2025 23:09:40 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 48/48] tests/functional/test_aarch64_xlnx_versal: test
 the versal2 machine
Message-ID: <aIvblMikl4vhSj4d@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-49-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-49-luc.michel@amd.com>
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e835e4-9cee-49cb-1422-08ddd076949c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2lub25GODlFRVZiS0xZUUJDcVVHTmhSOFcxZS93OHlacUhsVnFYSEtPdE93?=
 =?utf-8?B?NXgzbHgzZTRLd1ZGQWZkYXdOMmY2WldhekwzVlh3akNraEQyaThwU0hVWkk1?=
 =?utf-8?B?RG01eTI0K0dHNkthT0dNK3lkYWRsbk8xTkFnT1lOV053QWN5bjQ5SS9mVFlT?=
 =?utf-8?B?MGtYYTh3L25JNlV0UUhoa0JqQVIvV3kvZkptOVVFWS8zR0RGSHgwUlhNTmVx?=
 =?utf-8?B?ZVVsYld5bmduaG9yY2hPRlM1bnBaeVMzZ2FVVlJ5U0lyZEYzUXhYNjFpUm1o?=
 =?utf-8?B?aSs3S0NFak1BWEQ0ZHNsQUEyRG5RWXRWYm13VWJRQW55dk9KWGxZM2Q3eEkr?=
 =?utf-8?B?RmZVZGYyZm5ob1R4VUxIUzdFNjFxVlpvdjBtWFBFZWUzb3NxczVibC9CemQw?=
 =?utf-8?B?MkhQdGdKKzhqa1YzU00xL1U5QXBFQkdyVVZPYnBnN05yMGljWFZOQVg3NWFn?=
 =?utf-8?B?MDR6cFpZS3NuVkFKS0h0ZUo4eGViQ2FmV3MrTEJ3WndYblRBNzVjNlpCdnhN?=
 =?utf-8?B?Ty9zanBBc1R4eGlrUllyZXgxcVA3cE5VVFdwd2RZc2k3eHpFNkk5dUhSeGtk?=
 =?utf-8?B?NWpzQ250RHRtM1I5cVhFaTNEeU95VjJ3WDk4eFUwK1dXYTVKbnRhOGdOVXN3?=
 =?utf-8?B?VlJ1eEFjeDVraTgzTlNNVDVQZnhhb0E3ZGk1TnJnWnhxUUdHOFkyUFkzMXpP?=
 =?utf-8?B?a2VzY2tXL3l0ZWtBanhrdnBRcTQ5Q3ZGT2ZsdW5tdVdmWllrcFFFaGdQaWpL?=
 =?utf-8?B?MlRQbmFISE5sOWNRMFB4UWR6OGphVlBnRTNyUnVGaWRPVUEySlVNRWRSQm5V?=
 =?utf-8?B?cnNlc1BYOFNuUlE2NXhxdDZIYkNkLzlsZjZZTFlRQ2gwcFJCeGpuYmJNM04x?=
 =?utf-8?B?dmlPYTdXMmpVMEVXS1ptdzI2NTNBSXEvOXF4Z0NVV3pVS29pN09FdTlzQ1VZ?=
 =?utf-8?B?SG5kU09nZnpQS1B0L0hmSWdZTzRWUjJoTHVvcDhaU1hrbjAvNGFnREVpWitG?=
 =?utf-8?B?R2E2TEhJMEhkN0F0TFF2bGNZQ0R1ZWxQZ2dSblpzMURzdUNxVjNGZTl3N2Q0?=
 =?utf-8?B?VmlaQkFsbWpaTnVnMXJJb0R1WVcra2hLSmJnRWFFN0I1aWUxM1dBZzYwOVdo?=
 =?utf-8?B?bEwrOUMxWmRJSHpoQ0IzZTh4cklLdlhXdmpOb2FhenRNUVNvU3R6cjFjZXdD?=
 =?utf-8?B?RUQ1cksyOFFiVHZNcmVveXhuQi9mNTZBbkpESVMrZlB5NUdkQU5ETFIxV2ow?=
 =?utf-8?B?TGhzSTFHOWtKTmxkVlZDMDkyNkJwWUluMTdyU0FMMEQ1RVlJZ1BmTEZvOWNB?=
 =?utf-8?B?cS9DNzV5Q29ZbFp6dmxxRjZvdU14YXcyL255ZXlRSS84MFRId2tiTzB5SktI?=
 =?utf-8?B?S2pNYjZ2bFZBVWNpbXBCckdZK0lvcHh4NHg2anRUZ3FlaGE5cGVXZ3dHYWJL?=
 =?utf-8?B?UW1wQmlMcHNHMnVVNjdQRG91L2pMQUhYZ3JlbS9mYjJIa0JIbWwwdDFSNFJp?=
 =?utf-8?B?bHlwa0RJNkMxMFhDNzlDcCtOeU5vVCtoY3pQT3JzMTJXU2VLMzVsY2JOOURC?=
 =?utf-8?B?UGJnOERySEVwc2F3ZmVPRVN4ejROaDMxbENtazRzZ3l4U1Z6WmgwaUJOMVR0?=
 =?utf-8?B?OGNuRThwZU95djVPSXNOWTJMbFQxQWRZWHRYKy9rd3VjUVJRSDMrK3A1RTNU?=
 =?utf-8?B?UW5KMTNqRXVxaVNUMWNLOHc1VjNXZE1ocmFLL2JOMklqTnVYZ2RHMjBzUExh?=
 =?utf-8?B?UERDRWlDWWdNRlQwcDJ2VVlycXJrVk8zMkdtQzMxdXlqWkNaMWZHVUFzQnZm?=
 =?utf-8?Q?3aNrFLeAmMyWapwh9GwarzgpirtfixlfNADyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1dVaFdKM1dCY3gvdm5USFNzQ1lHSGhJTXNYZm16UVN4WXdMeWQxbFFpcmh5?=
 =?utf-8?B?eUN1Yk1lMmFzdDl4M0dEY1RaZHVWVFlkek5iSENKdzFieFNQWEt5OFo2cUt1?=
 =?utf-8?B?aHdmVTcyN1FDR1JoZGtSZkZlaTQxdUczM2YyZk1PWHpsSzhjRG9FVXlYdE53?=
 =?utf-8?B?RDJYM29lS3ZBeDJubmJVT3VET1VzTkFKS3ZuUWcrSXRFVEgwa2hWRkNEUnNT?=
 =?utf-8?B?T1lnaEVhMHF2Tkc5eHlIVmYwQjFzTWpQczB4TWZuS2g3U0FwVlRkblBSTU5r?=
 =?utf-8?B?ZmVFazhPd2dia2NrZHRvVHhQVGxDVjYvV1Y2dHZtWGorVXNhWUw2R1k2OTZG?=
 =?utf-8?B?V1QvSlhWZloraThsQ2lUdjEwM2RMOWF5VGhha01HUFk5Z1BVTG1YaGJMdXp0?=
 =?utf-8?B?UDQ0T1ZEc29ZNVN3bUlGcC9zM01CY3htSU9VK2RMSW1OaXYrSzJCZzdXbHdT?=
 =?utf-8?B?Q2JhZWZnQUJvbTdUWVVRUjRxNkNxN1cwRldaTVZBN2lGd1VpaFlLY2krbEZB?=
 =?utf-8?B?ZTQ4NFlZc2ZNVnJPNHE3T1p4cEVHTGVhUVRPYU9IaCs4TVVVM0tmUitCSGJR?=
 =?utf-8?B?MUx0VFlnSXRFNVN4cUQ5cWprN1NIaXArUHpOcElnNnRHMDI3Mm9GR2YxYnp5?=
 =?utf-8?B?OG5BR1hnWXQzcG9YV2gzaC9BT0w3TEUyWmNXRXRDNHZLdHl6Uy9reGxodnNK?=
 =?utf-8?B?dnJEZ0FBQXBIa2NzWW1JYWNqMVJ6bW9IbEs5V2lsMkNHczQvYTNSUEEwU05M?=
 =?utf-8?B?aTYvN0tYM1B0d1dOTzBoZEttT1FNYWtmUWJMUWd6Q1g5QTdIRGVSMTRHbXFH?=
 =?utf-8?B?elVLNjh5MGtWeWlQSWtuRXNBYlhHOW9MeWtqTEVOVEEwMVpVUER0dWN3bHhP?=
 =?utf-8?B?M2lPSldiY3BGRFNQTGV5eTUxZ0wzSnJWUXZ5c3JkR0N1azFnNmJCY0R5T1ZW?=
 =?utf-8?B?WkVpNm0xUlNzY2lhNEFiM2ErVE4ybXkzZWlncjcxM0U4VmJ1NExwRDVJT09o?=
 =?utf-8?B?ZW1wcG1aYm4vY1Q4NFJ5MjB2aGZtU1FSZ1MrSlJGZnhSVG9EREhsSWhrUm1Y?=
 =?utf-8?B?MERPYVV2cjU0NzNZelpsMkM2RlZpTGYrbkRQTS9SbFJ3T0wzcGllTjBVVTZq?=
 =?utf-8?B?bm5OSHlDWCtRZ3Y1N0RPZjRsS0wxN3hvRUY3OTVKUHJpUTNYUXdpNnhiNHNO?=
 =?utf-8?B?dEFpSGRsaWVPZGlWSGIxNHZSYy81bXd4cGRLUS8zR0FxVGJFWHlYRkl4dStm?=
 =?utf-8?B?a3U4bk80WmR2aXFmUW1oVS9ibG1TY2pYQ2planEzNk84SWkzcWloQjNuL01M?=
 =?utf-8?B?d1k2dk50akZ1QnN1Ry9EQmJYU05iNEZBdlF3VERhSEd5R1BEeDRCYkVLUHlP?=
 =?utf-8?B?TXZsckRuYWswUXBEcHJkc2lkZHFYMWVYN2NJbDZicWtCWnFzVHpCWThVVjhk?=
 =?utf-8?B?MkZ4Z1NTMTJWKzRoWm1qRlpXVlZ0NDllOXkrUXE4RGM4dS96elNUdVY5TTRw?=
 =?utf-8?B?MkgyWnd3cENxMjU0S3c5YVBzdUJXamVjUTcyU2RqSkt6c1VYWVdhNm5mK2pW?=
 =?utf-8?B?aVlrZ2hZUVN0Yzc4ZWRyWC9mWUhnaTFlRlFibThNa2wvV2xOQ29DRHp5YUV0?=
 =?utf-8?B?UDdRdENORUY1KzBKV1JvSFV0OGpKTEVyd1EvZ1MwMTFnRlc5cVY3WjVFVDlL?=
 =?utf-8?B?ZktENHk4VkF3VlM2cU5pZjNLTmNzenU0RkxXamJqVmQyVkkxRHNGbklUOHE0?=
 =?utf-8?B?dGxyelJpR0JWQmpFN3F0SkhWRFNDRXB0by90QmdGeWkwTHJiNk8xVFZzUkJv?=
 =?utf-8?B?Z0hIdWJnV012VFhOWHlmRU13M0cydEtpNU41MjltMEdHeW96a0UyQnFxc0ZV?=
 =?utf-8?B?YlFSQnhuckt6bDVyUDZpdmJEay9QYWdxT21zbjJpcGNDdDd5cTJLb2tTYWxE?=
 =?utf-8?B?aisvVGw5d1NCWjhRMzdXL3JTVlFiQ0dDMXR2OVhtenpYbWpoS1dGNWp5TmpY?=
 =?utf-8?B?RlAwdkM5RGgrZzZuYjI5akRIbHJmR1hWTExZbTB5UDVvQXdNSG1wYTY4d2FV?=
 =?utf-8?B?TG84MnVnM1hIcDNhbk5CM2hxa3VVZUFDWGc3Wk1JMUMwd0xhamdSQTN3TlBr?=
 =?utf-8?Q?8S1lJ0MDyAetM1wILieau3vh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e835e4-9cee-49cb-1422-08ddd076949c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:09:47.8023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCRVgQtC3yq72/RCAX5aYbk6P8PcaAACBbuouOS2oaRSTyhfS8jmcIntD9yapA42WiZSD4nhsR8F22pAXPZKmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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

On Wed, Jul 16, 2025 at 11:54:30AM +0200, Luc Michel wrote:
> Add a test for the amd-versal2-virt machine using the same command line,
> kernel, initrd than the ones used for amd-versal-virt.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  tests/functional/test_aarch64_xlnx_versal.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functional/test_aarch64_xlnx_versal.py
> index 4b9c49e5d64..f32d904ef7e 100755
> --- a/tests/functional/test_aarch64_xlnx_versal.py
> +++ b/tests/functional/test_aarch64_xlnx_versal.py
> @@ -18,12 +18,12 @@ class XlnxVersalVirtMachine(LinuxKernelTest):
>          ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
>           'installer-arm64/20101020ubuntu543.19/images/netboot/'
>           '/ubuntu-installer/arm64/initrd.gz'),
>          'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
>  
> -    def test_aarch64_xlnx_versal_virt(self):
> -        self.set_machine('xlnx-versal-virt')
> +    def common_aarch64_amd_versal_virt(self, machine):
> +        self.set_machine(machine)
>          kernel_path = self.ASSET_KERNEL.fetch()
>          initrd_path = self.ASSET_INITRD.fetch()
>  
>          self.vm.set_console()
>          self.vm.add_args('-m', '2G',
> @@ -31,7 +31,13 @@ def test_aarch64_xlnx_versal_virt(self):
>                           '-kernel', kernel_path,
>                           '-initrd', initrd_path)
>          self.vm.launch()
>          self.wait_for_console_pattern('Checked W+X mappings: passed')
>  
> +    def test_aarch64_amd_versal_virt(self):
> +        self.common_aarch64_amd_versal_virt('amd-versal-virt')
> +
> +    def test_aarch64_amd_versal2_virt(self):
> +        self.common_aarch64_amd_versal_virt('amd-versal2-virt')
> +
>  if __name__ == '__main__':
>      LinuxKernelTest.main()
> -- 
> 2.50.0
> 

