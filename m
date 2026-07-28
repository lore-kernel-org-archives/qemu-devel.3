Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF835C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woixb-0002nQ-7n; Tue, 28 Jul 2026 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woixY-0002lw-V6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:39:09 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woixX-0000mZ-En
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:39:08 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6681e7911b0so5458858d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785249546; cv=none;
 d=google.com; s=arc-20260327;
 b=jNYXJVOHvbGoJU/kR2xRjbgPHw1NQ9iMDQFerwEzUdGaktIB/9z0EMj1L3WxPTlTDe
 zrptRTqi+y09FSGuBjm5wITWBALFQPdapfJvv+wp4dTad8mKbyOkem5T99w+AUccCyg+
 AJdONbKdt+QZrg1lum0EyBHU1++KvRWN4Fb+x6r6SKZkaxmcVEdQAe5lEyiLPQVBXGoe
 tVUi2ChfZn5ZVJCYjepVWDxbT1FDcKiEwcRKH2csKwKHeVGImCqcIljAAge37GFXcNFr
 jW35YGVQoYPujPf/Xab09bSDPAUvKfO/kFCAJR9CTCiGWCzZV7b6tAe5YcFxC9c4wPAD
 OvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H0pP+XrMAwMqRZG5C6J60GHZJEAKEPpIro+Dr/Olv3o=;
 fh=E0eWGkwA2p36YxiBUYxgmPHOVCPDf8a5rzjKX+YB7yo=;
 b=IyZYGdZin7eDy7Z0UowgQmaiTHwoWxNR6XHkzToeSZLXLQ5rsIiL8/XC0APaulR4rM
 K7gbhFzkw1cJn1+N1M1dNnLv8MkxEM0UHA2l7CJlN6Raq2w2x0pkqP50MCO6uy7O2Y0E
 TRQqRdtRRfSXQfxMYkobxGcJsmtgX2u1vjcK6TYxSmsZVxbAT7Uq9aKj8bCc32NsdY9x
 i0JnGtLG9O4FNbkM7FZIbJbDSorFZ4lm4dDQLO2yRc/VQSDvyZtspYyeTRv9C3hlgzID
 0nYHcs1s9bVGb6nusgJiZXcsG2VAsklErl+l55HyyI69hOTrlwHfZR0HxIBMhoVh7zi3
 1+2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785249546; x=1785854346; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H0pP+XrMAwMqRZG5C6J60GHZJEAKEPpIro+Dr/Olv3o=;
 b=M7IR33OZNOzGYryCCWJNWNhZiWFJtfC1VP6MgrhqxXPzOloFjJonfQPwHnqLZ2fXkA
 n/dS9VKaeblefZ3FT4EwONW4gl28Bnw2AobjNO54ofmO56OvbW+mYbHEA4OqYW61cM0v
 UNf0Dc06U7ccTG0sLv92KckLD2GF1Zj8tjLMup7XDZyzQ9f8OoA5Xoq/cKwPZicvzNVL
 HQMGuI/yJ1WknojM/bkXsDz/VbxnGhM7DBByWHFSV1h5KKqgy+arPu67fXVGsqHOzhNN
 gibi9QzdKeweBi84ZIywl98YieDBWtyHC6SRsJxwi352nPsD2iBh0qH1YS2ItbubDo0O
 OzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249546; x=1785854346;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H0pP+XrMAwMqRZG5C6J60GHZJEAKEPpIro+Dr/Olv3o=;
 b=FoINm90zqMDCPIj49OYgxPOg9iMXfBu/UleZzN/EMHDcysyUQ4IswGE2Lfe3tQhRuJ
 wBazF/4lOB9/g4+6wzqZx9yt9Mgp5+2dRyK5yEl+yio5+j75UL/ZVqhBuKuPq7Z2yJFV
 mhOhDTsFd4KJLeRpo84cdcwCZEcT1E1VOYkqCtlR3ZT1CX1GeR2Wds0muPD1HP0RUBY8
 +rWHPUKbUkSAEFxC9HCNIRwsBbmNC4lZuTKp8HrLt+GagX/FtzAcczcdJztAYChSNGuP
 7DNtqXThvfGxr2bg2XIdafCGsMLdMVbw3pgS/FK/RuDib56db9tFHfg296deUFBbCTtU
 ObfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBkGDkILoZ+DPi21rH44f2aCLBediMij5uoinDaiS+C1nsP6qJA0AsGPRHmIcamSN8ZyCE5nyluZd7@nongnu.org
X-Gm-Message-State: AOJu0Yy4s5KVza/jvfsyIw8Hm7NKYv/b0fmn2tzhK+ZnxncYTu2132rZ
 Or1wsmREuFbRFUdZUb22Hv09EKbC43OHY1+fo9XrAYRPruVO66xDckaCIBYfy8oFp0WiOb1B4ys
 yux0kVD4thqetj1lsxLOK+Y18znH+8xCwdio1QDI7gp12Qoet0uebVEQ=
X-Gm-Gg: AR+sD106qqq13p/wH3n08Qxp2CFnxNJFyxliAdEHA5+nekr1bXtDqm6Onhon2t7o55E
 PFvvgNzAIB8gqSf26uG8WHCT6ywPbDIGBbbfjNOa2JTL5pZjBHpmnQDquOjYIhEY0HqL6zC16we
 bq20Y6jkgDStiiuTI6dTS5LNKdjJfIvCre2PveXLmiIMcoHbXALiXIiEpc/OOOzDk6ms6Opu/X1
 It6KtIFubMkDZr4mrSUZQORA0LQwG9MyrRP5EKvIuynvCulX6HOqHK5sRCZS4s2lkvy2rQ6000E
 PnqjgeKGt+m/gG1EwqXCyGnPPV150HcjNkAuvlkgk7dnww==
X-Received: by 2002:a05:690e:4005:b0:667:91ba:9bdc with SMTP id
 956f58d0204a3-6690545d1b7mr1162220d50.11.1785249546204; Tue, 28 Jul 2026
 07:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
 <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
 <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
 <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
 <2322668a-20a3-4a6b-8d7f-c04ddfef84f1@redhat.com> <ami94CmeBNRKy_es@x1.local>
In-Reply-To: <ami94CmeBNRKy_es@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 15:38:53 +0100
X-Gm-Features: AUfX_mwPf8ZxxzTtyolXaaZ5S2ILmfPZnwZ5wIVgDG62c5eXdboXHCSKaUXDWTw
Message-ID: <CAFEAcA-y+vNK2u-rSq+SVjNZrhO2=BsUysEw2PtCdCZ=qYx2bw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Peter Xu <peterx@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, 
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com, 
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com, 
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn, 
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 28 Jul 2026 at 15:34, Peter Xu <peterx@redhat.com> wrote:
> I think the bit ops should be more efficient. I plan to queue v5 with a
> fixup, v5 here:
>
> https://lore.kernel.org/qemu-devel/20260728031731.286666-1-gshan@redhat.com/
>
> Fixup:
>
> diff --git a/system/physmem.c b/system/physmem.c
> index fbe7df2391..2f37cbeb07 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3162,13 +3162,18 @@ void qemu_ram_move(void *dst, const void *src, size_t n)
>  {
>      uintptr_t test, len;
>
> -    if (src == dst || n == 0) {
> +    if (n == 0) {
>          return;
>      }

As we're dropping the src==dst check here, we also need to drop
the "and the memory areas do not overlap" clause from the
documentation comment.

Otherwise I'm happy with the v5 with that fixup applied,
and you can apply my Reviewed-by: tag.

thanks
-- PMM

