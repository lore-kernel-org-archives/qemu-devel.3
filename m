Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1ABFE5210
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGF4M-0005Cm-L3; Fri, 24 Apr 2026 07:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGF4K-0005Aw-Nk
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:51:37 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGF4B-0002nN-OM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:51:30 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79db5e18ac6so92544937b3.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 04:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777031486; cv=none;
 d=google.com; s=arc-20240605;
 b=UheEFIgzs1J4gChQ8OIg7qV7Z4rHuX1/sPiiBMZiWtV8sBhfbfPCTolgb9mdHlX+4F
 DEg2+50hE9xdhgJSUaBY87yk7/HcsYXniv8Sc2cW6511q76+BLLz93EjfwQwlXFG1hAS
 /Nnc4sNrN0TWTKCAZEeP1bFygijAmxmGu57JT+3/8XTSba7KtR5nz/VdH2i++Gr9BR8B
 CQt3IePAKAbC7+o62XE18q4IVE9VD6CT1vPUd4eWIVOIUxdi+oaDluQ0f81AMG2uJzz7
 rkIn1fPKZsw+0vqleZpX91r+Th1rB5GjEgRa5RX04092XaXOEZrMP4UOJCELvt7pLyAW
 r30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aADK6NGaSQ6jDLzgHLvLaSvVqcL1IvEiArKRA4FowUo=;
 fh=z6AaIQNSaWSNIPmRXuDA9F0UbA5m57xfRMn3CrPCpPU=;
 b=G6c3yqAC+rDpiB/JsvBjdqf2IxBciJGy0JCdt8YaEKW1MkpJFIPl37wXgPaG0tta2E
 5LTyNuFTXq+5iw66a294BsvNCiypF5aLTWm8o3jOv0EKWYZ6EQ0YXYfSWKNAPRWAhfW1
 4xzVGyKmqWpGnbha1MJq4i7Q57G4UsX4cxnOjMHeN+GE6TVKA4hTHAJVl7nWYQVrBlNA
 Fc+Hrf7mtMGWHUMPLyO6kovKnMpunE7XIkfbxcWnzufKRVSKyAfErQACdeyDJtoYH/tn
 +pMegKneJw3b6eeg8YAKE5CE3wMqTnrVeU9Voh15nA0rVz8rAf5WHlYTsNOnqUFXEDlx
 ZwcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777031486; x=1777636286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aADK6NGaSQ6jDLzgHLvLaSvVqcL1IvEiArKRA4FowUo=;
 b=AeM2f7RiUHebFP4XM1KJRi5guBBuD6BieNbRLtWYFEhNY+bkloe6RoJoLhjXs6LGo2
 7guSrboaGjlGevsL3rKKz+guZ0r1U/F8cLiqqjOMQqLYew5nFKuat65QbEaIv6KNs0v1
 4yQf6cAAS8d1mg+RcwzuqSlhsTNEzu5FRHIOSTT0woO0Pagb5GSRaaFFpW/UdFT242mx
 9uq7w+lazefzziO/cmkPGBPp1Ad9tmv9JejKYfi+5xAeBHFbkgdF8eYatJ7Y1WVuZgSf
 3dl05tOpZBlQ0g+cdz2IaX9ex6cFzxtIvaPJIgQx0ovXY1aBxx9KIWZ8ROvt8H/FHWK8
 ngnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777031486; x=1777636286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aADK6NGaSQ6jDLzgHLvLaSvVqcL1IvEiArKRA4FowUo=;
 b=N1fZXjUN6mBdK5mbvqveV8qouFXe92Z28tJfcC9u/FjxagIDWKUUFyFutLj1ktSGZO
 FK9rBblanRScL+/0tWhB4T5AfT6sXVZ0AOf2sA+dwwfwtc4eCe5lMMy+RLhMBCS2w93l
 YNSSTWJyNOlJPvPETNTfClutKBPkaQsXfLPxh4Cf83+KKWXZmNm5MbxVw+SKn+lGrZOT
 eKagA5b7ZARUhEBCScqx+eT9zQ0TMzft+bkZ3KYg9QNk6ZoIGy17OQyufVt4uDR70iWy
 XrhEvmJa25FW7tqriz54shjC2lItFID3ZmQnMoHT+nfdiMShMpZXXtlFVIIV+u/ZXkIP
 HW+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3VsbiYZXxp1db9+QuruBLIQC0+oFDBx9HslMQ+byPG9RNE8yU9bUtPJVjZ1oQ07uoiao2oUtxyNDT@nongnu.org
