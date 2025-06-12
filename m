Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90662C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 18:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPn4F-0005Eo-SK; Thu, 12 Jun 2025 14:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uPn44-0005ER-O4
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 14:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uPn41-00027a-TV
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 14:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749754452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cD7uA14Ilt0rQ5dNhWnX491vXI1MsjrqMDki18MGL4=;
 b=X1mfpmFGhc6WX0kjaeyt6IsSyPUnWSyBJandGDOv0pjUc41LM2hGG9uP6UuePnbeBGwjfr
 mWYyxsESskQaLr1xKZUwCAPjul4Mvl4EwKJd90zkm70ZGf1znaETGJgtrej6OcpTMKkFLg
 4roVqot5KsA2t10YGZ20NXhxTJt/MHU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-ryJRcbZSPjSNI_hKIqSOwQ-1; Thu,
 12 Jun 2025 14:54:09 -0400
X-MC-Unique: ryJRcbZSPjSNI_hKIqSOwQ-1
X-Mimecast-MFC-AGG-ID: ryJRcbZSPjSNI_hKIqSOwQ_1749754448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C9131956048; Thu, 12 Jun 2025 18:54:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.67])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62F8C30044CC; Thu, 12 Jun 2025 18:54:06 +0000 (UTC)
Date: Thu, 12 Jun 2025 13:54:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/4] qcow2: Add keep_data_file command-line option
Message-ID: <i4xgja72v56a37bsfexufxeuic4vdzhcmjzrlr2kjk3eugbnxy@sdc2o5e3ykuj>
References: <20250530084448.192369-1-hreitz@redhat.com>
 <20250530084448.192369-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530084448.192369-2-hreitz@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 30, 2025 at 10:44:44AM +0200, Hanna Czenczek wrote:
> Add a command-line-only option to prevent overwriting the file specified
> as external data file.
> 
> This option is only available on the qemu-img create command line, not
> via blockdev-create, as it makes no sense there: That interface
> separates file creation and formatting, so where the external data file
> attached to a newly formatted qcow2 node comes from is completely up to
> the user.
> 
> Implementation detail: Enabling this option will not only not overwrite
> the external data file, but also assume it already exists, for two
> reasons:
> - It is simpler than checking whether the file exists, and only skipping
>   creating it when it does not.  It is therefore also less error-prone,
>   i.e. we can never accidentally overwrite an existing file because we
>   made some mistake in checking whether it exists.
> - I think it makes sense from a user's perspective: You set this option
>   when you want to use an existing data file, and you unset it when you
>   want a new one.  Getting an error when you expect to use an existing
>   data file seems to me a nice warning that something is not right.

And it also helps if you accidentally type something like nbd://... as
the data file and expect it to exist, but qemu interprets that as a
local filename ./nbd:/... which (hopefully) does not exist.

> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/block/block_int-common.h |  1 +
>  block/qcow2.c                    | 75 ++++++++++++++++++++++++++++++--
>  tests/qemu-iotests/082.out       | 18 ++++++++
>  3 files changed, 90 insertions(+), 4 deletions(-)
> 
> @@ -3933,6 +3935,22 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
>          qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
>      }
>  
> +    val = qdict_get_try_str(qdict, BLOCK_OPT_KEEP_DATA_FILE);
> +    if (val) {
> +        if (!strcmp(val, "on")) {
> +            keep_data_file = true;
> +        } else if (!strcmp(val, "off")) {
> +            keep_data_file = false;
> +        } else {
> +            error_setg(errp,
> +                       "Invalid value '%s' for '%s': Must be 'on' or 'off'",
> +                       val, BLOCK_OPT_KEEP_DATA_FILE);

Do we have a function that does this parsing so that we don't have to
open-code copy-paste (with slight differences) this sort of parsing
into similar clients?  A quick grep for "'on' or 'off'" shows at least:

monitor/hmp.c:                    monitor_printf(mon, "Expected 'on' or 'off'\n");
net/filter.c:                         "should be 'on' or 'off'");
qapi/qapi-util.c:               "'on' or 'off'");
qapi/qobject-input-visitor.c:                   full_name(qiv, name), "'on' or 'off'");

Not necessarily a show-stopper to this patch, but food for thought in
the technical debt department.

> @@ -4004,6 +4029,40 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
>          goto finish;
>      }
>  
> +    qcow2_opts = &create_options->u.qcow2;
> +
> +    if (!qcow2_opts->has_preallocation) {
> +        qcow2_opts->preallocation = PREALLOC_MODE_OFF;
> +    }
> +    if (!qcow2_opts->has_data_file_raw) {
> +        qcow2_opts->data_file_raw = false;
> +    }
> +
> +    if (keep_data_file &&
> +        qcow2_opts->preallocation != PREALLOC_MODE_OFF &&
> +        qcow2_opts->preallocation != PREALLOC_MODE_METADATA)
> +    {
> +        error_setg(errp, "Preallocating more than only metadata would "
> +                   "overwrite the external data file's content and is "
> +                   "therefore incompatible with '%s=on'",
> +                   BLOCK_OPT_KEEP_DATA_FILE);

I like this safety check.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


