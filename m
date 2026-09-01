Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD05C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LcA-0006nd-HM; Tue, 01 Sep 2026 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lc8-0006mm-RS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:21:12 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lc7-0002ZD-DJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:21:12 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-861a2ae9c51so5581807b3.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788258070; cv=none;
 d=google.com; s=arc-20260327;
 b=r//cH9HwtrBRAcfTO+HAHnhBYXxFbLPR179McjAwTbPCsSsJ9nvNrqlsyLR2aZ1N8u
 C4i0S3S4HdksTfN5vYTfx43U1zk4ky/3R7Is3VE+4Op/bApfgNb7ebKJtUSRaoe6/ZZJ
 y7+k+fsa3mJoZugA/PJQ5SeB9xKn83XsszI3J9zwADUdNYi8W9XIQKEBnd3uDpgvsq1i
 4PAqHk1NoHLDP6BApLHZrAGXMklHRWCbBldpoFLXLveP7lgHzvCPAReJsHEfEiCUf7N9
 GtcfkVAdIA+Bmt0yAGaKAUPcP1RLghkdP06zMkPQqXTO9DNWPsIxULmZvUxu7f22m1JM
 w2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vY/MJJp4a+TGy2l3aR3eRVRxcKLxQb5D6XtRmioKqT8=;
 fh=bIE/bXSCkVaBwWnI5E22W+KoiLTAK5S4CW9f53swsiE=;
 b=gK2TTX973WuTI7v6Vdtf2R22qVczrzYqz7tBJITvN2gMFaxFta/QysLFNisd/YC8if
 izVRcwGJ5u1/O6sT9pVW8JEfpPiFM1mAOA/2R/USDweUfbNJoQUdzlx6Sde0rVJduAnz
 fE1GCggNGFJMHys/eZNbXxw9UibsfsUfowvjzJ53I3N7hoL9CF8TqLI7eUCFzgtlt9dE
 PXAEdJL1o5FydQ+vN8tkkdb1kw0vR/RpQQcnOgwErYYAlSKL+oL/kwHkC9bBkMLmw+H9
 PEjTOlS8i8KhFizochFtbnJzRHeDK41rMC/iN4EenHVH70alqcoF75XF20ujyJrYpfrg
 4Xaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788258070; x=1788862870; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vY/MJJp4a+TGy2l3aR3eRVRxcKLxQb5D6XtRmioKqT8=;
 b=vJLbF2v81Bo+F1GVyl482udMsWmchOXUIoPzGDDQS2VcH4rN1k9WtQH8Hvvl5EtKjm
 exQYM01653ysw23CIpuLWP1r3ut4B+eBiqVIhAXC63cLNb1FstnkUt9LbuX4e6wgqZcP
 38zUhHuzlgzpBTirEHd1Bse838goNDSM6N/eKlA7F261LOBfPS0ORbEXWmQcz24QWRJV
 PdWyT908fg8KPnho13MpPlC1pnWD58woZquksQ+RNayye5m1gx+DV4P0IrS6IuiZvnUp
 lxvr2Ksfqaim9avCQXGSA8XEGTKQa4gfdMFFRysOecKtCtFgBLALviiEXq3zaZ/+ve7f
 WTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258070; x=1788862870;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vY/MJJp4a+TGy2l3aR3eRVRxcKLxQb5D6XtRmioKqT8=;
 b=AGE27zXsTBvWdmPz5NU61A3CnDr30BV/Z+uQYKXeWf4yt5gFrqK+NRgEBeiaECr72Z
 pnvmP7JgmJnNDXwK/vFs5VmuX5zamKHvujV9JeOsu76zEwNrNUnN4yTjsa93+Ee9VXse
 T+/UMFhSjPxsFdZISVxBAleDX9HU6AdibZ/8BWLEnU1CT/ixLCDv7F+ovksQoWMcP9P2
 KIwxJcb9Q21KO59/EbB64ot3OfkaZhnQw8MLQWU4stSjvqjp73bdjb8QKsMeLhHC2cC9
 20CtFkNslrbnmkHy5SgmxCNMWgJ3GarvAS/y6f7YEaGxrkAaiw1oSXG6HPGbZljrkcIm
 TDoA==
X-Gm-Message-State: AFuF++klHQRsdynChLT79VJ/TYWFuUArhKh3qWiVuF8Ia3d9hEeQnkot
 eanIaWkIm8LJDm4GriU6TZoUjz2j7380oDRZ0HLHWyRJQOwMslKTy6eEmPIvIS1mzn0mIMudv80
 8sBhXz6XoWF8E7vu7iKPz7HbdQ2xbF7uM1ZlQNVWnMA==
X-Gm-Gg: AYBFou3IpqteMlklrsoHafxXrAmylyyw9dGIBrEjHgVrj12P/GfjW2xy2PtxqwMcDJ7
 31d2+Mh7wdoJIr/KGV0GxEvGxcaN378wmIcdNKTq7AsslYvvbV5ezmiVf0JibrAxCnAWELgowfx
 w2GFYRmetVZNVV8UL5RBDuYZOndehBtRkqBMJVBRpes7a8WOTmJKWeBe4a4QlFyXn98jlRCtMY8
 y0kY4XWXMouVSPciaSsEUz53OUVOeTphBYdPBMBioxZVGQmFXwNxFXHkJ0PCudfArLBhHjVvQUK
 HLEqt/xfVqlbOWX3tstTk8iEgEi4IkPvZEmzdj2TmHLVzcX35CDqxUKmCReWJ5VZjTjqRbjErY0
 HlQkB5lf+dskx0CtWTBZ/dhPQGDfN
X-Received: by 2002:a05:690c:102:b0:867:ae30:4ea8 with SMTP id
 00721157ae682-867ae307bcamr34698257b3.34.1788258069917; Tue, 01 Sep 2026
 03:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260827041557.775080-1-richard.henderson@linaro.org>
In-Reply-To: <20260827041557.775080-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 11:20:58 +0100
X-Gm-Features: AcwNN1U2e22oyC5Ud-grvKEybw1Aw0cJb3hMreZMP0qwrJKWHNXRPRzISrgORTI
Message-ID: <CAFEAcA8WARZRJ1GVf2or8g01N47WFLtEgswU2QhOQP_TNhNHAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 27 Aug 2026 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is something that we've talked about for quite some time,
> having separate "max" cpu types for Armv{8,9}, because Armv9
> prohibits some deprecated Armv8 features.  Retaining all features
> simultaneously has the potential to cause confusion.
>
> Pierrick, patch 2 replaces the one you posted using ifdefs.
>
> Changes for v4:
>   - Adjust for single-binary.
>
> Changes for v3:
>   - Several patches merged.
>   - max-v8 is also present for qemu-{system-}arm.
>



Applied to target-arm.next, thanks.

-- PMM

