Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4330BD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3Up-0007qR-4D; Sun, 28 Dec 2025 22:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1va3Un-0007pe-6A
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1va3Ul-0001N1-4O
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766977226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myDVMC220WP4va+Yk5snDHYHk3GKZXqT+I7UbdNv4i0=;
 b=LJSqBePjQogiiQUDIyv7Hbg3I9BTxxKNihlFx5Hu+/7MdIWDCzp7JBUS9QQGcCBl86tqqQ
 EyrHfSI0W84EcatM3QJIDpE/w45PI71LzbYy2GsBd2cNsLlkOzgeBCEZm39lxpZSTDLnVC
 lDU0vmXP/byOmdQ5zLFm8ckg8qFwAk8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-s_zhoWDnNcSwQlG75t0Cew-1; Sun, 28 Dec 2025 22:00:17 -0500
X-MC-Unique: s_zhoWDnNcSwQlG75t0Cew-1
X-Mimecast-MFC-AGG-ID: s_zhoWDnNcSwQlG75t0Cew_1766977217
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c2f670a06so11303742a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766977217; x=1767582017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myDVMC220WP4va+Yk5snDHYHk3GKZXqT+I7UbdNv4i0=;
 b=ceWhdOYAn1VrMqnMVOJER6AlZw4P9tbIHPEyedz0w9qZGjpPg0Y75v9gGSTM+bZvCT
 WFgcmNYNNX5MHHVn0IfVhSIfHLXyEsPbL4BZ4mk3Sz+4DKed0lOx7pyiaaTw2u/Az8QW
 2Zc4gAOEUmtXII1t/jjwMDym1CnfEyf+0fPKeCYDZcHcUXF2V42lLtXPRP1+jJRw0wbd
 O28FGu/i6HBo8HCN29HMqBBu8XmBB/kflzHuUvP8J3xbiX/MrTs36NrMHt8Nc35dqmXc
 CYinvdFSvyB146E8BY7RvzvGGmFMX37mt086ZcO2WqbGnF+zmrxn0wqZrdYZXCpEaVzi
 cEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766977217; x=1767582017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=myDVMC220WP4va+Yk5snDHYHk3GKZXqT+I7UbdNv4i0=;
 b=JxPTBw31MhlrDH4NobXbNGaDwlsrg7FqJxH1acPc37b+UTCkAiik+njOGHcmv6qdU1
 kSRnCbVhbyYUZFu9xJxbAANGWaG/9K+jnfsNbxbYHnMbKuUqXo9PS2zIYvng1Pik0NBJ
 HpaFLSbJcp/wPLlO0Ne98H3gYscaqUV60YuCsoRT2ATMDR1Qem+7+ifE8CjHeZ3hM1Rf
 4GdmbnRKZzvNPizTNfE/LZ5c9C6boULy6RNMvRvFL5QYMFVttZk+oh9Wihg9i0spk+yF
 i9SxglhWjbOmSPy8SOHig/9vlknXsl30V/eA84zro9bDiPODlF/2FOHk1OLz0zHxprEB
 CvkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSWqRz/V3GxJTLyatV5bxiPFV5l61vdVI7d9gC7/nytTQbbEPOzJx/TCkbNjGbIzYdvlgXmGAf/nZ3@nongnu.org
X-Gm-Message-State: AOJu0Yz0PdfPV9x28NNDcdwg37tYht6uK1ObbETHNtDIcUaB1/EOBmg8
 7GrdcxmRbum/8WThhYCnjGo1ZJ/kvRJjoXW30l+/EHUS9AQdvwb1nmPxeOcYQ1+8cLZCexKrGf5
 tWttJCpMouK0pk3wySrjN6MMNRHIYwJZllrKdDMMOyMSLznWki/SMbbQrXvatekhVKgMcJPAOX9
 CVkGnou//F2N+thAcp+EKdGaGI4kKBqJk=
X-Gm-Gg: AY/fxX4qYYNaHMGaQnvpU9FFnndNy2b8PiMLDkNtsk6mnsGzdfqcgmkX3Ecsy0oeqnB
 YtX0rZFUiXPY1JklnZxYL7C6+AzSn4WPh8sr7PaeORjst+D3hA3JJJ4NgWWp8b5qiSK5A19YdtG
 AB09fe2IY+UkVV3X638/Wy9cuRCDy3S9cUXEDoRGCawOcSsN+tQvCx/NlNsWF6fAJICuY=
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-34e921131b8mr25570021a91.8.1766977216589; 
 Sun, 28 Dec 2025 19:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn609pABAuqHdY0Nz/T4Nfql93rIo0mQs4cTWQ9mMeql0lBV2RrRvgAQV4mzOMaOYQrF6YBgugjp8eQFLEYBE=
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-34e921131b8mr25570001a91.8.1766977216043; Sun, 28 Dec 2025
 19:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <87tsxd7ye4.fsf@suse.de>
