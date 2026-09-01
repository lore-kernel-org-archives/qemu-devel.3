Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC9C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PfG-0003Vl-D3; Tue, 01 Sep 2026 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1PfD-0003VD-2f
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:40:39 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1Pf9-0005nq-Di
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:40:38 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c160420289bso625802066b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273631; cv=none;
 d=google.com; s=arc-20260327;
 b=JIWybHX/cWPrDnYbZTTV1UY4LQTbK4ivZt/dDh7uBnPi8LPXNxt+kT2pb8ILqcJw3B
 9LjXlZ5lGbW0xioId50z/x8wFvYmS/ORIHRkRgtZ9nxWEbK3rTLdN1goZievBjZ9Lrko
 8XJgFocmxgB9PeyjXBVEjAVtWk2MUlFQGKRvHZpsAtpU14Y4+YF1E7d7H04vgzbyrfdD
 EC5+GGefamCGkoUyBACEYT3w/xtWP8qUiQEed169TIJb4Ek2OiQPqT1RL/uzhAPjdNDn
 0vYs9P+GpoBxs9E41gGrj9pbRTTC141rcEXThcgFld4PobGMu9ZXiIDgAZgho+dVuHKm
 qDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+mIp+V5+2vQjKg8LuzJXA+gwIhZ26K/dzOFdKWn8KGg=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=e5lWCgQEBZFlXwKlbDqSZZG6fa3oJohlnjsciWtmEjrhbEPZHiHjS0+71lJd00XPwW
 AEHvw6lUfKbu3K+NJnPZoNZtYKVA8sA0NqLiFFgtKHHp4DoV7jdcoYtOq1SnDSKkLrey
 zW3uAAlCTfop0tAq4LVThMfpHztoZu6iU40oK6GAXEndrwbnRg+JOVNHwOZ9Y2kVVKbw
 yQsv+91mAWRzLwI0wY2ueM8juug5IVfAMNZJ6jCgrsZcgmmTqC4mIlR5n6O5mmFX1XWp
 38FUXZGgGM4MYblKrZQIblvVPkT8eTtgZ3M4SogBMeZa52T4rnoUGthVKsALEERXXr+w
 QwcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788273631; x=1788878431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+mIp+V5+2vQjKg8LuzJXA+gwIhZ26K/dzOFdKWn8KGg=;
 b=XRNKd/ynneePvztmIixCAtLumoT1XX467VGmIy8aAQ63S/mvL37YZg1HhhZshtz8io
 vQA9nPPPFrzSVFKw5ZaPklQeIHxpJz9n443up+LYCu1kbAr+QwIDSXm5hZ5FA2hrqxkp
 oNllTzgWFz8H03FxuwBhe9fklqq2lrgq3azhs24HHwQOfM6j8nuaa3gadrQct0wIs3RB
 sBH1hLLAV3QXGws6nqJlK+mxDBG2BwKdiVHOP6gfvi2pZkPYCcmxjwjWRjyLmb1CPHyM
 g3fEyg6qpP1Wx3Nn3JbqM8c39s8Cn1fTLXTWxBtIacErhYU25si5oNRwkz9xn8X8oIng
 wabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273631; x=1788878431;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+mIp+V5+2vQjKg8LuzJXA+gwIhZ26K/dzOFdKWn8KGg=;
 b=o1BByuFe1KWOOkCtsuFcV1xoQtnG18XYuPHNtUB5wvFvlxisGX9v34a4sVDlJB87+B
 VSGG7zts2Uu0b6szrgRZ6wDjNDAKhu1/29A0Ydw+jsiofjHiJOj6RtoLq92bTOw9rwpG
 6uM4e5citijGrAOQOnzYErPt8oHiR+qEPNhZ36C8V/K0u9N5vwabs1HE+BXH2HaPLVNp
 mEaj6JDDt7mgpEQPVJKKqxKzmnH1No3SYSpg6boic+Iokr/vVmUTKydCr71X8dFjiDNV
 svDwpfz/PnoIIFAfNHTIJbeod7qcavmpH2oiNsREihcXM/meMJgWsCkqmOa6LX4JGtE/
 h/ZA==
