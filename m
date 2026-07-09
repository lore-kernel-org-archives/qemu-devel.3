Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37DBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1who3c-00047u-93; Thu, 09 Jul 2026 08:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1who3T-00047P-Qw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1who3R-0003NW-8b
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783600835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bJIhTuKBVJdL0iSe31SY0Zwq1/ReEDqkPDWUKBLh/w=;
 b=CEvOU1T4qidjKLxginFi3/3yryap425zETkyzk76to9lnd9I8CiFQZZFWToQutvh1IqJuV
 n+lvadAGLtKmdkSMM3dYmjYUrnYaMPDyUerA+N0ntJOvFRV1may8MxVZAA+yneJV9UGNWF
 IjaCTeOXAuF56YP3pIDT4KTiu/fqgKw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-jwPFNhxWPsS6eQ4bBjFfcg-1; Thu, 09 Jul 2026 08:40:33 -0400
X-MC-Unique: jwPFNhxWPsS6eQ4bBjFfcg-1
X-Mimecast-MFC-AGG-ID: jwPFNhxWPsS6eQ4bBjFfcg_1783600832
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47416fc1674so2157181f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783600832; x=1784205632; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3bJIhTuKBVJdL0iSe31SY0Zwq1/ReEDqkPDWUKBLh/w=;
 b=PgiBuO4Z45NHMPsRJ6uZrtVuL/ltt9+YrBe6sPYp3WGYmPkQ8Fu1mf08h5h+8wSXH9
 RLZKcW4ZWDXuv3HVuteVXsnVRH4bqdXN4pYmEZiFFsMePQSRt+2ACQZxp5m15M177P5I
 5zBv8t5I0K8qghB9whHX/84mVXIXx/iqQcD6RfE9XTt0XVtDy9YCZyiXwaH4TZG7DWa6
 2J9dEKD7svxG+6RcN/kRUQ8QgMGR1loSUNzXSd2UZbuPYxbUUXdidQjHWmyxDnm5cY6b
 BsJaRLh7XzP2FiRi4RSsYF4iDTRd+/w0tAWN3a27NStEPJfZN/Sv4pk8IR4+FhyO7nVR
 8CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600832; x=1784205632;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3bJIhTuKBVJdL0iSe31SY0Zwq1/ReEDqkPDWUKBLh/w=;
 b=ZdzIsqKy0aC5uF9xIV0p3jnS2zlqlRmcPeXQZ7cq3UYVt0U/7eA6jUKdPrYF7yqy1m
 XW71lN45AMLykFNA3+9Y0wErF/Halq++IZcSQc28ARjQsSj9MFOn42h1FN7kivpi0szn
 JwWwMboHFtdMuee9XbYL9+YnWfCP4zKf3FVyC9ngp7cP91XgLfZbCyo7aOyBbnfAvqBu
 oac8nWaEr8/v/CR1MO9Z8cb7KqZZFlB3dWNKoqaemi/FWJIVqzI/211Z/+xG+NEVdNiJ
 h064yoFue7JUT7liP1kJ+JuTOceLjNXGja94fEvNrwTdTIVNvNtLpCfK4sfgMSVbbzQX
 bdMw==
X-Gm-Message-State: AOJu0Yyg6LY6VwDaX9I7KPPD3CZdZ1gmT7R9Ol89F9jqSbzfV6fgkKbD
 Tak8+S9CmMYlskd4awPkDI4B7X7E5VAArBT7RYys8EjGOgvPJZXfEMc0MxqB9gh2G4A5v1sTfn5
 n2teAKhDKgnHIRBH5rc0N/6iTMQWc/eigC+O8pkPEO31G8mqHVJDuqeOM
