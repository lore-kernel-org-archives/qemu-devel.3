Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF0DECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snguJ-0000Wj-5N; Mon, 09 Sep 2024 12:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snguF-0000VI-IJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:06:23 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snguC-000680-Uj
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:06:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso4453468a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725897978; x=1726502778; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TID65MnU7tJsbvdN8LmH6fBLK18mHHzrBBE0A/HJHKM=;
 b=cGnEKSQmECkr3GmeNHsvldh1JCv93cCTJXn+oB8x/iPYT54HA7EFJ7yv1EJ9t3WesR
 koL4EQ+es+iiCah9X6hDd62rDAsNA7dbbDfaU+N6DuAncjoFIDQ1dkS0L8X260h775/8
 sbTiDG/FI2IurgJphWJeuAEMvTnmfWEQdVUDW41kcqEX8wyplPKFSZqHlmgXcZO+gqRS
 aqINFcXd3RNSI+Nf72NajF6DxdbR5f8k/HrJH2EOYXDlvwm/00iqEvfD/y0mikVJ/4Vc
 TJ5Wpp2twVE1EdlYg8c/IeoWYDkunuCKD6NeqlDWbHhHZM3SzdVL/wOA8bRAPbrYqXIh
 HihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725897978; x=1726502778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TID65MnU7tJsbvdN8LmH6fBLK18mHHzrBBE0A/HJHKM=;
 b=O6t7bs+wuq0vGaLpr0EXWydCCvAznNXy1O9YKR66UZYvAZO/bO7F/eYKPQnB7FUMj+
 TxHcG2MmnIvQUoSK2G8g1fs3TVfxmq1PQERhIVXo2yOAZe+DuNMN2q4N7D1Jz8fYF7N8
 3oXiYrtCl21ZW2FXngYLJbViy17d7ngeWDH15q+TyLckU0PUqFwoHRHI9vBLR0WRgWKl
 UGsRBGBxKAqxNHAq+M3g8aPD827l2OdB+hldGmjAkgeUkLNjh3BIiN9ef4ractCDsTX1
 TQADjTHYVlerZVAvPhtdwQ+5z5EGQlK54mP4TkdeWM6sx5fRyGgl5D2PzDGyJKR5Po0U
 lAfQ==
X-Gm-Message-State: AOJu0Yx/Zkv79lbvCvAXOQWa80tzyi5jLfqAYbA/G/F+Ql5zX2r26+o4
 jS+tJ1UXR/fNeV64tYAdD8HqCc1eoOmfEP26toas21K16gWYc3CPbwl1dHf4UOwdo2NwuyCAmQx
 ta77sZsUdaiAnH151vU51dZ6GPtvbyJOrw8b0HUYg8KXd6TdQ
X-Google-Smtp-Source: AGHT+IHjoWWzOSzYxmqWrcOGoIz3bW/9510Wn84XxA6U9YXbSIh1QLteiSzYl5bD4a9YMiP8Zpa8ewzw16dHkVDzyp4=
X-Received: by 2002:a05:6402:2345:b0:5c3:cd1a:144c with SMTP id
 4fb4d7f45d1cf-5c3eac276a8mr5545069a12.32.1725897978167; Mon, 09 Sep 2024
 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240909141635.1459701-1-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 17:06:06 +0100
Message-ID: <CAFEAcA_q3FUj2gGW6VRbbn_Z2SvSV7kCZFGyueyQ7Bab_5kWgg@mail.gmail.com>
Subject: Re: [PULL 00/10] Crypto fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 9 Sept 2024 at 15:17, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit f2aee60305a1e40374b2fc1093e4d04404e780=
ee:
>
>   Merge tag 'pull-request-2024-09-08' of https://gitlab.com/huth/qemu int=
o staging (2024-09-09 10:47:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request
>
> for you to fetch changes up to 10a1d34fc0d4dfe0dd6f5ec73f62dc1afa04af6c:
>
>   crypto: Introduce x509 utils (2024-09-09 15:13:38 +0100)
>
> ----------------------------------------------------------------
> Various crypto fixes
>
>  * Support sha384 with glib crypto backend
>  * Improve error reporting for unsupported cipher modes
>  * Avoid memory leak when bad cipher mode is given
>  * Run pbkdf tests on macOS
>  * Runtime check for pbkdf hash impls with gnutls & gcrypt
>  * Avoid hangs counter pbkdf iterations on some Linux kernels
>    by using a throwaway thread for benchmarking performance
>  * Fix iotests expected output from gnutls errors
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

