Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CF3CCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squsv-0006Zw-PZ; Wed, 18 Sep 2024 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1squsS-0006Sx-Av; Wed, 18 Sep 2024 09:37:53 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1squs4-0007r3-ON; Wed, 18 Sep 2024 09:37:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 6F78EC0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726666634;
 bh=h/xNo84tLzuUBiJzxOYvmq5ZkSQGeVRmK+P8RjYIjBY=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=tHaZ36aVOLjizpTUOrHHR+pcsNY4ap9DYDd29KiJAry/4v9duLUfbYPYTau7gjj4P
 HVY7w0BHn/wyINi4X4kJLPAU7zqlFXedTXFkfSQjYPpJioHwczVqWfI7TK3eCxzPEV
 ZYI6JEyITO3oKmdtLSIsxpXnquT1jhWIk5jMZKXdgpqa8ZLDoTCs2zh/zvDTEiUJdP
 GAj1dM9PuLG1gB+27sapsaYlQCECXbeJnRGCyOC84Uv0WgLQzuX1zrPVvDKzP2G1oV
 m9hca+nb40Rpg+mMBE38T0X/L8ju9QDUhTRhtlAH3/qkVK72GH1nwv1UdzKyTMyQ8F
 QxNKK29Lk0TrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726666634;
 bh=h/xNo84tLzuUBiJzxOYvmq5ZkSQGeVRmK+P8RjYIjBY=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=MriygYevTylppcQGAiXdKg27BJP4JlqUR6cy9S/Rck59fl9shnIUvZFArNptS/Zqo
 egeLkmZTOE8Z31e8g8I40KQUe9w/vQuY+RtW8NaM3Onm02I7dSA2KpOuSgiQCPOyQj
 RExs3XJZeY8ddixKeiBxgN/u1jvKNWFzyubHZyxm5ke4d4rHrGuBh984lVH2sRTFyw
 YMUH210qlWhQTM9g5JV0oIt5ZEwgD09CWC91WX0sp7t4a/UAxhBJZTZe9jyBWi4NmF
 CqQlTdeQHureRFbZx3vxT0G3WeyYCPx2YWM787GoE+9kJWC+vkIdrgJPXDlxWJHfiY
 H16NNbZT3jYeQ==
Message-ID: <0e2bbc89-66ae-4ca3-b01b-64998a6e8da6@syntacore.com>
Date: Wed, 18 Sep 2024 16:37:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
To: Andrew Jones <ajones@ventanamicro.com>
CC: <alistair.francis@wdc.com>, <alistair23@gmail.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
References: <20240626-1420003b7d88d892be22a719@orel>
 <20240917115433.38503-1-alexei.filippov@syntacore.com>
 <20240917-4c642a7fb52b49f470c9f29a@orel>
 <20240917-d929b9736eea1df07a77a9bc@orel>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <20240917-d929b9736eea1df07a77a9bc@orel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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



On 17.09.2024 16:10, Andrew Jones wrote:
> On Tue, Sep 17, 2024 at 02:29:41PM GMT, Andrew Jones wrote:
>> On Tue, Sep 17, 2024 at 02:54:33PM GMT, Alexei Filippov wrote:
>>> kvm_riscv_handle_sbi() may return not supported return code to not
>>> trigger qemu abort with vendor-specific sbi.
>>>
>>> Add new error path to provide proper error in case of
>>> qemu_chr_fe_read_all() may not return sizeof(ch), because exactly zero
>>> just means we failed to read input, which can happen, so
>>> telling the SBI caller we failed to read, but telling the caller of this
>>> function that we successfully emulated the SBI call, is correct. However,
>>> anything else, other than sizeof(ch), means something unexpected happened,
>>> so we should return an error.
>>>
>>> Added SBI related return code's defines.
>>>
>>> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
>>> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
>>
>> Fixes tag goes above s-o-b and 8 hex digits is a bit small. Most
>> commit references in QEMU are using 10 or 12 digits.
>>
>>> ---
>>>   target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
>>>   target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
>>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index f6e3156b8d..9f2ca67c9f 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1517,19 +1517,21 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>>>           ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
>>>           if (ret == sizeof(ch)) {
>>>               run->riscv_sbi.ret[0] = ch;
>>> -        } else {
>>> +            ret = 0;
>>> +        } else if (ret == 0) {
>>>               run->riscv_sbi.ret[0] = -1;
>>> +        } else {
>>> +            ret = -1;
>>>           }
>>> -        ret = 0;
>>
>> Looks good!
>>
>>>           break;
>>>       case SBI_EXT_DBCN:
>>>           kvm_riscv_handle_sbi_dbcn(cs, run);
>>>           break;
>>>       default:
>>>           qemu_log_mask(LOG_UNIMP,
>>> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
>>> +                      "%s: Unhandled SBI exit with extension-id %lu\n",
>>>                         __func__, run->riscv_sbi.extension_id);
>>> -        ret = -1;
>>> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
>>
>> This, along with the addition of the SBI_* defines below, should be a
>> separate patch. If we were just naming the -1, then I wouldn't mind it
>> slipping in with the same patch, but this is changing behavior since
>> SBI_ERR_NOT_SUPPORTED is -2. I agree with the change, though, it just
>> needs to be a separate patch. And the separate patch should have the
>> same Fixes tag.
>>
> 
> Actually it's even more of a difference than s/-1/-2/ since we're no long
> aborting the SBI call, but returning non-supported instead.

I agreed, I'll split commits, but do you want me to resend patch as 2 patch 
series or 2 separate patches?
> 
> Thanks,
> drew

-- 
Sincerely,
Aleksei Filippov

