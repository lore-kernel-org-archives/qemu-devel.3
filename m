Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569F8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZsn-0007rn-Q5; Tue, 30 Jun 2026 10:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weZsb-0007pl-3M
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weZsZ-0001wP-BX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782831359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtVamKYFTeeekIBUnppJ42ULmv5+cTo9o41wHNAhNag=;
 b=hL/W5fjkE8bjxU9YCIEmrR5XnVYy9Oldn58QlGFpDzcly/Kj+V5lWI7CSUDCvBkJnOYa/4
 fAHNN+tRKwMdJrQ/2QBc9Jqzqk5C87zhvuNRlyGAXr5k7KKZUp7dEEyFbNsqnZuBq0GC8f
 t8u6Mz+nliJ1utGV4UfU3uIZhiZlrvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-3g2fVdcPPnOlLBLMYjR_aA-1; Tue,
 30 Jun 2026 10:55:56 -0400
X-MC-Unique: 3g2fVdcPPnOlLBLMYjR_aA-1
X-Mimecast-MFC-AGG-ID: 3g2fVdcPPnOlLBLMYjR_aA_1782831355
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1AB18001F3; Tue, 30 Jun 2026 14:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25BF41955F76; Tue, 30 Jun 2026 14:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A57A221E6920; Tue, 30 Jun 2026 16:55:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 22/35] monitor: implement "user creatable" interface
 for adding monitors
In-Reply-To: <20260624173752.2928717-23-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:38
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-23-berrange@redhat.com>
Date: Tue, 30 Jun 2026 16:55:50 +0200
Message-ID: <87fr24yt55.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Implement the user creatable QOM interface and define the monitor-qmp
> and monitor-hmp types in QAPI. This unlocks the ability to create them
> on the command line with -object or in HMP/QMP with object_add.
>
> For example:
>
>   $QEMU -chardev stdio,id=3Dmonchr0 -object monitor-hmp,id=3Dmon0,chrdev=
=3Dmonchr0
>
> Initially the "prepare_delete" callback is hardcoded to return an error
> which means -object and object_add can be used, but object_del will fail.
> Support for deleting monitors will be introduced in subsequent commits.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087..6affb70a59 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1187,6 +1187,45 @@
>    'data': { '*cpu-affinity': ['uint16'],
>              '*node-affinity': ['uint16'] } }
>=20=20
> +##
> +# @MonitorProperties:
> +#
> +# Properties for all monitors
> +#
> +# @chardev: ID of the character device providing the monitor transport
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'MonitorProperties',
> +  'data': { 'chardev': 'str' }}
> +
> +##
> +# @MonitorHMPProperties:
> +#
> +# Properties for the HMP monitor
> +#
> +# @readline: whether to enable readline for line editing
> +#      (default: enabled)

The default value is 'true', and it means 'enabeld'.  We pretty much
universally have the default value in (default: ...), not the meaning.

> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'MonitorHMPProperties',
> +  'base': 'MonitorProperties',
> +  'data': { '*readline': 'bool' } }
> +
> +##
> +# @MonitorQMPProperties:
> +#
> +# Properties for the QMP monitor
> +#
> +# @pretty: whether to pretty print JSON responses (default: disabled)

Likewise.

> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'MonitorQMPProperties',
> +  'base': 'MonitorProperties',
> +  'data': { '*pretty': 'bool' } }
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1237,6 +1276,8 @@
>      'memory-backend-ram',
>      { 'name': 'memory-backend-shm',
>        'if': 'CONFIG_POSIX' },
> +    'monitor-hmp',
> +    'monitor-qmp',
>      'pef-guest',
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
> @@ -1315,6 +1356,8 @@
>        'memory-backend-ram':         'MemoryBackendProperties',
>        'memory-backend-shm':         { 'type': 'MemoryBackendShmPropertie=
s',
>                                        'if': 'CONFIG_POSIX' },
> +      'monitor-hmp':                {'type': 'MonitorHMPProperties' },
> +      'monitor-qmp':                {'type': 'MonitorQMPProperties' },

Use the short form when possible:

         'monitor-hmp':                'MonitorHMPProperties',
         'monitor-qmp':                'MonitorQMPProperties',

>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties=
',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 51db7588b9..59ccc4b35c 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -10,4 +10,5 @@ int monitor_get_fd(Monitor *mon, const char *name, Erro=
r **errp)
>=20=20
>  void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **=
errp)
>  {
> +    g_assert_not_reached();
>  }
> diff --git a/system/vl.c b/system/vl.c
> index fb36140aac..79ed2be449 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1830,6 +1830,10 @@ static void object_option_add_visitor(Visitor *v)
>  {
>      ObjectOption *opt =3D g_new0(ObjectOption, 1);
>      visit_type_ObjectOptions(v, NULL, &opt->opts, &error_fatal);
> +    if (opt->opts->qom_type =3D=3D OBJECT_TYPE_MONITOR_HMP ||
> +        opt->opts->qom_type =3D=3D OBJECT_TYPE_MONITOR_QMP) {
> +        default_monitor =3D 0;
> +    }

Still okay, but if we pick up more, we better do it like
default_driver_disable() does for devices.

>      QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>  }
>=20=20
> @@ -1971,7 +1975,9 @@ static bool object_create_early(const char *type)
>=20=20
>      /* Reason: property "chardev" */
>      if (g_str_equal(type, "rng-egd") ||
> -        g_str_equal(type, "qtest")) {
> +        g_str_equal(type, "qtest") ||
> +        g_str_equal(type, "monitor-hmp") ||
> +        g_str_equal(type, "monitor-qmp")) {
>          return false;
>      }

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


