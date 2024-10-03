Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455D0CF34B8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9U-0006PF-Lm; Thu, 03 Oct 2024 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9S-0006OV-Ot
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9R-0003NE-9F
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso13440955e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970840; x=1728575640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjeBHXjlzQSNtx38IpNpXzQgASImIGzCJUFVpITmfMU=;
 b=UZ8wNRWFwxsMCrHbPJQjfNLLKQ07BWZZH7HMS1IQD5nggJV/20jDqRX83MGPtTf28E
 cuwPm3SkRTjzAOqqW95Dm6AwedXlf0vPaVI1A0dahlWeqBRdDwY1+xSGVPDQAuPZXRb2
 CLIKSuDNKt5W3WJcn6mHmxLlNJOySG0gJzO9OPdQxCHRv5zmHdr+V5ukUvmqTCk1FL+s
 CuTi5gWYYYc2ufo1glozPat7K/pm/Yr9hhWMKQVO86Jd22sxVmWf1Z4Tl0ipvSHTDd65
 hn0wHTB06GGP/XGITZzKjcMYc4F1cPLBNXNPVMQEHv+uH9dz82lDkvWmhcJ2w3uzc5Hh
 EmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970840; x=1728575640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjeBHXjlzQSNtx38IpNpXzQgASImIGzCJUFVpITmfMU=;
 b=TOi0Dv/mijSypFjnF3Bu/E68teshE9yzpfUstInhxAIUacL/SoVpozu9Ol+TTUte/i
 fku0i/VaPJCwsLs+F+CScp5WWt2cquZKGTFMCumNS1A3Vm9rd7l2UEU+ssYbxZLG2EC8
 FGOZKQEQ6f8mdkKHI8TkIR1YxJbwXgMFZoO3rRxhKIdAXggfb33nP33NCppDVhdPgmaT
 yxHVsney1xOlcoujafT2Xo60j3yFbs7cqqNqriNV+NxwSBQf0/D2ftnNDz6ambhPwlyB
 H1tFK7amvyfQgXBZOKrBzsOWmxUG8FwB9YA1pcJnU/XDk4rbGlkO7eWGg+Ya3VpL+g92
 0OlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCSMAhMcuPHwrudKETZCmMmEpHisEWOBKaxMypL3djNkfoJpChHR7gKjeqekf/spliQJ9uRKvf6UDW@nongnu.org
X-Gm-Message-State: AOJu0Yxw2vyJBY725w+AE01L9ntpDFOHgF9kDaoc9OI4+bGmVXmXJwQO
 bYQIQCmVUE+2lXa35RKOopOUhdNs9X0EaRxs9/FcUW9NwC0VIc1ntPDXykjJNA0=
X-Google-Smtp-Source: AGHT+IGg+2xEeOjWzICaD7z0CUDGluLiHwb6PvQu1NXOocw1KyT2Gd1P90PvAEYjuP8T3W2K62e37g==
X-Received: by 2002:a05:600c:1f90:b0:42c:ae1d:ea4b with SMTP id
 5b1f17b1804b1-42f7df9ff6dmr24091055e9.13.1727970839664; 
 Thu, 03 Oct 2024 08:53:59 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:53:59 -0700 (PDT)
Message-ID: <5ecffa01-9c8c-4239-9962-c8bcba26c1af@linaro.org>
Date: Thu, 3 Oct 2024 17:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/ide: Remove DSCM-1XXXX microdrive device model
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
 <20241003140010.1653808-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003140010.1653808-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 3/10/24 16:00, Peter Maydell wrote:
> The DSCM-1XXXX microdrive device model was used only by the
> XScale-based Zaurus machine types.  Now they have been removed, we
> can delete this device too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/pcmcia.h |   3 -
>   hw/ide/microdrive.c | 644 --------------------------------------------
>   hw/ide/Kconfig      |   6 -
>   hw/ide/meson.build  |   1 -
>   4 files changed, 654 deletions(-)
>   delete mode 100644 hw/ide/microdrive.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


