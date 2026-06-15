Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1EACD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCI3-0004Uq-GG; Mon, 15 Jun 2026 14:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCI0-0004Tu-AZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:44:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCHx-0003gk-Gs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:44:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bf2e8ccca1so23708195ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781549040; x=1782153840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BY7ENNqiYeIW6PVpB6sL2MM9C6bHsXqDktxjvWSqMg=;
 b=Vo1xSKla0SywzgY8mOfADvAwxZaGpXe4guqByCNML0eIgki8JPMNesK4UWjFBlTpRL
 Ql8Lq95tyZdYzuM+Qj2Ii0FnubLYS6oXF4Xm4zVCfPlSWCe5iTOsrwtx5TCUERk4NjdG
 Q8clsgD64b9jwEGIArp6/r/o9gcVOFeI5Wujz0MpCatJHXuxb39KuOHl7B6XmG4ZJUg5
 XAPWiVlG8pPa1daX2Agjs3Fa+Qik3MwP7N7Kfu5+4Kb3xMbMm7bvFp3CP2tSkqFU0uPQ
 s0NBvQ7xN3KcWU6uYs60E1GjcJn8hwY4Ponhy7jlRJ0TJzn+LWnF/z4FhMtdANqZnqB0
 DIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549040; x=1782153840;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BY7ENNqiYeIW6PVpB6sL2MM9C6bHsXqDktxjvWSqMg=;
 b=SuQX1HMp1tGV+w/vvzAL0kp8NdMbLxK0+boKZE8+G2OrVPxUIgbUwGVwVUghwrgz+R
 pP8Z9ObqDRvyi2IdJ+JXG+wMfZzL07UVd6RcjNtrTYj/xXM4wYPIbD1sC4xBAugSaZiU
 hCcqLKdlyOHSo/+F+YjX3Wdd7H1HDdCKyWJhOPJel3oryM8rQJjfB6xrWTjlUiOFgsIY
 QgVkn6RsxftaoKfpV2P95z4etww3vM8uT32IHzARmCynXhkiwz49Ydb2SP465sLNYh45
 Yjtju/1vVq3VboeWagDL/0ryvQIwQBQsfYZ/8eTu9g1ph+IHcnkYEddgBsAJF3rw+mks
 GaBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/P4wqhRosHkKSakqkZu34VE1QiUw9/GsUAu8bn7rq3UuhaTGqjhlBLLlViHSozJ1alT5DY6lnTCnSK@nongnu.org
X-Gm-Message-State: AOJu0YwmZUZU2ZvOuqHQfgtj+6rNl0drMEnM6vfyMtG2QZl10yXkL/nv
 AMITPnPZqS4iSbazch9QwKHEkNJ4r0j1koaS3rjQCpHSgk3pXqwE7W9wVclOwsbTOeQ=
X-Gm-Gg: Acq92OHsGufCDR71Ox1+pgt7Y9Uzhdee61F7+06/SRkerDf5Ig08Ezf5boPqJzcl2RM
 4IppLbSGct0xaQWW98sYgkhvu3hpBSJSBKFco/3yxHIpJFxC8XlcRzyh1uPpryMQDnlfLp6jViZ
 NL1Y4cH2PVdRtBV5RDWIXatoDOw11yynHkiOU3uNr3OWbBnALpivmAlucX1mSXK7qouD36C0M3l
 j4bjyTAioenpIpnVIu3hOBtR1KOLS9w3xVMJLz3VZpfd3Pzch2hISb6TZ/q9X7B42lbBhB+cIkL
 nb/KY1uHdYqYd2JDvmmwQ/OnegRee+mVL72TmadjOAYJrvNvRhFd6O6gZnmPhLWXmuMJ5qnv4cc
 SPpDRcSWgPkLPslR5TECFzLBsY5n64LbDqrD8iPJf45nXwdJnotik+avK30FfTuJ6Ggt8wIGBry
 F5O+W2v12tv3QNDGZMuLNNNTt0rU8g3inYF8NF/z+4y743yYROemVPXqdAUQe8jR3yHLOW
X-Received: by 2002:a17:903:1aad:b0:2c1:2fd:47ea with SMTP id
 d9443c01a7336-2c69a0dc478mr5127425ad.4.1781549040042; 
 Mon, 15 Jun 2026 11:44:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433558449sm113196005ad.78.2026.06.15.11.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:43:59 -0700 (PDT)
Message-ID: <79ad657b-ca2d-4e79-922e-c04e0b76936e@linaro.org>
Date: Mon, 15 Jun 2026 11:43:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/s390x: Factor common s390_ipl_read/write()
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Prevent duplication factoring common helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Cc: Cornelia Huck<cohuck@redhat.com>
> Cc: Eric Farman<farman@linux.ibm.com>
> Cc: Matthew Rosato<mjrosato@linux.ibm.com>
> Cc: Ilya Leoshkevich<iii@linux.ibm.com>
> Cc: David Hildenbrand<david@kernel.org>
> Cc:qemu-s390x@nongnu.org
> ---
>   target/s390x/diag.c | 41 +++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

