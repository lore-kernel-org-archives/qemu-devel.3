Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A23ACD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyL2-0000e3-5C; Tue, 09 Jun 2026 11:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyKx-0000Wc-J5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:25:55 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyKu-0002Bs-Lu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:25:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68ced97b6eeso7710331a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018751; cv=none;
 d=google.com; s=arc-20240605;
 b=TNq2L2al9Q5QBLxRiYspWwcMZ5A+u6FasRYHNkQ/CxbonpNjZO8qnV6pTFvfMBkwRH
 Lg8mul1iNj3iJF814mvkB5VJOyIsMZHqmDCS5arcHOWx2qE4eRvYjemXZyvT+TRip7Le
 UQqtbQm17PMseAYMWE08MWojPPk/Gdx3xssW1/PZfQAEI7xITkPC2KmQ/okR++8P0xDL
 ojXRyDGcfTXfyv67V1HoJRbgcvP2iy5A4s+HlXA/Pz3DWCvkC8k7tSRz0TFgxd8RJuF2
 8db1j3hep+LFfxlM9f8lduR/wJm+r0mSRjSdy6pnwiZ6mUAEnAvLit5BPDm7+HXhCt+P
 ILLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o7hZxrOxQsSfFXsDoeNg7xAeFrfoXUdRu0/vaXFQ7xY=;
 fh=OMhF2zv/Q78szEeh4hotKOsfH7jZcIoksqjymd8fAkY=;
 b=QKdInQD4caWY/waa07u3My8128N0gglA/kHgn7PjfBbVRT+7x9VEnSb3D8Vacj1dbx
 1SxucH97aXVNi0ppsC6zHn0W1F51rogd+P8cr0Ksy6f43/4L0r3hM3BqpH9XrTe3rtHX
 yX5VSibYZcXvUrJskZRlLmtyoG3cLk891oFRMEWSQggxxM12NQcQhTaYPFvxwlpKpgQ2
 r/brF0QNiOJx/gMkY3a/EMpPijvdvQ9AlJdBX79t5cAeFLt0TPYHggVYCyh6EOu+YH6U
 mSLa4r6mHT3URebVW3GWMEAD97xcPlLJynk4SRd1fxi7DzEg+8QWA2diyuW22kywe0hr
 sVMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781018751; x=1781623551; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o7hZxrOxQsSfFXsDoeNg7xAeFrfoXUdRu0/vaXFQ7xY=;
 b=eqhVwtcdaKQeArCD6FtycGKL7q1qZQ6cQ1GmgGkzDpl50mzaFNd87uWORVrsEAa3S8
 grqqV1IA5c5hZF99TRecLJCxO5oAvwSO4YRJ7ceU3+pyHuV3hho3k5jPFAPEuiSIKVH6
 smtbqWI3pozrzX5NedRQS90irhd13VhIA9XbWkpr7D/XfuBCyA5L5w5PAVKTadZuPQ2a
 Ke/R5ICvfUH8AjMO4l8UIHreEbI4ur1Ha8dCdSLlnX204JkAn6suW01wX+mslYUEmgSO
 PW9gpoPWCVw9FhD9mNKmZQI+J1yA7tY4nt1CjPkadMkovMaDgI1VeTOMHhn5Bb8aIGTJ
 5pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018751; x=1781623551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7hZxrOxQsSfFXsDoeNg7xAeFrfoXUdRu0/vaXFQ7xY=;
 b=RfLTOvqzT1jTiWI+xW+MLy5ZOIh7gtFDSKu59BjwQwjqvdMdwgB59N1AgkGLarB9+m
 rv3LP4mr7bigfHJ0QxQKSOzpR6liDsL+LVrKhqGovXAUaObAUWqFZbvCE5s7E4Ro1liR
 AsfRECh/uC/zm8IcDBsm2huxyRwlKSLhEiBOQRHQUF/VPwEPHlfviZQfmXiO8SAjoTNR
 v+7Iv2EU0T14EbnrCFtuP32aF/gIFYjdb05RFW91s2JOx26wlZqLE5VmnSPbfhBpnS3N
 35ya9Z32OqUMD/uPRlIB0cMAqdJZnnXF4T5o4pGG+GQKMvvfrLaMzQm8DyzEIghf7m5S
 vhaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E4x+MPc7puA2mEklh/jzYJDNjchMZovn54gQwlYgwtYYhCknuRcg1dOg66Qp6s7pyBerF6S/0Th1w@nongnu.org
