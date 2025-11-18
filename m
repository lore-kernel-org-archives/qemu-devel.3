Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FECED265
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIWe-00011L-4R; Tue, 18 Nov 2025 05:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIWZ-0000zz-MI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIWW-0004yE-La
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763460079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=29zAR+6wZoFqw3VujwdmfW0E40cUYtZwbIaE5zSg3XA=;
 b=VUleWvMfJygcoLYTGAO3uwYza/QWypbvalf5Qt4C9dgTZy7xNMX1YFO/hTm2LE3z78hGPX
 2RqvM4TursKZhiQm4wP3ZICmjyZ8TV7ZKRt5YuWYcMW4aIUnnDbmXsKtwmZZC6VEIIcehq
 HENgiHieGpN4/Xr3f9+TP1Hj/trxQq4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-ZaM2GbvUOfSPuiLHZhylOA-1; Tue, 18 Nov 2025 05:01:08 -0500
X-MC-Unique: ZaM2GbvUOfSPuiLHZhylOA-1
X-Mimecast-MFC-AGG-ID: ZaM2GbvUOfSPuiLHZhylOA_1763460068
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso41288635e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763460067; x=1764064867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=29zAR+6wZoFqw3VujwdmfW0E40cUYtZwbIaE5zSg3XA=;
 b=SUHsd+SevpKLUCZTvr7HIwAqecK/PqOdf0MJRrPxDErRZLZ4U4svZ7X0Mue0z63TVa
 DOqm9tSbk1nAKcp8BwNPGAZbW9+nLqJChPE5LwLoSEt8yRvRUfqgi6eOM07rjtffHFd3
 rQzreygMCnUcJ4yfjOuy3eyj67lX2WWljtC9+Hhfs1BnVVWPaIOHAGwGvVF2v+hhbA4f
 u67CE8ApL0iSnG947jkGcqt1kEl82aUW/oq1h6KBUiJGxFMbGKyC9y6ADEX1iyaIwjNU
 z8mnsXgxpfKUGeYXI6OxtNb/Iy7ZnungzBOYzPxkdb/FYLwndJ6+Nl8LV4eCAWoJsACW
 0VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763460067; x=1764064867;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29zAR+6wZoFqw3VujwdmfW0E40cUYtZwbIaE5zSg3XA=;
 b=YbNyRHAU68ZJ8wiJjWjsz4CwSh/Whh2X4IX9QKB8/oVyTU+gH8z9lMlg9d/IUubKhn
 Njh8wUK+gyxQpxsWkdtNlC1bTKUfZsrPkQBt8prJCwnaK02xd+fAG2DsMgmunxAHt7ot
 bfiWf9U1tLsDHpUFjf9FfKO6AekMGebult+l7fejsYCCwYXWJMAbtlKjWj4subNFI1oJ
 sGnDbbVr1Mi1whm/tb2V1/fbOraynGSsFUhrF/3ZzePh6jPyvs7qYHw+E6lWCru+LNZI
 h1VSe4O2w9h9OwhWN0vwnGy5PqzuMiiBQ69/xxoAtR7rrPsRMY9p95PZnn/o5obX0MZD
 zMAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhC4P+fllXrKWtb0MbZx14HVy7A7pFk2jd5OQoO/IgT1y+HCoDg1QcfYXzfjTwXMN1/iMpgApIQgVx@nongnu.org
X-Gm-Message-State: AOJu0YySxgRp3lYv1IajZ6ZDlmOkqAxmBkWC/jtCxc21p9z4XjhlplWA
 TiyNHwaJgsZUaKQ8aFjH1X6xJsCfUGIGD3FajYJZNDEOX0DLBKNk7jtT6oKJNcqbtpujmQB6ani
 bbtt+6rlVzanwhfUbNFJkQiqHlJMGBz1hzVOzyMTJ+Kg/P4yWzS6TbDwX
X-Gm-Gg: ASbGncuNTqz5I/1DzZp1Sb1xHBSTdRyc+pxTRWxT/R/CnCSYHzPgBYzLdVY3yk1W/OI
 v6VGM66ZZPxbpmuxTvYOX07m0hCk1y9U4Etaxr2U48qf9hwjUclnufh6sbQPhId6Wt2LG0W5gNf
 XS48PtIySnB7VsLrs+mVWGYKGNAOSqGUY1n46Nt+hedf63swTETWM+MAntfAJG5BfXMF8LGlWl9
 9WPL6kZr2LCQI/tOzhK9lT8eke7peDxc7IO2T76OC0e1F73AllMRO1V4HYRkk9FZoVZqTFUuIn0
 41aCFjpBjCE/oeN6l3DHSCFuUfXOw5DigepCG6a8PGS+TN2qyvqXaHjo9utEpDg7UQFZX8s9sd+
 2zqiWs3I=
X-Received: by 2002:a05:600c:3b12:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4778fe89ed9mr125068345e9.28.1763460067304; 
 Tue, 18 Nov 2025 02:01:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDaeWFfvgwjp5dW0cpggFL0dvHQhLH6tabLIrepWjL3S24GuG3ONF5BiTALtJM31R7JP40sA==
X-Received: by 2002:a05:600c:3b12:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4778fe89ed9mr125067945e9.28.1763460066632; 
 Tue, 18 Nov 2025 02:01:06 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de4631sm12652385e9.7.2025.11.18.02.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 02:01:06 -0800 (PST)
Message-ID: <e0da46f7-7fc9-4487-b6ec-3f6fc460559d@redhat.com>
Date: Tue, 18 Nov 2025 11:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] python/mkvenv: rename 'testdeps' to 'functests'
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-7-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-7-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> pygdbmi is only needed for functional tests and not tests in general; to
> prepare for more universally required test dependencies, rename this
> dependency group "functests" instead.
> 
> In other words: we promise that "make check" will run offline in an
> isolated environment, but we do not make the same promises for
> functional tests, which require an internet connection.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml        | 2 +-
>   tests/Makefile.include | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 1657953ff65..d814bb54d08 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,6 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>   sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
> -[testdeps]
> +[functests]
>   "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d4dfbf3716d..6f86eb283d3 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>   
>   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>   	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< testdeps
> +	$(MKVENV_ENSUREGROUP) $< functests
>   	$(call quiet-command, touch $@)
>   
>   check-venv: $(TESTS_VENV_TOKEN)

I'd maybe merge this with the next patch. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


