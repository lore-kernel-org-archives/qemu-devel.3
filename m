Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E188CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL47-00050a-Tj; Thu, 15 Oct 2026 09:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL3w-0004yp-69
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:00:01 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL3s-0002Hj-S2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:59:59 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b0cf2c0785so12598287b3.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792069195; cv=none;
 d=google.com; s=arc-20260327;
 b=gbcQqGiF3AAsT6ERnPnKSR/ajOvTtCeX6QbC5tbpW8uXI6yA2ocOHmge+9HamCrJlh
 fWLqnTDwhuseSgTqOFXFrRz73NcUOW2MLuRKkOYRdAMtGRLy8+DVsocZqhbnK6oH3NcL
 C6Hb5I69CBLiVD/O3T9zZ1wveT0cjz/111ArSxsd+8azqj3CYGVam5Hp2CKr3H3eaAnp
 h7s0/MBmNBuq3uzIiP62geOV9SDTRYW3PSxGn9pnEPHg9b9qQ1juPBodEe+dqHY0P1Ol
 SPVVaXnN+FLHv36bj3wpyP2HtB35J/YAn+TiOxQvWqbmcYF5ImYYuwjRAiIUZGdoalgC
 JmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bG+JBl5qKwa2XHa8u01oWs7LWmC2tmAkrm4gc//FRQM=;
 fh=VE+fSPwns4P0qLilbUMaglgxe5Il5vV69hoBMwU8/p0=;
 b=YK2Bv9nzlDZi3Fu3gkgGyu387Xfy5quu4QaXBdbA3i3JAhL3UpAz99j0Y1ZKRk2V8W
 l1O3CYYvrKhBeguU2z0jbT15Q5NlopuYD4eZzIBykbhGbrBlWqRXpycLFvRXDC82HVpU
 fiD5bxbKDyxQoX8Q8Ju9/IZ9EIelUTlVBwgMOS1eY6mqj48jXoxRTpDUPCgQM5Wid2QD
 6OUaLN/Uwgq5cBPejEGjrkxAv/pxIwWet/m7/WB33F4/Z679xYdmbmjos4Zvzb9KMoXr
 4LkJfImvQQlL4zAQgcePQqKHNBnH0wqYArQsUseUGhQnOIlVNdPBksTqMCkE/0+bFW/X
 ljbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069195; x=1792673995; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bG+JBl5qKwa2XHa8u01oWs7LWmC2tmAkrm4gc//FRQM=;
 b=gft6rRPWg1KSTUVQFysUqtOYZprrRTHRcJveSlSjfrQ9rop0RlxJMu3bXCPguFsX0b
 KjkyewE2yM4zBHTny8H9abcYexReSn6kS0upsdeNzs+z0ael+c22izNb1QEVf1gEyfOs
 sKqDlQEoUEFwqb947B1bJQyBnuHDx9MdohnvGGjVrMKC166FUueCE1Ne7dzkP44puoTO
 HP6FidOvnlh36oETe65MhpYsBuTWyfHwtwtGQAr3Dlj8IXvacVorLbeSm8wGGBqXNZE1
 zU/yc8hSNUKIDS6XECZgfLK0YhMSWk84TyjVDzVGi8/6TZnCGoLH6JTD3pEo8N7g/RFg
 kqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069195; x=1792673995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bG+JBl5qKwa2XHa8u01oWs7LWmC2tmAkrm4gc//FRQM=;
 b=mri5J4Ugrz0/9IgT0CFnDYnLNxnHEWyi/FPViHZMpPLh/U6dFkyxiR4kYljUl3ZYMh
 SVWZ65/9wNtvSjPd7RBgc+b5Cm9y93ayICwnS1TlO0a0Vz/HvdBdPdJJOejevUnKKGBF
 hS0YsQAJ0YYOZBgQGAjowJKK1FqSTWR1yKbSRQdkcupAzPrCi73guI72+gUjLG8yNG8Y
 yl9v334PBmQurlMQjqWIlpBtvGd3lUdHIFEmtaiGep6wqprBORDNcMEmamLYQIppWuh9
 3e33LLjsC4RMFbfYTCYsfpX2xe0xMe99WxJniNrDN87tKnTapwUFlF6mT+CgC1RIGppY
 b8Cg==
X-Gm-Message-State: AFq9FYKR5ZWPuoXtnqg7LKpkap03/wWZ/WY4e5So12VjlIefDGHKPrKZ
 5Nx6FAu+ouRQ6gui89a0g9sM49+AnGsdoB3gpogjscOWltsr87ZDC/1CfbKwHDjJfK2SMkVG0zK
 o8Z7drZ7pWOcrfSe+JWzMaq0VvHWUXJEKxup4Bb9Crw==
X-Gm-Gg: AYBFou1wlIsM4pgaKYktIRQDShXuU9IxVTbXD8XgiHxn7LxRDKv+lqYi5NJX4aohhZz
 Wd/R8fHV5GJTJ5DL7d0KKSeoGFMvnukUN/dkGsOW0nV4iSwwlPXDcwEIGaKw7IlU17aGM7VCQTu
 O87WDMTE96iq79IlTlELV65SvJq1opozg63PCxSCSBrXEyiZOfhRBSO8sMWDcWsJd+QOT4OSR7n
 Txd1TOXt9oKnKSjviLS1WWzEiP7Y/qBYtbxGKDHTvsBsfSC5TzqzBuGCD7K6BjDs+cQ11f65WOr
 rwOxQuuRg52n/rnrGrh1Lv3uGuUGFuXfmhvA2UuwfasShbWc1yLvKXnUstfJwEQNfw3EGdLQPnM
 mF5TACiMSGfmNyvyCxaDzcU03VIWdGYt5qeN7fm0=
X-Received: by 2002:a05:690c:ec5:b0:8ab:447c:b159 with SMTP id
 00721157ae682-8b07edf2767mr63205287b3.94.1792069195357; Thu, 15 Oct 2026
 05:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260725012635.4925-4-marcelomanzo@gmail.com>
In-Reply-To: <20260725012635.4925-4-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 13:59:43 +0100
X-Gm-Features: AclHuK8P-x-1z0Vijq_iKVo2E7aSWPYqsDlcSoRnEh9htqAdWMT6zRtSdHMDLk4
Message-ID: <CAFEAcA_6a4=spy4KJV7Otd-sKde4sKP6brW+dXtUgLMwm6hHWg@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/misc/bcm2838_thermal: add BCM2838 thermal sensor
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 25 Jul 2026 at 02:26, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add a dummy BCM2838 (BCM2711/Raspberry Pi 4B) thermal sensor: a
> single status register that always reports a fixed 25C reading with
> both "valid" bits set. Real hardware reports live temperature; a
> fixed reading is enough for guests that just probe the sensor and
> read it, without modeling actual thermal behavior.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
> series 829638, posted to qemu-devel in 2024, never merged). Ported
> to current master by Marcelo Manzo: header paths moved under
> hw/core/, class_init()'s const void *data. No functional change
> otherwise (this device has no reset or migration state to begin
> with).
>
> Boot-tested: guest's thermal_zone0/temp reports 25310 (25.31C),
> matching the fixed reading this device returns.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

