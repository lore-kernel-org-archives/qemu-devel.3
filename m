Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1960ED185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnk8-0000A4-4K; Thu, 08 Jan 2026 05:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnjt-0008GR-0M
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:59:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnjo-0007wG-Tm
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:59:36 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so22627365e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767869971; x=1768474771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uPkq2uCPddWLRCB7GHxXQIPqCZLxd0Z99+zsQFO7ivA=;
 b=xX//3Ha5SBIoDrdw+XmsCPW4UicnoOGEziQRjUVXreSlpHIbU926vCxJS+l1tETAen
 6XfdsNoUHZhCruve4/TkzUg5PdfAA9QonhRK/x6shHbGSjhO4DsDIf432yZSOkcXfoRv
 LKWpAl8RlO1p6nQ9wx0nvh8W9Re+5Dn/VotxWgdq9RvjJ7JxahJzRHnPRUR0X3SzTwDI
 AjF5S3BDuoPaU7w5rC+rWXIrybZJojuIQYVFwwQysAXbxqYaSgbkjrQW5mY5d4DZt6n/
 0GWEsHmiZa4YCyg96itwdBoWMYyXV3QSUrtcCCJp0iLWuIth7cfRQ8CQbpC/T7IFkalf
 xNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869971; x=1768474771;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPkq2uCPddWLRCB7GHxXQIPqCZLxd0Z99+zsQFO7ivA=;
 b=cxeHoyuqZ6jnkUZkoeBSUMQuZkaIZAplMxZpWP+ciigrePE93apbB0JsCtyVX+37Yj
 A2SaYKLntIxCXLR0jZQbk9btn+9I1NFzNcrxokdlfibT46jb4dgYcmMjLPgcBtrYCfWJ
 5XcNyywPuLUxIxrfQRkoVHKn09TsH61DqoNr0xwUkpiJ1IibtC+in5l85bkzVtuZza91
 cEAT5WWvT1bzAVtiBNXcEYh6beo88/EozNtCui7jt1hmxAy+cE7H6d2ucJ4URVWyb2Xr
 0SiH/zIXPdCxx/esgEUYXBhLv8JB2wMvFdvJWdiFDylNbtT7awmje+uRnbPei40V5Skz
 fLdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnqYM/atIbivIDdEAcV0WntNGyerEZt2nUs0mGSEElO76XjTdkDCfsBvBv44dsjFncLAyZNQGRwCN@nongnu.org
X-Gm-Message-State: AOJu0YxRX1IIv4T4lsXAJGamX9vNLIhkxcvXNxUzTqPmeP84U1vmPm7Z
 d0cJRVEKQPpyf8lRVa3BUIrBocQP/43tv+b3xFj+iQRfnTXC1dBa/HbdsQ3lTIMoUy8=
X-Gm-Gg: AY/fxX4nRwt1BJc4MoILll/wqf1z/bO0FOe5MkPMScd3PJp9YiHArjRBKcO4WlE3qxL
 ay270eh4nhF6e/0YLK0T7FaK/iNS8LY7ohQIoiw+yOa6UZK4xigZ8N6ELsxRy1YsNfmfjRJZiJh
 lZQ5qUURYv2ry94fAvt1zvwlEQe8X+Jj8UryIieUQNesA4eCadcSgG0VP29TpCobUN7g+AqEM8B
 L649pnzJ9WSlb5ixMyroKuL+/IjJI4Lf4+4iTVTP9vcldZohcTLGFRt/ozpCtDGC4M8r19/3edK
 3Q0WPj6RzqLbcc7sJ4WP+GSpPHXjIWk5vvmVcUqP1+EM8eocLQa7iVF1U9hh8GmGXwspaQr5IYc
 QKnRELV2C+iblgSiQTcoRXySiDBYhk1jVCGg9klTIM/Gu57HIE8pjPmCA6AGdXjPD0+yEJLzXt7
 kcKpCI7AuXmW3Sy7xa1p2I2pVztb/K6btgLKP0pHTBTmIKQHNbILgLAA==
X-Google-Smtp-Source: AGHT+IHQjvwUisRXtb7UJbiI0GG0a9/E5n+I2sjbofPrD+Wiw08uTG7CRW9sEnTmg2SQ+C9X63mQkg==
X-Received: by 2002:a05:600c:8b57:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-47d84b61399mr61345555e9.35.1767869970673; 
 Thu, 08 Jan 2026 02:59:30 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636c610sm34989985e9.0.2026.01.08.02.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:59:30 -0800 (PST)
Message-ID: <9b3f6725-a5d5-4348-a1f7-cf7448ad19d8@linaro.org>
Date: Thu, 8 Jan 2026 11:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/50] meson: Drop host_arch rename for mips64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> This requires renaming several directories:
> tcg/mips, linux-user/include/host/mips, and
> common-user/host/mips.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/include/host/{mips => mips64}/host-signal.h | 0
>   tcg/{mips => mips64}/tcg-target-con-set.h              | 0
>   tcg/{mips => mips64}/tcg-target-con-str.h              | 0
>   tcg/{mips => mips64}/tcg-target-has.h                  | 0
>   tcg/{mips => mips64}/tcg-target-mo.h                   | 0
>   tcg/{mips => mips64}/tcg-target-reg-bits.h             | 0
>   tcg/{mips => mips64}/tcg-target.h                      | 0
>   MAINTAINERS                                            | 2 +-
>   common-user/host/{mips => mips64}/safe-syscall.inc.S   | 0
>   configure                                              | 8 +++-----
>   meson.build                                            | 2 --
>   tcg/{mips => mips64}/tcg-target-opc.h.inc              | 0
>   tcg/{mips => mips64}/tcg-target.c.inc                  | 0
>   13 files changed, 4 insertions(+), 8 deletions(-)
>   rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-has.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{mips => mips64}/tcg-target.h (100%)
>   rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
>   rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{mips => mips64}/tcg-target.c.inc (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


