Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB06DE6ADF9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoVD-0005rJ-Jr; Mon, 22 Dec 2025 17:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoV7-0005oJ-Rh
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:35:38 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoV6-0005Ug-3k
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:35:37 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso5017134b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766442935; x=1767047735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZsPPA1yeSO3RwBD5KQi/rftlTaoCCVx+rH8753eYz4w=;
 b=tLnmFfXcqJOQw4RKGl8fkmasZLw/EpxjS8WbXit04ngUpkQOGEIXeZMHhoUiy7VTOS
 8UmeGO/FE/yZkp+TSda/5MjWnwFmSi/rOtde6T8i3swLGsCNZDVj4mRMXN2q5WlCkk2o
 HHXbTzZzEck6Hh01vGsfJai5Rfq0Z+SSg+ELEUrvT5YK0sDM72vFWJxrRY4GeZOj1hUP
 ym3Vk0J60UHT0+GX1q3UZVz9CQCyGm1SXMkEbxudRAY8LuVcZJ2QCEZLT1RQIL00XyOg
 bAfk/ycSdvhnixlAhsI0ix/fIH9zgKBJvsjahj3fHPSag8oowmccK9hYxOxckCugod3J
 UmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442935; x=1767047735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsPPA1yeSO3RwBD5KQi/rftlTaoCCVx+rH8753eYz4w=;
 b=YxuJo2A0g4xHIXjX7SOeYP/KkQr/CTyi/oCiZ+MqxNc8NDyP0+UAGBwoqBts54hYPJ
 mAKPrIo/3bsZKp9igLrfN2S81fLtanKn0ycsl/+xEuQwSMGm7ITZT+7k53HqVoerrgeD
 W00tXkBmSyrxTXAl3hlEgTHd9m5oHxYv1XoR6gAVnUaHToXlWnlNAudjzrYO3c2mgXvb
 AQ4D3Zd35HQmGqKgcfKoqhq39xw1EmnrjFO3wRIPKvpSDSV2fPWNzF+7D6YbuUjnIAT5
 sNuqtOJgIJxsACX5SuXiz6xkqEzY9LkHGPsXx+wrAchXsSBzt4G1NpMEIWlw6uc2VyTW
 cBIA==
X-Gm-Message-State: AOJu0YxjkRA/MMYF++NmngJ2P4ffezxS5wA3qYPscLnGPLoDXgBi+7Aa
 86PrMw7n9OcrjX+F5JngbDCZqooAxYa29Bwscpd1wnlhUz4GPwsN0ZKNSnaFGXDDqEM=
X-Gm-Gg: AY/fxX6UQ+KZes8yD+cXbiv2qp8qB0awszqoOT2fK0vv6un6sVjgr77dotofT1Yr34i
 juSxNemUieAKpaDikpLUC8PjD+ugGkGdfB5pTW1dTJWpYQCwN6XTmTUojGjEPfw1JYykMdo+XdF
 dthn7uokiwUi5BucVpyIK76FU8ckpBOeEKsZpZI21/0PNSxrIVy2vKyJtdHqIHv+q6+O0N3E3kk
 BEc4vh8gWkoK0FEGYpY5B45zhmSpx2DoinB18RpZaDLqsKiWuUaZkqOw405vB/uoxSa29NC1QE1
 48jcOMt6eUXTpu6/o2AXoJ0uK774YEaKi/5XWnQKNCciLE1SjeS611lXUW03xgpUyKI5VvVhDmU
 y2fol2zQZsdfcgWvhgvSh21ErKohWIQR/TDU2ZCpGrNwpkSUn3hZrMpc4EfSb/LS0g1rPVc4Aoc
 MY8sIfKYmyqvhwINfgHCJKW00LSzGSrNgdQraXCieQIhNQT8rfvSZ55jk=
X-Google-Smtp-Source: AGHT+IGByNqZ1INfiHJSv1onsUFag//FhDqoBzMy5T7Qsue8pjDl7sD9BhKmxIqzlx0XndyP1ak32A==
X-Received: by 2002:a05:6a00:8017:b0:7e8:4471:ae68 with SMTP id
 d2e1a72fcca58-7ff67966c94mr9703260b3a.52.1766442934595; 
 Mon, 22 Dec 2025 14:35:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7af29dcfsm11481497b3a.17.2025.12.22.14.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 14:35:34 -0800 (PST)
Message-ID: <079547cc-a4be-4f17-86eb-a33c752c6ad2@linaro.org>
Date: Mon, 22 Dec 2025 14:35:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 5/7] hw/arm/smmuv3-common: Add STE/CD set helpers for
 repeated field setup
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
 <20251222124517.3948679-6-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251222124517.3948679-6-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/22/25 4:45 AM, Tao Tang wrote:
> This change introduces STE_SET_* and CD_SET_* helpers to centralize and
> simplify repeated field setting logic.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   include/hw/arm/smmuv3-common.h | 79 ++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


