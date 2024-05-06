Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F0FC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zqm-00046r-ND; Mon, 06 May 2024 11:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3zqk-00046a-Ib
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:01:54 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3zqi-0003iB-5C
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb0wRY4B0i5N0RfiRZHJ2lljdMGK4KzDfakWZ6AIznD1FzDQ98bEKvGhxaNxWtgpJd+PESE5KFf+GkZ2vOlxEYxBZh5hE6GjeQzz+VSLcNc+g/ij+/jexhaXd3nC7E81zObGVrzWvg85AgoJHGCyBMXPcMce6AB8ZSOIX0175t2nuk0npon749Wj/Q+EmCgjRgm2GSR+D7mO9hwwM0g+da1HPmFvkGZl3IKx7Mhhuh3WGoRK5moi+A7hiStCQJ5KDeVIJvlYUis4vGu7Xm9XOgu9AXi+pfZ0SwkuQ36FuQa9BUkaoKIZ+EE3lFgH29EpYaZHTpD327TwZq7wZkacTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba2Z875aA9ScIQ/WV39Tua3teP8HQbR8y6Ihb3AqTHQ=;
 b=A6yadLpGyEeL+ZALc/qH7rEC7fJT5f6CuBcetebj5MjIJoF95k893YehhVvR89OLM24dHANG0aVeuBSyDM1lwQ3nyIwg7LzbhvYTszuJnT+zvooBCJ89sHRvkuF8GfRB1iCQBM9ykaDszYhNci1oj4hIjWIPcRDGyuWEbyTQfA4q+LA0BlHFvuYNuInMv9GjBA1LsLAS7aIYBHDeb+vTTvpAYsN7WKJcN0xKL1AWFZc69uOC+opdgzExTsPdQQZvpFxLVk0Y6R1V9nCVLqQTHUSWBwUn5Qg+ZXvRmdXAVqG0wtAU2HRFO4jqD5AyS6pAYjdOFpI1kI8/dqfNmho/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba2Z875aA9ScIQ/WV39Tua3teP8HQbR8y6Ihb3AqTHQ=;
 b=H8BPf+Eu4peGLAYg0hNgrhMfNhJEjNrg4AGTHJVjTzCeYxEAIDCVj7ptqws/sTNwptuhQQovSKb6mXeDMk4msdiS5Bpkd2j8/b/gcF3E8rcW/BZXZskGYV2kwqT8MgJzKptrgsgjh3UAWpMJ5ElTz5P2lkA59plLPEMp9kcw4FgS2srwnxeb6Si8RYeTOOOKHGteUNJD6XkVb1E3P9XDG5wxVSiQCDiLYxP3dGrZUiU31Fhis4W5M3iKqAlV3IxlP/Taq/jJoss/zA7Wo5mcCCDojuDwmtz/4lXJBamFZ4///0+UWLmgwogmkf1lgmGb+B55oymPl70ui7Y90T1Gew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Mon, 6 May
 2024 15:01:44 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:01:44 +0000
