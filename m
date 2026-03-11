Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC541049519
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0G0l-000819-TM; Wed, 11 Mar 2026 05:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w0G0k-00080j-0t
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w0G0i-0003uz-Bs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773221867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qY5XsbXfFt4NDbyyFrGJdf9fR+dRuA9pRUeESP17fs=;
 b=Lnf1leJoItX2sG1I9RMhVpVyEEwEC4tyNzT5mihgnej6cdHa8LRRqxSDUXyik76UvuHYAO
 P0pvLFdGPPwfB6yP0ZrIoaIzxEWpGk4vqin8/SRqyxI7ncyIpnh41fi4mmPy2y3Nt9vOl3
 XKjql/V5DdknurxlmO1oaW5Fj7mZc7o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-Q5HLUx6wPUGmM3GTqntE2A-1; Wed,
 11 Mar 2026 05:37:43 -0400
X-MC-Unique: Q5HLUx6wPUGmM3GTqntE2A-1
X-Mimecast-MFC-AGG-ID: Q5HLUx6wPUGmM3GTqntE2A_1773221862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FF971956095; Wed, 11 Mar 2026 09:37:42 +0000 (UTC)
Received: from redhat.com (stefkas-mbp.str.redhat.com [10.33.192.245])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D17180075F; Wed, 11 Mar 2026 09:37:40 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:37:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jorge Merlino <jorge.merlino@canonical.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] throttle-group: fix race condition when using iothreads
Message-ID: <abE34qeQY36q2PkY@redhat.com>
References: <20260310-fix-race-condition-b4-v1-1-09b9b9262a58@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-fix-race-condition-b4-v1-1-09b9b9262a58@canonical.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Am 11.03.2026 um 00:08 hat Jorge Merlino geschrieben:
> There is a race condition on the value of throttle_timers on the
> ThrottleGroupMember structure. Those timers should be protected by the
> ThrottleGroup lock but sometimes are read without the lock and the code
> expects their value to remain constant.
> 
> In particular, there is an assertion that can be false as the timers can
> change between their value is checked and the assertion is run.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194
> 
> Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>

For context, there was another attempt a while ago to fix this race:

https://patchew.org/QEMU/20251117011045.1232-1-luzhipeng@cestc.cn/

Unfortunately, neither the author nor Berto follow up on my response, so
it went nowhere.

As you can see, my conclusion then was, too, that the locking needs to
be extended. So in that respect, I agree with your patch.

I'm not completely clear on how much code needs to be covered by the
lock. Is it okay for throttle_group_restart_queue_entry() to run only
after the timer has been rescheduled?

Also relevant context: Commit 25b8e4d, which introduced the assertion
and stated that the situation shouldn't happen.

> This patch fixes a race condition on an assertion on the value of the
> ThrottleGroupMember throttle_timers.
> 
> The patch is minimal as it changes only a few lines. It will probably
> have to be refactored, maybe removing part of the code of the
> throttle_group_restart_queue procedure and duplicating it before the
> call. As it is now, this procedure needs to be called with the
> ThrottleGroup lock held as it will unlock it during its execution.
> 
> I left it as is now so that the changes are clear for review. As I'm
> messing with locks and I'm not an expert on this codebase I'm not sure
> if there could be side effects I'm not aware of. 

Yes, there are clearly things to be improved so that lock/unlock happen
in the same function, but let's first figure out what actually needs to
be done before we worry about the refactoring.

Kevin


