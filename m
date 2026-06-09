Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C4CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzFc-0005IH-76; Tue, 09 Jun 2026 12:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzFa-0005Gx-GM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:24:26 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzFY-0004kr-Vw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:24:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bef47b1ac01so869112266b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022263; cv=none;
 d=google.com; s=arc-20240605;
 b=CQ5nivmWO2vaPRnGxrSme6B6aeg8h5kbAOYOypXl9+2L3yFU9yQhmsKuS315P0FNLk
 O5PFPy+LJ7x9i7hyaXvhs2pWZuHEsLWJBxKyvBtURqIy2HWx4OFfKoUS8B2kH8NfQMk9
 Yjg2YtHeVhuF28eW/51bJxX0mnQ7ayytIZjpGxSyxmi4t9gDoPWb8W96LEx8kHQmuB6n
 viY8gFcwkx0qHHGSbUpGYVm03JLwGNBgOWfvM1CMLHddDhD0tUjS08Kz7N6dnpP/J+pW
 NqE3HjRtIKhP0pzm93TzCKDaFz3O1k5QNF14hITJA/JRf/wFp4Rk8CaCte9HD3ofvG1j
 fcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ep1vlU/2XuMlZX+At9w8bi/PfPVWKQvWPJWn7IcgCKg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=P+dsNLw/ZTa/yEb53f3xSYAAQ42PtWRO8AXUDacEeEG/AMrwxfJmXdBzn8EkOCOeQh
 7YvJi30zcPkm+pN5ANicgbAULjVCtuSo5afwE2v8MOhEkZq88Ge0t8Ud3LVdDA9Bq/Wx
 ZKF4vZuJ3kmIjqp3imH0ZrUEBMCa8n607nHFNB537kOi3wo337qiLylOhQaQEfp3sDZN
 M9hEtPqwA/naHXN/HjtaWN4xASwv7aRDULFbk4Bd46uMwBH4eZzN2XcM/741+muu2RMb
 gsmmOUPtsEBt74NYvHJcOEtCuQV76408crEnnS5mbLbsiwTnS13IOCzRonuXWGjHOhLR
 7ADA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022263; x=1781627063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ep1vlU/2XuMlZX+At9w8bi/PfPVWKQvWPJWn7IcgCKg=;
 b=mQAwPws2DZNTOZSJK8g3YQDtYbJ6DuO0S4T6km3E778rZ2eTMv1MoLKCt40fNg/oRL
 rQsqHFcUONTBWFbheFcD03epRsxC28Rg230DZoaD6yS/PeOmoSeqvjOVBERfUv3RTbYP
 FAru+tFZrotLbH1pry7xKCUgI8N5pzxns9X4qGtHqB86RtmfPXXYRva23nBzGfZsr2Uu
 OXbQYGLKm3UOlH0Y9ZX/KdP/aSGluF05UkgPG9zgIOYrgy9uFdgbbCZEfGQkBlzq7HO6
 v5Qo69yca+blfKTQ+1gx8j83klJOL4KxZ2uctXt41bvZB7enqcGVfS8PUcf0PsJGCfFf
 iYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022263; x=1781627063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ep1vlU/2XuMlZX+At9w8bi/PfPVWKQvWPJWn7IcgCKg=;
 b=kE8x70IpZis/Ixaz5/JEpYaiyQmq70cA4kDijrvmPo/nKs/bXHG08lvnB2urCrKlpR
 Hu9Lx2Q2we+JzisPy4Ao+xYcAMdEjnX4bAZ+KHFHPYRnR8A0vJiUhoCpB91QC/TJN8hs
 lvku9ZHLtlT0GKwAHqwnNVzNxE+LpJhDX2PwK2dhZy2fjUiWm5DkQ7ffD0I5THa9WLZS
 dKGNfXomBR/Yh4hRU/O01QbNkPx5V3MJQ60Ggj6GW2jonDUwc2/V0Am/mBuUQ5UWj3ZJ
 qdvNUDWPRSUD2aCGvUIMEwRLXzuaarwGkmfLXo14y8g0e9fbvnwiT88Z6IpcQFn0IKZ6
 rhbQ==
X-Gm-Message-State: AOJu0Ywqilq/En4hT6qDXSZ9th8aFK8ukotCafTA8fCCyxZON7eYGafm
 fkaKnQZ0+VleIfewn+VqO5jOmVXJ5oH80cJEFUaT57FzBsSqhuUF19e73Y88hMbPrhwSy8sA0Ka
 BDjWLxhz5iYWA8QVFrFVTdtQzzGQWrfgJKRzPJD3xRw==
X-Gm-Gg: Acq92OEhB8g/OcNr4lgqMqHt/bd7QdXYQEzVDM7x6Xfk+pZ4BkibBxDp6QoOCSyGFOh
 yAnxarRTYKILDBbjIo6Sabyt6LghEaORZKLXbh9H3ZZar9lzTgw2XUdV9/4sNVWKVjIrb2VFm5Q
 gw8wAloeEEVf3wrx21vansESjvVqxS6YECbPSHmIIwWM665wW1Wl5M1J3W+PNG+UMNxdFsOEBk5
 q3CPuygVy3U/AwyWi++HuOgFN/P5lej93+IeENP9LrCL7C/87gNhf1Oz/oRXi0+3Km2VKujQg81
 6W+p1cyxFlpacylOX2OG8xfRTBj9f5LUExOzcC+2nbi8ZpzqVV2lTQUHfjxXAj2oJmR1WbRyHZM
 GmAULVCZfA1do
X-Received: by 2002:a17:907:9812:b0:beb:7b50:3a7e with SMTP id
 a640c23a62f3a-bf3733fbae2mr1020011666b.45.1781022263331; Tue, 09 Jun 2026
 09:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-43-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:24:09 +0100
X-Gm-Features: AVVi8CeuQL7mUuSCJ06g-VsMU8oqgdjJ0qk5__hWy1N8oQZAUOv3yQGr3cOtRw8
Message-ID: <CAFEAcA9q5ZyW0xFQbVJHdpcbeiToCPkO6RVcG4ATqGyA8aqXTw@mail.gmail.com>
Subject: Re: [PATCH v9 42/45] target/arm: Enable FEAT_F8F32MM for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
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

