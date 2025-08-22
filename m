Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB1CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSbX-00016O-VS; Fri, 22 Aug 2025 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1upSbE-0000wm-Eu
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:18:39 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1upSb7-00083t-C5
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:18:36 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-618b62dbb21so4249265a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755872294; x=1756477094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NNgavYd/C6gRZunP2rCFnk7FmfqlLnbTrs4vpaeo5c=;
 b=rc/jqan5Z18bgJ96Cdzu4d1TvV/8duK9KNZh7uATqKb5LaP2Z1iTkXR95McnJf3Lnw
 CVx+L2x1q9T6gjVQDfTCyefNkjYWQf5sCVZrRPYEn7fMxrDryhyaFGZhz1XJcrokqnNC
 SWfNtseaqjr3phjbMyWNaQ2nBtteKvYJVyPldh7vjabwebk+qkwRmSwt/DLAfvdI/Bet
 4VXMDCEnhICNuWTNAsofPdtUGXtbgQ8/iYV/7miUbs8toHgA3Ky6/GNB7RI/LRgrWpa9
 G+L6St3wZsHcKkh1u5oQgT7e9ydD7ozyLJZdZbnZmlfGceOSQ04xv50UD6UMa2x9UiAd
 k38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755872294; x=1756477094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NNgavYd/C6gRZunP2rCFnk7FmfqlLnbTrs4vpaeo5c=;
 b=OA8oFa+RySRXx45Ox8Ng1IJ1nHA1rEQX36eIfbVL0aI0S7uxj17X2pKzahOdBvnge0
 FmR+U4aKok6Eq+2DGPNJInyG0qBk0nBCAP/mhwtnlsRdk0lBB1VDnk++cIF4pDJ1M6kS
 4GODHxeMdZbe8VH4HxiCYclQfzqVlXFz+a0kWe2Jqpw+YDIAAwsvy9kLJF/pXaSm3tGz
 WztV43SLFskFxrKkeSZUQTtjsQbeoVbwTh8/vocVgmozS5WXHo2qjWI3Cgv54j732FpJ
 B3uL9mVrKI0FVf/PYelAtuZF96DQA9+wqTXlJn0d90v8WWCs+R6u1B6pMKGtrSnMjhGt
 HKYg==
X-Gm-Message-State: AOJu0YwaIJxXIyD9NIVHbeNsE5B2//AtIGmIWJfaPnx7zF/1KsuXQjQK
 +lYbc/IpSgUQ7x0dxBJiq6G5nEpNaxEv9jRNKb+LhT9ELCEQwJJKayAI+1fiZvJ1J0F7t65J56k
 hksXv1hgiIgw1/tY/8Y6T5VFxQzEQ/1+AlIkgpZMXIw==
X-Gm-Gg: ASbGncuoMtwDnFsrxFgt1d4enm5Jpp2MRX81Mhl1Hq0o12+p8+kw87kXXM61A4dWL35
 oECKA4dTJARcguG+mNfr0PnMycxqW64TKsDWpN4mTckXxGf9bmpci+ZoQaVL0Fjc0C56sFRDFI8
 wQ7x8WGt+7NPz6bW9miDeQgfsdp20K6YUsPAzoAaqQFp0zDSKV9NzarsXFIk5dD+I2mWBQ8Y+Ri
 dQOIpk9
X-Google-Smtp-Source: AGHT+IE5YfX7zaWm0yEgcbvrkWSasCzLiMaKl7IFqrLkP803LwXoMxgew/I+ph3aLBfYXd9YofqV+5c4bVg2GL3LOoU=
X-Received: by 2002:a05:6402:5110:b0:61c:2762:10e with SMTP id
 4fb4d7f45d1cf-61c276208edmr1032115a12.32.1755872294416; Fri, 22 Aug 2025
 07:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250822134652.1366100-1-pbonzini@redhat.com>
In-Reply-To: <20250822134652.1366100-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 22 Aug 2025 17:17:48 +0300
X-Gm-Features: Ac12FXwpJhjlo8d7A7b5OC71vze56Sqd-hksmDKIx8uK6SrbKcxUf7uv1mCd6Js
Message-ID: <CAAjaMXaSmM3FtDNXw3+FO92wx=gNtdrR1pDKabZ8Y3y1rRtvfg@mail.gmail.com>
Subject: Re: [PATCH] python: mkvenv: fix messages printed by mkvenv
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, Aug 22, 2025 at 4:48=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The new Matcher class does not have a __str__ implementation, and therefo=
re
> it prints the debugging representation of the internal object:
>
>   $ ../configure --enable-rust && make qemu-system-arm --enable-download
>   python determined to be '/usr/bin/python3'
>   python version: Python 3.13.6
>   mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>   mkvenv: checking for LegacyMatcher('meson>=3D1.5.0')
>   mkvenv: checking for LegacyMatcher('pycotap>=3D1.1.0')
>
> Add the method to print the nicer
>
>   mkvenv: checking for meson>=3D1.5.0
>   mkvenv: checking for pycotap>=3D1.1.0
>
> Cc: qemu-stable@nongnu.org
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  python/scripts/mkvenv.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index f102527c4de..9aed266df1b 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -184,6 +184,10 @@ def match(self, version_str: str) -> bool:
>              )
>          )
>
> +    def __str__(self) -> str:
> +        """String representation delegated to the backend."""
> +        return str(self._m)
> +
>      def __repr__(self) -> str:
>          """Stable debug representation delegated to the backend."""
>          return repr(self._m)
> --
> 2.50.1
>
>

