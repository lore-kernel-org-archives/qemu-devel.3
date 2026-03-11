Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD88112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Kyo-0000oq-CH; Wed, 11 Mar 2026 10:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0Kym-0000oA-Ds
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:56:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0Kyj-0002ed-C6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:56:08 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so13035437d50.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 07:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773240964; cv=none;
 d=google.com; s=arc-20240605;
 b=ceUohEXiuVFLCdg/BQt+iWaHXHfcl8rozlmNFnnqX5Vjh27DQIYI2puqqMKL/iaJ/S
 BPM7eXGhVHpNkEubv1iMRkq7mwkppdt7oCsi/KQuYrkOaMyyyEWOIif5R7YEzceCCY+J
 kJNXUmi/bMn2vNlQmLbkt4Uan5CUy/sE0e7zUXDq68orEUiEY4bguKlRYooCVF9y6Fbp
 XODOE3nfKgPChdnI9Pz1gO9WVjG2I/LorNccWdtes9c7X8BqUoXnTpiI9wHRtxFKkbod
 EMIZAwTOwdSO6fKtJma11xGAe85DQZBrTmcRDoc8NeXcSAKBqo6OYWq2CxsKzwCAM6pA
 6CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NxLsCpu1Jvyn19lFn4kCJpVqSeIcdgtDNIKErwvYAL4=;
 fh=e7IVetjFwnsGH9H56TNJrWXiK83uVjsWYlTdCp0OehY=;
 b=KEKs5U6f3O+f5UBOO+pLg7xp3CYMlXJTpVuzNnsEY0oH9ROCaoHyQAPtfhfcFSXczt
 eAyMki9U1ANkMpvTBxgNERkk7AR/37NL9yq28WFslGaqjjROzx2nU/+h91Sdn56Y0BEW
 NQk+G6ux22Gy/F2SeOI9fS+c6/POIvXsm4/uNzIWDRHatOSOFWDPQ18Kr8XGmSocGxe4
 sCdnlIRs0TnfpAoIYSz5f0CNuEnO3zUXyfTJ0cI01g5Sx5m+SLnYd5inKbDosaxXULZ5
 xylSvn0NvJJFC+rxbVU+E5PEJqQlUlqWuv7gLHYKoIWEjSmCrECT5Mw7JpD3/vcIJ1yR
 D96Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773240964; x=1773845764; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NxLsCpu1Jvyn19lFn4kCJpVqSeIcdgtDNIKErwvYAL4=;
 b=V3LVUtko2Mzx3tzZ2y3OeUzccWDq1sQ+1Nn0Tf6FWbTQsEAEZoj1F/gAw5s7zDGRih
 K4BTZt+hdymizXwn8Ano1dWnHzbdsOlMALcS7Ulqur3kCyM+hCIruGRL/CiSvpE1zY3w
 aPQD+rW1B6RtxfMnrAxjGZu5ju34WrYcLl2uOfcvG+q1itA8U3J8AoNAv7znj6YGxvBn
 yDSxuVPNuelBLoRwyABXnzYvPHXr8GnATf5h01+KOR7/BKzimbY8WY90OkkKAwZ9jSUV
 y27cqnUjisR4wrJfe5+kl+lH7A/AlboOj49LVnnDe32HL4QZGl6GyG3S0vyGlMb84PP0
 vOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773240964; x=1773845764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxLsCpu1Jvyn19lFn4kCJpVqSeIcdgtDNIKErwvYAL4=;
 b=fEwsZ+mPQ0+IQRvxKRSRXBh7mALgn4a4i70WQwFaIvr2P9QI6WbxnEOBUP+Wlsu0FX
 VbPlVjyvme9baIRPmcdwx7oGyZ8PRqMdBVBPymGGfdGjv9gc9zJUbk7MnLrVgiq6FI/M
 QoiIRFSJ4QtNqTsYsTLg8+oS9miULPi3psWWbpT83+EF5UHOrnnE1fvf9L/peTSfbp/p
 7d8yPKzDzZpvQEAaOm51JXVOsBwVbkb2kEZrNU0Zs3QVaecFXemZ59ttbVb85/XQT93G
 y8gPXniNKjli4DKGast1onc5Ov3x+Xe/aXk0lCfYvqKOY9qyIB8WrPZvJxQTrWphM8c6
 vGsQ==
X-Gm-Message-State: AOJu0Yy9MHzqXrZkStgWRau/QzL6oD3WuPOymYIQ1F/IOTi7C61kumXq
 4sBlyd5txxr/9Z2anJyxc03YoDXD1Lhm/EtWozgbaalRHGJslEQHLQWNO7uKnkfMTadflEWPe34
 km8zRQCtCa0FCHv4/QNhoTQp6qEFWDCiyjIraLz+3Ug==
X-Gm-Gg: ATEYQzyCVDiWcR/cQZacpY+93cz/gF6SguDjyLOjleYWmSBH0YUu00Lz98g++tLzK7a
 FCE7si1vwtlWsug7TSgi22sxM0iTV14Vd11rVa3bTPirA5+LxR4zLI0MbuqPPWGXJcndU4+oPvN
 iYF37DNfqgMKVFH0ALIpvNmPymZVBq3pqkxOlZfcm1dt6Ie7pNlg9M1+qYKPec+okZkOTVDD1qE
 MLhU6DV8YquZUTya05wy0lUHCqaJiDm1Ln8KkiZnMB4yt8pHoGuKolUUhFKg5/Om/SIqDwUAVhg
 lzuBpe+1Ec/K3S2zCVaLAJ3UoSDRU7+VJaIunie6dgHicPYFa9EqaP1RcQfLq12ddCo=
X-Received: by 2002:a53:c047:0:20b0:649:d59f:dccc with SMTP id
 956f58d0204a3-64d65706761mr1982199d50.25.1773240963909; Wed, 11 Mar 2026
 07:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <87pl5abgpl.fsf@pond.sub.org>
In-Reply-To: <87pl5abgpl.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 14:55:52 +0000
X-Gm-Features: AaiRm53zf7hUHlIbIZsFgV1GFUP4KwX0LwDmIzXdymr_Fpy4-TqEgYzBFLj7Pfs
Message-ID: <CAFEAcA_tJRFKGCFdG-x+QAwur7VuqZUqhJg_U-hKi1iym5=+Ng@mail.gmail.com>
Subject: Re: -device T,help crashes
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 11 Mar 2026 at 14:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> Watch this:
>
>     $ qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help
>     qemu-system-aarch64: ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>
> A number of devices crash this way:
>
> * acpi-ged (aarch64 arm i386 loongarch64 x86_64)
> * fsl-imx6 (aarch64 arm)
> * fsl-imx7 (aarch64 arm)
> * fsl-imx8mp (aarch64)
> * microchip.pfsoc (riscv64)
> * riscv.sifive.e.soc (riscv32 riscv64)
> * xlnx-zynqmp (aarch64)

Largely speaking these are pretty useless to try to create on
the command line, of course...

-- PMM

