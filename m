Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0028BE7BDB8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryUA-0006XL-HT; Mon, 16 Feb 2026 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryU6-0006X8-Tj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:17:55 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryU4-00044u-Gn
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:17:53 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-649278a69c5so2704457d50.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771247871; cv=none;
 d=google.com; s=arc-20240605;
 b=h1A5KBU5FQjD/tTAT3MteO7LucKyOuEohowJyaFORpNyIYjUlnRo/G0PKOoiIKUGjn
 q2Vk2xnaSvIrvUbgkTwqYsUOwtKgOVyNl/MR6fa+C+DYI4jnv4+RL6tGHVtjf7XyP8RT
 M5W+1um2jSzHjmsGiKkWVENWaW3DoL4KTyNTJIkmgdwq+bKOEC10WdS1OUgtRDnO+IQo
 QuE/7MiLL/5QgQsv6LSREae5MLsQH1N1zHoRkyNqtE18z+KJ2QGOMvJtQ6umXW3dQwRl
 1BzVdH9JPHot/vIgPLvqqpxjozZbKlW9/qbI1OREBIEpG62+8UyWVVKYqd1sUpJJSfIq
 CIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hDCCXhPuzHtcr/cPcDQ3Csiw0LK6LO360gwgH2xUyyI=;
 fh=6pr6qAkd2aM53CIB0BqoUH9Z1v158ZU2zd0E5Lbo/ck=;
 b=jFkoQVLPlEq0AcshDVsfY+gbXvKrW7pWXUs02t0zJUBkoQbtF2AE1VoVZM6XOyzE1I
 6J+PxOERU83CDLCBHJ4oWxby9brLcrFnK2CzJK8r0Y5QJsTJiHLAUvH8fw7zJAaKZRTX
 yNrthffIEbOcPmviGrBm82tW44HdkKYFjAuiQXdus1Ux4Qgc6cS4Psn/G5G8WuaHkkHl
 Dm88pQQAtoYwGtfsVnZyUvqspfy4Y+npkSIi4jVSZzAyOBDhXSH0ml+tE0pKtZe58AGZ
 04bKFWOOmQuDjSwWkFLvw9hOL3wQ9x38rQJKVM6uakuoQnSxYowCP3xLgg4VFU18xzCl
 gWaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771247871; x=1771852671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hDCCXhPuzHtcr/cPcDQ3Csiw0LK6LO360gwgH2xUyyI=;
 b=ZhAWFVD20pledDHpV1FTnbS9A7f7B7YByQ88SwmGLXFSIU3xpA4KmrG4HMI4O59eJr
 qKxDJPXa6V/5naVE5UhzhUDh4352f/hON86GIjrCweACiFSCT6k1X6MXvI9z8aTB6gZC
 OQemaMJzaPth8ludFKIWY5lXQ4RWjpdkRfLWKSBvXiS+h2/bfeDd5aal5gqEvNAVwDjx
 dFgGqnvxbBivPsyTPea9yM7lYoZSW9eQbH00HXDUqWX/XwY++Jbm7DzYg169EbX9OpmS
 HfBUaRaJLvA266il4Wc891y8Eh+VpnCQZTkGwzygeR+ciXw88nCNam5fJRb8fZERygkr
 5IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771247871; x=1771852671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDCCXhPuzHtcr/cPcDQ3Csiw0LK6LO360gwgH2xUyyI=;
 b=IBXidbWmo0okJ+fX/rSPBP8Dqx/YxWz9OiLXJtrtoNjTrA/JtNHMeHvlX47xwCzvGL
 z++ef45X7fPrcQrN+JzuOmlXDvwQ49dt8yHkiGlDJkEKfKIqqXCslu/OHBEg9CUIKKXU
 LLYKR3WQgomNF+DXOjjhfG3WMhSVtzLb/jK/aH/iRIpb7vkzEN7h7fqb9JFGiWItt+3T
 dEVLlkThKc3Hs5Z4CXi4QsqnCz+4Z3DcXtmZy1PYNuKD8MJwdZDaVvtIUei/CjeTn3pW
 QchA54qjS3kkaQ44fbNulvxlduytIdgEwmFkdRmOHT1IO62X/7UEXvL5NA5pPIgNsfom
 LWug==
X-Gm-Message-State: AOJu0Yz3qUmG3jdYOV8sPQTEuOe2RSORduN0ERnDPqWa5USp1AdjqICL
 0VK4OMydex3YHbsFGp4FgGscjLWHoD7SR5UN+TpOpqI2tmxAlnqjOywef1x8yxZCWngKqWRWIzo
 pyO+cGhiPO/6rb1LM+5yj9QZfsZ4Haw145QZ1ztTXpA==
X-Gm-Gg: AZuq6aJnE4xNlfp6TjqZD5kJhAk2Rga+NebQIR6cEcWBEdLTOLqqadgTYgSWMK9VqIj
 aNXyd1ES4/iJtN9RcFgV93Y8Jw/sQ0K6zkUWMmiuOwAmNBQvCiEWJIzm7gXzZ+spWW8+6VjW7IR
 hOIK7zEy5nPChDwfx6GWotMy+U+PETHpJy/ygN0x7bgMkQYpcLpRwVvQXjXnp0FiDMjR+WrnALN
 uku7dO+iCl0hJdLRcLYkRfThvwMD9Do+zcVfhBwRbODPgzxqekLoyqteTZjR/5uOK7RBqrK5QeK
 WZLe7IlLEHDJcnZHJFWeXZHSctFMdbM1+GxeIRP3MhrF7Tr4dc6beisPP6H/dS7K7j4=
X-Received: by 2002:a53:c446:0:b0:64a:d1bd:8c75 with SMTP id
 956f58d0204a3-64c14b6d7c6mr6832050d50.27.1771247870859; Mon, 16 Feb 2026
 05:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20260212185425.2F854596A29@zero.eik.bme.hu>
In-Reply-To: <20260212185425.2F854596A29@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 13:17:38 +0000
X-Gm-Features: AZwV_QhtjrmQ3Pmzh2jHt7U6yDzEb1FZ2Zc2VEje1R7uTfP_rbUV184l_vw2vM8
Message-ID: <CAFEAcA-FQV0ptudM3HF5Q3k5f8qg25uqXE8rtxfTx7Og53x_Dw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-ohci: Implement frame number overflow event
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>,
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 12 Feb 2026 at 18:54, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> According to specification 6.5.6 FrameNumberOverflow Event when bit 15
> of frame count changes (either from 1 to 0 or 0 to 1) a
> FrameNumberOverflow interrupt should be generated. This fixes
> usb-audio on mac99,via=pmu with MacOS 9.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3274
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>
> ---
> v2:
> - updated commit message
> - added Tested-by and Resolves tags
>
>  hw/usb/hcd-ohci.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to target-arm.next, thanks.

-- PMM

