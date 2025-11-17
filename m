Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD9CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuNp-0006kN-J7; Mon, 17 Nov 2025 03:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKuNl-0006j8-1J
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:14:41 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKuNi-0002Hu-Qn
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:14:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjXJZjAnS1utQXi+nuTLxcuDMR5dRSTscjxRlyFsmohf/7UwFD8IygMBDPFkMiXU0WMQnFVWRfHBdwfMcpalDQLqYQkWTHCj5PwEOgYvsB2rgC4AaAtfeoKERFmNITfrNJfDnCNXjlLrVQ0GH+4riatTZhwwoQsi8zRb3FrSvNoHoes06ooUIO92hzcsBiMVnrKz1x3PRnXauPivjhriIXAgQmqu5lM3CvBo7K0pai5/JFPBgZxiTbsBEq9ZpLzG516efjizLIwG1tKFIiziW1UrRbAb6wISPaBEkTv/uC1VmO60PDv5SyvTwAGLBIzwd5d46uPrBNFJsPZdQrLlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWc+yeoMP5JnfyYakMPpRoHsoT1Fk0zhbitr9xvc2H0=;
 b=vHwZs0E9tO38iX28D/kj/1/Zg0Hq0osc3tNzHjckKuVp/4LHl9VAUFMuq/Kq4y1kTmFSgfxrxUdrP/zXECtD7CYXCCNnlAP37Jlo5CdwbDp7xipU6gWNk6RQXmnWVq2p3JY+o+gJo3xCcLuTX7gHwRvLV/r6r7573T4k3wyGznrS1PKxyPEcRroAVgPrsDLcoIi3afgKAgEn7j518HdnQyGEVzUYcq9lTNpNDpxUd4lSlYZnhdo2UNmaydx7booGVwHt8lVQLO+Ogy8qqS8KNVsEDTAR8bT0dwRxIIFBP58DPIOvCbjWJYMiBMmOXEOkOaQ339J7qAmc5zT8cMlc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWc+yeoMP5JnfyYakMPpRoHsoT1Fk0zhbitr9xvc2H0=;
 b=DRKe9JvpibB38QbfzgWTT6l4vMKNK0AfzcuVsa2rS6lCsR8W8aakovW1zR5XWB//vt/xdQpU39FZpdet7qX+T1aoHl5Pix300ph07mNfsa00CQ9q+jOJLvGNPoq0mMnn7072PKrkSHtewUbMS6VVbAhFhGHD9/ssQHlcH5BKrAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 08:14:34 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Mon, 17 Nov 2025
 08:14:33 +0000
