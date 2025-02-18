Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387EC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIRe-00026V-QQ; Tue, 18 Feb 2025 02:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkIRc-00023g-8f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkIRa-0006hV-6f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739865300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/mw942lI/lMgagmUlGMvzED3dh1JnOW4dEURYgVbp8=;
 b=S3aiX6GqrMMAW5q4QrZGv1mDLrbh+MS5u1IghybHMZ4wcEXr4eJwLqNTIZ+G/YEEFeG/QC
 XqmK/BlwexmNCJCL9W/LTJZQjCkCzUiQyNOCFeegPL5VDMDvDODnxZPFZj34Iqxnkz9qM4
 DNz43AX0NF7Ay05vDcAL2C63jhvnZJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-1nbVj7EYO4ur_01WWZS-1w-1; Tue,
 18 Feb 2025 02:54:56 -0500
X-MC-Unique: 1nbVj7EYO4ur_01WWZS-1w-1
X-Mimecast-MFC-AGG-ID: 1nbVj7EYO4ur_01WWZS-1w_1739865296
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F11651801A20; Tue, 18 Feb 2025 07:54:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4AA419560AA; Tue, 18 Feb 2025 07:54:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 386F621E6A28; Tue, 18 Feb 2025 08:54:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v9 2/4] chardev/char-hub: implement backend chardev
 aggregator
In-Reply-To: <20250123085327.965501-3-r.peniaev@gmail.com> (Roman Penyaev's
 message of "Thu, 23 Jan 2025 09:53:22 +0100")
References: <20250123085327.965501-1-r.peniaev@gmail.com>
 <20250123085327.965501-3-r.peniaev@gmail.com>
Date: Tue, 18 Feb 2025 08:54:52 +0100
Message-ID: <87eczvhelv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> This patch implements a new chardev backend `hub` device, which
> aggregates input from multiple backend devices and forwards it to a
> single frontend device. Additionally, `hub` device takes the output
> from the frontend device and sends it back to all the connected
> backend devices. This allows for seamless interaction between
> different backend devices and a single frontend interface.
>
> The idea of the change is trivial: keep list of backend devices
> (up to 4), init them on demand and forward data buffer back and
> forth.
>
> The following is QEMU command line example:
>
>    -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
>    -chardev vc,id=3Dvc0 \
>    -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
>    -device virtconsole,chardev=3Dhub0 \
>    -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`) and a
> pseudo TTY (`pty0`) connected to the single virtio hvc console with
> the backend aggregator (`hub0`) help. `vc0` renders text to an image,
> which can be shared over the VNC protocol.  `pty0` is a pseudo TTY
> backend which provides biderectional communication to the virtio hvc
> console.
>
> 'chardevs.N' list syntax is used for the sake of compatibility with
> the representation of JSON lists in 'key=3Dval' pairs format of the
> util/keyval.c, despite the fact that modern QAPI way of parsing,
> namely qobject_input_visitor_new_str(), is not used. Choice of keeping
> QAPI list syntax may help to smoothly switch to modern parsing in the
> future.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Reviewed-by: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index e04535435034..f02b66c06b3e 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -332,6 +332,19 @@
>    'data': { 'chardev': 'str' },
>    'base': 'ChardevCommon' }
>=20=20
> +##
> +# @ChardevHub:
> +#
> +# Configuration info for hub chardevs.
> +#
> +# @chardevs: List of chardev IDs, which should be added to this hub

Suggest "IDs to be added".

According to the commit message, there's a limit of four chardevs.
Better document that here.

> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'ChardevHub',
> +  'data': { 'chardevs': ['str'] },
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevStdio:
>  #
> @@ -479,6 +492,8 @@
>  #
>  # @mux: (since 1.5)
>  #
> +# @hub: (since 10.0)
> +#
>  # @msmouse: emulated Microsoft serial mouse (since 1.5)
>  #
>  # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
> @@ -521,6 +536,7 @@
>              'pty',
>              'null',
>              'mux',
> +            'hub',
>              'msmouse',
>              'wctablet',
>              { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
> @@ -595,6 +611,16 @@
>  { 'struct': 'ChardevMuxWrapper',
>    'data': { 'data': 'ChardevMux' } }
>=20=20
> +##
> +# @ChardevHubWrapper:
> +#
> +# @data: Configuration info for hub chardevs
> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'ChardevHubWrapper',
> +  'data': { 'data': 'ChardevHub' } }
> +
>  ##
>  # @ChardevStdioWrapper:
>  #
> @@ -703,6 +729,7 @@
>              'pty': 'ChardevPtyWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
> +            'hub': 'ChardevHubWrapper',
>              'msmouse': 'ChardevCommonWrapper',
>              'wctablet': 'ChardevCommonWrapper',
>              'braille': { 'type': 'ChardevCommonWrapper',

With the doc nits addressed
Acked-by: Markus Armbruster <armbru@redhat.com>


