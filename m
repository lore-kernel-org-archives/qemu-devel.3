Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA26CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkIm-00071m-Rn; Fri, 16 Oct 2026 11:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkIj-0006yl-Ga
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:56:59 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkIg-0008SQ-9G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:56:56 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b0e21048f8so991727b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166213; cv=none;
 d=google.com; s=arc-20260327;
 b=ENNRvNIfdFVHHeTYrGcSieM+Afph0jR13GmThhYJ+QffLnJ0hpbpZV7K03vnqAB1VL
 L1sAEg2YbhGVZ8OLsnVWm2EiXT7dI/OkS+IgBtVBjacvO7l9lVdM3edQOAJGQ6ej/Fsk
 WheG4Ru0bTAB10XrbrZyOI09Loptqe6PdiVqNtzxWI0ce2LNrw9e89Qhu+2G2nZ84zEn
 AdstDayFlGOI9yHnXLhM3Vp9b++oArgHnu1hpMGrot9Z1z8040W/M5w+9Na3rXbF9W/I
 GInQGbLEP8rQ6Uyi4fiAt8KtT1znHvgpnIlZZcvlLZsdkJz+sJl/acOlNe3C+iGOxIja
 299A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1ExK9j+YPbSPC7sfcOHKaCgU0m9CHR8eATjYSF7jCME=;
 fh=9FwaE6xOjIKzOMj9eUuBpotZzyx649+LgGvV9tCtDGo=;
 b=fEdp8FDQvqkE79LyRe9H6w7S1Am7VHX65NP349ij76kg1CQQbecrxo2i6PtsxbtwC/
 jzlwZlE656lF6IuAnNuPVn7zpQLEeitFosk34Bt2sG40tOUNxfXnG6hoL8AseUJnlVVn
 wnLxnePr7xFpo4IDXPtSoH9TMYSHAobMsRM6aFlePoTtV8DkmkTm6thD9d9VM+LHwA2h
 KifoqvpeMBB/QfFze+uL8CqsQort9alWNcqJIqgi/wadHVyzKDRFQwyefUcM7WdLeZ2D
 cVx56hG2QCgZZdeQeTWrgAIOZKZZig9DoSckZZQSkOXr/4mYzNA7/CfBPI5TloQL33dO
 P5XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166213; x=1792771013; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1ExK9j+YPbSPC7sfcOHKaCgU0m9CHR8eATjYSF7jCME=;
 b=LQ0NzNkspjfFaimXOt71pWeURGgQPMKbHJ+tMJ3HIYWCjQc/E0ha8VaTECuTx+QyB7
 XJr0e2b4s8VjnQsINW2bq9vwaRmaFSFySe35Gmklz4AaOCLY5Sx+a9ZG0rbbIvbVNxh4
 yqkC7mlNOK3IWzzGcjjv1ZEaTGpw3tVPci/i1S591kEoBrwbOvBdv+LU0W+SEpXSCWIk
 mW0NxMyjX0J2u/kr3X8PB5+tFrTT/l+ohvdzqk/pvOXZnK4hezLQeQvvPzqjF+gIMXs1
 UD3n6K00wQXlvo6k8QyctQSgWhckktoTKG93ISCdticf3ux6TW/vOzPgimHXxX1gbFsQ
 IY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166213; x=1792771013;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1ExK9j+YPbSPC7sfcOHKaCgU0m9CHR8eATjYSF7jCME=;
 b=viWLoCpC3LFqweZ2bMdDRUmKQDY2P7B0kYpDH+EjvhCVlTDbqJmlWD7gbGbr+Y4c+M
 RdcugB8KPOn/r6rDx6TOXdSPRWi1Si9vE5VMFNjUA42pw+7Cu1ckTnlJvd5YW6nMIPB/
 Z7JFJpwnrs1eBoWnY8/VyfYORy5C8tNO5RD99oR7vVx10UUHm68SlpmXvIOurGPzI8GE
 GX1k05hOs4Frbn+sv0FS+Le+Bu0LTEkVAYQJhQ1Q1oMtCHpclQhwuCw2fQ4imLDxaxJ6
 rd+tRMLwHofH7+l2l64ML+4ycwD818d+yjQuzqSPm1GsD5C8ylAUmxpxomA2occtFCq0
 2sEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJZFd05SYiToKbOFZRcMdYTIxKPnMg5jzbpYKVWM5CbGW5nBcABk5+4Ez/mBaChkYFGHBR/XmHVF2z@nongnu.org
X-Gm-Message-State: AFq9FYJ2pZ9ynwELCAjvEysSh8Ro67Rb99YaeG5tm+BREY3+7LRvGosG
 YT4hZuDwSo8UvZjblBPJKiTgHUzxY7+VNREME26UzEyGjswCSr57qTwd7gKM7nPkvel6YowW67r
 w04cyTSqhUFgIogLVDGCdfPWIVKVrKnaVCIJTEgjBsg==
X-Gm-Gg: AYBFou1D4O4D0EwwljJFS7xSxfdAncnfrcuEg0gRyub/15rKkA15oV8sC051+J9K9h3
 rT43j5wfTclaGnjuKnxhv/1T7zYx8IdlxEG0sJD12MX8oPmMLRpmZv1tesR3ktrYYF77MmXirzJ
 FjnFFvQZIS+dil1TcSTI8KvkqVRkuTqPA5NrKIirfXXBTLw+JKemy/GHPPXjXhNA27bBNpB57U4
 4HziIemfY6TKn9QIVKBkqTg71Y6cAuqx9RuZGkcoKPQQ+W1kdi8jDHm+Fht4BtaUHw16hJelVBG
 0arsAYcqhhB4hjXETszPpkNSz65NDHpaogcepIPfSQYMIDoqVniy8Fv6GsC6gOoVnmsF+Qubuu8
 JcO/48ru5OA3OU2uMTWHDN5zAONpJfFOcp5Ki6XI=
X-Received: by 2002:a05:690c:4d84:b0:8b0:8a9c:fac9 with SMTP id
 00721157ae682-8b0f2170e34mr1719607b3.28.1792166212717; Fri, 16 Oct 2026
 08:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-8-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-8-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:56:40 +0100
X-Gm-Features: AclHuK-9UgEUXtFnqP-08vQxMx1ZvtOBwk6ctyE1fo2vDL4tPgeIs4fL_WXzcUE
Message-ID: <CAFEAcA8zkdHaSo-mO04gsvkrfAUFUAo=UVkiDKbd2XGwCMjw6w@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] i8259.c: always use cs for I8259CommonState
 variables
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 16 Oct 2026 at 15:24, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The use of consistent variable names makes it much easier to follow which
> fields are being accessed from I8259CommonState.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 192 ++++++++++++++++++++++++------------------------
>  1 file changed, 96 insertions(+), 96 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

