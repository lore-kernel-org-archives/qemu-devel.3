Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C00C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaJ2-0006s8-Pk; Fri, 03 Jul 2026 05:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaIu-0006kD-1d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:35:25 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaIs-0003a5-EO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:35:23 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6662551100bso511377d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783071321; cv=none;
 d=google.com; s=arc-20260327;
 b=H88ipBfjg5lQNCN2OyUmPYCvbnuxvqiIndQZZu8ZtGMuyjzpjTyGvbAxlrmkh/slkM
 0rKfn7ICXQL8bzWpAKkolMvj7rryVZXpM2QM7Do/s9zKzQm7a1xT3FsjSgSu4WSNTf4k
 lrr0x33ekPMkb6I5t7oypJhfGjujVOLn+SoBHiymrqvLIo7VyIO6EEFHZQRDz0+bsNF2
 G7sEDk5fFMw+c1EnaHdIHBgnS2INubvinvm4iRvZJD9AQpIyFCQ6NrMqPOECZHJYxt4M
 W9Wzw1AoU+Yx6QReovKR5VzGLI6lS0uGEAoflpv6NU7LWznmaZzBlSAdD9p2YWqdbjzw
 dozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hioO9bE+1WS3nTG5w5OBsMRH2Z/v02bhxGRLciCY0hk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=r1d7VQNHnXoD5w6G7sq791M6OLLBlmRzrdlFxB74DrGnZDisU95H2uGvwGu/O19obM
 9lev5XEu2BeOPrY/PknGkW8sXccjSBnuUPhnzbMjW+QSYwp7dTEiKUequXLv+TYRbe1S
 ylUSF8km/xQd6fIk7b4tyRZxTEnwckrrKwDpovOsmyVRw2eNutyKNborjfEP7JPCQdj2
 cNyEsPjY8kXxEeZjK/bZrEGwdUoOO3+GpUrVPJWDWFxb0xqWlqZkkdnU2sC9Bro49l5e
 +zIm4TeLzGqZOYeWfQpzQFnaCSB49/KLPwYnnEV7mFIKtpYshFyPOFGcfEwrRDW1Z6nO
 bLzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783071321; x=1783676121; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hioO9bE+1WS3nTG5w5OBsMRH2Z/v02bhxGRLciCY0hk=;
 b=LMIpRI0VOpnUVeyeEme63KnW3uhUAeqUeLAJJcgMwJRHtIcbpj6k6iZQB0MiLmyyBi
 7FVPbfXqszqZNRJ3lGYv6P+sZx1+dhpKpxlarQAq4/UBYECc++5JG8C4BpD8AAN6q9w/
 dOaG6fuQcYAABTJbauunEaOqoJgoCHwlnC2DyRYBa/wqjTs5mLcHPa5TJee3SVrdLMwj
 NnqO+g9kv8YJgjGI8lFTQOgeS/GyAkeedZ3M8Lzlv3yv8VynHWZq8aJVWB+KAF/P8dAK
 oMWT0sGo0hDT/ZjhkvaeE6u/6ErKOwS45uhtrPqIdyxBEijyoUjq3haCHwyf7wbmMqAy
 AfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783071321; x=1783676121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hioO9bE+1WS3nTG5w5OBsMRH2Z/v02bhxGRLciCY0hk=;
 b=UdU0Nyi3BIN6T0d2G4vng0DYlq2S4vcvnQ0JucV2l/xPzgG+xi+G6BfJYZu5MalQwv
 2sIMZUYHw2SEFx8vVy9TxpRqYlqd0UXxBw4SVtrzArwEpEbMjfmz9Y9H1ezgnFDg5bRk
 /tMjt2VRbyuOcOKpgXnXVq6+rh0iuZalNGa1Gjt+wdQ+DcV2P2AxLxUcvRPPrp8IotV5
 ud683La574zs4PRTiLGpvWeHKifCcCYCT/wWPwBPIKySOp6UyvTIvQoLwzYxGzokuF2m
 MTQek1VST7iaJ9z5NFapiC6HllJp4w9oDa/K2wjO4eW1STmHwtQj9+DcyvG14xfrZGCw
 5TzQ==
X-Gm-Message-State: AOJu0Yw43gjRXqo7QxLDfvkCYAu+ViQEYb9CSs6Ugm8eqAkW48yOa38q
 rIqThP9Y54pLTve2K2gfjA9fzTgMrgu9BLy7U5Hc1D9b3t8qGd63Drl3YuvD24AshtOg5rMmmNW
 PlPiTrjRGeNWCQROkxwVzwBRr4eOYGERLX0EPF4YD0w==
X-Gm-Gg: AfdE7cl0eBaGUGlWVkws1IlrQXZIY9Aq+gSEvv/DGK04D4uXcOJWvZx9XPk+jPyMwNn
 WSLRYnpxQFglxPJLOfDSoJbKso+E+0YT1Njz5QBXSjII0Q6g729CNFqaxzMaSBHilfGC2o0cZtL
 26j/Xidl7hozuRVfT2iGshklpuXqFW+1l+/wHMnj7Udik8M1khang1GxrKwxMjmZEsG5v7SYr2g
 2CKKEZGbWmwwg10Afa9bA9U07/o2ybSGKyRqydsZvcZmh6LvQ665msYMs4+nzrMHfsFW8mixcvH
 SYsp1bFNPUoAisiDj9W3Bl7/i5/7JTGtiXDYSNzj2i5F5b3ixTzoGAZw
X-Received: by 2002:a05:690e:dc8:b0:664:ea4b:d1f3 with SMTP id
 956f58d0204a3-66521958b68mr8729832d50.16.1783071320592; Fri, 03 Jul 2026
 02:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260626164819.770787-1-richard.henderson@linaro.org>
In-Reply-To: <20260626164819.770787-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:35:08 +0100
X-Gm-Features: AVVi8CcT-XeltYJlb6jq8lwmOzKit5cEXra6MwfyCHPkWQNMlB0LI9wYMXUdm4U
Message-ID: <CAFEAcA-1+Y70ur4x6OKuOt_w=fY=Mnk72=Jy+EOr=bV9OUgKTQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Implement and enable FEAT_SSVE_FEXPA for
 -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 26 Jun 2026 at 17:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> v2: The enable test for this is (FEAT_SVE || FEAT_SSVE_FEXPA).
>     I thought maybe writing it all out like this is clearer than using
>     TRANS_FEAT_STREAMING_IF with a one-off combination feature test.
>
>
> r~
>



Applied to target-arm.next, thanks.

-- PMM

