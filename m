Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F3DC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x065k-0006y0-At; Fri, 28 Aug 2026 19:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x065j-0006xC-8S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:34:35 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x065h-0000Lw-Jo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:34:35 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1567444a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787960072; x=1788564872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=prc84MyO9vdwNeb/lJuYjuYl+EAND/SJ7WeSaW69/HU=;
 b=RIDR5yfmwtYMvxSYKzevXjKEqEgs+xrZLAbl6sEa397B7RrOrXPqoHM3QC7Wv9ylTq
 1FDGf+sGpdy+WoQ2txlZ8JROIpMB/9aZjsocqe56locao/oFfJt0EmZjmtm2L3LwZAZD
 2MG+iNTG3jt9+cio0ryA4ceSXNbe6dcvD3yZPWLrleuEwKeqx5hlSYr2ZGdBKAgZQjYk
 wATmh2tg4azRvxWx7YfBgrIqNMG4HRHIs6+veHW0BH7QJ0G/1b8Swim4QxCCJceijoL9
 WyttgYUu8xBfORml6hCGNHz9oLZewYwGHgMmDoej6dzj1FJt1UjXn8KKQ+9oJfaaCyxn
 qgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787960072; x=1788564872;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=prc84MyO9vdwNeb/lJuYjuYl+EAND/SJ7WeSaW69/HU=;
 b=E0tvZze5zjzSmxJkl7lLZ/TJ5OFZZ9IZJtGi6oHHRoyuwyyPpNWEWrd6NNXZOpPw2u
 aSb3het6QlJlGYFsSTlgk8JqDxfsbPDwx1beUiKUdskim1pecYPdn2fW4Xgt5PGjZp4L
 Av094U7nlvmsm01mid6H5YVx9cRHwAHtmwNKdMJ854sCgXjmiZ2tdU1E0/dSuyQOpSev
 ug8Rib026rwDOU51gQaIFWExlYWfb8nKP0DGYkPmGZogR29yaXr2BOClXvLBa3Pfheb+
 1libB70QMju0CFr08JJ4xlTtI+lvogT6roskyrM+du6Vik93+gTJCHZPU0HtG0xqEMmQ
 /CUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMkJQetG2ljshyJzrkDZh2BREcBcmSlu6GsxGTRW0+K1qpykkxvuTOAp+d4xt7+1G8jzLUTpKS1uml@nongnu.org
X-Gm-Message-State: AFuF++mmJ9cOcpDnD+m4G3pW0RDPifRokdYaTg/7UReppTK49wno09ib
 GTWFiHQizxuKGWgZAjJKmWCDWXURRbVO0pZdYQ5XXgBxMYPTjMBSBSGscDRei+6R14hOV+bKi0Z
 akhJZQ20=
X-Gm-Gg: AYBFou3bXy8UO90cYB2zfoH5rbSAD++X7AnAZeo+TnBgc0CHhalJ75UvnYhA13siO4G
 tdg0HUT8JYTTDRMStbiP5tdN5TpKCkNS8H47rWia2ebdG5jU7KGjASz+4kR0CslSJprofLkLfbg
 FzUauODMcjqhz9REiMWW5ejEf+ptXoyt7dWeIafUIWsf29HAjLuozcrW/al+xkFnG3RwY9tasex
 lTJJP9Y6H+BsbGcFh674Tf4PeirO8YVyN7p3Wce5RP74udzcTCY80UnnrVkzDGL84ug2RebKVQu
 G1AMGdD77FMFiGIroH6GaAoWNaty4S1Zgh99N1isHPkPBsL/zbHvqCYBSv4FpyR/WRw8DHlxPKe
 OvKRyyTBBJg8Qp7dcbK9q9nlx2VLULjUr2tNu85/ykwMUOUWzEjGu+Q4Jfz3VVEB/50YC/55iDQ
 koADa6a2f72sV4e9bTpTKr+jIinQSgalDYXp+Zs965GsFPAyePEzpYOB/Ng2xFMjLIJxcVkk7eJ
 vBfm/IKgPA1U//qFyEPis/AACJgRWk=
X-Received: by 2002:a17:90b:2d8d:b0:398:9beb:5c16 with SMTP id
 98e67ed59e1d1-3989beb6368mr4705725a91.17.1787960071658; 
 Fri, 28 Aug 2026 16:34:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc0c703sm4405730a91.9.2026.08.28.16.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:34:31 -0700 (PDT)
Message-ID: <1eb50526-a875-4be1-8ae6-5059ebc9ffad@linaro.org>
Date: Fri, 28 Aug 2026 16:34:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] random fixes (gitlab, tests, char-fe, mailmap,
 deprecations)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/28/26 05:13, Alex Bennée wrote:
> The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:
> 
>    tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.1-random-updates-280826-1
> 
> for you to fetch changes up to 485509e033d8d4fc3f408e02de205fad960e1d02:
> 
>    mailmap: map the last From-munged author back to a real identity (2026-08-28 11:40:08 +0100)
> 
> ----------------------------------------------------------------
> some random fixes (gitlab, tests, char-fe, mailmap, deprecations):
> 
>   - use .base_meson_job_template for macOS jobs
>   - use explicit cflags for arm system tests
>   - add arm-softmmu tests to MacOS
>   - implement qemu_chr_fe_backend_name
>   - deprecate virtio-crypto
>   - mailmap updates

Applied, thanks.

r~

