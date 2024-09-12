Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00365EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soceE-0007at-I9; Thu, 12 Sep 2024 01:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1soceB-0007Cx-VT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:45:40 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com
 ([40.107.94.46] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1soce9-0004Lo-D1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQ8yaNvHmNgXAwvJV4nWtUNSqy5kqDJBJopW5IJVdMcdsZsEFIuD4q4G/syfxedVpzbF+U0iPtOPzqX28czdzRZuhOPaUbhChX5fXyGHIBmWYZu5GzLKfp+93wr7mevU/tU9llVmD95GRE59KDt8TzZz+Ov7k8opkq20FX6KrZWh/snCi786p48mIIYWvqPZDtx2DMegcVXLrndXTYPgu+ehzo7nfDVPPYZB7c2BhLsHut+l4q9OYagPl0Wc5gPVNRMIkbBsKjWkxDiKxZeNWXcxZm2R42Mz43OTrs0qAWvhbyZy8psQ7VrEdeU9PnPxRFbc9KcERV+uPz0dY/4l+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LomolTXIsHeDqZGpPoXuxk/fz5h6WyNDtPiUQ6rxyNc=;
 b=XSNK7m4Q5Q+6pEtWbRGyHwwDWpiF6MxjBMapnv79noUzZLjdTuAI9hBE347N/7Hr2o1PKLXhtYXRpudUWDlc+bkvnUvCDcBIv1c6hulTyLa2YbjP2FQD1hERVN6RNHTrik4ImZP5+bPjfJaorJvf96w0tpAfyvjfIkCDTXIG3TkVEPgvu/IrEq4Qxz+fqvLQLGTgutSd1VbdRrO6gs1cpLzQEiWj8YGHQvZwILZCuIdE0XL4PScHMz90vNWITupgYAHJ7EWG0y4sRjlR4UM4f68YkFvsxr4i8C2hAkIOcEbW9HGkSR+qrjTIRjs7zG1cdZDeP+vRR7wgii93SQ+kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LomolTXIsHeDqZGpPoXuxk/fz5h6WyNDtPiUQ6rxyNc=;
 b=CTcqu9cSqSpnbHCJzDXjvmqCvRzFH896SZRGC4EofeMrFPkbnuLQsMa68j7XS4iF8B/FmVRNDzIxuOO0zl8L0gFmLoWNuCSf3pyCNcvfZF1G73SeLsQti7wrnAbyQClwZkg/dsJYuefYWd1cBbwzF/nNk/0usPPjv44NTxZmbRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 05:40:29 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%2]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 05:40:28 +0000
