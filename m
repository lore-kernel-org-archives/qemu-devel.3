Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382AD106286D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEM-0000Qp-3J; Wed, 11 Mar 2026 08:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0IEH-0000Hj-Tp; Wed, 11 Mar 2026 07:59:57 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0IEF-00058w-Ly; Wed, 11 Mar 2026 07:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YY3+0WjhcsfDDsyXZr6kbkwzMKkmddpRhq59lCcIlv0=; b=BxTJwnD9nO3ygPjyCpmTpW+VNP
 p/G5nKHJEofZ9KFz7fbdOlDN2TMT/MtRm2naMjGg2cv43Ov9L/k0wpNVRcyy1JkWUsIfliOUHgp9G
 vzDURVrCTVcLb+D4QXVUxfRTWbzwaszbcy6QvVNJw0SYWN57ixfVSdDHjYkpKEOn7kbYWGKXkd4GD
 v3TAxqAeU9ZWyB4N3jR/yPTAwoHJ6pmcXGoupqIMh54HnSQ8ugE7QvOZUkcgNr8bre6ipTnDSPayi
 5+Isk70m6DqaoVwwaVz9CIgef6EwfcpY7QfK/QuMzb0Vl9raLnWyWlGQ6vYBv9btBw3zE7hAviON9
 rdocLjww==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0IE5-00DSqW-Fa; Wed, 11 Mar 2026 12:59:45 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1w0IE3-006j5D-4u; Wed, 11 Mar 2026 12:59:45 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1w0IE2-004qbS-39;
 Wed, 11 Mar 2026 11:59:42 +0000
Date: Wed, 11 Mar 2026 12:59:42 +0100
From: Alberto Garcia <berto@igalia.com>
To: Jorge Merlino <jorge.merlino@canonical.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] throttle-group: fix race condition when using iothreads
Message-ID: <abFZLuP2251dNhUp@igalia.com>
References: <20260310-fix-race-condition-b4-v1-1-09b9b9262a58@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-fix-race-condition-b4-v1-1-09b9b9262a58@canonical.com>
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 08:08:36PM -0300, Jorge Merlino wrote:
>  void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
>  {
>      ThrottleDirection dir;
> +    ThrottleState *ts = tgm->throttle_state;
> +    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
>  
>      if (tgm->throttle_state) {
>          for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
>              QEMUTimer *t = tgm->throttle_timers.timers[dir];
> +            qemu_mutex_lock(&tg->lock);
>              if (timer_pending(t)) {
> +                qemu_mutex_unlock(&tg->lock);

I think I was too fast with my patch, I overlooked this part.

Maybe we need something like this for that function:

 for (...) {

   qemu_mutex_lock();

   if (timer_pending()) {
      /* We had a timer, delete it, we'll restart the queue now */
      timer_del(...);
   } else if (tg->any_timer_armed) {
      /* Someone else had a timer, let's wait for that request to be
       * scheduled so we can go next */
      qemu_mutex_unlock();
      continue;
   } else {
      /* There are no timers in this group, let's run our request now.
         Set any_timer_armed so no one else does it in the meantime */
      tg->any_timer_armed = true;
   }

   qemu_mutex_unlock();
   throttle_group_restart_queue();

 }

Maybe any_timer_armed needs a new name in this case.

Berto

