Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C0EE7DF16
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyHK-00029P-3v; Mon, 02 Feb 2026 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmyH3-00027I-Re
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmyH2-0000Uk-DD
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770055423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgdjZIAeQ9dr2cldjOG1ByPris3Ybpu/V3gt5fiRk34=;
 b=O/RL2ylI5gJNvzpptLIUfwaPrgpgAcjMnTncJ/ysgDR5BLpr8AGaYuDoeUKKzmmB6hV28p
 eGpkmn68l+jB+CynQeZ0zUdxR0F6Ng7Rxm/9ymJxmPyQjXwM8m8jWz4nN0YzYv8g4C4M16
 oodq3a7mt0GMemEmRWK2nATrNd8oqRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-dAV4MsRKPXWE_VQHQ-g5mw-1; Mon, 02 Feb 2026 13:03:42 -0500
X-MC-Unique: dAV4MsRKPXWE_VQHQ-g5mw-1
X-Mimecast-MFC-AGG-ID: dAV4MsRKPXWE_VQHQ-g5mw_1770055421
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso41439785e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770055421; x=1770660221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgdjZIAeQ9dr2cldjOG1ByPris3Ybpu/V3gt5fiRk34=;
 b=gq+wrkn6Za83L3sYCtFNR9AVSkltrfU0RxWpyllINJ1JIglvNzl/ObxtgxeDigWh5E
 94Jjv2NXSeacslxvINi3fVRyQLwy5SVm1oGSsivvkbHchBgaIuzqFTh/z93uHTK2ZlSw
 DmY8rIw0cRTFqjzyao9Uuygiw76Oi8vF7SdqstHJRx11SNNNvEq6fQhn1NAeryKgbErq
 +dosn+dRPGwsjzrppPexLP4pGgjoJBWClraVnU+x4TNUAlVu4XFmwi/c158uVPT9cOGs
 NeXLPQDd0tgDIqvNibtDKJk6n7B3lR39BdIVB9Q0Nm3YchcedEc3y826wTa0INfDa0fZ
 ea2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770055421; x=1770660221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgdjZIAeQ9dr2cldjOG1ByPris3Ybpu/V3gt5fiRk34=;
 b=MmywUYMeeWU8piNy3GWQT0STI9vhqNqUP0Zs0Npa9yHI4ubHZzS6NXEEf51eGZJ+cU
 d+DPuboMIc9Vn8b/eunTaes6A9kHzqt16XEZsPgQdwn7xhqyTlJJn4NOQTzosXCaIvI7
 i/lGH17tJhIozf0W2L3iJ4CaJvu5qGMepDNCSRVybo+E3U8Zs1UcqCsjDMu+zocaK9Dh
 8TaGqfWNRCuWSu7RmHEZgiIpwkjRkgrEgtcgmDxocprfhu6lzM07hhCkv9yOLPIzQjsE
 03cPPQyUT8dBgoansR4ttbTzhNrQG2zzUsNFZkEKZL4OtMjoK74L9g2ewPxhgfO6mCvn
 h/Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJUFZnYsnUlAjARBt8pZ4UG5xWbO0JHSgYif3iCojOzRO6wn9jp1+fyWI5qYlkIrZHTF28AWSVWkde@nongnu.org
X-Gm-Message-State: AOJu0YwAthq0NIjwPVxe0phgHbd0u+mdlbEj2SiQeQZoIFRtiMzygimX
 Zhmkm7IoMBATtA/seXW7coSoJxyENfH18N5G9VB7Ji+2gjY5oNnXNoEeKYeLUsoBQ6VvmS+kyes
 wz42/14Njpz+qAHuLgVqHX1HlkNliI3EDYP0YLT8N49BvNwV2WSpOMNBe
