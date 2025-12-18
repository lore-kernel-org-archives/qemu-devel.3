Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7ED6ACE5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWBYF-0003yN-Co; Thu, 18 Dec 2025 05:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vWBYA-0003xv-1E
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 05:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vWBY6-0006sU-SN
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 05:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766054876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp9UhEKJ7Aa1makSg7Sp20zlDcbU41vV+Bf96yUQzM0=;
 b=chaCpu8vtcqvwqgKW7z4w+5/o3/+6f79bTJ19LgDuQ0/d+jsSB4BWxsP76wTNeey1kR6Qp
 qfiJMtTHJ8vvWRmgJu3lTtVDby+uXLI9e9W+xwyM/atOtbQw15w6yP03Qb+dIXYswriVOT
 dCpAJ3hNSXO8nQLawX9oOme7Hcd569Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-gTgjzy06PgqYTfPg6Oiy_w-1; Thu, 18 Dec 2025 05:47:55 -0500
X-MC-Unique: gTgjzy06PgqYTfPg6Oiy_w-1
X-Mimecast-MFC-AGG-ID: gTgjzy06PgqYTfPg6Oiy_w_1766054874
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43101a351c7so414231f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 02:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766054874; x=1766659674; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pp9UhEKJ7Aa1makSg7Sp20zlDcbU41vV+Bf96yUQzM0=;
 b=iwdZMHwglArtPYaepNo5Q1ujNc9ShecUtdPUlRuL5uNhhlrcHyWvbmBixGBM0blD2E
 O+5VlTgxH0AZjBtFhsJWmLd4L/UImikduFqdREZZHJC6JcQzEqXmgC7L88Vaxplb4L0E
 4v4SiDFq5YZBRX+3aP81yxTjGTpMlLt3G9E4k8YHDtKjFcBCZjkA9aD3BMbG7rhi47y3
 rxJXOcvQTivhp2M8zgrSs3LVlf8R/Df3gfU0ZAgUV6lQYs3Mxx+xVdyTvs5IgyhBH95+
 Mzw27fdr25b4PFneCAAbNmMs3clwvn5BhuhkDENTIG3V5x1RLZ0qxOQyKo6nYf/CopRz
 BK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766054874; x=1766659674;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pp9UhEKJ7Aa1makSg7Sp20zlDcbU41vV+Bf96yUQzM0=;
 b=MK49oHF89X7Zf2yXtvlVagXVBrWybbsuU+S4F175omCjo28j9K8O3Q2YkaS0WEY/iu
 unyw7BOWbLQ9bbidfkSKenl+CA5nAFB2FaxTystsPgisshKdYMZKVaZ3DoFaB6+9MkXA
 Wn9CgoXEzRuR+aA//6IbRI+q3gg3RL+pka7jdi8+zEnSoJ+1s6dHxU/4BPXKu0YZ7y0w
 Ee4y0hjgbIR/r+UxAICUFj43kzLp2r2TLxmokod61eK93vnTH7ag19t2plMOSNXbKu2A
 Ffe0IGrHuav4B98f0d2LqznUqKEL+BjoM0Q8JPVAD+m+SFKNLQXJDJJT/aY/MfqT8Onz
 k/rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGhdYR3N0zUh2n2+zBpyAduFVPyAeUSOxcc50PjVPO4o8+hsI6pyp3QvqJJaZznJkf89d+iGQdlPwD@nongnu.org
X-Gm-Message-State: AOJu0YwBvtU0+s95nxFOHL/DIWQK4KWxAKIfbk6EZ2rMA9QLSVSdyYfd
 J1rANAlKSBtBEEKsvJRnE2mtEPNQWMbHMdwJjbFbrP6Np/jHf61tZyRbkD9TPNMFjRnCVYdo1Pf
 W6JntkFvg/zU+yg4vs6yhu2t7eyFfPsVJQHx2Y2B2ELMZTGvPtLh12uS5