Message-ID: <994ace03-8562-4c6e-b8bc-fa3d7b6d3466@amd.com>
Date: Mon, 17 Nov 2025 16:14:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
To: Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117055112.99046-1-honghuan@amd.com>
 <87ms4lrtd5.fsf@pond.sub.org>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <87ms4lrtd5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::21) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8611a6-46e2-40e5-a2c8-08de25b1570b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmhKa1BmTVlDMXRwUnBHbUQrdHNmc2tPVkkxdGVDdVMwck05WjFQVnhhNExk?=
 =?utf-8?B?TlRibWVMZTRhQXk1WU55MkEwbkFaNVV2bkdiYkJSNXZBNG1OMDA4OEZhRUsz?=
 =?utf-8?B?TTkrYnEvc0dyV3JEQ091QTg3QlRHMjFWUnhJR0hsdkVTc3JLYmNQbmN0MHA3?=
 =?utf-8?B?UFZGdGFSY1pkZHFLNXRHcFVRQ0hqaWhDMjQxckFTaVBITjhlU1IzNDBYZklw?=
 =?utf-8?B?VVhKa09tbk4zSkM0bFlHVzZ5b3Y2TEhPa0N3ZmZHYU9OUWZCeU1rZWgrdHlB?=
 =?utf-8?B?dUtsN3kzQVpRVXRnd2hQN254M1VYakg2UnNheU9UeWs3emIxQXpGbVRtTUw0?=
 =?utf-8?B?YUREc2l1NEduK2MvRUgrM2lZYno2d0IzenpvRE4zeEZpb0xFU0crZFhzTmow?=
 =?utf-8?B?L1JxYlZrZ053RzEwS0RSUWxzeGQ2Q3RVVzZNMjVlV0FIcHNDTmlaUEpKU2to?=
 =?utf-8?B?TFNobVE2ZDZ6V3lBeEM2bGNSeUszREt3SU5ob2V3MGN2cHJyYjFuNkkxQzZy?=
 =?utf-8?B?b1V1NGpLcUlvcExScVMzVENiNUZOOXdtOFNTYlY1T3ZvYTdJLzkwcFRZS0Qv?=
 =?utf-8?B?T1Y5RW15Sk1BNVdVZFlkbHdrM2x2a0pTdWVxQ3I0VjgxeTNRYVEvWUszZXJx?=
 =?utf-8?B?OHZtVWJqdlMrUFhYVVppNHErTHgzSWpVVjY0R1hUKzZPM3laeWExTUZpRjR0?=
 =?utf-8?B?RkFSaGw4SlFpNExMMzloU3Fxc2I1ZkJYTDdvS0V2OU04VnZQN0hybDJZcG1x?=
 =?utf-8?B?ZFZmRGE2NThFckl1ZVgzeUdZTmpCZTA2Y0NHUDNhN0hxTXdZRG00cFYxT3RJ?=
 =?utf-8?B?QnRIcENRYmloWE1CY0wzV2FXTXByNnhSaERoZVBwQUxYcVJDMUpZU3I5RXgv?=
 =?utf-8?B?MjF3UFl0VGJtcnJUMTNxN1UzcUxDVitWSThSZEJkVUdWM2RGd01YT1VZL09x?=
 =?utf-8?B?cEpVM1ZzeVFqTWhLbU5YSER3d3lGeHZKRE9UM1krS1lrUkZWZGVZbWVzeDMr?=
 =?utf-8?B?bHIwYUI4NlEzaXZoVkk1cExFMGpCUnU2cE90NE5iaFBSYThnWHllU0p0OHVr?=
 =?utf-8?B?Z3g4YVNLMktnZ3lzMllFdzBIbE5JR1JUK2RFUHVNTCt0SEF4MThrZ3F0ZkVY?=
 =?utf-8?B?czNuZWtMdWs1YVFTakZOOEJsNFJDb0tmYzF3Tk5WSE82dzBFRlFhaEpwTVlO?=
 =?utf-8?B?Nm1SYU44NVdlUmdBNHEvOGVnTkNkZmFrN2QrZlZUMHJ2ZkEvNkNkYnhvV3JM?=
 =?utf-8?B?RVdjN01rOWlzaUZiekh6b1NUaWVwR24rL211UkRJTlk5VXNJNVdGVi9hODNl?=
 =?utf-8?B?TURZY29iWkJYWFJZZW1KZENtWW1GQkxMc0I1OXNuSHNML1AwNmFvYjFvdGRZ?=
 =?utf-8?B?RWw4bFZDWVdKR0E1bS84YlNBemh6aE8xbXRRdVZkZ29JZDJFNmdESGJVbWJU?=
 =?utf-8?B?R0hKdStDRzRFNStqaU81aXpvaS9RaW56U2JuekdWMnluYkZnN3dWcy9jWUdL?=
 =?utf-8?B?bFNkSEpkQ1pDVDkyVFdDczRwbVFydlNSTExEdWFCQmpSUmphbGIvS0VRN3o4?=
 =?utf-8?B?N0dBS0pqUzNxRWUrdmdJN0lrNkR0RloxbFU2V1lMdzlJK3JESmgydlZvdDJh?=
 =?utf-8?B?L0NlYWlQdXB2RmF5bGVOenBEOUx0ZUorU2dyTjBCWDltK3VVR0dQcG9SbTJo?=
 =?utf-8?B?ZWhzMUhPVE5pUEdDYmFYZkVmdDF3YVAwRWQ0MENmVFd6amJ4YnYwTUN6ajds?=
 =?utf-8?B?RjI4T0s2SWNKZDZ2M0JSd05md3FsWkk2c0w3T00wc3A3RStpdWhxYjVLVFNz?=
 =?utf-8?B?OTNaYVNFSHg0NTFZKzJQd1VKeTl4L2xHZ3B1cjBTTEVMYXh5RHlPMDZOdnFa?=
 =?utf-8?B?UWNhN2JpbGxPMU5jcWJiZkJoU2pLSTV4YTBmZXRVV3pVYkxwL3VlcWhzZTdC?=
 =?utf-8?Q?+JtJhIbMQCRB7T3RPGivV3TKnMTXM3uN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5qNFp2aCtxTHJxenZOcnRnN0U5VTQxcm45R3lFQ29QMXJmTWFJcFpuTjI0?=
 =?utf-8?B?SUdBL0NMWExOUCtPTXpUS1UyalhRUDNLWE9JSTJQR3ZZelJpQmd4LzEvVVhF?=
 =?utf-8?B?LzVNaTQvazVPQkM5ZDIzMGJpSGl5eVVyd0UrblhGZWFnYlBZWlhjdzd0RkdZ?=
 =?utf-8?B?cEtlYTlhaHdEZC9tRlJHRzRFRTFLdnNMNDhBVmVMOHZ0aEJkNVNSVmgwT0E5?=
 =?utf-8?B?bEZNYi9FdVQ2SS9LcHhlU1k0MUEza1RZR3kwQUl5Y0dDd2FBK20yRCtZNDU3?=
 =?utf-8?B?WGkvSlhLUEQrM2xxUk10VVo5NzlBMDdnVmh0RkdIQUF6Rml6c1JZRGk0RUNw?=
 =?utf-8?B?L2F6NERKbms2QmdiWkpCWGVkR1puUjVQbEdzRklqSXVvbzZhVWxGemJ1UGM4?=
 =?utf-8?B?N1ZyZFlSTUpPRnJwN2lRZ1V5OW9McmtkeFpIZ0h0UXF0WWs4S0pLVHFrbWRG?=
 =?utf-8?B?QmtvZjZKcXFWbW5HT0gydkp1WURZNndNbHRZUHJSaE0wSFZqdU9wejA3LzF6?=
 =?utf-8?B?Z0ZySkdqbVQyMGEvcU50SzBHMnNSV3loa2FOZVNZVTg3SUhzRVg1T2poNGZk?=
 =?utf-8?B?U3hvTTluRjlDSy9EeHRyTmwzNHpxU2pKUWJtODd0WGdIbG5Ed1Fyc1FFNzNu?=
 =?utf-8?B?bHdGY0s0YktKNXVkM1ltaWM0Y01vOGdqQ013dm9nZWJFWkNXSHo0TzhURkJK?=
 =?utf-8?B?S3RzODBiT1FhbzBwWGMyOFZyemdIcFRDNXB1Y3BHSkp4NmZzSnJhcGczN3pa?=
 =?utf-8?B?RlIxcXE0dEtzYzBnbnE4R0k4L2FxZnVpSmpWd3RXMytMNlA0bEdkT0ZmdHNM?=
 =?utf-8?B?TTkrUG9HdzduVThMcEwyaXRiMGR1d0NFRHNSQjYvdzdFOGdrNVBUUE8rR3Rq?=
 =?utf-8?B?cmxoT2JQWEVkbUM1N3dVOFZoZ1kxdExnNkxTeXZ4c3VFam1udlNtVTZPcC9o?=
 =?utf-8?B?bUFCNUMxK080S0ptbGxPbkI1YmIwcUZraXdLWFNHSU0vZkVvRDNwTmwxSmgx?=
 =?utf-8?B?ZlpNU0tIL0xDNW5kOUZjaUVQMkh1YlpjOFpBWThRdHdkUTNZOWpWNjhBdWtB?=
 =?utf-8?B?dE9yTXlpbmZLL2xsOW9pd3dZSFgxTGNtNWtMRXdXYkxUZVpROG5ObEpITUNq?=
 =?utf-8?B?WGg1ZWFQWjZiQmUxRmNyYTN6NjA4ZTQ0Ym9BUXZpTUNDdjFIcnRwUllGSEVn?=
 =?utf-8?B?bjEvNktNaUJ6cGx3TmoyTVpWODlOZ3hXUG44U3c4VTN1M0N2WG9BdXZjRnF2?=
 =?utf-8?B?SjEzeVY3K2xweWhFYXdkNWg3RWtQNnJvZWlRa241dC9STW5UTXE5NnloYzB6?=
 =?utf-8?B?UEM0SEdnSjNmRm5ZR0NHbEJLWEtUam0relZjZXF2R2wwcjdyNE9LR1VUaDZN?=
 =?utf-8?B?QVM2aEJYNmJCMWJvbUd6RDN2R0pwcWdFZXdualZLeFZMZVJ3SG43WUhLSTJY?=
 =?utf-8?B?bFNITnlkc1RCSXBQWElueE5FSVdkNUVISHJkSzhqaUZRaVBxU3lBbkxkNmdL?=
 =?utf-8?B?Vno1bjFyWTA3b3o5K1B5QU0zaWN4Z0JpbFhtbmpHZllSeWpHbGNqcXVIWWlN?=
 =?utf-8?B?ZjltYmhab0Y1TEg3bHdjczVURTduZ2hySCtOTmQxdmZ4SHpvRkVXc1VIb0dJ?=
 =?utf-8?B?Z1BtbkZ3ZkJGRUFRbks4Z0U1eExvMGNZdlJheXhZMm5Nd2VuaXErUlJkc2tR?=
 =?utf-8?B?bEZBUnhzd1FwRG8rR1dPYzJQUllxbnROT002cXVkZDU5dWV6TDhBNHhxcFJp?=
 =?utf-8?B?K0pURWhlNXUyRzJpVURCdVViZ08zSHJWYWkwS2YxTEZyU0theUFpc0xvWCth?=
 =?utf-8?B?ZHE0MGMwbXhrUVVQUkFxZDVKVzZOTXRnTjVENzhXSmh4NFluTjBnZ1hxRVFK?=
 =?utf-8?B?SFYvZ3lyYzZPTWs5WG5CejYrdFV3ZDBtS3hJZWdtSlMxQ20zNkF1QjYyODEz?=
 =?utf-8?B?ejBaT2Z0eVM5a3Z2YzBXV2h3ejdGMGMzc2F2d2lzUnpDZ0VoSUxBUXluZk5J?=
 =?utf-8?B?NFFXR1hjOWMwanQ5Ym44Q2dIU1dwVjNZZk5leVdhTG13QTBXL1o3NS9OTGVj?=
 =?utf-8?B?VmNFNXZIc2hzVVVpbGx4UGJjS3BnVDBnSnAvRExRVS9NaEtnN01KNVpnZjlp?=
 =?utf-8?Q?cerQ178DNmoZuEXAIhdSaNyFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8611a6-46e2-40e5-a2c8-08de25b1570b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:14:33.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0RIyTvHieO7cQmwczp76vXftPbwlWp5G7hZKDeUfh3faNiHv2YwoHV1tTQDZIDG+nrmOY5diIkruS7BxG2rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/17 15:49, Markus Armbruster wrote:
