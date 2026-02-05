Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3FCECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5y0-00018S-Jf; Thu, 05 Feb 2026 15:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5xv-000187-0D
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5xs-0008Vk-3h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770323315;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4kpLz8R/oTCWNk5jHH5B1wndTMZkLJAEyxRLpab9HJ8=;
 b=aHEK/ChGyhJE2dnlYOm16h4eXn9JCzJ3SovSg010HXJJsHL0NkY9DU7ag/JgvqPbXM3Sb5
 17k7MDtOHtSqYmtGPCwscnKAlCtn/AoduscUkHsefw7AcDfDf2a5xNFfuIZVE8zg/nYzu6
 TT9kEJgFRlxX2JIiRzJ3R+t8a2p2uHo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-M7Ml2rXZM_O-px2Q_H-JCQ-1; Thu,
 05 Feb 2026 15:28:31 -0500
X-MC-Unique: M7Ml2rXZM_O-px2Q_H-JCQ-1
X-Mimecast-MFC-AGG-ID: M7Ml2rXZM_O-px2Q_H-JCQ_1770323308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793671800282; Thu,  5 Feb 2026 20:28:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B028D1800465; Thu,  5 Feb 2026 20:28:24 +0000 (UTC)
Date: Thu, 5 Feb 2026 20:28:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 08/29] hw/core: Setup Remote Port I/O channels
Message-ID: <aYT9ZMNk7stEXhHB@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-9-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205195824.2610192-9-ruslichenko.r@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 05, 2026 at 08:58:03PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> Add initialization of communication channels with
> remote peer.
> 
> This includes character device backend, which can be
> configured based on QOM properties or automatic socket
> creation based on the machine path. The patch also
> initializes the signaling event pipes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  hw/core/remote-port.c         | 187 ++++++++++++++++++++++++++++++++++
>  include/hw/core/remote-port.h |  16 +++
>  2 files changed, 203 insertions(+)
> 
> diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> index c909a825f3..5154c1bc2a 100644
> --- a/hw/core/remote-port.c
> +++ b/hw/core/remote-port.c
> @@ -52,6 +52,58 @@
>  #define REMOTE_PORT_CLASS(klass)    \
>       OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
>  
> +static char *rp_sanitize_prefix(RemotePort *s)
> +{
> +    char *sanitized_name;
> +    char *c;
> +
> +    sanitized_name = g_strdup(s->prefix);
> +    for (c = sanitized_name; *c != '\0'; c++) {
> +        if (*c == '/') {
> +            *c = '_';
> +        }
> +    }
> +    return sanitized_name;
> +}
> +
> +static char *rp_autocreate_chardesc(RemotePort *s, bool server)
> +{
> +    char *prefix;
> +    char *chardesc;
> +    int r;
> +
> +    prefix = rp_sanitize_prefix(s);
> +    r = asprintf(&chardesc, "unix:%s/qemu-rport-%s%s",
> +                 machine_path, prefix, server ? ",wait,server" : "");
> +    assert(r > 0);
> +    free(prefix);
> +    return chardesc;
> +}
> +
> +static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
> +{
> +    Chardev *chr = NULL;
> +    char *chardesc;
> +    char *s_path;
> +    int r;
> +
> +    r = asprintf(&s_path, "%s/qemu-rport-%s", machine_path,
> +                 rp_sanitize_prefix(s));
> +    assert(r > 0);
> +    if (g_file_test(s_path, G_FILE_TEST_EXISTS)) {
> +        chardesc = rp_autocreate_chardesc(s, false);
> +        chr = qemu_chr_new_noreplay(name, chardesc, false, NULL);
> +        free(chardesc);
> +    }
> +    free(s_path);
> +
> +    if (!chr) {
> +        chardesc = rp_autocreate_chardesc(s, true);
> +        chr = qemu_chr_new_noreplay(name, chardesc, false, NULL);
> +        free(chardesc);
> +    }
> +    return chr;
> +}
>  
>  static void rp_reset(DeviceState *dev)
>  {
> @@ -66,6 +118,127 @@ static void rp_reset(DeviceState *dev)
>  
>  static void rp_realize(DeviceState *dev, Error **errp)
>  {
> +    RemotePort *s = REMOTE_PORT(dev);
> +    int r;
> +    Error *err = NULL;
> +
> +    s->prefix = object_get_canonical_path(OBJECT(dev));
> +
> +    if (!qemu_chr_fe_get_driver(&s->chr)) {
> +        char *name;
> +        Chardev *chr = NULL;
> +        static int nr;
> +
> +        r = asprintf(&name, "rport%d", nr);
> +        nr++;
> +        assert(r > 0);
> +
> +        if (s->chrdev_id) {
> +            chr = qemu_chr_find(s->chrdev_id);
> +        }
> +
> +        if (chr) {
> +            /* Found the chardev via commandline */
> +        } else if (s->chardesc) {
> +            chr = qemu_chr_new(name, s->chardesc, NULL);
> +        } else {
> +            if (!machine_path) {
> +                error_report("%s: Missing chardesc prop."
> +                             " Forgot -machine-path?",
> +                             s->prefix);
> +                exit(EXIT_FAILURE);
> +            }
> +            chr = rp_autocreate_chardev(s, name);
> +        }

Having three different ways to configure the chardev rather
feels like overkill. IMHO it should be sufficient to just
accept thue chardev ID as a mandatory argument, and not
attempt to create chardevs from this code. That would
in turn seem to avoid the need for the -machine-path arg
to exist ?


> +#ifdef _WIN32
> +    /*
> +     * Create a socket connection between two sockets. We auto-bind
> +     * and read out the port selected by the kernel.
> +     */
> +    {
> +        char *name;
> +        SocketAddress *sock;
> +        int port;
> +        int listen_sk;
> +
> +        sock = socket_parse("127.0.0.1:0", &error_abort);
> +        listen_sk = socket_listen(sock, 1, &error_abort);

Please avoid introducing new usage of low level sockets APIs. The higher
level QIOChannelSocket APIs is preferred, that said.....

> +
> +        if (s->event.pipe.read < 0) {
> +            perror("socket read");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        {
> +            struct sockaddr_in saddr;
> +            socklen_t slen = sizeof saddr;
> +            int r;
> +
> +            r = getsockname(listen_sk, (struct sockaddr *) &saddr, &slen);
> +            if (r < 0) {
> +                perror("getsockname");
> +                exit(EXIT_FAILURE);
> +            }
> +            port = htons(saddr.sin_port);
> +        }
> +
> +        name = g_strdup_printf("127.0.0.1:%d", port);
> +        s->event.pipe.write = inet_connect(name, &error_abort);
> +        g_free(name);
> +        if (s->event.pipe.write < 0) {
> +            perror("socket write");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        for (;;) {
> +            struct sockaddr_in saddr;
> +            socklen_t slen = sizeof saddr;
> +            int fd;
> +
> +            slen = sizeof(saddr);
> +            fd = qemu_accept(listen_sk, (struct sockaddr *)&saddr, &slen);
> +            if (fd < 0 && errno != EINTR) {
> +                close(listen_sk);
> +                return;
> +            } else if (fd >= 0) {
> +                close(listen_sk);
> +                s->event.pipe.read = fd;
> +                break;
> +            }
> +        }
> +
> +        if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
> +            error_report("%s: Unable to set non-block for internal pipes",
> +                        s->prefix);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +#else
> +    if (!g_unix_open_pipe(s->event.pipes, FD_CLOEXEC, NULL)) {
> +        error_report("%s: Unable to create remort-port internal pipes",
> +                    s->prefix);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
> +        error_report("%s: Unable to set non-block for internal pipes",
> +                    s->prefix);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +#endif

... I can't help thinking we have this code "self event pipe" design
somewhere else in QEMU. Ideally we would have a helper API for this
task and avoid OS conditional code in this device impl.


>  }
>  
>  static void rp_unrealize(DeviceState *dev)
> @@ -73,6 +246,13 @@ static void rp_unrealize(DeviceState *dev)
>      RemotePort *s = REMOTE_PORT(dev);
>  
>      s->finalizing = true;
> +
> +    info_report("%s: Wait for remote-port to disconnect", s->prefix);
> +    qemu_chr_fe_disconnect(&s->chr);
> +
> +    close(s->event.pipe.read);
> +    close(s->event.pipe.write);
> +    object_unparent(OBJECT(s->chrdev));
>  }
>  
>  static const VMStateDescription vmstate_rp = {
> @@ -84,6 +264,12 @@ static const VMStateDescription vmstate_rp = {
>      }
>  };
>  
> +static Property rp_properties[] = {
> +    DEFINE_PROP_CHR("chardev", RemotePort, chr),
> +    DEFINE_PROP_STRING("chardesc", RemotePort, chardesc),
> +    DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
> +};

This really feels lik

> +
>  static void rp_prop_allow_set_link(const Object *obj, const char *name,
>                                     Object *val, Error **errp)
>  {
> @@ -112,6 +298,7 @@ static void rp_class_init(ObjectClass *klass, const void *data)
>      dc->realize = rp_realize;
>      dc->unrealize = rp_unrealize;
>      dc->vmsd = &vmstate_rp;
> +    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
>  }
>  
>  static const TypeInfo rp_info = {
> diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
> index db71071c8e..0f40018cdb 100644
> --- a/include/hw/core/remote-port.h
> +++ b/include/hw/core/remote-port.h
> @@ -56,8 +56,24 @@ typedef struct RemotePortDeviceClass {
>  struct RemotePort {
>      DeviceState parent;
>  
> +    union {
> +       int pipes[2];
> +       struct {
> +           int read;
> +           int write;
> +       } pipe;
> +    } event;
> +    Chardev *chrdev;
> +    CharFrontend chr;
>      bool finalizing;
>  
> +    char *chardesc;
> +    char *chrdev_id;
> +
> +    const char *prefix;
> +    const char *remote_prefix;
> +
> +    uint32_t current_id;
>      bool reset_done;
>  
>  #define REMOTE_PORT_MAX_DEVS 1024
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


