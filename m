Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD12EF48CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmRO-0006DO-Jx; Fri, 13 Feb 2026 01:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqmRK-0006Cn-Sh
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqmRJ-0003TQ-4U
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770963242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaWNMXtoZKSecdiHQ55VTitLjt9H7wwqom3288saEeM=;
 b=bxKLAw6WLcQ6lre+yfb7NyE1uIt3okvxjQBOJV6RGGmS6SXaQvK26MP9uCb6Dr3m1Gw6i/
 DcA/FR4/i+spmmEiTy45o0P5ZWMR+AuFTolD8kEU3ZYnQFVdtGs3dFaZi733XBcsA7lfyy
 YkYBYlGLLx1WmuuCxKK6fXU3lk8n1Fg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Z_YuI5x8OleDSssLvTX_9g-1; Fri,
 13 Feb 2026 01:13:59 -0500
X-MC-Unique: Z_YuI5x8OleDSssLvTX_9g-1
X-Mimecast-MFC-AGG-ID: Z_YuI5x8OleDSssLvTX_9g_1770963238
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F47E195605B; Fri, 13 Feb 2026 06:13:57 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53B651955D85; Fri, 13 Feb 2026 06:13:54 +0000 (UTC)
Date: Fri, 13 Feb 2026 07:13:51 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, xeor@yandex-team.ru,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
Message-ID: <aY7BH65INV42BDQu@angien.pipo.sk>
References: <20260212212738.141780-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212212738.141780-1-kwolf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 12, 2026 at 22:27:38 +0100, Kevin Wolf wrote:
> Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
> event only once a second. This makes sense for cases in which the guest
> keeps running and can submit more requests that would possibly also fail
> because there is a problem with the backend.
> 
> However, if the error policy is configured so that the VM is stopped on
> errors, this is both unnecessary because stopping the VM means that the
> guest can't issue more requests and in fact harmful because stopping the
> VM is an important state change that management tools need to keep track
> of even if it happens more than once in a given second. If an event is
> dropped, the management tool would see a VM randomly going to paused
> state without an associated error, so it has a hard time deciding how to
> handle the situation.
> 
> This patch disables rate limiting for action=stop by essentially
> considering all BLOCK_IO_ERRORs with action=stop different errors. If
> the error is reported to the guest or ignored, the rate limiting stays
> in place.
> 
> Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  2 +-
>  monitor/monitor.c    | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


