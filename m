Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A7BD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfRt-0006Nz-QK; Thu, 14 Nov 2024 14:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfRq-0006MU-RZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:24:11 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfRp-00017r-7I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:24:10 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so831107b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731612247; x=1732217047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWzEEnlQd4+qzmkCl9aS0fWcrCHVt1NBXqcmw/IuSSs=;
 b=uwY28sOR6jqbcBc7enHsYgTq+99k+1PCavPYCLKPDXE25RVSQIY4gTh8qUjFfDaWt4
 2PT4CS45agn1K5i3iZujxoZzDM/Xz/O8WIOykMlB5FgiRkVVL/FOA0JIq63EWNAFFdmj
 FbPE2ueBhvQe4f3GbwDQAnc2F7CnBd5eZpCMPiFbykyOyFykhq6g+vcw6zAliaJEqpvC
 jJNvGNU6oYnaeMlGF/9PbzeUeihNUM+7D7meFQ8CE3/F3Js7lKaAuD9lftGJj4BG4b1H
 RD9VYC3E0I2uU8eYYTBrbMR3O1RNp6FnlY0MxUb5LWcb+dAikAKwVLuXE8jCdPcRvq5c
 ZD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731612247; x=1732217047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWzEEnlQd4+qzmkCl9aS0fWcrCHVt1NBXqcmw/IuSSs=;
 b=k7P+0r0bqjNGUVJU9ZDxcfzfgbPH2vo+3QStlUPkg/4jH7sH0D1bkz9qFALUsi2Nek
 cOxNq748fz5qFLAeOlJ3rYxDw3XKLdgCyCtmHOPGfcVlTOd3NMtOYwUqowVbcm1FgpHy
 d7Z97nR175Infc6OJsCPwuAZBFJhGtxQcmnoRdzaCVQTRAyLh0gpzg2HmmrjHRRzS3oh
 iuIRwx9uSmzGAZOPuC8fQd6RMkSAY4f3e/8IQNUZg9JI8AdF/2g88lvi6j+u1VMfoyLn
 nb2NX3DSMh3bnHaMua8kpuNm5q4i1pSuDKhsLD3gYpIgujNSEj1xsKt0ylwuegNURfIM
 HZHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7zf+r1A2qg2y1kDlGnPmro5PN1yD9QePLgQfPt73i0BzBvzSQZobVRftJD6KVNihMShkeJWhYPkO@nongnu.org
X-Gm-Message-State: AOJu0YzLKSiD1X173BfXsm2bjxOL7wLELrc2F3eJk6mS43drFKURYRib
 E5Ar1LpdZqG7evXiK3Pfmm7HSm7V3550uT6ErN7sNbduT9bWAF5qVecQtmkOQ3Y=
X-Google-Smtp-Source: AGHT+IEFNzWQS2Ydh+tt1sUmQqj/IC9+BHv7wRXaOAxzDkVw4G20S9b0lIu4eFluAR1M27fMoJg2Vw==
X-Received: by 2002:a17:90b:1804:b0:2e2:7f8f:3ad7 with SMTP id
 98e67ed59e1d1-2ea154cd17bmr92862a91.7.1731612247433; 
 Thu, 14 Nov 2024 11:24:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f1e24ce4sm3506278a91.0.2024.11.14.11.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:24:06 -0800 (PST)
Message-ID: <30f61376-41c2-4461-9e56-3f98748fd871@linaro.org>
Date: Thu, 14 Nov 2024 11:24:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Move CPU TLB related methods to "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cputlb.h     | 23 +++++++++++++++++++++++
>   include/exec/exec-all.h   | 22 ----------------------
>   target/sparc/mmu_helper.c |  2 +-
>   3 files changed, 24 insertions(+), 23 deletions(-)

FYI,

https://lore.kernel.org/qemu-devel/20241114160131.48616-53-richard.henderson@linaro.org/

unexports this (and related functions) entirely.


r~

