Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E82CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDOt-0008T7-R8; Mon, 12 Oct 2026 06:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDOq-0008SB-Mh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:36:56 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDOo-0006Ro-Ox
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:36:55 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ae8607e8afso10173007b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791801413; cv=none;
 d=google.com; s=arc-20260327;
 b=bqAD9dUAvhstYVbv84c6fB7+LkGZ6Gmxir4UxG5nLujlcTWEsFFVKXBbwcaKKcIcfK
 j15UZZEIeEXGD1Mjdqb0MUP5goZqLwej76IiyU3bld+NXCdb8Z5ebHQamkK48UMyBR6e
 SBt1h8eRQhUK7nMwN4Y63KlO8k7wtyfqI3nrArK4ADLAaOfu+0N+ld2WNSc0sPOUg9TX
 FUjBd1gEpY4dUDiJlPQjnE5jdSJX7RtdTk5z9YzXsu2VH6yFM16ner7Io3ef/X7weSDU
 bQzVQgiqW5X24bwjKrarfdhMckGv05Bc8LZJnPp1r2QB+L3PoMgxd5YHlhuuD8mxrdEa
 yo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q4Pwj0umhNYnhJcqSnnypcfIwnJ9p2Z4oUzUhn6fJ4Y=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=eBW//FKuBJLiz0YFclOoqUh3f86UxtT6JekgTeBJvD+9xW6PIncV9UAElI1W0sguID
 GOjBcP9mzfNX/oa/4WHf1ish/B1LB4+ZAyPNpLOfdOvVyzXLxYRl2PXbjkyJ5jkbrapy
 TH2A/jbcPgorbtkBBnCviAyolqto2JxWRZ0qoOtaN2lfWzNQA/kKphGF7bMdQeniH0Dk
 8wBUoxdq7g8kh0eMkMTTuy0KeRm9TcI3Xnlz7i8ZP2sPEj/AOxEfkkiCxhwWdjTuRFX4
 CtvQlnKz1CcgYNbeBWfepDUIlWfzre/gJsg6/uFrpAdSxAPRTm2UEzHkwzaTlOyy6sjJ
 Ygog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791801413; x=1792406213; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q4Pwj0umhNYnhJcqSnnypcfIwnJ9p2Z4oUzUhn6fJ4Y=;
 b=PxLO/FOnj/wMShCPNG1Dp2eTzF6svOpzRVNqpuXuY8mRjWqE745PcE6H8bkQtNQfOe
 64VrPfkV0YKo5FtjnjL8taoE+JeF7BANMs1esp5RW80KmyYcNxWj2MxP9vGTF+EXWhpg
 ZYNsFSIeY51yp3vhP+lt8YI281z97Qar0dG+tay9KTURVO7PTHzIchyeJk4YW64Ul99y
 DoOjj5L5ImLpHQWZSQE7z5+beosst4NGaXzxBZAqqs+KJDQxlkuBw8pNzDGrlct28Q/g
 lX9Y3IDoppuDsh1AwrRaPZCOpBXdkeRAjE6MuLeks23hU63Nfw0xr39AHiZ9uHMoWhRQ
 A9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791801413; x=1792406213;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q4Pwj0umhNYnhJcqSnnypcfIwnJ9p2Z4oUzUhn6fJ4Y=;
 b=ShwgZMi8+ROzg2co3BFowvNMQa0kuK64XbxaEL6lihOTN0BNeHE437ohg3gtOGxJe9
 xn7+2kaH3ZWHYzfVKkc+72p3DCHtBGXy+jZmP6MKeAk1/9t54iAgrPjdl3WSXPUPaQ4h
 egKgGaxQVTSu1IZHKws5qX/ppU6gzaOqHk461pI6M2CcHEcB4ixq8wELWBzCskHRIbas
 1+hzZFnBp1nfcqJ59V/MD6T3+cUtJSd0HcabedoSntXOlCiYVSZ8hoI5xfDJONkwAtVn
 l/aPpU6wtY5wmtfOikJS/uZtJuFYWYCAE9jYdEKHV0B57Kv0Xnpo3Q8lim3VFnMAw27O
 W9Ow==
X-Gm-Message-State: AFq9FYJtPv/Q4fRyM2GQAH3krQ0/AwSquXHVkqZIxxrAPqoT3Qh1rolD
 fXP1+Fp3ZLG2dRpvX9g9NQY4cmpHmoDwbsgBf8j1+CS8wEq5ymY9fw+vSQ/Eu9oqe9NSojnll1E
 qYydDGus5JLf99FoopVQB6zZijoQFltIWX/hUQ7lYBA==
X-Gm-Gg: AYBFou1AmjgCvEh7nhLYH3VUQvy6d5dEMP6pKgA7kVGMor4xM/9f3MshRXcQFcdKIcv
 rV90OMWbpMrEDTbJ/afdKyoTBsl7FU246xFmIQ0Hy0RIuAmi3JlxUaR/rMnLhA5WIvhqKbgtorm
 /h/qQ/7LdfSb9TJHxvdwqtryKUAv6RgJ/AlHMb6EBGkH3ArLij3yFLF8XtKIHeN5oa2hqu0eToN
 WiSgpzQJsAWXGaZQQ/SCAt2tyHi2hf/HaaTNhp3/fxBSg3QugHpC2wLgaG3nydHTOdwxvmfcijH
 AzcCqQIJ3Wd0E/cF1KqpwwIOSl+EARCuVQSJJplARU4bFRIfzlmmJNRsuPL5igW3nGTWKk9Lc88
 LXgyF3Pyc92p+8V5gBnYDVTs6718b0u4E0/nv7hMZ
X-Received: by 2002:a05:690c:6509:b0:8ab:3dc2:a4d7 with SMTP id
 00721157ae682-8b07ed90e24mr30426327b3.22.1791801413399; Mon, 12 Oct 2026
 03:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261010070952.323466-1-richard.henderson@linaro.org>
In-Reply-To: <20261010070952.323466-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 11:36:40 +0100
X-Gm-Features: AclHuK-20_kwZsKo7IVLn4oF9imCQm3d7Q-BGTahwP9XSW9HzvoyA4LdWoYWips
Message-ID: <CAFEAcA92eOaY_39yN9H-vXZ7A9=CSPK6LEOxbbKxREv_HYw_qg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/arm: Implement FEAT_IDTE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sat, 10 Oct 2026 at 08:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v4:
>   - Squash accessfn when we don't need it.
>     Rather than confusingly add el0 to the access_tid3 switch,
>     complete the kernel emulation by squashing away the call.
>
>
> r~
>
>
> Richard Henderson (6):
>   target/arm: Rename isar_feature_aa64_idst
>   target/arm: Enable writes to SCR_EL3.TID{3,5}
>   target/arm: Squash accessfn in modify_arm_cp_regs_with_len
>   target/arm: Implement SCR_EL3.TID3
>   target/arm: Implement SCR_EL3.TID5
>   target/arm: Enable FEAT_IDTE3 for -cpu max




Applied to target-arm.next, thanks.

-- PMM

