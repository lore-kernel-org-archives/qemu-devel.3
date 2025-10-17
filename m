Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DFDCCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 23:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9uHU-00038M-3u; Fri, 17 Oct 2025 19:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uHR-00037z-DT
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:54:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uHP-0008N0-8n
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:54:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so26786395ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760745277; x=1761350077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0MGIdZUf5+ujmBGIBnSyr+PbnxVz6EArYYt9DQ9pu5Y=;
 b=bEjrNz49cLa0G3mmkox1rfDt6FsaxTBRu0MIWcyNv2DLmNvgvdQUr3B+2uR8gUnNyM
 vTme5ZvUM2YnXcHkDz5Xl8zoPHV9lsZ8Soky+QL5/qalD3vvLS0UTfnHTtFw3GbEBN4p
 vVdFMoc5Cln1xt7VnH0D8AtgpvnArnlDXJ3j4c5vn4Ka7LXlECr89zChCfNYESCBNB5H
 ZL4+PnSllgtV8Hqqr7Ra9jdIB/cxh5CUyt3aWYUcLvsfRf9p0SRAsSI/lT5k6dwYGst3
 JL9lW04IRGbVH1B60omz7lugggGJubJ2AAfYVxYDC8gNAr4VxfGRyRDM+Ht+1Fv+OUwj
 5wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760745277; x=1761350077;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MGIdZUf5+ujmBGIBnSyr+PbnxVz6EArYYt9DQ9pu5Y=;
 b=g6hgDdbam3kZJgtfwHOM7+iDJWXES2LefXrW4E+zhUm97oLMVQJsJLGRCkFXeFrxlb
 gls14x4iG+pvlDP897QlytrQg51rBxGToeJ0HD6f9OwS7w19R+ND+zhSGXI9IzNl7bT8
 PC/Fr24cJHVZo7X3g73R2ZzBioXWOka2wzzjZSv+JNJ+PxmEAVZiubLQ41SBZmaibR/B
 +4R5MO9rDUcg8bhjjGP4gHowMMVtVK1g47rNMJ2JMGzYK9KXdYx5C/wNhK1CBMeUBEuR
 ibEB5tB+4phc3ZfzTySSN1IGdzN0HuGM4sLHovGAfd9k56xESYyiYUb6gAE7lFCTB7gO
 MPOw==
X-Gm-Message-State: AOJu0Yy16/hPdBVD3WgnFT6ZK9xGnjk/f+j4hOhkpMsK2ATAPh8Kk0Bt
 ioGHuJBJcbJq/KWQd3Ma6bByAj3fZagbYlk6QUusFad8k6VDcCAP7/xN/0FksxXOGRA0gDLr5Vi
 gh6v9mfw=
X-Gm-Gg: ASbGncuT1aCAazCrcZNqfaTCrYYeZAXare1+z7YnCODlE49OX1Nr0gqea5Gy69YQacZ
 I7L3wAQ8QbbD8Uq0Rr3cNFzPa+bO6jEMf83X016CBIWLmEPgOiy03wqzjbIzEH8j3Ie6LbjEHM3
 h/j3p8vnCx9KYm4r2a+4PPH194YkooVsXB8XpEmCQ8DMeiBjCpWGl95JL3Ya30ukIW0YboHotlq
 5EB/C2p39Vcd5fiIayhXHFEx1klhmGXXpE6HtHTaIMKCGRHJ2Z/V78jIYeO3GNVGD+lVv3qAnBb
 NMpQf3JXwkajtsw1tuXQlARGj6DCeXQQjjHllwRkH3G9UH9fUEhpvYfHmMblBW9z/s1MSzIMI5b
 39KokVIdpR2T+NV+gMMT0sOQM1SSCwe4xV6lvt+bVjGrvCWaLPYZy98f3CEjVt/vGqA6DTfqe9i
 Zq3AXFdm3bs+plDfI72mSGC46b
X-Google-Smtp-Source: AGHT+IEmdkQZ/PU5zq8hNPjqyRzuO4d4gMB+PZmpKHTCQ2aa51uBwmgAoj/GH0h2kd38bOrX4GQHnA==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id
 d9443c01a7336-290cc2f83a5mr68831495ad.40.1760745277201; 
 Fri, 17 Oct 2025 16:54:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fe2dasm7138405ad.94.2025.10.17.16.54.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 16:54:36 -0700 (PDT)
Message-ID: <ca7ec472-ac1b-47a0-9e66-de25b9e005a3@linaro.org>
Date: Fri, 17 Oct 2025 16:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] include/gdbstub/syscalls: Add GDB_{EIO, ENOSYS}
 errno values
To: qemu-devel@nongnu.org
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
 <20251017211149.163762-2-yodel.eldar@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017211149.163762-2-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/17/25 14:11, Yodel Eldar via wrote:
> This patch adds the EIO and ENOSYS errno values as supported by GDB's
> File-I/O.
> 
> Until recently, they were not documented in the relevant section of the
> GDB manual:
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
> 
> Signed-off-by: Yodel Eldar<yodel.eldar@yodel.dev>
> ---
>   include/gdbstub/syscalls.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

