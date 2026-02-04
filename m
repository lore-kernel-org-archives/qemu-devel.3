Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CF7E9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncT3-0004F4-En; Wed, 04 Feb 2026 07:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncT2-0004Db-6t
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncT0-0004lD-70
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770209924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w9TuyJ1pfvkBkFoFw3t+O8m84DAfigc+tH8BcKonIkE=;
 b=d7n1OFg1ZxLivaFqyFIPZNCCTQOu8+m+H7DZJ+3v0SMm1MswIS+Twf8K8egTq+c2F6LsNr
 OSPvhTjyzCeSEnS/835yw30JfGqd9JaR0HivoxVr77WtFfRp+tQwjzepCWFz0yhANYT7s7
 kHZpCxspcROpHT9Yy/z9KuG0aQobDxs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-j6Di1AcyNb6cFjZT1-JFWg-1; Wed,
 04 Feb 2026 07:58:40 -0500
X-MC-Unique: j6Di1AcyNb6cFjZT1-JFWg-1
X-Mimecast-MFC-AGG-ID: j6Di1AcyNb6cFjZT1-JFWg_1770209920
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACB471802890; Wed,  4 Feb 2026 12:58:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA881955F32; Wed,  4 Feb 2026 12:58:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41F0821E692D; Wed, 04 Feb 2026 13:58:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [RESEND PATCH V3 3/3] qapi: Add attached flag for iothread
In-Reply-To: <20260126094422.23116-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 26 Jan 2026 17:44:22 +0800")
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-3-zhangckid@gmail.com>
Date: Wed, 04 Feb 2026 13:58:16 +0100
Message-ID: <877bssy8bb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Zhang Chen <zhangckid@gmail.com> writes:

> The attached flag depends on struct IOThreadInfo's
> 'attached': 'bool'. It can show whether the iothread
> is attached to an actual device. Show in the qmp/hmp
> CMD with "attached": true/false.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1f5062df2a..cb865d6e48 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -76,6 +76,15 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @attached: The attached parameter is a flag indicating whether
> +#     the IOThread is currently associated with an active device

"the iothread" for consistency with other doc text.

> +#     (e.g., virtio-blk).  In hotplug scenarios, users can

I'd drop the comma.

> +#     pre-allocate multiple iothread objects to serve as a persistent
> +#     thread pool.  When a device is hot-unplugged, the corresponding
> +#     IOThread is released but remains available, allowing subsequent
> +#     hot-plugged devices to attach to and reuse the existing thread.
> +#     (since 12.0)

(since 11.0)

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -93,6 +102,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'attached': 'bool',
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -118,6 +128,7 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "attached":false,
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -126,6 +137,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "attached":true,
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,

With that
Acked-by: Markus Armbruster <armbru@redhat.com>