X-Gm-Message-State: AOJu0YxPAb8bznc12wEEdbQgX2g/EIozm0Ih7sr3kXMMddPaIBxa34Bu
 Dm4vwrxwOVVzbENTLN18AThZYMzbqcdE6gzcB1B+Lgm4kFtBw9BpGHf8T8nKm7UQsnjmNo/fnND
 lddRfwkgUwMRpvYlPOIzTiI5pnlIjUE22jNMX+6FD3A==
X-Gm-Gg: AeBDiesgS3eaSfbr7Zw3W05buJ4G0HHemCOU5cM/xNhRCwDOgrbDs4GgVDTLBD9K+Lb
 /TnnH6ARYXQo3VfXhffp79njZNZ1lvGYxSBb+hXqJGST8ltPgP6QFUBBZT6VwBcC3rOAt3YWIEb
 M6MZXJesKL54mhokzQLAzVDtF6NiML7oVGMOE9p+pbiaSPgOy8oW1aWFZO2v+VfSZfeX24Dfgy/
 7i3C4BTwJ2bCE3llDoTBKc+3Mbj78PAyN2Fm2rlvI1h3in8AqnbmyJb2EDfCI6l3gAuHuLqm3gj
 Zp8YKSHzHmSCEKVZm+N9Xd7r5j/tIb/rB0qdz6BCwRbeVaF4sawZinT+fAKnzOoYO/4oRpIlGev
 j2JLtgttIQPSC
X-Received: by 2002:a05:690e:130b:b0:650:1aa5:856e with SMTP id
 956f58d0204a3-65311beafccmr20815130d50.37.1777031485985; Fri, 24 Apr 2026
 04:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com> <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com> <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
In-Reply-To: <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 12:51:14 +0100
X-Gm-Features: AQROBzBMy2AjmO9dx-K505fJ9xL3QVkDzIqOIqaZOywoLlD6pbefOYOI8InzlQk
Message-ID: <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 24 Apr 2026 at 12:32, Elisey Konstantinov
<elisey.konstantinov@gmail.com> wrote:
>
> I understand it=E2=80=99s a niche use case, however, =E2=80=9Cniche=E2=80=
=9D doesn't mean =E2=80=9Cbroken=E2=80=9D
> Currently, QEMU advertises support for PPC Mac OS X guests, but it doesn=
=E2=80=99t work on Linux
> for certain versions
> My patch fixes this breakage with a 3-line change, proven to work
>
> If the root cause in UContext takes months to fix, will you leave the fea=
ture broken for all Linux users that long?
> Can we apply this workaround to unblock users now, and continue the inves=
tigation in the issue tracker?

QEMU covers many more use cases than PPC macos emulation.
As Daniel says, this is very niche. It's almost certainly the
case that your proposed change is merely hiding an actual bug.
The coroutine backend is a fundamental part of how low level
parts of QEMU like the block backend work, which are heavily
relied on where QEMU is used as a virtual machine setup with
KVM and other accelerators. Changing the default here affects
a great many of our users. We should not do that only because
it happens to mask a bug somewhere in PPC emulation for
a particular guest OS.

If this was a workaround that affected only PPC and was at least
obviously a change to a PPC-specific part of QEMU like a particular
device model, we might take it. (Though even there we might say "no,
find the actual cause"; workarounds once accepted have a tendency
to stick around way longer than they ought to as people forget
whether and when they can be removed later). For a workaround which
affects every QEMU user including all the performance-sensitive
VM use cases, the answer is a clear "no".

> If not, what is the official status of PPC Mac OS X support in QEMU?

The "New World" and "Old World" machines are listed in our
MAINTAINERS file as "Odd Fixes", which means:

"It has a maintainer but they don't have time to do
 much other than throw the odd patch in."

In other words, there is no active development work ongoing,
and nobody with time and interest to investigate complex bugs.
If it happens to work for people, that's great. If it doesn't
work and somebody proposes a patch then we can review the patch
(as we have done for this one). If it doesn't work and nobody
proposes a satisfactory patch then it will likely remain broken.

thanks
-- PMM