In-Reply-To: <87tsxd7ye4.fsf@suse.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 11:00:03 +0800
X-Gm-Features: AQt7F2ogQqTTZnoeggGhw_aUM0n_U82HIw-zLGPYRb-vtIbP23wS7Lg7MAy0CFA
Message-ID: <CACGkMEu+3LraRL7Lckx29kbLGHSVnZCXPo9Kt9nBL+ByQc+95Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Fabiano Rosas <farosas@suse.de>
Cc: zhangckid@gmail.com, lizhijian@fujitsu.com, qemu-devel@nongnu.org, 
 lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Dec 27, 2025 at 4:59=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Jason Wang <jasowang@redhat.com> writes:
>
> > Add test_change_interval_timer to verify that modifying the 'interval'
> > property of filter-buffer at runtime takes effect immediately.
> >
> > The test uses socket backend and filter-redirector to verify timer beha=
vior:
> > - Creates filter-buffer with a very long interval (1000 seconds)
> > - Sends a packet which gets buffered
> > - Advances virtual clock by 1 second, verifies packet is still buffered
> > - Changes interval to 1ms via qom-set (timer should be rescheduled)
> > - Advances virtual clock by 2ms, verifies packet is now released
> > - This proves the timer was rescheduled immediately when interval chang=
ed
> >
> > The test uses filter-redirector to observe when packets are released
> > by filter-buffer, providing end-to-end verification of the timer
> > rescheduling behavior.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  tests/qtest/meson.build          |   1 +
> >  tests/qtest/test-filter-buffer.c | 169 +++++++++++++++++++++++++++++++
> >  tests/qtest/test-netfilter.c     |   3 +
> >  3 files changed, 173 insertions(+)
> >  create mode 100644 tests/qtest/test-filter-buffer.c
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 669d07c06b..ffa85ba984 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -46,6 +46,7 @@ qtests_cxl =3D \
> >  #        for the availability of the default NICs in the tests
> >  qtests_filter =3D \
> >    (get_option('default_devices') and slirp.found() ? ['test-netfilter'=
] : []) + \
> > +  (get_option('default_devices') and host_os !=3D 'windows' ? ['test-f=
ilter-buffer'] : []) + \
> >    (get_option('default_devices') and host_os !=3D 'windows' ? ['test-f=
ilter-mirror'] : []) + \
> >    (get_option('default_devices') and host_os !=3D 'windows' ? ['test-f=
ilter-redirector'] : [])
> >
> > diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter=
-buffer.c
> > new file mode 100644
> > index 0000000000..441cbb975c
> > --- /dev/null
> > +++ b/tests/qtest/test-filter-buffer.c
> > @@ -0,0 +1,169 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * QTest testcase for filter-buffer
> > + *
> > + * Copyright (c) 2025 Red Hat, Inc.
> > + * Author: Jason Wang <jasowang@redhat.com>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "qobject/qdict.h"
> > +#include "qemu/iov.h"
> > +#include "qemu/sockets.h"
> > +
> > +/*
> > + * Test that changing interval at runtime affects packet release timin=
g.
> > + *
> > + * Traffic flow with filter-buffer and filter-redirector:
> > + *
> > + * test side                        | qemu side
> > + *                                  |
> > + * +--------+                       | +---------+
> > + * |  send  +------------------------>| backend |
> > + * | sock[0]|                       | +----+----+
> > + * +--------+                       |      |
> > + *                                  | +----v----+
> > + *                                  | |  fbuf0  | filter-buffer (queue=
=3Dtx)
> > + *                                  | +----+----+
> > + *                                  |      |
> > + *                                  | +----v----+  +----------+
> > + *                                  | |   rd0   +->| chardev0 |
> > + *                                  | +---------+  +----+-----+
> > + *                                  |                   |
> > + * +--------+                       |                   |
> > + * |  recv  |<--------------------------------------+
> > + * |  sock  |                       |
> > + * +--------+                       |
> > + *
> > + * The test verifies that when interval is changed via qom-set, the ti=
mer
> > + * is rescheduled immediately, causing buffered packets to be released
> > + * at the new interval rather than waiting for the old interval to ela=
pse.
> > + */
> > +static void test_change_interval_timer(void)
> > +{
> > +    QTestState *qts;
> > +    QDict *response;
> > +    int backend_sock[2], recv_sock;
> > +    int ret;
> > +    char send_buf[] =3D "Hello filter-buffer!";
> > +    char recv_buf[128];
> > +    char sock_path[] =3D "filter-buffer-test.XXXXXX";
> > +    uint32_t size =3D sizeof(send_buf);
> > +    uint32_t len;
> > +
> > +    size =3D htonl(size);
> > +
> > +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> > +    g_assert_cmpint(ret, !=3D, -1);
> > +
> > +    ret =3D mkstemp(sock_path);
> > +    g_assert_cmpint(ret, !=3D, -1);
> > +
> > +    /*
> > +     * Start QEMU with:
> > +     * - socket backend connected to our socketpair
> > +     * - filter-buffer with a very long interval (1000 seconds)
> > +     * - filter-redirector to send released packets to a chardev socke=
t
> > +     *
> > +     * queue=3Dtx intercepts packets going from backend to the guest,
> > +     * i.e., data we send from the test side.
> > +     */
> > +    qts =3D qtest_initf(
> > +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> > +        "-chardev socket,id=3Dchardev0,path=3D%s,server=3Don,wait=3Dof=
f "
> > +        "-object filter-buffer,id=3Dfbuf0,netdev=3Dqtest-bn0,"
> > +        "queue=3Dtx,interval=3D1000000000 "
> > +        "-object filter-redirector,id=3Drd0,netdev=3Dqtest-bn0,"
> > +        "queue=3Dtx,outdev=3Dchardev0",
> > +        backend_sock[1], sock_path);
> > +
> > +    /* Connect to the chardev socket to receive redirected packets */
> > +    recv_sock =3D unix_connect(sock_path, NULL);
> > +    g_assert_cmpint(recv_sock, !=3D, -1);
> > +
> > +    /* Send a QMP command to ensure chardev connection is established =
*/
> > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> > +
> > +    /*
> > +     * Send a packet from the test side.
> > +     * It should be buffered by filter-buffer.
> > +     */
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
> > +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof=
(send_buf));
> > +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> > +
> > +    /*
> > +     * Advance virtual clock by 1 second (1,000,000,000 ns).
> > +     * This is much less than the 1000 second interval, so the packet
> > +     * should still be buffered.
> > +     */
> > +    qtest_clock_step(qts, 1000000000LL);
> > +
> > +    /* Try to receive with non-blocking - should fail (packet still bu=
ffered) */
> > +    ret =3D recv(recv_sock, recv_buf, sizeof(recv_buf), MSG_DONTWAIT);
> > +    g_assert_cmpint(ret, =3D=3D, -1);
> > +    g_assert(errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK);
> > +
> > +    /*
> > +     * Now change the interval to 1000 us (1ms) via qom-set.
> > +     * This should reschedule the timer to fire in 1ms from now.
> > +     */
> > +    response =3D qtest_qmp(qts,
> > +                         "{'execute': 'qom-set',"
> > +                         " 'arguments': {"
> > +                         "   'path': 'fbuf0',"
> > +                         "   'property': 'interval',"
> > +                         "   'value': 1000"
> > +                         "}}");
> > +    g_assert(response);
> > +    g_assert(!qdict_haskey(response, "error"));
> > +    qobject_unref(response);
> > +
> > +    /*
> > +     * Advance virtual clock by 2ms (2,000,000 ns).
> > +     * This exceeds the new 1ms interval, so the timer should fire
> > +     * and release the buffered packet.
> > +     *
> > +     * If the interval change didn't take effect immediately, we would
> > +     * still be waiting for the original 1000 second interval to elaps=
e,
> > +     * and the packet would not be released.
> > +     */
> > +    qtest_clock_step(qts, 2000000LL);
> > +
> > +    /*
> > +     * Now we should be able to receive the packet through the redirec=
tor.
> > +     * The packet was released by filter-buffer and sent to filter-red=
irector,
> > +     * which forwarded it to the chardev socket.
> > +     */
> > +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> > +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> > +    len =3D ntohl(len);
> > +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> > +
> > +    ret =3D recv(recv_sock, recv_buf, len, 0);
> > +    g_assert_cmpint(ret, =3D=3D, len);
> > +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> > +
> > +    close(recv_sock);
> > +    close(backend_sock[0]);
> > +    unlink(sock_path);
> > +    qtest_quit(qts);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +    qtest_add_func("/netfilter/change_interval_timer",
> > +                   test_change_interval_timer);
> > +    return g_test_run();
> > +}
> > diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.=
c
> > index 326d4bd85f..b7271055d6 100644
> > --- a/tests/qtest/test-netfilter.c
> > +++ b/tests/qtest/test-netfilter.c
> > @@ -10,7 +10,10 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "libqtest-single.h"
> > +#include "libqtest.h"
> >  #include "qobject/qdict.h"
> > +#include "qemu/iov.h"
> > +#include "qemu/sockets.h"
> >
>
> Some extra changes here^

Indeed, let me fix that in v2.

Thanks


