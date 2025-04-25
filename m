Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53B5C369D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L7V-0006Qp-Le; Fri, 25 Apr 2025 11:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8L72-0005il-LU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8L6x-0004wi-BJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745595425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNP4X7YDT7jlq0NijXYhRKSq76c+Q+Jr1DDXlpUK+dg=;
 b=Vun/IkXnDOtOoeYVCIyDf5xAxbMC8gDeIUMhPM6L2v0FsmwVLtSj2fl1sR4FoAC5ZqNYVA
 9E5E2QbXFfUCZ37ljl7kDgOa5fGtlPv2vwxOP8pvG5y5JIAD8PT5kSqAYlhA3EVXKKw4jb
 IJRwPsQFEDUZvQrBKgMv7zbqo4mCpLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-xaag4b2mMmajCS6wk2R0dw-1; Fri,
 25 Apr 2025 11:37:01 -0400
X-MC-Unique: xaag4b2mMmajCS6wk2R0dw-1
X-Mimecast-MFC-AGG-ID: xaag4b2mMmajCS6wk2R0dw_1745595420
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2442D195609D; Fri, 25 Apr 2025 15:37:00 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15323195608D; Fri, 25 Apr 2025 15:36:56 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:36:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Sunny Zhu <sunnyzhyy@qq.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, hreitz@redhat.com
Subject: Re: [PATCH] =?utf-8?Q?block=EF=BC=9A_chang?= =?utf-8?Q?e?= type of
 bytes from int to int64_t for *bdrv_aio_pdiscard
Message-ID: <aAusFsX7FwnElrNf@redhat.com>
References: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
 <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
 <292632c9-4492-4071-9100-a7b165af3e97@linaro.org>
 <zd2plm54sqdos4oqsd4lbukzozupboivu4pueawwtxrmtsg5q4@ay2rhlohwjub>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zd2plm54sqdos4oqsd4lbukzozupboivu4pueawwtxrmtsg5q4@ay2rhlohwjub>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

Am 24.04.2025 um 19:40 hat Eric Blake geschrieben:
> On Tue, Apr 22, 2025 at 09:11:51AM +0200, Philippe Mathieu-Daudé wrote:
> > Hi Eric,
> > 
> > On 21/4/25 17:03, Eric Blake wrote:
> > > On Mon, Apr 21, 2025 at 12:19:14AM +0800, Sunny Zhu wrote:
> > > > Keep it consistent with *bdrv_co_pdiscard.
> > > > 
> > > > Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
> > > > so we don’t need to make any adaptations either.
> > > 
> > > If there are no drivers implementing the callback, then why have it?
> > > I think we have been moving towards more coroutine-based callbacks and
> > > away from the aio callbacks; if so, should we instead be deleting this
> > > callback as stale code?
> > 
> > Could we add a comment in BlockDriver prototypes about prefering co over
> > aio implementations, possibly mentioning them as legacy?
> 
> Thinking about this a bit more (but you'll definitely want Kevin's
> opinion, not just mine):
> 
> $ git grep '\.bdrv_aio_'
> block/file-win32.c:    .bdrv_aio_preadv    = raw_aio_preadv,
> block/file-win32.c:    .bdrv_aio_pwritev   = raw_aio_pwritev,
> block/file-win32.c:    .bdrv_aio_flush     = raw_aio_flush,
> block/file-win32.c:    .bdrv_aio_preadv    = raw_aio_preadv,
> block/file-win32.c:    .bdrv_aio_pwritev   = raw_aio_pwritev,
> block/file-win32.c:    .bdrv_aio_flush     = raw_aio_flush,
> block/iscsi.c:    .bdrv_aio_ioctl   = iscsi_aio_ioctl,
> block/iscsi.c:    .bdrv_aio_ioctl   = iscsi_aio_ioctl,
> block/null.c:    .bdrv_aio_preadv        = null_aio_preadv,
> block/null.c:    .bdrv_aio_pwritev       = null_aio_pwritev,
> block/null.c:    .bdrv_aio_flush         = null_aio_flush,
> 
> file-win32.c looks to be the major client of remaining aio interfaces.
> How hard would it be to convert those over to coroutines?

Not terribly complicated. In case of doubt, they remain callback based
internally and just yield until the callback reenters the coroutine.

For file-win32 specifically, paio_submit() can be modified to call
thread_pool_submit_co(), which already does this. The win32-aio paths
won't necessarily become simpler, but that's okay.

> iscsi.c uses aio only for ioctl.  How hard would it be to convert it
> in the same way that we converted read/write/flush back in commit
> 063c3378?

iscsi_aio_ioctl() could probably be simplified a bit when the callback
is moved into the function itself, especially for the case of
iscsi_ioctl_handle_emulated().

> null.c provides aio interfaces solely for benchmarking purposes - but
> if it is the only remaining client of aio interfaces, it would be nice
> to just rip out support for null-aio: and rely solely on null:

null-aio is specifically an AIO based version, I think mainly to test
performance of AIO vs. coroutines. If we get rid of the AIO interfaces,
then we can probably just remove the whole null-aio driver. (Or rather,
make it an alias of null-co for now and deprecate it.)

> It sounds like we are close enough to a generic cleanup of detritus
> that it would be better to just finish the job than to add a comment
> about preferring co over aio.

Agreed.

Kevin


