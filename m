Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E452CA0ECD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUoV-0000eA-8v; Mon, 11 Aug 2025 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulUoS-0000dp-6J
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:51:52 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulUoP-0004zv-D2
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:51:51 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso4087585276.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754927504; x=1755532304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NSadXZ6JPtDqZmjU5fUdgp+ovRFdtaiaABDrJdAj878=;
 b=Ik5qmgaBzkGTGplcYHgjdFOa0Y/EWVFmVkirWgGvwv6VyCYaQBtmOdg+1cib+8mjui
 z9GC4q4m8fDdObWfNh4N11+Bq85LYnZvUG76KkqbjSWPLfMEEFST5og/jXZpzTuov45H
 AM6WxuNgjXk+vDpQbwYjkq4MlY0EuWGzdfLlAC/EfZCFT0eX0lA2ERVHt3ecUfzZlkLa
 UpzPIVbEe5qv4QYTDMymdLjH7VeXGvbLf49YEGQOYt0C6e60CP8VC57aNc3mld7CWVHQ
 sDc3sGRN7QfEDep9WEPHWF8KUjjU7FOHfKYwG/wQUae95oRyCo5YZSB7gTMlGy1wVCzj
 jrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927504; x=1755532304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NSadXZ6JPtDqZmjU5fUdgp+ovRFdtaiaABDrJdAj878=;
 b=MHEUEClObDvOqt2ttTMtYIcZ16M7efbmYt1yRPT2Q6MuHLLyDksZnkrUb9O+8CR45X
 DbpjDzt5gy65FxIHmBGqtB9tr6kR1dffzCRGHxdqUq0rUzEAn1HRI3v4Valhgftr1wsg
 oyO0RzNcKkqu20v5zehPFFJWFxZg0r3sJE8JNuVxfxloZyM50rUxIA1MReWdk9nSBzGD
 1VQb1sU2ALLFoojKyBcb+fbZvZuIyM19y8abELrLbZ2k5xcF0akjgkkH29iZBaVoumXl
 /T7auVbF73mXyE+2raNk53ZeV7P7NqyOeIuMAWiC4HPHbdPXNIOMAdl4xIQD5Ugu4crD
 bkGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyNL1/57tOpvCtQRaPUSigDg5FdFGw+5Kr/uJ74p2d68HqPq1zWoqpa35aYHdswmj2bf8cip2Gnk6H@nongnu.org
X-Gm-Message-State: AOJu0YwbvjYM+9cl0XUOIbpSutCXJGn0NORtAG6jpn9rAuAeIFgIJrMU
 6RH+GqD4Nw1hXp2+EEC7vMs4POB/ousfEBHGzI6SaSGYSqPkdTvev9FJuCHenAJ7+4k03GeS/xP
 fCYErwm9YCYCHGw+RRIm8Kag8TrU0+sS0gRa+UstYAw==
X-Gm-Gg: ASbGncuJcAJKf4YMDA+cxcfCO+huIim5y4np966ONI9O8NwXCrro/EEeuh3vEHFBWuL
 O1+gAOTv7FT4DwcAn6S3kfEOwxy43Luz9jaVew/1OLzPgSrYyKHJnPXHTE41MVQ97zT/ja8qVfH
 +cyPg+4WqOxheyLkhB7CipbfF4UT/98KwQvQ7vwJ7eFp49xqzKuPzFPy+WodQQRdlL9XdefX5T2
 P9NTh3j67jkunj2W5g=
X-Google-Smtp-Source: AGHT+IFaMpfBK11ZlNm7aZjj6Qo/6tJMsGVMoKDHP7p2KSdQH2fYAJZPzm6fs49YFWdJnasa16PvSMHuF6CUW4WZaBU=
X-Received: by 2002:a05:690c:6006:b0:71c:3ffe:df27 with SMTP id
 00721157ae682-71c3ffeee83mr14199757b3.24.1754927504376; Mon, 11 Aug 2025
 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QUgej+GPQAcot0H19hGvuAwtA1DXmbRScSXw=h3+vOHGw@mail.gmail.com>
In-Reply-To: <CAJSP0QUgej+GPQAcot0H19hGvuAwtA1DXmbRScSXw=h3+vOHGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Aug 2025 16:51:32 +0100
X-Gm-Features: Ac12FXyRM38EoA9p9p6DjF5URi0VVOE7HRAUEhgMHke_xszn67wlws5c5QtMC8Q
Message-ID: <CAFEAcA-3Wzr7p5anCWZncgCJcVDEwRVnZQQZ-tGR3SsYZ5i4bQ@mail.gmail.com>
Subject: Re: [QEMU v10.1 blocker] PCI hotplug test for aarch64 broken
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 11 Aug 2025 at 16:44, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi Gustavo and Alex,
> The PCI hotplug test for aarch64 is no longer working because the
> Debian installer URL is 404:
> https://gitlab.com/qemu-project/qemu/-/jobs/10981291922#L1129
>
> QEMU v10.1.0-rc3 will be tagged tomorrow and this may be the final
> release candidate. Please send a patch with a working Debian installer
> URL so the QEMU test suite passes.
>
> If no permalink exists then I will revert commit 374a245573b8
> ("tests/functional: Add PCI hotplug test for aarch64") for QEMU
> v10.1.0-rc3 and a long-term solution can be found during the 10.2
> development cycle.

This is because Debian 'stable' just moved from 'bookworm'
to 'trixie'. The URL should have 'bookworm' in it, which
is the long-term-stable URL, not 'stable' (which shifts as
the distro issues new releases).

thanks
-- PMM

