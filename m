Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B56C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTmM-0001gt-RZ; Tue, 20 Feb 2024 12:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcTmL-0001ga-7m
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:19:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcTmJ-00014M-KQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:19:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41272d42207so1543825e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708449574; x=1709054374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR6hPfm1ZobdqDTDbD36laIpSvCWjOIWMnppowp7ZMw=;
 b=f0tckOfY8cFLwTPSfPFGYFjsEJXfSo+U4MsEgmUg05EOUj6p4w6SMV3rLDozAPyQbd
 EATNerADDVES5bwPz1wG8IiF54guS28O1NzwnTjKovkeAXjMeJdSMGkXa3OYuXMbeujf
 5nBuCBDcX2YAKN0n4RQxahA5CjzZ3p3zbUDIaZC3bOXamU7FX6vm5Pe2gV9+VIxW/Qm6
 dqWUYl6q3+4apOIselRAzfWkVEWMigAbBxvFOlSOeGSp6VeLRW8PT4nnOUEpQtbz/Zoj
 q0FRwG1jjuc5oKhOJ6ticj478VpQQLqTrI0/gmxrm9OMnMfJPZKyudYOtMhBJi1ZYF1g
 FdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708449574; x=1709054374;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fR6hPfm1ZobdqDTDbD36laIpSvCWjOIWMnppowp7ZMw=;
 b=mw8iR9jXWiNe6X0Hj9psv7EaABpC0PUYaMUlTHB1OKZqytBPsuZ2sF3Y7hOpkIMi1U
 7VxUHCOyyvCMR/F7Nfn5wEP77jqcO4C5QrFHnGj0DxMCQ8ut9qEcSp7wu4XolvmG/oIt
 C5p0yIeZqrYD50PW2lvlDUcN/qqEs/ItcDc36XhmgSfL6cBSNbqvOutgPiDvmFfBj3pX
 iwNMa6575IisKKhakVt0CWlRchBJ0CzoUgdSgAv/3G3g+Mcnfkt6iB/TgmvXazk7Sil0
 KIQhExFkSOugXIV1+BDw4wyxcHYeu2q/IKEYxWrEglAbZSkcE+pp66Be5G4GlW2B+qCX
 +kHw==
X-Gm-Message-State: AOJu0YzyDDbemCSH5wiE5hdhqkMYvbSYwZn4G+vi1pZXMqepEoIItXhN
 X4fvvP+gXJFnMn9GBkCcBaJbnG6Lw0oP3tro6VtaB39kHbfHBcFoWcw+EtBmMNQ=
X-Google-Smtp-Source: AGHT+IFrgj6x0QBYYs2Hpqlg3McEkF/ZG4DeI7g+G/k5gylCBpVcXmKtsDEIPWjcElG/4Z7IqOXsJw==
X-Received: by 2002:a05:600c:45d3:b0:410:2d72:63b3 with SMTP id
 s19-20020a05600c45d300b004102d7263b3mr11484450wmo.23.1708449573988; 
 Tue, 20 Feb 2024 09:19:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c19cc00b0041061f094a2sm15344613wmq.11.2024.02.20.09.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:19:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 462A25F85F;
 Tue, 20 Feb 2024 17:19:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Drop msys2-32bit job
In-Reply-To: <20240220165602.135695-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 20 Feb 2024 16:56:02 +0000")
References: <20240220165602.135695-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 17:19:33 +0000
Message-ID: <87sf1naw9m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> MSYS2 is dropping support for 32-bit Windows.  This shows up for us
> as various packages we were using in our CI job no longer being
> available to install, which causes the job to fail.  In commit
> 8e31b744fdf we dropped the dependency on libusb and spice, but the
> dtc package has also now been removed.
>
> For us as QEMU upstream, "32 bit x86 hosts for system emulation" have
> already been deprecated as of QEMU 8.0, so we are ready to drop them
> anyway.
>
> Drop the msys2-32bit CI job, as the first step in doing this.
>
> This is cc'd to stable, because this job will also be broken for CI
> on the stable branches.  We can't drop 32-bit support entirely there,
> but we will still be covering at least compilation for 32-bit Windows
> via the cross-win32-system job.

Queued to testing/next, unless you wish to apply directly in which case:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

