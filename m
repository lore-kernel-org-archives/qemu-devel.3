Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0290C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 10:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seXxe-0003uG-9s; Thu, 15 Aug 2024 06:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seXxZ-0003tF-Rj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 06:44:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seXxX-0000A2-54
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 06:44:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201d6ac1426so6438005ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723718637; x=1724323437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0fye0TWadGzW0fRM/i5OA6YtbzZZKnhJQrwDMV2we4=;
 b=TehJ4GjWk5e9n28zvg08bZFS5Q3aEsdqt1D/R9e/ouSHuOjyG5EjZA3FUlE/R8DGej
 OP/CCiB54fbZ1Z3nU0MkOwYzqyWFTb1Op1pvr+4HVMq/ciBRe9M0hKXuu24ef2ALwPiE
 HM9yE7lRuGz0lcovSISBVkOQPxxKG6+yfRrdBCtRqVIq6lnngvOxC3eJC2+BXh4gikpS
 9rMc0NS3D+8Z4VtjcTZXwkuRZ/ILMeGIVNM1xvmTkuFpXJyPI+pGat68EaovXW0izEl+
 cfrT9SzY8F/aTbhbfgn+rifzU04303Ste2PAwIg0Gi1Ldp4HeIiR6Qr2AXQ1cEaISy9u
 Eqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723718637; x=1724323437;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0fye0TWadGzW0fRM/i5OA6YtbzZZKnhJQrwDMV2we4=;
 b=c2qgv8uIZnto7IkYpNgV+efsi2/EnvGXUC7zKfJ5MtNvISOU0KuYIuWK1QXoZpy74/
 EWo4JObtbXF1LePsDrjxiO22DVg9OEyQ05rnM2A3WzzuvW1aEGDeNqccBq2nqyFt7IDe
 m9JsxI7LFLeUcJ/aBenHvGroiWURloyihnqsMG8BdsSBQgUCLg/jiLCkhQcypad4yUZ4
 uaoW9ly/edDNb4cPUwwN0iglLOzH95j7IdIGYMLe9kmPZGsAgORIoAhgplFG49ZOodnG
 Iea/JeRJDx/e7eZlR5PpvTNUXFlrmXDuWpamtlNvhXlsaxbrnOvUH/xUuPKMCHrzMORR
 QCfg==
X-Gm-Message-State: AOJu0Yy3LpyJb+rljmJCKURlpSdxSFPJFT/LDnv+ZA8p4BfCqXm0kJv+
 DVLZ5GPm2dN2Cs8WTWYq84mRMIzDJhn2J/bZrgY0AsH+PqSYqdoL45NhGwABLezVu5c1M7bDiwN
 ToNw=
X-Google-Smtp-Source: AGHT+IEUCrarY4msRg5CC1x5vGnAQpBHeeB+R9T6FHeWIp9a+6491qT4XYSZpeaJPyY00ll3kSXp7A==
X-Received: by 2002:a17:903:40c5:b0:1fb:bd7:f232 with SMTP id
 d9443c01a7336-201d63b92e2mr62095955ad.23.1723718636993; 
 Thu, 15 Aug 2024 03:43:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038df95sm8168845ad.227.2024.08.15.03.43.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 03:43:56 -0700 (PDT)
Message-ID: <c5ed2097-6735-4cc1-9da5-c2393fe82d8b@linaro.org>
Date: Thu, 15 Aug 2024 20:43:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PUSH 0/1] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240815010556.535100-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240815010556.535100-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/15/24 11:05, Richard Henderson wrote:
> The following changes since commit c4d062885529a84928ddd260dab419b7d8dd4f90:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-15 07:41:16 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20240815
> 
> for you to fetch changes up to 3aefee3ec01e607529a9918e2978f365c5c3b5e9:
> 
>    linux-user: Preserve NULL hit in target_mmap subroutines (2024-08-15 11:03:47 +1000)
> 
> ----------------------------------------------------------------
> linux-user: Preserve NULL hit in target_mmap subroutines
> 
> ----------------------------------------------------------------
> Richard Henderson (1):
>        linux-user: Preserve NULL hit in target_mmap subroutines
> 
>   linux-user/mmap.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)

Comedy of errors, missing r-b, typo in subject.
But still pushed to master before I double-checked the list.

Ho hum.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


