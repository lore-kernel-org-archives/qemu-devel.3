Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1066CF11FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syujT-0004LV-Bz; Thu, 10 Oct 2024 11:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syujS-0004LB-1G
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syujQ-0003k3-76
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcItGc+BHJvYTsUwZJuf6ZrPGesLFo67k2o216v5tqQ=;
 b=QCrmwK8UolzTQppooeeU3j/REDgltY1TNwsK4oTJDoD1UOt9MgrwQx3MAEHEMDP8i0l5We
 HsVThxbLTCXZT3gtFF253b8/OWIoPQdDFIhIpDfRve3Kv9wDuDdnqEAziAT9CSLZg+Kh//
 8piWJvTEzKn+Lfxvt5p23+6jj0h6ilw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-lZdI08WjNoiM5nUu04ouyQ-1; Thu,
 10 Oct 2024 11:05:31 -0400
X-MC-Unique: lZdI08WjNoiM5nUu04ouyQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C5B1955D50; Thu, 10 Oct 2024 15:05:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4535B19560A2; Thu, 10 Oct 2024 15:05:21 +0000 (UTC)
Date: Thu, 10 Oct 2024 16:05:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, xieyongji@bytedance.com, kwolf@redhat.com,
 hreitz@redhat.com, Coiby.Xu@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 2/7] block: Improve errors about block sizes
Message-ID: <ZwftLPKwkdrQbprq@redhat.com>
References: <20241010145630.985335-1-armbru@redhat.com>
 <20241010145630.985335-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010145630.985335-3-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 10, 2024 at 04:56:25PM +0200, Markus Armbruster wrote:
> Block sizes need to be a power of two between 512 and an arbitrary
> limit, currently 2MiB.
> 
> Commit 5937835ac4c factored block size checking out of set_blocksize()
> into new check_block_size(), for reuse in block/export/.
> 
> Its two error messages are okay for the original purpose:
> 
>     $ qemu-system-x86_64 -device ide-hd,physical_block_size=1
>     qemu-system-x86_64: -device ide-hd,physical_block_size=1: Property .physical_block_size doesn't take value 1 (minimum: 512, maximum: 2097152)
>     $ qemu-system-x86_64 -device ide-hd,physical_block_size=513
>     qemu-system-x86_64: -device ide-hd,physical_block_size=513: Property .physical_block_size doesn't take value '513', it's not a power of 2
> 
> They're mildly off for block exports:
> 
>     $ qemu-storage-daemon --blockdev node-name=nod0,driver=file,filename=foo.img --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1
>     qemu-storage-daemon: --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1: Property exp0.logical-block-size doesn't take value 1 (minimum: 512, maximum: 2097152)
> 
> The error message talks about a property.  CLI options like --export
> don't have properties, they have parameters.
> 
> Replace the two error messages by a single one that's okay for both
> purposes.  Looks like this:
> 
>     qemu-storage-daemon: --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1: parameter logical-block-size must be a power of 2 between 512 and 2097152
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/block-helpers.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


