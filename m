Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F88ACCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMXs-00051G-Ad; Thu, 30 Apr 2026 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIMXX-0004yA-R5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:14:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIMXV-0004ze-Vy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:14:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso7681505e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777536868; x=1778141668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uq9Bb8nDWExSoEetUXIIKRAZNTUxAqr7m1l53Zxe4zk=;
 b=aAD28mjvAU2UhsyUF5ARU14nyRXon7uPaOf2o6jUYUnoBkNZ+Q15VRcYFaOYkheQwK
 d6Jsbvd/Xf8Gxs24O5KaIb16AVmxePU2jF1+6ugOWKe+dEvi0SMozdYFyNUx6zB9FuQT
 k8s+iCGWlAXFCvohFf47X76jTCsuOpjdndc2AIZVKw/WpwwzurGDfLGCy9MhLUmg4EOH
 Yh6U6F80u8ZCfHKVw/IfotAgEMmUpf1ZjRB124FCrLc82X99Y/G7fFiOsnSmuHPKXPkD
 SoIIcjMsTk7W6zQSgUlC+SG9g2Ts6NtWs12+80AZc62GkeYF9bM1WzpMxp4uDtR5AgM7
 pYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536868; x=1778141668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uq9Bb8nDWExSoEetUXIIKRAZNTUxAqr7m1l53Zxe4zk=;
 b=ohgv9fcfJSVAiSRc5vqODUcmLbc8iVrZgLmYxTdZuOXY8XvaHt5pJGCKRwM6iywjr2
 ywPXTq4JKWWpsCPv1LAVRsnZRu7UCv88VTsb+p8xUVzwZcDQCyQHXekuBx0qJCUVUM6d
 1j5QyuTMXPhKpx+QHp/PaKFopePuSIcc+2OzoWrxcXqkyxXQYz4H3yvCf5Z+Wxn3LWqw
 FZ6X82AiBJZJyy6TnUNzWjAhiR+32ATBnXWxourJgxPKWiKqk83gyHjJDn0kpymD7PL+
 z5OczzeZJamYgfyUOcM6Noyt/bO4B7LiqsJ2hO7LakMo8/ALRE2so+p8G4dKmPvF52a4
 notQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qXSIrRUjc7O+X3pYOp61k3Nnpue6S4MzD6ttdftaF704eQDP4IEGhN+36z7cDSNvHtx3WbI5llAmr@nongnu.org
X-Gm-Message-State: AOJu0YxOFTd+NC4QKrIckUnwrhMPLQ9Zb2VPV8FfqUbjCxGvL6jdd5Hs
 07sIgR5Zaqb0M2XKpoVejR4ifG+eZKdW1eImQT3TUK/fE7gdSA6XATIvV++HGEOl+DM=
X-Gm-Gg: AeBDieu3HhL3sXsdecJLura47HFzZ3VOvRivWpGfRmsV3MGy1uq3JBLSWFXOlL6S605
 SCpwkF/TvN1AYmjMXzeyqu4wuXCHAT+Jey4RzZe92qsZ/I4Iq6cjk9vR5kYQcRpocSWI5WwsDaT
 xm0U1GBajbg4/JHDZgjRNnMHjiXhUUAWiUMZqeVk3e0FUMaDf3UU8lIpN3nqMDhOSiF30rrJtck
 8g0FbV0sLLe36UWZZP2GK+Q6ccnpC5eke9lR/GMPqioRJCMyvA+pg3tQGciAU0qU30whHUELPJN
 d5GnKdDk/1GzEJ9iHOqsqI9ptKcn2rpLUI4pyCmGZgWPykR88BXLg3L0bkrwrbUAZcs9mOvLTzH
 u2flH/Z+i1sIK8XR3LfP7I166Oicmg53GZ/O+qx0LZqplT0HjzlnALQA4A+07w81dzfBKk4ryTD
 JNNqPfFhRoi6PleM1pIu2KH7vc3SlDrwWzY5IYWnFxFsH4BqDECUiS3JX695uZPKaEEr6uNvgEU
 /ieKlD1qFW08jo=
X-Received: by 2002:a05:600c:4ca3:b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a84445b32mr16368595e9.13.1777536867713; 
 Thu, 30 Apr 2026 01:14:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c856dsm50239785e9.6.2026.04.30.01.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 01:14:27 -0700 (PDT)
Message-ID: <58aa3189-5885-4cc4-b07e-1d5c63197f69@linaro.org>
Date: Thu, 30 Apr 2026 10:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] qom: make errp last param in methods taking va_list
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429210830.594724-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/4/26 23:08, Daniel P. Berrangé wrote:
> object_new_with_props can't put 'errp' last due to the use of
> variadic arguments. That constraint does not apply to the use
> of va_list with object_new_with_propv, so follow normal practice
> with 'errp' placement.
> 
> The same rationale applies to object_set_propv.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h            | 10 +++++-----
>   qom/object.c                    | 20 ++++++++++----------
>   tests/unit/check-qom-proplist.c |  4 ++--
>   3 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

