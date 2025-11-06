Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB298CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGz4D-0006qA-L5; Thu, 06 Nov 2025 07:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGz4C-0006pi-C2
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGz4A-00014R-Sp
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762431973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esEFL3oOl0/d+L0kE6FyA42Xl+3pWEm9yS0ChAlp4PM=;
 b=Kc7Xzs/7jBay+tg11ni90orGGE2jNeyE3cKXqam+Y7JhiHuKNMQFcGKhaY5Ba3XDQpZzyw
 wGipiUs9UJxF6ckjcTkAJfAjpYWMyBp5FnNchVGPiefZBooEb9jMTuWpaVQKLMKETMOpn+
 P4/Uxt42noGUqfebOyKvKLunUwJ6HnA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-v7ybZeQgOv6WFQ9EgzegZQ-1; Thu,
 06 Nov 2025 07:26:10 -0500
X-MC-Unique: v7ybZeQgOv6WFQ9EgzegZQ-1
X-Mimecast-MFC-AGG-ID: v7ybZeQgOv6WFQ9EgzegZQ_1762431969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 288C31800350; Thu,  6 Nov 2025 12:26:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 175DD19560A7; Thu,  6 Nov 2025 12:26:06 +0000 (UTC)
Date: Thu, 6 Nov 2025 13:26:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 8/8] iotests: Add coverage of recent NBD qio deadlock fix
Message-ID: <aQyT3MXM4MZGyhnv@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-18-eblake@redhat.com>
 <98abcae5-9768-4a7b-af5a-1cdaa84020af@yandex-team.ru>
 <2cdptk665ijo3ioo7qdjf54qtnmgq5xvib4whtueqosrqzax4j@nhf2ayky7fvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdptk665ijo3ioo7qdjf54qtnmgq5xvib4whtueqosrqzax4j@nhf2ayky7fvr>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am 05.11.2025 um 23:10 hat Eric Blake geschrieben:
> On Tue, Nov 04, 2025 at 02:38:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > On 03.11.25 23:10, Eric Blake wrote:
> > > Test that all images in a qcow2 chain using an NBD backing file can be
> > > served by the same process.  Prior to the recent QIONetListener fixes,
> > > this test would demonstrate deadlock.
> > > 
> > > The test borrows heavily from the original formula by "John Doe" in
> > > the gitlab bug, but uses a Unix socket rather than TCP to avoid port
> > > contention, and uses a full-blown QEMU rather than qemu-storage-daemon
> > > since both programs were impacted.
> > > 
> > > [While preparing this patch by making the new test executable, I
> > > noticed vvfat.out does not need execute permissions]
> > > 
> > > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >   tests/qemu-iotests/tests/nbd-in-qcow2-chain   | 84 +++++++++++++++++++
> > >   .../qemu-iotests/tests/nbd-in-qcow2-chain.out | 56 +++++++++++++
> > >   tests/qemu-iotests/tests/vvfat.out            |  0
> > >   3 files changed, 140 insertions(+)
> > >   create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
> > >   create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
> > >   mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out
> 
> Should I split out that file mode change to a separate cleanup patch?

It's an unrelated change, so while the patch to change only the file
mode may look funny, it's probably better to split it.

Kevin


