Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCDC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 06:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV3yZ-00073d-Qz; Wed, 31 Jan 2024 01:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rV3yX-00073B-Fu; Wed, 31 Jan 2024 01:21:33 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rV3yU-0004Ak-Qg; Wed, 31 Jan 2024 01:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1706682080; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=EeWh8n22ZvMxrk8hktTaOEr2sDarzcyjqxVNVugijLw=;
 b=j6zoGv9igZilBVcRKbfhzoP3NEZtCppPyAPExNhjer8WSM77ZB2U+fNAMRTLgS8hNO7swowgeLLLhujNEt2EcBXS4Ku4EtDujCXfDgzNVISgHcCzHJAFrQ/m4K5q/ionkgBMbj2V4qKk/pkVVTzLPJ9FsJmLqJtpfxWe2zV0uPk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0W.iK23V_1706682078; 
Received: from 30.198.0.179(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W.iK23V_1706682078) by smtp.aliyun-inc.com;
 Wed, 31 Jan 2024 14:21:19 +0800
Message-ID: <83c3bd1c-d3e0-4a64-8101-5591efaabaa8@linux.alibaba.com>
Date: Wed, 31 Jan 2024 14:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Support xtheadmaee for thead-c906
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, bjorn@kernel.org
References: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
 <20240130111159.532-3-zhiwei_liu@linux.alibaba.com>
 <4345f1e4-6588-4f17-975d-b9349b07421c@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <4345f1e4-6588-4f17-975d-b9349b07421c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/1/31 13:07, Richard Henderson wrote:
> On 1/30/24 21:11, LIU Zhiwei wrote:
>> +riscv_csr_operations th_csr_ops[CSR_TABLE_SIZE] = {
>> +#if !defined(CONFIG_USER_ONLY)
>> +    [CSR_TH_MXSTATUS]     = { "th_mxstatus", th_maee_check, 
>> read_th_mxstatus,
>> + write_th_mxstatus},
>> +#endif /* !CONFIG_USER_ONLY */
>> +};
>
> This is clearly the wrong data structure for a single entry in the array.

This array should have the same size with csr_ops so that we can 
override custom CSR behavior directly. Besides, It will have other 
entries in the near future.

I see that I missed surround the th_maee_check, read_th_mxstatus, 
write_mxstatus with !CONFIG_USER_ONLY.  But I don't understand why it is 
wrong for a single entry in the array, at least the compiler think it 
has no error.

Thanks,
Zhiwei

>
>
> r~
>

