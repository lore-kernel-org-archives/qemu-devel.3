Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00529CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5GG-0006v9-Sz; Fri, 12 Jun 2026 13:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY5GB-0006lw-U1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:01:36 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wY5GA-0006be-0J
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJO+gdrUMKElL8DMqJ4GotBfdydr82zazBiWNjRPygYefc+CvxrZ+CFMJUv9SSiPHM5vLCWIAmFOq+ZPiGDoFmDeYDpIDg2CziYv5dtnBKVNJeL0BIcU8ac+z2XigtAky04Q60xLxF2Nwx2SGBjRmA3coLj7eWrrv57WQAGjhdgAzK1GzhsqgBhd+Wf3bTsV/bEiHXHN5pSPQTOFuM5zbZ0gNfdplO7u9ObjHxmlTG+SiqQ4Ae7WPdJfKu2WG+JTw7Lu0fcfAHxsN7G1wiHZnnLRVKxWvQ3yhDQlz+cnO1UNH/LLlYNkNj3vBD3rXv5feSQoY5lMnHMjOre+kqQpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWAsNIRy9WQMtPqX4bKyd0zpZaRwTTkCKfKsnBDQOZ8=;
 b=DemseqyBTuAnkiv80OeiYYtTztSWGvYiwPFUXl9FfmyppnL9ZPY5bHNK4TOrXbEZpkco2AmTsnm/1iQuzqN4eI7vVDKRsjeDNKYwfSgkHHG++ipTJjJGm5/0tNk7W4Mev7d6JhB3Rc1ny673xg6OKkS41gfgszB0qNG7obCtdEk8ROdu6QCtAJeC5KrpGRS/ZJigUV0pNBFQDqJUPBEgDJZ+XzReKN6w6wUyCrZvOf0BiwNvDhYcE/6deWacDapQNnJf7fxKbBbafakQz+SyZ+9nWc4MAHO0mq0WVu89kNaShOiWdvo8wcs4RGaqk4NRRmaFweqTiIe8jN7Wl0ZZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWAsNIRy9WQMtPqX4bKyd0zpZaRwTTkCKfKsnBDQOZ8=;
 b=j2npHzDUFZwuujxMvtU8rt3fI3jeAOJW1IuHqqbKqyPvVOBx6KyhSvpC/YX8MqNkVnC9hs5WHkeYBAiAjbj5APUz4qKZLoOSvXXio1q0w6I9wU9GT7Fu/ygbOUuK9teZxvR830m5rh159+eK2hBsZuFfDR9Ap1jeH///mRKFSZw1Ej0fYHTIPbVVMKsHiUS5cUeA7ZfJIXckmtIRv3Ew7HZtpJ6FLVMhFL/oPkayvVqlX6CXsRHuwdfbry8iKiO7sx+ZIlreVBYz8pcibmL3XVA9Cd8ftWC9vqIdB5v3kBHE9NG6NZPpaNUdg6XceYMyecVaRZrpTdF3bFNe2yBiQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 17:01:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 17:01:27 +0000
