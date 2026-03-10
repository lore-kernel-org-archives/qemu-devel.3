Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7B8EB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyRT-0000SC-7h; Tue, 10 Mar 2026 10:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyRS-0000Rs-HR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:52:14 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyRR-0007eM-46
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:52:14 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso16149099d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154332; cv=none;
 d=google.com; s=arc-20240605;
 b=HmQ1Vg+Qc0ZodrQJQKMGkDfV4aNemB0tT4GWHHNEYDJgrfl9GMMTqp39sPwVHOfaR6
 sCJPW6wNTQrJZ+mpmR91cxxQpYQaYP5q+R6FdqtpwnBIvs5PZS/VSHBnRVChodGHB34P
 l1WNhBMIEGoa9q84XFivkm4ISUjeA96Z9kfTgqsDnnry2wLcRZRfKB/gnJ5sjiZxDrvf
 zJhFGBWJJdYPZnygEch22suFwlKio17GbOC6rokNH1UE1hHQcwTFJjJefBXaXBNUy9+m
 PewJSyEJtaldUu3DTWs4yi9ko/znHO58FG0RspgGz11qZnM14uj4BJdebv9Vog1KkMX2
 tE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
 fh=61hcG8LfOnpyBhAzbvYC5V7qNwnllrg2sfE1S55DUWU=;
 b=jo8Y1Kazzg21jpz6epwBNZTXXrcMI5smIla86DFYRyiJJe0gEvuMHAMX2Dp8uRLeas
 KKgfm6rFbdPzTpzX1j6PTZou+pseZIdwGoKhjzKrwComAMuXcjb5CXJzDaMa2DVautmF
 sX+cKMQuwPhcmS+zbRn9Xe7tsgfACF5nSfuNJMrEu38sWBAfPginmfYi2rmMQgRTMMno
 FV+HpWGRZ/+VSXexRg61dt2lCmiGZfcfVYz0d2mCxTcSJ70Yv4rhVfHOQ5B+jDzsAg3A
 DkkLLoYhZq/LqZjGRRG0nZycBDlebbIi/k8rKdkKMamPU6bZD8IyKJ/ZBdZ97AlfkqEm
 +apw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154332; x=1773759132; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
 b=XmYcAo+JmQ0dnagU0OH3BxzR3TUH10xI26Yj7XzI4JgX27CfOCiMUrBUj6Q/ZAgBe0
 pcNVxm+kx4KSwlAcxI3JOI7wvPcjD+cI1Z/O5nJdtp2KDGlHhMrI3xFXgdz/yqnKo0P/
 n+ZWRD6/WRZfu+cJsd2W/soDmipCszO7XZnFg8Tm1snabSZkVt1NdjhAGrr4SnmPKlDD
 +LgUrE10rbw/TDeWNG3x6aHu3O77Bes7woh4X3S00cNOMjmfma/yIv+KdcUjJdeWDaW8
 v2Alx4U7818PExQ4N79Btfq/hHwncy0WGDEqc8mQn9xnFcHpxJlO1KpfuHs+FmiAEDI2
 it6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154332; x=1773759132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJp8Hg9WBMV1JSzVZsMnHkOFsyey8WWYIm8zPWJ7FnY=;
 b=wme3sKE7k5wMRimJCroNIEzsNvoBNDO7M54L5DBUUDVORCisi9yZ3er61lGooN9l5N
 jroectgO43OoM1JzSMuLBENM3ro+0nfgWPOCQ5SE+Sjx/Oe3L6CFnem21DheqlRGpW/Q
 qVv3D6UyuEDQWGxr8QRjST26PI+BvDpeYvmjG6m2wRFRtUSz1Chp3yeBDcjLghdscO88
 uNck2vzkxXLrdpiMitlkVZ1w4+/cIyVGfEQG29jbDwTpl84cNkUZeL0xFX41/Cbyrh6Y
 SSysH1TA91s/PxnRLdJhfsLZCQKCQ1pA7AQ93PPC/kC+mu1pagz2PJQJt9E5Zdl7jWBb
 IoNA==
X-Gm-Message-State: AOJu0YzZCUMLTVNzRGDBxhuhwn8EzsMq7JZqv3Ql4W9V7wVMkOwc2PJJ
 48GF4cR6PA4fLzcs3Z6avitwR2god8bV4QP6JyUu299bnx8PuvTUYwXRzVrQpckZkv2kU7t5/eI
 z84l4/IVr1F2CGt2g8YF9om6aKqnnLhL126Gewh85vkuxbP0Q8oq6
X-Gm-Gg: ATEYQzyeYxSRytzYdy4TCWPuZGGl8/VKUkywzB5dJdQgxw1RpWagq7XMNk/2afm3pRd
 z9rv2QwYSMy2PjJ5FhWhwbqIYbVI7hyzLSzJ7UHvPh90HIuKA2oTLkVGZmUuv7Ca2WnQaI4iu8a
 mgEEkpxPSp62OI27mEB+h6P4JkP00ilnLYQ4azcd18xhVi5llpb3xwWyIUb7s2M4JJcD2K7p7pC
 yrTSLdKQATHPwyb5WiIugx9N9D2rGqK4GDDYByJ/MRqkhWsiQhBEqLkcFU0Z93NeyWBne4X0VP0
 QmiJZQP399j3nOXxYPxoQjQWkx+G8K2EyL6h4B+HZhgXpPFx0F++hflh8YRc20+Oqis=
X-Received: by 2002:a53:acc6:0:10b0:64a:d3b2:d394 with SMTP id
 956f58d0204a3-64d5a13ebeemr2693589d50.26.1773154331912; Tue, 10 Mar 2026
 07:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260310132154.2783257-1-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:52:00 +0000
X-Gm-Features: AaiRm50hzBtQP8mn_uikyElZG_YtsHGwkN8joSgiJHgdOkWuRigr8P-RtoKA4RQ
Message-ID: <CAFEAcA94vNGzmFMdMhu7835uH-N5y3M8wr-YP0zDZnLY8z8nDA@mail.gmail.com>
Subject: Re: [PULL 0/3] Firmware 20260310 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 10 Mar 2026 at 13:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:
>
>   Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20260310-pull-request
>
> for you to fetch changes up to 470ccb470b33bedede0100fdb703228a3f2683a5:
>
>   i386/sev/igvm: do not reset guest policy if IGVM does not set it (2026-03-10 14:20:41 +0100)
>
> ----------------------------------------------------------------
> - firmware.json spec update for svsm.
> - igvm bugfixes.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

