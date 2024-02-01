Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7FEC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUCv-0000GP-Ga; Thu, 01 Feb 2024 05:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rVUCo-0000Fw-St
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rVUCn-0002ew-IO
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706782919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGlYjPLH1hc0BZqCCASSvmqvRnklY9MiCQQRGNJDJEk=;
 b=Tst5bcmdqblmHGAT2qA7oDddVuW3nxUSkYe1drfZHu8eft3qREg7WGuiGRUxbAF9qoud7R
 RZAR3QhiEEkB8kyZrBUk2GDAueyJSVE31EAhxLW0F6gR9TX/I8NozU9MTFPj+5HO34kva0
 qQ/tKhxNqSxQ7IbncRRKXQs+0pzrHL8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-SHNZ2J6TPleVc8C4IAGi0w-1; Thu,
 01 Feb 2024 05:21:56 -0500
X-MC-Unique: SHNZ2J6TPleVc8C4IAGi0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B370A3811F22;
 Thu,  1 Feb 2024 10:21:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03316111FC;
 Thu,  1 Feb 2024 10:21:54 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:21:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <ZbtwvQISnyDjVl7t@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
 <ZboeJIXKDP7OP9YD@redhat.com>
 <ed004630-5b85-4ad2-a22f-475571d0df33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed004630-5b85-4ad2-a22f-475571d0df33@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 01.02.2024 um 10:43 hat Hanna Czenczek geschrieben:
> On 31.01.24 11:17, Kevin Wolf wrote:
> > Am 29.01.2024 um 17:30 hat Hanna Czenczek geschrieben:
> > > I don’t like using drain as a form of lock specifically against AioContext
> > > changes, but maybe Stefan is right, and we should use it in this specific
> > > case to get just the single problem fixed.  (Though it’s not quite trivial
> > > either.  We’d probably still want to remove the assertion from
> > > blk_get_aio_context(), so we don’t have to require all of its callers to
> > > hold a count in the in-flight counter.)
> > Okay, fair, maybe fixing the specific problem is more important that
> > solving the more generic blk_get_aio_context() race.
> > 
> > In this case, wouldn't it be enough to increase the in-flight counter so
> > that the drain before switching AioContexts would run the BH before
> > anything bad can happen? Does the following work?
> 
> Yes, that’s what I had in mind (Stefan, too, I think), and in testing,
> it looks good.

Oh, sorry, I completely misunderstood then. I thought you were talking
about adding a new drained section somewhere and that sounded a bit more
complicated. :-)

If it works, let's do this. Would you like to pick this up and send it
as a formal patch (possibly in a more polished form), or should I do
that?

Kevin


