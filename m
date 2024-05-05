Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854EBC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 07:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3Wbh-00018U-42; Sun, 05 May 2024 03:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3Wbc-00017g-PB
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:48:20 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3Wba-0000bF-3B
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n13S3Hi0Gwf2UTzG+k+3wFyFQ35PzzRgsQvtFklZulKyKBZJ6DHKIXK7bLbY3RLsYAj0wr4o7GZeEms2QT7iFFbBiTRgylYkLg0qpgDT5RvEoYahd47p2G56242YfR8wryZVd9YiHijuoixa6ycT6lUBo1DmH5n6WMKIiO8NO1c4PwfVz0c1Z3XA0LckvLJp4q6BxbHqqtEZlE/xM2697ByBc3mpKXliBmGlZ0Mdz/YPArZgTctsp8okn+2mVgccN/cqnBq2QyPQ3skR1DrcASAIQSzOJ1xnbfVhdWhFxusK106B1cV2ob7TbnKnEuJWUphA642VT3eTXBAqZd0zZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIoAiTbJJsoX9eUXw8Z8qjZzO1OyNBsMr692xKaJx8U=;
 b=jj9Xe9l7BcKypZLciynLgIkgUn8vaiuvZP/0+TbKKzKpQ0pKrF4Ce7L1IYNyhk9yW9HBRhf8vdcRmmS71Vog2xtNl9ZT8w8mAv2sYrmeKb178xdIgEfIPjkioTBPeqJGLMjvhkCJlVQmaW88t66y8x14AMjMWMj6KrrI6wKItmOCnavEeCxm96POAUA7D/oEti7LYKMkJ0u5SFjjx6asfDpdTYabtkLrn+3t8jsLbr0E+7futJKYXTAmIztG6QPRMTRPZCsKVA6B+f3VAJyc531z3nb5hTAJu5biJVVjHktcZQEHodpFK8AuqRdB9z7NFPnv50PTbIqlWxUROYiLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIoAiTbJJsoX9eUXw8Z8qjZzO1OyNBsMr692xKaJx8U=;
 b=Hx+eXJMllWsOcVA/Bwa+adx5twlEQ1A6x8aQidx8TwgM2AucxMir1P0BA9Nh1ka3X6jiNfb6jho/3KL2FHWVs8aN3s8K8jPUIGulSeVLU2glDoT1H+UCd+99/hKtRL/0G0WSboyQg7ovGQBD4AsyPwXpUomhjeecyXB6wiimNgT+XDBCr15jYdIkQM+BiMNTzcChLk8hF7rw0ckJ8EjSpKlyAoE/LivUz5tTfxXUj4HUFUoacsBPTijoxEURXaaOYCVrqnBf+sRZXgqokCHdAlT76zDDi0/oArTXWMI3O1eJOJW7VKJAq2CHIY8Z5VxWsPK0OynzcKU4TFs4atZ+ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 07:48:09 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.039; Sun, 5 May 2024
 07:48:08 +0000
