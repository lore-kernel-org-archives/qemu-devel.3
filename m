Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0832C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1xC-0002mU-Tm; Mon, 03 Feb 2025 14:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf1wv-0002gc-Gk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf1wu-00085O-3E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738610255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7LReFs9V+YpPSe4omsW0PaJo7v0MD/Enh0YeZRWlOA=;
 b=DaNBb8psilsduJzNLGgzYuuXY0BsOkWh8fPpEqrAZUvhjRv+//fdAffsMZ8Z2eKGBZN/1R
 i8ddBasFGEZuA+TxGmKploysfq5deyau/xj+PBxOi6L1lSZ1if4AHvGWKpCzFKLFn2FH3H
 wHqh7/RUrpyOcDOX514d9kau/slJe40=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-4Y6Kp4TkMNu3wCX9ZC3Iug-1; Mon,
 03 Feb 2025 14:17:33 -0500
X-MC-Unique: 4Y6Kp4TkMNu3wCX9ZC3Iug-1
X-Mimecast-MFC-AGG-ID: 4Y6Kp4TkMNu3wCX9ZC3Iug
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5BF71955DC6; Mon,  3 Feb 2025 19:17:32 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.73])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3AA1180099C; Mon,  3 Feb 2025 19:17:29 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:17:27 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] nbd/server: Support inactive nodes
Message-ID: <qcfwxx7pzewxd2arkcgad6ywtenfpm6oo5e7asffivunogtal3@v4coeuhv3azm>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-3-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 31, 2025 at 10:50:48AM +0100, Kevin Wolf wrote:
> In order to support running an NBD export on inactive nodes, we must
> make sure to return errors for any operations that aren't allowed on
> inactive nodes. Reads are the only operation we know we need for
> inactive images, so to err on the side of caution, return errors for
> everything else, even if some operations could possibly be okay.

We may still find a use case for block status on an inactive node
(especially if that helps us take more accurate snapshots, which is
the whole point of wanting to read pre-activation).  But I'm okay if
we defer that to a separate patch only if it actually proves to be
needed.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


