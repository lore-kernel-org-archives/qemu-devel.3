Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB894CEBF8D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxgm-00024X-EO; Mon, 17 Nov 2025 06:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxgi-00021k-Kv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:46:28 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxgh-0003qY-7X
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:46:28 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-787f586532bso37613917b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763379985; x=1763984785; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwEBnM9IbcbouqwEJ89NTsgNkU+JDh4mGkIAEFV4i38=;
 b=bEj4pvnw1GDN4vd8Ejr1495F9JovlasHD8Fjtq7Y+clI7emEtzDGR2R3U2daVpvmjB
 2drkCVMg7ryBBE1vaYYVpCOL9SCAT1au1ojlny9nQ61DPa6rIxaH2d1b+zjHJ+reJ1kL
 e5YzDnUiF4KJFfQRaAIX47/NHXZvQdA2nn76Abqu+X3eD7KfnG3Zuf24kCTME7aOiKC7
 jrmHRVdSXC0MJXmBoWdrhbI7MymsCzLe87PFJ5Ou7wFu3dsRgjr5YJeRVPwPmKg5vFcH
 JUWiwIB6tC0c9/dGsvgTBpC8Mj3U1wK6cnrt8r/dGfY1VhYZtuBYF/OdmqamEh5+U8eL
 0ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379985; x=1763984785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwEBnM9IbcbouqwEJ89NTsgNkU+JDh4mGkIAEFV4i38=;
 b=LasFlDl3JMe1KBUPFegB5FMP7G43czY/MdbuMK1NOwgYZUF+G353zJPAPmF6UX7V4v
 E2N3FtN1eStPtQFYLeJdIRAG+sjDN0EijIw4C6KYJSwzItEm/OhRAJdIX3kvxI1TQwjz
 VbuHb/1kXdwNzxW3Q4vgeU3D9OBqZTg/Q9+A9j0Uw6fucH7QyLbP1WWHloZBA3jMAEyg
 g3Aa4C9cTrVYJrOAiA/+xgqEuoGWj6iV0Hfnf07heTWAqtx/1SWqOmKJAMekf/ZsYePM
 1E76+m6D3JsLDTt5yth+kN+eha2tF+3NhNZFlvPGJs18gi+CEQvqXu8Zy9wLkpoF74u3
 9jtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJO5+CTR7sW9dnFD3PELac30NgJHihYBOXHj0ZIPLRy0v5gwC9fpj7D1rFzOas9V0dWlxFji1OO7t/@nongnu.org
X-Gm-Message-State: AOJu0Yyv3E2fMV9Qu8yEtWjxFCJfVxZCMIS0HrkT0BI62QyjJWA2psEf
 93EgiP/dbdOfS4krgTBgjGUO/POd5peN6toSCm6qe/N21nMSm02sq5XBFyxu59Ze9+foV7MP9yo
 +gFjTu76mbZ9bR3ellJFR4M8hX5VG1tReivQjP0cSNg==
X-Gm-Gg: ASbGnctJyhQ210IyKow62WwWrxhUuCn/t1JKMFKfdWwGauWgGdzpRvKqEy/lGjyHKLZ
 3X+PUdU4Kzg8EuaIf4lmpvRXdZiF1+uZFrx3KnkgZfWmMTQHh9jEJmgnHPKk/3ss7z7sJKtZIQN
 zDf1koJ3/AHWh9sytNHtrj+9TVLBgkyH0oNKTg7RS+9kYhj3liRcuzCFyf1qc023jdR7F7He6Zw
 ko+3DvFCi/HYYZIdzt7gWGU9wfbtKuq8jC/B/SFvno5hNl+j3QH9UzACgUdqzQ6VCDq4KIfxk/w
 oEzfbAo=
X-Google-Smtp-Source: AGHT+IFpYH6Tz8h8mcS5DygecuYEr25ERT0rAZ7oD/u2CzNueM5gkBck7duxcJ144LvDfNPiL5fYSXJ4YCFUqU+e3uE=
X-Received: by 2002:a05:690c:4c0a:b0:786:4fd5:e5d5 with SMTP id
 00721157ae682-78929ee3a0bmr94849307b3.39.1763379985248; Mon, 17 Nov 2025
 03:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <f495c43b-3d35-4763-853e-4e70428cb666@tls.msk.ru>
 <CAFEAcA_8DbBoQdxRzqedssk6hdKrCNSVrO8i6iK4o5SWrkrNaw@mail.gmail.com>
 <a794dd06-cf28-4d04-be08-c87796296a72@tls.msk.ru>
In-Reply-To: <a794dd06-cf28-4d04-be08-c87796296a72@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Nov 2025 11:46:13 +0000
X-Gm-Features: AWmQ_blN7FBZjyzVviPmcbzf_G5Of5j9ff7rWrCETyM_myL0EPNtlEvvddDgu2U
Message-ID: <CAFEAcA_Ee=tzECheOSN21fwqQgL9wwGEUYbGrnTS6B5kZYYxgA@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user: fix several mremap bugs
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Matthew Lugg <mlugg@mlugg.co.uk>, qemu-devel@nongnu.org, laurent@vivier.eu,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 17 Nov 2025 at 11:43, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 11/17/25 14:42, Peter Maydell wrote:
> > On Mon, 17 Nov 2025 at 08:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >>
> >> A friendly ping?  Has this series been forgotten?
> >> It looks like it should be picked up for 10.2 release.
> >
> > No, there are review comments on the series that need to be
> > addressed before it can be applied.
>
> Yes that's what I actually mean, - just used the wrong wording.
> What I mean is that this series is better be fixed and applied
> before/for 10.2.

It would be nice, but AFAIK they're not regressions.
Patch 1 is reviewed and could be applied, I guess.

thanks
-- PMM

