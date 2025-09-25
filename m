Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55823CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m7n-00071l-Hh; Thu, 25 Sep 2025 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1m7g-0006yz-0d
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:35:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1m7Z-0005fC-70
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:34:59 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so1771814a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758807289; x=1759412089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rER8+RjWenC3LctnrJfAqg5RUqSHNMJj9NlY3wvjs8E=;
 b=JB2BZmkz2FGA84ewPDQxQ+vLCDNG+rFasIMz6d2ULQRGIb4U5Cfh3fsnuBtNZ3fZv9
 6pZ5XsKtgip0j6qc97ozudsJcLqLcjn8nnjFMla747AhngyO/WNCwNZk0LDWE/UomNyg
 LiL3EC+o3tptRjzudIhV7G1sRuoZKmWLqSU2oTC14VePCWFcXXf0F4MhrCZ9Kx8KWIFD
 w7zS9eMbjSlMVF7Z/cFDTorop3oL8GNCrZS/PIVp/xfBu9HYuvz+I4cEKyZsTCsG54lb
 TEd0C0gruF4zj9Mkuk/8OSDTOEUQdClOTwRnt0SI/XvfXmrrDkZF5bVH4GrdF3hnNT/I
 pX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758807289; x=1759412089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rER8+RjWenC3LctnrJfAqg5RUqSHNMJj9NlY3wvjs8E=;
 b=KqkcEpwits+LINMHgFgrEQbKIU8Q0HV0qUWAEDeQanH/W2cCS0gWp/KmcViJ8XA6R9
 iXm94k2lfv1kYWrBnHx6nYseqMZX/CbXaZNedcMdWg3QYrPO77CbGNel2AvrOO7kdXI5
 gxTRzJtdNdw7HCBZu7iVCxzxhDYBD9n2/esv/76U7N8FdleW+FVCTKzCk97aw+pUHu/Z
 2XVYcur1cdluU9zMsPlEVk7JHuyNVljptLJzgU2XoLw5MJd1PVdtZwpJR0NckZaq31u5
 xdtPfsf2fqJfCNFjFXvyU/hMEVMjBuQdqQE5YS4lUVJ916LtUTqP+uZ3ULoM1iuwuZDR
 VlsA==
X-Gm-Message-State: AOJu0YzIYwQKrwpa882YgHpjemYt7Dlj9roaHUXncrSgmQvKtCU2fk4X
 XMSryTqL8cnw8HoHXmKslD1QBL/2DfrpS7iYVQCt1y8juL3iJBPBCR4JN4+Y6brbmTMB4LhYLTh
 fVEkT
X-Gm-Gg: ASbGncuVXHidR0V2Het3Iu5XakySCIUnlENAdekXgEoYjewBRgtiNejWu75dGYSdpBe
 x5B6xpiaQU7pSE2GniXP+aG/RKK2wwEVi8tAdSG4xaEeqc5sA07o3vD8lvM+raDLM75ryrQdv3w
 Eipz9tjLru8GfFX97eoA1fVMPwtN2neHDzePPw6mwUBMaX46LmqfyA2XtpIEHRewASfm3RYd+nn
 vomKNSHNM1W3mE1l4nJ8i9wDmn8pWEyFhg4LLqKOktvV7J0jXSq8Jx7TGNmKH0V1j971yw6Hadx
 FsOgL73LoUB9f0zN1HvTDX9y3jIOofEWV4kxliY/l9e4p8ZY3Ds807jQRDbQQN/Q6/rE1olDwHy
 LJYCapoV5sOl1BPT98sW/K4y0DcQs2R/mooUH
X-Google-Smtp-Source: AGHT+IFH54NDuHLBwJNc6LAhP6QDb467AjD0NW1TzSai0bb7L3L523a+p3/0EsD1rFbyDzzXQlwLMg==
X-Received: by 2002:a17:903:2290:b0:279:b2cf:26b0 with SMTP id
 d9443c01a7336-27ed722bb7emr32189135ad.14.1758807289297; 
 Thu, 25 Sep 2025 06:34:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ab640esm25442455ad.128.2025.09.25.06.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:34:48 -0700 (PDT)
Message-ID: <67c26319-f445-4115-aebb-374b67e3dcf0@linaro.org>
Date: Thu, 25 Sep 2025 06:34:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't set HCR.RW for AArch32 only CPUs
To: qemu-devel@nongnu.org
References: <20250925115723.1293233-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925115723.1293233-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 9/25/25 04:57, Peter Maydell wrote:
> In commit 39ec3fc0301 we fixed a bug where we were not implementing
> HCR_EL2.RW as RAO/WI for CPUs where EL1 doesn't support AArch32.
> However, we got the condition wrong, so we now set this bit even on
> CPUs which have no AArch64 support at all.  This is wrong because the
> AArch32 HCR register defines this bit as RES0.
> 
> Correct the condition we use for forcing HCR_RW to be set.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3128
> Fixes: 39ec3fc0301 ("target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

