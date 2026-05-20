Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFBDCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPk9f-0001sD-L7; Wed, 20 May 2026 12:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPk9e-0001rq-A8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:52:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPk9c-0001eC-CA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:52:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bd2051167eso23164085ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779295938; x=1779900738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCfflCEAKYnOHzLzXNrSn89zkvirFIpthaeGBPkaGFw=;
 b=cjfkChfksOPm1Co3tlakDBHmzVos2fU0TccloLsYmDfKJ2JIsa45j379RwNPT3p/m6
 37c2As0s3yZv3xDF0rjGDghZSwgZTSKOY+xvTpRtRH31047My8lFco4eebsqCmCEh8me
 PG/A9UHmh1bsAkd4zZkdWdT/RRBnjMy9FfAZs9/L/vArnAFzvQEF7wzidOIOfR8kom9v
 G+bJIcQOoOXXM2N4bFh/LavFpcu1JZUdMbxzu6Ldm5EKD0xsZ/sD7/rUp0mPblzVI+Pk
 DWHLWE4VnSogPmLlJB+yHBhDsLn+LNFWLET8BsHSdFYy0z3+9yU2eV5io5GoBtPAPvOW
 9cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779295938; x=1779900738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCfflCEAKYnOHzLzXNrSn89zkvirFIpthaeGBPkaGFw=;
 b=RFduDgN8XyN85gKRdk5FwgbLRHPX/jQ57QP03v7/qKq0duzHN7zlka7kxrm3muuofD
 9sdtJTYbTOAzJnI9gZ9+zylHTmJmq1K9Nz62oM8SpHZzFb428qotOCH+qdWebM7lCn1u
 aXUmTe7kIzvFeKef7dqRHqRSz/5l8p9nev1X1hi5khaxzfldHO5MPdoZKVBu0X4NTGqX
 VC/oirSCv2LPir44MfzgikJjVq0s7gUFDCasSN6pTD9rkoRBXqTXaInAaFeLy4OXEqMR
 MlHEDxkOAtzZ3OUK82/q7vjh+u5OJSB0OlWpN/s+/EkQL5GN8DwlCsbecVNBr1z0CJ7+
 xygA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+S5KgRuykAHFv6gX4h3//VDA/HcVGE1e8yTHNZSMcHrlGXrPwen3rj0Ft0MzCIk8bNk3WMI7N7lsoj@nongnu.org
X-Gm-Message-State: AOJu0Yx3sJvC/9QIPVZzUlxE73VmzQnEfNgRxduIvTGeQp053e5Ni1B3
 LXtK2H/4fX5rnuxY4qvjQgd1ZVnQwtFIvMBosDdDdrIYQB0vAnzebD++dSWlf1k2eFA=
X-Gm-Gg: Acq92OHxpZE/L1bmKK2B5Nh1kTuQ/Cvegoh/IBcHLYkG3fdrqd4YnK8YOVF3BDLYY5O
 rVwSL2e1yPLGo/8FhSudN9H8p3WPP1wnzlkn6INpaaeoc/0KUdss+QwghBGlTnFUrvIlwG3d067
 IFW9AY2MLpKLkSpFZWDGFrcoJqTcbc6skKiLAHzGpaU68cKtYCcZ6MMvuYkHtKbMtkPQUAlhAqO
 VjKcbUF2Ulsb3EP1iLy9+87PfoGUVWkR5Pb21fzcNdNY6E6QZQhIlPYu94EbbFT6lxxJwddxKHJ
 jZCrHMTvIoXNyGO8gSYxc5+8qoPDFW5ymeRHEp9Q8KsZZexepmrJCcS5iSXZP5fSOXow/3734+t
 a6XG2cDCujpINIoY6hS5K6OS6GtL6moJhw+A3eNKHUfOHjqRWiJyXk8EmaXz984/CjtTE8u4OFR
 oWUfvByI0GZDf/rTJegYAzSYpITK9RGLtqr1zbA6umKlGnGY8=
