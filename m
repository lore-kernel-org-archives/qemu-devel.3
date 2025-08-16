Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D405CA0EE6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 06:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unAej-00066F-L0; Sat, 16 Aug 2025 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unAeg-00065s-2h
 for qemu-devel@nongnu.org; Sat, 16 Aug 2025 02:44:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unAed-0003Gy-C4
 for qemu-devel@nongnu.org; Sat, 16 Aug 2025 02:44:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32326e5f0bfso2368574a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755326677; x=1755931477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfGtQ1L0EefLietGxhEZt9h0xh64WJEIgBtGOyRCjeE=;
 b=eUYUVNx6Vy3r0xfMR6URV6KI+AlS0qasI/QXPneBcs/8fXrKsJyASBMTtBh9Ov7ONm
 e3UBSvrdbeV4HYq08Qtu4sYxaPYYOeiPGQZsQwBS4OCwckQs6gYj3lnG4NsHThw8Gcgi
 EsBP4y90zoCVQDSuhP0gwIfOeCITAw/r1yS6zfupkDeVAqIclce+eizKGl+ztU0nBFpf
 fXU5FCVd/lGqqpjVAEPdffLzSPQTtFSeTLAuRSe/Pj+OoOkk6jt80XImjw2X8R2FfvpN
 5aFDvmWXIv1dbPXSGwNI4+CoUuebxrqeoKlZzqJF6YAR1VEnBOT3/d+zTJSeUlVaoBg9
 QRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755326677; x=1755931477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LfGtQ1L0EefLietGxhEZt9h0xh64WJEIgBtGOyRCjeE=;
 b=Bkn2WaXpbBAt6olneIyvkRIUY8OsXlJVnHVoO241ITuSY5VDa8g7WMqeK04zuK/Jtn
 Gcq2BWtc3U0K4/GUHDLV/EoEbTg2XWZIXW/+ohhecadpPpY0nRfmgbyegwvzoiZUPhwZ
 k/5hno5kvi+QE/KAU9+oXd8it5rZu3qJjthtzi32oABkeK++MlIwi01xl+T60W7J00aX
 V1ChNtHqa3bj9mWW4N78pNM2wwWcfRB29u47i4beDO14RX7XLHv4XEnY/mIP44QPKJvf
 29HDczSoR1kRc0IsA9JgC5d6XABU7b8pCz2qdatRDRJ9Eyg2pVnYyhXIsOzaQHC1TeKG
 cXZg==
X-Gm-Message-State: AOJu0YxJ/PreJcISZwapzyjqG9+VJq4Ogxbx14BPxEVlfDTKTd511VuX
 /pCl4MCRvfE+hecgynDULsPOi1HBYBhUJGZZGBTv5R66Y7y9ih1euI2zAVuVeaQ0jQRizXzR7GO
 EVZHLVLE=
X-Gm-Gg: ASbGncuPmWWJt/fDeLfD+IonmooW/r20DDA/uD3KhfIU/st1QRB62ypIbynqoZ9UgqC
 Mle4ZEkVs5mKh5Y91GFksmIS5rRbHpTcuXDSJchrIQgU0NFvVuOGyPJgHeBEZWfN9u1185a1wr2
 0Ugk+dT7DuJCdYjwEREZj/sQE1aLFfkxYOlL9wKTniKtzkTdXkz4veufKcFRiKv3/CwCu/UyVfH
 VB26rN2whBgVPHkGUY9r7Rc+RvFjCwA5iYlP7QUBkT8CPFOt5uHPe0DlWWZ99QF6lqjuUmzDQHR
 llfaxicO0F3yYZ6MY/LtQ/pP4CqSbUKsO2ENj8psj8zk8L+FzDkuj9ZK1tCFFYqLr9wWTjxhaJU
 Gn2RNFoW6w6+TpHdXfD6idzO5L+XZ+Z9dBFWiHq0=
X-Google-Smtp-Source: AGHT+IG0kS9yUn75FS5Uzq6oNRtzUCVilp0ZLloHdv7UmwkbHAnUOmIQvza+RN5Y8K2YeKAn+bvogw==
X-Received: by 2002:a17:90b:2c87:b0:31e:c95a:cef8 with SMTP id
 98e67ed59e1d1-32342182155mr5857187a91.32.1755326676832; 
 Fri, 15 Aug 2025 23:44:36 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.122.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32331124b2fsm5741913a91.16.2025.08.15.23.44.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Aug 2025 23:44:36 -0700 (PDT)
Message-ID: <e2818552-1752-45f9-ae5a-da0879a065b2@linaro.org>
Date: Sat, 16 Aug 2025 16:44:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: fix vector register address
 calculation in strided LD/ST
To: qemu-devel@nongnu.org
References: <cover.1755287531.git.chao.liu@yeah.net>
 <ee461421503da741d4cf6d2486b8596862fc0b7f.1755287531.git.chao.liu@yeah.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ee461421503da741d4cf6d2486b8596862fc0b7f.1755287531.git.chao.liu@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/16/25 10:29, Chao Liu wrote:
> This patch fixes a critical bug in the RISC-V vector instruction
> translation that caused incorrect data handling in strided load
> operations (e.g., vlsseg8e32).
> 
> Problem Description:
> 
> The `get_log2` function in `trans_rvv.c.inc` returned a value 1 higher
> than the actual log2 value. For example, get_log2(4) incorrectly
> returned 3 instead of 2.
> 
> This led to erroneous vector register offset calculations, resulting in
> data overlap where bytes 32-47 were incorrectly copied to positions
> 16-31 in ChaCha20 encryption code.
> 
> rvv_test_func:
>      vsetivli    zero, 1, e32, m1, ta, ma
>      li          t0, 64
> 
>      vlsseg8e32.v v0, (a0), t0
>      addi        a0, a0, 32
>      vlsseg8e32.v v8, (a0), t0
> 
>      vssseg8e32.v v0, (a1), t0
>      addi        a1, a1, 32
>      vssseg8e32.v v8, (a1), t0
>      ret
> 
> Analysis:
> 
> The original implementation counted the number of right shifts until
> zero, including the final shift that reduced the value to zero:
> 
> static inline uint32_t get_log2(uint32_t a)
> {
>      uint32_t i = 0;
>      for (; a > 0;) {
>          a >>= 1;
>          i++;
>      }
>      return i; // Returns 3 for a=4 (0b100 → 0b10 → 0b1 → 0b0)
> }
> 
> Fix:
> 
> The corrected function stops shifting when only the highest bit remains
> and handles the special case of a=0:
> 
> static inline uint32_t get_log2(uint32_t a)
> {
>      uint32_t i = 0;
>      if (a == 0) {
>          return i; // Handle edge case
>      }
>      for (; a > 1; a >>= 1) {
>          i++;
>      }
>      return i; // Now returns 2 for a=4
> }
> 
> Fixes: 28c12c1f2f ("Generate strided vector loads/stores with tcg nodes.")
> 
> Signed-off-by: Chao Liu <chao.liu@yeah.net>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2b6077ac06..f50b62b1d8 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -877,7 +877,10 @@ static inline uint32_t MAXSZ(DisasContext *s)
>   static inline uint32_t get_log2(uint32_t a)
>   {
>       uint32_t i = 0;
> -    for (; a > 0;) {
> +    if (a == 0) {
> +        return i;
> +    }
> +    for (; a > 1;) {
>           a >>= 1;
>           i++;
>       }

I suggest

     assert(is_power_of_2(a));
     return ctz32(a);

I was surprised we don't have such a function in qemu/host-utils.h already.


r~


