Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F92AC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMo0S-0004Ed-8I; Thu, 27 Jun 2024 08:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sMo0J-0004ED-Tt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:13:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sMo0A-0006l5-6x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:13:31 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx7epaV31m_aQKAA--.43228S3;
 Thu, 27 Jun 2024 20:13:14 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcVXV31m9jgzAA--.44423S3; 
 Thu, 27 Jun 2024 20:13:13 +0800 (CST)
Subject: Re: [PATCH 0/2] hw/intc/loongson_ipi: Fix for LoongArch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, maobibo <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
 <acc08621-19c1-4ec3-9fc9-acb0eec79121@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0e42f372-26b8-b94a-80bb-6403062d2f1a@loongson.cn>
Date: Thu, 27 Jun 2024 20:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <acc08621-19c1-4ec3-9fc9-acb0eec79121@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxVcVXV31m9jgzAA--.44423S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4rZF4UGF48WrWktFW8uFX_yoW8WrWUpF
 nF9as3tr47GrW8Gw4kZF15GFyrtF47Jw47JF93u340gw4kJr10v3sF93sIg3ZrA3WvgF1j
 qFW7tw4vgF4UZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07jnSdgUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.174,
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



在 2024/6/27 下午2:38, Philippe Mathieu-Daudé 写道:
> On 27/6/24 06:13, Jiaxun Yang wrote:
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (2):
>>        hw/intc/loongson_ipi: Gate MMIO regions creation with property
>>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine
>
> Maybe s/has-mmio/use-mmio/? Otherwise series:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
Hi,

If we had done a simple test, we should have found the following 
problem, but obviously we didn't .

root@loongson-KVM:~/work/code/clean/github/qemu# . /kernel.sh
Unexpected error in object_property_find_err() at . /qom/object.c:1357.
qemu-system-loongarch64: Property 'loongson_ipi.unnamed-gpio-out[0]' not 
found
. /kernel.sh: line 16: 117708 Aborted (core dumped) . 
/build/qemu-system-loongarch64 -machine virt -m 8G -cpu la464 -smp 8 
-kernel ~/vmlinux -initrd ramdisk -serial stdio -monitor 
telnet:localhost. 4418,server,nowait -net nic -net user -device 
virtio-gpu-pci -device nec-usb-xhci,id=xhci,addr=0x1b -device 
usb-tablet,id=tablet,bus=xhci.0, port=1 -device 
usb-tablet,id=tablet,bus=xhci.0, -device usb-tablet,id=tablet,bus=xhci. 
port=1 -device usb-kbd,id=keyboard,bus=xhci.0,port=2 -append 
"root=/dev/ram rdinit=/sbin/init console=ttyS0,115200 
earlycon=uart,mmio. 0x1fe001e0" --nographic


So to minimize interactions with the MIPS architecture, I'll submit a 
patch to restore loongarch_ipi for LoongArch.

Thanks.
Song Gao


