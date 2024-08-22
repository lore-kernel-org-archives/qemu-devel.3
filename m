Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 23:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shHXu-0007bc-6G; Thu, 22 Aug 2024 19:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1shHXt-0007b8-2l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 19:48:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1shHXr-0000gD-JT
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 19:48:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201df0b2df4so11193075ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724370524; x=1724975324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YWnDGNYpMEsssVSuTxqZ+RwyCkBwrlSX91JtShA6/8A=;
 b=qV4L7qB8uR6cFarASCXIlUQ6IJfxNb0zM4CtVzP0QqOf62l4vhyDDsQOBjVDME07OZ
 xOMaOg8CJkHKLlKxHeLBz+KOhkIklDLYdumID9Z4UoFPUkgv2FUPBFhWrc0AdKUjbjbx
 RMNDNPlmpZ8QaQAc5oL0V7X6mt4z5OljmIsm8vrgbKc50aPT6slBvJGZfvOV1zNCPDRS
 mLMOtsgnjQnlCbmDdqt+UBveP7P/9X9JD6CRwQpurbHus3hSDn5t2uqQjqtujxH3DWUP
 wIenl3uByGLWvteBLbnrTEVxFIi9murcvyxHoSvqc4U95l76c0kIdgowOKwEhNY3cahR
 lIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724370524; x=1724975324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWnDGNYpMEsssVSuTxqZ+RwyCkBwrlSX91JtShA6/8A=;
 b=swoNx2B5hvn8Gom/nw4r0FFO6y0Y96XFy+xnzKPll8we4XVfiCOGUd3u3P1WngUNkO
 +Y0hXBRZXGxi12Hqcm9KMAa+/N6dTZg+e+JH904kr439kRy7Dc20SIMwq/j9VhMuXpgm
 /SozcREcaT1ZGbTpAwY8vSPc+jCkSiKRpwkHpgAKd3tKAfB/GZraxUyO86d7k+mvVb3y
 XZ8K6pHLrqHzKe96oeGOiS17gyGu/lERUDYiYPCT5vsoMLao3q3QyoK57ffes6dJfoIs
 ovsH9oHaWFAG95NtrWOfcYDpKypDtXBIpX8dyIHqLziuLUCXKF313+mk+YdNI5ARKsnF
 042g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW34W88Oc4SgYUNPFoiJKEbxjmkrM0s4NfO0tGxRnfunC/ShnFZ71oZ2T0Es2QYqtUfW8PIRcqNjg+@nongnu.org
X-Gm-Message-State: AOJu0YxyRA4HQjvoM6kKKTzVRV0dzA4DfYDVTwGJrBv8DWpKfrQuu9hj
 AcWMwjqUtyuz5TIUnIRTX7k3RsYxSAfo40LHSQN7GG/m0eXXKkrJOw7nus62AfbMkA8nfK4z+s6
 pX+M=
X-Google-Smtp-Source: AGHT+IGvZniMnh+Y0KZwzrQINh6AnIgG82FKWxQCp/HG+kQfmoy1WJWnmzAAQvfu5zSIYswPwx7/SQ==
X-Received: by 2002:a17:902:ec87:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-2039e51f10emr4918435ad.56.1724370524394; 
 Thu, 22 Aug 2024 16:48:44 -0700 (PDT)
Received: from [172.16.0.208] (180-150-104-113.b49668.bne.static.aussiebb.net.
 [180.150.104.113]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f081sm17887265ad.94.2024.08.22.16.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 16:48:43 -0700 (PDT)
Message-ID: <27961265-f145-4c1f-a706-1a200f197e6d@linaro.org>
Date: Fri, 23 Aug 2024 09:48:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240822095045.72643-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/22/24 19:50, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    accel/tcg: Make page_set_flags() documentation public
>    linux-user/flatload: Take mmap_lock in load_flt_binary()
>    tests/avocado: Allow running user-mode tests
>    tests/avocado: Run STM32 bFLT busybox binary in current directory

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

