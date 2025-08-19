Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8291DCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUPQ-00039a-NN; Tue, 19 Aug 2025 18:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUPO-000395-6G
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:02:22 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUPM-0002LT-LW
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:02:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2445824dc27so54575765ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755640939; x=1756245739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDPALxuPdrr0bb6NHBl0g3Q9dLIBp9r5Q23mx3aKyz8=;
 b=wRwkfUNsKFXDeYkUKXeKi+YZvdLb7foU8XmGJnbFNVO/7/sD/BQnOZsrIgkvzJxeI7
 al3EUmapsp7e35XzfLi4vdM1EapK8a2PZvaxBag+V4Cn+6P73nV9WgNx29fJT4iP2fHH
 uFgyUtH/w1ivGtCl+272nzBtSHq4+KSjB55Z9UGADQDw0YXRoUzpb1eKJJeo93fuCJS9
 YAeJUZiPAee3Gv3SWp0ivAoSJrDB1dskyK0hJpbiwDuFHl0WkcHtPg6s1V2ozk2/Ec9i
 ymU/epKw4icrzKeb2St1oA1a1KWFQzSnlXXuqblpywfB2ie77rBXYuaFOaB9QyZlycRC
 P4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640939; x=1756245739;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDPALxuPdrr0bb6NHBl0g3Q9dLIBp9r5Q23mx3aKyz8=;
 b=SAENicCMBMzH9AshNfiI/URjdTC23F0sGwXSEktwaqlKkWsGQxMjC/92oNYhlOBf15
 SU4OQOgsGtGyuONno9OBaXj8vub1C5MwDxQjt8o1Ih7ZrdhhCxLa0Ic/Hb8wGPtgW7GA
 r8NIVmfcH512JhaS+JaXPaG7+3CaCbnYfJqshlif0CbZSj0XL+/KB9rqBPrmKjXGZH4t
 S7JNuyQVLqciXrXwugWOe/Tx4+gWozI91mJIX3uvsB+/LyRSGb38dbza1s+a8NeFQb0M
 hWsnCnTaHtgoyZ4B4SZ2dyC10KKEFwZG4Pzt5Wq1QjoidSybcQD0/GOsDIxG1KMZIFn6
 K9uw==
X-Gm-Message-State: AOJu0YyCmo0kjWLRhCkGqTIWncAt67QCIdCC+2mO1RlNU0xJZmeHeSLs
 LYbOggp+tKkrfJ4LxkppD/HBMcUmD5xJrqN9KdMoBggbxxlTa9ujH9FIyNqG/OzRaa5SBHtcyNC
 Nc3eNJ9s=
X-Gm-Gg: ASbGncuOUVgTMXTJteLjRApbs4zH9oWLzbgyhCwJtspxMYOcxmO6/6cDDkxIW9qMjQi
 a+8j689QwIBWlGFpTUDvvtojjQy/y9pLP5JJsgBbXAOBPqvnzkORs1VTy3RqCdbJNQdfNp2XXoJ
 9dL/dCtd095XIBIoANrv4kIVyvXhR8hf8ebV5L9Eu8a1TgJWGpoRqby0anpN065OsFfieehlnSe
 R8f+d5spLWXsJG41MDyNiQw0ypoVF5dvkI+lgL7Dtir4T+8MSa2tLU4Q/VCeSGY/iB02kYpyGuv
 qCAAYLpR8REA6Tzf8PCYLiGMuZYdVsvioI4S8/9UKyv5kuhaGmzqE14QrEHB5nZRJhMWmA4bpji
 VLtvVXe1aTuokdRizsVetQYtc8XzuWaXXEQ==
X-Google-Smtp-Source: AGHT+IFARLPxtZW2319jaF9AoyXdCarGsoAb6WifuJMjYUUu+vLbHSA+vf5qMCxXBwaWL8IMswTX2A==
X-Received: by 2002:a17:902:da8c:b0:243:12d5:db5f with SMTP id
 d9443c01a7336-245ef23c2eemr6932595ad.48.1755640938559; 
 Tue, 19 Aug 2025 15:02:18 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed50129dsm6729775ad.129.2025.08.19.15.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 15:02:17 -0700 (PDT)
Message-ID: <ac90c3c6-64ae-4abf-a850-59c862400b89@linaro.org>
Date: Wed, 20 Aug 2025 08:02:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] util: convert error-report & log to message API for
 timestamp
To: qemu-devel@nongnu.org
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-9-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819202708.1185594-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/20/25 06:27, Daniel P. Berrangé wrote:
>   void qemu_log(const char *fmt, ...)
>   {
>       FILE *f;
> -    g_autofree const char *timestr = NULL;
> -
>       /*
> -     * Prepare the timestamp*outside* the logging
> -     * lock so it better reflects when the message
> -     * was emitted if we are delayed acquiring the
> -     * mutex
> +     * Prepare the context*outside* the logging
> +     * lock so any timestamp better reflects when
> +     * the message was emitted if we are delayed
> +     * acquiring the mutex
>        */
> -    if (message_with_timestamp) {
> -        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> -        timestr = g_date_time_format_iso8601(dt);
> -    }

Something that really ought to be handled better is that we currently use qemu_log to 
print pieces of a larger message.  E.g. looping over the general registers to print the 
whole cpu state.

(1) We don't want timestamps in the middle, and
(2) we don't want unnecessary memory allocation in the middle.


r~

