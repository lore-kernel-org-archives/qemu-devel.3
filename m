Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB42C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 04:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1eeL-0003SL-Mi; Mon, 29 Apr 2024 23:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1eeJ-0003S7-J3
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 23:59:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1eeE-00011t-8h
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 23:59:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxfeuObDBmakIFAA--.13472S3;
 Tue, 30 Apr 2024 11:59:11 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxX1WLbDBmu80KAA--.9062S3; 
 Tue, 30 Apr 2024 11:59:10 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Refine default numa id calculation
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240319022606.2994565-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5ac8e771-4011-cddd-031b-910e78e278d3@loongson.cn>
Date: Tue, 30 Apr 2024 11:59:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240319022606.2994565-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxX1WLbDBmu80KAA--.9062S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr17tw45XFWUXFW8AF15KFX_yoW8WF4fpr
 W7CFykZr4j9rn7Gws29FyDWrn3Arn7Jws2g347KayF9a98WryrJr4Fywn0yrWUWrW8XFW8
 ZF18Gr45ZFyIvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.127, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2024/3/19 ÉÏÎç10:26, Bibo Mao Ð´µÀ:
> With numa_test test case, there is subcase named test_def_cpu_split(),
> there are 8 sockets and 2 numa nodes. Here is command line:
> "-machine smp.cpus=8,smp.sockets=8 -numa node,memdev=ram -numa node"
>
> The required result is:
>    node 0 cpus: 0 2 4 6
>    node 1 cpus: 1 3 5 7
> Test case numa_test fails on LoongArch, since the actual result is:
>    node 0 cpus: 0 1 2 3
>    node 1 cpus: 4 5 6 7
>
> It will be better if all the cpus in one socket share the same numa
> node. Here socket id is used to calculate numa id in function
> virt_get_default_cpu_node_id().
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index deb3750d81..29885f6777 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1219,15 +1219,14 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>   
>   static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>   {
> -    int64_t nidx = 0;
> +    int64_t socket_id;
>   
>       if (ms->numa_state->num_nodes) {
> -        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
> -        if (ms->numa_state->num_nodes <= nidx) {
> -            nidx = ms->numa_state->num_nodes - 1;
> -        }
> +        socket_id = ms->possible_cpus->cpus[idx].props.socket_id;
> +        return socket_id % ms->numa_state->num_nodes;
> +    } else {
> +        return 0;
>       }
> -    return nidx;
>   }
>   
>   static void loongarch_class_init(ObjectClass *oc, void *data)


