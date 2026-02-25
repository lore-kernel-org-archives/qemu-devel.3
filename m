Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF829EF5862
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8Ff-0007f3-O0; Wed, 25 Feb 2026 01:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vv8Fc-0007eB-3t
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vv8FZ-0003NK-2c
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772000395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmsq/4IzSa6slfXoYPqpq5H9JcIwv00j/sRc/swtVUE=;
 b=gbPyr9SSG7OLAOvbBA1ejz08tyNlcA4c6EYi01qWOEg1KG09ZpLkkSde5ayEpadaIonwcc
 Alm3l8gL7CY+VA4EYBraUjw3VmVlY0QCV3pQBUkmsnk2WW5Qed6utgBm7bNj2YwY03nyW4
 3dIyASuWO6jZekybKXJpZBntss2pDv8=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-R871MuW9Ocq8j8hnT3dnEA-1; Wed, 25 Feb 2026 01:19:53 -0500
X-MC-Unique: R871MuW9Ocq8j8hnT3dnEA-1
X-Mimecast-MFC-AGG-ID: R871MuW9Ocq8j8hnT3dnEA_1772000393
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-94de3e732f6so5432814241.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 22:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772000393; cv=none;
 d=google.com; s=arc-20240605;
 b=P7ikG+g4nVoMyhXQc7g4w6ngs+32274E8lDhAfw4XXuQNKSvYap0YY7tSpC++y/4qB
 OeMzUrH5vKfgDDeW8uS38zhnt0q0vMT/4uUQHXI3pWdTD628YOyI592ZtzLg8gFIUtQS
 7tblDNtKnru6UsDLHPJksDXeEm+rVHo4mTnmD39EnGyFjx2IlNJFODpfxwVlA1BJ51/S
 MxkDkx480u229Npj98y6Pz12G/jjP1BtYJm2+DBiqZypn3j/T+Sx+CUi8mP+foiXflwR
 zUwaeGmlE/AlRKK3dhzPF7dFxigk0Hlx1tBddJjetJIExqo2ToFobiUxaZWnjbJDDzoe
 BX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pmsq/4IzSa6slfXoYPqpq5H9JcIwv00j/sRc/swtVUE=;
 fh=41u6wkwhhWtXJ4kXPqknfOC7tvwWmAhOzst29ZF90dA=;
 b=O5ApwzEtwWOEVp5GQlcxF8pn/0AGn2VUDe/WIblWvNpFzL2Txe9rkVkgU2avispT7O
 lNMO638QcaGfjil83e3aMMwoiDvL2DXL4jktCap/xAUffbC0Ko0d1GT9VDRy/YC0gJ3e
 OIyXDAPFNDQMoiFnIRh+ctt657H3a5IlxVLDXlrM1CaCUIH54cxSOAF5lWkuQHE9HWV7
 7M4RRNtqACKjekk58gqd2kFZCG4OEAF4lzz421Vwg8zWjhFWBMunTHG41pFdPxTQimFd
 a/Yzt005kcNG//0JuzuydAOj7mxwm38Ti4t+DRFAS6NmpPGHDG+5Dqm8ZNuiIOj5qTg3
 3KkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772000393; x=1772605193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmsq/4IzSa6slfXoYPqpq5H9JcIwv00j/sRc/swtVUE=;
 b=pRqhCz64xTikXDvSXa5MkIVB9BrVwiyRyIO5rv4ofNn+spD0qWDhb8JHbytkhJ+n+A
 JOHqlceV2KfGEbv3KirBA27yCw/b+tmcjHfV4aKi0j9n3W0zC/8PivQaCE5g8rO3pWHU
 zIsfsDCswS9hNd8nsM5pA+WWVua/sfvXCOmtw9aPw6n20ZMFcYl7Y9oFuHHsjprMiptU
 V74YcygMx9IwRAJi3cHRKMa31r7+KUNY4WM0nwx9EX2s9JabBw5487qTSvI0wHI61ilD
 uzJwWliuY+m/qxSR3lmLHl0DYaF2/GkiLuqekIJv+QYSMiVRShB5QJMdxbe51u7OXING
 +Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772000393; x=1772605193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmsq/4IzSa6slfXoYPqpq5H9JcIwv00j/sRc/swtVUE=;
 b=ViWQmwa5OouiZfIRgBbh+v72sENtA8CGqqLzpcvRF1aGwitkml3yNrR76RHA+bJQXe
 V2zvrZiXa3wS9FNEMUz0IfLIG1iTeQ9DTpMuN31PF06cMMh6d5ErXviGVEP9wqGjuXDq
 GY50V6O6pmVCw7eBUjO7vy+IaMq0Uh+Qo2uMmVlfhx73BkkQnB2+Nmx8QFe+bsvDmfx/
 Ymt41O4kaw9I75CfLtqWlc4dVkHifHYADWkXT7oz/4CTkXOHI5l5GJbu1ScHtJWFMwws
 0dHX/4iq6JjxTNmXd9mgFLXBFf1PZ58VMo4/J4m0/ZVqPnxnFvTozNyeziF7d7VxUZDq
 Xazw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5Hee379ctwUyJdPQKKb4KJ3y7vHuRlpMq/SQX8PheKxYor1OqgG+wbsN1v9M4D+SsBLjkiLS8MMv@nongnu.org