Message-ID: <b57f362a-dfac-8ee8-5746-8abbe7b2183d@amd.com>
Date: Thu, 12 Sep 2024 11:10:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/5] Interrupt Remap support for emulated amd viommu
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com
References: <20240904100257.184851-1-santosh.shukla@amd.com>
 <20240910161403-mutt-send-email-mst@kernel.org>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <20240910161403-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 99aba193-9338-4d67-9a97-08dcd2ed6878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGZiT0dHUi9zOFpIczJQNzhLWkdJTU5UMVI4Qi81cTVsaUNoMldEb3AxTnBF?=
 =?utf-8?B?YjBjbDlBVXVtWnd0bUlIVStiY002endqVGw4ZTBHSUFmb2x3cGxHTEVIaUNL?=
 =?utf-8?B?NUxDZjlVVTJBTzRxQ1pDdUtWNVVKNDdVMmE1bXRSZmx4YUM5WHo4b1BqOUM1?=
 =?utf-8?B?QmJIZlVVWnBNdkhnNWtiYUdOSnp4VWJHYlltMlZRM3RNSjRqRWFMZGZiREZJ?=
 =?utf-8?B?ZW1GWTYzZmRHUHJYTjFYNEpNN2tOQ054ajlVT2I4VmExV3pkYWRCbzJ2RDlF?=
 =?utf-8?B?TVE4ODYwb2paTkFGSzdsZDAvdVp1V2JEamJZL1RTRkJ6UGZERGMzS1JEcTN6?=
 =?utf-8?B?K29oTmhVdUVWckZQK2NKZ0laVDBVejZiR0tLTm9mNXhOeFltQ3ppWnVxUVlh?=
 =?utf-8?B?MlM0cnpNWXU5TE1vTnhTOFVOK2lseWZHZlhWWTliWHhRWnhMTVRQbnpnUWdq?=
 =?utf-8?B?YngrblljUVBWcXRHZjNFanAyVExFaGxBTHVaYzIvMm9EbHRTODc5aTdDd0NX?=
 =?utf-8?B?MVJuZU5odW1TMGxjN3FqcjRGWlByYU5uM1AxWE5VZlpteUNrMlVQSW4xWGkx?=
 =?utf-8?B?b1hGWW90Sk5GTEJ5U0RWWkF0UUlwbkc1S09tYWxHb0tzZ0d6OXY0MXcxYnNt?=
 =?utf-8?B?eDh5dG9rVGc4SHQ1VUZZRjliVlU5RnRmejFkNTJ0SnBOY3dyRjFwdERsc2xI?=
 =?utf-8?B?N2x0R0orVmN4WGIwOUhzMjhTVnRPOWo4QUtaRndwSkxXRHFXS1FGL0VMc0U5?=
 =?utf-8?B?cmp0UkhqOE93aEF1UnBDL1ZnTnVwNzFydDhBYU9uWHFsZkc0aE5qKzlSaTZM?=
 =?utf-8?B?R0ZSdWFZTU1EYi81WmF4R3htOW1SKzhtekhSUVpjajd3c3NqS1RtTkFDSW1G?=
 =?utf-8?B?OXl1NXg3cW83ZVVsVis1UC9iRU1hd0U3U09jSjZ6VXNtL3Z0ZHZQQXRxOFBZ?=
 =?utf-8?B?RzlhZFQwSWVENVA1bnJTTGtVZ1VCdzc0K29JYnpFWENQd3BaaTkrR2IyREQ3?=
 =?utf-8?B?QXZ0OHBhWXBNU0t2WGZoYWpSTk04YjJGSVN1d2ZydHJPUjdMVEtDRXdmZmN1?=
 =?utf-8?B?aEx4UmdHbG5WVXhWVHpYK1B6RjJjUnlEM2M4MFNpdXNaOUlvZVh4b1dDZVNE?=
 =?utf-8?B?dmd1Z0hxUWZjUjk4NUFzYkIrSVFQOXVxcW5Eb1dSaDVBR3lJeEw2ZlU2M2o3?=
 =?utf-8?B?eXhhR0pPUTAvT0thUnJHbnROMTN2cEMwRlFIVmZNQkRYdHA2eTJvV0NldXFu?=
 =?utf-8?B?MWs5ODBGQXpabjYxc2IrUGxhcHluNjBVRS9LQTFHZDhVNzdSQlBXeHdWbmNF?=
 =?utf-8?B?UnJobmFCMTlSeFFtcTBlT0tJQ0pIZjVoNEZOcnVVd3ZOVEovQXZ3YUZBQ2RV?=
 =?utf-8?B?cjB4VHNjRnBDRSt6S0huZ3dBNXNLTlY5SndJTmZxcU5KVTBNK3NHbjhhcTNR?=
 =?utf-8?B?aVo5bVNXSGk4cm1IRHpNSjhGTk1LN0hYbTRQMkhWZk9ZL29kaGJoc3YvdTIr?=
 =?utf-8?B?QWxtK0VqNmRoYVh6aHQxUmRsUW83MlF0WU1pSFdrRTNUVHNyaEgvLzZRSndz?=
 =?utf-8?B?SjltRG1UdEFSdVlUMGVUZS9MUmpDc2Y0Uno2MWlYeUtrOGllR1k4MkNHWnoz?=
 =?utf-8?B?WTRZcjhVOENvTkswNGFMNlBuK1IvZTBTUENlbi9QbzJDblJidDdHNEdyRk1m?=
 =?utf-8?B?M2N4bEVlTE4rTWs2eXJSN1FuclFyeUd2SldkV0luZEtUTk1CS01tOSs2bjVO?=
 =?utf-8?B?Q3IzZ3ZqU21vL0E1MHRzdmVnNkpZVitHck0zSmtaSG9VYnNvaFlGTEUwSDNQ?=
 =?utf-8?Q?oMhkRiHLTcE32l43D8yXzP4FhGMjPkUcf/nh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHgwbng5NEE1b2xiQWhMcktmWnQ1UGY1bU1OOHF3SjlZUmI2TVBKTGZFaWxW?=
 =?utf-8?B?TXloR3ltbVlmeXM3YlhHMFJDNzdkR0hHL0tZRDBmaTlTR1NiVCtSN29sWkRS?=
 =?utf-8?B?OFkwTjhTc0duZjBYRVpEU2kraGRHRzEzdWduaVBucnlaWmRNeWVwd1F0SFlo?=
 =?utf-8?B?Z0RSTW9yQTVVR0VaQytINEdpZjlGMUhrc3MrKzE4NUJWc3ZnZEtTYzEzb3Nn?=
 =?utf-8?B?MzVwcHMyMG5JZVNUb3hKalpLTlpEN0p5cHp0RmVHRGpaRXNIMjJUSFFYM0Zz?=
 =?utf-8?B?cHh6Skl4WitRWmcyMTlPOWhrYldMQ24wc0J4NG0xN0xGMmRmN2s5aDRFS1gy?=
 =?utf-8?B?SmNBS3FnZ0VxKytnMXVwTDMwMm9sMTViNXRuRFlYNzRyZGR5S1ZnSXpiUkh3?=
 =?utf-8?B?b2FxenEvbkt1VVlSWW1vVUF5OEZ4ZmtabTVTS05lblpCbWhJTDAycWVnamtn?=
 =?utf-8?B?OUc0OUdyRUc1TU9semhHRWI0b2VXelY3Y0RtZ1p2S1R4UFZianJwbzI4SUU0?=
 =?utf-8?B?ZXlCcGJOZzlxYTZRWUxJeC9hcUhuYXRaSHhjeDk4eTlOeDNSaUlib0xuRVBm?=
 =?utf-8?B?Y1lBa1pNai9xNDEyVDdOdy9xWm8yQzRoYjZxNmEwNU1iNU55NDI0WU94YXZX?=
 =?utf-8?B?OCs5eXJmaWZnYjVsdFloUVlObWhJOW9wL0NyMUcxZWd3b0RZUVFsUzNDZ2FG?=
 =?utf-8?B?cEx0Zm9BcDY5cGZPK0J5WlFza1htNUc2N01tWXhzQ1loZTNiNU9aZys3YTZv?=
 =?utf-8?B?d0h5S3BBOEVvR1VjY2N3WXFaODIybkovMFJuQUNZWGZFbUl5aGRUbEFhY09O?=
 =?utf-8?B?SmNiOHRIb3ZINDlYcG5hTWhMTEE0c1hzaEdGcm9BQmFzOVg3MEc1Q2dsb1N1?=
 =?utf-8?B?aE1ESGpoVE5EZVRHV0puSXJMUDRubHhMOHFaY0JoYmZid0VjSHhPcXFKRCsr?=
 =?utf-8?B?S2o0UTFhTXV3eUcwVVc5dHJhbFViV1J3aTVveEkyTzZqbXBLTHo1SGFOZEEx?=
 =?utf-8?B?ajg0aWltYW9GQ2J6MHJDYmhOSTVPWVlnSkcvN0p0UTZVZXRlb05Fazd6V3BX?=
 =?utf-8?B?RWJzTVBTbkxhcFA4d3pKZS8wK2piTExjNUNYK1ZRLzBuSFJYSzRMZTdaOWpv?=
 =?utf-8?B?Ym9ENWhZZGpXcGFNeDhrRnQ4V21TUHltOWIremcyRENialJ5R0VNUWJJbU9I?=
 =?utf-8?B?YVFSc2lWVk8yalhlazdMWUtWeUJHNmNWakpZOXE5dkFQdjdnMk5OS0E1KzVY?=
 =?utf-8?B?d2w3b093eC9IOHFQT1RtaEJNRWVUWXBnREdZcXI5emZiOVEwYzY0S1ljNFMz?=
 =?utf-8?B?SGdLSkRmQy96dWdoNUJXNTNTaTVCRU5aY05nWUNFWU04MFFBQUppbVpWcys4?=
 =?utf-8?B?WmZRc1hHQUlIQS9ueTduRWJSVXdteUxaU01NNTJlZ0lSb3MyK1NLNmdrODM5?=
 =?utf-8?B?bk9COWwvN1BQOTNXSHJMbklFTGxtTkhQOXh0K1JOekttSXRBalRDVTJzUDdk?=
 =?utf-8?B?d3ppYWtaeUk2RC82QmZqRzFxVkd5NUYxK2xOYmNSUDgwaGlIZzY1UW9BSVhF?=
 =?utf-8?B?TjdaeGpTNThGQk1SY2R4cGxKQ0pnSUlkZCtiS3Q1b1VpemVnajFIQTYvaC9F?=
 =?utf-8?B?M2FuZFJFZHhlTHNjKzZMdkxIbUFGNzRoS1dDbmI5QTc5b2tmb2RxTGdMaDdn?=
 =?utf-8?B?azFadEZiMGJlZjlhTGUxZWEwckhTOXg2bS9hbzNQQnVQaWJKdll3bFBuMy9L?=
 =?utf-8?B?ZW0yYjNGa1laVklOWkNnai9TNVZnaWpldmgva0Y5czRCbTZHTTl6d1RiaU9T?=
 =?utf-8?B?NkZFRll1SEZHT0V3djBXQSs5SEV6eUE4eVcvTkZXeHp1aDI4YitiWXBvUFpG?=
 =?utf-8?B?ajN1NWJwSVNaUWNtQk1HNXoxU1c1ZGUxMlR6RmkxRk9QVG5PTFRDTUNSdEY0?=
 =?utf-8?B?Mlo1MmtiTEt6KytneUF5NG5EUGVIa0VmRHdMakVJVUxjVi9NWVMrZEtNSnFX?=
 =?utf-8?B?VlVIUTllR1pnREpaQ004Mkt5ZWlmdnkzYk9sRkNqOG9GOVVadllBYWZXd2px?=
 =?utf-8?B?QVFndlFVZ2NFckFCWi9aaHhHQmZGVXo0ejBNTy9xUG1pSHludnN5RFJzT0lI?=
 =?utf-8?Q?GxAaD97QmqyVZc+J92JXNVLJi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aba193-9338-4d67-9a97-08dcd2ed6878
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 05:40:28.4897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvgS+Tk5hVpj1XBbhsE8jnryngvqr+R7Ui2JgUiuY3oVUCza8LdcrERFMyVqPezYCtf4gIAiU+ug+fXGSqRKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
Received-SPF: permerror client-ip=40.107.94.46;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.499, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Michael,

