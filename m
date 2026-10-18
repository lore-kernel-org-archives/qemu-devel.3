Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50A1CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xINre-0001ro-PV; Sun, 18 Oct 2026 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xINrW-0001rR-V1
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:11:31 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xINrV-0007Jc-AQ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:11:30 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b05bf699easo8903057b3.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792318286; cv=none;
 d=google.com; s=arc-20260327;
 b=CK6n2IXjqPBzO/OXl8pWjLee0SfowWBNIYTAxxs5jfGQ4eWAT/FP/KdJLU/tcImuKy
 nbXFr5ZRGVUWII5xafzDxjGEf4gASbxC54QRwvXVfMp7ybGkFvq9LEMs5kLkiZ5YPOKF
 1JYGow0nxZKsvYiQ+mEQxo1kERLorDpA914XSkEJuX2YCPWM7UXv3jqsaWd4RXBiPlfn
 JU79Wx3Z0YOQPZt3iohF3KfM7wDhL/mWg6VkOE7dGNRYAEHfp7WYcRnZG9xRBMD3od4I
 gIHDim0/bEVVaHeN93j49zkWTfP2nfb/1FaHcjcLx3xqq9iLccTXMmrqNsORRTBXet8Q
 7ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A1mf/h4rs8yarG4cfrPSMjATG0zfwYsdn7iIaUhN85Q=;
 fh=MaPMZVROFfhGPd6Epx9Ku7CN+EKyDtJKTKzt6bmFhMc=;
 b=m0CZWGEp8p4NA9t+F62oF5uoGkJ8IUA6kmTQnyFVVr95XEk5llprlzKC+iXV0s+Ugs
 F6C1gZqfMlU8nCImBFtOj35DvVKPw+jQQVZhXptQbFeRzqLYp2OS8kTrunNArBA//I8e
 ItYfLphX+zo0zLjICdOqNM9On7wuoU9uhqP9L+wT9RCKkOMUoqi/Bk5S7NrxdCZpBEfh
 CaUAMPqJv4DHbwi6LUW3CAbnan//eoTPa0xc48ilk5XRHBb0FdzFamfREnLbwLg/mZUy
 Iw2/88lvC5K+b/OXBuunpWcQMqcY1THBrOEH5XI8pVctKhTMbP+D7rqJlnLyRaFZniNf
 khAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792318286; x=1792923086; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A1mf/h4rs8yarG4cfrPSMjATG0zfwYsdn7iIaUhN85Q=;
 b=bir43h2SEhGtTZ3BGy7HXecijpnkwXB2QMzb4M5iLHE47102u/ZFxevMSwJHEqwG9r
 WhOcmH09frVkrEEy6424ktk0DeodGiWW07Chz3JlSvMXecFnUjPr/k0WlAV99E820Dbb
 eYEQEvl0c0ZOAVDoQ8091ZnC6VwsLeKtoBtOFWXoYLJQEZ+9lesJmlYryUbn3Bba3JD3
 TEtb0X9edC7tzBgpVB8SLJjn4aRS4DEB0X3ZGa/76oCybBIPmTk2QS0gjaKkPo9vdmxG
 X38ZW31/hAvUTfSvQ5z4nsHXcMex8Dn4NzvTkc4WpL7GUkcm1mXOe2NYjlQnfvLrYJhY
 HDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792318286; x=1792923086;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A1mf/h4rs8yarG4cfrPSMjATG0zfwYsdn7iIaUhN85Q=;
 b=Qa+DdUuCpXQtCeJPMoIIwS23CNE4QV9aWXKhT1bu1YwMe7wbmU+lRpxn4JnyWRk46v
 DajEOnB/KDGKvm+o8HneUtCFXOKKyFVD8UY60mKtoXSMSgCdfMk6p2PsSP8d7Vbk8ZS0
 uGXBHNngUV5O7hQTeFi2Pf5mLrs3mKyBLexsdc4FcbE/yn3xh6I0LPezs0Gt2acopAgP
 mxVjP45kaNbBDvtfS6jdpiVtKdpzwjaKRqiFdmT4K4YDFnzsXyOwwqeZfTVy8rN/KWFB
 EJTZL6JFbXpjD7mN2nI/lmsH6xU2JbvvROrWSVtkTmDmGVwzVFmnr2b+2dZU2fK2cMLX
 iaDw==
