Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE7DD6206A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLUc-0002ui-Jh; Tue, 19 Nov 2024 05:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLUV-0002tD-VM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:29:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLUU-0002Mj-4w
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:29:51 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso6738714a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732012188; x=1732616988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=31S/gPBx567OTdkVGKSNuBJlJHg1VUWDKIvZRCSBvUE=;
 b=nIRKKUQSex8AV5fxBMl+ixAwzQEKcVaxE6x2cw/i3dk6RfLSk8sjdNNiz8oLIaPx/S
 jbOIEfNPkUSW7qOXkplr0arB0XULZgCIf+BEH4y6QSI7Yri2Ct0UUny6GfxYv7+pYOx/
 lC7OXyWq+4tqwAQZARiUK142EYNIxtQ/Wr0aUcoCL5HdWW/cJ8v+T6pTxRw7D+Hd55GR
 PWHHv8mci3+d3CsRmcGQki1/hJqLvYUt4FMaaKZRjOR1IUQSr3WIGHXNpIz6tNrFdmjx
 3ggG93unneUOqpkYQbDDIMCQ+6jP3vuOY+J2GLwNe4RRZiFr3LhdgkanrtH+T+AsgQxE
 p5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012188; x=1732616988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31S/gPBx567OTdkVGKSNuBJlJHg1VUWDKIvZRCSBvUE=;
 b=XrkVnOsyjsRjBRoI2cvOfwQyYUSzEf2JBfg1tjmiSFMzZ6xzHq00LrQaACnI/5SBG0
 r2Dt8vZWGx+nB9TSGffwuXDlJEQ/U/sA2BXN3owWaXT0SD/JFwzGdZZhRJBrJjHcUpbD
 BwM1JY1ItpjjrRk6q1gnes81syoL6VUoCba61j1aD04RuC/a98/6w22R/yidVLDiDLuC
 7GtLnta9mILf98WhpFIiHoe2jT6X/og2+ow+JHgqa81INztbq14GC1Rzy+K9V5GUEwyT
 t4ElhqzSD8bWF8nc32CUqM2LWYmy/7MqOsDMt71FyfjYKddVeD3083Q900dzR//ZNBqk
 IasA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9LT9WzvJSr2ivcpEO4WBwLbFSb8Yl/RKuupeDeDLmColjG5VeWlb2opA8am3f+PtISLe89qRdc5B5@nongnu.org
X-Gm-Message-State: AOJu0YyZLCtcjl179tOvL3kbj2MBYc03u2ffYDSJo7UGF2a4VZGuZtQW
 2iUiJWFKmZhe+L19D6H5JECDWiMtKFs8A5cNgUtOlbN0RQFjgWzXr0ZQG/HngZM0T97JcK7n0Ld
 UXHdVZ+49Mm3hJYdINUAYmYNknw8fDrMAYap0e1di5MvvSnNy
X-Google-Smtp-Source: AGHT+IE3cd65j30foB32REYXvQozf/FvgH1lcQ1k1kLG8OesyYWp3zHd0mLUTN6ja1EV/rdPfqHUHa/Ulh3TEnHC7uU=
X-Received: by 2002:a05:6402:40d2:b0:5cf:ddc5:b6e with SMTP id
 4fb4d7f45d1cf-5cfddc50e50mr2095705a12.1.1732012187768; Tue, 19 Nov 2024
 02:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20241118021820.4928-1-joel@jms.id.au>
 <CAFEAcA9tPhbjnJ6XjMcZq6iWS4i1BdrTB+=391L5UgaVSMkCLQ@mail.gmail.com>
 <CACPK8XeFP+fmws+tcG-qgz1WXyKAtMicpfcgDG-pd_jp8PLXwQ@mail.gmail.com>
In-Reply-To: <CACPK8XeFP+fmws+tcG-qgz1WXyKAtMicpfcgDG-pd_jp8PLXwQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 10:29:36 +0000
Message-ID: <CAFEAcA_+YvS7zTuosAxK8zMgBTD01SRheAat7WbHsfLHCCFGcA@mail.gmail.com>
Subject: Re: [PATCH] hw/aspeed: Correct minimum access size for all models
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 BMC-SW@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 19 Nov 2024 at 02:53, Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 18 Nov 2024 at 20:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Have you reviewed all the device read/write function
> > implementations for these devices to check whether
> > (a) changing the .valid value does the right thing, or
>
> I read the implementation of the read/write memory ops and I believe
> it does the right thing. We want devices to accept reads that are of
> any size, instead of returning an error.
>
> > (b) whether there are cases where we should instead
> > be updating the implementation and setting the .impl
> > min access size ?
>
> Reading the documentation for impl vs valid, we definitely want to set
> valid to 1. There should be no machine check when performing byte
> reads.
>
> I don't think we want to change .impl.min from the default of 1.
>
> I'm not sure if I've missed something that you're trying to point out.
> Are there gotchas about setting valid.min=1 that I should know about?

The "gotcha" is that the memory system's implementation of the
size 1 and 2 reads when .impl.min is 4 and .valid.min is 1
(as for instance with aspeed_apb2opb_ops after this patch)
is "read 4 bytes, return the relevant portion"
and the implementation of size 1 and 2 writes is "pad the
small value with zeroes at either end appropriately so it is
4 bytes and write that". That is often the right thing for
the required behaviour of the device registers, but it is
also quite common that it is the wrong behaviour. For instance
for some devices the write of a byte is supposed to only modify
that byte, and leave the other bytes of a 4-byte register alone.
Or if the device has bit-clears-on-read behaviour for a register
then the default handling will incorrectly do that for bits
that the guest didn't actually read.

Conversely if the device leaves the .impl.min at its default 1
and moves .valid.min from 4 to 1 (as with eg ftgmac100_ops)
the device will now be called for byte reads and writes at any
address in its range. If a write to, say, byte 3 of a 32-bit
register is supposed to update bits [31:24], that won't happen
unless the write function is changed (usually if there's a switch
on offset the write to something that's not at a multiple-of-4
will end up in the default "log an error" code path).

What this adds up to is that it's a bit misleading to have
a single patch which changes the minimum access size for lots
of devices at once, because for each device you need to look
at QEMU's implementation of the read and write functions
together with the spec of the device, and confirm that the
right way to implement "byte writes are supported" for this
particular device is to change .valid.min, and that you don't
also need to make changes to the read or write function code
at the same time or adjust .impl.min. Putting them all in one
patch with no discussion in the commit message of the device
behaviour and implementation was just a bit of a yellow flag
to me that maybe this complexity wasn't considered.

If we get this wrong for one of these devices, it's also likely
to be rather easier to bisect the problem if bisection
can track it down to "we made this change to aspeed_timer"
rather than "we made this change to a dozen devices all at once".

-- PMM

