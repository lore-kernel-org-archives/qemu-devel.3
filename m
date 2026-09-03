Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0213C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28Ul-0007b5-92; Thu, 03 Sep 2026 10:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x28Uj-0007aO-D5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x28Ui-0000C6-0e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788445967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iniYQgcPZOJTNkQAZDJ1yHpnUOWGXkf2wNRRkWuShLg=;
 b=RQtgGxShmF+5//uMKR8QVlGTO5Ek6QVc4zFxJSqCdD0FjYc0Nw6pSBun7ryg6TA0WxHr8J
 /ACQ1IB6noGJ4Y49eE2WjJz7GFrFWXsXFqs6EEzcFP3jJkFcFXJGn8CKm+E9vZ3italNNx
 /c1y0UdyX1q8Bx24wxIaaiCi1fzHMJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-G7zYxjC1OGyUI2SoNssp-Q-1; Thu,
 03 Sep 2026 10:32:42 -0400
X-MC-Unique: G7zYxjC1OGyUI2SoNssp-Q-1
X-Mimecast-MFC-AGG-ID: G7zYxjC1OGyUI2SoNssp-Q_1788445962
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC9701945110; Thu,  3 Sep 2026 14:32:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A01F19560AB; Thu,  3 Sep 2026 14:32:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4F2E21E682E; Thu, 03 Sep 2026 16:32:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 2/9] qapi/block: Add IoAccountingOperation enum
In-Reply-To: <20260831135206.126184-3-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 31 Aug 2026 15:51:58 +0200")
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-3-hreitz@redhat.com>
Date: Thu, 03 Sep 2026 16:32:22 +0200
Message-ID: <87fqzqpfrd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hanna Czenczek <hreitz@redhat.com> writes:

> This enum gives more information than IoOperationType (which is used for
> the rerror/werror distinction) to identify operation types for block
> accounting.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block.json | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 46955bbb3e3..456118eb0b4 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -603,3 +603,25 @@
>             '*boundaries-zap': ['uint64'],
>             '*boundaries-flush': ['uint64'] },
>    'allow-preconfig': true }
> +
> +##
> +# @IoAccountingOperation:
> +#
> +# A more finely grained enumeration of I/O operation types beyond what
> +# `IoOperationType` provides (whose read/write distinction matches the
> +# rerror/werror policy settings).

Why is the comparison to IoOperationType useful?

If making the connection between IoOperationType values and
"rerror/werror policy setting" is useful, why isn't it made in
IoOperationType's docs?

What settings exactly?  Could this be a link?

> +#
> +# @read: Reading data
> +#
> +# @write: Writing data
> +#
> +# @flush: Flushing data to disk
> +#
> +# @zone-append: Appending data to a zone of a zoned block device
> +#
> +# @unmap: Discarding a block of data
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'IoAccountingOperation',
> +  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }


