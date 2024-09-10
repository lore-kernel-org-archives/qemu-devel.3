Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529EEDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7hU-0002Mq-V2; Tue, 10 Sep 2024 16:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7hL-00025E-0v
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:42:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so7hJ-0006gF-CH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:42:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718d704704aso1125355b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726000968; x=1726605768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGKJUEmROt57+miZawKKaD/PTYuXCK36n4D48kD011c=;
 b=Qmwk9tU75R4tYmXexLFPkRM2+xJOHoGBYzoMm6KGTsUbFa0AfXhE2fp1Uc0mn0UwYr
 fR23SP56Xs8aKUNgWvuGp2+vlKkD2TvIIrxOkgacNXgt+6+r4nWZxlDofrCeE2ImCsN7
 BXcGZPjZ4UeBZH9n3unNo5ct7JlWt+INGtpcynqS40sbW1qnVXx2AdgCK1DKIbVfCGKP
 tDiNB/aXtK/hehuB0fb0/dCtNBxSPGk5aWvT23JtixSY8hxA1B2GHdMRdQe4VVrS/D07
 qBJAR5xUXNWsotrJN2hvDCq9RuGhX4EjyCC7+ip7uAruaO+RWJLZt9Iqy34gbd7oCn6E
 bVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726000968; x=1726605768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGKJUEmROt57+miZawKKaD/PTYuXCK36n4D48kD011c=;
 b=sB2iSr0DEQKG1RDX9lSJzAabVdeCapLMr+OaGpzkyz8BNv7Cb+FU+2thHw6bQ3ujYx
 nj7ljMyb/HM3BaELqIsW8A2/vlSUPakoqUxiGcMgsMsvqfhud1+H514zZ20HTS8yKO7V
 ZdrbLz02i3/4BiaOcoMQ7zBu0WBrkioHJuI0f4pr48HJIZgKOPMCm6z3MYOFWMSqfZRn
 5y3YAKiNcbp1EwuqEXIK6YtskjnUJtrcKYu892/V2n2Y1Qj1AWxYH4hOGaBUnxUuJC01
 mxN03nTjIVSraYqRLvvL/H5sE17P6qD+mEvVFvX19hl1Om0PFACl9W5VfHnCqytGP/Pp
 ZFLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqAwWSQ3kme9dEA0iFrLs0bKsZMKakT67AsdYiX19xOvlfjwskGP5hzJg+MkISzm6zktaCdjRkLZCC@nongnu.org
X-Gm-Message-State: AOJu0Yza6GOY7+N4jrhvg5ZRnvS48lr76IAsSfMxH17B98JiPd9OOMd4
 LqI3lINvhrTRwVMwNuaPbyj2mGfYyfXB3cZ7xTOWsiGAYpQwUNs645D98Fis26SmyEfGuISZOin
 q
X-Google-Smtp-Source: AGHT+IG0DuxKAvdXNG0+R9puFlNAvwjKi7GNc87J5K2yK+m2ANa2IeJaUa6UxkPqSup/Q74xlnrI2Q==
X-Received: by 2002:a05:6a00:3e08:b0:714:2533:1b82 with SMTP id
 d2e1a72fcca58-71916eda1bemr1074780b3a.23.1726000967943; 
 Tue, 10 Sep 2024 13:42:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7190909252esm1756561b3a.124.2024.09.10.13.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 13:42:47 -0700 (PDT)
Message-ID: <52291b6d-9001-4c4c-a393-d59dd3c0cb04@linaro.org>
Date: Tue, 10 Sep 2024 13:42:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] tests/docker: update debian i686 and mipsel
 images to bookworm
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
 <20240910173900.4154726-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910173900.4154726-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 9/10/24 10:38, Alex Bennée wrote:
> Whatever issues there were which stopped these being updates when the
> rest were have now been resolved. However mips64el continues to be
> broken so don't update it here.
> 
> Message-Id:<20240910140733.4007719-3-alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-i686-cross.docker   | 10 ++++------
>   tests/docker/dockerfiles/debian-mipsel-cross.docker | 10 ++++------
>   tests/lcitool/refresh                               |  4 ++--
>   3 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

