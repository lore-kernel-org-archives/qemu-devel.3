Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3004CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBO-0005Ya-Qp; Sat, 30 Aug 2025 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uruUq-00037A-WF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:30:09 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uruUo-0006Wc-KE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:30:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0AA3F8102F;
 Fri, 29 Aug 2025 11:30:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c1f::1:a] (unknown [2a02:6bf:8080:c1f::1:a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xTW9Rl1Fm8c0-0Gy97CHf; Fri, 29 Aug 2025 11:30:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756456201;
 bh=t0EERVi/AW1MnULrOfzLpJ3n4WkUUeGQx06/lgmzDwg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iB3T1/Qe36mIll74W9u/cg8s2Ta+P8uFVIwsVIYkjGD37bdxV1FFq30uL1LpFPNG+
 93uKxuHVWnvWclWUoTOYE8c6tRuXn0jZBsIPk2jq4L1CRZA4gM5nwfKSYwXG7MCq2A
 9GychvW2Vxc0Y/JXyeVkX8xB4Q3p3sgFgE1IBW1Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a7f72cc7-d5ec-4a9e-a1a1-d77f376c5ce4@yandex-team.ru>
Date: Fri, 29 Aug 2025 11:29:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250827205949.364606-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27.08.25 23:59, Peter Xu wrote:
> Migration module was there for 10+ years.  Initially, it was in most cases
> based on coroutines.  As more features were added into the framework, like
> postcopy, multifd, etc.. it became a mixture of threads and coroutines.
> 
> I'm guessing coroutines just can't fix all issues that migration want to
> resolve.
> 
> After all these years, migration is now heavily based on a threaded model.
> 
> Now there's still a major part of migration framework that is still not
> thread-based, which is precopy load.  We do load in a separate thread in
> postcopy since the 1st day postcopy was introduced, however that requires a
> separate state transition from precopy loading all devices first, which
> still happens in the main thread of a coroutine.
> 
> This patch tries to move the migration incoming side to be run inside a
> separate thread (mig/dst/main) just like the src (mig/src/main).  The
> entrance to be migration_incoming_thread().
> 
> Quite a few things are needed to make it fly..
> 
> BQL Analysis
> ============
> 
> Firstly, when moving it over to the thread, it means the thread cannot take
> BQL during the whole process of loading anymore, because otherwise it can
> block main thread from using the BQL for all kinds of other concurrent
> tasks (for example, processing QMP / HMP commands).
> 
> Here the first question to ask is: what needs BQL during precopy load, and
> what doesn't?
> 
> Most of the load process shouldn't need BQL, especially when it's about
> RAM.  After all, RAM is still the major chunk of data to move for a live
> migration process.  VFIO started to change that, though, but still, VFIO is
> per-device so that shouldn't need BQL either in most cases.
> 
> Generic device loads will need BQL, likely not when receiving VMSDs, but
> when applying them.  One example is any post_load() could potentially
> inject memory regions causing memory transactions to happen.  That'll need
> to update the global address spaces, hence requires BQL.  The other one is
> CPU sync operations, even if the sync alone may not need BQL (which is
> still to be further justified), run_on_cpu() will need it.
> 
> For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
> to now take a "bql_held" parameter saying whether bql is held.  We could
> use things like BQL_LOCK_GUARD(), but this patch goes with explicit
> lockings rather than relying on bql_locked TLS variable.  In case of
> migration, we always know whether BQL is held in different context as long
> as we can still pass that information downwards.

Agree, but I think it's better to make new macros following same pattern, i.e.

WITH_BQL_HELD(bql_held) {
     action();
}

instead of

WITH_BQL_HELD(bql_held, actions());

..

Or I'm missing something and we already have a precedent of the latter
notation?



-- 
Best regards,
Vladimir

