Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E669C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNUL-0003Y0-FG; Wed, 28 May 2025 16:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNUI-0003Wq-5H
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNUE-0002D4-5A
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748464490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sEuFc81vvNHZSdR+fql8sZJxZDQBKDqMhGGzFuWFiKY=;
 b=O2msgxLql1dLcGNu8rvsxvl3ldnWbWEZsdPhyysPaI0Aq484rUKpVNG7iykbBz8TWT+qBu
 VhCqYQasMM7IGmM6jvi99Ki2A61u++8YbgsqXX3hG9Y4vPQcUA2tMg+SJn76cLia4H5jPq
 m0qVXqrQ9HQdL55pkxRbi93eNobEqRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-HEeUKKtVMreTVR3Ft37GAA-1; Wed,
 28 May 2025 16:34:48 -0400
X-MC-Unique: HEeUKKtVMreTVR3Ft37GAA-1
X-Mimecast-MFC-AGG-ID: HEeUKKtVMreTVR3Ft37GAA_1748464487
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55D4418003FC; Wed, 28 May 2025 20:34:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7942E18003FC; Wed, 28 May 2025 20:34:45 +0000 (UTC)
Date: Wed, 28 May 2025 15:34:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, 
 Chao Gao <chao.gao@intel.com>
Subject: Re: [RFC 02/11] aio-posix: keep polling enabled with fdmon-io_uring.c
Message-ID: <kg2xppwdqukx6b5tj3x5i2rjlhp2muao22bhl4xlv72eycsuyq@dhjd5ynbpv7e>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-3-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 28, 2025 at 03:09:07PM -0400, Stefan Hajnoczi wrote:
> Commit 816a430c517e ("util/aio: Defer disabling poll mode as long as
> possible") kept polling enabled when the event loop timeout is 0. Since
> there is no timeout the event loop will continue immediately and the
> overhead of disabling and re-enabling polling can be avoided.
> 
> fdmon-io_uring.c is unable to take advantage of this optimization
> because its ->need_wait() function returns true whenever there are new
> io_uring SQEs to submit:
> 
>   if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Polling will be disabled even when timeout == 0.
> 
> Extend the optimization to handle the case when need_wait() returns true
> and timeout == 0.
> 
> Cc: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


