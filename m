Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F9FC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 05:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXYX2-0003qN-4i; Fri, 04 Jul 2025 01:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYWy-0003ny-0Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYWu-0000Wo-29
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751605206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZJWggfy7+yQgZn1a2ky+wwHtoxmMN8Jx2WZWX7g0CQ=;
 b=U6h0QYrmdCAce6bc4WkKDdqrPcGPiQ3F/QASqOhHVoen4XLK/w79M0UBpuG79qxAQXUu2m
 49+GUp9vwouJ/1wmMLEZhB1zjnAQC5CX7ttc5Buj5xLsX6+5Obbef4W1CxlqBNX5bguIKv
 P56kPM1C+yQWZsHa5weyIdrG1ycUW+o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-ePUI0Z_xN3SbOb83mnZcfw-1; Fri,
 04 Jul 2025 01:00:03 -0400
X-MC-Unique: ePUI0Z_xN3SbOb83mnZcfw-1
X-Mimecast-MFC-AGG-ID: ePUI0Z_xN3SbOb83mnZcfw_1751605201
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B45F19560AE; Fri,  4 Jul 2025 05:00:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AB773000223; Fri,  4 Jul 2025 04:59:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCDE121E6A27; Fri, 04 Jul 2025 06:59:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 01/39] hw/core/machine: Display CPU model name in
 'info cpus' command
In-Reply-To: <20250703173248.44995-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 3 Jul 2025 19:32:07
 +0200")
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-2-philmd@linaro.org>
Date: Fri, 04 Jul 2025 06:59:56 +0200
Message-ID: <87zfdksg8j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Display the CPU model in 'info cpus'. Example before:
>
>  $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>  QEMU 10.0.0 monitor - type 'help' for more information
>  (qemu) info cpus
>  * CPU #0: thread_id=3D42924
>    CPU #1: thread_id=3D42924
>    CPU #2: thread_id=3D42924
>    CPU #3: thread_id=3D42924
>  (qemu) q
>
> and after:
>
>  $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>  QEMU 10.0.50 monitor - type 'help' for more information
>  (qemu) info cpus
>  * CPU #0: thread_id=3D42916 (cortex-a72)
>    CPU #1: thread_id=3D42916 (cortex-a72)
>    CPU #2: thread_id=3D42916 (cortex-r5f)
>    CPU #3: thread_id=3D42916 (cortex-r5f)
>  (qemu)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  qapi/machine.json          | 3 +++
>  hw/core/machine-hmp-cmds.c | 3 ++-
>  hw/core/machine-qmp-cmds.c | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0650b8de71a..d5bbb5e367e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -80,6 +80,8 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @model: CPU model name (since 10.1)
> +#
>  # @props: properties associated with a virtual CPU, e.g. the socket id
>  #
>  # @target: the QEMU system emulation target, which determines which
> @@ -91,6 +93,7 @@
>    'base'          : { 'cpu-index'    : 'int',
>                        'qom-path'     : 'str',
>                        'thread-id'    : 'int',
> +                      'model'        : 'str',
>                        '*props'       : 'CpuInstanceProperties',
>                        'target'       : 'SysEmuTarget' },
>    'discriminator' : 'target',
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c6325cdcaaa..65eeb5e9cc2 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>=20=20
>          monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
>                         cpu->value->cpu_index);
> -        monitor_printf(mon, " thread_id=3D%" PRId64 "\n", cpu->value->th=
read_id);
> +        monitor_printf(mon, " thread_id=3D%" PRId64 " (%s)\n",
> +                       cpu->value->thread_id, cpu->value->model);
>      }
>=20=20
>      qapi_free_CpuInfoFastList(cpu_list);
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index d82043e1c68..ab4fd1ec08a 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>          value->cpu_index =3D cpu->cpu_index;
>          value->qom_path =3D object_get_canonical_path(OBJECT(cpu));
>          value->thread_id =3D cpu->thread_id;
> +        value->model =3D cpu_model_from_type(object_get_typename(OBJECT(=
cpu)));
>=20=20
>          if (mc->cpu_index_to_instance_props) {
>              CpuInstanceProperties *props;

Does the conversion from CPU type name to model name lose information?

If yes, should we provide the type name at least in QMP?

Let me also try a different angle...  what's the preferred thing for
users of HMP and for users of QMP, CPU model name or CPU type name?

Are there any commands that accept one, but not the other?

Are there other commands that return one, but not the other?


