Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B5FD462A1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 13:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBDhM-0006LD-0R; Wed, 13 Nov 2024 08:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBDhJ-0006Kx-Qd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:46:17 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBDhI-0003fy-50
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:46:17 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb587d0436so67829191fa.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731505574; x=1732110374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePSfgP6RRPRT4c0wWlQAK6C/pDg9dpnmzIJjXUYL4wE=;
 b=CBQ0TjOvg8L5u5wkaWwy4xF9WNTHdbpn8Ri7q/qEBQgBhzj7dEDZ4XP1lF6qToTi/8
 do3OosJDeqtQuPscL8KRWKTIDY526dX8f5UWc9Smv1UL1jHRAoTvEa8VfEa8oiixePJ+
 X6ab0ZsfdNph3Qs3lrWH4CM29FGEOTT9CQiO1/ihKKQi5ki8DY5vbDKnGDkoQU6wQe7/
 h1yWi4X4RSHd/3yM6unWxsrlw2OoHMEyeI7pXCtYEyS9XQJN8vxLJ1rTnUFhu+7ohIIQ
 QKg8K0DCTGO7F4f3Xdp1wOiZZHgLFJm3LhwrAtegb9qi+tbcCBAy0Qanf6meHhgph28E
 sBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505574; x=1732110374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePSfgP6RRPRT4c0wWlQAK6C/pDg9dpnmzIJjXUYL4wE=;
 b=LxIkLAwdpuqBuLcKpdhWfjPe8RRUYrPzg/o6EiRQRkMk2WUBer7rxVYW7ZXwNC2BmX
 RB4ssIjBBeulNdFM2zsGTWnLFDcTlIGBO+7bfcdQ0srU5tcm1SZjcHK+ZyhWDNpt/LGN
 SAfTbNP1jZDBa/YfSXx7mxeuD3NA3p0TjF5ogPP3rwRgrkQmQHGwJNv636zuvr5ptK0f
 1OgbNmPmRmtzx5187RQO4SIIN6L0q/jSV2KvAATVSKZh/xAUezEzFQItY8/qWbDv/Jhx
 yI2XHPPIRkhw3a5PotVrE8kGhF18LyvVDyc+s13sD/1JgnehxUxkRipNImFZNiQPeUnk
 jQpQ==
X-Gm-Message-State: AOJu0Yya0t2RC0BGX8KprrRo+Uy3/43zsQTse1FSLnz2VPdb2+v4NIIN
 ybPHm7jfJPxw6y5ttTz6SlLMyLFz4DuKa0z2YZrxPN9CD04aOcTW66aeJzjbE5s0Ji4t+ZBxxEw
 BbAGx2D0IF6FA4Q2FW+8Qljqf2KpgqStQGveOvQ==
X-Google-Smtp-Source: AGHT+IG0DKaI5y7bDA81TzXpj+6aeB3ElFenRpthIy99PWMspqPb/ohqb4zcVKugFXsieGwdCXks0WBmtHcffDIB2o8=
X-Received: by 2002:a05:651c:991:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2ff202230e0mr113256551fa.28.1731505573536; Wed, 13 Nov 2024
 05:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20241109073555.162151-1-pbonzini@redhat.com>
In-Reply-To: <20241109073555.162151-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2024 13:46:02 +0000
Message-ID: <CAFEAcA-gUUyjSSqtoxsnu4ZGh2FG2YAOBMNPqxz_Z2bXB5m49g@mail.gmail.com>
Subject: Re: [PULL v2 00/13] (Almost entirely) bugfix changes for QEMU 9.2
 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Sat, 9 Nov 2024 at 07:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a1dacb66915eb7d08a0596cc97068a37c39930d3:
>
>   Merge tag 'for-upstream-rust' of https://gitlab.com/bonzini/qemu into staging (2024-11-06 21:27:47 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bd0e501e1a4813fa36a4cf9842aaf430323a03c3:
>
>   hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus (2024-11-09 08:34:07 +0100)
>
> ----------------------------------------------------------------
> * i386: fix -M isapc with ubsan
> * i386: add sha512, sm3, sm4 feature bits
> * eif: fix Coverity issues
> * i386/hvf: x2APIC support
> * i386/hvf: fixes
> * i386/tcg: fix 2-stage page walk
> * eif: fix coverity issues
> * rust: fix subproject warnings with new rust, avoid useless cmake fallback
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

