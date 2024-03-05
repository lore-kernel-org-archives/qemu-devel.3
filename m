Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345D7C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSkA-0000hJ-86; Tue, 05 Mar 2024 06:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1rhSk6-0000gg-8w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:13:55 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1rhSk1-0004mb-4s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:13:53 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e56d594b31so345334b3a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709637227; x=1710242027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cn2pL1qremAkcnc9vQi2RIfUGtYRTpr9NM926Ppq3ko=;
 b=PeRjv0g6Rv1gJiI1OqMkhouxyUTMy+9/ado890f54fZZodXEDNlW+gMCbm5RpRfjJM
 l+IReF8XToKtYkq6egtb6TTgPQ7bT036CsMksjsv3I2Ryo1oMXdbFl0rsEp3TF4GSOq0
 GUu1AstxWyzrb62wvcjkNCk42/E9zPT2PcFRdYPNAjMd4ja5ef7XJIkOcUuDI66Y89Bp
 3KJNX3N4yZkxl6D95z7FxOZu7g/QH+23y+IsuDYY61HsdWgHpw2DTeK02EKvb65QbyRz
 SKNUOsqy5zoDYVbmSAk3QFbXLRP7+50QxCIR7cKFlmhjboPulKfUCOzu1kVEab+uZ9HK
 3F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709637227; x=1710242027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cn2pL1qremAkcnc9vQi2RIfUGtYRTpr9NM926Ppq3ko=;
 b=DmLFxatbb22PDoh1AYm/fqrA5PNuSq3dJ+0Q7HRfBl5yGUpceOF2tzCEBxR5VVsjJO
 Swge2UiZ4SeVwr1K52VppJmqbMSZdJ2qdudnIbE0cecNxh2xzYkpXTxFzjkXnJ9dTIym
 fe3h47FZQ4+HyzVc/X6tZcUtyvREzjAeoR+sBoLeBfXxR4YN9Rq9CPH5q6u9XUIdjPYe
 ztIz07ICpljDohVTK0K52FtOQDrS8MydZIIslavwQHdzKpdkKi1+Kqs1qxnuDzQk8TGP
 9WBMHs7ipLORMl9o8d3KTXb7Q2ZXOs7xJiu8JMeVUhhyGRNW9cVFq73XniJO3PtKQecD
 NlFQ==
X-Gm-Message-State: AOJu0Yw834FGKS4D/lcoVZYOjTx6Xf79foOeHlqLg0fDLvJu0zC+wR1Z
 LPlOYIv5t6O+TXRYqVD6a6fcEEhCYbk0UmKJSosVi3GJfNGU8kxWwDz217pkXJ2kqCUZO3w0bcU
 3CALdJLKWsrXmYh5XW7wUmYhAn9o=
X-Google-Smtp-Source: AGHT+IGjknkXmN+ZcMiCP2UV2SckCegVhArJIyGCBuNxVm6BIuZVCC0bGHfnZLHS7jT/BCP9sQBL4MDLLbMjxWkxk1o=
X-Received: by 2002:a05:6a21:a58f:b0:1a1:4897:c811 with SMTP id
 gd15-20020a056a21a58f00b001a14897c811mr1460215pzc.1.1709637226985; Tue, 05
 Mar 2024 03:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20240223161300.938542-1-peter.maydell@linaro.org>
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 5 Mar 2024 12:13:35 +0100
Message-ID: <CAAM0arMqt0pZZLxjEiLhw-QxL3-+FBE0AxJ8MYkfhpQBAoogFg@mail.gmail.com>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=a.tarasenko@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 5:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
>
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
> Before we can commit this to either head-of-git or any stable branch,
> we need a Signed-off-by: from everybody who's touched this file (or,
> for corporate contributions, from somebody from the relevant company
> who can confirm that the company is OK with the licensing, which is
> RedHat and Linaro in this case).
>
> The full list of people who've made changes to the file is:
>  Artyom Tarasenko <atar4qemu@gmail.com>
>  Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  Markus Armbruster <armbru@redhat.com>
>  Eduardo Habkost <ehabkost@redhat.com>
>
> (Artyom is the original author; everybody else's changes are largely
> mechanical, refactoring, etc.  We've done some behind-the-scenes
> coordination so I don't anticipate any problems getting the
> signoffs.)
> ---
>  include/hw/rtc/sun4v-rtc.h | 2 +-
>  hw/rtc/sun4v-rtc.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> index fc54dfcba47..26a9eb61967 100644
> --- a/include/hw/rtc/sun4v-rtc.h
> +++ b/include/hw/rtc/sun4v-rtc.h
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2016 Artyom Tarasenko
>   *
> - * This code is licensed under the GNU GPL v3 or (at your option) any la=
ter
> + * This code is licensed under the GNU GPL v2 or (at your option) any la=
ter
>   * version.
>   */
>
> diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> index e037acd1b56..ffcc0aa25d9 100644
> --- a/hw/rtc/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2016 Artyom Tarasenko
>   *
> - * This code is licensed under the GNU GPL v3 or (at your option) any la=
ter
> + * This code is licensed under the GNU GPL v2 or (at your option) any la=
ter
>   * version.
>   */
>
> --
> 2.34.1
>