X-Gm-Gg: AfdE7cn7QzvpPyegD+M5reUO4SC0+mJrkjKaxJ5I63sAp8HT4EAsAj4tHIw10lEadN6
 RmJVba5ZrXa900vHnG4sX09og/L/DnXTJRUTTglr96X0V3vDkHn4LbbnGhIpLagiXwdm8z5Cb93
 TkFXaa7FJ5hR1SlWiFbwYiApEITYmVAsgcotMjIVpt294T1UeLLjZ6I3UuO1dIy3fB+k+uDI7IL
 UZThCdzI20rA2oKKqkqQRtenWov9DJMWYAj6n+asB/zluDzlJcNV3kC9RZ228Wjo3HToDdJqWdz
 0D+R0rf5RVl7jlN+BFuRkXEyU9mZ8C3s+CSbEZriksGNCwDCsn6tq/rKnK+L/aFgENitnUvKykB
 CRtcHCCnFI+6wiK0fn5RsBJWfdK1R0d7v
X-Received: by 2002:a05:6000:2081:b0:473:cf28:a23e with SMTP id
 ffacd0b85a97d-47df075564dmr8251283f8f.19.1783600832138; 
 Thu, 09 Jul 2026 05:40:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2081:b0:473:cf28:a23e with SMTP id
 ffacd0b85a97d-47df075564dmr8251228f8f.19.1783600831686; 
 Thu, 09 Jul 2026 05:40:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm51209729f8f.13.2026.07.09.05.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:40:31 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:40:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Amit Shah <amit@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/virtio: return NULL from qemu_get_virtqueue_element()
 on invalid state
Message-ID: <20260709083651-mutt-send-email-mst@kernel.org>
References: <20260709100644.1878369-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100644.1878369-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 09, 2026 at 12:06:44PM +0200, Laurent Vivier wrote:
> qemu_get_virtqueue_element() uses assert() to check that the in_num
> and out_num fields deserialized from the migration stream do not
> exceed VIRTQUEUE_MAX_SIZE. A crafted migration stream can set these
> fields to invalid values, hitting the assertion and aborting the
> destination QEMU process.
> 
> Replace the assertions with a bounds check that returns NULL on
> failure. Update all callers (virtio-serial-bus, virtio-blk,
> virtio-scsi) to handle the NULL return and fail the migration
> gracefully.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6bdc21c050a2 ("virtio: fix up max size checks")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3802
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/block/virtio-blk.c       |  4 ++++
>  hw/char/virtio-serial-bus.c |  3 +++
>  hw/scsi/virtio-scsi.c       |  4 ++++
>  hw/virtio/virtio.c          | 11 ++++-------
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 6b92066aff4c..42c0f2553f18 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>          }
>  
>          req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
> +        if (!req) {
> +            return -EINVAL;
> +        }
> +
>          virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
>  
>          WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index c1973f0248fc..879df158608a 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -763,6 +763,9 @@ static int fetch_active_ports_list(QEMUFile *f,
>  
>              port->elem =
>                  qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
> +            if (!port->elem) {
> +                return -EINVAL;
> +            }
>  
>              /*
>               *  Port was throttled on source machine.  Let's
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 6c7376801190..8dd0b88a30c4 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>      assert(n < vs->conf.num_queues);


I mean just above this we have this assert.


If you are really want to be nicer about handling
malformed input, pls do this systematically, not just
at random places for no apparent reason.


>      req = qemu_get_virtqueue_element(vdev, f,
>                                       sizeof(VirtIOSCSIReq) + vs->cdb_size);
> +    if (!req) {
> +        return NULL;
> +    }
> +
>      virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
>  
>      if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a365530..7bccfdde33e7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2167,13 +2167,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
>  
>      qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
>  
> -    /* TODO: teach all callers that this can fail, and return failure instead
> -     * of asserting here.
> -     * This is just one thing (there are probably more) that must be
> -     * fixed before we can allow NDEBUG compilation.
> -     */
> -    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
> -    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
> +    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
> +        data.out_num > ARRAY_SIZE(data.out_addr)) {
> +        return NULL;
> +    }
>  
>      elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
>      elem->index = data.index;
> -- 
> 2.54.0