X-Gm-Message-State: AFuF++lsOzQLJ+Za2jGUvdWZVkQ6Cpm1OjUkaioNgHXgjvPgJc0q0r/Q
 VAonv9No4SbTGaALyBhcS1S8MHNEra6lhZXZtRTcQVpFPmUIb8h074H1RfI7KNxdlV6xxuKGo6Z
 5RUEpHujVaFHNU62DWLofBtcruSwPkfE=
X-Gm-Gg: AR+sD12r7I6BWrD57f1tWH3NUiTGVWdxO9KGJ1TImkDJ5kIigYfk84uzeqhZmP7k0OX
 HKFkykB3Sxxh342TI7gf2H89jud7Hb/gu5bhspmV9YoKz8TX5rMfmqhM8RUFxKbjpM6KYmGNKUs
 F7ieb+9Mc3ULlo0D4+EAFE/ue1RXc7DLBYZhxCwijzFALgCqK/xXuBH4sSD3bGJd2DGcF2nnsg9
 nZv/SEL5C3qBUhmtqQUp0iVfQMGJ4Ph7PreRD8hCR2h4mJ1CF1Xvu1bKWyDolyunb9StJFWgCCC
 tj4v9BwLZJWiSpGwZjKgxHd4ArKo0pPBwfT898LrxJKo
X-Received: by 2002:a17:906:4788:b0:c25:8bcb:ea0b with SMTP id
 a640c23a62f3a-c25b3bb8e6dmr766554466b.4.1788273631002; Tue, 01 Sep 2026
 07:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-15-zhangckid@gmail.com>
 <877bl5bkkx.fsf@pond.sub.org>
In-Reply-To: <877bl5bkkx.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 1 Sep 2026 22:39:54 +0800
X-Gm-Features: AcwNN1VbM660-bFlfF_UTv30XhdHiKad7_Ju0N8d9HxMnhbmaCMGJRaLXNG4A6g
Message-ID: <CAK3tnv+7m2exh9jc+cyAFx+JZv4xunxtRaSmUWH7QgpXPzBCFQ@mail.gmail.com>
Subject: Re: [PATCH V14 14/15] iothread: remove legacy
 iothread_get_aio_context()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
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

On Tue, Sep 1, 2026 at 1:35=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > All production callers have migrated to either the holder-tracking
> > iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
> > accessor. Remove the now-unused ambiguous getter.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h | 1 -
> >  iothread.c                | 5 -----
> >  2 files changed, 6 deletions(-)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 2ef8c1a1bb..9850cdb3dc 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> > -AioContext *iothread_get_aio_context(IOThread *iothread);
> >
> >  /*
> >   * Return @iothread's AioContext without registering a holder or takin=
g a
> > diff --git a/iothread.c b/iothread.c
> > index 803d6ce3c3..3a092119ee 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
> >      return g_strdup(object_get_canonical_path_component(OBJECT(iothrea=
d)));
> >  }
> >
> > -AioContext *iothread_get_aio_context(IOThread *iothread)
> > -{
> > -    return iothread->ctx;
> > -}
> > -
> >  AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> >                                               const IOThreadHolder *hol=
der)
> >  {
>
> Easier, I think: squash PATCH 04 into this one.  Turns "add copy of old
> function, change a caller to the copy, then delete old function eight
> patches later" into "rename function to mark it unsafe".

Agreed. Keeping two identical accessors temporarily is unnecessary.
I=E2=80=99ll squash PATCH 4 into this patch, leave blockdev.c on the old ge=
tter
while the holder-aware callers are converted, and finally rename the
getter together with its blockdev.c call site.

Thanks
Chen

>

