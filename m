Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A65C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96eW-0005T3-BK; Tue, 22 Sep 2026 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x96eT-0005RB-Fa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x96eR-00062i-Nw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790107177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NvHqcymslWOYSKI3c3bB8twG5KgiBn1qFCsYp3reGM=;
 b=hYV7IdZnmBBRUiidmfi0ENe0GdKrRmpWxFMwzcnFbpYX2HidOWWzPATnXvU7DJ9Dk3Oo/z
 QkgYS0VtYhNBW0UBBJkxk+X1eukU69IEyDymRPjtBMTp8R5fptTMkGtMTeZ//LQeeBDTpk
 GDBo4wXvjkq3kNymcLxuK3R0eCikBkQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-7LIEgyC9O8mVXWVM5e6QKQ-1; Tue,
 22 Sep 2026 15:59:35 -0400
X-MC-Unique: 7LIEgyC9O8mVXWVM5e6QKQ-1
X-Mimecast-MFC-AGG-ID: 7LIEgyC9O8mVXWVM5e6QKQ_1790107174
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88237195609D; Tue, 22 Sep 2026 19:59:34 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1B67180049F; Tue, 22 Sep 2026 19:59:32 +0000 (UTC)
Date: Tue, 22 Sep 2026 21:59:30 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
In-Reply-To: <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
Message-ID: <991e9427-bc5a-7226-453b-70de8825e4b4@redhat.com>
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
 <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
 <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On Tue, 22 Sep 2026, Mikulas Patocka wrote:

> > Logging guest state at the point your revert hook fires could be
> > informative...
> 
> Yes, I will look into it.

So, I tried, and got a hit right away:

superh_cpu_revert_uninterruptible
pc: 45be9e
r0: 45bea4
r1: 55d55e40
r15: fffffffa
flags: 1fa0

  45be94:       10 89           bt      45beb8 <afree+0x84>
  45be96:       03 c7           mova    45bea4 <afree+0x70>,r0
  45be98:       f3 61           mov     r15,r1
  45be9a:       09 00           nop
  45be9c:       fa ef           mov     #-6,r15
  45be9e:       21 57           mov.l   @(4,r2),r7
  45bea0:       3b 27           or      r3,r7
  45bea2:       71 12           mov.l   r7,@(4,r2)
  45bea4:       13 6f           mov     r1,r15
  45bea6:       0b 00           rts

Then, I tried to log only cases where pc points deeper into the gUSA
region and got nothing.

So, if superh_cpu_revert_uninterruptible reverts the PC from 45be9e back
to 45be9c, the deadlock doesn't happen.

Could it be, that on the exit path from cpu_exec_step_atomic, Qemu somehow 
forgets that it is in the middle of the gUSA region and continues 
execution in parallel?

Mikulas


