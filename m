Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B1BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rbH-0003hs-Ju; Wed, 01 Oct 2025 03:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rbE-0003go-7F
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:50:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rb2-0002BJ-A5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:50:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso53476715e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304988; x=1759909788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMdulZKMFOf6LbHpKoFOlEl0gNzf/6bBtdmn0FkyjOc=;
 b=J5CQDjNjsW5odWU2ssihRcjvFESEAKoeXD9qWG0xmuMwm4IKQKF6KiqiL2ZgxqQwgY
 76MgdhO8KQKQaEt6qzA7dXF6+UtL7vU6l+/00KyRziLlLozXByiXqktn65zG8BMdW4s3
 /MtwLWF1OILdTbfrTHVjAjl1wUMfFCRjYzecTGsuvIkAHl2uCf7Klh2BwwUUCnztBCvh
 6PjpaEj4OB+9yyJaAtF0gJuFiDGXP0cvwsm8YKuZL/Pp7rLG1EjmFh9IThr5fSvUklCD
 +yiYjeJcla5VhlKfTKzNFhWPcbrhIbtAnCv86/LYhmE1mfyDPUkNTlA5RwgtO4Kc7dxf
 rhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304988; x=1759909788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMdulZKMFOf6LbHpKoFOlEl0gNzf/6bBtdmn0FkyjOc=;
 b=aiflbK8hCspsYW0PA9A/fLSvOg0xccM4hSe3sJ5osX0G+Fc+HVQeix0FM9cHpmUpuC
 nOn7Bst7hsqbwatCTKtfA2razMPi0bs6iRODbSa0hTOtBAx/sXqUn92kOhhHqK3yzJ7X
 Bg8vzthTWWwVi9IPKX6mnH0kOwtbaTECmznQCSzIGYvV4dfdtUgn/+0vn6nd426An+iw
 c/uGrPoY9IYEynNs3Dx6lcRbGI+dwHGNTR7yDi1ln4rdr5heFs1M4TIdApACGL/Rp3ZZ
 hQdrknO7aqrwkEsB9awgfk2tok27hUrQLy8A2A6mcFSTA0YqXtU4qPBeE3I8jutRLNVC
 MmLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJO3s+zQURR/8eMAby49o9W1rjgNpX6b1BUF6AOz7FnzwmiDYGPjDMVvCynj7Uu6LnEMbJY8WMa9gK@nongnu.org
X-Gm-Message-State: AOJu0Ywg41rd9HKVaqeq4/4QbKUH942wp/GTa2v+U70qzQgOn6HPIbiD
 NmisJiPCUsn9mPWwTPw12NLDFNB3BjBIq2vg/uC58XAi9UUd4G+jjrw2NxojSYO/9y8=
X-Gm-Gg: ASbGncvP6zxHwN1SxDyQt28VzmvJsm3VTsfpOm9ICa1h8yWx1Nu4v8rAeRiLGOnjtrl
 JbzkHSCmvl9/QyGrSke+clmEAOfn8pVaAlbgFJhGnIKcbPF2d0NIlw9IieKMDNPg15B2kDXTObP
 imUaWCOi2veJaoEI4vTsXS0K05fclDDeb6Wpebqd2/HMtEvgJvDIlatbXtZjldeHYbTO3edw5XS
 04xp6Pvw0fNnlUU7JtApOIF1T9xE4L+5gK+RwVeDD+lWTTIMBjuV2CSFImKo19h8loGqfXvtASb
 gxXDnN8+Co+a54TOsZE2vqnFRTEP0jg3n6MKKD+Mkoky8tPcnfpEY/+Kb1ok2C0m9yhc8pQv0Tt
 WRuuRaK+/6Xt/zaAPABt/o/uwhKcqMoFRc7UbDWIvKduUyK5Hhw4o81QZP8QgXoTUbi6jjTN9Cd
 MijjdlblNDbgfbZQ==
X-Google-Smtp-Source: AGHT+IGObbKUHf2+rIbUjEGyCBHH/edn/BY0/CUrh5R6/e3wj9+ey7yx5pyrr9xk2TnvH1ZVJbANxQ==
X-Received: by 2002:a05:6000:186f:b0:3e7:1f63:6e81 with SMTP id
 ffacd0b85a97d-42557807a4fmr1632883f8f.16.1759304988145; 
 Wed, 01 Oct 2025 00:49:48 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199f17asm26749465e9.6.2025.10.01.00.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:49:47 -0700 (PDT)
Message-ID: <c319d6f0-abad-4576-a0bc-67f3e68bcbd9@linaro.org>
Date: Wed, 1 Oct 2025 09:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/33] target/riscv: Make pmp.h target_ulong agnostic
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-34-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-34-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/10/25 09:33, Anton Johansson wrote:
> The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
> CPUArchState.  CSR declaraions are only used in target/ and are moved to

Typo "declarations".

> csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
> parameter is fixed to 8 bits, similar to previous commits.

Worth a privilege_mode_t typedef?

> 
> Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
> migration from older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/csr.h     | 12 ++++++++++++
>   target/riscv/pmp.h     | 20 +++++---------------
>   target/riscv/machine.c | 10 +++++-----
>   target/riscv/pmp.c     |  9 +++++----
>   4 files changed, 27 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