> Honglei Huang <honghuan@amd.com> writes:
> 
>> The error handling logic was incorrect in virgl_cmd_resource_create_blob.
>> virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on
>> failure, but the code was checking whether to set the error response.
>>
>> The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
>> properly handle the return value, consistent with other usage patterns
>> in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index 94ddc01f91..e60e1059df 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>                                               cmd, &res->base.addrs,
>>                                               &res->base.iov, &res->base.iov_cnt);
>> -        if (!ret) {
>> +        if (ret != 0) {
> 
> I recommend
> 
>             if (ret < 0) {
> 
> Why?
> 
> When a function returns true on success, false on error, we check for
> error with
> 
>             if (!fn(...)) {
> 
> Same for functions returning a non-null pointer on success, null on
> error.
> 
> When a function returns non-negative integer on success, negative
> integer on error, we use
> 
>             if (fn(...) < 0) {
> 
> When a function returns zero on success, negative on error, both
> 
>             if (fn(...) < 0) {
> 
> and
> 
>             if (fn(...)) {
> 
> work.  I strongly prefer the former.  Why?
> 
> If fn() returns an integer, fn(...) < 0 is very likely correct (it's
> incorrect only if fn() deviates from "return negative on error", which
> is a bad idea).  If it returns a pointer or bool, fn(...) < 0 won't
> compile.
> 
> If fn() returns an integer, fn(...) or fn(...) != 0 are likely correct
> (same argument).  If it doesn't, they are likely backwards.
> 
> Because of this, an error check fn(...) == 0 triggers my spider sense
> when I read the code: I stop and look up fn(...) to verify the error
> check is correct.
> 
> Please don't write code that makes me stop and look up things when I
> read it :)
> 
>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>               return;
>>           }
> 

Hi Markus,

Thank you for the detailed explanation about error checking conventions 
in QEMU.

You're absolutely right - using `if (ret < 0)` is much clearer and 
follows the established pattern for functions that return 0 on success 
and negative on error.

Can I update the patch to use `if (ret < 0)` for all 
virtio_gpu_create_mapping_iov() calls in virtio-gpu-virgl.c to maintain 
consistency with this convention?


Regards,
Honglei




