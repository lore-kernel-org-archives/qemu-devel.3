Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D29CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk5b-0003iE-4r; Wed, 03 Sep 2025 05:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utk5X-0003Qe-D7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:47:35 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utk5T-0000q1-Cj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:47:34 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d603cebd9so66319377b3.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756892849; x=1757497649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6iwFNpEKksa79Ji7RtKq4u2zvwO0CP9q3R2wAD9kDJ4=;
 b=RZr0O6kwdIv/SOnqKqD0CaGic2TzSO6nk2QwtgHRza0HLGrrINcJia4ATqPceucR+r
 HJ2Y7jcH/EOToCinC0u5cr4kIKiueeb/1+QALe3AYl5/WqSwJJ7B69n2quKDvXK+frJS
 UhOL2msGYjoCP5WziyqDQWnFOK65Vp1mGDms6e0H3AOAOj+8yHO1Wo8rQM66ftYUgZ93
 sChSYi3Tmf+3WwMZI5BqTSvPv9ujBP7VxaxG3U6lXFt6NWk3c6gpUC9iBp467GBw6iGg
 HPUmceV6fgzg0Bb8drs1YbVDPH5h24uS45TP6tMP63BLMf4jbk5euM0FGw9Pg1V1vUlw
 3P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756892849; x=1757497649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iwFNpEKksa79Ji7RtKq4u2zvwO0CP9q3R2wAD9kDJ4=;
 b=u9rDYCpUWnyVuGLVjRAeHhGqV8l0fspMJvM56BcIGpbU4Iva+Ab/EZ10TNngRJ5/NF
 Gow0AsnYpNy1I9zW3iQIS/aFRCfdZieEyyFszSvZifgH9N6xgSXj5d6N4e5n6mZq73O1
 l9E0gm3XaBpO5djPrO2uhDth6ijb5y4cOwydna3Cq5hhf2YiZ0qqFGLs9QYgWwc2tXA5
 blBdXNVXR8MKeks/O3WJ/2rV/PNx8X3kIrxEZozQw79w25n3/vuc6+J16XzuVDuguuiZ
 ITBjdcx1DhMq5R+92flD5CUHHtjm+DUXSGEfbwr82opAtjGLH1roh46RRxuz0HhGw8IS
 pHhg==
X-Gm-Message-State: AOJu0YwHUhiwzCQ0PbhOT0WGS3vhbizQCaZr6nAIw4i5F6zKipAAVxEl
 UldSqlYj3Dy7A7m19JXP31NZckTgxhK0DtYIjjtjc/Xz2eM3Gc7Nt2qJseDx0Hrs3MsljtSoARo
 lVWYFrH1a6jjXzVsDaoAZ5eUqOmEINrOXVc/wX72enQ==
X-Gm-Gg: ASbGnctzqQu0QgiGJt73dHaDQhq+JVC98Dtfk6sv/cHalvDDgJCm5ox2m/NVf8SGx5r
 nZ+Pm5o6yubUcde47QOyaIPsBhg0WCFbapVX2OE8jNmkBTcIrx/94cYUMAznQi06jTegghAQK7c
 J7uAe0l2T3ypqcHG+YG5Sm8vxidRrGBz4meNN7NIQdqxnZoXEvv33tXAC8wYRQggvp+a2XOlGOR
 RP19bZRS1FiMfi20RE=
X-Google-Smtp-Source: AGHT+IGCxyp5ZbllPyE5oZMclYCxHjEgMbvdVLsJ2PNypMwMXVwuWhJ9c/EqqsflrmHG/6aqega+ZyDX92Vt0Mp3j74=
X-Received: by 2002:a05:690c:fc1:b0:721:6b2e:a073 with SMTP id
 00721157ae682-72276564147mr186103627b3.45.1756892849165; Wed, 03 Sep 2025
 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <CAAMq-Y86UY7LNe-p2P_d8mw7FgTqLm=HQdqbMvV8xxTdsZmx1A@mail.gmail.com>
In-Reply-To: <CAAMq-Y86UY7LNe-p2P_d8mw7FgTqLm=HQdqbMvV8xxTdsZmx1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Sep 2025 10:47:17 +0100
X-Gm-Features: Ac12FXzw5Un8462IWMcYKvNWMiGkVHibhr4dP3nOwrjv5-ssq40P_bjfeJL5SlY
Message-ID: <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
Subject: Re: [Withdrawn] [RFC PATCH v2 0/9] support unaligned access to xHCI
 Capability
To: chen CJ <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 3 Sept 2025 at 06:03, chen CJ <cjchen@igel.co.jp> wrote:
>
> I would like to withdraw this patch series.
>
> Sorry for the inconvenience, and thank you for your understanding.

That's unfortunate; I think it's an issue we really do need to fix,
but I entirely understand if you don't have the time to work
on it further.

I might pick it up if I have the time to do so.

thanks
-- PMM

