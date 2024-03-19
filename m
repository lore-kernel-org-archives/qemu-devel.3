Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E65C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdj4-0006gZ-9Z; Tue, 19 Mar 2024 13:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdj2-0006eH-4g
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdj0-0006bk-KR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3ddc13bbb3so21675166b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710871089; x=1711475889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIzJ0MlYTeAqrvebZ9zPQC8YI+EGPXH5EFCGUk6b4CQ=;
 b=hFDsSJ9pkRUijPtJWZuXfNmZ4c8gJ8AlBKxY+cotHO+zjlE+8MmEG/YT14wBPAmmFD
 8GPx/csQxzuCITpfj6uSii4XohVUsxUohLOqpu8uvOqLhltmsxncu88h6hwYp9SWD6tH
 o3XLNtD0d1qyE4HdynG2EQXKyNq1QowVJyXHadUod3/DFahEq2Ei2/egTq6oz6N46pKo
 cZ0LgZumwAWw+TxsmPAr5kOMa+hA1hnXUtZcRyOEzV8GrChcywUt6nrcFO0fTbW/dNoK
 nEK9Z7qixj4S3ZthLTUtXJCYChO/O90oe5RXvzlRCqOq6c7lgoP9ampAbl1i2t9b5iGk
 1/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710871089; x=1711475889;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIzJ0MlYTeAqrvebZ9zPQC8YI+EGPXH5EFCGUk6b4CQ=;
 b=WDEqgUPFUR5c4k3GlHlknjehwFAg7AYQ8msThYXRUtzge8xCnd98tzPXWcGHfeAgJh
 XfkfPvIZDA77nkd+bFV/KGoa8wCWU4J8JgV/T3Sn6jrmb7cWGZFhQ48iRjDDDlWZJeoa
 t61HmYGRt+cRr3HE2tg3wtl4UYRXrFWGifj4dAUY0S4ftV07huDYq9uCDAZ9+kfd7xmO
 Gf1m11EHsnrJLF4p8/Gu1BckjhWpHMZoySPmnUWA7jd8DHgINYM0vNHS4ED2qmFW190E
 1ntGKpMKZadKxhMJqSQ4yEab3Uz8DOLuKXSvEg5ve9iqFHiMRxNODOq8OqcEs9QfeBd8
 tqCQ==
X-Gm-Message-State: AOJu0Yxenccoy5wIDziuPjtjl7NLX5242Z93ELAvaRg+m89WGrtelyzR
 DC2UKcEWMMz/w29ZrmU/Q+oRtAtvRPh1SdVpavX1CTyLLGjOBHj17BoNIub+Ybo=
X-Google-Smtp-Source: AGHT+IHGcI4h4HE5ihojCSROY6YWxho900M1tKSH2gffea9ZSi/0sorb7pT3BqTQIi6WV1MJ0Tc9Gg==
X-Received: by 2002:a17:906:8a58:b0:a45:40e4:8c8 with SMTP id
 gx24-20020a1709068a5800b00a4540e408c8mr3022992ejc.16.1710871089091; 
 Tue, 19 Mar 2024 10:58:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ww2-20020a170907084200b00a46cc48ab07sm2052514ejb.221.2024.03.19.10.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 10:58:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83BE65F75D;
 Tue, 19 Mar 2024 17:58:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
In-Reply-To: <20240318154621.2361161-6-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:02 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-6-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 17:58:08 +0000
Message-ID: <87bk7a3xzj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
>
> That commit causes reverse_debugging.py test failures, and does
> not seem to solve the root cause of the problem x86-64 still
> hangs in record/replay tests.
>
> The problem with short-cutting the iowait that was taken during
> record phase is that related events will not get consumed at the
> same points (e.g., reading the clock).
>
> A hang with zero icount always seems to be a symptom of an earlier
> problem that has caused the recording to become out of synch with
> the execution and consumption of events by replay.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

