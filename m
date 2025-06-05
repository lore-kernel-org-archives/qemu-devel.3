Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469BEC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 20:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHaQ-0006ar-Mx; Thu, 05 Jun 2025 16:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNHaP-0006WY-8x
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:53:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNHaI-0000ls-R1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:53:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so1924119b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749156788; x=1749761588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCiC08QgAOdvHZ+FpduSbEpvSp/FB4ZBP3zDc4S0xWk=;
 b=JIKU3KmXx0d/6UNWuMDAlInv0yguIBTDL+6DOCET0dVDebl7F6emw2xrLJnx2S4pGy
 p4CJ84xqme7v2FBsiwtYMZhzUsAx4LsIOGxAG6YA2JnPWnvkyw2qCM0cDmGIRqbQwJuu
 caNstIntz3fBSIdpSqE3r0CEJvdI1AD5JLU+qzctwKeSpH0d6ZJ/E/EyzZVfQbb/C88h
 a6arebFf+u3xwmYHeVBHYREJdrpjx2A1N9A2mivBTKX0u+AhGqoZxw7JLBpoAZZhFLYU
 ukLQsoL7SKfIgWKM9V3lIwHNvG2MD72yFDBSwaso8xShtQyssC43dMfHexUgfZbjiGjU
 j1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749156788; x=1749761588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCiC08QgAOdvHZ+FpduSbEpvSp/FB4ZBP3zDc4S0xWk=;
 b=a83etSyLkAfw3IK0X5f9WKtptVjO+fS3b02d+cAZw0ECek/LwYXB47Adqt6aksJP01
 j6fh6Uray55VcEaUqr16jBb2gur+dAh/d7eIHGmtf5hy4PT+55VTymCREw2Lfaxmaj6x
 N63vLoU9ZPVQwgP0uXzRWu7AgDeIK8by7T3YMNzsTZu7cGsS2fb3IXw9d7K0eN86ohh0
 MyReyLjmI6TyMUA7uX1rv//dTel1t1btavT/F/vtan419/ZNpZzhV1K+tZUzYDhgEUNI
 SB9DOm53b9nMkGAzZunr42h/a1+8X2b2N8sq9cFAi6mZ3ZO5Ow+pR9oHM5IWjxhXrQ84
 K53A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlQkEJsrcF19Hsha/0ONYfT6f/BJxuBQMCPc9C2/jIuFkKaS9uRcJUoMBXST0h0NHXyJ66dET0cYow@nongnu.org
X-Gm-Message-State: AOJu0YwyebnjBZvLvaLzJMsp/FFRAzWgtlR4shhQK5+ruOQt3FzRmtqV
 D3fySnKfKYY64a8keilVV8bdEgD2NMR3GGIaMqWjtiE2f9vE2jRox59cjipNxldAnxk=
X-Gm-Gg: ASbGncsLegrQGcX3AMxFU75TNxjGKzqGbq/H9S72fnupwPMvDNjeVQNNDQj9/Aglju/
 YgEc0qrYx69RW26FhXIExJa1GE9rYVaQO6aHOvhRi9FoIBjvJ/Pt/Jxc5qOKBebS42pb4CVHPrV
 VKNALl93mF+7O5mOuU4pEAfzAeh9KOXwJCzXiyKtiDP7VFnO3E3yXP9lG5ygBrp2DenfBcslkE1
 Ur7FjFSjV2ELV0nrP1Y+DJYTk4xIWBCxAvSYZhYWNgV+jy/L31cJt7nxbwNN1voCnranHB1Vwc4
 TqVjul1xUT1y5MJVDJDI7tb3iP3Yb0IC5E8BsrBJ2YW6ZwKa0gU+8Tu26kSfDE6d1P3d4cCBfyE
 pxS5wVlyYBg==
X-Google-Smtp-Source: AGHT+IGgMmdv6SjFtkC7X0EFbFSxS0Cofc4RsOmEfNs6FBqUn/hqIpxtBmUXlBTgLtXEiQ9c0ncWWQ==
X-Received: by 2002:a05:6a20:ac43:b0:21c:fbf0:21bb with SMTP id
 adf61e73a8af0-21ee68cbf59mr895784637.24.1749156788241; 
 Thu, 05 Jun 2025 13:53:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2f5f892f57sm107720a12.66.2025.06.05.13.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 13:53:07 -0700 (PDT)
Message-ID: <7832d31a-2707-4cc4-9838-f2ea4b6b2cea@linaro.org>
Date: Thu, 5 Jun 2025 13:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/unit/test-char: Avoid using g_alloca()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
 <20250605193540.59874-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250605193540.59874-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/25 12:35 PM, Philippe Mathieu-Daudé wrote:
> Do not use g_alloca(), simply allocate the CharBackend
> structure on the stack.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-char.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index 60a843b79d9..f30a39f61ff 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -993,7 +993,7 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
>       struct sockaddr_in other;
>       SocketIdleData d = { 0, };
>       Chardev *chr;
> -    CharBackend *be;
> +    CharBackend stack_be, *be = &stack_be;
>       socklen_t alen = sizeof(other);
>       int ret;
>       char buf[10];
> @@ -1009,7 +1009,6 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
>           chr = qemu_chr_new("client", tmp, NULL);
>           g_assert_nonnull(chr);
>   
> -        be = g_alloca(sizeof(CharBackend));
>           qemu_chr_fe_init(be, chr, &error_abort);
>       }
>   

Would that be more simple to declare the variable, and use &be in the 
function code?