X-Gm-Gg: AY/fxX665g4QpTbhsfk/7i5GZgE+JKs2hzUlrEsXqhy/oh33/zHy0bwpwkjTvFBI/wm
 POe3fcAT1F/cinzFKZUnHcMdjeejuq3QJ7RfPlw9lz68dsoauFITzT7hr6Z0YGrUS5P9Ao1v57V
 CmnqpPmAOXVD+zjXWFDd576FVkemtWGx366OSbt6dvHycaJeTgmvAiLpuPgMw3//SMtekrnN/Kt
 Q0WRNydwpRjO3R07ehMhdo+FiAFBmvDiDiLsN7v/k6AjDZLC4jYRr6EdE8iHaNj2Ctrx25ois7E
 UXFi8tXIhnSz0qwKaCA3uv66lyUXLHZux5lwMfs2SAlXRo/uSxqkk6ieGWlBGjogcOWkL6g9Jnq
 vm0EF3xogXDruE25AS9M3FT5LBECf4RG6xvJ9bftfD+twSdM11w94j9ycyA==
X-Received: by 2002:a05:6000:2310:b0:431:c73:48a8 with SMTP id
 ffacd0b85a97d-4310c7349cfmr5741363f8f.29.1766054874044; 
 Thu, 18 Dec 2025 02:47:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFuywpjPrOv/NfID+cPGxbswKBxASUTRoemJwfrew+cKOcN66jSr00yj2VRvWLEsTsvRQvgw==
X-Received: by 2002:a05:6000:2310:b0:431:c73:48a8 with SMTP id
 ffacd0b85a97d-4310c7349cfmr5741323f8f.29.1766054873556; 
 Thu, 18 Dec 2025 02:47:53 -0800 (PST)
Received: from rh (p200300f6af0aa4009cef065b67c5ea88.dip0.t-ipconnect.de.
 [2003:f6:af0a:a400:9cef:65b:67c5:ea88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432449987a4sm4239256f8f.31.2025.12.18.02.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 02:47:53 -0800 (PST)
Date: Thu, 18 Dec 2025 11:47:52 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 0/2] arm: add kvm-psci-version vcpu property
In-Reply-To: <20251202160853.22560-1-sebott@redhat.com>
Message-ID: <ea9d0e28-27eb-be68-7292-780c0120f1c1@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Peter,

On Tue, 2 Dec 2025, Sebastian Ott wrote:
> This series adds a vcpu knob to request a specific PSCI version
> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>
> The use case for this is to support migration between host kernels
> that differ in their default (a.k.a. most recent) PSCI version.
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
> Alternatively we could limit support to versions >=0.2 .
>
> Changes since V3 [3]:
> * changed variable name as requested by Eric
> * added R-B
> Changes since V2 [2]:
> * fix kvm_get_psci_version() when the prop is not specified - thanks Eric!
> * removed the assertion in kvm_get_psci_version() so that this also works
>  with a future kernel/psci version
> * added R-B
> Changes since V1 [1]:
> * incorporated feedback from Peter and Eric
>
> [1] https://lore.kernel.org/kvmarm/20250911144923.24259-1-sebott@redhat.com/
> [2] https://lore.kernel.org/kvmarm/20251030165905.73295-1-sebott@redhat.com/
> [3] https://lore.kernel.org/kvmarm/20251112181357.38999-1-sebott@redhat.com/
>
> Sebastian Ott (2):
>  target/arm/kvm: add constants for new PSCI versions
>  target/arm/kvm: add kvm-psci-version vcpu property
>
> docs/system/arm/cpu-features.rst |  5 +++
> target/arm/cpu.h                 |  6 +++
> target/arm/kvm-consts.h          |  2 +
> target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
> 4 files changed, 76 insertions(+), 1 deletion(-)
>
> --

Anything else that needs to be done to get this merged?

Sebastian


