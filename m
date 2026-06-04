Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178C3CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV58R-000843-Hc; Thu, 04 Jun 2026 06:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV58P-00082k-T6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:17:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV58N-0004Uq-WB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:17:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso760452a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780568226; cv=none;
 d=google.com; s=arc-20240605;
 b=SpXTJp07Yy2zaIA0vohc5j9/LD4gitO+8XVigF3xWQFcGLYWJVyh67ISM7KvP3PScW
 dZu8MXtz5LLede6Ui4EcqI/WUYrlBnnBFQ2O8JPESbEmh0wqQMpreznFP0al/XmJkVar
 t2joIibedGh2kYZ57LBBousNNIcr5gxE8VjUYq5Va2GxTAy79fAtGi3jrzx+OlHPSTl3
 ZDWrIJDK+R0mjXGAu0SkoLK34ep69lA7cfRuPlhzO4zL+AejzgLDpmeqFbFU0GGpjvJK
 SkSZNoB3VkkexXSRhmsa/RruPu1uGk/dj077yaWhNArUkgMOmrF92+QSvQZBb2rmVz5O
 KLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NfShHkAr0yTHE7uZ2MzezQHrsuRC47mvMv1FqrsCMys=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=PxaN9iVfeOZ2/k0Cwak+UB3udI8KA+1ct7qsb/frMhjgucjnivzDaZAFkuxwHkE+zK
 KnsS8SlMGzPF9eDJIYaLafUDd8h7vvYmTnMUYu6iTTJWtuJs7vNNo7LGon9hLLqqxD78
 fo5h7OrTmTrNRtvQYf/YqcFHt1ofeUZbVLZvyw6TFc2TGO+m76twPmhNap/khMTmr3cV
 UZ1x48GV3H6HdKhpliwtrQML24LOtnT4bvcosxriFIonVlQxv2vwXRxhEriU7Of/dP4d
 Y1B63r05QdxOE2PMFacz6AnxJCJqAa2tAYZRTfdjoP73abuYyPKzg9Yo8N/eGDRV7ERM
 2USw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780568226; x=1781173026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfShHkAr0yTHE7uZ2MzezQHrsuRC47mvMv1FqrsCMys=;
 b=knRyeQGAKmd5BiyqncARx5gRc7DqN8io9UIp/6seps6AHrPEF8Gxs40w9QEpfl8h7F
 IayCWRNqOgXc0WpCWJAGfCn8NmEBBIYZBDoAlVbHXGK8+40jcaEAO7q9I7LNQxZbC6eT
 UYgCiCgw6dtNwSfQRLo41vftA0lfahLzYVCzJ5CCM/6qHjwIGo9uIA+M2QrKHHNY2m7k
 A16q606BkyzgAVQzV1tR9cY2bk1wY/+Hpdz/LqMeiNNELc9BZCKJX/my0lBUMqoZ3Ub4
 dQMYLu4KrEBD322xqRwMera+bWnhAD6TYTGlTI+AR5ao8CC6RhvMDIRg5fzMmrKvdcg7
 YIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780568226; x=1781173026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NfShHkAr0yTHE7uZ2MzezQHrsuRC47mvMv1FqrsCMys=;
 b=LAKSo3g9TgHpDFDQtyrheOY/G7ULJsT5zROqiOU18JTJn8qURJwRGAKc0meRYeKk8U
 Xr5ttAe9KQ1gGSu2qf/YyTWQso+dT8fsQVnlbjCnhVwC5CZhbXBiqNLKWGhRsCbO0FQr
 abPhUr2nDwmgJvdEbumfFIueNiA9uy96nqR3gY57RJQseDmSQZnOs4CXiHNi6eRYDSnv
 esac26pkyDc+5vWa62hGAuxn0dkKPZh1zdYNFUWBbmnvx+2FZJX5MBAbk5mM/oCr0NTR
 ECgmyaYGE7Lc6cMJwMergCGMFYivJZlHrT22bzClm2ahzSrq11RgN1o/7V/fgS1Ss1yJ
 p1AA==
X-Gm-Message-State: AOJu0YxaSX1nfI/1gC5LRQYpFw0aivQLeKjla4S7kGhFeO1SA89G2Z2Y
 0f5RVNkIVMp9Q3rJlFMhbtLfTDAHWEomWDqQqQ6x4RpjLW1WWXmck6mnclZ3EhC93KrSq7K32nV
 PVLDYz/IM+fs6lFKLhfBe5EwUp5ywKzw=
X-Gm-Gg: Acq92OEFWPmot8EJ2FYji8exzjbzu0RnZlGSvwUo0D+fmLXe9iVN4BD0E10rsbj0AVF
 fcQxwkrP7CYR/06o8eXfWUlKZKgyBphqsyQthR0+BM9YqTfPhWpB7qs4aI5y5vQ+VMEs2MCbbQx
 zI7WGWpaaGqTEzxU0JTSba+urMHOwGlV87d4PAkzeCtFimP3ZL7PYa7e8jW2JbRXbetb8N2Xq0b
 vjI6coaBMVw1K/53TvIZ86m3Z/Qs+314yTM80JkEjhxt3R0zG1tPRRcS8DD1lfLHgPe6Tbu+GAq
 iOQJ6GkNf1C9La1fdE8=
