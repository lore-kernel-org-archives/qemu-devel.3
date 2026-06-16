Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5BBCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSu6-0000MK-SQ; Tue, 16 Jun 2026 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSu4-0000Kl-76
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:28:28 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSu2-0004qE-PG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:28:27 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660e9ea26b9so4690043d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612905; cv=none;
 d=google.com; s=arc-20240605;
 b=LLHEeMVLc2DEeWlZxIzhKebgX8qSBqfMbr58Nj7ttb7R8pyUa4ZKvW8CVnBAVnFvMX
 xoTkgo+s3bIFJ45Q8+Oq1YrG13IyVRlGGyjhvpQNdcdbdLCOJeAgxFaxFJcGurDeeKev
 CX+ACRVtbnMRWvsA80FWDCGOKujg64E79BPp/A2wDssOd3qNiit4pREp4p2GLFjE9gRk
 md/0f6xGY8ZVwxIde2yZfDOr4fhgpzggaZNW2KZjQ5P66E9J2yXHFyXw11vQPquhvWAz
 RNlPP3W8bygZkXCIhd64k7JgcqqgoJn3AyUT1Vva05/PNG6Jz77NaxmhEiANhoiNPI9H
 KEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cykzMoqhj9Pvqurt1E/yxJhE0PiJuYvWeaXlCrunfPI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=NoMPfnLiv7xZf+THIk/bvvGByQq103s5xS02nWB6PrfzfW0Tr48Oo+QJscf18nGFn9
 E1YgRPLaNKRhpobRnWiTONsxQaG4dYi+7fD2C8rEk0GEInl76JjZCaY4MfEEHMsGGpF1
 0RH3I7ViIxZZzZSHtQXGvDbwZlvuO7j8W/fawfsWEdqbNoTBR4wPnwlkBa1gNGAt6YKL
 jXgpnh29bToBt+6QhR/o2sc0UHqOQIcH4dXqZ6WJKB6KA/7/NWZAkcG2DVA6XB8I4zlK
 3E25AvvCKzyhplzdxpvLnwAuqwF8DS3zFq94mX/FQY7DcjC9a7FZu2++mfI6wgTHAa1Z
 NcDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612905; x=1782217705; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cykzMoqhj9Pvqurt1E/yxJhE0PiJuYvWeaXlCrunfPI=;
 b=az2NoDMwAagCjS0gSsOf8tU4yWXp1vMZ0dM7WUVIz3+imsIHbJVXxFBK1sMZnt+scj
 mn1l0Eou+e8Rd0r6q09uv9kgYrVkWV3I3OK/OQSEOC/lu7Nu8dVq1ucXRO6zKqwhlsvI
 IAZLYv4L+47Qfev3/04QOeOZ/03UdBYA22M/wEWHf8OrRpyvK/cgGqSgPY80gXU0Kq0x
 hZ3KrIYhHIYu2Cl4NOEfLDPSIJhlo3u1hNSAcUVLC0ljTbWq7WmnsDATuTHrIiytve+L
 RCa7SPPRC/xGkESSIA2nMJcZ5K7aDmBQadachXyKJ+QV3kH6Gb2u3LignPEvycIKL44B
 36yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612905; x=1782217705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cykzMoqhj9Pvqurt1E/yxJhE0PiJuYvWeaXlCrunfPI=;
 b=PmAq0HEyoFHN1mauYVhd/5OrDjfRLX+CfEjm+wdczldt4xfiWJ6VID+gMUrnybXw3+
 wNkb5keH0mU9csWRqtHJYrlrxBPYh5dDOsDQLoNnvP4FVlJ2iFGtmEdxorkjsAIJIW4o
 dNdGROb0gnRcmqtRdmNvj7T0c6HbPteovACenyJ343Y8Lai0NlkBanldn3BMWfbZMqKd
 DXOyHq4TxSh0xuD/+DqiQJB2xYZXKgdX42+ME8nKnhVybyZnzuoPzK3xxtXZ+wgIcrGD
 PTOVr76f3nuO1L90i2F1IrZSRfGnG411b7Xw4M09kG1/dgkS21DZAexvQsmtHBYoP44n
 6xpg==
X-Gm-Message-State: AOJu0YzgzRwBR+iegKRaGPD0yFQzOILQqvU4dBdeRXEr3WUegdOa575O
 WQaRC6RpNvmLOqpzG7f6qyKnBVPM7gr+HjgkG5wBvj/JtY8S8F/2aJ6kzyGAnYslnPU3mgu/Zua
 y2xA5QqEM5PpopRZYwsi9pVSnrIVvG7BepSQAShUDeA==
X-Gm-Gg: Acq92OHoYYuc7m/pt6mwvEK3kW1rnBwY0W6s7lYEuosSGlPn8CCQ/7aAYlLydbtGeBd
 tNQ6asGlK+RqZNbWWPgosBZwde2zYG3WBlc1KpcH+gy9q16vIyN/g3R0hgHuOBRVb7UcvrxzzDc
 u5DlLpxl3tJTtpdtZQGFTpbbsmdz26LYY3+UjGaJuvc/h6gw18SDLJzBLXX/ajvp6vepL0fyQdW
 FTeJ870+h7FfUO45cb2rQEjNr6PYHfufu+8w2c67mNC6ZBRKbMZUftHvMoySa5VpGuVkH1sHfFZ
 t/NAoXBnYExOX9/K9GTCJ6V3lIe8TmklFjdp2CR4UNuz4SMCtRBjZBGXx/P6Erp9S2Q=
X-Received: by 2002:a05:690e:1309:b0:660:e35e:ac09 with SMTP id
 956f58d0204a3-66284dcd488mr13199491d50.8.1781612905274; Tue, 16 Jun 2026
 05:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-8-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:28:13 +0100
X-Gm-Features: AVVi8CeIhxEb8xrvUVQ3ru7VRS1qBDcDC0fWZxP2YENubg4qj9rOu-1Op8RFobw
Message-ID: <CAFEAcA8N8ERKTVefUF7-YQC0F+=LBMybFa0RvCsUrnuAxT2mSQ@mail.gmail.com>
Subject: Re: [PATCH 07/25] target/arm: Implement SVE reverse within elements
 (zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes REVB, REVH, REVW, RBIT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

