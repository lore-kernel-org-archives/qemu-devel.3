Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D0CC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 15:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s94at-0000lo-AF; Mon, 20 May 2024 11:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94ar-0000lH-Q3
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:06:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94ap-0004e3-0Z
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:06:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572baf393ddso10383961a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716217585; x=1716822385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuNom45ZpE7f0NnvPCGFgzZtr0Ht8Jc6mtyjuE5tUWc=;
 b=fid4Jrs9dD4iSfnsVYrSd7rbLgKdfAL2Mbf894CX9yHJy96g+jQEmM7E0wAiKz0HYG
 ILHXrk6BRbxKYni6ISm0aMzSMBB+PS1TnCtDPV5ZDNtUfF08lHuCO42RtQYn4WqRfwTk
 HYZZyyNJ3WKY0UT/KKbPjEoAPEQZoeD1EXhDeAsoMPuGQKkGmpJi+2EVY+oRUtJ5IlGa
 j0OPIlmUmUNlKBZsYno1w+q74YX7qzlQj6kkmomvvwVxf10Ixahmq4CuvNO+nFkTqy2K
 RadPvPNL3vB3lCW3INoZgyw8bwEgxOxiqQbXs0IuwFs9muwlRA6WyWt/5LEMGxBdsYO3
 aW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716217585; x=1716822385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DuNom45ZpE7f0NnvPCGFgzZtr0Ht8Jc6mtyjuE5tUWc=;
 b=bjG1SxVqb+UQYmcNDPPc6d1fbRsbUQvRWhAxnLOGofTRGImF61Vp+gpVKR7iwC9T0G
 7Lfl9FO2dyNWXuyXqBnvGX3baQNhZ2xNva9CcTAxtZbHZeGYlTIJn6Q8gYqOgXM2CXZs
 YA4/pqvNc3R4B27Ky3+v5hn1nxpt90zZLgxdW1TCiE9+PRw2Yc+/3zeGxArqZYRYHAvR
 mni/DynnXwoh6UiyshSaj/pIsYtX7V6A0U4CtEK6EmyI3tLAcv8i1Eg7sa6BTY27NwhO
 jAIiDHrr2ltbevksJjS8kAL8n2GzqJD5LkniD+KK+H2Sj4cQDV9eiqfZoopwy41Oxn5L
 S86w==
X-Gm-Message-State: AOJu0YznL9DiChhlE/zR5JJecIAHHXSQeV93EVDJiUBDfXfixPjN83Yd
 r5oOVVKZ2MfxtT4jTkeaH7BvNcEpzDj1tjWJmS7uFBntaVcKd8V53Nt9bItE7bpRdXDkqPr3yIF
 3uUzlIqo9J8lZZ+1a6ncPjIIEKNYo2PJxjwTh5ryg8aF5B+zH
X-Google-Smtp-Source: AGHT+IFyNcsChA2tt2/l/WoZktfUsf3S685tOerKJq/vUXPIBNW3BeAPuAYULw62Pm7lDBcoP6ox4/q7uXakmlqrXDg=
X-Received: by 2002:a50:99c9:0:b0:575:95b:5109 with SMTP id
 4fb4d7f45d1cf-5752b44a326mr5233799a12.6.1716217585228; Mon, 20 May 2024
 08:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240513113513.640007-1-alex.bennee@linaro.org>
 <20240513113513.640007-2-alex.bennee@linaro.org>
In-Reply-To: <20240513113513.640007-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 16:06:13 +0100
Message-ID: <CAFEAcA-fN32yMKy=cckUayH1+VNuKFim3b0uu7QviaovTZdybw@mail.gmail.com>
Subject: Re: [Semihosting Tests PATCH 1/3] .editorconfig: add code conventions
 for tooling
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Mon, 13 May 2024 at 12:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It's a pain when you come back to a code base you haven't touched in a
> while and realise whatever indent settings you were using having
> carried over. Add an editorconfig and be done with it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .editorconfig | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 .editorconfig
>
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 0000000..e1540ae
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,28 @@
> +# EditorConfig is a file format and collection of text editor plugins
> +# for maintaining consistent coding styles between different editors
> +# and IDEs. Most popular editors support this either natively or via
> +# plugin.
> +#
> +# Check https://editorconfig.org for details.
> +#
> +# Emacs: you need https://github.com/10sr/editorconfig-custom-majormode-=
el
> +# to automatically enable the appropriate major-mode for your files
> +# that aren't already caught by your existing config.
> +#
> +
> +root =3D true
> +
> +[*]
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +charset =3D utf-8
> +
> +[Makefile*]
> +indent_style =3D tab
> +indent_size =3D 8
> +emacs_mode =3D makefile
> +
> +[*.{c,h}]
> +indent_style =3D space
> +indent_size =3D 4
> +emacs_mode =3D c

The QEMU .editorconfig has a stanza for .s/.S files too:

[*.{s,S}]
indent_style =3D tab
indent_size =3D 8
emacs_mode =3D asm

thanks
-- PMM

