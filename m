Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22032D2D8E4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfur-0003dF-HW; Tue, 27 Jan 2026 05:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkfue-0003Q5-72
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:11 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkfua-00059v-2V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:06 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64455a2a096so4264092d50.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 02:03:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769508182; cv=none;
 d=google.com; s=arc-20240605;
 b=Lg0EQSfe8vqP2yGIiS844HFOWqoN83PPX5a2aUdRn28oMVWHqZ50OHG2huzC70z9hs
 sCK/k8cb8QROJ/BXQ5dwvWVaV/ZDVCn16HpUAhYFpFOjBzdaRqBRPQ12uKYCn+yTtEaW
 g0hBMQLnFMf/VQdb2yzErwNekLbZMdFWw9k2X0dkcUUGSBdms3OS+FlAv6Nd5H9GPwZD
 WB4N8/g0nmU8xiqRPfaqFHX3LySSIdWPaGOoe6Vb+aqZxcS0bQq4w7jWNP0OHPxsHE3r
 S8OmobqykrwDf2mB/qZ9KTXMlhyO7k2jg39yIu4o65LMKFgSctJaZ9bUZC8LCesdF6jj
 6rIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mMYC73AAK0xe0frY0GBjv0H4WaVO0aWaGbYrnPxRlKk=;
 fh=MS//RwIxfZJtyKQh1xMbdFJdVGF9gzzteKq+4n6gleM=;
 b=IJcreufd1TVzXbs1ZTbEB5golQ05NdVcLpQ/RuVzu7nO+1pqQYrsa6ktqTKZSVTspI
 NPOSwxaQ6Kv7iNMf9WOSBCMTKYBditFnLN1btFuRrX2SwrBEcFNNYV5bBrSU/JUE+9xn
 RjaTJdnrIei9m4RFshnh0HucrVVnhSDKXzgbXnVcM0C1o6mTjDbzgdIhHDW5qEBo4hlh
 JK4buCWvCNuZGZTNIw/NGlTUYjEe2pvfiKdBl8edRv+tjVZX7Iv5P3yZkKtELs71WNU1
 tRNpf3mUjwGpxsHppN3Oii1U+yWPt3LPGu0oJA6/Fk/bAJGaZfXeG+KYq9HNchFOEp/D
 +TZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769508182; x=1770112982; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mMYC73AAK0xe0frY0GBjv0H4WaVO0aWaGbYrnPxRlKk=;
 b=Y+N7HbfeoonDdf6xFMFvG4z1lMxv7o0nlS87BHuJu6fn0LHpCUQqU/gdpkyTTDxDAb
 Hmizp2/qo1OX0tsYHE/U78y1IiRYIZgPLnb9EWVGk1vBjpuSq9NgeeIYe4f1p0qr95wi
 ePoxKRkhqft+GlPpaAbkPyP7GnD6+/6YL1F1I/NODzUPUwOkjKI0s0793rI3YA2x0SVe
 gGrzHJm1EChitWq9TWpZNS+xUts+CI2ql05mRoeKzrhD4wC8PlBu20K/xI9V45VLJR6D
 P64cVVqbLvcMrNH/e2e6fMVDeQLoKInYIu8Q5aiv/2yTe8f9A8ZGzGTTkbCaIrsmlSTR
 Ar2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769508182; x=1770112982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMYC73AAK0xe0frY0GBjv0H4WaVO0aWaGbYrnPxRlKk=;
 b=sXk7J3IG2fxCxMldaBxn+tFa7d/YTqbgU5iruS/FIpAGZu5fGBuTpe9nd7aD7D8yfX
 5PDlsnxlx/sajoiOt/TuCFrvWkH8FrhuiTZEEZiQPzHsLA+1J6iIYC6USgu76tGT8zm2
 cl7VRCJETyTiWzLoX7es8REbnf9XQlqXqs4+Mu9QHc+5Kictrfgt28MpYzbmgbkxbvNK
 x2+IcTE5jQp8hsjynNHhhYoc5Nyfr5AzfqtCebyUgGk3pUOJwfHieJUEa2p7nq493pi+
 bdNEKXsMIhAd67e+Buq25Y826jDXBGJ9xJBoHxYWr/YLpUM1KvUzqOXB4H9oZpEG6+UB
 qMaw==
X-Gm-Message-State: AOJu0YzO0i0f2lzOqvCtYiuXlhN2V3VOE6DWKxn6ZP/HJ5jZLoaP4W5w
 IKg7+Jo7XEirC1oD3zjYb46Vq3BDAqbJs3fz73w/M71EH7a/yoZgKKYnue0xvKKWz4Gql6XVti+
 2Ojv6ammoAUmt+66JCIFvDJqm6XofIgJ1eeQ+UnoZLw==
X-Gm-Gg: AZuq6aKtuLffy5n5gJcrRqwzveYsFvEgZ7g/fSJSw9C/9FvRAorcuiTw8OKyLgqwyFQ
 laYyiVs/cUfvkVOygMHBtWU6hrrQu4ae/j5MGKooASyEMmlCa3lmAzQi3zV0YLuCyoYlxzxKuD4
 m1zFCUNmIF7KZVncG0vRoBwXPjpWlotGGsX4T5vvAkMM0xp7KqCXolhUaCKtHlw+LpLDOX2oyjz
 qvnK0KOxAiL4zzy7xvDSbusPhIYplHPZLHkb2yznh7cSg7AwcJZ/QPv6NdSWAALYXLNKg==
X-Received: by 2002:a05:690c:992:b0:78f:984b:4bb5 with SMTP id
 00721157ae682-7947ac92fa6mr11035667b3.64.1769508182060; Tue, 27 Jan 2026
 02:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 10:02:50 +0000
X-Gm-Features: AZwV_QjlrwRmcic-KhmDi_rLxdXSusFcfty7IMXfVAMCunt8qseqf5y0IzNHBL8
Message-ID: <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
<ruslichenko.r@gmail.com> wrote:
>
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>
> This patch series introduces new ARM machine model, arm-generic-fdt, and the underlying infrastructure required to instantiate a QEMU machine from a Device Tree.

I'm afraid this has been a feature that has been suggested from
time to time, but which I don't think is workable in general.

Device tree files are designed to provide enough information to
the guest kernel to allow it to find non-probeable hardware. They
are not designed to provide enough information to QEMU to allow
it to create and wire up all the hardware present on the system.

There are specific niches where it can be made to work -- I think
Xilinx have or had a setup where they were generating an FPGA
model and a device tree and a guest kernel all from the same
single data source, so they could put everything necessary into
the dtb, for example -- but I don't think it works in the
general case. As one simple example, the DTB doesn't generally
have any information about how the Secure world works in an Arm
system, because Linux doesn't care about the Secure world. It
also doesn't usually have information that the guest OS can
probe for itself at runtime.

There has been periodic discussion of more flexible user-driven
board creation, but that has generally been with the idea of using
the QMP monitor to orchestrate creation and connection of device
models.

thanks
-- PMM

