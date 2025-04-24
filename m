Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120DBC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 17:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u80Z0-0004EN-Le; Thu, 24 Apr 2025 13:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u80Yu-00042W-NB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u80Yr-0001W7-St
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745516432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q/x8Aeje1Q5U/M4JxGVC9c4qYqtE6oAttVL6PbqTZM=;
 b=MWcI+w+VLBQV6IypDyXNSAOlT8uy1jTudXFb6RhtiEC22h7qbduDQxZ2RttKnLvQrup5F6
 AoMAShZiKyQbO6WtK3d3oOoQMIknLo21BIElk2Ldq/8x70x3ECg0kYoFMosW7KYluDDLxx
 YWLwziPl9zOgblJmI5OPUFGF4hmDlXw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-aaepS7FZOpqaUqG9EDkGgg-1; Thu,
 24 Apr 2025 13:40:29 -0400
X-MC-Unique: aaepS7FZOpqaUqG9EDkGgg-1
X-Mimecast-MFC-AGG-ID: aaepS7FZOpqaUqG9EDkGgg_1745516428
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2E4D1955DC5; Thu, 24 Apr 2025 17:40:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C538D19560A3; Thu, 24 Apr 2025 17:40:25 +0000 (UTC)
Date: Thu, 24 Apr 2025 12:40:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Sunny Zhu <sunnyzhyy@qq.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH] =?utf-8?Q?block=EF=BC=9A_chang?= =?utf-8?Q?e?= type of
 bytes from int to int64_t for *bdrv_aio_pdiscard
Message-ID: <zd2plm54sqdos4oqsd4lbukzozupboivu4pueawwtxrmtsg5q4@ay2rhlohwjub>
References: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
 <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
 <292632c9-4492-4071-9100-a7b165af3e97@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <292632c9-4492-4071-9100-a7b165af3e97@linaro.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 22, 2025 at 09:11:51AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Eric,
> 
> On 21/4/25 17:03, Eric Blake wrote:
> > On Mon, Apr 21, 2025 at 12:19:14AM +0800, Sunny Zhu wrote:
> > > Keep it consistent with *bdrv_co_pdiscard.
> > > 
> > > Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
> > > so we don’t need to make any adaptations either.
> > 
> > If there are no drivers implementing the callback, then why have it?
> > I think we have been moving towards more coroutine-based callbacks and
> > away from the aio callbacks; if so, should we instead be deleting this
> > callback as stale code?
> 
> Could we add a comment in BlockDriver prototypes about prefering co over
> aio implementations, possibly mentioning them as legacy?

Thinking about this a bit more (but you'll definitely want Kevin's
opinion, not just mine):

$ git grep '\.bdrv_aio_'
block/file-win32.c:    .bdrv_aio_preadv    = raw_aio_preadv,
block/file-win32.c:    .bdrv_aio_pwritev   = raw_aio_pwritev,
block/file-win32.c:    .bdrv_aio_flush     = raw_aio_flush,
block/file-win32.c:    .bdrv_aio_preadv    = raw_aio_preadv,
block/file-win32.c:    .bdrv_aio_pwritev   = raw_aio_pwritev,
block/file-win32.c:    .bdrv_aio_flush     = raw_aio_flush,
block/iscsi.c:    .bdrv_aio_ioctl   = iscsi_aio_ioctl,
block/iscsi.c:    .bdrv_aio_ioctl   = iscsi_aio_ioctl,
block/null.c:    .bdrv_aio_preadv        = null_aio_preadv,
block/null.c:    .bdrv_aio_pwritev       = null_aio_pwritev,
block/null.c:    .bdrv_aio_flush         = null_aio_flush,

file-win32.c looks to be the major client of remaining aio interfaces.
How hard would it be to convert those over to coroutines?

iscsi.c uses aio only for ioctl.  How hard would it be to convert it
in the same way that we converted read/write/flush back in commit
063c3378?

null.c provides aio interfaces solely for benchmarking purposes - but
if it is the only remaining client of aio interfaces, it would be nice
to just rip out support for null-aio: and rely solely on null:

It sounds like we are close enough to a generic cleanup of detritus
that it would be better to just finish the job than to add a comment
about preferring co over aio.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


