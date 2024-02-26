Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D33C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6A-0000nU-1K; Mon, 26 Feb 2024 14:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reh65-0000me-Hf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:09 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reh5z-0004c0-HC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so2549781f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708977422; x=1709582222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTIUmYvDBeHjOkm9JVYv4ARKyMqKfxarRP+pX7+NEwY=;
 b=nnA2WJZHhQOapvJxEXnzkxpZF4bwZXzPR6P7ukvCHIv5VV8u1dP9QeEx8kJ57SqGXe
 c/OG6si0a22H7TluXi/R771nUXXJlE2MAp3k3zj4PuTeNyTHSYh/XtnmqTrEH/ntKaVk
 FG3qySwk8God1WULzCif59VKOhElNFs5i3i0QX8+JqIMb2whmSReVySqxwNVui8KweaH
 FIRNDaffdUNcH5/FbSHMZFEjWUx4MNaWn4I8UZQ+8/HvXgTSkTsLst9iCUjZHrqLDYqf
 I7UAny3SS9y1eHegOP/E0fryhnS9imsJn2VN1xVg9u1BEojPlm36zFmGey4IWdySolz0
 BCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977422; x=1709582222;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTIUmYvDBeHjOkm9JVYv4ARKyMqKfxarRP+pX7+NEwY=;
 b=JOuEvRHV5h3VykZSMLuGY2446l2aKNSO/u/4h+QWcgY3G6Wrr/RkHCN7XnJMtVMUmk
 B2/uu+hisdnMYNpIrklR9i+pesPtqqhhNl8mXIGtkGlscRHQkWP/2fpHMknIdxZgVxgM
 nxWKdv8XKqMgMltrUPQfQO8xnj4shtNFVLwhLpg9toLKsS9q9YEvUOjHSRgyhU1WAcUL
 8i8nTGQiH6yuzV1RievI3RiwVwPxlZlt7eHsalwH+kEV7CtQwCiAMjBqpsFEofomTHqj
 uxB7VubPhjKqmSlVujRlgCIFfWwJDJ6PLcOgt6l5+oEvGB9u3aXxMFpXiHLm7eJC8rth
 p49A==
X-Gm-Message-State: AOJu0YyZnlKPAer2WAE5mTA2isZn8eUE73RvAK2rcSDDgN0x8lGhCP4U
 qIN+ZDIaWf9rIrLvMAgAYgb8amdMu2YIc4dUcr6rCD32p4NcfnhEz1V6L1KYGqtvsRDEaagujiT
 F
X-Google-Smtp-Source: AGHT+IGhsOKsIS1GvNXuR11cQ5me5Wa//kYHulf5G9vyYj0Mrl4SVINEGWIG/X0H+7eru3KNE/F76Q==
X-Received: by 2002:adf:f291:0:b0:33d:264d:6dfc with SMTP id
 k17-20020adff291000000b0033d264d6dfcmr6200408wro.63.1708977421876; 
 Mon, 26 Feb 2024 11:57:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0033d6fe3f6absm9165384wrm.62.2024.02.26.11.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0D9C5F7B1;
 Mon, 26 Feb 2024 19:57:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: 'make vm-build-openbsd' tries to download nonexistent 7.2
 installer ISO
In-Reply-To: <CAFEAcA-3gSBhEv3GY9XeC-5nxjk9ymc7BnhUYF+Cu73tNE3uyA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 26 Feb 2024 13:37:48 +0000")
References: <CAFEAcA-3gSBhEv3GY9XeC-5nxjk9ymc7BnhUYF+Cu73tNE3uyA@mail.gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Mon, 26 Feb 2024 19:57:00 +0000
Message-ID: <87h6hvdmnn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> 'make vm-build-openbsd' has stopped working -- I suspect that this
> line from the logs is probably relevant:
>
> http://cdn.openbsd.org/pub/OpenBSD/7.2/packages/amd64/: no such dir
>
> though we don't eventually fail until much later, in 'make check' with
>         gmake --output-sync -j8 check V=3D1;
>
> Pseudo-terminal will not be allocated because stdin is not a terminal.
> Warning: Permanently added '[127.0.0.1]:33847' (ED25519) to the list
> of known hosts.
>
> ERROR: Python not found. Use --python=3D/path/to/python
>
>
> tests/vm/openbsd currently has:
>     link =3D "https://cdn.openbsd.org/pub/OpenBSD/7.2/amd64/install72.iso"
> but the webserver doesn't have 7.2 any more.
>
> Could somebody look at what we need to do to update this to 7.4
> (most recent release), please?

Sadly the installer has changed some strings so we need to update the
expect sequence.

>
> I filed
> https://gitlab.com/qemu-project/qemu/-/issues/2192
> to track this.
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

