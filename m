Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E86C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0La0-0001Le-Lo; Fri, 26 Apr 2024 09:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0LZu-0001L2-0d
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0LZs-0004e7-9o
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714137923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I637+LmtIYq/f+9+dvIp7PhFNQMjCFlwQl/tIRaFyLI=;
 b=Jv7JJsXrNvKpMmtrYCZREW+gYDkaLg2x9eN6ryPUig9cwN4qs9Mbzhb/2262vjfrQ1GSoW
 zeqedOvCQMj3GVmhAGsIKqhh727HnvDz6GItFjiUZP5r93UBIcru8n4kc0yQa1d3M7vzcU
 xdFUMpeSiUcCYPlloSLeQoeLMqv/NFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-YeadyHRUP32_hPaD_d97xA-1; Fri,
 26 Apr 2024 09:25:21 -0400
X-MC-Unique: YeadyHRUP32_hPaD_d97xA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7E211C05153;
 Fri, 26 Apr 2024 13:25:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BA8740F569;
 Fri, 26 Apr 2024 13:25:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EC9B21E6680; Fri, 26 Apr 2024 15:25:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 2/6] migration: Remove 'inc' option from migrate command
In-Reply-To: <20240425150939.19268-3-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 25 Apr 2024 12:09:35 -0300")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-3-farosas@suse.de>
Date: Fri, 26 Apr 2024 15:25:19 +0200
Message-ID: <8734r8tfwg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> The block incremental option for block migration has been deprecated
> in 8.2 in favor of using the block-mirror feature. Remove it now.
>
> Deprecation commit 40101f320d ("migration: migrate 'inc' command
> option is deprecated.").
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst       |  9 ------
>  docs/about/removed-features.rst | 14 +++++++++
>  migration/block.c               |  1 -
>  migration/migration-hmp-cmds.c  | 18 ++---------
>  migration/migration.c           | 24 +++++----------
>  migration/options.c             | 30 +-----------------
>  qapi/migration.json             | 54 +++++++--------------------------
>  7 files changed, 35 insertions(+), 115 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4d9d6bf2da..25b309dde4 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -488,15 +488,6 @@ option).
>  Migration
>  ---------
>  
> -``inc`` migrate command option (since 8.2)
> -''''''''''''''''''''''''''''''''''''''''''
> -
> -Use blockdev-mirror with NBD instead.
> -
> -As an intermediate step the ``inc`` functionality can be achieved by
> -setting the ``block-incremental`` migration parameter to ``true``.
> -But this parameter is also deprecated.
> -
>  ``blk`` migrate command option (since 8.2)
>  ''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 9873f59bee..e62fc760f1 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -620,6 +620,13 @@ was superseded by ``sections``.
>  Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
>  for more than 10 years. Removed with no replacement.
>  
> +``migrate`` command option ``inc`` (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Use blockdev-mirror with NBD instead. See "QMP invocation for live
> +storage migration with ``blockdev-mirror`` + NBD" in
> +docs/interop/live-block-operations.rst for a detailed explanation.

You didn't just copy the text from deprecated.rst, you made it more
useful.  Appreciated!

> +
>  Human Monitor Protocol (HMP) commands
>  -------------------------------------
>  
> @@ -680,6 +687,13 @@ This command didn't produce any output already. Removed with no replacement.
>  The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
>  command, which has the same behaviour but a less misleading name.
>  
> +``migrate`` command ``-i`` option (removed in 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Use blockdev-mirror with NBD instead. See "QMP invocation for live
> +storage migration with ``blockdev-mirror`` + NBD" in
> +docs/interop/live-block-operations.rst for a detailed explanation.
> +
>  Host Architectures
>  ------------------
>  

[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


