Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5225CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2Hc-000731-G3; Thu, 07 May 2026 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wL2Ha-00072m-Jv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:13:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wL2HZ-0007lp-7T
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:13:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso849129f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778173982; x=1778778782; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jBrT7abvhVkzhyt2WySTyMps6XBRIZ9aVgKiFOMAhNk=;
 b=h40C1pRFM3E7c2ptfFP2fUc5OJm+ed3+dxx5iLwvE/CTXDZhiNg9/ycxXZHnWdGCyV
 Nerjyci+ep+EsJFHcnv0TenzbtdJgpcT8nQNsWwUk2w7/5Jrd+NFeEiluRkXfkmrJclE
 38aDkkhM93VczD4X+h99Dhwd4+ZxKgyUDXqFpyJgiVuNyEOb8HPXsqU2U9eAaDzNK+IC
 U1Ohr47e5jfatZzWCCC6IB0vY7ezLlZl2MMekSGH6vAyTc3F8i73vxxh/fwLskz+6zm9
 5dnqgp/TLzXdiCxWeWASpze88hKsOtSXEJ6zmIcfRj0mIGg0xw4On44Cm6dSMCUjGprk
 QRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173982; x=1778778782;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jBrT7abvhVkzhyt2WySTyMps6XBRIZ9aVgKiFOMAhNk=;
 b=cqDEpaaPKk6Smg+BuxN/BRZQDNoiKBV0dqafo/OsZ83ycxJCiTbiEhXaFVmXB9xoNx
 0w1YrMQvyPQ3QUzEStztbaCwekUcONaisWZed7JJWOTQ82RdCMrsN5GopePDRQtBeZBE
 3uEmJ2Bm1AruX0gxSKqGX+ZvmchWwWapH0MgcnoMR8SSoJSzGxBbZiexfBok0SAyTND0
 XqM7SdVGd/TE4Koi1C2uDZxgHsckgGFQSbqDH9InWokFBdmt8tiIl/HGuIdpchWx2Cec
 fEt9YzwFy3a3XExD0y8cwyCpjbn13N/Wfn3E4Jh1PYAsumItsjvD0TmbYTQHPwguw2C+
 iOKA==
X-Gm-Message-State: AOJu0YyQv20XyjO231qXvhGKgYXu/x08zpiuRTw0KcEVcjevPugMvLvI
 aqmM7E6C7n5b0pi5OsO1JD8IuVM+jl/pinwv/lkh0bYPggj6NFHzWd5iINBFG2Uo1kTj48nTX6W
 zVzj8
X-Gm-Gg: AeBDiesUJJkV69PtNW7UsFvQkKPfKV+VPkdWa7aevQ/QS54wNOYEyNmcVV9bF1pnEU8
 ScBuuC1TnihA/R/RYXfAoVKG3fhVq4tAtNUk0Y2XwXMtISVwru7cBvzvs3YhqmTM8x1NdXpniwr
 ElhokGq1vvhQQDYoKHG3bocongNBXxj7jLzL163L4hy95SajVuF54SgE07OW1TzXPNpamY+P8I7
 oO3eOPeniB/F00Hzpbpi84B73hcTWrjV4UbXOx+CyPi7Q58xB67D4BaQbM/bLZrup56egDlkA2t
 B29BYdyoISEBEGT3IDX9vD1VPIw4WydWMgQWWg5toxDQBQLc4M8bFJFibYepuYgBsZE9Khf6iQb
 kOnt1M5Pwf2ms/zn1UVGFCowUDmJFcsWI9+f3BJSBKOImPjvaqob9xhJrGfrSXnbFG3Y23MdhQy
 8wvnG7kWICrylQjb4kF1CDeajiHw==
X-Received: by 2002:a05:6000:220c:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-4515bae9147mr14849501f8f.19.1778173982289; 
 Thu, 07 May 2026 10:13:02 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:2cf8:2ace:fcda:630d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4540f92c322sm523732f8f.0.2026.05.07.10.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 10:13:01 -0700 (PDT)
Date: Thu, 7 May 2026 18:13:00 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bennee <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/7] tests/tcg: move aarch64 page table setup to c code
Message-ID: <afzIHLbjs-PIkKy9@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
 <20260417164328.1009132-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417164328.1009132-5-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42e.google.com
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

On Fri, Apr 17, 2026 at 05:43:24PM +0100, Alex Bennée wrote:
> If we want more flexibility messing around with page tables lets do it
> without having to rely on assembly for it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> AJB
>   - a result of -O0 does mean each helper ends up with a stack frame
>     being needed to do the relatively simple mask and shift. I've
>     experimented with -O1 and trying to manually enable inlining but
>     couldn't get anything to work.
> ---
> +#define DESC_AF          (1ULL << 10)
> +#define DESC_ATTRINDX(i) ((uint64_t)(i) << 2)
> +#define DESC_NS          (1ULL << 5)
> +#define DESC_UXN         (1ULL << 53)
> +#define DESC_PXN         (1ULL << 54)

I *think* you have UXN and PXN the wrong way round? See table D8-52; UXN is always 54.
It works fine in this case as we always use them together.

Otherwise,

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

