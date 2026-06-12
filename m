Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD412CD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 02:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXrFH-0004r8-7E; Thu, 11 Jun 2026 22:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXrFE-0004qg-8F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 22:03:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXrFB-0002o2-Gt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 22:03:39 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aa63628d26so388338e87.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781229812; cv=none;
 d=google.com; s=arc-20240605;
 b=ISOxyGPzkMJn8vEWt8zMy8GYCf0zEHxDtMUC2tx+FMEDM8LcCTO9g0jsds5JID1AkT
 RYGhOxXdNCNzQR9tdl95py3pCYN7eW+jgs6KonWY0q+yLpocw5bZCPnI9FDRVEs095DD
 JKliVxE9slUj/4tCd87hqaiitgFGIceQzoheQFMD42+y/IznmMYClLP5fcyHOEcQM3X3
 ODN8M07/6DoFztxVCjDTzJ6uHfUpqGAvdUYMLIAxU8wsS+l8J8Qsrclg602uVIRAisP8
 zhCKc8KBFS26fPWARxqzwQtbVZF3LoUxO8JA4aNd2Eh1Dhdc8+0jPXtdzBMsYJUUOdMA
 IgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JunfJix4mx5gadvdor8irrcrf21sGI1GhYgOz2IF3iE=;
 fh=0mcvJVTuSKLoncYi1LvSndoE0o502xh0r1kihXeKibY=;
 b=WhdwIEokpRVQXhCCeD4KSMtLOhXkWJ4JPhklkZEXKCSgc+9UoGVFO67ulsbQOZa6j+
 Bh5i+u72qGw3+hhj9K1sEtLhZyewb3Ow3uADF8IUKzdBNm7zy4YsqkYjhnypqd5mcjcf
 YajXj25QUxIqztyu1eJBkGqFcGk1rzWzhBZ1JehLer2f5QT2JyKWMqlWZX0zFK+XJaUV
 ANmfBORN6MlmV0zH8Sns85IrZSMbl6TftVgNi2Edtb5vWMk17SwsDkFYBTi4UHChPIQ+
 6rvlhZtNlLYNtZHrqHomDKmzuHyoUcd/Q4ppdo3wO8+w+KL6P6C0hxM1oUhHyawmY8fn
 busg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1781229812; x=1781834612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JunfJix4mx5gadvdor8irrcrf21sGI1GhYgOz2IF3iE=;
 b=R+5fOKj5ojWQpLIz6cw6KUEFE/73rdNaLOgc3e5HwnhxFsQU5eTcjC/JPVXm7BRnQE
 gVE6ICV/GFtnDH5Q5YEU7vw0TvjbGknvCc67Tcy3NRroyA3R6qQd+YH4r+/BNm2wnTgu
 tztWl/2GS+Ji/QReNWdo0YS2RcNTVCFWhAu/Jo91imU7C8wE+Vxi0ClvngWE1a1UWgjY
 KhqlQ7QKo/11Go0fcTPxNhOqQ6PN+406RfzpUUOAiGyLdDpl6bbm8n9amuFQlBL514JG
 UVN3j1xDj9A0dKyIrIKyIioz30wPnda7/7XULMQENrSfbsN4C4BP4t0XtAKEqb/0R0dP
 ysLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229812; x=1781834612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JunfJix4mx5gadvdor8irrcrf21sGI1GhYgOz2IF3iE=;
 b=KNPXtvqzQj88KE3oozPAu2w52OjnTta2VzHY4HpgmTlfDwLjEdJvziemH0BeKeBuEU
 n3NKM7D/RDBbP6sQ0h+3/cgRZylGV6A1aLKDkZyysP1srjOwTPDGbYrWj3XvRaoK9PRu
 EI+apVz8g3TFmJIU9ef8djPcHyqJwWbg/meWMl+KJzj2gtyUYgMoDFz1UM6DP1k0fKA8
 7YpAy0VQSiEUhsNr2Zssi7gRm6PZVc61Ub8sj+D2rrBZoPw3BqbsaYgRW2oDwoEfldh8
 I/qgdvbOPawdekbrClVerHgvYq23AioNJ1V0fHXUnIZ4wtf0QcwssGgqtmen7/AUgSfY
 24cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+N246C8w1rtpB11oTaECRUahl7Exz4/5bUlWXpzZDubC4xuAcjttz9pVr3uDURfHmqsFvDuSVN7j+@nongnu.org
X-Gm-Message-State: AOJu0YwRsWRz0Tni/9g+UL+yZde7KFslXDHQcutXoNH6UtNf3xsyotcw
 QAFQApFbduMGetAZ2iAxxq2k5qEshl7mnIo4NIanrhidVYIWOs9lDFuxvNfl5nx1pg1XBoaIEJ8
 iPGzlaQC6FlkDmJOTMz14bXiTCV2MTWsyEu3N9Nayrg==
