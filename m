Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF10C982CF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6stX-0002tr-1P; Wed, 16 Sep 2026 12:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ssy-0002ea-Mp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:53:31 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ssv-00029G-RR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:53:28 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so7045045e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789577604; x=1790182404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2OAenVfPu48xDmNp7J/vYm6EMcU7uywgNPaUsaVvhF8=;
 b=YlOIMkUl7sIDFU9Npp3GUXI+m8gy3whEt4LK/e4rdoT3FnU4tAfWzsZURPYJOFInCC
 APAUl6w1ebvOuJWqmmHKhN1cP5zsuStc2GtNHGUDv4y+EJMJuhwNlnZ2MwTA9a9lA5Bm
 nduynQN8mih3P/Fg2U95P8V3zYYPVeJ6/0xYIkFJIRqjwKD2LsNNfQg8NQ0HoBn2xqje
 7iyRBQh2uKJBweScxrFcE6OQhlfIK0g+AQKTFVl4//gSYigeGOalpnHVBHCSLcD2uZfX
 RzCwXt5w3glH7oJ7vWfq3tYlOwKjI+OUWDD9E6uLOmkE4jUKUetV90uZVh6PHERnrYlO
 yIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577604; x=1790182404;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2OAenVfPu48xDmNp7J/vYm6EMcU7uywgNPaUsaVvhF8=;
 b=GFk7m8UFWrfnI5jjt/JzljaGjbxtMwUSGqd3XNZJyJt3DcPo5lu9pTJgFxhUdF+MaD
 KL3MLxEOVHJx5AbsYv63XXACzctMl1iCNHQLhcp1/3tyX6otkJw2g/seL5nEuGqom1M0
 UzJnXWAe2RWOiAznkU95xnhgvs2wxLK3xp56BaDUVaA3Us4yoPjrrVcgdpH7Y0bdrEDJ
 yju/RjB3MiWJoiH8pEcd6jCQtzPHYbIcGAU5RifdkpKLx8ubhUnPmiT1lV5j99U3B8eg
 X/OhYoP0DAxZjYm3yv0pqz1H03y+5P6HB01cuoaNTgt2OSQw/Zu2KQvziSvIafBU0YgA
 Gzow==
X-Forwarded-Encrypted: i=1;
 AKwUvByb5SMYGbv8DmEzddi7VhIOvfhoIDWAyJLx7qR6QuVqkB8VZCr3+Iw6ozIlG/EOVvcV39orywl4y9zy@nongnu.org
X-Gm-Message-State: AFuF++ks1cNiHjajeZQecwRjbYwG+Tr1aGRs9SjgXE5H3xQxOqbG9IfR
 4Fv7lgMAl38MGFPrlGvaNROJkd/GiHyH9Qsdu3gKkJ847XE+rR1RJIXULHtoKyuNjL8=
X-Gm-Gg: AYBFou2fV0BmrKy0mC/lL3QreRyJCYk4TT4r18NN4BzI/6YCMj6UkHld7JIdSzAbEsx
 fafFmzWKfTzBkp6jXtYi5TNpG4J037Za8LfwsIWXasyxq9ycmWOviEuV4WrGKLYzNFKA8/QRzUe
 kcaklzuKYw5VXEbh/PAqaPbACozRTEWP2Lw7jGEIHk7eSROcKRpyyqPuWToM3XWmTJDA2Tl/225
 CgEDRXtCNncInoK0iFud5Jz/rdn9Wg8pePgjPti9mM9GSdHHI4WYhb47gDFYtiW24l2xIVzgpeg
 TDxwqajTQn3+sOEB7ABgTuCpOKrKfz23nNApu4IkxVAXKAJIJZsA+ul2qWda8wjoIm5sXbbAxrJ
 I3uQfOqEgFpNXwI8iLrxRUgvKYrv/+ODlsdpw5CrZNdRVHvct/TImumSO2jDQZgMJ+qSOJ+A+cj
 cBDIqdbOpSRLfSfyE61pVjvoSEfJuBp5vSKHh7JvTdqI4UiUByLGXd5uk+wq5RuIButWEqwM8=
X-Received: by 2002:a05:600c:8b8a:b0:49d:1f10:8b9f with SMTP id
 5b1f17b1804b1-49eac463921mr49602885e9.7.1789577603904; 
 Wed, 16 Sep 2026 09:53:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f0d6sm3925665e9.7.2026.09.16.09.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:53:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F1DD618BA;
 Wed, 16 Sep 2026 17:53:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: pierrick.bouvier@oss.qualcomm.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/docker: fix ccache directory variable expansion
In-Reply-To: <20260915072403.347639-1-anders.roxell@linaro.org> (Anders
 Roxell's message of "Tue, 15 Sep 2026 09:24:03 +0200")
References: <20260915072403.347639-1-anders.roxell@linaro.org>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 17:53:22 +0100
Message-ID: <87pkyd87el.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Anders Roxell <anders.roxell@linaro.org> writes:

> DOCKER_QEMU_CCACHE_DIR is missing $() around DOCKER_QEMU_CACHE_DIR, so
> $HOME/.cache/qemu is never created.  podman then fails to mount it:
>
>   Error: statfs /home/user/.cache/qemu: no such file or directory
>
> It only works if the directory already exists.  Add the missing $().
>
> Fixes: 8a1975e4d44b ("tests/docker: expose $HOME/.cache/qemu as docker vo=
lume")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 0adddb6a5c62..e506add8aa8b 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -199,7 +199,7 @@ docker-help: docker
>  # Where QEMU caches build artefacts
>  DOCKER_QEMU_CACHE_DIR :=3D $$HOME/.cache/qemu
>  # Use a global constant ccache directory to speed up repetitive builds
> -DOCKER_QEMU_CCACHE_DIR :=3D DOCKER_QEMU_CACHE_DIR/docker-ccache
> +DOCKER_QEMU_CCACHE_DIR :=3D $(DOCKER_QEMU_CACHE_DIR)/docker-ccache
>=20=20
>  # This rule if for directly running against an arbitrary docker target.
>  # It is called by the expanded docker targets (e.g. make

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

