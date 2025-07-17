Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F4C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucHj4-000121-BC; Thu, 17 Jul 2025 02:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucHiy-0000ym-Np
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucHiv-0004rT-SW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752732240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yowgUpN7NagJa+ScfKLiizzy6/v3TS2dWqsmXMVegkA=;
 b=Pfmh5lVnZ/TyNow6t9ViI3u+JfaEWiLp+EjApwpG6dN98dIV8G15MuUm2JCNCBIisTbMIW
 n3vAew3go0ffpSgrto/a2Aozx654izylRge8F+d+zJKVuQ2FL1AErn0f5nRgM5E44JoWzd
 8jQc3QqYkMcly7fGW3lpvVFOxGiJTQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-IdyRSkktMIeJI2eCWUw6YA-1; Thu,
 17 Jul 2025 02:03:57 -0400
X-MC-Unique: IdyRSkktMIeJI2eCWUw6YA-1
X-Mimecast-MFC-AGG-ID: IdyRSkktMIeJI2eCWUw6YA_1752732236
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D318E1800C32; Thu, 17 Jul 2025 06:03:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5EE1954213; Thu, 17 Jul 2025 06:03:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D249D21E6A27; Thu, 17 Jul 2025 08:03:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  bschubert@ddn.com,
 fam@euphon.net,  hreitz@redhat.com,  kwolf@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
In-Reply-To: <20250716183824.216257-2-hibriansong@gmail.com> (Brian Song's
 message of "Wed, 16 Jul 2025 14:38:24 -0400")
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
Date: Thu, 17 Jul 2025 08:03:51 +0200
Message-ID: <87seivnyk8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Brian Song <hibriansong@gmail.com> writes:

> This work provides an initial implementation of fuse-over-io_uring
> support for QEMU export. According to the fuse-over-io_uring protocol
> specification, the userspace side must create the same number of queues
> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
> queue contains only a single SQE entry, which is used to validate the
> correctness of the fuse-over-io_uring functionality.
>
> All FUSE read and write operations interact with the kernel via io
> vectors embedded in the SQE entry during submission and CQE fetching.
> The req_header and op_payload members of each entry are included as
> parts of the io vector: req_header carries the FUSE operation header,
> and op_payload carries the data payload, such as file attributes in a
> getattr reply, file content in a read reply, or file content being
> written to the FUSE client in a write operation.
>
> At present, multi-threading support is still incomplete. In addition,
> handling connection termination and managing the "drained" state of a
> FUSE block export in QEMU remain as pending work.
>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>

[...]

> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
> index 35ab2d7807..4ec0648e95 100644
> --- a/docs/tools/qemu-storage-daemon.rst
> +++ b/docs/tools/qemu-storage-daemon.rst
> @@ -78,7 +78,7 @@ Standard options:
>  .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
>    --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>    --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
> -  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
> +  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,uring=on|off]
>    --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]
>  
>    is a block export definition. ``node-name`` is the block node that should be
> @@ -111,7 +111,13 @@ Standard options:
>    that enabling this option as a non-root user requires enabling the
>    user_allow_other option in the global fuse.conf configuration file.  Setting
>    ``allow-other`` to auto (the default) will try enabling this option, and on
> -  error fall back to disabling it.
> +  error fall back to disabling it. Once ``uring`` is enabled
> +  (off by default), the initialization of FUSE-over-io_uring-related settings
> +  will be performed in the FUSE_INIT request handler. This setup bypasses
> +  the traditional /dev/fuse communication mechanism and instead uses io_uring
> +  for handling FUSE operations.
> +
> +

Drop the additional blank lines, please.

This is user-facing documentation.  Do users care about "the FUSE_INIT
request handler"?

>  
>    The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
>    to create the VDUSE device.
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 9ae703ad01..7d14f3f1ba 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -184,12 +184,16 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @uring: If we enable uring option, it will enable FUSE over io_uring
> +#         feature for QEMU FUSE export.  (default: false)
> +#

Missing (since 10.2).

Please format just like everywhere else:

   # @uring: If we enable uring option, it will enable FUSE over
   #     io_uring feature for QEMU FUSE export.  (default: false)


Kernel documentation calls the thing "FUSE-over-io-uring":
https://docs.kernel.org/filesystems/fuse-io-uring.html

The text feels awkward.  Here's my attempt:

   # @uring: Use FUSE-over-io-uring.  (since 10.2; default: false)

>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*uring': 'bool' },
>    'if': 'CONFIG_FUSE' }
>  
>  ##

[...]


