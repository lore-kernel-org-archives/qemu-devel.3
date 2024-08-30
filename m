Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC3CA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 07:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjw58-0004ou-3s; Fri, 30 Aug 2024 03:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjw53-0004nk-1f
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjw50-00025V-FH
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725002995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYrJhZJMTc7HPFVtI1HRNwD9m6Xdox65fH3WYv6dS/Y=;
 b=bPvxn9tMF08fIPAzy7fonpy5A6hyhdgTT1SYagfugzLLhyKI55uAzMH8dyJCZ3SjIMHv0z
 pZQD6xFehXTGYbNMQvq/Bbuzx+DUFcQhnl9V9x+7fHmzjCzw3S2X3fT67aqFmYkvKq58qV
 IxNi0aIm7Pl9R60mscoHJ5tz/hNqca0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-fHDbosKPPRWLsI2ugguGMg-1; Fri,
 30 Aug 2024 03:29:51 -0400
X-MC-Unique: fHDbosKPPRWLsI2ugguGMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAD5E1955BEE; Fri, 30 Aug 2024 07:29:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BFE719560AE; Fri, 30 Aug 2024 07:29:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C874621E6A28; Fri, 30 Aug 2024 09:29:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,
 pkrempa@redhat.com,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
In-Reply-To: <20240827192751.948633-2-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 27 Aug 2024 15:27:50 -0400")
References: <20240827192751.948633-1-stefanha@redhat.com>
 <20240827192751.948633-2-stefanha@redhat.com>
Date: Fri, 30 Aug 2024 09:29:47 +0200
Message-ID: <87o75ah3is.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Markus helped me figure this out and even provided a draft patch. The
> code ended up very close to what he suggested.

Should we discuss the RCU draining issue here?

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/qdev-monitor.c | 44 ++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d66..26404f314d 100644
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
> @@ -872,11 +863,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data=
, Error **errp)
>           * to the user
>           */
>          drain_call_rcu();
> -
> -        qemu_opts_del(opts);
> -        return;

The removal of return gave me pause.  It's actually okay, because the
code we now execute in addition is a no-op: object_unref(NULL).

Matter of taste.

>      }
> -    object_unref(OBJECT(dev));
> +    object_unref(dev);

TIL that object_unref() takes a void *.

commit c5a61e5a3c68144a421117916aef04f2c0fab84b
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Mon Aug 31 17:07:23 2020 -0400

    qom: make object_ref/unref use a void * instead of Object *.
=20=20=20=20
    The object_ref/unref methods are intended for use with any subclass of
    the base Object. Using "Object *" in the signature is not adding any
    meaningful level of type safety, since callers simply use "OBJECT(ptr)"
    and this expands to an unchecked cast "(Object *)".
=20=20=20=20
    By using "void *" we enable the object_unref() method to be used to
    provide support for g_autoptr() with any subclass.
=20=20=20=20
    Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    Message-Id: <20200723181410.3145233-2-berrange@redhat.com>
    Message-Id: <20200831210740.126168-2-ehabkost@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

About 2 out of 3 callers still pass an OBJECT(...) argument.  Similar
for object_ref().

If we believe dropping the OBJECT() is an improvement, we should do it
globally.

Suggest not to touch it in this patch.

>  }
>=20=20
>  static DeviceState *find_device_state(const char *id, Error **errp)
> @@ -967,8 +955,34 @@ void qmp_device_del(const char *id, Error **errp)
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
> +    object_unref(dev);
> +out:
>      hmp_handle_error(mon, err);
>  }


