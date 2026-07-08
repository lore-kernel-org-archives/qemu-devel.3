Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA5BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPMy-0003dK-QE; Wed, 08 Jul 2026 06:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPMo-0003bI-89
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:18:58 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPMl-0005fN-GZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:18:57 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66766d649fdso677546d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783505934; cv=none;
 d=google.com; s=arc-20260327;
 b=KVv6+StZsOwCTRZBpazdQqgT9wIusKE4gT2K+29WP72ccMGRyoTNvD1oG2vfzB1G6G
 zmX9vkqP2nj8ExK+Ny4SlR1CIAf5IDXUcE6cC/PfiJvJ5xDHtOiJCNFIJcCdE0bvrqS8
 gx1DN1iEoldl3dImdxsetSnTF2zt0hl1UtVDJcp0LzrsWKXvvTebipjxsxpwiJ63aHN6
 6bEorxhQIFgq/ensIr6w8jLUMxogQQGUhhNH0aP4vMAWoxg3bx3nU/aiVbC7wKU9MctE
 zChzwZIjvIHC6fUgK0+OwqBMXVnYnqJAeDHtbgjbiNC1fJ1pgzCtSA/PQXmQmF2okOyh
 e82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7mOC5wIaMqqzEP03rzSVE6XFYBpSn1uEli06fXgZ5KU=;
 fh=10RhduUL+W3qe6vLjqIRiE+Qmxow+4xQKKoTl/PCTPg=;
 b=PLCt6Uv2Ot/2agdVyQi4AxXJqUf65RwwYJaCCddANTA/iX/qvVItjoXrj6pDXCyiX6
 3OYKL/0kPA4O7Be1QNmcwEjN3VRjIcGSv5RTyNwwy8ohh2DRBv7AN8g3yYl2UsHhv1+R
 m5G70ureQgEANDOjPuM35pehCUMtcxqNluSKAdbQO8bvSh8fJ5ZYDBjuK1D9Vzr5R0Th
 jpjYOj4H6qOnpOrdT6KlU1p4U8tClxqxhbU1fxTogCtdl9D/GzQlQ1fsuwa2rxQ4Ezln
 5fgBx71h48rTg0cL4W2SQubzpkOGtrwNCKkaGpqBgxCnzX5xMu0NoSz0paZuCcziWNCG
 mWNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783505934; x=1784110734; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7mOC5wIaMqqzEP03rzSVE6XFYBpSn1uEli06fXgZ5KU=;
 b=qZ/5QuL005FgjIUmhFycWiZH25mNrmmQQ8gctfzK3KDqU/vXK5pT6WVwkDm+qbi6Bo
 Gic2wn3Npj7hLwyfQpOnvewVNv52XZK3PfrZXDq5SH2E18QYs673C00rcKwpH+SUo1Xh
 ekBVNj1dEkUVs0DbqHXTEtEjxKl6CaPmC/eof8dHNU61yb8ZKbiN9X0z1oo4xhzVw0VU
 h9SPQIo55pz9GzXWMajmHsiLcmNbt02zWL4VMtASo9JclSxbMMEJGt0IBlG4FkRUU0v+
 T6HMY12rPWTVTD9FcRK+m4rRNtaiNEiMeoexXC5RzqRj+Fa7R6bwHhXe8h6Pe9wSH9ig
 32Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783505934; x=1784110734;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7mOC5wIaMqqzEP03rzSVE6XFYBpSn1uEli06fXgZ5KU=;
 b=GtIuaZTriV3j200sta59UoV97hR8maQX+N6rwi/g4fdLxgOqbNIaJ4X85erSJeD54x
 z9OlhXZl9q5zBkd7ySpfECnIr0Bi5X07XzU2wdcIvIQJywSWRr4QxsTg0rkb48qf7Ruq
 G0e1i9Q+9dVxu8nCJWfF8Z3E3AHqLoGFm0Ogkq5HPA3wA/UtCGsuGMOvIUqLucHjqKcS
 /ufXgCQL2ffApDVKT+YWz+FeNik8+Otov2Ac1J92P9KAEiGdeRGvl4nuuEpLq5cXlHYx
 bjmK0QMVhzPIERGE3Db3XDg98bs4jko9LUO2Hpdyvz6Agm2oTN4K1DTYK1K0mbby1FJA
 y2XQ==
X-Gm-Message-State: AOJu0YyDXmzBS8e5X3+lQrlAOJ2nSI4UR/dd/Epc49sgCAVDI5S2ovlM
 fWlCoc1BK237hJ82Ff31YH7FJwdFZ4VQf+uWLXTRiyh5GeGrTi4t3rU01OPHfE8Hp5FWq9O8gbK
 9KDqyp6huD7nZdEzMYeiWykxJ+aGM8x7+uh1MspUpDQ==
X-Gm-Gg: AfdE7cm7AzYuM9458Gk8NBpJJh1TPrzgj9GdPFTidX61ywGivX2e9XOqk1OTwrn+3vV
 vCzdAyrSMseZWrucmhjkojBHy96ecFaWIrT58vykoR6f42kM2Bzd0z6/hDETk4WVNQmjdbIBPBD
 A9ZsTPUbWN6+Phcd8aOqeEsRLpxiF/hIUsLuwN8rgpfNXgU6uJq/oSvkv90NDbrJDbsvyIz8Fyl
 lOg0pyTaWE4jL+mF5CZqQ6hDAt08SOoicy/vIDFLfnbMrTGKvBg2YK6vH9PDpTjM5f3peqmSXPl
 E9EpfMl6EoWpZNp/xquo7TJsLi+ggYE9h0fLChjDSvcgA1TbAPVx5Kyw
X-Received: by 2002:a05:690e:4848:b0:664:f523:30c8 with SMTP id
 956f58d0204a3-6679f10163fmr1057261d50.30.1783505934248; Wed, 08 Jul 2026
 03:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-5-its@irrelevant.dk>
 <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 11:18:41 +0100
X-Gm-Features: AVVi8Ce1FZPCPAgu6fTe6EYDkTrsdH3Eo4FsohH_hJ4jeIDx_FOH73vDX4PA9t8
Message-ID: <CAFEAcA_v+BgV1u+-GR-jrCsanHbgfyLh4FcwiLJmnyWWzh2zFg@mail.gmail.com>
Subject: Re: [PULL 04/11] hw/nvme: add migration blockers for non-supported
 cases
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 8 Jul 2026 at 11:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> How about we use glib's GPtrArray and g_strjoinv() instead of
> manually building the string? Something like:
>
>
>     g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
>
>     if (...) {
>         g_ptr_array_add(blocker_features, "SR-IOV");
>     }
>     [etc...]
>
>
>     if (blocker_features->len > 0) {
>         g_autofree blocker_list = NULL;

whoops, forgot to put the type in:
         g_autofree char *blocker_list = NULL;

>
>         g_ptr_array_add(blocker_features, NULL);
>         blocker_list = g_strjoinv(", ", (void *)blocker_features->pdata);
>         error_setg(&n->migration_blocker,
>                    "Migration is not supported for %s", blocker_list);
>         if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
>             return false;
>         }
>     }


-- PMM

