Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D250AE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKro-0002gM-30; Sun, 21 Dec 2025 09:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXKrn-0002fq-2O
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:57:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXKrl-0002bM-4j
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:57:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47755de027eso18741565e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766329019; x=1766933819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LVGQ4v7CrpvhQqzslQ18Tr06RGQvl9ZgaPzU5uxdHTY=;
 b=bs30wijS2XGLLUu4k8sbZJvxzHwgtPlnQUtUMjEwmEt5S9me7rCeVMMIwjaMzk46QW
 x+BzAKOJrtCt73j0oVnA0Ic92NicDi4dgXwtYpLfjCDE056vJRCbuxh2Ye/kOHhF7T3j
 oMW/aRicBc9VQzYVkvgtRrZG1K+Yy/3X9MzzOMoekh4dm833KUDIJv/vG5qkLJDlqUPD
 LUIB7aWbuQXAXbyyn/WTsRuxfLmKoBLF9Ymu6WjRZfHirl+QPZXS0gtppysfA8UFErQU
 nYlBTwGbuYTh+GePez3eOK3wLnXvK8HJ6HWEg6hbmuyjggXQPIAo9bDmj9OXdNrXS4eU
 n7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766329019; x=1766933819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVGQ4v7CrpvhQqzslQ18Tr06RGQvl9ZgaPzU5uxdHTY=;
 b=XGiGZ8SmIKGk8VMsDDXn82Fgh7jjxlOqu7SQev1mz/mMxNtxurxZeRjZP++BP6mUKt
 wVyzMMJhXRIwRbGH+n8fjYN/Jge73G+3cbhJdlXkEjSyZUkaokK5Mpm3HH7u5ucWBkMe
 lB68WpiWMa2FpTx3+Klhcs5FUaqJff+RlFbMa0i6ZHZ1ecfRIBYBmaWC4Ke2OgCJHG5k
 uwfjAfXzNo28Vq79KMZ+oy5/oSmnf4FDzMjxYoYEXNUcYre8HRsd3ymFJDZfBBT5QD9z
 V4CFXUMF2r5AGrlRbVaTlpLhUEkvX9MdEjnyv/pY/wcXazJG/2inpzzOgKhVIc9ZUfwV
 +W0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkdugechvewE+mnjgRe+zm7IRXWFcWbpI7UndxwkwT9XA1VR8M13UVzQk8hKLU3uTkWZkzBg9pjw1o@nongnu.org
X-Gm-Message-State: AOJu0YzzWAsT/+8cDTnxSy/UEq5a4K7PDdCGbIkEFzJil0usR6HIgPR+
 +UyTHgkLukAo3UNpU8w7PF/O4AXoonhDtxhFVWr1AEQDB9PIPumoEFSCPEGtxuNPXqg=
X-Gm-Gg: AY/fxX6WY+vbSio6mfxi/ym8I9Qza3i0DdDfMvnTpez+8rcILFVxP/kNzuxpnR0y5GH
 kBkoFraqvFtKj55Twc9U8+FhGazHbjmECNDmXn3xDCwP2AuVxDAVpWnVPth3SvogMGLVRRt1jSk
 1g1X7UuIGxC8ni8MssgJo70K+dTLOp58xMwYjL2VZggkXS79VElDEd8tywIFKLjRzeZJr+1nKfa
 3nxxNSCN5Sz2jp5ASrNyJLrpfk+jhbDo+jtPILoDAquE9jbmZA4biBM7DDNtcTuBnRum+G7kOf2
 xS/j+an7hs1481NfoTVCyvQ3wOWQ5R+U7GH9q8Z9DwA22G1/6HEBsMBGBUvFEgpQgxeva1BsEri
 gC5cGFiJw/9HqyM6Oo1NnbRncl+UjcIwZ4BRYiRDdXeNmGoOmAMap1BGmcB3t7BeYh1PF33hgmI
 2WSpr94yspRr/S4csz1VMFm5xOhC1Aa5YfNCiVOn8Y3D3M1ZYkjZ50Ug==
