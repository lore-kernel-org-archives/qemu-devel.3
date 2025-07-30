Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA4EC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhED6-00016m-A3; Wed, 30 Jul 2025 17:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE9P-0001QJ-ID
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:15:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE9M-00086y-VJ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:15:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso236645b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910147; x=1754514947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2cZUQEzD/FCbTSYQZTjRoOYVviR5yiQ+TIdbHRiU0yM=;
 b=tKPLCeZxsJ/pC+DssKKVDB8oixk5Pz0JG96nrW/wgGf+KFLvhcdsINXL/SPjvyLADr
 twf/uWx4SXbr1T6oMwFXp/QbTZptSIkU3NXLn3KcmXSyj6XOyL/V6cxs+GukHbbqmftD
 4BAYXIUivS//AsfMS3dWWCrXHaAvT8OqKiED46TmOgJP81W00H1DSQe0bUv79nsCIRU7
 9qCZ/vYV0Y/4F+8FvCIEWB50z5OI+VWFDV5Me02DdWlh8wtoKIqLjaew7gXVVY5ivB8I
 RpCKCs/RnbkdmsK/dZrXROnTI2FwBJHAy5T3DXBzwfMnHg1aQzSgqwhapk52FP6xM+Hw
 iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910147; x=1754514947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2cZUQEzD/FCbTSYQZTjRoOYVviR5yiQ+TIdbHRiU0yM=;
 b=wn5/IpHRMgB+cJYKi14HFC+r69Vj7RptCEzImp6/cJ1SsseQmvkvgeaf0yH9Wi3PyX
 vJWK1bqhxDlMeq3wpMOLOAlZPN7kOD/Ud69784txqqAbYhmSzTBajqv7X0YBHvfejT+i
 4CvrBNfvlCYdzepy+XtNHhmGThBx4/6FEyIerf2xrqLccIoQTJuP6Q4gLc7jxEa8qTj9
 U8ZBSRr20bz7meB8zQOGeL2BEww7UiAnlRxvKtn6xNoUhoTu5xolvZWWU30j+dMKK1FY
 Way6Dr8GjeGAxLEU5cLRnhaVy84fMEuB6A3SLjR/xJGbiZmyScBkQU2YC7GCFf2djj4w
 FMYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBDk+pifTh5NzTB8hHyxi1nOkCNxFyij13V975RNhn2yfsxrHHCm77gSdspfNjwt0hTyvvyA1QF0QY@nongnu.org
X-Gm-Message-State: AOJu0YwoxEoMTCJ08UcIjJB55c5fD01A8Obzvowk2Woi2qgskpiaM31L
 KoPemVvEUVz5ULE0ZYg1V5KoXNfbklPO4/4CzgPzGC2otwiaczBQmlJJXy5K9TGwvvU=
X-Gm-Gg: ASbGncucJlk4P3JHwbtxWOwbo84hD9bD65IVHSEn+uA9cgk3xJNvp+UYZ+IkuF3Mjcy
 hFsCpmdDqcUSfvdw8pFT56IRsY7L2XX2gC23VLy/J26l6+a/x8hJZksTkCY+JmrOo0ucpbGSLou
 W41VXiQ23EZ2lOgUN2cQFk8Jg+Fuj0MIDIohy+7OxKBR7wzavDDHK/HuTQYGF7PWQBpXIsr6XPK
 eBuJzcF2kaltweKQmROA4++nkGJvGekHGBlhzC6KR9PoMNW7+/NoV/GorxCt8Iga1J3K4rEHH5e
 Y3vXyQyNEOA2x9y9T1ZSgfvIOq3pfnFjgJEFFYlQKBRGGQ9NuX0B42ut+MeNqhwaNW1TJOu3t8n
 2Haz0WCnB3mYUNgHB0qMZ0reZHi0GSHWeQlo=
X-Google-Smtp-Source: AGHT+IFHxJCKWBlXtmEKxVnnydv3o2K8ldHe20h31QT9Lbwn2WmJajA56JIH7fJdEeXS4Wzcmn6GnA==
X-Received: by 2002:a05:6a20:3ca7:b0:21f:5aa1:3102 with SMTP id
 adf61e73a8af0-23dc0f13ed1mr7869068637.37.1753910147208; 
 Wed, 30 Jul 2025 14:15:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6c8940sm9869747a12.59.2025.07.30.14.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:15:46 -0700 (PDT)
Message-ID: <aa25e3f4-931b-4cfe-b2a7-8e91c10c9860@linaro.org>
Date: Wed, 30 Jul 2025 14:15:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/82] target/arm: Convert regime_el from switch to table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 35 ----------------------------
>   target/arm/mmuidx-internal.h | 13 +++++++++++
>   target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
>   3 files changed, 39 insertions(+), 53 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


