Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B9C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmRL-0002t2-RV; Thu, 29 Feb 2024 14:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rfmRG-0002sK-4X
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rfmRD-0006VQ-F8
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709236284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swI9MfhEAVQ05KwXTS4pI/p1jmbQ39gOuo+koSh4XKA=;
 b=cWvCiSlyD6tcEnGiqVhgo2zB5b8xfczq6rjKwxBlpphQcIxtvwoNbCl/jOy0jEz14fZUj3
 xMt5Og2jqhMllZgkEdKPOE9Dw3ZoA8I/JnBj4e784WUQpy1QXT8OsBZDneFOmmK080lfNr
 xX/f9I+Xf5/IcK2sT0ARSZC+f+1tlPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-BQj-FlGZPxipNT2Ectiamw-1; Thu, 29 Feb 2024 14:51:20 -0500
X-MC-Unique: BQj-FlGZPxipNT2Ectiamw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D74110B0701;
 Thu, 29 Feb 2024 19:51:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC49492BC6;
 Thu, 29 Feb 2024 19:51:18 +0000 (UTC)
Date: Thu, 29 Feb 2024 13:51:16 -0600
From: Eric Blake <eblake@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 03/16] block: Fix missing ERRP_GUARD() for error_prepend()
Message-ID: <gmziaj7f2xj6qxharirunbm5apnqffz6tl33emtjsdkn5uqkxb@hdfllvc76gdk>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-4-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228163723.1775791-4-zhao1.liu@linux.intel.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 29, 2024 at 12:37:10AM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
> 

> 
> In block.c, there're 4 functions passing @errp to error_prepend()
> without ERRP_GUARD():
>  - bdrv_co_create_opts_simple()
>  - parse_json_filename()
>  - bdrv_open_backing_file()
>  - bdrv_append_temp_snapshot()
> 
> bdrv_co_create_opts_simple(), as an implementation of
> BolckDriver.bdrv_co_create_opts(), its @errp parameter is so widely

BlockDriver

> sourced that it is necessary to protect it with ERRP_GUARD().
> 
> Though the @errp parameters passed to parse_json_filename(),
> bdrv_open_backing_file() and bdrv_append_temp_snapshot() points to their
> callers' local_err, to follow the requirement of @errp, also add missing
> ERRP_GUARD() at their beginning.
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>      ("error: New macro ERRP_GUARD()").
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  block.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


