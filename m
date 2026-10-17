Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38364CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5Kn-00082D-9j; Sat, 17 Oct 2026 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5Kk-00081w-Oi
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:24:26 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5Kj-0004Am-0e
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:24:26 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso3208177b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 07:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792247064; cv=none;
 d=google.com; s=arc-20260327;
 b=n8kRUjFI4+b5PTSaOnosenOV9dhW/L5kIRMvbWxuKECZYMU0eUtiYMHTxHkwZZepDT
 Zl5E3cAFVgT/PHv3kg1cX1rmK0EZJD4TVJG0MJFAf4cufFVA7MtzfFhfg0yC5L3dAQA1
 L1AN3BPxRcDuLSYZUyL+46T8eMFwA4XBJ7YXw/MqxEty3ygbku4Wbigq/pf3lqUbMbwU
 8+Kw3RaDEVQNI4KKPkzp0GTOC6zZKc9YLzvnJpF/WjC9THxsGKGiotbAJqlh1W1iDDPk
 EZT+KxjL/9u2m9jUxQ5s8/LsMHwXC+dT+sULMsymQRVFtJ+OPXRIb9aILP0OS77TTlGs
 GYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ieq3MEnIyhgTgRDAHtB/ZzfBeWohs1MqH0Kv9sOpM1U=;
 fh=yKIEDAwticMq3mqvUy7ZmP7nebdPEU0OfrEgfwwE5Ds=;
 b=JzmkaT6/P80N0Bly51v08TUSabCi2vyw/lBWRUVU+OzXWaNlBSFm+nc88rNl8H42d+
 6uvGSvpG24hi4qjgQms8ci6VjN4qgCsUdXbMFVKy/CijAK+uMznesHVk8tMojl0pIHyb
 GCpeSIrqUlVu7PfLrJa3dH8XDwNIpYe215clXSxTZ78+TQlCeosz1Co5hIymNSDGIAZ6
 WiovVU56M/6YY/YE6GAimRQWOvEVWBq4QrhpOyMVIOgskWd8UDXRs3+Fx9GYS4p0Ehuy
 90BWCSvjhvGp9Nrs+x0haVyVgBLFDj1C5+F4btTPAV+bB4BXdivWWN4BtCen0bXCc8px
 SzfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792247064; x=1792851864; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ieq3MEnIyhgTgRDAHtB/ZzfBeWohs1MqH0Kv9sOpM1U=;
 b=EDhtaKxfOIMtbvtQmTCC/0I5E7w1CoE8ozmeyIj90qm2oUhzxC84vv4HYFQSyNk26z
 iqq+1yOHfVQ/MRJqAoq6bEZwhof3IoeQ79bMBcIeZr9oDnYoWMjIrQFMxGTeUg2VOgWe
 nw+/p13/vbvE2stk4Wj4K/qCm34RpLM9spJInDXC8iwRgbYTXHIF70baq0HwcE2q6j2p
 RRje6c6xnNjAqpWDSrgioRqoCk+pLEWGzgi7K2sX1G8Mo/ox15fynZx5qLtuUGp/58MD
 IDVNzBxkT4NDlFOGyxlcWr2OQOUp5oPyYjXze+5Yf1jWcCFT0g53WERI2Xnaha5fnpLc
 P17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792247064; x=1792851864;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ieq3MEnIyhgTgRDAHtB/ZzfBeWohs1MqH0Kv9sOpM1U=;
 b=vCtefhhPXrdKBSQFJAPF9BEP4GFH5D1qJ0xivRqn0j3xabxmF3g+5o+p10SEFfaZBg
 FnZYgpgkZ0dbt/LRBnd+447OdQbcCypy/xxZDGMmtqquP+E0LE6xtXqksuKO9HBcWSOQ
 zgSF61oKp5Tx0SUxXhWY+CeVyqSbPd4AT5ei/OUTBy1Xh2dHssFiimEhkz96AVKA0O19
 pN92h1lTYzMV90tWT2HhhEPq/+zuJbukgq1bCMDOg11k+FB6gEhlYaVbTRDm+OFH+4SB
 YQMu6JYleUecPtkapG0nwn4phtOaOa6iCMnrjquojnnUriyXKT27y9k73ne4MK9EZ0QT
 TnpQ==
X-Gm-Message-State: AFq9FYKvcCZ6J1fWZXd+TTbOnd3ql6rp8nxpPcyuwcwvPhDgUXJNpEvE
 rHXpLO4p3ZbNr0a+EcPA5LeWBGUigdP18TiuckD8KhGvhJKpDTcFpcC2dDW5IXtdmayI2tuRN2Y
 llBTyXbU0FSWEnChr5nHikwGhDaAALneoer5iAXtBGA==
