Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789A606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DBp4MKmd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAQk-00070Z-RA; Thu, 19 Nov 2026 17:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAQj-00070F-V0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAQi-0003us-Br
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795126590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0oRn4Hi1f2j3YMN0ztB2N23f/M+oOoncuU2MOC6FFA=;
 b=DBp4MKmdk2VsAsRqLyC9D2UNT8Y7/umaEBMtWGjILx3eiI39dJYaAXzq2FVdcO5vWuucHj
 Ee+RAAxzKq8EQ9F1kpkJNjk7YXq+4iwEeAIeju9JrZ2k5Ms0cN1eMeFGervKFezzk3kI7o
 6OYHzw//GlGMUBiFD/uUIMNoEXSGG1s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-G1-iLJD9Op2hTNDC1uh1MA-1; Thu,
 19 Nov 2026 22:16:26 +0000
X-MC-Unique: G1-iLJD9Op2hTNDC1uh1MA-1
X-Mimecast-MFC-AGG-ID: G1-iLJD9Op2hTNDC1uh1MA_1795126585
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A561945111; Thu, 19 Nov 2026 22:16:24 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D176F30000E3; Thu, 19 Nov 2026 22:16:21 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:16:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: Re: [PATCH 1/5] block/nbd: Extract request slot access and
 reconnection
Message-ID: <av90YxzbatWpzCf9@redhat.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-2-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119144632.232457-2-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 03:46:28PM +0100, Guillaume Vincke wrote:
> The number of concurrent requests in the NBD block driver is bounded by
> MAX_NBD_REQUESTS. When reaching that level of concurrency, we park
> coroutines in a queue and, on completion, we resume the first. That
> logic is implemented in nbd_co_send_request().
> Coroutines also get queued when the channel is disconnected to make
> sure only one request triggers reconnection.
> 
> This patch extracts nbd_co_acquire_slot(), nbd_co_release_slot() and
> nbd_co_reconnect() out of the request sending. This will help use
> nbd_reconnect_attempt() outside of the request sending logic in a later
> patch of the series.
> 
> No functional change.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---
>  block/nbd.c | 56 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 16 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


