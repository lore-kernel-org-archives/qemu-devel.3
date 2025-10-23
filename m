Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6CFCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtnO-0007h2-BR; Thu, 23 Oct 2025 07:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBtn9-0006pC-46
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBtn4-00024L-Gj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761220051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNE0pIwf7h3rmebQSyZfc4u59qBmEQ1w/M5TsGcOgUM=;
 b=DKLKE6R7pPOc6zt/foZ/O/HtG6OgORzJmQvthsP6xNzi98FFHMFGJ33pbFP5YFRHqmxWJy
 8iOKAjT3V2kALj2ZwHTVCsKXRMV6fMApY+ZRaVTRV7o/Y6D51epMkNTI84NJqpQPmaV+rA
 4ukuL3wg9cndncMmWNTHIOBXYzWdtqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-lN_5q1_uPNGhVgSyTzERbw-1; Thu,
 23 Oct 2025 07:47:27 -0400
X-MC-Unique: lN_5q1_uPNGhVgSyTzERbw-1
X-Mimecast-MFC-AGG-ID: lN_5q1_uPNGhVgSyTzERbw_1761220047
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7B761956052; Thu, 23 Oct 2025 11:47:26 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6851800452; Thu, 23 Oct 2025 11:47:24 +0000 (UTC)
Date: Thu, 23 Oct 2025 13:47:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 18/21] fuse: Implement multi-threading
Message-ID: <aPoVyZSZdaY_VOs8@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-19-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-19-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
> 
> We can use this to implement multi-threading.
> 
> For configuration, we don't need any more information beyond the simple
> array provided by the core block export interface: The FUSE kernel
> driver feeds these FDs in a round-robin fashion, so all of them are
> equivalent and we want to have exactly one per thread.
> [...]

> @@ -451,6 +553,16 @@ static void fuse_export_delete(BlockExport *blk_exp)
>  {
>      FuseExport *exp = container_of(blk_exp, FuseExport, common);
>  
> +    for (int i = 0; i < exp->num_queues; i++) {
> +        FuseQueue *q = &exp->queues[i];
> +
> +        /* Queue 0's FD belongs to the FUSE session */
> +        if (i > 0 && q->fuse_fd >= 0) {

Why not start the loop with i = 1 instead of starting at 0 and then not
doing anything in the first iteration?

(I love the >= 0, running FUSE over stdin must be fun. :-))

> +            close(q->fuse_fd);
> +        }
> +    }
> +    g_free(exp->queues);
> +
>      if (exp->fuse_session) {
>          if (exp->mounted) {
>              fuse_session_unmount(exp->fuse_session);

Kevin


