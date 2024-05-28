Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D5AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzA7-0004Ic-Oi; Tue, 28 May 2024 11:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sBzA5-0004He-RP
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sBzA4-0006hc-6G
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716911690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCkfDtbfWHqfaF8lqWPGsCwpk/hKttzpFyCJsxRN2JA=;
 b=Ffz9LEDIqTfVvVW04oX2LxVe9RgUy4LfxIryhvzF8vY4evCQ1c76eqmbb71Bgy2Shp/BDF
 YwcLQ1I5d7JrmZxJdpDN3bQLDSl5WPqcUMgppx2zJJf5pyUkRsii8qWqqit8Ru8jcqI6cr
 8W+FRwAUTj/R5SCf1bLLwAoWFDjSoYg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351--1DrhXNSPqSEg3YFLvojvw-1; Tue,
 28 May 2024 11:54:45 -0400
X-MC-Unique: -1DrhXNSPqSEg3YFLvojvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77E7F380671D;
 Tue, 28 May 2024 15:54:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A217C15BB9;
 Tue, 28 May 2024 15:54:42 +0000 (UTC)
Date: Tue, 28 May 2024 17:54:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/2] Revert "monitor: use aio_co_reschedule_self()"
Message-ID: <ZlX-QOQDxgpiZwt1@redhat.com>
References: <20240506190622.56095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506190622.56095-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 06.05.2024 um 21:06 hat Stefan Hajnoczi geschrieben:
> This series fixes RHEL-34618 "qemu crash on Assertion `luringcb->co->ctx ==
> s->aio_context' failed when do block_resize on hotplug disk with aio=io_uring":
> https://issues.redhat.com/browse/RHEL-34618
> 
> Kevin identified commit 1f25c172f837 ("monitor: use aio_co_reschedule_self()")
> as the root cause. There is a subtlety regarding how
> qemu_get_current_aio_context() returns qemu_aio_context even though we may be
> running in iohandler_ctx.
> 
> Revert commit 1f25c172f837, it was just intended as a code cleanup.
> 
> Stefan Hajnoczi (2):
>   Revert "monitor: use aio_co_reschedule_self()"
>   aio: warn about iohandler_ctx special casing

Thanks, applied to the block branch.

Kevin


