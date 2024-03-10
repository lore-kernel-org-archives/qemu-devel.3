Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F941C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 14:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjJt7-0007yo-4H; Sun, 10 Mar 2024 10:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjJt4-0007ya-Kg
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 10:10:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjJsz-0004Wa-MA
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 10:10:50 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso3703551a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710079843; x=1710684643; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5aJgfiwLS4lEoCfT7DlAT39Mgy1LwmxYtfwl8u9ZmXE=;
 b=NFF2UdeqBMjOc9E/3lEwlD7T/M+/VdvNWLAan9OYrO2ZwwPudOMwtLiEA7RcP1V7Fk
 crFrzSf5s5h2T/14IWYMuOURDropWIoDjAylqfaFpaIjCai8QG1C0pZDqL14k0dClpPw
 JRqMjWIY7aaLXBECdMz7Pf/I2DUQDQSf7QP5M+J3fPlFrhufMs/oIzNSgMjZbh3T5f2Y
 XPHPQn90m2TEd5n1rTJ8nOnu/EogkQ66DSj3UlddNbHZQhznZLbyhftFIHv3VR3AXLM1
 zWu0ZNHBuZNqeO03iu6M0zb6TOhpl6DvSQuWeygfWHvSaO+Ha5NY/uzelEjlBbJJSKAZ
 wYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710079843; x=1710684643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aJgfiwLS4lEoCfT7DlAT39Mgy1LwmxYtfwl8u9ZmXE=;
 b=bS16mPIh39fbdwaRIZyKsAxyE/qGMwqQ9ziyoBU7GH216mgDdxg8v+PH93H5QiMkF/
 t3BIYQSUXIB0T7aNT5O0TapRyQ7q07rbRtgoNlVaIi+vv6G8QOZyJT138f4c/seWfTDM
 +MqBa4oQS7DX6XMhU5PW300B+1cJciRKlcw3r/wzFwN0z56GTfsELHMv5MTrFDKMWoKE
 bEWEsVuCfiik4DBnAPo0rR+bwsxIqHbUHLvXFIhYKd2Vf1ybVZTNO9pi4Ei5bpziQpId
 15utTXNyMx/D2ggKU4us+WFkjNBYivlkWrEnRlujXu+Vfh9SuLIEJjk68NIrkCjuMjCT
 ehSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS/pUq7+biZHHValb6Phf9kTyrkwVaSTEXPKdYE6tMFG72/zo62AsM69sx4krFSLkdbIwZRr+IWVvU1KvsjRXfMmc1Q4c=
X-Gm-Message-State: AOJu0YysQmVjiVlG+mPlXulVGuKORMnmjTohfjFo01mgkQoQze2vmXVP
 u6mR/3XE4XoY2LoIulkaHVQgZmjK9Y9urRddazCbq4pMiuxSgPGiLIvMYmAH/BY2CjSSQt2tSgY
 UKjWXes76arAkf9hWHpys5MgmV98I1vw1VL5gUg==
X-Google-Smtp-Source: AGHT+IEL8+tQ+fg+muPf9bdxCrFdXGvAw0+9KbHRljQx4uD/nQ48GPLkOADC8AWhnDwz7nFR5b07bepu4d7+NHcx+rs=
X-Received: by 2002:a50:ab1e:0:b0:565:ff64:33b0 with SMTP id
 s30-20020a50ab1e000000b00565ff6433b0mr2578638edc.22.1710079843242; Sun, 10
 Mar 2024 07:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
 <ZeYNQdqW2bBA4gNL@redhat.com>
 <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
 <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
In-Reply-To: <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Mar 2024 14:10:31 +0000
Message-ID: <CAFEAcA8Ooah-iCup=MOaqzr4UK47qwJqFwLNWHibN54KTLbh0Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 9 Mar 2024 at 17:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 5 Mar 2024 at 10:39, Thomas Huth <thuth@redhat.com> wrote:
> > Ok, while I was writing my mail, I was looking at https://brew.sh/ and
> > didn't see a link to a bug tracker there ... but now I realized that they
> > are simply using the github tracker, so I went ahead and filed a bug there:
> >
> >   https://github.com/Homebrew/brew/issues/16823
> >
> > Let's see how it goes...
>
> Seems to be going slowly.

...but they've just rolled out the glib 2.80 version, so our
CI job is passing again now. Yay!

-- PMM

