Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16674C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIz2-0000oY-Kd; Sat, 02 Aug 2025 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIwx-0006CP-NV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:35:30 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIwu-00050R-VU
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:35:27 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8fdbd45e10so2056599276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166923; x=1754771723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aW1PXTsA0BSzwss5YWeZynYXiLkPlAe2/jtr9wFBWiQ=;
 b=Jgp72tSvKrJGU7OHYbNe367S6ely39tGEPjG90wrGByZMMMchIn/hgwmCAJcm0v9rR
 D4kZbWkpafAXwyJ1bi3eU1qoqMCQh5AM2rBMo/psx1hI6q1QOwDzLf5/wPwcZNoAVD7q
 54VoJQAdsMTIhnj5Zu4fmKV0tS9TiKdHMveW//KY7P8A0/tB5vutLVbc6zJ+SGuxU90w
 uGiOPyHVJtWyDV7G4RcbYLEeBjlUM5ew6WYj1NZCouQqJd6TBcJv5hbunVi8WijPj04t
 7uvpjSr26Fv5LmXr6Lie8W8c7gLmiH9vm4CJ2w6zFUy9zxT85n1POFtjAYV0EbSmj+8o
 P1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166923; x=1754771723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aW1PXTsA0BSzwss5YWeZynYXiLkPlAe2/jtr9wFBWiQ=;
 b=DoXzbeUXcm3B1Of7XneaGJLhh842tsobPvKW7Q+kdGcsO0p/Y+goiohs2KVEq/ljEN
 mOZn/8radWjHcaxN7hd/650cGi7TOLkQC52prmhi+IX2VYETce9Y8/K8X4wpBI7uHzBm
 zNXnTUHWvxripR832wSbuP79l/w3gbhr4IciQluRI/Ia9GQfCbht0RYN5jHI0Nn5+IK9
 R5NUVZ9n8Y7aWhKRVat4H7IfLDser8K7CFEtGh5KjOuSQjXjNpEQt0dK9ANRyKUrl1dx
 xHM88vKUzEnPn6DKqABRlc56ayBs0UdyNDi01hjkb9VDZVtUEnh/zMFYLYn53/B0/Lyu
 vzLQ==
X-Gm-Message-State: AOJu0Yxo3RukmgFvjNrH0cdeDk1aXE20G6UnSzygid8eq+JB1QrNGY7X
 jI10kW7oiEg9XUovssRAPXAOe2k1NiXHZzvFPfkfxWDslMPy9skRqyK11JXsDCuv5lrgV+nqSwF
 q4MbisdqTDcfsK3U9NDKX3eegfsUm9Upog8SLEWH7IA==
X-Gm-Gg: ASbGncuC1ZXqZOmtbnLrX52Z2ntQvYCn+nMRAK4R0opb9BUFO+vaeNAGQj5H6xMb2NP
 hP+oUYY9N5Yq5zUo1C7HW5ux54CVM8Ww5QnHt2robVU4jXHC4gTSkmFanW0wgtJkbGfkjdPHKk4
 U4lZG4QEggXRvo12Yer7u5mdGt2cfFPQrChb5PcyBjDXLL9EYrq6ZdN4gYYmRe4vHT17D/N/TQK
 tJ4zC/H
X-Google-Smtp-Source: AGHT+IEQsD8KppnNZVgItXt1AEuKAU7AZRYzxPGrfGxriAQobRrFPaQpJEA/hD0g5Cysn3zIbWFNZ261BKCQokf7/qY=
X-Received: by 2002:a05:690c:91:b0:719:fa9e:b4e9 with SMTP id
 00721157ae682-71b7ed16cb4mr52352607b3.4.1754166922782; Sat, 02 Aug 2025
 13:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-81-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-81-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:35:11 +0100
X-Gm-Features: Ac12FXy0CHfCA4LTYyrbtSmb4nQsiSvk3FKSfyYIop51Xqqjpd0wSenyB6AzapQ
Message-ID: <CAFEAcA_kXcX3ig4+WsC3EDXA-CACt2AGAQmTxQKHXWr+sQ+wbA@mail.gmail.com>
Subject: Re: [PATCH 80/89] linux-user: Rename elf_check_arch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to elf_check_machine to match ELF_MACHINE.
> Remove the unnecessary definition for loongarch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

