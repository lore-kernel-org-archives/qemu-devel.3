Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA25C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESrb-0007N5-So; Mon, 12 May 2025 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESra-0007Ms-KZ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:06:34 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESrY-0007Js-79
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:06:34 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7081165a238so34050797b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747055190; x=1747659990; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mcqrijcrj+wqyoDBSpD2XmjCrH18wH7rCt3GL3b6dBY=;
 b=fZDeHT5Pk2NwNqWf3HNtUaROfE+x6JhQb3WbCb3Tzw6LYC6rWRg0+kNZ8gn97Ov3sr
 VWr4fsK0QOiLey3ta3BEjF/qGp3Z9zR5G7xIG1K0CJTotSkJNse8z0uvuMKKDQjC1D5k
 /knQ8eYN86F4kKT5xHAqzBgaS00tP5vpTiEkW/25oOY8Cb91g7ulKeEvC1enptur1Ltp
 FhYtogsqQnZH1Q63PF5Wddri923e7o2rmR55dgpGMcD7b1CCzSfOJ62lhMhN8OZSueIh
 dzgKjlJzw4OQUlM1I/tk9rGJe06tr93Q/VNXmoUHKNw2pOisqK7ti2GWLZlm6wMsSeiF
 3Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055190; x=1747659990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mcqrijcrj+wqyoDBSpD2XmjCrH18wH7rCt3GL3b6dBY=;
 b=AX339WWbIwoZAoRLU05vRmbq7RIP2RT3vT6gDaMMxSpDX3pFcTnznIecOgEbPhv+3w
 0a30LWK02T2Yb4ZJX1ApXNFgnRjFc8Sixuln6MdJ+rQBMZivEdYu8gMv9w8f1CQyreoq
 G1oRnyFT8/T3yZckHarjA3Il/zfmrI/fy1TygEbxHO8XLQ6WrHTERPF0mp1nC/ovWH4J
 Oth8K1MX8HiFP5qoDhCRNq1zR2W5Gjx2ZK7cUU1uhOXe4BFlGaYdRFWl2BVgWFQW9N7f
 hEy6U3R+QdgJzE3N5A4cN/BjzEmPDJEo1fWl3smF4mIAL+sVUO8C1Dc/HNCiHsN+BiAn
 aI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBFlwXmkkAaWJ/ZKoXUZC/rt3Kj33KnO0gcHIKEtn0JJlY7lf728D0BA10l2+rZEFkj+cPQTFfkMdE@nongnu.org
X-Gm-Message-State: AOJu0YyvLhNZofzhT02cL9pipgKq4Hhv+SOeB3xTYPUL8BXxMuocOPyH
 C7i3NNkIQ2mf4ig/2DWST8Zw3IYkYNi03km7frph21yYa4EXZXXtQs3zk3jR6347LoPrC7N41ay
 08o+Ov+7Il6qsp5Vg49/wZ6hDgy1KnkyKfB7DBQ==
X-Gm-Gg: ASbGnctk2doT0jtrJRfOYXisfUGg44miGvrMMC8VnXeexEqJy/p0Y6EctoFVvRNnWd1
 OZkBs6w4KaXw/7+BH/Jc7zFHhh3OnSzrrSo9F2/cxN0BHymLiyt4xGjv6JXvkL2GLFhOkz/4Q9F
 QC30kNKxP/htFZRy8fAmpfvARBdMTa8T/SDw==
X-Google-Smtp-Source: AGHT+IEYoP+VX9OBi5qtwD9PSdVbch5+jAmgOVTP27NAFjrveE97AOjPmPNUHI6QZsJXFPYnluRBKqYw/AJ4/pxUnTA=
X-Received: by 2002:a05:690c:6c93:b0:703:b278:db2d with SMTP id
 00721157ae682-70a3fa1b6cbmr178810877b3.12.1747055189837; Mon, 12 May 2025
 06:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-7-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-7-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 14:06:18 +0100
X-Gm-Features: AX0GCFuhAuT2iVB05N5VxRZ14cgtzmiFTBeQmBwd4A2frkqweMJRRHytCZEsP9k
Message-ID: <CAFEAcA_aq+gDdoeNR=rFCUecBufKk9BW2yh1-TiNKJyztvA-og@mail.gmail.com>
Subject: Re: [PATCH v4 06/22] hw/usb/xhci: Support TR NOOP commands
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 2 May 2025 at 04:33, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Implement XHCI TR NOOP commands by setting up then immediately
> completing the packet.
>
> The IBM AIX XHCI HCD driver uses NOOP commands to check driver and
> hardware health, which works after this change.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/usb/hcd-xhci.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