X-Gm-Gg: AYBFou2rlnZCIZvGs6JeqVWJmRueJvV3xOuKllsfkYDiKId4liUNSKvKglFgNQqJicj
 6op/JiX7wsvW/8IOxk7VSO1AiDdlKJQns7SJZwoGeZ+hB5IPa8dKR98n8bFX1/a1wvHTa34NgtV
 Mgii3h8sfFBPaP+gOtHMnqV1qx30KGMDtIBTA0WPqXsdPgXTYl4O2BFWIn195Ej8FW9wBILf8iI
 nH7Au7IzcFMtL+I6S17Cq/wxrkyvHsk1UYTOkrkHE+OSymtHxImGYiSDPfrbvWGkgmyH9aZIf2Y
 7JwVYUwMPEp2Dl3WsDiIyo4Xvqulj6vtJWLji6LYLv1w7dbOdf8i8t4l2cxPtj40I96PugN3X+J
 ZjXKgdVoM+Nowtm7XoSAuYlFeIAHPDfh+SIw3hvw=
X-Received: by 2002:a05:690c:fd2:b0:8b0:ccc3:27d2 with SMTP id
 00721157ae682-8b0f2176552mr11256367b3.29.1792247063433; Sat, 17 Oct 2026
 07:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8qQ-ORtpoD4xsytbqFBOi0+cqE5Bkbv3m6mi+ZXwxm5Q@mail.gmail.com>
 <CAGaQodKNRm54DnrnaS56E7YRYoss=Ts1fEP5oayqik3T3bTd+Q@mail.gmail.com>
In-Reply-To: <CAGaQodKNRm54DnrnaS56E7YRYoss=Ts1fEP5oayqik3T3bTd+Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 15:24:11 +0100
X-Gm-Features: AclHuK9GPrQI8kknDtNH2JGVnSg7NN9PVRcf3lEc_oVa4aCvpimBYjVSyuGLDb4
Message-ID: <CAFEAcA85iTUU=Pf8h-Ojc3jiBbW44V-1XRheVW=JqN-4xNLc=Q@mail.gmail.com>
Subject: Re: Re: [PATCH v3 15/16] docs/system/arm/raspi: move PCIe/GENET from
 missing to implemented
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sat, 17 Oct 2026 at 14:31, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> On 17 Oct 2026, Peter Maydell wrote:
> >
> > Do you know what's missing for the MSI support to work?
>
> I think it's the controller's built-in MSI receiver, which we don't
> model.
>
> From the Linux driver (drivers/pci/controller/pcie-brcmstb.c): the guest
> programs an MSI target address into PCIE_MISC_MSI_BAR_CONFIG_LO/HI
> (0x4044/0x4048, bit 0 = enable) and the message data into
> PCIE_MISC_MSI_DATA_CONFIG (0x404c). A device's MSI write then goes to
> that target address (0xfffffffc, or 0xffffffffc if the inbound window
> extends above 4GB) with data 0x6540 | vector. The controller is supposed
> to catch that write, set bit <vector> in its MSI_INTR2 block at 0x4500
> (STATUS 0x4500, CLR 0x4508, MASK_SET 0x4510, MASK_CLR 0x4514), and
> assert the second interrupt of the pcie DT node ("msi") towards the GIC.
>
> Right now none of that exists: the MSI_INTR2 registers are plain backing
> bytes in regs[] with no status/clear/mask behaviour, nothing in the PCI
> bus address space claims the target address so the device's write goes
> nowhere, and the "msi" interrupt isn't wired to the GIC.
>
> I think it needs a small doorbell MemoryRegion in the PCI address space
> at the target address, the INTR2 register semantics, and one more SPI --
> on the order of 100-150 lines. I left it out of this series since INTx
> covers what I've needed, but I'm happy to do it as a follow-up if you'd
> like.

So if I understand right this is because the SoC doesn't implement
MSI interrupts by having a GICv3 ITS or a GICv2m, but it does it
in the PCIe controller ? Let's get the base support in before we
think about implementing that. (The aspeed pcie controller also
handles MSI interrupts, so we have some existing code models to
look at if necessary.)

Does the system end up with the "msi_nonbroken" global set to
"false" or "true" ? I think since we don't have a gicv3 or gicv2m
we ought to have it still at its default "false" value, but if it's
false I'm not sure why we need to explicitly turn off MSIs
with msi=off,msix=off.  (This isn't worth spending too much time
investigating, though.)

Anyway for this patch
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

