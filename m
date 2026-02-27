Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4FFD530C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtJ1-0006On-5A; Fri, 27 Feb 2026 03:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vvtIz-0006OW-Gb
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:34:37 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vvtIx-0007V1-Pz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:34:37 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-897002b7576so30054986d6.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:34:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772181274; cv=none;
 d=google.com; s=arc-20240605;
 b=EKCcmhlPLDKH8GLSoUtV3ovx2St/5iXP+Wu+JnUrhD7etHnhTy2yJdKpUpWQXDOiBK
 klq96NbxN+a82jwdcwvtZ6gISXdnLZo5yXayNL/RJfNTRaoWvdWIfnHtz4is6zaFwvkO
 oOP5FAvYoi4S81icABWHFKTpDALb9nU3zrHXZAtVEdVtiAkwnPwVAXFZhy3ATJhqKSwn
 dfF+KP+AQHtnAJAxJU4MiOn3Lx2YG1e44nyk0NPPwmEvsOIW+56ZnDeHOACnRoeGkE6K
 UxnmRwVvO4DfaBss2lxdTC44Ji51AyeQ3TWrF1LZbMnIPYpqccA+riJeGn7y7klPWVMv
 Jlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yyRifZRjMZGyiAyTn+lUTGUriyc0kk4XG8s/w1yUK3Q=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=luNyIjG9jbPtMA9okDhkAV4lqq2okw/h4pZdUSNMCc29aYItBPdMGBH2NEsC6OwBuX
 gvt5GVD/6s1ArA3JxE7ZCzAh+tzWUROXnG/Lqui4zcdNscg+wLJFt/vQMEDTODfxf/gM
 OJMOvwAzfsfjYs2csWGt3/Jq5rfl1+eFOpRkF1euY5ZT7yS3t1iFXdgY/NsZFX+KxxtC
 mRuFFZhk3n/u5H9cHHxsuFZTYdTsP697H1tf9hIu3pKTeQevZUl0d8HQN6nDo8cZW3+8
 z/Epg+bdxHZlL1L0fBOhq1tnaNCX1ZvnKSBeWQzlH3aeDLhSs3tvLmkIpJTGp9j9U2Gm
 MhyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772181274; x=1772786074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyRifZRjMZGyiAyTn+lUTGUriyc0kk4XG8s/w1yUK3Q=;
 b=dLGTY2yOhQSyK76LyXmTvWQtjU+4QDYKYRW9sgjpdZo7hRGDoM+wXdPb3lswv6jaji
 dZXd2YkmAwaZHidALluUSYRiXKZAil7pUTmcfBMKzxQJcY/S6XvvliAb46jnFqVVqRog
 2dz9Wzildh0d7bf5G+UQzFrEM9WPtywRlQSaSnyI5ntjO8ZFE2zM59avSBN5fIebmayx
 hElpWzzQ7zySERWQCv4r73fY1XEo2p5VtWCbt2U4xECC/88uPdHYkH5DQflNbE2AFXZ8
 tUphL6tMBS1MSLiznCBHZu2pbWBO+vyotI4vetjuXX/cKsHLYUuILqSI0KNWZjTw7J1d
 p/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772181274; x=1772786074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyRifZRjMZGyiAyTn+lUTGUriyc0kk4XG8s/w1yUK3Q=;
 b=i06hDlIGjoV28SNLcSYdzOHjkDKR5+bObwCA2jZeWpaqFol92RZB9k7v1FBfm8RUKY
 DlXJwu/Y0M/AU85gCvFFxJLvzJJbRCNuydC7BZ3E0zBFUMWTYI7RgbFhzqpmFIkBByZh
 wNhubFvgXXD4ktBC84BiYRN42HAMQSs+n765oE0cAiO1yjVATaCRKPBvLRTpG6gTRjXW
 JFk/nBMeAUJHuP9MI8wEEmUUKDBRqHcX135kWCG2vXuRnvW45n2LUQVic9wBIOsNqAaV
 dY1GX89a1Q9lca0VD38eltuPS10v+tpKbryceZc/dBVw8q/N75Nk6dZTePe4qIS0Conw
 t6Ow==
X-Gm-Message-State: AOJu0YzfmcsgjUfAjTHvkRg6CfOryo4kjckdjA03PZ7yksVpBvRJ60yP
 qqd8MzDZblolJkrzZOe9dFNMvv1abEHAE+Hb5uU4CNipBsVnzPeYMOVz2TUviIYl2U+7WNbbac7
 QdwSBkMfIJpn+Ug3QJbGMWXLOZkAIpKJyCXmGwhcQag==
X-Gm-Gg: ATEYQzwU14cKRXrPSz10LNf5aoQnsnYULV8locmNmqwUyEPN44OHNdN0gBHk8r4Nrv4
 gtIZQWENeSrx5GsYoJUXQwYgUlzKXNKRUA2dGROdRpCUmGC5PgchkFju4FhZZ9gfhKgare40ipC
 Z5v5WCLAkf/wyC8yWQdQ+IUM1GRAQCb8HFIHBQifqNwWbrDbE8qSAguNQ7rA0sTOsIOWFsGVw1n
 UYdu54QS6VzswsCsctnWvNRv8XhWZI2vDZyeu92XrqjgbrFrf5plxHuD52/J8cQc+4BlOHUVlCN
 HBl0rm8Ud7Evt3YKuY6gebaK7w==
X-Received: by 2002:a05:6214:230b:b0:899:ac2b:6ddc with SMTP id
 6a1803df08f44-899d1e6e8c9mr29581056d6.62.1772181274569; Fri, 27 Feb 2026
 00:34:34 -0800 (PST)
MIME-Version: 1.0
References: <CAOkKuiOpVZwn7ZwPDPxJWmQ2SovUUTf2eLwg9dWFgEEhi3_NFw@mail.gmail.com>
 <aaFRigrJ-uiYcmUi@redhat.com>
In-Reply-To: <aaFRigrJ-uiYcmUi@redhat.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Fri, 27 Feb 2026 16:34:23 +0800
X-Gm-Features: AaiRm53WdC_F23nsfvrJmMfsr3JlvsNEjgGYlEeWsk-8d0HMfePsqsr5z876ZP0
Message-ID: <CAOkKuiN_RsOQTREhAvQT2aJf0XJ4Mxk8XRK6MrXrWcoNdGhr4w@mail.gmail.com>
Subject: Re: [HELP] Issue running test cases in Qemu
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks for your reply. I would like to start by focusing on the unit
tests and qtests. Is there any method for running a single test file?
Thank you so much for your help!



Best regards,
Choon Keong.

On Fri, Feb 27, 2026 at 4:10=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Feb 27, 2026 at 04:03:44PM +0800, Choon Keong Teo wrote:
> > Hi everyone,
> >
> > I=E2=80=99m currently working with QEMU, and trying to run the test cas=
es. How
> > can I run the single individual test file only, or a single test case
> > only? Thank you so much!
>
> QEMU has several different test subsystems, can you be more specific
> about what you're wanting to run.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

