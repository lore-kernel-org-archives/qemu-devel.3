Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F46BCE7B08
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtT8-0001Ox-EY; Fri, 14 Nov 2025 08:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtT3-0001IF-M4
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:03:59 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtT2-0005mc-23
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:03:57 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-786a85a68c6so19533047b3.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763125435; x=1763730235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRr5JTj4BPgYkkxXxlSvKvGC3Wt47Kkr8EN4M5cEeTA=;
 b=Ph7hoaIG04QLFkcqqck/vDOb+yGjCqjmRFoJgtcDu91/q0gEZ6WrB1UcDLFOTtqt+l
 2XSmgfq+djoC7Tw2Agg9RCwXPA7VtIP468a2Ioyg3WIlql8j8OOa4u7B2nnEmqOJPXWL
 U0HcO0dVj/w/7Qg2egTt8ddurCQRW0xESDQhH+D9GeU9j7b5IsXu91CdIwO/7c5cLKL2
 FtELQHhR1TWppDefeZ1CY3Jliecf4lylnay7/eOpZ1AcaA7r1YsBUVrHCJiu+FqDkUI3
 JXXCDZpkmxaCrhu7MT3zRw0VsKcuilQYnGa/3MwJd20VGamtBzLYb6+BsxnYKPMz54Sh
 Vx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125435; x=1763730235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRr5JTj4BPgYkkxXxlSvKvGC3Wt47Kkr8EN4M5cEeTA=;
 b=Uez2vl9iKRYytzKTeq0DZqCIQ/7iQ7Rfh5/W11AkO3AQdLnz4U3SuEq+munIp6LiZl
 ZgoIV3Mqstu10RiVo3OhlPkAwJCUekUqAH3oDB37zv7qWvdLfbxN0o9RAV30v2yWXqE3
 n+kG8lO8dxr0kICfrSbNROimJiaBT+DHJSRRaPn9j5OaOIxJaMBzxQPMnLesJkPYxCo5
 ldWeiMAElDvOk1C2Qju80vSn6Gls6vA8shkYm46TTzenGXHsDJGs9p671E8p4XZTAWzA
 ge+9F0XhPuhNdy5JfFPOj2/EzLoOCNq6fJt7Pb3wcrRCwFAw2c3d6jrFxa2CxBIiYreD
 3goA==
X-Gm-Message-State: AOJu0YzhtG2b/VrLqDzhOIzNSGnbBkanJG+2AIOlysX6EYGKFSjnCdrO
 /4YmJqGaGh2A6AMUAcQCdgddnUEwPr14eV3TEuem6zzy1rOJHOQof8Yzi1OfSQcNUxZ0HecvpZ8
 ar8epkKesvHj0rLQp9q8do6az+xOXkNoCOWbgchm3BuhwfmQdoLqs6EE=
X-Gm-Gg: ASbGnctSHBC+BQiFRZzYBeXqDCvZx1nyRP+0WQqYnD6MuER9yOSl+tbCSJmX8iVFwhD
 XJmJGRoH4uhitc+jRDrtUSsdVeR883EdMzCS5ZtiPtLZF4eVJ1pT5vT55TpLczDwDOGARqePwdD
 2VvNqDf70Dk71EEImvIiXbNjlbUJ34fr9OyKeNEqW9/wsavze5l463FDc2sXWBDe/7A+fbKvXUp
 +b0cG3+23gk7s2dr1jD4gcgUJJ//P18ReRE+pZQcG9f6HTsiKbbpSWaYbDkfJilg5LeuhFl
X-Google-Smtp-Source: AGHT+IER9bo6Zanj3vb3H752442jcqHn/qIrq0+t84/kBrKG6HT1uHwxPoXBdHAI3R3hDyrLI/+qu0xSnMmd8VWuGoM=
X-Received: by 2002:a05:690c:b05:b0:787:f0b2:8dbf with SMTP id
 00721157ae682-78929f68e74mr26534017b3.66.1763125434658; Fri, 14 Nov 2025
 05:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20251106144909.533997-1-richard.henderson@linaro.org>
In-Reply-To: <20251106144909.533997-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:03:43 +0000
X-Gm-Features: AWmQ_bkfAocvEp2WjJPcqq6Uy-bk4upizlX3piaeUL7vI802-tOkZYQWxZocKEc
Message-ID: <CAFEAcA-1-pjaGwMhOdbUauWSrPu-CGVMFv3PWcEYKTi5E+QrWw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix accidental write to TCG constant
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, gustavo.romero@linaro.org, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 6 Nov 2025 at 14:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Currently an unpredictable movw such as
>
>   movw pc, 0x123
>
> results in the tinycode
>
>    and_i32 $0x123,$0x123,$0xfffffffc
>    mov_i32 pc,$0x123
>    exit_tb $0x0
>
> which is clearly a bug, writing to a constant is incorrect and discards
> the result of the mask.  Fix this by adding a temporary in store_reg().
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> [rth: Avoid an extra temp and extra move.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Applied to target-arm.next, thanks; tweaked the commit
message to match the code:

    which is clearly a bug: writing to a constant is incorrect and
    discards the result of the mask.  Fix this by always doing an and_i32
    and trusting the optimizer to turn this into a simple move when the
    mask is zero.


-- PMM

