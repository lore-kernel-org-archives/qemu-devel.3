Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76B6D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4On3-0005mm-Bv; Fri, 25 Oct 2024 14:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4Omv-0005mL-Eg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:11:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4Omt-0003vc-RO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:11:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso5772298a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729879909; x=1730484709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8nfTLWIFuLIRZnJ5zttn9t99WgZPd9Fo1gzAk5S5KCE=;
 b=UiJSMVCYXEJEA9iY6DJGVk7+9NeTNZ71cjWUVuVNXI2Q8ExDMIE83IfAPQnezRE06X
 rM2pZc5q5fQxo52pWMjTYtZfijcIvXrDusB4uMbOMuMbKbyb/dnMtuaxVFpR8Dgq0KvJ
 iXvKtxEf5TPPqIDseKGtkyxe/DH95hTocWSJqrHWGsx1VZP97IY21Bag1PixQzNEWXfy
 Gjl3kqSa+04KvYAIUM0XfbW300wOpGxhnVjfcDuG7/WyGIRCzBPeXraTR5LujL5xCUwu
 d1HQopKmGhCCP67B41wjnjPGCMYARNVKYBwjCqhyK9fq5zb64UIhFePTc3OmmyirHmt2
 x1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729879909; x=1730484709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nfTLWIFuLIRZnJ5zttn9t99WgZPd9Fo1gzAk5S5KCE=;
 b=SqxCZypHBL5uOROU/gXJjnvFCGhCWNHmpS7TION5U5lh6zjnatT/5D+M4oJD/gH2Lf
 mUcDOwXoT/pppFtMU20Gmw2Pf6iq+R2D3EdHwBqObMvBCceYAUUh0oxaC+3dRxHUPSAT
 DCTec0EsLzqWtxC9wfrSB+uDTOxdAUFt5gvbVmX4k4q5ojqWVYLC/WYgohl67PyyPd8h
 Wz9sC3GHplP8tyJsXCO5Qbuk3pKT5JmCLXtaI2ji+3ig/5rNS8cAJvTCBdzE3gPWN3SS
 /npOup0RL7aQO+CuyI5z8+UQjz9i3J0kUhI/NIBqLWfmjxOSdXa/Jy3VDY2m7LVNHhqf
 8wXQ==
X-Gm-Message-State: AOJu0YyZk4ziKeZHCUHR3yrICaxHnHdb6XAKgjGWBGnwefgqBXFJqwxC
 YlrcxiymhcvaQEiBp82cHmbgFTz0SEOPFBiTuIx6p678E+r8Hwzh8WiZ+i2gF/W+kxBgPVxRu0O
 VRJHYGHtb/FpRDKwqb7SlbsB0n51CUxkUrRocsw==
X-Google-Smtp-Source: AGHT+IFj97ThCZdJaHmZqAxMZcH6FQSGgASk2i8CX8JNEcyWLP+VE05tCCVOPP4Imoal4zY4DyMBXBQ08CAQoXI02h4=
X-Received: by 2002:a05:6402:358c:b0:5c9:3070:701e with SMTP id
 4fb4d7f45d1cf-5cba2037cc9mr7428957a12.9.1729879908100; Fri, 25 Oct 2024
 11:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241024092626.1328049-1-gaosong@loongson.cn>
In-Reply-To: <20241024092626.1328049-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 19:11:36 +0100
Message-ID: <CAFEAcA89rs3Uk9NbqVM-Zwh7J6m10dAaYy0-D2GQOrKwAshv5A@mail.gmail.com>
Subject: Re: [PULL 0/6] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 24 Oct 2024 at 10:44, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241024
>
> for you to fetch changes up to c44e0d6ba280dcc6bdf4ed555020c61d564b526c:
>
>   target/loongarch: Add steal time support on migration (2024-10-24 17:27:55 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20241024
>
> ----------------------------------------------------------------
> Bibo Mao (6):
>       target/loongarch: Add loongson binary translation feature
>       target/loongarch: Implement lbt registers save/restore function
>       target/loongarch/kvm: Implement LoongArch PMU extension
>       linux-headers: loongarch: Add kvm_para.h and unistd_64.h
>       linux-headers: Update to Linux v6.12-rc3
>       target/loongarch: Add steal time support on migration

Hi; this fails to build on all the aarch64 jobs
(both normal and cross-compile):

https://gitlab.com/qemu-project/qemu/-/jobs/8190899599
https://gitlab.com/qemu-project/qemu/-/jobs/8190899331

In file included from /usr/include/aarch64-linux-gnu/sys/syscall.h:24,
from ../util/oslib-posix.c:48:
linux-headers/asm/unistd.h:2:10: fatal error: asm/unistd_64.h: No such
file or directory
2 | #include <asm/unistd_64.h>
  |          ^~~~~~~~~~~~~~~~~


thanks
-- PMM

