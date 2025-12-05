Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607BD2F7C3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRRTe-0000ff-88; Fri, 05 Dec 2025 03:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRRTN-0000d8-2j
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRRTL-0007Ko-1v
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764924445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nDDrU1SXwmwYAt7aK6YCiPD4lMEuObkQAG+MQ7TqQXQ=;
 b=Z4MQvsp7JbKXhxjgAZkXbWb8TrUdX7xc+DraLX9TP7GFwarK1v+88rXDFeu4bPRl9O1ddT
 5taHQmWYlALTkcVYAe0xhjieXaYrBqIYXdx9F674DQJmPiUQvHqw/Y/zOnwwuTOnkh5rUW
 EsFHjE0z7K+gx0QH9QhrZOl7ERYcddM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-OevIdXJbOaCSbzG33ZeRPA-1; Fri, 05 Dec 2025 03:47:23 -0500
X-MC-Unique: OevIdXJbOaCSbzG33ZeRPA-1
X-Mimecast-MFC-AGG-ID: OevIdXJbOaCSbzG33ZeRPA_1764924441
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e2d6d13d1so913280f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764924441; x=1765529241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nDDrU1SXwmwYAt7aK6YCiPD4lMEuObkQAG+MQ7TqQXQ=;
 b=Ne1qXAFXidUKbXkCCvEBmJevzA3trchoAO2iJHbkEJ7OPrP0y4YO0NdWxPrZv+BvUe
 dSF2VOp8LBJbSiEeiJ2zt6a2E6Ug0ZX4BFlIJkSBZhYZZviS6ysrt8raeOYqu5+qt6uT
 o7K884nW5N+K0v/KAQVLtoscYXDlScLT/XJJkFmClj12UMI3AE+rfsH4lFmGWiucRGXl
 rRiZU70RGWMC+evTEnDZ9AHbEZir1qSv44lXDa+xjKhV0fiqNxITvFstdgojNcC/vpbN
 J4o4qIXTvhi6mBTHp8jJMlOVhRzGlFHWwKV3Loux98Sy4eW87MEl1tOqtd3I8THLxk0p
 30iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764924441; x=1765529241;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDDrU1SXwmwYAt7aK6YCiPD4lMEuObkQAG+MQ7TqQXQ=;
 b=aGQ+O6XUThYmGUkEyFfAKRlC5QEkBaH8iduM7KEDMyfPrNPeXMDgQlFT5SpAEPYFPf
 af0n7o76v7FLBn9IeJktYOqNp4n8MTvY3XroiadyRZgsnAfFnhUUCunxy4BvflK1UXsl
 IbESlO1VFpJwUorYNOGN5FOL6lSVXzChOtaIV7GPaoNE3aJUZqdeXPARcbYOruQ8giSN
 p4xwvMrDMCWaM0qA1YTaSAkjYVNEVOCm5jrzNN67+WDdiL68yOisERwW9qqRr6G9miS7
 myUm81qzGW3xLxISktrVZsg4OafKnWZ1AERlLNHcE8/KExYGmnDMADsYdsaD9ck9INEb
 5GBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpRQY3AnqXXDlF+VkMS62/UeLj4Aa7OvBD2HoMXv3kDwvON6DanjqZo7h7AN9R8jloX3rNhVbKwHJ7@nongnu.org
X-Gm-Message-State: AOJu0YzfIELO9+WqZjYap9flwnYSGpOnJs4PWIGC6v5DCoZsaXvw10Iv
 0niiA5X6tNIaXxUa6U0fR9OGhbVmeVqLtm0IIP7wlUNPag/PDY6tzo/VFv2/1hV9bxB7+YMNCXX
 MxxMfQcXiruuPMVyCQtKnUslOM8h9IVVih0ynqEhiLB0B5eMXMWKZHvZq
X-Gm-Gg: ASbGncsycefLJ4xqkwzKvo2mJdEaCt49tFq2pr3Te09dEjai8INpJnvxVkBilNZdIlm
 8nf9/RsPD+aXFRPATckQrGEsfkrQ0bBTQwVl9novLpPW72yZ1kaYnrg61vkMaB4TKoOxQYCXd1P
 JgM8edB8UChcoprw2kXdcbie7KIbC4Wr8uTWjzzkIZ6afuydK2aRL0G0tuvh8t6WVrFcamd7yaF
 6mDTcjGQxHfwuKbkKzfm4I0ux/qi5hOk8iFNqv0lswQFC04J69N7cnix+GnXP5O+cV3/vz8JA2A
 Q9JTgqSD6qDqiMDP2jC0+nK5hKq2j+qCIjbkK3Oq9GRWhKozO8kGgH1hyU42++ltL3G29G1TKu7
 9XF010T8=
X-Received: by 2002:a5d:588c:0:b0:42b:3c3e:5d2f with SMTP id
 ffacd0b85a97d-42f731f5e81mr10510219f8f.39.1764924441192; 
 Fri, 05 Dec 2025 00:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuofs0DDbj/LJfkZTm5JQ1h+zNCO0RfNAbJRn3nEKQzf9QPXy8O4+nsVt8sCnsalqllMKnaA==
X-Received: by 2002:a5d:588c:0:b0:42b:3c3e:5d2f with SMTP id
 ffacd0b85a97d-42f731f5e81mr10510172f8f.39.1764924440809; 
 Fri, 05 Dec 2025 00:47:20 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331092sm7646010f8f.30.2025.12.05.00.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 00:47:20 -0800 (PST)
Message-ID: <468c8bbf-5efe-4721-8e15-00d13436294c@redhat.com>
Date: Fri, 5 Dec 2025 09:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] python/mkvenv: add 'checktests' and 'functests'
 dependency groups
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <20251205060058.1503170-4-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251205060058.1503170-4-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 05/12/2025 07.00, John Snow wrote:
> 'checktests' contains depedencies *required* to run "make check", and as
> such, we promise that these dependencies can be sourced from the user's
> distribution repository or from vendored packages so that "make check"
> can be executed offline in an isolated build environment.
> 
> In contrast, pygdbmi is only needed for functional tests and not tests
> in general; we do not make the same offline/isolated guarantees for
> functional tests, and this dependency group is allowed to fetch
> dependencies from PyPI at runtime.
> 
> For the time being, Amend the "check-venv" target to install both
> dependency groups, to avoid a duplicate dependency between them.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml        | 10 +++++++++-
>   tests/Makefile.include |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 1657953ff65..14ceb4e7787 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,14 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>   sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
> -[testdeps]
> +# This test group is for dependencies required to run "make check"
> +# successfully, and should only include depedencies that can be
> +# guaranteed via configure from system packages, or python packages we
> +# vendor.
> +[checktests]
>   "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
> +
> +# This test group is for functional tests, and can include dependencies
> +# fetched from PyPI.
> +[functests]
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d4dfbf3716d..40b114bd158 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>   
>   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>   	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< testdeps
> +	$(MKVENV_ENSUREGROUP) $< checktests functests
>   	$(call quiet-command, touch $@)
>   
>   check-venv: $(TESTS_VENV_TOKEN)

Reviewed-by: Thomas Huth <thuth@redhat.com>


