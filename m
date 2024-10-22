Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DE6D3C935
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3DUD-0000Nw-DR; Tue, 22 Oct 2024 07:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3DUB-0000Na-83
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:55:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3DU8-0003Sv-Fb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:55:38 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxbeKtkhdnuh0FAA--.11738S3;
 Tue, 22 Oct 2024 19:55:26 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxreCskhdnQbEHAA--.45226S3;
 Tue, 22 Oct 2024 19:55:24 +0800 (CST)
Subject: Re: [PATCH v2 0/5] LoongArch/tcg: Add hardware page table walker
 support
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org
Cc: maobibo@loongson.cn
References: <20241010063536.2276871-1-gaosong@loongson.cn>
Message-ID: <8a789df9-542b-a0fd-be21-df5fc34ecec7@loongson.cn>
Date: Tue, 22 Oct 2024 19:56:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241010063536.2276871-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxreCskhdnQbEHAA--.45226S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrWxGrW8AryfJw4UXr1xXrc_yoWDGFg_XF
 yfJ34kur4DWa4DJa90va4rt3yrJF48KF1akFWDXr4UtF9rXryayF42gan3Zr1jvF1rXrn8
 Ar97Jrn3Ca4YvosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.475, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ping!

ÔÚ 2024/10/10 ÏÂÎç2:35, Song Gao Ð´µÀ:
> Loongson-3A6000 and newer processors have hardware page table walker
> (PTW) support. PTW can handle all fastpaths of PIL/PIS/PIF/PIE
> exceptions by hardware.
>
> V2:
> - Remove the '21' magic value, patch1;
> - Add a flag is_debug for debug access, patch5;
> - Use qatomic_cmpxchg to change the new pte_val, patch5.
>
> Song Gao (5):
>    target/loongarch: Add a new cpu_type la664
>    target/loongarch: Add do_lddir/ldpte()
>    target/loongarch: Add do_fill_tlb_entry()
>    target/loongarch: Add get_random_tlb_index()
>    target/loongarch/tcg: Add hardware page table walker support
>
>   target/loongarch/cpu-csr.h        |   3 +
>   target/loongarch/cpu.c            |  51 ++++--
>   target/loongarch/cpu.h            |   1 +
>   target/loongarch/cpu_helper.c     |  26 ++-
>   target/loongarch/internals.h      |   4 +-
>   target/loongarch/tcg/tlb_helper.c | 277 ++++++++++++++++++++++++------
>   6 files changed, 293 insertions(+), 69 deletions(-)
>


