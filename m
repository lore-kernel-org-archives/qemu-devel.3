Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4545CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw4S-0006qS-Ew; Tue, 09 Jun 2026 09:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWw4Q-0006ph-38
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:00:42 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWw4O-0003Nr-GS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:00:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso4200882a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781010039; cv=none;
 d=google.com; s=arc-20240605;
 b=HEBBUIbEEul+YRB/Nl7gzKyVInvg0QaTXqlFyk74YQXly9SZDma7YRCp4I1NN/DW5g
 f5LfY5AU5ZeJK7fpNFv7upXAjMrwyqGNVcYtevNzp9qW6yTciAG6L0RUjFHQvCVI+3FL
 HLd+9liP6HlMbTFJ020VZtoIR0aHS/mAfaPrELvifjK73XoYObeoHiekf3BFIBFG+BJi
 kRhuXBwY86/pLgs6bMcR4RQTgkvXuigCbknTDV6jz9rsHfyKUWukXr6so+hPohbvKHgi
 RV7VZpCzcE5JhbL+gid8y1lNlGA4v0Yt/50wmB+OMQmOmbdBWCa8n/TnmgOGIItitYO/
 k71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XtaTvZBB01ivzRnhF0DV0zRyD2VbJ5cFl0/+7HP8ADg=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=KwH6Q5egyR9hiQNI7pslTvI60RjoTVH/ZiYir/b/YLrtJSx7LAhLXaorsA1m+VsTbW
 DF0G/HhIm21NAUfxYdNDCMUI4TcqMhttmCKjCHdOaUDfcx2iJ2bwG1+0P1bG7ivHKu9n
 5jqhMJSsT8S+zSZmax6w0tZ4A3Gq8hS8qFkH5Jz/5MwGPZnC0/uIvx705GXGcJJXBkpS
 v6znwL+G70vZVvGWB4+JT7mIwhkAd9nBkrSWBlo5Zq/rgqUiJxlMdu9+EnSLANygolaZ
 fOOqcstm0gSFB+Mpo58Gr29+pOGSgriXTdBiNFGc/9yFuGylK0wYDgPW8aMsWftOnOZO
 wizQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781010039; x=1781614839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtaTvZBB01ivzRnhF0DV0zRyD2VbJ5cFl0/+7HP8ADg=;
 b=mpVVks+tpijH+Urob8dMJan546FOw+Tzd6AXJLmXm/BKieDAthMayzcDq5ufphwYIq
 npc7Gku44p53LvfhKzfOxvlBoGXLeGuqwRg+luc97ZnKBMXWMy955Mbw3k6k26kP0RuY
 sc1BszgTJGikCaS2SFQxa2SoTN0mpid3ddh8vVtquaZq1nVDzpra26YlDAq/A63Mu44f
 52TnKsf3aTTiGFAXozhl5/xefNAiOj2MijeIkEaScmGr/ImPotUga2hs1VxYl40O3w+k
 MnOHBlplgLr+Y3aezqeSQL5vSPcVGyL2qcOsS1qqhwFGBS75i65+3gbBuiPdkWXxhvou
 RpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781010039; x=1781614839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtaTvZBB01ivzRnhF0DV0zRyD2VbJ5cFl0/+7HP8ADg=;
 b=h0pIfYsA/d1Km8cYRYlA4vTCkgPGZWSYhFslwHjQHVWmJbT7VKj12yIBR3PnXwhYPn
 TPAjXOG2i2NNIuiikQ9A90emIXCslLs/bgJqPj3yqmvh16dnYvuL4MYLdxjU6HGcPMhs
 uYhbNQXxQckOd+WhgvN/PTyJTU1SyTy/O2PIL0T0V3KfvCfgGWxvr4O4XkiKFFEEzbN9
 KnzcBxKOwHNsIqoR1KPw/cSaf7yoA5jqM6jkq01lcOWohII2OlxbAPuBahsukbzs1BjN
 bW61odLVpnjZgjfLqBxpkOsPhYCu5hFwwMGPznh7V8Iy2ONGsueFaKNooOXFZcu/5w41
 oofg==
X-Gm-Message-State: AOJu0YwjPfKE5uBoUXep3ECAREyt7mrfet1ToUkluXhDJKWh1kZOBX0C
 bJQnRaJJjN9cNq/Er2BZzH4DMi+M0dBWuEOzmjlX9Lna2JIK3RfY9rrq4tVQK3a6Zvhn/cNJYY+
 eJgmrArjeokoZcNh07SFd+X9+6IdfTgI=
X-Gm-Gg: Acq92OGsHzpL0ONoAY9/C2wk+i/VWse8aV+0U8+FLmePrK4HSGHc5bgyKTbgPze235f
 PXYw8IhLmNm2ryz5RJ5JFGwCtHwm5BrcHSHTjfrk9D3wDKjGXxV1NxGl4kTTCLEuMoJC/qVvV0j
 GUp1bI6k9lor5l48gUOQjUc+YlJuW3qfd+YC1NHVYHN8SZVDTTByjdHl1nBAHB/ZfqOhABYYM4B
 Re+X+XOo/ZTc73wz51tG0cOMdradjCRWX3pp9vx8osnYUMeQLd0FfsWEDBCrT7PCEGTtrztt9xm
 Qp0rePW41SysMDd53qg=
X-Received: by 2002:a05:6402:5d1:b0:68d:ad45:5cac with SMTP id
 4fb4d7f45d1cf-68fa4c00789mr8941959a12.3.1781010038296; Tue, 09 Jun 2026
 06:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-16-zhangckid@gmail.com>
 <87eciorgaj.fsf@pond.sub.org>
 <CAK3tnvJauCiFZNW84JP39KoXD5NieVV5b+GR_F0yeixYbw3Biw@mail.gmail.com>
 <875x3tl6k6.fsf@pond.sub.org>
In-Reply-To: <875x3tl6k6.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 9 Jun 2026 21:00:01 +0800
X-Gm-Features: AVVi8CdKJ5BBbXE5NLLecjqHADHZ3fnDwKSzRrII_-QyAVyHLIXK4l0z_FimeQs
Message-ID: <CAK3tnvJAFoHVbdQYxYnWD7rgD8KWzFGJfSwFPQ4oVn9bn6ZKbQ@mail.gmail.com>
Subject: Re: [PATCH V8 15/15] iothread: simplify API by merging
 iothread_get_aio_context variants
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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

On Mon, Jun 8, 2026 at 6:42=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Wed, Jun 3, 2026 at 1:41=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>
> [...]
>
> >> The patch appears to delete unused iothread_get_aio_context() from
> >> iothread.[cg] and to rename iothread_ref_and_get_aio_context() to
> >> iothread_get_aio_context().  It leaves iothread_get_aio_context() in
> >> tests/unit/iothread.[ch] alone.  The result is confusing: test's
> >> iothread_get_aio_context() takes now one parameter less than the regul=
ar
> >> one.
> >>
> >> Should you change both versions?
> >>
> >
> > Yes, I already noticed the iothread test, we can change it after
> > merging this series.
>
> What about changing it in v9?  Assuming we need a v9.
>

OK, I will add this part in V9.

Thanks
Chen

