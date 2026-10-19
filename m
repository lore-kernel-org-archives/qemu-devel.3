Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8530BCCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInJ2-0003lz-B5; Mon, 19 Oct 2026 09:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInIy-0003li-KU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInIw-0008Ja-PM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792416086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iB1cil72SfzsbpdG2gNfByFvBErk8aa//e42Ee3DKvo=;
 b=Iv2XQjHwU365ELKxzKjFl/RtYaGxeGDg9fv8vIJk5JhvhykW2we08UaIf+FhcajBUsW49f
 a8DmzvMhiLlMAMJNPQfET1wE1wwlmw4foeiXfyBRrY6jojp2emXInxbqsrkE4pC0cVt7lb
 ki8y+uc7rJXVzKLVaR+C1c02OwuQrVQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-BR5Rq3KZMJij1Wn1KlsT2A-1; Mon,
 19 Oct 2026 13:21:14 +0000
X-MC-Unique: BR5Rq3KZMJij1Wn1KlsT2A-1
X-Mimecast-MFC-AGG-ID: BR5Rq3KZMJij1Wn1KlsT2A_1792416066
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0251800BD2; Mon, 19 Oct 2026 13:21:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B6D91956040; Mon, 19 Oct 2026 13:21:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1496B21E6A04; Mon, 19 Oct 2026 15:21:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 59/62] qom: use QAPITypeInfo in object_property_get_enum
In-Reply-To: <20260911-qom-qapi-v5-59-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:35:33 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-59-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:21:03 +0200
Message-ID: <87zew9ygg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The typename parameter becomes a QAPITypeInfo pointer, and the
> validation compares prop->qapi_type against it instead of matching
> prop->type strings.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c      | 3 ++-
>  include/qom/object.h            | 4 ++--
>  qom/object.c                    | 8 ++++----
>  tests/unit/check-qom-proplist.c | 6 +++---
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 543dd3201b5a..1c23ec8897f0 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -18,6 +18,7 @@
>  #include "qapi/qapi-commands-accelerator.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qobject/qobject.h"
> +#include "qapi/qapi-type-infos-common.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/type-helpers.h"
>  #include "qemu/uuid.h"
> @@ -219,7 +220,7 @@ static int query_memdev(Object *obj, void *opaque)
>          } else {
>              m->has_reserve =3D true;
>          }
> -        m->policy =3D object_property_get_enum(obj, "policy", "HostMemPo=
licy",
> +        m->policy =3D object_property_get_enum(obj, "policy", &HostMemPo=
licy_type_info,

scripts/checkpatch.pl warns

    WARNING: line over 80 characters

Easy enough to avoid.

>                                               &error_abort);
>          host_nodes =3D object_property_get_qobject(obj,
>                                                   "host-nodes",

[...]


