Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AC8C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zao-0008RN-1o; Thu, 10 Sep 2026 03:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4Zal-0008RA-Nl; Thu, 10 Sep 2026 03:53:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4Zai-0000S5-2E; Thu, 10 Sep 2026 03:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789026742; bh=eYvDBcDwlRGYF9eyJfK6yKTmyfcGYJ2MuSmE4AhnD68=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e/FYJC6AS/rZz/HIc/rraeK4Q7EdNeFROldjJlYgEN6S0jH1zyBP4QNplS131+k1J
 6ziYqInoyK9BOY1LR9pzTM+ToqxgdDlLOjBCmGnWXKMiJZCzhnGLJ91GPWkpoTLAXp
 gnTSyZq93z3V4MwGu8ys+gjkfERqcKFpemkjTc9tb95vLHZBTAOn4HfipC2EI0wdQz
 EHHOSSWJE8dMI3j+4ShvpWStk2tkkMZixP22zz78YBCcyKLQTPkS+loedwDLp7tW49
 cQJ3kzeOzabhvyJf6OXU43rbd5wX9pcxd1CEcwJVJophiqzzGR+lAfVLB+RpkU/aBS
 JqHN6dGLZgXJA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC6BC1D35D3;
 Thu, 10 Sep 2026 10:52:22 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2994A42546B;
 Thu, 10 Sep 2026 10:52:53 +0300 (MSK)
Message-ID: <610b7674-dac5-4c56-88f9-fc77673155de@tls.msk.ru>
Date: Thu, 10 Sep 2026 10:52:53 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v4 0/2] hw/misc/applesmc: fix GET_KEY_BY_INDEX iteration
 and populate Apple SMC key set
To: Matthew Jackson <matthew@pq.io>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org
References: <20260719152343.69536-1-matthew@pq.io>
 <20260720164930.68383-1-matthew@pq.io>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260720164930.68383-1-matthew@pq.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

On 7/20/26 19:49, Matthew Jackson wrote:
> The applesmc device only answers APPLESMC_READ_CMD at its command
> port. Modern macOS guests (x86 10.14+, all 15.x) also issue WRITE,
> TYPE and GET_KEY_BY_INDEX, and enumerate the SMC key space at boot.
> The unanswered commands and the near-empty key table drive the
> AppleSMC kext into a kSMCSpuriousData retry storm (~1800 errors/sec,
> kernel_task ~70% CPU, WindowServer ~509% CPU on macOS 15).
> 
> Patch 1 implements the missing commands. Patch 2 populates the key
> table with a realistic iMac20,1 profile and the canonical #KEY count,
> so the guest's boot-time enumeration terminates.
> 
> v4:
>    - Regenerated against current master. Drop a stray hunk in patch 2/2
>      that reverted the qdev-properties.h include move (commit 78d45220b4);
>      the include is now left untouched. Reported-by Philippe
>      Mathieu-Daudé. No functional change.
>    - No other changes from v3.
> 
> v3: https://lore.kernel.org/qemu-devel/20260719152343.69536-1-matthew@pq.io/
> v2: addressed Peter Maydell's style review (loop braces, stl_be_p()).
> v1: https://lore.kernel.org/qemu-devel/20260507040153.14565-1-matthew@pq.io/
> 
> Matthew Jackson (2):
>    hw/misc/applesmc: implement GET_KEY_BY_INDEX, WRITE and TYPE commands
>    hw/misc/applesmc: populate Apple SMC key table
> 
>   hw/misc/applesmc.c | 344 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 337 insertions(+), 7 deletions(-)
Hi!

This does not look like a series which is "trivial enough" for qemu-trivial
tree :)

Thanks,

/mjt

