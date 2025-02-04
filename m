Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E12C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLDj-0007cV-5Z; Tue, 04 Feb 2025 10:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLD8-0007NI-Q4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:51:47 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLD3-00005t-UW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:51:37 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso5154262276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684292; x=1739289092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aiz8cM2JVtiJdskRflZqDB5iL8/Yg+UJF02tsi5pGro=;
 b=qX9GEsfEnzeq6KPT/P9jwhj6SH+IWgVXbgLpyp5yk8FQq4nzh3Azqkrpbk+JB5PmDm
 XAJO0Z8oQNQbjC8hHnWfKW8I1BeIglVTL76TvUCU+wn29axalTq4Q2rvvNRS4wcr34c1
 4+1W2Nyrr5BMZagMH7MlyaoxDLpyBDrEkhlYndFkc/ehNPvcaOtA8pUqj/etPk5f9MZj
 MhuPoB+nMs9Lrf2U4erdfxEDA9FQof4Z7OL+8jvuOAjDVFZuLu/PgPMiego4OS0yJ04w
 g4wQAxSJIewUhHSE2Ak+7ogHidyOPbyggv8VsEzPJut77kKIyzQOANu3mn5mo7fmzAzX
 4xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684292; x=1739289092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aiz8cM2JVtiJdskRflZqDB5iL8/Yg+UJF02tsi5pGro=;
 b=atJDq+3phQcvbzJsHUcClJK8I9AbFyNaUf6cLRPXa6r335f+uFdhaA4s9Xfp4Er1rl
 k85aonmue+D+GTXgvyWsAdTj4bKuDzlipZ3cuFNXoRgT18JkU/vnMJ96vLJ9AjLaIxVe
 C5QFF1Tchhuj4bZu5Lrz0p64S+RppoEEsWjKIdGVeqm1TNDhbV7gM1w/3CT5kM/baPPO
 sK1f651169Cb5CTHshh5ne3ruKsl3twNFhqNZHXmGLq9GoJTRy/EQakadc353fxlUDm8
 +6r8g83WGC9X61CXnolvxIO0gGOtCKjOBk1r6nAigrXjvCkcSWsoctkOJT4MQgyg+4uM
 i/nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVhlb5HucGq6pM7+YgzblXCVqjNqcDt0mvwwLU7f4cN5XW0oVy2TQf4002mINwEUMXtGgIEuhy3mNi@nongnu.org
X-Gm-Message-State: AOJu0YxHKYGPj5/YQkWqMHd5TxcOyG8sSILyQo7As1k57Q+VahwkRofJ
 UZyTkfML6r5lPiTpaQsvrMc+teYF9sp65o80F0ZjJe/oM862QwsdpIxtV6IPUuJbeLNyuXeVbU/
 bobeIk7OD6YyzraCBq45/lyDtLjrLmoGMGYSf2w==
X-Gm-Gg: ASbGncvczkCRns1lDKo0RIQr9SXF2u056GU3JcDH6rr8e8Ki9+qi80lQ6Fxw7iXQ8ps
 GCFc9NUhyrO9suG5neHG9lgxc591ncZbsTdQ61i9VdygK2Kgo2FCwGWvhwu4c9hIHsdr5crG13Q
 ==
X-Google-Smtp-Source: AGHT+IGUODkEWGh/e3dXB5aF7qCh2YmqRa8gvpgyD6jnDx5G2/i+FEGfN+QR2XkiAFyEwWIPVOfpbw9Lz1HZAhgJS6Q=
X-Received: by 2002:a05:6902:2742:b0:e5b:149c:d8d6 with SMTP id
 3f1490d57ef6-e5b149cd9d0mr2459529276.0.1738684292474; Tue, 04 Feb 2025
 07:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-10-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-10-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:51:21 +0000
X-Gm-Features: AWEUYZnMHclWGEgJ0GTYI0grNY_8QSAsMTVTPFUC7t3LHoJ52QK8LFSmeunB7vE
Message-ID: <CAFEAcA8rmyf1GqPxz-3ed5GEzfpHkYCPQx1qf+5KDavnV+QFig@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] hw/misc: Store DRAM size in NPCM8XX GCR Module
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> NPCM8XX boot block stores the DRAM size in SCRPAD_B register in GCR
> module. Since we don't simulate a detailed memory controller, we
> need to store this information directly similar to the NPCM7XX's
> INCTR3 register.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/npcm_gcr.c         | 24 ++++++++++++++++++++++++
>  include/hw/misc/npcm_gcr.h |  1 +
>  2 files changed, 25 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

