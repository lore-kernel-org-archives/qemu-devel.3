Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4890DCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 17:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlVb-0005Mw-Lr; Thu, 11 Sep 2025 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlVZ-0005MJ-UJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 13:54:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlVX-0002nk-96
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 13:54:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b9814efbcso13396905e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613293; x=1758218093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4fZ/9QqHXu8FqDihK5BYhyQm3L4rooWmFDgTijRZT78=;
 b=ZywC7CDOtOrgSAtIaMMr+5PpQZo9pgTNeWFr3WQ6+VDGQfIu7MDjtFFHi7872doID2
 yXtrU2KkbTuwlRNXBvdRIWpkja7lVIQSqgICTzyDiHlI5hbXjfzrmA90PfdJlBooIFh8
 UaMmZ2GDgR1hVwLUgKxEEKoCTsgNruLyqH/OUeSiVPPos6VStdF2O2kHWAcYOgJR9jqF
 IIhQ5dSLIm1f3sVJC3NBb0FzZ950eI4O7n/XJrwz71zb/Pt1qdF1RQXKmS7Dh56il2tO
 I+Sgz8Cf806DZ1a4SMeA5GPhve59LsWU2YkwKZsG7ykPEWysMVBIbqTe7smlegNLIKdl
 +TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613293; x=1758218093;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fZ/9QqHXu8FqDihK5BYhyQm3L4rooWmFDgTijRZT78=;
 b=tVuEl7i2rygi6Rz4n8deQ4D3ZYlLQ95RWOTFpl6EnRg5C1t144/qIUm0VvWDw0NC9h
 oe977hf0qUt4i0zVH9JvSUXAG35cb7YMsG/Okl4HTEDTs/O7BdG/+0Fi4w24UrgSNAHZ
 9/HhmwA8jSU90OIhJrvNsJ9wmbc8hBMo14CcNqGEAptOHZeeeePeFA25C4HF5LLbqE6T
 zWJFHspQBRqrtrwtNY6js9tEh01gDjQq0/OiXmTVcveTUI7mFDgAdXhJahlq4DaImWlp
 oEQ+HIYNwXhL3WcM/QfKyCycC0xY4tqJx1aKMuIbOOnI1AgAM0DNNIPrnyemawGnSyUo
 4TvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKEGEZHsEoGSeqy6e3zUwJrH8v0jVY4VuD43DdRk9q07ngPmFgMxhpZsTWnOtiuH00rnadAE3uPXSD@nongnu.org
X-Gm-Message-State: AOJu0Yzrlp24Ww6ComkD5Wdeabq4SY/0uM30FW+ZT9NWAmBJJuiQIpmp
 EMnF9BqU/AZgD3XyAffA6fUx0Ow5AO/wEATj3EDB62z/xtOG5fBq+9hybo/zfZ/IAw4=
X-Gm-Gg: ASbGnctam5ipaS+gdAZl3ZzFnrhYaliDA+zvdTugT77H0QQkiSFSOzyniJEAEthVpPV
 1Dt4pMrarCg4+pzWC/qe/NRzssldTNo8+oGQXDvmfD/IvzvuntsP8v749cvn4E+lWurlYxvS843
 ytbbAUvBxxjebDcTXCsqmFFXhdL5l0Yyr/YSJeZRwKEUZyyQpEtk21NjoCs3LVBVkPuc9VH4SrQ
 YhKRzTvY2Avk9kNMbXKd+/YclRiiD/bSKuYjJHnM2n9ZbQZHMIRibTbc1HuXy9/PT0sW/eSJgsH
 ebwIeg/F5MlQS+0glKeihWxfmEZUNP0tCxtiZJcldVNg/8BN2D7DGnUtbAN25YJS62KaWvFWZRW
 aP92xP/+/yI4dGAkXkvJEuJc2bTFy4E3GQA4kvsfTTCfMNDwvREqkUYoJSQFI6yv6bOufYgw/Nb
 xv6VM=
X-Google-Smtp-Source: AGHT+IHAaQttwreIB52eMBd0/THiqwsLwLJ614D0Le4lxlr3w25MtAZ2JjctwG5dUSU+71q3+8lDqA==
X-Received: by 2002:a05:6000:2003:b0:3de:e787:5d8c with SMTP id
 ffacd0b85a97d-3e75e1071bdmr3926316f8f.13.1757613293496; 
 Thu, 11 Sep 2025 10:54:53 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7654e484esm277710f8f.25.2025.09.11.10.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 10:54:53 -0700 (PDT)
Message-ID: <74df1365-b9d7-448d-9edd-4a25b8dbf6a2@linaro.org>
Date: Thu, 11 Sep 2025 17:54:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] ui/vnc: remove use of error_printf_unless_qmp()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-10-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> The error_printf_unless_qmp() will print to the monitor if the current
> one is HMP, if it is QMP nothing will be printed, otherwise stderr
> will be used.
> 
> This scenario is easily handled by checking !monitor_cur_is_qmp() and
> then calling the error_printf() function.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 68ca4a68e7..439d586358 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3530,8 +3530,10 @@ int vnc_display_password(const char *id, const char *password)
>           return -EINVAL;
>       }
>       if (vd->auth == VNC_AUTH_NONE) {
> -        error_printf_unless_qmp("If you want use passwords please enable "
> -                                "password auth using '-vnc ${dpy},password'.\n");
> +        if (!monitor_cur_is_qmp()) {
> +            error_printf("If you want use passwords please enable "
> +                         "password auth using '-vnc ${dpy},password'.\n");
> +        }
>           return -EINVAL;
>       }
>   
> @@ -3570,9 +3572,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
>           qapi_free_SocketAddress(addr);
>           return;
>       }
> -    error_printf_unless_qmp("VNC server running on %s:%s\n",
> -                            addr->u.inet.host,
> -                            addr->u.inet.port);
> +    if (!monitor_cur_is_qmp()) {
> +        error_printf("VNC server running on %s:%s\n",
> +                     addr->u.inet.host,
> +                     addr->u.inet.port);
> +    }
>       qapi_free_SocketAddress(addr);
>   }
>   

With monitor_cur_hmp, you can use monitor_printf directly.


r~

