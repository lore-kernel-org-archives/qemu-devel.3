Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEF4EA4FB1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuU27-00065u-5x; Mon, 23 Feb 2026 06:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vuU24-00065H-Vs
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:23:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vuU23-0000LQ-4r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:23:20 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61N5ecrO314591; Mon, 23 Feb 2026 03:23:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=u0jfK455GbR4vbg/PKeVatYV4ebsh/G6S0s8UWK/z
 BI=; b=mnQ6aKu6gSAKQZ3OX1+dslBO1FoQ2KImaOgvav+OYFvVIX5K2FF7VKNWb
 AVgUn32SLOa6Lu3iZXiXmD3v3BgvleyYOS3SKSVJlW3ePsbRt8ScTFNH8RcCLBl0
 BZYZxcpXiSvtk04RtcKXYuNXmdyK7gBtp5zclRlo4GkYEEzsOZ7K6K33JJWIvj3M
 OiDWPSynLz3FRZy2wRwiFUVVhZz8FI6JqTjViK9fr7Tr2X4GZSHneOoaJs0fu9BM
 mO2WkjIG3xXPbevbMKjvZj3/7xqhsczI4j2al89eU/WWab94nnUJKpYn/F4vH6aH
 aSf7MOSH/k8zvpwRDNowt/knPdrhQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020135.outbound.protection.outlook.com [52.101.46.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cf9g7kgfy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Feb 2026 03:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuW3nJDkJJEIvwCGAPmAqUvJbHacKrzK4aDxWOzuOjG4nYrYJ6nWyRMKtlRFvEQIuQOyfUdv6QNWphYDWeCodQJY3re+KVZPHxBzg0s3BHNi0TSim/bfcqNZ/gz1g2mPhTdSmc+oR7I6EbMWXUlgfaFFYIQTBY+tkS4x5lO/14Go8j7kPCD4VEDlbJwUdmkI442rAPvc7iekr+TeZtAZTLiNpIUhbzocRhYsaCsQJhsv/dFiv7TCKvTxbYTBiA9zoMtnnWk/zir/fsWpi6A++RqZwT1jzqXCbg2X522HM7r1dnf79SBeiS7QNJV0yazdNuiLbCCYNfVJ3yyvFe/BKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0jfK455GbR4vbg/PKeVatYV4ebsh/G6S0s8UWK/zBI=;
 b=aVvpH1mRWHGIfwK9Lc2aAqP5Qu3QhLMkhv0Kf9WrytVOLAg0QJI5Xi/QUdP12TN4uFzkLDEXG7epz8Lzb4tbWSUxRoeLEwh+NvXTJehbAPsaIQNgpBokGGtawKVbufL76S4bXv2gk29WJzw7jKr1liunlJKd8pfRsw8f62bniXC4wuHeBAVrBqlI76XTqwKqUu5TkTT4QJiT646k7d0C4YmtwEFb+aNURtvEJMtDDBgzi5vw5FD/JoLbq+L4xTvwUMqpn9dlgzciPIKEeP2cfO7Ec+tYJtvNnPGRLxO+7nOMvxE3tMXDd9quvNjI8AxvRcASOIA4XpXUc3+WimNJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0jfK455GbR4vbg/PKeVatYV4ebsh/G6S0s8UWK/zBI=;
 b=RvX9TzYjEoevZHeXjIWIkZOKnCmzkV6k37siHq9RsOp5N78nuavn8WbZUUCDirMhPSGPTRkoK8SkOppax/Mae3eP4ZQc/7sroVdi3ZIlbQni5VARz3oqkBSpV8z9QH8V3SLOhYoLRQ236vxQHQ/OBeLOrC+fIDxrjMdirTZE/jTHwrQKPDA4PJlPP9TAwTBsl3VL46vsku28tgvnCChsRwKl11FUp8CQDTgUS/mZmHV0QCgXAPoFnAk2jRS8fgfgZxsxMkUfO3qgBl+sEcy1tkbmxqjl/FitJ/LHD8fsBl1S5h0FBN3S26s7BzENXJjenSedlcuGccZfNVcCcjFsJQ==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by IA3PR02MB10602.namprd02.prod.outlook.com (2603:10b6:208:50c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 11:23:12 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 11:23:11 +0000
Message-ID: <c095b2f9-fc5a-4a47-a78f-1359a7b27c33@nutanix.com>
Date: Mon, 23 Feb 2026 11:23:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Support for Hyper-V's
 HvExtCallGetBootZeroedMemory()
Content-Language: en-GB
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <d4131a65-48a3-4da4-bd8d-c3a5991a2dae@nutanix.com>
In-Reply-To: <d4131a65-48a3-4da4-bd8d-c3a5991a2dae@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::20) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|IA3PR02MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5599eb-10ce-4c58-a761-08de72cded52
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtxUVBkZFlYbGFMS3hBVlpaaURQRkpBYlp5WXN3SlZCVkxoWVcxVnIwc1ox?=
 =?utf-8?B?aFlPZG9OQkh4aWZSVzNVQ3pNa3J3SGVqUHR3YVdvajJTbkpnSWhzRnhtN2Fo?=
 =?utf-8?B?NmMwdm5ReHRPUnltN1dpTnUyK21iM0Q4UllaaFo1UHZjNWJMOVBYaXpVOWdj?=
 =?utf-8?B?aTRPbWRvMFRDMWkwbytmeWdqRXkzdkpWYTZIbi82QXdRTzZtYTd6VU1zdWlR?=
 =?utf-8?B?QmMvSG5qcGNxaTRsc1BKeVZpQ1RTdm8xUExBY3l1SDhzNGhoL1ZoUnJMNzhJ?=
 =?utf-8?B?M1RBQzFMK2FEMnhZZ1RvaUxra0FJUlYrTmltY1JteUIvcG8wYXV0TWtnekM4?=
 =?utf-8?B?UUwySGluVVpNNENzN0t5WXc3Q3E0UWFZR0dlRWh3US9PZTZ5M0Y1amh0Y2hy?=
 =?utf-8?B?KytiSExVS3dJMEVNNTU2dkxyOG5rUnVtQzJYMDRzTGRTL3R3VUdMMlJ0ZEMz?=
 =?utf-8?B?b0JjdGpyZmdQR1Y2MkQwV3Q5WjlzUEEzakttbUJ3Mys1R2ZyRlR4NzZaSGs0?=
 =?utf-8?B?a1RTeDBMdEM5VFFlNC9XZnZqOENxb3FQRHhhamttNmRCWGY3UGxPd3FoWlU5?=
 =?utf-8?B?NUxLUklWczhhOXgzcmM5RldmNG1ZQzJoczhDV0gycnkxQStlMVBobmE2WjVx?=
 =?utf-8?B?M0MxRjhxRng4L2lvcDdRY2ROT012V1pkSkF4V2VVTWh6ZUMraUJNZkRzYWtX?=
 =?utf-8?B?eTJOQ2krM1A0T0RkQTV1MWF2cDlPT2pvRHQ1eWgwVWVJYUFaUnlFVWZtbmE2?=
 =?utf-8?B?OHN6SU5aRmZEM2JMMEtPSTBkN2VXaEViQnhERXlia2VoZk9iVTVrRUwvTUw1?=
 =?utf-8?B?SEdGdkNRWjd3dTlsUCtBaFlNYkhFWGFEaVdHMmJOUXFjaUtDd25RZW92VnY4?=
 =?utf-8?B?cXlSb3FFODNWcW9ZVEdlNGpnM1RLTmw2M2N3VXZjRkVSUXUrUzFjdWl3dEU1?=
 =?utf-8?B?RWw4WC9NSGQ0TlQ0VEEySlNNb2hlMjFDRDFtbXF2eHZJQnAwRmNaU3lRS2My?=
 =?utf-8?B?OVdaRkVYcitZZnZTNU9KdWJyNjRZcy9TaStySDBFRmJoRU55SmcvdWdiQllv?=
 =?utf-8?B?dElIc1VkTlNNVURlRGZGSDZRdkIyNThKbDROMEZ0U284NG9Bci9lMlRoNlBI?=
 =?utf-8?B?OW5kckN1S0U2UG8vckIwVVJoazZzR2VZM0hHcHZTbzBuY3hlZEcxRi94djEr?=
 =?utf-8?B?b2hjWkhTMWZvY0R4d1RxYnVVNEhRV01SYk1IQVcxUXdRdDZ6akxJcmNkVjVk?=
 =?utf-8?B?YWdLeVhQQ0Mrc3REdVVnYUZOdG9ZNVNxSTMrNTdGaWhucURsR1p4Sm9BUUdF?=
 =?utf-8?B?SVR0ZU1oVDJndDdITHdCQlRlZWJKaUtxK01TMWphRU9YYkZiSzU0b2JCdnU0?=
 =?utf-8?B?WjZ1WVF4a2NyNEFkeGxDMWJCa3RQV0RNZFRqb2tDRUhzWm92M2t3SnZENUtO?=
 =?utf-8?B?NTl3TVh4OXoraUd5L1FUNW92Y1hNRTdjbVBQVzFCZHJPaHNyOU5PWGdKc2Rs?=
 =?utf-8?B?bXFJdU85cG1RNjJ1Z3VkRTdyRzQxeGVQNzJUSnlaaUluQ3Y1L1FNTzQ4QnZ1?=
 =?utf-8?B?V0sxaW92Z2tJZ1ZDdHQrQVYzcjhRaTl5R3J2SmxWWVJyVnpEWEs4RkVxNHR3?=
 =?utf-8?B?TjNQbWtycXVFUGt0UkFHRTJPZm9rRkFJdUJTUDJFZ25pK0hGSTZ1VEYzTHNZ?=
 =?utf-8?B?eFFJemhWR1ZGVHBTZWJWdG5iM2hEYllrVjZtMFU1ajIraWxReXZMbFJNbDli?=
 =?utf-8?B?MGhWZlhDYjZSQTNQUy9iTnpJMnRMUTRQQmJqWU5RUFhieVJjYXl5UkplamRW?=
 =?utf-8?B?THdqb2MxYjdROXprdkg1ZEhBZTlKUXdkRFVEUzdUVi9jTjVtRTFQM0FSM2NP?=
 =?utf-8?B?NHBVeGg4TmY1R0htaXV6MldvRXNaL2pWem9DTFdmeElORUhPNVdOTFJuUFRw?=
 =?utf-8?B?RjhzbmtFdFZQQkxWalFuWUxxVFZleEgwcHRzUkZPUEk2alJ5QnE3eUtjNnB0?=
 =?utf-8?B?SDlxcCttUTBKc2p4T3Y3cmlsS3c3NzU4Z3RQRHlqNkxKcFM1aEp4V2plbTgz?=
 =?utf-8?B?dEFGS3Z6cnAxMSt1OEs1dUJMTmducXFUVjRSWUg0NUFEeXZzbjZPTXFodGU1?=
 =?utf-8?Q?RHaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNkeWtaNmo0WDViN2VoZmc5cFE1Y2FqRXZ0K21NcnQ1dm5IVWNuSTNSakRG?=
 =?utf-8?B?eHdPSndlbEV4S3Vxd210UHBNQVpzam5yNlFHRW80cGNLWWhoTUxQaHdFdVJI?=
 =?utf-8?B?a2xQV2FBeWl2RTY3NzlaUnJzV0YrWStJQU90Mkd1QTA2MlFOMVN2Zy9NQXh0?=
 =?utf-8?B?dTl6U216Q0dtbTdIUVp5TVNBWEJ1UWhBN2hJK1ZDMTdpTXJhZDdYZlZkUVhz?=
 =?utf-8?B?ZUJya2hjYUd3R0xmdXpHV0luUkJqNVpSaGtWVnAzeVlWTWV6SG0wTkw0NGNS?=
 =?utf-8?B?Q081WnpUbmpLcFhyYmwzMVhkQ2VxdUtVZUVWQlQvSDRXd0x4U3NIWHV5RDBl?=
 =?utf-8?B?N2RZTnlwZ0JrS3ZYdHdjUm1wZE12Q0VURlBtK0VQTU0waUhVSHluM1Vudmpj?=
 =?utf-8?B?UWxrWVozUUlUY2crNWg3R2w2cllQYmZtaXYxaFJXQXpJaWo4alBla1czWmRn?=
 =?utf-8?B?SlVmV2JUTDlNcWdpTWh6ZWZZeFVpUGlyNFpXOVdScHdLL21LckxDVDFJMldn?=
 =?utf-8?B?UklDMkE0aEYxd0w3Wk5yMnVWUW9qeHAyWUZHdGtjRm41VngrMjcwdE5pcCtV?=
 =?utf-8?B?UTBMdjZ1dzZ4bXlPeDhZZDB0Zkx4RE55aEJqcW9FRUlhWm1LZkwwaFN2Lzcv?=
 =?utf-8?B?MHlqbERrUk9lTjFEVmhJYmFpOTJwNEU5ZVhKYzZ4ekNDSjlKOXFlQWhGUlA5?=
 =?utf-8?B?TWxwa1ZCNGZ2YTNZSTg5Q3cxRFdpaHZkbkh1c2lyNTZjdGZPZUgwQ3A0TEky?=
 =?utf-8?B?THZmVXBJVG4vbVJ4YmVjaDMwdUJSWWhYQlRKODhTbi9Lcy9GTE1EQk9VTWEw?=
 =?utf-8?B?QVdaQ1FKWjRoaXhVRGtmWjRPVHQzTXNUcm5WY2liWVhWK2dLaEhZVVVJdndP?=
 =?utf-8?B?NjhVc0JhYnBtb0VQYUVjQ0k4SlJHY3hEMUs4ZDRaMXFJbmNVMUhMRlpKVEFC?=
 =?utf-8?B?Q2RwYXlJWS9kcGV3WE9McTlUMWx4VGpsaWJtb1QxTkVMYzNlMzJ0d1RibW16?=
 =?utf-8?B?VEovL3ZVRytpZTB3M3YvNVBjWTU3R28vNlUwa3Y0ek40blVoVUo0SkFUWjkv?=
 =?utf-8?B?aDhPNGFYYlEwODkvMWFxcDQvUk5NOUVMU0hoQ1pxQUtTR1AwZ0hSUkI1Y3RT?=
 =?utf-8?B?TXJrd09Pcksvb0cwWk9pdlZOZnNrUnRySHVuU0NFY21OYjVPc0V0aWUzYTMy?=
 =?utf-8?B?L2JkWlF5bmRHOEN2anFUWHY3ZlBRZzFIdjA5ZGk1NkxLYVFqbEVFZVlXU0Z4?=
 =?utf-8?B?RHN0UmpEU0FINXpsNEpPWktNaHdzVThoS2Zmd0EwaUlLZXhUeHBUY0hHOWRn?=
 =?utf-8?B?dUcvMVBDQzFpaUh1SjM1RzdBc3hZMGZnKzNxMTkwV3BCWWZSRVlXNnI2eTA1?=
 =?utf-8?B?YVRQSitWNmRyLzVIQWVtcjh3RStvUUUyTHBBQUxKbGgwTnFacHZQU29XSC92?=
 =?utf-8?B?UkcrV2tPNHlKVWsvei95TDlrcDFHM1JUV25HNFVCL0k2c0M3TU5HMkQ4QUhO?=
 =?utf-8?B?VGo0R0Z1alBjTE5CK2dmSHllYmZqeXdqN3EySjl3NHBBS3FPSmNpdFQzdXZL?=
 =?utf-8?B?OW5vc1ZtYlFRWmplOHA4QVE4U0pybmd0NmNsdkJ5S0xpRGYrcEJ5VWVvKzNU?=
 =?utf-8?B?TjJtUXprclREZTBDNEhGL21JVW9kQytENS96VTVicDZMZlBEdnczTzdRWkxx?=
 =?utf-8?B?Q2hoa045V1BOeGJHTTllQjBBcDVEZFptM3pneC9qUzFCRCtXanErQ0lySGdo?=
 =?utf-8?B?ZlV6RVJRTXlEaFZYZlFXVWdUbXNpMnNkZmJIcGd2MGtlT2U3dms3dzBVMk1G?=
 =?utf-8?B?MHF3c0d4d09VbWR5U0xHNUROL25PaUJoVldmMTNaVCtVbG1qQTlPY09RM0l2?=
 =?utf-8?B?UGVnMmZhRXlpeXczVnBvcnUvdk0zd00rVDk5a3VGKytGQlZvT1NzOFE3WDVU?=
 =?utf-8?B?M1doTkhxSTZxT2RoVTlYNGhQelZxbzRxY2dHZ2M2ZThwRThEK3kvNVhaNUpF?=
 =?utf-8?B?M3lCa3VUSllGSjUyRGVBU3BXRDltZ3FvdUJjZXJROThmR3M3MktEL0FURW9a?=
 =?utf-8?B?QW16a1FxSldRdytyaXRhQmpZUkpCMVl6WG5pWUg5Y1Rob3FNeXEwRTBqSktS?=
 =?utf-8?B?WEtqUEhBeGlSVGdLNmZ5dktDcGNIak5mY08rR0hNazNqblF6QkxsNVY3bktU?=
 =?utf-8?B?RkpJaHZrTDdEWU9PeXhvZ3c4TitHS2xxYVRaK05CKzkxdUw3bEYyK1lvQ3lV?=
 =?utf-8?B?Y3A1MFdvakNvQ3BOTFB3c3lxSTBiOGtPWUs0L1pGczJMQ1Z3cXZ1VEp3K3da?=
 =?utf-8?B?bzBuVGhwZWk2SkRSdkt5WmdMam1QeVgvNXY2UWZnL2o3S3ZXcHh0cU5ObURi?=
 =?utf-8?Q?zG+Ezl+HGMv3OSPE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5599eb-10ce-4c58-a761-08de72cded52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 11:23:11.1921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt4ZFAH5sGi71Rfz6iXSyFBhZUovaENIvm4P9l6RPWPIYg7WXqX97DqS0GnwquacUWuXSKSQ27WFWzKJLtnI2WOOzMBPxqLOmTwMtTCLAyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10602
X-Proofpoint-ORIG-GUID: jjtamgFBNd15a5LTkoe-ljNuuu1Ybhui
X-Proofpoint-GUID: jjtamgFBNd15a5LTkoe-ljNuuu1Ybhui
X-Authority-Analysis: v=2.4 cv=I4pohdgg c=1 sm=1 tr=0 ts=699c38a2 cx=c_pps
 a=5R5l3xa2V1v4tL9kvXelng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=IdsrjC9UPjIfIsbShrEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX09ivFQwUpHwa
 WU4bmkp6Lu6RA86yOF9Yt0K94y5bJ4gPsZD8k+Cnzq42ElqBi/GKfsFwegQcn1lPumy6Vebcmzh
 cPloszj3kLLKxK617OAwyhFB5DNIdPYnGgOXBEIOw3NktXg/bfWvycHdUxwNuIDx1v1HmPHexP5
 bUQhLRsaMLlc1Ihjrx37+UFWqvgt3zRb5d+7KjXksOaqFAF25+R+c/jfrjlCsxL0+IP7imaIC0a
 m3QNrRC59uq5WzldRCEl+kIddqNb/yzpqiTB3wdjgBO0eMO+fxM4DH3Ss/OSXEr0//JVv3dgFRC
 02jf/EF7HLUSb/rC3iNOnE3NRES4WROhem1h2UHCXg8c4h4I1TEgEWdrSE+mu43HSCedYatDvoG
 MdI7NPW+A3jiIrAnqDQmccKmYXHaG2ZdNOVVjaC0/uNrCL2562wM7rR8buja2+IhgeS2jc8gnbm
 xq8dj+AG0tgtD2hoMRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-02-02 14:26, Florian Schmidt wrote:
> On 2026-01-12 11:31, Florian Schmidt wrote:
>> This patch series implements two new Hyper-V hypercalls. 
> 
> Friendly ping on this. Any concerns, any suggestions about open 
> questions such as these below?
> 
>> Note that this is still an RFC series. There are a number of open 
>> questions,
>> most importantly, which memory areas to send back to the guest as
>> pre-zeroed.
> 
>> I also wonder whether HvExtCallQueryCapabilities() should have a prop 
>> bit,

Another ping. Does anybody have cycles to give me some feedback on the 
RFC items, so I can start working towards a proper v1 version?

Cheers,
Florian