X-Gm-Message-State: AOJu0Ywopxgx1ygl1gqeFPTaG6fACE+xNH4j7x+BklWXzwEprqJQKABF
 Hep3hpYOGH59HSKZVgU8M9opsmDEs94mucGO0YW2IHDUT04eZ6XdmgOIf4omQqjTEPOkfgxazuo
 eJS/9G9s+vfB08WfwbaxmeYReiBaTSmP6Qd4kP7P9Eswpu5Vp8UUbz5HWYghjSosvZt30kAnVu7
 6N3S9wwxVb2AU2qHHEbrLSKs8IXS6ffyo=
X-Gm-Gg: ATEYQzw+R0jylqXFM4vEAhVOdRaIJbJOyKfO8YfRFiVLTMi2OF7OFIpn0FSTFLhruzD
 Hu1rXiTqgBFoGUcBs90/m6+j7pRq0+YmQYB+O36Ir1ww1T3gJhVbbb/n6VxuwEVCLMMhJv/b/ps
 M9TL66BG5j8UTi2phKJj1rO9MRHqVoV99JD5Cqnd9qYCoSTDOw765fHOV2nTxb2zwSZsg1jRxHQ
 3cI6jg=
X-Received: by 2002:a05:6102:a4c:b0:5fd:e97c:e40e with SMTP id
 ada2fe7eead31-5feb307ab69mr7554439137.22.1772000392817; 
 Tue, 24 Feb 2026 22:19:52 -0800 (PST)
X-Received: by 2002:a05:6102:a4c:b0:5fd:e97c:e40e with SMTP id
 ada2fe7eead31-5feb307ab69mr7554428137.22.1772000392418; Tue, 24 Feb 2026
 22:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20260207134728.1495932-1-lulu@redhat.com>
 <20260207134728.1495932-2-lulu@redhat.com>
 <CAK3tnvKxsumtqbF6z6_3v5jWWwAeUg4sdYsXNY9Jha9tXYR6ag@mail.gmail.com>
In-Reply-To: <CAK3tnvKxsumtqbF6z6_3v5jWWwAeUg4sdYsXNY9Jha9tXYR6ag@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 25 Feb 2026 14:18:59 +0800
X-Gm-Features: AaiRm51Vo7WIwLRYI_wpetucxLlxSiOjojY5ecDLLe7JoJ0bBv1UoiFP9SNcRZY
Message-ID: <CACLfguV53qhomyXffUQU2PACs3+EwYnPXCgnQcNdsFbgYnooTA@mail.gmail.com>
Subject: Re: [PATCH 02/12] net/filter-mirror: add enable_when_stopped option
 for filter-redirector
To: Zhang Chen <zhangckid@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 14, 2026 at 10:46=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> w=
rote:
>
> On Sat, Feb 7, 2026 at 9:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Jason Wang <jasowang@redhat.com>
> >
> > Add a QAPI option 'enable_when_stopped' for filter-redirector that
> > allows it to continue receiving data from netdev when VM is stopped.
> >
> > When enabled, a VM state change handler activates the netdev's
> > read_poll() when VM stops, allowing the netdev to continue reading
> > data and passing it through filter-redirector to the chardev output.
> >
> > This is useful for scenarios where filter-redirector needs to
> > process network traffic even when the VM is paused.
> >
> > Usage:
> >   -object filter-redirector,id=3Df0,netdev=3Dnet0,queue=3Dtx,\
> >           outdev=3Dchardev0,enable_when_stopped=3Dtrue
> >
>
> It seems this series is trying to address previous VM migration network
> related issues that Juraj Marcin mentioned.
> Add CC to him.
>
> I've taken a quick look, and this series lacks support for
> filter-reply and filter-rewriter.
> Could there be a reason for this?
>
> Thanks
> Chen
>
Hi Chen
For this RFC, filter-reply and filter-rewriter is not need, I will add
support for them later.
Thanks
cindy
> .
>
>
>
>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  net/filter-mirror.c                  |  38 ++++++++++
> >  qapi/qom.json                        |   7 +-
> >  tests/qtest/test-filter-redirector.c | 106 +++++++++++++++++++++++++++
> >  3 files changed, 150 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > index aa2ab452fd..e1a0650abd 100644
> > --- a/net/filter-mirror.c
> > +++ b/net/filter-mirror.c
> > @@ -21,6 +21,7 @@
> >  #include "qemu/iov.h"
> >  #include "qemu/sockets.h"
> >  #include "block/aio-wait.h"
> > +#include "system/runstate.h"
> >
> >  #define TYPE_FILTER_MIRROR "filter-mirror"
> >  typedef struct MirrorState MirrorState;
> > @@ -41,6 +42,8 @@ struct MirrorState {
> >      CharFrontend chr_out;
> >      SocketReadState rs;
> >      bool vnet_hdr;
> > +    bool enable_when_stopped;
> > +    VMChangeStateEntry *vmsentry;
> >  };
> >
> >  typedef struct FilterSendCo {
> > @@ -251,6 +254,7 @@ static void filter_redirector_cleanup(NetFilterStat=
e *nf)
> >
> >      qemu_chr_fe_deinit(&s->chr_in, false);
> >      qemu_chr_fe_deinit(&s->chr_out, false);
> > +    qemu_del_vm_change_state_handler(s->vmsentry);
> >  }
> >
> >  static void filter_mirror_setup(NetFilterState *nf, Error **errp)
> > @@ -282,6 +286,18 @@ static void redirector_rs_finalize(SocketReadState=
 *rs)