X-Gm-Message-State: AFq9FYIG1sFh2njkAkdImoiDWT+N0xmkL16YfknMU8YEdaJoOVDLoNb+
 9ZD9J0hxF5HCQs5cYxPp6yfkExNAq4blMQPpoyNL2CHgniwOCagWRJoCiqXdEFi6BsByTZ6rpFM
 GiW/0MzkgMW8hjJiMOkOhYCXsDngMZNxiVg31m6MFRQ==
X-Gm-Gg: AYBFou2/g6VEZ/AVGrtf652h++fexPmbV6DBNqu3G0hIex/WoHi9E7Z4Ju9p5GkRk6q
 EklpbgULLcv3NNWG+abFqsWKJlzPjc4Z9+k6idHcwL4bssaNB49iIgT6ExT4cmIYqHn3gMqyt1z
 7cRJO18V6TH2o0O0NZr/HJcHsmRowdTFwifFfoGOZK7aGUVCrsTP45PQeLupbiVFoHVsc+/mpYT
 tNO0QoQOMEJ+XoF3muy9I+X6SaTD12v8eoFgUPeKdoBxosc6mcTOrajk/pHc5QnVkOQnK/YYduD
 i/BYtQvujyYfcC/ZbcLF62w1CDDHHxITZ1FMm+tEzj+zmQnr15Sks/rCJuDicvqzKdJc3hJTUfu
 efS8atYNFgSfR6xsSCT2GZa+PpN1FdfIr0cpwyMQ=
X-Received: by 2002:a05:690c:e20d:10b0:8b0:a1d3:3823 with SMTP id
 00721157ae682-8b0f218aa63mr11066417b3.24.1792318286504; Sun, 18 Oct 2026
 03:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261017-allwinner-gpio-eint-v2-0-82906f440378@gmail.com>
In-Reply-To: <20261017-allwinner-gpio-eint-v2-0-82906f440378@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:11:14 +0100
X-Gm-Features: AclHuK9ta7VjERKJ8di5c6DCthpbpeQis8bnLohayA6tZw3xKhpXZUNotMPw520
Message-ID: <CAFEAcA-hLDE7k4jauuasJq=3XD44s7kbQ6iEQa5dxkZ8ROZJCQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fix: Allwinner GPIO interrupt handling
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sat, 17 Oct 2026 at 10:15, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> The original patches assumed that pin had to be configured as input in
> order to be able to receive interrupt. However, after additional testing
> with libgpiod and gpiomon, the pin is actually supposed to be configured
> as EINT (0x06). In the following example with PH1
>
> root@cubieboard-ng:~# gpioget -c 0 224
> allwinner_gpio_read [PH:CFG0] -> 0x1061061
> allwinner_gpio_write [PH:CFG0] <- 0x1061060
> allwinner_gpio_read [PH:DAT] -> 0x49
> "224"=active
> root@cubieboard-ng:~# gpiomon -c 0 224
> allwinner_gpio_read [PH:CFG0] -> 0x1061060
> allwinner_gpio_write [PH:CFG0] <- 0x1061066
> ...
>
> The CFG0 value on the lowest nibble changes from 0 to 6.
>
> This patch set fixes that behavior to expect that pin is configured as
> EINT in order to allow interrupt-related functionality.
>
> Tests are also updated to reflect this change, and a new test for pins
> configured as input is added.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> ---
> Changes in v2:
> - Moved changes to the interrupt handling tests to the first commit, so
>   tests still pass once the commit is applied.
> - Kept new GPIO input test as a separate commit.
> - Link to v1: https://lore.kernel.org/qemu-devel/20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com
>



Applied to target-arm.next, thanks.

-- PMM

