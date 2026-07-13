Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjD3f-0006th-5i; Mon, 13 Jul 2026 05:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjD3d-0006st-8v
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:34:37 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjD3b-0001xT-A9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:34:37 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-667f1390f58so647032d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783935272; cv=none;
 d=google.com; s=arc-20260327;
 b=GkVOaQI2GkZUU/7dDGby+fi7JRxA11rN9mwYWxNyAwSvBHqCDisFDve8qQnxsVSQSo
 6o6czFQ2gM9GETRQDXkGe32u/yXMToNJiKQJCqv9qE2Jlq1yG57nT3qWsS/U3CKkadT9
 dTGjS9kz+oA3CQhrmjbnIMIgHR8nIFbDR4mUF+AbHY+6Xm2eJZgVtmIp7o0r/e7WyIVn
 JH8h+sleg2pzer8yNJpxoQiTP/yLn/s9onDWq+z8yxwTD+HDvkIA028iD5R9nhc0nzpf
 jZ7KDxTtZxRPRqOxs4GKpYC8rQs9X9Q3fUUn3ZVBriH8PM9yGYGYppBtFkhlatyIdNoI
 yNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6B2WnhOE8NF02oIsGMsXQEgrM7im3pLdjLr6S6+erhw=;
 fh=WbgGaTKXm6x/dcrlQxu4BHeEeg/NLuZFWdMKqrscpF4=;
 b=Y4D22VTByqMvkr7C/K3tTSZj6FfSrvXOmZzIhSQtR8+Co4yvNr5+Jee3gBrN8V4bYQ
 XYmjvNL3b6c+p2MsPxlJSOulue5J/uU0tiCnrHtHI2yY5u2LsFJxVhz6/LFEWzkAP2iJ
 3DB5SSlDP6EtJI86gIMRC3zAs50f9rZlhwbJ5Sx9/cSRAoniMg3z0wRXmZSNFqDZyRDB
 EgkRwCmxvHx0ZXZOjo3yX96XZuZ5bsGbJk+QWu9fSxitXBU3lpd3lAzF1huw6tSs50aT
 IAbTCuSQQ6HAiigFRQh5Q++3WRwHHDGryjIzTXcJ5ZqCsbDoeIy+4z0bAGehJX4jtKVE
 Gg8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783935272; x=1784540072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6B2WnhOE8NF02oIsGMsXQEgrM7im3pLdjLr6S6+erhw=;
 b=hcVhShFRFG2/xeUJrJiC0fK5lD4VwlP6E0RIW8DMVcZEorFgNjQK8IylU65rTZ+RHt
 yOtGJSmoMrNxTFK2rJ3A8m5cB9PU+ho6AV69jGLP4uuo7zEp9HMsktGryetVhzw160oK
 wgtreU0IeM0wK3iavvdH++1TFOKd1Qnqfri+m+GRhSwfE3cD32gu3/vv6GMsGtlhPT/O
 ksGRZ6LhKiWlLZS7YeDexkaGWs1/lPztcmNBAhIXx5v1arOdRztoMn82N0o9x9deUrYI
 nuPFAcvlcmW2STlD7TF2/iy/FNQsn5SR8k7xcx5U3dIwPZU4whIziNUsMD0Op9XpqQ3i
 OgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783935272; x=1784540072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B2WnhOE8NF02oIsGMsXQEgrM7im3pLdjLr6S6+erhw=;
 b=hQmmUhgUR31Ve5DAaNXjBWko/YvkwKfniip+Xy+/h2bgtwdyHSZTWmbCAjxDPFeWVJ
 xdE22/wZPlFjrZT6CImLm90qayxlx7wzs0abj5PPqUVkunYxuV+y6diO3sGkREjut5+4
 RaGHKHJLORJ97pi0187Kj/mx9WVBP2VcSxlDh3NYaZwQ4qUHfWEoWiAoJ6ihtJIWFHcE
 jO+OrcI3trnZOrFGdvJ61e8K/twkb6YiiWhu/nlrWGlcVf1Sn+UWNqrKJZBE4yF4ozA+
 2jpfLbaQXBgR4ZYYObt7TvIlmrJo/Gy33LH6nWhIIn4Hnf5s1N7JOQpEl8McrMKET51C
 k4+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhW0BYjSQDqdAvE2oer40gT3FNL8EMblYCOtxKZCgmcF9ttAgwGyk7XOSvsBRsaxuIa7oq32YgGYuH@nongnu.org
