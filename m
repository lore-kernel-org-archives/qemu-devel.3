Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B8C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmIQ-0007Lu-Fq; Wed, 05 Feb 2025 15:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmIP-0007LF-1Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:46:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmIN-0008VM-2Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738788410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR6o3e74F6v0nc8nk4LXrp3rCFtG+iLbVyMDIHTC5Nc=;
 b=fj+mqpaANCCYrcjqRafYh/Q8OgP3OkHLyrpLW1DsKVZrawJ2FBANB56hGJ7JGlILYbw57j
 XZ8Nppt8LGUM8wQmQXRN4dRcKGo7Rd3t61WFfD6EXMkh71sQkmaaHDzd8vNzxQmzpiNI8R
 WwhYjWgO4zMguAk61fls8n5LRE1NDqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-BCRAa0tbPJOKumeEo7syJg-1; Wed,
 05 Feb 2025 15:46:47 -0500
X-MC-Unique: BCRAa0tbPJOKumeEo7syJg-1
X-Mimecast-MFC-AGG-ID: BCRAa0tbPJOKumeEo7syJg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 426F719560BC; Wed,  5 Feb 2025 20:46:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BE3B300018D; Wed,  5 Feb 2025 20:46:42 +0000 (UTC)
Date: Wed, 5 Feb 2025 14:46:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 15/16] iotests: Add qsd-migrate case
Message-ID: <4kdbqdoosko5uswdxa2ie46nt2lxu4e5fmge4l7zefsltd7jvw@3qufmtymtegx>
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-16-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204211407.381505-16-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 04, 2025 at 10:14:06PM +0100, Kevin Wolf wrote:
> Test that it's possible to migrate a VM that uses an image on shared
> storage through qemu-storage-daemon.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/tests/qsd-migrate     | 140 +++++++++++++++++++++++
>  tests/qemu-iotests/tests/qsd-migrate.out |  59 ++++++++++
>  2 files changed, 199 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/qsd-migrate
>  create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out
> 
> +    iotests.log('\nPre-switchover: Reconfigure QSD instances')
> +
> +    iotests.log(qsd_src.qmp('blockdev-set-active', {'active': False}))
> +
> +    # Reading is okay from both sides while the image is inactive. Note that
> +    # the destination may have stale data until it activates the image, though.
> +    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
> +                       use_log=True, qdev=True)
> +    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read 0 4k',
> +                       use_log=True, qdev=True)

Interesting observation about reading from stale caches, but it makes
sense with a bit more thought and doesn't hurt the validity of the
series.

R-b stands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


