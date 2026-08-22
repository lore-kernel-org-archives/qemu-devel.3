Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46880C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxsuS-0008W9-FM; Sat, 22 Aug 2026 17:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxsuQ-0008Vl-Ta
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:05:46 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxsuP-0003Jz-Bn
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:05:46 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15d47266baso251529366b.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787432744; cv=none;
 d=google.com; s=arc-20260327;
 b=mAgRy7pTN6ZhADtjUebmbK97fQYmzc0hl4HbiNnrZvG9lweNpD8ZPBVR845Eyr7mLH
 M7UychTcNVxL2nskf52WHIjOM3dqTqqIDpBGeDf9XKL+HuGjAcinwh1GDX8NvRLERD/k
 ZefVVkYPah+UsevPpMRyhwL34w6YJtiw9bZvxyGdR+krHpI8bEo0oecoPSGc2DjJIgmO
 HKPRcx45TnTKEZEzMDLfyI8oSdDfxS4b1fmZEbTCJBTWHl8iD+GA5wosKxYu5SnZqWa9
 cM+NIVVYZFu+dgCv8B/to0Naydi5mEqbI0sq6tD+CBdrHqjLplE9qg8vyLSNkIsfmVeM
 CJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JCz9bZnIii5gohrqJM3OwDngkVSi5tn9Qsx880bCmKE=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=Vk7Q7KDjpeqJw9LBk66cJN5y2ImWmBE2UtINN6du1e+nalXIk3T4jfI+2gyaaGcRqS
 4eockbOSrSvwbH+w6927zF5MvGy3oQEr7coJeodQ4ZiYQ+ppN/6tiqtEtJWY5WDWkMGU
 WA24YcxpRMDCFQF6RxSZSkxvlRvsX5cyMLJn2xVltxWM5nScpI3IfoXqc2Lvn0csZuOx
 gVQYX/uucxVuy9oD1DtDRO5bZaYh9MaoqbGac0CC4xMVtkRKOYycX43OZBA1jc4w7lm4
 CI5gNqz20M+5l4P1YfLeQHGoSNIn0YxwawrrD2gnEnYhQmJaAQBvYHOEcWoXRjCqeOOg
 4Sdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787432744; x=1788037544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JCz9bZnIii5gohrqJM3OwDngkVSi5tn9Qsx880bCmKE=;
 b=o1hchOef+iB/W+UtFf125QstlqzVbOy0zpmptbtcRo8Y/i43n5FbYIfQT2tIQ681x+
 Vt8IX3nsqvP16KC3tMUL1/1mclPw+lDdZZaF+s5vC2iHlTy6rkh6AtZ2Y5D/YIZg5ShE
 JOm0VMRMYcmk7SW2xvcDQFEpHnOka7yL2aZQAL/ioE5kUwn1r+VRKOYrerp66ZLOVhR6
 6XpnTqQ9MqtmsVpbjePAJQcOAhWpNEWQlIXW/BV00LzcFbUHgyGSaqp8gmAoZQ5wJtPh
 h272qLl80EYMLIdeXgaO62T5yiXqMm29yItCiSfXu0ED26tZaVzDfhNsFpHMa1uGBHsR
 fKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787432744; x=1788037544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCz9bZnIii5gohrqJM3OwDngkVSi5tn9Qsx880bCmKE=;
 b=ChAg3c4lfYQ/NnP+ENYCnpOXfm13DSShgfAQAVSxHn8AlHMTNRccu9g3fhmimZtlU6
 SBXE88m4vX7X5wNUk6Qk8qSroVAeaHArFEZsJUMDtyAjrSjz8C0+S+aUw4yn3khV+iB6
 Bu/Hqa+gTdfvJG5c+ilCaDQOKeQmJNEmkQPwtD8Cyb659ydSe1Eo1GTgftj3OKjEoTaS
 RQTGObaEglY+kK6k3BSASCCwpXeBrlVJbjjYJXaLqYKI55Rg4s71l85Zpzl80gLnBrGP
 8zgFoCUKt3CutqnL8dulK4U6GfFxs95Iox97uCpBtyh3xIyze7ld/93ZO7/vu5KfXBF2
 gQJQ==
X-Gm-Message-State: AFuF++mcWLLRrFA0kc52t06SFacg/rraxp32pwRDPVZztyLDML/Jf08p
 WOyuYv5Aa+721pevuIUAypYHMzdji1M4SQYh5jw/luwesZZWC8pAc+h/0Icpv/5lPyXQTIA3InP
 DG7ZNUTUl9Y2cKJ+qf1IEtbkhyuoIp0o=
