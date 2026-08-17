Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80E1C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuzg-0002br-BA; Mon, 17 Aug 2026 06:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvuzZ-0002ag-PO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:54:58 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvuzY-0005mR-5s
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:54:57 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836cde02992so27670057b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786964095; cv=none;
 d=google.com; s=arc-20260327;
 b=MRn07K9QOGRFazFS1Q+NgOISfEdSt1a9LFJYTb0EKX9Ufm9m2bhahgMo6PdPxgFcYk
 GZOXzBvBxyLlG9v+WJp1OFfwcQHp997i0vPnbEeYsTLkG+8DAboK5mFh2mRHT7jY3/1d
 VRq0dsB5VJl9jwDbVj4xumGI4pPEHlVwQbuNxTH2I4BFd5uRflAvwlTIJXVLaEoqM1FV
 zqTF6MT5ug5j2N8ZEd9/SUK7f2Cf4eCbnwt9CiMEjfokbcONZ8mnpoBHQw3G6xQlRm1I
 PZwz+ume2MJ7A6z/IAFH7AUEGD6LJddsw3btIJ26CDVWdYTrJ2UJBaXEAJ/DjCFn40ws
 /QWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JqiudsbpXh+UoufUjd0N2so5cTk/lpnQCeZtZgT4VaU=;
 fh=yzuPFCXn95f7Fhvrva6X/+0hsZsG4fiyHsfM9iTNouY=;
 b=PiwEUHbsxRZyQfhoQEebbdMrGwfyOD/0RUFGE3F/nSgOyUPLQNKBjeYkK7t9gCANJH
 Tos0ABpWWAq7cY4dDBrZQvH8hFPfx+3nDSZppKhvilcYSXoexw/j97AF7GxRd/jPSQjM
 l2KuIxxoGyXU5XFESOSDTrPsOH5GC9nc4d0MkbLIs6m8FxeHJK3yDnrNt9/KKbiw/qrP
 Vg6Ee16TzHETS91BTVo6Tb/A6b8Jgi2hQtGAekR7H0u3TeOpp2N08w7tMrHLBQGLoAw1
 K6V/Z2m/5VQs9OsR0RxaNaDXNzsXsMukOMNX4LFpzxZgQnBTim/vibbbvf3Ac9WMp579
 klyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786964095; x=1787568895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JqiudsbpXh+UoufUjd0N2so5cTk/lpnQCeZtZgT4VaU=;
 b=tnUfs+zxRzoaGolmJlslzbpbFiYZy0xRMCHLHeZ/dLCVuzKr184J9DT4nJNZHzLkHx
 BmvTxqcFW1b9Gz6kSynI1Od3kBOF/Qr9lxp/gzjbsAz3K1gWlYkhJbrmaZKOtWspdmtI
 JXbUg3tuU7GV/5Fx6PD6ZCVIFiHNWlXlzfPAMnvHDX6gT1RZRsKnvaPbhVUFokw3eEPL
 /i4h/S9KGf9PQSRE+5e7xaVMY4v75thdZQoVkzi5G5xImFS5ZCQM3TV2zeI6f70hpGB1
 v1c5QdKWyP5HCv8m9GUJWCa2Q1EVQfpsCCGcv7c78wvtPnipvCMtFR/ktAEHVcz5mgP0
 0oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964095; x=1787568895;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JqiudsbpXh+UoufUjd0N2so5cTk/lpnQCeZtZgT4VaU=;
 b=ViWyJDd9jgR5ppUQODPUsJShXT99v5VmP0MuV2Kbn0JjYmB1GzaouyaXBJI9ZsJitM
 mFwbjE6TTBvVgHvs1GGGM/OTSAhcCR7mIvV+R9cr3ITD1bkwzek/5FZG51vD8L/zBTdX
 zaRMK5l1hDhVnHn4UnCp60c6N4qzcGkMPiTE/Bl0682O72ynfnvi2Hcs58munygZPQ5D
 wGUbV3ZT7Bc/vcW1oerCLDRE/qtW7kAQ04HCThETtWV+YeoN64Z14r8zkqTWqqkV9eM7
 c9zIe88UL7VmX8SnXSXCB3qJgI7lY/b+84GLbWL+m3Vvj5VpoiNEqBG4/z/8JIJ1sGUJ
 qa6A==
