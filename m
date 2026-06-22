Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D7BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfvL-0007kN-EE; Mon, 22 Jun 2026 10:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wbfun-0007gL-9j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:46:23 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wbful-0003K6-Ou
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:46:21 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37ce68a54f8so2724342a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782139578; x=1782744378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVLi5CTYge//fBqjN2o7pZfat9tur3gf3XYTWYG1l3c=;
 b=Pgerqny6yEpTghcjSve1i9AJPWPmU2oLBk3iAh1UoS1oikK1BRsHsgkLyNpFJ01cb+
 SXgdtk0VBtS4tFScx7io6ANJSa4tP8wJbSPaMx3gZu3iiwt0YM5YguJB65g5m3q3B4cg
 0SzbLYuMq8WvRZj0+fw7SxMFAxa/OG/FpzVPWIYqYNFl+hR4RF/VvQ+7NkdHn/0usbR3
 BPXQrIqeGvDKOm2Qa5FavgGZx3udtpKWnsoAPOr1XEdmGsenpYvETxZ0qUrrSuEhKuxu
 9rNnUYIYWFcijnAgc2W/TIdAXQLcqh1Tz6+kJfi4CVbNKsxqfRGvFyygANc/+FqKQkSb
 7wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139578; x=1782744378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVLi5CTYge//fBqjN2o7pZfat9tur3gf3XYTWYG1l3c=;
 b=IBWIAXf8vx9WJDVhTOdmjQ8gBWkO3/7Kv4jwLUYumY+fXItQ1mQbpAIhR0TraLRuGh
 N5gJ57RazhfFEQBCtGVvjge0tajTHSWvknBZfamNKlzCe+b7Z8ixpUFhsleSo/0h3TgZ
 y/unGAX5DyLL29wWqHnQlPuvcwUamd+JUqt+7vGulUeqVk1nanPLDHr3GRUM5dB0G0eS
 dFmxDD4JWoG9rjSkh/r2IZ6K0WmEl67OcV8AKizNnVOJi7FBfhlGoGseZLTfSN0ajLLr
 UsRgtqQsNmzm6FmiMR3pys23jhLcDhZ6/xIWnTHTAAwiXUJshOUIiBAwmBwiBy/2RRrf
 Ovjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwoX08nqYl6TOJZkGJ7RrNQavNJl0Jz0/I78gHiysgewmqvpbqDbe6fKUeUZKUXdRjnsLtQIUP/8Gp@nongnu.org
X-Gm-Message-State: AOJu0YyDm5PRp9WoGNJv8BVLL7OTleFmU8DYCBuJPPUsMnKd7fZjJBYM
 uH+PzrSYFmNwkwwTXSPL+SpVxKO8ZHdpE+DqTIaC4jrKA3ZhfOgNvPoYzlwlPS4ozKE=
X-Gm-Gg: AfdE7cnd8/XilScueLUaXo58GCnw9PaglttTAemvx0cYxkX7Czc5E/9pD8R561LXDxt
 w/YdAqL+IR0QddUGeNE7nb73fyZqF0WjtFBlUmPjnp75oGPOn5iB7ZphITBnu8lopH3pMjKFR9z
 7ufoLK4LMIkKEQ2EtBkdotMYpEutoN0t3grkqTUCwh7rkQSwRVclo/9iyKZOc+qLp7k3J/fQGDL
 k3R1oar00UOxgGj8OkPDW/tHUHqz2iA7w+lSmEGoI2K/KqUaJh0OtDSkDhU/+g4ObF++vJifZaz
 gd/SNseur35J0LTNV0Vm3/sctIvgwt2bNcUDj5u13xETltRshMR0Ayk8Iw1ZriQs16xOdPZ1e5r
 kNQiMIJ7+3nbNlvcBEUYzpt/E/2j5BZjtPlSi4mOupxvL0KJ0a1fU+a3EVKcDzMs713XuJmVO2E
 QddO0MFDAqSH1WgkQf6/Gnj815gjUpvBzzZi4SJ43hIHD70SCpEfjC55CKEg==
X-Received: by 2002:a17:90b:3f90:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-37d1e8d05f6mr13379831a91.18.1782139577649; 
 Mon, 22 Jun 2026 07:46:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4f008779sm7107594a91.6.2026.06.22.07.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 07:46:17 -0700 (PDT)
Message-ID: <a298b575-5f2c-4a4e-b590-9da4abc22e90@linaro.org>
Date: Mon, 22 Jun 2026 07:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: decode opcode extensions group 3 /1 as TEST
To: Andrey Polivoda <apolivodaa433@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260621032524.1138213-1-apolivodaa433@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260621032524.1138213-1-apolivodaa433@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/20/26 20:25, Andrey Polivoda wrote:
> According to Table A-6 in Volume 3 of AMD64 Architecture Programmer's Manual,
> opcodes F6 and F7 (opcode extensions group 3) with ModRM's reg field values
> of 0 and 1 can be used to encode a TEST instruction.
> 
> Although Intel 64 and IA-32 Architectures Software Developer's Manual leaves
> the cell 1 of opcode extensions group 3 blank in the opcode table
> (Table A-6, Volume 2D), the instruction in a group 3 with reg field of ModRM
> byte set to 1 actually behaves like TEST instruction on Intel CPUs.
> 
> Currently, QEMU decodes group 3 instruction as TEST only if reg field of ModRM
> byte is 0. When the reg field is 1, QEMU raises a #UD exception.
> This behavior does not match real Intel and AMD hardware.
> 
> This patch fixes this issue by duplicating the existing [0x00] and [0x08]
> X86_OP_ENTRYrr(AND, ...) entries into slots [0x01] and [0x09] in the
> opcodes_grp3 table.
> 
> Fixes: d7c41a60d0c5 ("target/i386: move C0-FF opcodes to new decoder (except for x87)")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3580
> Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
> Cc: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

AMD 24594—Rev. 3.36—March 2024 Table A-6 concurs that both /0 and /1 are TEST.


r~

