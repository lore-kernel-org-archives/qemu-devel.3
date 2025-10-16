Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81EACCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 10:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9LfO-0006n8-Ey; Thu, 16 Oct 2025 06:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9LfM-0006mw-3s
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9LfF-0004kk-TQ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760612214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+MlrqHgvkogPuhUaqwXSXTEJpxl0QsIa6eTcWs2ljY=;
 b=XGV8uixPwAihhJ52G5Llba41QnnxcQazsAn5t8NCvG54v1ZHQ0oGRMwBxZ7LFydhYuxGPX
 sI59YmN3ZEi2SmW8gChYq6l8fMWswX6xyt36C43StULUGDzF065g3eV1ZIzd+i1u0HYsLg
 jRJsUSdRiGJplec+EQ9Y1AVctpV/4Z8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-nmkJqm0cOJGlfgRpXlAIkg-1; Thu,
 16 Oct 2025 06:56:51 -0400
X-MC-Unique: nmkJqm0cOJGlfgRpXlAIkg-1
X-Mimecast-MFC-AGG-ID: nmkJqm0cOJGlfgRpXlAIkg_1760612210
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFF87195608D; Thu, 16 Oct 2025 10:56:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2838618004D4; Thu, 16 Oct 2025 10:56:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A514821E6A27; Thu, 16 Oct 2025 12:56:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  jasowang@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  sw@weilnetz.de,  eblake@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  berrange@redhat.com,  qemu-devel@nongnu.org,
 michael.roth@amd.com,  steven.sistare@oracle.com,  leiyang@redhat.com,
 davydov-max@yandex-team.ru,  yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
In-Reply-To: <20251015132136.1083972-17-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 15 Oct 2025 16:21:32 +0300")
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
Date: Thu, 16 Oct 2025 12:56:46 +0200
Message-ID: <87a51rgln5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This parameter enables backend-transfer feature: all devices
> which support it will migrate their backends (for example a TAP
> device, by passing open file descriptor to migration channel).
>
> Currently no such devices, so the new parameter is a noop.
>
> Next commit will add support for virtio-net, to migrate its
> TAP backend.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..35601a1f87 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -951,9 +951,16 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that

Either "Enable the backend transfer feature" or "Enable backend transfer"

> +#     supports it. In general that means that backend state and its

support

> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket). Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option. (Since 10.2)
> +#

I'm not sure I understand this.

What is a "per-device backend-transfer option"?  Is it a device
property?

If yes, I guess the device declares its capability to do this by having
this property.  Correct?

Does the property's value matter?  How?

>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -978,7 +985,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
>  
>  ##
>  # @MigrateSetParameters:

[...]


