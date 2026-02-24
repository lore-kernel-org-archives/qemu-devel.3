Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0627EEF5862
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvbI-0004Od-C5; Tue, 24 Feb 2026 11:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvbH-0004OJ-L0
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:49:31 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvbE-0002HG-Oo
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:49:31 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64aedd812baso5270476d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951767; cv=none;
 d=google.com; s=arc-20240605;
 b=acpem8agSlz0iGTzUftXl46/wzrzjWdLZw+X78S8dZRdOjBGGZSu4BaaQbLwkBEREO
 SHgEQqFb9vlgoZiPeOlIsJ6/93pGYxiUT/A+W2ttfofVIk7gUekhxlB5I5MUvP0f2Ltp
 c+RjptoezUh9GouQVRQkYKl+q1xJCMrnNd+6m30fGKV5BkoD3mt3zKKd0ojsmEdgkzvy
 KsGE41whCdGBBSb4zTkK6IRGmEA/1aJSYesUwHB0v5UuFlYcRDMC5pwtJwUctDXZpi/7
 djRq4p5ryTA3oSoeKuMURXVjT2EnjitZGOm9d8qYmiyfD0qVozysYhsqGDlodSUIr6ej
 S/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/Om0BAW+nZl2vlAqDqP8MUSZSRWzX+3bqPHNsaBfRik=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=NEMkbTItYMiblTWi+P0TjuVtJiOda5MUgZ5etWJIGeu0Mfv6BaV05OLkQtSAaWyBas
 t4BC6UCFa5hNJB/eX7xF4W+98pZYdBbkn9GqlADFxtBt7XEavgJ1fEXPXOpKT2I9tSEm
 NF5x75rQGXtDVt6BVZWDz5BquIjBFfvcG7lpCeWs5E5Z+panwmfVi8poJUxnIzAVNwWh
 p/4kWvSmi003s4LMsRp/qUoHs9Dnk6zn0pGcfKWXlajTYyZ2UMVCmXF+IXR/kkqawTnI
 k50Kgqo/AbHY/DYok9EVECQ29Kosea9BgQ3d7P57NCuVQGJ9a4+Q9G7ityrBXDfqg3lo
 QbIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951767; x=1772556567; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Om0BAW+nZl2vlAqDqP8MUSZSRWzX+3bqPHNsaBfRik=;
 b=FvmcZnydvK6aHtyQc5EnXZ7PXAVIzyDHGJlD1LZ/4pFTZn40+tQXyYFN53P9AVGD3N
 KMvNqEfJFi6XAwI6OnHizstzfjFelvl5fzbrJfuSInP+AFIKheU31I3CRYVHxlb6UlSr
 2Onb7+kMfeFy7HubbyQWzjrmJQXLjjio94akcw6hUJ/kdnMC5QxTt3Z6t1TqXwEo6F/Q
 LzRukdZCG9clFN6BaYqxhtA1uy2aWQBNNo6lHlT3MMQcXgTmAkAL9vljbIGByKwgeARp
 LAQfT4IBJHXEZS0tFaG6zNlcXt0kHIVyOyTD8Me54Sp4kWRvEqq6aMlWIEf7CgU8yPUd
 xTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951767; x=1772556567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Om0BAW+nZl2vlAqDqP8MUSZSRWzX+3bqPHNsaBfRik=;
 b=vsbV1+q06bPD2v2iunDrJ7Jm7noieZJQefClOzPkPuamDhvyXWQXZzfCWrZ77U8OFo
 JlaWbuTJxVS3NpzyI8gD0dKL0+caOPBbLia09mXkRdTCp6b1Ll+i5pCmFzv3w/AmLSiT
 /tnz73qhrwBWTB3bBIeXaJZLLT0BGS2+8evIB6n30p1lwxaKaqMz8iZmCzDAlv1oe8Rm
 sG/57Up3oD2Gf+d4i4DVyy0xwJDD5PdbH98xbM/DgkoTnjVaZH99qybETRqdSSiNUVf5
 FB3uSvf/BUiPVHyUwCA8IRmCD3Z7Z6ZkJ4j6NIJPQEGYoBWRlsYhcc6SYl7PlNeef7zh
 gTVg==
X-Gm-Message-State: AOJu0YwfU95MizV46VSHju+vLeEJYQxZCJuMJAOeWTOxjv/rd00begtN
 tIjmpY4S7wQMqZMFKkl780wgcSoS5GWJi4xHxn98pehYlINZT4g4SCK9ud0PeWutCixG/Gv3BWB
 fW1yssmgmJC3IyStEVyB1jidTuA80Hcgy8OeN/f4Yqh6JwYvQdiOo
X-Gm-Gg: ATEYQzzPupdgY5ZS+8OZe3xySKFCdLH3CEoN6YD5hYFYerZhKNxx8rtQNhAnVYamFJw
 sDo9r2/QHVDU9LL4k9503T4LKsHPXeJsXKdsUpOOH89QXhlBe8WU9YNfnyDVWP/v+3HoU7V5U68
 MhJBXinoiMfBbxGQS0KycioofHDP5b7JCEUHTXsgCu4qRhFZClYAV3qZGQWx2Dyj8LUd5n9vrx9
 etIwcajCrIaNJIsefuIlr5o9zYjIQ1EVLoNXnDyRScqqvEZn/75mt5QR/Y2/HLkGn97JQ8dEKE7
 0UealuohQcXZJwBAFjWt9PbxIls5Xtm375cN/yNPIpbTpuFU4qarToVa1ULBrFb9PY8=
X-Received: by 2002:a05:690e:142:b0:649:97d9:cf1f with SMTP id
 956f58d0204a3-64c78e3f750mr8816082d50.44.1771951767047; Tue, 24 Feb 2026
 08:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-7-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:49:15 +0000
X-Gm-Features: AaiRm52p64h1tb_bMMKx3-iy9hVu4zj_nx5Aa_6iZkWRX9VZWovIMpy0ai5NCYs
Message-ID: <CAFEAcA_TWTiDFNzCSQ7xT+6OTymJQRgvxCYaSc9HyPVOZJGeNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] target/arm: Drop kvm_arm_sve_supported
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function has only one real use, so inline it and
> drop the stubs.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

