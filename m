Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00342D1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4pD-0004ST-Ew; Thu, 04 Dec 2025 03:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4p9-0004OE-Ps
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:36:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4p5-0005oC-FJ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:36:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a637712so4334625e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837380; x=1765442180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qbaNuUJoxnLp5UuJm1FetAdlBppY0buDxjeYV7iD0I=;
 b=WfovtJcPJal8Qu6Pgm3868uELhV9rve61opFnEoZVAvlkdjUpRIF/QP1aNNy6G2eJR
 JbLEUtPjkLyj1GgdPTeUpmlN6yN5ASSZgXEitfehFvVQt/H4lAoY89V6r23oWYWknFSL
 FQ5EGa9BR9iBU7JqSgpLf9o71ou+IAlHhyuKCAxlCN/1lPAzfJnLhV6qu0bcKStzjxWa
 tOt1PMNWd+hpOWuBjXFtTgKZJmOqQWZX5PeWx3AwBTfacplhMmkxv+Vne/sjIdRYSoN2
 ahSaiVGE3nPaZQ7B6h3FmhM0JIwbSlbSWZNWJs5LM0jXejWyYqbQYj71yr3XswySAVMb
 l8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837380; x=1765442180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qbaNuUJoxnLp5UuJm1FetAdlBppY0buDxjeYV7iD0I=;
 b=rDvTKAZ4w110QH6OPsBnGUpeVm2Gmw5bx3zi3w1JFcaq5alr+l3UEk2bQ743v+qKBO
 XmDD9G6i7kqq5Y5FwHnZTKzPH1l26ZQjHgH5JvqiUoGer/XxsvJ1G/AheMRIC7KCwXQ0
 PYUgh4IHJJj3tXl6jEOh0bZeEnucPBYsqetTqOyhLpGQxyERYCz4sjqAKiwrpY647IKv
 hFcLxVu4qdr37XYtwjJmu9QVlKtW3TpAwaOv62Vs+JsS9NzuCuhlaOf8Fq7l5116O4B1
 ezzRRs9QqRwypII3bx97IHG8X+tJ5+ofvvjvzfdPmQW5/vfee6jBxU06xL/2dxjr43xq
 K1qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZaC0kgnSupquwGjC38lDiEDHL3Z8jxviRvFou0EVheD2SQM9gsy7FOIZN92ta08rtqYEr+qPNHEQ@nongnu.org
X-Gm-Message-State: AOJu0YyKKI7Hb4dVHSfBCOyqLcN2jFfa1EpRi8f50o+XG54P4Fv8u91k
 xMpTiM8IKRyacrJJGpUCTjPYEV/n+ntknz/jftZ0n+UROvSGVetPXNoFaXOlXWxgFtw=
X-Gm-Gg: ASbGncvJCen/Ba1lFDTmCKtOJP2/aNxCbnz0tUChB8NbUpMlZf0dy0uuFCtiSqgUNq7
 Gpl5epuD8LbJBbmf+gqYSSed0cNx6AMe2XpeqGsd71Dv0J6LeY1pab5d7z2FwCp87jSSY01bQAR
 3+LB4quZ0VhPxq762Rn48CgoBO1b+2LWl9vd/wA+Qe44yAHelJJOWeMZ5T6+z8DZJr3eM+iPijS
 yB+kDKkfZa/2sIlm1+qQrQir8uEMgHb5W18LjPbkolPBBNjQSa5SmCiS8ln+j7dQqO9sgM0r3Qn
 3vaIbg4p03lwNlwIFAD4qoeKd+ZtIIOO85LH+vXzzNJjo25CgV4TKcIDN/iQge1LkJI+PtDvS5G
 7lIpLCpFP0MeH9qXQ1iz62lapwc3AvqBHg9dTD2byT5GpFxgaBpNdM+PZIdfGFexA1VbOPKzoPf
 ECvZrTMRwOF/0LIp8BETGND+VPG8QKEa6gc/SumT9DJBlUEsFV2iYZgQ==
X-Google-Smtp-Source: AGHT+IE01N4AmrPgLANR2KQurNwLqi0gHGvH8Gl+ovcKyE6fFmV53e/9TE66APLHAUHAUle4QoCvcw==
X-Received: by 2002:a05:600c:a49:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-4792aef4202mr46318865e9.14.1764837379501; 
 Thu, 04 Dec 2025 00:36:19 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930f286f4sm18433505e9.0.2025.12.04.00.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:36:19 -0800 (PST)
Message-ID: <754c984d-9082-49eb-8538-23e746d6a126@linaro.org>
Date: Thu, 4 Dec 2025 09:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] block: rename block/aio-wait.h to qemu/aio-wait.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203185133.2458207-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/12/25 19:51, Paolo Bonzini wrote:
> AIO_WAIT_WHILE is used even outside the block layer; move the header file
> out of block/ just like the implementation is in util/.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS                        | 2 +-
>   include/block/block-io.h           | 2 +-
>   include/{block => qemu}/aio-wait.h | 0
>   block/io.c                         | 2 +-
>   blockjob.c                         | 2 +-
>   io/channel.c                       | 2 +-
>   job.c                              | 2 +-
>   net/colo-compare.c                 | 2 +-
>   net/filter-mirror.c                | 2 +-
>   util/aio-wait.c                    | 2 +-
>   util/vhost-user-server.c           | 2 +-
>   hw/display/apple-gfx-mmio.m        | 2 +-
>   hw/display/apple-gfx.m             | 2 +-
>   13 files changed, 12 insertions(+), 12 deletions(-)
>   rename include/{block => qemu}/aio-wait.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


