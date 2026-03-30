Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356591061B12
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EwI-0001C3-Av; Mon, 30 Mar 2026 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EwH-0001Bk-3d
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:54:05 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EwF-0000mY-Cw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:54:04 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6501d242e3fso1922962d50.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774886042; cv=none;
 d=google.com; s=arc-20240605;
 b=jEaD7UCN8FMCr2clN6TXQBwPJqW32kbgGCmySS4wHflfO2hQISFqpNWmLnPScPjA3T
 edTNiHGZHBE+c795Vhs4iAEpN4kn4Id2V9PlvZNZQgtDRyJgGTNuNw30l7m0O0jzM5TD
 yKgUldaXSjFOt6LYC3xqzKENSngVBDWX4pKT3MIhkqDh/T3ckxDwz8slrk5MuobyKia+
 fGHJJI2SVfdEmDKpP6sCdpoxXUlq7Ne5GwQ+385wAWfkGyRE8jAkUK/WWGLDwVWbVA57
 NQBcqHwiGFDdwgfU8zCYpDTvEDjc6lK1GxmNvXNn2BvFtv+6GXGvAqrTKH6/PQcveUpp
 fXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BfUawFruljZAbUMd+eNfZgXrIXYPM77ETsVSms9vQH8=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=BMKFwU9gTt/w1MbmVZ6XMQ/m3O2SuAMEm+ojbaa+BzULiAkvM9QEpGo/4CKfYZutsQ
 iE0VFRp7R+YJN07KJ93eCbwRnUwapJZbG6O8aiBDzOZZGurmbla9nINNew6JIadEqniJ
 KiPKnFtH6fCdLn1lPf9v8lFc72AoY+UcTAQ9KK9y2jfwZlW68BE6vgIKlKV+ExrwyVcB
 2Gphpaz1AZu37iS2KvJ5PUIZCZcKELjJfPKUkOBXW82b0S/ZCH2R1bOfvDjtZ8a97+gz
 gKKAnknTriFQLVx4lphG0TBENmKPU4RDTdKX9mnlFvtgFqv08R1q114LF55fqQFznH3/
 1GGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774886042; x=1775490842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfUawFruljZAbUMd+eNfZgXrIXYPM77ETsVSms9vQH8=;
 b=eeSImroTMeLyhoVBsVPufbBKYQVvRDkTMAXEBy0QQ6/BAsfYXO6B/sJa4dqZdmnsm9
 S9Svzdlp6Rzrsv+YMrMBNNwfTUsigcugDutNM3mUAa+W8w+hNLdf7Riu2TA+KHahxVAN
 jGr+S6GcMFT5qhO7lRmhCCYZqAgthIWwk6kOG4d7D1gun5UQBUFoO2C+9OIpjsHOIVJr
 k+PwnvUJfIi6T423xpFgT5ohF7aqAn9NuleZPwzTXnDO1qx5Wp5XF7j8es5MEw1AKAtA
 wQGgkR41Dc6RmbTVIdOqzLl5UnPPttLj0ycJAdBanOSl19k38Tqhz3D3fLXDzEJoT6Jk
 qJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886042; x=1775490842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfUawFruljZAbUMd+eNfZgXrIXYPM77ETsVSms9vQH8=;
 b=Q2wCPQvFAx3uuf4wrcxle1hX0xVPKQB4iqzWhdm5b8wtuu6oBQGbqdEhNhBpYgqdDk
 FXe6ctyx6bYvc8I3nSQPoPRyuiEwCKBCjAfkQw45xlA9QRUmd6IPFdOlCn3F4Wns+UI8
 KvMN0qRZxJrAJxha36tzg8jD9PPCJrcsMefXJ80fnO19Q4IWV8Q/7umk8bT+dURxJQtZ
 d3Ih0IXFeCqVM54mblcnnhlt33axHjOuriM0dwlAKDTkt2mmfyDq4qR4QSz3aXIV4Qfo
 1VS3s7U8fpkYMMnIF4/QI1ctxdi/7jSE8aOAW4kwg8HVq744k6f1umc3gD3BU9Ckvgmj
 VSAQ==
X-Gm-Message-State: AOJu0Yy5WevwfsMtahMQbM/8U735wiooXKpNtlRWxEeAUCECMtduRU1M
 zwJ8E0HqhG1G+q4SgzVLTiOeO+8h+UgY48y1G4InlMx/KOJSsGktHvbyeqH9YtxneoesCVAoWSD
 imcmSneG+OT08DwR1F+kEjAOluzABHxiEB3vdo4GIHQ==
X-Gm-Gg: ATEYQzxURzmDT097F1CCBq6SZk3P3Gku04ftfn279NSBs476TGS5nXR4F4SYuaCcsju
 bzbZjs523L1+kZ24U3EscEeDR+AneckhPLFLGcyWkZ8GX33G9Tw1sQtA/C/jDQxxfOyBoEMkJ8i
 b3a2t4WCSAtEIgqae2V8yKpuxOgYJEtwiAzafUPv/vtI4FxzTxc8fYhj4fZ1k2IgidWhhAv+/kP
 lx1aC6tMC6O0eL6U/68mD9VZaTRGHfmJBD0n50od6fKI9zBEtdXi2hu8WZfEIkGOTQccATYu1BM
 xAe88eBOlvWlDQBrM6yEVRI1hjSP7LQEH0C0+ziyLpos5XaUGR43PPMiQtKVdIJ46U8=
X-Received: by 2002:a05:690e:1343:b0:650:814:8124 with SMTP id
 956f58d0204a3-65008149038mr9930413d50.17.1774886041912; Mon, 30 Mar 2026
 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <20260321135624.581398-4-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-4-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 16:53:50 +0100
X-Gm-Features: AQROBzBeVZfRyb9CXoFh9vsSHEzkw3iBF7_en5u5zWfJLtPVv7Z-ydU-cTbN80w
Message-ID: <CAFEAcA-BXxihBMrgfyrA0y80Aoo6ZCoC7r3EVBC9Aqf-7W3xdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/tcg: add recursive signal delivery tests
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Add tests which exercise a synchronous signal being raised in
> synchronous and asynchronous signal delivery paths. It does this by
> delivering them with an altstack that is made inaccessible, then
> catching the badframe SIGSEGV with a handler on the regular stack.

The other thing it would be interesting to test is:
if the stack is inaccessible and we generate a SIGSEGV
to the *same* stack because we don't have an altstack
set up, do we do the right thing (i.e. terminate the
process by switching to the default-handling for SIGSEGV)
rather than e.g. looping forever failing to deliver it.
But that would be more of a pain to test -- I think you would
need to fork a child and do that in the child so the parent
could check for the right wait status from it, or something.

Some testing of this edge case is better than none, so I'm
not asking you to write that extra test.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/tcg/multiarch/badsig.c | 226 +++++++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 tests/tcg/multiarch/badsig.c

> +static int __chk_error(const char *filename, int line, int ret)

Function names shouldn't start with __.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

