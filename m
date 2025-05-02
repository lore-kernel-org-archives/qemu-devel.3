Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3124C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtYj-0008Tu-2j; Fri, 02 May 2025 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAtYe-0008TL-PL
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:48:16 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAtYc-00083R-Tk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:48:16 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e756416045bso1169211276.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746204493; x=1746809293; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iglvjjFZCtDTPF4Jg1I9knCUgQ1snHxkQwUXNZrdWwM=;
 b=dq58hkSLy/yqbPTKX8L9JW7Nui4xYTsH9TWJI5Efz7WbCXHqXrBtnOUDlg34Bhp1eW
 4TE0aqWTm5PjCjBQISpPIXQS9OBQG+YJ2goMe0brCU9HXxpLkexdJ7fy2OvFvbDRbflP
 tgp9ZNNBFapdMIh2dknxzjYCc2dW0wfcUf0fGs1isXSLLo/dHSTDEIuq7vKqRhaENsW/
 y7kRlmecuXWY6M6rEq182H5gTlZg81GzhFL8XSUgSDT0I4dkYT5bXrbpS/bmwdqRa3wo
 pLOe0AFx88VstRaTr1+5OXHHirtG364apVg7VbPmqJtoz2zBrv+zZOWqadrSMRcSLlXX
 cItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204493; x=1746809293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iglvjjFZCtDTPF4Jg1I9knCUgQ1snHxkQwUXNZrdWwM=;
 b=pPxheonpW0oCre0MH7JmHChw85BcLL9KKam9Z2zxKP4Y3XAe1zb69SLw+66i1z1HUx
 yt0my1KCA8L2ZjoSYbEj8+j36Mbq7U2g8AYjySov/clqqERj+62TsjLTAd5K7Ap2vUiq
 rWowBEJvcrrMEUX7MA4sB6YSq4sPYFf54wkYe5RZx/VXt1/70506O9dNevZnuR/Xz0Z+
 0vnLuuhtDoxPTx7zkO67BjWBnDvBndOde/zGOkoyVStUB71/hF0z/PgoCrH9kutYF+hz
 EyM6w8ew7VJshQY9Zclnly41xqHQ8GiGBB5WzmuNeOl6GEsQk+qmMtkqIvIWDGIzQWPc
 a73w==
X-Forwarded-Encrypted: i=1;
 AJvYcCViC6atAD8+0agtQp9RZIcJU8Pp6lZY0keKmxSIl5N9tmMC5RcW/UDCZNIMDK7az0I4U/S5gxHuQD8b@nongnu.org
X-Gm-Message-State: AOJu0YznznkT28Z+2JgOTfe/ba4y6Wha5W4sivi6QpSAR0lZ5i4jOrjf
 pTiHPSv+fXhdqWn6UoxV3lB/ZHWiHZzRLAZnMhbAwX00LICZ1TFEbyChQp2RSb6kKwWxdagrEbM
 riwh6TM+1zL4AD4RTry+fD1MuDvdV2QXs1KyuVA==
X-Gm-Gg: ASbGncsGn81SXBcDiZyv7WOQOn7nYC86ktHC+DFnwVgR+OvmhSzrBVSl+/D9J0IsQ9X
 2FEEiVnW8RDcJlNeCCMeI50CLVFmqm9vUhcyolx7ipP5z6wMMVPFwnliPPdv+2y6vdHVoUglJx8
 GupI/LuDZKTu6vIvnNVi1QIRVTTKE1s5kDMA==
X-Google-Smtp-Source: AGHT+IG/CykXw4Z4KB8lba2JmLeszRv/c8xBv3P1os8lk/nrvqn8px5qc4rNv61oHRiWTQwM2tT9hnmGbYVqrSRqDmY=
X-Received: by 2002:a05:6902:102d:b0:e74:f068:4df1 with SMTP id
 3f1490d57ef6-e756557bb23mr4678755276.22.1746204493399; Fri, 02 May 2025
 09:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com>
 <Z-pdzUBa4CrBourR@redhat.com> <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
 <Z-07WTw4PHHKhfxU@redhat.com>
In-Reply-To: <Z-07WTw4PHHKhfxU@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 17:48:02 +0100
X-Gm-Features: ATxdqUGP4hgFxPc-D-fAywPIfuF2mfKE4VajHVlMt_HICWPwsOAT2kZ0nB7tC3Q
Message-ID: <CAFEAcA-_eaPF16f5rBhPar_kHpW49JZ4fQNPGUtd3qbNs+ktJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 2 Apr 2025 at 14:28, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Wed, Apr 02, 2025 at 09:33:16AM +0000, Bernhard Beschow wrote:
> > Am 31. M=C3=A4rz 2025 09:18:05 UTC schrieb "Daniel P. Berrang=C3=A9" <b=
errange@redhat.com>:
> > >General conceptual question .....  I've never understood what the divi=
ding
> > >line is between use of 'qemu_log_mask' and trace points.
> >
> > I *think* it's the perspective: If you want to see any issues, regardle=
ss
> > of which device, use the -l option, i.e. qemu_log_mask(). If, however,
> > you want to see what a particular device does, use tracepoints.
>
> I guess I'd say that the latter ought to be capable of satisfying the
> former use case too, given a suitable trace point selection. If it
> can't, then perhaps that's telling us the way we select trace points
> is insufficiently expressive ?

Yeah; you can turn on and off a tracepoint, and you can select
them by wildcard, but there's no categorization of them
(into eg "this is basically the equivalent of a debug printf"
vs "this is something that is a guest error you probably
want to know about"). There's also no way to say "turn on
this logging with one switch, and it will print multiple lines
or more than one thing" (at least not in the spirit of what
the tracepoint API expects; you could have a trace_in_asm
tracepoint that took a "%s" and output whatever you liked as
the string, of course). And debug-logging is more documented:
'-d help' shows what you can turn on and off and has at least
a brief description of what it is you're getting. For tracepoints
you're hoping that the name is vaguely descriptive and also
hoping that the device/subsystem/etc named its tracepoints in
a way that lets you usefully wildcard them.

Also, the qemu_log() logging assumes "we're sending text to
a logfile, we can format e.g. register dumps and disassembly
as arbitrary laid out plaintext". That's fine if your tracepoint
backend is also "we just send the text to a logfile/etc", but
I don't know if all of the tracepoint backends would be so happy
with that.

thanks
-- PMM

