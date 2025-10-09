Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B9FCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ugQ-0004wz-IZ; Thu, 09 Oct 2025 13:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ugP-0004wg-EM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:44:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ugM-0005rl-A6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:44:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso10035305e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031839; x=1760636639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4yJjwJiN4Wu8yEEngc5Fjvek4J1FNJRvT4aV2R9EfdI=;
 b=HA1woxmHB53ZxKLhWeL1UxEpIZe1AHMwu3krJTcuMa+KDeyoNFjGueo2fZUjzGiXHF
 F9ETAjn3KYDCVVs0V0V6MSJ67bZAHLSl5D/HxbGtWh9SgQSq2Cp8MScamoVU6eZouYDQ
 H9NHues/SM/FusJvHgzFxpiyowwzEepv4fMbNpJOuvwcxilUhP8KXTH0B9iQWWxrVzip
 RMxqY9eqMdhYTjljdew5Ad+W9bAK+0cXmNylDplj1FwOOido6KOd7Jr5T6NyR18tAhHr
 VRzE5pL6QM44Ubs0Bf39InlxUBe5YzmmaXFi7IYVYySOUVvdkXXev2lVLrKLyMQ8aHY1
 QudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031839; x=1760636639;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yJjwJiN4Wu8yEEngc5Fjvek4J1FNJRvT4aV2R9EfdI=;
 b=d/aq4jwKgmN8UyGNG3c6reMh6jXOAAcBTtciern54DBPXgQV9XrQq0FX25sTMBvfQn
 2JAUyR2D3kcmCbXryBC6WlGP6h7+Je7hRw0DebeQo4eo+raRCYo/AtyRB874DFDTlzFw
 zjIgdjw4qKH22HZapMUQrSF0TL2p/mZ/EFlTlx/xgZD129hWe7oJoxKShC2+djjff0kS
 dOOuvVnpfgba4Fq8boRGlNL6l5aLLJ6XKG9AEIFvpqeJgtds/o38xVkdOTYRewk8gREZ
 Dk2Fko3g55ebu0HghgxzxuqZmbwaA1Pi0Cp21T1ynae3gkir83WSVJFJti0Uf45vwBcc
 9ucA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbFRXmnPzTzo94Yei//V+SxlMad/Y3R2cJ97ZzofCViIIojck9yocrmZNiexgvv2X/5kyk7Qjr/aKp@nongnu.org
X-Gm-Message-State: AOJu0Yxa5UbFq/WMgHncxjVakmJQ+3YJsjs2BpRB0qXaaYHd7kqxZH6h
 08RwjeEICpYtMvf/Feq52MYSnMnMkbqc8j0TCJ9p+RDzxRl3JCeFPv+r2Ps2xoLJmcw=
X-Gm-Gg: ASbGnctNIsCTsr5/IJmnbvUeUzAAbXrkQHadMzdKUQFS6E6lJrgbOFr996kU5FNUw3A
 Ey8G4u9tUOdnPPKCfqgJihrnOde4m5YVdJvSF+S8K63aF1GhaKIxsjF8B2dY3ZgALGb99LbKNDN
 uvYJy57JnjnYxPTL3Qy1Rz75K8zmXnpXijIpCCIdtYpfguhswNtKwXpWO0bPJiBiwin+ue43G6R
 mWibIJMXAvnnVwlOK/SkJ2qrpy4giEFF18lF7umI/kDR8BTxhEwE5qag/fvgv0Kud0F0qvVNtd+
 LBlQA8Wbce9MJiFkBMma32AGfpuN+suE0Vwq7LVOeTJZ2wqODxF+RiZ/Ndi40vjC3A+G0lq8r40
 ljR6kSaL3mqz45Bqahz1NEAwnUnlwB00RxTPEaFJFysNTYiuHuG8FJLEJ5r1aDlZMmei8fKB5M4
 h5QQe5UW5rj9ZpNzhEAA==
X-Google-Smtp-Source: AGHT+IGLF0LmbCnKzKmW8KiT6uNNXXtj28jyyOCp1LRQrXqKeBMdRqhNAEVjJv6HwV+h4EvPYOQyFA==
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-46fa9b16570mr65762765e9.36.1760031838927; 
 Thu, 09 Oct 2025 10:43:58 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8309sm75196f8f.50.2025.10.09.10.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:43:58 -0700 (PDT)
Message-ID: <c75dc27a-5c56-4010-a205-a8296a9ab1e0@linaro.org>
Date: Thu, 9 Oct 2025 19:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
 <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
 <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
In-Reply-To: <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 9/10/25 19:23, Philippe Mathieu-Daudé wrote:
> On 21/8/25 22:27, Richard Henderson wrote:
>> On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
>>> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
>>> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
>>> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
>>> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
>>> is C_NotImplemented.
>>
>> Not true: ld2/st2 are also used for 128-bit load store.
>>
>> See: aarch64, x86_64, loongarch64, ppc64, s390x.
> 
> OK. Hmm I guess I need to add a __attribute__((unused)) check like
> you did in commit f408df587a0 ("tcg: Convert brcond2_i32 to
> TCGOutOpBrcond2") to outop_qemu_ld2/st2 then.

OK I figured my issue, I shouldn't remove the following in the
MIPS series [*]:

-- >8 --
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3f4aca25b13..c519dfbf7d5 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1311,2 +1311,34 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {

+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
+
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
+        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
+    } else {
+        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
+    }
+
+    if (ldst) {
+        ldst->type = type;
+        ldst->datalo_reg = datalo;
+        ldst->datahi_reg = datahi;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    /* Ensure that the mips32 code is compiled but discarded for mips64. */
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
+    .out =
+        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
+};
+
  static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
@@ -1390,2 +1422,34 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {

+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
+        tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
+    } else {
+        tcg_out_qemu_st_unalign(s, datalo, datahi, h.base, opc);
+    }
+
+    if (ldst) {
+        ldst->type = type;
+        ldst->datalo_reg = datalo;
+        ldst->datahi_reg = datahi;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    /* Ensure that the mips32 code is compiled but discarded for mips64. */
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 32 ? C_O0_I3(rz, rz, r) : C_NotImplemented,
+    .out =
+        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_st2 : NULL,
+};
+
  static void tcg_out_mb(TCGContext *s, unsigned a0)

---

Let's ignore this bogus patch then :)

[*] 
https://lore.kernel.org/qemu-devel/20250820142108.46639-1-philmd@linaro.org/

