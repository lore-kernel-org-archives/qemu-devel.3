Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF02C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymPj-00053y-AA; Tue, 25 Aug 2026 04:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymPh-00053a-AV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymPg-0002sO-0X
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787646102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EfxP41Rv4zmJVMg+THyv9KObgSHLvoEqLdR4hL/gWjo=;
 b=OiRJFvaYXi4b8YgR4kX12/WItw9tTx97fwYSZbSKT5xWQByutU0VpMBkMc/i7rwT/m1b7U
 G4VkzAzYjeBybA+ClIV1uJ/aQlc7aR312ucn3aCWUApd+Ylu68J5l1N5F/Mc96/GZ70sFX
 tXgeTXCvpGn9ym++goXCQHG8fFci8uQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-3iZXn2VLNACnjswbZgdz4A-1; Tue,
 25 Aug 2026 04:21:40 -0400
X-MC-Unique: 3iZXn2VLNACnjswbZgdz4A-1
X-Mimecast-MFC-AGG-ID: 3iZXn2VLNACnjswbZgdz4A_1787646100
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD409197768D; Tue, 25 Aug 2026 08:21:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69D4B195604A; Tue, 25 Aug 2026 08:21:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3C7921E6920; Tue, 25 Aug 2026 10:21:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V13 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <20260822213343.661939-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Sun, 23 Aug 2026 05:33:29 +0800")
References: <20260822213343.661939-1-zhangckid@gmail.com>
 <20260822213343.661939-7-zhangckid@gmail.com>
Date: Tue, 25 Aug 2026 10:21:36 +0200
Message-ID: <87zeyaobjj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Monitors that require an IOThread share the internal mon_iothread.
> Account for each monitor explicitly in IOThread holder tracking, using
> the monitor's canonical QOM path to distinguish holders.
>
> Acquire the shared monitor IOThread AioContext once, using the monitor
> QOM path as the holder, and reuse the stored context for later
> operations.
>
> Release the holder from the Monitor ObjectClass::unparent callback,
> while the canonical QOM path is still available. This covers every
> object_unparent() path and avoids duplicating the cleanup in
> monitor_cleanup() and monitor_qmp_prepare_delete().
>
> The internal mon_iothread remains hidden from query-iothreads, as before.

Let's add

  Management applications therefore cannot use it to determine which
  monitors are using the IOThread.

You add tracking anyway for consistency, I guess.  Correct?

>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>


