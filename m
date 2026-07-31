Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03940C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprK8-00066D-NT; Fri, 31 Jul 2026 13:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprJy-00064n-JE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:47:02 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprJu-00082L-Gl
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:46:57 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6689402c7bfso1395997d50.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785520011; cv=none;
 d=google.com; s=arc-20260327;
 b=cBRvWDE3iLZF+gAXMb6nv0qaGS9lvBOjvNQ3DbXfjbQjq37nNWOI8e91XV7rHpFLb1
 YWFt76wPx96bNMC9cX/yM/LJrYjpoWg1KmsGZGoa+DS+jZ4bQ41wZYkewSlRR0GLdGqO
 7a9AQYEpV4vlTMlKAo4530jzU/MSqtZTbXol6F5VBZ2I8kCVxz4toL6KgYg1Rac/HUy2
 zJC3S4JrvTrmEAbdGdBFyZLCbxVbz8YlF4BmpkT8uJxbMrIe/YwMeoxEfNptB2knSb7o
 w0kX36km23xicH/bxTWP1bTMrsCfgROcSmptd7j+zFQMV/NTt528vZ+5MRvkHy3fKwyh
 Fldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nxVW1r7MPiFQtaZmJ6m7+lZfEOVo+HD0BGnYA/H8WSo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=R78qhDXZpTkaPfyPjS8e9HRSJk4T9M2ODkwvrQNOKjPTw1ptvRk1yFLuRh0DecvaJI
 4nFl1wVn5lwDeNAjZyuS2xnxJeomHqcUCYAVWvEkwUEB8lT9p8Qt244qc+GtFYBeLEfV
 G7jMyOXaJ6LI29sgHdJ/Wo0VOePywjhkQD3LOhoSksDEt7GbcS9wCbvRrj4yV1g8MACg
 sbz6Ff6kE8Hhe5y40aePM0W4zoNhegnBlxnPTOiIU2SjNwGAikQgR/bTpk/oM3V/9UId
 XN6WxqXM0xenj92Tdwnbe3p9diECJh3A/xvqMgDeWGrPOmaNiVFtPl69wsjXjcM2CDNF
 xzMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785520011; x=1786124811; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nxVW1r7MPiFQtaZmJ6m7+lZfEOVo+HD0BGnYA/H8WSo=;
 b=EJN/FErzx6qjDLawIOU8SgSXrdjfl8/c/QbKIaEeLAiaH2sJCQWEibLdHGuoXBTflY
 WwixKQLxfs+JI1TkvWEKoG+Po+aoR0effehqdgJCBTC86RwXaLNI5aatRc+B7GrLh5aj
 Rw21dbosgTBx30Dp/SsNI10HCl+QXENrpaeC18JfzIKbybTtnJYYnW3JU2mFOgCXeSZu
 h82elhvAmu5HNUp6HqGq6FP5w9uZQVuHr0VuTYmYZZrWgfkAcT78s+rgcckjLmETxSO3
 Z9jBCBw3wMqs+IpoU3V+7IdjfS8F2AOdW8pySoBiJIT02RhE43ZqqEoV96DjCe3agNbn
 rhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785520011; x=1786124811;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nxVW1r7MPiFQtaZmJ6m7+lZfEOVo+HD0BGnYA/H8WSo=;
 b=DtT5WWwgZ54BvLpAV1LR7xKS0yCbJ6UiyDlm/HIBpH3ZtHZ6uQx8LZk7i4vje/9zun
 Rh9NRX3tbIGSf4iIRDOYnUFvgLywwPTfvPIsqYTuByXBUO3KTmEPvKeZDguy3H3R/Zxc
 IWy00NEBc7F7ioRBtOyZQljHqcaW6U8qh0EgMUmVzcDvgL4bELZLmBJnwXY5MKo8Tj7Y
 SRBnNqY/1/IeSiEAt7EeKseprOiileq6YNzGg0/MBsTz8W85bBpH6NI91lnnowZptb2G
 /9vEh/c0fkj2mClt1DTecU1VIy6wQkKaHUh5vfOSMrANboN8KM+Aytz4q41SqlxdzV11
 i4NQ==
X-Gm-Message-State: AOJu0YzXFeffWh2RjF5YuKe5JhKoEWfKiqPxssSGRFbE+UUQz4EMMPXu
 QWpj8z5xHB2L18nnFuck5YOxUe0gfGJPt8QZQBW1U2xuTe+URlB/Mn1HgToAIRbyU9RXqFuzfj/
 WMWiTiaSiZb+QFOw+s++D5C+x2UTyFRvojFdfpwbvbw==
X-Gm-Gg: AR+sD11FuIXWHdrB0YC0K6ETyKhFrKhzjJNGlG3GdtidonSAVU8iNl0pgTaOnBE2EPl
 V4gkkHUORRbs0WRxfBvyr3liFUe+WyGCIUdowSOJqD/ffK06gRsOoETn5AplPGtYAPghvG5lkfh
 OWmSMKjc9gzOxZoEEGQq7MmwGNXrlhtiDR/08QFMgVlwhDW/eDjPygFkU6uQpisJQaVnF8ZFBTk
 jIDF6oeYmiZqcGcvWmX8JmJAVMyHTM4oLpUg45ZF7W8iAaxIHnPjVSI5oVaWVkxzlEqnwPKoGTz
 16EwUHrh5fe8TUy7UD/6y90rCwCNHTBETkQUob3pKEwKLi29YUKKGkiHdbev+81e5A8Gi1e90Z7
 o9bpIK1i6eZXH0M//NDZe3GDg/i3L
X-Received: by 2002:a53:db0b:0:b0:668:568e:8618 with SMTP id
 956f58d0204a3-6694efde7fdmr879479d50.1.1785520011068; Fri, 31 Jul 2026
 10:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-4-richard.henderson@linaro.org>
In-Reply-To: <20260724031123.76597-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:46:39 +0100
X-Gm-Features: AUfX_mwlwSiLwrDKY0AGcE9mtDwX06M3suwmRLlhqqzpw_kDHrEGeCtiPIF9jd4
Message-ID: <CAFEAcA_5gcPt2cvKDHx24KwNYtWs7Z2--Qeh-8iBqPaukLqwtQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/arm: Implement HCR_EL2.TID3 trap on undefined
 TID3 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 24 Jul 2026 at 04:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
> within the range which are not explicitly listed.  Previously we chose
> not to honor the TID3 bit.
>
> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
> on these registers

NB that it's mandatory to honour HCR_EL2.TID3 if FEAT_FGT is present,
and we already choose to do so for V8. It's only V7 where we don't.

>, so we might as well honor HCR_EL2.TID3 too.

I'm not in favour of this, because there's some complicated
history behind HCR_EL2.TID3, as outlined in the commit message
of 205ca535ab ("target/arm: Correctly honour HCR.TID3 for v7A cores").
I would prefer to leave the trap behaviour as it is now [i.e.
"on v7, trap only the specific registers; on v8, take the IMPDEF
choice to trap the whole range"], because the wording in the
v7A Arm ARM is rather vague. I also have a feeling that I looked at real
v7A h/w and it didn't trap these, but I might be misremembering.

thanks
-- PMM

