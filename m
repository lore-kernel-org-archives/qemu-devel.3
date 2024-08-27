Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B291CC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuex-0005uI-Pa; Tue, 27 Aug 2024 07:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siueu-0005te-QR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:46:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siueo-000359-F8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:46:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37198a6da58so3779545f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724759200; x=1725364000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FpP0CxxnB9Vb4qOSUo+F863TQgwaTjAW0Ma+Hnaaf4=;
 b=bZap+n/07Mp/iZMhWmFWl2mu4WwQ4twE/lccJouV26f+9aeShEae7Y+OhBylURrKTR
 fNJnqxOkJUoAhOzwwVn98rdo1pAQ5Q7BbiNjpWnCZSbZQdktv71cL/IgtfV6eobaNzaX
 c8l0J+qSnZGjdjvk8wXHWafx45LQ8X4gVMvjnrSz3OAl1WgchRt6OefKX56wbMj10wHG
 kbYaDhMJQnXwT/qLc2zEieIfkdVwna89KGYlMafvwEj4JRP9RzmQb/ItM0WhQI99EdgA
 XXYTjMThRti5Vo/F+I45o7nG9rcTdxePJmgXxbzqUbVEDCHshUOoDClcqT2FLy6OAmQ3
 EA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724759200; x=1725364000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FpP0CxxnB9Vb4qOSUo+F863TQgwaTjAW0Ma+Hnaaf4=;
 b=i5PU7MBYMFYjaS+5kYDbDV0C+/yUF9osw0kFoGSMb5eUQ/mqdRJihGFqGEQopRGYHz
 1AdtNz7x295RcIghTj5SniPnfL2V35Ri2QT99ghCppeJk+f/CdhGp6qFI3sHCgqKWUgP
 k+HZfPDozl7vi82ZTUp5VM9qpxqpLOF5w0Zz7bvkBmyrULJbPUOi7p0jAUoO9rDscyYL
 QOd90q9bavtfWF2ALK4Kew3HuyYWCRWSNucy9jEzSyagXbOJnGLHdN/yjeD3h1M8Lys3
 0i+vDBmjrVzRcj8d7MPsjMkPo73IS/3CGhJS5tnPuPNswvKpW4B+xpxZblei2uEd1SZp
 ovIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV61ZFloFsDbZUrM04VACABFmPy4b7JChRXLyt72iNaiFGt8HxbgRaRF+W7HrkI27qJPSIXPgXJ1ewR@nongnu.org
X-Gm-Message-State: AOJu0YyhC8vhjqWIjB5gLG2O4nwaDrjyGRmca4xnZtaERtbw5XlGB8GF
 TTFyxOfcguip5nqySvsaNKtU1dXb3hL+A4JSCIgAk/Is1PST918ADOqt6OXnpsY=
X-Google-Smtp-Source: AGHT+IHu050Eb+0Njwkw5uH8D5lMHj7y08eTIxnuXTsYaBQtunHinx9kGDv3BJUi942XpFA506RCnA==
X-Received: by 2002:a5d:674f:0:b0:368:5042:25f3 with SMTP id
 ffacd0b85a97d-37311863b04mr10248277f8f.34.1724759199920; 
 Tue, 27 Aug 2024 04:46:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefff552sm216864575e9.46.2024.08.27.04.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 04:46:39 -0700 (PDT)
Message-ID: <d075b9e9-b325-4df2-be2e-d8c6ed34cce6@linaro.org>
Date: Tue, 27 Aug 2024 13:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mark <zlib.h> with for-crc32 in a consistent manner
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 WANG Xuerui <git@xen0n.name>, Ard Biesheuvel <ardb@kernel.org>
References: <20240827100207.3502764-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240827100207.3502764-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

+Richard

On 27/8/24 12:02, Michael Tokarev wrote:
> in many cases, <zlib.h> is only included for crc32 function,
> and in some of them, there's a comment saying that, but in
> a different way.  In one place (hw/net/rtl8139.c), there was
> another #include added between the comment and <zlib.h> include.
> 
> Make all such comments to be on the same line as #include, make
> it consistent, and also add a few missing comments, including
> hw/nvram/mac_nvram.c which uses adler32 instead.
> 
> There's no code changes.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/net/cadence_gem.c             | 2 +-
>   hw/net/dp8393x.c                 | 2 +-
>   hw/net/ftgmac100.c               | 3 +--
>   hw/net/i82596.c                  | 2 +-
>   hw/net/imx_fec.c                 | 3 +--
>   hw/net/lan9118.c                 | 3 +--
>   hw/net/mcf_fec.c                 | 3 +--
>   hw/net/npcm7xx_emc.c             | 3 +--
>   hw/net/rtl8139.c                 | 4 +---
>   hw/net/smc91c111.c               | 3 +--
>   hw/net/stellaris_enet.c          | 2 +-
>   hw/nvram/mac_nvram.c             | 2 +-
>   target/arm/helper.c              | 2 +-
>   target/arm/tcg/helper-a64.c      | 2 +-
>   target/loongarch/tcg/op_helper.c | 2 +-
>   15 files changed, 15 insertions(+), 23 deletions(-)


> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0a582c1cd3..3f77b40734 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -19,7 +19,7 @@
>   #include "qemu/crc32c.h"
>   #include "qemu/qemu-print.h"
>   #include "exec/exec-all.h"
> -#include <zlib.h> /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   #include "hw/irq.h"
>   #include "sysemu/cpu-timers.h"
>   #include "sysemu/kvm.h"
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 21a9abd90a..56b431faf5 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -33,7 +33,7 @@
>   #include "qemu/int128.h"
>   #include "qemu/atomic128.h"
>   #include "fpu/softfloat.h"
> -#include <zlib.h> /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   
>   /* C2.4.7 Multiply and divide */
>   /* special cases for 0 and LLONG_MIN are mandated by the standard */
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index fe79c62fa4..b17208e5b9 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -14,7 +14,7 @@
>   #include "exec/cpu_ldst.h"
>   #include "internals.h"
>   #include "qemu/crc32c.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "cpu-csr.h"
>   
>   /* Exceptions helpers */

Maybe next step is to add declarations of crc32[c]/adler32
prototypes in "include/crypto/crc32.h", and implement them falling
back to zlib in host/include/generic/host/crypto/crc32.h (or
crypto/crc32-zlib.c if we need).

Then introduce HAVE_CRC32_ACCEL and implement host-optimized
methods in host/include/{arm,aarch64,loongarch64}/host/crypto/crc32.h?


