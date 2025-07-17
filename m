Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E519C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSj2-0000r0-M5; Thu, 17 Jul 2025 13:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucQA7-0005T1-VE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:04:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucQA5-0001fu-SA
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:04:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so1630507a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752764679; x=1753369479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orCS500NhnFyli9cek+sOZZKW3weyj51fzmO3ykBAqU=;
 b=tP9Xg1rGil05doqnt72ykU3T/PzCC0zk6/BSwA8ALe75W4kV9lSqBsv9nWtXJsRg/P
 o3Nq4iunTeq1VJ2+jKMBBapszR5gUew8KO5qEnBY4GUwCGsh0k8Z3szrVEHpswHliwkl
 EbVcWH00CXD+eqNFWZezEPAmzeZwxdI5et6fxEEarTGxkQtnUX4dfdEVU04Y+4vfTqhQ
 uHxF2yKte6eR2O0WIV/fNczPmE8892glTt300bh+tDu4w54OM3Z77BqbC+9j+o8/vq5I
 QrKnqHlA0scdOzFHn1AgySQCmRap5fn4qiAl2M9IqcOwlCLiAqwZwqdGsjZh0gjnGltI
 3KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752764679; x=1753369479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orCS500NhnFyli9cek+sOZZKW3weyj51fzmO3ykBAqU=;
 b=s+rsOdSbWarRmjWmNTBa6rMxrhg1ytTyGyTqTUh1M0rDd7jE0jERwAftDmBdj5Sc1b
 87gfdPkOS5B3sow+hAEXFG5qWQ/QK6qHgU2xtcMs+ezGqgVqAYlNJzd4Zqt8Dqf+4Owe
 13YnjHAXorNASws6Wv4DBTEOvi+P5udU2qqBeD2DN7Q9ko/4E37IILF2tftB1TXtpjhP
 47zS8xRZJEng/7K2/zM6yPYOd+7E0Zlck4KpVx/eyU+XXhRZrRWZrpyTg7L8JjDbZYEU
 cOAp1FaRpuYCRRfx7SK5SmQDTldGwMNE8xtG7WrqVXyQqfqXCWTTXHY2qWKnOCttYhLA
 L90g==
X-Gm-Message-State: AOJu0Yyrs5nJ1YoW5Us5PaldLn0XoxDtONZvwfm2vULeF/5t+1/I75Bo
 gOE5IuONxWvmfqZKN7Lp+pMywmJgC5P84bFJ0Utb0WhEfH1732HUwG+sXsRxaf5tKIC0cOp/HyO
 ie9fVepm/UdzTNbQdWopnRM5OlVdqrqQg8oD9kqTD4Q==
X-Gm-Gg: ASbGnctHzZEXCnANR44a1osWMRYMW5oAw6ds/sO19J4cI5BxLN3Ij8RMatcpFwLB1Wu
 iD8js0T5dxrTjFujmSPqp2/SXfV7TK5a9+NIvnvSVJ22rh9lkbFd2YkcvgHFprBQcHqf1RbV1g9
 cfUZbYy2yWc1wvKNZU7lngtiEXMYelmNUghJiO6VfWV6+445Lv4Np19j+vzTUBx2qKJtNAbj287
 1CQ2w==
X-Google-Smtp-Source: AGHT+IEDTr33QqJ8Q3HnMkPm3goGuvUr85bMM1YtLRCFy+ANVuYzksI+SXS+5lhAh/3Fl+TCnwjt5bOIYx6bCbQ1GRU=
X-Received: by 2002:a05:6402:430f:b0:60c:44d6:281f with SMTP id
 4fb4d7f45d1cf-6128590b4c6mr6601810a12.7.1752764679172; Thu, 17 Jul 2025
 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250717131256.157383-1-sgarzare@redhat.com>
In-Reply-To: <20250717131256.157383-1-sgarzare@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 18:04:13 +0300
X-Gm-Features: Ac12FXzD_nuF-8WaRNW6Df9x0_jul4ApU40bQ1mMlknK5E-BYpDT8NBF9Uqud_4
Message-ID: <CAAjaMXYdxJBu1mLSp1vcGzbMWq6Voj=LR-za95xce3XenY=aFw@mail.gmail.com>
Subject: Re: [PATCH] meson: re-generate scripts/meson-buildoptions.sh to fix
 IGVM entry
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 roy.hopkins@randomman.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, Jul 17, 2025 at 6:00=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> Commit 84fe49d94a ("meson: Add optional dependency on IGVM library")
> was inconsistent with the contents of meson_options.txt and the one
> generated in scripts/meson-buildoptions.sh
>
> Let's regenerate the file in this way to keep them consistent and prevent
> future changes from including the spurious diff:
>
>     touch meson_options.txt
>     make update-buildoptions
>
> Fixes: 84fe49d94a ("meson: Add optional dependency on IGVM library")
> Cc: roy.hopkins@randomman.co.uk
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  scripts/meson-buildoptions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index e8504689e8..0ebe6bc52a 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -130,7 +130,7 @@ meson_options_help() {
>    printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68=
+ GTree API)'
>    printf "%s\n" '  hvf             HVF acceleration support'
>    printf "%s\n" '  iconv           Font glyph conversion support'
> -  printf "%s\n" '  igvm            IGVM file support'
> +  printf "%s\n" '  igvm            Independent Guest Virtual Machine (IG=
VM) file support'
>    printf "%s\n" '  jack            JACK sound support'
>    printf "%s\n" '  keyring         Linux keyring support'
>    printf "%s\n" '  kvm             KVM acceleration support'
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

