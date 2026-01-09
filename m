Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F8D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKsV-0000OC-7V; Fri, 09 Jan 2026 17:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKsR-0000NK-8g
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:22:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKsP-0004VG-4t
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:22:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a1388cdac3so33277485ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767997356; x=1768602156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfNFYkP4JDsEfS/xwiAjtgypnUmwaDQt/7wO8vVtQxg=;
 b=w7YdM2LQ8oEhdZ0ykFbRhrjS8ODSGDtyPuNWXB5Xn86pVJCgZxAshOIPEPeex1fH3I
 7c6RcOF52sQSuClUfeIiXfc7MXuZubefEtkLqAO8m7Ig+q+yN8DEqqsV79VlyjqDIfV7
 ISs5nMGLFm1dPbQGDbzFA1yd/48V5mZEzFBMtEVkfXiBgBzW+m61A6OQOqFec+D8od1G
 hjACjX/b2zy7CsCWdoQv/00iRmJYQFyBOTTBDhFhotLSN7qWNWZQG2zrSDFT3RdtPb9U
 2w9H3lhfGG2dubEJppxOHu3ZkknlEeyYEX2UAICLOi78HUVwn2ADailynvCiFNx5tAdr
 m/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997356; x=1768602156;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfNFYkP4JDsEfS/xwiAjtgypnUmwaDQt/7wO8vVtQxg=;
 b=b7YigFE37POXUjxxM9JYCEBA/3Uj9ctrxqYfZvyO9KDi+ZtYMtUxHFu6w7egDieewX
 zF6MGW+0azCE4oHITs7sHyHcylKSrpmOWjw4yPNm6YZZYcRoecTRzaEuQyx548a4f12h
 bwNwoX2xA2k5OiN7pUjIexTXfBNAdkpoATcQ+166eo69AQRrFftaIwvdvDcnBucUdrwJ
 p5pMrd1KBOLlmjayqC2BW3Iz9M584dJWSevYrEPt4RrYHAK8q3RnLALPzYuIHIgUpoLj
 JHn/NQ0Wtiuc3d8U2Mo4dyz+0RLBLxzTXMbE2oF8bTvtcsAbEblAaTKiCkBzpsptcUtg
 onFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0p3iTFT5RyAGZIujx43uyrT3+44Cf6A4ZdrX7UQ838v64LeE8eZL5ThL7FOz5YPYC5eAkL6FdQVfo@nongnu.org
X-Gm-Message-State: AOJu0Yz3mUM+Z9yfcmMiSsVxTTkAjdI1bCfX4Y3SGoWTiWF2L//72IJ8
 t4x8/dFE1Qu99fyyOlvO1F0+/PCbbGOsh4nN3rmLJ0kIhTVjpQ9wZt1oBkOK7A4sUFA=
X-Gm-Gg: AY/fxX7yZ1c7HgTNm8AHn1Gx24Mv01P48IYLYjldZOgaMl4LPDWFMxry2O+PgbGaSHt
 YPy8HAbEpQf1tPRHQLe2rBgvMq+mQsg4ELH8T0oziPwXLRTRtrEj0rS/CTeE6uQFhRP2171DnmL
 5RT1oZJQCb/uEgX7Z86TiXIKixUcGTRESxKhu09DIbWqI4rAUaSqHVHqRpYW9KnaItq+HHOD5T2
 OiTkdPI1E0UuDpwiN7xvQZFZyHztTDTjV4bfUPQVMC04ScncT7/CzziIcMMydO0mpB0FFYt3rkM
 i9XnJUP+XxmTZwc0J+I2gVTS+Nf8lXAVk8NyO31uXWST3itn2qP/TW+0UW8AVoaXITHxd0fSYEw
 whD8qTK43TDer8O80ZxJvT9x5UsStjPdEhJo2zIx/FQNzVXdmQUWaCLY5AngXqW6FwHHE4suwTk
 Aaz+H9yMPz1thokgB2nRj4blzyxw==
X-Google-Smtp-Source: AGHT+IHU/o0zKYlS1iPaMQPcjbPYa58lrciaSPlQ7YY6cRidfuAmsytBnLw9emZU5SAj61SG4mtYLw==
X-Received: by 2002:a17:902:e88a:b0:2a0:c1fc:3de5 with SMTP id
 d9443c01a7336-2a3ee4b4c20mr78591605ad.51.1767997355523; 
 Fri, 09 Jan 2026 14:22:35 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd495dsm114940985ad.96.2026.01.09.14.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:22:35 -0800 (PST)
Message-ID: <6440b23c-cb48-4a33-aaaf-61b2b5ae76c6@linaro.org>
Date: Sat, 10 Jan 2026 09:22:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/29] target/arm/tcg/op_helper.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-22-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-22-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Remove unused header accel/tcg/cpu-ldst.h that has target specifics.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 1 -
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

