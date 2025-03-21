Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFFCC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgfg-00073e-H4; Fri, 21 Mar 2025 14:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgfO-000700-MU
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:00:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgfM-0002vf-Cs
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:00:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2241053582dso13133245ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580018; x=1743184818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqUath6DYeiXFaEb/UtEorokAMpBsE3LelLAqtNlKlo=;
 b=WrQejAZi6sC/a7oSMCzQrnewE5qzmhUTRthtHRwdZkhV1z1dfhETyQmF4D6Ti3n+Ei
 EYNSZxg1xzkBD+X7xLZIC3g4fRRgCyoOCprk/MYLGIIs9/WRJBXrloE3ajBU0L//+UMH
 vQUjYB26wPZwMpJAKjJ1yw1O6BMvylH0iAAqtdOd67eUC4Iyo+chz7XDy0T+Tl934zXQ
 BLQWw3RcRf1kQk27sZCbXb7M0GGk49nQHQ8cbNJDasFxAtHe77M0bs27PzsUcBywdi/I
 aHDmcSXo4pwkcH3Lwz4Eb8EPIvs93Ji6Gp82mB+bmvrhR7UrGj/768Qrm0Bvi4NGI3gl
 nhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580018; x=1743184818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqUath6DYeiXFaEb/UtEorokAMpBsE3LelLAqtNlKlo=;
 b=uezjXsisfTLudYqaIS8fhiPU9JxgBF/YjF9QiMiAolPHQtc4pG0rTvUPp47az+X6A+
 cbKgkO1DGippj7soskJTm4m4CwiJZcMzgO3WmzSxUUY/ovvsPkceRxZYNs9K3c8tsg7q
 K6kLnhVDpKhawTQCcOr6sx+vev+xY14YusDBFAaLgF4tOrvHlpUsOrOfotUQ486uvJrb
 /Cc76Z8myiWK2EoP4TxojYJT8DlMZramwF+lfG+MOR7fhYykNHQ2Y4P3rHFpFwBRa7ej
 /fCn8ykfH2R/RA/OVJnA1itAN30cj4JqIE05Bs9en6f2Y/kVRZPO+8EGcWM10n/TmCNB
 6gog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB9RMyjz6GApYQ0udZIgOiSAJqhNBIORPwT8zGdDd+3ivqO51qZe/s7c6rhEOJchEwShszQz1dsmtU@nongnu.org
X-Gm-Message-State: AOJu0YxbUxDOReC1Xuob9bYDEqaM5Kl0CbLgElcIXgvFqtaohWfR9re1
 z4jKxdtH8l9jdz1GvgWrFps01LlrZCtR2pZHi1j6bdMt1jiiXtqPFp4Akcl8+VU=
X-Gm-Gg: ASbGncs437CPa2psPgT/UPk1ftcBsD8lA8mO+8adHPfmnZGJbpLfZUEejM2FB97wa7P
 gXRfC2fP9MI4hyOOZZraoQvWd7W6dqUlrQ5BQjQ44DXCkEnUdDg03dk3tq6kptjcQFXIBFb6ed9
 H+Z44TmLuPhYbaBuntUyNR9KaeSD/cQDMTiyAPCYPAQwj3IeiZV9QlrnbyAUuJLE6IBiCBeTEGW
 s2Qv+Q0yOjexp/65pGMgwV4CVMrvAR6IFK/tMPZG1BXYCUt/wG8z+iTw6Vg2IMnYS1DNtD7FiYT
 gP4jhaLBrrfUX/+RxuEWGh3vLk0axJcAzsy5H0Q4fYeshqlRVkH4Q/dXdC7mRIunD80exXe+loK
 /yWQ3fqNK
X-Google-Smtp-Source: AGHT+IG+KnpKpR0jVp7IgTlzKnHiFoDpZhKDkqzftkZ4oAq96lTlohIvKcSdyzoZP3EgZGNch64EpQ==
X-Received: by 2002:a05:6a20:7f9e:b0:1f5:9ffc:274a with SMTP id
 adf61e73a8af0-1fe42f55950mr7582645637.23.1742580018455; 
 Fri, 21 Mar 2025 11:00:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28003b2sm2072742a12.28.2025.03.21.11.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:00:18 -0700 (PDT)
Message-ID: <2529af4c-9341-4515-a697-8c0e4a1f2dbb@linaro.org>
Date: Fri, 21 Mar 2025 11:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/30] exec/cpu-all: remove hw/core/cpu.h include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d4705210370..d4d05d82315 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -20,7 +20,6 @@
>   #define CPU_ALL_H
>   
>   #include "exec/cpu-common.h"
> -#include "hw/core/cpu.h"
>   
>   #include "cpu.h"
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

