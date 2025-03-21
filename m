Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0071C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvggS-0007L7-6r; Fri, 21 Mar 2025 14:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvggK-0007G9-DX
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:01:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvggH-00031P-Ed
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:01:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c915749so33111375ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580075; x=1743184875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UvO9Cxq0zExKjE4A3JJ2r35XbqlYJiJsGb+VZu5umiQ=;
 b=SZMJsp4iNztNu8QGkgiHueOu7blICKeGgLp2mWfD9d9+sLR2b8h3UFWF5qfHXNW2Pz
 jgNaFr1+CJCOLVG4qT89w/E4K2IEHuUQ01FRys5kXoz/4INw4J0IwTUYsTEGd2nZrSS8
 0w6/w6LXJ1HRitvD8sfYpKjj3hwk3Iy6XYmxnb00VWLUw/xhIaRoJZACiU15slCXLfGR
 aqllqkSYs+YOnePZ8FdU68gYrhyhkVXWYgFla6h+MD/kcFqZ5cY5LmO9DWb4G8mJgSky
 hO9emlYo/Pd6pq62/amFdeuDDanncauRplKo5vPhAi5SZmHLUgsa/dOuOGlkkv9e5Tvi
 NC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580075; x=1743184875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UvO9Cxq0zExKjE4A3JJ2r35XbqlYJiJsGb+VZu5umiQ=;
 b=QDFGvk9TdMljGve4daWqA5SSZu0OnbKWIS8tpW0rirdRcV5TjZo1L8YO0bN6Hf62tY
 yuwmAkyMAUuOiGji/8xscldCMW4r7PwktRtAjtc5huJSNL6X2hrfMlmheIvJZJOMDZqS
 blE6rbm0m+2rXT5Bg+pclNeKZ1uhVob3QrkxOmWWDZjkHQaWRsa8pnA/E74KWQ3BLKvq
 /2FE+Wpd3+TQzBV/h68S4Qb0RQW5vNylG7xUV1mKQ/Vq44cErO4xac4cZiKZxzRkHORP
 G2wP/Mc2aj0dsh2fClS6r4HADVs0iYtSu3OJq6seVteCDbt/M3m89D3jjXcSVYMBh82o
 ad3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc2a8lcMkoKRDqfGCJNs8422343ECQ7H/HPFiCInHOhiuwPFbMZhsM2Zf0Gx8tJ1Q6Cfm7PGeeWUr9@nongnu.org
X-Gm-Message-State: AOJu0YzET1OavHsrjMQV7br21Zx0/YhuLjvma5EqYrqPyqPOUazSOH09
 3/DBs5+DhjqikQzal91fZlGdGh3jEHbKQDET7zB/RbY3gkLwL5sSUbo1QVV/LH0=
X-Gm-Gg: ASbGnct4pzywWKdQFhMlGpVqfEfgfE6Wk84f9LV0G2lHQ9ycRz0Vei0aINbyvh3lAQ2
 1PWK5/kt7+tDtMNAg67eEv/QVXtPmn88y7HF/UUizjJeop0FGhc3XZPxZ8sPV3t/to4Nh5zDDEN
 0YQA9KJ2S3bq1huKdHKoGNtP/fBBD+dbKWAayxUcJR5Bkgbf+ubhS20Vgj3MpRNiaboVzmh6iMu
 UjJF91KuzJjiyLcZo1IvTYV12O64QIr9W+CPgJwwBndHTg0jYHVYg/Nq2KK0Geatik7xKSzjEti
 /j9SQ8mMlKsfpYET2ahXX5HzK/UGzFO+MtPr02FEOt+jpQ7M2Co7GfHOzMPSmrS9a77zVYrZOJb
 QdK2iaTjV
X-Google-Smtp-Source: AGHT+IEVQBUewn2vltOJjnD3ER07wbBMzpAhk+4Mm4mpvnSWKKtf7uMQAJ10PBB7+PuIE2/DxZNccA==
X-Received: by 2002:a17:903:188:b0:220:e338:8d2 with SMTP id
 d9443c01a7336-22780d83b25mr69121915ad.21.1742580075407; 
 Fri, 21 Mar 2025 11:01:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bd143sm20164975ad.150.2025.03.21.11.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:01:14 -0700 (PDT)
Message-ID: <0c0197de-ac97-4acb-ac67-ae6011e6f9ad@linaro.org>
Date: Fri, 21 Mar 2025 11:01:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/30] accel/tcg: fix missing includes for
 TCG_GUEST_DEFAULT_MO
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
> We prepare to remove cpu.h from cpu-all.h, which will transitively
> remove it from accel/tcg/tb-internal.h, and thus from most of tcg
> compilation units.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/internal-target.h | 1 +
>   include/exec/poison.h       | 1 +
>   accel/tcg/translate-all.c   | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

