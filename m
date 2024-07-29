Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB09C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 08:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMDV-0006PO-VB; Mon, 29 Jul 2024 04:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYMDU-0006Oa-BB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:58:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYMDS-0004hw-MW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:58:52 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9e25008aso419201666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722243528; x=1722848328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HRMii+RlBXa8/ciEPBTTq/5S+gWxNao+gfER2Vs4a5Q=;
 b=LpZgFGIIQGUROXO3DJSoVtuhrjVPnvM82pita6TfrqgCoH5SFZQOBrOTunS4qco8TF
 PQ28UJYyE62ogmSV48uNW5jAfdXB5E34FSj94QrYz8h8v9Aa5KGg7uDyNhth8Vz3F27b
 gTJKp5XF+jftXIgHbgTVzC/AUGEoo1wIp9gHs1PfSLAtRNvqU6NbV624uYuG8JvpYved
 xnjzy8yl6g62s8dX5fNn9GQG37W52ICocDmgwoPbZ6zeAZZbtsN7eqXfaGUWcexko4WR
 HLbpuRcDtpvXl+un12j4bzpnvvXb6IA16IJMzqEuEiwjhzsYvP1G7PWlo9unBcJljfP2
 1FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243528; x=1722848328;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRMii+RlBXa8/ciEPBTTq/5S+gWxNao+gfER2Vs4a5Q=;
 b=ESZWER47UPTqLgYSu/BF2PQauVyYMEUPIxJAE4XQUgHXW7dYwqlD8/1mLFh9XvwVK9
 FfVgD/RaRqC81reuY9mdpLmX7ylfSIMPcQ0g350yG0tbuJY62ocOCPzQoMmIviSELJwp
 GkKKAd67WaEa/97zCVqmQ57LXw2gQ7Xi2J81Q5zfTvNvzjNW4TDOXpEcCe+jTgtTrOuu
 sj+eeHhQfyPwMYmg6VSRL4lRC4LoSA5f6SRmZO/It2rvj+X4dgm9j0w+7IKMJqAUFWJQ
 c5+epm6r/huLSfkT1L1rx8I+2plLRLaU+yOGR+SARpiDrVnc/x3P5ODM3T1mNa0uNxxU
 Dpmg==
X-Gm-Message-State: AOJu0YwuKIp/WeVSGF3ig7720AwBmHCQ7lyoXdhrxp+y7IqLqjOiieBf
 Bh1x0GN/VFg5/Ng1G6k6I8IVSUZGDPJ5TPmbiJohz9CYE26SqAe+jmQNRR7AT6k=
X-Google-Smtp-Source: AGHT+IGvRmnQNZpMTFSaeTSwfi+Xtl0d0yqcwpvdYMXQ4pPV/QZOT6slESrrJG/ycVcq6xVNEj8FtQ==
X-Received: by 2002:a17:907:97cd:b0:a7a:929f:c0ce with SMTP id
 a640c23a62f3a-a7d40044af9mr512797966b.19.1722243527270; 
 Mon, 29 Jul 2024 01:58:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad91eeesm485207866b.178.2024.07.29.01.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 01:58:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2C595F844;
 Mon, 29 Jul 2024 09:58:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sergei Lyubski <slyubski@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: The question about migration/checkpointing
In-Reply-To: <CAMLUMH6dRAg+s9jzfVg3ihbE42yO1PssYLnKm-o99aEkpD8QyQ@mail.gmail.com>
 (Sergei Lyubski's message of "Fri, 26 Jul 2024 12:41:47 -0700")
References: <CAMLUMH6dRAg+s9jzfVg3ihbE42yO1PssYLnKm-o99aEkpD8QyQ@mail.gmail.com>
Date: Mon, 29 Jul 2024 09:58:45 +0100
Message-ID: <877cd41smy.fsf@draig.linaro.org>
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

Sergei Lyubski <slyubski@gmail.com> writes:

>   Hi guys,
>
> My name is Sergey. My company uses QEMU for  CPU performance simulation/e=
valuaton.
> Sorry, I found  your emails in QEMU  relatively recent commits  into ram.=
c .  Why ram.c . Because I see some weirdness in
> the  behavior.
>=20=20=20
> Our goal is :
>      a)  To boot  Linux , to launch some  TEST/SPEC, to drop a few checkp=
oints.
>      b)  To resume  execution from  those checkpoints, to attach a perfor=
mance simulator and
>            to evaluate performance at the "hot" code  areas.
>
>   How we tried to do it .
>
>      a) run QEMU with -monitor telnet options
>      b) connect  to QEMU with telnet=20
>      c)  after  LINUX  booted  in  QEMU monitor (telnet)  executed
>             migrate -d file://<FULL  CKPT PATH>=20
>             quit
>       d)  run QEMU  with option -incoming file://<FULL CKPT PATH>
>
>   Now !!
>
>   If  I  drop the checkpoint  when running  on linux a long ( endless) te=
st which  prints on      the console,  everything works (!)
>  and  the console is properly restored.
>=20=20=20=20
>   When I drop  the checkpoint  when the linux console is in shell  prompt=
, the restoration does  not  work.
>    I see either error message  from  ram_load_precopy()
>        error_report("Unknown combination of migration flags: 0x%x",
>   flags);

I suspect seeing the value of flags will help with any diagnosis.

>
>        or
>
>    the console is locked, QEMU restarts and  runs  (ps, top).   The only =
 solution is to kill=20
>    QEMU .  After that,  QEMU console is distorted and requires to type
>    RESET.

Are you able to attach with gdb and get a backtrace?

>
>     Could you please comment on the above issues.=20
>     If you need more info I can send you my screen shots.
>     Please note that  that the similar behavior is observed on  both
>      qemu 9.0  ( stable-9.0)  and
>      qemu 8.x
>
> Thanks in advance.
> Sergey Lyubskiy

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

