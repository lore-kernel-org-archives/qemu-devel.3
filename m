Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FE2C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujc3e-0007JP-Aj; Wed, 06 Aug 2025 07:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujc3d-0007Ih-9K
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:11:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujc3b-0005Yu-9C
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:11:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so34059405e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754478700; x=1755083500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhuLg3jTkab67n224aGtZZOKE5sYsVsu+mpcgV/+QF0=;
 b=uKzKRbx8T6Stup//6YeAXRZCBO4JUkN0q10Ivfvwz1D3kOkug+zRE4AQVK1VsBTah3
 0HE59kYxoRza4j6vC7uiFR23ClMZkn1qDR1zQ7dIi2ThXhuwK6Gdit39R3YoCTNR+NgB
 9u9CVUUbnkZaNlxhyXT1E4ju8f5hKSKxKlxaTPtdklN/NBK69cjLszo+ujdIa6CPEoTk
 LIkMb+XyUupG3Mya9u/TQpmN/QA10Nocx/gjO6mDiyYtdkVBG1IoWkf6H2BmARWT76mg
 idaX6UtXzuONi3c4gfDFd95hA7RQgO4akiv1xKLBgj9WOwMZuGgt8A+Da4MP24Yk8in/
 /NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478700; x=1755083500;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fhuLg3jTkab67n224aGtZZOKE5sYsVsu+mpcgV/+QF0=;
 b=ml8cUgp0v25Th1GMAhv28ZTrdVYYl1+UadBw6XFQ7f/ZQFcjb5ZMqOXJOYntOXg0V1
 Pzo6FQ4lGPKYjBFon1pGNn2WLtcBOOUiEL8AsEPKfe6L8ab2XsfTa8JfXU/tKHMIGoNR
 ltG/LjNxf+pmixR25g7MQ/ndxlLNO9tpMeXTxaAklmSXzEItV2ikiW54ZHHpntJa1//i
 eGEUkpCpy1yW6YdNSKh5+aQbd60ULvfJZ7eGVEwmcfo50/+uZhud6gmTtw1hkkkYnmL4
 WMFiirVrqRSMLJwkBZQ4uYwbj1j1w5vIWtpPNFSluLoI9ZFFo2Q/bW8xFiNbuXvFGsas
 4xyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWy7eB3dgoX6JEFBWyelIJ0/Fys9w+3W/LGD2E+VqE6E1Nd0FfHGir3HRQCw/oBMVasfRJUwxJshPi@nongnu.org
X-Gm-Message-State: AOJu0YyNckMePbjQbPTQZpz3Xf1aCul/ZJ/uH2akkHaIzRETROJzfQ96
 hzZ+u1t39i/qbGOg0uQfzNjlq0E9mvGKPTEm4YtcxnaFBnbWvbF0nJz5qX9mZu7XjoY=
X-Gm-Gg: ASbGnctBgO1qPRfaS1ius+va25i3gh5QiffdoNh+V9C57De0FYl8EiNfsRwkTB3Uy3X
 j5L2VrGxtRjtCrsKyDrc36NRRcmbcnhCtrbahJz0JHLvWZha91dSIrm332DTiYp/IeRaCxe7T9a
 +yTHmaiF8WU8RTeI/9Ul1oHdtdDTu2ocQy32ihvllNrRrG2thkc3iL2nt1vYus6SMe7FWmP3+7j
 W5x/Pd9uPZtbyYmaIHTu5ukKqDaRba26OTa4bJGFbBJi6d/h0MtRMH8gOwXwUWJe0QuZIkupReM
 eVULBCFb+hOgHwe5xCOeWSK4xdDT5QU+l1sVIWI3Ap4Wnf6z6DyTBvLzrQLVH4jRyHs5FzQFt0u
 1gXoNX3/WaqThYRCXefcJCpg=
X-Google-Smtp-Source: AGHT+IHi/qcZbuVMlieK4WBa15pufMe/cXnftvTUAqJoCiNfP5S358f92s7y7Y1iAhg5Aq09xz6pXw==
X-Received: by 2002:a05:600c:1d02:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-459eb751fc0mr6843025e9.9.1754478700383; 
 Wed, 06 Aug 2025 04:11:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm45658845e9.30.2025.08.06.04.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 04:11:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 677825F894;
 Wed, 06 Aug 2025 12:11:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Markus Armbruster <armbru@redhat.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
