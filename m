Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB8BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whhEN-0002mC-PV; Thu, 09 Jul 2026 01:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whhEI-0002kV-BA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:23:23 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whhEF-0008Ma-25
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:23:20 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so2520606a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783574596; cv=none;
 d=google.com; s=arc-20260327;
 b=edWWLgBoihckqdeAHZtmhHgXcMex4MUh+XMhTc4Z3FZgMa/huhoJHJSdrnT1kBbdfw
 sYBW04w8KPi8Wz6hs80bY/nzki2e2S+ylJRTus9VlmT/J3KEii9Xb47b9ExB8I3POKA6
 WTMszHDFou2QdMiAY4F0xSIwilQ8kXzq3XuyEd7Kt4rHBdPEckxEH5vXo5Wy7YN2C30U
 MwTSlT0YUScUmAM+BqmJJfaGXX++wsA5fk+Exy6zuZf9itYudlz2Lamcgm3AmT9zGjXb
 AdY7LPHU4RbLklbLND+XcUFBFC6wYxZ+jXdGsHN2v72kWBOv95wvAuBwlUoyRG8EYARp
 PrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xndrcRuhepZhzYUiBoWpSUf8i+jjiQ+COEmMXWTn91g=;
 fh=S6e0b6pizRPurpx6Y93qSIXaM3/7p+IgXj1n9TmU+ag=;
 b=j9u2Q2ikZH/ylrnwk6m/S0jt54v9IKlIL9SiuVQmYIYAFT3NAesldKusR9vovyx5bf
 IIROf3nM54hEiDhY7jtgqC4V2H5hiGcONavBRRSVQKBpwIKqLEMqkTmG5QXAewpfG304
 ATGz5DHkK+Z8Tkn9r6+FJFIgq6tcX7blTzaxnEdGNWTySjchyOPv26bS6S8SvqWX097A
 EroZupKeqtINBYuYEP0eX6r+7fM792DPtVV2SDf7DQjWIC6uzyyu2XNBruDyMMC8Q6C7
 jRlFta/5cEoP1qVuYeOkXDPhTTtEIiRwvWwN3Yi2f/7FFDLBBJSSJYE3MxHbbkDvc24F
 Zjkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783574596; x=1784179396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xndrcRuhepZhzYUiBoWpSUf8i+jjiQ+COEmMXWTn91g=;
 b=gZ7ctdaokGZQ1qEVGAST4QBsgY4SAzxx0yyzKNps4GfYLlZVkQNt74UKxWKEXisPRK
 Nr5CM9nqsNIJx/pmaWXjKgtgCSehadHNCx8vA9Fsjbkebhh/fDXJIGwGs+2my5UBP/Ay
 teAj9Bdw+IUODWmP5jaoDitlO/xQLq3CafAcuyPiec6vJAD5nNpdlzuDkFoDQhmdQcKN
 W+WhJI/0S6jehn8KynDxdvOiNhnf2HfjtWgPQ8+vummBxIVBxLzH0em00vO61pFwicHa
 KUEmtiKopk7Y/ENYg4gkWS+faK+jk+5PLXrlJ2QyRZijggppV8G6Be2ppLMDRMLPdq68
 vu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783574596; x=1784179396;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xndrcRuhepZhzYUiBoWpSUf8i+jjiQ+COEmMXWTn91g=;
 b=K93NFxV0x71XQF8xrC3yQlbMlILAoF36KSWqCyRzRbjzShNBj4Rq62exTtvaxsTMWT
 0q1LCR2wFK8+m7KBz74nIHsyO7tDjgIJOqqx/8twPHReQ0IrTgNrEfOU/X3RSdS3DK03
 FtUBbagS8bq8nk7/mbKWAyqG/4UXcYSH6sgH+B2riBZuuZQt7Kqq9cWgf2hdovahpeZd
 MMWEJP0jClwyNRTlCq6R82x999Q0IV5D0Kq1CF1bsy1KH7HURMvzm8SBTeczHfKnGBdK
 XNrkptXia8d/sUP2cGWsmOZtXAu2JQ875ZBT+E04SAt/10AP0Xp/pK+7t71tZLOAD68D
 FB4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfWFDrl4kzCnV3CMHF7zK2IQH7hUmTiCrLC1sjmp3eVhi9bVLEYzvknf9Dwkj/TR6ibdW5xIkTH9g/@nongnu.org
X-Gm-Message-State: AOJu0YxN+Mjh/fNhIcj55vo/CVY9dGzxZbUs/rzZqqvF/ZQIJasT/W7h
 QjQODo1B+EicPUzXTwcSCCy5vOy3yYo1Z91NSa8JfIWN73s+SaQfBYDh5MvCu4tgQ21PfXcYH1E
 XOu5unRYsD2aeqdokYUadPwh6BbqswpY=
