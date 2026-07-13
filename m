Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A5EC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjM00-0007rs-30; Mon, 13 Jul 2026 15:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjLzy-0007rR-DW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:07:26 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjLzw-0006Fh-Sl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:07:26 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6679d88abdcso312141d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783969643; cv=none;
 d=google.com; s=arc-20260327;
 b=hX0cFlCPoy4p/kynFLlPsS1UVV6J1GSxA4noMDEEQtxDLx1MybXWzgTOQ6JcNXOq18
 MTD8+BrleMFyevMM+xbJYFzA42OQoBk5dfJnmDfziDDr8NotnncZL16QxJqmvCD5A0yW
 +XIwrucOgtFmLvJ8dZNw6bmZawukxACLxWSlDQ/ipAiWZXkCn0NLxyFJtVYQ3BtT/oIO
 aKk7VmI9BUHf58qH+cdQgh+frBuOOj6sKS/Vvpft7RdteVjtaXp8BwSR00xLlb3ehHj2
 FZwErEORSAlu59qf/GUQI2j78gsgrpKiXJGC4XD5Ycnp5DuGTeJUAUjNh1DTrbWrj5Pq
 Bglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8c1q+Mm8YUtk8pcWMZL5rWZQ8eLadIHz0F9+PTsbMhY=;
 fh=xIzkOXaMnwCyK+79XPvHULmSvwh/A95GFxEh//hHlPE=;
 b=M74vJ6kfOaquBrb85YPpbhtxj3QYbNMZ8QyTm1fes9eq61pL1Z6o7T/9yP0BCNyN8s
 DPXtlRPFXE8yE64NVK2Fmg3aLSb81UzbiscliAuI4mQ5D8nkJmhNn0+XGggcmZ3hgal2
 y5W/BAJ0j0+D0rN2ycAFgaGUeL3ocMlw8lQl+hXpGrjABpNq+//Gg6glCc6UcUOHWebK
 z01+c4kbmJPLoUyCdGXAjslf/CDpyITly8MfO1w88LrZCuhDM4pWS3KXIZAQYd4JfmJF
 rx9/Sa3MGscS6NtCMFUqQGixhGjD7DEWlRMWAxecLF/4aWfNUEkiPeUcai5Cdsg5WFTw
 1tRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783969643; x=1784574443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8c1q+Mm8YUtk8pcWMZL5rWZQ8eLadIHz0F9+PTsbMhY=;
 b=P4yFLFMoccjTX/u0q4O45/BzwcyJEKBXBHO6Gn+c9TMCkpSn0JyoBxFiuFsoUePR/i
 V6GcOfWjumc2kdijKC5vAM3pwGC35WpNcH+5DNZN90Rm5vTlKyIppg3G/bPIJCO9wVFn
 XWQt7GC5tkGN4r9nd4hoQyNAKHHuX7M64S1RLk8GTGvKiY3MAUOZk5qc9y42twvJ5uvb
 8mGpph6S7PgyB5uK4TZpO4NlSNDhpxevaUb7lJgkDe8fjqGzewjOj5P/zLs0dtBy8fDX
 a/sHe0Rv4GtmnSKWZWk6bztBAn8+jjoWPfmFvYBb9vG1Ce+qJ8L4zFdS0UUWvqf8yJoE
 pK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783969643; x=1784574443;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8c1q+Mm8YUtk8pcWMZL5rWZQ8eLadIHz0F9+PTsbMhY=;
 b=ckKiP6moMF81qVnas61PDlWGvdzm2gR3QYW02PeC19YpDBbP9ia3jK/S8Y/a9acJjb
 YQPD7Ukah4LHVFudOFeB/44oi9VZ9AbQ/aCMHIXvWOBMnP3ulM8ncM5vSN0elKTqaNgH
 5f5ypTlza1A99ggqa3tuiSL+UI1oDjp3FTEH7camZXXCzJW7dw3qvK0C3HFQ40XcwUj5
 xbcjDU5ce+hY8FGuidU4z+nztLD4iUrrWmRNRBNrIQwWoSyE7+0/cIRtXuYBZJtuPg4p
 0koJtkioa5FMIMjFiPz8bPfG7GdFZwOAXfoahtqr3Z3nJswh752M1vB5KldM5UW3WDPR
 BCwg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqmai6NkYNL90GxIhnuavj65hQiNbnzZj9A3QzToqLvrVZxPSxXqljQaqkqBQFVLuX7x8yMFQWvzyfr@nongnu.org
