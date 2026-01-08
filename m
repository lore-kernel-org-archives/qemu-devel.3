Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0D6D185DD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdon0-0002aw-0U; Thu, 08 Jan 2026 07:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdomw-000260-4V
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdomu-0003lK-CH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767874007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UhWHJ6TYDhANns7ZSH9ItR0KO1XhOLNd//NrO4DGwU=;
 b=W6dJm6EJudVpSgddRorqkwy/vYEoWwQ/oqb8/JGmT+Hp5vnKIA4/uCNJkbWqJGlOAYFvY7
 Pt0WJ4cPNRcQ2fJ3ebSvoljWcHA+Zj7DwJbCXo6TpQjLjDR8MNjuTrH7bQMkuJWUjJOXse
 1ZNpu0Q0C7iLPUJ064TjYjmfJajeJKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-DIcwJhV8MyueE426-5ns5w-1; Thu,
 08 Jan 2026 07:06:44 -0500
X-MC-Unique: DIcwJhV8MyueE426-5ns5w-1
X-Mimecast-MFC-AGG-ID: DIcwJhV8MyueE426-5ns5w_1767874003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40B30195608D; Thu,  8 Jan 2026 12:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A0641955F1C; Thu,  8 Jan 2026 12:06:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F122321E6937; Thu, 08 Jan 2026 13:06:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/3] qapi/misc: Fix missed query-iothreads items
In-Reply-To: <20251229103859.98777-1-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 29 Dec 2025 18:38:57 +0800")
References: <20251229103859.98777-1-zhangckid@gmail.com>
Date: Thu, 08 Jan 2026 13:06:39 +0100
Message-ID: <87bjj48g1c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> As the struct IOThreadInfo definition:
> { 'struct': 'IOThreadInfo',
>   'data': {'id': 'str',
>            'thread-id': 'int',
>            'poll-max-ns': 'int',
>            'poll-grow': 'int',
>            'poll-shrink': 'int',
>            'aio-max-batch': 'int' } }

Suggest:

  The example is incomplete: it misses members @poll-max-ns, @poll-grow,
  @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
  (monitor: add poll-* properties into query-iothreads result) and
  commit 1793ad0247c (iothread: add aio-max-batch parameter).

  Cc: qemu-stable@nongnu.org

> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  qapi/misc.json | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..6153ed3d04 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -117,11 +117,19 @@
>  #     <- { "return": [
>  #              {
>  #                 "id":"iothread0",
> -#                 "thread-id":3134
> +#                 "thread-id":3134,
> +#                 'poll-max-ns':0,

Double quotes, please.

The default value appears to be 32768.  Maybe show that?

> +#                 "poll-grow":0,
> +#                 "poll-shrink":0,
> +#                 "aio-max-batch":0
>  #              },
>  #              {
>  #                 "id":"iothread1",
> -#                 "thread-id":3135
> +#                 "thread-id":3135,
> +#                 'poll-max-ns':0,

Likewise.

> +#                 "poll-grow":0,
> +#                 "poll-shrink":0,
> +#                 "aio-max-batch":0
>  #              }
>  #           ]
>  #        }


