Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2ABCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3TR-0003Lt-LL; Mon, 15 Jun 2026 05:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wZ3TO-0003Lb-HH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:19:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wZ3TL-000180-UI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:19:14 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxRemEwy9q5UgUAA--.46969S3;
 Mon, 15 Jun 2026 17:19:00 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAx28GBwy9qLPumAA--.53901S3;
 Mon, 15 Jun 2026 17:18:59 +0800 (CST)
Subject: Re: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>, bibo mao <maobibo@loongson.cn>
References: <20260615085214.44526-1-cui.tao@linux.dev>
From: gaosong <gaosong@loongson.cn>
Message-ID: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
Date: Mon, 15 Jun 2026 17:20:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAx28GBwy9qLPumAA--.53901S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZF4kAFy3WFyDXFykZF1DArc_yoW8Jry3p3
 y7ZF15Ka4rtr97C3Z3ta17WrZ8ZrWxGFsFva4Sk348ArsrWr1I9ryxKrn7XF1DA34rWryI
 gF1rAryY9F9rZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


在 2026/6/15 下午4:52, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
>
> Advertise the LoongArch paravirtual TLB flush feature (KVM_FEATURE_PV_TLB_FLUSH)
> to the guest when the host KVM supports it.  This pairs with the corresponding
> KVM/guest-kernel PV TLB flush series posted to the kernel.
>
> Patch 1 syncs the UAPI definitions into linux-headers.
Hi, you should use scripts/update-linux-headers.sh  to update the 
linux-headers.

Thanks.
Song Gao
> Patch 2 adds the probe, the CPUCFG feature advertisement, and a
> kvm-pv-tlb-flush CPU property (on/off/auto, default auto).
>
> The feature is only advertised when the host actually supports it, so a
> guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
> service PV TLB flush requests.
> Tao Cui (2):
>    linux-headers: Add LoongArch PV TLB flush definitions
>    target/loongarch: Enable PV TLB flush advertisement to the guest
>
>   linux-headers/asm-loongarch/kvm.h      |  1 +
>   linux-headers/asm-loongarch/kvm_para.h |  1 +
>   target/loongarch/cpu.h                 |  2 ++
>   target/loongarch/kvm/kvm.c             | 38 ++++++++++++++++++++++++++
>   target/loongarch/loongarch-qmp-cmds.c  |  4 +--
>   5 files changed, 44 insertions(+), 2 deletions(-)
>


