Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5A4E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUoa-0006cW-9h; Tue, 17 Dec 2024 05:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUoX-0006aQ-3R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:28:29 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUoU-00077W-GZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:28:28 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6eeca49d8baso43555487b3.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734431304; x=1735036104; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kaPsc9feCuvoLCjWOqgOWlOcfR2XUn3EN3VHL2kW7wI=;
 b=ISrzPrulAihQC6PzmUfeBdbJwMUfxJZWM8BANrG4D1cFrhBaMA+HlO2+VJFu14YR1b
 pez4BrgnNoz6crGE7IoQk54KR2N+Ec66I/LXqK9lSgmYvHNfB70Sg6IADFs6wUpS7Qr8
 p513RXaPsuiKjl11jXWFg+droPh5r+s3Ms3xsUXuNP/iDIQUvaJGgoeLuEbO94a6M+Ir
 Cnk495TOzI1WGd9kTAKkMYbBEY/PpB+oySEXaIkv7GZWCfxyXOW07JVoAq/vhTv1NgnL
 K7rFWCsghtqZlOs39d2P7tv/lSYkShijpQIp0xVX30mNwLnbf/U86rQS6lHWkhTGDO1s
 l3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734431304; x=1735036104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaPsc9feCuvoLCjWOqgOWlOcfR2XUn3EN3VHL2kW7wI=;
 b=vMIblc4qJm4TY4X/6vKQxN2laQH4XF1ERcmZ9cmRglbNjPHMoJVy2XFi/qweKRIQrt
 HQ3H1G7p40FucMAJQ7NPDaUyaZw17wHG8pZy6UlbNqJSivazwU4iyr9L8+/5E3MWUVCF
 gbgrzf6s7KgN2EbJmCf6e/nTh1gIepxLJ1rNoYUZkVO4XkW5H02imE9nxlvJmq6SpY/D
 Tve6K9FP1Mh2Jo3sozO22wnJjzDbrtpelF4YPK9H7mp/Z39NGOREgQ7mWaYzJBbA6wUP
 4xOjsAYPsTgtcwDzCnIu9lc4KjpdzGDJ5PqLLbbDMnVWfciqhWkJzxZF2TNmuC6CmWXi
 +8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrboad3bb5FjrkDRHBEu4OSnUFSIkCHGRlvpNo2u755l6X/o12n58/sIFM1i/NgG5KyNJcOPYhM0K@nongnu.org
X-Gm-Message-State: AOJu0YyLdEHif0vCb8d8Zmz88nPPxLwlLlEAYkU827H+OytNLgrsrQm5
 qgcV+JfdI64XTumJIiwf5nC/gG2n/kSPE0zwKyMDeQO/7ysO/suE8KxSRrQL0oLvLFvXnT6Udwh
 vP1zr3E2br2mE9wQ03gL1Cxggf7fgAOAc7fH65A==
X-Gm-Gg: ASbGncurvDewWCPh2YWFPWpfP2yH7TebJ38IcxJu8Ozast61JsdWUMpGXJmUu+MmIEP
 vZr+QFr8XVWsmmoDAvdqodi1su9bYKw9AXDm5ptI=
X-Google-Smtp-Source: AGHT+IEDNgFl/P6FRcYViOEEfRF+0B0DJ3tDGoX94v7JkkcRnbuwh8MF6k3lYqcD0GjwOyH+m8nT8aUQxWm8om9IF6E=
X-Received: by 2002:a05:690c:60c3:b0:6e5:2adf:d584 with SMTP id
 00721157ae682-6f2bbb1e460mr16863217b3.14.1734431304387; Tue, 17 Dec 2024
 02:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20241213224020.2982578-1-nabihestefan@google.com>
 <CAFEAcA_MR86C5+jV9=uQsZZ905w7+OgHozfQZKYXx+=Xdv_xqw@mail.gmail.com>
 <CA+QoejWYCMYRnrO9JnN9pEiJt0gLDUu8g5kkVenzp+xJeJp8Qg@mail.gmail.com>
In-Reply-To: <CA+QoejWYCMYRnrO9JnN9pEiJt0gLDUu8g5kkVenzp+xJeJp8Qg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 10:28:13 +0000
Message-ID: <CAFEAcA9Av_40TirO2a1uH9iEi_HdMkV-NcSJn8XqhLfL+mOvgA@mail.gmail.com>
Subject: Re: [PATCH v2] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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

On Mon, 16 Dec 2024 at 19:27, Nabih Estefan <nabihestefan@google.com> wrote:
>
> Actually after some more debugging with the help of Roque (cc'd) we
> realized that this patch doesn't actually fix the issue, it only hides
> it behind the watchdog.
>
> The root issue comes from
> https://lists.gnu.org/archive/html/qemu-s390x/2024-09/msg00264.html.
> The function `qemu_clock_advance_virtual_time` is broken with that
> patch and the conditions of the sse-timer test. In the test (and other
> tests) we run `clock_step_ticks()`. This function calls
> `qemu_clock_advance_virtual_time` which now has a check with
> `qemu_clock_deadline_ns_all`. This returns -1 if there is no timer
> enabled, making it so the virtual time in this test is never updated,
> thus leading to the failure. This was surfaced by the INTEN fix in the
> watchdog because now we don't have that timer running free out of
> reset. Once we enable the watchdog timer, we make it so
> `qemu_clock_deadline_ns_all` will return anything but -1, letting us
> continue through the test. My theory is that in other people's local
> builds (as in one of our local cases) there is another timer being
> activated (which in our case was the slirp timer) allowing the test to
> get through this failure. This patch only covers the bug, not actually
> fixing it. We shouldn't actually merge this, we should instead fix
> https://lists.gnu.org/archive/html/qemu-s390x/2024-09/msg00264.html.

Ah, thanks for digging into this further. We already know that
commit has problems (reported in
https://gitlab.com/qemu-project/qemu/-/issues/2687 ).

Alex was looking at this -- I've cc'd him.

thanks
-- PMM

