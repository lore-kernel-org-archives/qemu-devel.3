Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2299CCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmoG-0000oB-7O; Wed, 03 Sep 2025 08:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmo9-0000mv-Bx
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:41:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmo6-0006Zu-Gn
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:41:49 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61cb4374d2fso9448532a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903304; x=1757508104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uDIK1+/b7doU5cu5anlfuNO/gFsQaWznqew57k/z5xM=;
 b=CI0V7IDDHtmFpUxhPE6YSjz8arSX0iXZ+xTbWPGQOgbyJhB4ujqajdjQ4bQ4VCv8Ui
 4S9tirmgCYSxJQRLpfI6t37CM2pDcAxUsFMgplQ5a03aLm6+pFGYOzI3nrfHkv7X0zxg
 I0QSYOSOpXz5qhiFDbbpodw0kyp5GMH420Y03HlaUcK23TCx1bBvwIlSeZx/v2wvdZZ3
 VpvSCvVdbbrjxGeAf3EGmPuseJkS/IwpIHcVY0iixaEj+ye48up+xbDxLyktZCX4w3o4
 S+HH/QJijp0/SdONHWOlVBg/HtOmKJE6TVOQCZVaYLkTXtJNKZySEh9+E4bhNjMVmhtL
 u55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903304; x=1757508104;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDIK1+/b7doU5cu5anlfuNO/gFsQaWznqew57k/z5xM=;
 b=Uu0ifkLLa/2zuZ0wH9ZmNo7csxOM3NEVMByFD5UbEENycc4E7XgOJ2NmecvuecWrWB
 wHnyRPbTHXsQ62tvuuWc+KmLTknuLWH1N5R+rGv6TX1nw/SCxCyXvbGKSGZng+AzGSw9
 2ZHa90UYMy0Bn/zT4gvlKYUOPo+h2y4f3K5kbe//JD+tKe6OQ0/cNbRLZnANIy9AdF/T
 k62BsBOGZFZ64eT57BjaxBIK5oQxr5C34woJ4DxQ52fb222LUZsJWCY1olnT1OiDb9iH
 Buj1yD1siiF4a5fyGxOYRJtEsNqpzDsNSBnTY0H/EfNuga5Zk5HthOAopx3psG4GSKxk
 HbSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHsxuEp3q+tUFTF1+KdxoYHPaW2mVXEdhsnBYkDsFLYweEYc0OJejMj8iZBoVWmh6fULOiunr/Bz1B@nongnu.org
X-Gm-Message-State: AOJu0YypPitNOUoGy8K44KP5rRCVgX6KikX8IteihlXPgiDEbpAKeRfE
 jrX2BRBfQpviRc9M2MaAJPYWMyNRfpFZHr1tlcAL4E8n/A5y0VgpdY0ngNpgxJ9sRcc=
X-Gm-Gg: ASbGncva4hOqtIpnXr+6UJsf6+do5EM+UvfAUPATL9zHFdNHNZkou0t63gcIKEQwzjW
 daBDBgNeog8XhpfG9nzn0DbmgPJSWBlJ7QKFnGMqzGcSarFDfgGzXPHoiIFHBrFllPVlicF544E
 L6lyQgASYTErbfyygomCkvoYBVPy3E3v9b1hqg4LuYFpDau8Rsxmsn2Z8jULv9RUY7INkdsQPTz
 /0ILwTg4c6K2krwUeqnQW+65gKskv4olvmm0IsgQLj9rvpunOuAbNQ+z+gdthOFHVX+za9/oVbL
 sYjBUFOITq8lwhq6mHG9FhQ2C6qQ5cp35rfAySzq0zVijfWgP3f4XFOlPgeNMMukQl/Ee5nGblB
 wsCctuEKjmeRMWFuiEZMI7sVCp91WO1PvduU9pqdUn6fR+2QqSscWP6WWXvdqKCMWUX9lTnfILY
 hhX5mQhA==
X-Google-Smtp-Source: AGHT+IEphbZr5aBLGv60lvPurg1uMomsLAbQhhscUSKa+fIvnsBcw3yd22B/IzWJYYQzjGppQcgRSw==
X-Received: by 2002:a05:6402:3812:b0:61a:1702:792a with SMTP id
 4fb4d7f45d1cf-61d269a6fb3mr13413449a12.9.1756903304224; 
 Wed, 03 Sep 2025 05:41:44 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61ded4749aesm7642394a12.32.2025.09.03.05.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:41:43 -0700 (PDT)
Message-ID: <0336b502-4259-40ff-a5f7-ea11933ab5fe@linaro.org>
Date: Wed, 3 Sep 2025 14:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] accel/hvf: Restrict ARM specific fields of
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> Do not expose ARM specific fields to X86 implementation,
> allowing to use the proper 'hv_vcpu_exit_t' type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 195d64dcf18..3d2be4092ef 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -59,10 +59,12 @@ extern HVFState *hvf_state;
>   
>   struct AccelCPUState {
>       hvf_vcpuid fd;
> -    void *exit;
> +#ifdef __aarch64__
> +    hv_vcpu_exit_t *exit;
>       bool vtimer_masked;
>       sigset_t unblock_ipi_mask;
>       bool guest_debug_enabled;
> +#endif
>   };
>   
>   void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,


