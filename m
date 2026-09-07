Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4ECC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3hLK-0006g7-Jl; Mon, 07 Sep 2026 17:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hLI-0006ev-Hw; Mon, 07 Sep 2026 17:57:32 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hLG-0004D1-Bd; Mon, 07 Sep 2026 17:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry2SnqvY7bb4x6/tCEx02S7I4ZODiZ43sSEzZkxxK3PWy8Ak7OarZ6Y0HTMTQTuGgHwBkoFcyKkYit2EzMg7Mm0o1RQC4GsihnPfV9w1YdSrMVHeJPzXLO4+SRYpVPZx031JRz31F7koutAxxNVYQO27wHkRQkLlMTslMlhR9MWhArlyA/6grYFj2ixOssa2e2cG4l21rQojQ2RH0F7Qky5ZI8Nkwcexx2JHKk835hE1JEBGykOL33OzmKllD7x9qJfPqkX3R6bVnJceyGaS68eF296IS2x3MbvNgGplH1DLJqmH5Nv5ELd/ARTb6tToWHtvX98p+7O7qvJVYSlZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSzccNyvDkrM43rIetwftMTFPEWg50As66SuEOXUR6U=;
 b=nm+sfA/bf1cmu93gmEOfH+H4cF08VY9VFNjx7IY09OKd2HMf0Oxc53BM/tzLSlQi/P4ZCnwWsQPhSvtzqEokWMqJ1YV2W2l+xpNS0pd1Wp9ErOo1D8JcwCGglW6IXaFez+4sjxOkqAe2B955tb50SpLS7sYoyk4eygWWZihGmMfIoo+uwa4JDr47AL3wEdqgiTa78WAf0o+Bh/DYkFbf2SlcZebIPgIET/BO5Gui1ACePlqGGI6XzO3gHNGrXY52WyPCY2XEaDrvJRhezf4HTU5nhGXLI4DF+xHhgEQtgv8ZZ2i+r5jttUwpr/aP7jWCjdgP51AToXKxl8wzxPfYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSzccNyvDkrM43rIetwftMTFPEWg50As66SuEOXUR6U=;
 b=ygSfWx12oF5h7O3PuDTYQBjioJYHzaDq3e00abUsDIpqjM5gTal0pu+iu6HEJwZUJmviD/8vV7Yfb1hBMRNAQLhaynAA12WzOqiYntOj3xN9e/HO/1Jyckly7KNURsXNTjGxbtdp1LCoga9oJHtp0TYuAwy3EsrqQKos6YnbPgOqRcxP5OeTiCfVT8s3CGUEyLoqAb8HaTPpeazUk3xkU9fnzfyKRiCWD3fHmQac+7TpPK4lcmyZxqSrS6ruavVa+e2DzGqBo304AyW+mssfvvc+2GgtjNUxty++hPxdkk+xmWiJuQxZIemhv+yOqdJ4W6nyF0IYzlz0rOqNOhLvkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBAPR08MB5733.eurprd08.prod.outlook.com (2603:10a6:10:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 21:57:24 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 21:57:24 +0000
Message-ID: <872dde4c-8850-4c8e-bd8f-1cebc3671044@virtuozzo.com>
Date: Mon, 7 Sep 2026 23:57:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] tests/functional: replace HMP with QMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
 <20260907-nohmp-v3-1-c11e7d0d3d7d@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260907-nohmp-v3-1-c11e7d0d3d7d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000234.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f0) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBAPR08MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: decc7a1f-cbeb-49a4-86a5-08df0d2affbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P7mTTHpK8CBaS+6/3tvURvH67Ex73HwI3bCP5XEjcTNnpB4Ui9BTL0ez8iBj0UFfdYy/HaT637OaWgmczgeoKmfdd+v/ZmKRo/HKbDfxWyP6QLq4Vbkgdlhj9Satbq/UXdkAQBISDcgNyLCzo9nGi2OxN9Q6i4m93+6t4m1OQmhz0wLIBPcZOH4RjYYP76RSsI+lkVBTlWiws3OFhgh4Jiyu+zC3yUKE/qIrq0Y/F3iqzoPlU3V3qpXGuUzTTYYnxtUdzlsxQZLQu9lGRRNnqyVIfGgC0AdyznVJCa1SuNAR96FQtESTyvzD42KpxipCFErEeudCiYWjVBNxujQRMLNRizgf651rZb4IjTB6c+2JKYFFhkKNJ6xxbX1Z9cPP2ZUT+9cN4w7ZhVM2PPfjtwQzsQn0l/f/xzdyeL0pZYL8kmXF4n4nwqMNegd+DbQn6gio5bLitUfnGP8rJGsZ8mUyxTYFU9gS2WnLrFGdZAeZV9WpFdPXmMQFAg3eDc98zm39xUe8dGxtRUv7M9lZz6Sfw8ylIMaqMqd9Gud12x52y0xUc5Qfs8naKg3aKx99enalNgpDwp2PiYy6KC8QeaWEmAgh2Eb1Y1T0jckj9mcnKVLvc5AwRlfK8ceBz4GXxCvH2wEdWFqVQbDWUQZOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VQdDdvS0kxT3pzR0FXdll5MkgwdkJtbDgrR2poQmthMm14S2lFOTlwRi90?=
 =?utf-8?B?TThPYVRWbnV5MmJJc1U5RzJyOFZ2UzFNMFpGRUVFb0RBOS9QYWc3aVFpSXV6?=
 =?utf-8?B?eTIvVTlWMzEzNjdXdGg3bXV4dFJaYmVndTBFMjZraWlLUzdUTk5EMmt5Z052?=
 =?utf-8?B?UklaNVB1S21FRUN4L0NoZkhTem80dW0zS2sxVnM2Nmt6cnZnSTQzdW00Zzl2?=
 =?utf-8?B?TXpFOW8rM1N1WEcrTzVoTUdNNXJoYjBlZjJrcXBpcWFMSUtyNk5BcE9MZGpB?=
 =?utf-8?B?YjU5UDBTaDJYMk9Ia09iWGRKZFNIdjUzNFZtTzZtVzZibnRSVDYwS2NjMXFr?=
 =?utf-8?B?WHVsajZIZFMycXQreVZQYWt1MU1qcS9DR25FN083MmxFdHVROTFVVDFHRFNv?=
 =?utf-8?B?cDBQZ2pGMlBjQmVCeFJsa0crakVvL2JJb3lQekNLenZMdE9BR1RiVjd5QlQ0?=
 =?utf-8?B?cGRFNGZ0UTVMSzE2M0xMSjRGV0MyVytjQ3Y0T1hQbkQ2WkFUR3F1Z215bGNH?=
 =?utf-8?B?QVNrQXJRNDlGV3hGVlJob3lPUmVvb1V5aEpXY3A4NTdEY09uMEFJeWQwZVE1?=
 =?utf-8?B?d2lPTk5pT0pzREVQdlZheEY4Z0tCaGx1d2czYzkzSnFUUldpdUdsalpFT2dL?=
 =?utf-8?B?Rk9NQmJONUhhMHNPbFN4Mktack5YRTZFR3c2NlIyU0x5YXhzbjRJd1pZYSs4?=
 =?utf-8?B?R0hxV1ZJS21Dc1RmU2VFNXFRMERhWmtKdjRiN1N5TWRRUDlUWTZPOXVrSzlz?=
 =?utf-8?B?aVdxUkg3SHVUQmczajFTTyt2NVBKMDk1dlpRV1BONFlmWGM2Z0dZMCs3YVAy?=
 =?utf-8?B?RWFyOGxmaDVxWWYwT1gxd2xUU1ZtQVErVHpuRCs2OHlKVUpNVDhJN1FhV0h1?=
 =?utf-8?B?UnQwR1Vad0xPNDhzeTIyQVhxdWs2eXRISjh1QWJnYjNvaXpVZTRNdEpMWFhu?=
 =?utf-8?B?SzNENDJ0SlI1ZFI4cHdWSzhlTmc1OXllMm1MYlJ3ZjY5dTBPcDMwTnBWQzY3?=
 =?utf-8?B?clpIcUMzdzVEUmpHYm9FTitPelhtVW10NTBaYVhTaG9aMTcwRTJsY2ZuRnpP?=
 =?utf-8?B?OGlkNUJjbTR5VlRmQXVxNmU2Y2xqamZrTzNuTTEvdWg3QmR2em9LNW5mSjBX?=
 =?utf-8?B?eTh4V3VRZjhyUS9GLzNZWGNGNysvRkdoN2c4Smk1WEhtbm1nWS9yT1g4L1ha?=
 =?utf-8?B?R25GVUNXbjBzaWVaYUtSS1M2VGs0RFBOanpDWGpKakt5bVZWZkx0SmxBaUZx?=
 =?utf-8?B?aWl2L25TQmZrLysxSlVhUkg0WldMbGJtL0s1NEUxRmEvK1lXR1NELzNlWjR0?=
 =?utf-8?B?NGw1UW5Gay9TY3NzaXlQckdFS09wK1QwZWVEQkl4MXpLT081dUVkZnkxbFk5?=
 =?utf-8?B?cFZybzQrT3NETjhLOWtIckwrRXRES2R0WWU2MFFWVDRDSHovb3UvY01nS2hK?=
 =?utf-8?B?cWdRamRad09JY1AvWGVCWVBoS3I0RjJJSnFmUXN4dER4bDF3UGFmZVlzWlF2?=
 =?utf-8?B?MkNtOW9zRHVOSy8ydnBnbEppV2tUR2hLQ0o1WmpnMEx5cHhvK0ZhSFozU3dZ?=
 =?utf-8?B?QjZZSVE2aUQxaHM2bGRMWk9jMENuVlY0eWRoVnZadlJRTUNsZFE0d1dFRGxZ?=
 =?utf-8?B?dTlCN2ZFckdCTHpveksrUXNHZ3hpYU1ycFpyVDRTZFN1bEl2SWlvaFdMeE5y?=
 =?utf-8?B?d0E4UFdJQzh3WEZoRXNYVm51TlJqQjRIajl5TElLenc4ZEg2YlVpd2FteWVV?=
 =?utf-8?B?N250SXovWkI1d21kcFdkWi80SVdLdDVwWWpVUDFmdGlESG8vLzVSTy9wZlJS?=
 =?utf-8?B?Zjh6WkdPZTJqdngwYURtOFJOK3orZ3FTVnhyNkMwSExqUzkzWC9OZDRydGdp?=
 =?utf-8?B?dnZJU3p3dWxMUTRlajBpZlRsNnRZNGdRYWNubEVJTUU3OGJzNWlJdk1tVmdY?=
 =?utf-8?B?SFJhTytiQTFXNjRoSDczSTBvT1RTS3lVMjNjWWJNSmFGcFd0SHh1Rm9pWnFT?=
 =?utf-8?B?dmNYV05HME9xSWNOZXZSdTBkQTBuVElLcFpsaW9DVTFBSjE1UStkaEw2UUhR?=
 =?utf-8?B?OWUwNU9DVVhNVGhKSE1nL01kRms1dVBHL0hEVUR5aHl5Ukprc25DUFY5N3lX?=
 =?utf-8?B?SDdTTFNaYkxQOG5mSWdSdzJwam4wMG1aaHdvVmZTa3NQY1ZtSjVwY3QxTHcz?=
 =?utf-8?B?V1BUUGhyWSthdnpFazJqaXJ2cE9mSVUvS3FCeS8xc1BHd2hYcHkyL3FEZ016?=
 =?utf-8?B?dW1VT0FGQUxoUGxRNytXMEVaZWd3OExJM1NRUW9pQVlCK3lVUHQ4NjJTa0cx?=
 =?utf-8?B?ZDFBY0hQMkMzdU9IQlJwUnFXdkp4b3RJTVZFenp0dTRENzNHMkVCbklmcHVo?=
 =?utf-8?Q?8/i/l8+EialgGg4LehKEWdB7syB+PMaHjDvDX/BapwzOo?=
