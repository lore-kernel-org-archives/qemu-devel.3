Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30BC83F20
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqqE-0005aC-Q5; Thu, 10 Jul 2025 08:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqq9-0005Z6-Tl
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:57:30 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqq7-0006uR-VO
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:57:29 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-714067ecea3so7954917b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752152246; x=1752757046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n+SvTOi6PLpHPVuUl1REyy+vI1JFPYV6WHjr13zZGBM=;
 b=CM/VTHKkDOMYRAxhKBzjGFTEkTQH0EpW2SKu+ZbDsAZ3mqGh92A58AQUYmd5JZH7+G
 5W/K6Re97fxWEW+MyyBClRzPH/YqVpCsmXLswKw3QibUbpZDTmE8ytQsxNHQkpBb4Emr
 Flayg3Ptyl7nTz7SXUvJRFUPpW/yHWnzBxSuXXYuCPMZTXMtc0NYr8Qq8VL4gqYSeumU
 9VTadkbqNBs2GVjcIYlHlX/Y9Nk4W0s4BW9G2+VVHSsDYy+sL6VoLiqEZZGEm7HNCDyC
 p4yLgPXsYML/0mcP9vIFDiXzYCEIb8FSpn4aMHofsGAPtIgsp7VewbD/8eHA4GSGF0S5
 AdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752152246; x=1752757046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+SvTOi6PLpHPVuUl1REyy+vI1JFPYV6WHjr13zZGBM=;
 b=KXSSfIGjlnciDcS4i9bZDlBOWmhIYLfqZXEL7XaTcW8QMuFOhsSIfORDb60AB4nZqs
 EoX/vzx5XFql1GyFLY+UhVUx51Sy9b8cjmyVXQuMXEv0WPOcNrz1f7lt3W+tLut+thyC
 zhF7+ThBpOE7nQv3FEjGvNXGl4tbC/f6mCJmebwTize+eYIwXhs0qeWDfhjjdfMHSL7a
 8c0L8VwuXIR4yu61geS4wRxU/Sj0C7v7AZG4Vfmbj4DHBvl6JBIeI9fi2Edvf4gtBygw
 442oguZ8brLqBaIEseEUD/rC1JUD+Utt0439MylASh2OAb1dj8ue7clYw33k3Cab+ags
 Tonw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgrMsO2+vb+LQMcycKjNfewbg229vd589NBaReVAo14Tz1Gqfesy4VxgeVwSbCqyKfX07zskF4ImB+@nongnu.org
X-Gm-Message-State: AOJu0YzWP5X/Vaf1adLQtyj4ksIhdGiM+JOYeyoJBc3hC8nFEgtMDNrK
 1eC40i+fjJj9BmscK6KdCKtmYvPvVRir7R7TSfmXRDTaVG8YafbkcWcbbLuh9AfhqeM5E3C75Pz
 BsX6UV3dRuoH6C4h+CkxEzFGSKgL28azv5hcL90+5Qg==
X-Gm-Gg: ASbGncuWjpwjl8B0CqWqKmcoemVxfAIiRuaHtK7VonnGIKN7yRQcsAxkFtJU8Po5wG4
 QuODapG2nhsBdzTJqu5ZJ514Cvm5cjpMIX9yCBAPv45LwUmejDSENHTeuEOhwxA7NFnUDhjwrD3
 D4tQG2RT+zcrLo1JDbmXhSF2rI1HN/NJQxelHh17HWUvFI
X-Google-Smtp-Source: AGHT+IG9qBLAzmud+igg1+EbzGH/0VS3ucO+T32gz252xD96y5Lv9fHI8DGM+uSaIGVn66SaNa9LduJdMRDL3Mnu+20=
X-Received: by 2002:a05:690c:4a05:b0:70c:c013:f26 with SMTP id
 00721157ae682-717c48338a9mr36300957b3.33.1752152246116; Thu, 10 Jul 2025
 05:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-60-pbonzini@redhat.com>
 <CAFEAcA9mqK-=+bz+tdWzK5Jyq0v-ng4wQ5ngownLqOcbKQgq+g@mail.gmail.com>
 <da06f310-2349-422a-98f8-cf5995539c36@intel.com>
In-Reply-To: <da06f310-2349-422a-98f8-cf5995539c36@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:57:14 +0100
X-Gm-Features: Ac12FXwu7FyP2iZPwXfBQ5ROC3q1vBvVvnTn-qUrp14E8zA2fRU0of3y5u_M_mM
Message-ID: <CAFEAcA-OMyNNK+CoWLyJsAUokMti-z9_XhDiNe7KR0Drcm8GoA@mail.gmail.com>
Subject: Re: [PULL 59/77] i386/tdx: Add supported CPUID bits relates to XFAM
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 10 Jul 2025 at 13:42, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 7/10/2025 8:27 PM, Peter Maydell wrote:
> > On Fri, 30 May 2025 at 08:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> From: Xiaoyao Li <xiaoyao.li@intel.com>
> >>
> >> Some CPUID bits are controlled by XFAM. They are not covered by
> >> tdx_caps.cpuid (which only contians the directly configurable bits), but
> >> they are actually supported when the related XFAM bit is supported.
> >>
> >> Add these XFAM controlled bits to TDX supported CPUID bits based on the
> >> supported_xfam.
> >>
> >> Besides, incorporate the supported_xfam into the supported CPUID leaf of
> >> 0xD.
> >>
> >> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Link: https://lore.kernel.org/r/20250508150002.689633-48-xiaoyao.li@intel.com
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   target/i386/cpu.h     | 16 ++++++++++
> >>   target/i386/cpu.c     | 12 -------
> >>   target/i386/kvm/tdx.c | 73 +++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 89 insertions(+), 12 deletions(-)
> >
> > Hi; Coverity points out a problem with this code (CID 1610545):
> >
> >> +    e = find_in_supported_entry(0xd, 0);
> >> +    e->eax |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK);
> >> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
> >
> > All the bits in CPUID_XSTATE_XCR0_MASK are in the bottom half
> > of the word; this means that (x & CPUID_XSTATE_XCR0_MASK) >> 32
> > is always zero and the statement has no effect.
> >
> >> +    e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
> >> +    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
> >
> > Similarly here.
> >
> > What was the intention here ?
>
> It's future-proven. So that this code will still work correctly even if
> CPUID_XSTATE_XCR0_MASK/CPUID_XSTATE_XSS_MASK has higher bit (above 32)
> set in the future.

OK; I have marked the report as a false-positive.

-- PMM

