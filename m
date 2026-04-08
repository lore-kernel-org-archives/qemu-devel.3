Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F7D10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWU-00073V-L6; Wed, 08 Apr 2026 15:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wAY70-0007Tr-Ek
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wAOqr-0005G2-C9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775639132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsxumRYxbNg6GDrLqBwcgPeXAsOy8gUZBmrdHa/GWD4=;
 b=ipSDGrZ3CYuysL3LJp8tgjfhdnkXzVDO6uFzaoARppNihaXV0IgW5W1z1uk7tCYtjJSuvm
 JbC3ESQ1Eu8teM3kZOZ222i8N6NV8BCPNBgybLHfXSACWisWwvul9qLEIhNWPIZc/2qbTp
 8gh/1W5ip1x2oYGawSmTPxma0XhQBRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-UoQmEfuiMHmY8rH8nV9O8g-1; Wed,
 08 Apr 2026 05:05:29 -0400
X-MC-Unique: UoQmEfuiMHmY8rH8nV9O8g-1
X-Mimecast-MFC-AGG-ID: UoQmEfuiMHmY8rH8nV9O8g_1775639128
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13F461956096; Wed,  8 Apr 2026 09:05:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.231])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4466419560A6; Wed,  8 Apr 2026 09:05:25 +0000 (UTC)
Date: Wed, 8 Apr 2026 11:05:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PULL 4/6] monitor: Fix deadlock in monitor_cleanup
Message-ID: <adYaUz0JtcrzY3L1@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
 <20260331150352.256332-5-kwolf@redhat.com>
 <d0187495-f196-43a3-b77c-463a098b5f60@tls.msk.ru>
 <2f8a1144-f002-44ae-b9ff-8cbb4f13742f@tls.msk.ru>
 <adTy5PTUjTu_Swj8@redhat.com>
 <0e72c7ba-9a7a-4762-8085-bf99ac266f59@tls.msk.ru>
 <adU05hwKDW16sYu4@redhat.com>
 <bec7c78b-26fe-42d2-b274-0e6ef6b9b394@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec7c78b-26fe-42d2-b274-0e6ef6b9b394@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 07.04.2026 um 19:12 hat Michael Tokarev geschrieben:
> On 07.04.2026 19:46, Kevin Wolf wrote:
> > Am 07.04.2026 um 15:30 hat Michael Tokarev geschrieben:
> 
> > > I *guess* qapi/qmp-dispatch.c should not be used by qga.  That to say, -
> > > instead of adding more stuff to qga link line, it looks like we should
> > > remove stuff from it :)
> > 
> > I don't think you can have QMP without qapi/qmp-dispatch.c, so this does
> > look like the right fix to me. There is no real reason why aio-wait.c
> > should be considered specific to the block layer.
> 
> Well, or at least, qga can provide stub for aio_wait_kick().

As far as I can tell, qga has the same monitor setup as qemu, i.e. there
is qemu_aio_context as the default, iohandler_ctx where the monitor I/O
is processed and a monitor iothread.

This means that you need the real aio_wait_kick(), not just a stub, to
avoid deadlocks.

Kevin


