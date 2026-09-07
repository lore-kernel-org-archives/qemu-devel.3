Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224F5C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cK4-0005pW-1n; Mon, 07 Sep 2026 12:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3cK2-0005pG-4r
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:35:54 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3cK0-0001uW-D3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:35:53 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-866e57f63a3so39461867b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798950; cv=none;
 d=google.com; s=arc-20260327;
 b=Y/OX4pqZnFBBg7SR8VVJw8xRyLhaa5Ir0qW25ohqkoPLrcYSa8vb3SVQAyx/CDyy6W
 dYLO3xjywMoDrElTzOIRcGGGFO01EfN0p3cJEO7ByxJvzPHc/sMV/h5SWyDFC8S0hpHS
 +YJrfX3e6dtFKbVen/eoMBTUzVVBN0SbOnY2Xf6KOy9HaTXFpMdHYtyJ5yFNNg+9phv9
 VQd2LuvLtsPOkTmx2rFfbULRt7Pst5ajXDnnrJ3Grj20L+ee+qkshtwef9Wn72RdLu0O
 0q05B0e6zFIn57YSTsfX5r+ndPQh3dwDbl6ZZBh25B5zm6bce3Fw3jUgoUP7x2xFn+y7
 +Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wC8QCYmlScKzE/lvXIMEr9pFWPr8peXpZhK+kycZLog=;
 fh=TwiuvF+80khq0pdY+XHjayuWGiD11gRRqjGPvT8rm8Q=;
 b=CryC+22lOVhhPct54rAZyb3PW9Y/YCdE+vDfrYVrNqcyO0fTV3fZP90GLUNAsNf0UP
 Wk9dFkM1jRjrDjE3ieOiqW4ViqDRCNMPAbvV3Ld41Az2wZ6fsR+2uNBcrNaS6qqECokj
 IPJFMNqSW8z7pyJCjfbvBfrUM64yiIwJvcGmx5N+Buz++jF7sXb1gaw5Qf8ECtBv4p5F
 DqIklintvQhAZFN7znV/NMafIdrkHJBTrRH9EObA1rd8lqf681lkc+EDVrYNYQxwxlCB
 3l5+SAjM7u55QhQt6cLKas56aANOQMijjw/VyQLjqsLgGTk+DT1Xr/RYzGsNdVue1n5K
 +cgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788798950; x=1789403750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wC8QCYmlScKzE/lvXIMEr9pFWPr8peXpZhK+kycZLog=;
 b=o7YC4dbaqafOHXz3Y9uxs/37z+zWe83F4ruEON2gjZ1PXtAbO9sRnQoASNGVYmQDjj
 45++hYOQsEbG8EF4iuf0ztIJKYY11OZUY5X3kCdTFscTs4oggRWYipf/e+UbjUPpjZhL
 5n/W7pRhFydmSWFwtUKqzieDeBdqzAMWErQJEgOAHztKsofBMstEk+VhFJijFJyUrflD
 of+LLHdctkJ4ax8hME1ugOBTGHQP3K4x4X0F0BSEP8qcLzGePgC7qmfujhK7fvX2OQbm
 w3N0o4LTZamkCBRFTPHB0tYmqc6D08DYjtPjJY2/AxIpIMAMl19hU33bqxf2MScMzRz9
 r/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798950; x=1789403750;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wC8QCYmlScKzE/lvXIMEr9pFWPr8peXpZhK+kycZLog=;
 b=jm74WZQKaz9GymeLEvqZpqxfK1EUiaj3kdRSQX/cUpIGKlU+BE/5mCBl71qYfc69D5
 rK2QWkZRE1tQrskJA86SO1JLIHEfWacTb3HBF3rdrSCtk46Z/o8+0RV74IGOTEBXDF4R
 fjd2nhzgOXaZGxnC02W1LcIOruPUBmf5LbSk3/krrcAcMAPUD355H+mwQ/dyxy/udPkf
 250hdg5r5pFNXsf9arzKd3BGLNZ1nueQu1ySgyw2Sr9Wcjyf62biite3lCMgN0RAJCr1
 Zzs8ZvxMH8OBksCtawv5d5nzggc9eFhx5iiy0/FqdR4kyipdeioMT73i1DJDNE4QvFyR
 s4DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwahVkPTF77593ROCtlR2jk7qHXkf+aaC4yKXji3QeVRQoqWH6R2KNU8WdwjsSE9wJXDVNpdXHjTZdR@nongnu.org
