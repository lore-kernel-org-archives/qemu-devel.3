Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3343D3CCB2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 06:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgGPg-0000mm-Dm; Thu, 15 Jan 2026 01:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgGPe-0000m7-2l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgGPc-0000aZ-MR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768456851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3C6ZFOf4QYRV0UJy5NoqvZsPaTrS8qylSOK0qrdPcL8=;
 b=GFJNpHQJe2qZ22eeOIiYzCpoFB5ynfPn3ufGpUpPDKjY+JObM8xwvL9MGnt6+li9HEiKv5
 RuyVhW2Khf8Fs+rFFGr12AEJ17HbeG9gdeTft4S3otvG0nw39HphOrLz/r4QKovQB5Midx
 OxHRNYndbKzSCUI6HdfkRi1pLCf9NjU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-A46fgnl3N2CoPK1j5gcfrg-1; Thu,
 15 Jan 2026 01:00:49 -0500
X-MC-Unique: A46fgnl3N2CoPK1j5gcfrg-1
X-Mimecast-MFC-AGG-ID: A46fgnl3N2CoPK1j5gcfrg_1768456848
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4691E1956046; Thu, 15 Jan 2026 06:00:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F082719560A7; Thu, 15 Jan 2026 06:00:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D3F121E692D; Thu, 15 Jan 2026 07:00:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 2/3] migration: Remove zero-blocks capability
In-Reply-To: <20260114195659.2543649-3-peterx@redhat.com> (Peter Xu's message
 of "Wed, 14 Jan 2026 14:56:58 -0500")
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-3-peterx@redhat.com>
Date: Thu, 15 Jan 2026 07:00:45 +0100
Message-ID: <871pjrza7m.fsf@pond.sub.org>
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

Peter Xu <peterx@redhat.com> writes:

> It was declared deprecated since 9.2.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst       |  6 ------
>  docs/about/removed-features.rst |  6 ++++++
>  qapi/migration.json             | 11 +----------
>  migration/options.c             |  5 -----
>  4 files changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index b499b2acb0..6e4e2e4833 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -575,12 +575,6 @@ deprecated in favor of explicitly using the ``file:`` URI with the
>  file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
>  command documentation for details on the ``fdset`` usage.
>  
> -``zero-blocks`` capability (since 9.2)
> -''''''''''''''''''''''''''''''''''''''
> -
> -The ``zero-blocks`` capability was part of the block migration which
> -doesn't exist anymore since it was removed in QEMU v9.1.
> -
>  COLO migration framework (since 11.0)
>  '''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index e81d79da47..8a9d21068a 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -717,6 +717,12 @@ Block migration has been removed. For a replacement, see "QMP
>  invocation for live storage migration with ``blockdev-mirror`` + NBD"
>  in docs/interop/live-block-operations.rst.
>  
> +``migrate-set-capabilities`` ``zero-blocks`` option (removed in 11.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``zero-blocks`` capability was part of the block migration capability
> +that got removed.  Removed with no replacement.
> +

Suggest something like

   The ``zero-blocks`` capability was accidentally left behind when
   block migration capability got removed in 9.1.  Removed with no
   replacement.

>  ``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  

[...]


