Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCA9EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPhx-0003p1-Uc; Fri, 06 Feb 2026 12:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPhv-0003mA-VS
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:33:27 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voPht-0002em-OE
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:33:27 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-662f485e58aso1040771eaf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399204; cv=none;
 d=google.com; s=arc-20240605;
 b=dPRJvG0hxqnAg3szz9dHwD1QrCmtqo6fSv5IM8GIQIEcByei5axI6ydfhuRqx5/hMk
 ksyWufeHI0DzdoDosuU4tBj62Y/g6SVFhPMau93dtduB/15TlFv8Dx+qW+G1lEkb498h
 AeJwrm/twWUhRKZNjJv3uCTJi1agYEAvYHNz7nz+WGr9oWS10XsojnGwlbn6D6j61eDT
 FCS92pC0twXaKEEO7PxrVoR9NG/mgzjdVtH6KzgaqGNfkaeD1WvtIXAHTBafyNqG1q9D
 Vydd4y1NBQ2s4wzf9aV67oITEaIQBmA+7EyV2PsVm5diPV3BpZwr8B3W64YYBSb8Sfx9
 0lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oF541vMwvBhLoCe+/4b8TNAhRgKvrUc2DWK4C90kY+Y=;
 fh=9Xh+R7zIRm5O897kxCGh+dkL2L1w6BVeJfthgI/kLZI=;
 b=j/8oD+ZtxsH+vk0NiCllk4hT3jkXPc8U1q/cB4asbWuKLRFAOcWDO0hfw9VaBwFHgH
 Vla1p8PiRXKrlh5cTxHcMMcvTX8DOpoku0JYuNLLHDKNrpF+Bxtu3qvkaqUfK8D963+M
 v+ZoJOxs17GuItim2nqNo8mYmZKUEUB/UBJDY1AfN/9uEzilgmJUXG9hwgY4qZ/8DV4X
 TrcRunbQtiUGR+ks7smXaX9/K1Hbk96xT2m+B0CPDK5MZ4/9lTelftPOzIJC15D9AKZl
 9RJJtgY277Jhq7z2Ib/EBJTYdb9QC1J2Hq78A2Q8CHm5kNwMoIlV9nJOxzxqLQd0Ug3g
 kIqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770399204; x=1771004004; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oF541vMwvBhLoCe+/4b8TNAhRgKvrUc2DWK4C90kY+Y=;
 b=ge5Wp7qWZBZK8ohJZGW8EcW/WNVB0udAUp16GaT8j8TU33T0KLnedUdZldzjYGyC2R
 CE5QLQYCqYdTvJp9Doe9ok1qhEOcj8bw6/SBqSaYeOtuhclwKmzIzvfYuTeDNiyTDgg0
 ffXN6t82GxjrgZYdRCDAkRkdaCjgOURLIWMDjwdDlR4uYbT6ZYQnttKtr6kF77gQbx+J
 ZI0F6IDGxnYwqZftwfHZhps6J0/broKjr9+YwC9jYI7mewKZ+fFp5LEj/YusB6PGqndi
 2ax6+dvEtTs/oiqn9S4n727JCa3B1o4QThJgOyZh/yGaRgJFdhcwD7Q4MBxvjJJjuMdH
 C4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399204; x=1771004004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oF541vMwvBhLoCe+/4b8TNAhRgKvrUc2DWK4C90kY+Y=;
 b=V1Pge8QP9pDASjJx+bj+LNW26akjJt5XEswHHaAv5q7yqNyafaDWpvn5cmbcvbFotv
 ul0+4yilhHkzOYIq7OzWPIau55LU9i9dLY/bPEw92oMrpcSK+fnEVn5bFmB5+b0ZnRtK
 r2lUIqjBrCGRJNtQxIUjgnWt3WRpEWn2XlteJQ4j+h/PUUtRlI1Z6JMyDZXn5TTgDn1z
 DNFDz28ik4EhD5cJwEUZngWSoM2KPqpcSW0yTUXAu4F0Mc54Wgqe91Md5gLf5V6LKoxP
 QpR+nzfaZLWm05t5p9VMvUolRaiOYF6SGsA7nuQ0RRneAeR9TCFQW7I49M3NR5grs7At
 KihA==
