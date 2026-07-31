Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975CCC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 02:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpd4o-00061b-07; Thu, 30 Jul 2026 22:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpd4k-00061L-Oa
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:34:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpd4j-0007K0-72
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:34:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so763828a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 19:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785465256; cv=none;
 d=google.com; s=arc-20260327;
 b=ok6fdV/eexyjhWArblBcOWUu7azt9I3yxpr7HnTT7os7ZtX6LzKd6ACQfOEjfZUaa8
 dWCMYGPYoZKsVqQYrtY7zTc7fQo66ZeoATT0ec0UU8QdRP1sTUURnXm1/GRZd1adKlhD
 LlX+jdptwRi+COTMvq+uaTer1oVDOKTehUtr09/lQpAsiXSGpUPfNwypokZInv6rwVXL
 SEjN9ccPAJYx9GEfc2NYQL5+x2ACA7NjnhJkY2VR6KMD5vYzfNaKE8hVFddmSdltqqX8
 x5yIXdDBUyKitEoE11BaXjUsqmEwQD63RbnsJ+o3YSUBHzHy4o2JTomprgwUZsyUyxDU
 AWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+PGNIN9kGr+i4IMzV8cJTx3k3FoHZ8zt0CKRzE/Yct0=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=EDZ10+eCfEuFiwRF5r+wpvUf67IL/UeWLZfaMo21dsiZpCjcoci9QcanPFtWA/Joma
 DlNcB7V5uOFC+qn5xASn7h7+6x7dvdkkjhafowQqfxB/G6v4Vhzio5muwKRG2RLqlY08
 Y7JNDXED4HpseZqlyrAHf3/zL+ONBBq+OIYFhnaJWdgmUnrfcTtQ9s5UTaWO3lGjSc+E
 J/J9WFkXstghtStwIDet7NyZ4QVBd0Gk8qrdqe9k23VTp5+YhNrw8HC4A0Z7AMv3OvDh
 IQAfC/BgZs7mF1DkwaGBe2Qp94DFfuneNY0xTwX87J/IvgIus8W3n8d8Lbo4zjAXuZEq
 3wwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785465256; x=1786070056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+PGNIN9kGr+i4IMzV8cJTx3k3FoHZ8zt0CKRzE/Yct0=;
 b=UvoydpFvLehcFuV+zkf1Gc9S8OaBVUnq3XglmNfPQ0S6IZEs/QX7sR5cZtfJD31DK+
 WdNaro7sORmC9sQHElGKnd5QNlo10tDQm6hJ0ixtml5BuwKya+JFj/hS00p0DrEu1RA+
 mLt600tUw7N/JMbALTB2VodPv7lB7fdXtC1G6Hzbm2473WPMp7sI3Cpl1EkFpuEYv2zW
 lcMquA91QZIJftK862LgGzKwImfsKlq/5wpT7eLnP5B4HMFK4HUC6JHKdrMKMUl6J746
 WVXDMUCi3vrbXdKD4kxxDLbVg+zs8jhCtgq1LQCzAAA9NE27kIZBfqgQ8zqNYmuvKv2L
 TLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785465256; x=1786070056;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+PGNIN9kGr+i4IMzV8cJTx3k3FoHZ8zt0CKRzE/Yct0=;
 b=acRUh5c8gUzaxEg0xdxOIznIrSQbpy7BEtqCypFDf8cpJlFVuQMroVYZbL5Wedw5X4
 damktw8zBd7dgV/mpaWBL2mCICAytOO9yYJ4xHN0FvMNkRxoObsNS8B1tHOkeYHKqyJJ
 Y2SUs3HUgMgR/JNk50X3yISRihpsW7bwEUBhvBpSdMD8Ycgk0IBObCbM6Gyu9sTC4NwG
 //7ahUpbeHyn7ZESy/c9rxDmP1E0Ks1ymI78ry2bzbfs3YDqvuvA67/5ReX0koZCiPi1
 i1i4rySFrQDHaRjd43fKQA+//gLf+PbOT87ZjFgs3WIY9wWMaNLZg1Pa5PWbH8lf2scK
 OZYw==
