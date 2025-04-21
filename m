Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87160C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 13:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6rMO-00047O-8U; Mon, 21 Apr 2025 09:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1u6rMM-00047A-PK
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 09:38:54 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1u6rMK-0007OW-F0
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 09:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=bDW0R29TftOhMM4odMLyTAu+oTVdHSq9+IqBavuwSCU=; b=qsB4QlbRm5fH0g+c
 M73FHeFY9U29f0laWsF0O/M5i2LWKiX6vKQxVAUwKFUlVh2LrL96WFSQC49+/jpdHVnxbZWdjXJrU
 vgJeQIQSnNxPUZ4v2fVNfx8OSj9FTXz0UGsKdqHTPryBNCV44IYvINhKDY+xtiEloxLvpAeHmBucf
 fAWE8B57G3jun1IjbJmg1o78w/EAeBZhng/K5O8q8RhvOTbBpQJ5Ef+bEI+ONE7HilxUlPKqi7Cn4
 rvMQQ8rD5/d3nCi8Z3wlwcRytx0dTweoJHW3n/4xsnlKPgcI777bfA4HMkDYQxUr/HVysotySYrEy
 i4ROycVZwErnayXCfw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1u6rMG-00Cpp7-0q;
 Mon, 21 Apr 2025 13:38:48 +0000
Date: Mon, 21 Apr 2025 13:38:48 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: steven.sistare@oracle.com
Cc: qemu-devel@nongnu.org
Subject: Trying cpr
Message-ID: <aAZKaMkKYPlmBMcZ@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:27:16 up 348 days, 41 min,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Steve,
  I've just had a go with cpr-transfer, it's quite interesting.
I was just trying it on my (AMD) desktop.

* I was running with qemu displaying graphics, and after migration
the source display got updated every time I moved my mouse into the
source window; the VM was still stopped, but I guess that means
the source GUI is still parsing the guest VRAM and displaying it.
I'm not sure if there's any other interactions - e.g. is there any
situation where the source GUI will try and write into the shared
guest ram?

* Given that you pass fd's over the CPR socket, had you considered
passing main migration fd's over it as well, that way you'd
only need one incoming.

* The guest noticed the time skew:
  timekeeping watchdog on CPU1: Marking clocksource 'tsc' as unstable because the skew is too large:
     'kvm-clock' wd_nsec: 556248511 wd_new: 4a93129e69 wd_alst: 4a71eaf0aa mask: (all f's)
     'tsc' cs_nsec: 514023131 cs_now: 1047f1d8489 cs_last: 10414538c1 mask: (all f's)
     Clocksource 'tsc' skewed -42225380 ns (-42 ms) over watchdog 'kvm-clock' interval of 556248511 ns (556 ms)
     'kvm-clock' (not 'tsc') is current clocksource

  (That was hand copied, probably with some typos - who knew the
   GUI doesn't let you copy/paste from serial0...)


The source commandline was:
./try/qemu-system-x86_64  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -qmp stdio

The dest commandline was:
./try/qemu-system-x86_64 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -incoming tcp:0:44444 -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}'

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

