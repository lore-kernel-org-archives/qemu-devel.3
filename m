Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A7FCF3967
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 20:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srNoQ-0008DS-3v; Thu, 19 Sep 2024 16:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srNoM-0008C5-BV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 16:31:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srNoK-0003rt-3A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 16:31:34 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so1734325a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726777887; x=1727382687; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cFrXKQ5JiyhgU/Zi4HUS2WBOPlgOdm59JTQ8J9ZsjcA=;
 b=EJjOiDVt7Ox/nXYBDTClz9QBxOhDJDgGBl6JNy0yUWUZrvp2NFDw8SLKruSQz3VUBV
 I4Pt6a6WskaDm0104xw8PRftsCeHuxK03Rh3uriTxKR9PONiaGe1SOMtZYS3UnUYvtMj
 aN+Bibj0cQVVw65ZIlh28MJ59eLCOHxjD85ISzxQHKYIP3aMRuGagq5O/G122FKY4gAR
 2U5NzXoaIICIVpHJQiTLGY0fO+l1aYZ6k50Q4M26x+oe5Ahz5jrrHdqvSaoCanHjE2wQ
 RiqQ0FHW5B/Nni/bxSNy0WaZiOPMGwJv8SBv0yZyuOsGbDJ+HjmxtAwZtr7pGaiLHJJ5
 iUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726777887; x=1727382687;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFrXKQ5JiyhgU/Zi4HUS2WBOPlgOdm59JTQ8J9ZsjcA=;
 b=mlqaXjb1zHbefBaZ4XbNxIBByM/tYOCQBfAcoFO2kT0PiQjCixCWobCfNyYhQJ4fBN
 N//zsZUgsfwhFyjLO5RXKvp7KcGKZaxTwV44tmYAjRph9sCFqwab+zib3eGDP2pPLaaW
 UdywP9qHLpCVZfNGXy+LxKJh2xG3lUIPjkSGJt3QGfXsxmn4Imp7fzn69c/VMHB4u1/1
 GPCUvMPaEQM6s8N3GAHKfRRBm25oJBm1T67l4yD42iqoqG1AdRF0gCSKpkIC+S2gDiDU
 9dhctsxClKlEgdaGmBaBnYZERVtiCGEQYsVdTJED/eB6uPzz5BEq8s4LujbWIyuwcTUu
 dyvA==
X-Gm-Message-State: AOJu0YyAw0eAika9Xcsx1tDcaolkpiBqghTJIYp3zkUIFpC3J8JdAq9I
 BqUxIk4JnZFTh9gN3X67atC1OFI7+WAPDUPn42Zg1oEavQIfEtPRfWyHcL3MG0+34CTyAUFpFW7
 4VaqwtnHXcQEGUOshCmTr95Kw83ISN/GHqjQLFO04WtXgQUsI
X-Google-Smtp-Source: AGHT+IFd/8UfKbyrzxAMb6Grz8mJ+C2pb/zwMUchGs0dsj4pVBjNuj85LkCYGRnYjqeBCmXP6zxbYO/ztGBux6BUKrQ=
X-Received: by 2002:a05:6402:278b:b0:5c2:6083:6256 with SMTP id
 4fb4d7f45d1cf-5c464db69d9mr239621a12.10.1726777887448; Thu, 19 Sep 2024
 13:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 21:31:16 +0100
Message-ID: <CAFEAcA9UK64Ya+hySGtr2vKMURbbWm=6VRwwun5XGPN=6=Kquw@mail.gmail.com>
Subject: Re: [PULL 00/38] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 19 Sept 2024 at 14:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 14556211bc6d7125a44d5b5df90caba019b0ec0e:
>
>   Merge tag 'qemu-macppc-20240918' of https://github.com/mcayland/qemu into staging (2024-09-18 20:59:10 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240919
>
> for you to fetch changes up to 89b30b4921e51bb47313d2d8fdc3d7bce987e4c5:
>
>   docs/devel: Remove nested-papr.txt (2024-09-19 13:33:15 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
>  * target/arm: More conversions to decodetree of A64 SIMD insns
>  * hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
>  * tests: update aarch64/sbsa-ref tests
>  * kvm: minor Coverity nit fixes
>  * docs/devel: Remove nested-papr.txt
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

