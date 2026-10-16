Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592C9CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkI5-0006YH-S6; Fri, 16 Oct 2026 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkI4-0006Y5-T6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:56:16 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkI3-0008Q7-Gl
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:56:16 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ac4806e210so769127b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166174; cv=none;
 d=google.com; s=arc-20260327;
 b=d+ATsV9Gp5xmAkv18wHbNFGvi56OozVnBDoVFOOGiSD/wDUoS9sEyKtL2iZiItsCj/
 g9sH6NEU4Y7ag0tZjw5+t1ywLFOK1CTog2GpzXz3I7kCmz8Rtk03Q0ja2oFsclyaodOR
 TBUHwXAk/uVJulHS8rsGc0tXkjud6u0zQiQSJCjLB3cJgMLy5GDLBfdfTauRw3T4yP/z
 szX8s4Z933M0UzMEoc/RTEuJAmVaD+FGZKhDzUtHsnmyenw7I9gPhRPJGzFfm/mvka9d
 d7k/rdWqlPIe6AB+BZ3OP0MCk8C1roRH9lYJxYf2Jcka4glfgYKdkhJHYgqVdfKBTzii
 kPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LyGTEQn8TvpSDs3sbo/pVW3eD0AVPEzIKc7OTWsb7K8=;
 fh=ohQc2j/NBK+yVvDZRf/rQ58voAzPNts2GPCd0Qfsx9E=;
 b=rAyQECc/nP118VBHX+nwzkYdvmJVCf2wQR3+vMnfmVzipgK123l3lEqQ3T8LabVXr6
 94o4WtbgRIafd5sUeYza2QYhVB6JojTxnUYRwMb7iW2ekASFnfzxRLv+39laXrbwCVkr
 BFmcY3z30lw9VZWb3whYfa8CSmWvQrxR1n9iDmm6a3kCXrO5XuOHUndv1RY+a93BKtyq
 xYwVxFZsXTBB5/FU0jT06uqZVNZT2tGS3K/V/bpg2U0vnqJo6lue5YSUajGrX99Q2vp5
 wnpge4xS9tJg4xarquLv7S+Fyn4amByRiksMSO0ORuP5jg9kkLTtnEgm6MgvloCorYEG
 ubSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166174; x=1792770974; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LyGTEQn8TvpSDs3sbo/pVW3eD0AVPEzIKc7OTWsb7K8=;
 b=mzCqtMJIxO+k3z8iHUMFDx+UTj7CC6jWY+ywn7OjjSyAY10Pp8Yv5iBliJCcdiGiWb
 6Y/GoNvB/iyGcBIFcJTqX2VQ7gGSObtKbigbY4QSjApY2RyLgwX79V8Hl/2jFSYVb05Y
 YL93jf2eOH88xGJY9TEsmWkucEGQtXVr3rrFx78aDKi/lc5n+c8qJFC3Bonu5/fOIqlA
 NJRlOKvtNc4DBAPejwgZ7g7vzk8v+Df3k5MLGTulUEwCI2invCzgIbOwIU3+e0wIbXRW
 p7qVJUEZEmGX2dJYKCBQOjzmn1rgX3PdgWe6apAPDLOSkC0A8+2fCsTCvfQ7OzgiGvIk
 DoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166174; x=1792770974;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LyGTEQn8TvpSDs3sbo/pVW3eD0AVPEzIKc7OTWsb7K8=;
 b=grzrGiskeIuJiPrLYnPXEM+ZzjLNLiU9tMy3HKiodc9AQ/3z87e3Jpe+VrA7UlroRL
 C2JgEsD2OcejVINzaaexviVY31hNmvYmT5RTajwJuo4Obyj1NOue2TjdiL42G9/41HK2
 6YjHJ3YuyUQ4ZcF4W4/U5XjbDiTKlGYXeuPavbsaSgDmsRKeyFUQNetpno7W/T/Uh83e
 wbVpBpNOrTXNIWNpW6EFhxT9xp3oGdL1gWYXcf/SwUduWhDSktQM+jXryShOqWXgHfQ4
 2HRIu5JaPR2kFL2ba//A7cvTkDBzMmHgG5boKh7z0VPDuZJ8Px9N7+Kb50Dwt5Zcuyty
 nduw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1cP6uxcZHC4QtycgG1jP952hp5ijy1VMER/1XPvIxAGhuKquXZJkYkcoJWdDBY3hQ/k85SF+M8dMA@nongnu.org
X-Gm-Message-State: AFq9FYKc+5VmFbhOR45Lkx08aPXZwgaOBF8ocYSmw/W64rKewraQ9USU
 5snJduwV25DIpW7T6+AV9WYHX0WN41bEWq1gi7mt+qnGI2f/yMeTJg0ecq4apWNjvf3xfpzH2JI
 Zsf949m+8epyhejg7zra1Gz6N9AAjKfWQDQ5l2gAiwQ==
X-Gm-Gg: AYBFou3hTBvWfSVQyyL5mGcMUMlkkmvH+zUB+VfkvEDSfM8DLIe88EnndOBmwi7rfW8
 x/v12w099lQVQgubXgRc3OlBdjG6k1kL3GT1hRJxlGMFwu0nQJizDrlPl65CVAJP8lnIHlPbE4A
 r+s8Ry60L13zM0GOSIM3DqX1VeU+TJWzZ6XZsNrfbDQ24Ym6NO7jTOCGVj4Wa5dSErbtjkULEA+
 F8stZCjANuaOa5KjFCnGD4HkY0ZXs6E8JKC4FdUtqoRKaWTBWsPZr/tUb6JPHqBftcQc7xGUt1P
 rRFQurWF7/ctZw7qJUg29d3+CwfW+4A4knvrUAa4L2/3i5dS5+ioy0gmrJwmzEGDJ6J2jdyp9vH
 yPTzc0nG2B3MmhXh0HXcXiSwEhJfGyBH2ezp/llLukhwN47mDZQ==
X-Received: by 2002:a05:690c:4d84:b0:8b0:8a9c:fac9 with SMTP id
 00721157ae682-8b0f2170e34mr1713327b3.28.1792166174293; Fri, 16 Oct 2026
 08:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-7-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-7-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:56:02 +0100
X-Gm-Features: AclHuK9MHRDi7s52R0estk1KzgTugvCrprtO3xo5sNZ623bTnalBpp4C5HsLsLA
Message-ID: <CAFEAcA_X3PV8qM-ELPJqcB3tJ2W613Hfjpff3-zU9Xk469MsnA@mail.gmail.com>
Subject: Re: [PATCH v2 06/27] i8259.c: introduce TYPE_I8259 device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 16 Oct 2026 at 15:21, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents a single emulated 8259 PIC and its associated class and
> ensures that we can safely embed the device within a container device.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

