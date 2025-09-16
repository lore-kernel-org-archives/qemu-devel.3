Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61805CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyRDc-0004rj-Mc; Tue, 16 Sep 2025 04:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyRDR-0004Pb-9b
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:39:12 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyRCz-0006Qo-9t
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:38:52 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-72267c05111so39251187b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758011910; x=1758616710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nXUYlnpSXxiJOL7NcgpwOHUm4vgvpdIMYxgPw3z+RY0=;
 b=XFHPsMj8mOsOo5GJEGF4+FnlhlydQU633ZTXoxQfs6jtfl33rkvqoEQ4CmIZ85b6L8
 SeqKp9TdRt8tMtLfyIu4AfB0rCeKfouiM6GEvxQI8UiZeT11Xmc/QRypEkG2RoFDQ+ZV
 U1ue6QbZ/DW8TrXzaxIznNL1mcpYLVrXoD/ZTO9/dLj2WCbALW/IttO1Bi3HbIz6a8nS
 zFTRqRwn/ST950ZxRikEYb0ptnj4d4oJXYg0jd8W5Viti1a/krEi9n1DHZhbSNUEOtAb
 UmqFLbGtTJprsFr8wq5/dpdDqkNe8317S1KlW2qUqxBu5cQJuu8bZEK/JdYhsgkoMu41
 cMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758011910; x=1758616710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXUYlnpSXxiJOL7NcgpwOHUm4vgvpdIMYxgPw3z+RY0=;
 b=wpSPfazT+fQlCUVzVhW2BtqrexV/r1e2QjuKhsz2/3vgHiuNep8LRP2WPmpzKpR+OA
 1F2hUnVe3Bg8WFzEmClN5AuPgmvp0Ec5tjQVw2e/yswqkmd+dxydy5puvX1zxmtx8RAn
 ZkB3PpOCxSGGEe4Vu2qbiGNEZNy9KfmH6aicyp80HqMAad6KIyCsvv+r8yjkBmFR2f45
 q/BmB7vP7pzZp/MRzPQm/RhiiyIGmreUNaK6sRqJrKCF3J5Y9lBBGISuVI9NjJyDExwQ
 MvIGn1WuZnr016tPexgEn3ndK4CjBk9sVCgrgicJl6SthSA1MJay0NAQKJpqzDN2R/KV
 2BWw==
X-Gm-Message-State: AOJu0YyTWhKctB0gfPZQn4T+kqjDEr8MpMZezz5HL8aaQF29rnHLvgcF
 MAkJABX4POMTennvCJh1hq2i07+j84BuPq+/DIXj7t8KEG2Vm0goiklHj7Tn4FZApLf5u+in0mO
 oTBO9CkS7Vwt1lY0A00NDyEqyceLZLClmGhfBp9/PDQ==
X-Gm-Gg: ASbGncvbfRTY35zc8sozITDmE6UsZjYnj8wNLUoB5A88PZyHPNY1ItCpEOSoO17foyH
 K3lJblPV8Eqcjh1pRlBNUm7+vVZh/ubmQ1DnSq/SmtwFCWx4DS2QDFR+0cB4bZSTz75k0mcXFZ+
 kcXU46Mqy3KwA0vD3rOzIbcg4d/Bu5VHxSBjviL9m7eWrBMn3vqxSfLvVZSH9ZEbDn+Jhp/oJHq
 NPRJh9m
X-Google-Smtp-Source: AGHT+IHrBQlz7/Fdxv06eMmctttpp9NkMGIylulGPWLl6YvkOf7/ysjU3/ZWlDOCJ2OdN64Z+dKPnexj4It/HzCeo2g=
X-Received: by 2002:a05:690c:a012:b0:730:c83b:e9f8 with SMTP id
 00721157ae682-730c83c15d1mr114639477b3.37.1758011910099; Tue, 16 Sep 2025
 01:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250826205532.1500639-1-nabihestefan@google.com>
In-Reply-To: <20250826205532.1500639-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 09:38:18 +0100
X-Gm-Features: Ac12FXzHJ_6Xu5ABADwYfQUkLL5s31ax-cHt6ck1N7iPzUzOF147hVcsH1W1DE0
Message-ID: <CAFEAcA8zGzfh_b1UWAeTDpMi=z-KFVUgS2By6CgpONNMVjMP5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/pci-bridge: Create PLX Virtual Switch Device
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, venture@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 26 Aug 2025 at 21:56, Nabih Estefan <nabihestefan@google.com> wrote:
>
> Create a PLX PEX PCIe Virtual Switch implementation that can be used
> for modeling trays. This is a generalized version of the xio3130 switch where
> we can set the PCI information on creation, allowing us to model different
> trays without creating specific devices for all of them. It is used the same
> way the xio3130 switch is used + the PCI Signature information.
>
> The idea is to minimize the difficulty of creating different trays whose
> only difference is recognition by some daemon through PCI signatures.
> Instead of having to create 8 different versions of xio3130 that have
> the same functionality but different PCI Signatures, we create one
> general version where you can declare the PCI Signature information,
> while keeping the same base functionality. This is not meant to fully
> replace xio3130 since that is easier to use without knowledge of the PCI
> Signature, this is meant to decrease the difficulty of creating switch
> trays that require certain PCI information for recognition without any
> significant change from a normal PLX Virtual Switch functionality.

Could we implement this as optional config properties on
the xio3130 rather than as an entirely new device ?

> Changes from v1&2: Updating different formatting and API changes that
> ocurred QEMU-wide since these patches were first staged in 8.1.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>
>
> Nabih Estefan (2):
>   hw/pci-bridge: Create Initial revision for PLX Virtual Switch
>   MAINTAINERS: Add entry for PLX VSwitches
>
>  MAINTAINERS                            |   6 +
>  hw/pci-bridge/Kconfig                  |   5 +
>  hw/pci-bridge/meson.build              |   1 +
>  hw/pci-bridge/plx_vswitch_downstream.c | 188 +++++++++++++++++++++++++
>  hw/pci-bridge/plx_vswitch_upstream.c   | 178 +++++++++++++++++++++++
>  include/hw/pci-bridge/plx_vswitch.h    |  43 ++++++

I note from the diffstat that you have provided no
documentation and no tests...

thanks
-- PMM

