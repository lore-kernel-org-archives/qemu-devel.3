Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C93C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ymU-0004LO-Bj; Tue, 08 Sep 2026 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x3ymT-0004LG-Ml
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x3ymR-0007PL-M5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788885281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PUtwbQ6wN+9ZGS6RolrgY3gzZLlgaAJ9dGbgE/L2no=;
 b=ZTjxKOSZwAKMdFSltktZXXRoriwJTteZ9XWNoC6nPZuzYI1/8ujYTb9AWSFGMocUG0CVRb
 rwTcqi93HninKUiLFeN6RPjulewLRDS3kL+km3BSfdfd2DvxLob4w9BGY8158EQ96tS8yF
 hdJ87934pPOUGNGO4y0xg+VD9BF60LE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ru9uDmHZOkOz08xVbJ7Spw-1; Tue, 08 Sep 2026 12:34:40 -0400
X-MC-Unique: ru9uDmHZOkOz08xVbJ7Spw-1
X-Mimecast-MFC-AGG-ID: ru9uDmHZOkOz08xVbJ7Spw_1788885279
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66faff68c0bso377322d50.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788885279; cv=none;
 d=google.com; s=arc-20260327;
 b=SdlRULgFiFJNrwtNnavx9rSxYKrOklaxxJx2s1vv7ETBciTlkE2bC8T2mw2E1hvPKX
 UScIs30op8yq3iZAqWIpRIQFqp5HRvosn6fpQq6vrAZV9dgmavZl/mwmLkN2fQ759cnA
 o6WoNLY+BsSGCJI5JpOm9bwlwvaBYj00YmecBfWvdtMWumSWUXVT4N3MMhP1yfgwbfN+
 6vVGcgePfQmW78Y9lSlPN5RZ3Ygk8ycULUkn3PzCCKh8QnHRK95edf9v5agzcu+SUmqg
 nDXNllaXBxULTNkzaJMh8YmhksoT3RbidsFxWtXFKGWRxF+FerPEUYSP24eTDzshGjJU
 9qZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4PUtwbQ6wN+9ZGS6RolrgY3gzZLlgaAJ9dGbgE/L2no=;
 fh=ESuptqnqG/MKn4BxYFlRx/KGAD8dDslAj3Rmwxm5qw0=;
 b=cbfS3ExhtVcP3vlb6pJDYxrr3NU8XHAHBISR34bOKpspRlJqEQGfLnpbzVA2bcrjDR
 bBkYcIoEVCJiaUDk77Rp/C1wNt+hUUbMwR4TRlHZ778yANh8/p0JBi+TICKzZfUTuroS
 u4jVLmmWSKD3AwB2couVsnbFEhJywsIgglcVeo+7B9Kz8udSCFt+5bq1fFJTsSnMCXjC
 4oQ8ViPvGW1TP13HYZ+23geJQ/+rHlq2Iir6Ueaxm7ovH0zpJ4rhFLtr9DXu8OhPlcRn
 E8AvylhVuaflN+HkmMnZvpFJk8iigCavoYSP1fW/3AeAS9Cij7Pitdbxx6cCu55EEJUI
 Q9XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788885279; x=1789490079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4PUtwbQ6wN+9ZGS6RolrgY3gzZLlgaAJ9dGbgE/L2no=;
 b=fHozjI8NdSzEQDi3VDkggT4oRQBV9aWeZ+hSj7wmB9oOUEJxVez8uB4qpMvXwgjRly
 uwb/xI44gjs/0Y4CLqIyWgGKRKK1Tn/GS2kV9wT08vUBK+pKdJbP1dU0nXvslnpV7iE4
 FVSxse2oD1J/xyl9y8Bun+TPItxJD7Sqt6AfMtuJ0UVN2aIshTlpxRxB2dLDljYIEqaP
 brtQngT1jEVrX7jKIYkizHIKnmuSxUNPWuDgbDgX+8Ip/TNcnOrKP94zWnE+YFvykoog
 xgIhZRtThMuEwIaDPPULUmr5wGhachLA+Qa3zn+60tIyNKjN0oPjZ3ydN4GuWflbrwEj
 ozBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885279; x=1789490079;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4PUtwbQ6wN+9ZGS6RolrgY3gzZLlgaAJ9dGbgE/L2no=;
 b=V0OhblWNdkNRL3HOfTEAEerdWp7tcDjM2BuWEBg6R/wKDMA9GZN9VWT3MTVA1nrsu1
 C6H7KisOdoUCYFtY7HfHhY2zo3quFjEOReOdgsepTTLASvCFMtfwvPhgcKuaRv7WtEvs
 TWtGSMSxdRg+9t1rZBMam7r4fVRnDyYs3TdZuonvkT3DNSd/y1fXYAxSABGm7mSjHfq8
 k/XJcypLYVm99TRyUGyYJbtYrHfbJAsgjZEnnaNrR9uaymisvjXXrmlhoJnQ8IcQRYO6
 Z/361hCrxW4aDePwzKWEcxpI3njqVRGUZsSLevKHGeh/FKjA0MyXvJmdIEJ/Jx6cnY2d
 tczg==
