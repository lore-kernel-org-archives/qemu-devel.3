Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7AAC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetve-0002cS-4J; Thu, 24 Jul 2025 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetvI-0002PP-DG
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:15:48 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetvF-0005MO-Mz
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:15:40 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so1849336a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355735; x=1753960535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9i7kTHaH4g0O0Yyn1JE+t8XsC66ryBOfuEZCb7bjpE=;
 b=QqRIRz0Nu7bxtpnhLphaHGgTRiL5YCpfAtCkl9+EqNwfiOcm/ZxqqnIOgDQgflKuJD
 tW31O9a0OmsVD7vx86g1IcqCfadJTxvLqvBZh93sfa1d2tqbzSM2+IU4Gltp/9CqYA0u
 tKU6E3kmJ3qcVY949mJn7akAJCqoMUwoEPaNIzDrPjRYE/2QS0TUhu9KLM+akFufwUOR
 jHO7k1f7qmPiV+Lrd8ITTuhw1nXitYzpDE9p+GCfguHb7b27f1u01KF/MEq3K4EV2j5W
 1CyrMKyTs4YUmpqlAP1sA097asI78+nKUh/9R0Yl07bC+5as8no0A996ibB8IFeqhE6Q
 8WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355735; x=1753960535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9i7kTHaH4g0O0Yyn1JE+t8XsC66ryBOfuEZCb7bjpE=;
 b=AwRaU6EhHMm5yIniLGE+D+a6M0794CN1ldeic/UlB4jtc/sfIcM4LMefi/rnH6znoV
 ViE4njhub7iEY5cRPGbenCyA9qegZ5YqrK1b/e7AU0ueftxU0n4jldBwg7J57jxkNIOK
 q0Hc/r21vCaxKkUtzkhkt0+AU1Np0NbI+akKcwMWGZRAR6INxq2yl0hKAlEMf4ytai0B
 5xY399asfSGeVOwLw/8yfWN1qAu6nBos4ErwMhIkT5xE9AGyv9yFqCl6WYjdXRm+iK5c
 jO/xHf8Ox3x8YIZh6wfUEzgYVbFFVsRaYJL+peGBfHkcNLmAjz4DE21O4NOaPtYxYCqu
 DGFA==
X-Gm-Message-State: AOJu0Yz0J3EmQRkNPoiHa9mmWQ5+C2dssWhoz1W7Zt5do/cMHotMA98F
 zr6YC2Fl98BTMBpLuVcg+YKkOQfB0V8CbvmUgIELryaKonrt1F9HO7hIRPVhInBbrfxaAqTy+a3
 4MqMREsArzecGvL9wWQ+xCmDZ5GEB+gy8rz9saqvtxw==
X-Gm-Gg: ASbGncscco4wcbpmOmD8yXOh0I+4T/OPQMQ2IkP/DEBRslYiEYlKJj8Tt4V2XHJV79x
 5B4FksocWTiz8cTbxCz4OKMUgOYYIfODIHcd2Dn63RYRTS3luP97RTzhN+eS0MiqUgHKXJuVgmN
 cxSNyqC3ufM/KWYNrf+rOyyfW3xHaXmeXXIdSX+iZhE3m842lkJizOVb0dTq9m++NwKQEI+bT1Z
 K7Grg==
X-Google-Smtp-Source: AGHT+IFIztq9xSylbYqNBpe0qfdm5fufhrKTf90pWbzoFeHlY7ee1crPvthlzqEQRXTh90hTGTGlVcuQc5pjTzHYifg=
X-Received: by 2002:a05:6402:d0d:b0:607:2d3b:4827 with SMTP id
 4fb4d7f45d1cf-6149b5adb96mr5967732a12.30.1753355735493; Thu, 24 Jul 2025
 04:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-9-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-9-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:15:09 +0300
X-Gm-Features: Ac12FXxf0iFFZw5DsXWNHIwK534y-eIzkgjhJWBDtul29aSG0zCbBEXpTzaHn70
Message-ID: <CAAjaMXa05h5XpoZC+-cu0Ls=++yfXRheuO9DYr6ZGwH+65uZKQ@mail.gmail.com>
Subject: Re: [PATCH for 10.1 08/13] tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> We never actually used this is the end. Remove it to enable
> re-factoring.
>
> Fixes: 7cefff22d54 (tests/tcg: add mechanism to run specific tests with p=
lugins)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 3d96182a7b9..97ebe8f9bc9 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -169,11 +169,10 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>  # only expand MULTIARCH_TESTS which are common on most of our targets
>  # to avoid an exponential explosion as new tests are added. We also
>  # add some special helpers the run-plugin- rules can use below.
> -# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS varia=
ble.
>
>  ifneq ($(MULTIARCH_TESTS),)
>  $(foreach p,$(PLUGINS), \
> -       $(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
> +       $(foreach t,$(MULTIARCH_TESTS),\
>                 $(eval run-plugin-$(t)-with-$(p): $t $p) \
>                 $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>  endif # MULTIARCH_TESTS
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

