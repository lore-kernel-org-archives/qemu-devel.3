Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84501C982C7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 15:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vglf5-000887-Tu; Fri, 16 Jan 2026 10:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1vglf2-00086w-GW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 10:22:52 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1vgley-0002DW-EW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 10:22:50 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-93f5905e60eso1250850241.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 07:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768576966; cv=none;
 d=google.com; s=arc-20240605;
 b=MgsbVlAbzRtEx30yGjvIKqGZW0iir9ZjehwqhEAkHTv0i6wL0Oxl7CYHQrE0Ai41dM
 cQJ4GjU8dl71xdUlTyW6ir1hw09O1STCWC5YivCbSFvpB45+UzNMS4VjhuG6Sv0TEKTX
 eC1s9aU6nLS+4che2JEdi7BpOnzC5oYnFNqux4tkI8/PIyHT4Im/9HVthk+eCOvBKyA3
 PHBhW4JXlk7I2NmeTvEhzDuQLTSK1M4tl9QCjZXOA6YC+09hpc1rNA8B2S1ea/pJK7dU
 imleGRXqYGVetE4VDBcNCklWWPAMIR8JLAjwoSUQQU7yMpMDSRl4XDVBW/ZWwlrcurAX
 gJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Cn7TJEGLW80xXdvX1NxMATqZN6UeczIjNYExZi46mM=;
 fh=6RdNnZ/cYLz/ikEQGfFf7j7Zjtym5SGOE0+6me+7874=;
 b=lyFrXMwiMtxBpU1KTJiQKq8tmPjec0LywiccVopwwSBxxbnD6vB1DNjT+BR9c1K52P
 tNffSytnV9X4Ywpz4xTByfG839Z3EyH+iP5W1ygY7bL7VAwzjLt8Yt37fM+rxSzq5QvZ
 ZC+ZtqXcOP+Pwk2vE2QYiNPcFBU81yag2qBzPj1IB++7j+IZr8pAGkIZGfzkbnZnPl6+
 uXwlxCSNj8ZEYU0wo7G/jp5yetDOJFBIE6jNKfA8MXMHZEgIrMa1UCYVssgmoP2KNHBw
 OxkPm9dJY5TvzqpVa+s1u0lNOypRfidWQ3DqgcrBSBW4OoErasJhGiwS6QOvsY4EPIfV
 crRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768576966; x=1769181766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Cn7TJEGLW80xXdvX1NxMATqZN6UeczIjNYExZi46mM=;
 b=AqV9lzUG+GwnuDFdxLo8vjX5517Q047DhWh0fnb3MPmEOpe6vr8DqwtrsZP0vvbuLH
 s0SKaFiOP2LA2Dx1x3KQ0OPSPbL27nzOuylPzgC5DwdwlysXKcsTomFQUw7q9jrcJ5hL
 W+eVkD0nz93Ta/PERy7obz+l4o+VEDdSPLGOEVkjx9r+lafA3GKSm0FXL3zQ8pshpdgY
 XbMrOfVVb9APV2tfpOW1QTWsG1tIg4CNEG28+67XabVBokxHhDAk04sp9cRM+mRolsoy
 aoLnq+zNCSdJ8QcTdauASuCXGQqqg6YEixtcLUh/pg30KZ7v/+pJuvAbG5DQE5aFfE+4
 9q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768576966; x=1769181766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Cn7TJEGLW80xXdvX1NxMATqZN6UeczIjNYExZi46mM=;
 b=lCpTbZMDC6UV6IEuSNYv85foQ0b5BLdtE7rNbtPqKA/QbhfKR0FDBnJJawG3eFMK1f
 CE0ua0a+vYK8dHaKluejS9vZql6/BqTDlzXHcakAiPwHOW4tsZOxVh9DRKFqYMnHnXLC
 2XfpjBtNnRGOQN212lx0rMdSAxbDxP/xGY9pQMRJW235h7dJ0x6EDnU5jvte6DJxUKu2
 drvCNZbSKb7cu39Vm0HWoF+oN17V1nLrHJFKfcpDZJXR+6doLU/HnnrBkNp2tc22gS1I
 VM1e6qHbhdA8WpWWLGxwf23MeOA4G1uOTjDROoiDp/ZshVpE9jX+8Ao7hBdL8XCiwy/L
 6aog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJWuFW9k0GrWVq4ANmjxXParTWCJURiZi+AVczcGEHFnNZ2hzzsKt7RMAt608DUe2JKWH/+/V00SW@nongnu.org