Message-ID: <3d6438e0-550e-4f66-8932-45191ff64b8b@nvidia.com>
Date: Sun, 5 May 2024 10:48:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com> <87msp88nrg.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87msp88nrg.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 49faa97a-18c9-458b-4996-08dc6cd7b496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGZBQmVqSnVjUmMwc0EyQmpuT0ZnenhRbjRPQTQwRHZtK0JhdEc3ZlpkZG1Z?=
 =?utf-8?B?bVhuTFp3alZHNXkwQVZGNXc3ZW9GekQvUWY3ZzE4TGo4NDJrTW1hblp5YzFu?=
 =?utf-8?B?TkhkeTNNVUdseFNJSE5qaVA1Q0RTY2Q3YUZBTWdVT0xhYTd4cndRVWR5QTJK?=
 =?utf-8?B?THU5WDlhRXlQbHkyK09CWXRVcmtVNklzUk9icUx6QmU4WmtRZHBKQUVIQUNZ?=
 =?utf-8?B?SlpZMCtnb0gwUkFXMUJCbDZSOUFVcXFwS1RuYVl5bVN3SVdiQ3BGRXAyem8z?=
 =?utf-8?B?L2hCa0VabHRPMXAvVnVFWHpTeHkvTG0zcFhMcEFHTm5PeDZkaUJLYzVFdTA3?=
 =?utf-8?B?QXl6bFpHY1J0SFZSK1FvTFMrYkkwVGlqdGwrN0RuenU1UTFXaWpYQnVsS3g4?=
 =?utf-8?B?b1ZwZ2VFSmNtekdZVmVEUGd1R1ZCZUpnT2orL1NlVG5DaS9RKzF0YTZkN3hM?=
 =?utf-8?B?Um44L3dSR2QwY0VKeVVwYzgwcjh4ZzJwbnhuZ1Rxditmam9MYXpnVWZVSEdX?=
 =?utf-8?B?czk0aE9jTjhzZTViL1o1ckxCSFFCQzI1K2pnanNtNXc1MEp4bmExNUFHcTAz?=
 =?utf-8?B?Y01SSi9CSlI1c3R0NVQrS3M2L1NRN05hUEt0YmoxVFB0VHVuM3VwREhITno1?=
 =?utf-8?B?UWxDWmtUUWwwRVlWYlhsYThFaVBidWZIcjU3M3l3eFVTNTlFaS9tRWFwRzFH?=
 =?utf-8?B?TC8yLzJFQjQ3UGtLczByalZRYllWaXdMZFpPL01iVDhJdzl0aVpUQmdtcTQr?=
 =?utf-8?B?N3RleDRJSXdtakd1dnBja3RTNThmNmpJU3VGTDliaXVzOW5LdWVCdFpKN3Nn?=
 =?utf-8?B?WWFuMWxRVDZNQm1UVWRYM3AzeHN6Tm45VzdqTDlORU15WVRYVUJwS2RpQVc0?=
 =?utf-8?B?bzM1VW5aOGpydmJ4aGV5ZDRUTVJnOWlqZVJadkNMSHNMaDBhUmZzcWpLMFNu?=
 =?utf-8?B?ZkswaTFaU3NJcnJ6NEJ6ZHdmMGJlSEhKcDVLTVl3TC8zVGJqT3B6UmREaGdy?=
 =?utf-8?B?QnNFRHExN01xaDJ3WFZzQzZ4S0xOMlkvcmt1RVQxK1g4RkJyRGtPWXkxRXhs?=
 =?utf-8?B?WWx2TU9WbmV3czR1SFVIdUphYzVYOWE5NnhrY3QzejM0cjRRMXJHMG5ZQ1kw?=
 =?utf-8?B?UG4zWDRyZ2tGSWoyTUNIUnlKbjJMbjZIeVhldVU2Y2w4Q2NtUkV1eHhrVzQz?=
 =?utf-8?B?VmdHUElIZmsydmRDa2ZIVnd2M200b2xPUktDdTZ0RW1Mb0dVOHdZMGlkUlc4?=
 =?utf-8?B?a3F5OWxja3NjMmwzS2hweFRSaTZpbVI0VDk2TUs1V3BEbmh2b20zMllCUmZO?=
 =?utf-8?B?dE9sbzMwcXhBSUFZY09rM202NGZ3SVp4c2xjbmRXN0dKWFByWThzRCt5T1VB?=
 =?utf-8?B?TEx4R3VMVENKMlM2UmRpSkk1aWhPczF5aVArVFlhSkg0ajBPZWJwbmVkYVF4?=
 =?utf-8?B?V2VKU01RNWRVUllrUUp0aUlmdDFtUTRPdW1DTkZkcXlCYmVPS1hxdlFvYWQ3?=
 =?utf-8?B?NldscldxMEFjOHo5S3k0T1VsTGJjSWl1VzUvT2h4c1AvUDhMQVc1K1k5ZS9D?=
 =?utf-8?B?RXZtaXoxYVRTclU5VXJ1SVFNSXJPS2JDeTRZMWV4aTBraDR4VTBPUGdabnJW?=
 =?utf-8?B?YTJvc0FqTHZZOXRoWGxxMWNUZUlvMnV6WEloZ2hXUm41TmdOZDBVUTBYbWMy?=
 =?utf-8?B?cWhRZjhLbFNHT3lmT1p2c25LeDRnMG1EV2wyRlU4YkpJZlB0QjNwb2J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVF6NTBOSzRjOElrU3lEdlVzSVc3dWd3RTJUQWIyYWZSdG9xNlFIT0tuVWF6?=
 =?utf-8?B?aXQ0WXRpcU53d3R1U0U2WW9WUXZNMzlvdjUySE5JK3ljajlJakI0aXcvTzU1?=
 =?utf-8?B?RStFeXUweUV3MEt6dnEwRVQ3WlZSa29QT3dJd0pmMysrOHI3ZlhZZzZrKy9D?=
 =?utf-8?B?UnJpdHY5dEI0aXc0YTlWV3pCeUg1VHNQTUpxWHNrQ1dVSlVNWFRHVlpVQ0xU?=
 =?utf-8?B?Q2thbEpEYVRMMHlNalZISU5zZ2ZTTUhQR2xBaW0zbTR1Z2pZNmdZWm1NVGY5?=
 =?utf-8?B?R1BtTmE5WXB1eU1NM1NTRXlJM1Z6YkpENkpQZGxGSXdXYmFjY1FBb1NKdm1U?=
 =?utf-8?B?VndJWUZnRlRISzNyYU9BM2M1eW04NnNVa1BaSmtlVmMzcWFYNWpueDZ5ZEta?=
 =?utf-8?B?bmxXRFl6Uk9nMzJoVjFJcTBWK3hiY3c2ZW8rTHRBcnVzY0svaXJSODJxWnda?=
 =?utf-8?B?TkFEd0RuZXpwR01BTU9xdzBQUWtKWWhwOFF3WUtGQjJGZ0JzaENQODFGTHQy?=
 =?utf-8?B?Qnd5VDZqVUtBZGpxM0szSXFsYitOS21OTFhLRnNjaUpHUm10WDRtMEwrZjhY?=
 =?utf-8?B?bkNyVVV6aFRZWVR2N01sYnAwTUZ0S2xkWm5TVG9sdDNUTWhEZFZTTWpIb0pa?=
 =?utf-8?B?anFYRnZPNktIUEZHNUtKYmxjdm5VS1NqRTZjUW9INGhVV3Z2YmQvOEUvY3R4?=
 =?utf-8?B?T2lKYlI3WTJNcTIvMU1tQWVhYlJDMTEvZk15VklwV3JONmF4YVc1VFpVRkFN?=
 =?utf-8?B?RHVwSFpSMlB0cWorZkRCZms4NHVnUGxOTHREc3Z0WDdBeDZldjRHd256NTBm?=
 =?utf-8?B?L0srWmFRTURhZlR2YllvNnZtNGs3VlBtYklaTUhxRE1hNGRZVlEva0xaUS8x?=
 =?utf-8?B?WWJNWlQ5MGhoU2Q0WGl6TUtSa3RvSUtEZ1lNUVJqY1FFVmZYdUtYWFdEblpm?=
 =?utf-8?B?NGd5eHVpbUVDVElCMGlIL3dnMmVURjlSa1lQVWdLUnEyS2lhRFA0eGhSOWUx?=
 =?utf-8?B?YUxwMjUxZVRuNFI4ZVhkbkVYb1hPZ09hY0sxcFhHcVQ1bWdaVCtFQXdXSWpi?=
 =?utf-8?B?K3NZOENadUpPMjVPeGVURjVHbHArbFk3bGdHV3BGMkUzRFgzMnUzaDVCL3Ix?=
 =?utf-8?B?TjA0UUNVYkVvK0dvc1liOE1TYXNQeHkrVWZEWURKcU9nM3YraWFOa1MrUW53?=
 =?utf-8?B?c1V6R3NzVGV1VCtRRXlXQTFXc3B5dGxTZS84MGF5UjhXQ25Db2w2ODNzMVFL?=
 =?utf-8?B?MEI5aVl6c25kMXppbmNDMXVUTEdlVGlHUzRxZVB4eEVMazVZWXh1MWcxK0hr?=
 =?utf-8?B?SVJSNGhLZjl4WEM0V0E3WWlqcVZ2cDJEL2g1L256dzhXZnFLVFNhS0dsUk1o?=
 =?utf-8?B?amtMRE05NG9PaHBSb3JqN2Nxb3dCU3QxUzFPNVdOOG5wSWc4d2NIZnE2eG9m?=
 =?utf-8?B?Nmh5aC9XK1lKMU5qNmZqcmd2TVlGdkRpOGdIS0lFRHczeW5SaUJDYXpHeDVs?=
 =?utf-8?B?VnF1eGJidEVmcWJKZXViSFNGZVlzNWIxSjByWm92RWY0bG1sdUN6M2JNSndj?=
 =?utf-8?B?NmNTZlFhUWsyaUpSZ3k0L0VoTmlWR2R2dldtOTB4NU16Ym8veDllWDh0WVAx?=
 =?utf-8?B?bDRPcXI0Q0N3V3EyeU5yQWFFbTVtNHVValFIdzJDc0pyMmg0ellhSXpZaHEw?=
 =?utf-8?B?NERJSmN1RW1NakwyZ1hJcWtjWUlPMitvLy91MjZ6YVdKVFhoeVgzNjdZVTVi?=
 =?utf-8?B?aTVDeHdKU204TW1uYTV0MUxFWEEzaGE2ZUtOT2VoVlIzU1BCRDZNTG5uUmo0?=
 =?utf-8?B?bVZTZkQ0RFJFMk5uUHBwR1dGTXNXVTBqcWhJbURON3lzRHVicWZPUk1wWktu?=
 =?utf-8?B?L2l4dEpWbGc3ZnovYmJ3VlZsK1JVT21ESU1tUzVKT210MWYvejlVTnVhQVpP?=
 =?utf-8?B?Z1JoN2lSVmxFbWV3UVhUMkxDeTJScS90czQ0SFo4OXZDaWVUa1ROQXZSQUg3?=
 =?utf-8?B?OENXSEY0cVEvRGhuL1Q5MUU4TnBIekJKK21KVUM4djJTUmMvSDdNODZ2Q25X?=
 =?utf-8?B?ZlpoVE95ZFhjMDhPWjlPWEdHa215K3VVK0M0VmpqbjhSZU5weVNmNWthUENp?=
 =?utf-8?Q?BIX/7XshatSwtVvQe3F5ccCId?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49faa97a-18c9-458b-4996-08dc6cd7b496
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 07:48:08.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyzR14E/iXXxIFI6KQs2IKby9sYoMAcv5VpC+1CkUliO8/EfkgFmSCEcWrrL41UWpdPXH3q1g89W2N/8tlq+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Received-SPF: softfail client-ip=2a01:111:f403:240a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.23,
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


