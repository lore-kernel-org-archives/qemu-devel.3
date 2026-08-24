Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A381C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQr2-0006Qh-2c; Mon, 24 Aug 2026 05:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyQr0-0006QQ-I9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:20:30 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyQqy-0006NS-O1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:20:30 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so459361166b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787563226; cv=none;
 d=google.com; s=arc-20260327;
 b=QTbimpBCyBpKMgaXsBdBOAX/Urg0DlYPwFQQUhpLTd3P0t+fzYH1AdOLfDVMoMWuzj
 5bzEsrdBoUZG20QqXJtcEYDzexx4m4Mz0H/xsxapWTdJ0cD/ipcklbmTVElaQKIPNtCH
 OY8P8zz/3Bfs2nAYrgVb+3abfNfSn1begwB/x2+iNSzamqveOZvmfiwYTuQHdtyJox3Q
 0pPIUbNk499Oc7b4ySxbPSbJGUXZishwHTHn9QcAqa9nxtvJ2a9zqCzrH9kB4XkYuRYA
 gZEP0ZproPrRz4iU/mXwfXU9DBhs6YocAyESgABHl/eDFCIPnyZO7TX1rzTdMEtWfzlf
 aO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6EJLXJQcuhaVWby2f6a7kpaCGepaAPvmxfqVt7Jkb2o=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=jutVAxTgq8hMSS5XqSW43h8qRIOfaE8RMVhnEkqUiQt12KvX4+wqBcMmDCNyP3pyBT
 p68J/quyA4B+Lpk6fpG+Gqqq5xzu9Q4v2vKOhtqZQFb34lOoWM53BIGKzGF3fkWaMh3g
 L4SAL6X6YnuyiRJRWIg01LXWuAnxUBHqJUbakvFCz6GIhFYpO2Hi0m9yhQDQghndXqB3
 7M17cFXGIZIeLupRygUwmcgBoCmJQOIYE188JLlXHUHT3NacYi3ccjoR+uokndtJPNKl
 B5qNy5jUKuOB6sig73wLGunwkOxQHZFlKmDasDHDjTnh2uKmkzcrEXVe1UqEUAuT4BeH
 otcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787563226; x=1788168026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6EJLXJQcuhaVWby2f6a7kpaCGepaAPvmxfqVt7Jkb2o=;
 b=mckWmG2OS0zFLxBLsyuXKEEz2uskGgsYR2KZ5GwFWufaZCxTuEdZWhM1CD3IxXEKmv
 mTRac9Wj6rJ1TCb6xmlfnzS97NajUH+ijkqYe5Msf0xlP5dsreky/lRXXsbE53xTHXE5
 ZQRsD+Owifr0HKXa3IS9L0k7SundHRs8akaXnaAIn17Y0/kmF6VoVAOxNF+X25u+J9Wj
 bFvbyp70NfbtJ9hliHgEbMgxrntZAanh3YIBDtsmArH1pjVhfq+MJBj8q++kEEzrJ21g
 v2A2kGCqriRFBII5vRTJ14mRHIliYmsdSWgS2ur3n86R+h5alRZ5RfoYGIHPugPRJlBw
 KP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787563226; x=1788168026;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6EJLXJQcuhaVWby2f6a7kpaCGepaAPvmxfqVt7Jkb2o=;
 b=eWl9n7lxpsofE9nPJ7giDkCquRtIMFmNmSuAvBqx0n3XBX9DJ0QLgUe9HcNeN/GRsR
 otlEcNtL0qcr7OnzBFaoe6sGpduUyqLrEINtLK9MUYfJksR3YZufMEQP8CUEUeOIAJ7X
 wEAl6zCC/9XVNHlPn/Fo3McRx/xi1HjeqK8VtOaHNAswqyaZEBfndtqsumF6TlA0XHrT
 TgQHV8g9s4/nTFuxTcGHZJnHGCsie37gDs45lQ0NSEdYx8VD0tzICaa/NrpCHl0OMlam
 HH6ZQJS8kVwj8vTWEYPvA3CJN/cF1GjJkHHfwbGyMTn0g519T6jz5lLAQXg7AjEOwys9
 ZEgA==
