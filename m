Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83505C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Lc0-0007cg-1R; Fri, 25 Apr 2025 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Lbo-0007W5-7I
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Lbm-0000ti-F7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745597336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fK0/7xiF/If1o4IOD8dWNP/XiFTRWGWWD4n8tmOtVA=;
 b=X1/bX44dIz5LzVdeyZWi6+CNsLBn24r0uJNxwNDs7qZ/zh47z6lw9HRWe4knfa0pfIiagV
 Pf8xqOS8otmNHK8FXcuQkpdp00I3kinb9UBCLAqEmCrYlvdEtXFD/fcRiA4yQX1tMQQVhO
 02j/Oe3gksA5rGZPhqid679G8L7z80o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-d1SWBwpjNn6ylBkJPD_hpA-1; Fri,
 25 Apr 2025 12:08:54 -0400
X-MC-Unique: d1SWBwpjNn6ylBkJPD_hpA-1
X-Mimecast-MFC-AGG-ID: d1SWBwpjNn6ylBkJPD_hpA_1745597333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1AAD195608A; Fri, 25 Apr 2025 16:08:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDFB2180047F; Fri, 25 Apr 2025 16:08:48 +0000 (UTC)
Date: Fri, 25 Apr 2025 18:08:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vasiliy Kovalev <kovalev@altlinux.org>
Subject: Re: [PATCH 3/4] qemu-img: prevent stack overflow in bench by using
 bottom half
Message-ID: <aAuzjsNLQRUv3orx@redhat.com>
References: <20250327162423.25154-1-gerben@altlinux.org>
 <20250327162423.25154-4-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327162423.25154-4-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

Am 27.03.2025 um 17:24 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> Previously, new I/O requests were launched synchronously inside the
> completion callback `bench_cb`, leading to deep recursion and stack
> overflow. This patch moves the launching of new requests to a separate
> function `bench_bh`, scheduled via `qemu_bh_schedule` to run in the event
> loop context, thus unwinding the stack and preventing overflow.
> 
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

Normally, the callback shouldn't immediately be called, except for
errors, which take a different code path anyway.

Was this tested with the null block driver or with a backend that is
actually relevant in practice?

I wonder if switching qemu-img bench to coroutines would make sense. But
since this is a benchmarking tool, we need to measure the performance
difference from both an additional BH and from switching to coroutines
compared to the current state. In case of doubt, I'd leave this unfixed,
this isn't something that is run in production.

Kevin


