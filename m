Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AD2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZeT-0006eP-Dg; Tue, 17 Dec 2024 10:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZeQ-0006dp-Tk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:38:23 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZeP-00078u-BV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:38:22 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ebbec36900so1262539b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449899; x=1735054699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kE9b+bsMJaxcLbz/q+E5WzaB3WJhURRgldDoPdFE/aY=;
 b=k6nSus3NHxIR/UIDIrjJCyqzn4S+ofQjEUUb58cTlujBj4UHxknmp5cQh0Oo6SD4c0
 N9BG8vWezoxwWpOfqnuACk0m9ThfnQmfvcRUL6azOmybxgPPAb0QnuOg1iHY58zGMzLU
 Vs3GyN4QKFs9KVVROB3oPBZdx3EdNwFSSzDI63X1FxvmazLG9pohWqeG8f6wJW7EvmS5
 5NnYPEc6WSeccgs4ZnOWzwNDpnTZMVj8pKo52wKOf3IYYqzeAY4jpA/L9UTNn2GXQXz/
 ZVK4Smpzz3jmQGYpT7FDFUvVKLoQx2mbbIIDtQaqCT3cC/IjT1ietNvWSY3yBqtLFSPU
 2Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449899; x=1735054699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kE9b+bsMJaxcLbz/q+E5WzaB3WJhURRgldDoPdFE/aY=;
 b=nARXtKkxOkkWw+YpK2rdi3ykqiCNregvHWxIUlEdxv6xKPBBKAB0ndrJLIAlsVJh//
 1Vm6TYh6symRpwb7jBkSt0j5ha7S+f1ulSs3v1V+lBOlx8OSthOuOqNjZUgqphYUkMqC
 KV+2ZLRLGUipvaUA8ezbWN/F9/okYnp4dvyZYGaI2lPfs0mHjDaTNZZ8lhq4R9VvfpuY
 yG8hfiq1Qli2ZrrnZktarvbNchasVyMukl4CV1O9dt2E2+azZs3apl1/Nath3QjOMYJu
 ST4AxRGld65aFH7IQQ/QoJuraIpIi0X1XArgA54d4YPLjo+4wE1PIQ0TWK1lkYrGsVEZ
 Zr+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWKmoHTFdeJcG0/esCZUH7e1RlQW+DLLBkKaUgOALXHEecmP4f6YdEJdFuTqV3Jo/ZADmUzsUQu1S@nongnu.org
X-Gm-Message-State: AOJu0Yz96u5Rk+BRYOhyfYSm0oQax4l4iuQYrQy8o8YbGVl2hn9kFswj
 Mwwm1DvHUnMtSvgS1EujF2cIkabxdzRGrZKWx+wKTHPlCz/TWi+6U1Dl6Cfqgs6f57Tc8SQtXDi
 W60pba8u8
X-Gm-Gg: ASbGnct49khCnpNUcO/DQGowxgBNY7Bvu3ErNFnrnBozy84xoVsvvpsW6emJiKPolrr
 AbvbK4N9FQ2k7KtZnwdTWfXUmHvV4pWemLJdit61d4woGvMt6YsCcZrjuoYJGUYSE8nMySqxqGM
 QWHel+NDyGX1CWhVd8pGwJ96gzxc+/Vo+OhrsMLzVi+9ElFd3k6l8/8dL8MuuXCYuYvx65Bjgy4
 nMuAAWsrhZF+CH4d+BpMpjtrNBp14mIRIG8Mf8b9az5yvBc+3aJwOUHEunXVtPe1fGmigap+A==
X-Google-Smtp-Source: AGHT+IHbCf+E5WdLLspuHw77k+g3Of7s7+vfvOy0YtlORABMUC3Q4Al676o5xVbdh9Aoeg2mdUM3AQ==
X-Received: by 2002:a05:6808:191f:b0:3e8:1f5d:b804 with SMTP id
 5614622812f47-3ebcb2cf0a3mr1231198b6e.15.1734449898989; 
 Tue, 17 Dec 2024 07:38:18 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb493d417sm2283402b6e.49.2024.12.17.07.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:38:18 -0800 (PST)
Message-ID: <b7aa912d-6ea2-40bc-9ec4-52b6d0a046cc@linaro.org>
Date: Tue, 17 Dec 2024 09:38:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] configure: reenable plugins by default for 32-bit
 hosts
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/16/24 19:07, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   configure | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/configure b/configure
> index 18336376bff..02f1dd2311f 100755
> --- a/configure
> +++ b/configure
> @@ -528,25 +528,6 @@ case "$cpu" in
>       ;;
>   esac
>   
> -# Now we have our CPU_CFLAGS we can check if we are targeting a 32 or
> -# 64 bit host.
> -
> -check_64bit_host() {
> -cat > $TMPC <<EOF
> -#if __SIZEOF_POINTER__ != 8
> -#error not 64 bit system
> -#endif
> -int main(void) { return 0; }
> -EOF
> -  compile_object "$1"
> -}
> -
> -if check_64bit_host "$CPU_CFLAGS"; then
> -    host_bits=64
> -else
> -    host_bits=32
> -fi
> -
>   if test -n "$host_arch" && {
>       ! test -d "$source_path/linux-user/include/host/$host_arch" ||
>       ! test -d "$source_path/common-user/host/$host_arch"; }; then
> @@ -1072,7 +1053,7 @@ if test "$static" = "yes" ; then
>     fi
>     plugins="no"
>   fi
> -if test "$plugins" != "no" && test $host_bits -eq 64; then
> +if test "$plugins" != "no"; then
>       if has_meson_option "-Dtcg_interpreter=true"; then
>           plugins="no"
>       else


