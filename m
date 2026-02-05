Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80329ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5zL-0001h7-RW; Thu, 05 Feb 2026 15:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5zJ-0001gi-Ol
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5zH-0000U3-Iv
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770323402;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9qV/z/WkZPtS6OM0BpUsbfFll5aU2iTLuPicgbUDO58=;
 b=aVXW+n6DqXxSH7keinNMkyhRkw/o/FJLXCNx1Zr6enK89JKSfK+shPc/VxXAL+x66cglZC
 CKJDDVV3V2NO68C+3d9A+qRVwL7+C+XnSkxVZAXjk8ntw5OngiNxJMFnvzlRFrQGPLabx2
 Eub1HGiDiwF6lKUvs5apmBT3pJmDDqw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-a84lM7U-OP6nzAyvXSSuow-1; Thu,
 05 Feb 2026 15:29:57 -0500
X-MC-Unique: a84lM7U-OP6nzAyvXSSuow-1
X-Mimecast-MFC-AGG-ID: a84lM7U-OP6nzAyvXSSuow_1770323395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A7F0180025C; Thu,  5 Feb 2026 20:29:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98649300DDA1; Thu,  5 Feb 2026 20:29:51 +0000 (UTC)
Date: Thu, 5 Feb 2026 20:29:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 09/29] hw/core: Add Remote Port protocol thread and
 handshake
Message-ID: <aYT9u7yO61zCOdR0@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-10-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205195824.2610192-10-ruslichenko.r@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 05, 2026 at 08:58:04PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> Introduce main execution loop for the Remote Port protocol.
> Creates a dedicated thread to manage the communication lifecycle.
> This includes logic to read packets and manage RX queue.
> 
> Patch also implements handshake logic to verify protocol
> versions and negotiate capabilities with remote peer.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  hw/core/remote-port.c         | 190 ++++++++++++++++++++++++++++++++++
>  include/hw/core/remote-port.h |  22 ++++
>  2 files changed, 212 insertions(+)
> 
> diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> index 5154c1bc2a..91b0682884 100644
> --- a/hw/core/remote-port.c
> +++ b/hw/core/remote-port.c
> @@ -52,6 +52,88 @@
>  #define REMOTE_PORT_CLASS(klass)    \
>       OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
>  
> +static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
> +{
> +    qemu_hexdump(stdout, prefix, buf, len);
> +}
> +
> +static void rp_fatal_error(RemotePort *s, const char *reason)
> +{
> +    error_report("%s: %s", s->prefix, reason);
> +    exit(EXIT_FAILURE);
> +}
> +
> +static ssize_t rp_recv(RemotePort *s, void *buf, size_t count)
> +{
> +    ssize_t r;
> +
> +    r = qemu_chr_fe_read_all(&s->chr, buf, count);
> +    if (r <= 0) {
> +        return r;
> +    }
> +    if (r != count) {
> +        error_report("%s: Bad read, expected %zd but got %zd",
> +                     s->prefix, count, r);
> +        rp_fatal_error(s, "Bad read");
> +    }
> +
> +    return r;
> +}
> +
> +ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
> +{
> +    ssize_t r;
> +
> +    qemu_mutex_lock(&s->write_mutex);
> +    r = qemu_chr_fe_write_all(&s->chr, buf, count);
> +    qemu_mutex_unlock(&s->write_mutex);
> +    assert(r == count);
> +    if (r <= 0) {
> +        error_report("%s: Disconnected r=%zd buf=%p count=%zd",
> +                     s->prefix, r, buf, count);
> +        rp_fatal_error(s, "Bad write");
> +    }
> +    return r;
> +}
> +
> +static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
> +{
> +    s->peer.version = pkt->hello.version;
> +    if (pkt->hello.version.major != RP_VERSION_MAJOR) {
> +        error_report("remote-port version missmatch remote=%d.%d local=%d.%d",
> +                      pkt->hello.version.major, pkt->hello.version.minor,
> +                      RP_VERSION_MAJOR, RP_VERSION_MINOR);
> +        rp_fatal_error(s, "Bad version");
> +    }
> +
> +    if (pkt->hello.caps.len) {
> +        void *caps = (char *) pkt + pkt->hello.caps.offset;
> +
> +        rp_process_caps(&s->peer, caps, pkt->hello.caps.len);
> +    }
> +}
> +
> +static void rp_say_hello(RemotePort *s)
> +{
> +    struct rp_pkt_hello pkt;
> +    uint32_t caps[] = {
> +        CAP_BUSACCESS_EXT_BASE,
> +        CAP_BUSACCESS_EXT_BYTE_EN,
> +        CAP_WIRE_POSTED_UPDATES,
> +        CAP_ATS,
> +    };
> +    size_t len;
> +
> +    len = rp_encode_hello_caps(s->current_id++, 0, &pkt, RP_VERSION_MAJOR,
> +                               RP_VERSION_MINOR,
> +                               caps, caps, sizeof caps / sizeof caps[0]);
> +    rp_write(s, (void *) &pkt, len);
> +
> +    if (sizeof caps) {
> +        rp_write(s, caps, sizeof caps);
> +    }
> +}
> +
>  static char *rp_sanitize_prefix(RemotePort *s)
>  {
>      char *sanitized_name;
> @@ -105,6 +187,108 @@ static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
>      return chr;
>  }
>  
> +static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
> +{
> +    struct rp_pkt *pkt = dpkt->pkt;
> +
> +    D(qemu_log("%s: cmd=%x id=%d dev=%d\n", __func__, pkt->hdr.cmd,
> +             pkt->hdr.id, pkt->hdr.dev));

This kind of thing feels better suited to being implement with
QEMU tracepoints.

> +
> +    if (pkt->hdr.dev >= ARRAY_SIZE(s->devs)) {
> +        /* FIXME: Respond with an error.  */
> +        return true;
> +    }
> +
> +    switch (pkt->hdr.cmd) {
> +    case RP_CMD_hello:
> +        rp_cmd_hello(s, pkt);
> +        break;
> +    case RP_CMD_read:
> +    case RP_CMD_write:
> +    case RP_CMD_interrupt:
> +    case RP_CMD_ats_req:
> +    case RP_CMD_ats_inv:
> +        /* TBD */;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    return false;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


