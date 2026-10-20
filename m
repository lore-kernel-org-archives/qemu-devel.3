Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE56606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRpPq3t8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3lD-0001sW-Kv; Tue, 20 Oct 2026 02:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3lB-0001rr-Rb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3l9-0001Un-Bi
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792479342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQ6bLQZdYJYY+m7faXXZFMCKf1PNXjNj2NNg3408EJ0=;
 b=NRpPq3t880u4PRkPSPbjSdKSIGAOsLotNBrdBoUGIAEbbY4EU/aHeV81Nc59ZW+8MqKmbV
 bCWXNnZ9kQ3uWCz/dDXDs2enD8aoFoaytDriejfYXq/1HTTpKTjllr8Qden8YKmLrjAj5v
 qeMgPyWhrS5xX9QBaOugDJhuzm3fvdQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-1hksjIcFMw6Sjf7b3zlQpg-1; Tue,
 20 Oct 2026 06:55:38 +0000
X-MC-Unique: 1hksjIcFMw6Sjf7b3zlQpg-1
X-Mimecast-MFC-AGG-ID: 1hksjIcFMw6Sjf7b3zlQpg_1792479338
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1844180065D; Tue, 20 Oct 2026 06:55:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F184195608B; Tue, 20 Oct 2026 06:55:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A67D021E6A04; Tue, 20 Oct 2026 08:55:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 07/12] qapi/block: Add BLOCK_IO_DONE event
In-Reply-To: <20261019182028.45305-8-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 19 Oct 2026 20:20:23 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-8-hreitz@redhat.com>
Date: Tue, 20 Oct 2026 08:55:34 +0200
Message-ID: <871p9ksvx5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> This event is emitted when an operation completes, for which a
> BLOCK_IO_DELAY event has previously been emitted.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block.json | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 5f9f5c28050..38f293dd32d 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -660,6 +660,9 @@
>  # Note that delays deliberately incurred by throttling do count
>  # towards the operation duration.
>  #
> +# This event will only be emitted once per request and action.  When
> +# the operation does finish, a `BLOCK_IO_DONE` event is emitted.

I think the first sentence answers a question I had on the previous
patch.  Move it there?

> +#
>  # @qom-path: path to the block device object in the QOM tree
>  #
>  # @operation: I/O operation
> @@ -686,3 +689,33 @@
>        'action': 'BlockErrorAction',
>        '*offset': 'uint64',
>        'bytes': 'uint64' } }
> +
> +##
> +# @BLOCK_IO_DONE:
> +#
> +# Emitted on completion for disk operations that previously emitted a
> +# `BLOCK_IO_DELAY` event.

Can we have multiple operations in flight that previously emitted
BLOCK_IO_DELAY?

If yes, might a management application need to connect the BLOCK_IO_DONE
back to the BLOCK_IO_DELAY?

If yes, how could it do that?

Please use the revised syntax for introductions:

   ##
   # @BLOCK_IO_DONE: Emitted on completion for disk operations that
   #     previously emitted a `BLOCK_IO_DELAY` event.

> +#
> +# @qom-path: path to the block device object in the QOM tree
> +#
> +# @operation: I/O operation
> +#
> +# @latency-ns: Full duration of the operation (in nanoseconds)
> +#
> +# @offset: Request offset in the guest disk (in bytes), if available

Out of curiosity: when could @offset be unavailable?

> +#
> +# @bytes: Request length
> +#
> +# @failed: If true, this request failed for any reason.  If false, the

Suggest "for some reason".

> +#     request succeeded.
> +#
> +# Since: 11.2
> +##
> +{ 'event': 'BLOCK_IO_DONE',
> +  'data': {
> +      'qom-path': 'str',
> +      'operation': 'IoAccountingOperation',
> +      'latency-ns': 'uint64',
> +      '*offset': 'uint64',
> +      'bytes': 'uint64',
> +      'failed': 'bool' } }


