Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B284C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uerMI-0004r6-1U; Thu, 24 Jul 2025 04:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uerME-0004q4-3i; Thu, 24 Jul 2025 04:31:18 -0400
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:200a::631]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uerMA-0007lD-Gi; Thu, 24 Jul 2025 04:31:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXnSDNf1ybKryZMc01xuKv4ZPtaT5Jvih1Ojub0eZtzgBxYZruZIiR/lV/WwSWGTGF4XgldunWWLL2Rs0wmXrZmcw+29icDypvNugXl2JcvAZZmmPeinL+jTLo8C2gg2qW5FUbwa3L5sdhMLJyQVKKhSj9pvdEWDlnITL9Dnb3TUZ2tpGhxP9zSMiv9HlCuEOCLaelUVLKBSUpchrSRfNExH7TsS6iDQN6LUInC+WqydpNWp+74DW546UNGKDdn3NV8lQnKggbmu3+G6PheYS2hPu44V5vEbbR4/+kMHz6UgIsIJ7nEIPk3Vw5oU0Y0mPfTzJIxctDCfhJTx/DzRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4uQ1zzqtWTfT6ROp77vCF/wMKOP2BoFk3TRV+19hKk=;
 b=mXnE578LWZPXDxpxIN78Y1KNBP8TX2HoPMxCUAJ6BuRfd9w0h9F3ypyrNTxmxvYljLWFiSq3hOy091yn8SX0n0g1k8Jpn2GWVVYXmeivo5Vuxeo8lty1tB3ief+2xrcV0qmmq+L6a2DXhpzpbCm0+5EJUq+zEEiXpW7qa4ngiEoeGSRSHTsoAIOg72wMvB93F2V+ay0MuLPoCEpNL1DE6CVHVdhbUFS91IJJHHDrjlCFBGVxzNQ8ch208MjwFv6PZX9IftiZITBjAwTYnoePQaEynphqj22UosbYINrn++do3fIDFl+vediHW5RzVoFulrPqiXPgPuyDxGi0l0mS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4uQ1zzqtWTfT6ROp77vCF/wMKOP2BoFk3TRV+19hKk=;
 b=4UEcecZ6xsq5gd023d7wOUrvFVP7EngZpfJvqhXH9ynFm0pByLqIIpCfp2NQ/K+G2RfOXFK/7e/jLf/Mkh7jmJ5Zni0bNQmGehSOVg7gTQz8sq63KbFtHdIT7I/jEnddDTakK4chezkoan4eoHMa//U3NVBEGc5Q/MvGuleErWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 24 Jul
 2025 08:31:06 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8943.027; Thu, 24 Jul 2025
 08:31:05 +0000