> >      redirector_to_filter(nf, rs->buf, rs->packet_len);
> >  }
> >
> > +static void filter_redirector_vm_state_change(void *opaque, bool runni=
ng,
> > +                                              RunState state)
> > +{
> > +    NetFilterState *nf =3D opaque;
> > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > +    NetClientState *nc =3D nf->netdev;
> > +
> > +    if (!running && s->enable_when_stopped && nc->info->read_poll) {
> > +        nc->info->read_poll(nc, true);
> > +    }
> > +}
> > +
> >  static void filter_redirector_setup(NetFilterState *nf, Error **errp)
> >  {
> >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > @@ -331,6 +347,9 @@ static void filter_redirector_setup(NetFilterState =
*nf, Error **errp)
> >              return;
> >          }
> >      }
> > +
> > +    s->vmsentry =3D qemu_add_vm_change_state_handler(
> > +        filter_redirector_vm_state_change, nf);
> >  }
> >
> >  static void filter_redirector_status_changed(NetFilterState *nf, Error=
 **errp)
> > @@ -437,6 +456,22 @@ static void filter_redirector_set_vnet_hdr(Object =
*obj,
> >      s->vnet_hdr =3D value;
> >  }
> >
> > +static bool filter_redirector_get_enable_when_stopped(Object *obj, Err=
or **errp)
> > +{
> > +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > +
> > +    return s->enable_when_stopped;
> > +}
> > +
> > +static void filter_redirector_set_enable_when_stopped(Object *obj,
> > +                                                      bool value,
> > +                                                      Error **errp)
> > +{
> > +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > +
> > +    s->enable_when_stopped =3D value;
> > +}
> > +
> >  static void filter_mirror_class_init(ObjectClass *oc, const void *data=
)
> >  {
> >      NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
> > @@ -463,6 +498,9 @@ static void filter_redirector_class_init(ObjectClas=
s *oc, const void *data)
> >      object_class_property_add_bool(oc, "vnet_hdr_support",
> >                                     filter_redirector_get_vnet_hdr,
> >                                     filter_redirector_set_vnet_hdr);
> > +    object_class_property_add_bool(oc, "enable_when_stopped",
> > +                                   filter_redirector_get_enable_when_s=
topped,
> > +                                   filter_redirector_set_enable_when_s=
topped);
> >
> >      nfc->setup =3D filter_redirector_setup;
> >      nfc->cleanup =3D filter_redirector_cleanup;
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 6f5c9de0f0..b1fe55944c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -488,13 +488,18 @@
> >  # @vnet_hdr_support: if true, vnet header support is enabled
> >  #     (default: false)
> >  #
> > +# @enable_when_stopped: if true, activate netdev's read poll when VM
> > +#     stops to allow filter-redirector to continue receiving data
> > +#     (default: false)
> > +#
> >  # Since: 2.6
> >  ##
> >  { 'struct': 'FilterRedirectorProperties',
> >    'base': 'NetfilterProperties',
> >    'data': { '*indev': 'str',
> >              '*outdev': 'str',
> > -            '*vnet_hdr_support': 'bool' } }
> > +            '*vnet_hdr_support': 'bool',
> > +            '*enable_when_stopped': 'bool' } }
> >
> >  ##
> >  # @FilterRewriterProperties:
> > diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-fi=
lter-redirector.c
> > index 5540c232c0..fa958bb0a5 100644
> > --- a/tests/qtest/test-filter-redirector.c
> > +++ b/tests/qtest/test-filter-redirector.c
> > @@ -385,6 +385,110 @@ static void test_redirector_init_status_off(void)
> >      qtest_quit(qts);
> >  }
> >
> > +/*
> > + * Test filter-redirector works when VM is stopped (TX direction).
> > + *
> > + * This test verifies that when VM is stopped, the filter-redirector
> > + * can still receive data from the netdev because the VM state change
> > + * handler activates the netdev's read_poll(). Data flows from netdev
> > + * to filter-redirector and out through the chardev.
> > + *
> > + * Data flow: backend_sock -> netdev (read_poll) -> filter-redirector =
-> chardev
> > + */
> > +static void test_redirector_with_vm_stop(void)
> > +{
> > +    int backend_sock[2], recv_sock;
> > +    uint32_t ret =3D 0, len =3D 0;
> > +    char send_buf[] =3D "Hello!!";
> > +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> > +    char *recv_buf;
> > +    uint32_t size =3D sizeof(send_buf);
> > +    size =3D htonl(size);
> > +    QTestState *qts;
> > +    struct timeval tv;
> > +    fd_set rfds;
> > +
> > +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> > +    g_assert_cmpint(ret, !=3D, -1);
> > +
> > +    ret =3D mkstemp(sock_path0);
> > +    g_assert_cmpint(ret, !=3D, -1);
> > +
> > +    /*
> > +     * Setup TX path: netdev -> filter-redirector -> chardev
> > +     * Data sent to backend_sock[0] will be read by the netdev,
> > +     * passed through filter-redirector, and output to sock_path0.
> > +     * Enable enable_when_stopped to activate read_poll when VM stops.
> > +     */
> > +    qts =3D qtest_initf(
> > +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> > +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=
=3Doff "
> > +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
> > +        "queue=3Dtx,outdev=3Dredirector0,enable_when_stopped=3Dtrue ",
> > +        backend_sock[1], sock_path0);
> > +
> > +    recv_sock =3D unix_connect(sock_path0, NULL);
> > +    g_assert_cmpint(recv_sock, !=3D, -1);
> > +
> > +    /* Ensure connection is established */
> > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> > +
> > +    struct iovec iov[] =3D {
> > +        {
> > +            .iov_base =3D &size,
> > +            .iov_len =3D sizeof(size),
> > +        }, {
> > +            .iov_base =3D send_buf,
> > +            .iov_len =3D sizeof(send_buf),
> > +        },
> > +    };
> > +
> > +    /*
> > +     * Stop the VM - this triggers our vm_state_change handler
> > +     * which should activate the netdev's read_poll()
> > +     */
> > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'stop'}");
> > +
> > +    /* Wait for VM to actually stop */
> > +    qtest_qmp_eventwait(qts, "STOP");
> > +
> > +    /*
> > +     * Send data to backend socket while VM is stopped.
> > +     * The netdev should still read the data (because read_poll is
> > +     * activated by our vm_state_change handler), pass it through
> > +     * filter-redirector, and output to the chardev.
> > +     */
> > +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof=
(send_buf));
> > +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> > +
> > +    /*
> > +     * Data should arrive at recv_sock even with VM stopped,
> > +     * because read_poll is activated.
> > +     */
> > +    FD_ZERO(&rfds);
> > +    FD_SET(recv_sock, &rfds);
> > +    tv.tv_sec =3D 5;
> > +    tv.tv_usec =3D 0;
> > +    ret =3D select(recv_sock + 1, &rfds, NULL, NULL, &tv);
> > +    g_assert_cmpint(ret, =3D=3D, 1);  /* Data should arrive */
> > +
> > +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> > +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> > +    len =3D ntohl(len);
> > +
> > +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> > +    recv_buf =3D g_malloc(len);
> > +    ret =3D recv(recv_sock, recv_buf, len, 0);
> > +    g_assert_cmpint(ret, =3D=3D, len);
> > +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> > +
> > +    g_free(recv_buf);
> > +    close(recv_sock);
> > +    close(backend_sock[0]);
> > +    unlink(sock_path0);
> > +    qtest_quit(qts);
> > +}
> > +
> >  static void test_redirector_rx_event_opened(void)
> >  {
> >      int backend_sock[2], send_sock;
> > @@ -489,5 +593,7 @@ int main(int argc, char **argv)
> >                     test_redirector_init_status_off);
> >      qtest_add_func("/netfilter/redirector_rx_event_opened",
> >                     test_redirector_rx_event_opened);
> > +    qtest_add_func("/netfilter/redirector_with_vm_stop",
> > +                   test_redirector_with_vm_stop);
> >      return g_test_run();
> >  }
> > --
> > 2.52.0
> >
>


