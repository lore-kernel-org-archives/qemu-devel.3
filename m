Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF78D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 07:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5KUJ-0007ar-UR; Mon, 28 Oct 2024 03:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5KUH-0007ad-UX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:48:30 -0400
Received: from mail-bn8nam04on2061.outbound.protection.outlook.com
 ([40.107.100.61] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5KUG-0005vK-1k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:48:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgDE4085ttJ119mHS2ooq1qpH4Xr8GleG7pLsjjjqbErfWJL8tOtTNfCSnncvYl/AXdyK7CuCh4Ue6UQ+u5J9ljC+ASgjbeeEkKV217kvH7SoAozyUUS24Nzg07lTmfi9NzuA8aaudl6dqXSA8NYyxInMElGt0EVI5nCjgv7i2Lg2rfcQTi0EO60jFf0rAqknOnManvmnoVXFC2s8fVkNBo0nhGEeeXCrhj57JE1ppNjeAMY0e4g4u0ASDruvWLLnp05/x8aq/uzqsAL0B2Ukty0hHaJw0nHUyEZ+Hkd1T5tQhTWluhMs3I1YamK9SaBYguLWghOlw+96K+4z1nMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZp7njGal3D00WWOpVtn+9avy4JlmmoOuM5+u7dQxgU=;
 b=NbBtiU4v1oE4NMtLuYLQvdHea0l1G12QREl0Fl7jUQt6nUkK/bAzq+mc7GD9Ozff6/3ZbcYGpRJfl+WscJwxkRu2JXUXMe7fZEp0YHwjeHNiT5yOK3yOahlEELjjy5QbUXmKF2/SdKJ36VtSYA2HbYWwJmbMAeZpoTF95XDFjVbxB9Mv0HVxPAFpeJC+xDL6Sxjh5BkZNelAJhZNcNB2Bb3mBEfCRjpP5ajxfp2o04hw/icT3JfWdIR8N9cEDyXpK7W1HwdNO1pBFgUfN7DF5DbblqJgUZtAK0zqvrXzjf88pVl6mmM6UpJvinZTr1qxhm7BID0h2EVBl6Hy/CwtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZp7njGal3D00WWOpVtn+9avy4JlmmoOuM5+u7dQxgU=;
 b=kFSAmAgCFDHiFm3V7Mz6jzhQZN5y1cgYab21B4LrabZSltC+iwqx2R79kBRUxm8tkX0E9fF6fQo5ZVhzoSPj0bkekPJZ+xIXATxsIVT+chayA4sABYfSWFU/q1QuKI0FJtMfx+bmgN+oMaCXG31AJiFPLurSSv12qxO+50ogXvFvWQgZ6oCOd15/gb+BQwuh6/IqwpWjDf0Vkwml8jyzXEOn+UkPUdozZOuYBzt3IBRs6iouIck0tjlWP1/tqSHwcNyJ3vUabPvnx/nMM2VKvDDehSGSyFVwjyyE2IQBe3uNePtcwUxzzYqGrS2K1KlnUZrslUrwSAWyTOoWcNYkHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 07:43:21 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 07:43:20 +0000
Message-ID: <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com>
Date: Mon, 28 Oct 2024 09:43:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20241024213056.1395400-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: bc84fada-436c-4032-d029-08dcf72431c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?endWUitvbUxaZHJqT0dhRS9IRjlIVVVOcWNvMXcvRHpFR29ielhtVzdvQjFv?=
 =?utf-8?B?MkpscFYxakRFbmM3SmVZVDhWZ1RWcXdNbWhZc2pCb3llVVFiNU83R3QxQnhC?=
 =?utf-8?B?cGlRWm9jenZjQTVSY1dyZGljb0pjUE5ZTWxBSXFITEtYcWV5c1NXK2ZYM2F2?=
 =?utf-8?B?NCtXeVFqQ2dWYThiTHR4bzJzWkRZYStyTmxzRm12KzJaem5FUXlSbTZjTFRv?=
 =?utf-8?B?aEhVTisrd0RjWmVqaWM5cGpiVk5SRTJtcTlxMVNDbC9EdEtNWE41ZXFGV1VI?=
 =?utf-8?B?N0ZIMlMrdkU2M3lHYVlTTUJmcllYc3Z1YkdEc1c4aUpZUzEzYzJ3UTROdmxL?=
 =?utf-8?B?T0YzczdZeHVTQ2JmSVhrbi9XdGo0UjlxcWlORUdrOURMZ1NVYWFrSnR3Y0FU?=
 =?utf-8?B?U0FxU3BYbFhJbXNPbDdkMzZEbzhzVGJXdlZPOHFUSTRyR01Bbi8xYy9FLy93?=
 =?utf-8?B?NVVpNXZjUzRQQ2JHb3IxdWFUMUxVYi8zYUx3eWFQSTFxRm4rQzZac2F6Nkpn?=
 =?utf-8?B?N0hqYXhTV1o3MWxZSll6c3JYVExydVJ1RjJKVG9RK0Q2aVRzQWJvQzlyVWxG?=
 =?utf-8?B?Z3A3b1ZKQ0dEK1VCNGM3WlBNY2VvblNaWGhIUjVtK1p0VG1tQVQ0VE9Pa0g3?=
 =?utf-8?B?NHI2dDk1cHFEajZrVEJYQ1N5djdwcjdtOFFscU1PUE1Ub3NaNUtLZWhzT3Z2?=
 =?utf-8?B?U3gydjNpSk1WMDNhMTNmZTVib0VBYWNPbjczOHFuazV3eW1QbExzcmRCdSs4?=
 =?utf-8?B?R2tEOFZpMmNnRmVOZnhhaElZcU9sYldHNlNXOUZqeGdyQjVuQjJ2NUtaOE5p?=
 =?utf-8?B?QWFCSVVPbHFVVlZQSjdqdTZHVDJoZk5DdTFuSC93MDduN05CU2M4d0JiSGdO?=
 =?utf-8?B?Mmx3ZVF5OW5CeEZKZndIbnRSQitJL2psNGNsN00zQjBNU1VTSXNWMnZ6Wi9L?=
 =?utf-8?B?YWg0Z0xkcCs1NkRqelFTWVhvRm5aOTdWL2JsTS9GYVpxSHkzSWt5UVFmL1pj?=
 =?utf-8?B?czlxNk8wTjVMV0dIQVVTRjYrNlUrTks5YmM2QnBSNE02UWo0UjZWRE8wb2pU?=
 =?utf-8?B?N2NzTHdwRWQ3ZWxDUk5nekU5NlhzamgvK0FFZG1abVZBZGF0REk2NGYwVTVU?=
 =?utf-8?B?Q2lQUytvK1dGRThBZE9YckhvZWt1UzUxdDFuSUljazlwSnpNQlFWSEE0NlRh?=
 =?utf-8?B?bzNoU1VFT0k4Y3NIMmNmTllwL1FiT1NnWGNPSTR4TFl3NFJRNGhObFVLTGZi?=
 =?utf-8?B?RFFZd0MramtzVEI1U0xHWkRPMngwT1pNZ0pyblFBNVhldmxPTG5EQ0laMGtY?=
 =?utf-8?B?N2RwUm90YiszWHdoOHlaaDB5QXpESEVyQVVUcVVsMWVta2ZOMnBGa1JKdDBK?=
 =?utf-8?B?WExDMHp6cGFBVklJdGMxNWhWTVQxOC9ncWliREJNNVVnMXExczYzblZtSmZO?=
 =?utf-8?B?aGhXcFZrWXZuRm14VmZWcmpjK2dCWXhWaGtrdi9jcXRpRDBKcWJNUE1kRS9m?=
 =?utf-8?B?MjBWM0V2NjNGMy9CaWd0MUl1bEZ3S05KdjdXL2tNM0l2UllPdHVrM05EcWlX?=
 =?utf-8?B?VmdnOEJaNzBiY0J6WmI0SjhyZkoyNVAxV3FrcmZkcE80T2FiakxHbHpwbC9I?=
 =?utf-8?B?RHZZM2tIdktuMHNuOGVNT0E4bm9jRzFseHJqZjIydDFIVlMyYXBGeFZBb21j?=
 =?utf-8?B?ZlZSZnN5REVJcmZkYkRXQkZvQ2gzay8yRU14RXRaUFlHMHpka2RBT1NETit1?=
 =?utf-8?Q?V/3EuTIinrsVVnIpwmC8gVyXEJMzJyR6HReFHen?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmI5UVZIVVRvbTREQ1pCSkE5Y2w4Yy9OVjdCTG8vdUwrcjU1M3dSTnlHK0ZS?=
 =?utf-8?B?MDJrZkRTUTNGU1RMWEhIdUt6TXNDTjV3WXBhTTVaZEhaQnVmNE1POUh6dWpH?=
 =?utf-8?B?RGhtUFRjU2xkdVkxemtQZ3lqRUVjZit5L1dQMXRXWnk1ZGpKTm1QYlVBUnk1?=
 =?utf-8?B?RTFmeDVZYjcxSkUxOUMyVm1wMGtIZTB0UXlqbFg1emFmSXp5d3M1NSs3bmJC?=
 =?utf-8?B?N2ZoeS82anp4MXk0Z3dzUTcwbkxCVDR6N0kzeEZCdFdyZ01nQlNuTjJUdzc5?=
 =?utf-8?B?eVZrc09VbjhaYW9xT1pPUWtJZzQyY2pxWkVhVnpqc1ZhQmp1SEpCVHdwWFhw?=
 =?utf-8?B?MFJTd2V2RjU4ZFpVSHZpa1h6RE4xRTB4ZVVoa1lsK1V0dHdXcURYbnB4L0Zn?=
 =?utf-8?B?Y1R4dWY5a0JBMnJWdEFyZGU4UksyS2ZvNDBkaE9ZYWFqR3c3MnFteldHNnZs?=
 =?utf-8?B?YXJLbmVFS1p3OENTOEJGbWVTdjJpQ21CazhHV0d4NjFMWXg4TlFzVmt4TTJJ?=
 =?utf-8?B?VkRzUlhKQUZzTHQ2bTQ2WHBDZTVvM2tWYkpJbUJITnBIS05yenRGYmttVlIy?=
 =?utf-8?B?OWlqZlZzd2IwM2lqdzdTd21ZejllL1NFTlhBbGk5QkhKd3I0VHBUUFMxa0N6?=
 =?utf-8?B?bkJ6UGVBMDBiU3ArQWIxSnluTWRkL0U3RVRxWmRPQXM3QXJLQlR6Vmh0VU5Z?=
 =?utf-8?B?eDlTYnhkRm80WnJwdGNrdUtxN29ESlhwTys0K0ZNbjhBcHYyNktTVU5DOERN?=
 =?utf-8?B?MWNyOTcxbmhFZjh2UUl0S1F4NnFWNFpCMFRZMERJZ0VzaCtwRUx1djhrQnBm?=
 =?utf-8?B?Sm4rSStmSmxaWnBocWR2T0tacnMvWkx5SlFPcU9KM1hhdGNndkVKN2x3M3Yr?=
 =?utf-8?B?TnZxQk4xUnhha0tSNElucnYzTVZrV1JQMVBLVHAzYTZPamVqOFMrZndDNzdw?=
 =?utf-8?B?Q2hQeVB4SnRoTDAwWlljYzdYZjhnS2pSNXhJaldkcEJtTHNBTkR1WHgrT2tk?=
 =?utf-8?B?NTMzdnhMZVZleDdDQzh4QUlIS1I2L0dHeWI0MVJNSGpWOFpoOUxRMU5FMU5M?=
 =?utf-8?B?ejhzUUl4ZVNoNHlTYmFiUktHSFBDS0hJMDd4UGVaaHFSUGRaQkkrdUFhenFG?=
 =?utf-8?B?MEFlSHNjUDl2b0xnbE5FWjQrWkEwMGNWWEtoU2E4WUZIanl5QzBJbEQ2UUEz?=
 =?utf-8?B?MVQwRjhGZmg5N2RSREY3b25JQ1E3Ly9lMGtOTmNyVVNNSzRNc1lhdDJvdVN3?=
 =?utf-8?B?aFJWUE5Da25QSWFRaFJSNGZIVkhOM01kdW1KQzEyQkppUC85dkV5UDE5ZjhU?=
 =?utf-8?B?VGFDT1R1cXNZblJqUS9HR0pYcmU2blQ3anRtM1RHMURPaTFVSjdHYU5kbVlL?=
 =?utf-8?B?SlBWUkgrVGxiYyt4eXVJVDFWTDhYUDIrVEFncEFnQ3NkSS9FMFRnYVE5VDE4?=
 =?utf-8?B?K0NYd0lQQmRjTTlUb3c0U0p6SlY4eFFPQlo1K2NnUEtmNXRGbXMwdkFYTjcx?=
 =?utf-8?B?akN2d1hqQlhRY2VwRlRTT1ltMHZmbmlCY0pZb1NGNGdmcDhXMStNZmtUV244?=
 =?utf-8?B?ckRvSDUzMkZ6SUlGMENjUWFoZmRUczRPVUpFUDRpOG5OUm1tcitHU3FFdm9I?=
 =?utf-8?B?czVha2ZCaE1QTGFDQVV6NVNFUmROU25ZWDByTTVtcEdzQ3R1SDJoa1JycWNs?=
 =?utf-8?B?QjUwQ25UYnd5eEtRRVZiZ3dBMldrcWFVN2h3aHY3YnBUVVoyNzNBVVljOFNJ?=
 =?utf-8?B?ZlZIN24yaWhxODgxSkNPNjNKTEtaU1laa3lPTDNQV09FREFJWGo3eFNab3Rq?=
 =?utf-8?B?QUVidjdGZU1sTnVTQ1N0NGJud2JuK1UyNjM5dHBVSnREOFhtVXdaRTlrOUQ4?=
 =?utf-8?B?UUJMZXIxRFJFd25FQ0Q0VTZXWE04ajNzckNhQWVrVU54VFQrU1BtN1p3SnlK?=
 =?utf-8?B?NU5oeUU1Z0lieVFNWkE1UUhMWmpSajBUODdJY2FCSEJodGs4S3VZWU1SMWM2?=
 =?utf-8?B?RHdYb2tGVC92Ym85QzdvQ0tZOUNRdVdtRUlKcm5QV2VEcVZWeURxdE4wUStm?=
 =?utf-8?B?SHNSZy9LT1Raem0xYW1zd2o0Z1Z6Uy9UZjgrMzFKYm5JZzFESkVaRXZKUUhy?=
 =?utf-8?Q?hZ2izs/0rFsW7WTbG8xda3THX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84fada-436c-4032-d029-08dcf72431c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:43:20.7847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOouC4tYxPw9gD+92DQ0TR6r0ui4CvnSoZh90AJkjg28ODJCp6eFDEcrxxlcNfbnMoSfNEkTvL3l0XvtQio8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
Received-SPF: softfail client-ip=40.107.100.61;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 25/10/2024 0:30, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> We have two outside users of this API, so it's exported.
>
> Is it really necessary?  Does it matter whether it must be
> ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.

Actually for VFIO it does matter, because we don't want VFIO to do DPT 
log_sync in SETUP stage when DPT might not have been started yet.
See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration 
SETUP state").

Thanks.

>
> The external user is trying to detect whether migration is running or not,
> as simple as that.
>
> To make the migration_is*() APIs even shorter, let's use
> migration_is_running() for outside worlds.
>
> Internally there're actually three places that literally needs
> migration_is_active() rather than running().  Keep that an internal helper.
>
> After this patch, we finally only export one helper that allows external
> world to try detect migration status, which is migration_is_running().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/migration/misc.h | 1 -
>   migration/migration.h    | 1 +
>   hw/vfio/common.c         | 4 ++--
>   system/dirtylimit.c      | 3 +--
>   4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index ad1e25826a..c0e23fdac9 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>   void migration_object_init(void);
>   void migration_shutdown(void);
>
> -bool migration_is_active(void);
>   bool migration_is_running(void);
>   bool migration_thread_is_self(void);
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 0956e9274b..9fa26ab06a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>
>   int migrate_init(MigrationState *s, Error **errp);
>   bool migration_is_blocked(Error **errp);
> +bool migration_is_active(void);
>   /* True if outgoing migration has entered postcopy phase */
>   bool migration_in_postcopy(void);
>   bool migration_postcopy_is_alive(MigrationStatus state);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index cc72282c71..7eb99ebd4d 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>   {
>       VFIODevice *vbasedev;
>
> -    if (!migration_is_active()) {
> +    if (!migration_is_running()) {
>           return false;
>       }
>
> @@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>   {
>       VFIODevice *vbasedev;
>
> -    if (!migration_is_active()) {
> +    if (!migration_is_running()) {
>           return false;
>       }
>
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index ab20da34bb..d7a855c603 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>       int i = 0;
>       int64_t period = DIRTYLIMIT_CALC_TIME_MS;
>
> -    if (migrate_dirty_limit() &&
> -        migration_is_active()) {
> +    if (migrate_dirty_limit() && migration_is_running()) {
>           period = migrate_vcpu_dirty_limit_period();
>       }
>
> --
> 2.45.0
>

