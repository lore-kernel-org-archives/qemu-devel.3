Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8152DE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYdM-0004jf-Mx; Wed, 08 Jan 2025 11:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVYdL-0004jW-AD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:10:15 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVYdI-0002nl-5F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:10:14 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so2015158266b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736352610; x=1736957410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FVaJRJpLU4ekYycAZEIHHqFhvgMhGDyd3RdZGnWR6I=;
 b=oCJ3/JydTlnL+l460PbDcwkaj1BkK3Ce6hg8xqJ/BR3gGVERzLYC2nKN6ZBCGxTMeK
 jU7B9gLl4w1MoSg12pMT7uFUSaq1XOEJiyLPHSa7NrvrUM5G0e4G7vL5ODIxCdW/HCCm
 kre0YdRA6wAn5SZupOmAg7clvAeeKDAo5fhUsYqokxveC1SEmBY4zJmbyYoTj0Y4NuL2
 ORCRW+IqMQ5n87kFK19lyvOUyE2CjJiUOHU+br173v/lc6lYqsca2y5kKyIRt4QGicAq
 ZW0g58gddeUIBfMW/fn23LNUXh/d/nPj4CmCOQGQI18xYOg/9KM1rMF91yaR3K4oEzST
 OZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352610; x=1736957410;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4FVaJRJpLU4ekYycAZEIHHqFhvgMhGDyd3RdZGnWR6I=;
 b=cZ69E1zBl3mzT3+v90qL25CzpXQnTDg5LNgijYNYZYMWHE8ruu7tltzPhyutsU5SbH
 J+minf7q71PW6QHjTyNtWiYJA2jf81gxSuW1cWgo/uL6D7Tck269HGrX193IA2/6jRWu
 pzKi98U2H5cUj2LHoL15kkKtLxXKkBPF9oU0EBr306KqNTAlM//2ZhUWKKOeTONIcuBI
 hLWRFnKw92bKUM3f5ZlG83rntwUvDg9VZtPhM4axEpSJXWKMrxx+6r/oV32dKCIvfy1+
 4CVvlkncehXa8A3319IeJ1jPGxqWmA21BQuujAjCp/cQ4XBHHrbrMxVUV+igYs8jY6E7
 w+lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4biofTqNs33pgQAYKfGQnOVPGfdk/6kwi2dOp7cZXcuxKF9F43/JN+g6O5HbeDFX1C4jZKDzc6UWL@nongnu.org
X-Gm-Message-State: AOJu0Yy6Irieuec84oULzO5vY07PHZPA38dasdHigFGxsOObJggzhdj3
 DH3aHZ1shorjQhWC8wp65M6mJgIDXhazsRQh6V1fGMdbtZZM4w+2Qf6NlfMciuA=
X-Gm-Gg: ASbGncu0HVbNIMKY9VQBFQak5wySx1iT/x9PCj7tJSpUgyY1ilBDZezdfc+P9lQ4r0E
 VswM/tmyyC3j8QfKgFuHc2yyDOKnRqPz+T+5mRtHbwkYGhITq8GVhPbyGNmNBs/WW8OH7NIreyW
 Uw+9kUjoid8JQi1rH6w/wJAoeSlkpbR7P30RSts0KHi1FiGKiVAfxdMkHeZwrgcWFYBG648BBSR
 rUkUzmksJaCdkXYmeFIclOrmtSrkTo1aSCjb02nUrvizkhV3+bGg+w=
X-Google-Smtp-Source: AGHT+IEdQL8Hbp59r2HhV//U1NxLCyafAz3kzxoxQu+Mh5jrdUg5nevrH6+tYqZWjlK3mLNOhxPpMg==
X-Received: by 2002:a17:907:3a96:b0:ab2:b5f1:567d with SMTP id
 a640c23a62f3a-ab2b5f15acbmr182977266b.32.1736352610043; 
 Wed, 08 Jan 2025 08:10:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e8951ebsm2492663166b.71.2025.01.08.08.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:10:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BCB545F8AC;
 Wed,  8 Jan 2025 16:10:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/8] gdbstub: Try unlinking the unix socket before
 binding
In-Reply-To: <20241216123412.77450-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 16 Dec 2024 13:33:20 +0100")
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-3-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 16:10:08 +0000
Message-ID: <875xmpb82n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> In case an emulated process execve()s another emulated process, bind()
> will fail, because the socket already exists. So try deleting it.
>
> Note that it is not possible to handle this in do_execv(): deleting
> gdbserver_user_state.socket_path before safe_execve() is not correct,
> because the latter may fail, and afterwards we may lose control.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  gdbstub/user.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index ef52f249ce9..c900d0a52fe 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -337,6 +337,7 @@ static int gdbserver_open_socket(const char *path)
>=20=20
>      sockaddr.sun_family =3D AF_UNIX;
>      pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
> +    unlink(sockaddr.sun_path);

Should we be checking for errors here? What do we expect when attempting
to unlink a non-existent path? -EIO?

>      ret =3D bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
>      if (ret < 0) {
>          perror("bind socket");

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

