Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B8FEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjil-0000Qh-Uj; Tue, 10 Feb 2026 04:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjik-0000QY-K4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:07:46 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjii-0004Mn-Sb
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:07:46 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7927b1620ddso77008287b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770714462; cv=none;
 d=google.com; s=arc-20240605;
 b=LbXt7goQnrA6C2/pzD0XA8K7tTd3/n14jitUCW6TIjWDy/OIDuahAQMHcr+7TGd+EY
 y+1jKREGCox9U9w5eOzSpi2oZvzuDbSJwr/FJCSpnUKdCHVz8va7yAnA2VxBLyXmeD3+
 MwI2W8NfDDrt4mvmvBP1RcoAgGckrkwt7pnv27x50T/rGNlFfyihFg3fXzDORi46D+zQ
 HNU4auCGH2+B+BolgCQZEq2i0RZe9A90DFm+GvPKjG1eBC/dCrzWPNrImx14WO+cBzMS
 ifJTNUZbBuTLjtdZ30hgbVkkEoZrQKWVo6eAixEImH3okqDvXFydUQib0Qap5/AGBM1u
 0W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3mq9EjrxKMKFRmU5AHgJ3N0ycAHzAGLaifnDxjvVKU0=;
 fh=XWOOdLlTvjtv4bd9g+msdGDFgk8NOFxzbBqQ6mqRtFU=;
 b=A75ZpLXndizDxXf35klBiDvGm7r8vBL49dA5Y4l7V9BXihIjYMweeqyDyogXXmoKR8
 hGTO2SH4n8RCVrlICGWs4UwTMPnkQTYQvpNHc1IC73at+SC7sBinXIKxK2HUWkvor4dw
 RnP0oLJPG5kq3epsLuWYtZ2Fyi8TkNrhnM4FmnOYETOqgbqKTXBYCGleudUp4uvbrt3b
 gUEaoU2bNPGus6TfdaJBHnyivAChVxeE5oVNRAOqxaIWXuJaBqi35AXPIdhIjTTDIOsq
 45ytbc9ej1tWYUMK8pcyqN/ese/MLim0wqKol5XH3kzsXC2yjS6tEZmj+CPma10xKx3i
 Tvlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770714462; x=1771319262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3mq9EjrxKMKFRmU5AHgJ3N0ycAHzAGLaifnDxjvVKU0=;
 b=d1mP9bsTCUH5ar2sVrUZjTTVTiaay3P308ZOCjrkJiElUBUAC3dCKfWoTJzSO4CpuS
 BvxUZLYjO6dg/jG7oyJLJEJ4z0VenceMG6AmTeZbyBXF5Gr3tTqZAyuu6EBN77V9AycR
 VctPYy9bYo/YfGT190Cc54TNEBzQh7JhIZTpcEFAArfZOUEF43+xXsQC8yo8P3GpDa1X
 y9uQZAoT9CvDjXj+NfPVJSt03Pirs4RQf8CfIEQ5PGvQnrxHNs7HADl3dZZNo1FgYeKp
 RyQnSfWwiaaGQR2FIrahY4eNkGFnVbmswZ71uIMwz313RpvSpjyMQERpKpYqDuyw5D2V
 A7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770714462; x=1771319262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mq9EjrxKMKFRmU5AHgJ3N0ycAHzAGLaifnDxjvVKU0=;
 b=awyNuRWE153f4Q0dr+9QsnWvS7IryNwedPxidxRd7d0/AptYPeCv87h7fMda3ko6LG
 +iDIEu8ZfGc/nNM2NpQLY45DhZZ1j4f4RUD9va3uqxO74YH2EdQaqIfCAUGzCSlvrb+e
 rWl5BRcnjPNgThhlkRiMvNC7IlijTT3sH8grkatRqKtrIHhkNe/GI6+rHPbPBNDdEMsZ
 hQ5q+UgKKtU6eHNtRpiieKrEL0ynEh9pkClOGBdXzSi3hXJM6W8jPT4do7BdoobwBiGP
 9+RGGDrzjZa+wwxdH0b5dK7SnDA1ktOLyzGpal1ilWaFoLbcTFWG1WAqhgnUrT/RATLL
 ws3A==
X-Gm-Message-State: AOJu0YxUU5ge9UcbkbBqbg6nQe4SD32GX3rkdCxYb371ncYSpB95uFb0
 lUWLcgUsAylBXOqqv7ADD48qtxdYi7ghPEeh6qD7J+YQtuqXP2O/ODxhmBJ75KyvxsQzS6NoAdK
 fLAs+u+sVxVaO5wBNI8dMayNflCAR3nOPKHSTePXsMQ==
X-Gm-Gg: AZuq6aKy2vYWRZORssnal+hDNkh1pV1z9uxZZiz7xvKT04U1NzGJ/TX0MgLU4DO99T6
 Viv0kPpwTu/EWnkmWDDDbSSRbicuJdat4Z53NVYgO2XwmZQl8lGU5pyBKnVfDVZsUYM1UcPdfBK
 FPhej8o1jSLG8BIaLvI8xfcGM3UF7Mc3BRqogIsW5KrBhcnma23qgH1RjFTfmOzaRHn+WKMz7uN
 sfajlIeUFJZ05uworr228ouJ9cu1c8rY9yk4af7/P54QMxoNhlP6WqQPVj1NtSDygpD8XmN/gHy
 XSAXcVB9QU9AK5t1iEC70+gm/IozRSvLrcp57EsFuufXwmBCLLZOl7MiaBMxUDvLb43VcFWBxlP
 dCw==
X-Received: by 2002:a05:690c:6306:b0:795:6e1:3751 with SMTP id
 00721157ae682-7965e525c1bmr13426877b3.9.1770714462495; Tue, 10 Feb 2026
 01:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20260209001836.5413F5969F2@zero.eik.bme.hu>
In-Reply-To: <20260209001836.5413F5969F2@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 09:07:30 +0000
X-Gm-Features: AZwV_QhTbtD4WmN_gRAkpmsH3xYX9Ak_jcNWXUDRvb2iZXWAJQIDiqmcWviHz8A
Message-ID: <CAFEAcA-HwiOfh6sXa3OvFtrMotoaEpB9ZoLXq_5aXDoVqh8wqA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 9 Feb 2026 at 00:19, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> According to specification 6.5.6 FrameNumberOverflow Event when bit 15
> of frame count changes (either from 1 to 0 or 0 to 1) a
> FrameNumberOverflow interrupt should be generated.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Is this a bug fix for some specific problem (e.g. it fixes
handling for some guest OS)? If so, we should say what it's
fixing in the commit message, so that if we ever come back
to this in future we know what we need to test to make sure
we don't re-break it.

thanks
-- PMM

