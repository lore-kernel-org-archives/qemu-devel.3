Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E1C10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64en-00041z-JF; Fri, 27 Mar 2026 06:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w64em-00040y-55
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w64ek-0006tB-0s
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774608189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p4+Jp5dUHVQ9VpTbyD1Du4wwoAzeVpTCXeSUErVI/aM=;
 b=dr5Ge0Aph9+wCFf9t2rpDVny4R7OlNivr/0zFfN7Q471lKrVBRSxEiP5Kq7oz8JFinYpuK
 bXcdkfUq6xGVb0Pwp4XZkxPLssG+LTSFMa2iWtKn2BAAJdetscyet7X3d1YmZ1VQVGkoqL
 0FyALz0gfH9vEJFp81ElGhpYS/6kq9Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-zNQhANeBNTSJsYyqUJPTgQ-1; Fri, 27 Mar 2026 06:43:07 -0400
X-MC-Unique: zNQhANeBNTSJsYyqUJPTgQ-1
X-Mimecast-MFC-AGG-ID: zNQhANeBNTSJsYyqUJPTgQ_1774608187
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so18596615e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 03:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774608186; x=1775212986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=p4+Jp5dUHVQ9VpTbyD1Du4wwoAzeVpTCXeSUErVI/aM=;
 b=geGyb4WbW964y4mIcTWqoqxqlj3KLqLUf98cEPQ34kuXZ15vvhqw2M6avCrUQdi4rU
 HNdd4RNLZoL7kjKYqdZTG4qKNusHSwg21gkeLIg1gY1f3iOKE+seI7L9UzAw8h/GMZUN
 dNOBewDL9u9G5reOmpIu9Ozo7ormSDya8dCQfYoNqpCAbE0zNYigsmVp5w3wIBbRjlE1
 EZ+ojTQVeakMACL5GKVIq8PskrtTroNVOFtEH5rIVFR6MIkU4lXp7SY4FAV8V8Hmsd9k
 nQNQosbx5DJM3WLZkiP5RYYRfqX430qZgD9aaaqJJAkS/NvCI+eBc7obAy+FsV30f7vM
 z7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774608186; x=1775212986;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4+Jp5dUHVQ9VpTbyD1Du4wwoAzeVpTCXeSUErVI/aM=;
 b=oQnbhH/rlhFzNmrXvdHrEkUfWhynonnKpxNUJsncGIl+l1vOaX7DF8pGPuwY772X+z
 N2fzd5EGYIxpetw8p9LUsiOtjjiK+DySskpBerRTpm3OO1jBBQVVxBDZJ0KJc3f0JKpf
 cO2oPsm11rG1qlSK9JlZSG8N9jFwY48cdNPax8eHP2yL37PmDEyA5lEFaMBHEPyFjhX2
 O9g30AqULLpg+5Pll9SR0bd/6lpXA0NcxfiHs8H++BNg7IS42QvI7p3cmoyJINkY+8yz
 5w5lI858UsohM0ECsa38Sl4sVXfSh7x1tioRVVRAUELdv3nD/WdG4hUlsh2r+DfaJBjT
 uoQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEca2LqAFPnpwMM4IYhJb737lJsqFwdfJopUUE8rXijH/zDEkg+cijJJty6YwtMSCVDNTTTQOCzlvO@nongnu.org
X-Gm-Message-State: AOJu0Yw3xwGwJ4NlC/qfuc2/OC8WK5pQUqI63Hyugahb+tho1f7M6mlP
 z0N8PRoHnN1LXAKMaHio1fGy+G4aFsc8X2fsmQt9dIaWmG5LBwMOwL39Q9aIvzRUM9knATBUiKo
 Xyxl4EjCe5UcCinmHBCy2Yx3GMq9CBpxMNMIcRKvMHDPhMUPIjRn5wceD
X-Gm-Gg: ATEYQzweBtzPyUBpFiNduV3s+JAfrvAsMdO7+WrKRgmgvx6Sf8FIj6ZfoRpZ87YbKkN
 p7Wa6FtaiHWEX/T7Ti509URblriDW69HvN8GljDdoHs6wttoY/st4fY7AXX3m/2LxjmlvTpIEkK
 6CfDFlWufVf2BIWCwI8Q9PLk0S8/FaeaF09WWyV73muoGup7aP1qCZF+74NhzQVBnNkc9s1HUwu
 Mucc0jVN6zepfsgzzSzKy4g0dhcOTbEiMte/FoxGQ2/9ewE62qULJV9LLgM9d+EUUWj9GV3rtJk
 saj+G317duBj08X6HuYYOvs92vsFusWwH4nmYC9tYvwEnPze45kvzydpAomfMSgW4ut+FanF5Fu
 vA0t86CbczJ2d+ZBy0eN5LRBjqsBcKr38zMqGJwwz+V2PpNnGg/bVJsCMH7FX
X-Received: by 2002:a05:600c:4f44:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-48727ec7819mr34102545e9.20.1774608186363; 
 Fri, 27 Mar 2026 03:43:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4f44:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-48727ec7819mr34101985e9.20.1774608185811; 
 Fri, 27 Mar 2026 03:43:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725ec20edsm14957175e9.9.2026.03.27.03.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 03:43:05 -0700 (PDT)
