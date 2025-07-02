Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453B6C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsSl-0004ZQ-OS; Wed, 02 Jul 2025 04:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsSc-0004Xd-TC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsSa-0007Jv-SF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751443490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YA+fwEjok7UbvLRsvtmYBQs3WNZR/o2NJv9GMllS3jQ=;
 b=Khx/70W92qhKY0zihNBN79bT39CQNjdGxREVTXLgNF5LSyuyOxMB4ta5cb+JS/Faka2EFg
 ioqcqvwyEQb5DgCk/4Yq3qoYBs3JwlU9txEJMC12TnnvWRZLynNuoftujHIVOvBhMwNl+5
 JoOVNuTJsS78eZyIFtjG6eZnEtQVmgE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103--iREQV3XOW-fR69fYH_TNA-1; Wed,
 02 Jul 2025 04:04:46 -0400
X-MC-Unique: -iREQV3XOW-fR69fYH_TNA-1
X-Mimecast-MFC-AGG-ID: -iREQV3XOW-fR69fYH_TNA_1751443484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D9C61800343; Wed,  2 Jul 2025 08:04:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D2FD180045B; Wed,  2 Jul 2025 08:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D22BA21E6A27; Wed, 02 Jul 2025 10:04:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 08/18] qapi: add cross-references to migration.json
In-Reply-To: <20250613203620.1283814-9-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:10 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-9-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 10:04:40 +0200
Message-ID: <87zfdnow6f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/migration.json | 62 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d7c5047462e..fec6479a23e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json

[...]

> @@ -646,10 +646,10 @@
>  #     memory-backend-epc is not supported.  The VM must be started
>  #     with the '-machine aux-ram-share=on' option.
>  #
> -#     When using -incoming defer, you must issue the migrate command
> +#     When using -incoming defer, you must issue the `migrate` command
>  #     to old QEMU before issuing any monitor commands to new QEMU.
>  #     However, new QEMU does not open and read the migration stream
> -#     until you issue the migrate incoming command.
> +#     until you issue the `migrate` incoming command.

I suspect this should be `migrate-incoming`.

>  #
>  #     (since 10.0)
>  ##

[...]

> @@ -1733,8 +1733,8 @@
>  #     list connected to a destination interface endpoint.
>  #
>  # @exit-on-error: Exit on incoming migration failure.  Default true.
> -#     When set to false, the failure triggers a MIGRATION event, and
> -#     error details could be retrieved with query-migrate.
> +#     When set to false, the failure triggers a :qapi:event:`MIGRATION`

When and why do we need :qapi:event:?

> +#     event, and error details could be retrieved with `query-migrate`.
>  #     (since 9.1)
>  #
>  # Since: 2.3

[...]


