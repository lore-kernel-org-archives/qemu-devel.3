Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C391E7AD75
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 06:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ1I6-0002fd-SY; Fri, 26 Dec 2025 01:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ1I4-0002fP-PK
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ1I1-0005P2-K3
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766730422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04EmNU2VBW9k/wrhB9TjIw/nJ/ZTBlZPCuv0qVmN2gY=;
 b=WY0DbhBgZ4AhffvYUW3SqpqxlIcBeubLds2t5bVRnMScv1nEdIiHdggn2nmA9mN7U54y4O
 i+tez7GYQonozUFZbMxA/jfUqrm+aLdrrGSxF/b7zoPwGmhPZaLA8+zEekvbZwIkKMViGR
 A8waPAOrnvzB0u4Z65UJYwtvPmKOdfQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-QctSWQImPkSgGtupJthQfw-1; Fri, 26 Dec 2025 01:27:00 -0500
X-MC-Unique: QctSWQImPkSgGtupJthQfw-1
X-Mimecast-MFC-AGG-ID: QctSWQImPkSgGtupJthQfw_1766730420
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34cc8bf226cso15909044a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 22:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766730420; x=1767335220; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04EmNU2VBW9k/wrhB9TjIw/nJ/ZTBlZPCuv0qVmN2gY=;
 b=HxOG8fhVa+xHbFDlhztCPSmn02dQfweU3KBIOon7OBwCun7QqA/SJ8XPbbgeUpoyXg
 xuyPzjHrP0djg1DpgCap8BQkNErsM3fLCTDvM6t40BqRCrfXgGsto3g8gQBCV9UIb5wi
 0EPj3b/AvfbbLg5Xfj8ZxJ/UBmbqQ8620KnMXUxUJ8j/wIFjfMm+NgozovbPvkOvWrjv
 x6yRYpafhicyPY/oM95OxsLWZl9RGyzj9fDnWxT5nYk7kRmNkhq/RbBvZhA1ONTt3ABS
 z/4/bktA5lsheaNT8HA1/RW7bOn1IT15tFv8/hxt8det2jlgOsXuP5uZOCZwb0/edReU
 DK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766730420; x=1767335220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=04EmNU2VBW9k/wrhB9TjIw/nJ/ZTBlZPCuv0qVmN2gY=;
 b=twk8VJ0SUmr1G+TLW/v/7ssoaIMQtwcPqEpfTQD8Z5MdD3lXcdg7nDuaSxR8ICGz3E
 6PUn656IbGH0YZC5Rgw8WFcm4t5eWp8xNhQgTuBu00V5lqoqha/xdhOfkjGZVVjnkXRj
 go5tDMQYSKDgBLcsBUMox52BYI/Lc61ggqnpDyatJ3GgPw37E3V3pEj1T+p3y04J9bGz
 AgCHG2+aw8okRcrJkaF4cxtMNleupo8fCDSi9WVgtmFrN/wzo5CbZ5LbmE1gG9Qvagv/
 +y2jjCNpIkYeo1+hSBUNp7Zx+RjM/+4DV9ji4ESLP6sZXQWyUyeaAmi17wJ/fuvMASDp
 gqXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv26NkVW9NvSipOiJNcwJtuMjtKSd1RI3gpKXoyluPVlZsqYA7l/N0Rm0n9aObcWDI4NyaDJLUaIst@nongnu.org
X-Gm-Message-State: AOJu0YyT09WN6KOjcUoaeyCwPx1+wAuYjW+RcGEkMDU0N5W/oUEOJdDw
 PP8YOA0hxCXAAGLVICz+o0WG8cW2v9mvsJGKhWkTSwTKjxCEg+m7swXppEVbn4zLcjXWNMOThRx
 TEPLjrGSauf9HPET7RjEzY/fAjkYicpKXjyYcuomi1AhPRu7YrIETbQLcSWJ3kQII1K2jkjdcRm
 jogCFb1RoGoYZBKQQEWbSorvKDaYW2k/Y=
X-Gm-Gg: AY/fxX4QcuN7YrFbmNduRQxnjeUtYtCfZfPq6VVVaHc0sccjG04IlDZLUhmUXX4swhT
 kBRnddCVyQk+sEm11ZCFnolQN6MSbxyjrea1EKV8Mphn4/3n0A/N9vrW1QM8XRw+QvP+/ova+X7
 /R7CGB+JCIh9Y96b1sEdH8+A98HCzL3GUaYwGLIEI5q7YiijFOVBctw6ed2fYGj35Aboo=
