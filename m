Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB0FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIf5-0005qR-Hq; Mon, 27 Apr 2026 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIer-0005pe-Uh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:53:45 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIeo-0006iY-Vz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:53:40 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6587cee8b57so1405274d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777283617; cv=none;
 d=google.com; s=arc-20240605;
 b=bhqh5aBeCiRva1auX4fply1m5rM7MH5EX1MNvfirbYm6b/YUBho+BGeJVokK6RqhB3
 mMmRE1QGGPFVqF5Ey+eScEJF/4ij+PwuBu1dtQPGTmdyVoA3vikg232xunZ8KDySetgc
 Ie/EItxxTdP2J3LZynlxlghLlllUrqUky/v0DJTYlWK5geMxcoJzMP4L4pt+BRJVasjx
 N+Wq5gI1J8YRPKklnIWsUC0wmXoXltnUBVGK38dLpo5BdsQvI92lst75aVCGs63NNUzb
 VjrFUgxFf2CTdTZtYD5T+WJqTM/TXjU526UP5hYMcLYth9aIiQqt0axGkpmAZy6pnVB+
 Lhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d/nDOXfyKijUgvu8fbHWG7JnOWshdqHeOY15VvLOjsM=;
 fh=FOwmEc3pLszWtzlliwjtjCkmQtWE88cuUJLl1VZWrKY=;
 b=VtMj5RBZMriEwNTr+hMIjFNHYoq6iZ5pA6PR6UkPnSh7oVFig29rY5Eo5nv8fPYWja
 d2KpE2yvHYHWS+0nigLhqPh7ejSR+AK6N3WnhlxXZUx6yUk1weYUvHkcWhydTv3j1Yzd
 YT4mZx1Y94xQE/z6R4M758O+zoKL/tCd6J9n89VVuHflAPYeIe7ZQ6qI3ufE/fd59aJd
 vVjy2mspIzPCCWAFu3cg7X+CI9Zsxxg24TcoOhtm8EEKbHFGvIuFuTuIvQgg2+6l0NVa
 AyDGsZ6wjjMnl49/knarm9qJB48qsJB3skpjSAYZKLrz4ejf+AW+U2CbVuwVgvAOBKzK
 KM6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777283617; x=1777888417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d/nDOXfyKijUgvu8fbHWG7JnOWshdqHeOY15VvLOjsM=;
 b=nd8klbQDHN8bBdBnempqUZt7681Rz03TqDaAkd4XOfyf+nafbWqABNhheRl7U3t02i
 MURwMOUEJ0tEoT7pRlpnwfUXa/ygKYNronyLrskTx2i78ofifNoyTMEoA3B5TIo3HLN1
 +9EYaF78r8wxetKh1so/Z+L0t4e0CbCZY0yrFlprk76d+R0nnAmMgsj+5O751Azkp6ep
 bOf9TdsCCDPcX5T3/3gzI/Wmd2V513849sFLjmK0CKv49NhC5wn/E8lTVZhKXA+UVWya
 WbsFnPPaUTIO7SovS+tTsTm4HQLWneFZ8H0cI5lNoqBFPJqVnJ0uOXnhyrddG8b5UzlF
 HTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777283617; x=1777888417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/nDOXfyKijUgvu8fbHWG7JnOWshdqHeOY15VvLOjsM=;
 b=h0mWGzwS2CURiaY+oVxz+QvtVR0MUDFzPLZLIfIy2mix4L/rcGoXQ9SS2//3QxlnVv
 ptsXIL4aT/+O9WgtxMvNQmMCrxJMLvWh2ugVMWElOxJ1kPdoRTLkYCImswn+7AxnMUpa
 DzPK2bW+lTZubiLs9n2NpKj+7BA9ByTy6AGtatHQmFTy6ZKSKT63HMb5p4ZZaF5xvKC0
 ky3heDQVf2V0pC0O0Nd4acFCYGmoSR9Bpwa3W4T2BPSPJxe7pmi9TKRRXzo+zlxxQ5XC
 8Lc/1SpBY2xXuNNR4sOYPCGAgq0eS73eF/LTRI+9PlUO7GjyYJe+xaOsGiJ4ZTU2sDeu
 q4HA==
X-Gm-Message-State: AOJu0YwrMLswde0k4NOQ4GC9KaEeX9j2ZkrU+a68grHfUJ8SR7VDiNYa
 frJQimXOcdl1ezRabQidlXb1qA9t3SmInrx5iffd53HSgSj6DnAfI6tn07TCAf9gkmimlQndpiT
 O9w2PnfVP8lPoqNXJ3v4J7L4L5XmW/pBoajDBAHtg9Q==
X-Gm-Gg: AeBDievO5jooEeSBNdEXOi3xG38ZKGMM9Sz4JSJ7MuHyvUBLr6nps5Qw6D8aL6LjXI+
 dCovqQlemUrzYGve5D0JmnSXq+4l9iHyjH7gANzn9dPP40y7OGqw1b6s53p3A6TdxGS1OCQssFO
 nh6tctG13MBzmOLHSkMrqSalZGHwyT7I3ZtG+TKkSAmARAxJ2IR47cl+tJ7FMjL4+ljFjHs0nei
 rYR4oWeIjdNtupl/s+VGuBi+NBFSO9Gs1ilqIP4TC72LdXYupAKsHG2f8Fj+5RmmLtLbqo0eqeJ
 x2YqJ8V6YcJDl8pg3KnwRa3F4hDqSLn+gS6e8L5AWxVRgfL0FiZK9+YjPnK1UlBMGz1lLKEUYUa
 Kyg==
X-Received: by 2002:a05:690e:1282:b0:651:c29e:f0b0 with SMTP id
 956f58d0204a3-653107f0ad9mr39115805d50.4.1777283617620; Mon, 27 Apr 2026
 02:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260420162114.308519-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260420162114.308519-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:53:26 +0100
X-Gm-Features: AQROBzAE4t_ZXEa8YFvZzm_2OWnRIwhP16mvAAH2-G0BLGlQMvupEBJjc8PBIBQ
Message-ID: <CAFEAcA_29onASJ7bOs6jFbM9Mmj_X-SrJ85hSWxCOa-4WbFA8g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/raspi4b: NOP all DTB nodes when removing
 unimplemented devices
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 20 Apr 2026 at 17:21, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> fdt_node_offset_by_compatible(fdt, -1, compat) only finds the first match.
> If the blob has more than one node with the same compatible string, extra
> nodes will remain active. using the same loop as imx8mp-evk.c
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---

I wondered about whether it would be worth abstracting this
out into a helper function, but it looks like at the moment
only this raspi code and the imx8mp-evk do this. If we get
more places we want this we might do that, but not worth
it for two.

Applied to target-arm.next, thanks.

-- PMM

