Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350CCC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28pX-0008CV-I6; Thu, 03 Sep 2026 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x28pQ-0008BP-Nf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:54:13 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x28oq-0002UI-Ic
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:54:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so384850766b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788447214; cv=none;
 d=google.com; s=arc-20260327;
 b=jy6Hw+YRnQkJ9GZVW9O/DEGSFkqudjOTL/BhzFQ/C4N7mNdIan9wogRLt3Pi2sy7+d
 HD3jSQtrSdTzCRqER9fzdxNUUuuIm2uxLV9bAN3sqIjwTccNuFaRs39JyFDv1TtykZxS
 KyqNBuJdiD3Qg7HSGqtWU9j4Ag1pe40oD9RmZ+FaufBR+WpJDOMi6ZViuSyMRrqD2CT5
 2fI6p4hzM3H8NeMMOyJOqqDbVTvrvUCJI73meb8UF9bJ4mrrTB7btmyVZlYR76v3jTP4
 52PCm+smfpTUnV3Uh6EjP4xiKVKkdN07waVSC8mxh/KzfSa8UXMYT9FhQ7GU3ItdN7gs
 5qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=11xrXspVX/VPt/wxJXaaqSfKi3MfF1Ly/V6SsTPnIi8=;
 fh=G487WN5iI7wJU4P78jLtNwGGIfJNDYk43VUyyHm9OiU=;
 b=DiyFKJaosESxvoFHh2uwXf293NI0vxu1jYlcfOZhhiNSZwwZHnTbcOGT6U1J8uN3P2
 LdTJ0O+wjIE0TuNmIz9kIAC109u3I521WVn0gUTNqzNyNwNv+lC8LXZiIrbkkqSO8kDb
 14vSpYBo+bX4l6Sfcao1xeSKossoOQih2JXxEo9JJ6k+3zZsKjKdgPxym9fS3STZLh38
 3wBHaGnxEUYmGz043hSiWxGzSpCuoUm3wDwx8fiuRRNSgU2RY5UyxLcgipvg5bEvi7qB
 yUvA05BEFTtuYH9q7qqSaB1zZpBERlOkTkDVTT/elA4PmqVtbBLgbQJYtS5Z8L3OcV8+
 IcTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788447214; x=1789052014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=11xrXspVX/VPt/wxJXaaqSfKi3MfF1Ly/V6SsTPnIi8=;
 b=Rzo63zYEph98F0RWhEq8hceZy4QAixk0rQPsCtKqggMiSWMZzLZkYLt1fvjWw5xrk4
 L/td1ITsiEOPo/6G8oeR9Bni6InYZ7xk9yhh/i7TN65IfS5ahe6yUAB0JrjRFfuUrz7A
 JzaPT3I81xjenjCufc07IGK+Jy0GN40gR2PlHstrMVsH3KNixMMGUGW60eSTLbv/vzfl
 0tOIPO5/N2byp8dF8tGPAuX/vy1Sz14j+8wfe+dgSxtrMu9QxcOLxwyVKrnS/s78uLOk
 WBy71Vr+w8mtJ4kGz34Mdci08dgI077DmSDRUSDgCuW0Ze18B2JOh2DILVEjaAzytX6Y
 CmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788447214; x=1789052014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=11xrXspVX/VPt/wxJXaaqSfKi3MfF1Ly/V6SsTPnIi8=;
 b=a0ScrVxSwmcCR9ufgVPE3gKMlCh7yGy3iizObxxfzcT08LT7qI6txObAiTnsTYWSmw
 Odd74mDA2Sm51xOGMSk6yO97rvxqlvDkOwsu7EgAtubNsFtsqdmTsV2f6TGJF67WbF8k
 6913I40EZjTQH/d6NmwYXKTWqJch6b68l/zqYCEMBxIjuIDvD/TaqU0B+gymyyToyKSN
 ZAYbP1W9uKryOdXxFQc3lTbAFaYyrmGTmzbDLUp70oVj8we0Rfjd65mTuP0IDky1NT6t
 TjjIv1JSxyYtg84ijpQW1c2ZjzveIjazPWhVHXyTIvsZup6jY7ZJYI4tppNYabQkVwD1
 U8tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjVQE8pcUmpt33PG9eMCsFd9JJLR/+2I3DVeIwfOodpIQxit+nDtj/FhELMfKVEiK8361qDJ2ERgSg@nongnu.org
X-Gm-Message-State: AFuF++llv407qrly/G42Sx9f2NdlMUdRts0R//GIEfH8aLQDJWjMs5b7
 fQgalWlj8GJpmWBFqf9kQEYM5NoblvLQAGj90w6PAaPLqFaEBx+0uIWlZ8cuenPHjT9dMZ8x63/
 vnAH6q/m1D+rFHufMutvpQj14sCrTVfI=