X-Gm-Message-State: AOJu0YyRHlTT1K6ELRqIOmhMgNyCnjv03mOP0FlVgPhzJTStbOs9uaSr
 RaA+BKF8M3npekPDJA9Y8aT8SBzPDHfIcDlqzREQ10SowwUVSqJCxEyjwyzJSgp7tCucIAjOnv1
 qX4ov+o7jC5dWRhK9vYqBVseIOzrgkT2v2SfV3rw6Sg==
X-Gm-Gg: Acq92OE5hphGCixs8estpG4+toCWsz9J+lt2Qx7OCr18sZiySn5suJ0Z8L8hnQ2EME1
 xbK3S5h7Z2sEpBZdwPrHCzLTcuEqlwwig2Fb+LY4ddSVguQuMFIDmxr5H3cdOr8YnsVn6kuqHU5
 NEMjMtw+5oL4mQ0nSttX/Fo+g+V0/McWwYKQEteqTu9HwIYHzJdLUlKCVWjSRDvhr3y95ZvZu7K
 ZCk+yAHRQeYgZxh/D9tdbW2oKSWOxMwgI4GZ4eRw4hQc1X0UyzAUeMmEhRt3OEMkuRVUwnD98EX
 HDl/A08jEKCVtqkwPYEs9xKiye5qHxEpx/78pqgMgcn4g9V1R3o9OcAm+aR0kBi/SSJYQ4VSUBv
 CEg==
X-Received: by 2002:a17:907:6e87:b0:bee:b5f2:639d with SMTP id
 a640c23a62f3a-bf370376bf2mr1047493266b.10.1781018750780; Tue, 09 Jun 2026
 08:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
 <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
 <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
In-Reply-To: <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 16:25:37 +0100
X-Gm-Features: AVVi8CdB3SImlFLR632tnSYS0KHxqTkH9TALVmIC-IdIEoCpYoimC7lGmw54OfM
Message-ID: <CAFEAcA9N_O7RZRU+SPTfB_ePasjVZvUsFPhndfQDuHgQ+4Q-5A@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Titus Rwantare <titusr@google.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 9 Jun 2026 at 15:52, Titus Rwantare <titusr@google.com> wrote:
>
> On Tue, 9 Jun 2026 at 04:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> > I had a look at this bug earlier, but was not sure that this is the
> > right thing. What happens is that the guest does something that
> > causes the device to queue up data X ready for the guest to
> > read, but then instead of reading it, the guest does another
> > "I would like data X please" action. My guess is that the way
> > the hardware handles this is probably not "add the second
> > copy of data X after the first one". Perhaps it is "drop the
> > data the guest didn't read, so the next guest read gets the
> > second lot of data, not the first". But maybe the spec really
> > does say "you can do things in the order 'ask for A, ask for
> > B, read data for A, read data for B".
> >
> > I couldn't conveniently find the pmbus spec to find out what
> > the hardware is supposed to do here. We need some input from
> > somebody who knows about pmbus.

> Queueing reads are an implementation detail I decided on, not part of
> the spec. How the data gets discarded is up to the device
> manufacturer.

So what *does* the spec say? Does it just say that if you don't
read all the data before doing something else then it's all
unpredictable? Is there a way for the guest to get the device
back into a sane state after it's broken it like that?

-- PMM

