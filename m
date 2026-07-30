Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4252AC55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQBU-0005Gg-LD; Thu, 30 Jul 2026 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQAu-0005Er-Hb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:47:55 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQAp-0006Py-N0
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:47:45 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81ed000b507so21306397b3.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415661; cv=none;
 d=google.com; s=arc-20260327;
 b=gW0Lvq96Era8yX1Zz5VI/sEkWPMmHjmehFpLZrx5+0EH6gJer0NCMZ8vq0veSMPzg5
 efAt4SGJuvoZaSSGDa56n9manFxfALEUWSOz7UCyPt8ZpGCl3bDqWkMbgbR30yOqk5tJ
 05A+KBLesSDwlpSveCTgmwTmYR/8yA0iWMDIu8DBYgEF6o5y2/P3xln4JNLCvJJeUggD
 h8whDbpdwtu412gF8CN13MaJ6QP1sHc/cEjkOSAkYrEzhV7ECEsUTtsgN8542iTqRLe6
 dFsmfM8bwVuOUovbGW/Fai1xSmf9iodAzu2hNk+B7COyr3iHRlkSbgaxae9cro45sGa4
 LYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bxFdje7jjR+zvKahWORqDVEHGclh6x66ydhbsiz7wmg=;
 fh=qfEqggjM1nwQcACoAs+knt93Mv1DjZDIyiTP3TgukQY=;
 b=VPQue1MqqRt9PIxPtc7V9oTtYa28YTOvzcdfQAfvYX2bH9rJRkqbXQArPHjUkLulS/
 xiPggcuju3uS0BuTmvxaJVj1taOPYAa0Rd7APhDaWAdpam4kylqfRTqePK5QiaCNjbh3
 /k3LR+T1eE/LHCdu508yRLFOgttl377KTAQjpq22QItHxOgNYE3U/S+rSqSyghgWMtZi
 Qn8p5apdvpJ+i86fpXqVa4LQqjbxUIeA7+xzxzQ/SgNw6TT2Xhdqg8daYMsFw6RnLm6V
 x7bVSd+2BM4znHhRbUk7Vv6wtS91C3QsSv7Ks2DrWtiCYoXEVZBE2Nrlan5mFrao+sv4
 4eDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785415661; x=1786020461; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bxFdje7jjR+zvKahWORqDVEHGclh6x66ydhbsiz7wmg=;
 b=zZWjJz+nTvBst5Y75ynhf0Q8YlJC6uRYFOX3o0ElRr2RSNtIFWoeL8JM1hUpxoNY4E
 6zZ05GL0XilgEkxxLNb66LEAwnXX5dI7uwx7wuthrKL4CG7Y7j4tkcWjsJWAdO/WdN2R
 ZgRou+RHui9ayqh3jjpONGs3mRsqL2H3/savUHb/J/+pa6A75vvJThG158bSZB5wf+iQ
 hIFvrU9p2YTb3mEZ/Tn+DlV5nXx+hrWo3s5rICBSZk5vkW8cOoS8K7dSXxQa0BEbgxHh
 AoRlTWx+1T1OMA7XDCB0sfnOF+tXrJseCqvBAHW6yuAsJMryEj9HZXAgHQglMtduJJGI
 n28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415661; x=1786020461;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bxFdje7jjR+zvKahWORqDVEHGclh6x66ydhbsiz7wmg=;
 b=c5Px2AUTL9VZ6lRbMR2cGuxy+vMjPsOoWJkaZyoiFrrz2j7F+q4wkMcKn5PGJyqJnb
 aNnp8r15ctmzgjP+apvaVA6zkC+iEFHSWRmeNcWMFpm94sXUFJlEDgzaN+5Q7LDyftNQ
 76udZp6P9I7+0gWXATxNOrNhjLsiEwiPa8MqK9Go7NLrnEGPzenDTG+0NUiwY370jprc
 BUzPn42aQSe6F1rNkLCQb93oVcEDEJLsxrSGJ4YduM1I/t+5QwhEB7SV23Oml1Cfmspu
 QJbR19B5VtvFy+nuyCjSOEsbOHZv45VY3xv8OyCMAGTAYVQ2g/wmpaUwe1lVc+6W/JRS
 1Ypw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXIdBJpaJH4hQiw6gXsff4iinEiH0s0+o9xmRAVscrzOBtUKR2OTRrjK5sxtnidwW7M5AVusOodBQZ@nongnu.org
X-Gm-Message-State: AOJu0YzC3Taa08szUrMY/aWIFDJg9pJimVPeJRCSyCooUUW1tDjZGgxF
 74oraNnXO1zj4mK9rn4CPFksqC5bMvUEYf4cemx7f6tnSf+tL54U2cN9KBmCVsiuRMIcQ6Qwtwc
 OAa0muy/j4u/7rxKtkEeL9c9CF157r9MvifGi3idQLA==
X-Gm-Gg: AR+sD122tsnnHhBo6v520qWgPQu8Q8tIzH7hZzxeLFMpjmJHBjHH3loSoyFxn8NYNP6
 dD9ZRTgm+p3L1/jleKtqMFX5JutPf+YCUZQpql42u3ojarv4ZkyFuq47GUAKZKiaeX2r5X71+SJ
 M/S0/KFguke0rcG1mUWyAXHDIU78UvzKRyL0BkFLYTW0YnfUgRJ71nlvPVQGDyHs6o+yP9R9Zk9
 n/mZtLhYpJb9qU9KRA2r0A7xu5/iDJ2xoi/ilDqytBS0BZKu0fcbFKsMe3JS4t8uBWnHp5kg1oe
 6dwcJ4d7glWcuxjmKMV+DGosVU/Fjx6pkxWjwBVBsKvre2RoSBCjgSe56xzjO7E9ofaJmzGtCft
 vIYfQ+/NZmbQvjpMMzQu20H1bcSIJ
X-Received: by 2002:a05:690c:9a10:b0:81e:6a10:f904 with SMTP id
 00721157ae682-81fb8acc1demr15752097b3.45.1785415661447; Thu, 30 Jul 2026
 05:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-5-titusr@google.com>
In-Reply-To: <20260729231325.3808993-5-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:47:29 +0100
X-Gm-Features: AUfX_myktQa3A4Ln_TqTYZyhBnV8C3Zs9A7DubEX9NAW-SgJPwRN32D4fSLMQZA
Message-ID: <CAFEAcA9JKz6e4j6+-14EtpWs=g_c-EYE2Ay3OfyikbWOiyX8Ug@mail.gmail.com>
Subject: Re: [PATCH 4/8] hw/sensor: update adm1266 block transfers
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 30 Jul 2026 at 00:13, Titus Rwantare <titusr@google.com> wrote:
>
> Fixes an issue with reading the MFR_* registers on the ADM1266, this
> device has an unconventional access pattern where a block write of
> length 1 is written to the MFR_* register with the length of the data
> to be read back. Simultaneously, it is possible to write to the contents
> of these registers so long as the block write is longer than 1.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>

>  typedef struct ADM1266State {
>      PMBusDevice parent;
> +    uint8_t read_length;
>
>      char mfr_id[32];
>      char mfr_model[32];
>      char mfr_rev[8];
> +    char mfr_location[48];
> +    char mfr_date[16];
> +    char mfr_serial[32];

This patch seems to be doing two things at once:
(1) fix the semantics of the accesses to the MFR registers
(2) add missing location/date/serial registers

Please split it so we do these things in separate patches.
(Notably, part (2) depends on patch 3 in this series, but
I think a fix to (1) does not; we might want to mark the
bugfix part for backports to stable.)

thanks
-- PMM