X-Gm-Message-State: AFuF++nOLSW/V888ROtT9Yv7kY8Y3w5+AH0vOEixuAegQzAFE3paBQX0
 w9ynPFuPAOeJGNqwHT1Npi3nyvFKUOKM08wCUIbmVK4roUs3Lxk+kM2usr1PFgaNjnOkBeIEwpz
 wWMIhpWnJXFmsGOiLHt0/LtN2TZ6jDeyu+dWXVvaCLw==
X-Gm-Gg: AYBFou1BlfAGzftdliIhDbne8oOo2TeYFT4POiSf/cCa3X4Koku2EmobfUAcVMmIw8w
 eOIjE6O4uXr+ROkpZFRoZbPWgZsSYmO2RW5eDb/ntYEzZxJJ/KNgLUjvwkU88E19jTt6TAz1sIp
 lP+oM7TMI2ax9RC3kcW+GnvUlG20d8DOZscdkvcw9jAGD14P12dKTSy/cB8gM0wmyoqq/BKwCjT
 AcFCspvrjqYqJjX+LIC7LsVO3c/OK6zbO1w3RxPxXoY9PtW2WW7l/dW+9b1M3Te9jEGaa2EdhdQ
 or+CIsQLIdcNjOx1H8GCh38pVW6kwNNGt2k5bzlQZcb9tvw0CiB9WDeD4aPtEh//Lai++N7W7RP
 +HkXG7249aUZBL+7g9OMlafNGTlyP
X-Received: by 2002:a05:690c:c511:b0:87c:62fb:9833 with SMTP id
 00721157ae682-87c62fb9b14mr8081127b3.6.1788798950237; Mon, 07 Sep 2026
 09:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260906171021.26568-1-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 17:35:36 +0100
X-Gm-Features: AcwNN1VMeTsjD3qRwLqlV0MnI72cqenBua2nTH49VMy45Mrc_2svJpIN0yF_ZVc
Message-ID: <CAFEAcA9DVfiBUTqvwG8DzWyBcDxF87q9vkJ4aANRe=OaYjBAcg@mail.gmail.com>
Subject: Re: [PULL 00/40] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 6 Sept 2026 at 18:10, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9=
bd:
>
>   Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/st=
squad/qemu into staging (2026-09-04 16:52:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260906
>
> for you to fetch changes up to 1c05d7e94da04129ea16147074fe73158fb85ff9:
>
>   tests/functional: aspeed: optionally check the device tree model on boo=
t (2026-09-05 07:05:11 +0200)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Fixes AST2600 SCU protection key registers on reset
> * Fixes I2C byte latching for SMBus block reads
> * Hardens EHCI get_dwords()/put_dwords() with DMA error checking
> * Adds a second random number generator to the AST2600 SCU
> * Adds the ASPEED ACRY RSA accelerator model with ModExp qtest coverage
> * Adds ECDSA sign/verify support to the QEMU crypto akcipher layer
>   (gcrypt, nettle backends) with tests
> * Adds ECDSA verify command to the ASPEED SBC model with qtest  coverage
> * Adds the ASPEED UDC (USB Device Controller) with gadget device
>   and programmable endpoint DMA, wired on the AST2600
> * Reworks the TMP105 temperature sensor: Resettable reset, fault
>   queue enforcement, TMP75/TMP175/LM75B variants, and qtest coverage
> * Adds the Facebook SanMiguel BMC machine with EEPROM data
> * Uses real TMP75/LM75B models on the Catalina and Fuji boards
> * Adds optional device tree model checking to functional boot tests
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

