Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B99CF6ABB
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmfC-0005Rb-W7; Thu, 08 Jan 2026 04:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmfB-0005RI-Pl
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmfA-00039o-4q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ze3vpZ2b4SmHIOIleYpU5/AWnZrUK/Yj48Co88KXJy4=;
 b=MacQekwE4K2TOE9tz3dJ5Z2DLfnJLXeIE5Cp1YU/IHerylQhXpO3hXSkoWd1zCk/+PRNua
 pFDPITv3Uo8lJlt3ap5POGVpoqteibzxkxYgYHH1EO37OQ8UDgmK2vqpufIU5ZLYdWT163
 7gBPdJ1pejvrcG0rkfC5UzLJZBj98ls=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-CXDpb2xXPGi6FPKUipdjyg-1; Thu, 08 Jan 2026 04:50:36 -0500
X-MC-Unique: CXDpb2xXPGi6FPKUipdjyg-1
X-Mimecast-MFC-AGG-ID: CXDpb2xXPGi6FPKUipdjyg_1767865836
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so20959285e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865835; x=1768470635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ze3vpZ2b4SmHIOIleYpU5/AWnZrUK/Yj48Co88KXJy4=;
 b=krzRnTKAk2cObQsIkZa+4K5qfA9NrLjMOtC1vIWABzvXp7N8jX3AyL/7zpxIQSroyZ
 tu1fyCPSvHmu4OI4N2vW5+83Ne50AQrGtkaA+mA6q3OlicSe9fTRPVy3vFJJZThXgLEs
 vrlXsxHF6TtvRWSStLmQTXoEMucZQzWz24e0Wv2wXXjFFn7DB3Sq0234lDURb2ymhRDp
 r8BmPgeN9KooodJHo6wDF83AgMHDYZXFEcuWhvEr2772qvCy23RblZXvh8p4YG5v/VmJ
 3f2IwKvkhYRBRfPfRbzZgEpeJBctCrDrRSXXXOGdMZq9xUNZte6UO4OzK1Ziuv2xs/Xr
 VHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865835; x=1768470635;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ze3vpZ2b4SmHIOIleYpU5/AWnZrUK/Yj48Co88KXJy4=;
 b=X4RtPfR9Pv8Uydz921Ev+PO7GUkV/M/L3P/Ir1mDESeGlXIWFpHGtyFYARkhUyzvPl
 Imny3PRNZxn7Zw59rEpVu0gmaRCS/Q+Dznuq9VIRV+YlBFwM3A896XbG9uWu0nMRMF87
 hQqmfYimN4xD4HQNwcB2Ot5oLh5aj/al5pM1HfQTPYtIheWJdhmCD/eOrUOciKxGvfKs
 ybnxu3yWBt/R6rN7mEuGp9azaXc24I7ndeOMdNGfjtcEURC59DelgQoFcLB4MGrBfK4l
 nRjJ4qyUz44nr9rWNFoOzEK0vQwG5pC+Jzxqh4Y+kYQJINxh7IagQDjCen7WMthOmZhO
 8S4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5OZE5dmpAvu2DFtVB4pW3dzvGdbLTb411InjoA5uJMqftRRY+CUN222PM9gTtFVEG9zRYw49GdWU6@nongnu.org
X-Gm-Message-State: AOJu0YzGueL/V4lVsTgekCI7wSfx1VgKQXOt+WGQOdwb+vrY0FQ3t7sh
 LUez+rWUm6KRnhC09ehV6uKUswBh7QO3Xa5Uwah2s5dSUQ+hbhIpeB2rfb3UXqLlj5Dpdsotnnw
 c80i7bWAjedXgmCBkXpay1VJ5Hr3oqmDa/mlmAmy2IWRBUfIWC7vg7hqE
X-Gm-Gg: AY/fxX6kYq1VCL6FYj49X7A+He/nNWsoUKvnLfrCXTIYF1PMULrLB78xI/tG02ppobh
 N+OPkT4vTzeKodFAGwiFLprs4/xcLlcnmI8yU2surg4b+AeUXA6gzWGwX+qnwGkKl/YO16mA5/Z
 iX4TZTFVsQqfltIC7Oi19Qqa5rByqzjSrgWQQSU0i4nn9F1YTxRNUSTtJfsM6qW/u9Txculc3fv
 GGwtKzDgEQoxx2APoGEKqBdFpfjEjg/ydY+is3kWzMmJhH//wXIsLEsMxHPP61ns/3RjSniCFdU
 2hpre+4DtW8oMvmvDhJ8Nm1UYxmIJTOSgytV/is1pBa+avqZBOAWdqJJT9K+N2IVYoovwxXN3vC
 h518a2Q0=
X-Received: by 2002:a05:600c:b86:b0:47a:7aa0:175a with SMTP id
 5b1f17b1804b1-47d84b3bc85mr61028165e9.26.1767865835517; 
 Thu, 08 Jan 2026 01:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY/LQNdNaO9dy3Kq0ZLjBQK8JizEOJK1ehBd1qEeocPWukLTpQVhXWbUgMLSBn7Mf2ECQbXg==
X-Received: by 2002:a05:600c:b86:b0:47a:7aa0:175a with SMTP id
 5b1f17b1804b1-47d84b3bc85mr61027985e9.26.1767865835165; 
 Thu, 08 Jan 2026 01:50:35 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm142813935e9.9.2026.01.08.01.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:50:34 -0800 (PST)
Message-ID: <fe780bfb-11f4-46f6-a40b-4aa5e233f88d@redhat.com>
Date: Thu, 8 Jan 2026 10:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] meson: Remove cpu == x86 tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-9-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> The 32-bit x86 host is no longer supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure   | 16 +---------------
>   meson.build | 49 ++++++++++---------------------------------------
>   2 files changed, 11 insertions(+), 54 deletions(-)
> 
> diff --git a/configure b/configure
> index 00e455be57..846fab904e 100755
> --- a/configure
> +++ b/configure
> @@ -440,13 +440,6 @@ case "$cpu" in
>       linux_arch=arm64
>       ;;
>   
> -  i386|i486|i586|i686)
> -    cpu="i386"
> -    host_arch=i386
> -    linux_arch=x86
> -    CPU_CFLAGS="-m32"
> -    ;;

Ah, it's removed here, please forget my previous related comment about this 
in an earlier partch!

> @@ -300,9 +296,7 @@ else
>   endif
>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>   
> -if cpu == 'x86'
> -  xen_targets = ['i386-softmmu']
> -elif cpu == 'x86_64'
> +if cpu == 'x86_64'
>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']

I wonder whether we should limit xen_targets to x86_64-softmmu now?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


