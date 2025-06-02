Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9DEC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7Rd-0002Uq-RK; Mon, 02 Jun 2025 11:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uM7Rc-0002U7-5N
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:51:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uM7Ra-0004vd-Hu
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:51:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so46650165ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1748879480; x=1749484280;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axmal6ATX2PJQugNB8vvmc0gslsa+RSWT01c45nE8Io=;
 b=HPjwlcrzNPnf7XjRLv3ims8aGRsdscHcN2SzHMx1YPyLEAV5Nw8ivgCO4lVbUwiYgl
 ozcGTqqRI3uR+7foqWKG2NAS9GjPaIA46cYsUEvbPApSa2/3tbvQTCby/jxpqaZO6m2T
 jFhcTNMyqtA8sDDB0CG/6TbtPEHr0ja0y12jEVOK7mII9tehksRtb+589K3DTLWgnROX
 vs1GcnHm2t34QOhAy3Y8FT+n8l6j5R0Y5SqVuwBzIS7pwir/stmobE7mCo7DufVkBBi0
 5ZSGT7I2OnbbRFu3Rj5lOR6gEjxXwPXlcZqZGUH114aC2YyDXe2trHxTZPOEteEDzFDL
 sU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748879480; x=1749484280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axmal6ATX2PJQugNB8vvmc0gslsa+RSWT01c45nE8Io=;
 b=P3J22xRNsEJfIf7jrWM7DP4s1yEqe7fuEY3MsiZgSc6PHE0OgmRd3drqv9vouboYyu
 pU/4Z3ZUTB1ZT/dPauGu1jt+9TY17YFUbtcsY4XWd9gfvJ0vSgz2sK3ALlwhUW3jYyV0
 v3YOtE9tMiLfevv6wANe5r/ixlom/0V7tLZ0sSNtCA/GD42cUCHsZWsWtCqesQ3C1qOH
 pPGGc/1/rLdNZUDJcLtPRxuSGSce/MvjO00q6gEldZBfTfzPJpOV7AB89y7lQnQE32LM
 OAVhwsCCTY+SxLpljIcDV2CQpCClN6MSiHn+xhSVcFDcO/Rqo72Fyu6lsG12GgoUyHCA
 bCyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrIwIM01i1Op9eFkCkUmFnRX6aVeKMOodE+cBNgM2skMozKSBAvzmPkFApbbWZndbZvWOiKfiJL0ZT@nongnu.org
X-Gm-Message-State: AOJu0Yxv1mNruJm7snlNwfhCNpAJ+6KBIVsbFPZA1Ed8d3SUiFV8XYvf
 QLX9OoJb67EBH8841BC+uYgKVpNift/rh2DlAed7nc6qajeQzIsCv54RnD+giZeBGGTn9bB4I4G
 ImNwl67dHogo8/7NEzCDI4bP8tro3h0Yjh+rVx0zxDg==
X-Gm-Gg: ASbGncuK5yIUQtfTcQbKrwOnf8LfttcYLMGubEFDOAy0yxbFbAhz5/Y5RU5Z8Jcd21f
 HaIEgdKJV9WPS70LNy3d7YkRv12SmCxH5xGvMHQSeeIBs3tYu+A3/MeNGWJ5U35dGXZU9FHssbX
 /ebw27rBR4z1pMd9zeunhgYTLwhsH3trqL
X-Google-Smtp-Source: AGHT+IGYN/aQLXMRGHb0Tkhew3I5hI2cMFDIfwcf2XF/2Cx04pWckiqUkYyAqW3gWqB2KgRrkHdso4mA4joNaiLne9I=
X-Received: by 2002:a17:90b:538e:b0:311:a5ab:3d47 with SMTP id
 98e67ed59e1d1-31245cce4a3mr20426567a91.1.1748879479852; Mon, 02 Jun 2025
 08:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
In-Reply-To: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Jun 2025 09:51:08 -0600
X-Gm-Features: AX0GCFvOxGyh8BreulI_guA0Ugn3eU0WMnsh-psDKwyZMhs6WkkLafpqk1of94w
Message-ID: <CANCZdfqnGfMOk8FPSjfRbS9uUFohdO4ySQT=7i0+x0AZts7xiw@mail.gmail.com>
Subject: Re: Is anybody still using the "highbank" or "midway" QEMU machines?
To: Thomas Huth <thuth@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 30, 2025 at 8:24=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> I was trying to create a functional test for the "highbank" and "midway" =
arm
> machines of QEMU, and only succeeded after lots of trial and error to boo=
t
> something on the "highbank" machine. Peter mentioned on IRC that he also
> does not test these machines by default, so we started wondering whether
> anybody is still using these machines? If not, we should maybe start the
> deprecation process for those instead?


FreeBSD never used these for our CI testing, and we're not going to even th=
ink
about it, even if it wasn't in the deprecation path. This hardware is
too old and
too niche for us to care about (I think we even lack the proper drivers for=
 that
platform anyway).

We do use QEMU for a number of other things, we just don't use this model,
nor do we document it in any of the docs that talk about FreeBSD running un=
der
qemu.

Warner

