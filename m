Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD6C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvELN-0008P7-Px; Thu, 20 Mar 2025 07:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvELI-0008N1-3V
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:45:44 -0400
Received: from mail-bn8nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2418::612]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvEL9-0005rJ-QU
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njclHOomg5N+KETalioZVjYekXokJkZly1rdFsPy0Cp6BFABWP9cylsUcgtefyA5ot8OtPvsLapKfBdNKZ3z46efeCgW1YtKzlO1TxcxQ7EYEMOZyXCRm/KiBBV91yHJlLmwBWHO8h0z7AZmwSG1ChNepsoAh/S+sI4urA5MVaXpvjs5aWIA99T2pGrwUxXrgp/wrTmhVIWu++Otgv+4cWjfaLZOLdBPrKY1hYOX4VlJjBWI4EUgqLmNa1DXaca9C3YU1ioC59ho78CLz52zeffAqTswPc9xqfUjLzSpnm+1Jw/dqUZvbC402pbyURgV2g6JQEk9ezfJjNvzhl59xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua4+kd4ZDChlL0AXwxz33/EQvT86e+3shR2/NH6jGVw=;
 b=WxogZX9RiY3hmmllcxPBfgbGt2ksTR7nOby2e9clql5MZhv6OTkdbGnPDqr9zKd/30M8NX0YmOGdZW2C+5Uz34UApikeqvpbD+zTtDxUd/o5/1yYAEXQv2mloN9t9TDVM2efdpaPUMjZifA09oJuCntB9BtxZXkm0QYZ5ho1nO15ruuH5K/bYX1oLgvgTuSDY4SUU9u8l882Vt7LaSKad90dBXcwrzni0srJNTK5JneCFLGEHC88NxXZOQmj9TFc5tGXjD5FpNZEJ0JHEObVqrX4KnZVZhXvBBriNh8jjyu305Fnj7eseUBWgca5UePLvRYuXvAzdXEf3/q85dNnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua4+kd4ZDChlL0AXwxz33/EQvT86e+3shR2/NH6jGVw=;
 b=nLsccwP+quaSi15lQ5Df2BvtaGvZPOg6xb5Q64XsQjfN62m4EgRdyYyDGUOXUBe3HYlOwAN9ZT2XOJwVwBtrtpRTPH3Zoo727CAryT3aYVXaJtLIIfGEYiobcnHRHLpJ+Z2M6IxV4fD3PZyZFAvuSrwT12J3akSSEbAXf4O+sUS3VhQeTugZVDiizIyJzVjq1oIRIQskY8tH1Wd+HQs8FORCif16WDWLu/zNzFQOQR770MJimCsoG3amYQWrZhW6OWExt/pQIoEbgrh1dBsWJct5o+5R6nhE0Ga0KSiObPHvF0sgkuiZihTjkDWlitTR2PTv5kreg4MJ0+OFNoGQkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 11:45:27 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:45:27 +0000
