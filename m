Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF131075273
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38Hb-0005m5-Fm; Thu, 19 Mar 2026 03:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w38HZ-0005lf-B8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w38HX-0004zm-Eo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773907142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9RZUoxaUVyZguPCFk9dsqhk/cPDE5kZ1718sP11OLw=;
 b=iVhKZhyqkcTvmV76/Ha9hWO91WzVGu740vg71kpq/Kb4WfmxJWPBSS3o8QQgQ+L4x5r29Y
 9w3h2jM1pnmn14NdLEP1SOXRXpj8tbZnln2BDMoxTatQw6P3xdBhRjEbHEF9BsBy1FSrRP
 9KSkUZDp6D1yO5GS3E1QIaG9ZfTGV6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-_WilVl4jNwe3Kcy4Hte6rg-1; Thu,
 19 Mar 2026 03:58:58 -0400
X-MC-Unique: _WilVl4jNwe3Kcy4Hte6rg-1
X-Mimecast-MFC-AGG-ID: _WilVl4jNwe3Kcy4Hte6rg_1773907137
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D671800561; Thu, 19 Mar 2026 07:58:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0DDE18001FE; Thu, 19 Mar 2026 07:58:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7083321E6937; Thu, 19 Mar 2026 08:58:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v3 07/11] ui/dbus: run without Audio interface when
 audio is disabled
In-Reply-To: <20260315201646.96862-8-heifetz@yandex-team.com> (Sergei
 Heifetz's message of "Mon, 16 Mar 2026 01:16:42 +0500")
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-8-heifetz@yandex-team.com>
Date: Thu, 19 Mar 2026 08:58:52 +0100
Message-ID: <87ms04cksj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sergei Heifetz <heifetz@yandex-team.com> writes:

> D-Bus display can be used even when QEMU is configured with
> `--disable-audio`. In that case, audio interface will not be available
> on `/org/qemu/Display1/Audio`.
>
> (The current handling of the situation when audio is enabled but
> no D-Bus-compatible audio backend is available is different and
> hasn=E2=80=99t been changed.)
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>  qapi/ui.json    | 2 +-
>  qemu-options.hx | 4 ++++
>  ui/dbus.c       | 8 ++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index e3da77632a8..62eb05c6091 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1385,7 +1385,7 @@
>    'data'    : { '*rendernode' : 'str',
>                  '*addr': 'str',
>                  '*p2p': 'bool',
> -                '*audiodev': 'str' } }
> +                '*audiodev': { 'type': 'str', 'if': 'CONFIG_AUDIO' } } }

Is this a compatibility break?

DisplayDBus is only used in DisplayOptions, which is only used as return
type of query-display-options in the QAPI schema.  However, vl.c also
uses it to parse -display.

Removing parameter @audiodev from -display is technically a
compatibility break.  However, we're removing an optional paramater that
would always be rejected when present: it has no valid value, because
there are no audiodevs.

Removal from query-display-options is similar: it could not be present.

Removal affects introspection, which could conceivably confuse client.
I don't expect such trouble here, because @audiodev always existed, i.e.
there's no real reason to look for it in introspection.

I think we're okay.  I'm cc'ing the libvirt list just in case.

Do we need a release note?

Do we need an entry in docs/about/removed-features.rst?  Feels a bit
odd; we're not removing a feature, we're adding one, namely "can compile
out audio".

>=20=20
>  ##
>  # @DisplayGLMode:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29dc865820a..20d15c0004f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2232,6 +2232,10 @@ SRST
>          If no audio backend is specified and the dbus display backend is
>          specified, the dbus audio backend is used by default.
>=20=20
> +        (If audio is disabled at compile time via the ``--disable-audio`=
` option,
> +        no audio backend is used, and none of the audio-related D-Bus in=
terfaces
> +        are exported.)
> +

Well, audio is either compiled in or it isn't.

If it's compiled in, then why tell the user how things behave when it's
not?

If it's not compiled in, then why document stuff that doesn't work?  How
much of -audiodev still works then?  -audiodev none?  Anything else?

>          The connection is registered with the "org.qemu" name (and queue=
d when
>          already owned).
>=20=20

[...]


