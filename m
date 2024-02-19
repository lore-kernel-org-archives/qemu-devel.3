Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD8EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 02:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbtM7-0001st-T1; Sun, 18 Feb 2024 21:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rbtM5-0001sJ-DU
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 21:26:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rbtM2-0007ge-GD
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 21:26:05 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Axz+s0vNJlZjAOAA--.38136S3;
 Mon, 19 Feb 2024 10:25:56 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxM8wyvNJlMbk7AA--.1770S2; 
 Mon, 19 Feb 2024 10:25:55 +0800 (CST)
Subject: Re: [PATCH V2] loongarch: Change the UEFI loading mode to loongarch
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
References: <20240206021002.208805-1-lixianglai@loongson.cn>
 <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
 <CABJz62Pgp07EAgyTy1p5fGEZnTFA2byEn94_c+NQR5ELO3z7nw@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <6b3490b7-2e0e-2e95-b3e1-49e8c5f6d695@loongson.cn>
Date: Mon, 19 Feb 2024 10:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABJz62Pgp07EAgyTy1p5fGEZnTFA2byEn94_c+NQR5ELO3z7nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxM8wyvNJlMbk7AA--.1770S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4DCw43Gry5Jw48CFW5XFc_yoW5JFWDpF
 WrC3Wrur4DJrZrAr4a934Uu39av3s5KFy7XFnavryxCwnxtr18Xr1rKr18ZF9rAw1xJ3W0
 vrW8Kr98Way5ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU82g43UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.002,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Andrea:
> On Tue, Feb 06, 2024 at 05:38:35AM -0800, Andrea Bolognani wrote:
>> On Tue, Feb 06, 2024 at 10:10:02AM +0800, Xianglai Li wrote:
>>> The UEFI loading mode in loongarch is very different
>>> from that in other architectures:loongarch's UEFI code
>>> is in rom, while other architectures' UEFI code is in flash.
>>>
>>> loongarch UEFI can be loaded as follows:
>>> -machine virt,pflash=pflash0-format
>>> -bios ./QEMU_EFI.fd
>>>
>>> Other architectures load UEFI using the following methods:
>>> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>>>
>>> loongarch's UEFI loading method makes qemu and libvirt incompatible
>>> when using NVRAM, and the cost of loongarch's current loading method
>>> far outweighs the benefits, so we decided to use the same UEFI loading
>>> scheme as other architectures.
>>>
>>> Cc: Andrea Bolognani <abologna@redhat.com>
>>> Cc: maobibo@loongson.cn
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>> Cc: zhaotianrui@loongson.cn
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>>>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>>>   include/hw/loongarch/virt.h |  10 ++--
>>>   3 files changed, 107 insertions(+), 33 deletions(-)
>> For future reference, it's usually good practice to keep track of
>> changes between subsequent versions of the same patchset.
>>
>> Can you please confirm that the build of edk2 added with [1] is
>> intended to work with a version of QEMU that contains these changes?
>> I'd like to test things out as soon as I get a moment.
> I've tried it now with libvirt and everything worked just as I
> expected it to, so
>
>    Tested-by: Andrea Bolognani <abologna@redhat.com>
Thank you very much for your testing!
> Were changes to edk2 necessary to make it boot from pflash instead of
> rom? If so, have those patches already been posted?

Yes, edk2 also has the corresponding modification.

Before, I was worried that qemu community members had other opinions

that would lead to the modification of the scheme,

so I did not submit the modification of edk2 to the community to avoid 
unnecessary backoff.

However, I just submitted the patch to the edk2 community and cc you.

You can also get the edk2 patch from the link below:

https://github.com/loongson/edk2-platforms/commit/a85dbd29b03db714702836d52c14828a2f72b74f


Thanks!

Xianglai.

>


