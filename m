Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E576CC52D72
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmAO-0001Dr-Iv; Fri, 02 Aug 2024 02:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmAM-00017Q-GV; Fri, 02 Aug 2024 02:53:30 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZmAJ-0004Xv-5S; Fri, 02 Aug 2024 02:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722581601; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=aaKarWoFF/fDYsuumF95LUfvuAdPnffGAEXg1g8zZjQ=;
 b=l/c2jcCzq2gZtZSOvom+10gK5d6dtrnrqoACv1CJjBzGnqUrwKihLr+rCAKLx30hFW25oWoOl30XREd13dFTWMbavzLGr6bTOO4apMATIF6LDEv4XboLdws5HU9E0+ZYZA7/21RaPd/YxbCC1elPd14RwX71I6avIABmrb5kbG8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBwZhcb_1722581600; 
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwZhcb_1722581600) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 14:53:21 +0800
Message-ID: <bfb15075-ddbc-4081-b4dd-9ef57f0c0b6c@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
 <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
 <b65aa4d1-c206-4ebb-af8c-75b034c6b875@linux.alibaba.com>
 <5580439d-08ed-483c-aecf-e31536f36f79@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <5580439d-08ed-483c-aecf-e31536f36f79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/8/2 14:45, Richard Henderson wrote:
> On 8/2/24 16:21, LIU Zhiwei wrote:
>> By the way, the MXL is const now in recently updated RISC-V 
>> specification.
>
> Oh yes? 
Yes.  In 1.13 privileged specification about MISA CSR:

"The MXL field is read-only. If misa is nonzero, the MXL field indicates 
the effective XLEN in M-mode, a
constant termed MXLEN."

> Then perhaps we should rename misa_mxl_max to misa_mxl.

I will mark this on my todo list.

Thanks,
Zhiwei

>
>
> r~

