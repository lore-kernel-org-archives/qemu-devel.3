Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F983C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiB3-0007zu-7O; Thu, 29 May 2025 14:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiB0-0007zB-Ut
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:40:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiAz-00046Q-AC
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:40:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso1040219b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544022; x=1749148822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJkeEQzGnH65tVX6U19CmFXWiHNyn7Q0wXLW/YY2zTU=;
 b=xjeSclF9i0ZE4K8mddpIE8HXpg+RRPan10sUmp2GfqDeB3BBIG+206XI5LLFkHOE6W
 Zb+/VwkzO/VHwa7BHqjMZzWNMfpG/lH4xuQ1J+1XfrryWDsXmxVtKX4cLFP/t+abPvrU
 rMAnFX/8mZFTvVOP11B7aJdN3+p0rjafy2Fa6WSCBwezOYGkkqavHGVnpAlzpcoCpQbQ
 sMQhJ9Qm4OIKSrLzFkHalUQ1PDZpA43zEMwmA8GQj/TQBHhcKXSKN8x3nxnSYXlH7McZ
 yTCvKW711MC/vjnUufUuCmnzmzAN8KtC/5MrU5wBXDwdWz0ufOhrp4143C+f9fn5Ouxs
 jGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544022; x=1749148822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJkeEQzGnH65tVX6U19CmFXWiHNyn7Q0wXLW/YY2zTU=;
 b=ATFfrcvHKGCeGDuxZmB4NHqS9SUYvlslt5JI6dMuSA1vq8Kwt/Zp0vkMFEbitmhqMZ
 t6wBuLJANPynhdwHIEm+ruxECxBF65UNbTjQKciuJZjKdV6T4p6Umhqgg3cFBxLm5bLU
 8uJyEas77tfz9m3d+/qltSPxA4w6YQPXYDdnAQtoPVlvMZLKlHuEOj5SKjJw/6bgHiuP
 kwjdJNCzqmHBdR8YAR+Inh6eN7R+rJsRzucti6LAiBwfbcUKVkvD8PpgTqLVJc3W3CrS
 PKDm5tmp+i8tBrhS0GHcKSx93JwAxbOykQmZar2eZ8avwnDfZirXUO2RIwTHaTmloOng
 X+iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3kI42iRHMgMcvDhiXQUM7YBXfj6dqjs8k++ViTcwFllMqynpSwHY/+E6d9rUidSR5I8HM9Suaja1V@nongnu.org
X-Gm-Message-State: AOJu0YwUaymMQe1z35sWgPFhsutBUa7c+Id6+N7dD3A7pIV+MFNUXwD8
 u9DKwwRYeYBVnOag0t0FdN4mQKepZp/Xbbt+JivbNf18eAZqlqqX7C+x8ydkOzz1iiE=
X-Gm-Gg: ASbGnctXnx9XnaGCgYM5XjerhT7JMduL9xmWnHXJfgylPkw7386jX9Hk4+Ase8/SB5l
 6mR6ZsaIMhWqzJkTDqTODkHzSwxXlQ/NxxiBLx4iX4ggkIw22uanpubW9PnqMHG6QZOfk/kmUXP
 aMagLVXsBhEBJONHbf7ZyC0CVdd/cvLfd39OlwYPwJzEPixi7jPPyz6Dse+nnHbJN0nA5UghLlg
 ps8YvD+Bx5VKH+Rl4zB3mEBJ1Voq5CiTK3G+d9TuQRRP6nUuK9DapC6rUiUTHQyGU6xk9WeuKU+
 kAzEqy8o7UOsWVRYnu6zw7BfmxmLkSBiP3ASozTUiA+fFpa7ceOE3vzL8dqENlwy
X-Google-Smtp-Source: AGHT+IFQATXr6agSB7wd9OEK4hQgzMqfYWhYhXJ2KQ3Fv60KJjBz6aAjK2Afw+E9+qMHmAEMBxETgg==
X-Received: by 2002:a05:6a00:1392:b0:736:32d2:aa8e with SMTP id
 d2e1a72fcca58-747bd970cd2mr559813b3a.6.1748544022434; 
 Thu, 29 May 2025 11:40:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcfa19sm1691434b3a.132.2025.05.29.11.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:40:21 -0700 (PDT)
Message-ID: <47f7d567-d0eb-483e-90fb-4868fa481406@linaro.org>
Date: Thu, 29 May 2025 11:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-2-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-2-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch exposes the gdb_write_register function from
> gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
> plugins to write register contents.
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   gdbstub/gdbstub.c      |  2 +-
>   include/exec/gdbstub.h | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


