Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCA0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyWr-0001bd-UX; Fri, 02 May 2025 18:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyWl-0001Ql-Sa
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:06:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyWh-0003uZ-La
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:06:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so432530066b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746223594; x=1746828394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6I5wAX5STBumopkWmQ83ejgvOOzW9SpbBs3RJnq3oxs=;
 b=CDTPRerk96NL88fLtxkQKPznYp9DwRkZrXDc2plheqrItofzhb6yZx6RkRIQPyBh7b
 sIgtTUeULNZiuVY8vhYL00WTZ9efb6o6gXK4ixSFOMmgmNwCNGoTuBJu/24ur86hX8X3
 BaMa/wKgV35QDj09mbOUVdfG8pmWBGg59gW+Mhhvr8UlZF+zrKngujI+ElqT7eddRHp2
 cUi0lEsENkSkEpsF30SEsOVaK0gFWkrY/uoLK8ciZXB3XhVuD79ZEUxdSFIXtJhYF7BK
 T/JkP06vfOmuf8KkCBImhGWXh9FyOQhuPTCSqxbEdcdbozhFEGj0hMznkseUaaoJwOIi
 1S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746223594; x=1746828394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6I5wAX5STBumopkWmQ83ejgvOOzW9SpbBs3RJnq3oxs=;
 b=gZVqf74cIcN7Bh5GEL1UwerfZ76OKZm70aKnUzhCdNifrMvHhsLrl95inTCcxOSpWC
 MHrfeHUcPAuog/zgKwG+TGsRlORooSuJVPpyBNoKjZzzFpLJXZoPPxfgWgtF31jqD4nq
 TgpIFEZ2IykP8NKvpmJ0H5sFxJWzCcB3FP555hb+TwWJoLv0BNPfayszhUH1yo/3loNb
 S0Tf8fhMWOyYIxlbOIsc4LSjicy4DcUJPKJbp3+40W4R7m2R9F8/TOqQRIBR66dA1HyS
 DpjCy7s8odHd1GSYYyt8BWTajxMvVwOiuLvfe3jiuPQYsqzs+8mQtfSkyuNp6KllIGUE
 HqVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3wDciX7KA0XtzKSpvkcSJnF8gmrT7c9LNtIdF0aa3W/U4O/7dZ8nEHBcZa69hwO6imWg5qG1P8y/F@nongnu.org
X-Gm-Message-State: AOJu0Yy5DqvxWeJXVcboTPzTrAZXp8LFz4TJ1zbOiUUZ6i3nQ4Ef1Qaz
 AcUJVyZhbJByNwuDXzu2G6c/RdsK6nR9+mLf3daNQJj+zwA2SaKU/WvhVITtRz0=
X-Gm-Gg: ASbGncsbImpVKPfxjiH3Vq76futY0I7jDVJn85Afj3S7pnU4bwCOhzJ2z9y0hb1tjdJ
 rMH0RHBsHjjymQ8YYHyYfsBVuzWLa0rYQfcKMN+WBpKZo+xzbMKaF3OYI0AO03O2DyX5OG4LBXL
 Dc+YqSPWCVjJadcS+IRQZdDLxr2rGizkc49QjquYjoaa8hoPtlAxqo354u9pzDAhFj9Lqkj0GMf
 K4jSW5OeINjxEb7oXOXgOefUy8xpKDBFHEOdYn4fIeFnow7S/1VYpmCWSanTQ5JXruqdUiVLO5u
 fDCeqitUe/cN0ytX+0Zvc0egB+fUGuPv4eGNy3ACMzXZJLPw7x+glwGkPVPGax8gZxw6SJRsbKm
 vpnIZivDt
X-Google-Smtp-Source: AGHT+IGZMJcQQ0/qwFcEb4hHPYOMHukcoGopD4hWuim+PO1Wa+xsCRMaW3nGFU0IFoqwk0UqyLmNUg==
X-Received: by 2002:a17:907:9494:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad17adfa159mr459216766b.31.1746223593520; 
 Fri, 02 May 2025 15:06:33 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c01c9sm105502566b.105.2025.05.02.15.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 15:06:33 -0700 (PDT)
Message-ID: <e2ca43dd-a1ba-4eba-ac17-1e0ac0d42fbc@linaro.org>
Date: Sat, 3 May 2025 00:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] monitor: don't wake up qmp_dispatcher_co coroutine
 upon cleanup
To: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, den@virtuozzo.com,
 qemu-block <qemu-block@nongnu.org>
References: <20250502214729.928380-1-andrey.drobyshev@virtuozzo.com>
 <20250502214729.928380-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502214729.928380-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/5/25 23:47, andrey.drobyshev@virtuozzo.com wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Since the commit 3e6bed61 ("monitor: cleanup detection of qmp_dispatcher_co
> shutting down"), coroutine pointer qmp_dispatcher_co is set to NULL upon
> cleanup.  If a QMP command is sent after monitor_cleanup() (e.g. after
> shutdown), this may lead to SEGFAULT on aio_co_wake(NULL).
> 
> As mentioned in the comment inside monitor_cleanup(), the intention is to
> allow incoming requests while shutting down, but simply leave them
> without any response.  Let's do exactly that, and if qmp_dispatcher_co
> coroutine pointer has already been set to NULL, let's simply skip the
> aio_co_wake() part.
> 

Cc: qemu-stable@nongnu.org

> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   monitor/qmp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 2f46cf9e49..cb99a12d94 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -356,7 +356,8 @@ void qmp_dispatcher_co_wake(void)
>       /* Write request before reading qmp_dispatcher_co_busy.  */
>       smp_mb__before_rmw();
>   
> -    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
> +    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true) &&
> +            qatomic_read(&qmp_dispatcher_co)) {
>           aio_co_wake(qmp_dispatcher_co);
>       }
>   }


