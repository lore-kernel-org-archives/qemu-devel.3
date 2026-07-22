Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506EEC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTcc-0006dX-P6; Wed, 22 Jul 2026 05:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmTcX-0006Ww-Fz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 05:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmTcV-00019G-7z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 05:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784713925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U8wdrXioiQU759OWlv63OOR3b8wxb4eN9XMZEAEZRIM=;
 b=YSaJcp8uITVCJUe/ju/BhLDaxOqW3bYSylzZGfUpRUfbj1S8yerREen3324to2O019xh82
 v22MhQUFV40skQx4CTdlvLnoKdRMyBKaA5m9qD/kH/HJiQK++VGwUjP18TzrblSjDV3Pji
 mqUEC38+pp5QeLc+6LgSR/jFnJrIcRo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-38HQwv5tOUSFXbywM3gQUA-1; Wed,
 22 Jul 2026 05:52:02 -0400
X-MC-Unique: 38HQwv5tOUSFXbywM3gQUA-1
X-Mimecast-MFC-AGG-ID: 38HQwv5tOUSFXbywM3gQUA_1784713921
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96DBA191DFFC; Wed, 22 Jul 2026 09:52:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8C13004082; Wed, 22 Jul 2026 09:51:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72D6C21E6920; Wed, 22 Jul 2026 11:51:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Corey Minyard <cminyard@mvista.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH v4] hw/i2c: Add remote I2C master with host CUSE bridge
In-Reply-To: <20260720173055.2468210-1-ilya.chichkov.dev@gmail.com> (Ilya
 Chichkov's message of "Mon, 20 Jul 2026 20:30:54 +0300")
References: <87pl10md1j.fsf@pond.sub.org>
 <20260720173055.2468210-1-ilya.chichkov.dev@gmail.com>
Date: Wed, 22 Jul 2026 11:51:57 +0200
Message-ID: <87fr1bl5c2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

We prefer revisions be posted as new threads.  Next time :)

Fails to build for me:

    [334/335] Generating docs/QEMU manual with a custom command
    FAILED: [code=1] docs/docs.stamp 
    /usr/bin/env CONFDIR=etc/qemu /work/armbru/qemu/bld-docs/pyvenv/bin/sphinx-build -q -j auto -W -Dkerneldoc_werror=1 -Dversion=11.0.90 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /work/armbru/qemu/bld-docs/docs/manual.p /work/armbru/qemu/docs /work/armbru/qemu/bld-docs/docs/manual
    /work/armbru/qemu/docs/system/devices/remote-i2c-master.rst: WARNING: document isn't included in any toctree [toc.not_included]

Should you add a reference to your new .rst to
docs/system/device-emulation.rst section "Emulated Devices"?

Ilya Chichkov <ilya.chichkov.dev@gmail.com> writes:

> Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> host system through a FUSE/CUSE character device. This lets external
> host programs and standard i2c-tools interact with I2C slaves emulated
> inside QEMU as if they were real devices attached to the host.
>
> The implementation is split into three layers:
>
>   - A non-blocking finite state machine that drives the QEMU I2C
>     master. It is pumped by a QEMU Bottom Half and uses virtual timers
>     to yield during long transfers and to model clock stretching for
>     asynchronous slaves, so the main loop is never blocked. The FSM
>     walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
>     and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
>     back-off and retry), stretch timeouts, and manual abort/reset.
>
>   - An abstract RemoteI2CBackend QOM base class that decouples the
>     internal I2C hardware state machine (the frontend) from any
>     host-specific transport, exposing on_tx_complete and on_tx_error
>     virtual callbacks.
>
>   - A concrete remote-i2c-backend-cuse backend implementing that
>     transport over CUSE. It manages the FUSE session and integrates
>     its file descriptors into QEMU's main AioContext event loop,
>     translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
>     generic byte streams for the FSM, and formats responses back into
>     Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
>     start is supported for atomic write-then-read operations.
>
> Example usage:
>
>   -device remote-i2c-master,i2cbus=i2c-bus.0,devname=i2c-33
>   -object remote-i2c-backend-cuse,id=b0,devname=i2c-33
>
> This creates /dev/i2c-33 on the host, usable with i2c-tools:
>
>   i2cdetect -y -l
>   i2cget -y <bus_id> <addr> <reg>
>
> Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087..1552103a4a 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1258,6 +1258,8 @@
>      'tls-creds-psk',
>      'tls-creds-x509',
>      'tls-cipher-suites',
> +    { 'name': 'remote-i2c-backend-cuse',
> +      'if': 'CONFIG_LINUX' },
>      { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
>      { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
>    ] }
> @@ -1334,6 +1336,8 @@
>        'tls-creds-psk':              'TlsCredsPskProperties',
>        'tls-creds-x509':             'TlsCredsX509Properties',
>        'tls-cipher-suites':          'TlsCredsProperties',
> +      'remote-i2c-backend-cuse':    { 'type': 'RemoteI2CBackendCuseProperties',
> +                                      'if': 'CONFIG_LINUX' },
>        'x-remote-object':            'RemoteObjectProperties',
>        'x-vfio-user-server':         'VfioUserServerProperties'
>    } }
> @@ -1377,3 +1381,27 @@
>  ##
>  { 'command': 'object-del', 'data': {'id': 'str'},
>    'allow-preconfig': true }
> +
> +##
> +# @RemoteI2CBackendCuseProperties:
> +#
> +# Properties for the CUSE remote I2C backend.  See
> +# :doc:`/system/devices/remote-i2c-master` for usage information.

Suggest "for detailed usage information."

> +#
> +# @devname: The name of the character device node to create under /dev
> +#     (e.g., 'i2c-33' creates /dev/i2c-33).  The node is accessible
> +#     via the standard Linux I2C device interface and usable directly
> +#     with i2c-tools and the Linux i2c-dev API.
> +#
> +# @fuse-opts: Options passed verbatim to the FUSE/CUSE session at
> +#     mount time, one option (or argument) per list element.  For
> +#     example ['-d'] enables debug tracing, and ['-o', 'allow_other']
> +#     grants other users access.  See the libfuse documentation for
> +#     the full list of supported options.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'RemoteI2CBackendCuseProperties',
> +  'data': { 'devname': 'str',
> +            '*fuse-opts': ['str'] },
> +  'if': 'CONFIG_LINUX' }

Please add this type before its use.  Put it right before
RemoteObjectProperties?

With that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


