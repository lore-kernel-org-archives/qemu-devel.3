Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLGK-0000O8-6H; Mon, 27 Oct 2025 07:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vDLFx-00087h-VN
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vDLFs-0000r5-1o
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761563951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vErUxyhXqserEUgdjTw80akRS1kN7Ws+L+HgWoBMfWM=;
 b=hiOK3Jywn2ZpDJ4RWpDO8YvM+bquJhKkbi9ekMP1kl0yGgSvePpHKZ7zaCjLA+loKh1sMM
 hZFATYmKfCe+65G8PlBSfkukx4aduScJtH5jDrtN5d27dRqHt1a9n3HiLZVggUBeyzyMvZ
 3xbPK6JIIlrNCyeo6GuA1IacJ3PqWZg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Pji8yPMVOM2YWKNZgRx_Yg-1; Mon,
 27 Oct 2025 07:19:06 -0400
X-MC-Unique: Pji8yPMVOM2YWKNZgRx_Yg-1
X-Mimecast-MFC-AGG-ID: Pji8yPMVOM2YWKNZgRx_Yg_1761563944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4133D19560B5; Mon, 27 Oct 2025 11:19:03 +0000 (UTC)
Received: from localhost (dhcp-192-179.str.redhat.com [10.33.192.179])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CB91180035A; Mon, 27 Oct 2025 11:19:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter
 Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Fabiano
 Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Arun
 Menon <armenon@redhat.com>
Subject: Re: [PATCH] migration: Fix regression of passing error_fatal into
 vmstate_load_state()
In-Reply-To: <20251024-solve_error_fatal_regression-v1-1-d26e6cbd0a7e@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251024-solve_error_fatal_regression-v1-1-d26e6cbd0a7e@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 27 Oct 2025 12:18:58 +0100
Message-ID: <87v7k0twwt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 24 2025, Arun Menon <armenon@redhat.com> wrote:

> error_fatal is passed to vmstate_load_state() and vmstate_save_state()
> functions. This was introduced in commit c632ffbd74. This would exit(1)
> on error, and therefore does not allow to propagate the error back to
> the caller.
>
> To maintain consistency with prior error handling i.e. either propagating
> the error to the caller or reporting it, we must set the error within a
> local Error object instead of using error_fatal.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 20 ++++++++++++++------
>  hw/pci/pci.c            | 13 +++++++++++--
>  hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
>  hw/scsi/spapr_vscsi.c   |  9 +++++++--
>  hw/virtio/virtio-mmio.c | 15 +++++++++++++--
>  hw/virtio/virtio-pci.c  | 15 +++++++++++++--
>  hw/virtio/virtio.c      | 10 +++++++---
>  7 files changed, 78 insertions(+), 19 deletions(-)
>

(...)

> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 4cb1ced001ae241c53c503ebfd7c90e336799c37..41c7d62a482de3c618e71dd07c0cd23e1bcd5578 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1130,13 +1130,24 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
>  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
> +    int ret;
> +    Error *local_err = NULL;
> +    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>  }
>  
>  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> +    int ret;
> +    Error *local_err = NULL;
> +    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
>  
>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)

I was wondering whether it would make sense to pass the error object in
VirtioBusClass's ->{load,save}_config instead, but it seems virtio-ccw
is the only one using that pattern there (virtio-mmio and virtio-pci are
doing that dance in their ->{load,save}_extra_state callbacks); so let's
just do it this way and think about more error object passing later.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


