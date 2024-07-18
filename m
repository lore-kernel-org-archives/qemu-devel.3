Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C6C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNGz-0007Ks-5y; Thu, 18 Jul 2024 05:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUNGw-0007ED-Hi
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:17:58 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUNGu-0007WN-K6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:17:58 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso592371a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721294275; x=1721899075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJak8oBmdhUdXA3BmjAjSFXS8RT7kaQMoJzrFa3m4l4=;
 b=DUN0tdD4oeBg1ATigIZnnaKrIXhdDsma7cSVUtRbTdJHmUTOhYmFLnw218ViQxYaRX
 /znmoUciZpK8EH1bqCCx0n+tYS6kiA4+HMm/mQz+IBBswz8c0zX0IREagi605GYWK3sq
 Uf4FocVeBQ6jkEts10s12RX7caxGA5DNT0lS/+EeJICqt1c3plCeqjrxSDq7WsDQCN2k
 6BUdEN0H4TKLCHZASTI7faes6Q++Tk65Mm5oQATvzknr5nAjQ/bvmBY5l0ivI6GkEA71
 gLrF0yVkll8q5JZggrjgutDzUZOdg6LxHMqm7AeYrd325W4ro9Cdj03fJV8oTmRK4oeG
 dnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721294275; x=1721899075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJak8oBmdhUdXA3BmjAjSFXS8RT7kaQMoJzrFa3m4l4=;
 b=USRhL4+KCQ6TgJVv+Co6xk0bPSByK1ufT6e7W3rc6s1ZKnTfH4HwcDONK2M0xwQeBB
 mKunHAwhYiPTex5Netvj+twQwiuu0ApvS3i+zw3djii1ncPL5OFTYiehhSnW1PxfNcdm
 RnpvS65MexpdCzC73ghhQL3Bpcxh8GH0mLXYf6nXAkSXIPHBlac5AY6zYWBbcRU9biVk
 0xW4gjhKvI8QRmuNeas6n6BMjJQi0B3euZbHGsJ/M/gTp7hpznSfAaZxY23pofgfu/TE
 8mRb6+x6hZ3lUjgXvNbaLtn5Z1JRbm5Wru7khjvewzCgJqId8e6ceEHCl5/bISyK+JKf
 mCqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRo/1kRO2uy74zyqIm3MIZhHHwPjN2z+m1q2ZVrhX9tWcCg1N36bZnJF4NOuc/JccTh6EaEsYM3m0x7DrYgUG45Y6y40=
X-Gm-Message-State: AOJu0YycfgF5RQzYhg09+ascPFH0EzIN7eF96Ka7jvZ4QqInzRWnc/VP
 v8Xc1a9z7S3JNvxtlyh7DVxayqmqGPPh2qzfzwqkifCea7zQd6rS3QL9P0vQ9J9Hgqt5PoP6oCR
 ea4ml4O6qznFLTFepyoUVk6Bg5yjfpg3Wa4Kzdw==
X-Google-Smtp-Source: AGHT+IHBLJRKFF7Idw4GmwKc0c7kqgYWDz8qgSqjwYPrOIpxXW6XF2R7OaYZIr33HariEO04kzFVzC0EG/5fp9w2ZAg=
X-Received: by 2002:a05:6402:5113:b0:58c:804a:6ee2 with SMTP id
 4fb4d7f45d1cf-5a05bdc1004mr3147148a12.20.1721294274628; Thu, 18 Jul 2024
 02:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240717201123.9742-1-vr_qemu@t-online.de>
In-Reply-To: <20240717201123.9742-1-vr_qemu@t-online.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 10:17:42 +0100
Message-ID: <CAFEAcA_ODXCwNhdqTMBQhzNV60s=oWJfPeEARAx3XQRLbLGwPA@mail.gmail.com>
Subject: Re: [PATCH] docs: fix the html docs search function
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 17 Jul 2024 at 21:11, Volker R=C3=BCmelin <vr_qemu@t-online.de> wro=
te:
>
> Fix the search function in Sphinx generated html docs when built
> with Sphinx >=3D 6.0.0.
>
> Quote from the Sphinx blog at
> https://blog.readthedocs.com/sphinx6-upgrade
>
> Sphinx 6 is out and has important breaking changes
>
> Bundled jQuery is removed. The JavaScript asset is easily added
> back using the new extension sphinxcontrib-jquery. It is included
> automatically by sphinx-rtd-theme, so if you are using our theme,
> you will also continue to have jQuery available in your
> documentation.

We do use the sphinx-rtd-theme, though:
 html_theme =3D 'sphinx_rtd_theme'

so that release note suggests we shouldn't need to manually
pull in sphinxcontrib-jquery ?

thanks
-- PMM

