Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CEEC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOuud-0002cv-E9; Wed, 03 Jul 2024 04:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOuua-0002bU-Ap
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOuuW-0001My-5H
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719993612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DEZdYIm9olD/MdcaNkCyv3NOsZHan6cFct5CLv7TgBU=;
 b=OKUpfTHT0rE2st+UG6pOuh4ePJtGKowb1mJF8dSH0ZkyxsUHSzPf5jYRo1M3gHs8SdFvFp
 /p+EeaMNGvYyPaayDfo7U3YDpYbv+IS4tXFsk4d8o8hz9JQHxbpmtFg9ahymCdKt3TfnpI
 q+MG5YewLDu0A3xUJk9w2I4XP3i2hAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ySJhK6SbPOaN8-HLJcyzJA-1; Wed, 03 Jul 2024 04:00:11 -0400
X-MC-Unique: ySJhK6SbPOaN8-HLJcyzJA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso25653285e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719993609; x=1720598409;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEZdYIm9olD/MdcaNkCyv3NOsZHan6cFct5CLv7TgBU=;
 b=X+Qq3ddxt36IjJEFq//8qUibx2Hs5YccAvkZuK0WQFNYSd8ruiwLO+Xba3XzrD6LhF
 CjYXkHKlwOIEQMApu1Yi+EDJsGuatQJ/+m9m0h1OR8f6n7mrWJdOOVtwS0LPvMSdgknY
 sIYTOgpx+WoLwT6t16BfPAq68dqQcBGiwXorbRDvFv3vSrx4MoWG8ddHTfAqH91de9nJ
 L6xVmKVONwt/mUOC/1FNJXOguzwpDN8/t3JyRJYcPm6Z2pbDH3PA3aMtzKD/66CsYVqq
 Q8rwMhGqIkUKzlCCtBnU73b+Mg0R8EAMu2Epbx6S7yuxBvcQniq96An33vlpAVgAYobQ
 iDxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3XqbEsPSHRrap2vvjjIXpsU52zgt0DkKgNLXAbX0JQLsZIMAc7HMVLvMWdFWLUjkljJQhbwNdxXX4ncMew6pTkCYm8VI=
X-Gm-Message-State: AOJu0YzBhEeS+dKDdaoQUUDwOQvy4vP6Lcq77adLYqXk+BzK5vDWgxdM
 BFJ2cZEVuw81d6pVvMXgLVGCT8QWa5BHZ86K/swt3jvtmH02JoOYLbUpLzR5cMvXV6JnUU+OZ0v
 59rXwc+9+gdgZOLUJTc5kz+lrKbqSCqTU/dwffYwQAr7PMstp8OJwoUzScpjr
X-Received: by 2002:a05:600c:3542:b0:425:77ad:93cb with SMTP id
 5b1f17b1804b1-4257a009c1cmr69064015e9.2.1719993609451; 
 Wed, 03 Jul 2024 01:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZTueTUMaV6igmaE1x4p+Bgex8VdCKr33q7D4gKjG9WH9dD6yVQGg2TgRe/9IXSJmLe/eyxg==
X-Received: by 2002:a05:600c:3542:b0:425:77ad:93cb with SMTP id
 5b1f17b1804b1-4257a009c1cmr69063855e9.2.1719993609045; 
 Wed, 03 Jul 2024 01:00:09 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b677sm224939935e9.18.2024.07.03.01.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:00:08 -0700 (PDT)
Message-ID: <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
Date: Wed, 3 Jul 2024 10:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20240702195903.204007-1-jsnow@redhat.com>
 <20240702195903.204007-2-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240702195903.204007-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/2/24 21:59, John Snow wrote:
> With RHEL 8 support retired (It's been two years today since RHEL 9
> came out), our very oldest build platform version of Sphinx is now
> 3.4.3; and keeping backwards compatibility for versions as old as v1.6
> when using domain extensions is a lot of work we don't need to do.

Technically that's unrelated: thanks to your venv work, :) builds on 
RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because it 
runs under Python 3.6.  Therefore the version included in RHEL 8 does 
not matter for picking the minimum supported Sphinx version.

> Debian 11: v3.4.3 (QEMU support ends 2024-07-xx)

Nice. :)

> diff --git a/pythondeps.toml b/pythondeps.toml
> index 9c16602d303..bc656376caa 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -23,7 +23,7 @@ meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
>   
>   [docs]
>   # Please keep the installed versions in sync with docs/requirements.txt
> -sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
> +sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
>   
>   [avocado]

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