X-Gm-Message-State: AOJu0YwM/BJsVZES3lmwjePH9G7CsA4BCOwtQTQeOA+GL/rgrB5Ax+Km
 05Bgn5d4ZAjRfns8hcJIA4X+j34HLAY3mep4kXjmX/oMegLXSarw9elIqBFEO5nz6Jib2Zr1S27
 16XCrCj62DcDYW7c6rCeTwBtiqYL0mCQ=
X-Gm-Gg: AR+sD12FzNrzoFVxhKfGJb7Q/XHHSy+LG7+BHGbzdgy7CjvKA1geMJ5phRSVyU7Gs1Z
 +XtJOW5JxtT9EuEBI/kTgeX1uq5e6vJyLPN9jeZBdiVxWHoy1JsH8vBDxBb1T/wSV8UGLfRKIvu
 gHyPcsGd/atrlJbZg6mPfzWUcWn4Omm7Ksa6M9LqCL7ypiDDku7AwgqoNv7boLPwSi4DdDbZiq/
 HWLiWxgWZzJhJDiKEhzai49VQxN9IlYzFNz0s1ApBX3Qt2Bhzq/oBcj6QNudUP9p7G3ACe+TzKo
 p2xBTeCqGw8dRfwmgb4gLs1xGQoutf+TSRqcaHGEyT2F
X-Received: by 2002:a05:6402:26d4:b0:698:c1d9:8134 with SMTP id
 4fb4d7f45d1cf-6a0984bf6d7mr113155a12.9.1785465255403; Thu, 30 Jul 2026
 19:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-14-zhangckid@gmail.com>
 <87se5co693.fsf@pond.sub.org>
In-Reply-To: <87se5co693.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 31 Jul 2026 10:33:37 +0800
X-Gm-Features: AUfX_mzpINfjlCpcL33J5xI5KBcPtuUgfoY3X7Q-vQ2p_kI8RNf4XmS8Royg6qE
Message-ID: <CAK3tnvJOLw286Cwv-61SBw0g-qAin=atfj=qroC+F2Eu=6WNNQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 13/15] monitor/hmp: Add holders support for
 hmp_info_iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Tue, Jul 21, 2026 at 8:51=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Exposed the iothread holders via the Human Monitor Interface (HMP)
> > command 'info iothreads' to assist with manual debugging and
> > performance tuning.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index e9fb8d827a..cd2d9c1d59 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -240,11 +240,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict=
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
>
> This is unconditional.
>
> > +        if (value->holders) {
> > +            for (h =3D value->holders; h; h =3D h->next) {
> > +                IOThreadHolder *holder =3D h->value;
> > +
> > +                switch (holder->type) {
> > +                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> > +                    monitor_printf(mon, "[block-export: %s]",
> > +                                   holder->u.block_export.export_name)=
;
> > +                    break;
> > +                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +                    monitor_printf(mon, "[qom-path: %s]",
> > +                                   holder->u.qom_object.qom_path);
> > +                    break;
> > +                default:
> > +                    monitor_printf(mon, "[unknown]");
> > +                    break;
> > +                }
> > +            }
> > +            monitor_printf(mon, "\n");
>
> This isn't.  Results in messed-up output when there are no holders:
>
>     $ qemu-system-x86_64 -S -display none -monitor stdio -object iothread=
,id=3Diot0
>     QEMU 11.0.90 monitor - type 'help' for more information
>     (qemu) info iothreads
>     iot0:
>       thread_id=3D1035908
>       holders=3D  poll-max-ns=3D32768
>       poll-grow=3D2
>       poll-shrink=3D2
>       poll-weight=3D3
>       aio-max-batch=3D0
>
> There's no need for a conditional here, the loop does nothing just fine
> when the list is empty.

OK, will not display when the holders is absent.

Thanks
Chen

>
> > +        }
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
>