Date: Thu, 24 Jul 2025 10:30:53 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 01/48] hw/net/cadence_gem: fix register mask initialization
Message-ID: <aIHvPQd5nHNJeQ44@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-2-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-2-luc.michel@amd.com>
X-ClientProxiedBy: DU2PR04CA0190.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::15) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: edece396-a735-41f6-f347-08ddca8c6e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpUaGo5TWk4dWlCZFJFYWVtZG1aTHRFY3M3Q0dRK041K1NDdlBBc1ZlSkhr?=
 =?utf-8?B?ZGpQY0dqUEhWWjZNTDhLUHFIaVJmNkFjeUhJKzhBRVZ6R3FZR0QxM2w4WUF6?=
 =?utf-8?B?bHdxVjJIUEhCYVdYK2R4bEM2Rm9wbGpiN3lqQTRkRk1FZGJRays4YUEwUXB2?=
 =?utf-8?B?amJqUkJGTElDbC9BT3dUd2Q2RXVUNE5hYkxoZHM4UmZKN2RPNkFGWXlwK0pP?=
 =?utf-8?B?bkhFNnVnZmY5NVI1T2J5bTVNS3AxajI2dUp4NE5xdldCZ1F5ZzRMdDZJNUdk?=
 =?utf-8?B?NHkxdjJHbzBWOEJ5ejhWRVN2VHA1S3NIUmZ6K25kajhpYTA0Skx5L2pvTGRt?=
 =?utf-8?B?dzhvUDhpV05pVnhmend1S3ExNEt2UlZhRU10aktHSGlZUkl2ZTZiRy9EVzNj?=
 =?utf-8?B?UDk2WDI3bENpLytJTnhMSFhkUnc0TEJPVjg1S25ObHZ4ZHNUUVFVV2RVVU5q?=
 =?utf-8?B?V3R3b012eVU2YlMrRmRMcm05enJjYmR0bTNTQTFTRjI2Z21OWVVmdWdlQWpV?=
 =?utf-8?B?dFlOT1hwU0dDZ01XbTBqZWxTbk9LdWVxVmxZa2FxR1pMaEZOVE12d1VFRmY5?=
 =?utf-8?B?ZlA2NDBLMlZkODQwV3puMXp5cXlBaTA5YW56K2lhNlVPY3RxeXBlTFBRUDNY?=
 =?utf-8?B?Kzcwc3dqRmxFL3lvZVJUTm1YZW9OMG9CaXMydXRFWUQ4aUlUSG5nMGg4OFdZ?=
 =?utf-8?B?WXBsejQ1R3g3dmtzVFBpS0RZTWpiRzdtMkVXQ0pVLzFhL00wczB6UUhIWEhM?=
 =?utf-8?B?OHd5cnhhZ3gwN2xTMUNWRUlXdittekZDdTcxSmYvYXRQaDIwVlFvVWVPSjVj?=
 =?utf-8?B?TWtrQzdhd2dTUjU5Q29OakQwRzV0VUpzb1VZNU9BaWxWM0loODFWcXl0OS8w?=
 =?utf-8?B?bXZnOU51NG1tLzhLcml1UEZldlN1bEUva0o3ank5bGhtR0VwZUlBOTFHVE1Y?=
 =?utf-8?B?K2g1dm9tVFFHK3ozNEtLWUg0Z3RzYTgwVDhtKzVFMVJGTlNLKzgxMlFvZGRa?=
 =?utf-8?B?Z003M3pkNm54ODlaaUpmZi9KR0ZwLzY0bUJ4UVY2SVdybEd6MDE1b2VEdWp3?=
 =?utf-8?B?RWVyaktCcHRUMFVjYUJ4YjREbEFZRWFLUEhvcVJ2Nk9ucEZ6b1RyVUlXbmkw?=
 =?utf-8?B?c0dMaWJlaWdjNzdBbE8yS0VsSEVVS3Z2bUpsODJFcWhGRDdpQTdSVW4wN1kv?=
 =?utf-8?B?Umo2WDN1dEVDNFNQZUVUNzlvbERWTUZ2UzRtVEtVRFhGY0dneDVHTmhyYnh6?=
 =?utf-8?B?Z2VDU1YrVkpQQ1UyWjl3SlI2d0RWREFkUnhMTnZQVXd6M3hEaUZrYVczV3lO?=
 =?utf-8?B?ZDVHT2doaXVmY3dvMGwxdEJWZFlrczlBVlVUT1hvOUhpcEU3dnpIaWlZbmxJ?=
 =?utf-8?B?RVlpdmx0RS9xemZac0R5bHc4NUtCNG5IdXFOdHMxbFZ3R3U4UnJpY2FtYU9i?=
 =?utf-8?B?SG1USGJUQW9zTnFyM2lGY3MyQWh3VFBlRVBlTjcwUkdaOUlYcEFDUTRCY0lk?=
 =?utf-8?B?L3p3dUE5Vnc0NC9GSXhvb3ZhYzVjYThjZGU0cTFyV2ZQR1BqWm1oTWVWMWxQ?=
 =?utf-8?B?cXAybWxrRXZYM3VKY0NjUW9LeG1ub0RpUlFwSUtHZkRxNUpOek15RWNIeEs0?=
 =?utf-8?B?WWRFRWQzNUZsdFNiSkZ5YmoxdlRqblJsUHU2L1VUN3V3ckhRWXZ2eUNhVnVV?=
 =?utf-8?B?ZUJ3SjhqalZjaXZ5ZWtXWkU5NVRPWEc3bER4ZlVHclJBMFhoK1Zwd2hmTmhF?=
 =?utf-8?B?R0prMEwzQ3M1OVhvOWdJVU1qVERWN2hQMW0zeXpteVB1blV4ejRlUlBUc3Zv?=
 =?utf-8?B?aTRxMm1KaEg5Qk9yOTJlYzM5ZUlSTCsxb2I0bVg1d2Z2WERvYUM2SlUyVmdM?=
 =?utf-8?B?T1FKU1dYNEZTNTNKQWlVeXR4RWV2ZER2eTVscHZhNmNydmlScDRuazlkSVFM?=
 =?utf-8?Q?R7CjM/aX45o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGp3V1FFTkI4bDdmOHQ1T2R4ZUxEUTVSMGladHo1c1YvazgvM0hEL3YrajNy?=
 =?utf-8?B?aHpCaUVSdDBYeXFTUWJBZHVCcnhsNXA1NjhCMUFkM25aSC94TXdhenpQWkhj?=
 =?utf-8?B?ekhvbm5WSkh4K28va2xCbG9HZ2U0Q3RScEtFVnc3RWVMdWJlVWNTUCtLdStT?=
 =?utf-8?B?UTRjM2wyVzUrV3VVUUZpd0J1MkVaOFhqLzZrT0xoS3F3TFRaMjBLemtGOEVZ?=
 =?utf-8?B?dGdldlBQdlE3d1BMZCtYelFibVpXQllFTlJKYVRWdVEzRFoybEhFeXdNdDd0?=
 =?utf-8?B?RW9tdk81bHhQeVlOa0w4M2JWTmM2dXM4eXZhVmRIUXAvWS9HNVVQK3o1eUV5?=
 =?utf-8?B?T0ZBcWZWQnNtRnJDV0tseDAyWE5iYXRVWTlzL2pMZ1dqUFVhbmlzUDBSK0F0?=
 =?utf-8?B?dFNsZjdwY2h1MWVBTGQyMldVWDlSdFVVSlNrYTBNc0tvRDlic1BCK3BzYzZC?=
 =?utf-8?B?TDNrZ2hhOWRHWXdGejhVSWVTTTY5cEJzNC9PSER6QlZHZFR2OEZuS3EvNXJU?=
 =?utf-8?B?ZDdOaTNXSFBURmNRdW5rZHZIMzYxNHJrb3VTa1JjTDBjRTl1NncxbmJqbnNx?=
 =?utf-8?B?TVVRT3hpcmp4bktoTWpEaFZLOW1PS1dET1VlcjM4KzZpaElzUmVTSmN5dmNX?=
 =?utf-8?B?NmdTSm5JMnExa2xmUkN1eEdzbmg0bWRxZVdkcUw0SkpDZFB3YXJycWI3V1Zx?=
 =?utf-8?B?WkxGcE5mWXZMcktjOG1PV0R2MElLZDk0T2IvV2F0TVhmeVYreEJDWUNYSGVV?=
 =?utf-8?B?aVg4cE91RXVjQldKYzI2dHJqTVdkODk0OGVsaFh3aGM0ek9yaUlmVER3VmJj?=
 =?utf-8?B?WFNrNnJwWk4xUlZoc2JWUUNYVWZoNURhVmkrRm5sbUNIb2paN0E5RHBjNGhu?=
 =?utf-8?B?MG5vbEJCZ1ZMUFhvSXRLNGxKSWxEMm9vMnN5SzdKUEhjcTNzbFo0cUNwWmE5?=
 =?utf-8?B?ZE9oQWZUa1ZPT1M0R0h0QVFqeUplZG5OZ3RSSTYxdTdLV2IwempTWmJuT0N5?=
 =?utf-8?B?N3ZvSjFzY1FjNnZ3UGZqM2QxcDI3MXk4TFQzMlZ4VHdXay95M1RWVzVSWk9t?=
 =?utf-8?B?NDlIeHR0ZkdwWkRVd3ZVVjlpZXU2UGJ5WVRmSVIxdmdheHVTYW9zRVVEeDhP?=
 =?utf-8?B?cFpQUFlQM1ltUEYzQVlaUkNaaXZqSWZxMlNiV0x4Uk9wSC9LSVFleEZhVm1s?=
 =?utf-8?B?aHBNcm8xVU9EMlQ3YllrcUVqZjUzd21sWHFQdFdtZkJmTEEvNFBqRU5wNGRn?=
 =?utf-8?B?N05EVUFDVFltMHNUMFFRR0ZlS01jZXFMa1pFTUFJWmJUMDc3ZWRDNkVHU0N5?=
 =?utf-8?B?Yk5GVzMxUi9Wc1V2MUNzSnNpR2sxYWhPeXNnaDR6QVhhVytUYmlYY0hVWWgx?=
 =?utf-8?B?QVlIOGdMcFpCbG1vU20rMGRmMjNsanVodEN3TkhhNk1jcWZnZHRxdy9XTWVz?=
 =?utf-8?B?N291cmJKYlRySWxVL256aG1HNTFCR0NYTG55SXJLRHh1MkZXRWp3T3YwbWF3?=
 =?utf-8?B?djdqQ1B1b0c2ZDlndytjZUF2UXZYLzUyWGpIMCtZb3VRRlExWTA0WC93MkJB?=
 =?utf-8?B?RVlpOVNSMml2Nm1PK0MzTkhIdXNUOWdFSG03aEVUUFFkZFpWNDcyK3krMkNn?=
 =?utf-8?B?dHhKeXpraFNOUlJ4REEyQ2F1WnJqQ1U0NnhCd2h4eHlxanRsV3dSaHZtMVZ0?=
 =?utf-8?B?N3N2NklWdzMyN0xmcVAyRE05MG04alRpYW0xWStoVG5oWmEvbEh2YjBwcFFO?=
 =?utf-8?B?ZCtkVnlxL21NdmlSREVLdVM1cGRyYU4wT2RhcGZhaVd2ci9CSFdxWU1idURP?=
 =?utf-8?B?ZVFxL3llUzZCdEc4dkpXd21DR1NEckNzRUFLWk01UVlQdWsvdVpGdElvZTMx?=
 =?utf-8?B?MFgvMng1SVdVeFFtTWI0SWdoRVlYQnUremtFTDgvdkZhTm5XU3BhaTNPS3RE?=
 =?utf-8?B?eTRPRVVydnJrVklRZUtvcjhOZjdMblNCN3I1R0U3ODluMUczc3VvM3FTcXFy?=
 =?utf-8?B?WjFlSmR0b2hLUm1jWUNTY0JhTWZFazVabUVPa056TXhKbnRhNkJIL2pLeVpa?=
 =?utf-8?B?TjY2UmZoVEVzR3d0U05jTHA2cWxNdEViNmNFbElnWlJvWktBWVIwTUxpZE1L?=
 =?utf-8?Q?iV5NS59X8H0cck89l15B5VDDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edece396-a735-41f6-f347-08ddca8c6e2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:31:05.2248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjQeNZjanhixbjr/GoO+fTYHwrVjzz72ny6WVY1yRpyALbj936SkCv0CNHxVPlumuWG+CUiTYU5YPwiaZz1uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
Received-SPF: permerror client-ip=2a01:111:f403:200a::631;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

On Wed, Jul 16, 2025 at 11:53:43AM +0200, Luc Michel wrote:
> The gem_init_register_masks function was called at init time but it
> relies on the num-priority-queues property. Call it at realize time
> instead.
> 
> Fixes: 4c70e32f05f ("net: cadence_gem: Define access permission for interrupt registers")
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/cadence_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 50025d5a6f2..44446666deb 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1754,10 +1754,11 @@ static void gem_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < s->num_priority_queues; ++i) {
>          sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
>      }
>  
> +    gem_init_register_masks(s);
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>  
>      s->nic = qemu_new_nic(&net_gem_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id,
>                            &dev->mem_reentrancy_guard, s);
> @@ -1774,11 +1775,10 @@ static void gem_init(Object *obj)
>      CadenceGEMState *s = CADENCE_GEM(obj);
>      DeviceState *dev = DEVICE(obj);
>  
>      DB_PRINT("\n");
>  
> -    gem_init_register_masks(s);
>      memory_region_init_io(&s->iomem, OBJECT(s), &gem_ops, s,
>                            "enet", sizeof(s->regs));
>  
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>  }
> -- 
> 2.50.0
> 

