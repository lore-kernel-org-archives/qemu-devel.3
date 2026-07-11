Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1385C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 08:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiTNQ-0006vA-GA; Sat, 11 Jul 2026 04:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wiTNC-0006tC-ER; Sat, 11 Jul 2026 04:47:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wiTN8-00021H-1f; Sat, 11 Jul 2026 04:47:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66B8lCIF059829
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 11 Jul 2026 17:47:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oLHuqQNm7x08Ep5efDS1zs9hdSdwQTbHqCe/xY3u7GE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1783759632; v=1;
 b=wJcnK17Cv+8oMMt+KCTXmROyrljZPy7nl15jNHVJsAORYGvVLaVBryOfcO+z9rH6
 oD0jUi4NTzB2ZjqtyMwN7P+82IpaScgxvaKgAk8dkntDam/sQfbOQkLvK1rrHIAt
 iFtncK1XDAy6rJw6h2KIUTX+rC/dPluKmSd1xx7krcgmcxb0NP+Xqg53IokBqXlm
 dJ2Dc9lEnyZCQ3ZUPNvB7GUoe9KX41T69SUL2q+LUsvVl9jN3xLfu+R+tiMqf1JE
 CB/v33MTy5apwcAlrZy3vW4F6ybpJAY7xq9wi/D3EXCGpMFMiV1Wbw+LylU5FZ9p
 9BdmusMzEzPPXQwezQgKsQ==
Message-ID: <6b4f41b6-6a72-4378-950d-b8884e7dd839@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 11 Jul 2026 17:47:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
To: Michael Tokarev <mjt@tls.msk.ru>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Chengbo Gao <gaochengbo@bosc.ac.cn>, qemu-stable <qemu-stable@nongnu.org>,
 Frank Chang <frank.chang@sifive.com>
References: <20260701092241.307801-1-daniel.barboza@oss.qualcomm.com>
 <59d0a99c-8eb2-4192-a388-331d0dd93358@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <59d0a99c-8eb2-4192-a388-331d0dd93358@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

Hi,

First, thank you for your work maintaining the stable series.

On 2026/07/11 16:47, Michael Tokarev wrote:
> On 7/1/26 12:22, Daniel Henrique Barboza wrote:
>> We're hardcoding faulting type as READ, where it could very well be a
>> write access, and we're not recording the faulting addr/iova.
>>
>> A note was added in the fault_type logic because I wasn't able to
>> trivially handle a probable code repeitition it in this same patch.
>> Something to do in a later date.
>>
>> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3564
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/riscv-iommu.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> For the stable qemu series (currently 10.0.x-LTS and 11.0.x), in order
> to pick this commit, I also picked v11.0.0-1212-gca7bac51e04
> "hw/riscv/riscv-iommu: Avoid caching PCI device IDs" by Chengbo Gao
> (Cc'ed) - because it touched the same code and there's a merge conflict.
> I can edit this patch ("set ftype and iova in riscv_iommu_ctx()") instead,
> but it felt that ca7bac51e04 is also a good pick for the stable series.
> 
> Additionally for 10.0.x-LTS series, I also picked 2 more commits:
> 
> v10.2.0-323-g15406cc593a "hw/riscv: riscv-iommu: Don't look up DDT cache
>   in Off and Bare modes" by Frank Chang (Cc'ed), which avoids a merge
>   conflict and also looks like a (maybe missing) bugfix.
> 
> v10.2.0-312-gc497ef6739c "hw/riscv/riscv-iommu: Fix MemoryRegion owner"
>   by Akihiko Odaki, which I spotted when looking for the history of
>   changes, and which looked like an obvious bugfix.

This particular change is somewhat orthogonal to the broader issue you 
describe with RISC-V patches. I found it through a codebase-wide search 
for incorrect MemoryRegion ownership, rather than while following the 
evolution of the RISC-V code. The same search found a similar issue 
elsewhere, which you have already picked up:

https://lore.kernel.org/qemu-devel/20251121184424.1137669-18-mjt@tls.msk.ru/
("[Stable-10.0.7 18/81] hw/nvram/ds1225y: Fix nvram MemoryRegion owner")

Unfortunately, there are several recurring patterns of MemoryRegion 
misuse, and in some cases I am not entirely sure what the correct 
ownership should be. In any case, this is separate from the concerns 
around fast-moving RISC-V development.

This particular change is trivial; it corrects semantically incorrect 
code, but I am not sure whether the bug has any user-visible effect.

Regards,
Akihiko Odaki

> 
> Hopefully this is okay.  Unfortunately even the simpler changes brings
> up quite a lot of missing fixes just by a chance - this means that we
> either not doing a good job keeping stable series up to date (by marking
> commits fixing stuff for-stable), or we should not try fixing stuff in
> previous series for a too-fast-moving target.
> 
> I'm sorry I'm bringing up this more general question in a very narrow
> context of this particular fix (which might not even be important
> enough).  Maybe I should discuss this separately.  Overall, I'm
> having some.. issues with riscv pullreqs in context of stable series,
> it's always more time-consuming to handle these and a bit more difficult
> to decide what is imortant and what can be skipped.
> 
> Thanks,
> 
> /mjt
> 


