Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623A7CCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAw3p-000561-B0; Mon, 20 Oct 2025 16:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAw3l-00055Z-HN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:00:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAw3j-00012J-RV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:00:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-474975af41dso9715e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760990446; x=1761595246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HErnmUb9I5W5fQAwglVn7rxD5IolsV9YwLw0CxBCLVY=;
 b=qPwgGCZRAQ0vVe4eurX17dtmKgiukjnU/XARUB1r8NWr5vkPW6Ymz1DR+twUapFr+L
 JlRFRzyEc1Z5UzgP7stNtHArcU549bDsPxJ533nhJaEkKgV2oyGYgY5tNnGZ7gCkeArG
 ILgndkbV5aJ+sM4sqxX5SfszWAMp3RZKEx0ImXNKWgwp82QOeduDxdf7KVdehdnnFnRD
 nDLsNcbtf7PsR9ZqtacWBqHxpjoET00hC1eWMOMDHe5ewmN3vJQXWgI9Rjn9diSh9/Sd
 H/E26KRqNUcQyv0YDSaUfgrXs+ybIhGgby7HE7rKm714VIt3Vat6gg9p5kko86Un/gqg
 2XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760990446; x=1761595246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HErnmUb9I5W5fQAwglVn7rxD5IolsV9YwLw0CxBCLVY=;
 b=cwLePY19NBnqXd4kV4u/y/wzIdk3D0L9Bu1feA3mkR7hbQWJNsyNAn2DPqmGpjiRAv
 GL1hjeDQdppV/z4Cn1hADcV+F3MiX9tNU29Nq8g98mLzuw9Ht7rcQvWokVMr2oZ4Rneu
 5dsMCJiF+4FqtcRtz2KLiA0VEgPcbh67A7JlW/dfkRvNmfmrlOtAoSyCAruhT3JaJc3F
 jKv+fRIW1aCiDpqUYxrMQAH+iihgyHy4QYFVr4YOzCKV03efW4XXFTcj7XDguHqHraJT
 jzZ9CPGaQY0vyVLsYa0/cac9MzHozyKuabkaljy4awf3rt5in0bqlOlFw5lCyI/1aCba
 MxvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUVUPXkHgIkOZS46BvwB6BA7abR6V9PvbKVr+sRe8Odm+9AnyGdOVrh7wrRxCOPeApsJ/K/+TA826J@nongnu.org
X-Gm-Message-State: AOJu0Yz7N11rN0z3zxSLRCgVDlT51VFdRNy6BmlW9xbmxt+2HV+1A28O
 35Eo1+R4B0kuJ5hiYQAx+tGLJOpMjCqG3AdIPAxpPiX93Xb4ZlS2GvHJsq8Rc9TEO+c=
X-Gm-Gg: ASbGncuI9XFES6Zjvll1BulXbNW4190d/VGn/P0VjU9teV3JIbuI6uFcL/zq1PAdeYU
 fs5nfYM/QtwX2H6VVWX6PBYOHHJUZ1YmPfeH8heukfy4sJgEHNk819m7YKAo77zw86YoXf+73v3
 sKvh11x6coh9+H6jgs4M6NZ/6Dih4XmaKY3aUvg28aNVLpE6pbel8JSmkrC0jm1HAhW1bnkGpJd
 4iuwwYIjpYrm+/qzHSwpgxjI6rSkCQnW4TWL8cVmkZWvGzTRNm06Kmz2/X1n5fsw34Uk1gjee7X
 0DhVJG04meTGZTLHpHN1mB3seksdLUPqgCHH/U6HHhVVCEhW94gxC0FWjWOf6uSHYjmBQQ4YUsG
 2IZKKiD3gV52D1iTPb1AwtCzSndMmwLfE6XIQIShTO5DDNt9YszW6nsuDxr0AKzprWNzVQAO28z
 ftWou5CAhMnyNQ7+4u/YGqUFXDfhpNBRWhmAFJldirAmI=
X-Google-Smtp-Source: AGHT+IHIk9tPSN5Sljjoq4ytTQRtG3fYnmVDm5abFO3ZwOfsXWxIcsfmBc+GgPkFAU7QY+ujW0o9uw==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-4711791c522mr97490275e9.27.1760990445307; 
 Mon, 20 Oct 2025 13:00:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c653a5sm979475e9.6.2025.10.20.13.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:00:44 -0700 (PDT)
Message-ID: <a5070457-f751-457a-8f35-ad3a6d761210@linaro.org>
Date: Mon, 20 Oct 2025 22:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/openrisc/openrisc_sim: Avoid buffer overflow build
 error
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Jia Liu <proljc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/10/25 14:48, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Resolves this build breakage (which is actually a false-positive)
> 
> ../hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
> ../hw/openrisc/openrisc_sim.c:284:45: error: ‘__builtin___snprintf_chk’ output may be truncated before the last format character [-Werror=format-truncation=]
>       snprintf(alias, sizeof(alias), "serial%d", uart_idx);
>                                               ^
> In file included from /usr/include/stdio.h:964:0,
>                   from /data/qemu/include/qemu/osdep.h:114,
>                   from ../hw/openrisc/openrisc_sim.c:21:
> /usr/include/bits/stdio2.h:54:10: note: ‘__builtin___snprintf_chk’ output between 8 and 9 bytes into a destination of size 8
>     return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          __glibc_objsize (__s), __fmt,
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          __va_arg_pack ());
>          ~~~~~~~~~~~~~~~~~
> 
> by using a modern, more robust allocation pattern.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes to v1 ("Avoid false-positive overflow warning")
>   - switch to g_strdup_printf
> 
>   hw/openrisc/openrisc_sim.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Patch queued, thanks.

