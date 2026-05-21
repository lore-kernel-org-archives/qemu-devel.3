Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AE5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Zx-00036t-7B; Thu, 21 May 2026 09:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3Zv-00036I-EB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:36:47 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3Zt-00069D-JO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:36:46 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651d6347a69so7193312d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779370604; cv=none;
 d=google.com; s=arc-20240605;
 b=eNoOyarct5SIhaPb3bAGB4VGlv4nDWkJTs77icdMV8T+KFTjgyq80wJ5G7sd9hYZ/C
 S+CsZyRZ/23cTNmgpacbd2Xwc8uzdzsNS55L648Qv2rcdHNKIZSlevx2+NmlBomhuz3e
 RsYBnhC/EslkGT6jdodD3cUOtkM4dUwYG2mdWoYg606vbZrKEoRb1xZvwRZp7kuQcgcQ
 DsF0q5Lr/DQ2GCi5PSkIp2LvUnCxHW30zJsz7XGDnpKcNCChBcPOk1Rh8YKjgJvOMzF8
 gmdBdY4wCJyyvsJDFRVcRjcmn+HkPWy0yvliATMCtDPJvBshN/a39wwC5CvOCtVR+K2S
 D6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rPrA6+viXeigP8WjQobrxNyXtwBzDxNCHHIJauZQCx0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=EVNSIelWggnAuWQ0MTzu6e2XZEHxh943FxE2oi9B2r6tQ63dXTkLMz0Tf9JplUy+qs
 g0ar2R3adgKANwvmKQZMSM3PEWKNVDBIdTx4EC7t9If5dJYMGAeeLtTxWBOXYVHlz0sK
 U4g/IGGy5ZXH6CW/vumF2xwVfQK2gWDXgD+Su83oFof7KymYLZyViUgRksG4BEM0tril
 nb323mFgFsTmDPmbd+sAOofqdK1SP1xum86GNCFxw8xFJGrrEW815N2GWCOnmNxVdW6H
 z1IpLmLJIlzcMecjDhh0p+WitIGKtZ2/B5/KaPD1s4SigTDJlVCuF+LaMbzhvRav8Izf
 ZlEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779370604; x=1779975404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rPrA6+viXeigP8WjQobrxNyXtwBzDxNCHHIJauZQCx0=;
 b=IDzHrJ56jUqYyBM/XKLvGd2I78Soaey+VrQweM/dmtErlqJ38UyCvNqicDwZC21/5+
 S7H6VatOwANJjbW90DWy+4dxQ9ZI4AxVhomAnzefhnFLgpKqbx4AWVvlMznPjPhagHJD
 nznYJXo5n4V+c4WtVy+o1/IT6e8HBToH4q6pisThkv2sw8sIYqxJdGRR7DzQQw7o3RP3
 lr4KmGOV/fSRrQPm3WNZgZoxoFnbT2Bsl64tJ+JI/z0wkSjGJTgbnMflM6gK8r5wU/B3
 OX3vyYFRQRtsz5BHBVA7rkx6GqvGUJltX85t9ieEgOlxiBx8dUsTBTmIfHY9DuuyUkPs
 Kjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370604; x=1779975404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPrA6+viXeigP8WjQobrxNyXtwBzDxNCHHIJauZQCx0=;
 b=dmI0bfS/UXbpVxvKcosg42jaMGlHEJ26TmjNiQI0ooove7jGGK2seP748SyMTUUUrV
 oj3OtZMT90wxJj7/hcCa7jkk3RhRAQk2O/ERDgIBt7xmyPa92VBhT7c5XHYYmAcwyUGh
 Ye6PKc1ddp+os9RoJIQRKiYVJCXugSEH2bqA4Ty5lcmnoylTg7Q2eK7Xib4ZyNG2b3Dm
 38bSVIY/ZQusHMv7/JxT0oP4srGRWMu3F+QqjpYwvqyfS83U1Ikkd81HKENe8iupO5v9
 wqQo5NBVqCbhObowlHUiC0uQOJfhsXxjPms59Cw4CTCLT80a+7KZJm6KHzGAR/9MqHej
 xkQQ==
X-Gm-Message-State: AOJu0Yy1A0X4LxlOB4GkGU488rX3lwADVLqhnfZ65orDeRPszq6PMbZM
 NcQSJfLK+2DN8dfWaXVHJw1i4dY8S9Kmvb+W936Pms8oI1S4TgzMWiR1ngPv0NjzmU2sGNCmR4E
 XBnjxliBidql3xAMC1H2aJcKFK4kwhPilvkmySapCFw==
X-Gm-Gg: Acq92OE2tSxJY8DY0f6yXDP/Px22xROKP52762+Q2j4p6OI7HGrS8uxpLY9shZB12Hu
 L5woRwizEVJYNY+6Qr6ubwb7623m/Ex6Z248HxuP+yiZ1gJ6OW7lPPotSFtdVHnFynPJbJWt8hY
 bIhHN6t4s6gGkzVqyNMzxkd0sskPEbcrptF9cyJKZhlorh0JdIuOgp0vJhcqJB+Kjejfen2zvmC
 6GfLuvd3HzGP32yhCnLFf55fVnasj5Lgslkvo/dadFU6DwYU91XWOSOCRSuD7ohBM2x9mho/z1L
 5jh4f3WiZKAC2Fji3osZZjvCnjmniJnopem6iXspANMl5nHd/m8dLgAPIO+wDZ9bSZs=
X-Received: by 2002:a05:690e:14c4:b0:65e:3e40:ed9b with SMTP id
 956f58d0204a3-65ead053ce9mr2129897d50.44.1779370604330; Thu, 21 May 2026
 06:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-2-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:36:31 +0100
X-Gm-Features: AVHnY4IV3591kgmAk00gURnbUy7QzSH7JEOyExI0if96mNYOdvaYuHdt59ZKofg
Message-ID: <CAFEAcA-nNDpO5MvMsQSGOX_kRo95LmHLO3AeZ-V1uthLSPEFCA@mail.gmail.com>
Subject: Re: [PATCH v6 01/64] target/arm: Implement ID_AA64ISAR3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 20 May 2026 at 19:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