X-Gm-Gg: AfdE7clqrgrl3xULz0msEuiB3Txc8c73wMvRvQuqokFSuV2OM3mzCTyK9RFZMJhQpW4
 CFb3Kjz229GLuolw1YfLaQqHXiLNcWUA8mzkGqC2shZMH93GZCgdAa+FzeUIDWq5aKxSesRIXut
 iyay2w5UEr7blU+hITNrGpHOAfZhInSZWgCcrxuvw44V3ZhnZ65aVlYCZRlXd09FULs00kC/xZb
 SvXyuAvGKczxZCf0D+nW0WiN4Nol346eiaS95MGjW4dQ1ei1ygMySmvA00AL1uT4wq6ngO9UxA/
 yz0bA+gdFTcNcVbNAUhkA3BFq1WXMn/eGHDKLQ==
X-Received: by 2002:a05:6402:268d:b0:698:9251:2f72 with SMTP id
 4fb4d7f45d1cf-69ab44b563bmr2402766a12.35.1783574595411; Wed, 08 Jul 2026
 22:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
 <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
 <6e42ecc1026a057e07e73386463bd57e1467a46f.camel@wdc.com>
 <bf46f39c-6173-4cfd-b374-63529892a1fb@tls.msk.ru>
 <87ecix59j9.fsf@suse.de> <da24799f-dd23-49b6-8e7f-65d757721d3d@tls.msk.ru>
In-Reply-To: <da24799f-dd23-49b6-8e7f-65d757721d3d@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 15:22:47 +1000
X-Gm-Features: AUfX_mxGYHk7g7UScX8Vc2vmOqesUdLNCoKIBD18idkhq0-NKDEREsFLgvka2wE
Message-ID: <CAKmqyKNmb1J86B1TXqZ8xK8=4Q0VoUBUSWcoc6QSis+7nFv2Cg@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Zishun Yi <vulab@iscas.ac.cn>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Fri, May 29, 2026 at 5:44=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> [Trimmed the Cc list a bit]
>
> On 27.05.2026 15:20, Fabiano Rosas wrote:
>
> > There are no migration compatibility guarantees for an unversioned
> > machine type. Only migration and snapshots from same-version QEMUs are
> > expected to work in this case. Other scenarios may or may not work.
> ..
> >
> > The addition from this patch is in a subsection, so .needed will
> > determine whether it will be put on the stream. If we backport the
> > change, then the stable QEMU build will (likely) start sending this
> > subsection, which the old, non-stable QEMU will not recognize and
> > migration will fail. Migration from stable-stable would likely work.
> >
> > So any stable versions that (would) contain this patch are likely to
> > block migration from that version into an unpatched QEMU.
> >
> > Note that since the machine is unversioned, migration from QEMU x to
> > QEMU x+1 is already prone to being broken.

Sorry, I forgot to reply to this one.

Yep, that's fine. AFAIK no one expects this to work, so we are still
avoiding adding versioned machines.

>
> Yeah, this was my understanding too.
>
> And given all the above, I think we should apply the fixes to the
> stable series, and treat this as changing version (the version is
> actually changed, but only the minor version).  Yes, the VMs wont
> be migratable between 10.0.9 and 10.0.10, exactly like it was
> not-migratable between 10.0.x and 10.1.x.  Because basically, with
> no versioned machines, there's basically no migration capability
> between different qemus *at all*.
>
> When we do have versioned machines, we can't add fields to previous
> versions anymore, exactly because of the migration guarantees.  But
> as long as we don't, there's no guarantees at all.  And the only
> place where migration can be done is between different hosts with
> the same qemu versions.
>
> The above description leaves one question still.  What happens when
> migrating from unpatched qemu to a patched qemu?  Will the migration
> fail due to missing field, or succeed, making the missing field to
> have a default value?
>
> If it will succeed, then we definitely should add the field to fix
> the original issue.
>
> BTW, can't we just skip, at the receive end, fields we don't know about?
>
> But all this is.. well... sort of moot for this very change already.
>
> I haven't realized that this discussion is about a change which I
> *already* applied (I wanted to revert it until this question settles,
> but I forgot to do that!).  And meanwhile, I released the next set
> of stable qemu releases, with the changes in question (two of them)
> applied.  It wasn't my intention (or else I'd not start this
> discussion in the first place, obviously).
>
> So we do have this migration breakage already, "thanks" to my sloppiness.
>
> And I don't want to break things for users for no reason.  The original
> issue were described as a security issue even, so there's a reason to
> fix it.  I think.
>
> But in the future I'll try to be more careful about such things.
> Again, understanding the machinery and consequences helps here too.

That's much more my fault than yours. I nominated it for inclusion. It
does sound like in future including breaking migration changes like
this is ok though

Alistair

