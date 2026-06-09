Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF340CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzFy-0005iH-Et; Tue, 09 Jun 2026 12:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzFs-0005ec-RP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:24:45 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzFr-0004pL-CW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:24:44 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so826853266b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022282; cv=none;
 d=google.com; s=arc-20240605;
 b=jMIYDzOZM3rIVDTMwE4Kg89a5tYaoPvy3Ao39oV0MVh0qaYQ7VYUwJurTH0W3IxxY3
 V9//qujW7TwOibSJ1b08sXmbuA7clPpohRqladATpHzDA/BtJfNgBny9xbWqyKJ21tmJ
 osFTPtSKYHb6djihWOxTbKtQw6jSADMV8ejrrDKSiQDJ6YvuYsf1hFAqdj9sYqniSaxn
 USEJ1qgctpGrTLu3M/H28sFqVMhQU87VgvO66kOzO+k61HCWkmoh1P2fJYFawaZHvEmf
 Oz1KIwLHODOVFhQNVZy/hF7iLvpVpWR4gAcaadFZ39icQj1siVumGap7gNu0hTJjrU5O
 pjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FoGAFSjXle/G/xJsDCtMxGFsjbAaOC8QDzGVKIdsCPc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=d4C6fix/Alhrdak7pvycrU2apthP9BIB9thYZib38tm/YG+C9N1lQLImAsOT0tiEZh
 dfmi2cX5/2aUi49Cl/iqkiQ1fKkhJd0c6kUtQFT6wBPrQnAMspqlM3bh1HnimQz1l8lh
 mpu1vGdUmQX68EFPLTozSLwv1u16OUT1aurNdxg0LI+yU7aMJE3ROFn9OFNQStWaKLkb
 lT2kWEaIH1Q9/gYiBB3XezZf4RZH3AtROJNgr0kXO9NbFnN2FRRjFO7/G52ugV7X7MA+
 pewCaqMXQv3+3K6ukPYatc3wBD90QgkBG1wSKm+CZQFPS7TP83r820yiuyMTWhxgfL4z
 0W1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022282; x=1781627082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FoGAFSjXle/G/xJsDCtMxGFsjbAaOC8QDzGVKIdsCPc=;
 b=JUa3Du1v4N01GGe6PLMYPsuiMupgUCq07aQxi3f9CqlgAvYA/M7FeuI+Z65HlPkGEI
 4EgdwcpnhFnBT2Py7abUSXL4cKwL7l4tEoNaGcm723znTVBzHe91eyp4o8jSI3oqcLqM
 vZ52C1/NxVAZrkF+e2CnvMhf6fKvt58aUB95XapCPyxI8uLRsiw22ERnof7MiCC7sV8X
 KJys63VedGJUUspMXpEQpZCJCD40THqzz87rHLaPdx5zunbLTjvZT+gdnOnH+FD/0epd
 c1UY+ma5Cc4fkyFAnf5cYlVnYASEdeeteqqTcyhrlondJ/F3U/NvLVJUwG/S6riJRUDl
 eLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022282; x=1781627082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoGAFSjXle/G/xJsDCtMxGFsjbAaOC8QDzGVKIdsCPc=;
 b=UtW65HBYKr/XuC3EY3aq2fj7/j8ePXknC2Hn/EiaPO0NlDr6yQOSAKLFpxEq3n+6cN
 gQ5ghp2aDZO/KhajaxWbsOlmv9Q0eEkFvjOCVL/dr3FYWeaKJcWjdaUFCwaKMJi70+vT
 t7ubv/qq39f/mcKopamOHom5rFzo5LkVXRHj8zkBsu4qIuFQz8As4KHWJ6YMIfDy3XIf
 9kAqgpJi6I6WBSXSQT/5n9HYsbuH/kb2d/FzvtGfUhboRLBAjYu0ZzpqDEtozHlvAGtT
 o01hDBizxEfBjo6LpmTZN2SUgNiT5V910C689/qI7XJVHI/VOcHlki2JILlq+vCBNgMq
 XM/A==
X-Gm-Message-State: AOJu0Yx1lsp6aSDE6BPdmvKH7F+oEvA55Coig+8g+oNoBZ8uQKdjzgAb
 j9+TRvnj3x3W6rhrfNqp3bvsBdZS3hDZ0BaApeUw0EAFkzDW2zjsAZWomYQtDMNI1XYKz3HeHpe
 cUeuUcCqYdAdIodtVvoqdIByro98rOs1bzXGUv/tNZmsEGb2Ca5lE
X-Gm-Gg: Acq92OEyp833pByfaZkVzKdWPsbC8aFwJYOhqNepQDXGk6B1gYhMRsw6craD0oo584K
 JSCRuaemY5Cww7gJ4cpSBbX5uXnBEC1y3iaoTgsOUKrd/ti6FaDpS6Zpyj2apmneFWeM/YuulCe
 RSKxNisjMvpSsB/5duhGLupQrClxpTLPijsFhzBmPbfiJks2rS4aMBnEt0nNVy7mNsZAikwTD1s
 PJ+8RoUXgjRI8rTdW9R9zw9bCYPvsW6vpYPZaziYnxaKMl1LvIaXjpOdRqadvvZJENcLXD26Q1p
 MvJ9PJCVlik1cb23CnUuhU4R945nM1lLkSacNDBtXIdERMNQOiUOWyOl2n8jbrHTUcPCvqMmT9x
 GSg==
X-Received: by 2002:a17:907:75c2:b0:beb:9be6:f249 with SMTP id
 a640c23a62f3a-bf3737ea2fdmr748068766b.47.1781022281874; Tue, 09 Jun 2026
 09:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-46-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:24:27 +0100
X-Gm-Features: AVVi8CeX-yO7oS88h5XGZMXhbwFakSiXs38MGDlwdzHPb4P20rGbIB3EKid4Lss
Message-ID: <CAFEAcA_asdN42t9ccCVGc8FU+QS4s78PQ-9HOrncGeUTDm7i3w@mail.gmail.com>
Subject: Re: [PATCH v9 45/45] target/arm: Enable FEAT_F8F16MM for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 3 Jun 2026 at 04:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

