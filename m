Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB79C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 14:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3cuv-0003Ux-8m; Sun, 05 May 2024 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1s3cus-0003Om-RX
 for qemu-devel@nongnu.org; Sun, 05 May 2024 10:32:38 -0400
Received: from out-178.mta1.migadu.com ([2001:41d0:203:375::b2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1s3cuo-0002UM-N8
 for qemu-devel@nongnu.org; Sun, 05 May 2024 10:32:38 -0400
Message-ID: <960d6344-4aa5-4644-ba97-a06d21f4ead8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714919543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VY+njysv1MdU4u1nHnnqJGdW72Ge39UFiDFeON+QGqE=;
 b=taJ5kOdk2wl3oHJ8XlNRBIB/QtmTn9jYIKgmTYIaKOTNIEyB1/RBoYpuzOCNXYP7P0r7oi
 U7AnvcfyROoRjp0lA3/UKJhUggXT1et8mYL/ijzskc+wbJhGeYB/u/Lpn7ghgzTYS7pV7R
 A50jGzcXrBGpmyoBepbyUxQW/MQZNN8=
Date: Sun, 5 May 2024 22:31:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug
 System registers
To: Alexander Graf <agraf@csgraf.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 wanghaibin.wang@huawei.com
References: <20240503153453.54389-1-zenghui.yu@linux.dev>
 <f0c19830-d4e0-4585-b960-7dd3fa1a3c76@csgraf.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <f0c19830-d4e0-4585-b960-7dd3fa1a3c76@csgraf.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b2;
 envelope-from=zenghui.yu@linux.dev; helo=out-178.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/5/5 21:18, Alexander Graf wrote:
> 
> On 03.05.24 19:34, Zenghui Yu wrote:
>> We wrongly encoded ID_AA64PFR1_EL1 using {3,0,0,4,2} in 
>> hvf_sreg_match[] so
>> we fail to get the expected ARMCPRegInfo from cp_regs hash table with the
>> wrong key.
>>
>> Fix it with the correct encoding {3,0,0,4,1}. With that fixed, the Linux
>> guest can properly detect FEAT_SSBS2 on my M1 HW.
>>
>> All DBG{B,W}{V,C}R_EL1 registers are also wrongly encoded with op0 == 14.
>> It happens to work because HVF_SYSREG(CRn, CRm, 14, op1, op2) equals to
>> HVF_SYSREG(CRn, CRm, 2, op1, op2), by definition. But we shouldn't 
>> rely on
>> it.
>>
>> Fixes: a1477da3ddeb ("hvf: Add Apple Silicon support")
>> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> 
> 
> Nice catch! Did you find them only because of functional issues or have 
> you taken an automated pass somehow to validate the sysreg definitions 
> are correct?

Neither, this was found by code inspection. I was just curious about how
VMM would interact with hypervisor to expose features to the guest. Docs
at https://developer.apple.com/documentation/hypervisor are not that
detailed (I may need to read further ;-) ).

P.S., I verified on M1 that ID_AA64PFR1_EL1 is 0x20 at
hvf_arm_get_host_cpu_features() stage and is overwritten as 0x0 later
w/o this patch, which indicates the (guest visible) feature ID registers
are "writable" to some extent.

> Reviewed-by: Alexander Graf <agraf@csgraf.de>

Thanks!

Zenghui

