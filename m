Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFBFFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOaV-0004pR-0z; Mon, 27 Apr 2026 12:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHOaT-0004oz-AL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:13:33 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHOaR-0001wL-OV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:13:33 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65890a6ca20so1387717d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777306410; cv=none;
 d=google.com; s=arc-20240605;
 b=JEPcJVBI4dweq2fcsoazPTZG2u07zm54o1NRoexKdoaS3o2g4TB+2eZwXz0r3ma5H9
 C9nIviZTvEq8Cj02vedt38vf0/rkmy+n1bFv1FZEMKYG1bb6nWBa3YWm9lTonEpOUNH2
 y6OPuYzFb79WXX3fL8yTzPryPbEUkBbovSffBrNncSzuDGT9nLKPy+B5uVz4x/FRosBL
 ix5PaL5c2HWFVeunC6GF+nVngVCT2uqP8SKo0M9ia7AEWM5FBMzWVxAxb3M9yTTVp2nm
 ZactniQOMOyEtS0F834nHAmWznXdaPbehcVm4/sPs6UMXyKgQOhwKC0IEsSaWxufEOJR
 qo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rb39dPcxjq51fckrmVKeWSywprXIuORnPBeDwhuSSb4=;
 fh=TnDbL9mYH20MplIPRJjnJR4NKrcSt7fGISPEXk7FgyM=;
 b=WFbnI2ngmlCTaiPmEYCEB32QKnXk+N24r3bz6W4FTi3lhSnlyFxA3z3bFsq8zGPzCo
 w/ATKtgM6ABN3O8pK6FOwg7975laspw6gZPjsMcWlKoFS15hxWS/lfpqLg+spz4sK1L6
 oSZ94lvT1uP7mirztU5vlDSdJWkvcNopEwhXof08NLYA0EdVLaO8SXBNj9IlQoGcc9qh
 BNCEHHmw/RFEVQssuDpFEfbEYylemJR46i+L/Rx/ofH4CEOIAv3ANNcQIciNP7oritR8
 pkzqXbSJ2Vit1RkW9a2Qs48b/Sh1CdPVHLTAeg+cLthCKAn+lWs/h2FnfMS8cs/1XKpM
 HB2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777306410; x=1777911210; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb39dPcxjq51fckrmVKeWSywprXIuORnPBeDwhuSSb4=;
 b=mX9+A9tFH773sYmYRSZO46ey2xvJc7T+ETheV4QIp44ThXatAIY/aY8Mr6LMWdD9aF
 0wKH05DMQMwoWeNHWL6YS0BemyQTC9RdovuQewkG1y+80bvwlj4OCk/gNoz3cpUMUcvC
 sCtGomEXRbhIIjptZl4kdwlGs4zdEtJ3JLCV/r2Lo/CYQTb/gweS/3KG3ZtDdVOMYjzr
 g3N6dWcj2XrTvRU8zaceEBMzKAUTchpkTY57y0nEDMObTR0/HI6bg3yGKBltBbmP69uh
 LznKD5gFpsKmpZaIP1QlAJ5nepjC63nQP5ZvB/JUFqG9KDGZbpmnOjKMgjALrdDuodra
 fgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777306410; x=1777911210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb39dPcxjq51fckrmVKeWSywprXIuORnPBeDwhuSSb4=;
 b=VjoE0/pOIx+luSC+Fc+kn6UlxbfdhPGiwq+etUAyw3/X4OCTPdJDXm6aXbuHUbGdA6
 du3NG0kIl4BXVUhNjYBKNWXEt4JiMJDN/1bOknRLq4/998UyZgXhocFMdKyY1WOb8g0R
 oDiJBcwhOM78g0nEd2F7lRGDI2c2i749bHBqvgSfusFpS/3zRczZky702u48VRGDgRpl
 2An2BnIfoYArTq0dZ1WWr+H9HwIqzVNfp0gscta96hv9oOrhSYT28qMKXppBSiH1Mnf7
 ocY27sf6+XS08vR9L8ZNO7QmUgFpiZY9nSXVWKO4gqFaU2ffX9mE+l1XWhA3Bnxxy1Cn
 LMCw==