X-Google-Smtp-Source: AGHT+IFKwS8Km7m9BNVtIIIvxPF/iaOjQjOiVW9js8bgynAbjf09cijJ+RjBaJyrmDNxNDGvZd7ZFQ==
X-Received: by 2002:a5d:5d0d:0:b0:431:3a5:d9b8 with SMTP id
 ffacd0b85a97d-4324e510810mr9767561f8f.52.1766329019312; 
 Sun, 21 Dec 2025 06:56:59 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm17343378f8f.17.2025.12.21.06.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 06:56:58 -0800 (PST)
Message-ID: <3d97400f-0d42-4f21-b64b-c719443ca3aa@linaro.org>
Date: Sun, 21 Dec 2025 15:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] tests/functional: Add gb200 tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Ed Tanous <etanous@nvidia.com>, Thomas Huth <thuth@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
 <20250704083723.1410455-12-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704083723.1410455-12-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Ed, Cédric,

On 4/7/25 10:37, Cédric Le Goater wrote:
> From: Ed Tanous <etanous@nvidia.com>
> 
> To support the newly added gb200 machine, add appropriate tests and
> extend do_test_arm_aspeed_openbmc() to support the hostname of this
> new system: "gb200nvl-obmc".
> 
> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-5-etanous@nvidia.com
> [ clg: Adjust commit log to document do_test_arm_aspeed_openbmc() change ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/aspeed.py                    |  9 +++++--
>   tests/functional/meson.build                  |  2 ++
>   .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++
>   3 files changed, 35 insertions(+), 2 deletions(-)
>   create mode 100644 tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> 
> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> index 7a40d5dda736..b131703c5283 100644
> --- a/tests/functional/aspeed.py
> +++ b/tests/functional/aspeed.py
> @@ -8,8 +8,13 @@
>   class AspeedTest(LinuxKernelTest):
>   
>       def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
> -                                   cpu_id='0x0', soc='AST2500 rev A1'):
> -        hostname = machine.removesuffix('-bmc')
> +                                   cpu_id='0x0', soc='AST2500 rev A1',
> +                                   image_hostname=None):
> +        # Allow for the image hostname to not end in "-bmc"
> +        if image_hostname is not None:
> +            hostname = image_hostname
> +        else:
> +            hostname = machine.removesuffix('-bmc')
>   
>           self.set_machine(machine)
>           self.vm.set_console()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index fb87b957aa6c..050c9000b95c 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -33,6 +33,7 @@ test_timeouts = {
>     'arm_aspeed_ast2600' : 1200,
>     'arm_aspeed_bletchley' : 480,
>     'arm_aspeed_catalina' : 480,
> +  'arm_aspeed_gb200nvl_bmc' : 480,
>     'arm_aspeed_rainier' : 480,
>     'arm_bpim2u' : 500,
>     'arm_collie' : 180,
> @@ -129,6 +130,7 @@ tests_arm_system_thorough = [
>     'arm_aspeed_ast2600',
>     'arm_aspeed_bletchley',
>     'arm_aspeed_catalina',
> +  'arm_aspeed_gb200nvl_bmc',
>     'arm_aspeed_rainier',
>     'arm_bpim2u',
>     'arm_canona1100',
> diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> new file mode 100644
> index 000000000000..8e8e3f05c1b2
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> @@ -0,0 +1,26 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +
> +class GB200Machine(AspeedTest):
> +
> +    ASSET_GB200_FLASH = Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',

This test is failing for me:

2025-12-21 11:10:40,608 - qemu-test - INFO - Downloading 
https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz 
to 
/builds/philmd/qemu/functional-cache/download/b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc...
2025-12-21 11:10:40,798 - qemu-test - ERROR - Unable to download 
https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz: 
HTTP error 404
urllib.error.HTTPError: HTTP Error 404: Not Found
qemu_test.asset.AssetError: 
https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz: 
Unable to download: HTTP error 404
make: *** [Makefile:170: run-ninja] Error 1


