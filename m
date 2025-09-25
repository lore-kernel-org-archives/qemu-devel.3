Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74C5CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1p1f-00086S-3l; Thu, 25 Sep 2025 12:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p1d-00085N-A9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:40:57 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p1V-0006Uq-2H
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:40:57 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7501c24a731so11279747b3.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758818438; x=1759423238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1SrA9qW8iJXA9m4RI6rO99YKCYpL7/K1t0xvBg+EYg=;
 b=K/tPgmuLFy76l9JQNPhFForyRP8Sd96MXHMKpA3ttNS0mZ3uW+ylCXjiYIRI7H+fec
 EMYNlDB0/WEgcMert3p3zDkZej2ro7j/DuSc8UaczKo/CCewc75CB6bIjxqhWoQHPidg
 b7wTwSjuYuQLQFATc/oHQ9OJRb6y46Aq8Bi9EGNgWaRN24MywjXRKS3g3xqqSByEaxzR
 Zsvic8Ph5reD08s1+sJsFN/zqj6KPN6Gv0zPVf43kBOF50N1cLs/5oXV5Hkh4+pg6rAN
 v8jLCYYDpXjkklK5XcTfkREf2vaFnMetF7Y6E39rMDhieKASYHUTeneT5DySSU+VaxAX
 4+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758818438; x=1759423238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1SrA9qW8iJXA9m4RI6rO99YKCYpL7/K1t0xvBg+EYg=;
 b=Jd8m5qFKHNCMmEm2ClGZdi7CiqtiVDILR3iFHSaugR00/du0bUdPK0RIdgwCPSBkvB
 OO4ai6n3vwg53bnec0HJPQOcKZ0zZRuePR9Pt5WtSIiNAXo4yA+GR8lbo1FEYK+Ogk4H
 yFg1FAVxNSaY6ydeScTBZYku4Hn/16UFYaBvNgrC0Rz2VDupGLKOFOWXVoaT8Glc0dGF
 d7gpd59jb05EmXRop2sM+64eqk3eUsL+xrLn/SA40c6EN4x86pEmuAoACszduy3eR20O
 ogsqj9JrWkgg0vWxLivdX5IH25uT3EWBhF+i7GAJAY+jtK7RVpeVK/FLAG+txKMVDTaR
 KtsQ==
X-Gm-Message-State: AOJu0YxUeLPXh6VmZrpLIudH1Wclwo6E0ZrMSAivEJGUGwoMWrNlxmWk
 527/XkB1d/jX8pKq/YjKPgJLdWGkvQoEJRcnR6yJpdtw1OhZDWoTQpZnTzdshqxMXkjNSIr59e+
 EyAGGoJ/HZb/3TK8TI3EYTgRP3Wg40G/JaljDGNzpyA==
X-Gm-Gg: ASbGncuyGNoxkKznTg8vx6HkGPtioTc6y17GPzWwf4u1U8e9I/2B8adIQMKaCFnox6M
 WasLLer8KkcyhPZc2C8uxBEMeRtAZLzVBPz3pg/5Kk8PAyBz5POFSydxj3AiL7o9KsHQkUyCXi4
 ZzKVfONYmzIlffSp+4G+fYSTNPQyPb/32MemsLlZOsgVl2M2/HD73Z07Qksr/NiDbEtA0tA4UNr
 6PrRwOp
X-Google-Smtp-Source: AGHT+IE0EF4qIw6rBhJcAzpsoAbpdzFxHqkMobJTpgmkt9iUdcVfN/APYfvZrWkq8uU6RM5M3ZW123DBfQRvhWaXDD4=
X-Received: by 2002:a05:6902:6c1c:b0:eb0:7c5d:6a8 with SMTP id
 3f1490d57ef6-eb37faf44f3mr2977778276.7.1758818438093; Thu, 25 Sep 2025
 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-6-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-6-d85883b2688d@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 17:40:26 +0100
X-Gm-Features: AS18NWCH_gG1_2GuTQD-5iyF6piN61m1IS2b9sKVaWj15G-s7kMV7UB2Wy0KPyM
Message-ID: <CAFEAcA_Lp0hv_b726pSZg9CbPZrxEZ1gShOz+kJZuE2x3TG+Mg@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/pci-host: rework Nuvoton PCIe windowing and memory
 regions
To: Yubin Zou <yubinz@google.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 9 Sept 2025 at 23:11, Yubin Zou <yubinz@google.com> wrote:
>
> From: Titus Rwantare <titusr@google.com>
>
>  This switches to a using a fully sized PCI memory region that's
>  separate from system memory. Accesses to this PCI memory region are
>  gated by the AXI to PCIe windows whose size and offsets are validated.
>
>  - PCIe config space is not necessarily aliased with PCIe mmio space.
>    Ignore translation addresses for config space windows.
>  - Make window configuration register writes order independent.
>
>  Tested with pci-testdev.

I'm in general not a fan of introducing something in
one patch and then "reworking" it in a later patch in
the same series. It's usually easier to understand and
review if you implement it the right way the first time.

thanks
-- PMM