Message-ID: <04dbabd1-e2d6-465a-b4fb-847c3cddb3cf@nvidia.com>
Date: Mon, 6 May 2024 18:01:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio/migration: Don't emit STOP_COPY state change
 event twice
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-4-avihaih@nvidia.com>
 <1feeec7c-8b53-40f8-8db7-40ea5425bb39@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <1feeec7c-8b53-40f8-8db7-40ea5425bb39@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cb78e6-bdab-4186-89b6-08dc6ddd719c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzJhTFovYnQ2U21wam4vU1NIamY0ckNFVlk5R2R1SnkxMDE0NmdpK2Q2K3VQ?=
 =?utf-8?B?YXNEd0V0Z3hxNjYrQ1VQSk03WHJjWjA1dFNta3lydnMxME9LYWNXNXV5czUz?=
 =?utf-8?B?bFluNzZDdTBWNXd4aC8yUWhoVDZaWmJFSFhNdXAyOGVWM1RLTWVrMkJwSGxT?=
 =?utf-8?B?TUtBZDlubkU5bUdRK1hQRVlobEZPbUJGVnlqVVQ5UWFoYnhnT1prZm1VeWx4?=
 =?utf-8?B?STZmNEJDRjVnc1hOSXBSaFhYK2VHdXJuUnFmaHBBMGJlQklhK0xmcGtZYjN4?=
 =?utf-8?B?bDFwdzk1WmtQam5PMDl4NVV2U1pneFBMTjNIalF4QmZlMkYzNGpUL08wY2c1?=
 =?utf-8?B?amh5UTZlcHpCb1BvcXlXNmV5bEZOaU52a0JDNzQ0ZENYVUtzMlhDdkViWWxR?=
 =?utf-8?B?WitBamhuRFc3YWE0T0dVV2IxNjM4T08vUzlBZVVBNmlHRGRjOHAyR2tjemZj?=
 =?utf-8?B?TmN6VHc4N21ZOXVyU3AzVHNodExBWitKcE9Cam8yWWFqR3RuTC9oRnZ3dEdr?=
 =?utf-8?B?MTgrTHRzQUxkSXVkVWhBdWptcXFuSEZWT3NSY09VVmsrckNqaDdPT0ZaRlVQ?=
 =?utf-8?B?bWhkNkMyckFEeENmSkE2WkhETlQzb3dZcnpYUFJnMVZ5ZThEeDJNSEVWVzMr?=
 =?utf-8?B?L0lLdVNscjVZRHRpekN2dmYxeTczYnVKWHJ4WWVLMjcwbjVNYVRhaFgxM3RR?=
 =?utf-8?B?Y3U0NlMxN2RORVQ1VkptRmw5V1hPTGdKQVRuaHM1ZENMYWNGMzM5aS83YlMw?=
 =?utf-8?B?SGtEWjRISEZrZG5qbGpxdTFmQlhZeHdGekJ3U2FyWGRVcW93MERpZzZ6OEI0?=
 =?utf-8?B?UFhpd2ZlMlhQa1o4cloySEJZeTRaMlkrNWdxSGZpSDVCaUFyTUdTaDBzOS9r?=
 =?utf-8?B?bVVTdTBSbGJ1aGhNS29nS2RlbHI5aFJGaFZDdG5iUk5wUVBWdDJicENud2dD?=
 =?utf-8?B?WHkwTlZhajE4cnJKU2I3S28rYmFhUnRNdXFUNDhsMm5zQ0Zac1o0a09hTnZH?=
 =?utf-8?B?bFZKcE1oUWlyUWRmYlA2L1JqWWdjMzJLVTh4dWxSRnIxbGtqWkhOUHRnYngv?=
 =?utf-8?B?SjY0NDlyNVc2bHBxT0ZPcHZqYUV6WkFyc2JGSjNEUzFPY2pCN0g1NmJGUVNr?=
 =?utf-8?B?MlRFdWhYVlhwdzJhcDFIYW93QlZmZ1ZzK284U2FCNHlkazR2UUhGVWgzSC9J?=
 =?utf-8?B?bkx3RFU2ODdEcnZiSnJMTDFKVHNERnMwTS9VejJBS2ZROGsvSW1jS1VGYjNi?=
 =?utf-8?B?T3hIVVFKK3lZUGFTUk1SVFFmZS9WaXB2V3BpcXE1dVZ3LzFCcmNrYUFSZG81?=
 =?utf-8?B?SkdlMGQvUUZyaFNpWjhjaHhwOHJaaDMvQU5EY2I5V09vNTZYckdINWJQZGY2?=
 =?utf-8?B?TmI4U01McFVnTTdyQ202ekVramdoUkVvdktkbmg2S2Q4UlFZNCt4SUE4QnZv?=
 =?utf-8?B?RnFRUEpBcElnQmJSd3hqSG9CR3k2UVlqMzRCS0ppRGxoTXdEMEV1SURvT2wx?=
 =?utf-8?B?WXQ0TjJNYzdoK01lRDJ5QktPYU5DY1Zvc29UL216R29ndlFwLzYyemxMR3FH?=
 =?utf-8?B?U1EzMnVyRkkxd1VpYTZleTg0bi9xaHFCYzFsL0k5NWVRNUNyOVJNMHIvQU5h?=
 =?utf-8?B?d3hoRkkwUWJNUHdJTkZwcmNGZFRIaFBhZjJxdHdPSUxlU3h3RmVOQ1FXbys2?=
 =?utf-8?B?NjVRTnE1R0hlREFyS3FhSnlZVTJTY0YydVFYK0k4eHBIRTk0RUhWSHV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVhsRjVUZytFS1RUeG8yR2JXNXI1d0phVGFuT0JqR1h3WVVCUlRzbVl0Wk5O?=
 =?utf-8?B?emRFMUVhdXFrcVloU3hBVmJPZUZEMFREd3ViMk5TNTlIeWdwcHFwejZhZ3FP?=
 =?utf-8?B?bDFkcGE2VHpLU1gzZkNNOXorbHF1U05zMm5NbUpvdno3czJwdXVNcncxZnZV?=
 =?utf-8?B?S0pRNWVIczMzK0x3Vkt5VHYzUzBIdVA3OEkzcVFYM3BQbnVQTEpwK2Y2bE45?=
 =?utf-8?B?dGh0bTg3NkNSSTU2K3QxWG5oRjV3V2ZMcmhURzBrKzVSRWRHUHdCZmh4Vld6?=
 =?utf-8?B?bjdlRFMvWEloY2JMeXJHZk1nK1BCM3UvUlhzZjBQSFRGWTJyUlpNeHR1Zjc5?=
 =?utf-8?B?TUg2U3JYQkU5TEdEaU1ZUFo1cnk2QXZiUmZ3Mk5kSll1bFExSGpnQXBEOWRB?=
 =?utf-8?B?bWJjTU1uaEhYMTNWTXhITksydW4rbWhEcHRSTVRyNXVnZ25kekNkanM2VWNq?=
 =?utf-8?B?dWJkbi9tUnR1RXZrdE50R0c5bmVqY0hVcmQwellFMzBUL2VxSVZlV1JiTTQ5?=
 =?utf-8?B?Szd3c1BGSUJROU55MVpxWE5wNXRGRXBFSHJvQklqSlkyRHNZWmZjM3BwUGxi?=
 =?utf-8?B?UDRydU9VODNpSkhEVnQwQ1pvaEdJZG5vN2xlMi93Wm9IVzJPdUFsTmtrRFV2?=
 =?utf-8?B?clQyS3p5dVVrcmJkbnM5bUtLM3hJYTBCMndRRUo2U3AzYURTTk5vRFRqSy8x?=
 =?utf-8?B?SXFmNFZZZHVkclQ5aXEwbzNJcEJlNkNvb2V6RnJsQ0d4NG9obVBJbXFQSlVN?=
 =?utf-8?B?NGVhZnNMNTZHVEY5U0JKcUtFQVJYcERFUGI2WWp4c2didDJHYmN0SUQ4OC9F?=
 =?utf-8?B?V0xYbnpDQ2lmaWtaS0pmOXFzeWVNQlhEMmdNdk5UTTRTV2MxZm4rMFFudGdl?=
 =?utf-8?B?NjBOOVMxZXRucXJRczdmYmYyd2pnazYrY0lBdkdJM0NIU0tVRmxIajd5alBF?=
 =?utf-8?B?ckNCZ1IzMXNRVlZpWGpRL1ZSOWRxL2oza05YNUJ1bEUvUTNkcWM5dGs5bHFh?=
 =?utf-8?B?ZEo1Y2wzd3JhU3E2R2xFVjdGb1dRMVd3c2swTXdvUHRBU3JFQTBVc3JRMlBq?=
 =?utf-8?B?dTM2citLNENXdENxYjkwYkhXR1E1OFYwbVNIa0RNd3RpcG9LcGFrQk9BUi9m?=
 =?utf-8?B?ay9kbXo5QTdEYVJ6aFVHbWhYa28zaUxwZ1RicXp0VmR3dGx5blRRalV2Y1Nn?=
 =?utf-8?B?ekhRVVMxT0RWM1lWUEZkQ0JUWERrTHdScmpFVkljS1V6enVORmttaHpRZExP?=
 =?utf-8?B?M2dZNTVRZ0RlVVRSTnRPYkZtZko0Q3ZsNVU5N252cW5jbkNJWCsxOFlIUGQ4?=
 =?utf-8?B?TFBaOVo2YW43NERCWmh2L0tUQzZsVUxwOGZtNGhwQ2ZZMCtSa0JuQ3g0TU5Y?=
 =?utf-8?B?QXR2c1B5emtkc2t3aHNNRmVOZWVmdVJFdGZvaWU3ZlM4NGVmM0FaZHVxM1dJ?=
 =?utf-8?B?K3B2THdIYm9NaDZRb1JFdHJuSWhiOE8rQ2FYcUJib1lQTCtpRHNmdEVzMXk0?=
 =?utf-8?B?STNHMjRkZW43ZWlQdU5ua3RTQWRmRThmdXdtNk8xZVNmcy9GV2NURlpPanRi?=
 =?utf-8?B?V09XUVppNVROUUg2UE9ZcWZ3dnYrc0EvRXE3RUdFUjFBZEZkVVNyRjE2eGRH?=
 =?utf-8?B?ZEwzNnVhRk9iaGFaVlc1TXlkdkhvNFNDdys5QnFKTXlmZ0JDMlM0eTV1a0xR?=
 =?utf-8?B?bDlNTytyVG4wQ0NBM2x5UFY2QVVGN2ZyQ1FReVZ0RDM3N1V3MkdtZTAxWFdX?=
 =?utf-8?B?MHNSZE0xRE5zTmxEeWp6bURsL1dpUDRaZzRFS0hRbW1wdTd3N1RkRExkdnlO?=
 =?utf-8?B?ZUlzVnMzTitCWHJ0NVI1Y1ZzTTdFdGp4eFNEY2duMGR2TmlOYTFuRFpUbGtP?=
 =?utf-8?B?ODJreWZSWEpSS3lGMVdlRm42czRudG9KSkdmRHQxVE5YLzNNTjhWbmpsdzBZ?=
 =?utf-8?B?TktOQ3luMkZSMDdEQ29hdnBTakhTT3VGVXpuNCtlNVdEWi95S2Z3TFBwNEZ5?=
 =?utf-8?B?SExVRGhnQysyTU1nVFpJSHZqbjljRk9uckpSUkdlU0x3Rzh2VGJYTDVvTERQ?=
 =?utf-8?B?dlAvZzRmM0htV0puQjlnc1ZEMkhJejIxK2ViUDVMc01DSUFIOG00Z1NHdnBN?=
 =?utf-8?Q?uD9AF2O+0HacWYySJkTgx+35L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb78e6-bdab-4186-89b6-08dc6ddd719c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:01:44.4196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvrYOldxCujMVwwOux5XIywnTr6BAXTrIvJ1Nz0Tb9AIcb1dxtzbEVAIOgcRzJcAM474UmtZ6JepujdWZSb7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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


