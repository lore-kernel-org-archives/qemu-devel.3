Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA95ECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo61c-0002cp-83; Thu, 05 Feb 2026 15:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo61Y-0002cU-Px
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo61W-0001PO-PJ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770323541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZpVVUAkPC018T868g3KU1t6VILN6TWL7aSsGg1mQl8Y=;
 b=EsACmw+B7JLoD0WKA7okE6HQ1dmzECNQLRshQGx3GY1riIMhTyYCxwMZbwoHdt8mS3PAnb
 WdEWIO7THf5DBGRR49/jKbf/KTF8qesdPfXnmFfFob+YE5s3pEHFQfadq7Sdh+A3WIpo+6
 0Fs3BVjVfEqdOzBTb2HOIBfa1moIW5E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-BKZIvN-OM0SyDq4oF278kA-1; Thu,
 05 Feb 2026 15:32:10 -0500
X-MC-Unique: BKZIvN-OM0SyDq4oF278kA-1
X-Mimecast-MFC-AGG-ID: BKZIvN-OM0SyDq4oF278kA_1770323529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB21C1956070; Thu,  5 Feb 2026 20:32:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8BDF300DDA6; Thu,  5 Feb 2026 20:32:04 +0000 (UTC)
Date: Thu, 5 Feb 2026 20:32:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 10/29] hw/core: Implement Remote Port packet dispatch logic
Message-ID: <aYT-QEM0NBFWNEDI@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-11-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205195824.2610192-11-ruslichenko.r@gmail.com>
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

