Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3A7E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIrr5-0003ri-Sq; Wed, 04 Dec 2024 11:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tIrr3-0003r4-Ur; Wed, 04 Dec 2024 11:03:57 -0500
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tIrr1-0007vF-9c; Wed, 04 Dec 2024 11:03:57 -0500
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 15E7940793C3;
 Wed,  4 Dec 2024 17:03:34 +0100 (CET)
Message-ID: <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
Date: Wed, 4 Dec 2024 17:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
To: Yanfeng Liu <yfliu2008@qq.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1733328214096
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi everyone,

I'd like to chime in here because we are sitting on a similar patch 
which I wanted to send to the mailing list as soon as riscv-debug-spec 
v1.0.0 becomes ratified.

For hypervisor support, `(qemu) info registers` isn't enough. We need to 
have both read and write access to the V-bit.

On 04.12.2024 14:43, Yanfeng Liu wrote:
> On Fri, 2024-11-29 at 09:59 +0000, Alex Bennée wrote:
>> Yanfeng <yfliu2008@qq.com> writes:
>>
>>> On Thu, 2024-11-28 at 14:21 +0000, Alex Bennée wrote:
>>>> Yanfeng Liu <yfliu2008@qq.com> writes:
>>>>
>>>>> This adds `virt` virtual register on debug interface so that users
>>>>> can access current virtualization mode for debugging purposes.
>>>>>
>>>>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>>>>> ---
>>>>>   gdb-xml/riscv-32bit-virtual.xml |  1 +
>>>>>   gdb-xml/riscv-64bit-virtual.xml |  1 +
>>>>>   target/riscv/gdbstub.c          | 18 ++++++++++++------
>>>>>   3 files changed, 14 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-
>>>>> virtual.xml
>>>>> index 905f1c555d..d44b6ca2dc 100644
>>>>> --- a/gdb-xml/riscv-32bit-virtual.xml
>>>>> +++ b/gdb-xml/riscv-32bit-virtual.xml
>>>>> @@ -8,4 +8,5 @@
>>>>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>>>   <feature name="org.gnu.gdb.riscv.virtual">
>>>>>     <reg name="priv" bitsize="32"/>
>>>>> +  <reg name="virt" bitsize="32"/>
>>>>>   </feature>
>>>>> diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-
>>>>> virtual.xml
>>>>> index 62d86c237b..7c9b63d5b6 100644
>>>>> --- a/gdb-xml/riscv-64bit-virtual.xml
>>>>> +++ b/gdb-xml/riscv-64bit-virtual.xml
>>>>> @@ -8,4 +8,5 @@
>>>>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>>>   <feature name="org.gnu.gdb.riscv.virtual">
>>>>>     <reg name="priv" bitsize="64"/>
>>>>> +  <reg name="virt" bitsize="64"/>
>>>>>   </feature>
>>>>
>>>> I assume these are mirrored in gdb not a QEMU only extension?
>>>
>>> So far I think it is a QEMU extension and the `gdb-multiarch` doesn't treat
>>> is
>>> specially. My tests shows it basically works:
>>>
>>> ```
>>> (gdb) ir virt
>>> priv           0x3      prv:3 [Machine]
>>> virt           0x0      0
>>> (gdb) set $priv = 2
>>> (gdb) ir virt
>>> priv           0x1      prv:1 [Supervisor]
>>> virt           0x0      0
>>> (gdb) set $virt = 1
>>> (gdb) ir virt
>>> priv           0x1      prv:1 [Supervisor]
>>> virt           0x1      1
>>> (gdb) set $virt = 0
>>> (gdb) ir virt
>>> priv           0x1      prv:1 [Supervisor]
>>> virt           0x0      0
>>> (gdb) set $virt = 1
>>> (gdb) ir virt
>>> priv           0x1      prv:1 [Supervisor]
>>> virt           0x1      1
>>> (gdb) set $priv = 3
>>> (gdb) ir virt
>>> priv           0x3      prv:3 [Machine]
>>> virt           0x0      0
>>> ```
>>
>> A gdbstub test case would be useful for this although I don't know if
>> the RiscV check-tcg tests switch mode at all.
>>
>>>
>>> As I am rather new to QEMU, please teach how we can add it as a QEMU only
>>> extension.
>>
>> You don't need to extend the XML from GDB, you can build a specific one
>> for QEMU extensions. For example:
>>
>>      gdb_feature_builder_init(&param.builder,
>>                               &cpu->dyn_sysreg_feature.desc,
>>                               "org.qemu.gdb.arm.sys.regs",
>>                               "system-registers.xml",
>>                               base_reg);
>>
>> This exports all the system registers QEMU knows about and GDB can
>> access generically. Note the id is org.qemu..., indicating its our
>> schema not gdbs.
> Thanks for teaching, I need time to digest. I guess more feature builder APIs
> are needed (like append_reg) and the getter/setter callbacks might be at a
> different place.
> 
> BTW, compared to adding virtual register `virt`, how do you think if we share
> the V bit as part of existing `priv` register?

IMHO this is a very good idea since the latest release candidate of 
riscv-debug-spec also includes the V bit in priv:2.

> Or maybe we shall talk to GDB community to get their opinions? If they agree to
> add a few words about V bit here
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV-Features.html,
> then it saves us a lot.

Except being currently not supported by GDB

(gdb) info register $priv
priv           0x5      prv:5 [INVALID]

are there any reasons from QEMU's side that would speak against 
including V in priv?



