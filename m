Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888CDC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQCX-0006Sx-0R; Fri, 21 Aug 2026 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQCW-0006R9-10
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:26:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQCU-0004lo-5b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:26:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so13110615ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787322388; x=1787927188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iaMemaXU1t+v/N5y0jnCdL+YwHMrlHLfcMdM6T+3CFY=;
 b=stZ9PeLFshD9S3wPI85CO5fpXOGMoV0hsPD7oyVEZQNnBtFFpbVtu8lgYXeSWD2vgN
 KLL1mEnz0eeuSLDcdhv98wIhHCA/n8Waac42KiXTQSmDc6n5LdnpvgX68YIUmzi2VTKv
 1PBJSsiNqZ/ZSsVFt7GZvNQF5nRwqSf8liszw2q9nkE+1c18W6GbJq5QriwG8xh7sut1
 DU65x9ro9AMw8ptLN8Rhz485ORQUJBoPlKyaaxc7LphMRpsujSqfxlzw+Quu0Aj9dpB9
 /x+7Cshnk586v1aqsTtmGwtj1g0kSxK3W2eoPdeANMhwuUPsobQUaN7VQ5+NweGT8gMf
 mvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787322388; x=1787927188;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iaMemaXU1t+v/N5y0jnCdL+YwHMrlHLfcMdM6T+3CFY=;
 b=N/y1h9dUV7hsqGw/iqtzSN6h0My00wJp4TjwHh4pVUfB3L1ctC+jQxqGOM7FgxsBvq
 dXE+3BA4IXZaZMkGIKMMriMCvqcHUUbAJnP9sgRZVao8PAVEl6VkJe8pZlcw8QvsV3XO
 efO7jl6pw51jkbfejQO1tMXxo6l3kSvqFzhVDaMKKD9gvTNKpP0jzA/gEkphlO1bt4os
 AVktqivMmzUCMBOxbSJL/Jhsn0QZaCiiCTY/7R/1NVXmd6H/OcpMLHzh0/YqbLDqigZh
 YcSf87KjDv9fmsJyI7diCbbVjoxCsnRBxb/EIbI7p9Ln+B//5zP73H3uqFVmwcsZcrqF
 s0Qw==
X-Gm-Message-State: AFuF++mRYBnI+Rea3V9blS9ryIgDP/heDk8kVdhxmHLkx4dQuT2FfdSj
 c+jfKpCnKlziGuJ/Ka7pTatldR3ejalnrOlZXBu0vMUPWX17OJ3CYtX6zi80OqSjZLCPhCCq9BW
 yRL/A
X-Gm-Gg: AR+sD12mv8+QbcvlN+S4x1u+zU5znQbsTFEAiGAeMZ45ylQt+cGV/ehaiuGk1DjCSn7
 oRwF4+jOiBq9XtlEWrU2tqiLkxLy89ptHZB/H1muEe1LajT5qo3X7bwIQjx8ZYAf1K8szx5NxWi
 P8vXKovMgUMAGfc30419x/40j2a257WsawfbvZ6og6KkvsNNq8JlwiDoO5rxwSMqc9uDUhh25cP
 AwOMlvOENBnV7soQdGCvzt3r0z3i56MQovn20/eYPuRVe+Z+lYWbDtUF6LQEvJgjUUJUIH7vuSm
 LdZrWZBji4VmRAZ0h0mhlLJeLNO+Rm0hzkAGDC0rRdR5ivJDQjE7Mpo/eb5mBXP/2B074Cy/m0O
 is9nW/iuhQUb3cfuu+lsd5U75yUR1benIK6jmlrXI0SJ99qlxOY07e/OmQscvbzBG66oirL/Ryp
 L3Z8M0GnvCxBr6fa20Dt3cf9ZEYPGOE30FFVhMbSDrmhzknfbF3+X9i8vfrxGSPagjwj+jBv821
 t+0
X-Received: by 2002:a17:903:2c0c:b0:2cf:8131:75f4 with SMTP id
 d9443c01a7336-2d64b036898mr137217085ad.11.1787322388305; 
 Fri, 21 Aug 2026 07:26:28 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62ec88bb8sm19745025ad.83.2026.08.21.07.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:26:27 -0700 (PDT)
Message-ID: <3896dd80-5d75-4636-a18b-be8355b1f57a@linaro.org>
Date: Fri, 21 Aug 2026 07:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Make Thumb T1 hint space UNDEF before v6T2
To: qemu-devel@nongnu.org
References: <20260821132550.168896-1-peter.maydell@linaro.org>
 <20260821132550.168896-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821132550.168896-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/21/26 06:25, Peter Maydell wrote:
> The "hint space" is a region of the encoding space which is defined
> to NOP if not specified as an architected instruction, so that future
> instructions can be added there which fall back to NOPs on older
> CPUs.  In the A32 encoding, this hint space was carved out of the MSR
> (imm) insn by using the fact that a field_mask (bits [19:15]) of
> 0b0000 meant that an MSR (imm) would set no parts of the CPSR from
> the immediate, so it was always NOP on existing CPUs.
> 
> For the T1 encoding, the hint space is in a range that used to UNDEF
> in Armv5, and so the hint insns and the NOP region must all UNDEF
> before v6T2.  Rather than putting this check in the trans functions
> for each hint insn and for the NOP space (which is a lot of places,
> and awkward since those trans functions are often shared with the A64
> and A32 encodings), put in a decode line that covers the whole space
> which we check before any of the hints and which will explicitly
> UNDEF if necessary.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4208
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/t16.decode  |  3 +++
>   target/arm/tcg/translate.c | 18 ++++++++++++++++++
>   2 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

