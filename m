Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C156C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgKMc-0004Ud-Ae; Tue, 20 Aug 2024 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKMZ-0004U5-7f
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:37:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKMW-0005ZH-LD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:37:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5becc379f3fso3902968a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724143026; x=1724747826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuLPoW6l8s29WziZnN+BpIXkTUKReSVF73v2af5K6IM=;
 b=dePXj+2lYQ58cVBMiJ/EA0tFxkf/jhwWXsyp85YfZ4Sd4f+YKcpoOPQeVXwFzGWWvN
 DxAH1pPNisQn3obaENzpB+eKNVv7JhJRDya6ESCkPCGH+XKajgQxCQOaKGkHJ+H0K/M7
 xwo8izNTT/u+thk0+hDb/eJFBl8MZnWQCjw6C9rr/jmGvTIKwgD+aSya/4Z72hbmgCV8
 JPIp/hEQC5TtV8DoA/MvoPZ78r0hxdlLgXBQxnHcdrgKh5El/QcYK1bliP5lqh7fx34E
 8cnkRf7aEZYySR1WqSJTj15OukzIBzNM3v0jh/ow4dk3EV+EMI2Zviab1JsyiPRA0qca
 aAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724143026; x=1724747826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuLPoW6l8s29WziZnN+BpIXkTUKReSVF73v2af5K6IM=;
 b=nwaabx/AAP2HWDsYdYrzQEObA12Y7AiAgFVDc/Azd/2SR2MrVUZ0USItMKLIMaYDEP
 r/jvkOCFB6QyYl/WF5BOn1yJPYxw13ZdqAJS3HrCmlRhJq7wYRaYmHcePlsGE2N+Uy+d
 jY33vy1rfdAUAjWWS84F2y0VjI3xWP7dM4cSX0yR+T1D5LXX+4yrRB9YoeZ0OjIvI/9j
 3w9U/U1zftdD6N9bfBQsHIGr9BfnX47fQWBTpd/sHJeKrXg2OKadx1J5Q7yDgHZ2OpzW
 x/WIxfYUtaC3IWVvzYyOH/hERdplOvHRUX/V8PPfCf0mfzKR8S1N85SSfZEFyTNZtVqL
 0Rug==
X-Gm-Message-State: AOJu0YzvwbSwmy6AULxflgludkADXjZadnRfhofFhwiiPw5N6BxXYzeQ
 RVuqDPipXYyAVrQ4O6MfdkSdWWHvbFeV2FuApAD8TzetYSfeUtePcGhY1FTtldp1M/9cDM1IUl9
 kpYSvY5lyt/hJzwSvhyEcC87yI0fdlF1U5QKMwxCbJBLEezhS
X-Google-Smtp-Source: AGHT+IG85F/2KPIlDd+ID3YZfGZyD0OKcRFGl+l2nRZ/1Rzmyl4SG0tEAnUXyD2czFCMWStd+HZjsY6JAag8H+wZSfs=
X-Received: by 2002:a05:6402:2350:b0:5be:ec7f:3bb2 with SMTP id
 4fb4d7f45d1cf-5beec7f6708mr6583891a12.0.1724143026488; Tue, 20 Aug 2024
 01:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240819170700.61844-1-peter.maydell@linaro.org>
 <87sev0m9tm.fsf@draig.linaro.org>
In-Reply-To: <87sev0m9tm.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 09:36:55 +0100
Message-ID: <CAFEAcA_Gw45Ux+D4S6DF2Apc983-gWTHnzHAJqBDSkcmCYbZgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] scripts/lsan-suppressions: Add a LeakSanitizer
 suppressions file
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 19 Aug 2024 at 23:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add a LeakSanitizer suppressions file that documents and suppresses
> > known false-positive leaks in either QEMU or its dependencies.
> > To use it you'll need to set
> >   LSAN_OPTIONS=3D"suppressions=3D/path/to/scripts/lsan-suppressions.txt=
"
> > when running a QEMU built with the leak-sanitizer.
> >
> > The first and currently only entry is for a deliberate leak in glib's
> > g_set_user_dirs() that otherwise causes false positive leak reports
> > in the qga-ssh-test because of its use of G_TEST_OPTION_ISOLATE_DIRS:
>
> Shame we can't share with scripts/oss-fuzz/lsan_supressions.tct:
>
> # The tcmalloc on Fedora37 confuses things
> leak:/lib64/libtcmalloc_minimal.so.4
>
> # libxkbcommon also leaks in qemu-keymap
> leak:/lib64/libxkbcommon.so.0
>
> Or does fuzzing make some things easier to hit?

Ah, I hadn't realised we already had a suppression file.
I think we've just encountered different things.

Plus the fuzzing disables qga-ssh-test in
qga/meson.build rather than suppressing the leak report.
Maybe we could move that to the leak-suppression file,
or maybe it causes some other problem in the fuzzing
context rather than merely a false positive?

(There are also a ton of reported leaks in the GUI libraries
we link against if you run with the GTK GUI, but I haven't
investigated those to see if they're real or something we
should just suppress to reduce the noise.)

thanks
-- PMM

