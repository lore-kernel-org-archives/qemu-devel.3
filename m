Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CC3E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNtzK-0007RQ-KT; Wed, 18 Dec 2024 08:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNtz8-0007Qa-Jw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:21:08 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNtz2-0006h7-SV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:21:06 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso5694800b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734528057; x=1735132857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wd0XUmjdcfVtYA54yQSjmI0QoTn/5+Ke86U4Hn/dNFA=;
 b=vx5wkR6X6SyaVYn/Gnf82U6uiXdCWE17qmZXJZe2nfafi7pIb5oK454QWTlfbNfUm1
 g0EYMJ6zLoh5byTYACW+b0mKcQl7ANxPLb96IYM8gI+Ua7p4UPmelBgO53JRp8emOpyu
 aMJ4zGLg4Vg7mUrbhnVggnDmk68orbSGyvnnweSBi+jQaxUnRbWYRpGKIXqVrv5pL2yG
 9nVAHVbmyalbNQV0zhuUtGH4rXKdETf5tRkL6JrhixDsPwUDmaQrh85r2XEYvLLGbHIt
 BfTuMor6mh22iL2a6ZEkMkeLW3bw1ZTif5Fj9VdBDTsenbFj4CHdtONx8X1XMc0MvAgh
 QZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734528057; x=1735132857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wd0XUmjdcfVtYA54yQSjmI0QoTn/5+Ke86U4Hn/dNFA=;
 b=ZOKEIdX/zpq3Xe1NbjlZDXES9VOa+5p8WZYEDY2Ahoexs2eiI6EAmpprOMwQHlSvhf
 kib/8ftf51rcGREKl+Gi95infHCASBVbJL7+vMgP7wykR/TtwAC6NqYkvLNU9AS3lE+u
 P8FMcH2wpzhxZNJOJmAEvM1wfROWOYCvX0PKc0WwSaH1ZDEQyk8R6MEUZiu1Wgb+c/31
 5BT+Q3iOgfLWLro2b9HfSDoi0fVfKOLjRAuKFIJ36GGExRrdwSShCn0epzgSc3IS/5ZW
 37n0dchEC6q9F+V0d11xmeyb80lU+Vn7D6VW7fkXGGirEa0kcQPlGx29qY9H3D1L/hvH
 L9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVksEQdIwBZbkYu88oJ8yIVM5q67/KfgFRjTGN+rDG2lHHHhp3buTozbBcCaC7016z2xbvXpwCq38Nx@nongnu.org
X-Gm-Message-State: AOJu0YwKXSGEob9/loyjInL07jywcy+D0pBx3WMMhJQG0rpfiGyTDm7O
 bZD35VcUbHBz6D0LeonbVmArKGhk5P2AHTs0NdWqH/I6FeM7M1VIm/iP4KGXIkGhLBOcWZ1RScH
 r
X-Gm-Gg: ASbGncusU1QyMT5Zygx1ilOXYiyaZdVCPoH1lIIZZbURNWnO7AeMKXU7bTSYy7rcpXB
 jap9k++1964LFoGI/oroiJl83iSRfSW9bw57gFYZmWA6eArMNHO1hrRJbMMqC9HOFQTWpZSefLd
 nupDJBaYj8F4PHeJtNjbFe2+kxUfLAxuwRL65FraAj7r2hQ8yt4ZN8AxpBDyu9HFT2s4ZbXxbGC
 mYTOWlMojmaT18QC9IGxXkMzbOtj/u/gL6WmXF5neqcO1qoRb3nF4w4Pbu5TVpG9uOxnkgB
X-Google-Smtp-Source: AGHT+IEPvmtgjiT8ozC3Dx6MOPjjEcKSpvjkOl8tP8XcJDKiM8JMWNEH9XzAMJWVDpyHUtXI61TDNQ==
X-Received: by 2002:a05:6a21:3985:b0:1e1:a716:316a with SMTP id
 adf61e73a8af0-1e5b47fc5a5mr4771348637.10.1734528057189; 
 Wed, 18 Dec 2024 05:20:57 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ad8f34sm8502173b3a.77.2024.12.18.05.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:20:56 -0800 (PST)
Message-ID: <d6eb56fd-47d6-4271-a62f-7d6a4feae2b3@linaro.org>
Date: Wed, 18 Dec 2024 14:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] rust: pl011: simplify handling of the FIFO enabled
 bit in LCR
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/12/24 18:22, Paolo Bonzini wrote:
> Use ==/!= instead of going through bool and xor.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 6 ++----
>   rust/hw/char/pl011/src/lib.rs    | 6 ------
>   2 files changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