X-Gm-Message-State: AFuF++n4XG9GKRFBqLuueeaRgXoP8decw5r7NyjOKbI/TT5z/IvK5+UE
 Zxk2orx3v4GJN/Bh4J+mPyMD7KED84txYJJ5Ihb0apTXMMX3zpnWBGosaGMaqWib6IA90/WCw7Q
 HXynsLKziFF/bRx/loFZGgIi/FMGa6CI=
X-Gm-Gg: AR+sD12ayLLxf57nnu1KVcdSlSIi+zBiuEDnUzXgoZQLhPB5vv1hQ7EDAHU3GNhK27F
 D5mUg26LRhskFGShf64ui9Ftdu7qdUGeEx8be5f3dIpK30JQIIaxjCpgdj69QlQQWiJBmV/Qawo
 DtGSVbC+dmu3T7i+KS74E56EcG6Wp4fEHL+CxZpIRab4DCBd28aJpBGSW0yLQi3bsgeZ1tFeluj
 JINuCd1EdkiQqZcLYPn4yU5k2rQxlSgxP22qGOs+eR+A622Offs4uGonXgMUkqZhGLqARdRs0RW
 1NAilCjWkRTfcAOk+2Vxi4i4adFPGw7EuIQXY7LUdX6XkQ==
X-Received: by 2002:a17:907:3e20:b0:c15:f005:63fb with SMTP id
 a640c23a62f3a-c2491c28536mr2208300666b.3.1787563225992; Mon, 24 Aug 2026
 02:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-14-zhangckid@gmail.com>
 <87y0e12okc.fsf@pond.sub.org>
 <CAK3tnvL0N3AK78zwZVLP7ycujGeEHhmyuM6VG+LQd3GRg5CtbA@mail.gmail.com>
 <878q5wvwh6.fsf@pond.sub.org>
In-Reply-To: <878q5wvwh6.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 24 Aug 2026 17:19:49 +0800
X-Gm-Features: AcwNN1X4koTfhjqjE_VbHYDOiFldHxLUNdC8U-pL5VVckccIqRTnPQPeulonSbk
Message-ID: <CAK3tnvLAcR9j5UkMFE7f+Kc09eGaWG5v4feHMxqTfM8=jFmcbA@mail.gmail.com>
Subject: Re: [PATCH V12 13/15] monitor/hmp: display IOThread holders
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x629.google.com
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

On Mon, Aug 24, 2026 at 3:24=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Thu, Aug 20, 2026 at 4:17=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Display holder information in info iothreads to aid manual debugging=
.
> >> > Omit the holders line when an IOThread has no holders.
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > ---
> >> >  monitor/hmp-cmds.c | 21 +++++++++++++++++++++
> >> >  1 file changed, 21 insertions(+)
> >> >
> >> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> >> > index e9fb8d827a..41a813e79f 100644
> >> > --- a/monitor/hmp-cmds.c
> >> > +++ b/monitor/hmp-cmds.c
> >> > @@ -240,11 +240,32 @@ void hmp_info_iothreads(Monitor *mon, const QD=
ict *qdict)
> >> >      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
> >> >      IOThreadInfoList *info;
> >> >      IOThreadInfo *value;
> >> > +    IOThreadHolderList *h;
> >> >
> >> >      for (info =3D info_list; info; info =3D info->next) {
> >> >          value =3D info->value;
> >> >          monitor_printf(mon, "%s:\n", value->id);
> >> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->t=
hread_id);
> >> > +        monitor_printf(mon, "  holders=3D");
> >> > +        for (h =3D value->holders; h; h =3D h->next) {
> >> > +            IOThreadHolder *holder =3D h->value;
> >> > +
> >> > +            switch (holder->type) {
> >> > +            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> >> > +                monitor_printf(mon, "[block-export: %s]",
> >> > +                               holder->u.block_export.export_id);
> >> > +                break;
> >> > +            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> >> > +                monitor_printf(mon, "[qom-path: %s]",
> >> > +                               holder->u.qom_object.qom_path);
> >> > +                break;
> >> > +            default:
> >> > +                monitor_printf(mon, "[unknown]");
> >> > +                break;
> >>
> >> This is unreachable.  Please use
> >>
> >>                default:
> >>                    g_assert_not_reached();
> >>
> >> to make it obvious.
> >>
> >> > +            }
> >> > +        }
> >> > +        monitor_printf(mon, "\n");
> >> > +
> >> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value-=
>poll_max_ns);
> >> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->p=
oll_grow);
> >> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value-=
>poll_shrink);
> >>
> >> Quick test:
> >>
> >>     $ qemu-system-x86_64 -S -nodefaults -display none -chardev socket,=
id=3Dchr-qmp,path=3Dtest-qmp,server=3Don,wait=3Doff -object monitor-qmp,id=
=3Dqmp,chardev=3Dchr-qmp -monitor stdio
> >>     QEMU 11.1.50 monitor - type 'help' for more information
> >>     (qemu) info iothreads
> >>     (qemu) q
> >>
> >> Hmm, no output?  The QMP monitor should be holding the monitor I/O
> >> thread.  To confirm that, I made monitor_complete() print things (patc=
h
> >> appended), and got
> >>
> >>     ### monitor qmp holding iothread mon_iothread
> >>     ### monitor compat_monitor0 without iothread
> >>
> >> What's going on here?
> >>
> >
> > This is expected with the existing query-iothreads behavior.
> > mon_iothread is created under the internal object root, while
> > qmp_query_iothreads() only walks /objects, so internal IOThreads are
> > intentionally not exposed through QMP/HMP.
>
> TIL about the internal object root.  It's the root of a *second* QOM
> composition tree.  I have been operating under the assumnption there is
> just one.
>
> Your series adds holder tracking for any I/O thread, whether it's in the
> externally visible QOM composition tree (the one returned by
> object_get_root()) or the internal one (the one returned by
> object_get_internal_root()).  Makes sense, because at the place where we
> track we don't want to know / make assumptions about which tree it is.
>
> query-iothreads shows only the I/O threads in the externally visible QOM
> composition tree.  Makes sense.
>
> Fortunately, you were able to eliminate the special case for monitors.
> If it was still there, the query-iothreads code to show it would be
> dead.
>
> Back to what got us there.  My attempt to test query-iothreads showing
> holders failed, because monitors are not usable for this test.  Please
> show me how to test this.  Ideally, a simple command line and a few
> simple monitor commands ending with a query-iothreads that shows
> holders.
>

