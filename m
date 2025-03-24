Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC9C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twop2-0001YT-1L; Mon, 24 Mar 2025 16:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twoox-0001Y6-GQ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:54:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twoov-0000vx-VX
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:54:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22401f4d35aso101300535ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742849692; x=1743454492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjcUgPK06/izKZfVvH05gncc+9DrDMjLcc2e2JeXhy0=;
 b=awnABfK87LMnW8X6t8cQX8OKF1aF+fns/gw1mEpfe2V4ykDls1DWH0BJ+ZIyqBNtrS
 aBPXxT155EabXe48n3PTbEPYWVqL0bZm89haXtKKkFfD7jnqERNwjk65jNJALKfvfoFK
 c8ejzLmf3/JK98IyIStPL+qza4xbPc6DeJP2WUdtg6HNuyXooNKVMQ3qgm2lojmUNU8a
 s6awNcqn5+J6zF27Ecgo8EaL2YKX/gRy4z18zxymc5alVP6JjMg3MfQajct5xj3hkw9S
 eoCxR6pHI7kfjlPyGFfcfouQQhP25Vbnxg36GlK7yoZEa9AN4i0U6olG0KOivfb2DqEd
 ksyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849692; x=1743454492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjcUgPK06/izKZfVvH05gncc+9DrDMjLcc2e2JeXhy0=;
 b=Y74QSYBA438IBrItgVKuzgFqhlJ/h9X6/3E0FGx8qMv4KmlR/od/nhcAA1LqtuAcN5
 Afcre4pcGZRfC/8hkU3pPket8Xmp07aqFRfuXh6rst8ojMr2Ym8Sx/w1cUm55RmONu9v
 ue1VE0vtA/pEDz9UI+bbBfVD8PeBMw/UYq/4RKD4DFxmOeQMuYq/5uHadAIZw+bxTKZN
 ApLVBDgfpfV1O5BavLKobCKhFYH1+SL65at8ZKj6ZUfeyruFrVrwvNrPwPXLAzMobuX5
 AzfpNSb51WLTyayeIpSqkvUEy2YkP8sVfbd96VgwyZafKweRu3yAJLO+zsw6zvyWmWMp
 bMwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX96b0qwx/9kzviFQ4mW6GNNIupemp0ouvge6CpzjHkLdod2SZG+LmLKimvjFOJxzfXE0Nicxs1KsjQ@nongnu.org
X-Gm-Message-State: AOJu0YxArTTBzgpYhS1JGSIRtc38dN4tMkETVWAQo9aLGToS4oc+SKb1
 NbNagiomxWwfsB7TB1bKcM68EGRKFb7zKn6UDUAtntRkMkjwZ3NLkTp9l+B/1pw=
X-Gm-Gg: ASbGncvvbLRJtbFXGRnHgoO0KWiiHlACUTijMTWbjQ0swl7wV/T6LjlvhCEdHOKgX5E
 IjkcrIQeHlwO0aFpa2GzPnnGqz/OfV04LUs8VdokZoJu+PHzWc1hVX6YTX1nbJ8byHu9Z07C/Fq
 HcrPo4mLCge8q0P0Q5Gzqi/tnCLVfI4Uv9Ok+INjYnh9xzCn4q2J3XzcjnFZ+iOUy/v8yzpW5NZ
 AhL//9KSHUO0SZ3BJQSSMaQyaTo0r17EiG1ZKKDSy5ZRk6KuEjDpP21HXBC4siUATVCS8oF5j5L
 JPN18IEYvq5LlRAMP8PkGmqmEQQ6seE/eaKbSiQnjU3gUMAfDSmM4liyvVMpptngKSlV
X-Google-Smtp-Source: AGHT+IGJzNx9IZ5b2eNR9WIGYzP1pk30sz3PbrZFL+zU4w+xOKfS1nIh78+kz3DyaBP6HUlThar6YQ==
X-Received: by 2002:a05:6a20:c901:b0:1f3:345e:4054 with SMTP id
 adf61e73a8af0-1fe42f32676mr25724414637.14.1742849692427; 
 Mon, 24 Mar 2025 13:54:52 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27db8e5sm7724126a12.14.2025.03.24.13.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:54:51 -0700 (PDT)
Message-ID: <6a3f794d-3403-4e80-8fd4-9449a78a4ceb@linaro.org>
Date: Mon, 24 Mar 2025 13:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/30] exec/cpu-all: remove BSWAP_NEEDED
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-2-pierrick.bouvier@linaro.org>
 <61f1bc3a-abcd-4cf5-9d56-1132c8fc3ba7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <61f1bc3a-abcd-4cf5-9d56-1132c8fc3ba7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/23/25 12:26, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> This identifier is poisoned, so it can't be used from common code
>> anyway. We replace all occurrences with its definition directly.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h    | 12 ------------
>>    linux-user/syscall_defs.h |  2 +-
>>    bsd-user/elfload.c        |  6 +++---
>>    hw/ppc/mac_newworld.c     |  4 +---
>>    hw/ppc/mac_oldworld.c     |  4 +---
>>    hw/sparc/sun4m.c          |  6 +-----
>>    hw/sparc64/sun4u.c        |  6 +-----
>>    linux-user/elfload.c      |  8 ++++----
>>    8 files changed, 12 insertions(+), 36 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

For information, this patch was already merged (by Paolo who cleanup 
bswap_needed from hw/*).

