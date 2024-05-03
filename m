Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157A4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 10:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2qKN-0006Yi-GT; Fri, 03 May 2024 06:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1s2qKL-0006Xc-Ms; Fri, 03 May 2024 06:39:41 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1s2qKJ-0000VT-Ht; Fri, 03 May 2024 06:39:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 69AEEC0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1714732775;
 bh=4tUJdpqAd9R6UWBtq4RMNG1+HhfhmB08gWUPWb3n/n8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=u0L8iX5VnSGAxKyHp5bn7ErXTn+7o9WIWN0wfVvxbJFXR7J+1paa20eJ3qnRGi+NC
 jvawAb7ltOuHIbQGAtJvHHO7eV0h+8PoERIySGWFNpuCSo1yx7Eiyx26V6cbMHDQlq
 QR7cg89VdMaqmOZM8X9aqq9AHkwnu931pSM+NbdfhMuJI96HvBxpkgVPFmm9BQ+F1J
 HXuH+Aq/Tr/qR3kJDazIAdetW96OTeqSnvVeodAhZZqWb3HZS90hKfVA+U0msT9FgH
 iNVnX+XC0MvwzGyCA10ZzJLPIKPOmNMj8AzbiXze9aaPz3DXQu+7RQKQUxXVSFwcet
 iaUpB+7F2oVMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1714732775;
 bh=4tUJdpqAd9R6UWBtq4RMNG1+HhfhmB08gWUPWb3n/n8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=mNOhuLWCsYl0i4Idl2FyReUTGJhqxbWsqGW4lBYMeln54OIuIQOFosNRb9zWOY+5B
 88eSyaEFzigLm7nPvcRHdAF5Gar/h01xZ3bHqJ4aZteSD/YLPJ5l1x5YR53AMG4b/0
 YLjTSL/0MaNtznDXVf1/922aotA0EIDp1QTvVvTavPbVu15uNbeMnU5SuIHrDCuN3S
 5PjHi0Ip+MlZd5giHSdz7CSq5OmVIgQlwe5zTBWzylpZSnh8wUg/VwEh8PvFxb5D6R
 BSx+OWYNszs9sccxMXGwvU2hP/fHKjW8/UPQ8uJOycMIor8hdv/HUJ0AxLhkPUAFvM
 kitKDMYx2MNsw==
Message-ID: <e7acd34f-956c-47ea-acfd-0b9ef82ff90c@syntacore.com>
Date: Fri, 3 May 2024 13:39:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
To: Andrew Jones <ajones@ventanamicro.com>
CC: <alistair.francis@wdc.com>, <alistair23@gmail.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
References: <20240422-e78b28f00a168518c5d4937a@orel>
 <20240422114254.13839-1-alexei.filippov@syntacore.com>
 <20240422-fd9fc07462257b6da42d8eb5@orel>
 <20240425-7ae473e720f2879f34c957f6@orel>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <20240425-7ae473e720f2879f34c957f6@orel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SORTED_RECIPS=2.499,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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



On 25.04.2024 12:21, Andrew Jones wrote:
> On Mon, Apr 22, 2024 at 02:31:36PM +0200, Andrew Jones wrote:
>> On Mon, Apr 22, 2024 at 02:42:54PM +0300, Alexei Filippov wrote:
>>> kvm_riscv_handle_sbi() may return not supported return code to not
>>> trigger qemu abort with vendor-specific sbi.
>>>
>>> Add new error path to provide proper error in case of
>>> qemu_chr_fe_read_all() may not return sizeof(ch).
>>
>> I think something more along the lines of what I wrote in my previous
>> reply will help clarify this more. Here's what I wrote
>>
>> """
>> Exactly zero just means we failed to read input, which can happen, so
>> telling the SBI caller we failed to read, but telling the caller of this
>> function that we successfully emulated the SBI call, is correct. However,
>> anything else, other than sizeof(ch), means something unexpected happened,
>> so we should indeed return an error from this function.
>> """
>>
>> Thanks,
>> drew
>>
>>>
>>> Added SBI related return code's defines.
>>>
>>> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
>>> ---
>>> Changes since v4-5:
>>> 		-Added new error path in case of qemu_chr_fe_read_all() may not
>>> 		return sizeof(ch).
>>> 		-Added more comments in commit message.
>>>   target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
>>>   target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
>>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index f9dbc18a76..5bb7b74d03 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1173,16 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>>>           ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
>>>           if (ret == sizeof(ch)) {
>>>               run->riscv_sbi.ret[0] = ch;
>>> +            ret = 0;
>>> +        } else if (ret == 0) {
>>> +            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
> 
> I'd prefer we still explicitly assign ret[0] to -1 here since that's what
> the spec explicitly says.
> 
> Thanks,
> drew

Can you please explain it a little bit more, cz I believe SBI_ERR_FAILURE is -1 
anyway. Defines was added at first place just to came along with Linux kernel 
SBI related defines.
-- 
Sincerely,
Aleksei Filippov

>>>           } else {
>>> -            run->riscv_sbi.ret[0] = -1;
>>> +            ret = -1;
>>>           }
>>> -        ret = 0;
>>>           break;
>>>       default:
>>>           qemu_log_mask(LOG_UNIMP,
>>> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
>>> +                      "%s: Unhandled SBI exit with extension-id %lu\n"
>>>                         __func__, run->riscv_sbi.extension_id);
>>> -        ret = -1;
>>> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
>>>           break;
>>>       }
>>>       return ret;
>>> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
>>> index 43899d08f6..a2e21d9b8c 100644
>>> --- a/target/riscv/sbi_ecall_interface.h
>>> +++ b/target/riscv/sbi_ecall_interface.h
>>> @@ -69,4 +69,16 @@
>>>   #define SBI_EXT_VENDOR_END              0x09FFFFFF
>>>   /* clang-format on */
>>>   
>>> +/* SBI return error codes */
>>> +#define SBI_SUCCESS                  0
>>> +#define SBI_ERR_FAILURE             -1
>>> +#define SBI_ERR_NOT_SUPPORTED       -2
>>> +#define SBI_ERR_INVALID_PARAM       -3
>>> +#define SBI_ERR_DENIED              -4
>>> +#define SBI_ERR_INVALID_ADDRESS     -5
>>> +#define SBI_ERR_ALREADY_AVAILABLE   -6
>>> +#define SBI_ERR_ALREADY_STARTED     -7
>>> +#define SBI_ERR_ALREADY_STOPPED     -8
>>> +#define SBI_ERR_NO_SHMEM            -9
>>> +
>>>   #endif
>>> -- 
>>> 2.34.1
>>>

