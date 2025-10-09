Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19333CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tKS-0004fc-So; Thu, 09 Oct 2025 12:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tK2-0004Zg-4L
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tJt-0000Mc-5t
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760026601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaR7JQSvHn2FTuVinRhOe0sYPzVuaGw5DLumeZ4rTS4=;
 b=PHRguKEXPsj8so/5MVh9JuBsZ5yIQNIs8FKKl7eeqU6F/dP4MfDpwtcjq5ZhefMY3D9D/T
 +xQktjghVNcSleReHhROYNO2SkeAodcFEC9UEyKjDU6jcxGZa35OxFEmRlJeE+Q5CKBDoF
 U/GhX8dZ5w9RBJY64GvW6vqbx7cC0co=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328--VfBdJyjNd60g4Wo-FNZMg-1; Thu,
 09 Oct 2025 12:16:36 -0400
X-MC-Unique: -VfBdJyjNd60g4Wo-FNZMg-1
X-Mimecast-MFC-AGG-ID: -VfBdJyjNd60g4Wo-FNZMg_1760026595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2230A19560B2; Thu,  9 Oct 2025 16:16:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F18319560BB; Thu,  9 Oct 2025 16:16:30 +0000 (UTC)
Date: Thu, 9 Oct 2025 18:16:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 07/12] aio: add errp argument to aio_context_setup()
Message-ID: <aOff3OCKvw3nei_x@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-8-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-8-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> When aio_context_new() -> aio_context_setup() fails at startup it
> doesn't really matter whether errors are returned to the caller or the
> process terminates immediately.
> 
> However, it is not acceptable to terminate when hotplugging --object
> iothread at runtime. Refactor aio_context_setup() so that errors can be
> propagated. The next commit will set errp when fdmon_io_uring_setup()
> fails.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/include/block/aio.h b/include/block/aio.h
> index 2760f308f5..d919d7c8f4 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -718,10 +718,11 @@ void qemu_set_current_aio_context(AioContext *ctx);
>  /**
>   * aio_context_setup:
>   * @ctx: the aio context
> + * @errp: error pointer
>   *
>   * Initialize the aio context.
>   */
> -void aio_context_setup(AioContext *ctx);
> +void aio_context_setup(AioContext *ctx, Error **errp);

I don't really mind much, but the convention these days is that
functions don't only take an Error **, but also return a bool or
0/-errno.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


