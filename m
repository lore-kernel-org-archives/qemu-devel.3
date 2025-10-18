Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0F8CCD199
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 00:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9uTZ-0005kj-Vz; Fri, 17 Oct 2025 20:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uTW-0005kI-0c
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 20:07:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uTT-0001O1-PO
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 20:07:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-290ac2ef203so23865645ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760746024; x=1761350824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tj1LiYHZT5JfE4Xte3L5EfRaaL/qpnGtsyvSNv5aynA=;
 b=eSM4Vx/WPnikbiwHuB3VRMccQu0HIYL78Tfx9GD2H52KQhWV1jIwBg3J/v6l3hmSyG
 Anl2UnABoa8/ckyha7S6LFOVrwWC85H674taNnef4VEo95ErMxqEk7dJTdeXm7GoCdvs
 W75hT3p8myHJvCl94wOGrtPpqjc9kLIqtdk/IphmERvx2vp9jhDgGrRaV90Dkbn9ZhAe
 gp9NK1P8NSDe5P6x3NmrmHqZ9F67BnMvaJYy25n9u4DL6ltGCPnygEdCQZDxavbYuRmJ
 vEtRCAjYKohCA5qnP449/iTkoa1aeyMB6pQnb5/QDUndxArb7+CZzegOV7oT5LUc42pU
 8Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760746024; x=1761350824;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tj1LiYHZT5JfE4Xte3L5EfRaaL/qpnGtsyvSNv5aynA=;
 b=X+DKTOqgkxinogf9/6cVkclVrUNIC2aoWWMpOprwliE+D354jKhUm6Bloo7maSHv2X
 BoBKecZ7AVNvWlD/nn9FzEUOHWqGKwaMbVb8Pli42jcN4sAY1luDTO3h4ge3n8hQWwer
 mfD9d/GjA4K5YnbtIQTofC1hb8idLt5QUxWVPq0vDXhSauDAECcJBZGAA7U3OtzifWfC
 2cu23wxl0s1zwo0WOb9F1v4t3StV1Rib0OyppI7SD3SinVtHHOjFd9lAumVghvQpEJ9W
 Lpb37V95pWoAT8twft/bP3cyuVEDgZ58EQ7HqpYQ0hmJeui3UCYKDNO21QAPHkmCLCJf
 9gfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmoRcNlyc4K01VTwPlbsM2jwGd99WYZNlAr1aBkjs2r6iaZfP3lSN3JkiN/SSrMl/ogK2QHYjDn55I@nongnu.org
X-Gm-Message-State: AOJu0YxesBDNYVuETKWP3o026Zj4vP/TQN8cFG4KcJuLOcv29WXhAXxc
 FSAnXQ/27LS72VvlINdfrntBEz+Yb7yYE7JT0xx7sV7IQ4dDtzCA+h4gvSucStgc5ow=
X-Gm-Gg: ASbGncsnfc54CvL5lWc4LALP0JmcgWdQm1ZMS0p4i8PWRZq6mbTm5nXaXE1YLM5a8fq
 1B9VmVX9DQbhXbggyNGGXOzFHZPHRop3u6uwrsSKF7LZOiVq/gB5RzQuBlKerj6JuwEaghWR2At
 0FIardA++fv9KXA2blx35t7SeiAMjYhJlU9yk09DABlvBAGAHV7LPgmOHv3bF8+KPox/piRV5xo
 yZAw9MYo/sBGS17la8dUbDsDZ06JqB8HuRWCBhA5JVI2D5jr6K2tHCy46f9cUloPux8r6ae1JB7
 /hM3UiDLcGPtYwi4ctM6a9TT0AqhUWaUj5lvRXMMftZsor1W32xQCr6t2nwXGmhvYVcEN6emDGD
 0weINQO7/bd9+GkKp7hlfHYbQ045sDDekKDVu3o9H0oTc0szfPY13FuZtPi0y4N4Gx5xMWRB1Od
 Vcw0MPGGsGnO26Bw==
X-Google-Smtp-Source: AGHT+IFy1wuLj/VcH6k/86y3hTNQs22Vis63lgfA91sUtONqRb57rU2KGZd8TDRwkmRNkkCZtykx9A==
X-Received: by 2002:a17:903:1a0e:b0:28d:c790:43d0 with SMTP id
 d9443c01a7336-290ca30e417mr62934035ad.29.1760746024136; 
 Fri, 17 Oct 2025 17:07:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721936fsm7418545ad.114.2025.10.17.17.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 17:07:03 -0700 (PDT)
Message-ID: <971171ba-0fe4-46c8-8332-2a0089f679e3@linaro.org>
Date: Fri, 17 Oct 2025 17:07:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gdbstub: Fix %s formatting
To: Sean Anderson <sean.anderson@linux.dev>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Luc Michel <lmichel@kalray.eu>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-2-sean.anderson@linux.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017213529.998267-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/17/25 14:35, Sean Anderson wrote:
> The format string for %s has two format characters. This causes it to
> emit strings like "466f5bd8/6x" instead of "466f5bd8/6". GDB detects
> this and returns EIO, causing all open File I/O calls to fail.
> 
> Fixes: 0820a075af ("gdbstub: Adjust gdb_do_syscall to only use uint32_t and uint64_t")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   gdbstub/syscalls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
> index e855df21ab..d8bb90cc1c 100644
> --- a/gdbstub/syscalls.c
> +++ b/gdbstub/syscalls.c
> @@ -127,7 +127,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
>               case 's':
>                   i64 = va_arg(va, uint64_t);
>                   i32 = va_arg(va, uint32_t);
> -                p += snprintf(p, p_end - p, "%" PRIx64 "/%x" PRIx32, i64, i32);
> +                p += snprintf(p, p_end - p, "%" PRIx64 "/%" PRIx32, i64, i32);
>                   break;
>               default:
>               bad_format:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

