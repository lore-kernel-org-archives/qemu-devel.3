Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B946ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yIQ-0007hd-UJ; Wed, 01 Oct 2025 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yI9-0007fv-37
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:58:57 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yHv-0007xl-Fu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:58:51 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b57de3f63c8so4554821a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759330704; x=1759935504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fPeG+3nJU39wHJgDMjHdevxEKp72fk6EsCefMxQxrvg=;
 b=IAz4+Vvi5qyMQxBCDpn3XHvz6X9q4hxW8niNzVDPYPmWHXJvq7wizia2DHxsglHfeL
 vBFcH/E77SAot34QaZvskvKKlIy1SHhR6z/kkvhCgWowffnEkqrAXDa+3PQRyI/p8Wu7
 LGefoI55ejIgpn06iyjUqWdPL3XMOYJJG87gknqNXnNuynRhobw5snV62dRHMPgdkD7t
 bV866yOIVvVEmEoajWezg7iPeBCKRqBpKSos6sSDjaW0WQXME3Q5Uab40py2S+d+kkYi
 FgZWrQPFsW5VL5Hg60LFbWhroUUQUshJW2OjAruqZ2CCgIYMXOmmxRuaeJ9rO941b7dV
 R6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759330704; x=1759935504;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPeG+3nJU39wHJgDMjHdevxEKp72fk6EsCefMxQxrvg=;
 b=fydZwDoR6LYG3s+TaE7+BoGZSLVRztUrv62ooDOZl1nHF0sWT86quxf7RmjTZGInNF
 1Bq9WrZTR1v7JoPU735tI/Vip40NRHShfYa2jiPVGMVdAbYCh3W+IWCmGJAhxHoUOIV+
 uiPqLhfH0uarOUMuPtWKkkuYx9Zti3iNXAFO5/5PHxQPIJHXJpEvvKpKVyuZnprHam9z
 SKUsY1vQp9nlg9c54l8Qvb35J8dMRR2uJBJTlElve0f2x4Vcq6EAEIv4PyWkQVa74ghx
 jfbrPAmCS45JmKakhyfPS+ELPAreGIJYwXpfCvNyCnPbhSOOMNkFPWF3Nu+nJ6DIGQuV
 1qWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq02u/2KBQodHSmVMpYo5FtdqJ1lfibUKLCmDb0zCzF1IkATIBXZE9EzmkGgF4X8tg3Vvc81Kv8dTs@nongnu.org
X-Gm-Message-State: AOJu0YzBAOFELEsDzd6DiJkanH77kJnyZMA2Fydibt1pQDyBmWXQigOX
 PSLGQUqtptaE1E98AJKdzeMZRl9MF3ljFswTcQVH12OLaV0Sjn6ExT9rmi64Tqq9Gc8=
X-Gm-Gg: ASbGncvm4w5UReYtRWEpN426ulhCRzW8BQ5F9cih77gLsOfbrwjEnHQss1rIVyYNTnv
 4I6xbtX1D9OL7zzwoo6Edq/ljENZitiSX8hnSAED5Ihz9Z1oY0MuKH7VWV8j0joCscPpTdT6F+a
 HXx06mrVTEq60TL6Ing9/pl9nn+35rEnMTqf5SunnV2pdpILrbu84pdXsXxaggj3Gj48T0GLiDA
 g6gQSV8iU0XB/MEUWEX0JdVOMKjxOMPWLnC7JXjEr2y7lWf4ANFRO/RaGv+ddefQ+8FhB5zIliW
 ha/hpOpePFdEybQ3mzR+arWu+q4kgJSHrswTj9uRoInxVlRueCNZa7ydT0AlLKcdR1M4fAVAJdB
 Mo/iB2uCtWvfGs2wImfQcXqwvtpWGSa8Y4OcvAmDn1AtoFW4x65TpBTPWPhI0sMDIlf0VC13bA9
 fPZuU717Bo51f3QjQjNjb+mx3NZUhOYIM=
X-Google-Smtp-Source: AGHT+IEwdbLZMoFpoZVAuebwa9m3HOEoGgpuR602BV/V6VSi7DcN9b4pxFaD05lluDYs8GcI1HffKw==
X-Received: by 2002:a17:903:1c5:b0:268:1034:ac8b with SMTP id
 d9443c01a7336-28e7f2a450emr55912525ad.26.1759330704495; 
 Wed, 01 Oct 2025 07:58:24 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed65e8e89sm191471955ad.0.2025.10.01.07.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:58:24 -0700 (PDT)
Message-ID: <030464cc-4d8a-4dc0-b212-992409aa76bf@linaro.org>
Date: Wed, 1 Oct 2025 07:58:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] accel/tcg: Document rcu_read_lock is held when
 calling tlb_reset_dirty()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cputlb.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 9bec0e78909..db7cbf97826 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -31,6 +31,7 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
>   #endif
>   
>   #ifndef CONFIG_USER_ONLY
> +/* Called with rcu_read_lock held. */
>   void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
>   void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>   #endif

I think this is wrong.

tlb_reset_dirty doesn't need to rcu lock.
tlb_reset_dirty_range_all takes the rcu lock so that it can walk the cpu list itself.


r~

