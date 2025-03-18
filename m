Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D297C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuegs-00080U-Sd; Tue, 18 Mar 2025 17:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuegq-0007xf-9d
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:41:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuego-0002Qb-0c
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:41:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225e3002dffso69046385ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742334092; x=1742938892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=STjGlaJoL8peYNcrAd1LJeFiqwC5QN4avED5wEwNQ90=;
 b=gF680vBH6Cb3qzaZgt59iEOmcnAyf0A0zbKIgG1Q//yta0yxd+R3s7O3F8I0pgDEsV
 0Fe2fGK6weo7c8GzRsPkzo30yNYkw2GO2ZtCs1t9cHqWG+9oDnOUhqL09JTuQ70oUH2z
 tFKyp9DhgE2/4zbiTM6l7Yl+rSvw6nZzkRB+nNr4zChF4WKIh6BF4W7yRqLmFayu8hpP
 njnAK8BIPDU6RsccBruRUydpcYA8Up1TDAiD/Cshgq5MyKpWqZEZ48DIkIHV5gX/it6w
 CqKjx2vFYl6rGJkaHzUFT9L8vs6Rw2RFW7woytY+OwGrnborwtpjXl/H7zHhk6pYiXT0
 tZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742334092; x=1742938892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STjGlaJoL8peYNcrAd1LJeFiqwC5QN4avED5wEwNQ90=;
 b=AIsBPOP/O8cxqnQon+3viIClzfamfauVaHlZ3D7tb9Wj40Kk0HgK+eVrz7ZsL/TNwr
 F0Oxlb4LmKBgE6iOi2V6els6ib5dqJkZF1FkEYkLJdMQe6M+IyCZ4Kdf+jKj98UMSA3T
 mTdagEHf58hWOlRxlntIij8a01YXC5WUJMOEdNxf1KXh+Np8g0IXTY2kNat3oHG5fND/
 z+yLAdQJw5urjE7m+ofnfpcsZunfA5CccHVvt5ocEzvtR6xtvfzHNUOgt+bqdJEAvPdn
 0vvdQOApqgiEuXfr8lAfUtTY/I9slDxbCOHTwz85xRgwozU/OUUFUzNkUXq8aqMzjCo9
 U5/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8hxf4g+kX5U0H1KCHW6Uw0K8dQAKQ0GNHi9wujhWuDeOtufO2t+NvwsETK1NmpS72ioDGuYQv9OcX@nongnu.org
X-Gm-Message-State: AOJu0YznLzVx9zmN4PelGdarn0XZez87pzOPzFoRe+FiG0ohWnZ02fvz
 vaKQiTpbH+O90fXvrcpg4CZWy4Vj+IwulEpiBmeFaD1kY/8dJozjvOUW0GWfwYw=
X-Gm-Gg: ASbGncuRkHTgZZ4y+7Q5izz8wqjfkjxa/DMSXTkWM+nNO9hnpovd+ahtRs5xb0hOdHo
 h97nzjRpFBwIpugQFYGcyBf0dbbqRmSlBW0iVo5JCGLYb0ei1pQL71rcii8x8daJTlKOaVRQz96
 SA8UasitwT5Q+CyCU0JXt+c6aOwR2aIlgtQL6DIHA+YuK480lqAQ5KAzKm8yKEU0gCKeAPJnFQs
 tdNPh0lUDD2Q9foktRScG+VMHaFYqeKhkLxgPk2eIRZd9m48CYZDDFoA3aGUAQ6RnfnZOW1+Ifo
 mag5DTfMCPLAcXEd/XYmDVXEe1RtgcyESfvJvLXc/JErwl3288zExxkcae2uIqq9XQDPAzAS0po
 JgZl8T8V2
X-Google-Smtp-Source: AGHT+IEvjE74CFsm4MscUePIeChNuRGSVzaxg4KMJo3HjCDFURh6xUnSaRyz1CmLeVtwy7Y/lOF0tw==
X-Received: by 2002:a05:6a21:6d85:b0:1f5:64a4:aeac with SMTP id
 adf61e73a8af0-1fbed313382mr312364637.33.1742334092205; 
 Tue, 18 Mar 2025 14:41:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116944easm10408525b3a.134.2025.03.18.14.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 14:41:31 -0700 (PDT)
Message-ID: <2766725c-9287-4ba6-9e14-e84616d5fd17@linaro.org>
Date: Tue, 18 Mar 2025 14:41:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] exec/cpu-all: restrict BSWAP_NEEDED to target
 specific code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> This identifier is already poisoned, so it can't be used from common
> code anyway.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

I'll give you a
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

because it's quick and correct.  However, there are only 8 actual uses within the entire 
tree (discounting comments), and all could be replaced by

> +# if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN


r~

