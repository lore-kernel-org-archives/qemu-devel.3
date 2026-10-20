Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1260A2604
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OcnQYY1z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3fM-00010c-Fb; Tue, 20 Oct 2026 02:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3fI-00010K-AZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3fG-0000li-OW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+aC+1nI0DQgKx+5iRdDIiQKKdEyQaXalDIT3IaDC8V4=;
 b=OcnQYY1zIILzPzQTj1ebVECjfodh8fafdPaK/nFQtO+eJl0c4O2SnTCmdRCiLdo8Qco67F
 5AmGF7k9jE68S6JabvCjRoWLTQL+MZw18TRaaimRJKwYZDiedAaltckT7gjfr8dxFSO2rF
 TTyvTI+/GdhlLUqEOwI8b1R3bTFGk28=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-u-E2aCbWO1qHmioi4WISKA-1; Tue,
 20 Oct 2026 06:49:34 +0000
X-MC-Unique: u-E2aCbWO1qHmioi4WISKA-1
X-Mimecast-MFC-AGG-ID: u-E2aCbWO1qHmioi4WISKA_1792478973
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACEF21956054; Tue, 20 Oct 2026 06:49:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B47C1800444; Tue, 20 Oct 2026 06:49:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D081021E6A04; Tue, 20 Oct 2026 08:49:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 06/12] qapi/block: Add BLOCK_IO_DELAY event
In-Reply-To: <20261019182028.45305-7-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 19 Oct 2026 20:20:22 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-7-hreitz@redhat.com>
Date: Tue, 20 Oct 2026 08:49:30 +0200
Message-ID: <87a4o8sw79.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This event will be emitted when a disk operation takes longer than a
> pre-defined threshold (as set on the block device).
>
> Note that the description refers to the "delay-report-ns" and
> "delay-stop-ns" block device properties, which are not yet available.
> A future commit in this series will add them.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block.json | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 8f4a71733c1..5f9f5c28050 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -649,3 +649,40 @@
>  ##
>  { 'enum': 'IoAccountingOperation',
>    'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
> +
> +##
> +# @BLOCK_IO_DELAY:
> +#
> +# Emitted when a disk operation takes longer than the pre-defined
> +# threshold (as set via the "delay-report-ns" / "delay-stop-ns"
> +# properties on the block device).

As in PATCH 01, "block device" could be confusing, because we use the
term both for frontends and backends.  I believe "delay-report-ns" and
"delay-stop-ns" are the qdev properties every block device model will
have [PATCH 11].

> +#
> +# Note that delays deliberately incurred by throttling do count
> +# towards the operation duration.
> +#

Please use the revised syntax for introductions, like you did in PATCH
01:

   # @name: introduction, best to keep it brief, but you may continue it
   #     like this if necessary.  If your text need to refer to
   #     arguments, it's almost certainly not brief introduction
   #     anymore.
   #
   # Additional text can go here for now.

I apologize for the inconvenience.  We need this to eliminate certain
syntactic ambiguities that plagued the doc generator.  We'll need it
some more for the doc inliner.

> +# @qom-path: path to the block device object in the QOM tree
> +#
> +# @operation: I/O operation
> +#
> +# @latency-ns: Ongoing duration of the operation (in nanoseconds)
> +#
> +# @action: Action that has been taken ("report" for "delay-report-ns"
> +#     or "stop" for "delay-stop-ns").  A "stop" action means the VM
> +#     will be stopped with the "io-hang" `RunState`, which does not
> +#     drain the block devices attached to the VM, because draining
> +#     would be counterproductive in case of a hanging I/O request.

This feels less than clear.  What exactly happens?  My best guess:

* When an operation takes longer than delay-report-ns, BLOCK_IO_DELAY is
  emitted with "action": "report" (but only once for this operation).

* When an operation takes longer than delay-stop-ns, the guest is
  stopped (run state becomes io-hang), and BLOCK_IO_DELAY is emitted
  with "action": "stop".

  Say we continue the guest.  Can the even be triggered again for this
  operation?

The three possible values are ignore, report, and stop.  You cover
report and stop.  Can ignore happen?

We should use ``literal`` markup for literal values.

> +#
> +# @offset: Request offset in the guest disk (in bytes), if available
> +#
> +# @bytes: Request length
> +#
> +# Since: 11.2
> +##
> +{ 'event': 'BLOCK_IO_DELAY',
> +  'data': {
> +      'qom-path': 'str',
> +      'operation': 'IoAccountingOperation',
> +      'latency-ns': 'uint64',
> +      'action': 'BlockErrorAction',
> +      '*offset': 'uint64',
> +      'bytes': 'uint64' } }


