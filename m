Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA7CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDKs-00079U-EV; Mon, 12 Oct 2026 06:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDKr-000797-Ee
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:32:49 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDKo-0005wl-BU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:32:49 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ab43af5e97so14448057b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791801165; cv=none;
 d=google.com; s=arc-20260327;
 b=k1GVqRV8Bwq2CQg/7vwOL4pwhHTkNeu5AW1iDNmL0LF04kJv1Cl0VmaDe8pA10C6ND
 2VuuZDjOx/eCMmhIa6huGgPocg3il1XqSfN6hFs6AJd/lN/PwxsnRZKnFiHx7DqmB8kF
 SNB+aQVK/NXcxJ2uFHueu3ktuAsHoQawdcorRiQCfbhRzfeIslAzjskkkATiPiiV4D2U
 o4apVihVecnp5sbSj+YdbDm82l3shi5emwyJkUcQXxxn1VoPz2zmFSQMxycPvjoGNmBn
 N1WNMrg9OKIwVJSU9Fw1Ls2HvYEsBmpkV1kxI8Et9XtabksOx+TIfI1HG+TwBBoQmow0
 dAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YQI/rTmZyoxAzzXUf/eoWI3j/Wdpv6I65MmZpfEGH8g=;
 fh=FQj7FDIusZUry1X2qNQH2KZFq3jMCtr2ArfBjvDJfBc=;
 b=TNKePuxDLBLpt5NLx9QOXnUFzgHDDKNwRWz87+FCn9dOj67wqvrwSJkdF7K6Uuo7bx
 mfWezhuZR4mDC0UpEKGx47OyHrV5+rrZfl8x448QwKWzrf6ySZunGDGX+jasbAWLz+oh
 SlN1K2vtNi1NggrBAIOR666cIrPb2wdGQ4Gb6P8v1CisBwCFAIhMfEpWAwNHcDuQa187
 l/sn8qo84rCMUpj8lMdpG5zJnUpoJrNy3bc1wsV6qY5hjsYHQqdH6jWBn53TnX6OmSvw
 H5iyGjUJvqetZ5mKc/0ixaUgOlf13Zb3qYeQytJEMjlpos5GdhyN0zUTqvva1GGaIZ1o
 rvqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791801165; x=1792405965; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YQI/rTmZyoxAzzXUf/eoWI3j/Wdpv6I65MmZpfEGH8g=;
 b=P0JjeGifgKNmdkpgbVNGrKG9+4rgvW0mVxeG/2JGUbCGc4X0CsHodWiCBj3LKViXFq
 cD6tYeOyHK589eCXQWJ6Z+C39F2Sc34lJ/B9U9eywBkM+fPQ8pefBHt+GERZv1VGnJfr
 7eDaCoNcKHXRy7X2MZWLuGAKF4UxCyJ1tIOMeyh4Z9o+VChMNHbF5eUanGRPOZRti5zg
 ArmmUm9TRPDgCsoK1JHFxWXI5Jiq9+mJbBqJGcteLx3UVvP5J0WaZdknkoia/KC2nZLq
 iqnLga1sKIRyHNqBQ5nDz9+6VA+Fzy9/q67l+eqevj/SNNrJL17z/TVCbyzmfBFnPLv8
 /8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791801165; x=1792405965;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YQI/rTmZyoxAzzXUf/eoWI3j/Wdpv6I65MmZpfEGH8g=;
 b=z0nIFeN+2BRmh/TX4yjNKR9F+NvVN6X71wSZEB7VC7ISdfBf1lgfDMebReIf1LF96L
 gNXnjHIibV9+9yKXv63GaidulD+/ffpdborHTP0Mac8pi/qZWqUWX4FuHiE1YmU2isY0
 K/AgP6glZrSxPguT0q8zPqReYLMpWc/n+pHKk58JFybKXWNpRhAuexbthr/GWzzPLTjr
 91mfCsYDgHWDCA4dgrnVjpQ/A44IfIcSWEXiwy7XpHeVY6+0y+NBsQ3PqEOtJGAhmCmS
 a1l/cibHn+G0DeNr+Y5uCgVQc3LryG2lLryFRvRDebZ6QnHkie7TyNoX3OYIF7YFLKvX
 fh1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfMA7uSjFr/rH5ClkdiwGORbLcIk+MxOCv44mcsQxhMefSASjNAke8I4RXS71uO+Zix37W7LOxkLCf@nongnu.org