X-Received: by 2002:a17:90b:2ecc:b0:343:eb40:8dca with SMTP id
 98e67ed59e1d1-34e921a3dd3mr18675295a91.19.1766730419697; 
 Thu, 25 Dec 2025 22:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAzGFUs/BVu4mwR9r7Q3uw2EA+OFhrdOoefMwQ5lzU5OmuyrENpvIBupKUsjDvOdY9VCn95Ew9JIcMncLXpao=
X-Received: by 2002:a17:90b:2ecc:b0:343:eb40:8dca with SMTP id
 98e67ed59e1d1-34e921a3dd3mr18675283a91.19.1766730419190; Thu, 25 Dec 2025
 22:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
 <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
In-Reply-To: <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 14:26:48 +0800
X-Gm-Features: AQt7F2oN6Ic_dXhxitxmuutZYqJv13ZZnuCcahAFt0m6SqJs1Q_Eru79TllP0G4
Message-ID: <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Zhang Chen <zhangckid@gmail.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 26, 2025 at 11:15=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> w=
rote:
>
> On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gmail.com=
> wrote:
> > >
> > > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > Add test_change_interval_timer to verify that modifying the 'interv=
al'
> > > > property of filter-buffer at runtime takes effect immediately.
> > > >
> > > > The test uses socket backend and filter-redirector to verify timer =
behavior:
> > > > - Creates filter-buffer with a very long interval (1000 seconds)
> > > > - Sends a packet which gets buffered
> > > > - Advances virtual clock by 1 second, verifies packet is still buff=
ered
> > > > - Changes interval to 1ms via qom-set (timer should be rescheduled)
> > > > - Advances virtual clock by 2ms, verifies packet is now released
> > > > - This proves the timer was rescheduled immediately when interval c=
hanged
> > > >
> > > > The test uses filter-redirector to observe when packets are release=
d
> > > > by filter-buffer, providing end-to-end verification of the timer
> > > > rescheduling behavior.
> > >
> > > If user try to simulate network latency by filter-buffer, the accurac=
y
> > > of time is important.
> > > Do we need add some note about the first buffered packet time not
> > > equel to dynamic
> > > changed time (default interval time - new qmp cmd effected time +
> > > changed time ?).
> >
> > I'm not sure I will get here, we can't forcast when the first packet
> > will come. So the behaviour is always that the filter-buffer will
> > flush at a fixed interval. Or I may miss something here.
>
> This case same like this test, before change the user target interval tim=
e,
> filter-buffer maybe already buffered lots of packets, for this parts, the=
 user
> external measured time did not meet the expected settings.

There's indeed a change of the behaviour, but I'm not sure if there's
a user that depends on the previous behaviour.

Or if we really care, we need a new attribute.

>
> >
> > >
> > > Another issue is what level of stable accuracy the QEMU filter-buffer
> > > can be achieved in actual testing?
> >
> > We use qemu_clock_get_us() so it's the us actually?
>
> Yes, this is our expectation, but in actual operation, there may be
> many interferences.
> For example user setup filter-buffer interval to 100us, even on the
> same physical machine
> host to guest, external client may get test result as 110us(like ping).

Yes, but this topic is somehow out of the scope of this patch. It
require the support of the timer and probably some realtime support in
the qemu timer.

>
>
> >
> > > Maybe need to tell user recommended test range?
> >
> > Could you elaborate more on this?
>
> Based on the above statement, is it necessary to provide an empirical val=
ue
> for the time range, such as 10us(like 100us --> 110us)?

It's better not since it could easily run out of sync with the
behaviour of the code.

Thanks

