Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DABC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we546-0007dP-N9; Mon, 29 Jun 2026 02:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we53x-0007b1-7c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:01:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we53v-0002UL-GG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:01:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so5599720a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 23:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782712901; cv=none;
 d=google.com; s=arc-20260327;
 b=CEo4dSkdq11lYC5E8jB2LkpJIJUgwQ7HP5AJ0D8qzVQacqqUGMkcsTPSNeQk1sHerz
 Vdvkaydiey4ORXYBlEWgUllAJobRdSkKs62VHPElO2kfr0Buzikj5yzzF+J1iF0mOUpG
 /6xIh6Cna1kKBLitS6PV+uRrbTonfBsxILLbZAsPfV91VUCx1fGtDwlK74cA7HyOZ6Ei
 6fcO3c1Gij9FIaVTfFtkm490FKNH5okPTiyjmQsLiBMZstt7DSiDdU0F8zKdaLnzbq8V
 SaXKgxIbW6N3QArfPq8L3FjAukw+sg8AxsFBKOC98XD1Poi3+Lh/XjSpInWxBVTehBH5
 EzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ga8NKBvuTurHYZuFFPbMH1yuEaox5Co+PpnVCyXn93w=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=NP+uMcZyEnEQsMtfEtckXDNRihb31YZ997ncKuf7FZOdaKCzp5TNciHrt1NU35Dg4N
 CZCShE+OfxQVi14wYGTpVcMhXWrgqGcgMEZnYPJfvgyPNxjuTiFO4AtlO0oirPpJtmeE
 noBzPbgne+7DCTsKt8DirclLXffvtlXHQ6/PiJvIK9ViD3fYCCdk5CGGcXqGWQpUijnv
 Yuhjrjv195Oi4nHg8Hg1PtXEE8cm0E8FqVQJPeMbWXebQYPmiNlW7CkVMYBBrdXpFY9+
 pypOxpSw93CfDXYDHO6NffRCKo5oln/7cZz59fw7ivBORf623vPP+kY9oZUnhYxPqg4j
 44uw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782712901; x=1783317701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ga8NKBvuTurHYZuFFPbMH1yuEaox5Co+PpnVCyXn93w=;
 b=KLxx6URtWG//96vKwtyySpX0lBysLzZt10OdujOhcagprPLR7FOKSvdryYGtIE0cRe
 7gWRYoS1TWcaEO5PMl/jBYPbAAxsbChLZuO8xosu3H5mVMfhJVTh8Fj2bOaejQahr5HA
 8E4r9XgRKf9cF3T+ROZkr9ejv3EfxwCfT3JNjqAU42ONgR272mPhw+YKokBGAvfrWXv/
 ty5qmhaQqga0Kd/SOyIctX+JYphyjHoE7qcqhQCx9fUd4SVxwhv+VbIVyPwYv+Ho3f7S
 UmO0YQ4P5segJ/m1PBUbinyTz9Lx0N1T+lcDShNTvWIM1ohXbwvOLVWXjKl9vyEjNABj
 TidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782712901; x=1783317701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ga8NKBvuTurHYZuFFPbMH1yuEaox5Co+PpnVCyXn93w=;
 b=r+LuYrzwPok4bQCYEG9bupzbm7hAp+/42usg8nSsvwF2Bwt5KqAGk0mfoCgj3MnAJ7
 e/WZLSOo8b3WkAi9rJR+mpxQF8aNmYX2ZD4gIoYWwpFGWR1DPmvGKTuhr4rvgYmmLEvY
 QtEZIHGwMiwsSruht4f5t4L/zlNVU18pnJt2gXl+vYInu5wTqQkhUgcCCU0fxwnzzfXs
 XoHXJgbYDbJLKr+K9+k/xrIIRSqBuR0FtEoQ2nEjwzUlbW2+UusTT2HoQyHRaHZmwZGq
 IW3W+vOT5e3LXLhdbgduDItJFZ8XRaEi3SV9orjQWFqr31suQAXt4ymDjXzNsSXmy6eA
 66mw==