X-Received: by 2002:a17:903:182:b0:2b9:cd2d:6f11 with SMTP id
 d9443c01a7336-2bd7e8bd35amr259824865ad.18.1779295938052; 
 Wed, 20 May 2026 09:52:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4973sm230033115ad.41.2026.05.20.09.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:52:17 -0700 (PDT)
Message-ID: <946592fa-d9d3-4054-8153-332ef8efe505@linaro.org>
Date: Wed, 20 May 2026 09:52:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 37/40] target/mips: decode Octeon COP2 selectors
 explicitly
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-37-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-37-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
> +CP2_MF_I64(CVM_MF_GFM_MUL_REFLECT0, gfm_reflect_mul[0]);
> +CP2_MF_I64(CVM_MF_GFM_MUL_REFLECT1, gfm_reflect_mul[1]);

These perform rt = reflect(GFMMUL[i]), not read from separate storage.

> +CP2_MF_I64(CVM_MF_GFM_RESINP_REFLECT0, gfm_reflect_resinp[0]);
> +CP2_MF_I64(CVM_MF_GFM_RESINP_REFLECT1, gfm_reflect_resinp[1]);

Likewise.


> +CP2_MF_I64(CVM_MF_3DES_RESULT_MT, des3_result);

Correct implementation, but it's named CVM_MF_KAS_RESULT.

> +CP2_MF_HELPER(CVM_MF_HSH_DATW0, hsh_datw0);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW1, hsh_datw1);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW2, hsh_datw2);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW3, hsh_datw3);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW4, hsh_datw4);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW5, hsh_datw5);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW6, hsh_datw6);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW7, hsh_datw7);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW8, hsh_datw8);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW9, hsh_datw9);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW10, hsh_datw10);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW11, hsh_datw11);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW12, hsh_datw12);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW13, hsh_datw13);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW14, hsh_datw14);
> +CP2_MF_HELPER(CVM_MF_HSH_DATW15, hsh_datw15);

These should be straight 64-bit loads from HASHDAT[i].

CVM_MF_HSH_DATi should use something like

static bool trans_octeon_cp_mf_hsh_dat(DisasContext *ctx, arg_cp2 *a, int i)
{
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();

     tcg_gen_ld_i64(t0, tcg_env, OCTEON_CRYPTO_OFFSET(hash_dat[2 * i + 0]));
     tcg_gen_ld_i64(t1, tcg_env, OCTEON_CRYPTO_OFFSET(hash_dat[2 * i + 1]));
     tcg_gen_concat32_i64(t0, t0, t1);
     gen_store_gpr(t0, a->rt);
     return true;
}

> +CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
> +CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
> +CP2_MT_I64(CVM_MT_HSH_DAT2, hsh_dat[2]);
> +CP2_MT_I64(CVM_MT_HSH_DAT3, hsh_dat[3]);
> +CP2_MT_I64(CVM_MT_HSH_DAT4, hsh_dat[4]);
> +CP2_MT_I64(CVM_MT_HSH_DAT5, hsh_dat[5]);
> +CP2_MT_I64(CVM_MT_HSH_DAT6, hsh_dat[6]);

Similarly

static bool trans_octeon_cp_mt_hsh_dat(DisasContext *ctx, arg_cp2 *a, int i)
{
     TCGv_i64 t = tcg_temp_new_i64();

     gen_load_gpr(t, a->rt);
     tcg_gen_st32_i64(t, tcg_env, OCTEON_CRYPTO_OFFSET(hash_dat[2 * i + 1])
                                  + (HOST_WORDS_BIG_ENDIAN ? 4 : 0));
     tcg_gen_shri_i64(t, t, 32);
     tcg_gen_st32_i64(t, tcg_env, OCTEON_CRYPTO_OFFSET(hash_dat[2 * i + 0])
                                  + (HOST_WORDS_BIG_ENDIAN ? 4 : 0));
     return true;
}


