Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278BC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchoC-0008Nz-7T; Wed, 21 Feb 2024 03:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcho5-0008N4-Ag
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcho3-0001Up-Qj
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708503499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWL4amZhA6Tx0uaapwvU+/203Fs6lJZqVHFHDaWk19E=;
 b=M58iJZNJpEVg7eiL6RhiDhhlXi46sOG0SiSxB45/tqPDRKWxmZ1OvFyx6FaGpWASdNSNnx
 mr7U8CgKmVtr7KROOY4vcmPwFXEt+E4P2RQkFAZ3zroBhU2USd5TxiQm1DWmIjmasKUa9L
 CVHFdYyazECUU+XlJYKVlQoCsrAAVu4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-mek8KUImNu2L2N8BSM40Hg-1; Wed,
 21 Feb 2024 03:18:16 -0500
X-MC-Unique: mek8KUImNu2L2N8BSM40Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 240E41C04B70;
 Wed, 21 Feb 2024 08:18:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF63F1C1A803;
 Wed, 21 Feb 2024 08:18:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E21F521E66C8; Wed, 21 Feb 2024 09:18:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v6 15/15] hw/qdev: Remove opts member
In-Reply-To: <20240220-reuse-v6-15-2e42a28b0cf2@daynix.com> (Akihiko Odaki's
 message of "Tue, 20 Feb 2024 21:24:50 +0900")
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-15-2e42a28b0cf2@daynix.com>
Date: Wed, 21 Feb 2024 09:18:14 +0100
Message-ID: <87sf1mz0vt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> It is no longer used.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/qdev-core.h |  4 ----
>  hw/core/qdev.c         |  1 -
>  system/qdev-monitor.c  | 12 +++++++-----
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9228e96c87e9..5954404dcbfe 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -237,10 +237,6 @@ struct DeviceState {
>       * @pending_deleted_expires_ms: optional timeout for deletion events
>       */
>      int64_t pending_deleted_expires_ms;
> -    /**
> -     * @opts: QDict of options for the device
> -     */
> -    QDict *opts;
>      /**
>       * @hotplugged: was device added after PHASE_MACHINE_READY?
>       */
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c68d0f7c512f..7349c9a86be8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
>          dev->canonical_path =3D NULL;
>      }
>=20=20
> -    qobject_unref(dev->opts);
>      g_free(dev->id);
>  }
>=20=20
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index a13db763e5dd..71c00f62ee38 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *=
opts,
>      char *id;
>      DeviceState *dev =3D NULL;
>      BusState *bus =3D NULL;
> +    QDict *properties;
>=20=20
>      driver =3D qdict_get_try_str(opts, "driver");
>      if (!driver) {
> @@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict=
 *opts,
>      }
>=20=20
>      /* set properties */
> -    dev->opts =3D qdict_clone_shallow(opts);
> -    qdict_del(dev->opts, "driver");
> -    qdict_del(dev->opts, "bus");
> -    qdict_del(dev->opts, "id");
> +    properties =3D qdict_clone_shallow(opts);
> +    qdict_del(properties, "driver");
> +    qdict_del(properties, "bus");
> +    qdict_del(properties, "id");
>=20=20
> -    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_=
json,
> +    object_set_properties_from_keyval(&dev->parent_obj, properties, from=
_json,
>                                        errp);
> +    qobject_unref(properties);
>      if (*errp) {
>          goto err_del_dev;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Depends on the previous few patches, of course.


