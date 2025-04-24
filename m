Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B088C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85AP-0004ns-7e; Thu, 24 Apr 2025 18:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85AM-0004nR-Tk
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:35:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85AL-0002gA-1p
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:35:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227a8cdd241so21794045ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534131; x=1746138931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Os+Gyuq7L5F4/sLliHZ9QVemvTCQAuQZxRmqlbQ/7Gw=;
 b=ARs2mZ7PMVtElFJF9H9Bxu5uYPlHXPgpGld3oTqlZCvRet8DyaMMbyaK70jC4yZEUB
 w9wL0KCtRBFxiMZC4GiMvQnnvqwD4Jew2X/UazsxDdvjJPPf2xCUaYcKJNLoMyQtHkRd
 MAY/Inv2/ovptwTCL0+E2N1pLaoqhHIa6YLZRw2X7DijgLIXSbHxrHsvlvYOOIvJ8Sdh
 9LpIF5jessVKxmxY/gNI5SiazW4Co7Twj9OLqnCh+2KxI7rGzZZTAmFLYJU+mlmaWstL
 lU87L2ztzuKm/3q+7segWEfTN/Ai/Tq9SNaUAbAJJmMjqge6ByZ6BwV62GlCmReh0uKH
 pudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534131; x=1746138931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Os+Gyuq7L5F4/sLliHZ9QVemvTCQAuQZxRmqlbQ/7Gw=;
 b=M4LxgGhxeWFiyD+V/LWh+vF9dW/MKZmP4EDUDKoXZacGsKgz+FViC9/eq36gesoray
 Zid3wVs4QaBGOYAqqVx7kzxS+zZvkH8Q5BRC2E7qTsBIB8XaR5VWt9wlj8u78g/sMmKL
 8esru3qfPpU+P1C0/7eHTbs/rqBSSBmHgGTfEzDCBdV3BmdrFg1qBtkj7KIRmq9Qn4MJ
 RXTDvCipTnW1kDjKj2tU1c10HOPc7V1CPr0sRtidZqlfXC6FtAboNweoIkVEEaNknUgp
 2Sgklb8bZIjiqpisojfd6ZC/IEd06VBLp/bOiIyhcDsRJo5ZV8i40+UvH0SIa6OhqmP2
 /hRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX33Z4Jg6kH7WUn7w5w6uqSKTOC7xHkHTyArZ7bcv7yhqrGAa/RWGVl5+Bk0itMdILhdjPiaSA54ksR@nongnu.org
X-Gm-Message-State: AOJu0YwZbFLhxnhR4wM3PIVYP2jyJAThycwv01jPEH5i6LyUuaB+pJOG
 643JL5N8k6YQHdJQfybiSd2uemY/6U6Ub1k4w3JNhJ6/0rFj1tU4F6MqdkE2ho8=
X-Gm-Gg: ASbGncv1vPOKF2y5OPQBLbSpUfkA1rIUgNbi7P8PEq3fJIp7Zb2Z9BxzJizMNU92CMo
 hdBGNYdpk+FuemzXiryXX+zZDRKcnavtf++9qqnIOq2t0AAuXWDkjOuUls74J2q0vX7gqFI28UR
 rnCLiILFBU19GCxqsr0+4Z98mB+h9cHhmWOcK1LOpjtjuHkBjTy6Pl8mjAwLau5YxwEcgdynNBk
 2QwyUMGcMfOflvwTTFt7egtMJU+JK9vmSHg3tGKzny7fKl331WU5yNZEaxGlPCju1GESy5j0Q3z
 QmOk2+Zdk+AiQKllTuubXDs0XBxW2Qbl3Nf7HfHOsarzsnOwiXxTR9SeNTpimWR0
X-Google-Smtp-Source: AGHT+IELxS/o0xGI26zpnTOAaHcFSkWg06N4ksaYprUUsLnU7dzrYeQpOKH2hcVoMgwoTPTG6xueiw==
X-Received: by 2002:a17:902:cec3:b0:224:1609:a747 with SMTP id
 d9443c01a7336-22dbf5f11ffmr541555ad.31.1745534131542; 
 Thu, 24 Apr 2025 15:35:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76e21sm19141775ad.45.2025.04.24.15.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:35:31 -0700 (PDT)
Message-ID: <b9d5b3fa-44bd-4ecd-ab71-9085ffee3717@linaro.org>
Date: Thu, 24 Apr 2025 15:35:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
> will be available on qemu-system-arm and qemu-system-aarch64
> binaries.
> 
> One defined with DEFINE_MACHINE_AARCH64() will only be available
> in the qemu-system-aarch64 binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/machines-qom.h | 13 +++++++++++++
>   target/arm/machine.c          | 12 ++++++++++++
>   2 files changed, 25 insertions(+)
> 

I won't block this change as we need to move on, but I still consider we 
do a bad compromise between code readability/grepability, to avoid a 
code size increase of +0.0005%.
Anyway, we can always change that later when adding a second architecture.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

