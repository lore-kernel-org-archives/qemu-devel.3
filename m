Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C97E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUujX-0003lh-NG; Mon, 06 Jan 2025 16:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUujV-0003l8-U2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:33:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUujU-0004Ej-GJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:33:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso155475295e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199235; x=1736804035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RBUh6hKLKjU+LTeeIxdtJGV4vxMYUIp5ADtNPgfjbgU=;
 b=TEWiG6oCmHdCrpfcERFeotZOX8vUVa2a1DtaRjcEuyof7s0canHh8Iw8JZF5I93x7Z
 Y13czF+4qFRMR2xKcXn1Ao/87352B1bKZv5v0/QnyFihh2VmkNMKssjm9JCtN7SzWg+O
 l6vdDO/7/HVul0ZTsxJVKLgAtGtLF97jvY0V9XBfsVdVJLfe+iPXWMED56z+YKEUmvQE
 YuOvaDy4/TItsMvpl2OKMdV92VP9zrDEs4skT0u/TW2wy3Vu2ASz7Cg1Q8Ste+lIdCkh
 eGnB/QBfhkpXWGHsi8uYQGIFd4a1Z7eGhGXNcLRmJnTBPTkyRf+WpeS0Tw+dIb1WfxCo
 5r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199235; x=1736804035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBUh6hKLKjU+LTeeIxdtJGV4vxMYUIp5ADtNPgfjbgU=;
 b=eM7kl7JIrlitrt46XTWc9tknbxWSHl6ZIdc8pyyKwZnUGNfYapsAGqNLAam0sY3T1N
 8qi0FgjZFid7sfHvPAaPgW7w5j3o8cynGCPHvIWUOPVKZCzwyv4dpADuMuIbQGsBndxJ
 /N1nE5AoXhdDzjSpCxX0j664ZsgxzK8X0cWdhWoDyQgXA8X8raxi1amaVIyR9wcZVcrK
 8dIs+BlaiZ7HEzQGgW32XZvl0BM9ok5arSQgpnM5cqLA2IC34rT1SMoaRMDXwKq1vdHy
 z1HhedhcvsIn80D6LXtdjjkfDrbXDoTaYWmvzcWCJEsJ34nrqVAe65Z0ns8kqYpXNGtD
 nwmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xTmV8WShIAzFgmogHqSqpvGprceRBXITiDWJEI1Da+IehtA3DmC2qgjwoEBEFSqIEfe4JUkB1jgs@nongnu.org
X-Gm-Message-State: AOJu0Ywv9bKDQHj39GcrEXb9ehiIWao8AqGjWMNlnsseBa+mNER7kIxd
 AxQ0g/BzQibfpXYuD8a9v1xCM1nq/PXDnqOIDL2/gIa47nv1uTf33URKsJ/9Nd0=
X-Gm-Gg: ASbGncttWYRX5DbafHijEuLtCaFBk67j0xL48va1H/XZOpvooikBk/ziLM6RU6KmL6k
 n3d56SIg1AQAfAEcZsz9IV2vmyoPws/21hKhSGqYWPaAg73uRq77qY1W0EZ0Sp0+iMhPCxWQ3QA
 8/R7Irg8hp03TbJzXNfpOJ89YipWYdPlJM1oN8xG//1jz9QIYQVjbNBpgd1fc2HhrPNHCKBPSNa
 Zmamsym46kr609pBJldN1HKRaRInd0LSQdmlPuhrFyE0Pa9HYIgPvnCaGpZWkBMAy/TRXMKR45G
 D06fuaczaAkrevW7kewK1Lgm
X-Google-Smtp-Source: AGHT+IH0NEd2sbFKUcsX1VhwjA2O/7YFiTEN012oVBHrBX9JpE5fo4f+Fqwi4fEDTmAd0eSAtowcqw==
X-Received: by 2002:a05:600c:4194:b0:436:713b:cb31 with SMTP id
 5b1f17b1804b1-436713bcbcbmr514002785e9.3.1736199234861; 
 Mon, 06 Jan 2025 13:33:54 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm611995115e9.20.2025.01.06.13.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:33:54 -0800 (PST)
Message-ID: <e5c4b014-738f-4583-bddd-4e5366dee19a@linaro.org>
Date: Mon, 6 Jan 2025 22:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/73] tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> In addition, add empty files for mips, sparc64 and tci.
> Make the include unconditional within tcg-opc.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h                                      | 4 +---
>   tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc}     | 0
>   tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
>   tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc}        | 0
>   tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} | 0
>   tcg/mips/tcg-target-opc.h.inc                              | 1 +
>   tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
>   tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
>   tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
>   tcg/sparc64/tcg-target-opc.h.inc                           | 1 +
>   tcg/tci/tcg-target-opc.h.inc                               | 1 +
>   11 files changed, 4 insertions(+), 3 deletions(-)
>   rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   create mode 100644 tcg/mips/tcg-target-opc.h.inc
>   rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
>   create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
>   create mode 100644 tcg/tci/tcg-target-opc.h.inc

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


