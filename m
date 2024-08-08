Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D64C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5pQ-00007I-Mg; Thu, 08 Aug 2024 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5pP-00006f-9K
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:17:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5pN-0004Pp-53
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:17:27 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ba43b433beso1323432a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723133843; x=1723738643; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Efwt1mG8YrRhKfCjMS6sDnoVzjTSjeueUv0ps7jdJ8=;
 b=Vej52L3ZN6VdvmenYx/ydvR3SCgzOtARKfRVuH7XjVCwo9P2yraCBjB6el0t6m2Lws
 Fq1J3eYfZW60Ux7uojt9KiUxRJv2u5q/Go8nO9heAEZ7BZaUaz+W9+D/ctky/PVy+mQ8
 K/VX40SvoWTQJtjwLrAuFTpK5QrgbXC0zfLT4SC7lNSB+8Ve30l5XsIDkomFeZXDv6eD
 jOsVqGA94hkXW1yeopF4+2LpQPu4NQXRuV7x8TjU3dwg8HTd15ynoVrJumIeVzGolMIl
 WAb6Ppc9WYNjEr0mTavLHM0Gzgoy0he7P/FdTbZ+b/StYspLFFeQqQiYmyBWplotQIPZ
 SEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723133843; x=1723738643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Efwt1mG8YrRhKfCjMS6sDnoVzjTSjeueUv0ps7jdJ8=;
 b=rMxcntmWBQl/2VGgCP+ARHABqBH0ziQjNYF9lxE4q0peULioAshmzMJCigP2Wbulw4
 5OxYUL8lWkB5UYO/RY4fl3fYgs+vKPts7OZ43SKqyQmrq2ipX5HEa0sCv9m7AeWI0Yw/
 EtKI/DO2zfg8qilLvpye7a4jf1dWNqZDdv+KysxCKpuDQc8gdxuTfttovOVECOkBpkcp
 KX1xZhvlNAtK9vkd1Um4XDU3HBjDlRKbw7INUzRG7T1Ztbqyw67QfCMDVkixKccmNbvO
 FcznIppNI+d2wR/3ZbS1o+gCpjfxOpxjnWBxY/D+ruVRNb9GODXLHOz4H4v58MRbfcI4
 Pv0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW2tv+RQAOgxljOV+dZcmAR02qB8YzEu7IVhHKMPVgzSRg/2hsPmYCIPay+DmfRWHs0qKygD0QJA2YF0/2JiGxtSldtnI=
X-Gm-Message-State: AOJu0YxcxUa1OCheNy3cmx65MHE2mpZ9PYVMVTs0XDCbAWKJigYilUNU
 WcNaiusydFP0EI2ZYzF+6cJM9hHxETFZFw4OCSwhVBUzQX1M9WlYnQk72Yz2+JehFtk8f+zmW5p
 pgi9kYtWajezZ/TJuENivz4QxZyK8BOJPWSix1g==
X-Google-Smtp-Source: AGHT+IFk2A71+OPHTwQU+9HyMZpYC0P0iL/fHLEoVVMo8Tp2XMDLOW5XZX7SHzRmW366WgTUEpJ1RtoumS9PpKYnd5c=
X-Received: by 2002:a05:6402:2346:b0:5a4:6dec:cd41 with SMTP id
 4fb4d7f45d1cf-5bbb23aa915mr2002307a12.28.1723133842731; Thu, 08 Aug 2024
 09:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
 <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
 <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
 <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
 <bf8d2172-ddd3-499c-a164-6b358c6496a7@redhat.com>
In-Reply-To: <bf8d2172-ddd3-499c-a164-6b358c6496a7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 17:17:10 +0100
Message-ID: <CAFEAcA_Zo-WmjMZwcecwgPAp_DOfaewV_nDx3QpCzYx7h2Kckw@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 8 Aug 2024 at 17:04, David Hildenbrand <david@redhat.com> wrote:
>
> On 08.08.24 17:56, Peter Maydell wrote:
> > Right, I guess that's my question -- is "WAKEUP" ever any
> > different from "WARM" reset? I think the latter is a more
> > common general concept.
> >
> > On the other hand it looks like we already have the
> > concept in the runstate state machine of
> > RUN_STATE_SUSPENDED versus RUN_STATE_RUNNING, and so if we
> > define "WAKEUP" as "goes from SUSPENDED to RUNNING" that's
> > quite a clearly defined condition.
>
> Right.
>
> > Whereas WARM reset would
> > be a much wider range of things and ought to include for
> > instance "guest triggers a reset by writing to port 92"
> > and all the other SHUTDOWN_CAUSE_GUEST_RESET cases.
> > (Side note: do we document all these runstates and transitions
> > anywhere?)
> >
> > For virtio-mem, on a guest-triggered reset, should it
> > (a) definitely not unplug all the hotplugged memory
> > (b) definitely unplug all the hotplugged memory
> > (c) we don't care?
>
> During ordinary system resets (COLD) where RAM content is not guaranteed
> to survive:

"COLD" isn't an "ordinary system reset", though -- COLD
reset is more like "I powered the computer off and then
turned it on again". A "WARM" reset is like "I pressed
the front panel reset button, or the watchdog device
fired and reset the system". We don't currently really
model front-panel or watchdog reset properly, we assume
that it's close enough to have it be the same as
power-off-and-on reset (and there are some kludges in
various places where it's not quite right).

> Effectively (b)
>
> During special kexec-style resets (e.g., on s390x there is a difference)
> where RAM content must survive:
>
> Effectively (a)
>
>
> On implementing architectures (x86, arm64), kexec-style resets are
> really like warm resets. For example, when we trigger kexec->kdump we
> must not suddenly lose the RAM content.

(There's an awkward conflict here with our rom blob
system, which currently does a "copy any guest images
back into RAM" on reset. Should we do that on warm
reset? For some usecases you want those original
images back again, but for "guest did a kexec" you
almost certainly don't...)

> In that sense, at least virtio-mem wants to treat WARM and WAKEUP resets
> alike. But I agree that simply because virtio-mem want sot treat them
> alike doesn't mean that we should represent in QEMU using a single reset
> type.

On the other hand, if virtio-mem does want to treat them
the same we could start with only implementing WARM and
not add WAKEUP until we have a use-case for it.

By the way, I assume this patchseries is 9.2 material,
not trying to fix a bug for this release ?

thanks
-- PMM

