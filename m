Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8C0C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgvf-0004aN-2i; Mon, 10 Mar 2025 13:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trgvd-0004aB-Pj
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:28:37 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trgvb-0003K6-Nb
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:28:37 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so3564400276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627714; x=1742232514; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+aQVNKGdvVqgISDOWbZzds/yeU5qoIuTz9LPLRXzFo=;
 b=kRHWQ63hOxmN5pMwrKZHPIJqk76igUpcOiL7cZqnof0H1zaAlOgu//n8zid3oJNFpm
 JFxzs+fE513Ogl9mBOkm0Mjm29mIRy6oi7CgnRTktJUG9RRItoJvFl4V1cRz45bOA/w6
 DgkpmFvdNAz+ykCP5VV7HiFAUjeoTYGNbO/HHS1YrL9RDDDI2/mYBp9SIEH9FeiCBL8q
 zY9LgFcXQtOqfGtghRwv/TLQ6LnQycMTD8ZubyGXZ+KLLlq2/6wVBGyUFb38RSjgOG3d
 fDuMrYtsa2COQIe+nZbrQU8QnPrFI5E8eRt7/NJWJjjnbxe3FvdYHR8cSZuRlF8SJsUn
 totg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627714; x=1742232514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+aQVNKGdvVqgISDOWbZzds/yeU5qoIuTz9LPLRXzFo=;
 b=SulokbctH95X6ItEn0CkLZAprA0AkOE6d3Qt8yY2M7WlIKBRIOa6uhUnNDXF9zI5Pe
 dFGDnchcMuYAw6hqWjsijpbk7zqRKjUmjArdgnbpjI1Sqi7NYu1Fq+8kCSmrdbqJb2F9
 26rJK95iIQGnTU/8XTbmJKWkOM3tHwsyOCcqFyMhiPTJFlB4IlV0xcNfpo0t5r1yxOfR
 VxSFom1s4hbY64Ai8f4GKoPrH1Z3zv31nh+CNEYvT9FpOxC1IbELDMCCNLsBXQp65qxW
 xX4utjG6x8JQv6EcustAsdLXams3SFkYwnViJeGbeT4H7VUoFo0ryDny4HMeRG8XWns8
 vl/g==
X-Gm-Message-State: AOJu0Yxd5VpBpow4oDxBp3xpbuWUOoU6XZu67VhuXo6y1RVs6LLyFLuQ
 /oB0qJMdhJyomFARa0idkJ2rFR9TrKsIu1UvcIe+a1eE11ohAPLx+zPU3gxAKVEo2kytioS1vml
 0VfNWSXJP9f1cSl3pkM9+0P3oANDtTUQLgcC45w==
X-Gm-Gg: ASbGncs2E9wFvBQv2ED3tqD7tz1Nt/nUooyM34BKS5sFy+VpNljS9EqGFKhAZ4bDoVy
 h/Ms2Dpzht65OJ9/PU8utrmW+FTbOUVhthBuU7PSnoqyq0Vq/eWZlo7jYByeXmQ1z7lJkFbMmLO
 m1XQH2QLpJEmllOdZCKkuH6Gy9GLk=
X-Google-Smtp-Source: AGHT+IFn9LN/8rYO1/l1ZXVt6zj4pVzPF4tgz8dn2zdoK5tPlvHcJR/eOQdNN7xQ6P2i28Gk0du0ofxKrksAUXHTAPY=
X-Received: by 2002:a05:6902:4707:b0:e60:b153:1c95 with SMTP id
 3f1490d57ef6-e63b51583f3mr473254276.6.1741627714022; Mon, 10 Mar 2025
 10:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250310012825.79614-1-philmd@linaro.org>
 <CAFEAcA_fRWgntwbiFiDJqAkthR8vBzrkLOLkp5GeHD9O8xTMCA@mail.gmail.com>
In-Reply-To: <CAFEAcA_fRWgntwbiFiDJqAkthR8vBzrkLOLkp5GeHD9O8xTMCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 17:28:22 +0000
X-Gm-Features: AQ5f1JqfUSaaRXhVD-DJtdZRzExhnA4EBN730uEgwxRQrU-7pc1cZ9YbEkGKLHk
Message-ID: <CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 10 Mar 2025 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 10 Mar 2025 at 01:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > Hi,
> >
> > This series add support for (async) FIFO on the transmit path
> > of the PL011 UART.
>
> This hasn't made the last pre-softfreeze arm pullreq, but
> I think we can reasonably call "don't do blocking I/O"
> enough of a bugfix for it to be ok to go in early in the
> freeze cycle for rc0.
>
> I've applied it to target-arm.next.

...but it still fails 'make check-functional', though in a
less easy-to-reproduce way than it did. The problem turns out
to be that when the guest kernel is doing its earlycon
output (which is by polling, not interrupt driven) the output
can be corrupted, which makes the aarch64/test_arm_virt test
fail to find the "Kernel command line:" output it is looking for.

This seems to be because the pl011 code and the chardev
code disagree about how "couldn't write anything" is
reported. pl011 here is looking for "0 means wrote nothing",
but the chardev code reports it as "-1 and errno is EAGAIN".

I think the chardev code is actually what we need to fix here,
because it makes basically no effort to guarantee that the
errno from the underlying write is still in 'errno' by the
time qemu_chr_fe_write() returns. In particular it may
call qemu_chr_write_log() or replay_char_write_event_save(),
both of which will happily trash errno if something fails
during their execution.

So my long-term preference for fixing this is:
 * fix up any callsites that can't handle a 0 return for
   "wrote no bytes"
 * make (and document) qemu_chr_fe_write()'s return value be
    - 0 =3D=3D wrote no bytes
    - >0 =3D=3D wrote some bytes
    - <0 =3D=3D a negative-errno indicating a definite error


I had planned in the meantime that we could deal with
this by squashing in this change to the last patch in
this series:

--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -275,6 +275,9 @@ static gboolean pl011_xmit_cb(void *do_not_use,
GIOCondition cond, void *opaque)
     /* Transmit as much data as we can. */
     bytes_consumed =3D qemu_chr_fe_write(&s->chr, buf, count);
     trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
+    if (bytes_consumed < 0 && errno =3D=3D EAGAIN) {
+        bytes_consumed =3D 0;
+    }
     if (bytes_consumed < 0) {
         /* Error in back-end: drain the fifo. */
         printf("oops, bytes_consumed =3D %d errno =3D %d\n",
bytes_consumed, errno);


which makes the code handle both "returns 0" and "returns -1
with errno=3DEAGAIN" as "try again later".

But even with that I still see the check-functional
test failing on a clang sanitizer build, though without
any clear reason why. It's intermittent; running the
test like this:

(cd build/arm-clang/ ; PYTHONPATH=3D../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=3D./qemu-system-aarch64 ./pyvenv/bin/python3
../../tests/functional/test_arm_virt.py)

I got one pass once but mostly it hangs after printing
some of the early console output. A debug build seems
more reliable, oddly.

I'll try to continue investigating this this week, but
in the meantime I'm going to have to drop this series
from target-arm.next again, I'm afraid :-(

thanks
-- PMM

