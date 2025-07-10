Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49A4C83F20
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqRZ-0006vn-C0; Thu, 10 Jul 2025 08:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqNt-0008BG-2T
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:28:18 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqNq-00064C-4J
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:28:16 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e812fc35985so760042276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752150491; x=1752755291; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L8Avu3/7JCIkAMUNtgSBoZNLzLoF7VbDbT/0ZEcClQE=;
 b=V0Pr0j6Lgt4FjcIpOWa6aDP+LYgCFmVSU/4o1rY0ZOaworvbPn4xqgODXD6aISHOoZ
 YqgdKUeQ8V5ofBw8+mIGzJp8rGecjDnTqozn9ag1xNXBWdxcA6DSNu2eB1b8eaz6gUJ2
 Jn3W9rQGxR/kOat22RlQN2+TB1YXHCzIcV30uq60wNgZR4ZTjDcrOwDfFWJ920xYDchj
 uQuN3YOAWwuhy/KqQBUfBAT/4WKPAHslzMOu6FSumm6sVWRfxCVweLb7ET49pC7IRrF9
 s9pJzmjCVXSM8rm6/VkWG4kDzs36V4SECm0f4iFJHnd4dGlmNTzXB9/kqf8dEpIke8yP
 nq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752150491; x=1752755291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L8Avu3/7JCIkAMUNtgSBoZNLzLoF7VbDbT/0ZEcClQE=;
 b=ip6U7eniTe7oLPacgCrOAbfv/RDCqQEAfDVYvIXoXoumq8dPL3UY6elir2E/VqsNHU
 qHEJPJ2Q6QWHqpliTj30KTbZWRtxBeBHvHhskgH47TplEW4PeS8IzUaUI3NiAMcN6MU/
 QR/s9qK4PWJxGS/H44ajmpHrJT1m8s74Dd4mW8CuSUPe5DbAkli7jlkvsd1HHV0wbK52
 P0f69QPKcEj00b4GaMwHFWe9Iv+RtY20VRdy+4i+Ts1tTCZDNA4jKjN0DPAUAZAL0zif
 q/3Lb4mVe+qLezIwxiD2XwxDdJBQ2BuhbxwGADcclLpgkJi143vMn/fD4rqERbwcgq3z
 wEkA==
X-Gm-Message-State: AOJu0YxsUBDhmLhLW5vmDsX9eUhw6xcG3QcBt2ZbklrXxrolpFi+DELI
 712cUn59olGtG2EHlm9E2ILcHRKImFKK4h3kErWbiXzI24FNqoUhTxOl7RrhF+YScq4wd0QwSxO
 wuo0U3U/e+zBGn86TwcU+Dj7Ra3AjUBoexd815lynC9yLICmsJYwM
X-Gm-Gg: ASbGncsxQGH/kRE2bqzAyVYtYV9dCIYgrHRehfi2DgQTLINGLuNpbPiWjAGua+U69yy
 QOzOhBG48/R+oPEMjOl/Q2E4TffHaXTfPLD1AmTbygebpZHE7Dd3VKpjbDWKPjj+woiPQ+guyMF
 6Yc2ZEDXXCXyTf9P/T+3WmxBMg+32Ecv6AOicyekc7h/fm
X-Google-Smtp-Source: AGHT+IFpvb03kgwBUV353iD2cca0s32ZX8u48rQmqvdv/v7caV8Zc9xOCZBF5nEM8w2V3/jVuxm77IHwj2CXEw8gyNM=
X-Received: by 2002:a05:690c:4d04:b0:714:583:6d05 with SMTP id
 00721157ae682-717b19fb7e6mr93289307b3.32.1752150490584; Thu, 10 Jul 2025
 05:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-60-pbonzini@redhat.com>
In-Reply-To: <20250530071250.2050910-60-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:27:58 +0100
X-Gm-Features: Ac12FXzSiQy6yJgchInNuhsQj-XQd3WSR258NfHeEleygBSXMy08_85Sp3yJHQY
Message-ID: <CAFEAcA9mqK-=+bz+tdWzK5Jyq0v-ng4wQ5ngownLqOcbKQgq+g@mail.gmail.com>
Subject: Re: [PULL 59/77] i386/tdx: Add supported CPUID bits relates to XFAM
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 30 May 2025 at 08:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> Some CPUID bits are controlled by XFAM. They are not covered by
> tdx_caps.cpuid (which only contians the directly configurable bits), but
> they are actually supported when the related XFAM bit is supported.
>
> Add these XFAM controlled bits to TDX supported CPUID bits based on the
> supported_xfam.
>
> Besides, incorporate the supported_xfam into the supported CPUID leaf of
> 0xD.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://lore.kernel.org/r/20250508150002.689633-48-xiaoyao.li@intel.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h     | 16 ++++++++++
>  target/i386/cpu.c     | 12 -------
>  target/i386/kvm/tdx.c | 73 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+), 12 deletions(-)

Hi; Coverity points out a problem with this code (CID 1610545):

> +    e = find_in_supported_entry(0xd, 0);
> +    e->eax |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK);
> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;

All the bits in CPUID_XSTATE_XCR0_MASK are in the bottom half
of the word; this means that (x & CPUID_XSTATE_XCR0_MASK) >> 32
is always zero and the statement has no effect.

> +    e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;

Similarly here.

What was the intention here ?

thanks
-- PMM

