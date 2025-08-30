Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51822CA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNph-0007Rh-Fo; Sat, 30 Aug 2025 11:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usAfh-0004eU-Mb
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 21:46:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usAff-00005P-Td
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 21:46:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2489c65330aso25436825ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756518382; x=1757123182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeiGZCtGUwJzdJxJXvxrl47dx7UlphJuiz1m2IhwOtc=;
 b=LXFyUOIrySR7mxrS1mH1Qj3KqSozvAQTHBmbQquO+M/gPw/TZ+4ODIMs95pMR/Q1IV
 OE2DAp1+cOQJNHqMt2RF6VrfBTDL/gQnIo3BMXPn8zQNmb4vUflim2DTxtwhvzrZQaPf
 kHe0fDwZ8uUYWFq7QyiXY6qz0YHWGnunZzGKGgmAUGetiD48I7XT6q927LFNVNuCY5ru
 C547ZApiuEWA5XZgQVuVxnsY35oY2ZzOiuQKN+9C3SE2Jbi1IzQZS4YCwUYNbi88UlAJ
 7MYplvys9yROzPjUH0VLSMok2EFMscip1pE5sUbb48JXCdk6ehZibu99dYAhPXc4HMSU
 VsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756518382; x=1757123182;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XeiGZCtGUwJzdJxJXvxrl47dx7UlphJuiz1m2IhwOtc=;
 b=X/miilGazNJDXDaunptWKAQWHQwqllIc6EoyFKQ5QI9uKdFMc7PBDNBItMYV7bVcOo
 FkTKmXrpvlUF4yiq+LNXQpuyYF1KWcPHabwSm9Dm+UjrF7oH6Kbs3EjcfcUJWQe969Bm
 fSeOwLjCEKozf7aIi37rbljxQ6DNvMd6r2H+vyrDtmTqrfEWgc9I2yy3KYHhC0uSnr/4
 yVwG35wcKMP7AKT86eWOzjG10X5hHvwtZDtdO7FkPTtErzOhfpXzyqn4hnacdUPg52Gk
 gS2oLmhJ+xI8oHQl18AROacyE18DZaYAMYYe0cB+kFGsxh0SEGtOOrlMY3RpQ5sj3Xtr
 3gKQ==
X-Gm-Message-State: AOJu0YxkWcR57NHKgQN/ahda0ec8JJgLTpId5L8uHBEsEPITwJadOu9j
 Zux4H7xr28+Bs08DMkgqD/m3hy0zQ7bScPklMjlaChlsoT/yPfa8pJAHsRv/T9j4bRnX1x0lHkj
 81MJcLvI=
X-Gm-Gg: ASbGncsNWozLuha/1hhyXMwcZGAXHIcOE2tgggPwlgK1CUwlzpFuJ6b6mYkYfK0LBc2
 6ftCsLVsJ1jMGbpPB7E/+kQByescOOqzDgk0gIolDkyQ4iHMWPPFfBJw+Q9AETuWztkz6Nr6w7H
 9WA0+vD4x7c/WxiTo1g32NSd98DgRvAB49b+VDbR4vPcHFPwl4TCt4l4PbIZLbgq9A1kGpRlELU
 IOPfsvGAliSfNK7aJkuCM1jM8PfjV+nE4s99yGTuAkzuRjRHJLYup9ZwokBl3D7cwIYN74MAAQt
 vxGfIFy1FbEJn5rKP4qkPG7s4mb25Rn6w2C0dJLoh5+dl3h3Pi0nTRdey8DdnTCD1cFZZvedCl0
 SUu0qW60pYBUpelqNg8W0L1BSzjt0SBSwx6/k8dEWkwj8GniUZQeoE64TEv22E5VyZ68LW8LPEZ
 soCMgg
X-Google-Smtp-Source: AGHT+IH+NToBrjvhaG3MatqQRnyJ+wzPTBZiP1uTlawwnK3evm2pZ8VhvK787XKEN3Psn2gY2qw7ow==
X-Received: by 2002:a17:903:1a2e:b0:249:1145:ee0b with SMTP id
 d9443c01a7336-24944a70111mr8339165ad.23.1756518381700; 
 Fri, 29 Aug 2025 18:46:21 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-12.dyn.ip.vocus.au.
 [122.150.204.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490f755ebdsm32619615ad.26.2025.08.29.18.46.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 18:46:21 -0700 (PDT)
Message-ID: <505de9c2-d6a6-40fb-83b5-aa7258b6c1be@linaro.org>
Date: Sat, 30 Aug 2025 11:46:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/91] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250829222427.289668-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/30/25 08:22, Richard Henderson wrote:
> The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:
> 
>    Merge tag 'pull-lu-20250828' ofhttps://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20250830
> 
> for you to fetch changes up to 3f1b9dbdf5452a2baab00d46bd149f6f8192fe44:
> 
>    linux-user: Remove target_pt_regs from target_syscall.h (2025-08-30 07:04:04 +1000)
> 
> ----------------------------------------------------------------
> linux-user: Finish elfload.c split
> linux-user: Drop deprecated -p option
> linux-user: Tidy print_socket_protocol
> hw/core: Dump cpu_reset in the reset.exit phase
> hw/core: Use qemu_log_trylock/unlock in cpu_common_reset_exit


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

