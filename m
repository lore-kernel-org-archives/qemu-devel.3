Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323D8CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 05:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCsIX-0006y6-3q; Sat, 03 Oct 2026 01:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCsIU-0006xj-DV
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 01:28:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCsIS-0005RM-12
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 01:28:34 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6935SOtf081221
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 3 Oct 2026 14:28:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jFNpRImV9i/4GiXR/vFIZ4eMqqhzTaveIc9bkcTMCGk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:Subject:Date;
 s=rs20250326; t=1791005304; v=1;
 b=o9sFGhKu3iBiOGfq9Gku65eITLSZraA4gicf2bf5+hsvgq6xKVFt5CXHe14vPtGQ
 XIxjQITfXQNQanxSEjdX4xhnPBNBKbGDDjRi7SBTZXpBChJmJuZdqyR0fSP4XUQv
 uopLABQijtC05tKiNotdW9/dvbEfZIZ1qMkv5Gcph353grZzbHFzU67JjQKLHSKR
 tuu+OIS05X8I3+uwSZU6FSV1M3m23nhGD7OFaTCeD53SGKbueWhKC3/yPcikcPyW
 W5TT4OJdcNNUiEjYiLLZzfFmZt9sK5MdwTvnettzuPibF9Xq/2dhKZJEKxdfijk2
 j9+EuiOuwkoHaMjpY4y1Fg==
Message-ID: <a495aded-aa95-46ed-92c1-8edcca7e4441@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 3 Oct 2026 14:28:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Call drain_call_rcu at exit
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241013-rcu-v1-1-a93b7c5957f3@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20241013-rcu-v1-1-a93b7c5957f3@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MISSING_HEADERS=1.021,
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

On 2024/10/13 16:31, Akihiko Odaki wrote:
> call_rcu() callbacks may have potential memory leaks, but QEMU may
> sometimes exit before draining the callbacks and leave the leaks
> undetected by LeakSanitizer. For example, PCI devices register a
> call_rcu() callback by calling address_space_destroy() and they will
> not be freed until it gets drained. This hides memory leaks that
> is going to happen when PCI devices loose references to the memory
> allocations.
> 
> Call drain_call_rcu at exit to expose memory leaks by call_rcu()
> callbacks deterministically.

I have revisited this older patch and decided to abandon it.

Adding atexit(drain_call_rcu) creates a deadlock scenario whenever a 
thread holding an RCU read lock waits on another thread that calls exit().

For example, this may occur during TCG migration:

1. ram_state_pending_sync() acquires an RCU read lock.
2. tcg_log_global_after_sync() waits on run_on_cpu() for a target vCPU.
3. If that target vCPU is handling an ARM semihosting exit, it calls
    exit() before servicing the queued work.
4. The atexit handler triggers and blocks, waiting for the migration
    thread's RCU reader.
5. The migration thread remains blocked waiting for the exiting vCPU.

This type of deadlock is too subtle and easily introduced inadvertently, 
so it is best to drop this approach.

Regards,
Akihiko Odaki

