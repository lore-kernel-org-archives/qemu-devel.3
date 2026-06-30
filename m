Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D70C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUK0-0006Xx-Si; Tue, 30 Jun 2026 05:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weUJx-0006XG-NO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weUJw-0005WB-6V
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782809994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUpTSXigTNe0YckeQ03uIUKeCd/qvqZ81pCSCFyNnLQ=;
 b=LeqqGDdDJGcPFtU2LOXSA118bdn1fk9s5LpzVbRqB1WYru6KjnEXvTTfbOSySS33kZe7Xj
 zjvVe/Dq80JydQaXGOuDAZ/JOWeO4MW9XDYNebVEFpok8C1j8tHPAmoLCCJoasvYgl7Odd
 nqlAceDak5nvfeCoPgzXXpieII+spKk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-mF5xtWYnMeqZhC2iQ0pkeg-1; Tue,
 30 Jun 2026 04:59:51 -0400
X-MC-Unique: mF5xtWYnMeqZhC2iQ0pkeg-1
X-Mimecast-MFC-AGG-ID: mF5xtWYnMeqZhC2iQ0pkeg_1782809991
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D0C1956047; Tue, 30 Jun 2026 08:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A0FC195608E; Tue, 30 Jun 2026 08:59:48 +0000 (UTC)
Date: Tue, 30 Jun 2026 09:59:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH] hw/hyperv: Avoid crash if hyperv_find_cpu() passed
 invalid vp_index
Message-ID: <akOFgWNEkhmXoWF7@redhat.com>
References: <20260630084855.2319838-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630084855.2319838-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 30, 2026 at 09:48:55AM +0100, Peter Maydell wrote:
> The hyperv_find_cpu() function finds a CPU from a CPU index; this is
> basically a wrapper around qemu_get_cpu().  It is allowed to fail, in
> which case it returns NULL, which its caller handles.  However, it
> includes an assertion check which accidentally assumes the CPU
> pointer is non-NULL.
> 
> We could assert only if cs != NULL, but the assertion here is not
> doing anything interesting -- hyperv_vp_index() is a trivial wrapper
> returning cs->cpu_index, so this is effectively asserting that
> qemu_get_cpu() did what it claims to do, i.e.  returned us the CPU
> matching the index we gave it.  qemu_get_cpu() is a simple "iterate
> through list and find matching CPU" which is unlikely to be buggy,
> and we don't feel the need to sanity-check it in any of our other
> many uses of it.  Drop the assertion entirely.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3568
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Checked only with make check / check-functional...
> ---
>  hw/hyperv/hyperv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


