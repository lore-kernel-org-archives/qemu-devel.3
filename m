Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E5CD35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rug-00028k-P5; Wed, 01 Apr 2026 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rua-000287-3x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:30:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ruY-0006Vz-A8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:30:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso59667295e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035851; x=1775640651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMG+FntkdIELFXVpo7cezJB8xPuEOV9NMoPuxOwyzWo=;
 b=iVsV4C971HFwOtFjhV6Db92QhtKkgoZRruzG/z+eKluP9LIljpkUFi6y9ZZgzGqjF6
 Ocr8lmZP7zRe+zeYoIM/TAfTfYSrfAs3uuCYT/AIyycujs4Z5PQSJzHO4KAAtkjr8gsW
 CosmGijP2Lc5mbEPYsxNXbIOcClnyThQD899jekOv8YAystXvTy9pzjHvkM7nssDFZpg
 W3OOjQZeW1EnJb62L3IrZ4Ph2BZZXVhJG5tRgVZEiwoZqZXTucWXh64NN5CO+adDysdj
 s1Wq3KPiKjgnI8Z4aBrwuiuA5QKjNrwIUL/cQngEubQsetv/fbJ0QyEyJQzRr/PEhmI3
 7eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035851; x=1775640651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMG+FntkdIELFXVpo7cezJB8xPuEOV9NMoPuxOwyzWo=;
 b=kBX/QiAkCUTkoabjvP6JIC5dVwQHVl9XIzRJeq4AUfkdPrOtvaY5ZfHY6NtFGww4pS
 kLF3Cp94o30cMYvDkCB3p0h4Kd7Ku6JjxN5Ah6XRT+VRgwMs7eQ6v8HrIrZS3F8uMCpK
 KtpWRz9GXU1erlxpHIgz90NArD8tu9TOqB9HPzlubvnJFY4TdLfTTwavf/3RHKIxNqKD
 aXGtI4dpubwSlmUmJb9GPHW/Fqn2Im8hPOt/EQoO/iuav8k8Js8McJbYqrgLTCONkerc
 1lwXZNaYPnS81a5yZ9RcYoosZ0+XPjdmX9PV1yOtkUEKJseKIEZjq41BQCbgPLzcMh27
 7O+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU20BIpFMSTmu2GcL7EQVVfC7LnD2zk11PJaAdyXyfPCGIb+Mx09Uqo1zXSJS97+NWWHxkxM67B6Nx5@nongnu.org
X-Gm-Message-State: AOJu0YwvTf+6BVYjQoXCKWNx+pJEkxbFD1oaetP6408U/QuV36ugK5eb
 Po0PN2C+UHfu2YIHqyvDm0mxEsOR/y+OCsC/zgqR/l1qU81zKFIdv4d+q2LV+iP8H7/w6Y9Rxrx
 FdZkAvF0=
X-Gm-Gg: ATEYQzzaFPDbnK63ggucKqeMfG9L3JHvf46+koICAaDPY28aEINVVmw4F292EGzfzD5
 8n0yEXxOE0Xh2c0/cI3zQIYgmnQbYmtyEPT6PoFuPf9Z4siQrgRbKotSybwVeL2EoWfXdEZ+8Ta
 /4H344F5yLDfKh6TziniO/4pA35Ei3hB3zVXy7JzBzPM2kJU689IWBUbrAzKcGoZs4T4SEBbT8u
 G1NS4lWre7e+tx/kVrBFzmXWmW6byUI8tO+AUAnDsSi9HR5GI6i9sWHacH6idk/pFp3mjMkPayl
 OxPFhecVf+HS+mfyoYOS6I+xyyKOvZERyUsFzf63u+6KAROaP6a10IXCQ2BmHOnUitFZ/n7/lUe
 HsWeJErbyEAPebKUiB+/yv0zEh1kznbe8bAUsR0b+2lJrc+Yn/3XsRpuYA6I+OSEbPRt6ZuWtC/
 0POOLWoUFFGwXqxA0VQnrYdpB22J3FPz6Ft3l6ehBDe8RCE5psoiQvwvWZ+ANzyH6vYQ==
X-Received: by 2002:a05:600c:c494:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-488835712e5mr43658785e9.12.1775035851046; 
 Wed, 01 Apr 2026 02:30:51 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c760320sm63542325e9.3.2026.04.01.02.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:30:50 -0700 (PDT)
Message-ID: <13bfd7c0-d80c-4082-a6a6-085d463b40d9@linaro.org>
Date: Wed, 1 Apr 2026 11:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/60] util: move datadir.c from system/
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-36-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-36-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> The datadir module provides general-purpose data file lookup
> utilities that are not specific to system emulation. Move it
> to util/ so it can be reused more broadly.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   {system => util}/datadir.c | 0
>   system/meson.build         | 1 -
>   system/trace-events        | 1 -
>   util/meson.build           | 1 +
>   util/trace-events          | 3 +++
>   5 files changed, 4 insertions(+), 2 deletions(-)


> diff --git a/util/meson.build b/util/meson.build
> index 33132c04ad6..cd56fe2ffe4 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -30,6 +30,7 @@ util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
>   if glib_has_gslice
>     util_ss.add(files('qtree.c'))
>   endif
> +util_ss.add(files('datadir.c'))

Should we add under 'if have_system' or 'if not have_user'?

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


