Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3009CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GZM-0007Ym-Qq; Tue, 22 Apr 2025 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GZJ-0007VA-6y
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:33:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GZH-0008WO-8K
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:33:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so307155e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339632; x=1745944432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhA5xq49HNzqorOYQ9bY2ILXiNLjv82LVcLAetOf4D4=;
 b=O4eDhbriCiHwqcNdO5LRZaAUnmeGo5rNR0M81SdAHp5g/Ip8Lv/g5mDrwIoZS2CEtn
 AkX4A7+FMS1zU3smmdibXtedxr3M39ih/E4i+zSUbv/+myuKEfSNXrh3BtdLnOkbVpaH
 HGLsspo4aVaj+UV3XjUGk3sxrvbVXTAdhXGEcMAqWxeR2mCep1WcetnzQ8OEmOZIVfDg
 tXZTGGSK6DdNWDXcJx/PRW7sdtm+Hj8M0Cjxzvqy1WH1xqB80lxtEPsVByxRypTYGyXh
 9RVNcIwHWjL5ZcmICuyS6xGi0csWxxUaONPUmh5JX6cKgObyDkdSBindUvmS489Fd3/U
 jBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339632; x=1745944432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhA5xq49HNzqorOYQ9bY2ILXiNLjv82LVcLAetOf4D4=;
 b=FrEQoNz72adBPfxtAB+VK5PuokLzIoG+zgiUo/PQvmNwWHgMqyvsE4wjdtlCYJROG4
 PCFx8gfTUW9+bJV81zOsI1zHDNqLlI99HOSOeCcxip5Gns3msb0lWbDzAL4CNV8AnNye
 KcEtvXPYWDYwUgJwcE5rg9n8T24mhNG9kHQ8Ltnn5+jpX9zJqsJ5Z8Aadxz2JUTAL7EP
 7glIGqjSWx77BTsye6PGa1wbgfetnTrtck8zOHkHhZ0WEA4QgEYX70zdQ30JFZSI6Wod
 sp0eQ0OKDF7swyTefs8s8xrp/g5n3d4lLVrSZUIkOn/90uMgC6WLojPbGL7TztzShYzp
 ZvfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhslm8NqeLdHU1vadbQRpxA6esMc3ThWoZ3CKonsrbQb4CodTXSu38OgE3BbLi3znJdfs9rgmRbNqB@nongnu.org
X-Gm-Message-State: AOJu0Yz5spIo/91RCVWQQRePO01qyz3Gj2lMAJ5wf/CE+++LLwfA95CD
 2aVrCtpydmiPzB+zWUkUk9RvdMUBmEB2yS9uJpItkLL208V2+VjkG68f2B7m+XngjbMYcglzUk+
 e
X-Gm-Gg: ASbGncsFTezfr9B3iHVrxRv2St0izoMXRs6JvWJN8qtg7+wmVcS9JKPBe3VhqnffJQp
 37Kr94eliJlybCCcpf3P7vnvFHfn3FZ+P9cx1DwxOJSfcQ0NOBUmjwiWsuEDw79qcl0rGp4qY35
 XMYMGEqK+jAbAn+BSAs0d9Y8aZgxEWKHDSuSEF5Ec1MxhbSh4Vb9CNzl3Iy7R8Rx/ZLxeUP+sSN
 bacG9/FkTs6zhzrn3jLAev+dJ5LlCtCUERX2B3o12mLLmkt3zvfqzmWxnisNBa5zuBL/QUvoXKp
 xrMS+96pNOvFcl/jb1p778R2waHaUvrZdUnRNmFKgxmujqDpcKYLBkY6Xm87LWSjyBEvlOK/HPb
 ljz9UXFqu
X-Google-Smtp-Source: AGHT+IEOs0gCvNFDNbnC4OHsq2u5D6RCDZEolQJMSY4m/0IiqhvS2RKFBrHFTo/AsVfkBx8k6WQa2w==
X-Received: by 2002:a05:600c:3106:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-440697904f3mr167195245e9.11.1745339632336; 
 Tue, 22 Apr 2025 09:33:52 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db173sm177331945e9.32.2025.04.22.09.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:33:51 -0700 (PDT)
Message-ID: <724f89ec-c172-4cc6-892e-b0090a7e7fb5@linaro.org>
Date: Tue, 22 Apr 2025 18:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 129/163] target/s390x: Use tcg_gen_addcio_i64 for
 op_addc64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-130-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-130-richard.henderson@linaro.org>
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


