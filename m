Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E428106ACD8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kNH-0003QZ-6H; Thu, 12 Mar 2026 14:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kNE-0003QB-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:03:04 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kNB-0003Ea-Q6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:03:03 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9fcc24b3so1209326d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773338580; cv=none;
 d=google.com; s=arc-20240605;
 b=WKNq3uwJ4+so78Z1cIlRICMjigg9e91FQJ67lqQgG8ja28jGG0KWWCXWVGgDlHFhxB
 7IyX0BWUcP338kgSZftbQHSktXCHpFhORUiKs/dcB5qt+QjfREylVOXR3hpnxN2oW/df
 pjuxtrFCYol9XbvyTdzdPkoVCcKOJxRI+rsaE3kW/us6yVQop2wcQkn0OTqZX2XBQX6D
 hWyR49hcEGtp9ankZi9o/T9yI13KFBxL+/iZ2gKvnJPx48DOiLGRIhy5yCnVf6Ji4xFp
 UPSvdVFrndo7H43AvvKZiNm3622avj8Ww7DZW2jWvpUHZS47E4cKG3xYl4ZxQT3d1AQL
 hBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IGgzDuf+wujYqBEUZ5wAtVUG7/BOWtO6DrMdfJp5hls=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=k2Vk6hBG6y/q+te1Jlm+G2ugI+K5GYdcDIWHlgsRbitjZzg06gNLhuNMOS/N/vdyaQ
 vbPDwcliq3cTTZyiIzUqTSVoKBBAvpE0OStzcdrZSXLhwvXahZ4JyNAlD5mT63wgpXWZ
 bOU+M9gFl8YVOM1IIwEMlb2aShJtBTXpx6n57Z/FczW1nBZqNZxAqFO5ouzQJ97zsC+C
 81wry7YU96QlMgjqZLlVPJ54UdUBe/4EHuL6cgpJs2SZh7ExYOZccUOIJB+FuKfBbuC8
 ZlarNVJrdJN8BKNUmM5D8owwgKsnEcnudEw5DWmx4EMKPVg/6JUo88OLspR1/scDHwvF
 WZiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773338580; x=1773943380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IGgzDuf+wujYqBEUZ5wAtVUG7/BOWtO6DrMdfJp5hls=;
 b=ppJ5pxXSx3/M9szfA7FDFExAE1rO0lW1aWVt/qq7f0M+hpfaLhNuH+sJnjvdqnwtYV
 Wo51ToL0QY/vrJ4EnbhAsyJ0Opxd1ZsPKqo5zxBGlu2M2HR855VC3gBxlYz46hmxGvcc
 08GuQslSD17FX+NQdeqkTE0i8ZwR6VLWgQYb/AS1LgXYFVqtObUocaI794Ec1zq9uYdx
 j6A/HQ610UcA/+qrYiaAEOXpoCxNaV3CDXDqE+qCwXVS9kQMXYYV5Ztk0qS3u9PV888t
 qemq7Y50qPOX2PTFqa0QZrr6zh/QmMF5vPFR/jCrw4wiz+0tQdNjW/wRe6CXErgP83h+
 07DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773338580; x=1773943380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGgzDuf+wujYqBEUZ5wAtVUG7/BOWtO6DrMdfJp5hls=;
 b=sl6isyyiQRl4DmvcH64EB/ITpfHSWFOw2Aax65TjiJaYC4R+1v4w/sKh6BNMj7fIRn
 utoZmN/dGMBFZAa7+iEG/sa8sIHi4WOE8s94z4jtfI/ZjRuZNn2yHTGMUki+N4oUGN7o
 oSGDNQQUMCjKyoEf/j7/jGJOxVVBy4COwqA8loC11YsKQqH8FRswRImx0OcWZMttXcKJ
 W7zoNlVvdD0yS46tkE8Pi6w9CeAMhu1UHqfYukLw62Xd9iNA3jZ+P521H/GCa3NRzWMr
 5yW5CVdy9vi62x4feF8U1GHQVUrfU3d/R5Ft8bAkf4+S8OXk376msKXlK5YhwtQbAaXM
 pQJw==
X-Gm-Message-State: AOJu0YwdQXYddmPf18UAALOSMm9hXKjgysq3f4U8U55/eXvpFiy9NQJY
 QwvbzZZOIwtFoLoSvbCPOK3J9dfHKHWs4R+L9EuKNSo0k4sWGXKofJsPn01kPPUaB8oxs1dR91d
 LRLnOYnBMo/G14Ov31R/Qv1h/HBX63j4wuJmBYtfZM9R3r8HWNYb3
X-Gm-Gg: ATEYQzzOP4JyL5mAcsc2d1n1G/96sJwOYI24Z2lbYlsXhGTbgXcYTkj8dhBq51uzNje
 nxM+M0kkQOeGcdfD2fZUsWEmLjzUEoNZmAadyiwwRKalbXQeDoTKcp2ss8jULG3ZSXgAB3ks0Kn
 Ocs+yRb12+Mi55jksu5F66uIMOKJIefZJaBf/8CC6/ey1mOBSOrtMx7ZT0QLEMUqTOOzF/648md
 aORcP44/66PVGwVcPm16KklD34QOtxI8uIiynN88DXbIi5mLVieI1AaxfY1D2SXJ3LuoE9AN+OO
 MvZrSsywn6m6lYe3/Fk7IxE7D5pNVi5itkaQQao0pUCFN7FY+fXxEL11Kzhgbb6whbs=
X-Received: by 2002:a05:690e:4319:b0:64d:294e:990e with SMTP id
 956f58d0204a3-64e630ec377mr333872d50.87.1773338580220; Thu, 12 Mar 2026
 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260312110451.685161-1-pbonzini@redhat.com>
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:02:48 +0000
X-Gm-Features: AaiRm52UZ46-iKzyiCXzD7ayLW_JPt2PgYbFRFbqtepRgkhREMXRfdJrpJ0L2Wc
Message-ID: <CAFEAcA_hbk-=4socdMK3twKAEkCdY6sTrgD7bSkZ0zjpogfc7A@mail.gmail.com>
Subject: Re: [PULL 00/14] Misc patches for QEMU 11.0 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 12 Mar 2026 at 11:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to c725a896c6b92f733e0eeb236167cbd9b33efda8:
>
>   typedefs: move QIgvm out of typedefs.h (2026-03-12 12:02:55 +0100)
>
> ----------------------------------------------------------------
> * accel/kvm: fix typo in variable name
> * system: fix coverity issues related to confidential guest reset
> * target/i386: add compat for migrating error code
> * docs fixes
> * hyperv/syndbg: check length returned by cpu_physical_memory_map()
> * typedefs: move QIgvm out of typedefs.h
> * rust: Update Cargo.lock
> * i386/cpu: cleanups for ClearwaterForest, AMX and more
>




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

