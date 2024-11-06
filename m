Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD6D59F67
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8nbv-000343-BL; Wed, 06 Nov 2024 16:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8nbt-00033r-TX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:30:42 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8nbs-0004bf-5R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:30:41 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e601b6a33aso222825b6e.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 13:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730928638; x=1731533438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqXsIZtuGIOuW5Gn43DKmDnsK7qTSNWkCXc4v8P485Y=;
 b=OVijuyvsD5hu/A88fbR9fRQzeiQLFNj2CQY9GOxV6u3CuEEK3v8fMLIjWfbt2BFs2c
 YfzVMgs9qVdcxUQ9WwyDE1VxPX1DY8vJwCqj7l5ORDrxHdaXXzEXhfMbeDlf+mnM3Mhz
 +VCQFdl92YpQtpQdAoD5mw/2g+DCdEjVBVD8EnK5ee2SYhiMNiZB69NikVtnut36sQAL
 /rsdNg4KVASEVJDbMuX5UfyaFFstZlh4PawHVVp1CPhbOIcOFTnbkRndflvWkM1m62JV
 D9/sILer0Z+nvYR+PsslPpi+Zb7Fs0aGQWNqc0bEK7R7RZ3FixLmdiH1i7Lkuk2A8fjW
 llbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730928638; x=1731533438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqXsIZtuGIOuW5Gn43DKmDnsK7qTSNWkCXc4v8P485Y=;
 b=P43qcdoOVZjp2H/ZacW/TKVwrNH5RF/fLalrwEkReQP6Rf7E3IyzTq5cP1OJO6PVUi
 2RYupR/GvhBEb1Jkr80qwHf6n2bRVT/O5At3D1iftRW0AsME6hfBXtQT5cO3CHwzAeib
 CvxSfmom6eEwMuxupgNLF9ftL6jzSvc6engbtyzidu+wjH01JsTKoJLAC9VMfuYeOURh
 pCizpJZwfgh+b1jb6511bbYgaP4tKEjyBxE0KnvfR/8frkjP4gQmieVr4aGkr1lh1YbO
 6su4eXCXwWdahRrbBlTK9Nmc9bwWZgclLWQa04kzyCxgCJmbd6f3580W2YpO92kJuSwS
 vU5A==
X-Gm-Message-State: AOJu0YzARQzD644xr/d4ZUFNshqfvLCdqxd8TdoouixpnkzbddP0owjG
 W3XsWtb9fOP9+A50DI9NQeTPsGuqrp+iaDaTOhi+NRov9ApOsATZZqpHS/V3B+Zk2TyVrggx9GZ
 N/Tb5rcna+RCvP24amfLou3az2So=
X-Google-Smtp-Source: AGHT+IEz7T94iHR/Q7B1nR0yV1pX9EXa1wdQaXsM80l9RYv9581ebtVRAUh5CpIqa6iQEeCeFSyspGL+iDubWi4iLXQ=
X-Received: by 2002:a05:6808:15a5:b0:3e6:4f27:5c7e with SMTP id
 5614622812f47-3e6608d66f9mr23239248b6e.21.1730928638637; Wed, 06 Nov 2024
 13:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
 <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
 <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
In-Reply-To: <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 6 Nov 2024 15:30:27 -0600
Message-ID: <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Nov 6, 2024 at 3:10=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/6/24 18:13, Noah Goldstein wrote:
> > Question about impl regarding handling of `-execfd` with/without a prog=
ram name.
> >
> > 1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
> > 2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.
> >
> > Do you want to allow both of these? If you want to allow (1), what shou=
ld
> > we use for `argv[0]`/`exec_path`. The program pass ("ls") or
> > `readlink(<some_fd>)`?
>
> The canonical response is, examine the kernel source.
> We're not implementing this in a vacuum, you're replicating execveat(2).
>
> I suspect the answer is (1), to be compared with
>
>      syscall(__NR_execveat, some_fd, "", &["ls", "-a"], env, AT_EMPTY_PAT=
H);

Err, I think the reference for '-execfd' is `fexecve`:
https://man7.org/linux/man-pages/man3/fexecve.3.html

Which doesn't take a path. So I guess we just interpret the "ls" as
argv[0] but not
as "exec_path".
>
>
> r~

