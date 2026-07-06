Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74399C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfY6-0000Bj-6o; Mon, 06 Jul 2026 05:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfY4-00005w-M4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:23:32 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfY3-0006P7-6R
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:23:32 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664dd23829eso2344412d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783329810; cv=none;
 d=google.com; s=arc-20260327;
 b=ZQmXYD4vLcbVjLXmuGZiF7Johc5VvTTGCF80+mtqz6dPfNUgaZRntC+8iWI7rwNMuo
 QI7EhIS8nNWmD0rq1lu3XUtXwEIyXlTGHrb5t6pxDbTO2V5A3jEq9T7s/+3RyEX3E2x1
 gMxssjOsppAmrgICTF5H8Ib112t1MY8j7r86aBDjitcfcrm0N3oAuoC8DRKGfqamuNtF
 6AjMvDNIZUNaiSnnxOFTaNdTgVLNgxATUy2TDBzwvAT7K3XKS18YB+kSKH+MBBKeYRqA
 S1/ekvK1MyhBmznoM8tTIL2TuPpzY8R4ibXVrinV/KBLoF64ytoKbOw1WbN5gsNYB/dZ
 QX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yqsE9oL4j2+upRkRgQlld5auIFgbcSheHBEj5Xu/ZwY=;
 fh=sa54kRfqZCSJoqqovfbLshesdcnvoIzhJ6jhb/uDQ0k=;
 b=C7WP1k/EDy4ovDAeEyAAmSNgmAttNcTqYF6tfMAmjARMmzHKxuCnWCwOgiF7pIZFGb
 GfbUOjDtcHUV3DQUa8LSBw4LPxdcvUJqilvZVEO8fzJWBrUvNyHCy8RXIt6RiDmJM/fQ
 lfPOOFC+T6J6TWnYnaVYwNgUqH1m1+5wbFcpdNYq9Wt+dqQnzvtpKiMLXSY4HcVJh4Pn
 5vwRvAr5bwiLrQLMb99ZEufoDaZnzZneiz3ETvM/D6G/0yXGYuQFxBdwjwjqG5Ts836W
 j+i5cVHNGMdkLEGXmETSs+dHQ4r6ph5BclIyLDP9Nf39blZTZHsUYmVwUu5m10m6//vG
 zaNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783329810; x=1783934610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yqsE9oL4j2+upRkRgQlld5auIFgbcSheHBEj5Xu/ZwY=;
 b=fGeXOM4VUuClRjyr1ieUf5t5nYJHJfSnl68pLiFWLOtsXS+CRWl8uvsx0cd1EopAvU
 I1l4rv0J0hgP4a8w2CM7sKP2JIjsH1bnjEviTQRpcqMckupAW+sja7hNSiWMKvy+lGFi
 4bk3TGwzB4UppWf6ej6edNn3Gp4cr98LPyf5fmC7LxMDoa7uWg63htarGuw8VX39L8KI
 mhuSGeGGDM9ef7B+QIMQYBy0RnAoRd6b+3Z7pnB4mgqmvlM2hxgNHKIZH7avLGhpRQWU
 fHaWvoAPTIV1TcizVjND1/7Ho3Gcbh8xjR9NhxoONyT11/TcfY5MfDxwWAL/afTsL241
 jkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783329810; x=1783934610;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yqsE9oL4j2+upRkRgQlld5auIFgbcSheHBEj5Xu/ZwY=;
 b=gmS7vJAdDFlDzfdpLLWbgayKku+OZNQ335Lt/aVEw/IRyTTEi/gd4qg97fqQTNJwbr
 64y7pf3cdDh6jXIRJ6ukdvDDLnpsmyIy7gNwfN/No2l5owt8Q5Sxc9sefqpTKtmHe7E3
 Qpssd0N5YLzbJsfMjxcTXsJNFXuGGt+fcF8NxSj0Uo68he82LiXxD+swjfKk7bLL6ERG
 /UphKlu2IWQ5VhiVswiuJb9Dkw8JwID/cdA738FMsFEgXc8sadGtIFixy5plumQ4M7+k
 sxmEb9Ea05hHNXdn74eR+4d8MxBLkq2tKIkCD2uTM6/nczBmXTIq9Fsx6+s7q3JD5tom
 eO9Q==
