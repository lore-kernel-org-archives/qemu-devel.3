Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC380EC1432
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNry-0005Bc-Re; Tue, 03 Mar 2026 06:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNrv-00058E-V5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:24:51 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNrq-0005tu-52
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:24:48 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64cb577e79cso5554708d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537082; cv=none;
 d=google.com; s=arc-20240605;
 b=dtIcrsz3fGt3agV/SWPR1haAl/93iO+k2WbUn7AJGuIuTuQ48VxAdJFrAzDGfWkJAB
 b9JwD0HZywNUpT2JZCWNqEBPiqk27xxok1poZ3pf594n4G1p4/p+Ah1sMOPYrcYWlIIP
 pOmOEw5P1BUR0A6NHV1BcqUAvdTBBu00mzN8ZHfW/Vnzrtl6U9PSTErDXuzjmCGRXFNt
 2M0N/TN5CtYnIIc5/BFEPAk+wXxUbnSXkFQ9teCGJrrJCFajgtNlzQbd5Xs3GaBRpppX
 AEACwMT3NXK7buR3WOa6YhEeWifcGXhA4qeOuGz14wxF3BfZbMv5uzjD34SjAx2pSvRw
 9MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zhG3lYnK8prcsi7F0qfSX28vrAi9TRvqJXR8s+2eSKI=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=CtdUUx1byGultlDuDJFUlzjIqg7x3WBnArPL9s6s7Fo9JttlXQ7LS/kpXpHYPt/Qiw
 5u1oCdDn/ohF6OO0LFrrXOawgg1CZ5SfNGPIelUdFNJf/R7foemRgcOZatWnGLTJtzko
 shZU7SVqlXS271yK2KicySu1iTjv9jbgAX5HOKT4n0x4efNXTDIw2UVVVoQjVbDGwRVX
 swbl45B5YpTuhlxCLpR6WbN/n2lljyRD7WeenZt4EIfimgLj1Awtbw/pMTfRTTnJpUAk
 Rpsj6irXcQCcTz1kbVvgTJqNnNoF1rUUo3uytNVkYTr+SbAIOPb5tlSCtpY+ZnTBwNt2
 UoIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537082; x=1773141882; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zhG3lYnK8prcsi7F0qfSX28vrAi9TRvqJXR8s+2eSKI=;
 b=XT+A1tx7tzFraN+5lWuejEuAgAQI1joo82zgs1vm3vbAeAVWMEimmVY0NYL2Ribzl+
 tonqEIJTel7og1w+MfplTC3IqAGNRyqULF7ZTmD/MiC8O8fn1HQ12t5S+E0vO9EzIOxg
 WK/xVfWss6WxrUY2/wcrGXQM4zmMPUtxtMMAmbOhhpE4jT8AeVB3O45VEbEebfBlX/rI
 0eJes7eUAoaojSaaOtprJlA86uBn5My2Xo7mJQ3JEiy/NXzWDvPGpsK0FeguH5t3et8J
 6xuLLSHFnY3rkDS5AJyL2EinidojMuVg/SdFm51M/dkPc8noW/U4jf7K3JLYBM+tX6Ke
 hZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537082; x=1773141882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhG3lYnK8prcsi7F0qfSX28vrAi9TRvqJXR8s+2eSKI=;
 b=JaqjHGIg4xRcXY0WqtpkNs97L1P2ZAKS0TPgmjXvQgebaqOTY9GqFpOQ+LVzn6m6e6
 ealFSf+XBGE75T2d6rS6Vdj3kaX8kZoRz59lWFmnLN1d/7FtrkR/rRbmQtMmZrtSZY3y
 46pxu7FgIavKNTC6iwS19Eoq3v1PgcmvMOBjKFOtiGG+QanAxs/33z73dyN7pwOjxGyB
 TX7iW8Cc82OE54Vdj0fGxUHTOdyN/IAZfqC1tGLLkN1xLeuUn7O+iADDhgDPctD2Zsyn
 qOu0tSa6AJ8e7WL53Y4qU4Av2T4qh8k3cYJ2tTyghTCFyML6wE82WdX0/vQ9SH+Q5JQT
 FDoQ==
X-Gm-Message-State: AOJu0YzsfKfpF4LxNZjBOj1YUhuqiVXoa1HNsqlfNPlfNbOeuApqv9p2
 KISWo9hhsbWMn83nYBPUk1qKdQQm+/eLMvQT2HFeBR+MhmAKZZ57E2i8OAjr3LYyGmgen6DgjNH
 2XMxS10yzFesaniiAuh1uF9EQX/5+heaYMgcIEUhr3A==
X-Gm-Gg: ATEYQzzOd14ikFPUrvLyH1svHUNMDcPhfiW0nL1B3JptnbkPxmXTMPU6lAzgH+Z2Lha
 1P/sus1mrUEeAS949NTPKh4NhbtZxzFnZ/7YQZzoztlOyJIgS10a8bTIC9cxRrTTLfpwHMh0W9t
 YRgYSxroAIdVWr2SRdUBwtQJycBB0gG2EPbcmotFPT79Y6GP4tQqpxiqSb/GOqE0Ak6FPNHHnu8
 y/UTwZKuUC6amoqfi000610MU70GDrB6YU3o1lgNcB0jyHUO1uPVYIHTxBPVpDktL2Vs3xd4RVh
 dUKKldL5fqTf7azXQZGVZGuM0I0xrfvno9fw1Kk6c6UryEXVxr7Iwz2MjWqdjNzVe5A=
X-Received: by 2002:a53:ee50:0:b0:64c:9fd7:676a with SMTP id
 956f58d0204a3-64cc232ff88mr9551234d50.83.1772537081841; Tue, 03 Mar 2026
 03:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-3-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:24:30 +0000
X-Gm-Features: AaiRm53LIb7RBQx4Dg__eBLCxG62Y9LFnIFLhHGYRErqmRo5b5dg2rPrrxBWhHE
Message-ID: <CAFEAcA_fPRxPdcGtTKG1Pj7rw5XeSK+mnrnh9oK5Xhou=LoVNQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] hw/char/serial: Remove explicit cast from void
 pointer
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> A void pointer asks for being casted, so C allows for omitting the
> explicit cast. Take advantage of that.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

