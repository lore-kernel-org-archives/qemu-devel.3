Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE81AD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZvK-00013Z-Es; Thu, 29 Jan 2026 16:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1vlZvF-00011G-3g
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:51:30 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1vlZvC-0003xT-Rm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:51:28 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-505d3baf1a7so2831cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 13:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723486; cv=none;
 d=google.com; s=arc-20240605;
 b=B3mQR+VzXJ7NR11fZJDYUU/FuXLS4e21g70NebVlub86QDaWh3X/5AtAEdHzjxLIz2
 JEM8hFBOZghpcVsAEcXh3aB5UuyPAXwTpm9cUVjMWwtEODJWYNE/Jf5VCOpykNW+V+WJ
 N49LJjvMtCfMgTJlXjxM/MjIFfhjNbA0rDZjBARemQnfkqZv6RuCKTXaj6CA7in/Af6Z
 d/xadg3qI9M6f9XdwJnfkZ6FH5OGtOH7sItCR73/p98sGBy5PUA9qn553VhLmYK6UAGr
 QGe9ePCXtIEI37BquXMkYddWZ3bPJTGekMgi9PdakpLd8UBfLhfgRd9jHuxc+wODdzB+
 9uOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JB5sHSBTgpiwm580DTmV8/C3fDsCqiRa/JzFw6HZfPk=;
 fh=n1hjJT/kTsf56rqa3aBrmTBBt8BCw4F6/BlqSChW3sI=;
 b=EbHIu0rhtuBBKDjFKAddzdglGHNsMwIbT+wt0wXBxEyfeSDIKQvo+MCDb+VGI06RTp
 5WL5dJoi/y+pkh5JGkphbjPlgKFEhewGIkXwd0BYJX2nGLBPErWYZARUZZ8CC9NSphR4
 VTe/AGN4/fJTNWVZKvgu7Ic46a0ejs4FOma4uLwrTVFBpvx6RaADSLv5yCcqnjjov4GZ
 9hGSLQUp8gYAtPUjSnRmTGeYMjwovMA8kYKlokyjeeJdJZjKvOnseDu6VE1nxdjdXQVx
 J8DA6ClVA98f3Ry98BoSyNRHXEGhFnwqSRwrrDMIrioZHM7Cp5Uy7Lx1wZzjl8qqvIp+
 1Sqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769723486; x=1770328286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB5sHSBTgpiwm580DTmV8/C3fDsCqiRa/JzFw6HZfPk=;
 b=AKIwkQehPx+rO16BgwdQgSHpoN21zT3k7YUWO3vWzwVvnIEk4ALuXrGOM+l2vohrZm
 x+EXgn55UyVAx7oP6md/c3V2N5AWVLBxDTm3arkKLuylJGWxfDYpMnYfP5958/AVE1Y8
 5vfm82oRnJBK4JqFkzvv5CnyPUf70q+7wXUzcgpwO5qNKUFLxkeEvhMHv49ZrOuCv59L
 kId7ZoIzmGYNdOWw81MaQaYVjH9K25mxZy8VR7wni7LGKLq3E+Te+fkiuGSPZWUHHtf+
 4pRHaD7k/wHKk9vIg261ZwCRjZ5/qgq8cE6qM60fIZdYDzbu4XKZbm/PdsJejBlSGCAG
 jhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769723486; x=1770328286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JB5sHSBTgpiwm580DTmV8/C3fDsCqiRa/JzFw6HZfPk=;
 b=O06KUMroQHSGvuBogtnbiBPynKc9XNDfATz5pMTmzPeDasR5Zhu0SKYHj92NP7CUdk
 Dxphr5vOhU4oRHNI4VW59uRyhFan0Q3wg3SWGWTOGB6sQtC+fFS33Uv7w3kLpe7l7EMZ
 eOj1Ic72LSoX/9J7TB8lBlQJ9OhSaju5UJdTDPYcRUg39RFiKy6lvu50iHqLPOcWU1G0
 mgvcbL7MsDp54R5bh7rdADu3Y5xtgbD6bGE5Wr5vY5smkVhmdFYBQ7TESnRgkKdAcT5i
 Tq8JXs/fFPiOhAxyhEGbtYcZMC/nqcIduD6tesM9VOJJ3HMrOsvoRiR4BVAjP04Qr3be
 byFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVktMugZeX6nns//YwBPczE0Q7rj9cBnug9O00Td8aNSWlZTu9spIwqdWd2YVZpHucp/7r7MJzLnKBC@nongnu.org
X-Gm-Message-State: AOJu0YyN/mbSuLZN3JmzoVq3xbE5AjkF4zZvJ9eL6Pgsc6B+0rGYeHla
 0+sK1UQMHLKHx1zhPAp5u9FceqJ/P7R9+Dby6MJw8Kf0suLAffxAD/vTgct7U5Y2CqS7vO3nSyD
 rLvgmpEe93ON0qt58d+zAZpyvgaub4GtfIvqX512V
X-Gm-Gg: AZuq6aL5zaq/0IGZ6WIAkOLay36/E4YdQcW2awvrb8oRCIDULWBOn1rfp6hRLD+loOZ
 cnK9lv+Ttv7PgmkRQUNWeiurEs1x2GZnSxVZJRH0VcBUk0Wlqa3kwhx0rjLJCxe1W9HSunxyG9r
 zI22ePZlZp9PqpnnXOAyKNXc/Hr/DjsuJ2MXtk0Nwph9m+MVWy1P3WCOIOx5Wj28wNdpHGFTBqa
 F+i0jUdIriC2D63ApQ6cIbsJIt1Qn8BUIPCEZbxKccGvTU23KTo15Nw7CvHilRgKvMIwsWcO5Ef
 LdiSU63TXC6oF5WqAXhSF8Pqbg==
X-Received: by 2002:a05:622a:190e:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-505d2a045abmr3172921cf.18.1769723485468; Thu, 29 Jan 2026
 13:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
In-Reply-To: <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 29 Jan 2026 13:51:14 -0800
X-Gm-Features: AZwV_QjravbClAF6cXqCUYKRZjCLVUJyuBT-NYY_a7GD2NrXHCxa5eGy88hJivM
Message-ID: <CAOGAQer0tav724DOnjsEp+1HJEwsMuqdNjBSVR2yU_KyG0B0Fg@mail.gmail.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 mjt@tls.msk.ru, 
 whollins@google.com, jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=rkir@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello Peter, thank you for looking.

On Thu, Jan 29, 2026 at 12:31=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> > How would you prefer I proceed?
> There is also option 4:
>
> 4) Don't change this, because QEMU is not a C++ project
> and it's not a goal for our headers to be compilable
> with C++, with some minor exceptions.
>
> What are we trying to achieve here, and why does it benefit
> us as an upstream project ?

The Goal: to cleanup the specific header include/ui/kbd-state.h by
removing a redundant enum declaration. I realize my original patch
description focused on C++, so I will update the commit message in v2
to reflect this cleanup as the primary goal.

The Benefit to Upstream: Currently, this file uses a verbose style
where a forward declaration immediately precedes the definition.

In this context, the forward declaration is effectively dead code. My
patch consolidates this into the cleaner, standard C idiom found
elsewhere in the tree (e.g. include/block/block-common.h):

We are proposing this change because kbd-state.h is a public interface
header causing friction for downstream C++ consumers. By adopting the
cleaner C idiom here (which benefits QEMU by removing redundancy), we
also resolve that downstream friction as a side effect.

