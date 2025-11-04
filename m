Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D54ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCrU-00076e-Pp; Tue, 04 Nov 2025 03:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGCrR-00070G-Ek
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:57:53 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGCrO-0007ar-1t
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:57:53 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A488qx4015421
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Nov 2025 17:08:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0cIml4HlJH+GRxor4hDn/Tpd4VMgzt4OnsdEL1Ari/Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762243732; v=1;
 b=KMY2nKXhTpm3kJ6WJZnLZgoqO608XeILzSyDHUxj1Hcn95cGCPEnIoJY80NnaJhx
 jc37oCgIsmuqtE55XqctqOKF20aGzdQO9Nq0mXfSitNuV6G5fHHnMtnjQLzNMbqf
 mBLpLSF21Cu0GnjkRB8nBTgHSCZe8wBJinD3Oqb0VtU0FhXpqPlj98QJuOXRcmfm
 OX/q7T+KeEKOcN9gWyFjYA+5BDmpbGK1wL9fyoXupis723JyPtcPhWCGE5RqrtwZ
 h7UlgQPP+eROsjNpt0FRlrkO2OKl6UehnJnzMNQjzvyDcZkns4CI1bzkYxfdULlW
 yAo5ms8xy/zlRtFs/rcXXg==
Message-ID: <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 4 Nov 2025 17:08:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/04 16:41, Thomas Huth wrote:
> On 04/11/2025 02.45, Akihiko Odaki wrote:
>> On 2025/11/03 22:59, Thomas Huth wrote:
>>> On 28/10/2025 18.34, Paolo Bonzini wrote:
>>>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>
>>>> Borrow the concept of force quiescent state from Linux to ensure 
>>>> readers
>>>> remain fast during normal operation and to avoid stalls.
>>>
>>>   Hi Akihiko,
>>>
>>> looks like this commit has introduced a regression with the "replay" 
>>> functional test on the alpha target.
>>> When I run something like:
>>>
>>>   pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough \
>>>    --num-processes 1 --repeat 10 func-alpha-replay
>>>
>>> in the build folder, approx. half of the test runs are failing for me 
>>> now.
>>>
>>> I bisected the issue to this patch here - when I rebuild qemu-system- 
>>> alpha with the commit right before this change here, the above test 
>>> runs work fine, so I'm pretty sure that the problem has been 
>>> introduced by this commit here.
>>>
>>> Could you please have a look?
>>
>> I cannot reproduce it with commit 55d98e3edeeb ("rcu: Unify force 
>> quiescent state").
>>
>> Can you provide meson-logs/testlog-thorough.txt so that I can look 
>> into the failure you are facing? If you think you have something 
>> useful for debugging, please share it to me too.
> 
> There's not much in that testlog-thorough.txt that could be helpful here,
> it's basically just the information that the test has been killed due to
> the timeout:
> 
> ==================================== 1/1 
> ===================================
> test:         qemu:func-thorough+func-alpha-thorough+thorough / func- 
> alpha-replay
> start time:   07:25:26
> duration:     90.01s
> result:       killed by signal 15 SIGTERM
> command:      RUST_BACKTRACE=1 QEMU_TEST_QEMU_IMG=/tmp/qemu-rcu/qemu-img 
> QEMU_TEST_GDB=/usr/bin/gdb MALLOC_PERTURB_=255 MESON_TEST_ITERATION=1 
> PYTHONPATH=/home/thuth/devel/qemu/python:/home/thuth/devel/qemu/tests/ 
> functional G_TEST_SLOW=1 SPEED=thorough QEMU_TEST_QEMU_BINARY=/tmp/qemu- 
> rcu/qemu-system-alpha 
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 
> LD_LIBRARY_PATH=/tmp/qemu-rcu/tests/tcg/plugins:/tmp/qemu-rcu/contrib/ 
> plugins 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_BUILD_ROOT=/tmp/qemu-rcu /tmp/qemu-rcu/pyvenv/bin/python3 /home/thuth/devel/qemu/tests/functional/alpha/test_replay.py
> =============================================================================
> 
> Summary of Failures:
> 
> 1/1 qemu:func-thorough+func-alpha-thorough+thorough / func-alpha-replay 
> TIMEOUT        90.01s   killed by signal 15 SIGTERM
> 
> 
> There is also not that much helpful information in
> tests/functional/alpha/test_replay.AlphaReplay.test_clipper, apart from
> the console.log file. For a good run, the console log looks like this:
> 
> 2025-11-04 08:16:46,148: PCI: 00:01:0 class 0101 id 1095:0646
> 2025-11-04 08:16:46,149: PCI:   region 0: 0000c000
> 2025-11-04 08:16:46,149: PCI:   region 1: 0000c008
> 2025-11-04 08:16:46,149: PCI:   region 2: 0000c010
> 2025-11-04 08:16:46,149: PCI:   region 3: 0000c018
> 2025-11-04 08:16:46,149: PCI:   region 4: 0000c020
> 2025-11-04 08:16:46,149: PCI: 00:07:0 class 0601 id 8086:0484
> 2025-11-04 08:16:48,149: [    0.000000] Initializing cgroup subsys cpu
> 2025-11-04 08:16:48,149: [    0.000000] Linux version 2.6.26-2-alpha- 
> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 
> 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
> 2025-11-04 08:16:48,150: [    0.000000] Booting GENERIC on Tsunami 
> variation Clipper using machine vector Clipper from SRM
> 2025-11-04 08:16:48,150: [    0.000000] Major Options: MAGIC_SYSRQ
> 2025-11-04 08:16:48,150: [    0.000000] Command line: printk.time=0 
> console=ttyS0
> 2025-11-04 08:16:48,150: [    0.000000] memcluster 0, usage 1, 
> start        0, end       15
> 2025-11-04 08:16:48,150: [    0.000000] memcluster 1, usage 0, 
> start       15, end    16384
> 2025-11-04 08:16:48,150: [    0.000000] freeing pages 15:2048
> 2025-11-04 08:16:48,150: [    0.000000] freeing pages 2987:16384
> 2025-11-04 08:16:48,151: [    0.000000] reserving pages 2987:2988
> 2025-11-04 08:16:48,151: [    0.000000] Built 1 zonelists in Zone order, 
> mobility grouping on.  Total pages: 16272
> 2025-11-04 08:16:48,151: [    0.000000] Kernel command line: 
> printk.time=0 console=ttyS0
> 2025-11-04 08:16:57,358: PCI: 00:01:0 class 0101 id 1095:0646
> 2025-11-04 08:16:57,358: PCI:   region 0: 0000c000
> 2025-11-04 08:16:57,358: PCI:   region 1: 0000c008
> 2025-11-04 08:16:57,359: PCI:   region 2: 0000c010
> 2025-11-04 08:16:57,359: PCI:   region 3: 0000c018
> 2025-11-04 08:16:57,359: PCI:   region 4: 0000c020
> 2025-11-04 08:16:57,360: PCI: 00:07:0 class 0601 id 8086:0484
> 2025-11-04 08:17:08,468: [    0.000000] Initializing cgroup subsys cpu
> 2025-11-04 08:17:08,470: [    0.000000] Linux version 2.6.26-2-alpha- 
> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 
> 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
> 2025-11-04 08:17:08,471: [    0.000000] Booting GENERIC on Tsunami 
> variation Clipper using machine vector Clipper from SRM
> 2025-11-04 08:17:08,471: [    0.000000] Major Options: MAGIC_SYSRQ
> 2025-11-04 08:17:08,472: [    0.000000] Command line: printk.time=0 
> console=ttyS0
> 2025-11-04 08:17:08,472: [    0.000000] memcluster 0, usage 1, 
> start        0, end       15
> 2025-11-04 08:17:08,473: [    0.000000] memcluster 1, usage 0, 
> start       15, end    16384
> 2025-11-04 08:17:08,473: [    0.000000] freeing pages 15:2048
> 2025-11-04 08:17:08,474: [    0.000000] freeing pages 2987:16384
> 2025-11-04 08:17:08,474: [    0.000000] reserving pages 2987:2988
> 2025-11-04 08:17:08,475: [    0.000000] Built 1 zonelists in Zone order, 
> mobility grouping on.  Total pages: 16272
> 2025-11-04 08:17:08,476: [    0.000000] Kernel command line: 
> printk.time=0 console=ttyS0
> 
> I.e. the replay worked as expected. When it fails, console.log only 
> contains:
> 
> 2025-11-04 08:25:26,601: PCI: 00:01:0 class 0101 id 1095:0646
> 2025-11-04 08:25:26,601: PCI:   region 0: 0000c000
> 2025-11-04 08:25:26,601: PCI:   region 1: 0000c008
> 2025-11-04 08:25:26,601: PCI:   region 2: 0000c010
> 2025-11-04 08:25:26,601: PCI:   region 3: 0000c018
> 2025-11-04 08:25:26,601: PCI:   region 4: 0000c020
> 2025-11-04 08:25:26,602: PCI: 00:07:0 class 0601 id 8086:0484
> 2025-11-04 08:25:28,601: [    0.000000] Initializing cgroup subsys cpu
> 2025-11-04 08:25:28,602: [    0.000000] Linux version 2.6.26-2-alpha- 
> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 
> 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
> 2025-11-04 08:25:28,602: [    0.000000] Booting GENERIC on Tsunami 
> variation Clipper using machine vector Clipper from SRM
> 2025-11-04 08:25:28,602: [    0.000000] Major Options: MAGIC_SYSRQ
> 2025-11-04 08:25:28,602: [    0.000000] Command line: printk.time=0 
> console=ttyS0
> 2025-11-04 08:25:28,602: [    0.000000] memcluster 0, usage 1, 
> start        0, end       15
> 2025-11-04 08:25:28,602: [    0.000000] memcluster 1, usage 0, 
> start       15, end    16384
> 2025-11-04 08:25:28,602: [    0.000000] freeing pages 15:2048
> 2025-11-04 08:25:28,603: [    0.000000] freeing pages 2987:16384
> 2025-11-04 08:25:28,603: [    0.000000] reserving pages 2987:2988
> 2025-11-04 08:25:28,603: [    0.000000] Built 1 zonelists in Zone order, 
> mobility grouping on.  Total pages: 16272
> 2025-11-04 08:25:28,603: [    0.000000] Kernel command line: 
> printk.time=0 console=ttyS0
> 
> I.e. the replay did not work.
> 
> Could this RCU stuff somehow influence the replay mechanism in QEMU?

I don't know (yet).

Can you attach gdb and show a backtrace for each thread? It often 
reveals deadlock among threads.

Regards,
Akihiko Odaki

