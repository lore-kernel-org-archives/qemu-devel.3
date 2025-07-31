Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8672EC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbUv-0004Rl-GB; Thu, 31 Jul 2025 18:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhbOq-0005v3-7q
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhbOo-00050D-Ap
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso21021665ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999515; x=1754604315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i6FAU78odGAfuQaqZCpseUf5N9EJSCttMrgfepPTdPM=;
 b=cBH9qx36FC2pj6Us9UVsjJHjdZtNmHpMrT3FZsPhNsK5O0BpOCMUPGXt6WXaYIpgua
 5lkvyzZdZUT6M6h0+YbVSbvuD1CAjzM3nnYMbxfCwuRUVEURTyY+h5y7jdUoJXzEotZb
 /3MSsRs94e/UaWNUNCRG8thZnLwxSEsX00HLWrMIyaAaEpSxfTRdKyIrRcrCm0v2UYQJ
 32nlRA27XSAyB0pWSvw09r8NKRL9Dq2HxoyJY+2QaZigstlWDhnqlP+hd9pGWaGHgBUe
 rRYYimCPQHjjLpG8e13bg0G6IxvCxNSkweKQPbhPjZe7q9qVAuSz+koSKlW0dZrLDxgU
 VsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999515; x=1754604315;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6FAU78odGAfuQaqZCpseUf5N9EJSCttMrgfepPTdPM=;
 b=B8dWfIKwJP3OSxsnZnuEuJRq+5nVO3BA2WROSu0ISmdbx1lsSDkV2YYb4fHPWvPYiA
 ajzb193auy04Ih50veiC5sAguLAFIJ/LOYvAcYs8MyCx//ylFtgX9ZM3YTWgBGal97h4
 sLq/kukZYvEBdSdawZXGr8DQ2L1BwTYU98wIbPaNaBPhOg6PYVKz7zrMDhzILnf2RIij
 Z5tqzynD+N1cWMOmckjy3tEe1OB8qtWA8x3XQeKFcP5yV3SLek6MCvkxJ/kefTmuo+92
 6QqRVZOLT80edqUcmzqqO5X3cGOnCIt8VgM9CWuLNb5KtedTpmdjGdLcGwrM4tzXWxup
 UjUA==
X-Gm-Message-State: AOJu0YzWDJt+ZztEVtf44pqwmmnFjunymCC49TY+xOPATZmA6wjzqepi
 n4KIBKtTC4TFIcY8C34ozNUvzUOG8K81FDr0H6gnYMm9c0cFjn60spLDivu/FpiU07LUVjgt/q4
 IhpS8EPQ=
X-Gm-Gg: ASbGncujIwTS9KQxA44zZatZdP09XtLEsFKk0osN5aYHoXTGHurCQgxFoNh26mM9NUk
 KdFR1xIIt234QcKoTRMdJGbQKAcasSmD7XQm9E/oC1A4QmDko37nD6YmY7T3hVsIaYzmXGEREn4
 7O7/oZcGtLnNzMVpdaZSgdQgr9utRWe6ZQ1L1AHwH5k9tF6ExAQokeZ/ST7xT3RgPs8ruRLpHs7
 +Gp7JD6mLrog+Bkd0iSQ3LFKa8afif8fpJ1+Fwk6Gb/YjHCyv36mFElv0TLlRWzFcIoHmrbIHJg
 tN/46mOirFqQrnd8BWReTVyVB2eOJe0qXSrX7viXTSh3/hQy8QAN8NUQVWIfxd824ESJ0EY470w
 FHF7clJLmJSeOXch+Lp9iUSp33GvUP2C076Fzg02r
X-Google-Smtp-Source: AGHT+IE1pnBwhX9OKe5xKEc1jSNT7v8f/d2S87606ViZ3KHwJjvgfMxRXYg+EP14R8Zw2FzBQ0wmsw==
X-Received: by 2002:a17:903:1967:b0:240:52c8:2556 with SMTP id
 d9443c01a7336-24096b0d471mr118172115ad.39.1753999515037; 
 Thu, 31 Jul 2025 15:05:15 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e897ef30sm26330415ad.106.2025.07.31.15.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:05:14 -0700 (PDT)
Message-ID: <92aac7ec-0830-4ea0-82c9-da79f2f9abfe@linaro.org>
Date: Fri, 1 Aug 2025 08:05:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] migration: compile migration/ram.c once
To: qemu-devel@nongnu.org
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
 <20250730220435.1139101-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220435.1139101-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/31/25 08:04, Pierrick Bouvier wrote:
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

