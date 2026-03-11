Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419A7104C00E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HBf-0004fo-S3; Wed, 11 Mar 2026 06:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0HBJ-0004bP-Fs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:52:51 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0HBH-0001zD-UF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:52:49 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c97997b0fso9873663d50.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226367; cv=none;
 d=google.com; s=arc-20240605;
 b=hATkENu3C8RwucoGnaLAweb+slo5RlH7RjgO0qfFMDIVlS+NOoxMq/iZG32uhTJ6wk
 ZXIULY3PChWczayNSRGfO+RrltDSNXIIlRobxDviWDbCjJlLJKK9AZzhk88ES82ht6Hf
 Ay2G0A4YGRXieXmdk+erz9Zqr968y8SgTlObkCULwyB96EbUtoDwMWH1vy1kTNrFB1L8
 3HMU1wSy7ulSFbm0EJSwswGw8ErhDSghlJKAqcQenx/eewW5KCh+Uzsjt+k1L41oXccl
 zgH1FzqowGSx+BoSemGEaYayJCw0Sm693njy3/O+xckZydQTHFZx4N49ha6T2SEnv+Nc
 ZuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8sUemrHPOW40xJ0blk1bRj6suupCKfQkWnwFoAScRqQ=;
 fh=8A/qvOjdiRdPC99itMK2f8zFtAtZdMHUYTDW8ZLvQPw=;
 b=SQCD3ywYSieKBmDQ7inCwFJJ8DQyT6yxLJ5Al5sa2IZRNyB7ZZU21xAbv2oGKNY+2L
 K441RUwEJsZXZT59IdjFtk2Nv8Q4l8kN/52H29ukB6JvuTThYtU8ASuajGi4LuY37E+T
 nBchDzQgh4zxQGgyBkGE1lMTLa7X9K4Q+Fxqxo3+wT138YxN1YMbQfGhEwgNajV8jyGj
 sZLOS9x8bkP9DyC8C7o9i30MkaWANKQqL8ynQcErkKUC+7yuLg+o37R6+aap4Pcbf6YW
 f2ZDTTAGWKhKtO74mugKgDXkfGBsMQNhpevdtnPCwY3rZ1+UXrHhBR139MKnt/IbvhLe
 QX4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773226367; x=1773831167; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8sUemrHPOW40xJ0blk1bRj6suupCKfQkWnwFoAScRqQ=;
 b=Hp4+gTdJv9bu4ZujMzCZw+OC0xp+ZahomQF84Vrwq7ec0ZqgJs//VP6W6tHHrbfbpT
 QxBvr4RN+thXkuS9ZltENgjSLQLxD2i2UxfhezqpEveQU8ei7qHxInY0pUJ+Tbs51VdM
 HyThqfW67VBvZSJ2+scv1L8YvzPh6ZP3vljfadjDfG+oMWOosz5mKWA1Enq+RODNZXwX
 VEOIiMY9W1DgCQF+fuyRJZTBpjvH8IIp/NSluvWpOPomVX1befrfUY9ang89g7AMswXF
 VL2C2pMufxDZ+Cufbz7zf60rCFlXKSofiV6TWCBxUJ74JVdDvPynPfSc7EPDVjv6HHBR
 aakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773226367; x=1773831167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sUemrHPOW40xJ0blk1bRj6suupCKfQkWnwFoAScRqQ=;
 b=Wsjgk3KhEngKzsfB7MZkmLAmd4qJKDJoCsgK3uyuzTOZ7HeIr1jJiK5Jl4ZNYHnyag
 ikNeuyyewtVLbVUSYzFHXu7cfCp5X6sT/FAU4XnIxJx3SHtId9z83b1Jkx+u6ws2g5up
 T3ZuFDh1k3ebLKh9D4KMEtTxlLoQ4VYd6ZZgG8qhQVfXKJgPQ85HiUvoPrwis2iju9l8
 iB57tlfCqY9FgLENsn0pG3lfJSGJ0AiiOvdVJuqb9uox2HRBYSIdGkFQjTWI7NRpKE0P
 JQBCqZCSuMeTVtNS/M3VNSeR6QXn7hrSDQ6AzMPZQ4gvb8Y3k6kp0yvtYSP2erriPzs6
 EjJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd9gFpd9AeIemDP78c9fi2036/ZS25MD62Jj5XU5Hy4rxKs0yL9R5rvGIAyEj++ujOBA5jrVGP4S+L@nongnu.org
