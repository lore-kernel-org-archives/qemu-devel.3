Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91441C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtbv-0003ID-VA; Tue, 10 Jun 2025 03:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtbm-0003Hf-NE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:41:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtbk-0004AM-5H
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:41:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54836cb7fso1249694f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749541278; x=1750146078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iXkfU9L4GZiVE5276HJNDJaK8nC1ZrKYeXNCrF9jdiE=;
 b=Jc9kS5oeSJFuSmUsQZT2IzbJxomwQAl1w2Ef7d0wXhUWMbte/TbfiGUWs2sjLKLZuL
 y3/KyW5Tb6pUpN1l7dTee5yo5I/ZJJK3sX42lprgN2oseP/hUgqBRDNU/UvnAdFkK5n9
 9EwPtKZbANlhJWVu0glUIWTc4AkeaR+K+nyH7xjtccKSLUtwdJ6E1fGMpI7J3UVDX1bS
 l9Vcm3uWeG9hxkxizpXq6JJV3D2CsgpLu6Qi79n4TlcbjQxB9in1sMiAsWo3FywpCj0x
 Ne6ykI4XUMYzblARySasYK7VV4lU6Efw+KmSkUj47ehbPfnoxEzoELcYLl+jf+S9LpNI
 CZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541278; x=1750146078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXkfU9L4GZiVE5276HJNDJaK8nC1ZrKYeXNCrF9jdiE=;
 b=tPlHdyJWtkoswhB3ZNesKYB6j6Wv3/tYqiHsNc1SXUXQaqJrV+wbFAJVxJdBx94GCN
 TRwV93mjfATcuWmf1SiMsDWm/kjpkBJRymsvceFga9+EnBiJ16WtlOsg68EbVZa4motr
 d/yJmpyxb4V3y9OvrWl80teObS0//UjqsC+/2boX57dlBn/kUlsBUiiF3MxLgj9Y4TKI
 6rl4LFQsxHy3s7K1RWR1U64NszY6uv50FybrXLufxR3hJDtEWARxwfyPxrphVed8XRhd
 OcPgSLD9rl/QCtFub99XTggcLGWTyqs+soetOJNMrVJRBDvZl0VSaWBZ0O4msvz+ekjr
 iMNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJxjXX1EPNmrFt3UvpoCH/KNOaet6twmq8NIxj2Qup4Usa4B1TZx+bj2AV5oFEKApd8P6A49Urp5aC@nongnu.org
X-Gm-Message-State: AOJu0Yzt94JCAjyDd0rmrX/VdCla9gI82OPGCKGBvqM/7RcwYT/tLpi3
 9LoCIjIS9dy/MNrKimZsZVXifc9fY/m62SvDTNDJiPY7yJuLwUuk0GWV1phbCTlsXC0=
X-Gm-Gg: ASbGnctyQ+CMEQ8z2QO1v8pmQvuNbw7ZQ3Pt1pXPdUBB1NdO5S/rL5csJdCDQ2EmYfH
 ztp0TpXNj7RgiZHr8l3o/SS1gBUYPy7RTgRRiqYyjHECwUQIqRch1vKI3UGFTMYf77oBNkr85JP
 DxpzQnQalmH6NfSFrAGZ42VIMwUyW9i0kapl1DcxA6DQwEGtzh69+8WxvDZgZRyzjS5pLKEC08p
 xSgVXTG++vr0kHF7VPULmtklKxv0bV7dzgzlEr0xnh2qaErbjiA2Xh2b7wU5WowJUx/ayKJVYmB
 JsGgq2CurEaLJe3AsGfetj4/AWxT0wYHlHPS7FbU/irkRLka5e8DRkc7JI1qxhorrWGZDHFBZ/I
 MzrOdnKIz5FpmDM1tn30+0fbC+65eIWbaPFCdczg4NAVASw==
X-Google-Smtp-Source: AGHT+IGDNAv+eeNfMclexyuGsq3lFH4qy2RrkUXGAmlWWUXxQzmEUNY3TiCMVPF8EG9fKEek5IoNPA==
X-Received: by 2002:a05:6000:144b:b0:3a4:dc80:b932 with SMTP id
 ffacd0b85a97d-3a53188a757mr11648635f8f.8.1749541277999; 
 Tue, 10 Jun 2025 00:41:17 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d9adsm11335387f8f.9.2025.06.10.00.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:41:17 -0700 (PDT)
Message-ID: <bf645bff-3ec2-4c14-8fe6-b1dd48682af2@linaro.org>
Date: Tue, 10 Jun 2025 09:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/riscv: Add MIPS P8700 CSRs
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-5-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250602131226.1137281-5-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/6/25 15:12, Djordje Todorovic wrote:
> Define MIPS CSRs used for P8700 CPU.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c       |   3 +
>   target/riscv/cpu.h       |   7 ++
>   target/riscv/meson.build |   1 +
>   target/riscv/mips_csr.c  | 219 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 230 insertions(+)
>   create mode 100644 target/riscv/mips_csr.c


> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c0e048a66d..984f93dd4a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -497,6 +497,10 @@ struct CPUArchState {
>       target_ulong rnmip;
>       uint64_t rnmi_irqvec;
>       uint64_t rnmi_excpvec;
> +
> +    uint64_t mipstvec; /* MIPS tvec register */
> +    uint64_t mipsconfig[12]; /* MIPS config register */
> +    uint64_t mipspmacfg[15]; /* MIPS pmacfg register */

Pointless comments (not helpful at all).

Alternatively:

        struct {
            uint64_t tvec;
            uint64_t config[12];
            uint64_t pmacfg[15];
        } mips;

>   };


