Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FCCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rYD-0001kc-F6; Wed, 01 Oct 2025 03:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rYA-0001kB-Lk
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:46:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rY1-00010f-Jr
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:46:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so47110805e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304803; x=1759909603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qw0sf/5g7pbfRXp7mdnGosJKc5PiyMwC2MTRVlZ842w=;
 b=ze3KSf/qbdg1SLxsggxbXDNMjeEMrL1PAH/oJKjpVPkurGp03OUM9Y/4OuQnsM8yJL
 0HH3e9QBvjlLI5xiSfpDer3pf/66xFlM4XAJRZ2L7/b0ujRY7PeKqqonFIjhF+kK4S0K
 xQOLdE4FZicVDiKZo0d83VVZtaJ8HPZ1mSShtGO7Haeim6phw+foVBVcbC1y/TzlOBJh
 oHyT6QuN1XeZKnecSWmh5Q15dTbaHgpZW/CEE2l95k5IynnjE7v/iEjJKGkZoWoVXa2g
 biMSyJ7uKUFKsC/jA9ORKYXr3YBOMCKaqb9kIr7UhpFtgfsxppYBo4sCQkBhs9/xKx0X
 5NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304803; x=1759909603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qw0sf/5g7pbfRXp7mdnGosJKc5PiyMwC2MTRVlZ842w=;
 b=PxuxIodoE6cW44UEjreD7mxDVIM2Bj7CUNSOCQGy3ODzDuOgMq+EpmhA47+q3sQCqn
 hf+LSa1OD5rpmsXqIlooy9bqNnqR0sJVKAQljYrPotuOjAaIYAsTocYEuEeeol/zkexC
 3zEoM+0nr+qVkZO5qbq71tOmM16lY8SzlJgCxHSg1sD+d0r1VlQJsNcIcMxEQu/SQYDH
 OBgvF8ZUP2E9acY1NRnFa8Z2n/qlpqMSjap/P/Gc/HV527C6NpJ+Nbbf9qAHC0LRaZY2
 PQE8pWCJVEShW0fzhsFtRyZq+OPoFYzSN2YFve2T+kP47BiP5y+Co91nyrnWg+o5Aeko
 IIBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYMnRxNoN5QWBQHQRegofHSofrEQ7uvz9iJKRvzRi+BjqYtR2zxYfP9bujXL+lH2sfYx7tJG2t8RKX@nongnu.org
X-Gm-Message-State: AOJu0YypvG+NXOKk2KahfVcm7ofRbePCT/3ndk0SY+lKUzVOkhOQEzjn
 wCWiURQSBOCp3EaiA3MofY9lZIaWY0YOMm1aUrSIKMuuTu/NhVcV0SHo1HnUqbhQO2Y=
X-Gm-Gg: ASbGnctml8enoiuNQ6v3CXg1GeKWfUaowIU9E9q1Grm5Iy4phIn6k28WyZIS8AGJFPT
 WPKcJuU+4iq1ZIrK3P+cez5BAwyxr4m9P7pgT1OmjfhckbIg4Bl0mAG0IwNnkX2D0YD4gh7znnq
 cQBfnPDbw1FG7xTeQBHJpF8cnDpGSkFXglqHsDl2JT+shmPEzs/15OFgoGes9CDHcd6XkAOpIsY
 XfJuu9zg0KRZvICdEIlPb25+oRdPQgLumz1WNo7SZN/KTGEYx7WryjXWpv5yEGgz+l6NKfUD9hb
 8Rn+OCAgnOWXmWRhQnyY3yDcFYYbjn7088/TAaGOIZoY4tU95i6ZC2xw+icjQdtuLb4SaTotC0A
 JB2QWeSFTokWow664B7XTgGqDpFwGo3EKsy4VFtMdccQaqkNLGQeqvW1F9i91VNPSgVnmyI3PjT
 2BfM+wsqIkbBFWag==
X-Google-Smtp-Source: AGHT+IH6QfKuky7HOJmpxX38Y40qmdvB6Dc/OybW36KaQt2Iljb59gJqF+QHYxiDwpMFazi+Kxe+9Q==
X-Received: by 2002:a05:600c:3d9b:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46e612e6a49mr18336315e9.34.1759304802739; 
 Wed, 01 Oct 2025 00:46:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm27246007f8f.34.2025.10.01.00.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:46:42 -0700 (PDT)
Message-ID: <723d6d25-1344-4a4a-9c81-5ffc5b5fc32f@linaro.org>
Date: Wed, 1 Oct 2025 09:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] target/riscv: Fix size of mseccfg
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-30-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-30-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> mseccfg is defined in version 20250508 of the privileged specification
> to be 64 bits in size.  Update relevant function arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/pmp.h | 4 ++--
>   target/riscv/pmp.c | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