X-Gm-Message-State: AOJu0YzDWu2hNIwjywUD9MSoOX0Tl2PcCPXG856YwEWKgc8XuVb38wI5
 IXjeaTWA+qGX/APNk6JaxMCVmKy41g3PYSkbvvIew2ZrJDQHcM17v+Yoo4wFEu3U4cOlA8dPgI9
 3uw89riUzbtmqqLgzXeXiUcp/WVnF8VQ=
X-Gm-Gg: AR+sD11flCR5ltzqX4usKkyZFQLhC904qYbCpMVhlq79Pzkij/+PZgs4UbzwTclYI2f
 yp4IXKkWmHHOTzMw94hwSxoF8diq1x1r/tbXMe9fL3w+rmvlywO34H9BLUC7ihUjYXghGNb34Hr
 /btRGRsmMfP0MQv0aUsr4bSbkGhS9KgxaTDuXo/ZUlm9Stt2Ep/s8fF/82bNPBjO5zUD+eptRia
 tYD+WmK9jH2uMLQAhXmAy3+Pozj8+/1qL5vgvyiRENwxlFLrl771UgFVHMgXss1cAlb7T7RrSOj
 42wSW2cGO3QWScQbOy2wn9YZ5l6+wyEssLQTWVzEJoHV
X-Received: by 2002:a05:690c:e292:b0:81e:4e5d:484a with SMTP id
 00721157ae682-8370c93d325mr63526437b3.2.1786964094836; Mon, 17 Aug 2026
 03:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
 <54495516-9f01-4077-860a-a4c9cc612a73@redhat.com>
 <CAMxuvaz3yrNkTnYOHtDcqGgKjW=9B-v82dGHpvSYUjzgrBYmDg@mail.gmail.com>
 <225b9367-f343-4690-ac37-d2bbd57680a7@redhat.com>
In-Reply-To: <225b9367-f343-4690-ac37-d2bbd57680a7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Aug 2026 14:54:39 +0400
X-Gm-Features: AcwNN1Xewz13ybBkboE0qtsYeACRs-p_2OdwwpFRRTZaiYVjzFm38y0RkH7I26M
Message-ID: <CAJ+F1CL7VVXBa5jJKxaKQ-ZV4Yf=uoz3SSLPCcxmRH6duvnYMQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: fix pylint false positives for cv2
 module
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Mon, Aug 17, 2026 at 12:39=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 17/08/2026 09.57, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Aug 17, 2026 at 11:19=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>
> >> On 15/08/2026 09.24, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Add generated-members=3Dcv2.* to pylintrc so pylint skips member
> >>> checking on the cv2 C extension module, whose members are not
> >>> visible to static analysis.
> >>>
> >>> Silence:
> >>> 2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files =
in /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
> >>> 2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco=
/src/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Mod=
ule 'cv2' has no 'imread' member (no-member)"
> >>
> >> Alex recently already sent a patch for that error here:
> >>
> >>    https://gitlab.com/qemu-project/qemu/-/commit/dd14a21b9dc1
> >>
> >> Didn't that help to silence the message in your case, too?
> >
> > Ah I missed that, but it doesn't help:
> >
> > pylint --rcfile ../tests/functional/pylintrc ../tests/functional/arm/
> > ************* Module test_integratorcp
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
83:25:
> > E1101: Module 'cv2' has no 'imread' member (no-member)
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
84:26:
> > E1101: Module 'cv2' has no 'cvtColor' member (no-member)
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
84:55:
> > E1101: Module 'cv2' has no 'COLOR_BGR2GRAY' member (no-member)
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
85:17:
> > E1101: Module 'cv2' has no 'matchTemplate' member (no-member)
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
85:52:
> > E1101: Module 'cv2' has no 'imread' member (no-member)
> > /home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:=
86:35:
> > E1101: Module 'cv2' has no 'TM_CCOEFF_NORMED' member (no-member)
> >
> > My understanding:
> >
> > I1101 (c-extension-no-member) - disable: silence if pylint can't
> > introspect the module
> >
> > E1101 (no-member) - but we need to tell pylint to trust any member
> > access on cv2 if it can
> Ok, but could you then add it to the "disable=3D..." list instead, so tha=
t we
> disable this for all other modules, too? ... otherwise we'll be busy addi=
ng
> an entry for all other modules where this pops up in the course of time.
>

I see your point, but disabling "no-member" globally means pylint
won't catch typos like self.naem or obj.nonexistent_method() anywhere.

