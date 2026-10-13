Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66198CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfLS-0005F0-N9; Tue, 13 Oct 2026 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfL6-00053N-08
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:57 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfL3-00055t-Vm
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:55 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8726acc5eadso24297667b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791908812; cv=none;
 d=google.com; s=arc-20260327;
 b=kMHjrgAPXi1VknK/W9VwRgjK+MMa8Srf4ZlZLU2+wmjFTsm18KFK75kOksfmQ0niFL
 vH/PJW2f5LK8DGlIGudY9XAkxkJUVRP0Rv2LfFTLIihl3rTPjsqBdVSk2z978jRq9RbM
 kAmwMMH0WtZe4E3sEKifBlJ+SUDkeWdM15DLbtsb4En6Pg3p109LB6N58UyOG/7AYc4K
 x+LZ48yF8CBQstOwsCJIG9ntLxiBw+PKELnNfe9zzYqAZa9uhN7TasQ1YL5jc5QUQ8eh
 Dzgf7S9VgduW5fOEK/7/wvqMI3t4trrBuQV0UKoNR3tK3bTvowKVFKDm/3fIT1eBqvt/
 pbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lfW0nUOSaRUIuZAH3PPaoOxVv0uganAcfQGMmdwJiqI=;
 fh=8x3y8/eirLYrwddHypnsNsNpqMI2SdU8PmkQXoEmpc0=;
 b=o99LIE/Gj0NttOY7SjaEl7idON3ABKAMYXYZA7nJIKbQkSBLAhTRo1IiaHmh1cfOTf
 3EX78vgYFD0c7uQ+aMqg/FBFUHVHaYRz+yCZPAP06OMFF3LG0Lif3t0rHeBm76NG8nHz
 maVfMsyQlbg5FiOcO4aUY9XK47u9X4jMLMwdDc+pnqu3hUbvVS6sLQ8CT05yF+svNqn4
 0qWcSvu1WUZKeyQTxlF8pMI863NdK2GLwATcwuQTmyi87yM6qYJJqMk+9ivj/hAZKF7G
 g01hiX430dvkedmPIkZnVEVMFePUYblQ/93C+xsxEn7VGcx9OWSN31nR5mjkPnN5fjIN
 W2Yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791908812; x=1792513612; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lfW0nUOSaRUIuZAH3PPaoOxVv0uganAcfQGMmdwJiqI=;
 b=Bo1LpBx52ibELxBGuvMKNYW8jfPUJElga6ECLmINik6s91Unji1DBpguizQVLDUSZ1
 RFRwmiwe1ocGBGHcTbQtHntd/7ROEGOE7UJZlmG9hKj5v2ka5+BOzwVDgScVPQoQEwXN
 nnK4JKt0///Oj1YXfmH+HlO8YJbBp21szBXpKyKdaL/SRQdLBJd/EcpeaJWeUXN/Pgja
 2KHqFcAvMzFRZq3zJy86F4hDQorNFA0LG2kGl7Cl6s3SUPEbc/Fb7Vm3PU86NSQm68X+
 PrZ6Ro+QKSKLayj6EsZgx84FKQeHXZCS4URuElmRXqGlRN8EnXT2txr4j3hNyE4smdln
 57xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908812; x=1792513612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lfW0nUOSaRUIuZAH3PPaoOxVv0uganAcfQGMmdwJiqI=;
 b=Voh+RDaeRYjtzDLit1zfI8ltMsvvjI2++oJ2xLSdq6vXOkhmefRIef75sp9Zff67qL
 Oi3RQEHIqLUPHtKVMBYnO6iqfR61FG64SN8CpRH8Z+Gk3bf+B6MosCOYPJ4Tbn8bsKGH
 vMgyKfw3rNe202YaKNwZJCUaqXtcLCTjwV1ls9jaCqE1eTMO3pVjfDv81XyHf5ZMvSn4
 jHFXLeuIOdB07KlHjQhQOzGreBq4ZBDSryGrH1IsHKcpa7l5psZfhXZOteHl5LY4ZPs6
 i6N2rHyRWkqu9ykBG9pG1Y2EhKEDyncubGcCQnEjED0Wfj3d1r5vxqEP5LsB02FS5RBv
 MSVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5Hn1WrQV45HIdAQ3HcN6NSUQrUFeRc7mREmEOYBZGptriFrvlU671qP+A8sHSK6qzecGueyW+ze+A@nongnu.org
X-Gm-Message-State: AFq9FYL7B9byKTwi+2Sq/NLbH9+4vyAVexH/8TEss6AueelpEAZdpuAZ
 Bp8eXfYQqxsDeOAIObM/xCxPKd1c0cDSz3Vs1KvpyM9/3czBgF49Ty+mVppOs4QwAuJ/ZxnL3d5
 r4ZXrHKnSqeJ/suf8x2ma7/ZMSLHjr6QXjXFbJGGxog==
X-Gm-Gg: AYBFou1+yeYsmcNaUmYMWn8mWjs1RqNkMGyggKi71VE2yuS3zi0F/bCUjsGN1XgSwee
 +HuY+7sAHFRs2RwQRXEbzT6IJWRxJwYHPBFuWs6nD9syh9jNopILX8QzuM7XZANz6OuNXbTXzqT
 lvrWdwl9BOYTuY9Grk/H72JSbAI6oFiiW4jt0tEHFKRPje/DIeltDCcsUGW9nkkgQk9PKXlRA7L
 cn1KX1rVXecEGU66ISYMM+giU8TAyW1PBhzT59Tni84kdYs8MpVkwXeTrotUgmWpyCvhHNP5fNU
 YSPJRodJ9w8F7fIJ/WlVNvWxtbJxMtspIBp2nopPfrePOkbEoUtjdnrB/14iCD8y53TUwDrsLCN
 ntVRg/2Zl5ZN8MU0ursu7eAeubav6F2IkHqaSu/w=
X-Received: by 2002:a05:690c:e3cd:b0:8b0:ad62:19aa with SMTP id
 00721157ae682-8b0ad6230f0mr19157117b3.33.1791908812379; Tue, 13 Oct 2026
 09:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-21-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-21-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:26:41 +0100
X-Gm-Features: AclHuK9LMqtW-CAAZ3xrwGlJrfDwYU71aDjAnimvRogO_6sdanZdfIn2PpOI6Zc
Message-ID: <CAFEAcA-BxUQAg6uVPn7EMP=xJ_J7oa6FD6hxZFrmQJmf=-VhoQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] i8259.c: switch isa_pic from I8259CommonState to
 I8259PICState
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The isa_pic variable exists to allow the output to be fetched or read (fetched
> and acknowledged) from the x86 PIC. Since this can also contain a cascaded
> interrupt from a slave i8259, switch isa_pic from I8259CommonState to
> I8259PICState and update both pic_get_output() and pic_read_irq() accordingly.
>
> This has the advantage that a i8259-based PIC device contains its own internal
> reference to both the primary and secondary i8259s, and therefore it becomes
> possible to completely remove the slave_pic variable.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(That isa_pic global is kind of ugly; in an ideal world the callers
would have a pointer to the PIC they cared about rather than relying
on there being exactly one in the system...)

thanks
-- PMM

