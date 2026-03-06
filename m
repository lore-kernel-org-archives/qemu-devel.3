Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5122F01812
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRQb-0001dw-Im; Fri, 06 Mar 2026 04:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRQY-0001cU-CV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:24:58 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRQW-0001Am-WC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:24:58 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso11165566d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772789095; cv=none;
 d=google.com; s=arc-20240605;
 b=C0xbIFWkUB1TQ15kX4Th75hKu9GrcRepCxYOpYxoDhcTrBoRktaXn65qpbkIIcvAIQ
 12RclUGnnuPed29IsVRtxqOV/2U4743YNl8ip1U5RRgauEGMyNSdK23DTDnAVt8ydRup
 jSTQD6Rzg+6nh+Vhygmwt68kPZXCzikWIYxv9+h11TZsOQoL3skrwJViV0iMPOBkxHnP
 Pa+hxzRNtmophk/jg1NjEic4BKeiY2UfJphpifrJxKbPAehTunNB0t/DzE+KNLJFH2ig
 SEV52nRTe1Um6yv3m3xekEVOrpz0ict1lz+aG3vOoZ7/lwUPvG80LKGM+job6yf5naKs
 FalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xkgGQzMEwUzolE3oLVrHcVLK36Dc8YqjciFFaSttqwg=;
 fh=9VbhhDmhTaYYuDQ1iBoJ535oPzjxqBxO6nj9daI7qUQ=;
 b=EPlWdpva7HHL4XCRQA3qIHf/yVeAoTgP9GX+AXXuG02eHvl21zbpEQbytbFnaYIq7q
 3aqfWDYLbmrWaBuLjHleweA1ICk4b3Qe8fLWzWFDdxcdIGZkGEiZHWhjN88KOSO96Fip
 ZqPKx9ahKz3kqqvzq6w2EChyynWf5Ty/CBOd0EeWHaKhYiJNfcHVBmVYMJRTst81il9z
 +jnRREuuoKG/Qtw534h3xNDhJOGBqxp8M+m6pbXVlGJ2uqxEj7+CcbK4J0O0IJoZcEKc
 W6CdYaLksuHvU4DoZmHzn3RwBtWzmDAM2Bo6ApHPos64CBPn/Dr02gyKqvnZxjPaLj2b
 EMpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772789095; x=1773393895; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xkgGQzMEwUzolE3oLVrHcVLK36Dc8YqjciFFaSttqwg=;
 b=RVWVOIQdlX6yzPK+L1d9QiUFS8TCAtC+cNrH5Jrm8yInuz5T3GaB6/oFuYshT1WOh/
 IiKfuhOYpPs4sSI3AB/HgrAJVE7GX0f3ehoqbm8H122NWKly6M0crCN98Juxbemkp2+1
 DfJotFE+uyN4wTtae8haKhv+VCJkcZidDiC2wQ3NUlpDdhUREcYoLVy3hmi0txRxHY5e
 4isNPh1vHt7w2plt/Inx+aw+mKpoorLrLHt/an51j8mRCuLQmE24odTh938LPRz5tgh6
 AKhQdxQgKhT590+YwkUNv9QhLOcyNO3Yk19UMrfMwsKZrp/9WYsnj10i2wqiIgofEJ2q
 Wb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772789095; x=1773393895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkgGQzMEwUzolE3oLVrHcVLK36Dc8YqjciFFaSttqwg=;
 b=Vv0StZRde6Vm4HuXKLYdFr73C+YoZ0Dwt/AdneIgVrJ0VLIjZnfNiBUGuCyiOJdxq6
 NmgUP715XzojrfUs7mvZ1NnAEAN9n5mlVauJTP/1txOFQAMWsGV5grMG9i5clucoJ2fj
 mpN24+LYdlWEki0/Gc6Qy7IJ3NgobnI/W8gFSS4dUDm9fzK+QrWVqi+ehisjtzIDh4f+
 AvmI/MdI76AS9vBrlVUxdkoDrqFAiM3z7o07KFMyDmWlaDRQRhsCMUZmQ48G9p0/NgqQ
 By1CeWRj4bujR4IKPkwSUAwGE3ozAx+PXFTYpZdC28aAZ2A5FxkFi7eGAPiigxrZfK//
 nk7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUVbWeEa8aDw7xtLUPU+e6PIp1iREk8E4ibR8+StTRMmvmpKiXxZVhWMIPnfEbmRRNRsPs15cZnEKW@nongnu.org
X-Gm-Message-State: AOJu0YwVw2fNwRXKR3b5XAMDSQTvipKwYhgKwUX/w24j1r+G0JQLskMP
 ddnXiXDZvREOfN+51Lm+IiGVxpEENkkguunr7pVKByPlqkEQxTXQ5Yijv8r+8/3NbpV0zLRddSa
 oGi8TgNX0f6XspojN+KsDfdcX+QSN0czrRh25f2wXkA==
X-Gm-Gg: ATEYQzy8fpLfaD5vvXn63QWSENpGWyPg1R/wpN+w1kX5GBAb15DkuuA9AITWp2JT+pp
 sYCG3t3PV91Xuu6dDBglGCK3VSTactpE0qYbv4yaHq+vBWVpStRaaAkv2QaRT7D0v5bg7tvf/yc
 2v/TfHTHw0fJ94RUJaadQzo8A08Fyz7dvDaQhZv8ORphvC8IR1F6EGkTyA9TQRTn079WLaDtmq5
 a89RXUkBPIbKQwoBFI5ghdHTb4HTLUsYb5gJ59cpMMQpYbS8/isBqqQeEtk9hwXs4tvKVfI+CDc
 CqhjjQ1Y7rBGQL1rGzM9hqoRGABlPh0P2M1Y/8DCtZA6QiJXtct4ozLXu7MT9wdMbAE=
X-Received: by 2002:a05:690e:134c:b0:649:db34:c512 with SMTP id
 956f58d0204a3-64d07108346mr4665928d50.21.1772789095322; Fri, 06 Mar 2026
 01:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20260304142344.3341444-1-tangtao1634@phytium.com.cn>
In-Reply-To: <20260304142344.3341444-1-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:24:44 +0000
X-Gm-Features: AaiRm53AnZqqesJvufABADgC0QBIVKHIB4T580lGm8FPp5aoic4CsW4dyW4EetU
Message-ID: <CAFEAcA9T+=wF=N0nayH02x+g84fbSbfARDT6M2YRBk9XSgRyqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/smmuv3: small fixes (spec compliance /
 robustness)
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 4 Mar 2026 at 14:24, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> This is a small fixes-only series extracted from larger Secure SMMU RFC.
>
> These three patches are self-contained, already reviewed in the RFC thread,
> and can be applied independently. Sending them separately should make review
> and merging easier.
>
> Thanks,
> Tao Tang
>
> Tao Tang (3):
>   hw/arm/smmuv3-common: Fix incorrect reserved mask for SMMU CR0
>     register
>   hw/arm/smmuv3: Correct SMMUEN field name in CR0
>   hw/arm/smmuv3: Fix CFGI_CD handling when stage-1 is unsupported



Applied to target-arm.next, thanks.

-- PMM