Message-ID: <ff5edbbc-b6f6-4064-840a-5ba146190ae1@nvidia.com>
Date: Thu, 20 Mar 2025 13:45:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
 <ea1b19e8-245c-449c-a7bb-31b79c62b799@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ea1b19e8-245c-449c-a7bb-31b79c62b799@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2353e910-ae42-4de0-0fc6-08dd67a4b55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c293YzN6TWZjbTlhYTFkTXJzZlI3NE5pMmw0U0dHa1VwdTgxZk9vQlhRM2Zj?=
 =?utf-8?B?ME9xdEp1MDNMMi9rOE5qeDd3SkRvclk5YVZkd2xNeUNlTFJUN1hnMy96cjRP?=
 =?utf-8?B?Njd4NTQvN1Z2SXBQUGJXaUpoeHVPT05jdDJIZis5azlpM1JmV0VzRmlIeThW?=
 =?utf-8?B?TVlrb1JlNTZmUUlMRFF1K2RzZ1ltU05zZG1tVit2MnFvNkNyamxoak05SGdy?=
 =?utf-8?B?cjBGdzBRaklaWFFrQzhHYm9zUDVaYjRQNjNpK0tWRGtRMklodkZON3poYmtO?=
 =?utf-8?B?ZGlvWmdlTlQ2cjJoRXJWdHd2QTJqcG4zeEJFamd0YnhQQlpGOU9LdUplUmpZ?=
 =?utf-8?B?dEhyUjBMV0d2WERzZnhianVGd012Zkk3K3gwU0JFR21CRGZWYmxvMlhsZmto?=
 =?utf-8?B?Z1o4d1hETUxjV280NVRCNGdFTVMxUmFVTTVxeVp6NDlPbDhzMHI5SFZmOEpI?=
 =?utf-8?B?Nm96NzI5VnFVaXovdWwzM0JuRjU5YTZkUnV4dTc0ZHVlelZUczJIeEoyQ3g3?=
 =?utf-8?B?WlRFY0xzSnY3ekdoVGF2T2pSQXhRS1Nzcnd6ZmVqV05PL0JRbTJIS2dTZ1V1?=
 =?utf-8?B?cGdBRGxkd2s0WTFVOXJOd3lIcHFLdE1IWGZPbmVjTSsrT1JRZFBVdTVaazc0?=
 =?utf-8?B?Vkp5b01QaW9NdzJYWnZmem9WZmNNTE5LQ2lyeU5JV0FtdjNTTUtZN2hxeU9B?=
 =?utf-8?B?OTVIYVlocVNueXg4ckIzNkM5YlJrdURhcy9nM0tBajVPb0pWT2NnK3FyRkJ6?=
 =?utf-8?B?UjBEbndQa1VaN25XdmxHbWFIaTlqb0pVQVhuRlgvWno5NEFtRDJFSGpGWWdF?=
 =?utf-8?B?T0pFYTdCemU5b1FGUUdvWVpJQ2ZRaXBQcExPSVRKdi81Ni85Y3o4b1d3c0NP?=
 =?utf-8?B?T04wRllQV0Rnck1uaGJmTTU0Z0RUVGJhbWdyKzFBbU41TitWcVpQczBzLysy?=
 =?utf-8?B?R1J6MUkxcE9FdlIvdE9UZkpNVnB3NUFKS1VaTTg5bFI1b0liWWJQUlZoRDNI?=
 =?utf-8?B?czJDZThObmhzK1FYY1NsKzlYdlpyTno2QWkyRmNYNGtwS3pnSWZxci83cTh3?=
 =?utf-8?B?ejAyd3UvTDVDREV2ZjdqYnVEUXNxU3djMXFXMkZwRnpzMTVZbnpDREFMai9N?=
 =?utf-8?B?alk2dnlTWlFHclVkbkJxVElRTmRYTWxhZmJ2VGI0WmhPNzZ5Qzk1bUhFZk11?=
 =?utf-8?B?Q3NHR3hya2tYcjlUY3cvYlZJWitlS0krMXFpeEhYMlZPSHdBUU5wR1lTT0tk?=
 =?utf-8?B?cGhQalo4RXdFSU5ua1VmQ0drcGNJZmVwdjl0dTV0WDN0RGg3K0RIZ2JPN0tm?=
 =?utf-8?B?TXpLd0VVUnVUVmt6YmRxRXFGb3FrbVA2bUdpRTZGY3czaGhUek41d09idlBB?=
 =?utf-8?B?eHJvYXFTYnFuUytubnRXQ3M5Mk1GK3IwbEpYRy93eXczb2dWTUlpeEVERktB?=
 =?utf-8?B?Mk9COGVvd0ZudS94VlBRUW16ZVNHVlJ4QnVWdGY4Q0lDYTRva3lUcGFWc3dS?=
 =?utf-8?B?MzVuMFRYWXJKMGdKOVRFTnUxNlM1TW1xbGhPeHd0ZHphcW5QeHJ6cHA2R0No?=
 =?utf-8?B?b2tQUlZrbDRDaHd1QkxRUDBJbCtkbGN5QitQR3Blb3RDcVNLdngwZ1pxSXRu?=
 =?utf-8?B?MVJaQWhIYXQ2cUM5UnJrdzZ2NnpJQkFJdzNFOWxXUWtDTlNMK1p4VjlVbDNG?=
 =?utf-8?B?cEVFeWJKcEZjcDErYmc0aXhoei9tcDN1VC9namlCdlQ2QThieFo4VnRkeUY0?=
 =?utf-8?B?MHJ6V0IvMzBOWkJTckJxdUlWTStyV1pxQXMyR0Nsemw5OGdaTEFMSXhabXdH?=
 =?utf-8?B?cDNiSU0zOUFhTUNqUXowb3NjVFo4OVIzRytnS0R2R3Mvc3BIcDZtMlZKQkxj?=
 =?utf-8?Q?1szgiJn7U2Iv3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdUWE1OdnA4TndoT3pmdjRuVThYU3IwR3E1R1V0NlZuRUhEUTdhcUt4V0Ro?=
 =?utf-8?B?YmszN2pJWUZ0eGJRR1c1a2Z1ZDFYd2lrUkhDNTlsN2dWeDZtZW5jdUprUWRv?=
 =?utf-8?B?STY0RTR4SklsNVFjejhSQXg0ajJXQUN6SHRNQXNRdTN6TUxVS0ZrN2NxeXp6?=
 =?utf-8?B?YmxFVTFtTUlhaWV3QXFPaTRlV3JFSGEveExYVnhWYkgxL3d6T2MzTFQ5RDVG?=
 =?utf-8?B?RXF4OGZqTk9HSWU2V0xrTCtaTmcrYnRuS01EdnZKaWZlSG0xTkdvbmVZNmw0?=
 =?utf-8?B?NE1FSU9UQnBIWXRoZXFTaC9CNlltdFJVelJtSUlib1JoRTJYVVh2aFpxQ3Bh?=
 =?utf-8?B?YllMaENHS2RiRm9rb2hIeUR0TUl3c1EvWnhYbE5HZmtuU0s0aXRLTVBrRE90?=
 =?utf-8?B?R2dKWWU1NEtpNVE0ZDVxeS9pQnY5NDNKcFMvc2Z1OG1sdjhDemhuSlRMeGlV?=
 =?utf-8?B?bjJMcTIwUFZ4SEQrZWNKc256dW9SM1ZrMEVRY0FzWVBpM2tsYW5HL2VKQ0VD?=
 =?utf-8?B?WHlZcHVBMWdpNmJHeXZsS2pRcjVsc0N3KzV5Umd6MDVEd2lEdDZYMXg5Ymlv?=
 =?utf-8?B?R3JBVUpBd3VFanJWcnV4U3d6enF2MTJLSG1ld1ZUbG1EYTdHMHJIR0k0R05K?=
 =?utf-8?B?OWpZYVNWMms3dFd3QVlrZXBCdEdBaUVFZWVlUVNORUdMQ2pUMkVKeUx6c1lM?=
 =?utf-8?B?dkxOeUdSaGFBRU92MDVnTGMySzlpYmk0VDVIVGZVWWtOY2xrMEE4VStxZ1VX?=
 =?utf-8?B?d25LSEIrMG84dnphUEFXYUxRRnNqT1Ntb2lJaEtJd3lXOXI0b1F0MW9lVXdB?=
 =?utf-8?B?RHdOSjBPbVQ0aVVWcDZWcnRQTHhBZzZYM3NCMnRZY2JNVDhZTy9jcE5jQVBP?=
 =?utf-8?B?cUFYQ211R0thaWFmbVhncVA0K1AveEV2L2lXeDd4M2Fmb2ZlUDRFcHl4ZFo5?=
 =?utf-8?B?T2VlajA2T1Vhc1puWkhWdTZWcHBUQk5XQ0tDNTlNTjhTLzVxdDhZZVFuNUZx?=
 =?utf-8?B?Y1J1aFdkeG43N002bytZaGF6a1J6ZGl4RUMyMTBLTEFWOXhpTzRQc2JrWTNh?=
 =?utf-8?B?WlBZSEFjR25UM0JmRU5tZHBmSUNOM09XYTVjcnVzUS94RHVUVHFzd3dKQ2Vt?=
 =?utf-8?B?WjlqWG5qNlBZUnpUdHY2WmhJUlk4dTF1NGVjNmc1c1Btc3RZL3pNTXJGdXBw?=
 =?utf-8?B?RC9LRTUwaEg2ajhIdVVTWnhFaG5oWXVhQ25GNE9KYVFXS2psdk82V3l4bVNk?=
 =?utf-8?B?cHN3dk42ZzA4aEtvVkptaEhycWMwbGdLbEVka0dNZW9vS20zY212eHNBM1dl?=
 =?utf-8?B?aG5aYjJyQldmNGUrVkN0RCtkZWZqN0dJR3V5dXdmL0lGdlFzWkl2b3BLSFIy?=
 =?utf-8?B?SksyZ21iL0VCa0RJVjdnakxFcnE1dFh1MUg3aGFadWRCZTJ1NkdKLzQ2MDRu?=
 =?utf-8?B?SUhZRWwxcktWb2NqYll3cjJTdkFtZlhwbzFjVFVZUFdmR2ZpMWlmbXVlQjBj?=
 =?utf-8?B?QVBiYkk3Y0tjTSthSHpIcVc4NSttK1hDdnE3TS9PSEhjRE9VU0V1d2xaMFlJ?=
 =?utf-8?B?ZGpKTXdqMm90cE5pS0g2Tmx3cVlVY2tpc0lhTjMwRzQrMitMaDBBc25jUDNR?=
 =?utf-8?B?VDh5Rjh3R3lIZjBFSmN0L3V1Slh4UUFpOU1FWDVzSUExMUc3T3FGdEVSdzYz?=
 =?utf-8?B?bW9tU2srK0V0SnFCSWNyVmpWTHZpUmFkUDdNMXRQM0xWVVI2VjNFaVhjdXl5?=
 =?utf-8?B?QThsaGxmbzZJMzJhcTE4SVVkVkM3ZTg5bDR2RDBRNzhIRmNjdldkUENLV3JI?=
 =?utf-8?B?ZmJXeDhUMW5sUVEwMHRQSTFVQUpNc09Ta0RZNmM2ZDFHcUdUS0tSTUtRM3Ar?=
 =?utf-8?B?TU9NSW1DUVZRcE9Vc0M3SjhUeXpwam41VVFoRTRkQUovM0tNWjgzMXNTa3ZL?=
 =?utf-8?B?TEVsVnNTNlZOMHJjQWRQMURaRTc2VlR2R2pyQkNsK3ZreUYzbndnR0w0MHc0?=
 =?utf-8?B?K0tIUzB1Tnpxa0U5eFZyY0MzbWhZY3diQUFuWkswTTcvREpFWlhJTllubWFh?=
 =?utf-8?B?blQ0TTkzdkl2SmZlb0NjQjdrL1ZVa1Q5Z1dsaVVoaGt3OWp3S0Vkb0sxbytw?=
 =?utf-8?Q?oLAGbtuPZsfu0c+fADan+fvfM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353e910-ae42-4de0-0fc6-08dd67a4b55f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:45:27.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJraqQ4jWbeyz5Kbwj0Qb2ahHXF9iLKUkEqyhZdeiqXoWnFGjLanDO4aBGF+H8ooHgF9+pXzsIK31vVPxSBa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
