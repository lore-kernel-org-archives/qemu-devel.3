Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C10FD35669
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkwKU-0006pF-Lb; Tue, 27 Jan 2026 22:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKT-0006np-Nq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:34:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKR-0004UR-Vs
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:34:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a7786d7895so42744535ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 19:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769571290; x=1770176090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nk95NSmFMoXIw2qnNtgBUK/Zvze2iPVz07fenpQRGik=;
 b=eviq/sy0Y236c92C9r8gD4D8e4eQW+d8YB9BcJmo5MZ1frGxjuFboNqRC+nwzgRNce
 mofjX+GXxqquZHtlM/qt2WAQ+/sKm4OoKbaNk/h8JIGrRWcc2vheJLyfLHm6432XQ9lM
 79S2ztT+e6fTFtLjnZ0jwKXWihww9/aqy1pkDsWQ9T6jov3oHu2YslDLgSTFvUbm396q
 f6VyLK3m2hIcaAoCgPMHaxK2tXgciEhZUm1qbhUgzrkOwjGi6q11m7iZz2Gw2gqf1/VR
 T9I0hSgHeLPK7pLxnms/lNpS5KGJkbSn5vDypV0VVOUekApO4w5L2Npz3qJz9ef/aGKF
 Rj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769571290; x=1770176090;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nk95NSmFMoXIw2qnNtgBUK/Zvze2iPVz07fenpQRGik=;
 b=DnADQ360Ro74icrjh8jkbYULI90uT40vTZ2NLY8XNvHIDqz+2DOglBIRiiuysnTGHf
 ZpzBUcoHW7fQOG+i0pH+t7Isshbkeyjdwt+GAaEWHe54TmBYHDdchEzq/k+tfvXGjokg
 odODOWMaa1Cs20xDXpv47TKIGiV68uvrOB9bsD/U8ShbUlidsxTfVhX4c4zGavzd2UHw
 LvD+FwS5YaTvZNkkdpOPyycex3eOuotA1GX1dLZwlo3SZxewx1i6sIwUTrNVUK3pw83v
 GZJIDa4RfcMmLPmXVTOHXzGhxF3P5ZYpiVh92FnpVbF51NwGp/53DD0ATc/PFEir+f40
 7Qqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwPKVGLz+YgT6i0pZfkiecGM+17rVRZXsNBKxO/PgeVhLoATGZJFxDym8oE+7OCBazP7TVa4YB1PI2@nongnu.org
X-Gm-Message-State: AOJu0YzkOR0yhRPCfrH5KZyjR+vx/0zEEMC4s7/78HzKOorszUBc9AbN
 UNd05yhp+b3kFv98HfPsgUHv9ALDp2kFlQnFxJOqrz9cbSUUfhjD+KjaOnFQOrzxr9g=
X-Gm-Gg: AZuq6aJLRuOmkQRB+ceiSX9R2oiaJnofmgq+WRzkovzTYlGNcLj5oqq5L4Z0KUO8i6H
 KcfmxESwEFpNY3pT8Uo70HbVl8/yKbJ1PauaD8z6VUVTiFw4/ax3qhrvwdiqzHMsWJ2Ts3nxGtT
 rNEwdVlJEIkNyHMm1fvjXRvO4GaW7Tkmjk5pG7w9cahVrg3vQJLlWsbBgpNFj/3PYi46+Lj+OOl
 doCzODM1x3/+wqh1ESjwFq/pMh85nwJU3tBo0DlFqWbNRbmayTOdQMItelqMdRbxuWKt+qQr6vd
 YE4zzwjfRif3VNXlYkMHsrA8iqPoecUjqbMrQijg2rDFob7cEuDPE0jhM/Ijoudaienf8HS0j2u
 PGtFixc1wcUDXUVfMvUKBvSJc1iuQCXCiekhxARyWoOhOpoBD202187b7FhIjmop/0YL49Dfs1U
 OXFS4L2EmyFwBtYMvskrg7jkE4nBKhng==
X-Received: by 2002:a17:903:2ece:b0:29f:1738:348e with SMTP id
 d9443c01a7336-2a870d65001mr39496945ad.15.1769571289482; 
 Tue, 27 Jan 2026 19:34:49 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b6f4d04sm7375635ad.94.2026.01.27.19.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 19:34:49 -0800 (PST)
Message-ID: <cb65dfda-305e-4c2b-99be-a85c9acdf6c1@linaro.org>
Date: Wed, 28 Jan 2026 14:34:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Rust, i386 changes for 2026-01-27
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260127093906.353741-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/27/26 20:38, Paolo Bonzini wrote:
> The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:
> 
>    Merge tag 'pull-vfio-20260126' ofhttps://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to df8dfc3b6080713c2dbd7ef37c2c85a78e502cd6:
> 
>    rust/hpet: remove stale TODO comment (2026-01-27 10:37:11 +0100)
> 
> ----------------------------------------------------------------
> * rust: move binding generation to bindings/
> * rust: fixes for Windows
> * target/i386/tcg: fix a few instructions that do not support VEX.L=1
> * target/i386/tcg: various cleanups

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

