Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D9FEFB61
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzyK-0007gY-BP; Fri, 27 Feb 2026 10:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzyI-0007g9-Rl
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:41:42 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzyH-0001AT-5r
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:41:42 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79df972so2428006d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772206899; cv=none;
 d=google.com; s=arc-20240605;
 b=F8yvfTiYRqNsNPPiV2JW3oO5sPjSCIVMR0xwFU7unkfnsbPJisVfG7ytYty3ujWgSk
 3oceJD4cI9X3cnNn6EERA/M1QdPfkLWS9RDXaZdTqCb74o/xxRO/X7HmJwcXAU2ycipB
 /KfNsodFN5FfyYL3/gGi+RzN/BZ3WF5xSCUirQc1Uo+C2td4IPWVkS+eSUsFNSoeE8FP
 +lyA8gNSg3qpuzLN3CWPEhW5Nlv93dfekeOKS3TZ2N1k12hY0pSF1U11XN6rFUO3H+7n
 C8Fyc5NHLDQlrydl2a3X9P+Ag1Emi9vQKcxdHf9/zN9jKwit6vcgLjCLVVhNJ5akFs39
 eEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sdhfb2hbydWQTQXwnX9sfwR4aytZTPxQ9Ec0YgcPDFc=;
 fh=305ByrI4MiawRuxmEuO2VeWT9Uic1fF/eg7hArgjZks=;
 b=Q1p8s8MExe0zOwS6tI2ROqVOhSsbpNdfUubYyQnq9ouiq4laEWPgZiwo+4ZnxQ69sq
 dCwO4/qqj/XOxVy1DC2SsdtLTCRK0A7HTgdanLF3SsQ+BH22LkzTu60BXtsiktT2wVSW
 hDNesjQRZteB47doc27vwUOwNQ3DSpVp0rEsyG4AnNS+MVa7I8hb8BhZwOi3k3XYHjXe
 z0iQFY3WyD5tueYhxLFYioEC1gtA4lIlC3Yby75X1T3UQNX0JmhuoYbt48ASKTI5qR7t
 zJK8s88kDpCTylPEPmtT6FvZR9opiFQxdSPqGq4vBewAW3VC1bQ40SxDNQPzNez/EOdX
 6GhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772206899; x=1772811699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sdhfb2hbydWQTQXwnX9sfwR4aytZTPxQ9Ec0YgcPDFc=;
 b=uWG8lfhD93/ETVWny9xkjIOEWLzvrHMqfIbR7hmZWpNo0+OvRpNj9m6CNRpG0+Ji4M
 dFj4vZhau3EQcIKpKPJeiv25JwsvbmCrkiJoxxlJYZ//pTWyNIgekJZBaSyFUpsNAYdO
 oXcQfHs0XBrHRi4h4txTUeqwO4Jfeb55mq3nfT2sjiO12RY0v92MeU0YyxodMAm8uDM7
 +CFbqu3INhSF6RTGOruaBxGAtE/PsuW/bX/ak+UaxrmUl8oEWj3e1X25mrNeBZ5L1Hmd
 D0cffOI9zzNwiRfUl/lObSSI6JdHHk5/t0gxewA7nSDogT8ESbD1tfkvD22I/8WY/+VL
 KL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772206899; x=1772811699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdhfb2hbydWQTQXwnX9sfwR4aytZTPxQ9Ec0YgcPDFc=;
 b=i7NWQNk/kqN1str9Mjl8Z39hJOkZ/GdK4EN4NLCRGD8i9g+cya2TMeqb5+UEP+tVRg
 JwixW71mWQbG61+MeHzTv6CzHRg8Iy/vJNnYJKqbmo47eLWc209mnyVi7DL/tUsm9EgX
 GoZ1IPX4RBJD0U2MCA0QvutJ7HtKbqLklOI6c23csF8vIOc19lOdCEIheOLEheh9CvDH
 dCnuIdWSLqSOR9JWu/fbGxL5maaSlo+8kPFLSyHMmaZ8sNzLVbstnaD9fWvxkyjCakZY
 dbgELDr81Hz54IYy+KJ5/QykYycg+4ptZ+tV6YFORWUZCnHLhtvFfUa0YxCIzW5LYRkD
 yowg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyo6mjrURdtoQg1hCABFYKuvn+k1HqndOBQxE6i2e4TUUUbPFMYnPK68aOvd+BIm1FqBz2+27PREVV@nongnu.org
X-Gm-Message-State: AOJu0YzfFjIWqYUlixWvdtafe9RbatdAEKsFI2c/SAl5xVoFJPryipeW
 1PYuBxcW7durjw4SYkMk/C6as5ae5NzkpzKpNvDNeEreIuEuKvVeMKUSTuZ8JQx2h/umFRQI0cc
 5nJXuINc+KrQ0x0ruO2DGQjOX1ZWueFYVQu/AQru3yg==
X-Gm-Gg: ATEYQzzzZ1kKW3laN4VtBi6JAmjXdG35iHS1LO9bk0cCN43gm6dXl10eP+8kz4ci5/H
 g0vC8nnUIehvbOtA5alQ4dRF0AHJlwBRN9jD+I1ddSn+lcG3DtNl8Vr6nMxJlNwtrzQWzUMdaDC
 8eQ/S5BhNgnFSbapMjk405/m1y7AcTd+9KrHk75Mqm7+zAMP324tISn6cX3PRHpbUzC2foo+of7
 9EtHeJ+x65rlFmr23ODEJbAVo+GZSpdnV3TVuxxO+1qcBfkALCLC5M4Y9P3RiCkQeV6s3nmg0BU
 ENHd/ZlGW62fbKa/GUVc5PF/2A9FPszlxSfxquaI6/NEzDcYLhIzaVrXPlnkp9185b2D7h0CWX7
 O+A==
X-Received: by 2002:a53:cf46:0:b0:64a:e959:b3be with SMTP id
 956f58d0204a3-64cc22d70c6mr2119452d50.71.1772206899311; Fri, 27 Feb 2026
 07:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-2-peter.maydell@linaro.org>
 <CAFEAcA853KSRD7yJKjyoM-E2R4YNou=x+BCR9EWrjym==-tQjA@mail.gmail.com>
 <6b0d1396-63bd-48cd-bfc3-2b0dc34327e9@yodel.dev>
In-Reply-To: <6b0d1396-63bd-48cd-bfc3-2b0dc34327e9@yodel.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 15:41:27 +0000
X-Gm-Features: AaiRm50zEKLwcKtVxa6EY25rb6orP1q_vda45rmeYjyWdtzKOgVJ6-LfBs6kJZY
Message-ID: <CAFEAcA9xXoD505V4wzfTZHt_ajRGYVRN3KRd3BQgGx=YRDYXNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] scripts: Move lsan_suppressions.txt out of oss-fuzz
 subdir
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 27 Feb 2026 at 15:32, Yodel Eldar <yodel.eldar@yodel.dev> wrote:
> Also, there's a missed reference in the docker test script (diff below).

Oops, thanks for catching that.

-- PMM

