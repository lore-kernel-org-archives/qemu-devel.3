Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191DC27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGN9x-0001d1-4J; Sun, 09 Jun 2024 14:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGN9q-0001be-SQ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 14:20:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGN9o-00078a-LS
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 14:20:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-704090c11easo2494783b3a.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717957242; x=1718562042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OgoO35tj7FwAq5O/zs+5NGQXqn5akRnnw0UN4iTd794=;
 b=VyOEu8YxJTB/G+6fZX76En7FZd8wTYvoMlhczk7O6CjPMQhcekatsGVjDki+iMaKVP
 t9INKnn/x08ZGPpaVnOxR3bhhdX0k3zogbFbCIe2F1uHd1QTUnm/K51xVW5Fotfdov7/
 e+7M47YZ0dp/HUt5TJNJYRYCTRZJRrK64Y+jD3nmmGMfmUuxEwQE7yINHfB8o/w94WQR
 c01DSHejzx6Y9Vj7NnM+4zhjnqgrxQQtHxpM3c/LgczO5WgxhJyew4X8CpfVfDffJQ6H
 Z0C93EhKu5RqGxmq/4BRwBvuvl+ZY7EZ1PYvsoStMeWgeSSJEwL/LIFbc9n858qMLqfD
 pwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717957242; x=1718562042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OgoO35tj7FwAq5O/zs+5NGQXqn5akRnnw0UN4iTd794=;
 b=mpvQPln66gcpcTEzUjCMVUc+3beZvr/fxkKCsyFOKZFgTI2geWOO4mzhKtJlD3u3en
 cPwZReVJLNMVZf40uaXmTeyI8+swp4HLO34NG48dfDbPkw4jyD3xWs/3u4ZRIwCEGs49
 R4jN26TWrPuvnOpGp2OT8TAGRqBXzmIvPuyO+eiaU87o+WOF6JRlqG5qdqHjuzlQ41KK
 r40ZEr4Pguq4hpSBdgaM/kx+27ZFwPQ8i6I/uQ2FPlb0DHVt8tHbcZy8MsdheBb1GEk8
 YxCYdolqwGrfgSDK1VmL+alBKr5MPSTQ4xsjfXYwa4M+Zhtr1qcqnAd2NFSSJ9U9O/Qz
 Au0Q==
X-Gm-Message-State: AOJu0YxYlg4XCWJcb8yWgIjrNV5xOeWnmCdkEuTztkQe0nmx1soUzrd9
 K7Q8VwSEUOyo6vaDuwQOqSdRLkmDUEvlnkR6ZG6Ibq2nVKL1sBkGuNXHpUHBq+8=
X-Google-Smtp-Source: AGHT+IH7xnbz1qbPtY16cte+cJYVNR9Z3kabr201odJpKG6rrPRSH4AdJASqXrLsYrz8EjH/SRJHZQ==
X-Received: by 2002:a05:6a00:815:b0:705:964e:d9e5 with SMTP id
 d2e1a72fcca58-705964ee47emr900834b3a.11.1717957241817; 
 Sun, 09 Jun 2024 11:20:41 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70428c93f30sm2445987b3a.37.2024.06.09.11.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 11:20:41 -0700 (PDT)
Message-ID: <b5093590-8f8f-4869-8316-f4b294900064@linaro.org>
Date: Sun, 9 Jun 2024 11:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.vnet.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-3-rathc@linux.ibm.com>
 <91e78fa4-f844-4b79-ba09-46c722f35df8@linaro.org>
 <d027b594-6fcc-49f6-a179-25b479be2be7@linux.vnet.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d027b594-6fcc-49f6-a179-25b479be2be7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/9/24 11:11, Chinmay Rath wrote:
> The calculation of effective address in these instructions is slightly different than the 
> others,
> for which helper function exist :
> 
> EA for these insns : EA ← (RA=0) ? 0 : GPR[RA]
> EA for rest storage access insns : EA ← ((RA=0) ? 0 : GPR[RA]) + GPR[RB]
> 
> This is why I could not reuse that function. Also, this calculation of EA is limited to these
> 4 insns above, and only 2 others (prefixed insns), which is why I did not create a new 
> function
> for this, considering it won't be reused for any other insn.
> 
> Please let me know if I should create a new function in this case as well.

If you expect this to be used just once, then leaving it inline is perfectly fine.


r~


