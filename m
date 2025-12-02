Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071EFCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 09:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQMvT-0004ey-7B; Tue, 02 Dec 2025 04:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQMvR-0004ej-Ko
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:44:01 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQMvQ-0007in-2n
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:44:01 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-787e7aa1631so65024917b3.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 01:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764668637; x=1765273437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvLcLC4bd1HtHdWUFs2WwNafNU5vivN/XbXE06pZelI=;
 b=HtRj32EzkroFUqEHuVlvIUhfNbvIm6evaSpyrFtUj9z9I8gko91KrEi5z6N4yPCFkb
 e9+SlrnAQQGvSihRI2Mosq+JOS5TkJPnZGyEozBrHfNumdFnd9NIp5Jxrb6XBkg2wKjy
 Ck3Wvc94MXYnTC0vZ7P+hflXyRmaTuNR0Z7TGd9ifY+T4C4/KVpN6pN2zJ7t3kcOM1w3
 0GnLks2/Kx8/K2VviG9eFYkNOp07NawX2UtHtCTIAR5EO/+Hm0rrQlQC4XwODQJCAyEZ
 6K9icl9+dT7zN2/7Ai2/yd1J2lQY11xrhEBO595QpJoiI6BpzBKN8TCc3kJoYPlXsqnZ
 mnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764668637; x=1765273437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvLcLC4bd1HtHdWUFs2WwNafNU5vivN/XbXE06pZelI=;
 b=MCQixIwnEuVnfztT2FT5g/+dZXhyyTzYpdnEl3T9hIU2XknepndRPQfVKo6YqDMtJI
 GRWXaqXLtzfqxFm9JRtfAGDViTLIF+N0ohw6ILd93rnbTFfBg/7XZUT4SCF9q42e/s+F
 y0FWScfaP6qHb1YS2gBViSsjVweJUtGPIT5GRGwNAOovuKDajbLEtRTts5qgOYZ2Drzl
 JH5RtpLNc5NLb52I951iLF49cTxggdQq/QwMMOFOJFt2xQwTsAdLJOFnLJMEsdzeeLhN
 3MzipAR1x/aGF2CmLbEd+40pxbhVYA9xbSP9EMUc51zubXVTkU1Gzv3JEqGZVb8SHNc+
 xaZQ==
X-Gm-Message-State: AOJu0YyO5Niv8qL97PiZ7IWd0RofUECsOaSPQ4Rg9k65tpGcGWgorHpu
 QldS0yzzK6u3g7OZjTKZVKU4Sq41nhkcEN89H9Y8SvCz+JRAdj7sNLWtTdBm7pUZ8mqK724SurK
 UizN0iwgRrIzKSi/P1H4J3EFrEnj8Lsm0a6kO+DEk+Q==
X-Gm-Gg: ASbGncv+9orO09xu0ywhEfmq2VCGqVofy/jmpHwdnXQjJlEGC0CweALBbP3nuJZ2seM
 6HUiRAUmPBUaB1rqoQBKF8CMlS/0tQ5HJU4D1N2OofOs+o9j5s2rzR3WrMxLcs7h5OkC0a1YB4X
 XFkPwXxaCPpZm94fqdaaz9fEuytSwHIDxeqHumC2JEeES+79tgF73CL7BEjXNu/5kt2v+m23VIN
 uaI1BT9SCCvopoAFv4GwjvXn1J6H1LLF6X1elgh43+SZmaTkCWOZTrWJAeWPORCaPXyFzuE
X-Google-Smtp-Source: AGHT+IH1mMzuep8lyCqv63R6uAxVtoapp8Ku8H4PiAqRnZwN7LYu1eCs/LzY1QBF1gWZPjQV25DAHvn9cOIdCLFoCg8=
X-Received: by 2002:a05:690e:4007:b0:641:f5bc:692f with SMTP id
 956f58d0204a3-6442f1c2a53mr1077579d50.40.1764668637422; Tue, 02 Dec 2025
 01:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA96wEquV-rWRU8x7DZBkNUOLYb_DVi80GRSZ_ekGGLUhw@mail.gmail.com>
 <AM9PR04MB84870E366018AD0D159DD40287D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB84870E366018AD0D159DD40287D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 09:43:45 +0000
X-Gm-Features: AWmQ_blcWs-BpSsG1RZlpnSTJIxiTzkSijVyCAnYURQs5lqgR_EQESela23wHTE
Message-ID: <CAFEAcA-i3XMS2w1xD_aVe3y07ac+uD-RzE57OB1dPWdadj--1w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCHv3 00/13] Adding comprehensive support for
 i.MX8MM EVK board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 2 Dec 2025 at 05:19, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
>
> > At least some of these patches were reviewed by Philippe in v1.
> > Did they all change?
> >
> > The way this is supposed to work is that where a patch has been reviewed
> > and hasn't changed in a followup respin of a patchset, you keep the
> > reviewed-by tag, which tells us that we don't need to repeat that bit of the
> > review. More detail:
> >
> > https://www.q/
> > emu.org%2Fdocs%2Fmaster%2Fdevel%2Fsubmitting-a-patch.html%23proper-
> > use-of-reviewed-by-tags-can-aid-
> > review&data=05%7C02%7Cgaurav.sharma_7%40nxp.com%7C7d7d9203ac334
> > 65757c908de3116f632%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> > 7C639002171850292201%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> > OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > fQ%3D%3D%7C0%7C%7C%7C&sdata=%2Bj2Q4APWnTNTY%2FTHqfaEZsmBJH
> > E%2FzD6zsv%2BxnZ9IyC4%3D&reserved=0
> >
>
> The v1 patch files reviewed by Philippe changed. Structure type was changed in all those reviewed patches that's why reviewed-by tag was not retained in the follow-up revisions.

Generally, if somebody says "do this trivial change X"
and then gives an R-by tag, they mean "if you do this
thing and nothing else then you can add my tag to it".

thanks
-- PMM

