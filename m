Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A296EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsap-0000Br-P3; Tue, 10 Sep 2024 00:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snsan-00008X-GY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:35:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snsal-0000zU-Ln
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:35:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-205909afad3so3907855ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725942901; x=1726547701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7j8mTjVAdrT7FRJ9qOJgnW8QO87/xHhosP8psy+p/w=;
 b=Tz4b7iCGj6xGcSWrCNeVF8XQFvvUsKvTs11/21FV3HbQqM6wpzTKx0J27bCTh+jRUD
 50kQcEeHbpwHgCowYNPa0BlqPoF6m+l52Y5+7FxDNoOmjysmjGfwHIv65ECK3gAESFpP
 HEnRhWDshEDJxCh4aCKH9L+jGg8jc5DzakfxaO7mjPbsPUQTNNYwCX1bCC7X/7rwdloB
 U8vQu2+3+800YpZHPnDeCiNTEj1GB/5efBmwsA/cDipmbZw//4/B6UpvLS6bBYff38Bh
 jEjbPORSRLRmU+iLgprdqvq+hqnsyIlQspACkN07JZiyS7dDPh+hwfQEjgFf1tU6cQcp
 QJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725942901; x=1726547701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7j8mTjVAdrT7FRJ9qOJgnW8QO87/xHhosP8psy+p/w=;
 b=gmE6axKD3ePLNVhTRxIXfSwK0IqzyCv6L3ZinI3rGuK5+dhPT1qKChiLORAXMuM8/t
 HR5HIf4mL9t5J1wbMU41IvHjYq2Lsj3KDfZc3OSE1hs5GzuuvW0V4xXPlnbMpcDgSawi
 kPuhFC20G19wFR/ZsNCYXjZJjV/N44g/PJDwQ74e/cf95WG3Vj9V5MvG4PjsBH3IOeFb
 nuHspJRktzI7qcaO9L5AV04VYV7QdLXGsAn5fMlAgRZOFEk62hlKZiAdlvLsO5H97rZK
 YCT3NsfqRWrJeb6Nbz1plSMLiMqwCaoZekweSK927jdaztALqC6IOzVWVsPfy/DVj9+8
 Wm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQJzFFXp1asVmLLNiS/r8dv2LVttLaDd4oBJ9vl7xL9JxjLrCZ00fC3wcaUxEsHVR6DIH5DdCy568i@nongnu.org
X-Gm-Message-State: AOJu0Yypu/sySGa7uecxA6jO6oUDHg8ZWoK1ny7CxWtGMG5vDjykyXqn
 qRwYrzOgiZMYZOK19ghpnq1MuJbpZ1+FKCJ1aH2NoDLSPsoAVuzBvO/1nBMpD44=
X-Google-Smtp-Source: AGHT+IEy8RReu8QtZn4eTVpJhSB1Wr7W8071oH8Aikc7HCixvmOijZ7KlYHs5AUBEBidPOdEdGh2Nw==
X-Received: by 2002:a17:903:230f:b0:205:9112:efea with SMTP id
 d9443c01a7336-2070a578bdemr99174005ad.35.1725942901114; 
 Mon, 09 Sep 2024 21:35:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f31235sm40884665ad.253.2024.09.09.21.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 21:35:00 -0700 (PDT)
Message-ID: <04500d38-0869-4e02-8281-d1f577fcb000@linaro.org>
Date: Mon, 9 Sep 2024 21:34:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] tcg/riscv: Add riscv vset{i}vli support
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-5-zhiwei_liu@linux.alibaba.com>
 <efa2bcd4-3ed6-4943-8dee-f764ee5afe87@linaro.org>
 <ca6c39e0-0b29-4dff-9e89-93db342ae9af@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ca6c39e0-0b29-4dff-9e89-93db342ae9af@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 9/9/24 19:46, LIU Zhiwei wrote:
>>     lmul = type - riscv_lg2_vlenb;
>>     if (lmul < -3) {
>>         /* Host VLEN >= 1024 bits. */
>>         vlmul = VLMUL_M1;
> I am not sure if we should use VLMUL_MF8,

Perhaps.  See below.

>>     } else if (lmul < 3) {
>>         /* 1/8 ... 1 ... 8 */
>>         vlmul = lmul & 7;
>>         lmul_eq_avl = true;
>>     } else {
>>         /* Guaranteed by Zve64x. */
>>         g_assert_not_reached();
>>     }
>>
>>     avl = tcg_type_size(type) >> vsew;
>>     vtype = encode_vtype(true, true, vsew, vlmul);
>>
>>     if (avl < 32) {
>>         insn = encode_i(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
> Which may benifit here? we usually use  lmul as smallest as we can for macro ops split.

lmul is unchanged, just explicitly setting AVL as well.
The "benefit" is that AVL is visible in the disassembly,
and that we are able to discard the result.

There doesn't appear to be a down side.  Is there one?

>>     } else if (lmul_eq_avl) {
>>         /* rd != 0 and rs1 == 0 uses vlmax */
>>         insn = encode_i(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);

As opposed to here, where we must clobber a register.
It is a scratch reg, sure, and probably affects nothing
in any microarch which does register renaming.

>>     } else {
>>         tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
>>         insn = encode_i(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
> And perhaps here.

Here, lmul does *not* equal avl, and so we must set it, and because of non-use of VSETIVLI 
we also know that it does not fit in uimm5.

But here's a follow-up question regarding current micro-architectures:

   How much benefit is there from adjusting LMUL < 1, or AVL < VLMAX?

For instance, on other hosts with 128-bit vectors, we also promise support for 64-bit 
registers, just so we can support guests which have 64-bit vector operations.  In existing 
hosts (x86, ppc, s390x, loongarch) we accept that the host instruction will operate on all 
128-bits; we simply ignore half of any result.

Thus the question becomes: can we minimize the number of vset* instructions by bounding 
minimal lmul to 1 (or whatever) and always leaving avl as the full register?  If so, the 
only vset* changes are for SEW changes, or for load/store that are smaller than V*1REG64.


r~

