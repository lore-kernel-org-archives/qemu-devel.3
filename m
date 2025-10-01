Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FC4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4403-0001DT-QS; Wed, 01 Oct 2025 17:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43zv-0001AO-0T
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:04:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43zk-0004KC-2q
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:04:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77e6495c999so421817b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352647; x=1759957447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9XFCxpFTs5n3pKyc3+ovsnuFiQyiP+5TOIkYE21+Yk=;
 b=m948eIOh8mMGXaOdjW2S6qZzN+2hagAlyEGJ6s6xKGEKtWrs1IdBL4ORMeCrP1ro26
 kQxvmMt8ACLlcCAESIL27t3fLhIEPa6u/zbjkF1CmEKuKsuWvU3LvpM5UXStASR/hqCU
 2s7ynnh1NpIwpqVt/sdhZt/PjJbTuDR7CkzfW+af7V8pn4PdDylKSXyO+JZeHgbkvael
 Y5VbZOjK6/CM/TQUOqLAoqZlRif7zLO1ROWC0VfubWgJsRoKzAhligTJ1+3KnyVBwCU8
 fRTcSlN9QAhWl687fFke6f7yb1Ky/oR+FCEwXJNwWJOEQSQmCa3OlVCHNOKYr9By+xIh
 QOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352647; x=1759957447;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9XFCxpFTs5n3pKyc3+ovsnuFiQyiP+5TOIkYE21+Yk=;
 b=K5Pn/29ZUaWbnnCHjczF+eWW7fRVUopiIJhvFI0uwklNYDkAc9pqZX+/Ytf8ZIqqxG
 D5zg0l3adSiVnok1ib2HGw+Dyq4urojFjBIRAFlRpaF75HNAc0gM7aXWPuZ0p64st+Wg
 Ucw/6gyJpS2SfeI0TLtZXEZKSsjWoERzWyUeskpH2XtdMsCV6ylvS/ig9254NRboTEZ5
 rhjBdk8cNv8/cu8pivZTWTVIHiEmGJ/SRKwLOi9iNj1HGJ8PdWwMkAkr5XbFTKZvMxA4
 SauKvCD0EKjWzDDQ/uCvP6ZWFcGfCTEO7bGu3XnZnIRchb5j+dfzQG977v1iqu5Xzrgm
 AOyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYh2aBLvY8JOFnvROKJ8Q3gJab2R/OnKI/Y+wFM9mXAIi6ftQ2SIIJxHuPCugnurbIF+zNTYILRcrv@nongnu.org
X-Gm-Message-State: AOJu0YxayEezp4OWlL8MgSWmY0PRKhz7zrI8s1WAGasJvjVla5BFtqDX
 Zs6Ss+KcXVWtmna+oCMRocRoUMMK7lSaCVVxSk68tCKCsHMie3dCYZOGEZH67JONa2g=
X-Gm-Gg: ASbGncsXMgtAwXIQQLPxa19Eb3izrglfv2j8UPYd1//dDT7ZdFLXLCn5lvMWpyYUsch
 aAIGB+UK39sMVnKI8LutEsLa9HN35k+AsX6tKSh9kU5CW3RzKbinbL7U/1V/21GSbkkwT312Sj1
 lm0etEWSFyDXUfxTzt8EupSsH8J7RTmUfAU6Qi4urOJ/eXYqctGDIkzzq8j9JJArWtdgum6heDl
 6d3olP0uUplvc6a9XdLKsxGq0E1x0BJg6yA3l2vZ025EloS+GJKAjPfH2vi0mn3QOJ77r7G28Hk
 Nkf2Twu7KlFpKlt8Kp7vJnkHdDF3gj7rayiCrdOVN+Uq5Ov+6cVlSbijqolKBmnx0WpwBQ5144o
 mJJYcqyxsrEuC/gPSTQ2p+kG+D8NqoN7HVxHfASOmeTMtmdw7pCn8yoRMmzKiKM/CtPAx4ZE=
X-Google-Smtp-Source: AGHT+IFZi9hBFX4bMDuQM4hhXPrcVQWZ09HiVl5GCehsB3MjmubtNU4WWWEcHQzhy9ryEbc5P1Q8dA==
X-Received: by 2002:aa7:8893:0:b0:77f:3db0:630f with SMTP id
 d2e1a72fcca58-78af425d26dmr5363134b3a.28.1759352646769; 
 Wed, 01 Oct 2025 14:04:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f9cd56sm594019b3a.2.2025.10.01.14.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:04:06 -0700 (PDT)
Message-ID: <c37880dc-1d27-4213-aa31-19068b437a98@linaro.org>
Date: Wed, 1 Oct 2025 14:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] system/ramblock: Move ram_block_discard_*_range()
 declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>
References: <20251001164456.3230-1-philmd@linaro.org>
 <20251001164456.3230-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001164456.3230-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/1/25 09:44, Philippe Mathieu-Daudé wrote:
> Keep RAM blocks API in the same header: "system/ramblock.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-common.h                 | 3 ---
>   include/system/ramblock.h                 | 4 ++++
>   accel/kvm/kvm-all.c                       | 1 +
>   hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
>   hw/virtio/virtio-balloon.c                | 1 +
>   hw/virtio/virtio-mem.c                    | 1 +
>   6 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