X-Received: by 2002:a17:907:28c6:b0:bd9:aa4d:c6b5 with SMTP id
 a640c23a62f3a-bf0ac309ac2mr261404966b.9.1780568226029; Thu, 04 Jun 2026
 03:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-8-zhangckid@gmail.com>
 <87qzmorh9j.fsf@pond.sub.org>
In-Reply-To: <87qzmorh9j.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 4 Jun 2026 18:16:29 +0800
X-Gm-Features: AVHnY4KPLWDGkCY2R39qXycWdjf_XUGDCXO_c5JGOkRqB9-T5vmGnPCT8_OfRvk
Message-ID: <CAK3tnv+okGDVvEL+rDrMrTbJfCDmnttCbQyXYeQ-b7bO99ZODw@mail.gmail.com>
Subject: Re: [PATCH V8 07/15] monitor: Update tracking iothread users with
 holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Jun 3, 2026 at 1:20=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Based on monitor ID tracking iothread users with holder.
> > Introduce the AioContext in the Monitor struct to avoid repeated calls =
to
> > iothread_get_aio_context()
>
> iothread_get_aio_context(iothread) returns iothread->ctx.  I doubt
> avoiding the call is worth the complexity yet another variable adds.
>
> >                            and ensure symmetrical ref/unref during
> > monitor lifecycle.
>
> What do you mean by that?

As we discussed with Stefan before, the iothread_ref/unref need to
call in pairs, for example the virtio-blk. But the monitor implementation
is special, it have the monitor_suspend/resume with iothread.
So I try to introduce the mon->ctx to simplify it.

>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/monitor-internal.h |  3 +++
> >  monitor/monitor.c          | 20 ++++++++++++++++++--
> >  monitor/qmp.c              |  3 ++-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 2060311b03..92d7630921 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -127,6 +127,9 @@ struct Monitor {
> >      guint out_watch;
> >      int mux_out;
> >      int reset_seen;
> > +
> > +    /* iothread context */
> > +    AioContext *ctx;
> >  };
> >
> >  struct MonitorHMP {
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index dafb4ad8b0..7eec6f967d 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
> >           * Kick I/O thread to make sure this takes effect.  It'll be
> >           * evaluated again in prepare() of the watch object.
> >           */
> > -        aio_notify(iothread_get_aio_context(mon_iothread));
> > +        aio_notify(mon->ctx);
> >      }
> >
> >      trace_monitor_suspend(mon, 1);
> > @@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
> >          AioContext *ctx;
> >
> >          if (mon->use_io_thread) {
> > -            ctx =3D iothread_get_aio_context(mon_iothread);
> > +            ctx =3D mon->ctx;
> >          } else {
> >              ctx =3D qemu_get_aio_context();
> >          }
> > @@ -612,6 +612,12 @@ void monitor_data_init(Monitor *mon, bool is_qmp, =
bool skip_flush,
> >  {
> >      if (use_io_thread && !mon_iothread) {
> >          monitor_iothread_init();
> > +
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_MONITOR_NAME,
> > +            .u.monitor_name.monitor_name =3D (char *)mon->id,
> > +        };
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, &h=
older);
> >      }
> >      qemu_mutex_init(&mon->mon_lock);
> >      mon->is_qmp =3D is_qmp;
> > @@ -631,6 +637,16 @@ void monitor_data_destroy(Monitor *mon)
> >      }
> >      g_string_free(mon->outbuf, true);
> >      qemu_mutex_destroy(&mon->mon_lock);
> > +
> > +    if (mon->ctx && mon_iothread) {
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_MONITOR_NAME,
> > +            .u.monitor_name.monitor_name =3D (char *)mon->id,
> > +        };
> > +
> > +        iothread_put_aio_context(mon_iothread, &holder);
> > +        mon->ctx =3D NULL;
> > +    }
> >  }
> >
> >  void monitor_cleanup(void)
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index b210850a15..b67674aef3 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -565,7 +565,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, co=
nst char *id, Error **errp)
> >           * since chardev might be running in the monitor I/O
> >           * thread.  Schedule a bottom half.
> >           */
> > -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread)=
,
> > +        Monitor *mon_p =3D &mon->common;
> > +        aio_bh_schedule_oneshot(mon_p->ctx,
> >                                  monitor_qmp_setup_handlers_bh, mon);
> >          /* The bottom half will add @mon to @mon_list */
> >      } else {
>
> The patch does two things:
>
> (1) Replace iothread_get_aio_context(mon_iothread) by mon->ctx.
>
> (2) Call iothread_ref_and_get_aio_context() / iothread_put_aio_context().
>
> I challenged (1).  If we decide we want it, I'll ask you to split the
> patch.

It's OK for me~

Thanks
Chen

>

