Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155ACD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 23:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPTw0-000526-Lm; Tue, 19 May 2026 19:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPTvv-00051n-T9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:33:07 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPTvt-0001i2-51
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:33:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c82471904fcso1817551a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779233583; x=1779838383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mQvOhXfj4HsiAVnhMkSqlbU7ZS1M+piFYKOTzQlthzY=;
 b=SFeBotECjQlVUpTD5hC14flBZ1KX3MFlU5Qk1NZ1ZeC/qp37r+w8wYZPzsUo9gyQiM
 vW1vhuEqZolElN/eSGRJcPs/SUh8uNJoORyaMTHGTCPjIFSEx1Imr50TDuXWLBRobAlX
 z5spets3UBTz5x8MG9gppeJbFuVlt9J8mANaAnqAMiuZVkuBVj2pXNK6feCorKyMN9gL
 AsE9fR3kmANu2oGToKP7XSiOC0EJPhiXIRImq6BU6dDedv1HGlAdTBDgk0MB0vkhk7OD
 t8UGGW6GPYWQVNDW6j5X2D2qN4oyGpAIWbMt5e+WeOGrYr9x/bLlokVr0/X8sKAOo77L
 mrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233583; x=1779838383;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQvOhXfj4HsiAVnhMkSqlbU7ZS1M+piFYKOTzQlthzY=;
 b=aTpVUhJWUiv1k7sNwa/inxhJloSpbsax/213bPvWacdnepZ8Pn+Dp9JJf11HcSXxBN
 LCrvg/yG7lEP5UCXdQAogkL/lOkmqmydtK5MDcGPy4MaaM3PLOev0anAIJAzBVg4+2aP
 hsplKgIIxoPt31l/Nyre54RupfSlu6CsXNv6fzPTNiVza2OxIMFQj+qgZhk+7Bclg7tA
 BwxiLGWg8shs+mF7gwPmWRoFx7yN4npbe47UZ0QMXqi4q/UKgGsi5hWnXbjVWTjhIPk1
 0D84PnAlKDSfrRoRwpFKEmrdnbCsrBpGfBGxY3GvLyUsQVC0jXY3xHaNh16q09T/n40O
 B0LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Gb6oSKJWuSBc1NdD/uTvNUhIy5sRmv9DiNgt5BV+n2jsoSN1gVZskxTQKBvAJtvoy/s45MfL4Ucek@nongnu.org
X-Gm-Message-State: AOJu0YxopaqBl3Vx2fX7oz4ZvVr8D5qex+nxtBGNFXpmJN5uRcZXRAGN
 GVUFpBV+5FgPc/YKSY1dxOxjvg5qQEbthLaftXygYV277H6sj0uFcJ2RIeSPOlY5b7g=
X-Gm-Gg: Acq92OEWJ5701f5JU5PfA/c9ooFSYQi7u3/6FztsWM2jR+UlfO47YHpKJ4BjWsZ+7Zd
 DEYwHpdWF3bCx6WZeZAMyRYt3Gpv97ibG/E7bMBe20Y3nYQCJOGBWH5bfnZTLMtu6O8aAyaKpgb
 CTpC8E03vcnpUvWTMDzMSbfem/s8p2rY7YpCPUEXqB+GXqzc6Mbq8/mJbBdhDB4vYC7HOGYjpvh
 Iot2DQlilP72q0eyazY07V/PgcJXlLJZXHznF7+RNHIwdlfWsFw8JZ27JslcEN63x4BNl4QCllS
 vpUzw6uUWvTJ06tiR5gf407DuP9VY/02W2kMnflqdc8DOo2qvDH0GKLs8+aMUrqUMbpIOnWwsMA
 IQ6c2VAMdTFok529Ed5fWAAyzM8v8rp+booKL0sCf4YYgntiM+wd1BHHvPDNdZBDJdTWhj0Dhna
 Y+YQ14wxsmfhJMqvFu1+y52T69q3sKc7/4g3Bh
X-Received: by 2002:a17:903:1a26:b0:2ba:5f24:cae2 with SMTP id
 d9443c01a7336-2bd7e9dc136mr227506005ad.35.1779233582987; 
 Tue, 19 May 2026 16:33:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe47c8sm199452535ad.51.2026.05.19.16.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 16:33:02 -0700 (PDT)
Message-ID: <95576e03-146b-456d-bad2-139158da7657@linaro.org>
Date: Tue, 19 May 2026 16:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/40] target/mips: add Octeon COP2 crypto state
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-24-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-24-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/19/26 09:22, James Hilliard wrote:
> +typedef struct MIPSOcteonCryptoState {
> +    uint64_t des3_key[3];
> +    uint64_t des3_iv;
> +    uint64_t des3_result;
> +    uint64_t hsh_iv[4];
> +    uint64_t hsh_dat[8];
> +    uint64_t hsh_ivw[8];
> +    uint64_t hsh_datw[16];
> +    uint64_t aes_iv[2];
> +    uint64_t aes_key[4];
> +    uint64_t aes_result[2];
> +    uint64_t aes_input[2];
> +    uint64_t gfm_mul[2];
> +    uint64_t gfm_resinp[2];
> +    uint64_t gfm_xor0;
> +    uint64_t gfm_reflect_mul[2];
> +    uint64_t gfm_reflect_resinp[2];
> +    uint64_t gfm_reflect_xor0;
> +    uint16_t gfm_poly;
> +    uint8_t aes_keylen;
> +    uint32_t shared_mode;
> +    uint32_t crc_poly;
> +    uint32_t crc_iv;
> +    uint32_t crc_len;
> +    uint32_t snow3g_fsm[3];
> +    uint32_t snow3g_lfsr[16];
> +    uint64_t snow3g_result;
> +} MIPSOcteonCryptoState;

It might be easier if these were sorted to match Table 2-2.

Why do you use uint32_t crc_len for CRCLEN<3:0>?

There is no gfm_xor0 or gfm_reflect_xor0 in table 2-2.
I suspect your implementations of CVM_MT_GFM_XOR0 and CVM_MT_GFM_XOR0_REFLECT are wrong.

hsh_dat[8] is mis-sized? Compared to HASHDAT[15:0]<63:0>.

hsh_datw[8] is not a thing; As I read CVM_MF_HSH_DAT and CVM_MF_HSH_DATW, they are 
different ways of accessing the same data.

hsh_iv[4] is mis-sized; there is no hsh_ivw[].  Similar error wrt DAT?

aes_result/aes_input should be one AESRESINP.  You should not invent non-architectural cpu 
state.  Elsewhere you mention latch/result, but that would be an implementation detail of 
individual operations.  That said, I don't see any use of aes_input / aes_result that 
actually overlap.  You copy aes_input to a local variable in[], and write to aes_result 
from a local variable out[].  You've already implemented the latch.

Why shared_mode?  I don't see anything like it in the docs.  From later patches which add 
zuc_lfsr[] and snow3g_lfsr[], I think this is incorrect.  The docs explicitly say that 
those modes overlap HASHDAT[].  You should simply re-use that data.


r~