X-MS-Exchange-AntiSpam-MessageData-1: g1speeJ3Z+Sl6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decc7a1f-cbeb-49a4-86a5-08df0d2affbe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:57:24.1474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25dOteRN4PWWMw8XpapBz1y3frJgEkdjXNKBFqhfSrHSS0u7g2xtRyTggiy2LwtscGM3ZqqGuejSEp23RBgFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5733
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 9/7/26 15:13, Marc-André Lureau wrote:
> Replace HMP with QMP equivalent.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/arm/test_integratorcp.py | 13 ++++++++-----
>  tests/functional/m68k/test_nextcube.py    | 11 +++++++----
>  tests/functional/mips64el/test_malta.py   | 13 ++++++++-----
>  3 files changed, 23 insertions(+), 14 deletions(-)
[...] eaten a bit

> diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
> index 163bbaf5ca36..3b6d53799616 100755
> --- a/tests/functional/mips64el/test_malta.py
> +++ b/tests/functional/mips64el/test_malta.py
> @@ -11,6 +11,7 @@
>  
>  import os
>  
> +from qemu.qmp.qmp_client import ExecuteError
>  from qemu_test import LinuxKernelTest, Asset
>  from qemu_test import exec_command_and_wait_for_pattern
>  from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
> @@ -154,11 +155,13 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>          self.vm.launch()
>          framebuffer_ready = 'Console: switching to colour frame buffer device'
>          self.wait_for_console_pattern(framebuffer_ready)
> -        self.vm.cmd('human-monitor-command', command_line='stop')
> -        res = self.vm.cmd('human-monitor-command',
> -                          command_line=f'screendump {screendump_path}')
> -        if 'unknown command' in res:
> -            self.skipTest('screendump not available')
> +        self.vm.cmd('stop')
> +        try:
> +            self.vm.cmd('screeandump', filename=screendump_path)
Typo here :-) screeandump.

Den

