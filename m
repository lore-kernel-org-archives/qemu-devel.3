Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A322BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRE0q-00087t-H4; Tue, 09 Jul 2024 12:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRE0p-000872-1H
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRE0n-000525-7Z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720543695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOEIMAMP/0J5WABOUJtCCyKZtgwP+NSk+WseQw6WNjc=;
 b=MhJyZCWgvyehhkKPo8QMwIXB1RB4rj3Rz+yv8W/V/RiEEUrI5Y/1NPUgKM5e3eOzX1nyRi
 6nFLZsgsJswk06+Vp4A870cmK/QaKNcl+hdyKq/Cy77SwwQNvBgptGCtiby6gOLyAHks9x
 DtgaQpW2C6U+vKZEzUmRAbzl0OVmn84=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-HQ-A14CWPlC4WDuH3ZsV6A-1; Tue,
 09 Jul 2024 12:48:12 -0400
X-MC-Unique: HQ-A14CWPlC4WDuH3ZsV6A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1178A1956046; Tue,  9 Jul 2024 16:48:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3175A3000183; Tue,  9 Jul 2024 16:48:08 +0000 (UTC)
Date: Tue, 9 Jul 2024 17:48:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qdev-monitor: QAPIfy QMP device_add
Message-ID: <Zo1pxag7rYg_3D6j@redhat.com>
References: <20240708143027.480821-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708143027.480821-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 08, 2024 at 04:30:27PM +0200, Stefan Hajnoczi wrote:
> The QMP device_add monitor command converts the QDict arguments to
> QemuOpts and then back again to QDict. This process only supports scalar
> types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> array of objects) are silently dropped by qemu_opts_from_qdict() during
> the QemuOpts conversion even though QAPI is capable of validating them.
> As a result, hotplugging virtio-blk-pci devices with the
> iothread-vq-mapping property does not work as expected (the property is
> ignored). It's time to QAPIfy QMP device_add!
> 
> Get rid of the QemuOpts conversion in qmp_device_add() and call
> qdev_device_add_from_qdict() with from_json=true. Using the QMP
> command's QDict arguments directly allows non-scalar properties.
> 
> The HMP is also adjusted since qmp_device_add()'s now expects properly
> typed JSON arguments and cannot be used from HMP anymore. Move the code
> that was previously in qmp_device_add() (with QemuOpts conversion and
> from_json=false) into hmp_device_add() so that its behavior is
> unchanged.
> 
> This patch changes the behavior of QMP device_add but not HMP
> device_add. QMP clients that sent incorrectly typed device_add QMP
> commands no longer work. This is a breaking change but clients should be
> using the correct types already. See the netdev_add QAPIfication in
> commit db2a380c8457 for similar reasoning.
> 
> Markus helped me figure this out and even provided a draft patch. The
> code ended up very close to what he suggested.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/qdev-monitor.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)

I think we're justified in saying that applications should have been
using the correct types already.

On the libvirt side we already switched to using JSON for -device,
which has forced us to ensure we're using the correct types. So
the risk of converting device_add is minimal from libvirt's POV.

Other non-libvirt mgmt apps might get tripped up. Fixing those
should not be too difficult and fixed code would remain compatible
with older QEMU versions too.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d66..1427aa173c 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -849,18 +849,9 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
>  
>  void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>  {
> -    QemuOpts *opts;
>      DeviceState *dev;
>  
> -    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
> -    if (!opts) {
> -        return;
> -    }
> -    if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
> -        qemu_opts_del(opts);
> -        return;
> -    }
> -    dev = qdev_device_add(opts, errp);
> +    dev = qdev_device_add_from_qdict(qdict, true, errp);
>      if (!dev) {
>          /*
>           * Drain all pending RCU callbacks. This is done because
> @@ -872,8 +863,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>           * to the user
>           */
>          drain_call_rcu();
> -
> -        qemu_opts_del(opts);
>          return;
>      }
>      object_unref(OBJECT(dev));
> @@ -967,8 +956,34 @@ void qmp_device_del(const char *id, Error **errp)
>  void hmp_device_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> +    QemuOpts *opts;
> +    DeviceState *dev;
>  
> -    qmp_device_add((QDict *)qdict, NULL, &err);
> +    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &err);
> +    if (!opts) {
> +        goto out;
> +    }
> +    if (qdev_device_help(opts)) {
> +        qemu_opts_del(opts);
> +        return;
> +    }
> +    dev = qdev_device_add(opts, &err);
> +    if (!dev) {
> +        /*
> +         * Drain all pending RCU callbacks. This is done because
> +         * some bus related operations can delay a device removal
> +         * (in this case this can happen if device is added and then
> +         * removed due to a configuration error)
> +         * to a RCU callback, but user might expect that this interface
> +         * will finish its job completely once qmp command returns result
> +         * to the user
> +         */
> +        drain_call_rcu();
> +
> +        qemu_opts_del(opts);
> +    }
> +    object_unref(OBJECT(dev));
> +out:
>      hmp_handle_error(mon, err);
>  }
>  
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


