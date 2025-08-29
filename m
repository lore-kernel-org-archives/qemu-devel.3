Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E481CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBZ-0006DM-G6; Sat, 30 Aug 2025 11:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uruWE-0003mR-IY
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:31:34 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uruW6-0006t3-V0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:31:33 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e989adfefeaso163233276.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756456282; x=1757061082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3w37zfElto3qXoWmipNIx6UAtBzYa8FuYHHoW3jRCjA=;
 b=dElh9l4H1pOdFLEHP1nyf8wDj8Pt8axYdiFtSPqEJjXojjGky8lof9Xy3rjvg3jEUb
 5PpRhfbPI9WZLXwW2wo9XwMDMiPJMR+3FR+vLonpogeDdE2IvfCbclFckkps/IuWu7iQ
 DEzhVF9rVHMCCay8EWwR+4gvX8x+6bp0v4JTE9Dype5eVE4KFR1mUtNl+yDcVgL370Eb
 /MvKnLpqBjxqnZRYwCMRRwSKYSUm2sqYGgPFQD6AgleRyl57RPy1n5WGM0j3ofd8qMce
 ziWOqxrlVhhJ9ARyJfKDvq5avhaSD95wkf82aOZVnagVQ/bfD0TgaLMFX/plBzZDEb/i
 ollQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756456282; x=1757061082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3w37zfElto3qXoWmipNIx6UAtBzYa8FuYHHoW3jRCjA=;
 b=MMB188P9PLLx/UmYDwCVulCoVlaSFLn5jFIDob6TlJ1V5kG7NuaFy7NfWcDm5QJ4JB
 uyzLRdcuZ7UqSCife+cRgwfJJ7dDUoCUvuCZBO/gvgVDV/TU88yrZOXSj9uWZX03ZcQl
 uhULWt1e4c19hfnrUk7Zy2LGx+gcUbYo8IXW+9f4dRkwafKmlPO60JEzH1GmhVc4svhs
 FsO8lZ8NvzH/zOi4q7X/mI+w5QbOMPJhRl9Ft6ilxbz6CIFAdTRPKMDVngkdW+KgUK6J
 IBKdVIjWGWUcLSDbo+Vn8NCyidiCFmnpSF6CbVbgGymx8Sw20HBgc7VLeT7EBVgzFLY5
 vQrw==
X-Gm-Message-State: AOJu0YwL7fNt4Hjp/TLcMX4MG6fKvU0OxkwKIvFTG5TMbnBfuFIAIe5s
 sG9L+mbF/6n5HDY0hqOCAu7IvJRFyti2Jyz5/qRXRxFMCTbT5K2F5Phzh6dKs/ZcMct39h0rxId
 kDGxbywIM9S3ubhRjKO3KI6+hyXDS0IbitFlH4f12ZQ==
X-Gm-Gg: ASbGncvfs8+QE05i7F5hQRJM9jx8JqA/j0ymDWiy/qgxVSGYMy01R0QdY8LzUw0cBEc
 esdO+C0mrUEGVfwpveqs6WX/cHiidqkrQCIuyp8hHOhDnKwjhEUOGp4NERf+NZS/dbUvZdHJrfl
 HprAwqIObZuBJ8PF1ua/X/hLLNpxCQcqSOzDvSibeuP1L466qVXEsUHIIRcQYGbaBSO3dkOud3H
 BM4khveL6Ab7+hNFqQ=
X-Google-Smtp-Source: AGHT+IEroBT4Wo4XIuJ6FwD5eKFjNK8yXZkssh/dDq08EOW9XNmYGcclP7RyRx/LPJixTs5Es/GTfn/cJevvrZbbZwE=
X-Received: by 2002:a05:690c:6001:b0:721:1fda:e328 with SMTP id
 00721157ae682-7211fdb5f33mr163508527b3.49.1756456282416; Fri, 29 Aug 2025
 01:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-31-richard.henderson@linaro.org>
 <CAFEAcA9AbA4pa9EjOnkmrGMOOC-4nS+FNqni91bfDDkH1wOAbA@mail.gmail.com>
 <fa015de3-3d90-4c2a-9746-0337e53fac89@linaro.org>
In-Reply-To: <fa015de3-3d90-4c2a-9746-0337e53fac89@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Aug 2025 09:31:10 +0100
X-Gm-Features: Ac12FXwijQ2tfuvZSYInqz8m8PForKD3F3klDDUOxCOu5MaNsCFRHLUukNHYH0w
Message-ID: <CAFEAcA8g=1W_CqKSDkpKaYcmqZBYtWf6h77oj7Pdg=KHJNFhAw@mail.gmail.com>
Subject: Re: [PATCH v3 30/87] linux-user/i386: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Thu, 28 Aug 2025 at 23:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/29/25 00:42, Peter Maydell wrote:
> > On Thu, 28 Aug 2025 at 13:09, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >> +/*
> >> + * Compare linux arch/x86/include/uapi/asm/ptrace.h (struct pt_regs) and
> >> + * arch/x86/include/asm/user_32.h (struct user_regs_struct).
> >> + * The structure layouts are identical; the user_regs_struct names are better.
> >> + */
> >
> > Why do you think the user_regs_struct names are better?
> > "bx" suggests a 16-bit register, but these are 32-bit, right?
>
> Mostly I really don't like xds etc.
>
> > Commit message should say something about why we're changing
> > the types (though clearly here the target-specific types are
> > more sensible than the host-specific ones).
>
> Oops, yes.  There are quite a lot of error across the various target_pt_regs structures
> that we never caught because they were never used.

With that,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