X-Gm-Gg: Acq92OG1UyIvh7ON+0WoSv2W/XbHxY7lQNpPGynj33Itit2Az6tciLSU7kP9NVMe/PD
 tV4zwV0HYaqPnMJ/8Nw5yjsmNRVcItKdDWTd4vhdjgvaEa7z3VZ/5EgP0e1kv/17+XJJWkUlnDE
 xv+2lbr3ecwJ74F0CFdLgoHE6CNqsg1Jn/QgnEPiA7K6uCaH79zzY7aU7ivVuZBUBY56jnTyXpO
 hEIycW2YSVCA3PeE2H1bs5e54aXwUi3zmTLkTxzLxKSMP13r6tbVkukDhwxxQY2T/3Ar9tWVhIn
 DQxYhMg=
X-Received: by 2002:a05:6512:24cc:10b0:5aa:6869:2bec with SMTP id
 2adb3069b0e04-5ad2db6b6f8mr163733e87.27.1781229812239; Thu, 11 Jun 2026
 19:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781095539.git.yong.huang@bitdeer.com>
 <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
 <airgpjWeo4bHHve-@x1.local>
In-Reply-To: <airgpjWeo4bHHve-@x1.local>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 12 Jun 2026 10:03:19 +0800
X-Gm-Features: AVVi8CeO35D5j9lQh5dPRW9SBrROzQL-ewyiBwxU59hkMLU2EY6XXjnJ-tChcAY
Message-ID: <CAFWXh4yYP+kYbQvjD5i73jf3HWFy8fYWcKcK3X5VcgagjriwdQ@mail.gmail.com>
Subject: Re: [PULL 0/1] dirtylimit improvement
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 Hyman Huang <yong.huang@bitdeer.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lf1-x12c.google.com
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

Agreed!

On Fri, Jun 12, 2026 at 12:22=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Jun 11, 2026 at 11:18:53AM -0400, Stefan Hajnoczi wrote:
> > On Wed, Jun 10, 2026 at 9:15=E2=80=AFPM <infra.ai.cloud@bitdeer.com> wr=
ote:
> > >
> > > From: Hyman Huang <yong.huang@bitdeer.com>
> >
> > Hi Hyman Huang,
> > Is this pull request intended for qemu.git/master?
> >
> > I did not see any previous pull requests from you in QEMU's git log.
> > It looks like your previous dirtylimit work went through the migration
> > tree. Do you intend to start sending pull requests now and are the
> > migration maintainers aware?
>
> We're not..
>
> Since dirtylimit is almost only used with migration, Hyman, do you want u=
s
> to keep sending pulls for you?  I think it's better we're copied on all
> these changes at the very minimum.
>
> The other thing about the pull I want to say is, that patch changed most =
on
> KVM not dirtylimit: v2 sent on June 4th and planned to be merged today
> without maintainer's ACK (in this case Paolo, I added into the loop), I
> think that's a bit too rush.  Shall we still at least give Paolo some tim=
e
> in case he wants to say something?
>
> Paolo might be busy and may respond slow, normally what I do is keep
> pinging if the patch is important; if not, I leave a patch there until it
> becomes more important..  I suggest we do the same for this patch rather
> than merging it without Paolo even noticing.
>
> Logically the bare minimum is that patch gets an A-b from Paolo to merge
> it.
>
> Thanks,
>
> >
> > Please follow the pull request process and sign your pull request with
> > your GPG key:
> > https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
> >
> > Thanks,
> > Stefan
> >
> > >
> > > The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a=
6d1506:
> > >
> > >   Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong71=
5/qemu into staging (2026-06-09 14:00:28 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pul=
l-request-20260611
> > >
> > > for you to fetch changes up to 3b224b1c7df1ddefd6bca34f201264d72846c3=
97:
> > >
> > >   accel/kvm: event-driven wakeup for dirty ring reaper thread (2026-0=
6-11 08:22:50 +0800)
> > >
> > > ----------------------------------------------------------------
> > > dirtylimit: refactor dirty ring reaper thread with event-driven wakeu=
p
> > >
> > > ----------------------------------------------------------------
> > > Bin Guo (1):
> > >       accel/kvm: event-driven wakeup for dirty ring reaper thread
> > >
> > >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++----=
--
> > >  accel/stubs/kvm-stub.c   |  4 ++++
> > >  include/system/kvm.h     |  7 +++++++
> > >  include/system/kvm_int.h |  3 +++
> > >  system/dirtylimit.c      |  2 ++
> > >  5 files changed, 52 insertions(+), 6 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
>
> --
> Peter Xu
>

