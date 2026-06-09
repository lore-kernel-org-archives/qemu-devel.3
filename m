Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D38ECD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsjQ-00010Q-SZ; Tue, 09 Jun 2026 05:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsjP-00010C-OW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:26:47 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsjO-0006U4-DW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:26:47 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6603d8697d2so5336385d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780997205; cv=none;
 d=google.com; s=arc-20240605;
 b=CdruZNLC+WT2v+S51lattFsANRY/1qZ2dsTEzpKuwwfOk7aaCA9R/FYf0qnQD8nuJK
 T2p00ob5XVMIJUD078G20H8ZuqcAUwPKsMUq0bm6RfLGuVsR6phnMjzPI7zK1N6rRCCy
 P+biWEYmpbv87dFZwKj91gWvSxIgGtc8/j8qm9vSLbyLY1KV/Ubak9iqxzYkrHX+uB5Y
 1s8H+4kh5ezPQxSGmP2sh7RN24L1AyKJgYfKhxiGjcXn+UsEO5jH8LperAhILMOURDue
 Jla+WbGtXO9Kl0quzQducqgbmB3kfqdYVPne7GiXzL80AEsbBODXY6Nmoq0ur4o6RRKi
 Yl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=clBCTdTFpgrBzfJHgv/x+yOCluBtetLKmo6yncOVsSOaABxrM78hfxQd0XHcuHA4/O
 fhUp6HyEg+CjVAt1QRvwcnIsm0P/sBkj30+oWzLeLpSZ9koDjWY6mDUPkyamvur+zURe
 KipeTzHpnklvrEZDmgODUL+ZoqaW83pkfGI+pMG1TR1Mcaqa2PdLDoGTXSTB5K+MrOkV
 QLz9tD9dLFrGYdty1uXtHFJ5VU0uMtWOLkBNkNrcX0dZiEbFsLbjZISxowVNaG1JjQL4
 1KlMI2pRdfSBZ6hvlNEgPOnVSFjigW5SFmoHktR7Xp2NeLXp6GNm1JOw6UyJljO2Ckl7
 Sdug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780997205; x=1781602005; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 b=R7G9X5hIu7Z3O5hiT2GL5ejOH72AUv/2loxuR81bYN/EwX+zu+mByQO2T3JG9BbrTd
 kWbP6Q/71Qk3TWt+tdIUZbk/ezdx7ZQ6uLU/q08gbV8gUxzkpREQZBUoelrH0h1n8a5r
 ooV+onCUnZfkUS0mwC54URtaPfC2CcGvb+XsYwa/4L42O7aOxhMVZOZ1sB+ty38z2gVV
 +e454pNEfQPed2TgLeffYX0zCfBaZRsj4bA56vK6MQZwhOUcYwnkJg8aVAjm9afh8cWz
 vj4woFXSd2Jm+mRRZxhpvY0jALJtaxcr7Nl7TVvefmOS2wNlcBehmBtaN9Bg+X4n5CNx
 TCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997205; x=1781602005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 b=VpCA91QfJuSPZC5O+EONmXLjqAbuuNQmI8kg91JG4+YmYcxrsBGapC6JN/uOkV9qGy
 qQE/Lc7s+pCZ7cwHHrCIQ1LEMT0wkGcYCua43nLTHsi4lpo4IYfU9E+C7KnyLWttcCri
 dBZmqU8rfK/4WchZkdZhC/mMS7LRCWeLIR2FzBcyH8tEyfZT/aHjGDmmmpjv0jGd4fzC
 jz8+1FQsSHKtapwU6KS5tonqCy0/CZA7crwrLcbrluOgksQ5nBc+7pGMfukeVW0mZ4Cu
 aZR5IiyUkpXYsS2xCEAE93FOMtukgQNE6zCck5gwXerHM0WeVYXEbGijkBhCYUUWG/VP
 mx5Q==
X-Gm-Message-State: AOJu0Yzb9zH988SGl/GWBHS9NsRs/bbnaKx9+pvPCRY2QWuhExim8Qiz
 UyV5eAKF9BotHRyMUqtRDWlfYPfolDBkY8/AiD/HBvzXNfKLSEHl4FQfWG9Wk/pDhJirPu2L914
 fxfJcqwypszBNqCxmv4m2roeP7UNdTKqUY6pXsOxglA==
X-Gm-Gg: Acq92OH7Kpdr2KUMXaqqTv44my6wF3GFcfnl8ltG+pAnTbctrg3Reb3ShFKbAYCC+OB
 2nVQzbUAl/8Si8xpDgcF8jQIklCC0UIqizkwsYNoAIJaqEsGyItlvUXa2/jL18u7HgkAObEwXnB
 juSnjB9bR9+NJH4SfqTy0cNpf12zU6gWORuUYQiSqZn3vBnUiVFVz1TSWiOZakjTJuAKg1ioAFu
 YdMPn27ck/9HsSOamzcaBvKsf2vgzMxcgK4NBr02ejrUebbf5B2/Hd52VRLSdO9CfFBhKgN1ThS
 EKXZbjtC9PwTmldPJdF2ul3fo/+1nJzj87wl30h2NcoTrR1ucp/RXx8h1LEDBJU7zf1GwPecyIf
 C5w==
X-Received: by 2002:a05:690e:e8f:b0:650:1aa5:8594 with SMTP id
 956f58d0204a3-6614f80009cmr1452729d50.49.1780997204805; Tue, 09 Jun 2026
 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-24-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:26:32 +0100
X-Gm-Features: AVVi8Cca1su1Q8MFbFY3shS0pJ81iK_sgw3qIdq3UBnuaoCm_9TSUr0Bmd3VHJs
Message-ID: <CAFEAcA_PLmZxVA+VVFCWsy8Jrq05nWLH3AUTi4Xj8BXw+oKTHA@mail.gmail.com>
Subject: Re: [PATCH v9 23/45] target/arm: Enable FEAT_LUT for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

