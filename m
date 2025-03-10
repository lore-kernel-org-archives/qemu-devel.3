Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ED4C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgy4-000664-C8; Mon, 10 Mar 2025 13:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgxY-0005pF-67
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:30:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgxV-0003oe-74
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:30:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22548a28d0cso17837145ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627831; x=1742232631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ti7mPSqfdvK+f3qvZ/ax56ZU6iahsWKj8hnfl6gpqJ8=;
 b=rcCgG9AFfl85/Re9svVCnsxvHcrUFkGllHQ50teWTCBbb07DO5lSFSytRcAgtyZoQf
 4WQqKtul6qBxQkPQJkYmNG2C9m0i474e2YzgU72G/BPfX/O3kqAolxYRYUzt0FP4z+GH
 jfZX/5BHo26FM4qnSr9es4agawLTXE9bPrpV3KpUQt4Dc/SMHOPQOO4Pj23Td5yDJvxk
 epDm7wNGmVkTwwGe8n2aXx1n/LvzBGLBvSQwkqJeNg/co97fXUmXAjbXt0FvXeJsRUvz
 w4Cy23bAku0M21losS/CZV0w3g5Zxa0TYWeczU6i8TQ8R2Z1/k1kc5A1I3Nq5qKrIdoK
 NJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627831; x=1742232631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ti7mPSqfdvK+f3qvZ/ax56ZU6iahsWKj8hnfl6gpqJ8=;
 b=fIQRDkVFLjigFMq1CRmyUxjGDIKnvUyjzWMNZH7KtG2zF8Pq3DP8/tX9WJNnuv31JP
 oyCJTAu56x5071poDSfg8sjsDJbu845Ieaek0UnNLR0Ta38plOlQxcRHS6u3PAEU+4Xc
 Idd2emeW65cx443d5vztpHVLobroccXp1rSwvFFdBp2H6vF7n7ckUtPIYB1uPzXMCU8l
 MdtWo2zbtdEHuT0img3jhR7xS/1m+j4EsP2Ism2InIsFzp6LAIeKxHiBXoIIhrICmUaw
 IpzOklgBsY58Ayb0zhi2sqnc7hLrcmM9uUnXqJ1ijb7Lf5RSTjPl7JIX28NuBbwhXT2r
 zJgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV32FbD3NewE3Y0xinhagia466xY87Yjqs3P62dXixf3uMHnTQNXx/xLAyb7aQNuGy/7JWkgc9JEB1@nongnu.org
X-Gm-Message-State: AOJu0YyNYOVxvzvps20VZsl+G6CJrm63SQvUwKQlNCMO+5v6X2BwqKrQ
 aLZdGjR11cPtfezeaNK3qQYG5GpE0F0WI2uXE9Jaa6mqKCWqDA7Ajz2Z27bl3G8=
X-Gm-Gg: ASbGnctpBdqU9WgD2PNbN1FGlQCBlru6gkydm2psE9NXGBgmADT8a4G0KBY6DO03uAy
 xNyWHqUMP99PfGHPJ7+LpdggR15F5ecqdwHb8GFLwfwe3AnCua/kmLrLrbKaoMKEP8rbBFyU/bT
 hQEobQxBncOU5BrCm/sqep/uAsDK5TMTPdw0YkbTkect6aFy2fenWfzBUfHLUhA6xuDleBXGPgN
 nqphO/1QqddjRQdvJfmqfyk0JUB/tsv6KeJlS5Nn8uCbuJ8MYGEn0L80CXvd1jVDXZanOF2cRaN
 aPERTf41rRZ+ZXiO2E1jijA7oD8/Sl9HQRoYY6r6hKsoLzO128MWSCYrE8W3ik3n6XLqm1wwPoZ
 uD2O4lf4Y
X-Google-Smtp-Source: AGHT+IE+HMKkJ4TqNHn6fDHWEebR9FICmIEqukiWbkwDwXnzKD+ftMErLitwe0+e2rAv01GoptPQHg==
X-Received: by 2002:a05:6a21:6011:b0:1f5:84c8:5d03 with SMTP id
 adf61e73a8af0-1f584c85f0cmr4746432637.3.1741627831295; 
 Mon, 10 Mar 2025 10:30:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ca79944csm3723112b3a.87.2025.03.10.10.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:30:30 -0700 (PDT)
Message-ID: <aa4b7ce3-78bf-4a06-8ae3-36a7b5d823ea@linaro.org>
Date: Mon, 10 Mar 2025 10:30:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] system/kvm: make kvm_flush_coalesced_mmio_buffer()
 accessible for common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> This function is used by system/physmem.c will be turn into common code
> in next commit.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/system/kvm.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

