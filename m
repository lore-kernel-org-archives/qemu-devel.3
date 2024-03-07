Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C5C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAZ9-0006QQ-S8; Thu, 07 Mar 2024 05:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riAYr-0006Oy-Qa
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riAYq-0000WK-Ap
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709805670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=56pbzrzV5WD/DGXaL/kmmd87zZvo3yYiXHt3TsfUHB0=;
 b=ArELDUBXj6JljXEiNytvGs0zaIZbzpgNTu6oJ9uXj/EWyS1PNqS7h5SxWOl6GV7KWylxfE
 vvfraKNNm6I/aQapUvKgGzijBeBqDc1BYOGuxYV/k04QMeYBTFRANkV6KGUAdE+0sTrfyJ
 aOCvDWVUwnG9Ep14O0Qqm+pJc9qejT0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Nfepq1eLNnu0SzB13aY19A-1; Thu,
 07 Mar 2024 05:01:06 -0500
X-MC-Unique: Nfepq1eLNnu0SzB13aY19A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E01F1C54462;
 Thu,  7 Mar 2024 10:01:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CDFB1C05E1C;
 Thu,  7 Mar 2024 10:01:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D919B21E6A24; Thu,  7 Mar 2024 11:01:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 6/6] qapi: introduce CONFIG_READ event
In-Reply-To: <20240301171143.809835-7-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 1 Mar 2024 20:11:43 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-7-vsementsov@yandex-team.ru>
Date: Thu, 07 Mar 2024 11:01:04 +0100
Message-ID: <87cys6cqe7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Send a new event when guest reads virtio-pci config after
> virtio_notify_config() call.
>
> That's useful to check that guest fetched modified config, for example
> after resizing disk backend.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 6ece164172..ffc5e3be18 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -179,3 +179,29 @@
>  { 'command': 'device-sync-config',
>    'features': [ 'unstable' ],
>    'data': {'id': 'str'} }
> +
> +##
> +# @VIRTIO_CONFIG_READ:
> +#
> +# Emitted whenever guest reads virtio device config after config change.

Let's not abbreviate "configuration" to "config".

> +#
> +# @device: device name
> +#
> +# @path: device path
> +#
> +# Features:
> +#
> +# @unstable: The event is experimental.
> +#
> +# Since: 9.0
> +#
> +# Example:
> +#
> +#     <- { "event": "VIRTIO_CONFIG_READ",
> +#          "data": { "device": "virtio-net-pci-0",
> +#                    "path": "/machine/peripheral/virtio-net-pci-0" },
> +#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
> +##

As for PATCH 4, I'd like to see some guidance on intended use.

> +{ 'event': 'VIRTIO_CONFIG_READ',
> +  'features': [ 'unstable' ],
> +  'data': { '*device': 'str', 'path': 'str' } }

[...]


