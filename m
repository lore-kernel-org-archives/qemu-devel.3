Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC78CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSx71-0002PV-Ni; Fri, 29 May 2026 09:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSx6z-0002PE-FW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:18:53 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSx6x-0005li-ON
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:18:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1742746866b.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780060729; cv=none;
 d=google.com; s=arc-20240605;
 b=A01k5MDsVVQIAdN/5UtUXqtoX03GGwqGi7Pq63P960542be9KbRlk/NgdfigaUmz5f
 Tumt/FaEEZzjlH5AsKT8S/vMwGb5d1gZVgUQbXTr9rRZs0MX77ZFBC1weSEqGZdt1J8g
 MjniQGDswpIlgMh0fbY64jWAZWyg1tQPWrE2oUmrQ7zUEpFRgWAavqdOApL52kt0AJJn
 /lEQcSFswF1DAssIjfgEQI3Cj4mG4R57PEG6XwmBD58k6g3o/eF9rQFwVXEV2SRWCido
 yt8RHBhQnmEwzd5O781xXSdsS+U4fpbFVAQlTgEymNGu3KHF0shyVDRVHFz9XIUcUByf
 8YTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WXIJSqB041pMPXTkOOaKd/bLZWqppRXmVBXM0Py/2i8=;
 fh=8uPdt4wUQ8sgzr3+yixux2jJHjOrGV2pKZFUaE6Lbck=;
 b=hdLdw9XN2EESoX4qbDiB1ohUnAPqYjzBPHHA6+5AiKBpRrNfw5v07oxzgIlNRA3uIz
 al92py5bTeKxtbsBFDuzAT1aqSH69uJ1aCWD7gvKtd4MuYQkyhHYcMl96VeLywMhOWpo
 07rpX4axfmJw76MojkmCbOvqW0FZfpeL60sXCRimSI8mPNSaBp+e6mE/3zAHgX3u4MuH
 MV0nZfcSkZXx9Ibio7REhL9tKPvAJ6r0Q1lVDQjqYgIpeA7eCdOwvBvp1mOlongXEKnv
 LZXSjgro7Q3zFCj3qSlZ2SauDcWXvhtdFW0rhWwhiaD1jRFW2ZmkNqUwsusUC9hhUgu8
 TrhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780060729; x=1780665529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WXIJSqB041pMPXTkOOaKd/bLZWqppRXmVBXM0Py/2i8=;
 b=VwvzrCLVl6iI+/whMTG/hVrK1uPOOQCD9/v7GgMKDQ7OcRMgnZf4D4PJVIPDvnkjRc
 iJlwyhMrOWiOvV9j11n5xi6JkgYwpLxgXEOBZ2WalxGEukWNcbwQj3XYfkaJl6fsE/Cb
 rQYf2dp8Sip5bur6gpG7mwIz6vKbWoxp+SZHsAYwUuB2X+LBUkOKp8RS2a8699YpNUS2
 vmGkUn4PfMoBLU2gb6jXtZMn5bi5PN/gZffKwfz//wFr5BG0qRInrjPcqb05elD2LK/G
 5ZulU7gsfdDwfjBJdvtn5MTVXsipXzAhhSxigLGAL9WpzOMt5nFbT+l6ymTbkcpCrg9/
 IgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780060729; x=1780665529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXIJSqB041pMPXTkOOaKd/bLZWqppRXmVBXM0Py/2i8=;
 b=Z2oykAd+TiDsmT32/117rnLtbBtSJ4nGvFBlMIX+xpRCPHNqubX/sJ6dSMKzIw3vsm
 WEb4zaBeuyskQfBSuF8TAPqbBSI6ues28QEL+RwQLdZ6wB/zS0x6KXYHrUkkETy2Gj28
 F18jDY+TKReJczJcOOYPjdL5mLDiCoNpWdMjfpmemOMcz51tPhfRqaSLOXUHFomAa5+5
 rtkkyaCBicP8kFWLqoeu/1cUDOHJStq8zdQE2WkbwqQkO1AGykpPnAOlb46ln0iYSlOO
 4siQuHQh7m8yds0CkhmkNyRbvvy8mhJj/SeSUJ0QmuwHhkO9MJwF7pYTUqHoEivXltdv
 Lwxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O/5TKDE/ESam2owZmnFNwiUVxHPwBCoMfsELsi9q1GjodPV8dJMV26cWLZDKdjjfEoQY5jUQbcOeZ@nongnu.org
X-Gm-Message-State: AOJu0YzrzfZspT4gl6N+Hyd1BUfo8PdncCZCJmLRba0CkGrHNsGT/I1l
 aTeK52RjwqM6TsbA9+Q9GE24I5Fh02S6svly4WYhFDynfSqS26EDXSl6h3ecRT9drvTLSONPmgN
 gGP7lZqT4dsqFQvWfeEN5uUW3waoa36c=
X-Gm-Gg: Acq92OHKxV/bWfy2/dUFlaFEEmjmxF/HgbpzJnuimgDbgAEN/3W0c5XKTxua7ju+mQ0
 SQjxSizRHeiON1k0vVusw5PlWxNAzE65Towb9nyzLHTD9pFX43S846hfQVOy/+Bx/4DjbrMXUyA
 1FJ1v7eVNTZmdLLy3cVxa7XzTtdIfPG8/0HCNNjVAsPzHvwi6WhCdWr54zuni45uGNGLj8bf4Lk
 pAryne+WlbX8007nB63J73KYW9/lk4mxz0FQ3o4bvfhPs0qvBe8xZmSyER7Sj3AWVPXnHaK4SJH
 nAlmdCmlKtGf1doXfzCo25Q5Vk5/KbSZKBXaGlKTAIRSFkwabPbb
X-Received: by 2002:a17:907:c28c:b0:bc6:92e5:818a with SMTP id
 a640c23a62f3a-be9cb8d1a5fmr157142766b.21.1780060729144; Fri, 29 May 2026
 06:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
 <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
In-Reply-To: <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 29 May 2026 09:18:36 -0400
X-Gm-Features: AVHnY4LEpRM66OzW95xXS48JUyTxDVElwcb9ehSwenwI2hPoFDkZcD_iy-2SfhA
Message-ID: <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Warner Losh <imp@bsdimp.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Warner,
How are things going? A few options if you're willing to take on the
maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:

1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent
FreeBSD guest can be deployed.
2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system
installation (e.g. dd and reboot or some other trick to overwrite the
live system). We can screen share and you tell me what to type if
remote console access is needed.
3. You provide a recent FreeBSD disk image, I upload it to OSUOSL's
OpenStack, and I create a new VM from your image.

At that point you have access to a FreeBSD VM and can install gitlab-runner.

If we don't have the FreeBSD gitlab-runner online when Cirrus CI shuts
down on June 1st, I will temporarily disable the CI job. We can enable
it again when there is a runner available.

Stefan