On Thu, Feb 05, 2026 at 08:58:05PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> Implement the mechanism to transfer packets from the dedicated
> protocol thread to the main QEMU execution loop for processing.
> 
> The patch adds the following features:
> - signaling logic using internal pipe to wake up the main loop
> - the rp_process handler, which retrieves packets from queue and
> dispatches them to the target Remote Port device.
> 
> This enables QEMU device models to handle remote events.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  hw/core/remote-port.c         | 148 +++++++++++++++++++++++++++++++++-
>  include/hw/core/remote-port.h |   5 ++
>  2 files changed, 152 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
> index 91b0682884..e44d9249c3 100644
> --- a/hw/core/remote-port.c
> +++ b/hw/core/remote-port.c
> @@ -52,6 +52,8 @@
>  #define REMOTE_PORT_CLASS(klass)    \
>       OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
>  
> +static void rp_event_read(void *opaque);
> +
>  static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
>  {
>      qemu_hexdump(stdout, prefix, buf, len);
> @@ -96,6 +98,12 @@ ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
>      return r;
>  }
>  
> +static unsigned int rp_has_work(RemotePort *s)
> +{
> +    unsigned int work = s->rx_queue.wpos - s->rx_queue.rpos;
> +    return work;
> +}
> +
>  static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
>  {
>      s->peer.version = pkt->hello.version;
> @@ -187,6 +195,135 @@ static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
>      return chr;
>  }
>  
> +void rp_process(RemotePort *s)
> +{
> +    while (true) {
> +        struct rp_pkt *pkt;
> +        unsigned int rpos;
> +        bool actioned = false;
> +        RemotePortDevice *dev;
> +        RemotePortDeviceClass *rpdc;
> +
> +        qemu_mutex_lock(&s->rsp_mutex);
> +        if (!rp_has_work(s)) {
> +            qemu_mutex_unlock(&s->rsp_mutex);
> +            break;
> +        }
> +        rpos = s->rx_queue.rpos;
> +
> +        pkt = s->rx_queue.pkt[rpos].pkt;
> +        D(qemu_log("%s: io-thread rpos=%d wpos=%d cmd=%d dev=%d\n",
> +                 s->prefix, s->rx_queue.rpos, s->rx_queue.wpos,
> +                 pkt->hdr.cmd, pkt->hdr.dev));

Same point as last patch, that emitted structured data in
tracepoints is preferrable to merely logging. Consider this
to apply to any other qemu_log call, so I won't repeat it
every time.

> +
> +        /*
> +         * To handle recursiveness, we need to advance the index
> +         * index before processing the packet.
> +         */
> +        s->rx_queue.rpos++;
> +        s->rx_queue.rpos %= ARRAY_SIZE(s->rx_queue.pkt);
> +        qemu_mutex_unlock(&s->rsp_mutex);
> +
> +        dev = s->devs[pkt->hdr.dev];
> +        if (dev) {
> +            rpdc = REMOTE_PORT_DEVICE_GET_CLASS(dev);
> +            if (rpdc->ops[pkt->hdr.cmd]) {
> +                rpdc->ops[pkt->hdr.cmd](dev, pkt);
> +                actioned = true;
> +            }
> +        }
> +
> +        switch (pkt->hdr.cmd) {
> +        /* TBD */
> +        default:
> +            assert(actioned);
> +        }
> +
> +        s->rx_queue.inuse[rpos] = false;
> +        qemu_sem_post(&s->rx_queue.sem);
> +    }
> +}
> +
> +static void rp_event_read(void *opaque)
> +{
> +    RemotePort *s = REMOTE_PORT(opaque);
> +    unsigned char buf[32];
> +    ssize_t r;
> +
> +    /* We don't care about the data. Just read it out to clear the event.  */
> +    do {
> +#ifdef _WIN32
> +        r = qemu_recv_wrap(s->event.pipe.read, buf, sizeof buf, 0);
> +#else
> +        r = read(s->event.pipe.read, buf, sizeof buf);
> +#endif
> +        if (r == 0) {
> +            return;
> +        }
> +    } while (r == sizeof buf || (r < 0 && errno == EINTR));
> +
> +    rp_process(s);
> +}
> +
> +static void rp_event_notify(RemotePort *s)
> +{
> +    unsigned char d = 0;
> +    ssize_t r;
> +
> +#ifdef _WIN32
> +    /* Mingw is sensitive about doing write's to socket descriptors.  */
> +    r = qemu_send_wrap(s->event.pipe.write, &d, sizeof d, 0);
> +#else
> +    r = qemu_write_full(s->event.pipe.write, &d, sizeof d);
> +#endif
> +    if (r == 0) {
> +        hw_error("%s: pipe closed\n", s->prefix);
> +    }
> +}
> +
> +/* Handover a pkt to CPU or IO-thread context.  */
> +static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
> +{
> +    bool full;
> +
> +    /*
> +     * Take the rsp lock around the wpos update, otherwise
> +     * rp_wait_resp will race with us.
> +     */
> +    qemu_mutex_lock(&s->rsp_mutex);
> +    s->rx_queue.wpos++;
> +    s->rx_queue.wpos %= ARRAY_SIZE(s->rx_queue.pkt);
> +    /*
> +     * Ensure rx_queue index update is visible to consumer
> +     * before signaling event, to prevent lost wakeup
> +     */
> +    smp_mb();
> +    rp_event_notify(s);
> +    qemu_cond_signal(&s->progress_cond);
> +    qemu_mutex_unlock(&s->rsp_mutex);
> +
> +    do {
> +        full = s->rx_queue.inuse[s->rx_queue.wpos];
> +        if (full) {
> +            qemu_log("%s: FULL rx queue %d\n", __func__, s->rx_queue.wpos);
> +        if (qemu_sem_timedwait(&s->rx_queue.sem, 2 * 1000) != 0) {
> +#ifndef _WIN32
> +                int sval;
> +
> +#ifndef CONFIG_SEM_TIMEDWAIT
> +                sval = s->rx_queue.sem.count;
> +#else
> +                sem_getvalue(&s->rx_queue.sem.sem, &sval);
> +#endif
> +                qemu_log("semwait: %d rpos=%u wpos=%u\n", sval,
> +                         s->rx_queue.rpos, s->rx_queue.wpos);
> +#endif
> +                qemu_log("Deadlock?\n");
> +        }
> +        }
> +    } while (full);
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