X-Gm-Message-State: AOJu0YwcxRrGOHVBRFMy5lf2g0XvXnsBdlWnVMM8SPAY+f43b8eWUTVD
 59WKEwn8cViEmJhKd2dCM1NOnuLOZyO+P8HmWuvFFWEwBQbi6E28Jwslr8w+oEYt6LcOoUi4LnP
 j0JOxry+kvaTxPLyN+uyT1e5AxM8L44WhpLM0iEQeEg==
X-Gm-Gg: ATEYQzwvRoJULQ0YfPxC6DCQC8lTDHeDM2rJTPuS6x4q+x0UbEex4PS24nORrI3eb2t
 u0aIDNiwI81+bYtD6Aw5oTkwBdpXZ3sbD4jNnhCi4t6WurHorGnUn3kwA5rrchQOrYXYGZFYlLM
 KW8GBw7OmgG+/LIl37ZomSO942alPS0sG8Mt2+S20wwPqlP39wu+k3jH98tCfzeLzkkBH06qLoG
 o+/d/zCeFAM773vuiR0pYFeoEVE3w+ft6HcOjKMwzSPjTWPRruNT5o+TYTAv9evcNC0uE/XGZt6
 Laxv++s046Z++TZ7yUOR4/ogjHcXxGnkJPYVkAuLVigeh9ltpyl/jEODEe5LLiEAmWs=
X-Received: by 2002:a05:690e:b49:b0:64d:6600:64a1 with SMTP id
 956f58d0204a3-64d660066e4mr1617171d50.16.1773226366726; Wed, 11 Mar 2026
 03:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260208103958.121455-1-heifetz@yandex-team.com>
 <47a14220-139f-4be6-a19d-503924d5e90b@tls.msk.ru>
In-Reply-To: <47a14220-139f-4be6-a19d-503924d5e90b@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 10:52:35 +0000
X-Gm-Features: AaiRm51Mm-9wzovRtGo7Zm7286__J8iEJ4B4LGkzDDxKgsWPy3CqmkvtMERAz_A
Message-ID: <CAFEAcA8xKEC62gTv2Trni_Ers7gkFWUgdTb_r3PaT0_Vz9sUPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix a few minor issues reported by Coverity
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 11 Mar 2026 at 10:48, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 08.02.2026 13:39, Sergei Heifetz wrote:
> > Hi. This patch series fixes several minor issues reported by our local
> > Coverity installation.
> >
> > Changes in v3:
> > - Nothing. I sent the second version of the series without the corresponding 'v2'
> >    suffix by mistake. I apologise.
> >
> > Changes in v2:
> > - Remove assert(block) in system/physmem.c instead of placing it
> >    before the dereference.
> >
> > Sergei Heifetz (4):
> >    migration/savevm.c: reorder usage and assertion of mis->from_src_file
> >    dump/dump.c: reorder usage and assertion of block
> >    system/physmem.c: remove useless assertion of block
> >    hw/usb/core.c: reorder usage and assertion of p->ep
>
> Hi!
>
> I applied 3 patches from this series - all but the physmem.c one.
> It's ugly either way, so I'm not picking it up.  Sigh.

I think patch 3 is good, the commit message just didn't include
enough information to fully explain why the assert() there is pointless
(i.e. that it's called from only two places, which both already
assert or assume that block isn't NULL).

thanks
-- PMM

