Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90104C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvhQ-0000W5-V4; Wed, 05 Jun 2024 14:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEvhP-0000VS-5U
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:49:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEvhN-0001ST-97
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:49:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f6262c0a22so9228545ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717613363; x=1718218163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxtBUe7PmoHepiAiytkOQTQWasXuJtZq8CmrQN8GtbU=;
 b=sYiRdZzbH2XfLngTa0jd4vRWV2qVX3TEud/VS9yNf5uG3mWWjVvHMIFtCyC/10ZN5a
 q8jHKe4+/+PxqIhJTBmEt9XovzDw+2z/QBf8pqG8Liv3JEVtc4Sgt8NIShHbidtPl/WQ
 78dvJMfpsg0eqnFutyrfDaSacjohJj9WElkAUZ9b7cIHrcDHt9fy0beqOAlgPPwEs9El
 1VBQ/honpBOT+TXVGe3SVLIcP93SKnG+czdfIW1OcD7dmgctHHFCQZgg/hvLALx6vmpR
 cAtJ1Yli1noNh/H5qKciGdN0YhEachQvs2UuKwFBXzsVws1H7PTUZprA34z2foJm9wN8
 Rh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613363; x=1718218163;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qxtBUe7PmoHepiAiytkOQTQWasXuJtZq8CmrQN8GtbU=;
 b=AOuYpLQn+WWmdeZo5mXWJbIB1qf2Yi538BFK9bHxPUsBSqdZWMnf6Bni7CvoVGFzk4
 9dL+G4sD+YFzVjf3JspvCDqluxgE1Ai5M+ZpABF0QYTX3JFrZYhJgxBlJS8dEwnaPQzr
 RwjV4DDaHIn9iWe2pt0skk4tRGok2ZiG8qszKiy2dc3zS1U/QcIJtVC4BXg6WFU3w0k8
 I42ZP2QgXJMVsBXdt5Y080nDR6iie0LUVbVewKXQEz6DiD6Ip5LF25poh6oVAWvAZjql
 ltLSv1BXgqNW+h4xT18EVlqRYyMwRFAUSJBGrQvpYn9Mk02gfjcNN829oBZ5HnAbu366
 nZAQ==
X-Gm-Message-State: AOJu0Yx62z4XptWjYA13zOitERVbLOys1gcqjTDsdrQN36AcF0yjOW4v
 kGRDRJebBDm1UBt9IIx/X/S4MZNA6A+HcE3Cbgnd1nXAYWKqeAEXgN+5nc/hCQ1v48ghgdFGTKa
 v
X-Google-Smtp-Source: AGHT+IHSH/KH6fT4CCvOgbltJPQvwVbAa8XFMnhn3medMzVdtRWqeh7dBsr/mqu/OID58eYSS5Hdxw==
X-Received: by 2002:a17:90a:dd45:b0:2c1:9ea1:630c with SMTP id
 98e67ed59e1d1-2c299973d53mr651422a91.1.1717613363437; 
 Wed, 05 Jun 2024 11:49:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28067b0e7sm1983848a91.15.2024.06.05.11.49.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 11:49:23 -0700 (PDT)
Message-ID: <d3497349-de58-4ee7-a0f5-d1bfd46c6e65@linaro.org>
Date: Wed, 5 Jun 2024 11:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/38] sparc + linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240605172253.356302-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/5/24 12:22, Richard Henderson wrote:
> The following changes since commit d16cab541ab9217977e2a39abf3d79f914146741:
> 
>    Merge tag 'hw-misc-accel-20240604' ofhttps://github.com/philmd/qemu  into staging (2024-06-04 14:53:05 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-sp-20240605
> 
> for you to fetch changes up to b12b72274320ce3ee516d963efd48766163cb240:
> 
>    target/sparc: Enable VIS4 feature bit (2024-06-05 09:11:17 -0700)
> 
> ----------------------------------------------------------------
> target/sparc: Implement FMAF, IMA, VIS3 and VIS4 extensions
> linux-user: Add ioctl for BLKBSZSET

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


