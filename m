Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8363EE77173
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 01:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJjbV-0006z1-MY; Fri, 06 Dec 2024 20:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJjbT-0006yV-Oc; Fri, 06 Dec 2024 20:27:27 -0500
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJjbO-0004DV-R9; Fri, 06 Dec 2024 20:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1733534831; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=3suNTl7cwKYJPMFfqJY65KCwAxaQoVLTmMxchXCQzn0=;
 b=fkGMrzrIo0o3q+JZGMtBF3p5uYKhU/MJhWgPZ6QGy3uV+buKl7sg0OUr4Xyv1yWhCt4/NdcLgGWZiEeplhNu5CaVh7nWognlZcxCBWPPVqZffamoBZG80oVeYQreHcg5u5g37M61HyuamVjt4DeBlwKzdfSeOBfMCwpgfjC39LM=
Received: from 30.166.64.54(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WKy1-Bs_1733534829 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 07 Dec 2024 09:27:10 +0800
Message-ID: <acbb7e5c-5f80-4d06-a569-53aeb8383e48@linux.alibaba.com>
Date: Sat, 7 Dec 2024 09:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] disas/riscv: Guard dec->cfg dereference for host
 disassemble
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
 <79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org>
 <5536d7c4-c3df-4cac-900b-bbb3cb2a8c4d@linux.alibaba.com>
 <bbd8f614-f967-4f7f-82c1-eafdd9fbba68@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <bbd8f614-f967-4f7f-82c1-eafdd9fbba68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/12/6 21:36, Richard Henderson wrote:
> On 12/5/24 22:39, LIU Zhiwei wrote:
>>
>> Both zcmt and zcmp are not compatible with Zcd, as they reuse some 
>> encodings from c.fsdsp.
>
> Ok, fair.  A comment about conflicts at that point may help.
Ok.
>
>>
>> Zimop or Zcmop also overlap with other isa extensions, as they are 
>> maybe-ops. Other extensions
>> such as zicfiss will reuse their encodings.
>>
>> I think we had better disassemble them to zicifss if it has been 
>> implemented on the target cpu. Otherwise
>> we disassemble them to maybe-ops.
>
> My point is that they are only belong to zimop until they are 
> assigned, like zicifss.

No, they always belong to zimop unless they are assigned to other 
extensions. Applications built with zicfiss can also
run on cpu with zimop. In this case, the instructions of zicfiss should 
be disassemble as zimop maybe-ops which has it's default behavior 
different with the behavior of zicfiss.

  Zimop belongs to mandate extension in RVB23 profile. There may be a 
lot of cpus implement zimop but doesn't implement overlapping zicfiss.  
So disassemble the applications to zimop is appropriate for these cpus.

> At that point they *have* a defined meaning in the standard isa.
>
> So, yes, disassemble as zicifss, but always, not "if it has been 
> implemented in the target cpu".
>
>>>> +        if (((i == 0) || cfg) && guard_func(cfg)) {
>>>
>>> This should be i == 0 || (cfg && guard_func(cfg)).
>>
>> OK. Although I think they are both right.
>
>  i = 0
>  cfg = NULL
>
>    (0 == 0 || NULL) && guard_func(NULL)
> -> (true || false) && guard_func(NULL)
> -> true && guard_func(NULL)
> -> guard_func(NULL)
> -> boom.
>
> Or are you saying it won't go boom because we happen to know the 0th 
> guard_func only returns true
Yes.
> ? There's still no reason to call it...

Agree. Will use this way.

Thanks,
Zhiwei

>
>
> r~