> +CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT0, gfm_reflect_mul[0]);
> +CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT1, gfm_reflect_mul[1]);

These perform GFMMUL[i] = reflect(rt).

> +CP2_MT_I64(CVM_MT_GFM_XOR0_REFLECT, gfm_reflect_xor0);

This performs GFMRESINP[0] ^= reflect(rt).

> +CP2_MT_U8(CVM_MT_AES_KEYLENGTH, aes_keylen);

AESKEYLEN is 2 bits.  You need to mask this write.

> +CP2_MT_U32(CVM_MT_CRC_WRITE_LEN, crc_len);

CRCLEN is 4 bits.  You need to mask this write.

> +CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL, crc_poly);

The correct name appears to be CVM_MT_CRC_POLYNOMIAL

> +CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT, crc_poly);

CVM_MT_CRC_POLYNOMIAL_REFLECT, and is missing the reflect.

	CRCPOLY<31:0> = byte_bit_reflect(rt<31:0>)

> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_IV_REFLECT, crc_write_iv_reflect);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE, crc_write_byte);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF, crc_write_half);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD, crc_write_word);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE_REFLECT, crc_write_byte_reflect);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF_REFLECT, crc_write_half_reflect);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD_REFLECT, crc_write_word_reflect);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD, crc_write_dword);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR, crc_write_var);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD_REFLECT, crc_write_dword_reflect);
> +CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR_REFLECT, crc_write_var_reflect);

Misnamed?  s/_WRITE//.


> +CP2_MT_HELPER(CVM_MT_SHA3_DAT24, sha3_dat24);
> +CP2_MT_HELPER(CVM_MT_SHA3_DAT15, sha3_dat15);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT0, sha3_xordat0);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT1, sha3_xordat1);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT2, sha3_xordat2);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT3, sha3_xordat3);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT4, sha3_xordat4);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT5, sha3_xordat5);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT6, sha3_xordat6);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT7, sha3_xordat7);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT8, sha3_xordat8);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT9, sha3_xordat9);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT10, sha3_xordat10);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT11, sha3_xordat11);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT12, sha3_xordat12);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT13, sha3_xordat13);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT14, sha3_xordat14);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
> +CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
> +CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);

FWIW, SHA3 is missing from the document you shared.

> +CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, hsh_startsha_compat);

What's this?  I don't see anything for 0x0057 in either the cn50xx or cn71xx docs.

> +CP2_MT_HELPER(CVM_MT_HSH_DATW0, hsh_datw0);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW1, hsh_datw1);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW2, hsh_datw2);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW3, hsh_datw3);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW4, hsh_datw4);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW5, hsh_datw5);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW6, hsh_datw6);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW7, hsh_datw7);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW8, hsh_datw8);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW9, hsh_datw9);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW10, hsh_datw10);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW11, hsh_datw11);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW12, hsh_datw12);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW13, hsh_datw13);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW14, hsh_datw14);
> +CP2_MT_HELPER(CVM_MT_HSH_DATW15, hsh_datw15);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW0, hsh_ivw0);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW1, hsh_ivw1);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW2, hsh_ivw2);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW3, hsh_ivw3);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW4, hsh_ivw4);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW5, hsh_ivw5);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW6, hsh_ivw6);
> +CP2_MT_HELPER(CVM_MT_HSH_IVW7, hsh_ivw7);

These should be straight 64-bit stores.

> +CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, llm_read_addr0);
> +CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0, llm_write_addr0);
> +CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, llm_read64_addr0);
> +CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0, llm_write64_addr0);
> +CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, llm_read_addr1);
> +CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1, llm_write_addr1);
> +CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, llm_read64_addr1);
> +CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1, llm_write64_addr1);

FWIW, Chord and LLM are missing from the document you shared.


r~


