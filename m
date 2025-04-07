Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059CCC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oJk-0005CZ-OL; Mon, 07 Apr 2025 11:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oIC-0003am-Rv
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oIB-0007Md-4l
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744039302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QL3lNYVPvKtkwiQSBVFWcA1j83qKrH8yEWZkI+TWk6g=;
 b=ClwJYvt5FPwhpkA8tj+Hxt7B1YS38MZdGPDUkaMDGKoYkQhai3RckZLinVogLyd9czM0dM
 WoX/PFZ6/EIlTq4DTTgU05GBRy/w/U9o7/MG2c0lIVrq9f4lVxAxoMRUxywzc7hAW9z7uL
 JxjnFuw4FBHCOozxHtp8YYtSdiVqQuo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-6fSqYbvOOkyBv_-IuXQphQ-1; Mon,
 07 Apr 2025 11:21:38 -0400
X-MC-Unique: 6fSqYbvOOkyBv_-IuXQphQ-1
X-Mimecast-MFC-AGG-ID: 6fSqYbvOOkyBv_-IuXQphQ_1744039296
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972D71955E88; Mon,  7 Apr 2025 15:21:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28071801A6D; Mon,  7 Apr 2025 15:21:32 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:21:29 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com, devel@lists.libvirt.org,
 pkrempa@redhat.com, michael.roth@amd.com, pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] qapi/block-core: derpecate some block-job- APIs
Message-ID: <2rmedwqzuool3cejadxb4m5bypc3owdiagwk5jjwfsc4ag5uob@ivwo7xjc55xs>
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
 <20250404193154.707145-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404193154.707145-3-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 04, 2025 at 10:31:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:

In the subject line: s/derpecate/deprecate/

> For change, pause, resume, complete, dismiss and finalize actions
> corresponding job- and block-job commands are almost equal. The
> difference is in find_block_job_locked() vs find_job_locked()
> functions. What's different?
> 
> 1. find_block_job_locked() do check, is found job a block-job. This OK

s/do check, is found job/checks whether the found job is/
s/This OK/This is OK/

>    when moving to more generic API, no needs to document this change.
> 
> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>    find_job_locked() reports GenericError. So, lets document this

let's

>    difference in deprecated.txt. Still, for dismiss and finalize errors
>    are not documented at all, so be silent in deprecated.txt as well.
> 
> ACKed-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
>  qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 76291fdfd6..afa7075051 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
>  ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>  details.
>  
> +``block-job-pause`` (since 10.1)
> +''''''''''''''''''''''''''''''''
> +
> +Use ``job-pause`` instead. The only difference is that ``job-pause``
> +always reports GenericError on failure when ``block-job-pause`` reports
> +DeviceNotActive when block-job is not found.

Typo fixes are minor, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