Received-SPF: permerror client-ip=2a01:111:f403:2418::612;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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


On 20/03/2025 13:18, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 20/03/2025 11:13, Avihai Horon wrote:
>> On 19/03/2025 14:21, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>>> Rename these routines :
>>>>
>>>>     vfio_devices_all_device_dirty_tracking_started ->
>>>> vfio_dirty_tracking_devices_is_started_all
>>>>     vfio_devices_all_dirty_tracking_started        ->
>>>> vfio_dirty_tracking_devices_is_started
>>>>     vfio_devices_all_device_dirty_tracking         ->
>>>> vfio_dirty_tracking_devices_is_supported
>>>>     vfio_devices_dma_logging_start                 ->
>>>> vfio_dirty_tracking_devices_dma_logging_start
>>>>     vfio_devices_dma_logging_stop                  ->
>>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>>     vfio_devices_query_dirty_bitmap                ->
>>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>>     vfio_get_dirty_bitmap                          ->
>>>> vfio_dirty_tracking_query_dirty_bitmap
>>>>
>>>> to better reflect the namespace they belong to.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> The change itself is fine.
>>>
>>> But on the other hand, it looks relatively long names, no? I am bit at two minds
>>> (as I generally prefer shorter code), but I can't find any alternatives if you
>>> really wanna have one namespaces associated with the subsystem:file as a C
>>> namespace.
>>>
>>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>>> when talking about this stuff, but it seems a detour from the code style to
>>> abbreviate namespaces into acronyms.
>>>
>>> Having said that:
>>>
>>>           Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>>> shorter.
>> This file is not related only to dirty tracking, but to memory in general.
>> Maybe a better naming would be memory.{c,h}?
>> Then we can have vfio_memory_* or vfio_mem_* prefix and rename to the below:>
>> vfio_devices_all_device_dirty_tracking_started -> vfio_mem_device_dpt_is_started
>> vfio_devices_all_dirty_tracking_started        -> vfio_mem_dpt_is_started
>> vfio_devices_all_device_dirty_tracking         -> vfio_mem_device_dpt_is_supported
>> vfio_devices_dma_logging_start                 -> vfio_mem_device_dpt_start
>> vfio_devices_dma_logging_stop                  -> vfio_mem_device_dpt_stop
>> vfio_devices_query_dirty_bitmap                -> vfio_mem_device_dpt_query
>> vfio_get_dirty_bitmap                          -> vfio_mem_dpt_query
>>
>> dpt can be changed to dirty_tracking if that's clearer and not too long.
>> In patch #31 we can rename to vfio_mem_{register,unregister} or
>> vfio_mem_listener_{register,unregister}.
>> More internal functions can be gradually renamed and added the vfio_mem_* prefix.
>>
>> Will that work?
>>
> I would associate to memory if we were talking about Host windows, DMA mapping
> and etc. I believe that's more fundamentally related to memory handling of VFIO
> to justify said prefix.
>
> Here the code Cedric moved is really about dirty page tracking, or tracking
> changes made by VFs to memory. Calling it memory.c would be a bit of a misnomer
>   IMHO :(

Hmm, yes, the majority of the code is related to dirty tracking, but 
maybe we can view dirty tracking as a sub-field of memory.
Dirty tracking doesn't seem the perfect fit IMHO, as this file also 
contains vfio_dirty_tracking_register and .region_add/.region_del which 
are not entirely related to dirty tracking.

>
>> Thanks.
>>
>>>> ---
>>>>    hw/vfio/dirty-tracking.h |  6 +++---
>>>>    hw/vfio/container.c      |  6 +++---
>>>>    hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>>>>    hw/vfio/trace-events     |  2 +-
>>>>    4 files changed, 29 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>>>> index
>>>> 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
>>>> --- a/hw/vfio/dirty-tracking.h
>>>> +++ b/hw/vfio/dirty-tracking.h
>>>> @@ -11,9 +11,9 @@
>>>>
>>>>    extern const MemoryListener vfio_memory_listener;
>>>>
>>>> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase
>>>> *bcontainer);
>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>> *bcontainer);
>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>> *bcontainer);
>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>> *bcontainer);
>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>> *bcontainer, uint64_t iova,
>>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp);
>>>>
>>>>    #endif /* HW_VFIO_DIRTY_TRACKING_H */
>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>> index
>>>> 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
>>>> --- a/hw/vfio/container.c
>>>> +++ b/hw/vfio/container.c
>>>> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>> *bcontainer,
>>>>        int ret;
>>>>        Error *local_err = NULL;
>>>>
>>>> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>>> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>>>>                bcontainer->dirty_pages_supported) {
>>>>                return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>>>>            }
>>>> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>> *bcontainer,
>>>>        }
>>>>
>>>>        if (need_dirty_sync) {
>>>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>>>> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>>>>                                        iotlb->translated_addr, &local_err);
>>>>            if (ret) {
>>>>                error_report_err(local_err);
>>>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>>>> index
>>>> 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
>>>> --- a/hw/vfio/dirty-tracking.c
>>>> +++ b/hw/vfio/dirty-tracking.c
>>>> @@ -45,7 +45,7 @@
>>>>     * Device state interfaces
>>>>     */
>>>>
>>>> -static bool vfio_devices_all_device_dirty_tracking_started(
>>>> +static bool vfio_dirty_tracking_devices_is_started_all(
>>>>        const VFIOContainerBase *bcontainer)
>>>>    {
>>>>        VFIODevice *vbasedev;
>>>> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>>>        return true;
>>>>    }
>>>>
>>>> -bool vfio_devices_all_dirty_tracking_started(
>>>> -    const VFIOContainerBase *bcontainer)
>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>> *bcontainer)
>>>>    {
>>>> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>>>> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>>>>               bcontainer->dirty_pages_started;
>>>>    }
>>>>
>>>> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>> *bcontainer)
>>>>    {
>>>>        VFIODevice *vbasedev;
>>>>
>>>> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>>            return false;
>>>>        }
>>>>
>>>> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>> *bcontainer)
>>>>        return true;
>>>>    }
>>>>
>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>> *bcontainer)
>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>> *bcontainer)
>>>>    {
>>>>        VFIODevice *vbasedev;
>>>>
>>>> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase
>>>> *bcontainer,
>>>>        memory_listener_unregister(&dirty.listener);
>>>>    }
>>>>
>>>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>>> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase
>>>> *bcontainer)
>>>>    {
>>>>        uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>>                                  sizeof(uint64_t))] = {};
>>>> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>>>        g_free(feature);
>>>>    }
>>>>
>>>> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase
>>>> *bcontainer,
>>>>                                              Error **errp)
>>>>    {
>>>>        struct vfio_device_feature *feature;
>>>> @@ -940,7 +939,7 @@ static bool
>>>> vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>>
>>>>    out:
>>>>        if (ret) {
>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>        }
>>>>
>>>>        vfio_device_feature_dma_logging_start_destroy(feature);
>>>> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener
>>>> *listener,
>>>>                                                     listener);
>>>>        bool ret;
>>>>
>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer, errp);
>>>>        } else {
>>>>            ret = vfio_container_set_dirty_page_tracking(bcontainer, true,
>>>> errp) == 0;
>>>>        }
>>>> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener
>>>> *listener)
>>>>        Error *local_err = NULL;
>>>>        int ret = 0;
>>>>
>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>        } else {
>>>>            ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>>>                                                         &local_err);
>>>> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice
>>>> *vbasedev, hwaddr iova,
>>>>        return 0;
>>>>    }
>>>>
>>>> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const
>>>> VFIOContainerBase *bcontainer,
>>>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>>>    {
>>>>        VFIODevice *vbasedev;
>>>> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const
>>>> VFIOContainerBase *bcontainer,
>>>>        return 0;
>>>>    }
>>>>
>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>> *bcontainer, uint64_t iova,
>>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp)
>>>>    {
>>>>        bool all_device_dirty_tracking =
>>>> -        vfio_devices_all_device_dirty_tracking(bcontainer);
>>>> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>>>>        uint64_t dirty_pages;
>>>>        VFIOBitmap vbmap;
>>>>        int ret;
>>>> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>> *bcontainer, uint64_t iova,
>>>>        }
>>>>
>>>>        if (all_device_dirty_tracking) {
>>>> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>>> -                                              errp);
>>>> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer,
>>>> &vbmap,
>>>> +                                                             iova, size, errp);
>>>>        } else {
>>>>            ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova,
>>>> size,
>>>>                                                    errp);
>>>> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>> *bcontainer, uint64_t iova,
>>>>        dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
>>>> ram_addr,
>>>>                                                             vbmap.pages);
>>>>
>>>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
>>>> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size,
>>>> ram_addr,
>>>> +                                                 dirty_pages);
>>>>    out:
>>>>        g_free(vbmap.bitmap);
>>>>
>>>> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier
>>>> *n, IOMMUTLBEntry *iotlb)
>>>>            goto out_unlock;
>>>>        }
>>>>
>>>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb-
>>>>> addr_mask + 1,
>>>>                                    translated_addr, &local_err);
>>>>        if (ret) {
>>>>            error_prepend(&local_err,
>>>> @@ -1147,7 +1147,7 @@ static int
>>>> vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>>>         * Sync the whole mapped region (spanning multiple individual mappings)
>>>>         * in one go.
>>>>         */
>>>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova,
>>>> size, ram_addr,
>>>>                                    &local_err);
>>>>        if (ret) {
>>>>            error_report_err(local_err);
>>>> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase
>>>> *bcontainer,
>>>>        ram_addr = memory_region_get_ram_addr(section->mr) +
>>>>                   section->offset_within_region;
>>>>
>>>> -    return vfio_get_dirty_bitmap(bcontainer,
>>>> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>>>>                       REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>>>>                                     int128_get64(section->size), ram_addr, errp);
>>>>    }
>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>> index
>>>> 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
>>>> --- a/hw/vfio/trace-events
>>>> +++ b/hw/vfio/trace-events
>>>> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>>>> "region_del 0x%"PRIx64" -
>>>>    vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t
>>>> min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64"
>>>> - 0x%"PRIx64"]"
>>>>    vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>>>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"],
>>>> pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>>>    vfio_legacy_dma_unmap_overflow_workaround(void) ""
>>>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size,
>>>> uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64"
>>>> bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>>> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size,
>>>> uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64"
>>>> size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>>>    vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>>>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>>>
>>>>    # region.c

