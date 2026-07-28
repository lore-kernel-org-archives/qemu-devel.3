Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDEFC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woilb-0001XQ-6s; Tue, 28 Jul 2026 10:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woilZ-0001WO-85; Tue, 28 Jul 2026 10:26:45 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woilX-0006en-Fn; Tue, 28 Jul 2026 10:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAOhOCfo8Zz7ukpQrsOs8pxEv/pz44s4QEgykpRh9NmSoZmVH5TcwuUReSfLY9b3UkI36D5ayqnmBuMqPO5NkbzBsCjAILejrWOhQ+6lTSfP5YcfwesJLRAjsXvWPfWy94Ln1+XIHPjxwF+ZO0vfMrHbHy+eNtvd1QKUzdqdJvguIfyfV6Qm92ApEMeH3mzjaHD2u2ab8wBQUT4WHGPV2VnYgb0Ow+kTTXlRLi8pdIKQlq10CLVsrSJ9yGm9hEUDS1zywKCITd8IdOqmiWngxh7KZCPEx1n4woWV2QV5rgYOMehgRhG7m+jYYuGd4W7hVIuSLmHk9Y4UQ/xdXjJz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pif5WiSfJWazCyvYsBPuUcLPBDtRbqd5tASAu55YEAY=;
 b=q9p8zrauU7g2sW2RL9IKQovSvsRA5l4WpBnQiXzPphkmAs1PkLRhuk6DbgNNF0qp0uUWinnC3x9rtf+ujuYXflnHDfBwRTVw8iEAIt5sJ09aY4q6RkalhRu8CeR+K/77M83HlNMOssyAeN06043KCn4atCzCr8ghqKzlHffCpIy8GoBVfUBueFn9YfxkezDl+mZJ0rimrP+qPGFC5cYkGYYZb8x+Y18yzQUnHoaZjfHIpYDijk9UgkdrnPIkFUfnpgmE5r4JWT00aHy3yHb7LZwMT1WJDfyHScDLX+wxIsVT/KQpU7Vdg7bR5I5GvnFOoWcuHQz1wy5SYyxRN2pE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pif5WiSfJWazCyvYsBPuUcLPBDtRbqd5tASAu55YEAY=;
 b=H29qnaXmsNzglg/taI67+LMcKmjY7HyjhQ2M6jbdp8mk1nrRN7XTFGa7u6IH+ZVnnFSJQjvE39ey8ZOl/WOFgkmJQe2TCopyRDNayKrHEbVQipbJjSP72vRs1tJUs0o4gxOvLu9Hr8PbeaiR3SQ2FysUnq6yK5oYC3/XwfFs/ALc6Ha/xiiRds5AzZf+crt3mkTF39atcChCGCbspBKvnL54c/JiNwCzeWKLo0eBQX+dlsI3AQF/Uzs7PkXYnaGCg+LMxc9GjitA/5QvD10Ob/XnGaXrBjHVZocLQW2TyBCaJUSJky8JMbhEe2C6S18NyiriWNGbNS7UZcpsjQEKWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PR3PR08MB5705.eurprd08.prod.outlook.com (2603:10a6:102:93::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:26:37 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:26:37 +0000
Message-ID: <a5c37d07-059b-40fc-a37f-0d45b4039d55@virtuozzo.com>
Date: Tue, 28 Jul 2026 16:26:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
To: Stefan Hajnoczi <stefanha@gmail.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260728104221.3981592-1-den@openvz.org>
 <CAJSP0QWsKcV-o=pt9BSbF7pLhAOCZVV6_w_UsTF-Q5Gb_X9PUw@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJSP0QWsKcV-o=pt9BSbF7pLhAOCZVV6_w_UsTF-Q5Gb_X9PUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0068.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::11) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PR3PR08MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bbc965-7762-47f1-adde-08deecb43ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|18002099003|56012099006|4143699003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: Cnm0y/6m1VDbk4LigsEmyX5hiOOinKCs3V52I2ZgNW0yvKB/LKav5JIiym1tlu4eUN4k/+/ZGdmDgkOvxPax/M7UxGE7S8/hR8aVi/XjTrVjFSnLKFSf7sV+GcFBvKOuK35hNv1N6egT3kexXj1J1tGPCxQwXDO3S6alRgYO2viC/ieYAItRuSwjgE+nJdY96wgmlwfX26OEuLXEtNWWjDrXnBqdpnaRylj2wxdwj3o9hvfymEbx5EzbbR2/tBf119vqd6Z5YkAkatdWWbQJHRgUHxdyyNEr5a8qX6zibI6GW2T3EPMj6TUpRKkMJ+1teOp4lUcT95sUxVo+z8d4SVKnTuX+IzmEpKchnaR4p6k9YCN5eokRVYtAMZKiIOWiCMYTToAHyPhs4FaOENfDEgxe9bqZVa6fe8cWjsCNtZ8FEsYmwx/8nQDrbx8AzRM2bcvwpor/hcQFuRmtJDeGLpnPfKPRLxDSncrQgS4EvmKUtzlJbfHMJ0yxGO4h0Qha3iqllD3tZ8vMESIaZBsZ1zV9nJ+Zp6+zBRFD9hgRRcF/er54e+kdR8uV2EnyD8BEfvgqL72O6MzGpbvJ7LASgrpi7Hjs0UjT4EJXZUCG5/1t9iG8MxXW3C9rCOswSxiAGXxMTCKAlmxQuUgDfg4C+Mrqv3eHx7EKkxojnPZU4PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(18002099003)(56012099006)(4143699003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHUybk5kRWRoUVhFSTkwdXF1bzl4MU9ENlVkbEZQTVlEYzBpTEg2R2JlM2Jy?=
 =?utf-8?B?bitQWnBOLzdPOEV2MCtsdHJPRlgvcEVFRkRUSDd6MkZqaGoxQkkvbVdrMzQ4?=
 =?utf-8?B?NTNKd3drSGVWZEFmbEplRVR0OG4xaHZmMjE3UlErbnJVL0hXOWI0dWc3Ykpo?=
 =?utf-8?B?VncrcktJblowSE1HMUU2N2Fyb2V6Yjdnd2ZpcnNtVnIvZXQzQ1F0bjBTOFVZ?=
 =?utf-8?B?TDErLzlvZk9IZzFSTi8rSmdsTjN5T1h1dlhKMVkxdGZZajNMdlR0bnd1R2JR?=
 =?utf-8?B?dzRLaWZWYXVCMFlCbkkxRVpsSTgvN1IyVjlocCt5aUh5RnBtZEMzSEtRSHo2?=
 =?utf-8?B?ZUpQZENaZkRDMkN3dk1EKzgyZlVRcnYzUWlDSGhOZ2lWaGVCV1NRZkczMHZ5?=
 =?utf-8?B?Wk8xeUVQaWJJby9mMklsSTdpMS8yeXA0OWc4K01NbDBDQjQwejEwTlVDTTZY?=
 =?utf-8?B?TExtTXN3TXdpdjkyVE5BbTAyZEJpc3gvUlRVNzJxZVl5bW9qNlVTNzV0SzAx?=
 =?utf-8?B?MlBuQ2xzdm1DdGFHS3dJZ1dUd0tLSDhOU2oxelZ2S2ZwenhsVTk0aVR5V3k5?=
 =?utf-8?B?QVJBUlI3WTV4N1QvcVkxY1FCVElvQ2RnSVdsSUk2d1R3YUFHcWJoVFcvUzE3?=
 =?utf-8?B?MFBDZ2E0akhJaStCT2pQM2swdm5iNXNHcloxYkVuNktxTlcvVjM0Y3l2cytk?=
 =?utf-8?B?K0diVWhxNWY0S0FvNERQSHMwbFErUmRUOGszMFNyZ2NISWx6TTRUZ3ZkZGxz?=
 =?utf-8?B?SENHK2JNWDFCWDN0ZWY3bkQ0OWp6MzZXS1k0VmwwM0tpajA1R0pJMkhyVENU?=
 =?utf-8?B?K3lZQXkzWkpCTXhUMElTZ1FtQlJQQ2JpU2E4RklQK0F5K1lTVW5VcmVlN24w?=
 =?utf-8?B?MVFyTVo0SDdiQUR5S09ac3Bsd1VGamFpUXVpV0dYOXpwVGs2UXJLcUE1dWtV?=
 =?utf-8?B?STdFbEEyZkRQbVB6ZlR6YzMybmpTeG9NUkd1L2YvdkVZVzl1WTJJV3V6Rk5T?=
 =?utf-8?B?V3hKZ3BZaFBTMUQwVmpsQTV0Y2tUcGZUQ1daUmxzTUVOdDh5dUpUOG1pcnpC?=
 =?utf-8?B?MmZya29DUnMrOFpRcEVOTGVXR3hOS3d2Rjd4ZjlTYUpacnk2bkJoelpsZVVE?=
 =?utf-8?B?MS9wNTQzNFo5ajkwRlIrcXlDMHI2eUJaUkZFMDFBalQ0LzB0dHFUNkNFV09k?=
 =?utf-8?B?cUNhUjM1dEN6cDhpUTlYenBMdzBqVzMrNlBRVGlqWC9oaG55eFZ1M1lDM0dv?=
 =?utf-8?B?U3A4amRLMDVzaFgrQ2YwdURUNXlmWGo3VjRlSGRQTlY4SlJWUkVtUG0xdTlO?=
 =?utf-8?B?RS81VGJqaDN4UU92YzNFTmM2NXlMdmZobXpnK3pMT1FUMHZIOWMvY0dIMVla?=
 =?utf-8?B?MmpFZy9BZzBMOWJWQ243OWQ0QXpqeUs0TU84VmFza1JoWGJPbEdCUnkzSGxG?=
 =?utf-8?B?TjM1QlNBV1VwNklMWlprTzRzQythbXRhZUhoM0R2YTFEQ0pDaitTYm81TUFL?=
 =?utf-8?B?OTN0dEt0QVlYcW8zQ0ZoRVZlZlhMUDVVRkdORzNuNm9UWHFmeXU2Q3FhRGdZ?=
 =?utf-8?B?OGFuNG5FWkdnWWVzMzVtSDZSVUlkdzR1VE15Y0RQVmtONERteWx0dFhENzJy?=
 =?utf-8?B?SmRjVWFjQXpHNVN1M1hnd2NwSlJlV2IxcVA0cEpWM2FMR0Y1MEtyR3lidjRj?=
 =?utf-8?B?eURsczQ3Q3BFM0Z0NTkwa1BJNHo5eHRBMXhKS2M2MUhOMEtNQ08zVlNpQ1A4?=
 =?utf-8?B?Ly9RTnA2b1F5WHNiNjhkSC9HS3R6YituaVZUWmxGd1BzUDdtOFJJTkJ0clRH?=
 =?utf-8?B?SGF0NUxsSGtoRXFITUpTS2NZUWdzRUZnUmRYS0NBTk9YanVtTnN1ZWJKdkRh?=
 =?utf-8?B?OC9VTk9UblYrNTFxdUtNNmdDSGpTUUx2S1hCeDNFaTBKQ1hvSGFFY0ZONDBh?=
 =?utf-8?B?Tmh4RzhKOElURFhMQzFYUzJMdFB6NEZkUkFtMTg1ZGpyQUdKL2lvdnI3eHFh?=
 =?utf-8?B?MUlHU3Nkak02NTlkTFJyb2o2cE5GdC8rQnUrK0g3SUVUL2cxWThDYnNnU2J3?=
 =?utf-8?B?UHVhUk02endjWWtTcnY3UHVQNWtYUHVVZUtUTkx2U2JacjF4QkFmeGdWbEU5?=
 =?utf-8?B?ODVCZWZwRlNUR3FxUEtxdHJ1dkgxTjRxczVyWWpZMm1LdzIwaE9uSys3L09D?=
 =?utf-8?B?VU4xb1AzN05xUTE1cHRKem1XRkNQajlnU3FBRXJVT3RyeUJWVytuSTFZSVdl?=
 =?utf-8?B?VllTMms4NVBBbWF4cmJHUkRCaWVuRHluKzJWaG1EMFJJUlJkVkplMURyUURm?=
 =?utf-8?B?dGp2WVBOQjR6aG4vd2o1NXczMDRXU0J6UXM2dTRQM2hyVERFNm9zZmM4V29Q?=
 =?utf-8?Q?YOkOnMRgXUheLj5VZnhfDBuMCh1P5FXRL44/8XX7vpytA?=
X-MS-Exchange-AntiSpam-MessageData-1: oyBLoDaBcnFVwA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bbc965-7762-47f1-adde-08deecb43ba7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:26:37.5029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irHCFW0sqjJhsHLoyL/qJ46viutyf9Ld4FZwH8ikNV4VGuYffxfx4IhPuJj0cQrB3GzCFdBLwNZZmJHILiZIxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5705
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
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

On 7/28/26 16:01, Stefan Hajnoczi wrote:
> The qemu-iotests parallels-checks output has a mismatch:
> https://gitlab.com/qemu-project/qemu/-/jobs/15576051278#L143
>
> 53/56 block-parallels-optional+block-thorough -
> qemu:io-parallels-parallels-checks ERROR 9.82s exit status 1
>>>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 RUST_BACKTRACE=1 PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=221 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 LD_LIBRARY_PATH=/builds/qemu-project/qemu/build/subprojects/libvfio-user/lib /builds/qemu-project/qemu/build/pyvenv/bin/python3 /builds/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -parallels parallels-checks --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds/qemu-project/qemu/build/tests/qemu-iotests
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> --- /builds/qemu-project/qemu/tests/qemu-iotests/tests/parallels-checks.out
> +++ /builds/qemu-project/qemu/build/scratch/parallels-file-parallels-checks/parallels-checks.out.bad
> @@ -143,6 +143,8 @@
> protocol type: file
> file length: 2 GiB (2147483648 bytes)
> disk size: 1 MiB
> + Format specific information:
> + extent size hint: 1048576
> == an unallocated cluster still reads as zeroes ==
> read 1048576/1048576 bytes at offset 0
> 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> (test program exited with status code 1)

Interesting :-)

The difference comes from the underlying filesystem. I use ext4 locally and
runner seems uses XFS.

dev007 ~ # qemu-img info hint.parallels
image: hint.parallels
file format: parallels
virtual size: 4 MiB (4194304 bytes)
disk size: 1 MiB
Child node '/file':
    filename: hint.parallels
    protocol type: file
    file length: 1 MiB (1048576 bytes)
    disk size: 1 MiB
    Format specific information: <----- XFS specific info
        extent size hint: 1048576
dev007 ~ # 

I will fix and re-spin.

Den

