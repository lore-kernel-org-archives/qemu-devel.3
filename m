Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF48C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NdS-0000Uq-3d; Thu, 03 Apr 2025 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0NdN-0000Ub-9r
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:41:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0NdK-0007tZ-W5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:41:40 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736a72220edso1167744b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743698497; x=1744303297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QkVbnPHeMLk7x6RqbFBrkCafntY6ooAIo4bb5r0rXD4=;
 b=nfoImvQKM4/hejAfVj40N69kmtdAJPwAy1s/Tv/JLVkq0TIdsCDquilJ83i/0sTVrB
 tYB0S3heuhVcVLaegWBpUMUQ5OKKBRY3PBKHoSKUXwfIetP6lvg27oVHSy/jsT9H6dxM
 CzCyC9BYFigwbqxzOxS/+gY+wkK/K1T4qJm6XaGb+EHtf0vp9mg56p7Lg7Q0FCoqZ7da
 75ga26FnqE2hCOhhsa+it9dBQqZxjJb9nR+34grpHZ7dUpKztsLhn/616vDQYh72fc0S
 /lqE1N3KBpH5uEG9sTSqJuyqLsQJHFP6QOgnTjheMgWrxWYkkHPb0NFcdLE1bdtn4b7i
 A5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743698497; x=1744303297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QkVbnPHeMLk7x6RqbFBrkCafntY6ooAIo4bb5r0rXD4=;
 b=MA4fu/lo6Z/QfgX2ghH3sBIWOkDtAlefLb7C9Wa6dPNfDlOXw8EytU9iSHzMdZDDld
 oPENWCRSnUVulJQBPZ2nORbi/jAa9rPYFlh9xbioCgOTAzfgJ/Vl4MZUmIYnME8DKg+H
 8Kyxw7xxsWL6moH7NoR+UfCppBFN4rezawQ7DTd89WFW9TamT2Hea47vguF3SmK3DkBF
 6idRDq9kJFdH3LODD8dwt26TuhsdSZbEiEPF7TQsDP38M+imodC2la5t14qjl0daqfNo
 VyK1fDGhOtSZDmey4SOy6MwrsWjd5xlkj12NiZ+VYeadOjJTbvI7SwAi4S3bqFPnWZbD
 d7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7WqdeLZ+3rFadKe2TmtqWHxJT1RsI3/t7W7XSbfoyevyMgXw+sFpa8kGpH/u40GO/bUIqVNcTj5hM@nongnu.org
X-Gm-Message-State: AOJu0YyL24QWGbfZLFce2VgrtrW/MyVcASXu5UsWVbbdg9Np5TlBV9tt
 08+8EUpZnXadlRoUQz9dmVbEYYnpVoKu2rK3J8l5EX/iYzfSn0/rTkpqxOTIrkM=
X-Gm-Gg: ASbGncvSHk3epsmRn5pgKQQcZwOq3Yxyw6PTfFIvlbiGgaSxUmj0RGpRgk+AMaQaJzD
 63/cAcxMcXr7iRf+To4wPl9GPv5fv/j4PDp4dCuEFzLm8UZeIZaIuRtso0XnHL7cU/v2B7L6jqd
 wKB+EsQKWxSGQET2eUqgwWjVsHEWTHGt3Vc6bNB1dXGXk4yZot9QsghjcHjvLsBMOVegpTlnL5s
 +uTwxn6a57vCkjiFYZvOgsD4notXYEepio9YHshzVgA/4/4ucNG6KrXyN78qd5mqyZyOs4gZRxK
 3ipxnE+JE4tTtiBfFGJcR9sdBTnu3dVtRsMhJTBDXrLIXI+cKDZPNTGL2ExUkTxfl/mQEijfpUE
 nCiI5Rf/T
X-Google-Smtp-Source: AGHT+IHj55VTY32Wmey7Z4MU7lCzzue0dxXH7EkVlzXkLnIrEcanC7yqdu2O3u0uZ7lBvPl6j5j4Cw==
X-Received: by 2002:a05:6a00:1910:b0:736:6202:3530 with SMTP id
 d2e1a72fcca58-739e4c303f0mr280036b3a.22.1743698496633; 
 Thu, 03 Apr 2025 09:41:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b2d76sm1707631b3a.122.2025.04.03.09.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:41:36 -0700 (PDT)
Message-ID: <af4ca9bb-3b46-42d6-996b-73872e34e7b6@linaro.org>
Date: Thu, 3 Apr 2025 09:41:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 01/24] hw/core/cpu: Update CPUClass::mmu_index
 docstring
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250401080938.32278-1-philmd@linaro.org>
 <20250401080938.32278-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401080938.32278-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/1/25 01:09, Philippe Mathieu-Daudé wrote:
> Since commits 32a8ea12fab..90b7022e698 (target: "Split out
> TARGET_env_mmu_index"), target's memory_rw_debug() callbacks
> use the target's TARGET_env_mmu_index(), not the generic
> CPUClass::mmu_index() callback. Update the documentation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

