Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6D2C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZw7O-0000yf-GX; Thu, 10 Jul 2025 14:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvTi-0005yi-B4
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:54:38 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvTf-0005Kn-VE
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:54:37 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-611e455116aso723837eaf.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752170074; x=1752774874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTV+R7aGZOqN+fQp63L6PbwpObrFEHqX3d3sPjti1z4=;
 b=iB9qYrD36yx2y3B4+UZBZUNDlUImmm24TyrhuZTWlFSJgLZkwDtVPyoweofAw1Z7F4
 UKfV4Y0x1Zvm+uppfWbjDsou/6pj3zBLC7/ataWZIp5xGtVM0CKn1lKdT8jxt41saIj1
 cw8MfbhIT2i3LQvEK7boVsTNJgvO2IczDzZNUxgJfSx5aDKsOQcFWVUkV9QVETIamZOt
 JAATx+sGnIR3gzHLZ7F/M6n7uc5ZWVJ9wiJpviB+T2h4CEAmwB9HA4nL4CEZWjab4Vlf
 xUuPMWpjNKr9/RWcH5q/PUtqywd8P7iEzkqZy3DVvVfn4iuzdudhFkr2yeiC4vJJKmcI
 BtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752170074; x=1752774874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTV+R7aGZOqN+fQp63L6PbwpObrFEHqX3d3sPjti1z4=;
 b=xTHwbzM4LviHUDX3ifmmm8r0q1iFf8b4XUwg8AZkIml09y7uxFNSlBywezj71RYicM
 j0v+MoXy0+wt0fK6kegNTc4fbXUxRwfFrVdM6MbXBL2q3q0TPEUXxXWIMNFbA6wegUBQ
 KcMEfj8nxAQqldSObsa4vIF5lzzGaB69845EENEY7rQ6Tymnd97kX1UPjDZ6PiGEZei2
 iANnF/qQLONibvlAq2r5bXzGqKhvpGivK0Kd6+ihB3NRDmCfwYHNVXWubp8E8m4F9VKs
 gxoe3L7YereW+rK4WaMz1eS3tcS3sFehb+3Ll5eNEuix9sq+cSJlVxqzO09h6m7MrGer
 TD5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQyXqDnpf1Kd7fEr4UUIZ8pcnmrBhfug0rLJfgap4F+GjgYC6pbksgaMItC5S/FG/GaUTReWkYSMYA@nongnu.org
X-Gm-Message-State: AOJu0Yy15rILuiSf+x0jNsxpP1ainGlLk9O+poIAE8Vo5dph6cZrfSal
 /FNq14byE7h25cLmFwuiLxiCDt5sNIHrXI68fTbv58C7UNQZ44B1AijH+y8kuuO6LKU=
X-Gm-Gg: ASbGncvd1zko+meMTabwLdpISoXojANKuYcehvTB8Y/JBg2LMhXanbCleY+smHYatQc
 I1hEMpI2zJhMJ6fKImwzeXVg4MgzwnGpM6mOS+XtbU36WytJ6rYg8PITBHEU8p5tA7Tn/LlWZjb
 sAziSFyIPA9A6GGFQ+uHQCnjovC7CfTGSD5ztXdzZr2oVh8uYzDq/7IWADbBpn/R+IdQ2KbmuG5
 x6F2E8SunZp+jwIih2mXiNp/kUkcRy0nwtPvsypRYJy64EgF1tyKagm4faDy62WQ4T3ze8ttnbf
 TnaUC19Ie6LoEvcYdQa+x4BaakjffxP48WcfFoC52qNOa0QtERexCZuHrYmVnshKProhvOVmI2x
 9Pas=
X-Google-Smtp-Source: AGHT+IGh5cfMWrq5g4fDO/HUFoUrVduF86a71GrTO/cvilF6tbagSxPU1AcyzBofaSzgjFk6MgDx0w==
X-Received: by 2002:a05:6870:890c:b0:2df:b3b9:5dfe with SMTP id
 586e51a60fabf-2ff2715609emr45227fac.29.1752170074397; 
 Thu, 10 Jul 2025 10:54:34 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11236266sm394190fac.11.2025.07.10.10.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:54:33 -0700 (PDT)
Message-ID: <858618db-b50a-40ba-be23-bedeb11d0f82@linaro.org>
Date: Thu, 10 Jul 2025 11:54:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement fchmodat2 syscall
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 7/10/25 05:31, Peter Maydell wrote:
> The fchmodat2 syscall is new from Linux 6.6; it is like the
> existing fchmodat syscall except that it takes a flags parameter.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: don't bother with trying to fall back to libc fchmodat();
> add missing braces for if()

Queued.

r~

