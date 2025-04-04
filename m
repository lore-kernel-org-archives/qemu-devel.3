Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E643C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 05:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ZZU-0004LG-7t; Fri, 04 Apr 2025 01:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0ZZS-0004Kz-5N
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 01:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0ZZQ-0003Gp-Jc
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 01:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743744382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y7Nbv5uop0UuAgVMI/0eRBllvFPXC9t4RwioDV37Aq4=;
 b=bDvVkoPkbnMBESye8GPJPETKdAoTolHXDFwjFgsqt7dtSYjKDTy9DOv1ZXnImqp9ZmR3d8
 NV5krx48re4uuR2SAsE/xViVxmUpPcBTNU3mMFJmH4hWXpnCDIluD8tJmFUFklLeOEMYXH
 AKTLSd3ikqx2Nim2q7LkTWOKtLuXKWQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-34R7D5aWNaiqi6lIBLe9_g-1; Fri, 04 Apr 2025 01:26:20 -0400
X-MC-Unique: 34R7D5aWNaiqi6lIBLe9_g-1
X-Mimecast-MFC-AGG-ID: 34R7D5aWNaiqi6lIBLe9_g_1743744379
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e5d9682f1fso1554268a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 22:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744379; x=1744349179;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y7Nbv5uop0UuAgVMI/0eRBllvFPXC9t4RwioDV37Aq4=;
 b=toQCRJrVCo9kGDQ2C/hI8kRKYbVOfzvH+8cS5VGrTKRDGm3T9Q2Ulx3Mjbd74F++rr
 V76kY3Rmfm84jG7e7Kef+nnl/KDe1K/8ODKf3beLZFQu/mP+oYUwNv1vg4L5kqNgpzkP
 wLUhjnCgRUf2TrZjRLraKZvmDk9x/Jv60Q5HSGTF73p5fkp9+YN2itxEPRlZqUBMH4qq
 qwg1fCnJPGnh5zxUO0e+96ouknswf4Mk5KERQ9PTaXFGgT160TSW2eGXPGyJfpyWggjs
 EXJUgKiJwMlsHolFjk6tni7MvB5fGzg8Hbji8BQ+N8Ue8Rp6Pm64zF0zuRKG465WHPKr
 XZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0TNjGCS2u/CCIiRbZCRnf2LmtBmUVLdZvmg+VCq8RZyOkyPmoNnsTyicBfmvgglEXxph7jBXpLuZ0@nongnu.org
X-Gm-Message-State: AOJu0YzoV+Grgqc2rpB2WpcPhb0nIxCY1Ljn3cZf7pjt2cyfI162xeHU
 3G+G8wa90m/SObJgRzlOX5zYESC4MjWetEZ2JCFJJ5uBYjXf18e+bv8H3VtdsnNcCieulO6ChkM
 VhbyEkFca7Vyp0WEB95GBNah7sZ/3J6LKGn+am6iV4YaJZs5FZbT0
X-Gm-Gg: ASbGncu+k+78KW4I/whDkGKWDvtGIaH1XKYZWHt6g9BBkKy1MZjHW6xkPG2MJhZmr/r
 l7ZTIaRX7le+aC5P4IurOHOjlxTVA4QN29j5QpLMpduTqfhEQFYrQWBZZgI/75yvEUgl6n9vD49
 N/uJzWk/xsL6WSXI0jcqi/lJ72QuGsaaAZko5jz60iLwI55GRPqjRBrqVu5DJ0KJOhpNckMhurz
 3q7Lu6ukhkpy9XGjbwox0FPwW1NLFwQD6dF/uSxIiDj+0XqRkvt9Cp9FivDOf2iLwbWfLYaXjue
 4j0PXQF3fMqHOyq+SH3IVAu+ET3Re7L3OUHvnJQWHstG
X-Received: by 2002:a05:6402:3492:b0:5e6:bba0:6778 with SMTP id
 4fb4d7f45d1cf-5f0b660694fmr1062636a12.23.1743744379380; 
 Thu, 03 Apr 2025 22:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs1p9Cg+sY0O/d8arqFQQ8P2oCn6M8kMjIailhM2/72CEdrERxz2e1DiGQIQtDZoO98dkX+g==
X-Received: by 2002:a05:6402:3492:b0:5e6:bba0:6778 with SMTP id
 4fb4d7f45d1cf-5f0b660694fmr1062617a12.23.1743744379040; 
 Thu, 03 Apr 2025 22:26:19 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880a5204sm1829396a12.66.2025.04.03.22.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 22:26:18 -0700 (PDT)
Message-ID: <e92f7d01-8def-4a5c-8910-49197386b63c@redhat.com>
Date: Fri, 4 Apr 2025 07:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v3 2/5] tests/functional: Add a decorator for
 skipping tests on particular OS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
 <20250403203241.46692-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250403203241.46692-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/04/2025 22.32, Philippe Mathieu-Daudé wrote:
> Since tests might be failing on some operating systems,
> introduce the skipIfOperatingSystem() decorator.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py   |  2 +-
>   tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 45f7befa374..af41c2c6a22 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -15,6 +15,6 @@
>   from .linuxkernel import LinuxKernelTest
>   from .decorators import skipIfMissingCommands, skipIfNotMachine, \
>       skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
> -    skipIfMissingImports
> +    skipIfMissingImports, skipIfOperatingSystem
>   from .archive import archive_extract
>   from .uncompress import uncompress
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index 1651eb739a7..50d29de533d 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -5,7 +5,7 @@
>   import importlib
>   import os
>   import platform
> -from unittest import skipUnless
> +from unittest import skipIf, skipUnless
>   
>   from .cmd import which
>   
> @@ -26,6 +26,19 @@ def skipIfMissingCommands(*args):
>       return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
>                                   ", ".join(args))
>   
> +'''
> +Decorator to skip execution of a test if the current
> +host operating system does match one of the prohibited
> +ones.
> +Example
> +
> +  @skipIfOperatingSystem("Linux", "Darwin")
> +'''
> +def skipIfOperatingSystem(*args):
> +    return skipIf(platform.system() in args,
> +                  'running on an OS (%s) that is not able to run this test' %
> +                  ", ".join(args))
> +
>   '''
>   Decorator to skip execution of a test if the current
>   host machine does not match one of the permitted

Reviewed-by: Thomas Huth <thuth@redhat.com>


