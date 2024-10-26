Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2382D10BFB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 20:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4n1K-0006hv-FE; Sat, 26 Oct 2024 16:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t4n12-0006bD-5r; Sat, 26 Oct 2024 16:04:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t4n10-0003E2-Ht; Sat, 26 Oct 2024 16:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ASTMuWfLPQPC6OGvLHWb2fl41TSnhSwrGjygq+Z/dI8=; b=QFX8WxlScOy4YE7e/1Uzel8E5j
 tieUTgzTPiNajwbiUkO9kB2wi/tseKqKhkFea/YDfGByGyM6+25u5Y1k6wgJ/74LQs6RQShrOAqLe
 4blSfaEhF7oV5NHmHzesvZXDwyQYQ/AVMhGwfoGcIZsgTuD+2l/FJpBT66eTMRfag40OPWbqB+7ql
 M2SqkGDtBBoN++LvFLpSrbtcdEjWrkLDs2cYP/SNAcZqIp6KdKrFQUoom/kU8MeZrdGWo87sW/X7M
 WCqxmlGEYJpOQ0kKZIjXC2DNpwDNYoH4BGOxun5YWl2xPT8Jzlp8hzmumMs3/BVmnjPtjWaR+KymH
 QWUNhAgPd55bZscg0VQXfZbe2Ka2B1yRotQU3UdoALfFjMc2gFb1Jx+WwXdlkgW8UBNAXVXQQrY/1
 gohSZGcXzTWrN51JAqgVtU3Kt8pQuHE/4WGOPtHoJVA8/XnZXi6HwL92euJ7JZhVhsRzt0SWiv5Lr
 i4NIIThNVuWvjxEfft1bzUnHMS/yxwQLt9w8C1uO5L8+wodRN3eT3HgpHBrYAzqq/YwEveQ5BH/mR
 +D5B46/Cs97/UPFB6/W71KvwYTFS2r7NJUxzUoZXPHgtydhjf4egzXqhuQOZ6hcESaypuW06LCHIL
 1/56XAeDz87g4ac2DlJ7zst+kH+Lzzi9uyA2mT5dE=;
Received: from [2a00:23c4:8bb8:f600:4f5e:5d86:d4a2:613d]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t4n0T-000ArA-2O; Sat, 26 Oct 2024 21:03:33 +0100
Message-ID: <ef7a7694-827b-4734-8132-c6ca1de23eea@ilande.co.uk>
Date: Sat, 26 Oct 2024 21:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-13-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20241025141254.2141506-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:4f5e:5d86:d4a2:613d
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 12/21] target/sparc: Explicitly set 2-NaN propagation rule
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 25/10/2024 15:12, Peter Maydell wrote:

> Set the NaN propagation rule explicitly in the float_status
> words we use.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c             |  8 ++++++++
>   target/sparc/fop_helper.c      | 10 ++++++++--
>   fpu/softfloat-specialize.c.inc |  6 ++----
>   3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index e7f4068a162..dd7af86de73 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -26,6 +26,7 @@
>   #include "hw/qdev-properties.h"
>   #include "qapi/visitor.h"
>   #include "tcg/tcg.h"
> +#include "fpu/softfloat.h"
>   
>   //#define DEBUG_FEATURES
>   
> @@ -807,6 +808,13 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
>       env->version |= env->def.nwindows - 1;
>   #endif
>   
> +    /*
> +     * Prefer SNaN over QNaN, order B then A. It's OK to do this in realize
> +     * rather than reset, because fp_status is after 'end_reset_fields' in
> +     * the CPU state struct so it won't get zeroed on reset.
> +     */
> +    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index b6692382b3b..6f9ccc008a0 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -497,7 +497,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
>        * Perform the comparison with a dummy fp environment.
>        */
>       float_status discard = { };
> -    FloatRelation r = float32_compare_quiet(src1, src2, &discard);
> +    FloatRelation r;
> +
> +    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
> +    r = float32_compare_quiet(src1, src2, &discard);
>   
>       switch (r) {
>       case float_relation_equal:
> @@ -518,7 +521,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
>   uint32_t helper_flcmpd(float64 src1, float64 src2)
>   {
>       float_status discard = { };
> -    FloatRelation r = float64_compare_quiet(src1, src2, &discard);
> +    FloatRelation r;
> +
> +    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
> +    r = float64_compare_quiet(src1, src2, &discard);
>   
>       switch (r) {
>       case float_relation_equal:
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index 226632a4d10..8bc95187178 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -404,11 +404,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
>       || defined(TARGET_RISCV) || defined(TARGET_SH4) \
>       || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
>       || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
> -    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K)
> +    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
> +    || defined(TARGET_SPARC)
>           g_assert_not_reached();
> -#elif defined(TARGET_SPARC)
> -        /* Prefer SNaN over QNaN, order B then A. */
> -        rule = float_2nan_prop_s_ba;
>   #elif defined(TARGET_XTENSA)
>           /*
>            * Xtensa has two NaN propagation modes.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


