Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE19DD6406B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SSp-0005GV-4G; Fri, 08 Nov 2024 12:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9SSn-0005GN-KR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:08:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9SSl-0002Un-Jx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:08:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so1790724f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731085677; x=1731690477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/9gxUZzOb1MDGtv0PKtRpTtaKyI7tuJTWG+o38mKvA=;
 b=ASZereomRSgTT8NUcZb48RygsIfaBcS34rYuuqeG/kz6fLHRGJ6gYYXeNUvlCOzwQX
 RdV1qICLd+SRJXzPe4L+Kq+TTizTX4nEyXsxc1g2lSUQROUvopFI8R7ye36wZxmGraI5
 Pnpr8CffCAF7+lfM307V2qrIqN0E4d612LHXfScNlXlMY7v77pE13L47wHbpSCeAN+Fj
 p1ODgrr3ZkKyEF2mTna/GS+Shuv3FW0luML61UD7SHtDFdjSY+DN4F3ycEXKH2t2egVO
 4hVNmmIn+BGTAYM/NHtVz5OOhxVSvMcXbQQgigJWZ9/c86kueXdMZ3Z+fxzW8dlVYIp7
 sE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731085677; x=1731690477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/9gxUZzOb1MDGtv0PKtRpTtaKyI7tuJTWG+o38mKvA=;
 b=mNTn5EI8mw5kc/pWEFztzqBOzXtCSOMbopX6oqfQ+7+dH5YET/yyQmeUXeo+i9wWuo
 Bi2kPqB9ti7MSo5RBFUSe4JaMGWb4eLLvYoMSgIU3GnvifqZordRpgd9fejUIYvv5JqB
 1iCktXOmRAYBGx9MK3ViTotG96Ls4iUUH+eRNV7PSR6Oybl/tYfNKUjiHgJBDIGLyVAr
 a180SVJ5tWxZ7zXIzy9c146V02akrOm6ZBDp/ycMDoMz8pLAR8GofDwAkxtYnRfGIPTO
 lJ/57GK8nNTahkfSgUS9y7l/eKwiN6ksNRBE2xD11XItJ7ZqST8HW4IKb82iImzFZwIs
 XIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr3WIEX9oU/Uf+KAuaTD7Qc1RB+Njt6dKxHYw/JgzdI1yHenXhKblUxcdlhffs8zQW+7af0C3fPARC@nongnu.org
X-Gm-Message-State: AOJu0YwBgVUh/LidwBgspiS88eUi+knqrJKUbdJsA4jocz7ZeiVes8DL
 E3tExSE5q7KWKqPva87+neHHMgSR4HBuaOSE6tDz8mqTxUAMENHhkLmjcCHemMo=
X-Google-Smtp-Source: AGHT+IEbSHE/HKXSvFo/uH/lXRYDE+49hm8rXHRJXg2v8N364C8mGxL/RRMP25cVejRtIZEnG3bxaw==
X-Received: by 2002:a5d:64e5:0:b0:37d:481e:fca with SMTP id
 ffacd0b85a97d-381f186fa0bmr3680311f8f.27.1731085677362; 
 Fri, 08 Nov 2024 09:07:57 -0800 (PST)
Received: from [172.20.143.32] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed999e0csm5406545f8f.59.2024.11.08.09.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 09:07:56 -0800 (PST)
Message-ID: <8e1f724c-17f7-4f9b-8e84-6a076149fce9@linaro.org>
Date: Fri, 8 Nov 2024 17:07:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm/hvf: Add trace.h header
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
 <20241108162909.4080314-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108162909.4080314-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 8/11/24 16:29, Peter Maydell wrote:
> The documentation for trace events says that every subdirectory which
> has trace events should have a trace.h header, whose only content is
> an include of the trace/trace-<subdir>.h file.
> 
> When we added the trace events in target/arm/hvf/ we forgot to create
> this file and instead hvf.c directly includes
> trace/trace-target_arm_hvf.h.
> 
> Create the standard trace.h file to bring this into line with the
> convention.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/hvf/trace.h | 1 +
>   target/arm/hvf/hvf.c   | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>   create mode 100644 target/arm/hvf/trace.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


