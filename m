Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B46E7FDF3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 00:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn4aD-0003KP-MG; Mon, 02 Feb 2026 19:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn4aB-0003KA-R2
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:47:55 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn4aA-0007vK-3n
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:47:55 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so124162b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770079672; x=1770684472; darn=nongnu.org;
 h=content-transfer-encoding:cc:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX3SSCl0xlzlC02SqbJyizdehITJP6I3maOWkJrW2/Y=;
 b=cx7mTVpDEdWJ03eyrvoLg7kzRIAuIsSGfOKIsbWHSrdBxjZWyPC8PQ7gWokvGZIaSZ
 yTMiZHsRj7YwmpoPLXitfzs0YDuFgRD3qA3T9CJUF3ZVj2eteC4MhW75OzG9MHm5wjkk
 yiQ3tn3SGrvbHnQdlEe8JkOUP/PE3G7vfzyxSO92oskpMTxNnjPHj96Iyu1q7xZENYsm
 xa6ASXJ6lo6woFwftEC0QWRh93QemjJTxNGpwLyAAbdmYCO0Y4FQixH+Hr6PvwUUC6/f
 HW+fdyRKMdsmA5RwYJvLZB+SjDWo9CiJTscv7SBM+SXw3wyuPWY07T5EdHZd1UUyt02+
 y+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770079672; x=1770684472;
 h=content-transfer-encoding:cc:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vX3SSCl0xlzlC02SqbJyizdehITJP6I3maOWkJrW2/Y=;
 b=pdEy+rdqvwMjwsh/jWURO2Rfmpaq8C/G2R2ftYaJd9rmERSAogn0D3QpBb771q9l9K
 cphKnmka/R91sB0iKz7QIpzhjgQIjIQdRzRpfxJbBsoiGyouBfpniVjetMixUhEUMg14
 re+xOwVNrrgRM3/W+AabMjPC4tQ5VEMYvZQ2NRXByyg6RMwQ4YFdNmKEuvAevwOZZMAX
 4T4Ldo6WNZMe/QBkcXIeAUyVqpQpkDLIwdCmFj0QQ1st9EmfycWZ2GiuZ4Hg4xL/aBnz
 Qe+vJ290u3zQ+ROYa727uwBoZQCHiZJ0hGYlGdzKLDntMHRqgJKT/jHAWqQTJ6gF9Zm4
 XVgA==
X-Gm-Message-State: AOJu0Yydyzm6IISziU9/z67iFcZ6As1IpmYrFdA2+i7lAK/U3sVX33iY
 QXYPaWi1Za3UUVflWzMApXWKazTezr3L6QpaUbkM4nnZV7NAgz2ojhui1dPT9vhxz2vhpYytfYT
 EsSFEFFVl/A==
X-Gm-Gg: AZuq6aIDwmUEhJdaWoj3H3p5whIP50KKo0AqwyB/SflPUvAttdgyySnZA8rkTd/UDZo
 tL2wRj2sZwBcQ7hpITMzlpy7vyacRupfsUGBJyopLDFQbmuEmV55TvWfb5i1o0by5+3rvJwD8lW
 Mx6opWrGfzutsNM6qgKoaTGMwn5v0aML7Rlg+jRHafUUDer7LyQATqaTl3l8sUlAbsZ31Wh4jdb
 z5ojCWde7HOVtdsiHrxiPGAegL1xYyQe5R8ferXQSEp5eZZImCaA5Swq9BxS3XYColLnkmN1A1o
 +WXIEUJ4UDquht7jBxNgeREk1ZU7PYOxg7u0frpCkGYgM8U6EAYoWB1tbaULHuGUns34Rr9J2Pr
 uy4095TIHRGOEemmWn3akOhOTJIlHyNdUPef+wEvwoPzh9Nt1jpcNGr6tu4ivQMY1r+GSvHwq85
 6nPhbZgxXUNlTJHt9GTa/z+NDMdNnEhsFtq+Ypy2UddQSb5CLADJMaaT5JW296KYJqMoCPzOaax
 irNE3IbNJRvXCBoKvqjTqP7WngUURcWUpIG6ob89w==
X-Received: by 2002:a05:6a21:47cb:b0:38e:9484:4663 with SMTP id
 adf61e73a8af0-39356300067mr766696637.31.1770079672059; 
 Mon, 02 Feb 2026 16:47:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642afbeaf3sm15340904a12.33.2026.02.02.16.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 16:47:51 -0800 (PST)
Message-ID: <74094b25-73bc-4e76-a7d6-d41e2a22c6b9@linaro.org>
Date: Tue, 3 Feb 2026 10:47:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Subject: openSUSE container failure
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

E.g. https://gitlab.com/qemu-project/qemu/-/jobs/12960514743

Annoyingly, the gitlab pipeline drops some critical lines that show the error.  Thankfully 
I can reproduce locally:

> Resolving package dependencies...
> 
> Problem: 1: nothing provides 'rust1.93' needed by the to be installed rust-1.93.0-150500.27.62.1.x86_64
>  Solution 1: do not install rust-1.93.0-150500.27.62.1.x86_64
>  Solution 2: break rust-1.93.0-150500.27.62.1.x86_64 by ignoring some of its dependencies
> 
> Choose from above solutions by number or cancel [1/2/c/d/?] (c): c

It does appear that there's no rust package available anymore?
Should we just drop rust from this image for now?


r~

