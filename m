Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9336C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvlp-0003mb-Fw; Wed, 15 Jan 2025 00:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvln-0003mD-ID
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:16:47 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvlm-0006ld-3M
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:16:47 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so8615550a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918205; x=1737523005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eyEx6JgeIj7hkgtKZp2Dfobz4hmzOD0PyOttRT/5VSM=;
 b=YSlBMSvUHSzhLhdiuInHCnwKBh43zFTa1mHsXo8sUeVjP8KCdQTSD9mOjkSU+nwyuo
 1Mfe6OnWt4cjTKX2TftsZqy0TSZKSmT8CTa7MClDoCt5kpG8tnay2BSd5ovkw3DnPiR1
 FQTmNTVwURspgwXLAG1+78/+nqb6OSAz8jBt5JrKIFeZ0BAbw031dcxOQXWWzNpdVEJh
 xufol6zADzRYb4XgN3LnQZm1u7RzVa4Vy8vKYGKLXbt8eW+YpMHnWGeCrPk+8vVokXUE
 DGv+BE8+qavnlsqwBhVx+wEnQLoadgV9I5USQtIU5RC6OuYiqNSse4ysa2+sFxxc1nSE
 pmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918205; x=1737523005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eyEx6JgeIj7hkgtKZp2Dfobz4hmzOD0PyOttRT/5VSM=;
 b=qK0PQSAJ/+9o5Sv1xAQ1SrPKjrl8msz81fBs/52XAVCupOh84YSRKhNGIY22/a/7AN
 7Lc00G2GtuIy+AnFS4Lw1Ubu07KspFSUq/4SHT5RCDYTs8Il+YDXOXVUi0LgyK3uwFWy
 rWIxPmY3zqASq+DEr/flKKB0KAcNR+TutNRL/pCs+SUWHTFsuJ2jJ4E2Iv0TKtTZdRtY
 CjqEgRvJwa+SrpbP85H6hIJ6AnVfvmGXhmU+tbKVL/HRAotpoH94fKFR1lVCdao0HE9J
 PhVZSzinE7g6o1f/PzX/+n2nLYMWD+fa1QLu5X5QkF72ZkM+F+ka7lufL5nB7RkKKC46
 fg9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFi0Qd8GcyaC3e4p95u19SrJDs7/NSHF5Pugypuda2quYZR0K5YXGZRD7zw858nMdBFX4mZ7P1mODn@nongnu.org
X-Gm-Message-State: AOJu0YwWmYVhfa2UGbdG96qKHkdT4GPJ+4evdFJ7wwrZCOjS62HWR6l/
 NxZUitHVE4lGst0VqSZU+vbtrDoyu1IS31xkj4ov5ub+/QoBOeSvRJ/Of4YIf1g5NYyhrqFOvZt
 Y
X-Gm-Gg: ASbGncv3lsKw6oi+FcYE2lBL0546fDaipqw84d393pV3LlCTNuo4CPzPblxBIqT9dA7
 BO2MWW0i7SwvJ9Z0fLh9ScaYFiKxWGZHz1xR1/cVKkDt21uuE3SkNCKFPplaPFGbfIFO7jqtZF2
 Yf3e3Trdx1cDszavWhR7LakzeCtkWYdc1a8MwCBehEYrlXdwPn5tPb9KiTuLP+pEDknqw01IcDb
 5BSbHn+0WQkQ+SoJ/Ef3PBgHmuHcvrf/RdhZko+yw73YqnV4IaMpks/DnZPBqUU1hItUvxGlKxI
 ZYPfoJzuK9qyU5e1wWgsorg=
X-Google-Smtp-Source: AGHT+IGua2koMnXBWHGi5DX9PLGcbzSJ1+VjlcHlnFzhtiq/kbbDpWAX+JSrFzkJg1W8B671TGklsg==
X-Received: by 2002:a17:90b:1f92:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2f548f429e3mr38562293a91.35.1736918204727; 
 Tue, 14 Jan 2025 21:16:44 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c17f992sm513318a91.12.2025.01.14.21.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:16:44 -0800 (PST)
Message-ID: <c0338c5c-4773-4bf3-b3e0-f2122506514c@linaro.org>
Date: Tue, 14 Jan 2025 21:16:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] hw/mips/loongson3_virt: Propagate processor_id to
 init_loongson_params()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Remove one &first_cpu use in hw/mips/loongson3_bootp.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_bootp.h | 2 +-
>   hw/mips/loongson3_bootp.c | 5 ++---
>   hw/mips/loongson3_virt.c  | 1 +
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

