Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B68C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s80aq-0003z6-VN; Fri, 17 May 2024 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1s80ap-0003yd-3a; Fri, 17 May 2024 12:38:03 -0400
Received: from mail-am0eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2606::701]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1s80an-00078h-5w; Fri, 17 May 2024 12:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhEBG2RDRf7MzbGp/APkNKpycWNkCuUU/Ga5Fy3e5yqdYlEGVYUW0hzF98Or024lvA87Cd4Lk6cuJQNSGUx7jWIHWucpU9VxkIsIUKr//yJPIjI/sNZhmGxlyamLZoKtPv56x4Bof647fEwBD6xM2BD+msMzqfhOvoh9FLdXpP4V23dW4glXAoc6jnCPQgQBLVDgVZdCCYRp/9R5/UXoagLEfXzsaI2ln6J0JrWPr8xx6KqXYhT9Qdu6rH1oxHANo4a3f/UQ0foZ7H7Mx4IaucI2BGUa/9XiPCyIp0UtLTb0wLiWyv//LI+aLkGUg/E7iiyK3++TMbboL7jkm9GTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGHFHiDLUME+aunhzA1v0pteck0VALS8+1PYfNcF+SE=;
 b=MnJIm4uYRQZnqYK3MWuerBSW4cQ5SVNnskhAsI1aAtyEnvF8KrZtCckqdkx95nKLDVCYbf975a+HVxlp3Y4a+gJP7H/5NssKxL95+gpdxblWRUrI4GMaRfflEEPQQAWPzhfjfVO2puZx5ij1IhI98UpPEnYg/aBpvg9zqFSxH9g97v8145GAa37R0IP1Bz9jI0lwfPjni4WZf9nlenAtT+85c7mWMC9MhPyJdA38kmQqDKwi4Mk4BRZWcbZn8r4HRO7BXehax7REZMv9xSNYIAFncIePOa61lrH/gErfTV+Q/Glz21g5IprXHT6f8EIsG+m+kNvgTkl2pdM+nwH8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGHFHiDLUME+aunhzA1v0pteck0VALS8+1PYfNcF+SE=;
 b=aLmnKnmffU3TMiI6powbCsyCSkbD6NbBg372l9HRXVrrzPwU+Jro4ZPcedp9wSNFN2jEHGcmN14WvTUi0HfXzSk9VjG/kKz+pLyGoMUEUP6u64TH4oIUicCWKXXcz9dmpkTzu2+ApGVf5xsTshcn1h4CZnwXsPm9nzmdUtSkfCyvXwXDg+9Zli5qafel6MtfUgnFxiJuBVl/mnvFexq98P8x04mNr0n0kuIBZfz1yb5PV3bEgZdcDA2raEXnlVAcC/S+TlIMsM3JAykGA6VV12Kn4fK1idyRlXawog51/rR1WgZLzz2+cxwQPL+5dP8gBeXAtQebxzXTjMtQ2O0BPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DBBPR08MB6089.eurprd08.prod.outlook.com (2603:10a6:10:206::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 16:37:57 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 16:37:57 +0000
Message-ID: <663bac83-eaaf-476a-83c7-bbef69605948@virtuozzo.com>
Date: Fri, 17 May 2024 18:37:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] prealloc: add truncate mode for prealloc filter
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240430170510.148812-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240430170510.148812-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DBBPR08MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b52072-88df-4d9e-09a0-08dc768fb573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STE2dDJEZk9BTTVvcDlXQlhKVnlIbWNuaTlLK2xyTll5R0V3UXFPRk5YSjF0?=
 =?utf-8?B?ZEdLOGl2ZC9xQXkyU2U3MGRsNGoycTc0UFVuMmpCZXdBbzBHMXY3TzdNa2Nt?=
 =?utf-8?B?UEU5ZjZCRldEVDk5anh4UHZ5S1ZLeTQwVjVNdGFvejBrbDNGUmxmL2l2aWk1?=
 =?utf-8?B?QWlrK1JqdVVlS0F5M3FBT3VLVGZ4YUQ4YmNyb0t1QWZMcVFGbW5uQ0R4Z1pT?=
 =?utf-8?B?Yk5wYjgwZVhxR3FzVVFGTzFrd2Z5a1Nodit2UzkrT3RoTmoyK1FzbiswMGZR?=
 =?utf-8?B?UFp2SmU3aWtjdTBUU0l5WUdKVm5WOW10S1Q4b09ZYVJBeU9TcUJ1Yy9uV0pW?=
 =?utf-8?B?NGUrenhlUStxellLUmg4MTFNM05NM0tJWjNzUjRabFZ2WWxXaFhaRnplQndG?=
 =?utf-8?B?OFU4SU92M0FGYUZ3SWZrb2o5Z3B4YXl6QmQ3L284eVg5elJna0lObEVOeFhO?=
 =?utf-8?B?MWJVTXl1RWFqWmpqQ0R3aGRDWUxWa0lYN203NnhaR25ldTlBeUhWOFl6UjFq?=
 =?utf-8?B?QjVxM0s2RW4xckJNRC94WGx2RnZjZUhnS3g3YmJabUFpSExvZzRmVEFGWHdR?=
 =?utf-8?B?U3RObWx4UUFvc2Rkd2lPVzQzRXg5L0pzZ3BjT1NyQ2k5WlNOSEpVUFNUWWlS?=
 =?utf-8?B?d05xL2MxVkMvMTRCZ01wbVVnbk56aXlzdWFmMzhkRXRaTHBpNFhVbEJkUWg0?=
 =?utf-8?B?R0d3TGF5VVlleWp0U2w2MG1hclQvQkhra0tSWnA0cnM4UWY3V080YjdiR3gr?=
 =?utf-8?B?RzAzUlhyVy8waHA3cmQwc0lRYTM5Zmk1aS80Z3o1T3QzTmpFdFFpdUZPVnFF?=
 =?utf-8?B?Vzh4Z0J1Rll2Q1E0V1pqTkVDcE9DaXVad21EcXhGRXo4MmhKYzJUZ2xSK0Zj?=
 =?utf-8?B?MkE5V0pYTVo0NWRWRHNrakk5TW9ORG1hMEVjb1JNQ0t5SXE4SlNKbGovMisy?=
 =?utf-8?B?dWtIV3RVaUk4S3BJYkx6VC91VXp6dGsxQnFDYUNzM09URUs5WFJwQnljZ0RV?=
 =?utf-8?B?cjdlREJJT0RLUmZhMTBaS1NOY2hNRTNJQThyTTlSMWcvTmlwNzltcWhmWkI0?=
 =?utf-8?B?ZzdlZmZHUkFuWWd5dXJvNGFEbGYrQTVudFkvbGozY1NmS1RUU0M4YXhtOEF6?=
 =?utf-8?B?RGEvZW56eUhJRlc4YmZ4b0VGa1lVZVk1MnlaVjBDakUyMG9aQlBkbWNhQUZm?=
 =?utf-8?B?U0xZNFo4SEpEYS9kV1hKeDB3WTBSdGpyRTR1cVl3RWJZd1k3UStoWjFPU2d1?=
 =?utf-8?B?YlVzNytSaGxLczdyd2FYcWF3eEdBMGU4cTY1c0JROGhKYi9XRWhvV0tqbTFp?=
 =?utf-8?B?NFN1WGJzWUJ3SVJYZGo0emlBL3kveWVBUzlJMlBJcjVUQjByc084eTZzeGlz?=
 =?utf-8?B?c1FBdVBDUm0zbG50S0tWYlNQeU53N2w0bmQ3TDN0V2lCc2MzZjVxdmxYTDVL?=
 =?utf-8?B?dm0venRLbmd5azFhbWx2Q3g2VGEybWtXQnZqeks0OHJkU2R4UVNIMFNHYTBO?=
 =?utf-8?B?UXFXNVdxbUJkTkJMYlYvUE83TFByek83Y1dYLy91dGZ2dldRaXRrYVZtY00v?=
 =?utf-8?B?cGR6Q3dOU0RlWTRPMHhHVVVnai9XWEpiY0kxZGlRN3VRNkhwOXloSlV3RThn?=
 =?utf-8?B?R2RITGJhUXZLcENkSlZQOW9GZFB2Tmo4dGpiWFhQWldzbzl1MTQ3ZmVHRjY2?=
 =?utf-8?B?d2x4VEw4Tldxb2ttL2dIaDY2ekN3U1hJT0VNME1jemQyaFdaUmJnNzhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzdNSDJieHNUcVlBb1NsSjlmcXpNVXpDd3ZsS3pxc2tZTTJZUWJSM203dXFj?=
 =?utf-8?B?Zm16Z0pkQlRVUW1iblpxcFpxZnQxNkw5bEI1QTV1Uloxd0pRMjNGdll1MjQ4?=
 =?utf-8?B?RGh2SldrOE5vckpvMGk0ckR1ZUs4WEVpQWNMK0lRbllmanM0Zks1U2p0cHV5?=
 =?utf-8?B?bVZZb25NNml6K0dtQjAvOWhERHNWQ1dNYjNYWTA2VmExQXIxYUJxejdHZFhS?=
 =?utf-8?B?bEhiSGMxU2pwZUVuVVpjeWQ4TUVVWW4xUHlyWGtHOHN1REoxa0tVSjYwcXd6?=
 =?utf-8?B?R2pneFZLWGVidWRBdlpwRDdHbTBsRHdjNW5JMHhPVXljYng3eWIyRTdwbkM1?=
 =?utf-8?B?R2Q4dk5BRlNpVE1yNkhaaHF6bTV6RWl1eXhBUFpGaHA5bnZJWTVVZkZVcHcw?=
 =?utf-8?B?RE5UT1h3cy9BNzhtbmllMzB1cDYrdUk2bjJWcnRJNGQrM1ZLQWcvU0NUU2RY?=
 =?utf-8?B?YlF5ODU4WGNubnV4cTRqQU53Vk5kM3VrcEV5bys5UG1VYXQ5MEQxSGRISDNx?=
 =?utf-8?B?SWpvZ000WnZxdXJoWTRZdFpMUjgrVTVmMTZnTUwxSWhKNlM3ZERDWlY5S0Iv?=
 =?utf-8?B?TWVDakR3LzdUWGl6b0RRby96dzRYWjNNMCtnRmF5UVZBM1ZZMnpMYWpLaFdt?=
 =?utf-8?B?MVEwN0NTTUI5RWxGN3VTUHhBTzRmUEJ1TmgvM0lUbnNPNmprVER0MVZpMG9p?=
 =?utf-8?B?SGRvVEtGZVF6eTNTTi9ZR3ZQdU56VE95V1ZYZmFXNk1NT3dzallFck92Ym9J?=
 =?utf-8?B?QjVYNHhnOUI2Wm5wMDF2RVgzK29Bak5laDNTQlo4Qy9Lc2YxRnUrNERPcWdD?=
 =?utf-8?B?ZHljZGJtcTZZTUY0RUpacU1FRkxKUnNrZXZ3YjJYVzFXc29aMytQeTFUYm1z?=
 =?utf-8?B?dFMvWGRiN1FQS2MzQytDVHhwd01rT3NpV3FQY3Qrbm40bG9tTkI4RzRmV2lM?=
 =?utf-8?B?bWJnOEcwVS9FUDNBQ1JiTS9XcS8yOXovNXNMYjBkMnhVaU90TVFSNC9Bc2lu?=
 =?utf-8?B?RE4vYTFFWnhpZDZlL0FEVkh3UVdROGtJVFlkdmFHRjcyRFlNU2dDY2pSK1lt?=
 =?utf-8?B?VGNZTG1lVjBIdnNZQ0N5WGQ2eko5NzYrbXQ4OFVoZ0xGZFBKVUh6QmhmSEti?=
 =?utf-8?B?QmUvQVdPdVJ3RUVCK3hiRmJTbHpORTBVR20vd3VlQ084QmJpVGthczcxK0Qz?=
 =?utf-8?B?Tnhkb2h3MVhaOXNLb3E3UlUxZGNpNGkyUEp3THN4K1laZVNTdmxRc3o1YUFZ?=
 =?utf-8?B?V2pJR3NFV3VIVUtJa3daWE9JcEgwY0k5ZHFOWHd3T2FqbExkWXRCUTBnWngy?=
 =?utf-8?B?dzBrcURKZjlmNW5TSkhtL21ReTVUMWltRUdFK1psQndHd1gwdXlFSXN3cUE1?=
 =?utf-8?B?NnR0cHJmZDJ0bFFxTzVlYWV4YzhGUmNnTzVnQ1R0ZVZSZGtPSzUrQWYwdzVl?=
 =?utf-8?B?NS9tM0pNOFJCKzZ0cjNhQ0k3VFhBajB2OEFscDQ0ZlZKTk9tUmI1TG1sci95?=
 =?utf-8?B?aktFVVFPR0ZmTDVTaXRreXVHUjJ0VWZzZ2JjQ0E5bFB4RDdXUExLVFEzVXRD?=
 =?utf-8?B?dS9FeWcwbWwxQWZPbkFqSmlpdlBJaXluY3Z1cW95Wk9rWDJ6aGQxOHZCTDJC?=
 =?utf-8?B?a25odlBLT1d6b3FKR051NCs0amZCRTAvSC8wR2NGS0I2QXBOM2xGQXY2dWJo?=
 =?utf-8?B?ZFZZQ1p3dityME5pR0d5eUpFU0ZmYW11cGgyNkVZYk54QkJFNzQ5ZDdEUjRj?=
 =?utf-8?B?Q3NueWo1TzljU2FjckZ5alA3V1hob2xjMVZVYmhyQ0Nwb0Z2NWY3azVzNDIy?=
 =?utf-8?B?aUpCVUhKZWF3ZThzdm1QVjVOak13M2E4WEtpb0YxeTVuaUlRdkVhMGplRE5M?=
 =?utf-8?B?UUM4UTAvSnlRRHBsVXpIQ0oxVS9pQXhwK0ZaUEVGakpyc3hKdTh1TVJyK0Nm?=
 =?utf-8?B?RWcwangzSk10SDJzQWpPakdrSXRZL0ZYZGxIdS9tTTJzMGsvUHQ5MUxtdXlH?=
 =?utf-8?B?OTJ3Q3lGWk44djhJaWIwamZaN3pYSEZ6Q0o0TEZSWjJZcVRVMzFHNHgyUGNx?=
 =?utf-8?B?L2VwSWZZM3dnWTNJMkRPc2JwNnNHRWdtVU5WVVNpR2N3akQyY2hlbjYrU2Vn?=
 =?utf-8?Q?+FcZKVPCX1VIRYGxVFO/HZTKm?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b52072-88df-4d9e-09a0-08dc768fb573
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:37:57.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7OimOpzmcwGFR+ue8FOP1oAdIZdwYyd44HxUp/VUuw74EJbwqSLBpEirNJOhLl5ltmICwBXp22VKs5Mk6psRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6089
Received-SPF: pass client-ip=2a01:111:f403:2606::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 4/30/24 19:05, Denis V. Lunev wrote:
> Preallocate filter allows to implement really interesting setups.
>
> Assume that we have
> * shared block device, f.e. iSCSI LUN, implemented with some HW device
> * clustered LVM on top of it
> * QCOW2 image stored inside LVM volume
>
> This allows very cheap clustered setups with all QCOW2 features intact.
> Currently supported setups using QCOW2 with data_file option are not
> so cool as snapshots are not allowed, QCOW2 should be placed into some
> additional distributed storage and so on.
>
> Though QCOW2 inside LVM volume has a drawback. The image is growing and
> in order to accomodate that image LVM volume is to be resized. This
> could be done externally using ENOSPACE event/condition but this is
> cumbersome.
>
> This patch introduces native implementation for such a setup. We should
> just put prealloc filter in between QCOW2 format and file nodes. In that
> case LVM will be resized at proper moment and that is done effectively
> as resizing is done in chinks.
>
> The patch adds allocation mode for this purpose in order to distinguish
> 'fallocate' for ordinary file system and 'truncate'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   block/preallocate.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 4d82125036..6d31627325 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -33,10 +33,24 @@
>   #include "block/block-io.h"
>   #include "block/block_int.h"
>   
> +typedef enum PreallocateMode {
> +    PREALLOCATE_MODE_FALLOCATE = 0,
> +    PREALLOCATE_MODE_TRUNCATE = 1,
> +    PREALLOCATE_MODE__MAX = 2,
> +} PreallocateMode;
> +
> +static QEnumLookup prealloc_mode_lookup = {
> +    .array = (const char *const[]) {
> +        "falloc",
> +        "truncate",
> +    },
> +    .size = PREALLOCATE_MODE__MAX,
> +};
>   
>   typedef struct PreallocateOpts {
>       int64_t prealloc_size;
>       int64_t prealloc_align;
> +    PreallocateMode prealloc_mode;
>   } PreallocateOpts;
>   
>   typedef struct BDRVPreallocateState {
> @@ -79,6 +93,7 @@ typedef struct BDRVPreallocateState {
>   
>   #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
>   #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
> +#define PREALLOCATE_OPT_MODE "mode"
>   static QemuOptsList runtime_opts = {
>       .name = "preallocate",
>       .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> @@ -94,7 +109,14 @@ static QemuOptsList runtime_opts = {
>               .type = QEMU_OPT_SIZE,
>               .help = "how much to preallocate, default 128M",
>           },
> -        { /* end of list */ }
> +        {
> +            .name = PREALLOCATE_OPT_MODE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Preallocation mode on image expansion "
> +                    "(allowed values: falloc, truncate)",
> +            .def_value_str = "falloc",
> +        },
> +        { /* end of list */ },
>       },
>   };
>   
> @@ -102,6 +124,8 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
>                                       BlockDriverState *child_bs, Error **errp)
>   {
>       QemuOpts *opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    Error *local_err = NULL;
> +    char *buf;
>   
>       if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>           return false;
> @@ -112,6 +136,17 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
>       dest->prealloc_size =
>           qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
>   
> +    buf = qemu_opt_get_del(opts, PREALLOCATE_OPT_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
> +    dest->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                          PREALLOCATE_MODE_FALLOCATE,
> +                                          &local_err);
> +    g_free(buf);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
>       qemu_opts_del(opts);
>   
>       if (!QEMU_IS_ALIGNED(dest->prealloc_align, BDRV_SECTOR_SIZE)) {
> @@ -335,9 +370,20 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   
>       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>   
> -    ret = bdrv_co_pwrite_zeroes(
> +    switch (s->opts.prealloc_mode) {
> +    case PREALLOCATE_MODE_FALLOCATE:
> +        ret = bdrv_co_pwrite_zeroes(
>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> +        break;
> +    case PREALLOCATE_MODE_TRUNCATE:
> +        ret = bdrv_co_truncate(bs->file, prealloc_end, false,
> +                               PREALLOC_MODE_OFF, 0, NULL);
> +        break;
> +    default:
> +        return false;
> +    }
> +
>       if (ret < 0) {
>           s->file_end = ret;
>           return false;
ping

