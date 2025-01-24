Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED45C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMuC-0000XZ-ER; Fri, 24 Jan 2025 11:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMu0-0008TM-5J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:51:29 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMtx-0001yb-Cm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:51:27 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so4375290a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737737479; x=1738342279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gXE15mkcNpzOGS5EJlj1b2+BpeJ5W5y/+0OTdAZnEfE=;
 b=axKg9WIBX05hkdW4fXdkJP9V/pYEWL1L+Cw5I+ufc0cXYVjR1qaVt38XwSlCBgRTdE
 xqEGRSal1uiTiXC4KcqCLiULYUtpLBR3Ax7Tntnn0DJPzeoo1Cw64ShCsNjiXxA0hF5p
 xkjY00CA6jlIFTk/ZjxoS3+eOTr+Z68L7pQMyXPJZyFS9Tr0pFV952aqvVIuuVmnG+FM
 j7ox+eCe6sR2cZMicMOKyJ+DPupgUkH0WLun+I3obMz69NNZaaiGuJ4C3uop7xagB213
 08ezOA+Bi7sk0Xc62O0STYTRpwjMY98DljO+xANYjaCNP1SM+elle2NTm2Cvtpk3tPt1
 ShmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737479; x=1738342279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXE15mkcNpzOGS5EJlj1b2+BpeJ5W5y/+0OTdAZnEfE=;
 b=pKle+4O4S6tQPYHi6cI+FbFvrkRF0vpvWve5I4uI+RJR1dS9R18/P/70Hr0BeR/tG4
 FzM0tAwDL8QtxSj+UcIyVPhz92k4A17eptL6s9ZhRecK1ZPDg3pF6VO7fDVkcFOL+oOB
 h9LaMGQMuyrspNHIAWGU7pHYCNocza/PY5jC+D/MVOOwkf5CZZ/f2abzejFTCirgoglz
 JFr2XcLKUjwmLTZkko/HgwZlwgMd1yGWXmRiGJds0Nlh2Hl2Q3xPbeTT+ZtKyWL7Xidb
 ahoXGcg2A2mj84aDR0BkwXkjKVNLqFgBT6/njjO15pq+EiGEQwpsNC0Xkphb8RjuNY8s
 zajQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ5pxjU+wnSjcK6wlYCAPd6UPtq9zS3JwbAh3niWE/f9TSsJI712sMWTs7mDtCngsseyHxQ+9GY6nP@nongnu.org
X-Gm-Message-State: AOJu0YxxHt4tkL5LrIcUFFQFbjYeCsZPe8ofEr90/RcF2M8NwHTtofTv
 V2f+dZiYVKb/bXOmBObPDbXW6ofBcvQ4mgPWZtr3i2AbiIb8qbm/V3wU4QMAKuk=
X-Gm-Gg: ASbGnctKgNOxzvd9Mf64jHaXi0f4FV+3CW8K89UFd7A+V1skVyECqzK4gItkr500fay
 gWeYyHP5gWtSww07uX5Q5c0KGLavKEByJPQhzKMPg7CWBHaSDvaRtHL3HN/KWMLM77DdpVije+A
 E8d+m6FxFEKXHW95Ud0zmxlkXEmRIvx2VRapJNnlXhtZkqP3ToEoEtlfDsoZhJX0j20XjC8w2lt
 xAUQvQaEPVVJlclX2leFo6DtEY5tI18StJI8TnEqxD10dztIUvd96rdSbCKU/CPrMo1vby16Nex
 GZhqXYaiNBWfA3c3JzTCvKXW
X-Google-Smtp-Source: AGHT+IEzOH0H9LAMqeeid4z976NqSsP24+5Z9ZdBwQk/KKAuIIIGNBIr8tQZhwh7im0j7TLRTMuOgg==
X-Received: by 2002:a17:90b:5206:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2f782d4f189mr38966313a91.23.1737737479552; 
 Fri, 24 Jan 2025 08:51:19 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa56160sm1971766a91.18.2025.01.24.08.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:51:19 -0800 (PST)
Message-ID: <f6e862cb-09ee-43f8-9131-4f80b0ad7b5c@linaro.org>
Date: Fri, 24 Jan 2025 08:51:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] target/rx: Ensure not being build on user emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Currently only system emulation is supported.
> Assert no target code is built for user emulation.
> Remove #ifdef'ry since more work is required before
> being able to emulate a user process.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/cpu.h    | 6 ++++--
>   target/rx/cpu.c    | 6 ------
>   target/rx/helper.c | 4 ----
>   3 files changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

