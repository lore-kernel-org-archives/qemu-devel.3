Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D9106FD6D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0tDd-0007SE-Ls; Thu, 12 Mar 2026 23:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tDc-0007Rr-7O
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:29:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tDa-0005A3-KA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:29:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso14752025e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372581; x=1773977381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X6XwO4DGUjm2IaJ2h9VQF5ZH5UmMsu1yvTVBGGsClyo=;
 b=Oza52pSdV6qLX+I1h0o3hscxU3qPX3/CSos9MZ69KPb/pHJnLkVMgUuF9p0ttML3F+
 DXOmMfGwQWuH62k4o830G7F5wy1CXUMs8KrS1FdcQDEoFI+QA7ukICoaxuKug4QgLlOJ
 oou718WBBfnmwZGJ8WVYyWN1FoR1x3hMgJnR0FhTC27suI4uLZyWkJjEcc+I+IK3mCLz
 Kzf0kD4lKNIeDHepYn67Pr/4zZlIeWV/lwg8nnfgDmuEE1IruN+KZeXY/vDeG0JYZj/W
 z4IDQI3RMkn644ovatBaPwkKeKBTjCgGy5KvZkO/WVFm15WSCb/01y6DICeN0sNpY0QT
 7N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372581; x=1773977381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X6XwO4DGUjm2IaJ2h9VQF5ZH5UmMsu1yvTVBGGsClyo=;
 b=nGy0sOJAuIeekV2lbXrJ0JProK44TU0oLzmD1j74GBWI2Ph4keRyvLl6ZUqKROzHLL
 PA0nthcP+mciQOxykSg1kQkYNVM2fSGF+xXQBJv26ZuK9vGiDndnTH2iTj4TdHmM+jbr
 1My7KwOhpEBloKRmHNzHXLscmd/na9MmcWorQaLNsar2xRoHh1VhJvmu0C38MNbyWLCZ
 vzI/T039d5iqHBUe/Dzlg8pDxG+U7hQrzakecIEB7aMy5AutfHMLFE89Zx0ygdkVbHr9
 a96m7revRw8cWvY2mQLadw+CGrp0j2ukLwjl+B7D0Cad7YHf6s1pD8V4lEl+AYt5Wicw
 gCRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAbgCdItkgeRIyoiaQ1+xlnMDNxzSP3e/XxudPKstCBGt/JhQzSPGuAxAjWLAuJIZvq4C6YRqwc505@nongnu.org
X-Gm-Message-State: AOJu0YwZp+CJxi5XazVkk0bWEwzjVEv/Ewk3LAafwf9UztckWWCgh4Iy
 Ji1lnBateUUyHD+/FmMUyHK8pT+gAaSNFvm8h/uR6IxhqUUMJ8oa8bgf1Zh6p6gMeWk=
X-Gm-Gg: ATEYQzzlDShH6Lv4PVxu5Avt9cm3AQHWki+K61ovhENKTnOLTQNRO1SKDZG2oSkAJED
 SDtMLon8fvBIIrPJrqG8qztC8tt6p0uMMlA/jcJLU1UMRI/PRDSbLfVW2kASVRrWjuPg79AM3RO
 W7pByLOnjWAwk4FtZSA5yFCNK4g+8OcbZgWFh91IDcAqG1PumiloYepP/lgpOJOJmQewgOr2B2m
 GiE/VGwofFK4mMTizGnS+NuusuoJpc54i5X+pqIXQaEz1utJxnrHvHQS9elEZbsNFEZzH1q9LjA
 Gd6HrJyDhOt/im6loyhlm5lcwfiL8Vqa+Yeegy9fhZYB2GFYcAkXWjIgIviCTlmLemMenSZGbKY
 L7XhybmUIgTltr1aFeYfEcrg/W/0dJKmqowftS440rEML5YOl97Xnz6XaCyvl/oLZAB89fb5Kb1
 uQ8VZRjKEY1Gfif/H3moeoM4e9FauQrAfau1P1h5HiCCXYi2SbnPDCnc9VBb+sWtbXNw==
X-Received: by 2002:a05:600c:8b6f:b0:485:469f:5320 with SMTP id
 5b1f17b1804b1-4855670ff09mr23915855e9.30.1773372581128; 
 Thu, 12 Mar 2026 20:29:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a78cesm13141634f8f.11.2026.03.12.20.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:29:40 -0700 (PDT)
Message-ID: <8904904b-5e91-45dc-aae9-bdb0d2f21349@linaro.org>
Date: Fri, 13 Mar 2026 04:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Since this function needs kvm specific types, we need to extract in
> another file and link it only for KVM builds.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/kvm-spapr.h | 12 ++++++++++++
>   hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c |  8 ++++++++
>   hw/vfio/spapr.c     | 30 ++++-------------------------
>   hw/vfio/meson.build |  1 +
>   5 files changed, 72 insertions(+), 26 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/kvm-spapr.c
> 
> diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
> new file mode 100644
> index 00000000000..1a7697a07a8
> --- /dev/null
> +++ b/hw/vfio/kvm-spapr.h
> @@ -0,0 +1,12 @@
> +/*
> + * Vfio spapr kvm specific functions

      "VFIO sPAPR KVM specific functions"

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */


