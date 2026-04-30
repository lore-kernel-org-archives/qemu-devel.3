Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10522FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIK6g-0004Ku-A4; Thu, 30 Apr 2026 01:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK6G-0004DO-4N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:38:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK6E-0000fZ-6L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:38:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44261378651so1012462f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527488; x=1778132288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JvOPgAAJspuflVT8enNzVciGOFKWL4FTqHg7jDZYx30=;
 b=PoIaF5jHBS6LKdaGPWR8hVBBqTrGi0yQi4s+SI3Du7n6g+s+f1xmba32mZS9u9AMPP
 aavUfxP27mvzLfK/MPZTyDy6ayx9d2r1V85HAlVAtaTFtT0/u6Yyok59D/MyH1yzYR0F
 AuRmFMh2SbgS1EKdNgTDkYS5S5CzX0ul1wdYqFXo30Ve+iHnBejqXcRx70CmvEXvR27x
 0Hqkb5ykHTgFCnihYMG/E7otSnsY+zKpL1YwPfmKxncS3SqdVoW6z4QeDFQqdg8iOoFF
 HjFkwrw04l37ZetdB+dimw2Pc8VuP6lXgzvzWGdXGnPNPmBOn+87Qxidyv/JZs0IB18t
 vmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527488; x=1778132288;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvOPgAAJspuflVT8enNzVciGOFKWL4FTqHg7jDZYx30=;
 b=M4lFkDU/i6qpSvpuXClyGD1NF7aByW+7zSWW41dZfWJvR6KFO6E2ydD3Bf1wBruZD0
 QnqGZ/V4fr9ZXuz5JSPRDDAZFbBnReyuWR9opFWBmEAMXcq8eJ5PGjcoNyDl92FRtX6r
 kQ3oUcMfwNtgOZWGk72604VIYIP9IM/ipUlV5WMWSv9wr6HyX63G+m1XQJtePgC2HwsC
 6wfFggmokvhLwW9l/WznH/KuijvteFbe9m77XRcZ9gpEhqlNJ1MLgLV0eeO+5f/NoaO1
 5s45PJ0VmrUbFNal/rTfhOedKAovKWOsFVW+0nCqXPYROfxEiqfmZzmfNWYG4XG/4ccr
 2gSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Cgihcr37G1JQ8yWVzmVWqiC/O7VP5hkWwjPt7/pssh+Xlg/DeZQfLi8pg2CqNxDizuyFLXznXsQb1@nongnu.org
X-Gm-Message-State: AOJu0YwFOh47kyWzBrEVcpj6aPbGWE11TPVJu4tVXdwGibkvpxHKB8uF
 5M9j7MG1gshmpXQ+wttSQAjSGyFbUHgiWqR3wHJUJWtk+ZC1mzj/HuDWNCWQBrwi1x4=
X-Gm-Gg: AeBDietMlaNSzMjr7WEIJ2tHbSGGvjKD/foP2fmkT7UukxNYJbo/u5we3C4gRXvzLAB
 eerd2BS6bhEgwL5JxoQPGn5HY6rBPycrnW52EU2RXUlaxABywe6ANtKQLOAY6c4CCi+vO0jmOjf
 WKdTw0CUiOZ9XXKZcXA8OMKY53akWINwbsETPCEPON28Cy36+tZLAD6pJSChwIfhj9TfHQhVEPJ
 nJIHvzkooOIbPuOlUCCFm794tZpbhdcHaZPPF94w25ULit3IXwa0LMpPHpb/Zg1nvDKSsGOttBP
 FC3hOTxKkgwGdIpLpspE6gDbpZLV0gSVEvcOkSiY0+JD1C7WYffZgFojZzyuIePOLzzba8bDg8c
 9eDo7zS2Hakktm13fcnBeNNaPqGZOKnFhxc9eHX759pqobcv5Efs7QqOymTDALkmGlMcxSn7vvG
 tAj4CnNlWQnSEYjA1r8MF73+Exmqz29e6NGtyDEPrxHpWPxmkybDg2iLzGLZXsGq3utjar5dk5m
 Sqz
X-Received: by 2002:a05:6000:310c:b0:43e:a75e:352 with SMTP id
 ffacd0b85a97d-4494dd48b5emr1831121f8f.4.1777527488272; 
 Wed, 29 Apr 2026 22:38:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-448e74324a5sm3893375f8f.12.2026.04.29.22.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:38:07 -0700 (PDT)
Message-ID: <8e80505f-689a-442a-818e-366d4c6b3532@linaro.org>
Date: Thu, 30 Apr 2026 07:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/40] fpu: Export unpack_canonical and
 round_pack_canonical routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 02:04, Richard Henderson wrote:
> Export the unpacking and repacking into the various formats.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h | 30 ++++++++++++++++++++++
>   fpu/softfloat.c               | 47 ++++++++++++++---------------------
>   2 files changed, 49 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

