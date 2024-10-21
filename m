Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296A4D0E6F2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ptP-0007ei-5U; Mon, 21 Oct 2024 06:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t2ptM-0007eU-VN; Mon, 21 Oct 2024 06:44:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t2ptJ-0003DJ-Ug; Mon, 21 Oct 2024 06:44:04 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AADD4E6001;
 Mon, 21 Oct 2024 12:44:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id uMOB6HvHBZia; Mon, 21 Oct 2024 12:43:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C05C4E6010; Mon, 21 Oct 2024 12:43:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A49F746F60;
 Mon, 21 Oct 2024 12:43:58 +0200 (CEST)
Date: Mon, 21 Oct 2024 12:43:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Guenter Roeck <linux@roeck-us.net>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 06/12] target/ppc: Split out helper_dbczl for 970 (fwd)
Message-ID: <416c2534-d975-6123-00dc-060ec00c1e24@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

(Resend with fixed ppc list address.)

On Sun, 20 Oct 2024, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Jul 19, 2024 at 11:07:01AM +1000, Richard Henderson wrote:
>> We can determine at translation time whether the insn is or
>> is not dbczl.  We must retain a runtime check against the
>> HID5 register, but we can move that to a separate function
>> that never affects other ppc models.
>> 
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I see an odd failure when trying to boot ppc64 images in qemu v9.1.0 and
> v9.1.1.
> 
> Starting network: udhcpc: started, v1.36.1
> malloc(): corrupted top size
> Aborted

Do you have more info on what reproduces this? What is the QEMU command and 
what guest code is running? This looks like something may be using dcbzl on 
something else than a 970 or if this is emulating a 970 then I don't see why 
this stopped working. Looking at the reproducer may help.

Regards,
BALATON Zoltan

