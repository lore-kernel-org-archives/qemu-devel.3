Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A96E7AD69
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 01:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYwla-0008TS-KL; Thu, 25 Dec 2025 20:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYwlX-0008T5-4c
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 20:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYwlV-0002Qw-1W
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 20:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766713030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=solq3XpJGXYCBDt9wYTyCXAAhqPBzteCxWLq8zLYnIQ=;
 b=c9sGqXS+4ZgIXPm6rf5TyBsZouXttsBAcR9sEUaJy7xXAH/VGttKIdfWljoyDoQAqIbo84
 w6SF3Vqknr/m7DvtNEKo3htI83xm6PQHJDTCMzuxFOkLQZNhZ1uS83q4rbgkZBacJ8qMfk
 YPLh89hLCv95MhDY9NKvISpmB8iYELc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-nB3_72EDN1yrTqGQnBnztQ-1; Thu, 25 Dec 2025 20:37:08 -0500
X-MC-Unique: nB3_72EDN1yrTqGQnBnztQ-1
X-Mimecast-MFC-AGG-ID: nB3_72EDN1yrTqGQnBnztQ_1766713027
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f1450189eso64339355ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 17:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766713027; x=1767317827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=solq3XpJGXYCBDt9wYTyCXAAhqPBzteCxWLq8zLYnIQ=;
 b=qGvdh8xkyGgrM2xEUHnYzIUUldfv0aBYXEAagi/s5i3kiEuwKlxEVtxhkDjm/CjKxL
 N0YeFfcUBxC78fbfDd4wzjkSEMQEwfLNk1Gr0gVq+oqupB0yFGNFFOhhxK/x2BT9bxsZ
 C/n5OPYKu/SFXe2ggOyFi9sRfOTJdJPTFq9NwE3y6Q3PlS3O9RE/KZwA/46UztzCz44g
 5W6YnYoB0RRsLzu1cOksxR3Sq9/Gib4+q6H9HhEPWnwUJWs1k0pP7g74Ri9hWAe+GOTZ
 iJXJSHjBHQi/Gs7lHkK6I8C0eiF/GiaZhnpWSFJuwCOzBORTsnp1ZgNMlFzHHt9T1hW5
 ro3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766713027; x=1767317827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=solq3XpJGXYCBDt9wYTyCXAAhqPBzteCxWLq8zLYnIQ=;
 b=mijd2hxupcjlPUpLHOYZAqZp1SAVwXG58aQWAgc/+1dCRWeCfQpB5BnsuSyEzmZK6u
 PWPnFDpMxpJMZlImoc3T3t6ngPe2VRu1ogHmILxa3PQL97J0TUdcoUga6uRz/YE+gFbT
 zn6MixzFAcyNIlH6xATE/21MFJumP1UWZj3pfpOqabM43egzQGkwLz4Ew3jtGjpfccx8
 EFm4AJ5qQ93FRJDQd6dgdhDgAzPSeCoqvNsO8ZYEzOcMFtpnwpFX6gdY3nXr7K7KZpf5
 aFl0cI4MikBFFPaX2uPyVZeOzas88F+0Hqbrr1etPlfDDdXI69czTho85iUA9PCc1npx
 RTjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0v9xRZ1tboc7UBMSmYNumPGogFFQkiAsXL2jzwb5RvEDqx1tr91rguOI+8UB4AU1PBQ8P+z1u8vqe@nongnu.org
X-Gm-Message-State: AOJu0YzCOcNKuxngdbxYQU/qKLwuimDEk24EUec3zcDfB91Tl6v5ngPa
 MYoa1qOoCJosOiAcCWCBWRhgf1eJkOSwo/zFUZf8/68ikX/LRCfKAbAsaDEYsydulTIohD58sR4
 REhk3izxRVjLBTZiP3FsJe2apMTnNzCHlm4FZHxDRCEuYIT3OJxxYXaHZTODV4eEXiJkng3Yv8m
 H1j+AgvWyNvdIJyev7JP1SsFZAJsY1Ag0=
X-Gm-Gg: AY/fxX6DA7yJ/I5JKopsFJSlBOE/PhzYJOXWnkd+aEmnX6PeVQgUTAKdQb1uQQXSYHS
 0nz3u+ge8bTdtJdgsG4a7PwS4sINkzc9NasO/zr9sWhIZUiYu80AFmqYtvWyJa3PhSlPl4dR1A5
 nsRz7m2TVH1h8mv2mkMoUSrGa79sBP//B4Rq4YqCReu9oU3jBvHCNQmZanisiMJPsEstzK
X-Received: by 2002:a17:902:e78c:b0:2a0:d0ae:454d with SMTP id
 d9443c01a7336-2a2cab4335fmr218007965ad.22.1766713027180; 
 Thu, 25 Dec 2025 17:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIYmTmRWZ9HR1s/T4M/TeeSaJU8+a3jPl8i3pW2Pe0kxUaolbomZ9GSzWrqaoYE2g8aytJiG0VKcV84Sh91gA=
X-Received: by 2002:a17:902:e78c:b0:2a0:d0ae:454d with SMTP id
 d9443c01a7336-2a2cab4335fmr218007765ad.22.1766713026711; Thu, 25 Dec 2025
 17:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
In-Reply-To: <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 09:36:55 +0800
X-Gm-Features: AQt7F2pWbffv1mE_cPBYlZf-eU2PbWD-vceEuawil1jsLN52RmJ0CWl8m3O207I
Message-ID: <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
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

On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
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
>
> If user try to simulate network latency by filter-buffer, the accuracy
> of time is important.
> Do we need add some note about the first buffered packet time not
> equel to dynamic
> changed time (default interval time - new qmp cmd effected time +
> changed time ?).

I'm not sure I will get here, we can't forcast when the first packet
will come. So the behaviour is always that the filter-buffer will
flush at a fixed interval. Or I may miss something here.

>
> Another issue is what level of stable accuracy the QEMU filter-buffer
> can be achieved in actual testing?

We use qemu_clock_get_us() so it's the us actually?

> Maybe need to tell user recommended test range?

Could you elaborate more on this?

Thanks

>
> Thanks
> Chen
>
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
> >  /* add a netfilter to a netdev and then remove it */
> >  static void add_one_netfilter(void)
> > --
> > 2.34.1
> >
>


