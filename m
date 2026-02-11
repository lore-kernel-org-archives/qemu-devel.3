Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17529ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqD1V-0002Wf-0c; Wed, 11 Feb 2026 11:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqD1S-0002Sh-Oz
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:25:02 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqD1R-0002ES-7e
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:25:02 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65941c07e8dso8356465a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770827098; x=1771431898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmpY1MaIiRY5Uyi5p5NnR6la0iFGmmXl5ao5qHmhhGM=;
 b=jpa5GPjhS3Tm1RVDB1zHwBJITRN77W2cLPw4KQt1d+IXBgFy6JEMYvi7wtFMsC6/6g
 h0XVqpG4CuiLsrhrID2Ea6E12tLe1Vm0x31CU1j//u8/oxXkL4SVw6tmbeGodnRLzkKo
 V5hJXJ4IqYOD3xlEhPR5pc9f8O4HYlfxTDhsKa5AnaTpihMrxc94xW2wom+DSmhVqQMN
 WYtgZr+EEFUL2d3kM3M4y1NG7edP6eTVfnB3a2PeUPboWlEpcnNIVXv1+DPwFAlQuF35
 xMWMAgv48JbuCKaY9ZbazjIz2IGp//C3ixYPmltXaow7GuBauheYQoNF3PtgLdUB4y+d
 fj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770827098; x=1771431898;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmpY1MaIiRY5Uyi5p5NnR6la0iFGmmXl5ao5qHmhhGM=;
 b=RS9MnSxiDBl9ln+3T09vthHBOoaNvHfh/GJIL3itfY2lWZquCXPHOha80lf3jm2mZf
 MiyvFOqQ3dmQSsfNdlI+xT8Cu1/uLuqE/tJNM666BgEo0U/XHgd/QrRuFLW/DJh6yNAt
 4/2p5cYP56OTJb7rojJH28elLCNYMaZuCKrNlm/7yfSN/KwGfQv6lsC5AUDqsfYL//78
 61ZRMDCTiRw2As3X1ambQpVHLK1qTqpwV3LWX1lc3jo15n1gPDRqBvPBeB5fbVKjzNi0
 24xdP1cttuVz69i+Nkjx22tYr0g5+yjcjXc+BDDjzGBmlFwwc3WgyAEntJ1y7lx8hovF
 8fiw==
X-Gm-Message-State: AOJu0YwoDHHxXz2Kpd6qcEo+xIL1jvQUZQP6CILKeXY44mRHpZG8gZww
 2KYP2i/V1FlDGMXordGgBzWeYzry151Y2DmSgyIFT4s+Ufdx2cQlDl4gzGgQk7/Dtx8=
X-Gm-Gg: AZuq6aJRKjiFPACQRRtgWoWqvwqH4YVrUFXkemvGbefmG7+17bbYZdeSRMheXQKjBM+
 FonimtO7fJHQ09Sxp7p4zskfdxn7H14oxojwtjh588P13lmoxG/oNFhENsOot88XbriFi7/uZaI
 oeOamKRWaICS5hGfBJ+99oQXSfbqcwEIO05v0k2BgyLKlRHpca6vHBYdibU6NckE4QQklER9RLF
 cIxtcLoTc5YiNfXJYV1X5etCGibQpWbVSDU8kaHhycC5C6Vd8WgjDH7xL2vtqhMNQKGOj9fSccX
 PBCj3SqP3a9NEPQf0YXKGLzoP+ueSRQgr1HJzj7kfH/u9GvHg556+R6trk1BredHwRR20ANZHTQ
 o3KFv7MnwfJF6/jxjoSyNilydugPQgjA1AOLkh/I8AGKaX9MK/WY2uBIHeRhK6W7F9K5pb2VVPG
 DUxNfpq2zVt1azWH4hvTmms6NLajZ1HbkznQ==
X-Received: by 2002:a05:6402:1d51:b0:659:5c6b:d280 with SMTP id
 4fb4d7f45d1cf-65a39adc4a6mr1667600a12.10.1770827098202; 
 Wed, 11 Feb 2026 08:24:58 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65a3cf38c6asm883588a12.20.2026.02.11.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:24:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFFE65FC4E;
 Wed, 11 Feb 2026 16:24:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs/devel: s/most/most recent/
 ``probe_target_compiler`` call
In-Reply-To: <20260114102522.4044591-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 14 Jan 2026 10:25:22 +0000")
References: <20260114102522.4044591-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 11 Feb 2026 16:24:56 +0000
Message-ID: <87h5rnnt7r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/build-system.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 35c77343914..71331e64ac8 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -88,7 +88,7 @@ and operating systems:
>    ``$target_ar``, etc. to non-empty values.
>=20=20
>  ``write_target_makefile``
> -  Write a Makefile fragment to stdout, exposing the result of the most
> +  Write a Makefile fragment to stdout, exposing the result of the most r=
ecent
>    ``probe_target_compiler`` call as the usual Make variables (``CC``,
>    ``AR``, ``LD``, etc.).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

