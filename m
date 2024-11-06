Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD327D59F41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iDr-00084o-GH; Wed, 06 Nov 2024 10:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t8iDn-00084Y-Fq; Wed, 06 Nov 2024 10:45:28 -0500
Received: from mail-db8eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f403:2614::70c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1t8iDl-00070d-Bc; Wed, 06 Nov 2024 10:45:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdEsf6SD6LRnWx/u8A5D8Tkj+OZjRB2M3zo2awTBMDlPcP9vEX5Vj5meTgYj5Qp3qJwYh8outf58HEtuI9mXyEN0lM5mbM6MyCXipNCDxFB6EjeUINPW1PUfUhPZLYqelRMkC0fa7IVrSeW2Zm1ektxcyB7+aEtE4cEq3zax87kI75GOj3QsMQ51l5vM9T2KNAAZY09gKo/57/slKQ2wvMZQ9y/sz4ZEwK/dIO6myUl+hReTmq3BDOPtgM11rX4wfvtiVIsGhzzJd+gH5bpfMP9C1K2QAHhqizAa+/SPbJyzjJI6j4Oy7IOqg2ZvYF1NqKbF43pDqfFWgvQPm2Onew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrAchx6gxFIQCg7ELF9HYua8UrINgMF8Tw7gLal7xt8=;
 b=RuqtV0K6jqfakfp77OaVnUzhspf/d8iFyY+/M4HZmSNcgd/k5yesjXRTptOVIYfUgLEDKXG68WSBqeiPABALxElReOjByY69rWQm5sqIck2vbKIS8YVyZUZliDUcFVkLBBLpyw/LikSrtY5pvNPCXCVkRwUyRuVEJRnC2k6hkgE3TzPd27tca679fQOvcaqMYGkBepZkd/EnCYkczP4aaMCTPVpCSnL8xBuJyRIPQ3Q6ip3h46kmGCCyx4/+M5iE8lq5IPLnR1lBcmqlrebJVYltd78lM3BiSd4aqEEWkpdyEoUc2rOiVXP8rnapa3giXz0mUX5AIqCVhJRJAjLgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrAchx6gxFIQCg7ELF9HYua8UrINgMF8Tw7gLal7xt8=;
 b=w6MfsRe3Gbrzcb8PLzFZbRmVLDeDUWyxkY1RK2PKeizAY5hlp6KWsvTAEGABWdgWlvA8yglWj60BUu4WbUL/Mj3t1+XoOwKhoeAKZ2fHbBpbnXXf7DQBEWJDafT1NrXa0bsUDnXfX5/uB6gxOmfusHeWYrnwrq0EKpBjhs0Hp189K1izkW2jzZ2cyQHfcGDvRP98VjBQ/8dGycpGB7pM7kduxg/ldOo5ZTgIlH5DE4aMUXxwZOdW3SRYSW4OnpSYwEnyUnWpl/0j5YxBbDXCr9GsqXYd4tw3uUm/1KXOd5Brxjtn0V62Ox5qtrZ4K69vozOOxVN6Tlqd75ie/TO/lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 15:45:16 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:45:16 +0000
