Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AC2C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmeK-0001E1-KL; Thu, 13 Mar 2025 13:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsme3-00019m-6M
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:47:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsme0-0003c9-O1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:46:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224171d6826so31381525ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741888015; x=1742492815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6fXWDdIA88opuWNujhSyIznmheyx7fFUYwtFAofg9k=;
 b=fDCaD0wPuKjuoH+E63YpfhZ35BRDqgMf7/KRtJjSSNU6ct6jnTPS866wxlyo9AvT8m
 sXDP3Kov19ZYQCXnXsA3Zl6s/jBft5+9fZNYpFfFiZ1eQWsnPCZJne53t1H2E2NgFyB4
 bA5AiEt2NdA1W/SoUEm/H7d0STRH62u6cO4Dk6C/MjvCk3mJouClgEV4qbLRiwKWh5vU
 +SSXCRExwKZO38Ti86LzfJHONe+P9zgh5EI8KzkefyINJ0VscN0A8Y4wT93JKvKsTEg3
 DEsUAcwN/uIdo1sZmwNdkogYNbe90DHytqs8zP85wXI9c8R5odK1ix5aQ5H6i3h8QLOB
 69Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741888015; x=1742492815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6fXWDdIA88opuWNujhSyIznmheyx7fFUYwtFAofg9k=;
 b=LknpdsdNt7e/+GBCwydbzKNmHjyhu5aJfzUrhfzAU5lwCpA/nvy3bBEhMelGecNIJn
 BKLJMVqftg/KCgm507JxbYyFE+9MJ6PGjD/X/iPtsOLcKiQExG438NLweDD4ukOqvDQc
 m1cY06B56kvt2FgOTdpZe5PO0UxRAxEt1BQBeS4rgErWwCvR41skpMlpIJRkGh62+LMG
 EuRTLBsG58xhNdB9lV9DF3JeBeOL647lCPAHWyH2l86cosw0DUGWMFTIsRZlJFQrdJ8Y
 y0cxTObykX9zET4hFmdJnWw2AxTHTY0M6Fu/USKzo+tyTbAk8Y1T5kYWmGhzuJbhF13U
 w1Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzP1GnPULmvefXzfS88zkgqtUXji3aVoAbiHr/1ZwP0/+E4qdYKf9h4jC+1FB/xZYuv0aB6/2JhtD1@nongnu.org
X-Gm-Message-State: AOJu0YzAxLPA39PgG1y5Yn8LiOoHG2Q6nazn04zNNrgL4enq4fwzRe8z
 0CNThsfdPydewBR+yoDv+bdyGLDYgcvtKbcQWDSyCXQyxPLn+hxrwPUI5nqs74M=
X-Gm-Gg: ASbGncv7/NnTO1mq0u3CGeJCmvvwV2MpYG8Sm+ZjT8yQb7A40stW3l00+NVS6j9Cdpc
 m9ZMHnAy0JofD4e5GlzKzIg9QZ0rGC2UXkW3YjpAGGOfv5Bzf/pHxpcCsBlpebKwJPAapLuD8xy
 PakV4K20yJs3olwvd3E675eR//lVwKtKsw+bXhDuZi9CsYTu7MSLfp3pnPUgn92uETCQIvmFzZI
 IZLj9vLeGAdhkSXEhoLGOQvk6y1w+dRp2aEzqaTIvVXH7K71jLK/AKUUB/RAHKDDm6se1vVyp4U
 qnrdWo7cP4rvTr5+eN8KvvUNH5p+nPHg11FDDzaIuWPT0JXsjVIetGE05w==
X-Google-Smtp-Source: AGHT+IE63v0JmZGgrVuOypM1bK8PKJa+ApxXJFS4H+N2WIa5J9HlHWNCCTS/5W8HnLy4kjayra0zyA==
X-Received: by 2002:a05:6a20:ad0c:b0:1f5:8a69:f41b with SMTP id
 adf61e73a8af0-1f5bda0409dmr825939637.37.1741888015095; 
 Thu, 13 Mar 2025 10:46:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddb52sm1564774a12.19.2025.03.13.10.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:46:54 -0700 (PDT)
Message-ID: <ccb46ae9-5e94-4f9c-acad-16844c37f952@linaro.org>
Date: Thu, 13 Mar 2025 10:46:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/37] gdbstub: Move syscalls.c out of common_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> Copy to libuser_ss and libsystem_ss.
> This file uses semihosting/semihost.h, which has separate
> implementations with and without CONFIG_USER_ONLY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> index 0e8099ae9c..b25db86767 100644
> --- a/gdbstub/meson.build
> +++ b/gdbstub/meson.build
> @@ -7,15 +7,15 @@
>   # We build two versions of gdbstub, one for each mode
>   libuser_ss.add(files(
>     'gdbstub.c',
> +  'syscalls.c',
>     'user.c'
>   ))
>   
>   libsystem_ss.add(files(
>     'gdbstub.c',
> +  'syscalls.c',
>     'system.c'
>   ))
>   
> -common_ss.add(files('syscalls.c'))
> -
>   # The user-target is specialised by the guest
>   specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-target.c'))

So it fixes an existing issue if I'm correct?
Maybe there was no consequence, but definitely a hole in our build system.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


