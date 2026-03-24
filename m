Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE0E9A75A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ygS-0006hM-25; Tue, 24 Mar 2026 06:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ygP-0006gv-TI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:08:21 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ygO-0003iL-Cj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:08:21 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79ab3e26cceso10618407b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346896; cv=none;
 d=google.com; s=arc-20240605;
 b=L2alqeU4ufYqtt+5jR6S3o4y75klXQCdHVC1XYiNU0A0TJekMTIPmlhlnLoAXPtDAG
 F6KCrldTbzNnS4XM29eCdo0dwdT2ubuQls5A1LhCQLRxs5xDnHSv2eFGOgbkcOLe4tTF
 hxRbj5d9w1/yyY/mA0hOxcYmKLx/+kvVqdFWkkFwtpJ1XkTzRiDnGx42MfxzAWEa9UiE
 V6yCRyAbay25Grm5eg3o/IPul71ZzmGcC6XCAM00a8ZLssatCsNx+73HVxN1AmMrJ17D
 hektqBDsvHs0iWPID0UTkbnQm1N/4MArinSQF7UP6K24yvYslsbutBan1oPMrKkrZeyU
 AY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FiaTLq1M7Doeus9DWJbUnATXxFxwPRMeeYczqh4Kd0o=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=FKEHK102U/0dwI22CrGiTPK3dr5yPXEGedo4NAlGoaNXm69jiMN4m/qrPyyQX6ImVn
 AdjnDDlWX4KmOP2ySRnw0VlL8ckqoSHG6acIW3PcQDl+SLmH2heif81Ke7RU+g9c2GP5
 RJn0iZfJr2mwNb0NSv8Hlyq6C4fd9KwGjHCaXV/iK8qKcnf4ERel+EU917BFg3RyPbdN
 ceEZQfn8g9RnXCFwjxNU3jgg5RxGDLhrtodZV/69A7EUbPYA0FLpRRW7cC4B3GSpVI2w
 V6BAL9qcnFHMR9zrqiE4TC6lWktvTFVEBcaOrEEeRqnXkxL5Yx+RKjpHI/Nru4cJm8+r
 LFIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774346896; x=1774951696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiaTLq1M7Doeus9DWJbUnATXxFxwPRMeeYczqh4Kd0o=;
 b=nks5EhTX6ZeTGydrGs7VkMfMbS9Btl9cMxPqCjlToSL0SzEliFmL+tJVWOj7hH5uIZ
 lq7YeE/J+TK/DBqnjMeDaUIU0Zr9wh8Vamh7Ufie4Rhq0/3Ng63Z1rvhL/7MNAYZNQuc
 7RQc7SiwE9et/shmLiwKcCJb1LowXpP90nnC063Ap0pUFZBoLoXaGzT5w/H3mX6T0GjO
 dzb1AK97yiGgQsLHqBRzJNFCZ7L8TUqs7RlQV02a3NOCYQbXJAtVwUSnSd/PKa9OmKPk
 Q7oLiGgig707idtsvQGphTqfP0P2fyHPg2XSnWrNJan6yxwOcwYy/S27PNeLJ4kJyH3l
 vLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346896; x=1774951696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FiaTLq1M7Doeus9DWJbUnATXxFxwPRMeeYczqh4Kd0o=;
 b=tI29lghzRlbRGJOriH47DZ9646sQs8MgPgVMgainquEznZq+I2ytODny6NjZ9fEDnz
 b1ARGdybE3HmFj5kgE6gLAuyH0QeKKwbFQJaYTAhWXmxjSg0YCzUGnnmM2yoIsAK8nQp
 KaO+5L0N4xjmIOQozWSPfYL23HBuBCuXOwaSX83YKyzj8TSKtm88q5J8Fifwg6+NDqb/
 nogAhdgtcjai36KHQJxxV6h31mNIDnYVWkkjyi6iwQlWOnUgpG5N+B7qs1vY6o3Zaw2X
 mCw+0sKS01jdftcWn+mIzg/UE0Qn1v8xKdd0S4aYQMF5wcSwu8HOkRI7oeXKDHGk1QdH
 fFBQ==
X-Gm-Message-State: AOJu0Yx6LjaGAD5z2DDYNnzu4XvY3609+eOqIBxNiUq8icHMQLMgZQjq
 rl0nU/Qnv0RsgwCVnU1BcZAxeqdbCv93jtNactX0mbjs7O4FmiHOOziGvOm31sKq5xXsi8Lq8lW
 5OVENX9ZW8Tnbeixvc5oHUzMNqNx6WQXOSyTSPLQwFf3Y8ml6/bGppZc=
X-Gm-Gg: ATEYQzx7rDvZ+0duNkXebuV7lAnBvpUdPpyNDZronuUZ5FFRCWO8jLLkHe/uQmMfwAf
 lEAXPDOnuUYhyUirwDM3reBpGAm21dpd/kak7PL7gSDQTAddpABQoaZsNiTX/axts66V1UZ5VU8
 zoWmKgPe9Ayc9Jvi7Ywi2e7idWY1lt3+xMDW7wuFUUqkwvNQP4DDm6kIrYjL9dlmhnMp812NgDz
 g54fpG5WMPXVrTUG3l3jRsDPjnbOFqphPPJOAKLGxRL/3OuOnLbEB36Z8jGL8e+6g3Iftc5XJTN
 5VG4jFoAaJyHV4aFEapOVMH6uT35lmI5F95W0xpXgdsUFhBIVw3iIEY2HHNKx2iRGJE=
X-Received: by 2002:a05:690c:39a:b0:79a:8eee:fa3a with SMTP id
 00721157ae682-79a90aef73cmr161342967b3.25.1774346896504; Tue, 24 Mar 2026
 03:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260323165218.96607-1-philmd@linaro.org>
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 10:08:04 +0000
X-Gm-Features: AaiRm52V1IWvlxxCEoRBnToxj60JZUVp2zhv0O1MUVq_7_aSw0ei502NgxMAuF0
Message-ID: <CAFEAcA-9U4_FT6hTzb69KOnqafsedy1xCqVoqtVST9WFfA3jjQ@mail.gmail.com>
Subject: Re: [PULL 00/27] Misc HW patches for 2026-03-23
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Mon, 23 Mar 2026 at 16:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf=
27:
>
>   Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu i=
nto staging (2026-03-23 10:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260323
>
> for you to fetch changes up to 070fc710251809c4d8d2a84f24527a174e843423:
>
>   hw/hyperv: add QEMU_PACKED to uapi structs (2026-03-23 17:50:50 +0100)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Fix guest-triggerable abort in FTGMAC100 Gigabit Ethernet
> - Fix uninitialized value in DesignWare I3C controller
> - Clear dangling GLib event source tag in virtio-console
> - Mark RISC-V specific peripherals as little-endian
> - Correct virtual address formatting in monitor
> - Improve error handling path in core loader
> - Improve error hints in IOMMU FD
> - Prevent hang in USB OHCI
> - ATI VGA, HyperV & CXL fixes
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

