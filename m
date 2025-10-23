Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtr8-00011o-G3; Thu, 23 Oct 2025 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBtqz-0000sR-6Z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBtqx-0002RU-3n
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761220293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5J0XleYy35J72GSLb8VrlEjmKmwrzI5uCA4kevpMWE=;
 b=dp/riD5LDdLz7yyHM++9SSSuJWWihO0ShscTQX9JMF/b5OGFDeKzwPQ8wv/cG+hiLStL1S
 MXMDoXvNzVx0Lzfcnd0mRSvDkol8fteIw5iateSdseSXGTfZ1NCNGDFLy1E1256cayQt7R
 nF5nzBuU2TelNoZfTdi4Y0a40qK0iA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-VvcMHZOqNiKpgA0i6iCdjA-1; Thu,
 23 Oct 2025 07:51:29 -0400
X-MC-Unique: VvcMHZOqNiKpgA0i6iCdjA-1
X-Mimecast-MFC-AGG-ID: VvcMHZOqNiKpgA0i6iCdjA_1761220288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052061800657; Thu, 23 Oct 2025 11:51:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B079A180057C; Thu, 23 Oct 2025 11:51:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F136021E6A27; Thu, 23 Oct 2025 13:51:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 06/32] system: check security for machine types
In-Reply-To: <20250926140144.1998694-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:17
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-7-berrange@redhat.com>
Date: Thu, 23 Oct 2025 13:51:24 +0200
Message-ID: <87frb97s5f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> This wires up the machine creation code to apply the compat policy
> security check.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  system/vl.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 38c6caf524..716bf6d490 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2182,10 +2182,19 @@ static void qemu_create_machine_containers(Object=
 *machine)
>      }
>  }
>=20=20
> -static void qemu_create_machine(QDict *qdict)
> +static int qemu_create_machine(QDict *qdict)

Suggest bool.

>  {
>      MachineClass *machine_class =3D select_machine(qdict, &error_fatal);
>      object_set_machine_compat_props(machine_class->compat_props);
> +    Error *local_err;
> +
> +    if (!compat_policy_check_security(&compat_policy,
> +                                      object_class_get_name(OBJECT_CLASS=
(machine_class)),
> +                                      object_class_is_secure(OBJECT_CLAS=
S(machine_class)),
> +                                      &local_err)) {
> +        error_report_err(local_err);
> +        return -1;
> +    }
>=20=20
>      current_machine =3D MACHINE(object_new_with_class(OBJECT_CLASS(machi=
ne_class)));
>      object_property_add_child(object_get_root(), "machine",
> @@ -2222,6 +2231,8 @@ static void qemu_create_machine(QDict *qdict)
>                                            false, &error_abort);
>          qobject_unref(default_opts);
>      }
> +
> +    return 0;
>  }
>=20=20
>  static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
> @@ -3763,7 +3774,9 @@ void qemu_init(int argc, char **argv)
>      /* Transfer QemuOpts options into machine options */
>      parse_memory_options();
>=20=20
> -    qemu_create_machine(machine_opts_dict);
> +    if (qemu_create_machine(machine_opts_dict) < 0) {
> +        exit(1);
> +    }
>=20=20
>      /*
>       * Load incoming CPR state before any devices are created, because it