X-Gm-Message-State: AOJu0YxvfCN02o3Ptj3QSwiJAN3aWW1J+xUTYcUTeSeUCO5uRQNsuqtV
 1VFkIeAGFWGMmtKOe3cIZ6H0LcQHcemiOZDZvw+BbxPQDNCIvkZ4VdOAP9XWgowL7R1hvF7Ie2M
 ESpRILqSWgNrTVrC4XKSHY5ckSn5uA59VAN5bjVtV1g==
X-Gm-Gg: AfdE7cnvl8ufRi1wlQXPRu4i1/NAwvVIHFu7O1TFfUx+N9K4U7TKFq+3cg58ChP66RV
 lovefhXzI+fUILYHN+XK+RpT5+Llc89SrGPUMyfSKiyWBxTE+9zLPi1/eHQChpn1+uEotHU5let
 iuws7zvqhvVio5gYwsY3sDWoR56kezAMjq6dTh1h6kpRPTIp+ISWF/9z+vSohQZ9zY76eW9Pj34
 ap2YYvKPqV9lEC32cODOW6P5F9rz1/e1A9AV7+GTTvQBBX94jGeRY5okcCzOOCoBQoGxSYhxuWJ
 CJzFoQVa19KPlPZ6I2/Zapdh1xUptGojBEf+YFVeybxUFXR0LOsWQUcs
X-Received: by 2002:a05:690e:1501:b0:664:c928:5d51 with SMTP id
 956f58d0204a3-66652df348amr9086281d50.28.1783329807818; Mon, 06 Jul 2026
 02:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260622060507.83195-1-kchiu@axiado.com>
 <CAFEAcA9aPwGf9acMvBMON+mNU+uyvMs33wrmAXxoTFR80vi-rQ@mail.gmail.com>
 <ae7c1ca5-2268-4b19-8ca8-188974497955@axiado.com>
In-Reply-To: <ae7c1ca5-2268-4b19-8ca8-188974497955@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 10:23:16 +0100
X-Gm-Features: AVVi8Cc8xsmR0_aNip1B6U89tY771scAEfnpl1RrRh6hqe0qLXqsJe0Raymmrkw
Message-ID: <CAFEAcA_4zrzjZq0EzsiRudBkwjM9bTai992QyDhzULnSOv2=pQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 6 Jul 2026 at 03:38, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
>
> Peter Maydell =E6=96=BC 2026/7/3 =E4=B8=8B=E5=8D=88 07:38 =E5=AF=AB=E9=81=
=93:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> > On Mon, 22 Jun 2026 at 07:05, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
> >> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emula=
tion
> >> The model for Axiado SoC AX3000 supports
> >>    4 Cortex-A53 CPUs
> >>    Arm Generic Interrupt Controller v3
> >>    4 Cadence UARTs
> >>    1 SDHCI controller with PHY
> >>    8 Cadence GPIOs
> > This causes 'make check' to fail. Please test this kind of
> > thing before submission.
> >
> > Hint: running QEMU without any other arguments crashes:
> >   qemu-system-aarch64 -machine axiado-scm3003
>
> Hi PMM
>
> Does you mean this patch set is not buildable or it must be passed
> without any other arguments?

I mean that the code you add must not cause our standard
test suite (which you can run with "make check" and
"make check-functional") to fail. One of the things it does
involves running every board model with no extra arguments.

More generally, regardless of what command line arguments the
user gives, QEMU should not crash. If the arguments don't
make sense, report an error message.

-- PMM