Thanks. Here is a reproducer that also exercises holder removal and
registration by another device type:

$ qemu-system-x86_64 \
    -S -nodefaults -display none \
    -object iothread,id=3Diothread0 \
    -blockdev driver=3Dnull-co,node-name=3Dnull0 \
    -qmp stdio

First, hotplug a virtio-scsi device and query the IOThread:
{"execute":"qmp_capabilities"}
{"execute":"query-iothreads"}

{"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
"aio-max-batch": 0, "poll-grow": 2, "holders": [], "poll-max-ns":
32768, "id": "iothread0"}]}

{"execute":"device_add","arguments":{"driver":"virtio-scsi-pci","id":"scsi0=
","iothread":"iothread0"}}
{"execute":"query-iothreads"}

{"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
"aio-max-batch": 0, "poll-grow": 2, "holders": [{"qom-path":
"/machine/peripheral/scsi0/virtio-backend", "type": "qom-object"}],
"poll-max-ns": 32768, "id": "iothread0"}]}

 The result contains:
  > "holders": [

Remove the device:

{"execute":"device_del","arguments":{"id":"scsi0"}}
{"return": {}}

{"execute":"query-iothreads"}
{"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
"aio-max-batch": 0, "poll-grow": 2, "holders": [], "poll-max-ns":
32768, "id": "iothread0"}]}

And use the HMP is the same logic, just need change the "-qmp" to "-monitor=
":
$ qemu-system-x86_64 \
    -S -nodefaults -display none \
    -object iothread,id=3Diothread0 \
    -blockdev driver=3Dnull-co,node-name=3Dnull0 \
    -monitor stdio

(qemu) info iothreads
iothread0:
  thread_id=3D4005900
  holders=3D
  poll-max-ns=3D32768
  poll-grow=3D2
  poll-shrink=3D2
  poll-weight=3D3
  aio-max-batch=3D0

.......


Thanks
Chen

> > I prefer to preserve that behavior in this series, since exposing inter=
nal
> > IOThreads would require additional API decisions, including handling ID
> > collisions with user-created IOThreads.
>
> Okay!
>
> > I=E2=80=99ll also change the unreachable default case to
> > g_assert_not_reached().
> >
> > Thanks
> > Chen
>
> [...]
>