Message-ID: <cbd949dd-673d-46cb-8cd7-9fc94515afc0@virtuozzo.com>
Date: Wed, 6 Nov 2024 16:45:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix possible int overflow
To: Kevin Wolf <kwolf@redhat.com>, Dmitry Frolov <frolov@swemel.ru>
Cc: stefanha@redhat.com, den@openvz.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241106080521.219255-2-frolov@swemel.ru>
 <Zys8tLcKjADMtkqn@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Zys8tLcKjADMtkqn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: b04067b2-2ae3-4349-2b36-08dcfe7a027d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0hjUE12c2ZWTVF2a1NZNUlPY3pVci9ZSUVScThJVUNWb0ZjcFdoTXdCSmFI?=
 =?utf-8?B?SVBwb0N1Y0haUU94Z2hZRzFTM29zS0ovV1VrOG51Q1BFRWEycXZ4SkFnVHpP?=
 =?utf-8?B?Tm1rM2RERHlYQjg4RkpTdUwzUVdzdzA1MUJGSmVHT3g3dkxEMGhVby9uRzhl?=
 =?utf-8?B?c1FwdkExS003amJLbEtKUnl5YktsS1BxZExreExuZ21XUTFWZW1haU41Q3M4?=
 =?utf-8?B?YUR5OC8wYjlkamFGb3hpYjllVit3bVhhazdLWk0rNS9IRE9uRHRMbnBHU1hj?=
 =?utf-8?B?VW1QTXRzeVkwZ1NBbmUzQW9peWdpOWl6Nkk3Zlp1Nk1JYnB1TGpDTzcwQ01q?=
 =?utf-8?B?ZW9GU3VYVGI2UkNoTXloQUNIS2o5RzVyOVlteGRBb1h2alQweUx0QS9DdGpW?=
 =?utf-8?B?VnVOck1HNjM5UDU1RktoTUtaRnZ2cC9uc0pwWFFDUk5sNmJiVUVsZW5KbEo1?=
 =?utf-8?B?OHhrZHdVaTNQd3pSdkl5ZnFiOEVYK1hCemhybWUwcXNLb2xTcUFrak5IbkJS?=
 =?utf-8?B?UG9oaUkrM0JjeFR0RWhESzRjTGRsVDRpSXJFeWNaRitzb3Nob3BsQktQNnBF?=
 =?utf-8?B?MVJ3Y2tjKzladm5CZWpqQitQalFqNVNhWnhvb2FvdkVkYzRRdnRaem0wVGxi?=
 =?utf-8?B?Y0xWaGRXbStPY0h4bUhzYWlFOVA3QWxyOHA3ZWxvcCtzZ0tldTVaMU0vU3lj?=
 =?utf-8?B?TU5IaEFJSHF5c3p5Ty9hb0hLQlJVVDMwRXV6dlpiSGZIaHhHUU1tTFdRZjA1?=
 =?utf-8?B?clZ1WnZCMkN1VTlTZGVEU3QvVjNtZXMvWklGNUI4MlJnMlBzWXk4eEQ2aEpz?=
 =?utf-8?B?am56dW1rUndvMWVCcVZqc3ZDWGxJTk9na2tac1FSaXpUM3Q4M2sydi9tWWFt?=
 =?utf-8?B?SGpibHRLdWtTWXZkeTFkMkpUOEZUN2pwaVZZb2VJVDBXa1M1YmFzZEEvMWRT?=
 =?utf-8?B?RXdHazBkTVVVTjhhSlJoZmtPcjRnL3NzOWV4UTJwS1BncUFaQWg1eG15eEdp?=
 =?utf-8?B?L1Rzc1BOUWtqM1d5SFFEVWcraTlycmdPcmM4eUp5Zlo3VDBYOXl6Z1Nmby9s?=
 =?utf-8?B?ak5yVFdPK1lXL3JyeW5DM0pwTmd0TmFVZ3NBNkkwYWNZUFBWMC9nZ29BQ2JV?=
 =?utf-8?B?aXV2RHEyaGUzaTNUZUxEdTFQbCtDL0cvTkxjY1U3L2ZHeHVmUDBBRmljZU1T?=
 =?utf-8?B?ZW9xcHlIMENMYWZYcG5EYXRLRlM2ZzRoMmc4Zm5aUFczZGdZSjU4SCs1Ujln?=
 =?utf-8?B?dHVyclZLcnBVNGd5RG9sNXJrVmFzUHNMZFRiWmZaNDQ1Qml1T3BUMDEzQWEz?=
 =?utf-8?B?Wmp3ZTdPRTd2R2wvRURlUFlZMzZnOTNxaFFBNklqc3RaeEp5Sk10LzQvQUlD?=
 =?utf-8?B?Y2ZVT0daOE9iOVl5V3NFSUdQVThuMGlMWFZCUkJYUDFaNnZuVE5nVndQaFhX?=
 =?utf-8?B?R25panBESExJM2ZnWG0vNzZRQ2lyOXhDNDN0MjhhSFVJcUFVNjlqVkNyb21V?=
 =?utf-8?B?Mkg5NjVwZVpndkZMS3o3NW1GcXltR2R4LzVrRHYweE9BWEx3WTF3NUVQVWxl?=
 =?utf-8?B?bXhqbjNVRjdOVDF2THdBUUxWM3ZsQkMyRDRyOHppaHlCS1grLzFPbG5jQUs2?=
 =?utf-8?B?bGl5UEc5QjlRRzNzeU9RakVkVHF4dWJxL0VhT09BUVI3YklySTNuanJpSmE1?=
 =?utf-8?B?dUdyeEh6dlRKQitHeXJYSFdJdHYzaGpEMVR5Nit6UVl3SHVpZmhoaGZOelk5?=
 =?utf-8?Q?Phz7eIBjnyiX3C7zanAbWgwd7ak2tsoWf1+y72v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU93ZS95VmIva3Fob2FEeFlTaXhxVXVHeDdxREtqRGlRZVVtYkpIYlZJMmN1?=
 =?utf-8?B?bnZtNnZta0J0eXFKYlRVZEU1OVBZcVZjeW1vSXFzVFlUTTFOTVZHd3p6Q0l1?=
 =?utf-8?B?YUNMRDJEUEVqQnNwZHFXTDlMbkdYQ0Y5UXZEVU9UcmhZT1RjT1lhcis5N3d2?=
 =?utf-8?B?WFZZTnNpVHdoL2JQNS90U3drRXoxYjZkQkZxWC84Vm44VzNsVFE5aW0rNzZn?=
 =?utf-8?B?YWhSUFh0VTJvL0UvK0J0aS81RExYcWtTR2I3a1BSL3RSeDhPallTOXRGajEr?=
 =?utf-8?B?RDVIaDVrZ3VkMVlsTTgrcHJKM3AvUk5QMGhET3ByeTY3SDl3V2gwMWV6RW0r?=
 =?utf-8?B?Z29tK21KK2gwbXhMelhHbUI4NGVSdEJ6ZWVEeG1OekFOR2hJRzR0RWhQTFBY?=
 =?utf-8?B?Ly9XSGRicUpGbStzTlZ3Y0w2NS9rZ2E2cjlTcStwWWpvb1h6QVExT1FNRWFG?=
 =?utf-8?B?UmtlcVFHb0xPY3ZrczQ1VndlZXh3TDdVTnZvYlhUcFZ6amphSUdDWnQwMGdO?=
 =?utf-8?B?MUl5SkpEaFpyWnNjNThTOEQyK2YrWEsyZ3hMREVFc3V2YzNxSFRUNk9Qa1Mw?=
 =?utf-8?B?TUE1Wk5nRFV4V0FvNFllV20vczJMK1VCOWcxc3pmbDhXTnBrWWo2WFVic3pZ?=
 =?utf-8?B?ZkxIY0NubDZsWlVwTjA4Mm5vYjQyRUVOUWFxcFVKV2Exa0h5OHc0cnNYdjkv?=
 =?utf-8?B?cVNTeDJMWk1BdWJQRjB3UnZrNXlQeWJ1MHU3aWMrWUNPUDAyWXRFcTVNSXJH?=
 =?utf-8?B?emttWmZEcDdPb0RJUkN6L2JWdVhzeHJBWTZWNWVnTy9pMlRWZVp5QWVKa1Ny?=
 =?utf-8?B?Y2lrSnlHeExwVXZMN2xDMUZTUUpvT3pySjJkdlNLUlZNUGptV05DTXowbE4r?=
 =?utf-8?B?L2FGS1RtN09pdUt3RHp2QU5tSlFmSm5Zb05Zd0FOM084eFRmd2RaYktyVWp3?=
 =?utf-8?B?WUZFU3dTNGlhNE5aV1NWQ0JEdFRralhXanJSSG4yUDB0Snl2N3hTS2RUY2lV?=
 =?utf-8?B?SEZLSS85S1JzYW02NUtWNUl3NlpLMWdJSktuQzFVYzJCTzVLKzZJbEtKUmo3?=
 =?utf-8?B?UERlZkJIUzdKUXBJOU5tZnhiaE5RNncvekg1K01Hb0E5OVJWVUwvcHoxTUNj?=
 =?utf-8?B?aGdxUjhuQlRJSnN4T3M3ZGZ5VjBpbWtWSjluRy9lRWNBWjIxZ1NMWHFPTXcv?=
 =?utf-8?B?U2tPU25yVUZEQkl1RTlFalFSRHZURmJEb0gvcFpGc2ZlK21qTTNCSjhqS3Rz?=
 =?utf-8?B?KzJmb250NmdvdE1NMlQwUFpEelhuRXZHY0NpMHozNy90ODNXV0oxYUZsQjNa?=
 =?utf-8?B?UWRTeDBaOTJTalN6TWZoWHlWVkk5ckg1bFlOcUx1MXdpS3NzQ1dMaDFmWFZq?=
 =?utf-8?B?VEpjNHpPTVM4UkJFd3NDUWhuZG4rVVZtbURiVUtNWUFnU1JJWmp2ZjRBK2s2?=
 =?utf-8?B?eW80TWxGYWQxYkFmbGV3UG92aElIUW9YMHpkc1FyUyt2M2ZSRitJYjBWSlRw?=
 =?utf-8?B?bTQwa29mdGU0c0IyZFMyMTRvdnVWZzhDeXQwVXNWSXFJWGc2TkRSQ2tiazJN?=
 =?utf-8?B?UFc5YWlRekxURFI0TnZuZi9zaitEb1FBakRwNjl0OUJSZE5JdWsxUEVlR1Nx?=
 =?utf-8?B?ZTJpbTB3Q0N5cXRBOU5JbmxKTm56Yzg0bUhBQWV5bE9Memc4bzF0Z2N2dXAr?=
 =?utf-8?B?aVNJWFlyUmFSVGk3U0g3T3ZReXZqMnJHcWxvVjlocTB6UytCdnl2eEFrd1ZO?=
 =?utf-8?B?MU1xYktTcldrL21NOGlYWUFnM3gxU0tMbnR2SEFTZGpsdmhBWmxSbExQb25D?=
 =?utf-8?B?VDZsdFVmeHluR0kvRlpIdHUvVm85enBKeUx4cFRNWVBxUGFIRlFwTXZ6WHBk?=
 =?utf-8?B?V0s3d0NoMmd4UiszdEkxYjhYdFZpNEZ3cVQ0MWgwNEJaOUJuQzF5Y2tjd0Vv?=
 =?utf-8?B?VTl6YmlJQ3ZWUUU1aWplTDhnbUk2VFg2K3BZbkdCZ2VvaVBBUjlsRW95cGpF?=
 =?utf-8?B?SjF3SkdUay9kVFVuRHd1dHFEUXpYMDJxQkxOQnQzcVFjMDkzQ1FOcDBaSFVl?=
 =?utf-8?B?TVp4SDduWXdWS0tFWHNBV0dlMlZYOVJkdVlaZUJKVEVXK3lMdWg1a3VtR0dY?=
 =?utf-8?Q?zHU5PSsY7UU5mPK5aaieTPRk9?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04067b2-2ae3-4349-2b36-08dcfe7a027d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:45:16.2180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wsmxl0PMLg51t36QXmej4WF98fv1pebLqzqYdeztTRR83yV5Ez8IjZJzs1vXby21+PyFbwqBetfy2QfdtDNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8750
Received-SPF: pass client-ip=2a01:111:f403:2614::70c;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/6/24 10:53, Kevin Wolf wrote:
> [ Cc: qemu-block ]
>
> Am 06.11.2024 um 09:04 hat Dmitry Frolov geschrieben:
>> The sum "cluster_index + count" may overflow uint32_t.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Thanks, applied to the block branch.
>
> While trying to check if this can be triggered in practice, I found this
> line in parallels_fill_used_bitmap():
>
>      s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
>
> s->used_bmap_size is unsigned long, payload_bytes is the int64_t result
> of bdrv_getlength() for the image file, which could certainly be made
> more than 4 GB * cluster_size. I think we need an overflow check there,
> too.
>
> When allocate_clusters() calculates new_usedsize, it doesn't seem to
> consider the overflow case either.
>
> Denis, can you take a look?
>
> Kevin
>
Hi, Kevin, Dmitry!

In general, the situation is the following.

On-disk format heavily uses offsets from the beginning of the disk
denominated in clusters. These offsets are saved in uint32 on disk.
This means that the image with 4T virtual size and 1M cluster size
will use offsets from 0 to 4 * 2^10 in different tables on disk.

There is existing problem in the format specification that we
can not easily apply limits to the virtual size of the disk as
we also can have arbitrary size growing metadata like CBT, which
is kept in the same address space (cluster offsets).

Though in reality I have never seen images with non-1 Mb cluster
size and in order to nearly overflow them we would need really
allocated images of 4 PB.

Theoretically the problem is possible but it looks impractical
to me in the real life so far.

Thank you in advance,
     Den