X-Gm-Message-State: AOJu0YwB2QJeJOVzyr8ZgEPIpOnNeVMmvi32d7oD9p0dUZYUGqKVOuA8
 fN64hSUIh/28sz7oeua4vdRNIK6HWlxQRnxg42yPcABMROplGYOen+VbjEJSWEdA+ifJIzqZFmb
 6N+IY0fpnIdFnqG7gPdRFJOTcbbsk/yM=
X-Gm-Gg: AY/fxX6krMhpm5GLYY3fT8QAsdH3M/jcEbiE05qhkqgwDeLTxSDzacvG9ey49p581IV
 30vZ3F0ENSJM5dbFkQMhJDxyPoY8wROsWmoWZOcHZn/w2I+n/5AxeI/wlN4jAYOV8guw8vCouI5
 lV4DQ2MH28DYnvbZNCJjlYwvXMvEEGHAliadr+4wL1dNFpiBbu+emcWbunbwBajSffe0caCsEiO
 l9i3fCqKrnIfFmhN/FZm2JK4ateQjsYtcNpp9VxEIlEzGSB+OXylY40WIPR7yg/QGlD73EEfjmv
 M6s7lBWmkjS/LiF54yLLJIn7HH8=
X-Received: by 2002:a05:6102:6c8:b0:5ee:a08e:8c0a with SMTP id
 ada2fe7eead31-5f1a559378cmr1241736137.33.1768576965779; Fri, 16 Jan 2026
 07:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-23-pbonzini@redhat.com>
 <CAFEAcA-CZ-pL_nOSSinZdgmP8NbzuTN0xhRFhB-ny0NkgCfLOw@mail.gmail.com>
In-Reply-To: <CAFEAcA-CZ-pL_nOSSinZdgmP8NbzuTN0xhRFhB-ny0NkgCfLOw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 16 Jan 2026 21:22:34 +0600
X-Gm-Features: AZwV_Qg3nDreQHq-6kdc8LsjTHdD-_O5jXufws0IpvdHeKFdnNdLcJHGRFpfaw4
Message-ID: <CAFfO_h7qQLeKq-n5hngpaNYCcxiRJQjeEpiXQwk_9sVM2jQKWA@mail.gmail.com>
Subject: Re: [PULL 22/49] device/virtio-nsm: Support for Nitro Secure Module
 device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Peter,

On Fri, Jan 16, 2026 at 5:45=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 31 Oct 2024 at 17:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >
> > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> > for stripped down TPM functionality like cryptographic attestation.
> > The requests to and responses from NSM device are CBOR[3] encoded.
> >
> > This commit adds support for NSM device in QEMU. Although related to
> > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > used in other machine types as well. The libcbor[4] library has been
> > used for the CBOR encoding and decoding functionalities.
> >
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg0038=
7.html
> > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > [3] http://cbor.io/
> > [4] https://libcbor.readthedocs.io/en/latest/
>
> Hi; this commit includes a file hw/virtio/cbor-helpers.c which
> does not include our standard qemu/osdep.h header:
>
>
> > diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
> > new file mode 100644
> > index 00000000000..49f55df3994
> > --- /dev/null
> > +++ b/hw/virtio/cbor-helpers.c
> > @@ -0,0 +1,321 @@
> > +/*
> > + * QEMU CBOR helpers
> > + *
> > + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "hw/virtio/cbor-helpers.h"
>
> Is this intentional? Could we make this file include osdep.h
> as our standard practice requires, or would that break something?
>

I don't think something will break. It's just that when I added the
file I was not aware of this standard practice.

Regards,
Dorjoy