On 02/05/2024 14:19, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Add a new QAPI event for VFIO device migration state change. This event
>> will be emitted when a VFIO device changes its migration state, for
>> example, during migration or when stopping/starting the guest.
>>
>> This event can be used by management applications to get updates on the
>> current state of the VFIO device for their own purposes.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Can you explain briefly why this event makes sense only for VFIO devices?

VFIO devices have their own protocol for migration and a unique set of 
migration states.
This event holds info about these VFIO migration states, which I think 
cannot be described in the same accuracy by other events such as run 
state or migration states.

>
>> ---
>>   MAINTAINERS           |  1 +
>>   qapi/qapi-schema.json |  1 +
>>   qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>>   qapi/meson.build      |  1 +
>>   4 files changed, 64 insertions(+)
>>   create mode 100644 qapi/vfio.json
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 302b6fd00c..ef58a39d36 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>>   F: include/hw/vfio/
>>   F: docs/igd-assign.txt
>>   F: docs/devel/migration/vfio.rst
>> +F: qapi/vfio.json
>>
>>   vfio-ccw
>>   M: Eric Farman <farman@linux.ibm.com>
>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>> index 5e33da7228..b1581988e4 100644
>> --- a/qapi/qapi-schema.json
>> +++ b/qapi/qapi-schema.json
>> @@ -78,5 +78,6 @@
>>   { 'include': 'pci.json' }
>>   { 'include': 'stats.json' }
>>   { 'include': 'virtio.json' }
>> +{ 'include': 'vfio.json' }
>>   { 'include': 'cryptodev.json' }
>>   { 'include': 'cxl.json' }
>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>> new file mode 100644
>> index 0000000000..a38f26bccd
>> --- /dev/null
>> +++ b/qapi/vfio.json
>> @@ -0,0 +1,61 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +#
>> +
>> +##
>> +# = VFIO devices
>> +##
>> +
>> +##
>> +# @VFIODeviceMigState:
>> +#
>> +# An enumeration of the VFIO device migration states.
>> +#
>> +# @stop: The device is stopped.
>> +#
>> +# @running: The device is running.
>> +#
>> +# @stop-copy: The device is stopped and its internal state is available
>> +#     for reading.
>> +#
>> +# @resuming: The device is stopped and its internal state is available
>> +#     for writing.
>> +#
>> +# @running-p2p: The device is running in the P2P quiescent state.
>> +#
>> +# @pre-copy: The device is running, tracking its internal state and its
>> +#     internal state is available for reading.
>> +#
>> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
>> +#     tracking its internal state and its internal state is available
>> +#     for reading.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'enum': 'VFIODeviceMigState',
>> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>> +            'pre-copy', 'pre-copy-p2p' ],
>> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
>> +
>> +##
>> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
>> +#
>> +# This event is emitted when a VFIO device migration state is changed.
>> +#
>> +# @device-id: The id of the VFIO device (final component of QOM path).
> Provide the full QOM path, please.  Feel free to additionally provide
> its qdev ID.

Sure, will do.

Thanks.

>
> Precedence: events MEMORY_DEVICE_SIZE_CHANGE, DEVICE_DELETED,
> DEVICE_UNPLUG_GUEST_ERROR, ...
>
>> +#
>> +# @device-state: The new changed device migration state.
>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
>> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
>> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
>> +##
>> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
>> +  'data': {
>> +      'device-id': 'str',
>> +      'device-state': 'VFIODeviceMigState'
>> +  } }
>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index c92af6e063..e7bc54e5d0 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -52,6 +52,7 @@ qapi_all_modules = [
>>     'stats',
>>     'trace',
>>     'transaction',
>> +  'vfio',
>>     'virtio',
>>     'yank',
>>   ]