X-Gm-Message-State: AOJu0YxVh9cg+FyPbIGJv2PU+wg5+P2y1+HnGwPSpGv08MKK9xD0zT/2
 V0Ed3BNl9CbLMn0EzYv86lC7jWe61P+b6Gx6RuWIwSxylNw64APvXYM1QDAXkeDr+o16JGnkb/y
 Yn2YjdkzZJH3juO42nXzZYD2cLhWp9D4=
X-Gm-Gg: AZuq6aL7oNcYMSkW3NycR10g400eeZtEtaGOFFHczqmzECxnwRBXiX6qoHNOofB9vwe
 u2TFB1nqVeiyo5z6CpTpMWQarg31B9sbmHXsVd1Uj6Lpu5kPJCmCCkicADjgP801Aonk3lwZQcb
 0LdmXSoVmd8sy1VFKOQGIvb1T7M2QjRZCXaQIg7325zRWMxiajdtMaSQNC7rA8aaVPZtHAEgcyV
 41icgmMq3HK9CLDIotSfBQln7jn838sHdqWmgccEwyHhMkhMzv3vL1RelJyUp3qQD6Ev3HaSrju
 KS6fDlqo
X-Received: by 2002:a05:6820:80c7:b0:659:9a49:9047 with SMTP id
 006d021491bc7-66d09f9c55amr1536898eaf.18.1770399204147; Fri, 06 Feb 2026
 09:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-9-ruslichenko.r@gmail.com>
 <aYT9ZMNk7stEXhHB@redhat.com>
In-Reply-To: <aYT9ZMNk7stEXhHB@redhat.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 6 Feb 2026 18:33:12 +0100
X-Gm-Features: AZwV_QixEr-1wITKewZLIhta_YHs6U-GKreO8876u9JrYkBN-wJUPn04L1F4uNQ
Message-ID: <CAN-aV1FmTNqvqY4eMKg7+Op2eth5GjmLe_O+0Sh=ox_TLSsJzA@mail.gmail.com>
Subject: Re: [PATCH 08/29] hw/core: Setup Remote Port I/O channels
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com, 
 Ruslan_Ruslichenko@epam.com, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc36.google.com
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

Hello Daniel,
Thank you for your review.

