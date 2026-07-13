Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCN4-0001LS-9W; Mon, 13 Jul 2026 04:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCMq-0001Jz-MY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:50:25 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCMo-0003xE-3w
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:50:24 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6611669cd16so3774640d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932621; cv=none;
 d=google.com; s=arc-20260327;
 b=nemvSAWg1S65XiYW2xNE7wByLog25GNT5QZLstg4VQdaYKa57iBIm6pKTN7ddJ6VBh
 o39ttqZ1jvkGh1OsWrPpYexqesxBH7sgjyIJsZ1z6jDxwYOb+acBob70+WwSvI7/v1e0
 STuDb89XAw9ZAbe/KZD1bDsQYQY07bpQe0e6EwZKNrXhGo5PjcMgKg/hS5avnBO96fTD
 0hmsNQctS8HAjI3JpdUofkI4HH7qSDCGpUCitnSxEHlBpjlrqhS4prpWcoIBJ5J9mo2j
 VM8pCVXORZ7XUWAhhOFUW5zs013hw41COq8FrZNRMwnSu0NgjUtwYGsgtcxLPL1PM2T6
 5Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wdIe0QjZ7IhWqXYYbiQdPLRJP8InRI9h/Lt8YBcv/6E=;
 fh=Bo5gvAdftZzNImKjYOCLToa+0qrP0rThDosEVmOF4Cs=;
 b=hojCJBUllAVJ+URrt7LNOVI+SG68Rc7B2bZx3yuoeFUM6mTWnjksxVY03nCW3I4ijU
 p3MWonSlnk4BubfwHcBvhVFjZRm2eDAuRHvsdpVfvK4bt5dWB5w5NSIZIpGIqZOP1qcl
 RngUWEMD3qYgIeU9OfET9rwb4c5cja/49MyZkZDQADD4epWS5tV70J/PHa4+yT08NRxX
 RYyKTx49+lhp3eR4+GwVClB5ywsUM/9IAdjno4Mg6dOG0hhjn/DL3ezgBa8lRWL7L8cK
 bWBqpn3N/uTVLy4lSVDVWnDFSTFmtRrQf3L4SJhp+Gp2CwKBN4PbbI74YQimUAuHvEwz
 Arew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783932621; x=1784537421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wdIe0QjZ7IhWqXYYbiQdPLRJP8InRI9h/Lt8YBcv/6E=;
 b=fHl+0Ry5aq/eKAEJY6y5ngXUvYclI4JBbd/Boaatl9DyL5tiEF2gRUrxFMnY/OUdAa
 LURHNtqSqsrjdP/gMnEe4rq28gKm3Z9d1NfUx7TPfZao8mM6WRZ3kXJP5jEhyBWJrAHx
 /opUZbtxK9jJkFTIug+juT9wNgcJ4U5/4n8HS2Yuu40ouYtxq8pSFpgSo4zZolspnKZc
 IENxLedGwB7aSArWwTbneFIhM73iPsDvL8xiJ99KTTluh6RapAIemZsCwDUCNtG9qYwn
 m7/Qsusc4fvLVBt2HpRjXox5GI6mjJvYTC+jABJXXzEgkr98h3aVWJYr/Ijb9zw3TvPq
 qACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932621; x=1784537421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wdIe0QjZ7IhWqXYYbiQdPLRJP8InRI9h/Lt8YBcv/6E=;
 b=eFzYwOJOtdkoyUIPzH65uEgR8gv+xyu7BTmB1pz/IZ7QTGzySD0aO1yRFTcVRv5OHw
 wkALbML6+/G9fVwza1cjn9u0z/VWE3iem7alrnoiGHbZwQnfxAvw68BderfqmftkEYF9
 4fBxKBMG9F4I4wdMHhzjH9K32mnL1PZtiVbp6tIMIawpeQnH/61Pm++0iPlNeU3XoL2d
 iKDdr37PIV4AESOtZAC4bTK7gt/0HiLHKrMUDTQJbFvlH8vFKavTZ6kLccjONBSAw0Yl
 72RK7J/EbOxjjHRdzV9Gf3KebhKTP7FOdD8tNnSnPiOP+ErergWP+/tUbvCazDAEhVKG
 szGg==
X-Gm-Message-State: AOJu0YyOYz3pRpA4CYceenF8JnK9Nx2u7P3tIberYkWK0AuzrvGPeN8h
 JZdpJsxbtp+Q5t5B4iE22bRd9v+vgkUq6y0zIgD8fhcVgEfR8Oqb6X7LKSSQAKQ1qN8xTA+HE0j
 8vfbujHkyxgZ0MNFbzQNSHLWIK0u7R0Jmj9yK71ePfA==
X-Gm-Gg: AfdE7clkEjgyUpC51Flj6iPtYyH9oSjxb9iyP69scK9A+JQVhb3KsNixRbhbjNy7o9R
 57PHzTMEP19ooKJplcwoFfmguwAylSfiyxNDGocL6BE/vJBMO4qAT8M5XcnimonXhTfhss9DXF7
 yTYxM2V0XIa3CWxhP52hRor0d5bcYnpGbLL0bWcNg4ZoUQyPxR63DBs6AzGvmKEBfUBdMH7g0RM
 HsC0C614u2SysCmH8pX/GR4ewN2grJlX/J4HqM7WyDcWQ5A2iYGzzBodAKf5WaTztjXiXC44PCg
 OsvTBX4RJv3qDEpL4AXS9fx4fXWf2Ot4AE2BPaKh3ILFzNk7TLS66V5i
X-Received: by 2002:a05:690e:169d:b0:667:d8b8:9033 with SMTP id
 956f58d0204a3-667d8b89b4dmr5313759d50.16.1783932621031; Mon, 13 Jul 2026
 01:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260709111225.1106856-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260709111225.1106856-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 09:50:09 +0100
X-Gm-Features: AVVi8Cf6jC1_ob4a8bkaAOwDcd24VZ37deqrImYU3De28ExSp3zvcHLtjpcnnpQ
Message-ID: <CAFEAcA9fN1o68y1iG6O_1pWhNqrFFOZXye6unBZ=uvy0OiSgXw@mail.gmail.com>
Subject: Re: [PATCH] arm/virt: fix smmuv3_devices leak
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, skolothumtho@nvidia.com, 
 "open list:Virt" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 9 Jul 2026 at 12:12, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes: 92e340997f861 ("hw/arm/virt: Use stored SMMUv3 device list for IOR=
T build")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/arm/virt.c | 1 +



Applied to target-arm.next, thanks.

-- PMM

