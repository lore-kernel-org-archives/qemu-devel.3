Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96DED15DAF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpip-0004zq-Ek; Wed, 03 Dec 2025 11:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQpim-0004y5-Bf
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:28:53 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQpij-0002xb-Uu
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:28:52 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-642fcb38f35so5429106d50.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764779327; x=1765384127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kv1ONXZalTzUliu3Lf3hacUz8qwrxGUwXvTGqJG1wgI=;
 b=dXPo115Dko0kpuIzXTt0Qc048odvkMpAluchELjZ4cSa5821wIE3VVMlhQSHjE+kXm
 cL3pEArnkfk+7bH0x+BODXfohjUFC5wTg++7kD4ugVpLy63K6SqcYd2r8GFkactGFAem
 YqNwRvKkXZlkOsnOHAPcVUubGAG0byuHHmI6FiNXUfObqUh2yx4deczQPv8tOGiHA7J0
 XP6IpEDwNzt1hj8DO46Iqe+iHzSZ2bIMik3LVNA/O/3rjKCc+r6L5NCUH6wPpDTn1VE6
 XaUK6D0w11Yl4PQqSMvAx4tYD5PhH111uAcgMxfzagl33r8RgfxuOm7XXZZEFhVz53Tj
 h3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764779327; x=1765384127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv1ONXZalTzUliu3Lf3hacUz8qwrxGUwXvTGqJG1wgI=;
 b=rmXcSGcVdGUlyjHxIysgZDHqhfBLmVECOAgIHK3mddedbX5NlHNIbWhiuHKFzrmtKb
 Ld4loezspGa5vwqTWlDNAMOe9nFYnxBYQkLihR+WB9RmX2oUqwhFGnGVBwTz7gD95LCk
 nnkipRa3agnVvYOPcdESPEOpFFjP8Z8VUvZMm3niyvNtT54h9EjmsYFFFj5FAKV2mD4p
 ZQD9attQZkAh9XuvQjLmboLriwa5qWrGdd1+Y8Q+Z0a01dgBjnwNJBWOxgTiZdX4rzND
 JMY3Gt05RitcBT68U/cXO1clnr1c5Hs4s3o/oZSenmiYxgVx/cYJrC8Y6+njTNyffd1C
 C3Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7XQ46EFDltUAQ+XPHpw2stwNQRNSSzMJJNSMZX1Zz8Du/i16VwuuufvyIAFs6ccBmEBbnfAwkLC13@nongnu.org
X-Gm-Message-State: AOJu0YwxGiXy0V1Wuv5SZ22/g4LLVQv5FTwCwxD+Wp15fDM2P8pbIUbM
 HcHSMl/k7Tl7rAK2eIHPDo1z6+TpLXyG6vSeh84JH82VBn3PyaaceOe9jRamJHI0QTDrCnwskcg
 AuaicQbNcpHaYNGadJ0P3kE6fHatuG8SPNaNczA6WGQ==
X-Gm-Gg: ASbGncuACP2SOgU3NmcBGClxdQxcKpcUWlXHa6PcHsXH8eCtECeWryWDjMnHCTX8zIK
 Su4huWf/hVCdySYZUdqDWy/eS8+BhGoSKByuGfmS7/bHwTxhFKxuXNSnXeMIQFM84opDKEykYJ7
 VMYAkSbKJmYeFG1H+QsPUleFLs/qQsrYrSLKfR4KEuU2w0w5vbQ1gDEKYe+J+4pkQztYJOT7V1u
 dEjShj5qdpBYcTW366UD2seItjBxRvDEydJsvsja4p1a/8HK0zA2i2YltpQ0dcQPP5iiRsk
X-Google-Smtp-Source: AGHT+IFTyV0plQbL7g6XrqADTbAVgQFyEy0YpWk2YvVgxRSkzxwuQ5lWfM4E4GzxBhfRRvUVsGf1S7o7b0xKaiQH/BU=
X-Received: by 2002:a05:690c:6107:b0:786:91ac:e16b with SMTP id
 00721157ae682-78c0bf06e61mr21460807b3.9.1764779327313; Wed, 03 Dec 2025
 08:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20251203131511.153460-1-dave@treblig.org>
 <87a4zzu230.fsf@draig.linaro.org> <aTBCLbDbpXgkTLHr@gallifrey>
 <CAFEAcA-Uy0UQwGEK+f95BJmDripg1-8vhzPF5qRSY40=duhRUQ@mail.gmail.com>
 <aTBjTzbaX0befChO@gallifrey>
In-Reply-To: <aTBjTzbaX0befChO@gallifrey>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Dec 2025 16:28:35 +0000
X-Gm-Features: AWmQ_bmKHQQ_YhvSy6UczQB4KFywWqzPdsfZy-7wLfs6xNs3GYGEc-n_hvBIGiE
Message-ID: <CAFEAcA-y5ucBTOgngim5cpuKbFYXajOz0zEeT2S0rC3wnMPSrw@mail.gmail.com>
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, thuth@redhat.com, 
 pbonzini@redhat.com, jak@jak-linux.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 3 Dec 2025 at 16:20, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Surprisingly, this and -h/--help are our only two options where
> > we provide a short synonym. I note that this handling of -M
> > is not consistent with how we document -h/--help, where we
> > print both on a single line:
> > -h or -help     display this help and exit
> >
> > But it would be trickier to fit that in for -machine and
> > perhaps confusing given the suboptions.
>
> Right, that's one of the two reasons I kept it separate.
> The other reason, is that I couldn't figure out how '-help' and '-h'
> both got defined - why is the second DEF(...) not needed?

A piece of delicious fudge lurking in system/vl.c: we have
this hardcoded entry in the qemu_options[] array before
the ones that are generated via the macro-magic from
qemu-options.hx:

    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },

So we recognize -h on the command line and turn it into
QEMU_OPTION_h, the same as -help, but it doesn't result in
anything in the documentation (we leave that up to the
strings and RST in the DEF("help"...) section).

thanks
-- PMM

