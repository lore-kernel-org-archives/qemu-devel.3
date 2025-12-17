Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E7ED66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwtz-0004kh-Us; Wed, 17 Dec 2025 14:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwtz-0004kV-Aw
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:09:35 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwtx-0000Yx-Mk
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:09:34 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so482239b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765998572; x=1766603372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0gcgUFcIy0Rl998fbvewGR5lW7JgEQupnjBQ1p4RVng=;
 b=iJvexFMdMGNIJTwidlT8CfEbASM3+0EfLhT/mf2JEZTFlfPtcPHqcaC4EB3RfqiQxP
 4l9OaP7/5zWGYunizGrlbcO7pp47GNyDe7c8XyKnng+FjNl++SfFkcL/lWUq4SAbShdY
 gGNKElWApFiw4nROlcGX1yt1TZyV417K3lcjfgNWH+ST63rUJNlNVXxUCCq4uwUWe0Bp
 FkJ3XNjj7nQT0xdx/0pObbJulnF51Y5Hl1gek5oIL20TaYgyo4uxF4om6b5/s3uWEeyf
 cJacWbhZTCjp4PgxxYqF08gjTGutGuBY62K07MJbE8wF/GgtKVc2hQLubMBRxMAbrAwb
 Lwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765998572; x=1766603372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0gcgUFcIy0Rl998fbvewGR5lW7JgEQupnjBQ1p4RVng=;
 b=G2OaTVbjjuIc6iwVkdQ/k2ePzAx3viqAfPvzKMlsW631OEKte99rsW8mwsJ+qyN1la
 ki89/xlv9puhcAgF7qAuyD5LFgALkh9bD+luHtQbpthXA/ha0xKmPwvWtysVtf/gACAQ
 l/eL390MiFbuQ9XNYE0SEJILdBxAyIF9rrYtK5lj+65YdP/dAgs5WV/+d7N7THeL4F+E
 83MXxpCKF5odaaCSQyONuPmvL58EVCZuI+i5fMryRYavAES81L9EK217Ufr4oIhXbOjX
 pMySzViGvXQ3rAZ18ZizfmLcS+xUaBLY9+BnXWVnoS4NebTsFlEN0SlqGLl6gAWAQwqo
 j0RA==
X-Gm-Message-State: AOJu0Yw7WnIWhYDX95TXVeWymTVsn9llUROWXgK7ty8cJ26AveTeS5Bs
 FeEGKCfX2hwasH8mtf63YBxpnmrvkJ2tocs7mhW1ApHjAXDuymmF+JngSfhIMNrog9CL/PyH+L+
 utXRADJI=
X-Gm-Gg: AY/fxX4Y9+n5zmJtVNaqvmRJfdYQZNB4iozumITPFp4L0fdU+KnNOzBQhn4hF1gRU11
 mWjBZ5N/aYQQSXZGKYB/eUs/mAS0ey0Y1jk6onUZSAMfimjr7N9n496CdvFtcX/zA9HzJ1vanzh
 7n3GPTsWByBDBMj3RoVWo8DDDoqhlAU4vUSsskJriBO+T+jkAqyndm3t00/AUBCx/XN/ioMzXZT
 N6LAzCF7PmG0CKU666vwdA2ekLWx9jbB96ZcmbXojbXHqbbQHIfWcEG21oANPCEVP4n+/sQZWHG
 n9KCz0s3bmmN1VVvOyBHDrP6gpZliKZOqftd+y4giuD7GzgzKfgGZYsy9ODnqun5zzIpviutiEP
 mpp15omneOgO6+AWYba41+c2EOLgU4ZOST7ZjzypvKOhmbel3Q07YiIw7W8Mx+7PY8eDxiq7S3V
 dQhqF7ntttrCrGu6oQrmh2lAITlj2myA==
X-Google-Smtp-Source: AGHT+IGw9upkc8rGJFXChsj/SHkJJwIpWWumE3Wx12jx0p8M1YG+6UzpO3a8bzF/I038tmdwu5xJig==
X-Received: by 2002:a05:6a00:2295:b0:7ab:242b:95c6 with SMTP id
 d2e1a72fcca58-7fe0b73a291mr425067b3a.6.1765998572060; 
 Wed, 17 Dec 2025 11:09:32 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe1456d417sm196556b3a.58.2025.12.17.11.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:09:31 -0800 (PST)
Message-ID: <50046687-efa9-4dee-814f-31234bee9cb5@linaro.org>
Date: Thu, 18 Dec 2025 06:09:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] system/physmem: Inline and remove leul_to_cpu()
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> leul_to_cpu() is only used within physmem.c: inline it
> and remove.
> Since @bitmap is of 'unsigned long' type, use its size
> with ldn_le_p() instead of using HOST_LONG_BITS.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/bswap.h | 11 -----------
>   system/physmem.c     |  5 +++--
>   2 files changed, 3 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

