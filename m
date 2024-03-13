Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C5DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkH99-0007eA-Gn; Wed, 13 Mar 2024 01:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH96-0007dy-Hc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:27:20 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH94-0001Um-TL
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:27:20 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a422ea50e6so95362eaf.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710307637; x=1710912437; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnXKdH2/uWP57aKF2ItTto9p7NWRfTRsqVbKFZCjSmw=;
 b=nRLKf7e14qeBM8hBNfvrRRgL5nzykYX8I6lS76lkmgAfuCOcbqgJxN+i1TTSYtw2JA
 gYqEEwQipI8vuSE/5oSONwY/XAUKzAkpgp2KFFR5U9KD7M39DwxGRtSMvly527wEhsvu
 nCxLirnyixSeslJ7CKTh3LUjo6Do2LlFlXOaKpNzaD/TrVDfoVnAIbvYDpoKHfFrnoRu
 Whfzr8WTiB94fj9NZxUUtDftL1joqDZnTY20jzM8P6iUoVYNUJyg4jyV44UEM3k2z2Qv
 ODvbVQzfM9E8vRd5gUmDMPqTK/XUnCjVbnU9DqY2eg2kMUMS138xMiAfDqeHMkACI/Vi
 oLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710307637; x=1710912437;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SnXKdH2/uWP57aKF2ItTto9p7NWRfTRsqVbKFZCjSmw=;
 b=dG+Q0WWnd19Re0/LbFUnoeRPQyAcmP7zM8AoAYdRujZfqxHz8uOxSgrUcwGeTs7DPf
 qE/tKOfF4SuU8hlILLycVoMKoiXTU3EfNBc3yA+lNeQL1ycIZwfgCNGC1UN947UO7zPL
 nNOXLDwWSNxAF0AzhOiU2LFa4VtqSNDBembd5ld7PBEr5PcYBAqs/arJls/6Wm0sD0B2
 p+hpd+JGGsF7oKt/YwNwWUFe4wkeobvSO4CQZ3oYII9x7T35Hs9rIr/L2mNwqbeESMVC
 f2QnsGaURZKHqbNQXMRBtmXD3I40kPOapxW6XrpPnPATGRhUrc+ONjnlZapCidPRu1Bg
 B0mA==
X-Gm-Message-State: AOJu0YwaQJylLnJFp23l2hjx9EuUaCvu4SkBRLFmK/uy8o6ATwxZ13pN
 WPc9Pc7NpbMArpLCCsWX8xKYmIb5kpRRKH0Uw7MOGEco2FPSYtDy
X-Google-Smtp-Source: AGHT+IEuZPopXt8ctCtN+RbTklJNLwkYT4db4caHAMMHw9nnNHv1qEDoHxuEK0pQkXMSWz6SvyZibQ==
X-Received: by 2002:a05:6358:7f17:b0:17b:f880:a3c1 with SMTP id
 p23-20020a0563587f1700b0017bf880a3c1mr4067520rwn.17.1710307637448; 
 Tue, 12 Mar 2024 22:27:17 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 g6-20020aa79f06000000b006e6baf14752sm323054pfr.58.2024.03.12.22.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 22:27:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 15:27:08 +1000
Message-Id: <CZSDGDZ6T6H1.1XB30P8R9UPT6@wheely>
Subject: Re: [PATCH v4 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-6-npiggin@gmail.com>
 <87v85ro9qt.fsf@draig.linaro.org> <CZRTTCV604Z3.3MT5MR0P5FWQK@wheely>
 <87a5n3mac5.fsf@draig.linaro.org>
In-Reply-To: <87a5n3mac5.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Mar 13, 2024 at 7:03 AM AEST, Alex Benn=C3=A9e wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Tue Mar 12, 2024 at 11:33 PM AEST, Alex Benn=C3=A9e wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>
> >> > This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
> >> >
> >> > That commit causes reverse_debugging.py test failures, and does
> >> > not seem to solve the root cause of the problem x86-64 still
> >> > hangs in record/replay tests.
> >>
> >> I'm still finding the reverse debugging tests failing with this series=
.
> >
> > :(
> >
> > In gitlab CI or your own testing? What are you running exactly?
>
> My own - my mistake I didn't get a clean build because of the format
> bug.

Ah, x86_64 is working for you now? Great.

> However I'm seeing new failures:
>
>   env QEMU_TEST_FLAKY_TESTS=3D1 AVOCADO_TIMEOUT_EXPECTED=3D1 ./pyvenv/bin=
/avocado run ./tests/avocado/reverse_debugging.py
>   Fetching asset from ./tests/avocado/reverse_debugging.py:ReverseDebuggi=
ng_AArch64.test_aarch64_virt
>   JOB ID     : bd4b29f7afaa24dc6e32933ea9bc5e46bbc3a5a4
>   JOB LOG    : /home/alex/avocado/job-results/job-2024-03-12T20.58-bd4b29=
f/job.log
>    (1/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.tes=
t_x86_64_pc: PASS (4.49 s)
>    (2/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.tes=
t_x86_64_q35: PASS (4.50 s)
>    (3/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_AArch64.te=
st_aarch64_virt: FAIL: Invalid PC (read ffff2d941e4d7f28 instead of ffff2d9=
41e4d7f2c) (3.06 s)

I added a bunch of test cases that x86 has problems with for some
reason, so it skips them. Maybe aarch64 is the same. I'll take a
closer look at it.

>    (4/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test=
_ppc64_pseries: PASS (16.48 s)
>    (5/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test=
_ppc64_powernv: FAIL: Invalid PC (read 30020210 instead of 30020214) (2.80 =
s)

powernv is known flaky so that's expected for now.

Thanks,
Nick

