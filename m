Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CBC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY43m-00082U-Tv; Wed, 15 Jan 2025 09:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY43l-00082M-Eb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:07:53 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY43k-00027r-18
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=armD6io0RmDqTc+/mOgyLi04ESlkXMV9/yglO9pLXw0=; b=ELCdo7gswT3tSOyYzBii/HjChq
 OL9zDBqY86FBvnzXED86mSomHdsc2VVW1LFbTGv0eUdGIjl0yD0mMmublkZJMWaagkKz5v+oYJ9i9
 HkrzVV0PhTYOIf2eR8nOY0GzWAu6qjR7uDtIwgmBQkQpLXIj5YrBYovgztrj6v/uZjpI=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY43c-0060qZ-2j;
 Wed, 15 Jan 2025 14:07:45 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY43c-006QEO-2K;
 Wed, 15 Jan 2025 14:07:44 +0000
Date: Wed, 15 Jan 2025 15:07:40 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 1/2] hw/xen: Add xs_node_read() helper function
Message-ID: <Z4fBLEig8GlAPCv2@l14>
References: <20250110093531.23221-1-roger.pau@citrix.com>
 <20250110093531.23221-2-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110093531.23221-2-roger.pau@citrix.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 10:35:30AM +0100, Roger Pau Monne wrote:
> diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
> index d8dcc2f0107d..6478d25be5e6 100644
> --- a/include/hw/xen/xen-bus-helper.h
> +++ b/include/hw/xen/xen-bus-helper.h
> @@ -37,6 +37,10 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
>                    const char *node, const char *key, Error **errp,
>                    const char *fmt, ...)
>      G_GNUC_SCANF(6, 7);
> +char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
> +                   unsigned int *len, Error **errp,
> +                   const char *node_fmt, ...)
> +    G_GNUC_PRINTF(5, 6);

Could you add a comment about this new functions? It's quite different
from every other function in this header which deal with a xenstore
path. Every other function use "${node}/${key}" (As explain in the
comment above xs_node_vscanf()), but this one uses a printf format in
`node_fmt` (which could probably better be named `path_fmt` instead).

Otherwise, patch looks fine to me.

Cheers,

-- 
Anthony PERARD