Message-ID: <9d82a749-ba87-4d11-b41d-27d4d4d4030d@virtuozzo.com>
Date: Fri, 12 Jun 2026 20:01:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] migration/cpr: support vhost-vsock devices
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: a4597c55-2e1d-4af4-8315-08dec8a43e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BGSV36vn7yYnzafBT55KSc1mbTyywoev6Awm0n48aO+fgZofH5JUnCFyYuFOM4Atd/pG/vcbRRMm+B/AGEXfyHqWnJP2ZBAwTnG0UesQnaIdK96pooYowmHKpfIygqy8R8xs9ZXAwVKDzOcrAyIRFLb7e769CdzeJDPR2aUwHtpIzFnMEGNGXet0dJGYm8caBUgHivBevfX7ZiHx6vfhjRPAUXGUoA4UPf/eLqgQuuBa5AV1JyyFkR5pAmJbVCUHeikoa/iJqXQGJ6CqWI+1uDH0WRBzsYmQp2cXoS1LWqtO/ZNyMJ4cfOBQ/L4KHn2DXyrcbsUIIESpHeknEpyvRruAHtevypi2cIDt+VF1cXoRiZNYh91zgSK2FRXp8ipszpFOh/NWbS+1gsUz35wRcbrJ80OeOQJ8gqg65dyZYMxe00qgZ3MGYZZoCRo/0gO+28Db9jogsn/k7adklyT/5dzO+4QW2VMJGDmZTtjFAygEMn7FrX3kObNSLMCblIfH3INnzmZ6JeGWPFw2QelBsqy43s8aoStuaNI0f8MTwqLaumU2TCeF4G0KNdOH0QXYwnk3MlTg+p9KfqkEahFvLoYEFHPj671+3WkCtDAKkVbbvHEO7BhzGDV0fpaQup4oamc4GXRtIlNFxOdwwPSWtDXplROttPyp5E+Ueu89aRh/q7TGnc74P+L4P2PT1AevJpPQZ9tMS8Qmeb0LTUgrcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9vbTB4WlZTSnNtNHFlVFl2RjhUM3d5WW1BVXd3N0hRWDRBUmRZNnlUQXp3?=
 =?utf-8?B?VXhraUVZTVRocnV0L3NqRWloVllrNjVPT212L051Q0lXWWtNVEV0amFPN1Zt?=
 =?utf-8?B?dlJTdnVuRS8vTndwaVdjRVZqZFNzWkVtVHFFTXN4VFBwV2FURjRpczc5STB0?=
 =?utf-8?B?anVEdnpQZEhJc2t2MEZDN2NIZmI2eEtzRUpJTnVVS0JJQVU2eVc0elp6NmdL?=
 =?utf-8?B?WUNmaERla202Z05vQ2lwY2VBRmpxek1hYjhMTUdhVlB1OVRlM1RLRzkxWCt1?=
 =?utf-8?B?R2hEVzVydTJuTXFqRGFDK2ZpdHRPTzd0ZE9pVjVTSTdoeWFwK2FrTFhpaU1s?=
 =?utf-8?B?RmhuYnJhWE03N3VyZG9DeTF5blRwdzVKSEpVT2s0aitHUVcyUmt4L3NFd1pv?=
 =?utf-8?B?aGtBMXZReVNlRG1IV2drVDd4U25YRFgvLzdVVDZZbUZ3THdwMEE5RVpMeEF4?=
 =?utf-8?B?NXRGd0tuTWFXNnBYbzVJQndiVFhlVXZIWFg0Qkk5eStFQ21LUnVyOTVaRUNW?=
 =?utf-8?B?a2tkc0ppaFBaZFIwSzFiaWd0bFNoS0NiUkdWV2ZEY1hPang2SDYyL010L2Y0?=
 =?utf-8?B?ZndqSmg2NDliaVlRR01oYUJNTU5vQjZGRHI1TFk4VzdITWpESFNrUjArU09m?=
 =?utf-8?B?eWxNMFdkbnl5Ymo4bStaZ1JucHQyY1RoYlR4S01BWjhScFBDZUFnMURjZGdF?=
 =?utf-8?B?R1J0NTlpemVxT1dYMkpKaFlwVG1Pdkl1R2FndHE3TW42WjdNb0hjK2tHemJJ?=
 =?utf-8?B?cTlxb0FsZjdnVVRzZHoyQTJ5ZUErcHJkRVR4bjNpRGd2SHhhMDRPZGZhVzRT?=
 =?utf-8?B?amZzaGx0dGMzOVJOUDBBRnVNSXI2VGNUZzJmWHNweThDT1NpUnAxMWZZb2lU?=
 =?utf-8?B?eGF3Y3pwVzlwQ0J5alRIVjdneUM4d1VXTTltL3ozWlJKemxLRE9qakhSWHhD?=
 =?utf-8?B?THc0N1BJQ2ZROW1wQmlFWktRZXh2OWNkLytEd0ozYTBDOE4xVXFmUVBERDJT?=
 =?utf-8?B?c1lLd3hFbnlPZjkwNWZEOGdtUWFMSEd6UkNqTTBScXNBU1F5bXZkOU5RaWs1?=
 =?utf-8?B?NFdZZXNOakdSSHlGZ2k4bSs4R0MwNmcxYk5oeDlicTB3R0hJNU5hQnJaaEV5?=
 =?utf-8?B?ZVdleGQzaW93djU4R2pIODduczhobjMrSXJEMjhyZGRScnAyODJocVI0MnJ2?=
 =?utf-8?B?cm05UWY5UzRpdGVtUEtjZjdrOWlUcWZtZFVJTE4yYWpGdEcxdUpMYmFmYmZs?=
 =?utf-8?B?RGprdVJjd2F4dTNYUktnNkNGa1l1T3FZQmxsb0RoMlBhVVFCbC9IVzM0dzBQ?=
 =?utf-8?B?c3UwTW5FcWwybFloYXJvUUhDcm5WMTNyK2JMd1JxdFdXelJtTDByeGl3MWRk?=
 =?utf-8?B?dkdaNTIvVnlMSjRCam4rN0ZMODBBVVdmamlDNVNqRDZha1FiNkRLZFIyVzZN?=
 =?utf-8?B?Tm5yZkl3c1RpSnZKek9WQnJwWXFTUkN3UldDcXYybldacHhtdkh6dUhQeDZl?=
 =?utf-8?B?N0xrcW91SlZ1YlZJZ242UDAwa1pGODgxQWNwMlMwY3VvSjQ5UnFrN0NFTjZG?=
 =?utf-8?B?R2ZESzNCSVp2WlBwZTkzSXByZUpUOWxLM2w5aXM0SElzWVI4WkQwZ3NBMm8y?=
 =?utf-8?B?VDJJbFFLTWtiaVpRUVhsMWovVTVhWXg5UFZURDJNcXg0OG9RVnBBbjg2V3c0?=
 =?utf-8?B?V3NKTzQ4QlE4K1VYY2lCYVRWYW5oWXEydGk1bHFaVlF4QjRaSHRSek1jQUt6?=
 =?utf-8?B?UFRxU3MxQ2hZM3Z5NzNNY0RxU01KZzFjVkRzVVpKVTR1cEtTdWxIV3ZaVmdT?=
 =?utf-8?B?d1BtQkxDd0duWUZ1YVZMelVkd0xrQjZ5cENBQUZjUTNiS3RyRVRtN05jYTk4?=
 =?utf-8?B?SXlRamNkQ1BwZGw2bjJ2SjRzcDJQTDB0NmNobVhMOTZGNXBmeCtMcng1eTVR?=
 =?utf-8?B?UnRnZEFnRUNHS1pqbTU0Y3NSMDZBU2ttYmVkNTNRWUJmckJzRzM2RlpiY3o3?=
 =?utf-8?B?YTdPVjczcG4yTGh0MDl5Ylh2amNCSVFGcWd0Sk1YYUMrR25pR21VS2lGV2xh?=
 =?utf-8?B?MDhEYVR5SVRIMWdUR2xFbXI3K0UxK2NZUkxDR3YzSFoyK0NRQmxYOTZUSDJr?=
 =?utf-8?B?V1NseVRoc0NKMGllaFUwVHRZMDgwbmdISXZscWprazY2UVhpejYxTEdIL1lo?=
 =?utf-8?B?WS9aSm5PRFhKMklkTFpzWHF2K2k2UVZ3MUVNdDIxRSttenJKTmY0dG9pcnJW?=
 =?utf-8?B?N1ZoellQMTVtMmJPOEkydDB4dUd6V0lyc3lVazRwYjU1M1hPVDc4cDFYUHho?=
 =?utf-8?B?bGRoODdodndkSWx5Z0lKa3hxaE5UUUljbnh1RXNBaW0zc0t6VXNXUzlDZkNw?=
 =?utf-8?Q?einOCryLHLcocwhg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4597c55-2e1d-4af4-8315-08dec8a43e3f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 17:01:27.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxTRyp+yP+B72VdtQLMJfT8CHMQzBpEvvJllYsz+kgJt6lYY3ztJv4hITmcOUYQV44hVuUAtEvC/dahtKA6zvRGJ09kZ37mWvdLobDXBbNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/12/26 7:51 PM, Andrey Drobyshev wrote:
> Host<-->guest connections via vsock sockets aren't yet supported for
> live update / CPR-style migration.  This series adds such support.
> 
> It's based on the vhost-related basis submitted earlier by Steve, Ben
> and Mark at [0].  Patches 1-3 are rework of this submission, adjusted to
> the latest master branch and with respect to Fabiano's review comments.
> 
> Essentially we want the host<-->guest connection to survive the CPR
> migration.  For that to happen, we preserve the vhost FD and issue
> VHOST_RESET_OWNER ioctl on the source side before the VHOST_SET_OWNER is
> issued on the target.
> 
> VHOST_RESET_OWNER is currently not supported by the Linux vsock driver.
> We've implemented this support and there's a kernel series complementary
> to this one.
>
> [...]
>
Here's the complementary kernel series adding support for VHOST_RESET_OWNER:

https://lore.kernel.org/virtualization/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