X-Gm-Message-State: AOJu0YyuFOepaRWJKWA4awtO3ZUUeZb9h5bjXQvgGV53mi/PqiaZ/tYN
 xFtW2NapDWuMxNzvjJIeUBWnCzRkqjSKMrQV2IDmEnrJPRkWpx7+dErFjTPitEmnpfkkuZqYhlc
 0wUW6EhP0ojqVVRI7U7BsVoOMzWjYTY0=
X-Gm-Gg: AfdE7ckPhdKnbibl6kwA6pZlDw/fzG1uDFTmrfs1c3yFc6Jc7y9lXU1RHEkqAJedopm
 d0yaL/r1mIl4yyknHpmoTYT/OSH304zQagOHJY0JRH9u9WTC2ph/x/B837e77xLHjkHlr3gb3KF
 grkbV15dPUetn/zF229seIvW9Owoc/HPp5Jxw4pZzT69IRBRKilu0YFBhRn5ALtqllg7VmbJA7m
 2bUAunY9GRYXlFLHF8uY8pNtrrwP3yJkFiWhEdza8IAPA24HneuLdfBrOyr64a0+h9E2TUOXQ==
X-Received: by 2002:a05:6402:34c9:b0:68d:643d:be37 with SMTP id
 4fb4d7f45d1cf-69810b7238cmr5583966a12.23.1782712901220; Sun, 28 Jun 2026
 23:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
 <20260624175143.GD109308@fedora>
 <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
 <20260625151608.GA160758@fedora>
In-Reply-To: <20260625151608.GA160758@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 29 Jun 2026 14:01:04 +0800
X-Gm-Features: AVVi8Cd0N7XzgfaLxhpQsA2h2rNa_rr4jyOzCKbxkTE8uEBL6ZwPhbP2qZ1pgbw
Message-ID: <CAK3tnvL5=SoBPV-WQ22AM4xaneqBU=BbAAbUyhXodFiFD=dYJQ@mail.gmail.com>
Subject: Re: [PATCH V9 05/17] block/export: track IOThread reference in
 BlockExport
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Jun 25, 2026 at 11:16=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Jun 25, 2026 at 07:06:26AM +0800, Zhang Chen wrote:
> > On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 03:08:39PM +0800, Zhang Chen wrote:
> > > > Users currently lack visibility into which block exports
> > > > are utilizing specific IOThreads. This patch integrates IOThread
> > > > referencing into the BlockExport lifecycle.
> > > >
> > > > - Add iothreads array and holder_name to BlockExport struct.
> > > > - Use iothread_ref_and_get_aio_context during export creation.
> > > > - Implement proper cleanup in blk_exp_add fail path and blk_exp_del=
ete_bh.
> > > > - Support both single and multi-iothread export configurations.
> > > >
> > > > This ensures IOThread 'holders' status correctly reflects active bl=
ock
> > > > exports for better debugging and resource tracking.
> > > >
> > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > ---
> > > >  block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++--=
----
> > > >  include/block/export.h |  6 ++++
> > > >  2 files changed, 60 insertions(+), 9 deletions(-)
> > >
> > > If AI was used to generate this patch series, please see QEMU's AI
> > > policy:
> > > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai=
-generated-content
> > >
> > > This feels like AI generated code in that it is verbose and has lots =
of
> > > structure (e.g. commit messages that look like an AI summary of the c=
ode
> > > change), but the details are not correct (misleading comments, leaks,
> > > etc).
> > >
> > > I will pause my review at this patch and wait for your response.
> >
> > I used the AI for parts of commit messages.
> > Please continue to review code parts and skip the commit message parts,
> > I will remove all AI-generated commit messages in next version.
> >
> > Sorry, I just noticed the discussion:
> > [PATCH v2] docs/devel: relax policy on AI-generated contributions
>
> By the way, the existing policy already allows using AI for code review.
> I recommend doing this before sending patches.

OK, I will use AI for basic code review before sending the next version.
By the way, do you have any design comments for other patches?

Thanks
Chen

>
> Stefan