X-Gm-Message-State: AOJu0YyhKWE5ks4weQ1tB+VkW4i2lcE82E/Kyreyzs6HPz9aduDHD+8Y
 cUW5Uq9Zf6SyTfXrILr25cxbO0cXgWgIN5xrLOcQloFWKxoJtCcZFRDi+XWxLf28SeVoWZraDRh
 wF1hA/ctKzeVUeQAwqEy6P/Z2qR3g03Zo2gu/+jaPxA==
X-Gm-Gg: AfdE7cndxoSfZa9XkmuSYB3q3SprThcQnDQW5AW3cp+J+aN5iPjh8T9DWbd0adqVBwj
 BamlmKjH5tgnRXfLON0fB4cui5/zXhco7swLjNQdLX1TzyJIUTYeZfKSN27pGnZdcz6ZOgQXE0w
 m6/INIeK3HqJjOaWM5i3emxEQhbb7dUAa1vHGeGRJri3tSRm8kvE3VDtcCXjL0aVJtl0RsSbYbk
 XWJsDfntO2HlxJmYKPXyqAOKS7uMl+zKgmKw2Sia62aw00+s36QYUt1GUloFxT0z7+UEZFUBiKk
 Vx9ghsO5mDyhmQzkGKqti+zVbbiOBuEndAZPX+hPbBb1O82GQvd+2cn9
X-Received: by 2002:a05:690e:350:b0:662:d25f:daca with SMTP id
 956f58d0204a3-667d7c3e331mr4113588d50.60.1783935271784; Mon, 13 Jul 2026
 02:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
 <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
 <91ad4c80-adc6-4f37-8346-20230638e5f0@oss.qualcomm.com>
In-Reply-To: <91ad4c80-adc6-4f37-8346-20230638e5f0@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:34:20 +0100
X-Gm-Features: AVVi8CdgW8uZtfTG3CfbX0on-a2Zg1JVnLNeJcMW-0ssxWgaLotoK_8NUX27qnM
Message-ID: <CAFEAcA-hnm17d4PR0wmaKwQmM-K50nHeRYv0a-pCk3J1qUbPsg@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Leesoo Ahn <lsahn@ooseel.net>, qemu-devel@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 10 Jul 2026 at 23:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 10/7/26 17:37, Peter Maydell wrote:
> > On Tue, 23 Jun 2026 at 13:56, Leesoo Ahn <lsahn@ooseel.net> wrote:
> >>
> >> It's worth cleaning up all resources that the guest taking and to quit
> >> if an exception in el1 could not be resolved.
> >>
> >> Otherwise, the guest will get in the infinite black-hole by
> >> unmodified pc.
> >>
> >> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> >> ---
> >>   target/arm/hvf/hvf.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> >> index 8b902c6882..4358cf90e8 100644
> >> --- a/target/arm/hvf/hvf.c
> >> +++ b/target/arm/hvf/hvf.c
> >> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, h=
v_vcpu_exit_exception_t *excp)
> >>           cpu_synchronize_state(cpu);
> >>           trace_hvf_exit(syndrome, ec, env->pc);
> >>           error_report("0x%llx: unhandled exception ec=3D0x%x", env->p=
c, ec);
> >> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> >>       }
> >
> > We should do something here, but my question is whether
> > qemu_system_guest_panicked() is the right thing. We mostly
> > use that for "the guest OS wants to tell QEMU that it has
> > panicked, so QEMU can reflect that to the user and perhaps
> > reboot or exit", though we do in a few places use it for
> > things that are more like "we don't handle this case". I'm
> > not sure exactly what the right thing to do here is, though.
>
> We usually abort() for programming errors (here unimplemented
> case) and don't let the guest mis-behave.

We've definitely used that strategy in the past (either directly,
or indirectly via hw_abort() or cpu_abort()), but I think these
days we'd prefer not to let the guest trigger QEMU to abort().
Some of those cases we've been able to convert to LOG_GUEST_ERROR
and continue in some manner, but some cases are just not
continuable from.

I think we could probably use a better mechanism for "something
went badly wrong and we can't continue executing the guest", where
e.g. we can suspend the VM and let the operator look at its state:
 https://lore.kernel.org/qemu-devel/alSqlDRT9L8OqAso@redhat.com/T/#m9ab2f4a=
819e33cd5ac0f6d22ab30f98a0d599866

For this specific patch: what is the case where we get into this
codepath (and in particular what is the EC_FOO exception subtype)?
Maybe the fix is to handle that case. Compare an earlier thread:
https://lore.kernel.org/qemu-devel/8D0BCB24-BB1B-40EF-A361-0F79D65600AE@unp=
redictable.fr/

If we're getting here by falling through from EC_INSNABORT,
I think that can happen if the guest tries to execute from
an MMIO region.

-- PMM

