Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6B2C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugj9m-0002P8-Ml; Tue, 29 Jul 2025 08:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugj9Z-00027I-Pj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:10:03 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugj9X-000814-E4
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:09:57 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61530559887so3369334a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790990; x=1754395790; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r91sX1eIpEaT8QzOwHfBD9CArL1+llwbwzFUj8IwSt0=;
 b=DiDA8gHJkAyCVYU7ev48yTa1mQddUvCeY7N9RWebCiSB1D8AOI5QhzRDC/ou+fNUIZ
 Q2p0LVUTYKPwo1U7XXOeWpEnTCz9qjVwcLLU2hkn6Ee2cq1bwUNBvqu90riJD2zU0Uk0
 2PVcJUyFyH8gg0JWLFhEA6ZY7ynn2MjSEgAB3X6rP+mb40uySE7z3lNCq+RG1rF58GAU
 ESM+1VT7/DrNJbv3sT+/xL3zWzbgIQvonGeP81rsVdJ/rrTQRPZz4rprPc8FFebuw5iS
 xCLOSKMNPWmNQrXnwIlrhaV/laoig1L0mFpJG4b9b2AleuBQS+AdOaUwbEfMk+9nMODy
 OWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790990; x=1754395790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r91sX1eIpEaT8QzOwHfBD9CArL1+llwbwzFUj8IwSt0=;
 b=VCE/GmXSdWzWhmvcJjneDuJzfnftvQBO5WtbmM71CgbDw3TkgG6xunYaqRIB1ha/Op
 oUInC8EczIPHGmgi4cyJKl9qZElMgPzX4Uormvezyr0fkMdtPmwP2id8UDm+GC6nMAY6
 VcxJAzL4fIJQw81Zg6Qy1ZXOhWKIdZ9bHen3AOGw/stuAjW/26Wc0Xteb+/qarWagYox
 7G/u9RanIDgv5thMnKAFjD9hf6CrLyT8KpXkfhKrluvdJByqozfpJV29M7+oKMpYgUFl
 ZUKpwVQCL7pOpUAmuDCrwVWM3C/5mf1XLhcl08cDH7hS6ukvXWtHy8QhuKKGx027WAwa
 flng==
X-Gm-Message-State: AOJu0YxcbtPCiE4Vdx/XFfOUdMki5h14/ipxkza/ZEi4ugsZ92xroM06
 xpetV/sfQaK3JD6FaxZsGjUzgzfBNVAKm1Ij7DvDiHqf+few3ZV3jCEfb8gGgrbbt3bMwkkE4R1
 C7f05f4WyiSGKraduvFX/hok+v+/y8upzYlNPwUVaoA==
X-Gm-Gg: ASbGncss5NNn97FJA241Vcg1siFRbsUIgMtwtcvtUcandYwshvvFLslruyxsc7Hkg6+
 HUlG59+eAlY1sTk9AHa9zSE0XYRrRUmefA/w3x6LbpxKLwRF/Zpp1ZmhcIpOhKHvC1OxUeqHmcy
 T4Eeptzwmpx8/QAGwTOa6jHEfpeOFDntbiDZKMhDbvJnzyh3XkXvWnDjsrf9wvzi6M1hPTy5KOL
 gYBkg==
X-Google-Smtp-Source: AGHT+IFsCvR3ifYEzjfBNA/9SkMH09x1R02k9KF98WM2tcdaP7RQ7+b3vo7u+QRR/6Bzj3i6bYA6e3aB3PiP/xa6vCY=
X-Received: by 2002:a05:6402:518c:b0:615:5563:548e with SMTP id
 4fb4d7f45d1cf-61555635851mr5657979a12.7.1753790990490; Tue, 29 Jul 2025
 05:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250729091642.3513895-1-armbru@redhat.com>
 <20250729091642.3513895-3-armbru@redhat.com>
In-Reply-To: <20250729091642.3513895-3-armbru@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 29 Jul 2025 15:09:23 +0300
X-Gm-Features: Ac12FXwE0y9z328R-u0nAyoTqwbzSvhobN7lFugOiBSk2C5zIbeXPJgFT-k9uQA
Message-ID: <CAAjaMXYyJHaCwd_3Dxd=wDVj+kPcK-FJZQ=8e7RGD7m22NV7ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Cover docs/devel/qapi-domain.rst properly
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, Jul 29, 2025 at 12:18=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1bd69c3db..9c22e921e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4432,6 +4432,7 @@ F: docs/requirements.txt
>  F: docs/sphinx/
>  F: docs/_templates/
>  F: docs/devel/docs.rst
> +F: docs/devel/qapi-domain.rst

Question: Does it matter if this is already covered by QAPI section
which has: "F: docs/devel/qapi*"?

If not,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>
>  Rust build system integration
>  M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> --
> 2.49.0
>
>