X-Gm-Message-State: AFuF++mPEcO4BdX8TwiunLVjOZC7DdsME19qWdTcTGY2ukhlyQFkrCft
 8graC7U2omVR1RiCE7OV4AaTu4Y+jCHNB7TgLOiMG5zkQzCfbiWV1mrsu4x8LlWBXjoZEXlsYA0
 AgDCTEJ8RgsVI1cJ4a/ldl/+3Pz8CQdfsQ+31DhzjRNiacSGP6LUSCrRIhHgyfUJEdGdVkUY3Ia
 Pjvk3mOI9Vzl152gIz5mMhEL5lx41qxOk=
X-Gm-Gg: AYBFou3mkyr0hAWSYuevpoRUDTFJp63uXNB7sLp64UD1zVjrSPw++kqEuAc/Zei+Ngf
 Et10xpgCkvk9VkbexcvtvUsDoS2J/yqh8uXnhoBtlFeyeF7KZyNx3WriScgmoANf4vyV58iJddo
 BQ0tkayBvFr/IsEfuYiQzzD8YUh9nhlFB8y7A8oyRgqBZjWQEXKmkgtgLkgdj5GvdH49YVDbaNq
 1XHYOb3tlx6AWwH
X-Received: by 2002:a05:690e:1247:b0:66c:c640:a7a9 with SMTP id
 956f58d0204a3-670f576cc47mr2838573d50.1.1788885279255; 
 Tue, 08 Sep 2026 09:34:39 -0700 (PDT)
X-Received: by 2002:a05:690e:1247:b0:66c:c640:a7a9 with SMTP id
 956f58d0204a3-670f576cc47mr2838540d50.1.1788885278627; Tue, 08 Sep 2026
 09:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 8 Sep 2026 12:34:28 -0400
X-Gm-Features: AcwNN1WK2RkQc8rOPkibd5yccVRX-76wPO_MMxpMAhHHaGHlKtyCvsoM4jQYPr0
Message-ID: <CAFn=p-bQeHAw6KQW2xpKki+a9WMHrQctKXosRG5NHhJ+46jETA@mail.gmail.com>
Subject: Re: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Sep 6, 2026 at 6:29=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> pythondeps.toml and docs/requirements.txt pin sphinx=3D=3D7.2.6 alongside
> sphinx_rtd_theme=3D=3D1.2.2, but 1.2.2 requires sphinx<7 on PyPI.
>
> A fresh install of the docs group silently downgrades Sphinx to 6.2.1 to
> satisfy that cap, which then fails Sphinx's own >=3D7.2.6 runtime check
> in docs/meson.build.
>
> sphinx_rtd_theme=3D=3D2.0.0 is the first release that drops the sphinx<7 =
cap
> and resolves cleanly against sphinx=3D=3D7.2.6.

Thank you for catching this and writing a very targeted fix.

I did not notice the silent downgrade as I have sufficiently modern
releases on my base system which our build system happily used
instead, and none of our CI tests noticed. I'll have to invest some
time to ensure this is tested somewhere for the future.

>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: John Snow <jsnow@redhat.com>

(I did not test this, but based on the failure logs I saw and the PyPI
version constraints for Sphinx, I believe this fix is appropriate.
Peter, would you be so kind as to take this patch directly as a build
fix? I am taking today off as a sick day and don't want a build
failure to linger.)

> ---
>  docs/requirements.txt | 2 +-
>  pythondeps.toml       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/requirements.txt b/docs/requirements.txt
> index c10c4cf7c91..509d56bd1e8 100644
> --- a/docs/requirements.txt
> +++ b/docs/requirements.txt
> @@ -2,4 +2,4 @@
>  # Should be in sync with the "installed" key of pythondeps.toml
>
>  sphinx=3D=3D7.2.6
> -sphinx_rtd_theme=3D=3D1.2.2
> +sphinx_rtd_theme=3D=3D2.0.0
> diff --git a/pythondeps.toml b/pythondeps.toml
> index e4c10d4a9f7..afb1364dd28 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -29,7 +29,7 @@ meson =3D { accepted =3D ">=3D1.12.0", installed =3D "1=
.12.0", canary =3D "meson" }
>  [docs]
>  # Please keep the installed versions in sync with docs/requirements.txt
>  sphinx =3D { accepted =3D ">=3D7.2.6", installed =3D "7.2.6", canary =3D=
 "sphinx-build" }
> -sphinx_rtd_theme =3D { accepted =3D ">=3D1.2.2", installed =3D "1.2.2" }
> +sphinx_rtd_theme =3D { accepted =3D ">=3D1.2.2", installed =3D "2.0.0" }
>
>  # This test group is for dependencies required to run various tooling
>  # and tests that should always be installed at configure time. It should
> --
> 2.34.1
>
>


