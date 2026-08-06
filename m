Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72334C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrnD9-00016c-M6; Wed, 05 Aug 2026 21:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrnD8-00016R-3j
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:47:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrnD5-0002QX-2f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:47:53 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6761la4V080889
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 10:47:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mouRBOQ2NzFbc4vCrZBdEMbw7kCzE1Ja53Xq+7BkWds=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785980857; v=1;
 b=b9lNV1+4Cye8AMIlEltBEibmxowjMaLRo6YbVI6YYdtXcGjIpdO5qw9QvSLGrdEl
 zrCX15G2Y+OlvKI10qnNfYKMC0W2rhhRuP3QBmAN2MkViDdotVb7Uvmbynn5MFGX
 xIY7Q8I5aoieue9vpHCv4x8OYelMP7WXP2pqYrcIsazYZq298MJhyH7UP3DBSqlO
 BlV1551CkSZlIYlMkkvbz9AD2sr10dnYaybc0eBVY1gic1UEYVmIvI5tju0YK0Xq
 Xf74UHIVLwCzYllkcjQqV2pXIk45OIPA39ElpbRm5pDd8wxnW2IKNr2blxZUDE2U
 MMcfJcguT/qSoC6NFq7pvQ==
Message-ID: <7569efba-b88e-4252-9f40-16246dd4362b@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 10:47:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] runstate: set crash_occurred on guest crashloaded
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pbonzini@redhat.com
References: <f76c7662-09d5-4f70-a72f-90dcbe9cfef9@oss.qualcomm.com>
 <178593181019.90910.8754057031123805737@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <178593181019.90910.8754057031123805737@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/08/05 21:10, Zhengrong Li wrote:
> Hi Philippe,
> 
> Thanks for the review.
> 
> I followed the existing pattern in qemu_system_guest_panicked(),
> which already sets crash_occurred on current_cpu when a guest
> panic is reported. The intent was to keep the panicked and
> crash-loaded paths consistent.
> 
> Putting it in the generic function also means any future crash
> notification mechanism (beyond pvpanic) would automatically
> benefit from identifying the faulting CPU in guest dumps.
> 
> I agree the original commit bac05aa9a77 ("cpu: Add crash_occurred
> flag into CPUState") doesn't explain the design choice well.
> 
> If you prefer moving it to handle_event() in the caller, I'm
> happy to adjust. What do you think?

I find your reasoning makes sense. It is a common requirement of 
qemu_system_guest_panicked() callers to update current_cpu, and having 
the logic to update the CPU in the same function will de-duplicate that 
logic. While there is only one caller of 
qemu_system_guest_crashloaded(), consistency and future prospect 
justifies to do the same.

On the other hand, it is also true that a function that is prefixed 
qemu_system_* implicitly updating current_cpu is obscure. I think the 
intent would be clearer if the functions explicitly take the CPU via a 
parameter. In fact, most callers of qemu_system_guest_panicked() 
explicitly take the CPU via a parameter. e.g., kvm_cpu_exec(). 
qemu_system_guest_panicked() breaks the propagation of the CPU value and 
potentially attributes the panic to a wrong CPU.

We are adding a similar function and its call, so it is a good timing to 
perform such refactoring. I still don't require you to do that since 
updating the signature of qemu_system_guest_panicked() requires a simple 
yet codebase-wide edit that is not strictly necessary for the feature we 
are adding.

Regards,
Akihiko Odaki

