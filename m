Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2085FFEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57Gt-00047K-CI; Tue, 24 Mar 2026 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w57Gr-000454-HC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:18:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w57Gp-00030G-Py
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:18:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-487035181a7so24318435e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774379910; x=1774984710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9ybZ6sHf7peVthVZMHJacmFgu+y7QATdzWCq7QjAmE=;
 b=CnLP9AYHC7SZdLP234GjX1mE8RCrwixFWKrglxftnrJPN4x9DYkurM5AyIk+ejj2VY
 CZFKMBK0yKgYsp/yLwc1mgM4Fz9ncNLWa3y8A3WBA1B8uHIQm+Hufc0HGitNBn+zEpJD
 XX1vO1IwPtdJkGvsW7acSmZs8Vfrzd8iZ/jpdDC0wIvdtG100Gb4WXEyjBCJ3NdnsXgC
 uafv6g+mejQTRDIIoWZS+MB1X0V4M/oWcDeK5Ud1e9EO410LrzZtZru3/pgUZbbWVaCI
 O99r6J99gPOsVksmQ3jpOG+tyBTCFO1VLW8wLMYZNmduFJvVTjJzbiAJPJhnGep1NWWs
 E9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774379910; x=1774984710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9ybZ6sHf7peVthVZMHJacmFgu+y7QATdzWCq7QjAmE=;
 b=PrSPc6Ihm6p+gpTZWEcDfN8PFTqbxz4pMxUc4CQiuRsAYQegbnTJq8QEgaKpE7FH03
 IidRZGUn831MRbFkBnGAP77n6Qdm3y/4lJpxbQV7k2lnLY9+iWp4JbG71PKLyMoqZ8eJ
 jh3nNcoqa5j6aWP6kfoYu+uvnhBX264k8nbYR4DIvY0r4AVObbns+U88nsULHxVzTxPx
 NICQfcdBbxzBTPMDSNgiIq8ckW3VOkGO/5e7BePKdQN86uvgqF8AispsIDGcmNwUY9Zo
 Z0iTe2iz3iWdkRfSGZHRdi8YougpNii10bDq5Cuavg1GwgdF9oCqEb6SIY9tcvFxw2nJ
 ayrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXliRYfIgtaHxB/NNne3A38i5BZjbElkGIsvxr78+zBMGvOHe9iHKiDJTTN3/4cB3noDKuxxELZzSIQ@nongnu.org
X-Gm-Message-State: AOJu0Yx/8ho70w1O7tsqmvNSRKpoCWit3iS1YS4Pp3p4oIafX+K2M6OM
 8eFEbc417TAASJw/4Ci/1u2EpWRUySpVbdJe4pNJkFm8jHX9l1KC9j/K6Bfkco5OUkE=
X-Gm-Gg: ATEYQzwcfji6vtHhr/cHPB+aAmURywpJYu9MaMtf8HEFoltv7POuMu/Cr1nEy+0N6po
 aKFqTgVBczgnI0OcETyyAlJVJMZrVbC+7qnIgRtJfLzZ+Pmxqj8uvcKx9x7EVt21QscxQngBDCL
 YpDT35GLvaK/8OlEvhnLupHjR9gQvZPcvY5kGo0UnArOR+3vhi/ux66y4up2I4c3Bifux79Qm45
 8P0f49FncxkPs9mBZVmiC4GEe9mlkzjDIypoY400TnwJrgxJcO5zcRonzGnaIOqReaUAg5xgY7+
 KDZ3Buk1uZTv8Sk6YrC4XwrfC/OMonYuVWQKlsC9TpeGuOy3RTJcNXd2GJWK2hxPs4i/jyLniBE
 PScUtuCAOTfTgGysNSn0nKp2gd/h3F77tmPDbPwNqEmFQ74Es10raIMC2zqoiQP745FA7yrI3aN
 +kAUv/Phn43xgiFYoCr6mFnKKbSStSOdB0G0fnQLWm+3XbFvKKnbShEL7U3Aprq7lEQQ==
X-Received: by 2002:a05:600c:630d:b0:485:3586:1e28 with SMTP id
 5b1f17b1804b1-48716034eb4mr12739625e9.18.1774379909486; 
 Tue, 24 Mar 2026 12:18:29 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711764509sm69273445e9.13.2026.03.24.12.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 12:18:28 -0700 (PDT)
Message-ID: <3768bc38-1231-4f62-9ac8-c27e8bb66e7b@linaro.org>
Date: Tue, 24 Mar 2026 20:18:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260324165705.785605-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260324165705.785605-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/3/26 17:57, Paolo Bonzini wrote:
> The version is never set on 2.5+ machine types, so qemu_hw_version() and
> qemu_set_hw_version() are not needed anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/core/boards.h  |  6 ------
>   include/qemu/hw-version.h | 15 ---------------
>   hw/ide/core.c             |  2 +-
>   hw/scsi/megasas.c         |  2 +-
>   hw/scsi/scsi-bus.c        |  2 +-
>   hw/scsi/scsi-disk.c       |  2 +-
>   system/vl.c               |  4 ----
>   target/s390x/cpu_models.c |  2 +-
>   util/osdep.c              | 12 ------------
>   9 files changed, 5 insertions(+), 42 deletions(-)


> diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
> index 730a8c904d9..a40a6c204a6 100644
> --- a/include/qemu/hw-version.h
> +++ b/include/qemu/hw-version.h
> @@ -7,21 +7,6 @@
>   #ifndef QEMU_HW_VERSION_H
>   #define QEMU_HW_VERSION_H
>   
> -/*
> - * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> - * instead of QEMU_VERSION, so setting hw_version on MachineClass
> - * is no longer mandatory.
> - *
> - * Do NOT change this string, or it will break compatibility on all
> - * machine classes that don't set hw_version.
> - */
>   #define QEMU_HW_VERSION "2.5+"

Maybe rename as QEMU_HW_VERSION_2_5P if we remove the "do not change
this string" comment.

>   
> -/* QEMU "hardware version" setting. Used to replace code that exposed
> - * QEMU_VERSION to guests in the past and need to keep compatibility.
> - * Do not use qemu_hw_version() in new code.
> - */
> -void qemu_set_hw_version(const char *);
> -const char *qemu_hw_version(void);
> -
>   #endif