On 06/05/2024 17:39, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 4/30/24 07:16, Avihai Horon wrote:
>> When migrating a VFIO device that supports pre-copy, it is transitioned
>> to STOP_COPY twice: once in vfio_vmstate_change() and second time in
>> vfio_save_complete_precopy().
>>
>> The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
>> transition. However, with the newly added migration state change QAPI
>> event, the STOP_COPY state change event is undesirably emitted twice.
>>
>> Prevent this by conditionally transitioning to STOP_COPY state in
>> vfio_save_complete_precopy().
>>
>> Note that the STOP_COPY transition in vfio_save_complete_precopy() is
>> essential for VFIO devices that don't support pre-copy, for migrating an
>> already stopped guest and for snapshots.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 6bbccf6545..30a2b2ea74 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -591,14 +591,17 @@ static int vfio_save_iterate(QEMUFile *f, void 
>> *opaque)
>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       ssize_t data_size;
>>       int ret;
>>
>>       /* We reach here with device state STOP or STOP_COPY only */
>> -    ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_STOP_COPY,
>> -                                   VFIO_DEVICE_STATE_STOP);
>> -    if (ret) {
>> -        return ret;
>> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP) {
>
> Shouldn't we handle no-op transitions in vfio_migration_set_state()
> instead ?
>
Yes, you are right. It's better to handle the general case in 
vfio_migration_set_state().
Will change it.

Thanks.

> Thanks,
>
> C.
>
>
>
>> +        ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_STOP_COPY,
>> +                                       VFIO_DEVICE_STATE_STOP);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>       }
>>
>>       do {
>

