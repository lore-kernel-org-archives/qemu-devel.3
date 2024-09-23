Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B30CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 12:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sshoi-0004na-6m; Mon, 23 Sep 2024 08:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshoZ-0004lP-IA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:05:20 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshoL-0001CH-9R
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJg8MenYfqg4sIsJqRUbknJ/iCJ2zXid0egcQI8BptpETmsDdE+K839+jE0W/JOqroZ2HM7GHFoLDWVsxxCT7406YfOiTwCXcpalAporRGcwo8nwtguQ3SbHBxzyWM7TfWC/Jo0EuDfaIdrcCzcyf2Mopv4pEZns+Kl/QF5gDheMVWu2nYsoIjMzYpwPAHPIuqeCRjwP4F5V/w5OzAQEVTsR681E4jRLmfGsqveedo1w7R1vYHNW+47dl6SfPDGJN3iZS7CGNwBxVguvX81dfXJyeh9HSSPVKWZQZNTUGKvxnQcr/guZkntbXc1B7x1qYPILi9RuI7lSpcvEjiKv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDJHQFI58kU6V/3kRs3BF1nulq8f4Gh19kA3XxnfUaQ=;
 b=RYsdoZbImkueRb/WuhNafpjljkkmLqjjnt6zUCZzVWVYTXzBXTuAtdq2TIiqx7+ldxBvq7JEXwovk1p59RA+WBwspFZaAD1rpXHhabDfUdnHTtaXxKOjTlk2FbukTixrZ6DqkQ4wQQzYLE//CVtA4HDO14Y4jR37M3558s+yrK/MxjX1JjYfaonzl1cbRy4GW1SWSM9SYNCGTPjB5JGmtWQXGFquKrdSSzTrxJjqYtz/BHlCKbwS8i/1KAky/DJwSX7DG8ytMAU5nXYtXaRzpfwO90Ew0hKG1sjmEsU2atxy2E0vI/kebDTByMB0MgrX681hSjYCKM4QEaVyuTED1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDJHQFI58kU6V/3kRs3BF1nulq8f4Gh19kA3XxnfUaQ=;
 b=FGkJGwkvnUr1w+MTZTe11Mj8vjmZmZt0YjDOJU9yGCgWhvGBtciIAKYDhEBtl6XgMV06IuZd7rtJGmEy16lFtPQXC4tLdITGKAd6Beg4UeBtXRyKb5MtTpu8VwIEpR2qxVcbae2y5ErQp9eiBjcMcWbuBcoEg+zax7N/ft64XFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:04:23 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 12:04:23 +0000