On Thu, Feb 5, 2026 at 9:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 08:58:03PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > Add initialization of communication channels with
> > remote peer.
> >
> > This includes character device backend, which can be
> > configured based on QOM properties or automatic socket
> > creation based on the machine path. The patch also
> > initializes the signaling event pipes.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  hw/core/remote-port.c         | 187 ++++++++++++++++++++++++++++++++++
> >  include/hw/core/remote-port.h |  16 +++
> >  2 files changed, 203 insertions(+)
> >
> > diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> > index c909a825f3..5154c1bc2a 100644
> > --- a/hw/core/remote-port.c
> > +++ b/hw/core/remote-port.c
> > @@ -52,6 +52,58 @@
> >  #define REMOTE_PORT_CLASS(klass)    \
> >       OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
> >
> > +static char *rp_sanitize_prefix(RemotePort *s)
> > +{
> > +    char *sanitized_name;
> > +    char *c;
> > +
> > +    sanitized_name =3D g_strdup(s->prefix);
> > +    for (c =3D sanitized_name; *c !=3D '\0'; c++) {
> > +        if (*c =3D=3D '/') {
> > +            *c =3D '_';
> > +        }
> > +    }
> > +    return sanitized_name;
> > +}
> > +
> > +static char *rp_autocreate_chardesc(RemotePort *s, bool server)
> > +{
> > +    char *prefix;
> > +    char *chardesc;
> > +    int r;
> > +
> > +    prefix =3D rp_sanitize_prefix(s);
> > +    r =3D asprintf(&chardesc, "unix:%s/qemu-rport-%s%s",
> > +                 machine_path, prefix, server ? ",wait,server" : "");
> > +    assert(r > 0);
> > +    free(prefix);
> > +    return chardesc;
> > +}
> > +
> > +static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
> > +{
> > +    Chardev *chr =3D NULL;
> > +    char *chardesc;
> > +    char *s_path;
> > +    int r;
> > +
> > +    r =3D asprintf(&s_path, "%s/qemu-rport-%s", machine_path,
> > +                 rp_sanitize_prefix(s));
> > +    assert(r > 0);
> > +    if (g_file_test(s_path, G_FILE_TEST_EXISTS)) {
> > +        chardesc =3D rp_autocreate_chardesc(s, false);
> > +        chr =3D qemu_chr_new_noreplay(name, chardesc, false, NULL);
> > +        free(chardesc);
> > +    }
> > +    free(s_path);
> > +
> > +    if (!chr) {
> > +        chardesc =3D rp_autocreate_chardesc(s, true);
> > +        chr =3D qemu_chr_new_noreplay(name, chardesc, false, NULL);
> > +        free(chardesc);
> > +    }
> > +    return chr;
> > +}
> >
> >  static void rp_reset(DeviceState *dev)
> >  {
> > @@ -66,6 +118,127 @@ static void rp_reset(DeviceState *dev)
> >
> >  static void rp_realize(DeviceState *dev, Error **errp)
> >  {
> > +    RemotePort *s =3D REMOTE_PORT(dev);
> > +    int r;
> > +    Error *err =3D NULL;
> > +
> > +    s->prefix =3D object_get_canonical_path(OBJECT(dev));
> > +
> > +    if (!qemu_chr_fe_get_driver(&s->chr)) {
> > +        char *name;
> > +        Chardev *chr =3D NULL;
> > +        static int nr;
> > +
> > +        r =3D asprintf(&name, "rport%d", nr);
> > +        nr++;
> > +        assert(r > 0);
> > +
> > +        if (s->chrdev_id) {
> > +            chr =3D qemu_chr_find(s->chrdev_id);
> > +        }
> > +
> > +        if (chr) {
> > +            /* Found the chardev via commandline */
> > +        } else if (s->chardesc) {
> > +            chr =3D qemu_chr_new(name, s->chardesc, NULL);
> > +        } else {
> > +            if (!machine_path) {
> > +                error_report("%s: Missing chardesc prop."
> > +                             " Forgot -machine-path?",
> > +                             s->prefix);
> > +                exit(EXIT_FAILURE);
> > +            }
> > +            chr =3D rp_autocreate_chardev(s, name);
> > +        }
>
> Having three different ways to configure the chardev rather
> feels like overkill. IMHO it should be sufficient to just
> accept thue chardev ID as a mandatory argument, and not
> attempt to create chardevs from this code. That would
> in turn seem to avoid the need for the -machine-path arg
> to exist ?
>

I think we can consider using only chrdev_id, for now. This loses some
flexibility, but definitely simplifies things a lot.

>
> > +#ifdef _WIN32
> > +    /*
> > +     * Create a socket connection between two sockets. We auto-bind
> > +     * and read out the port selected by the kernel.
> > +     */
> > +    {
> > +        char *name;
> > +        SocketAddress *sock;
> > +        int port;
> > +        int listen_sk;
> > +
> > +        sock =3D socket_parse("127.0.0.1:0", &error_abort);
> > +        listen_sk =3D socket_listen(sock, 1, &error_abort);
>
> Please avoid introducing new usage of low level sockets APIs. The higher
> level QIOChannelSocket APIs is preferred, that said.....
>
> > +
> > +        if (s->event.pipe.read < 0) {
> > +            perror("socket read");
> > +            exit(EXIT_FAILURE);
> > +        }
> > +
> > +        {
> > +            struct sockaddr_in saddr;
> > +            socklen_t slen =3D sizeof saddr;
> > +            int r;
> > +
> > +            r =3D getsockname(listen_sk, (struct sockaddr *) &saddr, &=
slen);
> > +            if (r < 0) {
> > +                perror("getsockname");
> > +                exit(EXIT_FAILURE);
> > +            }
> > +            port =3D htons(saddr.sin_port);
> > +        }
> > +
> > +        name =3D g_strdup_printf("127.0.0.1:%d", port);
> > +        s->event.pipe.write =3D inet_connect(name, &error_abort);
> > +        g_free(name);
> > +        if (s->event.pipe.write < 0) {
> > +            perror("socket write");
> > +            exit(EXIT_FAILURE);
> > +        }
> > +
> > +        for (;;) {
> > +            struct sockaddr_in saddr;
> > +            socklen_t slen =3D sizeof saddr;
> > +            int fd;
> > +
> > +            slen =3D sizeof(saddr);
> > +            fd =3D qemu_accept(listen_sk, (struct sockaddr *)&saddr, &=
slen);
> > +            if (fd < 0 && errno !=3D EINTR) {
> > +                close(listen_sk);
> > +                return;
> > +            } else if (fd >=3D 0) {
> > +                close(listen_sk);
> > +                s->event.pipe.read =3D fd;
> > +                break;
> > +            }
> > +        }
> > +
> > +        if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
> > +            error_report("%s: Unable to set non-block for internal pip=
es",
> > +                        s->prefix);
> > +            exit(EXIT_FAILURE);
> > +        }
> > +    }
> > +#else
> > +    if (!g_unix_open_pipe(s->event.pipes, FD_CLOEXEC, NULL)) {
> > +        error_report("%s: Unable to create remort-port internal pipes"=
,
> > +                    s->prefix);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
> > +        error_report("%s: Unable to set non-block for internal pipes",
> > +                    s->prefix);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +#endif
>
> ... I can't help thinking we have this code "self event pipe" design
> somewhere else in QEMU. Ideally we would have a helper API for this
> task and avoid OS conditional code in this device impl.
>
>
Thanks! Looks like EventNotifier may work here and it supports both platfor=
ms.
I'll try to use it instead then.

> >  }
> >
> >  static void rp_unrealize(DeviceState *dev)
> > @@ -73,6 +246,13 @@ static void rp_unrealize(DeviceState *dev)
> >      RemotePort *s =3D REMOTE_PORT(dev);
> >
> >      s->finalizing =3D true;
> > +
> > +    info_report("%s: Wait for remote-port to disconnect", s->prefix);
> > +    qemu_chr_fe_disconnect(&s->chr);
> > +
> > +    close(s->event.pipe.read);
> > +    close(s->event.pipe.write);
> > +    object_unparent(OBJECT(s->chrdev));
> >  }
> >
> >  static const VMStateDescription vmstate_rp =3D {
> > @@ -84,6 +264,12 @@ static const VMStateDescription vmstate_rp =3D {
> >      }
> >  };
> >
> > +static Property rp_properties[] =3D {
> > +    DEFINE_PROP_CHR("chardev", RemotePort, chr),
> > +    DEFINE_PROP_STRING("chardesc", RemotePort, chardesc),
> > +    DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
> > +};
>
> This really feels lik
>
> > +
> >  static void rp_prop_allow_set_link(const Object *obj, const char *name=
,
> >                                     Object *val, Error **errp)
> >  {
> > @@ -112,6 +298,7 @@ static void rp_class_init(ObjectClass *klass, const=
 void *data)
> >      dc->realize =3D rp_realize;
> >      dc->unrealize =3D rp_unrealize;
> >      dc->vmsd =3D &vmstate_rp;
> > +    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properti=
es));
> >  }
> >
> >  static const TypeInfo rp_info =3D {
> > diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-por=
t.h
> > index db71071c8e..0f40018cdb 100644
> > --- a/include/hw/core/remote-port.h
> > +++ b/include/hw/core/remote-port.h
> > @@ -56,8 +56,24 @@ typedef struct RemotePortDeviceClass {
> >  struct RemotePort {
> >      DeviceState parent;
> >
> > +    union {
> > +       int pipes[2];
> > +       struct {
> > +           int read;
> > +           int write;
> > +       } pipe;
> > +    } event;
> > +    Chardev *chrdev;
> > +    CharFrontend chr;
> >      bool finalizing;
> >
> > +    char *chardesc;
> > +    char *chrdev_id;
> > +
> > +    const char *prefix;
> > +    const char *remote_prefix;
> > +
> > +    uint32_t current_id;
> >      bool reset_done;
> >
> >  #define REMOTE_PORT_MAX_DEVS 1024
> > --
> > 2.43.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--
BR,
Ruslan

