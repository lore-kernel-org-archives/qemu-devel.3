Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA99C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAJo-0008VQ-SV; Mon, 28 Sep 2026 08:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAJQ-0008Rm-MX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:18:30 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBAJM-0007PK-A0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:18:26 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66fb93aee5eso3032387d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597902; cv=none;
 d=google.com; s=arc-20260327;
 b=GhzVCJwDXNcWe3tlo8AHmXdOIvQd6uzr7Z7tLpfwgBwTfByqPQZoPtx4txnUR6wwzk
 RYfKmO7AP3xas3KF4rHaDQqkohchLyj95TWS21Sm3w6QGkXNH2EXBtAyaZgi2PzugGeA
 pkR7U+051xJUJZvushF5FkOAFr2AZhloL1D1880SAGA2gZ8FVwSSwyjH9vtmDix/8Ecs
 fO183yBUB1NsEPMZt7wf/VKvIPJW7Aq/62oTDkoFS4vrTShUMqA8+vlypT47+dmz3yL7
 Pr8yoQGtCHUJtfRcUvo4ulDY+mkLxdTcvH0mfH44NxUh2VeJk+nrQnquppgllGhSCLUT
 xoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tyhR6K8kv2DiaBgjFE5j6JP51JNzMA3q085iJsPNf8s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=T9di96Acu8jWqNhiYX22dF/aHCgDwhAtJYf0tHjkk4uWkfDyVGAuRcsucyDiAnkGYp
 wPeoQSIukN56O0EcEEP0NggpoTiTRKiFXAj5hKXMJLps/wT65H/NCBXdPegy4Au9U1iH
 v1DVoU/a0WkSYzKsPPsbp0yxLTF78gk+OZVCBvuWSMOf7n2vc2x5wTSqS9m/aQud3jeG
 CvCYkkLwE/hpMd4G27CDp3toZkyoy0TCx1wvBTGntXa4VBet05nQ6NxogSqhHngB9Jrr
 R+BUqIe4k9k1ZGDbMX+jRHgqEU44BdhfcRY9aAl9JLAkl4SJQrDws1zYy7W8Tj4zC5Ot
 gfbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790597902; x=1791202702; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tyhR6K8kv2DiaBgjFE5j6JP51JNzMA3q085iJsPNf8s=;
 b=pD98JnWO4cP29tAnDj5txLVFwmZHXI/QKQsNQUV4w0cRhZmfu2D22SLoySuWWzouf8
 9c3bN+M3e75TvDVBO1zrYcVzeSWupnk/QudfiTBRpwUbMPP5VxoL4hkZdiruy5LHiB9Q
 SdkuxL+RtbogmV57aYsRA4++8b3NeSYPifXWjBFCSh9h6ndXRHO+054xkD3mekFBrUOy
 w3K7dHYbKZHgA84k9R7PH8nu3goRpOpH7cS3Zlam+220MM3yvoy8Bi++dZyYq8NH61hd
 iO1B9AAXKqCbjggjGeyk/hH33Gl5QVzqHLcKHtpkj5LPldCfNAmHmSTDZOGSvJy+GhDJ
 FtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597902; x=1791202702;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tyhR6K8kv2DiaBgjFE5j6JP51JNzMA3q085iJsPNf8s=;
 b=MjRZYz2zvBffzlvmlQaO3FQmWva9ztxsCOP5+C1fttvFzAqEVRs/RaIv4q3Ax3SXXl
 7EWrIbzwBWowIAN5UZgk084ALuDpaFTF53lxF7Ck1wsS5RMiVigevcOP9sBAMyYvCaOa
 8MnY9NonRQThnNvhwVMbfEs/coqZ9LKXKjwjbEIudCtECPBydWuG+iwI/l3wgQhrqaqL
 S/qNzX4YonEkEzL8Q8dBQIufDVbNQv1qpHKbEVIzPi/mJjQVBalwNUAWbMHJoC/Px618
 9UOvWVK08cNY2K+FrWXHKp2NWuIG2Z5UXhhwqWnwPbQkOv+N4tBt2YUYKnmKQhrQ7ZO0
 H2PA==
X-Gm-Message-State: AFq9FYLtMvW1knSy6VoCT9ZnTN+vkGnczmhomPMQx3s/04fKNWpSaw+F
 86Q90ebzxAAbZYctcEjI39lSvUvmxO+BxxdHVezQyCb+RXvaPF7seNinVb2qBMwmWq+XjD4Vb5s
 mL36qACIAbVXcYbrgw0BCOeXBzzbkhy/YWPptDKQr8A==
X-Gm-Gg: AYBFou0KMK7pA9e5lWagBh2rC7iJiFRwWz7VffanlWo7ZfQj3EvSx/LcYuxLP4mQ1d+
 puGQsvACPul76rMV0GC+0naLboPGolUodOpm1bBhqRxtbFNRTKm2rxI3xpftsq5ju27SHPKaIY3
 0/8o+ZLqbTj0Y205UmyD4sZQzMDVn+ldg1liB6JPcahTPll1RZt56KXtBL6NQzr865HC33dZHmA
 rZsA2fO52h7Yd+yKnMBSg8Utreo+PhrndeRDqkjd/Evr5TkAO4OI0KaJJaTOWKUbjvf6PaGtGP5
 J4r2ZkKYmwM45k9Mf4UUXPf76bm8oA8lz8G8HOKWk5h5T/Gi78mP6u8nR8wDXVR997n0ON7Bcv1
 JBMuCPeh/eKP7T6P94KGTGeLdmJ+CosHFO4oq/D8=
X-Received: by 2002:a05:690e:dcb:b0:671:43a0:77c1 with SMTP id
 956f58d0204a3-672ed3b5989mr4523407d50.66.1790597901959; Mon, 28 Sep 2026
 05:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260925162632.404001-1-richard.henderson@linaro.org>
In-Reply-To: <20260925162632.404001-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 13:18:10 +0100
X-Gm-Features: AclHuK8kmZe_VtLT6MyoHjA3rojXfYTWWpiZFWu8iZkiem5QwyY5U50CBobbcPQ
Message-ID: <CAFEAcA9GAqVM-G2EYrAcJ-xcAQUoHgGFVtkcMfaYYjG_78uetg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm: Implement FEAT_IDTE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Fri, 25 Sept 2026 at 17:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v3:
>   - Drop helper_tid3_udef_el1, because the entire tid3 space has backing cpregs.
>
> r~
>
> Richard Henderson (5):
>   target/arm: Rename isar_feature_aa64_idst
>   target/arm: Enable writes to SCR_EL3.TID{3,5}
>   target/arm: Implement SCR_EL3.TID3
>   target/arm: Implement SCR_EL3.TID5
>   target/arm: Enable FEAT_IDTE3 for -cpu max
>



Applied to target-arm.next, thanks.

-- PMM