In-Reply-To: <aJJGvL8feHr7Wme7@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 5 Aug 2025 19:00:28 +0100")
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
 <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
 <aJJGvL8feHr7Wme7@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 06 Aug 2025 12:11:38 +0100
Message-ID: <87h5ykzout.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Aug 05, 2025 at 07:57:38PM +0300, Manos Pitsidianakis wrote:
>> On Tue, Aug 5, 2025 at 7:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>> >
>> > On Tue, Aug 05, 2025 at 07:22:14PM +0300, Manos Pitsidianakis wrote:
>> > > On Tue, Aug 5, 2025 at 7:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
>> > > >
>> > > > On Tue, Aug 05, 2025 at 12:19:26PM +0300, Manos Pitsidianakis wrot=
e:
>> > > > > Add a backtrace_on_error meson feature (enabled with
>> > > > > --enable-backtrace-on-error) that compiles system binaries with
>> > > > > -rdynamic option and prints a function backtrace on error to std=
err.
>> > > > >
>> > > > > Example output by adding an unconditional error_setg on error_ab=
ort in hw/arm/boot.c:
>> > > > >
>> > > > >   ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
>> > > > >   ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
>> > > > >   ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
>> > > > >   ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f6=
2]
>> > > > >   ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
>> > > > >   ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
>> > > > >   ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a2=
82]
>> > > > >   ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d0=
1476ae17]
>> > > > >   ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
>> > > > >   ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a=
5d]
>> > > > >   ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
>> > > > >   ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
>> > > > >   /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
>> > > > >   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3=
033d67d65]
>> > > > >   ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]
>> > > > >
>> > > > >   Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:
>> > > >
>> > > > From an end-user POV, IMHO the error messages need to be good enou=
gh
>> > > > that such backtraces aren't needed to understand the problem. For
>> > > > developers, GDB can give much better backtraces (file+line numbers,
>> > > > plus parameters plus local variables) in the ideally rare cases th=
at
>> > > > the error message alone has insufficient info. So I'm not really
>> > > > convinced that programs (in general, not just QEMU) should try to
>> > > > create backtraces themselves.
>> > >
>> > > I don't think there's value in replacing gdb debugging with this, I
>> > > agree. I think it has value for "fire and forget" uses, when errors
>> > > happen unexpectedly and are hard to replicate and you only end up wi=
th
>> > > log entries and no easy way to debug it.
>> >
>> > If the log entry with the error message is useless for devs, then it
>> > is even worse for end users... who will be copying that message into
>> > bug reports anyway. This patch doesn't feel like something we could
>> > enable in formal builds in the distro, so we still need better error
>> > reporting without it, such that user bug reports are actionable.
>> >
>> > Was there a specific place where you found things hard to debug
>> > from the error message alone ?  I'm sure we have plenty of examples
>> > of errors that can be improved, but wondering if there are some
>> > general patterns we're doing badly that would be a good win
>> > to improve ?
>>=20
>> Some months ago I was debugging a MemoryRegion use-after-free and used
>> this code to figure out that the free was called from RCU context
>> instead of the main thread.
>
> We give useful names to many (but not neccessarily all) threads that we
> spawn. Perhaps we should call pthread_getname_np() to fetch the current
> thread name, and used that as a prefix on the error message we print
> out, as a bit of extra context ?

Do we always have sensible names for threads or only if we enable the
option?

> Obviously not as much info as a full stack trace, but that is something
> we could likely enable unconditionally without any overheads to worry
> about, so a likely incremental wni.

The place where it comes in useful is when we get bug reports from users
who have crashed QEMU in a embedded docker container and can't give us a
reasonable reproducer. If we can encourage such users to enable this
option (or maybe make it part of --enable-debug-info) then we could get
a slightly more useful backtrace for those bugs.

I agree most sane configurations (i.e. a distro) would just attach gdb
and use whatever symbol resolution the distro provides.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

