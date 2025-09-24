Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ihx-0005mI-Ql; Wed, 24 Sep 2025 02:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1Ihu-0005kV-CD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1Ihq-0002tX-Us
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758694220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qlPcIX8nQulyC2R3FdsPG3LybREYLmeO3L2NZpO9tCM=;
 b=FJpZ57f0DW/zuA4dQBR6oWta8fPT/RxmGTz43FrQ8BnCFlOybx6uZDb17qLTyRQcxQo7Cp
 SHSD95P0UM6hSwaEhKXjOMxwQV7x0Rg2k91blLYy/SjVpiJ+OJ8+4qI6S2sorbI20XDmRR
 OhnDMAW2n1vrCAqQhRjP0jFP+u1KB0E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-ZgUr6202PoWhfeLHJbJuXA-1; Wed,
 24 Sep 2025 02:10:12 -0400
X-MC-Unique: ZgUr6202PoWhfeLHJbJuXA-1
X-Mimecast-MFC-AGG-ID: ZgUr6202PoWhfeLHJbJuXA_1758694212
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CABAD19560A2; Wed, 24 Sep 2025 06:10:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20F3A180035E; Wed, 24 Sep 2025 06:10:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2584321E6A27; Wed, 24 Sep 2025 08:10:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] block: Expose block limits for images in QMP
In-Reply-To: <20250923163735.378254-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 23 Sep 2025 18:37:34 +0200")
References: <20250923163735.378254-1-kwolf@redhat.com>
 <20250923163735.378254-2-kwolf@redhat.com>
Date: Wed, 24 Sep 2025 08:10:08 +0200
Message-ID: <87o6r05qkf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> This information can be useful both for debugging and for management
> tools trying to configure guest devices with the optimal limits
> (possibly across multiple hosts). There is no reason not to make it
> available, so just add it to BlockNodeInfo.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json             | 59 ++++++++++++++++++++++++++++++++
>  block/qapi.c                     | 34 ++++++++++++++++--
>  tests/qemu-iotests/184           |  3 +-
>  tests/qemu-iotests/184.out       |  8 -----
>  tests/qemu-iotests/common.filter |  3 +-
>  5 files changed, 94 insertions(+), 13 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index dc6eb4ae23..eda041ac1c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -275,6 +275,62 @@
>        'file': 'ImageInfoSpecificFileWrapper'
>    } }
>  
> +##
> +# @BlockLimitsInfo:
> +#
> +# @request-alignment: Alignment requirement, in bytes, for offset/length of I/O
> +#     requests.
> +#
> +# @max-discard: Maximum number of bytes that can be discarded at once. If not
> +#     present, there is no specific maximum.
> +#
> +# @discard-alignment: Optimal alignment for discard requests in bytes. A power
> +#     of 2 is best, but not mandatory. If not present, discards don't have a
> +#     alignment requirement different from @request-alignment.

What does the second sentence try to convey?  As far as I can tell, QMP
has BlockLimitsInfo is only in the result of query-block and
query-named-block-nodes, i.e. it's not something the user picks.

> +#
> +# @max-write-zeroes: Maximum number of bytes that can be zeroed out at once. If
> +#     not present, there is no specific maximum.
> +#
> +# @write-zeroes-alignment: Optimal alignment for write_zeroes requests in
> +#     bytes. A power of 2 is best, but not mandatory. If not present,
> +#     write_zeroes doesn't have a alignment requirement different from
> +#     @request-alignment.

Likewise.

> +#
> +# @opt-transfer: Optimal transfer length in bytes. If not present, there is no
> +#     preferred size.
> +#
> +# @max-transfer: Maximal transfer length in bytes. If not present, there is no
> +#     specific maximum.
> +#
> +# @max-hw-transfer: Maximal hardware transfer length in bytes.  Applies
> +#     whenever transfers to the device bypass the kernel I/O scheduler, for
> +#     example with SG_IO. If not present, there is no specific maximum.
> +#
> +# @max-iov: Maximum number of scatter/gather elements
> +#
> +# @max-hw-iov: Maximal number of scatter/gather elements allowed by the hardware.

Maximum number

> +#     Applies whenever transfers to the device bypass the kernel I/O scheduler,
> +#     for example with SG_IO. If not present, the hardware limits is unknown
> +#     and @max-iov is always used.
> +#
> +# @min-mem-alignment: memory alignment in bytes so that no bounce buffer is needed
> +#
> +# @opt-mem-alignment: memory alignment in bytes that is used for bounce buffers

Why is this "opt"?  I guess it means "optimal".

> +##
> +{ 'struct': 'BlockLimitsInfo',
> +  'data': { 'request-alignment': 'uint32',
> +            '*max-discard': 'uint64',
> +            '*discard-alignment': 'uint32',
> +            '*max-write-zeroes': 'uint64',
> +            '*write-zeroes-alignment': 'uint32',
> +            '*opt-transfer': 'uint32',
> +            '*max-transfer': 'uint32',
> +            '*max-hw-transfer': 'uint32',
> +            'max-iov': 'int',
> +            '*max-hw-iov': 'int',
> +            'min-mem-alignment': 'size',
> +            'opt-mem-alignment': 'size' } }
> +
>  ##
>  # @BlockNodeInfo:
>  #
> @@ -304,6 +360,8 @@
>  #
>  # @snapshots: list of VM snapshots
>  #
> +# @limits: block limits that are used for I/O on the node (Since 10.2)
> +#
>  # @format-specific: structure supplying additional format-specific
>  #     information (since 1.7)
>  #
> @@ -315,6 +373,7 @@
>             '*cluster-size': 'int', '*encrypted': 'bool', '*compressed': 'bool',
>             '*backing-filename': 'str', '*full-backing-filename': 'str',
>             '*backing-filename-format': 'str', '*snapshots': ['SnapshotInfo'],
> +           '*limits': 'BlockLimitsInfo',
>             '*format-specific': 'ImageInfoSpecific' } }
>  
>  ##

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

[...]


