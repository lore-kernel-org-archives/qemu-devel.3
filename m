Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4476C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWywP-0006Ww-Cf; Wed, 02 Jul 2025 11:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWywN-0006W1-DF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:00:03 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWywK-0005sE-1V
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:00:03 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso4287305fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468398; x=1752073198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/QMA3UrLT2YLoe6o4WB6MEW09cGgC3z97gJPkz4vwU=;
 b=mQ+inE1F3bwEeO3VZuP0liItqHUJjJN7VDuVzWKJfEKiNujI7XWcjTw2mTG9vE5sJl
 nXgMh0MZEkqJirw2XGGc0KWX93rCcFG/u8ZpCbCOwL1lH+qspShewFWCA7kdX9p74FcE
 gbgybjcb9wvSJbzg+lNdWXG9oZsE0o1ZqkPLcWU/rYEcWAxUgthbHf7FWQ2FxGoo7vhZ
 Yjo+g8Al301Bf8mzJrZpAAYwhxJU3v7ymIZ/po3j45g8nPFtGC0jdxCeU3fekJoidmRM
 auEWE84xfTxK2/0FEix8IcnzaRPJpYz6VnizH7AuhwEJ1DXzijuRsniFtIGM4sxmQSed
 hfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468398; x=1752073198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/QMA3UrLT2YLoe6o4WB6MEW09cGgC3z97gJPkz4vwU=;
 b=imuW2zW01llvCL/IMldMOVUf0LBveBUBYMPomp8STE29Yl4WkTzvxWtkN4uJeq+9iU
 v1yX6KoNVQWEQPQMrnIImoAcY82zyXQxP9TGcKaZIubvXrmsR1jN5bmu6BoAOCQG4K9w
 XLjlKWt4HE0P6SYDu2D4Qo27UZScZBAy5dV+UUJ2ntYnDIzX3EgWv6zRnNTCWB8pnjb/
 dKZ9iwLBdf1bZx3N9D6xbP8i/mvRVIrzC+3lUUPraglxW29xpRXtCdXmIA1gpwT2oT2o
 Ko3htO993ieRPFWyH8kHfhXUYDYF67KqMVsViLg+POvPbW8ISbna3ecCux7lMlLcfIDl
 4Uqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpp4/gmnypyGzFRJu7T3B1uQgrxObCo9sLmkBh2n16iexUuAwCoUisdX/yr/Fy2Zik/8NK0QecQ6Yi@nongnu.org
X-Gm-Message-State: AOJu0YznyGD/O6h1VbQLRGaOPkAWV3MQfe7P78ioE8N3RPJ9EE+KfnDE
 NcjmDJ1pgciWb2OoBUpBh7B2Xl5UhL607n8JEmJusEcRmF/e92omnBLUqzsfSOkjn+A=
X-Gm-Gg: ASbGncttDxrCp8gV08iDQZJNfAQ84H7VgvvHGHYk9oi2MrmL6Si1fv886nqMJm2pwM2
 WBpxVj8cbDZNUDNHaWcln2FQSRDAgXRafbcfyVPxK39sUByLNJWLDbYRI/1s6UBG0ZX7dwkZvHK
 OWaARU3KPvqGpFKEqzoTr4Ty7Pi2y8A0JiJnnqNic+DcxDwkd2XTQQswWrhQhLF9KUdUgFaltoq
 6K+yyEiFFwHkwRMy1bZ9ipDXNXQJYcm8akXZPu1tkT68Mnv6zLyngtWSCPCbVz4VGtNd4jy/JVr
 GjgMU4v9akBR08pd2+9Ok3cGwv6dfAod8ZVgM/rrrZ6BIBG0TkagzsbSOuCMZDu7nnbWGn9PY70
 v
X-Google-Smtp-Source: AGHT+IFiq8UqcyE9b34XQ7QK0zP+NQ5bZ33E/KYVOixVD4+IjawEcAL5KHHAksVZ1F4FeEf1p9TZpw==
X-Received: by 2002:a05:687c:2e0c:b0:2ee:2800:85a6 with SMTP id
 586e51a60fabf-2f5a8b5914fmr2535838fac.26.1751468398433; 
 Wed, 02 Jul 2025 07:59:58 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73b0f3ec6dfsm2009452a34.59.2025.07.02.07.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:59:58 -0700 (PDT)
Message-ID: <6f583a66-4288-4080-822a-764e090d7332@linaro.org>
Date: Wed, 2 Jul 2025 08:59:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/68] accel/system: Introduce
 AccelClass::pre_resume_vm() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 3 +++
>   accel/accel-system.c | 9 +++++++++
>   system/cpus.c        | 1 +
>   3 files changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

