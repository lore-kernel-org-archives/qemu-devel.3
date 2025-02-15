Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22D7C021A6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 20:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjOQR-0001F7-GP; Sat, 15 Feb 2025 15:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOQM-0001Ee-IJ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:03 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOQK-0005Mj-KO
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:02 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f61b01630so66724245ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739649959; x=1740254759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSSdUnQ4S5ygzPSji2bp9jnNnEJdH8XgxBLP0EcH82Q=;
 b=SGFRJa2tzjm/uMGBeVQlijYRTkZKdWHIg/raJNtXEmEj7OudX98WpailrB1pgsTil+
 B4tXm+V1EcUfOosb163q9nU6GUPOhhR+rwFDR6E7hrEp/FPLZsV8CCAG8tLdlmOm/W1+
 WjKVJD9qGHpMsihZpsL4rLmKWfa9goIdWb9QgaKLDMzcmuJ0xlQMqeh+dWdEUHUcUeRe
 3K73jIwAwqrnwqgR19RxXGJqP6w+nNB70JHFkZlYgD6et4zQk5UeucL/J0Iiq6w3xz/A
 +3rXPaIArYv6J5V3ddVSZEmaKT5PCW/iF3G/XTy/b+zEcKwb2IW0Yu+pD/DTullarXl0
 808Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739649959; x=1740254759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSSdUnQ4S5ygzPSji2bp9jnNnEJdH8XgxBLP0EcH82Q=;
 b=Vr6KVBl40lmANOyZ4jtOxfJ3N2TWdzKJl7GjBGZRJNoW/OYZeAGZI9Aaa2eryw9Q41
 caih/p8a1Lk6em2noGl9UTPK1jjVkvMIo2/avH+DaIyYLCBNUnbDNLV6Wli7M4E0YB8p
 t5DbbfA0r/Dtg6H95J6HgPE/4XdkRZ9DZtnlWRFh0sOneY5ixjnmgnpAcL6Mg2fmTAlL
 1K8GADithWxFuLLdQcKLs3goKBrlLwcMJJ1O9D9/G2W7Oxrnf7lqnmyJ+ku2RVPiEVQE
 wsVnuvQqCKJX1RSCNM91jEazLDHbHKCxKwQfzZijLbVSmte+oohhQ3pw8ZQrpzdzUx15
 S+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCViHTVVtHKDFDDTrUNnKjDUgrYq1s2YwmmfEGb3wkCjOaaRWw0mBeGRh8DKnw9xNIrek+L/GMn+FItN@nongnu.org
X-Gm-Message-State: AOJu0YyaipXcGsue3lB5NM7q7Q/51+CfUhhOinh6cQUJUyGjG5JUUaUp
 Am3CyrV38BXNwfyUeXKVvYS9HQe5hJgY9M6iGcpqpNkXSjoyBnbQHzVo5YW/3fI=
X-Gm-Gg: ASbGncsYftyWg2MxOEgpW2nswF3dv/LKlRE8q6ieuH1/mv34HLTsWsb9ZXXneivQ6+j
 2rBKuNO/nOsi47dtOlHhocjGyfPWeMOKt69DMSdcdFDK483hV4o9OLcAK3kTkWEOCoeTjUFsJbq
 Vx/2Ut9TDsIm/tta/w8LyJCfMZrDN+yX1OMo+Dbf4KKHrcdJu5ixf84qo1gvlhZFeNcAp59u777
 yC3Ui2RCov4MQLYjIC2SPKX3Dw9+W9eBgc/aj7mMuWUw68tsmjeUhUQhPSBpx5gimIjl1hPRmNc
 L2lUMM3e3hEuiK/tzGCS0Xu192Ujyucq5QjST70FF9TZUcHSymvpyGA=
X-Google-Smtp-Source: AGHT+IEvmEFbSge5adVVNgBvOEYaTgcrveVL2Hqb3nztRTSR4cAtbn4YiDbPBb3rud+QpiPOxm0Gkg==
X-Received: by 2002:a05:6a00:3d55:b0:728:15fd:dabb with SMTP id
 d2e1a72fcca58-73262200ec7mr7504562b3a.8.1739649958734; 
 Sat, 15 Feb 2025 12:05:58 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324276171fsm5433570b3a.144.2025.02.15.12.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 12:05:58 -0800 (PST)
Message-ID: <bc1be819-241c-4f62-9874-7f2683c04252@linaro.org>
Date: Sat, 15 Feb 2025 12:05:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: fake UltraSPARC T1 PCR and PIC registers
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
 <20250209211248.50383-1-atar4qemu@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250209211248.50383-1-atar4qemu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/9/25 13:12, Artyom Tarasenko wrote:
> fake access to
> PCR Performance Control Register
> and
> PIC Performance Instrumentation Counter.
> 
> Ignore writes in privileged mode, and return 0 on reads.
> 
> This allows booting Tribblix, MilaX and v9os under Niagara target.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/sparc/insns.decode |  7 ++++++-
>   target/sparc/translate.c  | 19 +++++++++++++++++++
>   2 files changed, 25 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued, thanks.


r~

