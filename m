Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AE6D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJJT-0004hH-IH; Fri, 11 Oct 2024 13:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1szJ8Q-0000wP-F9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:09:05 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1szDq7-0000JE-VH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWP324PG7aT9MGnUYNbxNDBq4F7F/BUXn3pQTi+oB2yi0oNA0nGnTxlOptMJNOBFNbtuNoN3EzGj7wrdrNTOGbGMDl5icuSQDomp6Zj5IwODwiEGnqC2juj2H0UwA3SzC7cdRxVtiBdpoDC9j+WDtD26dUte87sU9NjPYvTdkuilh+9wiP+vz7CS2+AK3nk92VW4LQUUsOkeccZwDZr9cwhvZZxdXTLuB5Tg+KRUKBh+EuNiKKx02denPX1qf5GYfns4CofUZmKZrL/FRkYSWMYadF/gVy8dHzAozKalpjkNv+yV9fxLgt3IgkERdLp4R0Rgzpffr96OukxpT9Ye/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjTN7LrK7c5m+uh/IeHbaU++HSPM1uTv0ghAVgZnT1g=;
 b=e+QsDxzwrQgv4c8CCdmMq0jlMKqmibc5p3n0TDeWMtsrB25g7rUegSvGrhhmw71biz0Xv0w0+O/tuoHYzsE508pC+vyIYE1O5w5wM2ejqpTh+wrxcudENWcppL8OyS2mZHiWMs3qztBRzQJ+HQZcVU8fC6wgcExlI+n0XxZIvt0nfI6c9Fb3GXLa/rQ+99sTGxsAKr+1i6dU8TvtVvGxC0lILUnl86qElJA/NLViGAvkVnwiP814bQc4R05HrFufoaZD0MVJIUunp1nS/5jrQlN9fUNL3KNEYgfgACUNuJelOdGPuwaO/ziEVyOAsf8NKdO2+r/ireg8AXCqNTYGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjTN7LrK7c5m+uh/IeHbaU++HSPM1uTv0ghAVgZnT1g=;
 b=cEyl+m8cFKQ+ww7VhC4JLXX/x7J+HovaNzMFKSqng2pxDaAhXmqeB+OXtvBx9vr3tBJ9OG74NNe5AhZIaQgQV9ZkY0Qjic60ZgsPwW/2D/lRMlcgoykZpwudtXWHSkxTtZM9PoAJeHNjkgxbUgjFxV8WlIPPvuokB314fvRg4sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.19; Fri, 11 Oct 2024 11:29:40 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:29:40 +0000
