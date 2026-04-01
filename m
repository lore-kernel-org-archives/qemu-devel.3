Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD1D35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rsh-0001bT-7F; Wed, 01 Apr 2026 05:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rsf-0001bJ-N5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:28:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rse-0005zB-5z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:28:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso68850595e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035734; x=1775640534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j2jppzSPsdlB/nMgEsoiQnULGoomvIZk8XU84d4J6Ck=;
 b=AWT1tbopOxJPoJ7e0/0nKCFgBObtjHmN/OuftqpoDZtfCHE+p+x04Nwyxff0sfxRx3
 g5MNyIVD/qS3DMCTx/n7trNUtkVn84LYDBZI7RbQgrOfejrMaEYMWrU/FuZK/Tp50scg
 vZ+/vDFQ9Jwk6xjQpLcWCQs82k6LK4vdzRYAEJJwdrBwkOYJCRgtss1opiNDDXkZRZ3C
 42M8zcx4tSm6E0deHVtlqinbAItqhMy+EMzvBnMVg6c2299QtxQ4+vq0IoDYKM9poEW7
 V8C13Qm/iFzLp619MUW4QEm9jkVrRoN9UpeGDDq6x957CLlfAPX17905N5uOZCqb32xR
 hyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035734; x=1775640534;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2jppzSPsdlB/nMgEsoiQnULGoomvIZk8XU84d4J6Ck=;
 b=B8IG6U2x3F8zDGDxe+q9IA7QcQtwjzp7JEm5l2a0nZmjabHJSjhlbao7iTH7+jN6WU
 zYCcn8jhpSCHxDCVkxg0TukQO06k5EGdEZt9kkv2mjgbKq/1wnAep2kvs77ebNM04u6y
 WFFtKodXaKbnb/fezcFGnQGCYnV/5sOzuqVMFJ9Rfl2EQzdj78yj2FOwT2eyuhb2iuHk
 tGrUrA8uzvBFhPjcN47rRnjdHkEPnveLxYHYFNrHSAohQFGE95/hHiZ4reH6YmgtWmqT
 wBF3XgdlpdYwWNidjKHRcq077a1h2Uow+6Ac3zV3wEoZtVU/+icUKUHcmT5F0p+0IS/0
 Bf3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn81UXSRpevmjGiC61/1H0RO7e8DX+BK2bwykrnp2AvbrDMra7Fx1bRi2kGhAA80ywIdJuAdTica9D@nongnu.org
X-Gm-Message-State: AOJu0Yw0/w+LMIugN6K0iLCC8ygh9sSh3a0JMMsMiRfaiQT4bgbWmViG
 LV6foWT9vJN20tMvAo15YyQWxX/SKiwJYyIU2BIdIiRoFA6Y2xjceagmqvfC5wJnmTHTD8S36eQ
 ks0bx0Ig=
X-Gm-Gg: ATEYQzz8R2qSwb3dB6WqhXLOtCLBKZ5kpmWV8LQlxd76Tf0/kPbO2WyxaQBMldybTt0
 urccGiRJVLBVzdkt+Wo9c04O6CdaxdVwDXzzbtTCyyaURjFCB+5ogo+ltaaPalIhYwQfmUCvooP
 8py+ETMs80sV5MgTVCMiLKmQrHDLewAiExgl4JY/244j0AsUWnm68mY0fAQ1THLcXIeD8mHFlK2
 Z6Knau9Z6LqdjWMY03adKM7V7Bgr2sBfjqDaCBwrI/wqXYrp9oWxa2jkID4qJyxurPDHJqR8jAJ
 awlg1ZLgPBjpcAr0/jOmpQNghkXaE7chPT+qkf8CyXuYE7d8cHFkn/HkDkyBO5qDuof97Y20xMH
 C0kAN7OhSkrzWiug7lJullnt1b7fGVKG/pdjegG+edqPWIKH+6reCYLHGiIjJ9RU4wEvzbAFyY6
 7H4zg3SGqm8ZwCgZFU50/BsJKFIyX8Faup/YPOmvkuGgfgEJd2jHbJOLMfZb6xhgrKng==
X-Received: by 2002:a05:600c:858e:b0:487:467:4276 with SMTP id
 5b1f17b1804b1-488835cd391mr34159745e9.30.1775035734059; 
 Wed, 01 Apr 2026 02:28:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8f4b77sm37313665e9.33.2026.04.01.02.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:28:53 -0700 (PDT)
Message-ID: <f9dbf62d-4c47-46cf-aaa5-9c25f4a20bb8@linaro.org>
Date: Wed, 1 Apr 2026 11:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/60] ui/console-vc: move VT100 emulation into separate
 unit
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-35-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-35-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
> Move the VT100 terminal emulation code into dedicated ui/vt100.c and
> ui/vt100.h files, completing the extraction from console-vc.c started
> in the previous patches. This makes the VT100 layer a self-contained
> module that can be reused independently of the chardev/console
> infrastructure.
> 
> The code is moved as-is, with minor coding style fixes (adding missing
> braces, fixing whitespace) applied during the move.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-priv.h     |    1 -
>   ui/vt100.h            |   92 +++++
>   ui/console-vc-stubs.c |    1 +
>   ui/console-vc.c       | 1035 +------------------------------------------------
>   ui/console.c          |    2 +
>   ui/vt100.c            |  987 ++++++++++++++++++++++++++++++++++++++++++++++
>   ui/meson.build        |    4 +-
>   7 files changed, 1086 insertions(+), 1036 deletions(-)

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