X-Gm-Message-State: AFq9FYIUZoAZhb4DMT9e6YOQEwhB6g5NycG8w5LooLXN4RYI4+UoWvpK
 xLkjr1Zwqfmm0SwxkHVc69MZZS5AjOgFeCh0ucSa5B8RBFraQzSc62W0tN9ncnUYf7E940ZsTHJ
 2/xMzoyAEUULAdehBQc2dQA+TFp/4ZlbbBz89eq+VZg==
X-Gm-Gg: AYBFou0q1x1C0x1B2HKLMuUVMB2eP1aCgLtFUOjp2tbRl9aXHSXYdV3fg5pW6XHKCnU
 9ff5F8W0Ann203KeZohPL3xnSnGLvDb66wYlDeM4pnxT5RzrneeIRvlYahC4kt2IXvGCjnlvVX7
 Qtme01n3VPAtgAQS3FqWvGYFFvi1DTxMTdq11iG424CCq8ZfkM/58UiyPYQSWnu4M3hlG+Whemp
 2iX1CVe/njzRaao+TH9QYmJ520ve1PD6V74h8DcxM7TDAFqSNBmVtNHkI7pujVj7T/cg9K5N5eC
 S9z2ZI/4JYeG0TRjJ0kAjMXloHtKHs5t3ZWociEv8k4+QAso/1462YYBPGxOE2U7HQMgPSLwsvd
 BMfo8UH5jXfFoLDaH/dZK3iAsxH+r63jgH86GBcA=
X-Received: by 2002:a05:690c:56c6:b0:8ac:c329:682d with SMTP id
 00721157ae682-8b07ed09205mr21470367b3.11.1791801164938; Mon, 12 Oct 2026
 03:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261009115728.1299384-1-fuad.tabba@linux.dev>
In-Reply-To: <20261009115728.1299384-1-fuad.tabba@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 11:32:33 +0100
X-Gm-Features: AclHuK8AFMvBxGnvEeYYBK6kDyub4SiDtm1qkQ6ht23RjHpdhp94I11GUJgw7qs
Message-ID: <CAFEAcA8D-8SAtpCq1WV1zmHcJhieHRdG5Z_o=oiOYN4Ly+vYWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] target/arm: Fix the TTBR table base address in its
 52-bit layout
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>, 
 Itaru Kitayama <itaru.kitayama@linux.dev>, Will Deacon <will@kernel.org>, 
 Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 9 Oct 2026 at 12:57, Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> Hi folks,
>
> Changes since v2 [1]:
>   - Each fix is now followed by its own test, and the test description
>     moved from the commit message into the file header. (Gustavo)
>   - Clarified the stage 2 comment in the test. (Gustavo)
>   - Noted that RAM_BASE matches the address kernel.ld links the test
>     at. (Gustavo)
>   - Collected Reviewed-by from Gustavo on all patches. (thanks!)
>
> Two fixes to how get_phys_addr_lpae() forms the initial table base
> address when TTBR uses its 52-bit layout, each followed by a TCG test.
>
> The first stops TTBR[5:4] leaking into the base address of a table
> smaller than 64 bytes. KVM's page_fault_test hangs on it under TCG in
> its 16KB, 52-bit PA guest mode. Itaru reported the 16KB hang on kvmarm
> last year [2].
>
> The second uses the 52-bit layout whenever TCR.DS is set, as the
> architecture does, where QEMU used it only with a 52-bit OA. With a
> smaller OA a non-zero TTBR[5:2] is then an Address size fault.
>
> Based on QEMU master (f7ada39eda).
>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/r/20261007080019.350315-1-fuad.tabba@linux.dev
> [2] https://lore.kernel.org/r/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev
>
> Fuad Tabba (4):
>   target/arm: Clear TTBR[5:0] from a 52-bit table base address
>   tests/tcg/aarch64: Add a test for a two-entry 52-bit TTBR table
>   target/arm: Use the 52-bit TTBR base address layout when TCR.DS is set
>   tests/tcg/aarch64: Test the TTBR layout with TCR.DS and a 48-bit OA



Applied to target-arm.next, thanks.

-- PMM