X-Gm-Message-State: AOJu0Yx8oP+Ty6iWj1hdHS1Q91rSgfn0b3/GJKnAFH6mm0yqynqzE9iH
 hWg2M51NoVJLSYhhx9LXVsFUoiUcoq2np0uYeCnoSx5qarY5UW04/54dcPz7DDvK54h0Sc4sugg
 LM6R3wc5SJLvoAN6ypaChOAb6ZIvnvFLvn3zZBjJxYQ==
X-Gm-Gg: AfdE7clmv1LZ0RiaWZ3z0kpoCfGXxFUBsLE7HojyrI4UAuWFk9MjcmHbh5n+Pzcnl+m
 nTGtfs7+GbKfDL6VheiYcTi2EVQdBS2PPTsn1E9znuXYFhx4LNWY6vojK9ZzMR+Gg9mK8O00CPT
 4BXK6QmV7ycihi+c4MNls27vYvrmbDXWfd8GV7ZUBz+vYe18B0BG0t5ZimfQ9Iyhg2mmifIrPV1
 NeD/4fxdS1XR0XA/BCnHkdCKacjHv7MGkxFX66f6rQAMYJ3FiLBfXr/yiGFDT732OZAW0IhHQjr
 NxHaUlYzJVLX9cVplnlys7GfKAJntjpp27bs2KZkw0EzVZDdKWFzFyi2p0EdTSx+Sgc=
X-Received: by 2002:a53:bf0d:0:b0:667:8b9c:e6bd with SMTP id
 956f58d0204a3-667d7cb361dmr5018774d50.97.1783969643477; Mon, 13 Jul 2026
 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
 <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
 <CAFEAcA9wRhZPyiAym26DQWEyb2AS=QBpvRi9wBEJKsHEw+j0sQ@mail.gmail.com>
 <alUyrS2ViWMswx82@redhat.com>
In-Reply-To: <alUyrS2ViWMswx82@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 20:07:12 +0100
X-Gm-Features: AVVi8Ce-i6UDhemFzB6dZL9LpkrxteBrXjJ2QBuCgLYAcPKGEz1rVC0c_m-kyH4
Message-ID: <CAFEAcA-ntJmOH_OaCAqanfHtG+fHwS+5RgXbuQOK4j95nMwsZA@mail.gmail.com>
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 13 Jul 2026 at 19:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jul 13, 2026 at 07:15:34PM +0100, Peter Maydell wrote:
> > On Mon, 13 Jul 2026 at 17:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > >
> > > On 7/11/26 15:34, Alexander Graf wrote:
> > > > +Object *object_new_child(Object *parent, const char *id,
> > > > +                          const char *typename)
> > > > +{
> > > > +    Object *obj;
> > > > +
> > > > +    g_assert(parent);
> > > > +    g_assert(id);
> > >
> > > Of course, typename can't be null either.
> >
> > These asserts are of the "not very useful" kind, as well --
> > if either of these are NULL we're going to crash pretty quickly,
> > and then the debugger backtrace will point you at your programming
> > error. Asserts are most useful when they turn non-obvious bugs
> > into obvious bugs or turn "happens a long time later than when the
> > problem is" bugs into "happens very close to when the problem is".
> > bugs.
>
> For the 'id', we ought to call  id_wellformed, and report an error
> if it fails, which implies  an "Error **errp" arg for this method
> too.

That would be a programming error, which we should assert() on
if we want to check it. Adding an Error* argument just for that
would be forcing all the (many many) callsites to add extra
error handling code for a can't-happen case. QOM error-handling
boilerplate is bad enough already.

-- PMM

