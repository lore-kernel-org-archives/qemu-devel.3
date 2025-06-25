Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6A2C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURYh-0000JK-7b; Wed, 25 Jun 2025 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURYg-0000J8-3c
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:06 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURYe-0006mY-8d
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:05 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so1431543a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863422; x=1751468222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6cwsoOHcfj6T/5Pw1St05AdV4lo06kGzXbnHmlwviQ=;
 b=VrU46TVVBbyb++5Pj9gPd/5bf2ERF0Sx/BaXa7f/iSwDZIObH9iFsHJgsWGEQ8Pwlv
 5nKIa7Pz6d2qicvhsCvca3pURt3kby69H7CIH7yHI15tVg1vEuuOEPyedyqgvoZ1q6GA
 MocS5v1KlHN2Q8+jsvKQi0Kk/S1jKjn475EuzJlMmG2ejr/urzyYZnF+b4c3wwstU54W
 J6khvqPTZ6L3OGGYbJVzdOZAYPd9qZlnk/zKtbMDE0p/9HDblM26PtNSsQqg8HTC6Zj9
 OE2CE7fcok0qd3erWq5izyHta+94BT46YVrYd4/pQdASy/4oeCyZRfG7Hnkk4n/NK5Ff
 cMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863422; x=1751468222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6cwsoOHcfj6T/5Pw1St05AdV4lo06kGzXbnHmlwviQ=;
 b=RQDgKeEuTUT23uVvSgt65z2XVEeeZ9o0hTGoWYmOo4hxqDZT0Sgs8dPcftvI8XANJ7
 5u/6I+uUDD22/OjhROY+J5voohqLLn9fmX/yOpVFe4VI6h0uE4kFkxh6PE83TMgaJycC
 dzbdjOHKsFV2eJZbezP8E56qV4pQkKSjLX9vJ4P6qRvwjgzGCmP2erq1OeBs2GsibNvc
 PxxSs8l4lveDCcvZZG3AtBNcenA8FG9nScIv1u3MqLiGhh7hQpLMuR1ms7VROX8qE/Pe
 PsFt2r/8Q1GxT9G9ERugR5dqddkOY9wKCf4MCkQRo4D2hSVz6E1xhk+W+S4f0IBRF6wg
 vFUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNOmEQTJvlHoF8JqTqcXOX29yueXW9mnkJi7g+kXFd2AE14v6QFIcG+vTuLtq65oZQDlJlxjhXQ2Fb@nongnu.org
X-Gm-Message-State: AOJu0YxX32m4WEKPVy3fvrOjE20Xg/OyLIr7vTrEly09ksCrDpi/EP4i
 L1IrbPVvxGAaN9eidEQScT4OQFjaOj1wGUebrO32vaUk4UEBMbJHG5Ga2XxPTkENOiw=
X-Gm-Gg: ASbGncskRVC+caZ7yp7HA50gy4u8f/JIAeyImEuOflfVwCucTtThZCdPperydwgRksj
 fC65N4Nx0r/isrk2eCCGM7vTtuXq+glMhogpwPBb7AKoY8w8Yypa39Y5Yqf7zbCE1iwUGYmJbXf
 I/CW5Qo1XsVW1BNUzY/FdtvR42MVWdJk5H78sLhgscP2uYvfF8UG4OVp5F0zZXV7JLZItSX+bNc
 gF7OCPyvXzkTNqCWbPtG3EyzBhXmSbW5VW1P2ZI3lSSJThK/6x4wu5UZU+H6xyslND58Ug6UavI
 YuDECEJNVZcruV3dodgggF7E9h/0mME8LR+NmY86LDvab9thTDRyZMYnclUJ/HxoAOHZftL8d8g
 =
X-Google-Smtp-Source: AGHT+IHNHwnzom7LRygjG0lgiffrMDmER6nm6g+xmygWgAV++9f2j8yf41PY4D0AFBXJLHs3cZho1w==
X-Received: by 2002:a17:902:f711:b0:236:6f5f:caaf with SMTP id
 d9443c01a7336-23823fd61bfmr64108695ad.15.1750863422108; 
 Wed, 25 Jun 2025 07:57:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86d5ea7sm133496715ad.206.2025.06.25.07.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:57:01 -0700 (PDT)
Message-ID: <04f3f265-d227-4e05-8d57-9164250deec6@linaro.org>
Date: Wed, 25 Jun 2025 07:57:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/27] tcg/optimize: Fold and to extract during optimize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-24-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


