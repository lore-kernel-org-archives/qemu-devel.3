Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDED4C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc22o-0007n7-Rw; Sun, 26 Jan 2025 07:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc22d-0007jN-9G
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:47:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc22b-0007ct-QL
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:47:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so64585295ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895624; x=1738500424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QIAPL1pMk8OSHWDEGQ2zge5zvjgqFB4uXwdxce+MT5Y=;
 b=jYYvksqVFF6OajNgb4hg+kUUl5Ly+cs65FXf/0rzetiLMa1xZwMX+P1vpoukKMJy99
 E70I4viIQejnfRN+JcVBS9GM0B/hQH93I/xisdzv/UHV7kTPaKm+RGsn7mgkqYPlUd6W
 lln+U3zcmhaIi28CckqCg3jKiIIgMuRFAR8DnMMe3RakPSqIlKtIFZPrSBMI+XlLYkDr
 RHZaxLI2VXA/PRDtrAbNETK2hlODjoSn47OiwF3gRdmMwZMkVYfz6oYxgaLHxab/UBTl
 tmwfdTQcEyPe/3K9ZOGU08+6m6IHGeoexy4UMK7N5kGY82Bo7afqtUcs1WP4dxrADMRA
 +cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895624; x=1738500424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIAPL1pMk8OSHWDEGQ2zge5zvjgqFB4uXwdxce+MT5Y=;
 b=Rg6jN51+BNt4uYjFigUQoh02b1TX0ozJxOn4XaCe2u6zS4qUsq5xtsSD6A5eWR0J7U
 gvGH1zuijmMzXC+MMoqGf+NJIDHsOM4ryLhmgDaVS+ocfvnGj3WhFO7rr/WCrSL/aRfs
 ydzemOWXqvp2hXuSPLBh4OCAKlpnFUoz3bBUqxROkFKs/I0dEUcSGRnyXKXoSYlA5Pdu
 RbqoqmOP6BIm2a3GDizC2D0SctsphNcpZ+qE99nwzUU0CAMCLn6fgFqGJjGopCG5ppef
 VuWqdYQn2BvDYSbC7AZsoj9uZk+GG/0hN3KI1BZoKIGUwpxyMPUmr/HgVAg7+8lraNqb
 tsFw==
X-Gm-Message-State: AOJu0YyDJuy/DRQmxdFw/9+Q4weJWFmEiP5Iow/rdGWLNfbiRvUUnPDR
 6IcJ+e4xzfVdKfzUb5z/M4HSELfoj+CZXf98l/DboyPs/R5eVyC4vRe4ovv8sQf0/dUzEbMKtIk
 C
X-Gm-Gg: ASbGnct5c6RBBIJNax8qhTOir0GudGomMWMRdqR8mk917nQyxhAeoxjLs6OiWTZsBzo
 mO7ezAZRT951heAAQsO5C1EzNnxcfOCydD9TX/4++Yz0+UC0Gzh8abhqNShfr3wH6UcZCJ2AnB8
 W71K798cGmaNl8Djnb8kf7Bg5/zJQ7rWMWuQeVQNbDZyVq7eJVqb4SWlrdeHQGHpnnlZ1hE9gw7
 ausOHKfvb58WFcqBliyMo1gRAGX7o9YAcuPfTi70RcMxsz0ka6mDuslIWKeJNHtlRB1ufRuwln8
 oKRKXyzacgVOKAaZ4qQgjb0=
X-Google-Smtp-Source: AGHT+IH12cSd1tGmUdeNovOJjw4piEF0QWnLEGVulov3pjFIjui6xyC+us5WKf6kD+daq+K4FPDCSg==
X-Received: by 2002:a17:902:d48a:b0:212:67a5:ab2d with SMTP id
 d9443c01a7336-21c35604a08mr684339665ad.44.1737895624278; 
 Sun, 26 Jan 2025 04:47:04 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da413f474sm46023815ad.130.2025.01.26.04.47.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:47:03 -0800 (PST)
Message-ID: <930f5644-80de-46ad-a57c-7bf7a7a50fbe@linaro.org>
Date: Sun, 26 Jan 2025 04:47:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/76] target/arm: Implement FPCR.AH semantics for FMAXV
 and FMINV
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-48-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-48-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the FPCR.AH semantics for FMAXV and FMINV.  These are the
> "recursively reduce all lanes of a vector to a scalar result" insns;
> we just need to use the_ah_ helper for the reduction step when
> FPCR.AH == 1.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

