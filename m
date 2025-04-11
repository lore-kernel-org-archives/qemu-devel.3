Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A81FC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 17:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3IBZ-0002Z8-PB; Fri, 11 Apr 2025 13:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3IBW-0002WU-F2
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 13:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3IBU-0006DY-EM
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744392534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1XPsmmRe8gXwwk+SaTPpVoNAWSkG7VBiWfWVPajLJI=;
 b=L9Ru72pM54uqss/pmC8hn72ksRtz0lfLL11uqIkNKqIzjvZCUkgsMekmR/YQG4Ezyvsw67
 kU/07kuzEbiyqPe89FeRFhHNJpKAbhizTx7+cLvJCrjdPAYZvo6mDYWxpPzYlWbcUuOMy6
 Uye3QnIUsNuYkbptJ0/5KDXqDEcV8XU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-Tx_91J_7MmqpSG8Se2PQ9A-1; Fri,
 11 Apr 2025 13:28:50 -0400
X-MC-Unique: Tx_91J_7MmqpSG8Se2PQ9A-1
X-Mimecast-MFC-AGG-ID: Tx_91J_7MmqpSG8Se2PQ9A_1744392530
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D65B61955DC6; Fri, 11 Apr 2025 17:28:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 436BD1956094; Fri, 11 Apr 2025 17:28:46 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:28:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/2] block/io: skip head/tail requests on EINVAL
Message-ID: <sqmppkfqoxnivqod7lrwfb5aji2d2dfos3opru2wdzf4nwfgws@xg3lmrtjgkxl>
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-3-stefanha@redhat.com>
 <c2daf7e2-359b-4e4b-826f-511fa9c0e3fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2daf7e2-359b-4e4b-826f-511fa9c0e3fb@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 11, 2025 at 10:18:55AM +0200, Hanna Czenczek wrote:
> >           if (ret && ret != -ENOTSUP) {
> > -            goto out;
> > +            if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {
> 
> Could use `(offset | num) % align != 0`, but either way:

Use of | and & to perform alignment checks only works if align is
guaranteed to be a power of 2.  But isn't there (odd) hardware out
there with something like a 15M alignment, at which point you HAVE to
do separate checks with % because bitwise ops no longer work?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


