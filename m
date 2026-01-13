Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63CACF45DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 00:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfScW-0004od-9D; Mon, 12 Jan 2026 19:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfScU-0004oI-EG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:50 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfScS-0007Lp-Nb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 19:50:50 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b553412a19bso3144544a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768265447; x=1768870247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbI7OClXsXIsCPzkLAoUog3yn8PYnnwmzWf59BdHe2o=;
 b=CSNjiG2+QMYwA9dk0oFC8jsKNY657r6vyrTqFiEeaOthIa1TgHolWjOQBz2n2+IrrN
 y4ZmYieWuTi4MbDbtqIpbywkIard1Jr9342BVluk7tWltPS/WIBs58W8CnfXaUlCgmEH
 q3ZZlxTvq7eorcCeHsWoS8CZlYL0eFrz4azGzLrZAoT/fWnubMCDHG6nUN9/fDLlvOBG
 KNxW34Bwf+OfC/HBTe71qmPaeUsZQxvCR5CYEgLLHTg3phRDul9YobQXyxSlXrgYSdyi
 AC3oT8r+Eqz7w8DeeJF0kZ30QbLOJ1IQ8ZiSzvmgfO9PHFem/EQVdCoKD6o5lHTgWy1D
 jQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265447; x=1768870247;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbI7OClXsXIsCPzkLAoUog3yn8PYnnwmzWf59BdHe2o=;
 b=ItVrkAI7IcGcrkftJJvJxhfA1tLAsoFibJSdc+45Z29m4YTMENLcqxKXubVoD+IvvG
 iptvaVkcdpHylDSmb4l+RKHoWASsFzvBzQA284PoyAsNF97IHfFea7lSXMAuxN9uzAxO
 QtaqOpZK18qwlVGvL6G6+t7g2rk6iT1iW2daUbaveNnd5fzHZEZO+r7xl21Dq2EGWL96
 dqFWuvBFsMI07guEVcoMseujwui2ujmlQ2wJXjsZHYnxKEL/QK3CBjNyTFdRnGbr/QNe
 NTH8ixAPovhfYfP5J+PMysAGMFsake6Kleqywz8A+WHCh11xSBaw9SiuHHWaJq+oQt6Q
 HEIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEl0s7yzSNinCPfu1DCbEJiRH+ZCLCkmFaN5E1Q4a8IN/nFfar4zEa3UDZjJJDrGkImWNTqr9D99S+@nongnu.org
X-Gm-Message-State: AOJu0YylTcN4ntgm/2OtZjrHtXPDw27k+k8rDrYrSFCx/l8FVdsPDnKi
 hlfBce/L2FETUvC0e00fKKxIHW1fGDsf+P0fIpCtxd5967Z/QbUa+KaA4rS0+sZzOYg=
X-Gm-Gg: AY/fxX78VIKmEQUWyUQ7YG+vvi1hPBL6eHwF+vuEmAhSzR860O/nCjjacSzbtElDzbR
 OUvmW9RXeyoGfrNxCEd9pcOVa7nDcKDIxiijelCJWBw6xc9scS4U6UEiCw+iRc2ESFRm6IC9V9L
 KYbWpWrkEgCzWDD4lCQ7s8pDkqDwm03/6SZYSyWUL6BnkZ52kh5Wx25AAkD0LD9rzjUE5sD0fJJ
 j4HmBfyu95RFlHOsTI+y+B1RPiCe5+K39wTo+Y6opZiLDtlQ6zj1LZ2Lmz22dfG3LNF7lKvUGt1
 8NsaNochUFcwr6k+NrTdnMPxiM+RBzcoB2AnP0mEzszt36lUXIr9n8YXN6b5JsmymS9gZURdTO7
 zZlRVfbn/yJq12W2eC018U4cMUPmOS5ImRRJX6EdjlnbgcVI+GdZnj211z2oJrrjFPU/v9VqOJD
 DDzqQC44pue9PNr8FHD5XBL9hoG34=
X-Google-Smtp-Source: AGHT+IG9461SzAjuLSHcKpux6Md4736ihX7tcIasgyJZKeOH5FR3aORGZfevyWa3HQ1ECqujoFUX8Q==
X-Received: by 2002:a05:6300:210b:b0:366:14af:9bc0 with SMTP id
 adf61e73a8af0-3898fa13db1mr19235101637.74.1768265447117; 
 Mon, 12 Jan 2026 16:50:47 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm19380724a12.16.2026.01.12.16.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 16:50:46 -0800 (PST)
Message-ID: <6ae6a5a4-abe6-46d1-b4ce-e4cc81a156ef@linaro.org>
Date: Tue, 13 Jan 2026 11:50:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: use default prefix for Windows compilation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, qemu-stable@nongnu.org
References: <20260112160736.1028280-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112160736.1028280-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/13/26 03:07, Paolo Bonzini wrote:
> The update to Python 3.13 causes meson configuration to fail, see e.g.:
> 
>     https://gitlab.com/qemu-project/qemu/-/jobs/12672816538#L397
> 
>     meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path
> 
> This is https://github.com/mesonbuild/meson/issues/14303.  Remove the
> prefix='/qemu' line in configs/meson/windows.txt, since commit d17f305a264
> ("configure: use a platform-neutral prefix", 2020-09-30) says that the
> NSIS installer doesn't care.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/meson/windows.txt | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/meson/windows.txt b/configs/meson/windows.txt
> index 55b192e71b1..9ef0fb3c8f3 100644
> --- a/configs/meson/windows.txt
> +++ b/configs/meson/windows.txt
> @@ -3,7 +3,6 @@
>   
>   [built-in options]
>   bindir = ''
> -prefix = '/qemu'
>   
>   [project options]
>   qemu_suffix = ''

Thanks.  Applied directly to master as a build fix.


r~

