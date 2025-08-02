Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B55C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIuM-0007wV-DU; Sat, 02 Aug 2025 16:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIrQ-0003fC-Qy
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:48 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIrO-0004Bi-FZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:44 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8fd59484f7so2247731276.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166580; x=1754771380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0en4Gzuhx1Wd2kc4Q50LmzU+9ZKRJuDrxT+ywYUqNdM=;
 b=YzQ9xVg7NKncZJ+aFjaQnNKSRaYRxJNKsynR21GyOHc4rj974EbwF1H2eqC2IiH7Ad
 ouO2coRHxk1bXfuYu/JUX1yaz4xqu/6/k5EzSQjtFPDmiFbnMsfmsNMp+2P1+biQQfce
 GcZ0eidp2ZrfAk564NVt5GmgHN1out9c0dCsVfS2ArVZcHhLuj17g+rwuPhDDk0JW6u0
 fmoqUfXKHEd3wxSNMDD0H77t8YtNmp558yNPkVazdKchORhmJvQf4E3cdpztOat3eqAJ
 2Gh1G6S5XavFiYjQnQZ4MlsNpLiAM/v9vczkuRmZrxCCxn72SGrhkCN53iadDvozbE2A
 gsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166580; x=1754771380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0en4Gzuhx1Wd2kc4Q50LmzU+9ZKRJuDrxT+ywYUqNdM=;
 b=IctDz3CBIJKncTvBF/Xl9zxb3zKcJLtKBMy17Yf6idh8K9/fYkIR8VZggw9tnbuCD5
 1o1AVUhMmNUzo1vNIleHKiUMncKSmIDa80S30IgDoSLhtxoLdANPjufX6TFb7ty0quom
 T0+HboVrfFDz1iYjg0PhMoeIgPuuwR0xHz54m8uUOT86UpSJHYqUFTw8AQgj3HBBv3Lb
 Axaf+Ip/tOERj6yzrs2moebHuTN5/1J04Jtj0GsaNXYhEGjabkWDwokgjHH3PfiMPwfM
 C6AmTmEjimAXBrsy5przf8kuaCWJV3rv3vNGNuqGJdH13dRR5Sn7LbFvKyhCiXKYtOHA
 SBwA==
X-Gm-Message-State: AOJu0YxKLIUUWIW0yoGuhusl1VmUEcsTDcG583UvL2Zqt0s4XjptA6LI
 Ivjlk2q+GZSDP/6tH9v0/nfyOlwTznZbja7B0RGQ27H5HSt4py8cMCGJkX4qwnKaRB8WhgW8Obi
 YVeNuBRyV7vFKyrWxdrUyL1+WCp/lP9Ms/9H04fC9hg==
X-Gm-Gg: ASbGncsGfiscj2ONBcAtFnO2aEhx081jUOTRfPbOyOih7sAa6wJ74dLBQNB1bkFVtMU
 EcNawoBzySc8/l9azV4Tl/w8iUCS0cVWaWxlrpJzBGy6SMIJDlAjo+W5U3RoxIu5Vd8Fn2BFnPX
 28K2LR/6eb7KrpmIV4Eh4rnsv9Z4Oap1L8iTKKl3RGRz+M4pTVpAbsWBEPL6JTNKlRmhZ/hAVDn
 sqtRdHq
X-Google-Smtp-Source: AGHT+IGjFvySBBM31LqFe3xDnsmljEYjBqyKgx94QtAVaJB5ryycu3g1by4fD+6QgsyfQuDHobZKIoSduRZ1963qfQA=
X-Received: by 2002:a05:690c:6407:b0:71a:51f:81ba with SMTP id
 00721157ae682-71b7ef858e9mr61573277b3.31.1754166580332; Sat, 02 Aug 2025
 13:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-71-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-71-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:29:28 +0100
X-Gm-Features: Ac12FXxZhcPusvmFxUaw_RTwiOtvZApg-j7Xz_ipf0S_hqCBVl6R1k34CA4nAH0
Message-ID: <CAFEAcA-UzTp08vKOx-jNapk=d4CG0CMiPaYT6pZz5Y2K7AvjsA@mail.gmail.com>
Subject: Re: [PATCH 70/89] linux-user: Move elf parameters to
 openrisc/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 30 Jul 2025 at 01:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

