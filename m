Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABCC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDFz-0007Yw-I3; Mon, 16 Sep 2024 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqDFw-0007YS-PA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:03:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqDFt-0003cM-0I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:03:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso5813853a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726498987; x=1727103787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTS3gBhLViHhhMXoM+4avk4HTdmFPf/JKzaEjggmhGk=;
 b=LbNtZJl+K+i4bwHmilS3/NZUWDCY/qZa03cikm7M9Ec9g9gr8yvyHiO5CczM21j1b8
 ehCnWkxI2fHzVchmQ31txRygZxFEDUeTRVNzIyWCBAQsklp4DToKXa6rPn4Qce+TckC5
 j20akLnAjwl+hAdn+oWr9ZEYNk6tu8aCSvj+paLu2a0hXTVgWH8PTnaO6PBqCflSjNBD
 imBTEOImr2zBRkxtA8tZenxCk5Y9Sfj+u+AuGuL7fA8VWQE/aa3+fuJnKwpO3uTYGH3H
 7Et+jV/py1uSXjv9RPTjztP4sEiW/+DojgMPRDZPaRT67z/aIqMpSITAeKqrTlGexOET
 aRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726498987; x=1727103787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTS3gBhLViHhhMXoM+4avk4HTdmFPf/JKzaEjggmhGk=;
 b=MvwRzq9UCOB1mxzIDlhJEJbeh9JNWKVYk0qOHanDs7ks9qBVYdTEPnKFYm7YupWSXN
 bYMiG+Ro7LBLZR8aVguZR69CDiuLkckTDPvqmiQ/FmZ1TQMbJQ4rvTwDCIRG4sA4prH2
 pC4F5nLoYOxq78Tox1BKTmN2lDs9ypeai/ylDLqi6W1Ia2DMS/yI1OfN3qUTvzhjI5u4
 VhzX/ecSY2fjxL1QTxLzoNVFMo1C1CdLm/xtmfuK4n9/S/0TK6KW8PioY5vb3SFBNx5D
 PcunebilBRaLkCau1yxyrHTiDcFhJCgELQkz61COpPdhV0y7FJGC5M6bRAPrYeqcw2f9
 ns9A==
X-Gm-Message-State: AOJu0YxnOirS1zTMuG3p94F16O+vX9ol3edjpXBxkX9feaiWx1Cgmc1O
 i8XeMInvKULsMzZ9zFcTkPb4M6y60DKC75cHoYY0jvOTGzx8naNUSAkUUg/5L9xEUmovAmQZ/+H
 XwwJ58sm14fCKpQIkQMRhO/HyoPRLKl9dt6sXcg==
X-Google-Smtp-Source: AGHT+IHi73ZCw6gAHdIA4ntUTH1gKVVEnmiFkZWTBgyDpbWaK4ggJSnhdN0Fheb5k5CQbmwHjB1/nA1cSgwBmWSgSuA=
X-Received: by 2002:a05:6402:13cd:b0:5c4:3150:5ab8 with SMTP id
 4fb4d7f45d1cf-5c431505f2amr4899018a12.17.1726498986865; Mon, 16 Sep 2024
 08:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240916122603.71615-1-kraxel@redhat.com>
In-Reply-To: <20240916122603.71615-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 16:02:55 +0100
Message-ID: <CAFEAcA92v0UByDWykb7P=Ecd206WO+WNzdU2U=Q51o-fepPUFw@mail.gmail.com>
Subject: Re: [PULL 0/4] Edk2 stable202408 20240916 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 16 Sept 2024 at 13:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb=
0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into sta=
ging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/edk2-stable202408-20240916-pull=
-request
>
> for you to fetch changes up to 2b759fbc9a70258a244f98da3415947dccc2702e:
>
>   add loongarch binaries for edk2-stable202408 (2024-09-16 14:21:34 +0200=
)
>
> ----------------------------------------------------------------
> edk2: update to 2024-08 stable tag
>
> ----------------------------------------------------------------

Hi; this fails CI:

https://gitlab.com/qemu-project/qemu/-/jobs/7835418334

449/942 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
ERROR 50.07s killed by signal 6 SIGABRT
>>> MALLOC_PERTURB_=3D179 QTEST_QEMU_BINARY=3D./qemu-system-aarch64 PYTHON=
=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/pyvenv/bin=
/python3 G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-pr=
oject/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=3D./qemu-img QTEST_Q=
EMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon /home/gitl=
ab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/tests/qtest/bios-tables=
-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
acpi-test: Warning! SSDT binary file mismatch. Actual
[aml:/tmp/aml-9FJ0T2], Expected
[aml:tests/data/acpi/aarch64/virt/SSDT.memhp].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
to see ASL diff between mismatched files install IASL, rebuild QEMU
from scratch and re-run tests with V=3D1 environment variable set**
ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion
failed: (all_tables_match)
(test program exited with status code -6)

thanks
-- PMM

