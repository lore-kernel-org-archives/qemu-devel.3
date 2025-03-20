Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D4BC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCLS-00081R-Bp; Thu, 20 Mar 2025 05:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tvCLI-00080v-QQ; Thu, 20 Mar 2025 05:37:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1tvCLB-00005L-Ta; Thu, 20 Mar 2025 05:37:33 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxqmrN4dtnK0meAA--.5974S3;
 Thu, 20 Mar 2025 17:37:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxHcXF4dtnbntVAA--.49975S3;
 Thu, 20 Mar 2025 17:37:11 +0800 (CST)
Subject: Re: [PATCH] host/include/loongarch64: Fix inline assembly
 compatibility with Clang
To: Yao Zi <ziyao@disroot.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 bibo mao <maobibo@loongson.cn>
References: <20250314033150.53268-3-ziyao@disroot.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c8679bcb-4978-5ae8-c3a8-161e4b51c19f@loongson.cn>
Date: Thu, 20 Mar 2025 17:39:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250314033150.53268-3-ziyao@disroot.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxHcXF4dtnbntVAA--.49975S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr48Zw48Jw1xZr4kAF4kZrc_yoW5uFyrpF
 9Ikw4kKr4xW3ySvFyUAw17tr13Xw129F1jgrW5Cw18CFy293WUXFsFkas29F1jqws29r12
 gF48Ka1rWa92qrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.598, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/3/14 ÉÏÎç11:31, Yao Zi Ð´µÀ:
> Clang on LoongArch only accepts fp register names in the dollar-prefixed
> form, while GCC allows omitting the dollar. Change registers in ASM
> clobbers to the dollar-prefixed form to make user emulators buildable
> with Clang on loongarch64. No functional change invovled.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   host/include/loongarch64/host/atomic128-ldst.h.inc        | 4 ++--
>   host/include/loongarch64/host/bufferiszero.c.inc          | 6 ++++--
>   host/include/loongarch64/host/load-extract-al16-al8.h.inc | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
Cc: qemu-stable@nongnu.org

resolves: https://gitlab.com/qemu-project/qemu/-/issues/2871
> diff --git a/host/include/loongarch64/host/atomic128-ldst.h.inc b/host/include/loongarch64/host/atomic128-ldst.h.inc
> index 9a4a8f8b9e..754d2143f0 100644
> --- a/host/include/loongarch64/host/atomic128-ldst.h.inc
> +++ b/host/include/loongarch64/host/atomic128-ldst.h.inc
> @@ -28,7 +28,7 @@ static inline Int128 atomic16_read_ro(const Int128 *ptr)
>       asm("vld $vr0, %2, 0\n\t"
>           "vpickve2gr.d %0, $vr0, 0\n\t"
>           "vpickve2gr.d %1, $vr0, 1"
> -	: "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "f0");
> +        : "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "$f0");
>   
>       return int128_make128(l, h);
>   }
> @@ -46,7 +46,7 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
>       asm("vinsgr2vr.d $vr0, %1, 0\n\t"
>           "vinsgr2vr.d $vr0, %2, 1\n\t"
>           "vst $vr0, %3, 0"
> -	: "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "f0");
> +        : "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "$f0");
>   }
>   
>   #endif /* LOONGARCH_ATOMIC128_LDST_H */
> diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
> index 69891eac80..bb2598fdc3 100644
> --- a/host/include/loongarch64/host/bufferiszero.c.inc
> +++ b/host/include/loongarch64/host/bufferiszero.c.inc
> @@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
>       "2:"
>           : "=&r"(ret), "+r"(p)
>           : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>   
>       return ret;
>   }
> @@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
>       "3:"
>           : "=&r"(ret), "+r"(p)
>           : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>   
>       return ret;
>   }
> diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h.inc b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> index d1fb59d8af..9528521e7d 100644
> --- a/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> +++ b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> @@ -31,7 +31,7 @@ static inline uint64_t load_atom_extract_al16_or_al8(void *pv, int s)
>       asm("vld $vr0, %2, 0\n\t"
>           "vpickve2gr.d %0, $vr0, 0\n\t"
>           "vpickve2gr.d %1, $vr0, 1"
> -	: "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "f0");
> +        : "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "$f0");
>   
>       return (l >> shr) | (h << (-shr & 63));
>   }