X-Gm-Message-State: AOJu0YwwTOuMB59yIU3+N3pPwyIVdYzt4gh/j/GnhcfHCVh7xOInVlrg
 fAtzyJsrBVCU7usfx+Nr1p5O1qXNMWToAvjuPdmQUin4Zmb/SyG4YBIhErI9EkSmF3PN+mF3pNS
 DM7LHycojTvRyQdqmT35s311RMwbLD1P9XP75lcj9xQ==
X-Gm-Gg: AeBDiesxW2RiDpC3n5KRNQBqWkiLvfaItd1ozKR7g9N8eEJNtKZ/GoDfSh7lFexQFBr
 GBU/Wh/YMdpFmp6pWLUke6CBfdfALY2RCEy075nCcQ24cexL+Z33OoiONHeTQtR7IdvXZUtLEwV
 zK1NbYJSWnnIUoVmdLzDKxq3IQoVE5F71GitmxXWuUi7X8XgWSxfkw+zJg4OPiJeqHmKUoFZH6Z
 Wyym1Xci94zGTNRS75ZqHlNE8zs55eaXMOwvAcmsvGy6N+Jnm8l80XcoPveOpXTWf4b5vf1zs/1
 XR0hJnh6jWj/JpXKsJTm66G52TkXN6iIGaIldcrE7FfdKbc33wHlswZroHCq4EIg3CYceaWMA8o
 CZV+bc3B/WcFw
X-Received: by 2002:a05:690e:446:b0:650:3431:24c7 with SMTP id
 956f58d0204a3-65be0c81e2dmr13722d50.34.1777306410170; Mon, 27 Apr 2026
 09:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260427150007.1185559-1-peter.maydell@linaro.org>
 <87h5owif7q.fsf@suse.de>
In-Reply-To: <87h5owif7q.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 17:13:16 +0100
X-Gm-Features: AVHnY4LnMuPaZ2cQo4-Cla25bzhKWXe21xdvaeuwhoAEVfbcT95iyd3r9zicUVE
Message-ID: <CAFEAcA9PeZpe7KbFpxKStR01Nk4TMZ-JWm37xtB4EeQPqKdMvQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Make qtest_get_arch() cleverer
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 27 Apr 2026 at 16:40, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The qtest_get_arch() function tries to determine the architecture
> > under test by extracting it from the binary name as provided in
> > QTEST_QEMU_BINARY.  The current logic finds the last '-' in the
> > string and assumes everything beyond it is the architecture name.
> > Although we also look for the substring "-system-", the only effect
> > this check has is that we will exit with an error if it is not
> > present.
> >
> > Because the logic at the moment is very simplistic, although
> > it is possible to provide more complex commands than a bare
> > QEMU binary path, such as:
> >   QTEST_QEMU_BINARY='rr record ./qemu-system-x86_64'
> > it is not possible to provide extra arguments to QEMU, such as:
> >   QTEST_QEMU_BINARY='./qemu-system-x86_64 -d trace:foo'
> >
> > Because the "-system-" check and the "find the architecture" check
> > are not the same, the latter example will pass the "we found
> > -system-" check and not notice that the "architecture name" it has
> > found starts further on in the string; so rather than printing an
> > error it will return "d trace:foo" to the test.
> >
> > Improve the "find the architecture name" logic to look for the
> > rightmost occurrence of the substring "-system-" in
> > QTEST_QEMU_BINARY, and take the architecture name as starting there
> > and continuing until the first whitespace character or the end of the
> > string.
> >
> > Because we now need to potentially modify the environment variable
> > string to terminate the architecture name if it is not the last part
> > of the string, we make a copy of it which we cache in a static
> > variable.  This lets us avoid having to modify all the callers to get
> > them to take ownership of the returned string.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I wanted to be able to pass trace arguments to a QEMU to help
> > debug a failing test; in the past I've done this by writing
> > a little wrapper shell script with the right shaped name, but
> > we can do better than that.
> >
>
> There's QTEST_TRACE which can inject any command line option if you give
> it a tracepoint name as first string:
>
> QTEST_TRACE="cpu_reset -d guest_errors"
>
> Maybe we should just rename it to QTEST_QEMU_ARGS.

That might also be useful. It would also be good to document
all these environment variables that you can use to help
in debugging qtests...

-- PMM

