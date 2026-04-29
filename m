Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD7FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI8zy-0002FW-MK; Wed, 29 Apr 2026 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI8zx-0002Ei-03
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:46:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI8zu-0002R8-GT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:46:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso253605e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777484813; x=1778089613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RkIXZXeSBHNXV33qZhjL4CNCiZuR+6rWWs7KYOUfSTU=;
 b=QZXm1hVx6bp/HEWTL1ZGDsJRb0y9U7R+OmSCcZUeeE7WRbDenfiGuzEbf0gZNXBVkz
 qjqL1jmnAZel0rAIwNTuORkOYfmtTvfntcc7stsUS1p3xjvytMleMmGYvuzCXxeghxZj
 75WZD9Df7AEuRqfS04oMXqQUnj0CBrug3ikOFdBTPINPo9dCv6xpQ0sCu6MDnyU2nyk/
 fmm49V/G6hnUClvd6gq+r650JctvhfWqdJLH7N1qdcjbMHNSIlbHaIwaoJ++mXlZGlUu
 NOmCLoV0tv0zWiJiatgCSM+s+yaK0p53npcuqp61f3qQjH11i+GGRFRtD6alF435JRBd
 USHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777484813; x=1778089613;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RkIXZXeSBHNXV33qZhjL4CNCiZuR+6rWWs7KYOUfSTU=;
 b=DgIK1nPrqt0PlPYzQrcbm3Gu5tPbk+1C6zgzew6Ar0FEsqPT+zlMlYI3AV1LHt1/V5
 hBhlY5W76A6vkVIry+btr9iNhl3rICTP7KldsbTOzotfBDNbdT5uggckV7N2BF+wONPv
 BcJEcZAUnEx7riRPhQb9DASlDHpo2FhHpVUNwb4GqXgJzu8arHImJOyLK0Jy4Dhn7hXP
 b+2N2KToIQMY8h7Tt+Cy3Sh33lse1l9zZdqbaePofTWgQQm4tvzBWvngX0bZNpuyqsF8
 wAw8rExFPoI/VTD/kz+WdilHskUORn8p4iN7cCkIkfknl0qRkaYvVsPpbjpY5cvmBH5h
 vhRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A3zufniLmXfjGDRGWQjtYlHFz1askqzT/NdgNTPZ2SLmP6TWlqre27nbEvpWdHd/MhDbxc2Vr496I@nongnu.org
X-Gm-Message-State: AOJu0Yw1u2C7GHEeFKCrR7YYsgMeMTBu4Da1sijTSe6w31S2WeNjAO9C
 YJdFFPpQZQWbobLhkycIFS6ljQErsHvR/EFoU7xMHw50/vftS1dSxGVtI3iQVesiNhc=
X-Gm-Gg: AeBDiev8iN457s1lgs+UyG5FuE3lh9sy66pBkRRJjqK5RQGvdh6Rvn7OgLa1SC0pgYw
 eFcPPTGCcUQYzaUJ6GgmOgVUvGt7muuZxCVaEOYWOr1MtnBrQV3aLCM1c69toS5cWhQeCyDuxHb
 wZYtPJYZCZbNvA0f1/sTxy1OIrc0cr0d2bOXevmE7ar6VYC9X8ZDo94ofN3uuHrvjk5/VRmN6HG
 X1F1hzHPgQMsD5Mhvk2sxjzr7Y+FvaNr+DiAJUlnofTKrIHfXwCDvbjRdARjv48x8ZDsxnAMQn3
 r/WmwDBfwSGYz4zVlJckq88E3ODSSRA4aKNDVw23xnFK+OA8oL7vmkPtdObiCwKDyDire/WVwAx
 foOU6KLUEnS8c4tHfQKcIJsXTJh+FuQSJKDoUTinE9Ph8Bi5PQEtDvSvZpfZzjnnieKzRAybT/1
 Se5NRcufQAR9UCQ3VtZRmPLTOQuNZFs4JpGXRz67rk9Tj459xo5EkLwkYa2k3G04GhRIY2xApQz
 CnN
X-Received: by 2002:a05:600c:859a:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a7b519560mr61940545e9.11.1777484812485; 
 Wed, 29 Apr 2026 10:46:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c3057ecsm22772285e9.20.2026.04.29.10.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 10:46:51 -0700 (PDT)
Message-ID: <e1da2b86-0c13-4e31-aadb-55ca877ce204@linaro.org>
Date: Wed, 29 Apr 2026 19:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/84] fpu: Drop parts_{add,sub}_normal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260426134002.865628-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Drop the forward declarations and the _Generic macros.
> Add partsW() for use by muladd_scalbn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 16 ++--------------
>   fpu/softfloat-parts.c.inc | 12 ++++++------
>   2 files changed, 8 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