Message-ID: <abdeab64-c7f4-4f96-bb09-411f22dbe3a9@redhat.com>
Date: Fri, 27 Mar 2026 11:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs and tests: assets moved after GitHub account renaming
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
References: <20260326214436.256215-1-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260326214436.256215-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/26/26 22:44, Pierrick Bouvier wrote:
> GitHub setup a permanent redirection for all repositories when accounts,
> so the old links will keep on working also.
> 
> However, GitHub allow this username to be reused again. To ensure no one
> can inject malicious content, I took ownership of the (newly free)
> pbo-linaro account [1], so no one else can claim it.
> 
> [1] https://github.com/pbo-linaro
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   docs/about/emulation.rst                      | 28 +++++++++----------
>   .../aarch64/test_device_passthrough.py        |  4 +--
>   tests/functional/aarch64/test_rme_sbsaref.py  |  4 +--
>   tests/functional/aarch64/test_rme_virt.py     |  4 +--
>   4 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 469f31bab6a..3b4c365933d 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -898,24 +898,24 @@ As an example, we can trace qemu itself running git::
>       $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>   
>   For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
> -<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
> +<https://github.com/p-b-o/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
>   Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
>   using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
>   Some sequences taken from this trace:
>   
>   - Loading program and its interpreter
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
>      :height: 200px
>   
>   - open syscall
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
>      :height: 200px
>   
>   - TB creation
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
>      :height: 200px
>   
>   It's usually better to use ``uftrace record`` directly. However, tracing
> @@ -928,7 +928,7 @@ Example system trace
>   
>   A full trace example (chrome trace, from instructions below) generated from a
>   system boot can be found `here
> -<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
> +<https://github.com/p-b-o/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
>   Download it and open this trace on https://ui.perfetto.dev/. You can see code
>   executed for all privilege levels, and zoom in/out using
>   :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
> @@ -936,27 +936,27 @@ taken from this trace:
>   
>   - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
>      :height: 200px
>   
>   - U-boot initialization (until code relocation, after which we can't track it)
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
>      :height: 200px
>   
>   - Stat and open syscalls in kernel
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
>      :height: 200px
>   
>   - Timer interrupt
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
>      :height: 200px
>   
>   - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>   
> -.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
> +.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
>      :height: 200px
>   
>   Build and run system example
> @@ -966,7 +966,7 @@ Build and run system example
>   
>   Building a full system image with frame pointers is not trivial.
>   
> -We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
> +We provide a `simple way <https://github.com/p-b-o/qemu-linux-stack>`_ to
>   build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
>   and debian userland. It's based on containers (``podman`` only) and
>   ``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
> @@ -974,18 +974,18 @@ on machine where you build it.
>   
>   You can follow the exact same instructions for a x64 system, combining edk2,
>   Linux, and Ubuntu, simply by switching to
> -`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
> +`x86_64 <https://github.com/p-b-o/qemu-linux-stack/tree/x86_64>`_ branch.
>   
>   You can follow the exact same instructions for a riscv64 system, combining
>   opensbi, Linux, and Ubuntu, simply by switching to
> -`riscv64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/riscv64>`_ branch.
> +`riscv64 <https://github.com/p-b-o/qemu-linux-stack/tree/riscv64>`_ branch.
>   
>   To build and run the system::
>   
>       # Install dependencies
>       $ sudo apt install -y podman qemu-user-static
>   
> -    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
> +    $ git clone https://github.com/p-b-o/qemu-linux-stack
>       $ cd qemu-linux-stack
>       $ ./build.sh
>   
> diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
> index 10c73728f36..3ef4e7ddc1d 100755
> --- a/tests/functional/aarch64/test_device_passthrough.py
> +++ b/tests/functional/aarch64/test_device_passthrough.py
> @@ -78,14 +78,14 @@
>   
>   class Aarch64DevicePassthrough(QemuSystemTest):
>   
> -    # https://github.com/pbo-linaro/qemu-linux-stack/tree/device_passthrough
> +    # https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough
>       # $ ./build.sh && ./archive_artifacts.sh out.tar.xz
>       #
>       # Linux kernel is compiled with defconfig +
>       # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
>       # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
>       ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
> -        ('https://github.com/pbo-linaro/qemu-linux-stack/'
> +        ('https://github.com/p-b-o/qemu-linux-stack/'
>            'releases/download/build/device_passthrough-a9612a2.tar.xz'),
>           'f7d2f70912e7231986e6e293e1a2c4786dd02bec113a7acb6bfc619e96155455')
>   
> diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
> index 4845c824960..efea80c5782 100755
> --- a/tests/functional/aarch64/test_rme_sbsaref.py
> +++ b/tests/functional/aarch64/test_rme_sbsaref.py
> @@ -20,10 +20,10 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
>   
>       # Stack is inspired from:
>       # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> -    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_sbsa_release
> +    # https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_release
>       # ./build.sh && ./archive_artifacts.sh out.tar.xz
>       ASSET_RME_STACK_SBSA = Asset(
> -        ('https://github.com/pbo-linaro/qemu-linux-stack/'
> +        ('https://github.com/p-b-o/qemu-linux-stack/'
>            'releases/download/build/rme_sbsa_release-6a2dfc5.tar.xz'),
>            '5adba482aa069912292a8da746c6b21268224d9d81c97fe7c0bed690579ebdcb')
>   
> diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
> index 5e23773f93d..dcb18678bfd 100755
> --- a/tests/functional/aarch64/test_rme_virt.py
> +++ b/tests/functional/aarch64/test_rme_virt.py
> @@ -19,10 +19,10 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
>   
>       # Stack is inspired from:
>       # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> -    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_release
> +    # https://github.com/p-b-o/qemu-linux-stack/tree/rme_release
>       # ./build.sh && ./archive_artifacts.sh out.tar.xz
>       ASSET_RME_STACK_VIRT = Asset(
> -        ('https://github.com/pbo-linaro/qemu-linux-stack/'
> +        ('https://github.com/p-b-o/qemu-linux-stack/'
>            'releases/download/build/rme_release-56bc99e.tar.xz'),
>            '0e3dc6b8a4b828dbae09c951a40dcb710eded084b32432b50c69cf4173ffa4be')
>   


