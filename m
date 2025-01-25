Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ADAC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 14:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhUX-0002T6-Os; Sat, 25 Jan 2025 09:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhUU-0002S7-Jt
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 09:50:30 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhUR-0007lv-EV
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 09:50:30 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so4377527a91.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 06:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737816625; x=1738421425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MGsJTkxxMqydUqp2SRyFlmAmZMDrWrzEHv/KsnbyZww=;
 b=KFUL/yRdOFbNorwQ8NVpynSMwelS1Soc6U4if3OTRp3H5zF4QNzSuDzprcyztiHCLA
 hNbTxDs+oQgQngR7PTnb8GSyntdh4yDb3ghdi2mM705NCJCSOCotOm3zrAlmEdLG66kN
 85aRWk1UE3fJtxbxPxyHJOuJdN390pxJkwx11Zw/Gus/Q4f309YbqPSQMm0yboWHuVgP
 226gvBJa/wEKekaAC0cHmur6KBb1qf2mBCMegwvb8LOJep312glDgHItSYH3C1XrZ6Qc
 04cKtppjaOKzpWZBTo99SoTK5oJFdjVTyaV2WT1WhFgojOiKOa8oloo6l2D6PHcNGPWo
 UFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737816625; x=1738421425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MGsJTkxxMqydUqp2SRyFlmAmZMDrWrzEHv/KsnbyZww=;
 b=LR0fyWVfxMtCf16Rs3fh1RfVhtPni0Qv9K4VGLbt4dZoWOfPqB04Tqe4Cc2L89mIpr
 BO4URtcuP+ls/lAFzJkiXBIhs8IifK3K35L2M+VLmPmojeQvc9RGjErfBY4IcqlvHPtR
 iFl2hUYgXz5kqNIbrZjo3dwGufBXbZZU8dhnVzIT9StP4e2aZOhV6ogNLG+Gr9rxGnzL
 11wUOuDHnv0UvdAzd3t368olZ23LBqbT8hApR/DmOLA99pH2u1YjqIrcgqBFFMCbhH3s
 Nd/9wFI7ikUtTHmiVFIAd+ao8042a0K7eFU34bPqpuXpUOaAHGV2RX6UYbGyJf0a6IBQ
 sF9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU26WYsF6EXirSfgHFdtNVSh2rW2M3Oh0X1JcfQdGZPYDwMxlEQnW/BglBuDkG0Qkw7l2AwgkydP0Eg@nongnu.org
X-Gm-Message-State: AOJu0YxsOfIoh/EL2q8TsASUSMwbluOT6WCYjrHc8gep2+ZgCxRtFe/X
 VDZqJGrM7wCOwmgfN7CnJ3gAQlsLBtmUcZE1OHHB+s+Ata9O3OU4kzf3VwHvqPU=
X-Gm-Gg: ASbGnctDMnLiTknAa1vIXgUQNpn05+Ca22X6hmY3LlDXi80Fn0wVzb5eDjAxJBRoyio
 LHY6HZfSVDqe1P2AuqUY/vAQpWZj2/+VBQj2GHsx+b+SlGP61h1RyNFjkAkudMEZ6+SADcBrbLy
 L2fZ4GjKkeTvWg78mYMln7hHMm9HCLGjGta7J1Sv3llU+1mR8vK9YrCakV6OKGOPaZM26ELMsjU
 3YMeTt5N3ScgyBwzRYvaxKD7qzDBY0zOSuW78oY6MmcG15APtlueM3wwBph8vdqg/0J1laMjrFO
 6V3wTo4mu5d3H6LalAG+hg==
X-Google-Smtp-Source: AGHT+IGfJDR7XqDEFg8I3VSDR6L2eyMgemPZeRU56x2tQ2NiLhn+zXPSa4r5Hu9ZGACTAMKtdl7/qg==
X-Received: by 2002:a05:6a00:3a28:b0:725:e405:6df7 with SMTP id
 d2e1a72fcca58-72daf94858dmr45288346b3a.10.1737816625585; 
 Sat, 25 Jan 2025 06:50:25 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac4907f0f60sm3318277a12.40.2025.01.25.06.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 06:50:25 -0800 (PST)
Message-ID: <d79e5fa9-4879-49ee-8db9-5c394d97def7@linaro.org>
Date: Sat, 25 Jan 2025 06:50:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Fix PPNO execution with icount
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250123123808.194405-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123123808.194405-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/23/25 04:37, Ilya Leoshkevich wrote:
> Executing PERFORM RANDOM NUMBER OPERATION makes QEMU exit with "Bad
> icount read" when using record/replay. This is caused by
> icount_get_raw_locked() if the current instruction is not the last one
> in the respective translation block.
> 
> For the x86_64's rdrand this is resolved by calling
> translator_io_start(). On s390x one uses IF_IO in order to make this
> call happen automatically.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index e7d61cdec28..ec730ee0919 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -1012,7 +1012,7 @@
>       D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
>       D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
>       D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
> -    D(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO)
> +    E(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO, IF_IO)
>       D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
>       D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

