Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B75BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 17:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEsgE-0005JH-MK; Fri, 31 Oct 2025 13:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEsgD-0005Iw-2b
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:12:50 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEsfx-00029K-PV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:12:48 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-78488cdc20aso36016207b3.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761930747; x=1762535547; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2SB9POBkjg1Us0sUG+3O3Z6wvadHIuK9NbeMFU1sRIY=;
 b=qnPl4+rvfW66hDtP0XkdVM91rHXWkRTX5iFMpBy5/uLVAxndmTweGO597rQgWAndnI
 ff6UJ54IQlcovcA1r3Ogt797hdoZrRLysd8bAkeH6XsHPmwvnpHtRI3BNw8xvABvteIp
 Zjx7Eyo7QMVWicpdqyDscmY92IF7JRbT5cijoCML78qlxcOn4tnmRLVWIu0yI7joBbvY
 Tb2B9ivjmnIC9HZoCGpmvEFic5BO+LynpMB1MICwgNrdZ5ElfBlydRkJEeCeUmEo2ZrZ
 GUiwRRrS0J9DN3OCbb9mhSNPtEgn34kQ5647i83u3g3dq1CGKbe88EakJ/TehEhNjnxH
 /bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761930747; x=1762535547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SB9POBkjg1Us0sUG+3O3Z6wvadHIuK9NbeMFU1sRIY=;
 b=c2/eysKNUcnhFtfobJFXDTcuOJ/WOdjnFAxOHQ0rI1HKtsPiqhmbrqe3ghAEsaXSAu
 O5ipYCBlUCEE7jSIt1KiWIuvoRq6hamWvbPUyM51Wu3svUleKUcmoT3rrUVwf6roAms7
 gtNUhBjSeuHQP60oZAWlMIaD7nASaAB2ojyRvsoWVT3lXphnBcqJ86lgs7pmyTkSb0eI
 mxlWq03/2tA1KLdBKuB3PhSretLL9b8PLNRXpP3xfpcVb4d0FygpDk3rtGnF1TVpEbwk
 fQkq33Kcl5ugMuo5eXKkBhgO0JqA8SS7AMpP9NM70mhNmecjF1X4lTve5BVGuzTnQBWF
 4xrg==
X-Gm-Message-State: AOJu0YzEu0Uub5nD2KMTmQFuN7ea0o3ZpfP6kb8s2rumci36pIrBN0Ac
 RE25n8xhPFoIPV3Y2kuxhz8GK/wdoZiZrc1m1V82aa8MkHGP1GzBQbqzjZWZR1/OEl3Ng+BwTs/
 QOW8CDSMQDDqNRTWTasIXrDl0HotUBbNV4+sVnm6Wnw==
X-Gm-Gg: ASbGncsFdQ48uATymRvCjY/BI7kG/LvfHjiBYrWX3+6Fn+PujgmHp5V7i7bSeSob5tJ
 ApIS6LiJLkgWW0QP+gFknGRbj8FfN4dcXKuSGdQb6dwpv+puw0dwbiuzv8HOQ1ByNs3HGqTWEQt
 Vr++DdEwujR2MNr7Vzwnq7qErZH0g6ciKNSkh3LpJpF9grRMGc1QKBGWZaU1Ptn7lf8UKCs0BoP
 HQ9pO+VrhrVKi52Cwf6jQ9pPBvLJAzy7/2v/qOjIhmZTjJ8gCvv5xwkCQGtc/LNWoNkYfyeBuOb
 2RUrl/8=
X-Google-Smtp-Source: AGHT+IFCte1X8y4YsdxnWBtbHiM0a3qAzsqv3mQGAYobUBkzvYIkCor5esJxpwIj7FPkYrgHHWC1AZbfBR/c8surOxo=
X-Received: by 2002:a05:690c:3385:b0:784:a2f3:85e0 with SMTP id
 00721157ae682-786483e8aa4mr37133117b3.2.1761930746785; Fri, 31 Oct 2025
 10:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251029142311.2986-1-shentey@gmail.com>
 <CAFEAcA-CGQ2JwDoBVZNhQyBMNKXbZsy2Ds+=m0MAPq0hrsWHhA@mail.gmail.com>
In-Reply-To: <CAFEAcA-CGQ2JwDoBVZNhQyBMNKXbZsy2Ds+=m0MAPq0hrsWHhA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Oct 2025 17:12:15 +0000
X-Gm-Features: AWmQ_bkPj_LxqpykJudvE1UxVO93iHQc-pfGpj_kX67HAiWOeDGk0rwbnXgfw7I
Message-ID: <CAFEAcA_sbvMEJ-oTxTYOutgUrH0iapNcJrsZd3=Ov6wNn-NE3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM Support for imx8mp-evk Machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 31 Oct 2025 at 16:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 29 Oct 2025 at 14:23, Bernhard Beschow <shentey@gmail.com> wrote:
> >
> > This series adds KVM support to the imx8mp-evk machine, allowing it to run
> > guests with KVM acceleration. Inspiration was taken from the virt machine. This
> > required a device tree quirk for the guest clock to be kept in sync with the
> > host. Without this quirk the guest's clock would advance with factor <host
> > system counter> / 8Mhz.
> >
> > Testing done:
> > * Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
> >   `qemu-system-aarch64 -M virt,secure=on,virtualization=on,gic-version=4 \
> >   -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8mp-evk \
> >   -accel tcg -smp 4". Observe that the `date` command reflects the host's date.
> >
> > v2:
> > * Mention various tradeoffs in the board documentation (Peter)
> > * Accommodate for single-binary (Peter, Pierrick) by having CPU defaults
> >
> > Bernhard Beschow (2):
> >   hw/arm/imx8mp-evk: Add KVM support
> >   hw/arm/imx8mp-evk: Fix guest time in KVM mode
>
> Thanks, I've applied this to target-arm.next.

...I've had to un-queue it, as it breaks "make check":

test:         qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test
start time:   17:06:52
duration:     3.70s
result:       killed by signal 6 SIGABRT
command:      MALLOC_PERTURB_=155
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
PYTHON=/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
G_TEST_DBUS_DAEMON=/data_nvme1n1/linaro/qemu-from-laptop/qemu/tests/dbus-vmstate-daemon.sh
RUST_BACKTRACE=1
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
QTEST_QEMU_BINARY=./qemu-system-aarch64
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
QTEST_QEMU_IMG=./qemu-img MESON_TEST_ITERATION=1
/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/qtest/device-introspect-test
--tap -k
----------------------------------- stdout -----------------------------------
[...]
# Testing device 'fsl-imx8mp'
----------------------------------- stderr -----------------------------------
unknown type '(null)'
Broken pipe
../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)


I think the problem is that you're trying to use ms->cpu_type
in the fsl_imx8mp_init() function. This doesn't work in the
device-introspect-test setup, because it is just instantiating
each device for test, not running a full machine.

I think the way we usually avoid this is that if an SoC
device object needs to know what CPU type to instantiate
it has a QOM property, and the board model tells it.
(Annoyingly this then means the CPU instantiation has to
move into the realize method where the property value is known.)

Philippe may know if there's a nicer way to deal with this.
(Would it be too ugly to just handle ms->cpu_type == NULL
as "assume default"?)

thanks
-- PMM

