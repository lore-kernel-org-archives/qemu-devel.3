Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20990CD3425
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 12:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIn8z-0005tF-3T; Fri, 01 May 2026 08:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIn8e-0005rf-C7
 for qemu-devel@nongnu.org; Fri, 01 May 2026 08:38:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIn8b-0002AZ-0C
 for qemu-devel@nongnu.org; Fri, 01 May 2026 08:38:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso22307415e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777639109; x=1778243909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UFB+YuhL6KiZIr86vLelBiy5ZXx2GLumTYKovzQNMc=;
 b=xTM/JRyQ1k3bsZAOdOg95JtQZZO/r8QhRgmuTQ2ysKzwoX4O2rstEHMEIjGUxBg5mg
 LQd0d8lI5SwqEYX7abXROEaqe1QQhCw8oEeBzmEVluhZjZExMSSKo0FQCbvF4AEEQtSS
 vylchHlCA2GDlanxHmzYYdrqtP99XsuNFUf+9NrfhCxo2DbwWn5o3LwRwrDLvN8S1ycs
 iLqU8hSr2WIvHCnNjxaswkAmOY1toAHdbpMsMjDgQdNlTdkgsf8bXWIfP6JHOpFF31oG
 UBLpagnFhHEnT7E3///cFthElfXn7He80bnCdqPgO8bmRKT6SBvbRgaXa7Pr1AIARMbJ
 0khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777639109; x=1778243909;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UFB+YuhL6KiZIr86vLelBiy5ZXx2GLumTYKovzQNMc=;
 b=PxUapXoIGGgAau7jPMn3wcXfYZ8XKCkvdXzmHHh13hxWBpfrNWRsArggg6UNPBxkHN
 tuv2nyVlxjO3xRRCRYBcaR8akaAbsNBN6cCE0D6bW3lSRv2f7dtyIsZ2QJ6ONOcy2g0y
 cpVX0Nyc9Xnnro14pR9rGGqpcP4rCNuhdJBlOmDBQtYpsGxjW9VO82niN3xV2KyCSr4L
 vK0p+NypT7ThoS+5SOoMLmbiodWdikGlSm0L9uz8AEvLLUYKN70OPYCJD9J7Pb73XUsV
 K3MR3KWULh8A2BZs2MaccvJaFL+Fy4ZTM6kPfK6nidcDJc1F1PBNxXEg1rMEF/E3O03B
 F7uQ==
X-Gm-Message-State: AOJu0Yz8Vr6rNS94pWbPmP7A3Yo6o7AOD2C0SCin2oAPSUpd84wsGkuf
 72OcArrfjkOIhUNHj88DFTWjcM/yi5Vu9E9MU8Xra7xm3gCm++W8TXIGZfK0KqD3gLM=
X-Gm-Gg: AeBDiesxGaBmGjSFQvGaunxdNt4xNQjBgJVMZnACanU/BxHgLhpvxiL1Cm+TtQM7seL
 XdztkCs37Ipo/jmYF8MOUUrSz7OJmR97t9HypDlh4+kPChGRDO9P23aTU0Eb1UWrX8LCAjHRgE3
 cEVis0bbBnbOzNLtwwUpjw6SY3V4zouNwfeK1XvuNb0t5uw9GapBc0us2eLJQxkjOpop0YG41SB
 ENBFt2nZYb6fie9T3kAFJPokLTRhljVaangF0iv39bSzr2svHtQXBxihoJR8fpKKhlKMsPzr+Hr
 uzC+EFTK6SYGoBZiYdGM0BX7/4UMF9vnc9zVWgWImtKxxDOTN6eAAho7Y5xKp36OA5uS6QMl+0k
 l59ZnhbbNXJyrZ/+8n1Jjh6Pgi3YHvUQeUSuj1vi64f0NRQrg+R60mAgv/fQseDWxt90CJuvD+Z
 3EY0I+5FRhxtoRxd7ylQYHhk02LNaeA3EQKg==
X-Received: by 2002:a05:6000:2408:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-4493f428324mr11916146f8f.43.1777639109473; 
 Fri, 01 May 2026 05:38:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981dee90sm4690322f8f.22.2026.05.01.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 05:38:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A19885F8FC;
 Fri, 01 May 2026 13:38:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <th.huth+qemu@posteo.eu>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
In-Reply-To: <20260501115506.3792110-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 1 May 2026 12:55:06 +0100")
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 01 May 2026 13:38:27 +0100
Message-ID: <875x57e24c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The Python os.setxattr() API is Linux-specific, so trying to use
> it on other OSes triggers a failure:
>
>   File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
> line 227, in fetch
>     os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
>     ^^^^^^^^^^^
> AttributeError: module 'os' has no attribute 'setxattr'
>
> Since we only set the attributes here for informational
> purposes, skip them when os.setxattr() isn't available.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset=
 download & caching")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/functional/qemu_test/asset.py | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_=
test/asset.py
> index 51a434b2b7..0abd89e0a3 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -223,11 +223,14 @@ def fetch(self):
>              raise AssetError(self, "Download retries exceeded", transien=
t=3DTrue)
>=20=20
>          try:
> -            # Set these just for informational purposes
> -            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> -                        self.url.encode('utf8'))
> -            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> -                        self.hash.encode('utf8'))
> +            # Set these just for informational purposes. Note that
> +            # setxattr is Linux-only; as this is only informational
> +            # we can simply skip it on other platforms.
> +            if hasattr(os, "setxattr"):
> +                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> +                            self.url.encode('utf8'))
> +                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> +                            self.hash.encode('utf8'))

Well TIL:

  attr -g qemu-asset-url /home/alex/.cache/qemu/download/ff9d7dd7c6bdba325b=
d85ee85c02db61ff653e129558aeffe6aff55bffb6763a
  Attribute "qemu-asset-url" had a 73 byte value for /home/alex/.cache/qemu=
/download/ff9d7dd7c6bdba325bd85ee85c02db61ff653e129558aeffe6aff55bffb6763a:
  https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day20.tar.xz

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>          except OSError as e:
>              self.log.debug("Unable to set xattr on %s: %s", tmp_cache_fi=
le, e)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