> /usr/share/udhcpc/default.script: line 41: can't create : nonexistent 
> directory
> 
> I bisected the problem to this patch; bisect log is attached.
> I also found that the problem has been fixed in mainline qemu. Bisect
> points to commit: f168808d7d10 ("accel/tcg: Add TCGCPUOps.tlb_fill_align")
> as the fix. I attached this bisect log as well.
> 
> Reverting this patch isn't easy due to several follow-up commits. Applying
> commit f168808d7d10 plus several preceding commits on top of v9.1.1 seems
> to fix the problem. The commits I applied are
> 
> da335fe12a5d include/exec/memop: Move get_alignment_bits from tcg.h
> c5809eee452b include/exec/memop: Rename get_alignment_bits
> e5b063e81fd2 include/exec/memop: Introduce memop_atomicity_bits
> f168808d7d10 accel/tcg: Add TCGCPUOps.tlb_fill_align
> 
> Obviously I have no idea if this is even remotely correct, so please take
> this report as purely informational in case someone else observes a similar
> problem.
> 
> Thanks,
> Guenter
> 
> ---
> Bug introduced:
> 
> # bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 
> release
> # good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 
> release
> git bisect start 'v9.1.0' 'v9.0.0'
> # good: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead 
> code related to 'acpi_memory_hotplug'
> git bisect good 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
> # good: [76e375fc3c538bd6e4232314f693b56536a50b73] docs/qapidoc: add QMP 
> highlighting to annotated qmp-example blocks
> git bisect good 76e375fc3c538bd6e4232314f693b56536a50b73
> # bad: [60d30cff8472c0bf05a40b0f55221fb4efb768e2] target/ppc: Move SPR 
> indirect registers into PnvCore
> git bisect bad 60d30cff8472c0bf05a40b0f55221fb4efb768e2
> # bad: [6c635326425091e164b563a7ce96408ef74ff2ec] vfio/{iommufd,container}: 
> Remove caps::aw_bits
> git bisect bad 6c635326425091e164b563a7ce96408ef74ff2ec
> # good: [23fa74974d8c96bc95cbecc0d4e2d90f984939f6] Merge tag 
> 'pull-target-arm-20240718' of https://git.linaro.org/people/pmaydell/qemu-arm 
> into staging
> git bisect good 23fa74974d8c96bc95cbecc0d4e2d90f984939f6
> # good: [c135d5eaafe7aa2533da663d8e5a34a424b71eb9] tests/tcg/aarch64: Fix 
> test-mte.py
> git bisect good c135d5eaafe7aa2533da663d8e5a34a424b71eb9
> # good: [6af69d02706c821797802cfd56acdac13a7c9422] Merge tag 
> 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu into staging
> git bisect good 6af69d02706c821797802cfd56acdac13a7c9422
> # bad: [71bce0e1fb1a866dde4a4b6016fc18b09f317338] Merge tag 
> 'pull-tcg-20240723' of https://gitlab.com/rth7680/qemu into staging
> git bisect bad 71bce0e1fb1a866dde4a4b6016fc18b09f317338
> # bad: [62fe57c6d23fe8136d281f0e37ec8a9fab08b60a] target/ppc: Split out 
> helper_dbczl for 970
> git bisect bad 62fe57c6d23fe8136d281f0e37ec8a9fab08b60a
> # good: [3b9991e35c08be7fd6b84090b2114ff1bfd44d3f] target/arm: Use 
> set/clear_helper_retaddr in SVE and SME helpers
> git bisect good 3b9991e35c08be7fd6b84090b2114ff1bfd44d3f
> # good: [521a80d895ec8ef0200dcac9b9b19e60b0cc1d1a] target/ppc: Hoist 
> dcbz_size out of dcbz_common
> git bisect good 521a80d895ec8ef0200dcac9b9b19e60b0cc1d1a
> # first bad commit: [62fe57c6d23fe8136d281f0e37ec8a9fab08b60a] target/ppc: 
> Split out helper_dbczl for 970
> 
> ---
> Bug fixed:
> 
> # pass: [72b0b80714066a435502b67cdb55a7868ba0487d] Merge tag 'for-upstream' 
> of https://gitlab.com/bonzini/qemu into staging
> # fail: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 
> release
> git bisect start '--term-bad=pass' '--term-good=fail' 'HEAD' 'v9.1.0'
> # fail: [4ae7d11b70a840eec7aa27269093b15d04ebc84e] Merge tag 
> 'pull-tcg-20240922' of https://gitlab.com/rth7680/qemu into staging
> git bisect fail 4ae7d11b70a840eec7aa27269093b15d04ebc84e
> # fail: [b5ab62b3c0050612c7f9b0b4baeb44ebab42775a] Merge tag 'for-upstream' 
> of https://gitlab.com/bonzini/qemu into staging
> git bisect fail b5ab62b3c0050612c7f9b0b4baeb44ebab42775a
> # pass: [1bfb726112ea4fda07c988f08df32d1eebb9abec] ui/pixman: generalize 
> shared_image_destroy
> git bisect pass 1bfb726112ea4fda07c988f08df32d1eebb9abec
> # fail: [7e3b6d8063f245d27eecce5aabe624b5785f2a77] Merge tag 
> 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging
> git bisect fail 7e3b6d8063f245d27eecce5aabe624b5785f2a77
> # pass: [e530581ee06573fcf48c7f7a6c3f8ec6e5809243] target/arm: Fix alignment 
> fault priority in get_phys_addr_lpae
> git bisect pass e530581ee06573fcf48c7f7a6c3f8ec6e5809243
> # pass: [795592fef7d5d66a67b95a7f45cc1a84883db6a8] accel/tcg: Use the 
> alignment test in tlb_fill_align
> git bisect pass 795592fef7d5d66a67b95a7f45cc1a84883db6a8
> # fail: [9d08a70ddc08e9b6ecf870fd232531c78fe0b208] tests/tcg: Run 
> test-proc-mappings.py on i386
> git bisect fail 9d08a70ddc08e9b6ecf870fd232531c78fe0b208
> # fail: [da335fe12a5da71a33d7afc2075a341f26213f53] include/exec/memop: Move 
> get_alignment_bits from tcg.h
> git bisect fail da335fe12a5da71a33d7afc2075a341f26213f53
> # fail: [e5b063e81fd2b30aad1e9128238871c71b62a666] include/exec/memop: 
> Introduce memop_atomicity_bits
> git bisect fail e5b063e81fd2b30aad1e9128238871c71b62a666
> # pass: [f168808d7d100ed96c52c4438c4ddb557bd086bf] accel/tcg: Add 
> TCGCPUOps.tlb_fill_align
> git bisect pass f168808d7d100ed96c52c4438c4ddb557bd086bf
> # first pass commit: [f168808d7d100ed96c52c4438c4ddb557bd086bf] accel/tcg: 
> Add TCGCPUOps.tlb_fill_align
> 
>

