Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA571CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2NW-0003g1-QS; Wed, 13 May 2026 01:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2NT-0003fe-IO
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:43:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2NR-00071w-UH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:43:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so70344605e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778651004; x=1779255804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5sGamYW7ZniAK5YnYnlnemqK9YfibXJieyjqaSQdr4U=;
 b=M2lgewFEfIAQt7EfNPXbQgHubf0txjlqH59Q0T09Akyre/RCGltX4x8fHu6Aiot6+/
 fYlgYPDL4tAwZLBArzsZ4JII5XoIgw9Fr/LezaHiX4FitcoPmFnayTab7CNLa9XTHfjt
 0DknEOKC0TfZHcPIfwUzpEx67yqioKgg7gAALMm1Q3l3Nd0g8XuTYNpZgdT2gUvrBaAa
 j6wlmmZnW7oq+MHxtBEbMpKKhggvwuINXqiR3wBt+7p+uaTaAvmMeBJFlp6jbco+ewCw
 Pawr879PKQ9TAIGpvM1/0lvuYPrptIiFS6B5hTHLeoAZSJeyjbiJ+T5rkbvCxH2dvpnd
 tj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651004; x=1779255804;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5sGamYW7ZniAK5YnYnlnemqK9YfibXJieyjqaSQdr4U=;
 b=XljovD/JteekCMxAPHgz9z1Hrx7G+6My3Lq8WayNM0Y8iJI1CYfbXXMV5DqqWctFsU
 Md+QZ9Qq2y2qcVQRFOncRr32zCp2Hmj3RTI0wraNpidZyyTYiBIBpvXmDi00zTpvhdnx
 6GL+3SoH3sVTJ/fl/g3NvzT4HC37J4m0R9lGb3L35chxuQ6dATiSdey3PBYp1jUFfBld
 yG0CJPCpP0XHdFIYzjq4UVlBiLcD8Brybv8sqlOYvuX8tQdOZ0hW3WNBmoocAZgoUZtC
 Tiaa2+/63JdYxEiz30eu0QMmTGRx+0mxOU01MptpovZABoWBXZx/6yPk57x8LCauGBLm
 9Clg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+47IVtzAzV4Hhy/bFv7jP18HRPWcPtmgRcrJap6HWd35CYcSl8tn8ZOkOsTTsCDOlSChZYkJe5T4a5@nongnu.org
X-Gm-Message-State: AOJu0YzvanIMDr97vpKQWtQrz5VN0DIPRtPM5XoLNeYxSB5p+yZjIyxk
 vzOnX2RmTu7I0sX7gGQSkJX9Wj6jVl6fPxlwZEHKO1aZ1FcW+K9sJuutEbvfBVy1D2A=
X-Gm-Gg: Acq92OEHNwOfRIt4V3CXkFJCIo8vmxRs6kiVU/Fnhb6rCqt4+44KGUQI4KlCETYg+k8
 U1rx16cef0xDVuaAaWnyMDZqjbQSS2G2QCHY+6N1o0IsEdECDenoaQteJEtSA0ouxKf6kVQzLLk
 xGZ7TBiyx+I/UxJd3zWyiEfs3HvbooqGNU54jRX4l+/e9ro66T68FihSPKyewrieAvWEC99vLm7
 ukuVAUinIz9/fNTI3l6GcmUQjecl4MzS9ARwo8H5YjNERu1yGX8EblseizZGlprm5FJIcflrHAI
 N+RNV0ZmWexc8LXBchydmz6FLy3ivYOUZagcZWGjpLKriqj6+ON766s6Qy7V8Er6oa5FpdQsF2N
 dyQve4+mV+zvfgsuDDiq/ND+U8YXjYA8XsimlrsyfSs8X4HDb7DNqE8D0zIZvZsYbl6bT3xcVW1
 3FCCNv4lCF0XAp6veKKImqmw3bTwEbqa+QCSt2JrefaySZE58iskGst1ujFIU2fvcFWQ==
X-Received: by 2002:a05:600c:45cd:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48fc9a3abcdmr21942375e9.20.1778651003967; 
 Tue, 12 May 2026 22:43:23 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm36714571f8f.20.2026.05.12.22.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:43:23 -0700 (PDT)
Message-ID: <3ec1998d-7a6d-4cc7-aab1-d55fc5222192@linaro.org>
Date: Wed, 13 May 2026 07:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] hw/arm/omap: Remove unused omap_mpuio functions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512203414.3633237-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/5/26 22:34, Peter Maydell wrote:
> The omap1.c file includes some functions which used to be used by the
> other OMAP SoC variants which we removed a while ago, but which we
> missed when doing that removal.  They have no callers, so we can
> delete them.
> 
> This code was the last user of hw_error() in this file, so we
> can also remove the hw-error.h include.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 26 --------------------------
>   include/hw/arm/omap.h |  3 ---
>   2 files changed, 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