Message-ID: <9e4161ef-222a-0d4f-caf6-41c9c6830f0c@amd.com>
Date: Fri, 11 Oct 2024 13:29:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: erbse.13@gmx.de
References: <20241011085944.25815-1-pbonzini@redhat.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20241011085944.25815-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a369782-ee27-481b-ef3e-08dce9e7ff03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0svS2RZZFdLUHlDN3JFOGVlZWl1MXIzaW42K0Q1WkdNck5ROVlvbzdMTmlk?=
 =?utf-8?B?YmlGSDExN3hsSWhuVm1VSmw1c1g4NE5TdnNWSUV6VlBwVUxvdFljYWVaTU9v?=
 =?utf-8?B?bG11Q3FNVllqeTNFdVVGNnFKVjhkTDl6VktoWEIvb3RXSE8wbmpDdzNFbURJ?=
 =?utf-8?B?cTRkQ0tEVlkwbjJPMkoyeE5Md3dTWWdHYm40OTVuVk12Sk0vMzJnWWtIRlpJ?=
 =?utf-8?B?UllOWmttYmJxYnJNN1k2Q0VyNjNLbGthQ0ViT3JJZFFlUXNRZzVuckFjV1Bn?=
 =?utf-8?B?blhzM21CNWJ0Y1A3dFdFMldUbVEzZUdzUEFIV3UzRUJpNCswYkxWb3B3ZEpQ?=
 =?utf-8?B?cFVJUWRGMnlNVlhyVGwzN2JlVHJ1QWlRdmJLUDMrN3JXR1RzVFUxVUZFOTBI?=
 =?utf-8?B?UkhhVGhHL2dXY0ltZ3kzTmRvbGJqN3JJZWd0b2Q3czh4RHd4anQ2dUJEeGl4?=
 =?utf-8?B?L2dpaVcvUW4zZ3JTYXNkT1drRzRjTzJvUE5DWVl2TVV2REF6VTdUNnQ5WGY3?=
 =?utf-8?B?MGZBN3k4MjNNazZFeFVEaFNRaTVxNXAxOEZTamVhMW1KcGFpZzFsdXRzQmxt?=
 =?utf-8?B?VThNdTM5aFg3NUxuNnlsUlVQeFhsRzVSODNCblZiWmFoeWVxbWM0NFFrZGFX?=
 =?utf-8?B?VWV3d3Q5NHpxWEo0SEZibkFqM1R5S2ZRMDdJaERUcjFZRVROci82UkcwL2N6?=
 =?utf-8?B?NmhySDloLy82bkQ5V3pvbjJKM3FSTWgrekJaamZhejFTdTlaSXl3ZExBWnRO?=
 =?utf-8?B?T1huK25naS9NUlRpRHBJSDF5cVFhVUxuY3YvcktTTHA5OFJaUlhKMmUreDF1?=
 =?utf-8?B?bm9WYWVpYVJNN3Uzb0pmMFU5TjVZbFRpaGdFM0NXQ1JjYWFUSllHTDhJWlBK?=
 =?utf-8?B?cFBLaEVBRmlpS1hraFNOaXExdndBMUNKK3BTbGdDK3Vvem5oQVlQMXlRRElN?=
 =?utf-8?B?SlJMNU8vUDhxdndnamJNWFhmWVBMR2FRMXhCaE9UUUFWK0cwWlFnSEdiN3N6?=
 =?utf-8?B?WkZRSGNOOGdDZjRzalg0NFgwVHJYWkwxNHg0bVJ0UEdyRmlKbytXQnJDR0RC?=
 =?utf-8?B?dHRtZnR4MWFVWW1xa1RuVkJ4aEVvU0R4Y1BUL3N1elBUTVRIa1JGdHZTRlpY?=
 =?utf-8?B?YnNRZTRESko5TVNhcGVQYWJKQ2VwL2tnSXVBVXJ3azFOdENzNTd3RHduRkZk?=
 =?utf-8?B?NDBtbWd4Q3NGemt2MTBpOXBrUVVsQThwTVB5cUxHeW5wTTVjb3h6czJBcUM4?=
 =?utf-8?B?cTBrM2xlK1VsOXhuR3JQelgrTVJHSTIwUmxNWFdyUUIwQmNRU2M5bVhUZXNU?=
 =?utf-8?B?NWxoUlVRdUZiYUt4bW1Pa1Rxc2NLU1RIcm44THFFYlRwZHRKZjJnOTk1S0Jy?=
 =?utf-8?B?VCttTmJWMGtQeER1ZlJhdUhHdHh3b2JKbXFGaEo5aHN1azI3c2paUnQ0cjZX?=
 =?utf-8?B?UWhrYnR5UUxBNCtUWXJ0NmgrbExTU3I4QlNUZFZQOEEvbmZiTnE5ellXNERh?=
 =?utf-8?B?NnNHZ21XanQ1MHZjVkhxK1RWeVI0SnU0MzA5b2JVL2JmQzZGSkpnSGlFU09s?=
 =?utf-8?B?a282UURxOUttcUp0VTY3WnZSNzU5LzhBUmhyRTJzQkZzRk56OTdxQzUrNUMx?=
 =?utf-8?B?dHB3Q3RuaHVzZkNRc0R6cmVOTGswVEQvbnRDVTVnWjlEZUV2WUdrczdWeE81?=
 =?utf-8?B?TzdZQ3lyT3RzeUk2UUhyN3p1cUJ5WVpGV3hEU29nNnZDOUxFK2tTdk9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdNd0s0Ly9YL0h3eUt5OGgxQXVsdVdlbDFsWHJ2M1ZNVnhXU2Y2NnhMREdH?=
 =?utf-8?B?MzlJN3N2WjNMWXhabUlZZ1Z1cDBURGZqYkJ1NVNwS3l1cFYyTFVMNE01TDJx?=
 =?utf-8?B?K2pnQVRyUlh5K1JZcWlzT0pNc05rZUpodWx6bWp5Mll4Qmx3QmJWYmNDd2M2?=
 =?utf-8?B?dnFmclRIRVZCSmhxT3RSa0xlL3lHWnBuSW5zZWdERkpSb1NvWUVSelJ2aE5w?=
 =?utf-8?B?ZllLWklWZFRuRkhFT3VjUFIvclI2cXBBRnRhVERPQ0tDd3ljWVBObUlKUGxv?=
 =?utf-8?B?R3EvMVR5UmFSeDBwVDUveWRqTEJiaDRlbXBMMHlIR285UzFyV2k2c1FEc1pC?=
 =?utf-8?B?QnBzd2lweEpHYVU3czlkcGlXQ1JlUVNsM2xPM0lKMnZicVRzR2lJeXhLaDZP?=
 =?utf-8?B?MjRxb1p0ZHlPVGtKN001a2k2ZERkMnJ3TyszU1BRUmpyMGk2T3VxSkVHQklu?=
 =?utf-8?B?TnRWNWlncE92Q2VOZFk5ZmV2SlJQc25HaFFLVUFlbEhpM2dTakh0bEtKUVV3?=
 =?utf-8?B?NUthZlpubG4yTzZHZDZPRVlqUW1HMngxWU16RGhtQ0xHalI5ME5lMk1IWlBD?=
 =?utf-8?B?allHN1ozYzhWRnFGak01Q05uS0xhdHVIdkM0VVJkL1FCOWdYaG9xUW5nZGcz?=
 =?utf-8?B?cHl0a204TTIvK1psZVhIaExITlpWOHArSzY4YjlkNTlFYXBOemxuL1pFM2dL?=
 =?utf-8?B?bFc5RmJiN1A1TUtjdXpkWnY5QzZUR0xWSC9TS1ZPLzRkdHJZSER1aGIzR2ZL?=
 =?utf-8?B?OWVrL3RUcG42dXNnbnFNN3FpU3d4WGl4VXZ6ZTdrMU4yNzltbjhFM1IrK3pF?=
 =?utf-8?B?eUpFYzByY3lXcWZTdGJrUk9UMlVTWm1OZStoRm1ycE5MSlhiM2tCbnkwYjg4?=
 =?utf-8?B?UGNxMnRSVlMwaUs5TGoxVERmT2FYMlVRYlYvYkxnbWp0M3ppSm1neW9PK1Vz?=
 =?utf-8?B?M2Fpa1MxZHQzcjhRMTdoTFQxSVlNVnB4L29uVVRONWhqbE5BR2ZyWEFMa3Na?=
 =?utf-8?B?a2Z3Q2Q5bEsrZG0vRld6WnJHelJZKzEyOWhTa3hjdUxVelBCOWRGeVRITjBH?=
 =?utf-8?B?MDcrNUFwVHlEcjkydW50SG1menVneXBYbGdBR1FMTTZlTmUwVlQzeW9hdDhx?=
 =?utf-8?B?aC9VYmNrSm9WYm94U2dpLzRQVFNEa0EyQTFrMUVSQ1pjTWg4bTVzS09udzJB?=
 =?utf-8?B?RHM0UkVFa2RKM2hnVzhKaG9BT2RGMWtTZWNodWEvZ2lLRXd3OG94YlVjb29K?=
 =?utf-8?B?M3pKSXVENDJ0OVpmM3pOTythMks2akQzaXlvRHhsWU4yNTdoZFNwb1FRdTlk?=
 =?utf-8?B?WCt3aGhuclhreGwzUmNtOTl5bXdGeUhUMzZjcEd2bHB0QjRJQ1VQOG9aT25D?=
 =?utf-8?B?TndYYlhLeFJZZkpBOWtoMTVZbS8xV01jUnBWRlRWc3VHVXprUjJyVCtQUG1v?=
 =?utf-8?B?MkovajQwWHNkR0lLQ2cwZWVLVE1oeVNialJNZFJ4NUkxcTUxWTRiYnp3Z1pM?=
 =?utf-8?B?TVQwK0ptNVh2TVpQMmltUHlzSVZ5T1RkSEJsYVIyZnNoRmV4VTlNcUVrbXNw?=
 =?utf-8?B?bm1KNmxLS2pSYXRXVzNVWldkR1hocHJ1NmJ5WmxYVnkwbWxXUER2L1BablBR?=
 =?utf-8?B?Vkc5dzNyTHp1eUpyaFZ4SjVPS2lEeWRnS1A4dFVTWlEyOWhGbzA2d3VrUnAv?=
 =?utf-8?B?d0tBODR5ZzhrV1VJNEtCN2ZSZzAxSzV2OGFnM1NLbnFvQVF1VjNDNTJHYXRO?=
 =?utf-8?B?SmIzbWVEcmpHMzZXWW02L0IrbUQ4NE1xaUZzUVZQa21uTG94cUI0a2pSODd0?=
 =?utf-8?B?SXVRR09ndkR2OW9BSXRLTEQrcFRSdXZLL0dhZTNnamxxNkRUQUI3TkVMTHBI?=
 =?utf-8?B?V3EyeGFPajd0bE10N2Q4ZXJwOHJLTHVPRlVoc1RyNnRaRkI4aGtHWkR1TXFx?=
 =?utf-8?B?OEhDY3kzWXVWY2FESzVKN3ZTT3VEZU5JeEF5SEQ1UEV2QW14N29xT29qOHJD?=
 =?utf-8?B?ZDhuL0gwNkUwUnkzVTJDRmtlS0NHelRUMVN1S0F4dHFxSjg1b0FRbUJicVc2?=
 =?utf-8?B?Q1N3Ylo1L3RkNU1YMEFlTS9USzVLdDg0RGtkdUZuYzNkL1prQ2xPUE5XV2pj?=
 =?utf-8?Q?udq7k9p9QAE1VlepMJIlxgvQp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a369782-ee27-481b-ef3e-08dce9e7ff03
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:29:40.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSdE8gkWiYlRgs7vBfc4ZwaBe+HGRSS30VqzAQDk2M33P4TwM3ERr+fnIE/ILzc8NAotwz1A4Ne8bTxfVjZHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
Received-SPF: permerror client-ip=2a01:111:f403:2416::600;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.342, SPF_HELO_PASS=-0.001,
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

On 10/11/2024 10:59 AM, Paolo Bonzini wrote:
> The exact set of available memory attributes can vary by VM.  In the
> future it might vary depending on enabled capabilities, too.  Query the
> extension on the VM level instead of on the KVM level, and only after
> architecture-specific initialization.
> 
> Inspired by an analogous patch by Tom Dohrmann.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   accel/kvm/kvm-all.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4287e254df8..482c5b24cf6 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2604,12 +2604,6 @@ static int kvm_init(MachineState *ms)
>           goto err;
>       }
>   
> -    kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> -    kvm_guest_memfd_supported =
> -        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> -        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> -
>       kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
>       s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
>   
> @@ -2723,6 +2717,12 @@ static int kvm_init(MachineState *ms)
>           goto err;
>       }
>   
> +    kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> +    kvm_guest_memfd_supported =
> +        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> +        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> +        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>           s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>       }


