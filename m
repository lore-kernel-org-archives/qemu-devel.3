Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786F8EC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMaS-0007Dz-8R; Tue, 03 Mar 2026 05:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMaK-0007Co-2I
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:02:36 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMaH-0003Td-JA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:02:35 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso4766698d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:02:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532139; cv=none;
 d=google.com; s=arc-20240605;
 b=RDUuZ3nUV2Uzp+hKmz9K3/YlsArDnZGUlMG24jxFk7T9phEI+ku5FkzgEUdkR2VOls
 Ce3t5pMwq9jo6TzPr1xmUx0njMYRRoAxGPE5g++yREKEmEgrwuwFb7TMVX+ZaxzavdGG
 aDm7zJM3Gbc+TmeA0PvyYuhzamvO+Nt6SBYpbOnDF1iqQYLLcvbZI5NTxEFiMjz/WxDs
 Rhf1Gky8CVzY7MRwCkSp1frmXWf6H6EB2eAd/jAieMlqO81wKG/6JcqCIZ/eGmhBCwc2
 K9g+I0TpmN08UTcdEYu8WNE1TpANdBXBcJ1zTlgXMiR4opsmwqGdC1wWnyqoPtBukOW7
 ud/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EntsRb85JProsrEQW+3gNqKQue1+QEBdP2giyri1q6E=;
 fh=T1BJdbaoNP7tDGkP3CmE75MzjQvDV3CZ4R6pPERIwEU=;
 b=a9MxwEj7V/cgj66opQv3V7VmwRYzzn1u8dXyhV7Vag8CkDgl6eGiGOrroy/jNWVuhG
 9iNoCxUVS60JKR3Au5oy7M3fa8rORW68KFyizmp95Ae/WbojLUd+oS+Wy5NRmsFK/zoJ
 bcTxt7fQ1D9EoD8p3d8bqQ/Gw+6cVPFUDalvZErzbh1gn3/Nm4GcxZaEKyzuvilJQ6ag
 UNP6uyGPf44nIP5SGlsua2GVJn2oNhbfRpOYo4P+iwee9mQJ4XdPBiC6Y3ovnf1glAUH
 dG7diracG0HhqBTIX9Wcw+HqSYbdHBsvGlz3vE9g+sQC3qXXvTCZcdr91s6jIZF03Bhw
 G8bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772532139; x=1773136939; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EntsRb85JProsrEQW+3gNqKQue1+QEBdP2giyri1q6E=;
 b=g/gwHD6HkV0hOmphaR248rBI+r8Xzg02inTk2D24nUdLdLzqv35bJzBb92fCU2CRpx
 zlTii+/bjfj6m4h0QRoQPeG8ilXg6NTvwoLma2LIyJsR9uHq7fAMD55nKFRMNJt6iGsW
 mrKaGo/mnj9l6AAeERoVguH//DS+CytubVdp7AfrZaNRsMB0izv2lf9kbGy/imgGJxs6
 nQcc4m+F4Kv0FEW7A05W4k9bPbRXloum4QYPhcKNLUQb7J28OGmMEaU1RU1ymKJtFBVG
 R5lv80NC/YY1o2BWeq43jimSKjJPK6dRDKZpBZm8xKS95WPa8qGYBxuxH7M2SY9+hALH
 m+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532139; x=1773136939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EntsRb85JProsrEQW+3gNqKQue1+QEBdP2giyri1q6E=;
 b=wGpItJoj4NIkJoXeBKTa0Oy46WcjFxTlrAgooWYuM99sLw1Se1rCQVKAUjT9vnKlpR
 l58KXtV2XYWwT254L7jr8D22ijz08XcVJRMiKmWcMCiztphjhY/4kyXHgD5wgs67n/Cy
 VnyhMPUkyjbvFHNRlQPdQEmFPg3EiyF5ivqOkPAGAb89qS/VYSDLr0NSGXG3CHI/kaE/
 boi52OZH6srKsBmtvOUS/fRnUl9e795UlblQwPs93gRMSmjF7z4yUnu/sfT1gMa5sD19
 ht6XX0zYyH8j8JNRYqGbyH0BhxC4pWCejL3ebA5GtYVW3DIMH0dCtB/GuffLtbcPDpPn
 4qlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVSr3BHbJXyX4PSOuI4kkmY02v+JKXqa7vYhDbenOcUcwWi8UscrAfUtx6K/Xvj9c0wkMB19o+B2C/@nongnu.org
X-Gm-Message-State: AOJu0Yy5QXqEtc95UV1FKqmfLY/Roo1t1hK5S93lDmjr7uhYXAVU2q2s
 uE9ZYAi4Uoz7IzxMoax84f46xzkVfmUjb1D5gzWR+ZpdN5iVSX/gvDUOLY4fbbXRrW0SzM+c5dp
 tMLoLN1UobUJn1m/1YUJU7LiAT//aWEXnMgXM3azCIg==
X-Gm-Gg: ATEYQzzo792jRWFI9Qid2IzbvT/ajM8W3wGC34aHnQFZetY+xR9X3jedTLm9noZh/Wj
 plNfrc4+jWWtpYmPkXetPWaUfiTZRYVGJth20Pr6xAOAuHz8s5FBTOZaXVwPEeXRj6JfAP0qdCI
 d5mYmtzlOuHqxVjsQIxF48XiYTN6zQ08+tV3HEzr6VFvHvbn5ylluYmFNLy00sNRfXn3dBqi0zc
 H/YjdUsOx3wJlCnrcOHUFRn9Mx2woDjn2ounYdtKj/42Jkg/kenj9DFxYfVBklSR5V/BVshbvKk
 b17r/xNtwKOfLnomrombtsydkeKYQmLwtVh+qMbvBV8b4SrAquG3DvOnF9Apzwctjts=
X-Received: by 2002:a05:690e:4452:b0:649:41c8:9cf2 with SMTP id
 956f58d0204a3-64cc201e400mr9694102d50.10.1772532139465; Tue, 03 Mar 2026
 02:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20260228070622.2195836-1-johnny1001s000602@gmail.com>
In-Reply-To: <20260228070622.2195836-1-johnny1001s000602@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:02:08 +0000
X-Gm-Features: AaiRm53kj8RV75Ryoijfh5gVqdmDWH8HxJcQ0ibsx4uYVJy9DtSgrO2EjZ2Y4VQ
Message-ID: <CAFEAcA9zBjycO_jHCdZDopkPbJdUje+xMA3EyEi3boSk9sGEyA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing dependencies for STM32F405 SoC
To: Chisheng Chen <johnny1001s000602@gmail.com>
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Sat, 28 Feb 2026 at 07:06, Chisheng Chen <johnny1001s000602@gmail.com> wrote:
>
> The STM32F405 SoC relies on STM32F2xx peripherals (ADC, SPI, TIMER,
> USART) and the unimplemented device (UNIMP). However, they are not
> selected in Kconfig. This added these dependencies.
>
> Signed-off-by: Chisheng Chen <johnny1001s000602@gmail.com>
> ---
> When using the following command to configure it and
> enabling `CONFIG_OLIMEX_STM32_H405` in `configs/devices/arm-softmmu/default.mak`,
> this problem can be found:
> ```
> $ ./configure --target-list=arm-softmmu --without-default-devices
> $ ninja -C build
> qemu-system-arm: unknown type 'stm32f2xx-usart'
> ```
>
> This is because the dependencies were not selected in Kconfig.



Applied to target-arm.next, thanks.

-- PMM