X-Gm-Gg: AZuq6aKCNM6dRLbgtonDp3Q1g9IOZapetWPgqj/q1nW7xfGyWowud+9VTlNUYJxf1vv
 kpFffKs4kczWrMiwIfELcljwnSN4WspJzo9WV+lZZzaCB6albNKgiUEwh3EWwsgW02UWVnry3im
 5GQ5FWCUIOSDV0LtFulNE1LZkVFpxyiaqx+6fq0fKgSDd+RuPFF9fAUr0C2VpWWS07tSMAidIio
 0OpIV0+kbiWLHeF0I1vMf+RjhiI2C3lfFdjFdra0LYE2NQGhuHAmL4pxwjv8nw9omJUCuE+8YbX
 U2UINuBKajzb4HyB+fNV0tqwsHajHw1zJULP9OFhp4V77y4KfJq8N8xX0UCM0I4aYksPoQnQw6a
 DQAU95B5VCi3suPsaVwz+a9g+dlTOCyNzkoIRMIDrLrq58gZ46nIBVy5FjYTkbiKEYM/a+sVSdG
 8N7gvSSYGjmB44Iw==
X-Received: by 2002:a05:600c:3f0a:b0:480:4b59:9327 with SMTP id
 5b1f17b1804b1-482db44780bmr170461855e9.1.1770055420812; 
 Mon, 02 Feb 2026 10:03:40 -0800 (PST)
X-Received: by 2002:a05:600c:3f0a:b0:480:4b59:9327 with SMTP id
 5b1f17b1804b1-482db44780bmr170461425e9.1.1770055420430; 
 Mon, 02 Feb 2026 10:03:40 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483051372cdsm7281835e9.13.2026.02.02.10.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 10:03:39 -0800 (PST)
Message-ID: <5b0d09d9-6f52-4211-a769-1c07b7926b06@redhat.com>
Date: Mon, 2 Feb 2026 19:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson-buildoptions: Remove duplicated entry of --gdb
 in the help text
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20260202174123.1943748-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260202174123.1943748-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 2/2/26 18:41, Alex Bennée wrote:
> Since --gdb has recently been added to meson_options.txt, the help
> text shows up twice in the output of "./configure --help":
> 
>   $ ./configure --help | grep gdb
>     --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
>     --gdb=VALUE              Path to GDB
> 
> As the probed value is of interest we want to keep the configure text
> so make meson-buildoptions able to handle deferring to configure.
> 
> Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional tests")
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> AJB:
>    - This is an alternative take on Thomas's approach in 20260114155355.82096-1-thuth@redhat.com
> ---
>   scripts/meson-buildoptions.py | 9 ++++++++-
>   scripts/meson-buildoptions.sh | 1 -
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
> index e636d258e8a..9e3a75c8b11 100644
> --- a/scripts/meson-buildoptions.py
> +++ b/scripts/meson-buildoptions.py
> @@ -53,6 +53,11 @@
>       "werror",
>   }
>   
> +# Options that configure prints help for, so we can skip
> +CONFIGURE_HELP = {
> +    "gdb",
> +}

That's reasonable, yes.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> +
>   # Builtin options that should be definable via configure.  Some of the others
>   # we really do not want (e.g. c_args is defined via the native file, not
>   # via -D, because it's a mix of CFLAGS and --extra-cflags); for specific
> @@ -189,7 +194,9 @@ def print_help(options):
>           key = cli_help_key(opt)
>           # The first section includes options that have an arguments,
>           # and booleans (i.e., only one of enable/disable makes sense)
> -        if require_arg(opt):
> +        if opt["name"] in CONFIGURE_HELP:
> +            pass
> +        elif require_arg(opt):
>               metavar = cli_metavar(opt)
>               left = f"--{key}={metavar}"
>               help_line(left, opt, 27, True)
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 3d0d1323446..e8edc5252a3 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -58,7 +58,6 @@ meson_options_help() {
>     printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
>     printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
>     printf "%s\n" '                           firmware]'
> -  printf "%s\n" '  --gdb=VALUE              Path to GDB'
>     printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>     printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
>     printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'