On 9/11/2024 1:44 AM, Michael S. Tsirkin wrote:
> On Wed, Sep 04, 2024 at 05:02:52AM -0500, Santosh Shukla wrote:
>> Series adds following feature support for emulated amd vIOMMU
>> 1) Pass Through(PT) mode
>> 2) Interrupt Remapping(IR) mode
>>
>> 1) PT mode
>> Introducing the shared 'nodma' memory region that can be aliased
>> by all the devices in the PT mode. Shared memory with aliasing
>> approach will help run VM faster when lot of devices attached to
>> VM.
>>
>> 2) IR mode
>> Shared IR memory region with aliasing approach proposed for the
>> reason mentioned in 1). Also add support to invalidate Interrupt
>> remaping table(IRT).
>>
>> Series based on f259e4cb8a8b4ef5463326fc214a7d8d7703d5de.
> 
> 
> Fails build on non-kvm:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/7791357916
> 
> /usr/lib/gcc-cross/i686-linux-gnu/10/../../../../i686-linux-gnu/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_amd_iommu.c.o: in function `amdvi_sysbus_realize':
> /builds/mstredhat/qemu/build/../hw/i386/amd_iommu.c:1660: undefined reference to `kvm_enable_x2apic'
> collect2: error: ld returned 1 exit status
> 
Thank you for reporting, Fix in v2.

- Santosh

