Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E234CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94PT-00060z-7i; Wed, 15 Oct 2025 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v94PQ-00060b-Se
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:31:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v94PN-0007W6-LG
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:31:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso49201635ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760545878; x=1761150678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReruoDdoSMJ/N8lj7J7WuJkfs4jH4DGBRGBmJVyCxwE=;
 b=v+3X9+LJnz708FYs7NR8hkwKhIFP1ctGQXuvoHaAIVkW/3NN64Qf0oE1lx+hp8m8Zo
 5p85F9Gx5VCVfF7jlxGDLyrvUxdoLdzkVvmGkWBge4Of9YJJu6oKh4XGd6ZphLDmW8dI
 T8uh0h84Vr/Y/RD0W754GS2nK+rgf2jHQqVQT06cpzXtZDp0Uo9B39krMorpEFbCYr8Y
 p9DfiGaF+OiTH+jpk9xGfbgNUIsYxJNpWN9Igw1NXuKULLchNws/zld1Jn6O+vVAe/XG
 mqU39IvzRTE9GcjCVUj+1XrmxTeD8wWiwYdyDgM9tWg+aNLk0QwxwxsYKYBga3TlZAAs
 ZIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760545878; x=1761150678;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReruoDdoSMJ/N8lj7J7WuJkfs4jH4DGBRGBmJVyCxwE=;
 b=QD17kHC+B7eyH4AR3Vn2vjPq57LTR01pmXj4u3V8qmYCd8vl0NAttwxs2XGlCZurAM
 oQO4QfkKq6ATzPhutmtlal7a4xVGPT41K0nzUJMiW67ydjntJ6jTmXtr+6CbWX/iHx1E
 wIKu5l5Koo+EUPdAq1xyAELRrieMj/XVPtn8EwXLMpWg7F66+6SyOKCvzHpkK1V0eV2V
 3eGc0ZBGiR9ofkMSvGJmvJCqP46kzo4cXBv804rghP+t7ZuY7FggAIE6/6qvMRs964WB
 6Oy7fYloydk+yjhy6v7stAURno8q2TWMM02b+hapJxKPdH9zqPi19h+h3oYhATRZrK2t
 SwOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAYyIUsRknEGlQ+RPbmzjjJCriWfwIoM46Wp2uqgu9jneiVOQiRLZlEc6F3v8bK3BpyXbly10bkd7F@nongnu.org
X-Gm-Message-State: AOJu0YzA8qXSAEKmQdxAfGEwSJRr1GbpJTz93SXOLQmSDWriUZF6KJG3
 2oMmh3pYOnuQ/iZmNLo2d/P6xkBh3oZksKnHYxxy2HVc2RHJPB/uzEMj2ev0r+kYq3Q=
X-Gm-Gg: ASbGnctkZHh0rl9WfzfLspNjjk5j8b0ez8NqC5WOrmrxZvDeIey6DS7lx3OTZCQt88T
 qAQReYf3qOfPnqS9OrEr1lr8mLcNY8raB0L1cbL092Rao2tCG2SuAJnQSt5XM9nXT91fExagT1x
 Ruodjflgbyt1hqkau/vAYWGjtyTRyYuwzK44xswhtV5QzRgkE46gT/XEWVu5spiSxXyeFe0u+gW
 JEZ4u7LUn5Or9qHOO+LH7l4LARn40goj61o9iQMuvAmxkWQ7yDtDxYhyL1RJzPpuNmshCWCbh6E
 3UfHPGsoRb5BVjFsUF4ezIPlRsV6z6fiSMKdmtlQfy4t/+gWggtpgHfGvvzheuswdbdsgUhZVb/
 sPp+UNCGaaSgYOWyyGU5pFnWeHgXYWgGqBnU1rqSGiOqy3xEwUpn4Lxu7gpA=
X-Google-Smtp-Source: AGHT+IFCB3yfgp2HVl+Q4sYWTffMo6p2ZfXikWgpdGKEJTRBNhK7Gz1PolRlWRYpx/AO7pgPKv5jhA==
X-Received: by 2002:a17:903:2ecd:b0:28e:cc41:b0df with SMTP id
 d9443c01a7336-2902741fb25mr321416205ad.61.1760545878317; 
 Wed, 15 Oct 2025 09:31:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a228aca0csm89509a12.17.2025.10.15.09.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 09:31:17 -0700 (PDT)
Message-ID: <1fc99217-f1e3-4ad9-8f67-89ab47995c98@linaro.org>
Date: Wed, 15 Oct 2025 09:31:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: Replace target_ulong uses
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-2-8b416eda42cf@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-2-8b416eda42cf@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/15/25 06:27, Anton Johansson wrote:
> -                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
> +                mask = (1L << (target_long_bits() - (va_len - 1))) - 1;

While you're at it, long, via 1L, is always wrong.

Here, use MAKE_64BIT_MASK.


r~

