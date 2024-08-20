Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D948C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 09:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgL8l-0001Sr-Br; Tue, 20 Aug 2024 05:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgL8i-0001Q7-Dk; Tue, 20 Aug 2024 05:26:56 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sgL8f-0003zz-Vp; Tue, 20 Aug 2024 05:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724146003; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=PgfYMwVr4+//L64PSFMIHNsEOrOKxw1z5NF7vGcpe9A=;
 b=mFB9mv2RajluEmnGoxbC8+p/zkOApUo2+vlMlMm7ukxTrbaWLkhAFPhpbZmgATSjEFwNcxZJdWlJGLMzyL5ETWjZ70NVGh1Oo2jIjEKZBLJL+Kz6ByQpfKKshNS17MDgJGgLbGt855XvQ7lIlDVzl+GrJQKRsQOZLmNWooGQgxk=
Received: from 30.166.65.10(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDI3aXS_1724146000) by smtp.aliyun-inc.com;
 Tue, 20 Aug 2024 17:26:41 +0800
Message-ID: <9fa5280d-d642-42bc-a138-55b9542d1ca9@linux.alibaba.com>
Date: Tue, 20 Aug 2024 17:26:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/15] tcg/riscv: Implement vector mov/dup{m/i}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-8-zhiwei_liu@linux.alibaba.com>
 <1c5bb9a6-ddb0-4aed-9150-ff4031b4c2d5@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <1c5bb9a6-ddb0-4aed-9150-ff4031b4c2d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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


On 2024/8/20 17:00, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> +    case TCG_TYPE_V64:
>> +    case TCG_TYPE_V128:
>> +    case TCG_TYPE_V256:
>> +        tcg_debug_assert(ret > TCG_REG_V0 && arg > TCG_REG_V0);
>> +        tcg_target_set_vec_config(s, type, prev_vece);
>> +        tcg_out_opc_vv(s, OPC_VMV_V_V, ret, TCG_REG_V0, arg, true);
>> +        break;
>
> Is it worth using whole register move (vmvNr.v) for the appropriate VLEN?

Yes. We will use vmvNr.v next version. Thanks for your suggestion.

Zhiwei

>
>
> r~

