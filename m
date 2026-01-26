Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135FD19513
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSFY-0006tm-TD; Mon, 26 Jan 2026 14:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vkSFW-0006tA-8y
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vkSFU-0003Nx-QU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769455664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1FR0cwhD+i6e3O50q/50anwhRHw+yFNuQqfe+61sPA=;
 b=a09YaXVIlOUPqxTlNdtLJ8W11tlcBFtkRNsnl7ZBalOYHVGV4OsFAJVkysfmUAQPdT3HA/
 34+xX9pOTyb+xUtKMbIgDggPEyjPH480xkpM9FuXWtt8pLTW3+Ca+STVAIqNs7IbJDhQkk
 dzmRCE0Wq6w2IioRx2C9rVwk8mblP7k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-VSVhv9xLMSqvThsYWWelRw-1; Mon,
 26 Jan 2026 14:27:39 -0500
X-MC-Unique: VSVhv9xLMSqvThsYWWelRw-1
X-Mimecast-MFC-AGG-ID: VSVhv9xLMSqvThsYWWelRw_1769455658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68EF11956096; Mon, 26 Jan 2026 19:27:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB9F1800993; Mon, 26 Jan 2026 19:27:36 +0000 (UTC)
Date: Mon, 26 Jan 2026 13:27:33 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/2] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aXe-G3OaSiHz890m@redhat.com>
References: <cover.1768920111.git.pkrempa@redhat.com>
 <a28928bee84afcc1755695db58ca6c358da43a76.1768920111.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28928bee84afcc1755695db58ca6c358da43a76.1768920111.git.pkrempa@redhat.com>
User-Agent: NeoMutt/20251211
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 20, 2026 at 03:45:56PM +0100, Peter Krempa wrote:
> From: Peter Krempa <pkrempa@redhat.com>
> 
> Some time ago (commit facda5443f5a8) I've added 'flat' mode (which
> omits 'backing-image' key in reply) to 'query-named-block-nodes' to
> minimize the size of the returned JSON for deeper backing chains.
> 
> While 'query-block' behaved slightly better it turns out that in libvirt
> we do call 'query-block' to figure out some information about the
> block device (e.g. throttling info) but we don't look at the backing
> chain itself.
> 
> Wire up 'flat' for 'query-block' so that libvirt can ask for an
> abbreviated output. The implementation is much simpler as the internals
> are shared with 'query-named-block-nodes'.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/monitor/block-hmp-cmds.c | 4 ++--
>  block/qapi.c                   | 9 +++++----
>  qapi/block-core.json           | 7 +++++++
>  ui/cocoa.m                     | 2 +-
>  4 files changed, 15 insertions(+), 7 deletions(-)
> +++ b/qapi/block-core.json
> @@ -855,6 +855,12 @@
>  #
>  # Get a list of `BlockInfo` for all virtual block devices.
>  #
> +# @flat: Omit the nested data about backing image (Omitted are
> +#        contents of 'backing-image' key of the 'ImageInfo' struct
> +#        which is returned as 'image' key of 'BlockDeviceInfo' struct
> +#        returned as 'inserted' key in  'BlockInfo' struct returned

Extra space.

> +#        by this command).  Default is false (Since 11.0)

Still hard to parse.  Maybe:

@flat: Omit nested data about the backing image (ie. the contents at
       'inserted.image.backing-image' are trimmed to avoid duplicate
       data about that backing image).  Default is false (Since 11.0)

The idea makes sense to me, but I will defer to Markus on whether the
wording still needs a tweak.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


