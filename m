Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66440D41175
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLKp-0000NW-KU; Thu, 15 Jan 2026 06:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vgLKe-0000KI-85
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:16:05 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vgLKa-0004JL-AY
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:16:02 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-50143fe869fso8877151cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768475751; x=1769080551; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOmwEXz/QnqIYZHs2pWGe7QjqG39CGOpyg+CvtEyUG0=;
 b=aAQ6oNv7z4v9SA7VFE27QJEGoFJKySgE9oxhLj87bIDWrPGg0JkXrbo3dLw0EhdQuL
 0mQnc3/SNviytWFImasxl7CGgURwfIDkyLQdB6nWBBnldIlMgLiKn/+v3b3KJYjDPzG1
 RTTYlo0VtbRjOg/3rPQeDGkPPdYWWBnY05cE0VgvIhTJqzLx/m8BGzdRLVbuR/Pp2RaU
 SBxGPoFAl4x39NszVHwR42ElmnmZ1ivZzm9Qe9wB5jgyjmo/JcLyF+lkPtvAxiZIaVIH
 iKDGJ4puIVDCNJ2cYjrDJE7I9dU8ZQJcNrtfRWSjlkMSMfluTxhNjMn1rO+rQrEwte2w
 JDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768475751; x=1769080551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOmwEXz/QnqIYZHs2pWGe7QjqG39CGOpyg+CvtEyUG0=;
 b=uUUJKiK2rCeZcSK22enw6Sb5ObQ/V+jsHyi3w30vBuLJ4SRdRWRdk8Wp9HxnKlZS+h
 S30aV+XIv09JmzjwpYPSJvHqTEWsREguEvD4tInglq3HOgBkipliHS4hHo9qzhs8Rqvk
 Qg9tb47RaxFD3aD6TrN89ABvAkTvp9o4OTcZfWiAlK3eGI4g6pcNakip/0VKSeYhRHFV
 kOPy0Sy+hoAx2C9gXk308KZY8JZ15+DxQ6kNMr5BWMYKbTZ8SMwT/OSYgQd6/TK55rvk
 HPMDqAqtkLBx1AmBEVjhtoMEXyhjC39SwsHDZ36nFZayqpY6K4eHPBPML2l62EfRmqiH
 dDUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD5ZtjiGCC5wred3sYIiEbQLr4McmEWWWlBz6D+poEweLPic8sv+AWKx1ByZY6hvHewRqGZiXhFWfE@nongnu.org
X-Gm-Message-State: AOJu0YwhHNv4WBWpCdR1YBUSE5u5TjBCzQbjtKuuHg5xZ90eLXbPs6Zi
 MyqqImhCV+ySLjMxI6o1qO663mdbRhWAPJirzLCFohhwoJhsTmmPHT6msJ91wUTONBJ7Mg1wMhW
 QojfhbSlfKdYUEqhQEeqgEMiLMEeOoFc=
X-Gm-Gg: AY/fxX7lLPHloYUcxZJdP6TJ0pwjO9wTdpTorJnDuNR/bNbqpXRkQRwk2PBQSLMPZ82
 Itbi4hKu5ZfpOqnGZd1aKmAvvxS2jWOJjyyhAIPBOFiDjYZwjosR4eoJWClVnFAORvDJNmvme28
 Y24CdqIxqjMw2XUypPtAa+kt+NaXiOLTJEAHHbXwQCSYJaP+RpGUbas/BOukUu20HNx8kSpw6zB
 77am0djowNZirFFNgO1j3m4gr5XDUjIoX8zIKJPiDGpAAWFFsg2mzxabOXsolTpvEXsJ8d5AhTN
 nWy51E5qVXfea8Ie6Xpya2kuZL0=
X-Received: by 2002:ac8:6f13:0:b0:4ee:2459:3d6c with SMTP id
 d75a77b69052e-50148481cbcmr73615911cf.58.1768475751408; Thu, 15 Jan 2026
 03:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20260115020423.722069-1-dave@treblig.org>
In-Reply-To: <20260115020423.722069-1-dave@treblig.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Jan 2026 15:15:39 +0400
X-Gm-Features: AZwV_QgCTVKCAnCrHFX7wiY9_FdFWVM_kyUXpdfK0XlVA1baBSSwBegOg5U5mRc
Message-ID: <CAJ+F1C+3fsq8xuSK_FZFEB55mvmkw0YOyvHYi37ONKH1vcEsMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] HMP: hxtool sanity checks
To: dave@treblig.org
Cc: armbru@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Jan 15, 2026 at 6:05=E2=80=AFAM <dave@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> Hi,
>   This adds a couple of sanity checks to hxtool to try and catch the
>   type of mistake that Markus' patch fixes.
>   (Included Markus' patch since otherwise the script correctly fails)
>
> Dave
>
> Dr. David Alan Gilbert (3):
>   hmp*hx: Move info docs
>   hxtool: Split srst/erst add checks
>   hxtool: Error on missing docs
>
> Markus Armbruster (1):
>   hmp-commands-info.hx: Move definition of "info accel"
>
>  hmp-commands-info.hx | 33 +++++++++++++--------------------
>  hmp-commands.hx      | 27 +++++++++++++++++----------
>  scripts/hxtool       | 38 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 65 insertions(+), 33 deletions(-)
>
> --
> 2.52.0
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

