Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A31CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sloxt-0005mW-EI; Wed, 04 Sep 2024 08:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sloxp-0005lm-49
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:18:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sloxn-00032R-Gw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:18:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c3c3b63135so581757a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725452297; x=1726057097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6haIxqunDPo48CI/+2LsH2lpR7EwyF/jPInFjf8Gu90=;
 b=xYr+G0xdd2VLekKGR4JYXhoVSfOO3s+79cU4BtVqC5bZ+Esum15W0d4aHgrckCxg0Z
 XIgfJGQ2TNMXz7sjed+HVgnQPhUMgt+PXMmswTVyg2BKEn89vYoToRcwOu++wZNEZOsm
 TQV+AsT20HOM5tXftvt0h6Yoq+WY/wdMizXV01ZUcnS3g6ryKDUApSDZrPJUldfzN2Ie
 JWXs1MUBskQReKR/u+R+IhbEb+ZXoCzRFYIaWPI/1uET/+t1UHs9Le0XSE5VbIe+brlE
 C4ZtvcZQsIudtXXudqsgrrX7WGUku0SH+MXLECDQKr/TcM/TYwyhDcnu9EjK1tY0INja
 Tw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725452297; x=1726057097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6haIxqunDPo48CI/+2LsH2lpR7EwyF/jPInFjf8Gu90=;
 b=hZRWE5l8ctR0ZFd+wrGbj3K8rRU/sw4CbszR70RWFZU534OzsWLud+1qLq+vO9DzBU
 mjb0sOToOw8P5MjGBgbLKycXUt52C52ZLNqZdrbL+kD2LU9IrW4UEcSqus5iHBOMQNrd
 aIkxXO286o6bHc4BtoP9Vbg6VAURvReB3ni5cVV+lpqp8uymD2JhohY+Oqx4SP/X1KLs
 HjORgTcWtGCDLmWaYkDtrgBfPYcBwOeDfYsI8bzrMVFN+5po6aoZ18jJCIE2oCCaYs5Q
 CDfuo5Wn+0p3uVRBQG7TuxE6ena61iQNoItW3/zGnYUTtSsVMa8DOq+y4cRfIIM2ifhI
 03zQ==
X-Gm-Message-State: AOJu0Yw6ZZQnYPE9Ut0QL8OgQLLiWok19qm3mnuzxpCdGo01nN0OL9Fk
 cCUTGOQzgyCiVbnGuSmOZW5AUBa9r4M5bkGU5sP+HKWqrga21wUyWfdoFogja5dg98inDYtbjPI
 S7ODum0uPpnhURmOlC7gM8LgcfkfAdpAO3kUImirrDm/21Sjw
X-Google-Smtp-Source: AGHT+IGTYwCiT96aaHuoBRu1+oNNsbzbhbVnfQh4sY5ZU2tT+WAlXc9+6rLzoZIKxUXg+pulgjyI0DNAEmjgyxuVBbI=
X-Received: by 2002:a05:6402:40cf:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c2757dd0femr2940072a12.18.1725452296814; Wed, 04 Sep 2024
 05:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <1832886563.20496.1725444713946.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <1832886563.20496.1725444713946.JavaMail.zimbra@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2024 13:18:05 +0100
Message-ID: <CAFEAcA9dno-ZA6cSMr556-biNphdFHBhBXRZsavR43XajnTH2Q@mail.gmail.com>
Subject: Re: Are floating-point exceptions usable on AArch64?
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 4 Sept 2024 at 11:32, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
> I tried to provoke a division-by-zero exception on AArch64 using:
>
>     uint64_t value;
>     __asm__ volatile (
>       "mrs %0, FPCR\n"
>       "orr %0, %0, 0x200\n"
>       "msr FPCR, %0" :  "=&r" ( value ) : : "memory"
>     );
>     volatile double x = 0x0;
>     volatile double y = 0x0;
>     x /= y;
>
> When I look with the debugger at $fpcr it still says 0x0
> after the msr. Are floating-point exceptions usable on
> AArch64 in general?

Floating point exceptions, in the sense of "when the
exception condition happens the cumulative exception bit
in the FPSR is set", work. What you're trying to use here is what
the architecture calls "trapped exception handling", where
you set the DZE etc bits in the FPCR to get a CPU exception
instead of it updating the FPSR bit. Those are architecturally
optional, and QEMU's CPU implementation doesn't implement them.
(Nor do most real hardware implementations AFAIK.)

thanks
-- PMM