Message-ID: <cb40305a-b52c-4b6f-8469-b01b7e12f81a@amd.com>
Date: Mon, 23 Sep 2024 17:34:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 5/5] amd_iommu: Check APIC ID > 255 for XTSup
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-6-santosh.shukla@amd.com>
 <34eeb085-22f8-4e7f-9814-8cae599b9747@oracle.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <34eeb085-22f8-4e7f-9814-8cae599b9747@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: be89a14d-2ec4-456b-397c-08dcdbc7dd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDU0NXdTMGNJN2ZCNVE1cU1id3FGbzFMaDN5NzJBV1BvOUtaMWY4dXpqZ1RH?=
 =?utf-8?B?cGlkZ3FFVlMzREVQY05mVjJOMlhJcXJmM2JEOWxDNXdERnNKTXo0QVkrUGdx?=
 =?utf-8?B?dDZIVm1XcG5RaTN0MUFQQkdKY00weGkzSnN3VHZvZ0txQmNJZDJYRWRyaHk0?=
 =?utf-8?B?djNaSmc2YkJPVkQ2Y1dBbHhpRHBuU2puZVNXV1JVeHlVTm9RZUxQU1VJOU0y?=
 =?utf-8?B?S2F3dThEdXRVbGM3NHB1L1AxdFA5dWtUeFdqd1JNdW5WMFg0bFMyVTdHMUg3?=
 =?utf-8?B?K3VEbzcvNWdFcmJTQ0dPamowNUlQeEluZDhNdnF0N0U1VVZYMFFseWdlVUVQ?=
 =?utf-8?B?MkxqT0piSkRUSkR1SmZxQlhUS2lyR25aVFZRNHFMMjhrR0FCMWlyQmVpKzZH?=
 =?utf-8?B?SUxjdEVWbytncTBETHdsRUN1amxkbG8xMitVbFhCWXI0Y2FtWFdyK0pzcHNu?=
 =?utf-8?B?bjlFWi9BWVVlOEZhV2xxL2RVbjFTTFlhSXVHS3lYdkJ2dFdjcDBRVGc2MzZj?=
 =?utf-8?B?SzU1cjYyR0llcW5Pdzg2NDZnLzJuR0VWZnVpV1ptUFBKOWpYNzlocGJseDJ3?=
 =?utf-8?B?YTdHRDlxOWJvZ2J5YmJ0L3JPNGZwUVY2Z3VkTVkrdjA0R2QrU01laHlWUXFt?=
 =?utf-8?B?NytRTFJiNDF0akxBdFdWK0JkNlZWWk9iSWJDaFRnaXNqek9WS1l2SkZWZTZ3?=
 =?utf-8?B?Y01ZS1lQQW12aHVCT2hDUnVWUHBpTEw1SzBHNzRNRndWTUpTY29zdElxcVll?=
 =?utf-8?B?ZlJqMzlvRFJjMEEwRzlXdkxid0o3cVAwQW9xa1pza3RuTDRPcGFhUVlOMU00?=
 =?utf-8?B?UVloTlZvOWREc1JQSU1RUWs5R3lOZmNtMlJPZFZZUld0Ynp4V3FpSDVycmov?=
 =?utf-8?B?T0xIMmlWbk81TU5WZURCNXd4QTFTR24wYkVxSkFhN0RmTC9DK3BWejEvQUo0?=
 =?utf-8?B?TDIrTUhyTzFkd2lWblBremJPTlJZb2d1amc1SG0wWkJVYTZhYUZYZFBaOXlx?=
 =?utf-8?B?TFNPMEN4QmhJa2Nhak52VUt6QlZCckVOVGxuQTVJaEdKT3ZmQWtCdXdZelJu?=
 =?utf-8?B?eHpHcnVIaFhJRVZ4OFBSdXV1Z1NXNDlON2twbElZODRRcmdYWDVCMzBEbEc3?=
 =?utf-8?B?V1ZTcVNqTmNJNXZkeHBGSTVEVk1lL2tMSXRlbXVvMVpwVUp3Z3JjTWRUUGx4?=
 =?utf-8?B?TVJkYmRXRnJWTGhORXNkczBYbSt5eU5xTHh4RU9PR2FVV1FtYlZiOFRQUzEr?=
 =?utf-8?B?M0RwTHVvV2ZpY0V3UFFLdFRQSkFoajNJMWN0ZHhqTnZHOGMydERZN3FrZHRm?=
 =?utf-8?B?SFF3eFBpbEhYOWtvcWFmNC9wM1QrWVI1QnZxVWJnekR2bFVJdkw4MTdObEt1?=
 =?utf-8?B?UTdPU2FIb2pqNGFJZ1dGck5PK3hXeHY4TmFEV0FEKzBNV1dWNUpLN1hISFNv?=
 =?utf-8?B?R29ZZ1labmVycTVNYVEzdEFMZi9OelpIUUVVWGxsWktXZUJHZnVCUWc2bHgy?=
 =?utf-8?B?eDFHZE9IV2dzZjlpblR1bEJITERZM2tCWkVFOTFDbmtuWk9xMU1Md2cyYzVC?=
 =?utf-8?B?c1pGenVwV0tlZ0x1Y29LbGRFTnpLREdZZzFFNzBOSGdoUjVoNG9VTmZNVHFT?=
 =?utf-8?B?d08vemtRMFhFbmNkYW9hK0tKYytDUms4YUkwL1lLSk1ZdTJZNS82Y0dJMGVG?=
 =?utf-8?B?ZjFRVm9KV051NFFwN01rWFk3OG9YT2VCUUJveGF5V1YxUkRod2NUODNjSkRk?=
 =?utf-8?B?QzVWdEVXbk9hMHRiL1JONk5pdDFJQ0x1L0YxSklGVEtEejRJeEIxbTlGQlAw?=
 =?utf-8?B?VnRZeW9oMEY3Zk44cENBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnI5cEZ3Ky9tSUF1TFVyMFR1aGMrL2lMWnBHV2dML1RLTkVFQy9wek10Z3Fh?=
 =?utf-8?B?NzVMaVZBR24rMUhBUWlLSzlDV3lldDVEbnc4QjVZOFlmM2t6T2NaU083bHFL?=
 =?utf-8?B?VmszS1ppeUs1djVObWNrNCtSKzJCa0l3OWNiZmhYdGZpYzF6dzF4RXFSaUho?=
 =?utf-8?B?Y1ZZUkRRc3FhdXVXWHJZL0c3aWIvVjlUUnEzTXpsRS8yYkF4U1Y0bWtkdmxr?=
 =?utf-8?B?R0lmSGJiSmxRMjRJY2VLTjZ5UjI5b1pjWnM2N3R1b1lUbVZEQU9hMkkvRGVZ?=
 =?utf-8?B?cHFjTmcybkh5OE1hZmZ3V0ZycDI2cmduMmtacjBxOUJ2cS9VN2VLRXlSV0ZC?=
 =?utf-8?B?cG5vY3hRczBWOWVRd24yQUpobUxGeXI3N0dUMUp4VEtsTmhNMWJWR3hWczR6?=
 =?utf-8?B?TU1JYUF2WGV1M2duTUNFOXRFdHo0b3IyZG9oV2EwYkRMNk5mMkhFeVV0UTJm?=
 =?utf-8?B?WDY1bzZkUXNqMVE0VHRvby8xejUzZjdVOEpicjlEMFAzOFFXOEduSzZEcGRH?=
 =?utf-8?B?Z3NlVFlGMHF6QU1lOWRDaGZQc0JVcGh0NWt0WFdvUUVodzB3ZXU4L3B6QmVn?=
 =?utf-8?B?K2lyNzN5V1RiVGp1cTd5RzR6MGVCbS9XbnV4UGJzOHJtaG5zeGU3aUY4aHBs?=
 =?utf-8?B?N0x6RG9oZ1ZIWFJmNUpveW9rWGZpKzFlam5WeHNLUUNpWWg2RzVYaVdJWEtQ?=
 =?utf-8?B?VnhRcHhZYXorM01PKzJUSkcvZk9Ga0UzaE5ESnhxSU1qZ3B5UEwvbC9wUFJt?=
 =?utf-8?B?aVpIS0JPZEhwV2N5RkFTWnJzVnhWcGNGSC8zalhLSmdFOGVoL0FJazV4V0Nk?=
 =?utf-8?B?WmEvS1lpdXdwMnNMdlBLdGRMamRnb2dwd1dZK2JycmxkYWxBcmRRREdmclU0?=
 =?utf-8?B?eUhtakdKQ2tEUnJzSkhjbDJLRWlJc3hTL3JINnRBcTdRMklISnRzKzJVMVV2?=
 =?utf-8?B?U0VPN0xhRHVFSllCZEYzZGpoSjVJempBRk1wK25TU3JwSUlZOERScTR0WHdo?=
 =?utf-8?B?TjRZb0JxRVBGN1JOdGRVQlpDNzI1NncwM0h4VFBlK2lCN3pCcDdzbnNjTnVp?=
 =?utf-8?B?bGE3c1ZqZzk4S0NpSEVGQk9IclJ5VCt2TGwyRG1oZHNhMmRKbmo1TTlYaVp4?=
 =?utf-8?B?ajhzUEU3S013Z21qMXE1dEhZYjBxcHRIWm5xNnlPSXBEaXhxWXk0Rzg2blVY?=
 =?utf-8?B?WGV6Qi8wSFZXNkx1dVRwalpUclRiSldIRXJmMnNtUzB3SHFkaDBOenAzeVgr?=
 =?utf-8?B?bEwzM29kNStZMExiR1kvYjBFR2xyd0FLM3JLOWU1M3cxYWZuM0VQbFE2b3Ru?=
 =?utf-8?B?NDNwZUlLWnVKZ1VsZDVWRXk5N1Ayd043Y1BNelJzeDJVRVBuU0U4dkdKMGN1?=
 =?utf-8?B?VUl6bnVMRXpuQ3ZhaC91NGZQRitzKzZFcldQWUhyWG5uZE1SV2NqdHhFU1lw?=
 =?utf-8?B?N2d5NzFmUVVpQm1yMHEwOUZKRTM1QWlDOHVrRTN4dVZsQWM3QlcxYld2RTJK?=
 =?utf-8?B?b1FjUG9vV1RqWVgvaGorZ0tTNGdTS3FZUlNUNVUwZFN6UmVtK1I5UFQxcGNl?=
 =?utf-8?B?UEY2ZTUrMHBhbW4zWnpmUitFc0dZelY2cHRyVVc4RHg4akEyZVNGNjhVSkJC?=
 =?utf-8?B?b2hTNDRTZUE5NHVkU0Z5RFdoMzBoOElTSnZiZUIvSExESUJUNHpCSWZQYVhT?=
 =?utf-8?B?TXFtc0V4TklVL0ZTTkRVTnBpdVBNcksvZkRUMFlwY2NwUVpnQmZRbzRrNWVR?=
 =?utf-8?B?d2M5UVM3cnA2TWtYYnZYdWtieEhsYStBRC94bmprMGpBS0xNd3BDSVVvWnFH?=
 =?utf-8?B?QTN2L1MrY2hFM2tyY0dOMVhUbEsvYUVWRlV2UlQzbGt5Qm5kOHpUdkFSWDVl?=
 =?utf-8?B?Zkk0TXdkTzBpdlpiNFhnczNkMnpNcW90QlpTTFVRNnVZYW1TWUgwRHhiaFpC?=
 =?utf-8?B?aDNuUERxQk5kb1dnYVhjSE5VTHJIVEhpbTFiZ0pSY2hLZFpTM2lWU2ZlREJy?=
 =?utf-8?B?TWdoTVNQVkhyQjNqUHQydmxMY1ZENVhPcVpBemZjWlZzbUFuTkE3MjFZYTZY?=
 =?utf-8?B?SlcycHhYUFdvQWVXK3dUTVVOdkFXKzZZS0kwKy8wV0tISEZhWk5scithbXdF?=
 =?utf-8?Q?TMfLCsxnpQehUbzae1DtOFHc5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be89a14d-2ec4-456b-397c-08dcdbc7dd20
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:04:23.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFeIXeKzU4nG6JJZswYq4Wn7H0a5Ef1+GbPgWafYlmb169HmlkcGtaAWFzdlv7BOEHGf+bsRPhi6pMf1zaMHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.417, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/21/2024 1:56 AM, Alejandro Jimenez wrote:
> 
> 
> On 9/16/24 10:31, Santosh Shukla wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
>> to support vcpu w/ APIC ID > 255.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> ---
>> v2:
>> - Fixed non-kvm build issue by adding a check for kvm_irqchip_is_split()
>>
>>   hw/i386/amd_iommu.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 9095146525e6..24eebf053df0 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -32,6 +32,7 @@
>>   #include "trace.h"
>>   #include "hw/i386/apic-msidef.h"
>>   #include "hw/qdev-properties.h"
>> +#include "kvm/kvm_i386.h"
>>     /* used AMD-Vi MMIO registers */
>>   const char *amdvi_mmio_low[] = {
>> @@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>       memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
>>                                           &s->mr_ir, 1);
>>   +    /* AMD IOMMU with x2APIC mode requires xtsup=on */
>> +    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
>> +        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>> +        error_report("AMD IOMMU xt=on requires support on the KVM side");
> 
> Use "xtsup=on" on the error message, "xt" is not a valid option IIUC.
> 

Yes - V3, thank you for spotting.

Thanks,
Santosh

> Alejandro
> 
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>>       amdvi_init(s);
>>   }

