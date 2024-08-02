Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C517FC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnEE-0008Jh-RS; Fri, 02 Aug 2024 04:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnEC-0008Ig-Mn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnEA-0004xy-CF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722585688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/sTUvm1SB+z7dTfDlvvhnjSHGNpwLqP2R3D/TauNp4=;
 b=MRU/B3E8Ggw92OlRjAUKeS47bg2ORBh8SlwPZOrGElOyZ5w64KxuzwAXcsMDUSpjcBrh6y
 bvAk72LybqqG4ZuZFThu9n42fjyZwn7PgzvMB3AheKJFa+mO3iQQ7mRtFRID2+drj6ivSE
 JgFJfPtxJpY/pfoJofdnM+aNY9foz8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-5XTNc4Y5O4mPUY-wUXPyBg-1; Fri,
 02 Aug 2024 04:01:25 -0400
X-MC-Unique: 5XTNc4Y5O4mPUY-wUXPyBg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A094195421A; Fri,  2 Aug 2024 08:01:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBF60300018D; Fri,  2 Aug 2024 08:01:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9085421E6682; Fri,  2 Aug 2024 10:01:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  pkrempa@redhat.com,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
In-Reply-To: <20240801140552.1021693-2-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Thu, 1 Aug 2024 10:05:51 -0400")
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <20240801140552.1021693-2-stefanha@redhat.com>
Date: Fri, 02 Aug 2024 10:01:20 +0200
Message-ID: <875xsj73qn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> ignored).
>
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
> commit db2a380c8457 for similar reasoning and object-add in commit
> 9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
> for the time being.
>
> Move the drain_call_rcu() invocation into qdev_device_add_from_qdict()
> so all callers benefit from it automatically. This avoids code
> duplication.
>
> Markus helped me figure this out and even provided a draft patch. The
> code ended up very close to what he suggested.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/qdev-monitor.c | 56 ++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d66..8a756b1a91 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -725,6 +725,17 @@ err_del_dev:
>      if (dev) {
>          object_unparent(OBJECT(dev));
>          object_unref(OBJECT(dev));
> +
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
>      }
>      return NULL;
>  }

Moving this from qmp_device_add() adds RCU draining to call chains not
going through qmp_device_add().

Can adding it hurt?  I guess it can't.

Can it fix bugs?  I don't know.

Let's review the callers of qdev_device_add_from_qdict():

* qdev_device_add()

  - called from qmp_device_add()

    No change.

  - called from device_init_func() called from qemu_create_cli_devices()

    See below.

  - called from usbback_portid_add() called from usbback_process_port()
    called from usbback_backend_changed()

    =C2=B7 called from usbback_init()

    =C2=B7 called as XenDevOps method backend_changed()

    This is Xen.  We now drain pending RCU callbacks.  Impact?  Beats
    me.

* qemu_create_cli_devices() called from qmp_x_exit_preconfig()

  - as QMP command with -preconfig, phase must be
    PHASE_MACHINE_INITIALIZED

  - called from qemu_init() without -preconfig

  We now drain pending RCU callbacks.  Can any be pending at this
  early point?  If not, the change is a no-op.

* failover_add_primary() called from virtio_net_set_features() called as
  VirtioDeviceClass method set_features()

  This is virtio-net failover.  We now drain pending RCU callbacks.
  Impact?  Beats me.

My gut feeling is "improvement, possibly even a bug fix".  It deserves
its own commit, doesn't it?

> @@ -849,34 +860,10 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
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
> -    if (!dev) {
> -        /*
> -         * Drain all pending RCU callbacks. This is done because
> -         * some bus related operations can delay a device removal
> -         * (in this case this can happen if device is added and then
> -         * removed due to a configuration error)
> -         * to a RCU callback, but user might expect that this interface
> -         * will finish its job completely once qmp command returns result
> -         * to the user
> -         */
> -        drain_call_rcu();
> -
> -        qemu_opts_del(opts);
> -        return;
> -    }
> -    object_unref(OBJECT(dev));
> +    dev =3D qdev_device_add_from_qdict(qdict, true, errp);
> +    object_unref(dev);
>  }
>=20=20
>  static DeviceState *find_device_state(const char *id, Error **errp)
> @@ -967,8 +954,23 @@ void qmp_device_del(const char *id, Error **errp)
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
> +    dev =3D qdev_device_add(opts, &err);
> +    if (!dev) {
> +        qemu_opts_del(opts);
> +    }
> +    object_unref(dev);
> +out:
>      hmp_handle_error(mon, err);
>  }

Remainder looks good to me.


