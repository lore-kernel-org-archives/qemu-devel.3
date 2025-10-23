Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ADDCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBttx-0007YD-O4; Thu, 23 Oct 2025 07:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBtts-0007DI-6g
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBttp-0002jA-Gy
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761220472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZZr63NIUe+8BmFvq0yS3qOihBbOcrnesFIvraTfKIc=;
 b=Vdcd8FgALDntpABinqqMRw2W9y0ee1zzOOudodRhrfPkk44onUnQaEds/Ss0Mib/4q4K1b
 EUojM2M88aoy5asGdrLg03m7UclqfDbQKD88u/ZmOqr58HaMOAO6i7FESAbd3wOikCh0mX
 BsVdB1tQqJwh7I2VinSla3Bxo0K841w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-iXZ8de5mPTWvu9FQcj7joA-1; Thu,
 23 Oct 2025 07:54:28 -0400
X-MC-Unique: iXZ8de5mPTWvu9FQcj7joA-1
X-Mimecast-MFC-AGG-ID: iXZ8de5mPTWvu9FQcj7joA_1761220467
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91C12180057A; Thu, 23 Oct 2025 11:54:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1249319540EB; Thu, 23 Oct 2025 11:54:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3177021E6A27; Thu, 23 Oct 2025 13:54:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 08/32] system: check security of device types
In-Reply-To: <20250926140144.1998694-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:19
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-9-berrange@redhat.com>
Date: Thu, 23 Oct 2025 13:54:24 +0200
Message-ID: <87bjlx7s0f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This wires up the DeviceClass types to have their
> security checked when devices are created.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  system/qdev-monitor.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 2ac92d0a07..520fe5c495 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -43,6 +43,8 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/clock.h"
>  #include "hw/boards.h"
> +#include "qapi/compat-policy.h"
> +
>=20=20
>  /*
>   * Aliases were a bad idea from the start.  Let's keep them
> @@ -644,6 +646,13 @@ DeviceState *qdev_device_add_from_qdict(const QDict =
*opts,
>          return NULL;
>      }
>=20=20
> +    if (!compat_policy_check_security(&compat_policy,
> +                                      object_class_get_name(OBJECT_CLASS=
(dc)),
> +                                      object_class_is_secure(OBJECT_CLAS=
S(dc)),
> +                                      errp)) {
> +        return NULL;
> +    }
> +
>      /* find bus */
>      path =3D qdict_get_try_str(opts, "bus");
>      if (path !=3D NULL) {

All users of compat_policy_check_security() in this series pass

    object_class_get_name(<the-object>),
    object_class_is_secure(<the-object>),

Have you considered passing just <the-object> instead?


