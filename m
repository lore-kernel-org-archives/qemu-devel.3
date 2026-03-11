Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC7F1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nhz-0001lL-CY; Wed, 11 Mar 2026 13:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w0Nhw-0001ky-VU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w0Nhv-0005o9-87
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773251454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOTYeHIHWqapF6z7iW/Ae/k239I5+uwzuiv/Vhz3ugA=;
 b=JO8+LOA7JjLQP7id0D/IYKrd+zx7zDh5iVljWu3JZZ+MjK0eygohSoKefDcRJDZer4lzb3
 gAhpixcKoMWvdMVgDjIJXSykcgaKZTP5rlGaNlu3iaZqWaGGVbfuyDDa/Ij41cYJ/78LUA
 gAlQI6KcNSmJ/Usai6mmZlF3u4GUNis=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-sJmazy9tPb2IkRteWFpMbQ-1; Wed, 11 Mar 2026 13:50:51 -0400
X-MC-Unique: sJmazy9tPb2IkRteWFpMbQ-1
X-Mimecast-MFC-AGG-ID: sJmazy9tPb2IkRteWFpMbQ_1773251450
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7986f771f69so36637207b3.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251450; cv=none;
 d=google.com; s=arc-20240605;
 b=faWsNIG//StSw2OL6sFES699e1o0ScCfqh0S36prj05tCexx/mMXHhp7CbnZB2sbKZ
 3YTTj15/94gqz3QCwd3V0AbHybEdy94wp/kI3YX+z1XOpmbw7G3+pgp7bMF7THfDOlK8
 1ZQZtQBDr+bQfMqV1RJR7gZSRQwAG0BQdwig4RaCxFKuCQ/i4T91sjHXMzny/xU8pNy1
 PZTP+vQaSU2ujZ6cM8yYMD/eIsxD7fKM4fYz8KLHNF+L914s/RhcmkVDXuAMdU9ILXOO
 1SPVZcaArBCQQqmClTWI73YKhnj9GgDR2Q8t9YsgwgsA9fRWAbhwoVFqt60DTpU+B35c
 KzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TOTYeHIHWqapF6z7iW/Ae/k239I5+uwzuiv/Vhz3ugA=;
 fh=ElQKVI4Dk6HA0JYXCzp039d/Vuy6kuE9fuR7MvVeTmo=;
 b=ONNEzF6xw2z9RrAmMHQZdKWj0q4DcYZqjA1gmFkC+fPU3stsQTETYU0UT1xRFCIDSa
 ojImnSCEzJ7CN+lYeQw25FnZcl525nCh4PnmdtcLGS2wqfckNbRDewj1jNpiXbdWGb9J
 mu9aBnF5++4HXlpSyCk9XXh28i58v7LDuPfafSqzcOQ7moPop5DwsN6dB6tU+B8yGCFi
 gc9bVjGM7Vd21f7WsvRKygEagwizggcZ3OV9b7rHq6MZiJ0LVlCaE9Fi8B+kb6f/Zsec
 CxIvIUSa4q2soOlfqqXrNaFg9rOeYDioqGl0tjsSEXR4furkhErgBpvTnGkRtKfjDOQE
 uBvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773251450; x=1773856250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOTYeHIHWqapF6z7iW/Ae/k239I5+uwzuiv/Vhz3ugA=;
 b=SfX6mXfIsXJswPSYgj0zTMsDCp/ki7xN3C59Jl8snYe0BzXqy5cTl9DUJ/yLV1Q/K8
 YKYT2cLojGvxC7/T5MHYTxDS3y149TPu7PEUPx4xacVcUrtztJp91JN5tEzPy80E/w8B
 5uYeB57r86nHyxz9VmM1qv3qhfh5afagsubFuiDtON2ILiNRTGZirD2U+tnW5+gxwd5P
 TbjB38v/gJZg1gglhxCLtFXCSBweSYWgAb8LRCPv7kiar113ztoYfTfW4yXuWOguLCo7
 nl72Cmrvfc13pC52IjcfHlS5m4EMaXird0XAbW0uWoCj2zVec5vSjCnDOiqSyZk824js
 NqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773251450; x=1773856250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOTYeHIHWqapF6z7iW/Ae/k239I5+uwzuiv/Vhz3ugA=;
 b=hEVEAPKY5HjClBhsmlDLzX/LmopZH7QBK2goKyISe5ryqL/DopwGWY6nQkTDFkGEBd
 i6o30x8GCJzfCgorpvyqOCHo9NsR8CX0BU12OfsHT9v3mrJG95zfdO6F021DRrwQ7epZ
 GeSMR1rymFCpCfd6dNhFcPNrBzkF3wDf4re9UM4V7ukj4Ifm8e8On49KcN8W9KKtBWmL
 2kgVZA85SzLaeA3n9+Sglu3wVwPXUIK0RnJBK88UjJj+JYAHDUZmytv1XYNTrIw6qq8v
 vweZaBbU8P4/+kE8ewq9DxZU7ihzODC0CCbyDB7skXlQ7EVnBeXbEjfAXL798/jHpVXG
 mmdw==