X-Gm-Gg: AR+sD10okemsfSGOtq/qMMnHs7cUHjvV0UFdm0o8iJ0niNdgShX947mlfmES9U5WQHh
 ziHzZKzXtpUfJ5AOX3HTJSzTk1EOahnvfyrGj2t+VGksA/mP4YOsY6//zncj9FTGcXuDE4LaPNf
 wOYbcYqsOnRHBkusSx8KkqrNZZPvByx5sMwQprzg3/aNFEND6YIO37jz8X6g7NHedndPel9ipIw
 zRNyEKVT9wfomHAELZD5s4sSa9mWq66rJdHpMqoh9Ba99ygOgueauOdaaw3A02hiDnz5389T2qh
 WIbNKJQKOpWSC0KKO1IQsWoe1Zzs/fMPOnJIrjykcqTRCDPQog==
X-Received: by 2002:a17:906:ee8b:b0:c20:f6d9:d8c7 with SMTP id
 a640c23a62f3a-c246a6b0db6mr1760688766b.24.1787432743499; Sat, 22 Aug 2026
 14:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-14-zhangckid@gmail.com>
 <87y0e12okc.fsf@pond.sub.org>
In-Reply-To: <87y0e12okc.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 23 Aug 2026 05:04:43 +0800
X-Gm-Features: AcwNN1VEpqhK5JcL5ylkz6JUcThsrHU1f_hWTT3YJ6c4NXaytMx9YRx-dMGRqBc
Message-ID: <CAK3tnvL0N3AK78zwZVLP7ycujGeEHhmyuM6VG+LQd3GRg5CtbA@mail.gmail.com>
Subject: Re: [PATCH V12 13/15] monitor/hmp: display IOThread holders
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, Aug 20, 2026 at 4:17=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Display holder information in info iothreads to aid manual debugging.
> > Omit the holders line when an IOThread has no holders.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/hmp-cmds.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index e9fb8d827a..41a813e79f 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -240,11 +240,32 @@ void hmp_info_iothreads(Monitor *mon, const QDict=
 *qdict)
> >      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
> >      IOThreadInfoList *info;
> >      IOThreadInfo *value;
> > +    IOThreadHolderList *h;
> >
> >      for (info =3D info_list; info; info =3D info->next) {
> >          value =3D info->value;
> >          monitor_printf(mon, "%s:\n", value->id);
> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thre=
ad_id);
> > +        monitor_printf(mon, "  holders=3D");
> > +        for (h =3D value->holders; h; h =3D h->next) {
> > +            IOThreadHolder *holder =3D h->value;
> > +
> > +            switch (holder->type) {
> > +            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> > +                monitor_printf(mon, "[block-export: %s]",
> > +                               holder->u.block_export.export_id);
> > +                break;
> > +            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +                monitor_printf(mon, "[qom-path: %s]",
> > +                               holder->u.qom_object.qom_path);
> > +                break;
> > +            default:
> > +                monitor_printf(mon, "[unknown]");
> > +                break;
>
> This is unreachable.  Please use
>
>                default:
>                    g_assert_not_reached();
>
> to make it obvious.
>
> > +            }
> > +        }
> > +        monitor_printf(mon, "\n");
> > +
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
>
> Quick test:
>
>     $ qemu-system-x86_64 -S -nodefaults -display none -chardev socket,id=
=3Dchr-qmp,path=3Dtest-qmp,server=3Don,wait=3Doff -object monitor-qmp,id=3D=
qmp,chardev=3Dchr-qmp -monitor stdio
>     QEMU 11.1.50 monitor - type 'help' for more information
>     (qemu) info iothreads
>     (qemu) q
>
> Hmm, no output?  The QMP monitor should be holding the monitor I/O
> thread.  To confirm that, I made monitor_complete() print things (patch
> appended), and got
>
>     ### monitor qmp holding iothread mon_iothread
>     ### monitor compat_monitor0 without iothread
>
> What's going on here?
>

This is expected with the existing query-iothreads behavior.
mon_iothread is created under the internal object root, while
qmp_query_iothreads() only walks /objects, so internal IOThreads are
intentionally not exposed through QMP/HMP.

I prefer to preserve that behavior in this series, since exposing internal
IOThreads would require additional API decisions, including handling ID
collisions with user-created IOThreads.

I=E2=80=99ll also change the unreachable default case to
g_assert_not_reached().

Thanks
Chen



>
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 26e7ef4d35..57672dbe0e 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -751,8 +751,13 @@ static void monitor_complete(UserCreatable *uc, Erro=
r **errp)
>          };
>
>          mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, &io_=
holder);
> +        printf("### monitor %s holding iothread %s\n",
> +               object_get_canonical_path_component(OBJECT(mon)),
> +               iothread_get_id(mon_iothread));
>      } else {
>          mon->ctx =3D qemu_get_aio_context();
> +        printf("### monitor %s without iothread\n",
> +               object_get_canonical_path_component(OBJECT(mon)));
>      }
>      mon->accept_input_bh =3D aio_bh_new(mon->ctx, monitor_accept_input, =
mon);
>  }
>

