Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15391C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weq3z-0003Tz-5B; Wed, 01 Jul 2026 04:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weq3v-0003Tk-NE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weq3r-00084W-NN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782893566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFIiid7XwlPr1mA1LsFA6Tl154flyBATqW192WPWxd0=;
 b=YAuBskYHD354do+m5RPTUClW5vJYhSYstlAJS8ELb2yP97/vrAnLgBexb9bgXn0Y0BuXJU
 d+Hy+3aZkEBxPqh+ENKniUuXAB2+lHDE8UGgrcwq8WHqQ+AHqNOYVueiH9fCrk4NRulW6S
 T0Mw58w5Yxw+8o1nvtX8a6Fw2Sf4Rrw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-ptB9tod7N_q2VPXIwe_A5g-1; Wed,
 01 Jul 2026 04:12:42 -0400
X-MC-Unique: ptB9tod7N_q2VPXIwe_A5g-1
X-Mimecast-MFC-AGG-ID: ptB9tod7N_q2VPXIwe_A5g_1782893561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1747F1955D5B; Wed,  1 Jul 2026 08:12:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC4CD195607B; Wed,  1 Jul 2026 08:12:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 387D721E6920; Wed, 01 Jul 2026 10:12:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Corey Minyard <cminyard@mvista.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2] hw/i2c: Add remote I2C master with host CUSE bridge
In-Reply-To: <20260625074054.500140-1-ilya.chichkov.dev@gmail.com> (Ilya
 Chichkov's message of "Thu, 25 Jun 2026 10:40:53 +0300")
References: <CADgQP8wPoi70zcPwY7ZtfY9tgFcGxGYpMMWGe+vvj3UjH0MyXA@mail.gmail.com>
 <20260625074054.500140-1-ilya.chichkov.dev@gmail.com>
Date: Wed, 01 Jul 2026 10:12:38 +0200
Message-ID: <871pdn6scp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> index dd45ac1087..b515f1e4e7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1258,6 +1258,7 @@
>      'tls-creds-psk',
>      'tls-creds-x509',
>      'tls-cipher-suites',
> +    'remote-i2c-backend-cuse',
>      { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
>      { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
>    ] }
> @@ -1334,6 +1335,7 @@
>        'tls-creds-psk':              'TlsCredsPskProperties',
>        'tls-creds-x509':             'TlsCredsX509Properties',
>        'tls-cipher-suites':          'TlsCredsProperties',
> +      'remote-i2c-backend-cuse':    'RemoteI2CBackendCuseProperties',
>        'x-remote-object':            'RemoteObjectProperties',
>        'x-vfio-user-server':         'VfioUserServerProperties'
>    } }
> @@ -1377,3 +1379,19 @@
>  ##
>  { 'command': 'object-del', 'data': {'id': 'str'},
>    'allow-preconfig': true }
> +
> +##
> +# @RemoteI2CBackendCuseProperties:
> +#
> +# Properties for the CUSE remote I2C backend.
> +#
> +# @devname: The CUSE device name to create (e.g., 'i2c-33').

What's a "CUSE device name"?  What exactly is created?

> +# @fuse-opts: Optional FUSE mount options.

Syntax?

> +# @debug: Whether to enable debug output.

To what exactly does @debug apply?

Blank line between member descriptions, please.

> +#
> +# Since: (your version)

Assuming this can't make 11.1:

   # Since: 11.2

> +##
> +{ 'struct': 'RemoteI2CBackendCuseProperties',
> +  'data': { 'devname': 'str',
> +            '*fuse-opts': 'str',
> +            '*debug': 'bool' } }

Should all this be 'if': 'CONFIG_LINUX'?


