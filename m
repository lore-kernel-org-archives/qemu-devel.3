Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16C5CCF9E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuLW-0007Iw-JP; Thu, 23 Oct 2025 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBuGT-0001Px-Fz
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBuGN-0006VM-Hd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761221869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hg2hC5L98UVtQ++c8KdSziVy7OBtW1l3z8LTPULgwGo=;
 b=iUB9NJ78hi0YitwGdNUwTriEouCLwECjvO3Fp9h9C4koaBp8UOC7ehfHWDysqaMP1Q5fsG
 cyEE+IKbUm7rZgFEVbET7kp5PCwrXJvYILSCMp/bj1rHeMAIpSWWWtCJ/ORmMbMKcbpSTC
 appxxtEhKFR0FKNLiAO+G68j8G8q7Pg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-VoUxbbfOMNGctsJ8hbaXNQ-1; Thu,
 23 Oct 2025 08:17:46 -0400
X-MC-Unique: VoUxbbfOMNGctsJ8hbaXNQ-1
X-Mimecast-MFC-AGG-ID: VoUxbbfOMNGctsJ8hbaXNQ_1761221865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D2311800744; Thu, 23 Oct 2025 12:17:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8ECA180044F; Thu, 23 Oct 2025 12:17:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D7BF21E6A27; Thu, 23 Oct 2025 14:17:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 10/32] hw/core: report security status in query-machines
In-Reply-To: <20250926140144.1998694-11-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:21
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-11-berrange@redhat.com>
Date: Thu, 23 Oct 2025 14:17:42 +0200
Message-ID: <87zf9h6cd5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c | 1 +
>  qapi/machine.json          | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 6aca1a626e..4d9906f64a 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -100,6 +100,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_p=
rops, bool compat_props,
>          if (mc->default_ram_id) {
>              info->default_ram_id =3D g_strdup(mc->default_ram_id);
>          }
> +        info->secure =3D object_class_is_secure(OBJECT_CLASS(mc));
>=20=20
>          if (compat_props && mc->compat_props) {
>              int i;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c..bb2b308ccd 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -194,6 +194,11 @@
>  #     present when `query-machines` argument @compat-props is true.
>  #     (since 9.1)
>  #
> +# @secure: If true, the machine is declared to provide a security
> +#     boundary from the guest; if false the machine is either
> +#     not providing a security boundary, or its status is undefined.
> +#     (since 10.2)
> +#
>  # Features:
>  #
>  # @unstable: Member @compat-props is experimental.
> @@ -207,7 +212,8 @@
>              'deprecated': 'bool', '*default-cpu-type': 'str',
>              '*default-ram-id': 'str', 'acpi': 'bool',
>              '*compat-props': { 'type': ['CompatProperty'],
> -                               'features': ['unstable'] } } }
> +                               'features': ['unstable'] },
> +            'secure': 'bool' } }
>=20=20
>  ##
>  # @query-machines:

Isn't this redundant with qom-list-types?

{"execute": "qom-list-types", "arguments": {"implements": "machine"}}