X-Gm-Message-State: AOJu0YwyXXMQrziWmQKCDBrsMZc8rZf+6cLhWRaPP4XpBxbCas81bvpo
 OYPkH53AocCIcxrK5GaiMAsiVudmmOzUqtOIxXa/6XlnYyCryV6CLpGXiVt9zb3OscHDwpAnvvt
 3hawwaareCAx7AQQgrx/E0FJkpNQcddCQLDyFBhtVDKXik30kJIOk86U2DP6p4DeqAfyKdDVIOc
 MVWImj5YV47V/FJzGx9m8fdefHE+VpKwE=
X-Gm-Gg: ATEYQzyvtdVaHruR7ZUAwCmuuwzBmNFZw9okB5ZyTCgOM6VY+z+HFe+t2jhJQQAPJx3
 bIeNbteve4nOp8wrNtqj7RjfkyoIStFcVGnTkaSYxBC+J3oUrVqUbU7wfLzpd1msw6x1yANJLLt
 WpP/EkOksufl469XVreLYQsnAthg/l8FqWihaRCSD1+jSafkZCCjJYaamALAA1s3PRwRbcGehkq
 SHgngk/iAMNVQ+TbdLEUgikWg3aNCqlNhYZDA==
X-Received: by 2002:a05:690c:6604:b0:799:1a03:84c1 with SMTP id
 00721157ae682-79940fc3dbdmr5210877b3.4.1773251450458; 
 Wed, 11 Mar 2026 10:50:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6604:b0:799:1a03:84c1 with SMTP id
 00721157ae682-79940fc3dbdmr5210657b3.4.1773251450034; Wed, 11 Mar 2026
 10:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
 <20260311150327.1084669-5-mjt@tls.msk.ru>
In-Reply-To: <20260311150327.1084669-5-mjt@tls.msk.ru>
From: John Snow <jsnow@redhat.com>
Date: Wed, 11 Mar 2026 13:50:39 -0400
X-Gm-Features: AaiRm50ThViT4k_pICk6xAHj1wrlYzUT2JkBzlzs1tp7U1f0zDneRP7N0-mHSOc
Message-ID: <CAFn=p-b1RbHmJgKvonqDX6H5+7dwcXfNEMTsMiU7GmSW=L-yQA@mail.gmail.com>
Subject: Re: [Stable-10.1.5 05/46] python: drop uses of pkg_resources
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 11, 2026 at 11:05=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> From: John Snow <jsnow@redhat.com>
>
> pkg_resources has been fully dropped from modern pip/setuptools
> distributions and we should phase out its use. This patch is enough to,
> by itself, repair most GitLab CI tests upstream; with the exception of
> tox tests which are still making use of avocado - which will be dropped
> in a separate series to restore functionality there.

Hiya mjt - that separate series mentioned in this commit has now also
been merged and you may wish to consider it for stable inclusion. It's
a four patch python PR that adds Python 3.14 testing support and drops
avocado and it makes the optional check-python-tox GitLab CI test
green again.

--js

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <20260211195804.135144-3-jsnow@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> (cherry picked from commit e44a26ba940214824b61976324058e73d9f41658)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> diff --git a/python/setup.py b/python/setup.py
> index c5bc45919a..789fa39b0f 100755
> --- a/python/setup.py
> +++ b/python/setup.py
> @@ -7,7 +7,6 @@
>  import setuptools
>  from setuptools.command import bdist_egg
>  import sys
> -import pkg_resources
>
>
>  class bdist_egg_guard(bdist_egg.bdist_egg):
> @@ -30,9 +29,6 @@ def main():
>      QEMU tooling installer
>      """
>
> -    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadat=
a-1babbe54c108
> -    pkg_resources.require('setuptools>=3D39.2')
> -
>      setuptools.setup(cmdclass=3D{'bdist_egg': bdist_egg_guard})
>
>
> --
> 2.47.3
>