X-Gm-Gg: AYBFou3cfMHgVU4yKpZwSbEGjF4KBnq0OYkhOwVNanlgxxnr5LgmpvG8mdsCIWxn0jt
 jnNJo3D2JdE00+3RCUdBwT0E01VEKwS3d2JPv3EpVHLc2oS7EZ5TRGLtdxef4BZudmnR3JAi9Im
 exxL3ZAXIs+8YclaJn8D/df6M5kEYa3BcPJntIFMSHF6BwV3Dx+2JzT4Ug10MKh4Ds1kTsw1b1h
 qPTnrxI6CpXh4ACNjeD7NARsBn8WY+/um8v5TNnEDZ+Jy47QoIFs/oUCRzkTBlylBJev0qnexaJ
 sSoyHtkhrWqq0eG40BQb6alpCdTv9H55Lhi3NazCyIgR
X-Received: by 2002:a17:906:6a13:b0:c12:3059:4071 with SMTP id
 a640c23a62f3a-c25d55bbd0fmr742740666b.15.1788447214211; Thu, 03 Sep 2026
 07:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <20260902193518.GB787498@fedora> <87ik4mzx7p.fsf@pond.sub.org>
 <20260903134250.GB825275@fedora>
In-Reply-To: <20260903134250.GB825275@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 3 Sep 2026 22:52:57 +0800
X-Gm-Features: AcwNN1WTtKqe9Vu-Sf7Np8l7bzL_B4o58zc2XGLlbINiYX-zKrvJQTc9JSAlFQs
Message-ID: <CAK3tnv+Woa47SibQhOht5bk0sWjWLn8GgN3GPAk+WAd-65hBYw@mail.gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
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

On Thu, Sep 3, 2026 at 9:42=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Sep 03, 2026 at 08:05:14AM +0200, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >
> > > On Tue, Sep 01, 2026 at 12:00:27AM +0800, Zhang Chen wrote:
> > >> Monitors that require an IOThread share the internal mon_iothread.
> > >> Account for each monitor explicitly in IOThread holder tracking, usi=
ng
> > >> the monitor's canonical QOM path to distinguish holders.
> > >>
> > >> Acquire the shared monitor IOThread AioContext once, using the monit=
or
> > >> QOM path as the holder, and reuse the stored context for later
> > >> operations.
> > >>
> > >> Release the holder from the Monitor ObjectClass::unparent callback,
> > >> while the canonical QOM path is still available. This covers every
> > >> object_unparent() path and avoids duplicating the cleanup in
> > >> monitor_cleanup() and monitor_qmp_prepare_delete().
> > >>
> > >> The internal mon_iothread remains hidden from query-iothreads, as be=
fore.
> > >> Management applications therefore cannot use it to determine which
> > >> monitors are using the IOThread. Nevertheless, track the monitor
> > >> holders so that they follow the same explicit holder and
> > >> IOThread reference lifecycle as other AioContext users.
> > >>
> > >> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >> ---
> > >>  monitor/monitor-internal.h |  3 +++
> > >>  monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
> > >>  monitor/qmp.c              |  5 +++--
> > >>  3 files changed, 34 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > >> index e0a124a317..74ea15c85f 100644
> > >> --- a/monitor/monitor-internal.h
> > >> +++ b/monitor/monitor-internal.h
> > >> @@ -154,6 +154,9 @@ struct Monitor {
> > >>      guint out_watch;
> > >>      int mux_out;
> > >>      int reset_seen;
> > >> +
> > >> +    /* iothread context */
> > >> +    AioContext *ctx;
> > >>  };
> > >>
> > >>  struct MonitorHMPClass {
> > >> diff --git a/monitor/monitor.c b/monitor/monitor.c
> > >> index 6af09f2f6e..9e3b639eff 100644
> > >> --- a/monitor/monitor.c
> > >> +++ b/monitor/monitor.c
> > >> @@ -81,6 +81,22 @@ int monitor_device_index;
> > >>  OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true=
,
> > >>                              { TYPE_USER_CREATABLE }, {});
> > >>
> > >> +static void monitor_unparent(Object *obj)
> > >> +{
> > >> +    Monitor *mon =3D MONITOR(obj);
> > >> +
> > >> +    if (mon->ctx && monitor_requires_iothread(mon)) {
> > >> +        g_autofree char *path =3D object_get_canonical_path(obj);
> > >> +        const IOThreadHolder io_holder =3D {
> > >> +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > >> +            .u.qom_object.qom_path =3D path,
> > >> +        };
> > >> +
> > >> +        iothread_unref_and_put_aio_context(mon_iothread, &io_holder=
);
> > >> +        mon->ctx =3D NULL;
> > >
> > > mon->accept_input_bh still exits and uses the AioContext at this poin=
t
>
> exits -> exists
>
> > > (it is freed in monitor_finalize()). Strictly speaking, this violates
> > > the idea of not using the AioContext anymore after calling
> > > iothread_unref_and_put_aio_context().
> > >
> > > This could be a source of bugs, but mon->accept_input_bh won't be
> > > scheduled anymore in this code path, so I think we can live with this=
.
> >
> > Worth a comment?
>
> Yes.
>

OK, I will add a comment before the "iothread_unref_and_put_aio_context()" =
:

 /*
  * accept_input_bh remains associated with this AioContext until
  * monitor_finalize(), but monitor teardown ensures that it cannot
  * be scheduled again after this point.
  */

Thanks
Chen


> >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >

