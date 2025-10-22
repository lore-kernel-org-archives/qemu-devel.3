Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62578CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBahB-0007lu-3b; Wed, 22 Oct 2025 11:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBah9-0007lP-MS
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:24:11 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBah7-00034f-LA
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:24:11 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so8969334f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761146647; x=1761751447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5jmEOby2nS4Gf9uvI2Y8UICeyB9COHpy7ZN4V5tpnU=;
 b=Vj9fKNae4ADoD2MEMFahSgz7xEJyo/rLyAOF/BC7LjF8lcITQuyWsyncmgL+fECZL6
 +MS97BvWXu5p2h5gau5t/MlM2HS0LRmvvLBvNcZukZ07Nq4iNcWV/R4CGYUJT7NAG8MJ
 46PNknBTglNRt5NTcEH9+llhQEr+dp1XL0OR5VUepLTCdu4KylmU4OKPHFVQoZnYeEc+
 eWdLUWuBfQvblrYLZLhlZ73BX9QCBajjo4I49MlSJgojw+Rs89/poCL1iieBnpgT9/77
 W5/ZV7x7GxBuV3/DZXAaA+qQDTSJUW7F0YcRTzV2VDJcxjapndYDIEbC7XMmgulz2gNd
 oPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761146647; x=1761751447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5jmEOby2nS4Gf9uvI2Y8UICeyB9COHpy7ZN4V5tpnU=;
 b=B0PR1UncTbcRfGFgEYHJx5Zptjobpv995NXTZN9M6cfuh5rhmbtuXNInZM7fH9WjKk
 vgOcywOxz/azCJzfQR8pW2EPXmRRD9lrtm7T0sLCS9Oop5UU7DLzlNe7pS+R3Cg9gcAi
 luUtLAqLqn0nweKgkE+kRwa4esXif+IyYEcYc/CJa5k8HaEsvDLugkg7q1GReagxuAv4
 J+ZrYF27FYTI471EknaSLMXvt5fBJAZ3X4CGkeCjyEgNF9MSptUHvY7cGLOTSwnIxT4N
 0UiTlGryjjLXxS3eSmoVQ77f3515ZmMmkcDMow1GYd7yP60FzscX6rzajnJlfBJ+xy5L
 3BfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKclh3Ie+4ONq9fDFVAYqL/M3nNaJGQdsRj2QfWQ7E4FOtfQHtbxqKNB+762T3e3JhNBek1LNbWuc5@nongnu.org
X-Gm-Message-State: AOJu0YzlFNv0kvrK07YL6omTBBqDiMfe6+yaDCZMOjX/ehtbwGxLQQGK
 NN8aQY7pROF3MJTp1JwgPXX46b/wnuCOq08jbrJtxHwEW8X4I6fmgUpFnDJbkW+GZk0=
X-Gm-Gg: ASbGncsBWGe0NK5FluQkuE1Z9+tf+CUMrQr/+wYfYK+SLt8yZE69cYreOIxct4PGEgB
 icVc+tKinNvtf8Ri70WhLQva/EKxHy3iLq+5IUG7GWmZLS+aW8kG2d4zo/TGIf3OTobi+9WBp7c
 0KpTmYDO/nqf85SzdO0mnh2ADPEgYQfBdiPmUF08QXvHjQI2hSvTgGjHrg1X79XiXs9vbsbA8fX
 l2mVVpuS94HBsz5F/v+xg216iBYFjMDHSwpsuVjCDLEWz0a4lBCaQS2w3JiTc3Hg0EukNquqsSb
 JpbqudpZMfH5tR91Xh3tfRGU8sNuBdLUTzb/xo81B0OnXgzceei7yOMNv9qE3GcNN9eoB5AUL/a
 9INmrcSSDUsr0w99vilMd0oHFqSgKnqaTtxpGRUvXLlaPJyUVSpTlgHUwYUHJmsPDWM+hr69HaH
 JX2BOH1Ih3j62aoieXpYdJVQmEvGfMvDkZ3JG7tq0drpHHaMgmogHN1w==
X-Google-Smtp-Source: AGHT+IG9cr/kBTy+D9KRZLBnm0+J6p9Yl6N8jh7AMazMf2/9BRMNHQvzLYiAZBFcYN1QeZRcqeJE+w==
X-Received: by 2002:a05:6000:22c5:b0:3f2:b077:94bc with SMTP id
 ffacd0b85a97d-42704d7e9c4mr12946434f8f.4.1761146647339; 
 Wed, 22 Oct 2025 08:24:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496b09bc4sm40726075e9.2.2025.10.22.08.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 08:24:06 -0700 (PDT)
Message-ID: <c292db71-8f6a-4086-92af-9f2d19afecc3@linaro.org>
Date: Wed, 22 Oct 2025 17:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Pass actual memop_size to tlb_fill instead of 0
Content-Language: en-US
To: Nikita Novikov <n.novikov@syntacore.com>, richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20251022115213.91457-1-n.novikov@syntacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022115213.91457-1-n.novikov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/10/25 13:52, Nikita Novikov wrote:
> Recent debugging of misaligned access handling on RISC-V revealed that we
> always call `tlb_fill` with `memop_size == 0`. This behavior effectively
> disables natural alignment checks in `riscv_tlb_fill_align()`, because we
> have to fall back from `memop_size` to `size` when computing the alignment bits.
> 
> With `memop_size == 0`, misaligned cross-page stores end up reported as
> `store access fault` (AF, cause=7) instead of the expected
> `store page fault` (PF, cause=15), since the “misalign” path triggers before
> the second page translation can fault. This breaks misaligned accesses at
> page boundaries.
> 
> After switching to pass the real `l->memop` into `tlb_fill`, the cross-page
> faults are no longer mis-classified as AF.
> 
> Fixes: ec03dd972378 ("accel/tcg: Hoist first page lookup above pointer_wrap")
> 
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Good catch!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


