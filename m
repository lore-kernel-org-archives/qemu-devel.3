Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D06C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdZP-0000bs-4J; Sun, 18 Jan 2026 19:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdZN-0000V8-Cm
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:56:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdZL-0008VI-PH
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:56:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so28071915ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784194; x=1769388994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vb0BdIsaGsRtvJ3FrH8H5E20/XUlS18dS/O7ITq+bNM=;
 b=fv9wkQ8Ta4Qc3cSga3hiral5jK7Fl++WfIS3W0e0WtGL8h27SiDKJujS3ba7TfJMPA
 IMYegrfqFNx7DaqxG/o/JdfxQaIVLQqtJu6+vnHVqq+btX+0CYkRvjIjAot2cAYHTVFw
 xlerKAZnfe+QuvjxON3scoJIcEvkKguSr8qUaaSjdtzwNWBJ6iBF/7vDO4HbTlKGdzth
 xrJrUmLMfj2Vbkxz7YiTuqkP+GRi8m0wf4yAqLuSI5xq6xWViINAZXsmo0iFvM3VxCW8
 8U0aleSqb4mLi68yG+DFmvVbrlVD12lPLWdU9IF/VW/nM/E073bRvv9sWjHjsr3jZ5vu
 7MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784194; x=1769388994;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vb0BdIsaGsRtvJ3FrH8H5E20/XUlS18dS/O7ITq+bNM=;
 b=MGbDY0HO1mpJ+smqFS/k0PHOM2dUaGfS/z8e1VfUXVmFFLbb357kLbJPO6LnUVJZKO
 S2lWh9MAH6Wg71St7hsNaG0hh6DwmI6sExm4UBCtsS7okN/j7H8pXQ7Ksa32ovQS8Vc1
 56/wBk8b8mz5ak1ztI4cdf722+wEV+LwjTA1npgQA7/APf56F7qlRJvvhKnEc5yF/Qcf
 aoyLIbSjMHRjMNkAp1sKxOEu/INdzzhojHRE/5KakUKoo046xqSABbQ+wGOslIznPUDV
 doAXs78VCNTFfMN3RcuZWvQiyv/7/3QzlY72CgEk4kX8QZCN2PmDMOAFM9w1MO/UXXSZ
 gN2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc6GEnKSoTP8tt+a98hDM9YgsSNXCLQuyShDbvJBDRHnd7W/pP3Rkg18BHENRquW0Djnyw9pc+cCm1@nongnu.org
X-Gm-Message-State: AOJu0YwE8+VobS4aKrHYC2kPdeCMzpCVpHSmVJZdvpdLn7GfZrLDaD3t
 0ZkvljL2PiM7UR9Aa9ouGoN1NcdZPBCK5se1U0OCHhbn8OUJCp60kmVh+Q0Tm1TPGdI9SsuXxhG
 pbZG1upX9fA==
X-Gm-Gg: AY/fxX6JfXXrtNTAnBxTnqesanSLkWs6fxciaTpOaB7r9c8MlKrV802ExRy51idHUE6
 8l/yh5EGd3jRY4rk1+bOKCDqQU2CKHHzIkovcjEPZFBfF2fZIbYyof//g1cMOpwQqA+QSb5fRUX
 3YurFifHQAuAV5uj3SmQyXG5s+Dl0+NNRNR5kKC9L4pC8zF7fpYozWr3Ks3iMq1bdtm/1KjxaTI
 CYkJJ13l2+SH/KfFDV9TV13ECIogKcPoB35X6hEKKNxd73ZRHDx1SYiY4vgS3OKgvaOdryDq8/E
 5bOYojjFlgDoblBmr0F3YoTZkE6xaYGxsrCOVo+xjLprjN1gbK+hQfWXE8kX33U7wUZTtKzs5fQ
 dJkxMZFP/BE8kVVw6uHHnjRdoZOsM4obn1re4DPnjVCVcPnpnG0ZPQ+q6m/piObasuc0WKWLXot
 7cJBGA7Ta/XdX4kGfG1bLxkJRsLxu7Wg==
X-Received: by 2002:a17:903:1105:b0:2a2:ecb6:55ac with SMTP id
 d9443c01a7336-2a7188583bemr86719255ad.7.1768784194111; 
 Sun, 18 Jan 2026 16:56:34 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190abc6esm77130965ad.19.2026.01.18.16.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 16:56:33 -0800 (PST)
Message-ID: <f5cbb740-24af-40e1-a152-78b16c6b93b0@linaro.org>
Date: Mon, 19 Jan 2026 11:56:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/i386/tcg: fix typo in dpps/dppd instructions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> Their gen_* functions were incorrectly named gen_VDDPS and gen_VDDPD.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   target/i386/tcg/emit.c.inc       | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

