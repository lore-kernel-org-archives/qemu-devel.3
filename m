Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5D9CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDoNx-00065w-Vh; Mon, 05 Oct 2026 15:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDoNw-000656-BQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDoNu-0000GG-Sn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791228601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wwkOZGdZ8Ch/rrUAeCo6J4MR554QCXU2t4zHs9qG9Dk=;
 b=QAUSgQhhp8/BNmAmbsB4TR42ZQ1LWvasSOO8vEay6mOMHu1DNj3RpDFf60jrGjmv7VDtLy
 e0qhAN5FTQUoK+XtYZyjfRJhUixCd3GfOUOCOoEMdQ0VAnlgzxHhikTgpzeKSM7bohZVgQ
 2Zf8rRqEtTk5rJ4RKxBYFicOT4HFUes=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-RZx8JKhdN-6pYU30EeqNlg-1; Mon,
 05 Oct 2026 15:29:58 -0400
X-MC-Unique: RZx8JKhdN-6pYU30EeqNlg-1
X-Mimecast-MFC-AGG-ID: RZx8JKhdN-6pYU30EeqNlg_1791228597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 738AF19772EF; Mon,  5 Oct 2026 19:29:56 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCD3C1956063; Mon,  5 Oct 2026 19:29:53 +0000 (UTC)
Date: Mon, 5 Oct 2026 14:29:50 -0500
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Add coverage for NBD connect thread start
 delay
Message-ID: <asP6i-iViGlBTmN2@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
 <asPv5A2Ie02ruyy3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asPv5A2Ie02ruyy3@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 05, 2026 at 01:44:10PM -0500, Eric Blake wrote:
> On Fri, Sep 25, 2026 at 05:53:46PM +0200, Guillaume Vincke wrote:
> > Test the connect thread starting condition with reconnect-delay=0 when
> > the server disconnects after a successful handshake but before running
> > operations. Prior to the change to nbd_co_establish_connection(), this
> > test would demonstrate two I/O errors. The tests 264 and 277 covering
> > reconnection do not use reconnect-delay=0 so this case is not exercised.
> > 
> > Add a test that provokes multiple errors in order to put an NBD client
> > in the above-mentioned situation and shows that the first operation
> > starts the connect thread and leads to successful subsequent I/O.
> > 
> > Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Also, I checked that this new test exposes the problem if applied
independently from the patch in 1/2.

Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


