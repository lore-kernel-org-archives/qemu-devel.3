Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492B5CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9q-0000k7-U4; Wed, 07 Oct 2026 04:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEI4t-0001GS-DK; Tue, 06 Oct 2026 23:12:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEI4T-0000Ig-HD; Tue, 06 Oct 2026 23:12:21 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69738nvq088535
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 12:08:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7OiV2XTbdLHwTCpnJ3Ni/aaSq0QDzDpbyoVquXUDln0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791342530; v=1;
 b=VYs/wTUTOVHxdHAHlw7b8slm6R2QyB36NF8/i9h/0U3ajfcN1vAUVKaZwnoCbRR+
 yCoQV2b4GDCW04I7xT1JGryGZ4HC3MJTNDYNdChkEod/BEcvQVsMKdDnKEU5DpwL
 v3GkErAQIu+arrkQ7NJu52dpz3VgaaO0/3+iQKy314r32lA90BIKW4cCy8QT5jrW
 pw29D+nFmcSb67gnpY/t6bIu/WyV+zZb04vw5V32hZGmmrBT2hkVa311zMBbhdrx
 iMa9inlS1pVnqdJn7J7W9uUIct+YO916Tx7GxB/rXvczgrgBkxd+RVivle3IN6/I
 v1/Ui4fnvFVx0VByMujQhw==
Message-ID: <ef0df981-37ba-41e9-91f6-feee5a829671@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Oct 2026 12:08:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] monitor/hmp: replace MonitorDef with GDB registers
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <1b9d9cef-8f65-4e96-9e7b-fd136f64a75d@oss.qualcomm.com>
 <33ad7803-82ad-49f0-b39d-d3a23807ab75@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+0A4_VU3aNk=fWwvR=MPbe3Zw2zyeFnyCGmJET6fAoKg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+0A4_VU3aNk=fWwvR=MPbe3Zw2zyeFnyCGmJET6fAoKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2026/10/06 23:31, Marc-André Lureau wrote:
> Hi Akihiko
> 
> On Thu, Oct 1, 2026 at 12:03 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/10/01 2:18, Philippe Mathieu-Daudé wrote:
>>> Cc'ing Akihiko who worked on gdbstub.
>>>
>>> On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
>>>> Hi,
>>>>
>>>> HMP monitor supports printing $register expression. The lookup
>>>> was done via GDB stub registers, and supplementary MonitorDef
>>>> HMP-specific tables.
>>>>
>>>> Migrate HMP registers to use the GDB infrastructure and remove the
>>>> legacy HMP MonitorDef. Use a "qemu-debug" register group, as they are
>>>> aliases or synthetic registers, but gdb doesn't seem to care.
>>
>> Unfortunately, these aliases and synthetic registers appear to have
>> several problems:
>>
>> - GDB already provides writable pseudo-registers for SPARC64's asi and
>>     pstate. The new QEMU registers shadow them but ignore writes, breaking
>>     previously supported functionality. See:
>>
>> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/sparc64-tdep.c;h=93db3417a2a9f64790acab33288eb05764112e0b;hb=6a5e5259790e5a854ddbb69eb486b9245fcfeee8#l976
>>
>> - GDB caches each raw register independently. Updating one alias can
>>     leave another stale, causing incorrect reads or skipped writes.
>>
>> - The new raw aliases do not inherit the original registers' unwind
>>     rules, leading to incorrect register values when selecting older
>>     call frames.
>>
>> The latter two issues also affect the RISC-V aliases and cannot be
>> resolved merely by changing QEMU's register read/write callbacks. I
>> therefore think we need to retain HMP-specific handling for these aliases.
> 
> Thanks for the feedback and findings! Would it be an option to have
> qemu/pseudo registers use a prefixed name like "qemu.", then it
> shouldn't conflict with GDB. HMP would need to try with it if not
> found. Wdyt?

That would avoid the conflict, but "info registers" in GDB would then 
list these extra registers. This makes the output noisier, and the 
displayed values could still be misleading or inaccurate.

> 
> Alternatively, keep the monitor specific register lookup, as a secondary path.

Ultimately, the design trade-off comes down to:

- The actual impact of exposing pseudo-registers via gdbstub.
- The relative complexity of implementing pseudo-registers versus
   keeping a monitor-specific lookup as a fallback.

While the issues with pseudo-registers aren't critical, intuitively, 
keeping the monitor-specific lookup as a fallback seems like it wouldn't 
add much complexity, and might even be simpler. If so, I think keeping 
the monitor-specific lookup is the better approach. Otherwise, we may 
need to give this further consideration.

Regards,
Akihiko Odaki

