Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F79C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsGP-0000lI-3h; Tue, 13 Aug 2024 10:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsGM-0000ia-Mm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:12:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdsGL-0002Q7-2t
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:12:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281c164408so41296085e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723558355; x=1724163155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdqKYFqOXFkRx66mqhKBp+swgypS1ubJBEF5ZqTzKvQ=;
 b=l5b56ZE30LVXe4+sZyphvmwa6M4Gci9a9bCXZ43iAeGA/+7wRRn7N3L9b4n8qwgFW7
 B09iiYqwwCNo1UQv4MgYSq5SVNM5h+r3AZtze67XD7/A8CgeNo2uq2aJKgYaYFH7rKse
 hLA0krWqL/1G7UOQ3TblLPnjHh9e7vFHNWY5Hpfykw9jCtGA8ziEuVmVX5IpRlgYprgF
 visUuUOd+6roERTBP8D6+9gv5D3FDMk04QmH3UWLScqWf8kUeronjxsVFozRpX78BBAS
 nxz8xveTS01UsHM0Pi8vWL479qutzye7yZCENWPuKi1gqt6EYfOd+o7I8Ed+t9FNvtM4
 fhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723558355; x=1724163155;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdqKYFqOXFkRx66mqhKBp+swgypS1ubJBEF5ZqTzKvQ=;
 b=H2pPhwwFtm/HZfikRNf6R8aSkaIDu0pzpqBUpsg25XkYUHuBzKCx2coyGF+4iBqEQL
 a8hDVZ5dXpDVzs40n3CyUWve6HE/wWM4ktx1ipXnFbXlPwGybcmeK2M9oiRG4GSBE9t+
 2dQduR5urqTnRhKUd1VPSAm5iPd2yMTQu9IqlreSKu0ISkzNYQXnfsXnzGI1/TZOTOaN
 esJ9gKPivqr1AsQTdSlTkeH6LoDAsXokhg4cay88fNP31+/LHnNQ+4jAz+dlbQbkryGG
 tQMpOButgiVhHIeFpKt1QsTIfjC6LX0woxM93+8Ea2TEKve3+C8InHbjNBvKmXZ0mM29
 VhnA==
X-Gm-Message-State: AOJu0YwIevCBHC8XrdNeZHyiPOUTGZtpKgi+BCBdN/xRzvg1vCKUsfiY
 Td6oE8BX7whHwHbfSNUv1t9OwV7bBVPI2Nhr8Jts8HHybYOzrTdFkdOoNqcYIoY=
X-Google-Smtp-Source: AGHT+IHbWa+lqBftyESeJoFTjexfM9VpejBP0LaGTWu+xiY+AyRDtjdcoCVWqAGW3vLi9bv2/xfxew==
X-Received: by 2002:a05:600c:4f4e:b0:425:7974:2266 with SMTP id
 5b1f17b1804b1-429d486fec8mr27483415e9.24.1723558354977; 
 Tue, 13 Aug 2024 07:12:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7b1505sm226572455e9.46.2024.08.13.07.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 07:12:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADA3D5F792;
 Tue, 13 Aug 2024 15:12:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v6 00/10] replay: fixes and new test cases
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 13 Aug 2024 15:06:27 +1000")
References: <20240813050638.446172-1-npiggin@gmail.com>
Date: Tue, 13 Aug 2024 15:12:33 +0100
Message-ID: <87jzgka4vi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> Since v5, I cut down the series significantly to just the better
> reviewed parts, without adding new CI testing, since there are
> still be a few hiccups. aarch64 had some hangs Alex noticed, and
> x86_64 doesn't seem to be working anymore for me (with the big
> replay_linux.py test). But with this series, things are much closer,
> ppc64 does get through replay_linux.py (but requires some ppc
> specific fixes and the new test to be added, so I leave that out
> for now).
>
> Hopefully we can get this minimal series in and in the next
> release I'll try to get something stable enough for CI so it
> doesn't keep breaking.

I'm happy to take this through maintainer/for-9.1 unless there are any
major objections from other maintainers.

>
> Thanks,
> Nick
>
> Nicholas Piggin (10):
>   scripts/replay-dump.py: Update to current rr record format
>   scripts/replay-dump.py: rejig decoders in event number order
>   tests/avocado: excercise scripts/replay-dump.py in replay tests
>   replay: allow runstate shutdown->running when replaying trace
>   Revert "replay: stop us hanging in rr_wait_io_event"
>   tests/avocado: replay_kernel.py add x86-64 q35 machine test
>   chardev: set record/replay on the base device of a muxed device
>   virtio-net: Use replay_schedule_bh_event for bhs that affect machine
>     state
>   virtio-net: Use virtual time for RSC timers
>   savevm: Fix load_snapshot error path crash
>
>  include/sysemu/replay.h        |   5 -
>  include/sysemu/runstate.h      |   1 +
>  accel/tcg/tcg-accel-ops-rr.c   |   2 +-
>  chardev/char.c                 |  71 +++++++++-----
>  hw/net/virtio-net.c            |  17 ++--
>  migration/savevm.c             |   1 +
>  replay/replay.c                |  23 +----
>  system/runstate.c              |  31 +++++-
>  scripts/replay-dump.py         | 167 ++++++++++++++++++++++-----------
>  tests/avocado/replay_kernel.py |  31 +++++-
>  tests/avocado/replay_linux.py  |  10 ++
>  11 files changed, 245 insertions(+), 114 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

