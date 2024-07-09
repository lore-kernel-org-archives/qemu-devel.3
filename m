Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBoc-0004tm-2i; Tue, 09 Jul 2024 10:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRBoa-0004fK-23
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRBoY-0002vV-5V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720535248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHymZ/8S1w6sSbKZaPpokV6jh2oq4br8wNw50Br8l2Y=;
 b=FTngqGEbCkD19sjPpSYQDAKPi9zM/IzYrs7aGV75oxklQJ7Sk/5yrC6NNGxLCQniMER4Yu
 MY0YWNdKRIAoFQwSg0oUU/WDeH4RDcOEA3S0EYw6lI51kpSryZKWc66EffiICdZ2FMNBPO
 OU+L1JufJBIhlpJvqJRXdspNiBsBKcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-923nEj02MyiKVo2vIU0mrA-1; Tue,
 09 Jul 2024 10:27:27 -0400
X-MC-Unique: 923nEj02MyiKVo2vIU0mrA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC329196E09B; Tue,  9 Jul 2024 14:27:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBAD53000184; Tue,  9 Jul 2024 14:27:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C355721E668B; Tue,  9 Jul 2024 16:27:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qdev-monitor: QAPIfy QMP device_add
In-Reply-To: <20240708143027.480821-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 8 Jul 2024 16:30:27 +0200")
References: <20240708143027.480821-1-stefanha@redhat.com>
Date: Tue, 09 Jul 2024 16:27:22 +0200
Message-ID: <87ttgyd4j9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> The QMP device_add monitor command converts the QDict arguments to
> QemuOpts and then back again to QDict. This process only supports scalar
> types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> array of objects) are silently dropped by qemu_opts_from_qdict() during
> the QemuOpts conversion even though QAPI is capable of validating them.
> As a result, hotplugging virtio-blk-pci devices with the
> iothread-vq-mapping property does not work as expected (the property is
> ignored). It's time to QAPIfy QMP device_add!

This patch doesn't fully QAPIfy device_add: we still lack a schema
and use 'gen': false.  It gets us closer, though.

> Get rid of the QemuOpts conversion in qmp_device_add() and call
> qdev_device_add_from_qdict() with from_json=3Dtrue. Using the QMP
> command's QDict arguments directly allows non-scalar properties.
>
> The HMP is also adjusted since qmp_device_add()'s now expects properly
> typed JSON arguments and cannot be used from HMP anymore. Move the code
> that was previously in qmp_device_add() (with QemuOpts conversion and
> from_json=3Dfalse) into hmp_device_add() so that its behavior is
> unchanged.
>
> This patch changes the behavior of QMP device_add but not HMP
> device_add. QMP clients that sent incorrectly typed device_add QMP
> commands no longer work. This is a breaking change but clients should be
> using the correct types already. See the netdev_add QAPIfication in
> commit db2a380c8457 for similar reasoning.

Another one is 9151e59a8b6e: it QAPIfied object-add.

Both commits eliminated the roundtrip through QemuOpts, and weaned the
command off 'gen': false.

This commit eliminates the roundtrip, but keeps 'gen': false.  Best we
can do now, but I'd like the commit message to make this clear.

> Markus helped me figure this out and even provided a draft patch. The
> code ended up very close to what he suggested.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/qdev-monitor.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d66..1427aa173c 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -849,18 +849,9 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
>=20=20
>  void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>  {
> -    QemuOpts *opts;
>      DeviceState *dev;
>=20=20
> -    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
> -    if (!opts) {
> -        return;
> -    }
> -    if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
> -        qemu_opts_del(opts);
> -        return;
> -    }
> -    dev =3D qdev_device_add(opts, errp);
> +    dev =3D qdev_device_add_from_qdict(qdict, true, errp);
>      if (!dev) {
>          /*
>           * Drain all pending RCU callbacks. This is done because
> @@ -872,8 +863,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
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
>      Error *err =3D NULL;
> +    QemuOpts *opts;
> +    DeviceState *dev;
>=20=20
> -    qmp_device_add((QDict *)qdict, NULL, &err);
> +    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &err);
> +    if (!opts) {
> +        goto out;
> +    }
> +    if (qdev_device_help(opts)) {
> +        qemu_opts_del(opts);
> +        return;
> +    }

The part above is moved from qmp_device_add().  The part below is
copied.  The duplication is a bid sad.  Could we factor it out into
qdev_device_add_from_qdict()?

> +    dev =3D qdev_device_add(opts, &err);
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

Have a look at this TODO in vl.c:

    QTAILQ_FOREACH(opt, &device_opts, next) {
        DeviceState *dev;
        loc_push_restore(&opt->loc);
        /*
         * TODO Eventually we should call qmp_device_add() here to make sur=
e it
         * behaves the same, but QMP still has to accept incorrectly typed
         * options until libvirt is fixed and we want to be strict on the C=
LI
         * from the start, so call qdev_device_add_from_qdict() directly for
         * now.
         */
        dev =3D qdev_device_add_from_qdict(opt->opts, true, &error_fatal);
        object_unref(OBJECT(dev));
        loc_pop(&opt->loc);
    }

Could we resolve it now?

Thanks for tackling this!


