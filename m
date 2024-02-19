Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55DFC48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 02:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbtCt-0007d0-DQ; Sun, 18 Feb 2024 21:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rbtCr-0007cp-1f
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 21:16:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rbtCm-0005rK-Nb
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 21:16:32 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxJ+jwudJlHzAOAA--.18255S3;
 Mon, 19 Feb 2024 10:16:17 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3xPtudJlK7g7AA--.1860S2; 
 Mon, 19 Feb 2024 10:16:14 +0800 (CST)
Subject: Re: [PATCH V2] loongarch: Change the UEFI loading mode to loongarch
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
References: <20240206021002.208805-1-lixianglai@loongson.cn>
 <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <4dd0752f-b5ba-2fbb-6c2f-40c8b638f414@loongson.cn>
Date: Mon, 19 Feb 2024 10:16:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx3xPtudJlK7g7AA--.1860S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trW3Ar4DJFyUGFWUuFW3Jwc_yoW8uF1Upr
 WSy3WY9r4DJrZxJwnxZayxW39Iyr93KF9xXF1Svry0k398J3W8Xr1rKr1kXF9rJw1xJF1j
 v3y0k3s8WFW5ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
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

I'm very sorry for the late reply.

I just had the Spring Festival holiday,

so I replied the email as soon as I saw it.


> On Tue, Feb 06, 2024 at 10:10:02AM +0800, Xianglai Li wrote:
>> The UEFI loading mode in loongarch is very different
>> from that in other architectures:loongarch's UEFI code
>> is in rom, while other architectures' UEFI code is in flash.
>>
>> loongarch UEFI can be loaded as follows:
>> -machine virt,pflash=pflash0-format
>> -bios ./QEMU_EFI.fd
>>
>> Other architectures load UEFI using the following methods:
>> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>>
>> loongarch's UEFI loading method makes qemu and libvirt incompatible
>> when using NVRAM, and the cost of loongarch's current loading method
>> far outweighs the benefits, so we decided to use the same UEFI loading
>> scheme as other architectures.
>>
>> Cc: Andrea Bolognani <abologna@redhat.com>
>> Cc: maobibo@loongson.cn
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: zhaotianrui@loongson.cn
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>>   include/hw/loongarch/virt.h |  10 ++--
>>   3 files changed, 107 insertions(+), 33 deletions(-)
> For future reference, it's usually good practice to keep track of
> changes between subsequent versions of the same patchset.

OK! Since there is only one patch, I did not add a cover letter.

I saw that you replied test-by later,

so I plan to resend patch V2 and bring the cover letter with change log 
and your test-by label.

>
> Can you please confirm that the build of edk2 added with [1] is
> intended to work with a version of QEMU that contains these changes?
> I'd like to test things out as soon as I get a moment.

Yes! [1] Works well with qemu with the current patch.

Thanks.

Xianglai.

>
> Thanks.
>
>
> [1] https://github.com/lixianglai/LoongarchVirtFirmware/commit/985ce19438d9544968c7e921c6acf2c74fd4713e