>
> Thanks
> Chen
>
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > > Chen
> > >
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  tests/qtest/meson.build          |   1 +
> > > >  tests/qtest/test-filter-buffer.c | 169 +++++++++++++++++++++++++++=
++++
> > > >  tests/qtest/test-netfilter.c     |   3 +
> > > >  3 files changed, 173 insertions(+)
> > > >  create mode 100644 tests/qtest/test-filter-buffer.c
> > > >
> > > > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > > > index 669d07c06b..ffa85ba984 100644
> > > > --- a/tests/qtest/meson.build
> > > > +++ b/tests/qtest/meson.build
> > > > @@ -46,6 +46,7 @@ qtests_cxl =3D \
> > > >  #        for the availability of the default NICs in the tests
> > > >  qtests_filter =3D \
> > > >    (get_option('default_devices') and slirp.found() ? ['test-netfil=
ter'] : []) + \
> > > > +  (get_option('default_devices') and host_os !=3D 'windows' ? ['te=
st-filter-buffer'] : []) + \
> > > >    (get_option('default_devices') and host_os !=3D 'windows' ? ['te=
st-filter-mirror'] : []) + \
> > > >    (get_option('default_devices') and host_os !=3D 'windows' ? ['te=
st-filter-redirector'] : [])
> > > >
> > > > diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-fi=
lter-buffer.c
> > > > new file mode 100644
> > > > index 0000000000..441cbb975c
> > > > --- /dev/null
> > > > +++ b/tests/qtest/test-filter-buffer.c
> > > > @@ -0,0 +1,169 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +/*
> > > > + * QTest testcase for filter-buffer
> > > > + *
> > > > + * Copyright (c) 2025 Red Hat, Inc.
> > > > + * Author: Jason Wang <jasowang@redhat.com>
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "libqtest.h"
> > > > +#include "qobject/qdict.h"
> > > > +#include "qemu/iov.h"
> > > > +#include "qemu/sockets.h"
> > > > +
> > > > +/*
> > > > + * Test that changing interval at runtime affects packet release t=
iming.
> > > > + *
> > > > + * Traffic flow with filter-buffer and filter-redirector:
> > > > + *
> > > > + * test side                        | qemu side
> > > > + *                                  |
> > > > + * +--------+                       | +---------+
> > > > + * |  send  +------------------------>| backend |
> > > > + * | sock[0]|                       | +----+----+
> > > > + * +--------+                       |      |
> > > > + *                                  | +----v----+
> > > > + *                                  | |  fbuf0  | filter-buffer (q=
ueue=3Dtx)
> > > > + *                                  | +----+----+
> > > > + *                                  |      |
> > > > + *                                  | +----v----+  +----------+
> > > > + *                                  | |   rd0   +->| chardev0 |
> > > > + *                                  | +---------+  +----+-----+
> > > > + *                                  |                   |
> > > > + * +--------+                       |                   |
> > > > + * |  recv  |<--------------------------------------+
> > > > + * |  sock  |                       |
> > > > + * +--------+                       |
> > > > + *
> > > > + * The test verifies that when interval is changed via qom-set, th=
e timer
> > > > + * is rescheduled immediately, causing buffered packets to be rele=
ased
> > > > + * at the new interval rather than waiting for the old interval to=
 elapse.
> > > > + */
> > > > +static void test_change_interval_timer(void)
> > > > +{
> > > > +    QTestState *qts;
> > > > +    QDict *response;
> > > > +    int backend_sock[2], recv_sock;
> > > > +    int ret;
> > > > +    char send_buf[] =3D "Hello filter-buffer!";
> > > > +    char recv_buf[128];
> > > > +    char sock_path[] =3D "filter-buffer-test.XXXXXX";
> > > > +    uint32_t size =3D sizeof(send_buf);
> > > > +    uint32_t len;
> > > > +
> > > > +    size =3D htonl(size);
> > > > +
> > > > +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> > > > +    g_assert_cmpint(ret, !=3D, -1);
> > > > +
> > > > +    ret =3D mkstemp(sock_path);
> > > > +    g_assert_cmpint(ret, !=3D, -1);
> > > > +
> > > > +    /*
> > > > +     * Start QEMU with:
> > > > +     * - socket backend connected to our socketpair
> > > > +     * - filter-buffer with a very long interval (1000 seconds)
> > > > +     * - filter-redirector to send released packets to a chardev s=
ocket
> > > > +     *
> > > > +     * queue=3Dtx intercepts packets going from backend to the gue=
st,
> > > > +     * i.e., data we send from the test side.
> > > > +     */
> > > > +    qts =3D qtest_initf(
> > > > +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> > > > +        "-chardev socket,id=3Dchardev0,path=3D%s,server=3Don,wait=
=3Doff "
> > > > +        "-object filter-buffer,id=3Dfbuf0,netdev=3Dqtest-bn0,"
> > > > +        "queue=3Dtx,interval=3D1000000000 "
> > > > +        "-object filter-redirector,id=3Drd0,netdev=3Dqtest-bn0,"
> > > > +        "queue=3Dtx,outdev=3Dchardev0",
> > > > +        backend_sock[1], sock_path);
> > > > +
> > > > +    /* Connect to the chardev socket to receive redirected packets=
 */
> > > > +    recv_sock =3D unix_connect(sock_path, NULL);
> > > > +    g_assert_cmpint(recv_sock, !=3D, -1);
> > > > +
> > > > +    /* Send a QMP command to ensure chardev connection is establis=
hed */
> > > > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}")=
;
> > > > +
> > > > +    /*
> > > > +     * Send a packet from the test side.
> > > > +     * It should be buffered by filter-buffer.
> > > > +     */
> > > > +    struct iovec iov[] =3D {
> > > > +        {
> > > > +            .iov_base =3D &size,
> > > > +            .iov_len =3D sizeof(size),
> > > > +        }, {
> > > > +            .iov_base =3D send_buf,
> > > > +            .iov_len =3D sizeof(send_buf),
> > > > +        },
> > > > +    };
> > > > +
> > > > +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + si=
zeof(send_buf));
> > > > +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> > > > +
> > > > +    /*
> > > > +     * Advance virtual clock by 1 second (1,000,000,000 ns).
> > > > +     * This is much less than the 1000 second interval, so the pac=
ket
> > > > +     * should still be buffered.
> > > > +     */
> > > > +    qtest_clock_step(qts, 1000000000LL);
> > > > +
> > > > +    /* Try to receive with non-blocking - should fail (packet stil=
l buffered) */
> > > > +    ret =3D recv(recv_sock, recv_buf, sizeof(recv_buf), MSG_DONTWA=
IT);
> > > > +    g_assert_cmpint(ret, =3D=3D, -1);
> > > > +    g_assert(errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK);
> > > > +
> > > > +    /*
> > > > +     * Now change the interval to 1000 us (1ms) via qom-set.
> > > > +     * This should reschedule the timer to fire in 1ms from now.
> > > > +     */
> > > > +    response =3D qtest_qmp(qts,
> > > > +                         "{'execute': 'qom-set',"
> > > > +                         " 'arguments': {"
> > > > +                         "   'path': 'fbuf0',"
> > > > +                         "   'property': 'interval',"
> > > > +                         "   'value': 1000"
> > > > +                         "}}");
> > > > +    g_assert(response);
> > > > +    g_assert(!qdict_haskey(response, "error"));
> > > > +    qobject_unref(response);
> > > > +
> > > > +    /*
> > > > +     * Advance virtual clock by 2ms (2,000,000 ns).
> > > > +     * This exceeds the new 1ms interval, so the timer should fire
> > > > +     * and release the buffered packet.
> > > > +     *
> > > > +     * If the interval change didn't take effect immediately, we w=
ould
> > > > +     * still be waiting for the original 1000 second interval to e=
lapse,
> > > > +     * and the packet would not be released.
> > > > +     */
> > > > +    qtest_clock_step(qts, 2000000LL);
> > > > +
> > > > +    /*
> > > > +     * Now we should be able to receive the packet through the red=
irector.
> > > > +     * The packet was released by filter-buffer and sent to filter=
-redirector,
> > > > +     * which forwarded it to the chardev socket.
> > > > +     */
> > > > +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> > > > +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> > > > +    len =3D ntohl(len);
> > > > +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> > > > +
> > > > +    ret =3D recv(recv_sock, recv_buf, len, 0);
> > > > +    g_assert_cmpint(ret, =3D=3D, len);
> > > > +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> > > > +
> > > > +    close(recv_sock);
> > > > +    close(backend_sock[0]);
> > > > +    unlink(sock_path);
> > > > +    qtest_quit(qts);
> > > > +}
> > > > +
> > > > +int main(int argc, char **argv)
> > > > +{
> > > > +    g_test_init(&argc, &argv, NULL);
> > > > +    qtest_add_func("/netfilter/change_interval_timer",
> > > > +                   test_change_interval_timer);
> > > > +    return g_test_run();
> > > > +}
> > > > diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfil=
ter.c
> > > > index 326d4bd85f..b7271055d6 100644
> > > > --- a/tests/qtest/test-netfilter.c
> > > > +++ b/tests/qtest/test-netfilter.c
> > > > @@ -10,7 +10,10 @@
> > > >
> > > >  #include "qemu/osdep.h"
> > > >  #include "libqtest-single.h"
> > > > +#include "libqtest.h"
> > > >  #include "qobject/qdict.h"
> > > > +#include "qemu/iov.h"
> > > > +#include "qemu/sockets.h"
> > > >
> > > >  /* add a netfilter to a netdev and then remove it */
> > > >  static void add_one_netfilter(void)
> > > > --
> > > > 2.34.1
> > > >
> > >
> >
>


