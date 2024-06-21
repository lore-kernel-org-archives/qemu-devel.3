Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEFFC2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhZA-0000DM-Vo; Fri, 21 Jun 2024 12:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhZ8-00009o-Nk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:56:46 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhZ5-00023w-Ma
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:56:46 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so2413491a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718989002; x=1719593802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=osROlMWISQkFAl9Fnq532Q+c53mVVN4CuNGsARfPqlA=;
 b=GHmn8NlarKjSiyDNAGUAJeRJU1sRX87h0/N5GtQszOkrXSm+4lru/XZefkJD3xzf9M
 pd8gUPv4/ioEWrQD9mQjzNppMJkDlb88YCxDqU+nHUs5JkVBACeq9ks/WAlnqyuUYNDn
 bgSsm71oDybx6GEbknuuH4xbuyVoxQ0uLYmlFcjJ8rcgKayY/huqahPTaKqAbZ8pZvBq
 Xj2Y+bI6c/GyEdnsN2VlhkCX3azl8Bq3f3May+YDjh/ol03qcvNReiTWlLVeb7Dbf0nv
 cC3/MM/1m6MDGcdoaFjc/LD1hlSL/a/6J0QyegZKXxR5UX1qXhD5UETZU1tgISUengGn
 clXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718989002; x=1719593802;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osROlMWISQkFAl9Fnq532Q+c53mVVN4CuNGsARfPqlA=;
 b=skV8XeYpO095hN3XOjSS683QeuZUVcBk4LB/BhdCmXJ7J9QhK2Ye6Mqo1BRY92l6Xm
 7vQ361KmFRXtjcxdMtrCVhtpN6lL/WOcY/U7pBQ2YIjbqZ4J7Tr+S5c8XR0ic23Mn7+3
 nKT6JyTQfZVqLpgz04GuH0te9XHySiG2IsZ6vR3kIYk3t+j4+Wt/gLXHLey/JKF+XnzG
 7ENsCpaq9n3kr35ZSdufVgmOeEvOrk+JBC1JXXa8aLkzuFFfUfFEbvVi/srH3iCF/nsq
 tAgdES68/kqFkmyiGCC2T+Y/9ZKDDvCrZRswPVL9lLMt/YjneCo+Nk5WehBA2XvNEFz2
 NdUg==
X-Gm-Message-State: AOJu0Yzt+HnQfoLZSDLs86RwEQH0HKgIbTBhxze4GRafn11cuhrPhO6J
 q+bU3nYy5YKPhEOLlJiiNJZJ9YaDadh6MpjJHDWp11M13UPzB8HosuCxzKKy5U8=
X-Google-Smtp-Source: AGHT+IHYerQcVqynmb0tq5Lmdh4BwrOMcvN3uxDDhAuG+Y4pIUOCswGAJRiFLx1AzSQaLeqjnDpKdA==
X-Received: by 2002:a17:90b:4c4d:b0:2c7:cd4f:d765 with SMTP id
 98e67ed59e1d1-2c83c2dc00cmr424415a91.21.1718989001741; 
 Fri, 21 Jun 2024 09:56:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e53e7bf0sm3868779a91.19.2024.06.21.09.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 09:56:41 -0700 (PDT)
Message-ID: <d8b192c3-8606-40d4-83f4-56cbc243dd5f@linaro.org>
Date: Fri, 21 Jun 2024 09:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
From: Richard Henderson <richard.henderson@linaro.org>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240621114604.868415-1-rathc@linux.ibm.com>
 <20240621114604.868415-3-rathc@linux.ibm.com>
 <b41472ca-5627-4f3a-ba35-cc3cded553db@linaro.org>
Content-Language: en-US
In-Reply-To: <b41472ca-5627-4f3a-ba35-cc3cded553db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/21/24 09:34, Richard Henderson wrote:
> On 6/21/24 04:46, Chinmay Rath wrote:
>> +    tcg_gen_qemu_ld_i128(avr, EA, ctx->mem_idx, DEF_MEMOP(MO_128));
>> +    set_avr_full(a->rt, avr);
> 
> This needs to specify atomicity as well.  This is much more important to for 16 byte 
> operations than smaller accesses, as this might require stop-the-world semantics depending 
> on the host.
> 
> According to section 1.4 Storage Atomicity, we need no more than 8-byte atomicity for 
> these vector operations, and then the following the alignment bits down.
> 
> So: MO_128 | MO_ATOM_IFALIGN_PAIR,

Actually, you need MO_ATOM_SUBALIGN semantics, maxing out at MO_64, which hasn't been 
implemented.  But since none of the rest of target/ppc has been updated to use SUBALIGN, 
using IFALIGN is not a regression.


r~


