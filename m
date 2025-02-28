Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19948C282D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3cQ-0003II-Rs; Fri, 28 Feb 2025 11:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3cI-00036B-6N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:53:39 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3cD-0006VN-RF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:53:37 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223480ea43aso61093805ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740761612; x=1741366412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BdTxu/Fbc8V+uuokoy561N/92tzo7vuSN7ONms8a4r0=;
 b=Ee/QP59Ub2HmkODRfnBd1ssG13zqbvmflrE4ZbJoha2lhgxanaoDtKbkF20tob+ZDa
 XMQJs+brdj3NX2nO0NLA5VBq47aFEDEKxv0JlwdmTZlD+r0AqZd8PsqtMwW+lT3Wyqns
 RoXnuIl2D1d76AroJIocxBXHkEf4kZ9FbG5GLET978gP9pzbOYvYEg2634+h3jZFF3Gu
 9qHbvNYkbQO2SjgLRc7vQRGjh7jj388TMBm3E2QOsqEXzR4EkBUUlMsY2EgB1YC8jCDH
 HP1YlePRdg54YdRgzhG6UHOlC7xcKLiN3bFnGzAB1RtnfIYfQmh0EofzyA6eehOObhMU
 NrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740761612; x=1741366412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdTxu/Fbc8V+uuokoy561N/92tzo7vuSN7ONms8a4r0=;
 b=El2pw8ITOIgZ0FIleYjpKRBkQh+saLylgIDkYzJngn6Dqq10OcwsKHJK1OBDij6QaZ
 rvnUu47oulNarvbQKK12WzueZuh04Gomv6YUV5fwESTi/wwvi+yqY+Cp7pi5XPKf0V3J
 wHt/xy935+wHTdaKAnpFm8OCShm1U3oST86tDSwLdKo7AUzmcGeZ6n6k4yiHyrBWmQzg
 eaG6Q6fZAhaw8Uq5tlXChQM14LlMbwNP/zXSUnFIXr3ONdDtU4xRviRZsFlnbn2FVPEW
 1YAwWbezPUjLoFAlYHxZLGjL8oykOISfi9CiCcsUBasdp2jq8mZ/5pNzITGsPGNSgywX
 pM4A==
X-Gm-Message-State: AOJu0Yx0jASWYd1qiX2KOyzcXUOlRLZw6awMr7Ie7QIm1nT9fRpc5pvY
 CJs5caGiw2DLir9hCFPYyFsbb2Hz7jr29h8MZm9U68GQutUUYep40jPXMG+1LxPd7pVIYl57Vjq
 J
X-Gm-Gg: ASbGncuAAIlBmKl5grghKjG1OJOzHYVittJUVy006F3S2rYq5jTSuJptfziqTAeWxA3
 rOt1g2r7nT6LCKTq8XLkmSBw2jzUpU84IgbJOEpBJ7QcD/j//UQPE6RSUs3s79jo/VxTSS8tHw5
 ziv2k8kEDS2tHb+BbvQIhGUpboxkIOHbS5GBaii2iKHY9FH964sX/ktc8p2NqzVIxl1ZJzIT/HS
 39cc4Zc7EGdSvLotWdyx6cnFcYXzoTY4Vwb/EvgFArYnRc8XsXXxzBkKF9zzBYVJmiCqoXFzZ0w
 rGjuqAwb+kkh0QQ9/NcYgA0tD0XjqKw0iROUFcBuDMl6LkPX4IMagZoBdSi6AttLhc12nuBg7zf
 7lLb+Caw=
X-Google-Smtp-Source: AGHT+IHsa0TN3CsRmpqtWPWs2QKn2n+zu71qcBBy3BkoJZ3DYmIGhdZJ2GXkzdXu0MVsw5V+p/2PZg==
X-Received: by 2002:a05:6a00:228d:b0:72d:9b11:1ebb with SMTP id
 d2e1a72fcca58-734ac34ca79mr7434663b3a.8.1740761611685; 
 Fri, 28 Feb 2025 08:53:31 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2a640sm4111166b3a.16.2025.02.28.08.53.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 08:53:31 -0800 (PST)
Message-ID: <d9eebcc6-7f3e-4b14-8d4d-b99c789b4950@linaro.org>
Date: Fri, 28 Feb 2025 08:53:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] tests/functional: set 'qemu_bin' as an object
 level field
To: qemu-devel@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-3-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102738.3064045-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/28/25 02:27, Daniel P. Berrangé wrote:
> The 'qemu_bin' field is currently set on the class, despite being
> accessed as if it were an object instance field with 'self.qemu_bin'.
> 
> This is no obvious need to have it as a class field, so move it into
> the object instance.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   docs/devel/testing/functional.rst      | 2 +-
>   tests/functional/qemu_test/testcase.py | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

