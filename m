Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3447FED2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Zai-0002rB-8z; Thu, 12 Mar 2026 02:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0Zae-0002qf-W1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:32:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0Zad-0002Rz-4q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:32:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-662ac74fd85so1022851a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 23:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773297129; cv=none;
 d=google.com; s=arc-20240605;
 b=AzBhnycfPvxMFu9E0byWfwj0qH/B83FbVrZ2PqES7YX1Is2sElsaqzMPpvUcDgFrCT
 ACxSShquoCmZx/S7zvvHOG/9GqJJork4gjXz1YznckT+L91AN9LDrIJ8bVKoWii+evsm
 XRWBzSW4UCDJtbdVuTSfyRWRa5cbbn/oOHMYgjOsIMbZkJ/Z7Ax2eJIiuP6+rPGaXQel
 10NtNVcmHJnCzKq98zytVcqg92F+l5VWixljHk28wIWbL0Of6mlmszvaCPdxwDg4vlxz
 gVv90ftaFdsgdeEwDWMDqHUcszno0COrTI4MoYbFWbYESMOI2RupUa1So7Z1Eh5PBe/U
 Yuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nEKOI9PM0rx+3wZoWCZ1k1qSH2cpB+4dFR55YDjxTLc=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=cKDJI8sQyjLcGU7+0NjSnIoMQ3LPlB/jwHm+mrAO4VVNnw1IR5SiVVWacCvxKFlmWB
 TRSIO+L4GoVeaWTVz9tHHEvIeWllu/WwlhEeaFeJrkinok5PyLCd1FMwEOtnIzSJfGZb
 bNLUS/7kPMPaL9UC5TFT69onUtzqt65+Ry6ohntXiXoq5QRdQtopQYT8lv/kIvuHVvBD
 OmibiywYYyB3ERwaGDRJ8IDNVpzkdWgMYAmsazEVPwmezSAIaTY5QFlRLY6XSbJTV3e3
 w9/Ocwp4gUrjO5vrQOEZCDAY4cuR1XMHSNjD6uaHPFFOYiiluiY/QHwoYMYftVjKvziZ
 voSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773297129; x=1773901929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEKOI9PM0rx+3wZoWCZ1k1qSH2cpB+4dFR55YDjxTLc=;
 b=ghvxEMjRlFMIt0UZNRNLKTt6lIqOS6yu/+s5TiTG+5TQ0tZdC9oVjydD65RtP1LRW0
 kZv8DZzpmaEjDgqE1UoKr7P+epuS4mtgPJdpGiA78XFGDvdIXSaVDm+vSbPQhEXAHDMv
 5hmVwe4BkPJZYD4VuGTJmHjVoJhhBwTHBJVVSsWbYZ7gLxvaVIlZUWI5vaitclmsISsi
 jPAATx6CqXENlWFYDHQgMWN3dyG+zsQFQ3bByGa+UrBJ64LTTtfhXpMMT9S0Z/sBVKD6
 3KXKEzuj8ayD1NVcFwuuyT96d3X69w1beFcCSiDHZ4Lq4bzvEPSFXwbu/n9k2kBpOg2s
 q4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773297129; x=1773901929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nEKOI9PM0rx+3wZoWCZ1k1qSH2cpB+4dFR55YDjxTLc=;
 b=QGzvjzt1NVsIUMd38GmTBTYgw185mhFlq4CLAFBCsamPg7jIt+gIzS+axFYfVnR8aT
 AYm2Z/vt9Z5I682sg/Dgf6UD2btyElVaYXaFRTPV6yfW3ASxszHR2o9Y1wLzzK2uxynE
 EpB+WESOOK9I0fB2aPg/xLRxeF0+BAhnxkfkGH6gW1jMNC9fy1AwMC3XnUEhDqxJVibD
 73zTj4iTMzD64/tSEAgJ/09ZPXEEXWpsBZkyEcc38kwu2D/cZN/7qJHijUaXwdgHowLr
 pOb21Hfwun8ovHjStpO1OxRORyunEvCm2mTiVirV/XGmhAJfbAniFeLwQ4V66MO6oKsL
 XmjQ==
X-Gm-Message-State: AOJu0Yy6E8B1k3DkmuO5uPL1seJHNY7E0rRmxnveN09cGC43nM0hFyaN
 n4pkUFZIKv06M0qhjM/553fx9RnScvYJ8lrwdvNuoFkDSflT7Hgaa4U5xLQycFmBv+J7M+wku32
 U/Fu4om92FGb8bJk5s7qge2At8LBXNOk=
X-Gm-Gg: ATEYQzx7nYoQHDdLvfPjeE3u+l2MuqQiHa6Km/MfN+NNDlKsLqconM8u6EB5njsJpU5
 XuSnwmG0f2XkRhp6d9r68Ps9Ly4Hvf64qC0HgGSTz2qfui9tdepgVfUxZUESeKsZXCrUEtrJHlt
 pIK6wCGdkOaiMoRcxhHmCSG2NpNHGk+67gNOnfXAtR+iYCy8sZwMLoQTcH8rKhPQmaWeDFWqhM+
 g1rGbnJY52lS1QjI5yj6OS1dOtW8XfeCaiat6xUbq/v/F7MhE2aR8GizP/t5r7kOuF2WcJ4llrs
 jqgJWy0=
X-Received: by 2002:a05:6402:13d2:b0:65f:ab99:2d4d with SMTP id
 4fb4d7f45d1cf-66319cc24b2mr3146364a12.19.1773297128460; Wed, 11 Mar 2026
 23:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
 <20260309084422.GG39949@fedora>
 <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
 <20260312053601.GB116604@fedora>
In-Reply-To: <20260312053601.GB116604@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 12 Mar 2026 14:31:32 +0800
X-Gm-Features: AaiRm51izpBB3PRf3lcpY9wfMIpt7M-yAi0FB5tRHaEJwmjhgwzVehGQo7ZD4EU
Message-ID: <CAK3tnvKfeKBxigGsS8B-PiBuq2w5i7Dp3sBfXzZKoaDFr4QBRw@mail.gmail.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

On Thu, Mar 12, 2026 at 1:36=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Mar 10, 2026 at 06:15:16PM +0800, Zhang Chen wrote:
> > On Mon, Mar 9, 2026 at 4:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> > >
> > > On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> > > > @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object *o=
bj)
> > > >
> > > >      qemu_bh_delete(s->event_bh);
> > > >
> > > > -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > > +    /*
> > > > +     * Use the device's canonical path as the holder ID to track I=
OThread
> > > > +     * usage and ensure the AioContext remains valid during the de=
vice's
> > > > +     * lifecycle.
> > > > +     */
> > > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL=
);
> > >
> > > Should NULL be path?
> > >
> >
> > Yes, here code in the finalize function need to waiting for the
> > coroutine to complete processing
> > Or do you have any other suggestion?
>
> I'm not sure I understand. My question was about:
>
>   AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
>                                                           ^^^^
>
> NULL is passed as the argument but this function has a 'path' local
> variable. The path variable should be passed instead of NULL.

Let me explain in detail.
colo-compare have two real holders for the iothread,
1. colo_compare_timer_init.
2. worker_context for chardev handlers.

I try to make them use one pair of iothread_get/put.

The real iothread_get with "path" is here:
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    char *path =3D object_get_canonical_path(OBJECT(s));
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread, path);
+

The real pairing iothread_put with the "path" is here:
     AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
     if (s->notify_dev) {
         AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
     }
+    iothread_put_aio_context(s->iothread, path);

     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);

Thanks
Chen



>
> Stefan

