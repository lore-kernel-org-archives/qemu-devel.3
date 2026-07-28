Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32911C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojnW-0007oM-0F; Tue, 28 Jul 2026 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojnT-0007kR-KE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:32:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojnN-0001g7-KJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:32:45 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1c24ec9525so656559966b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252753; cv=none;
 d=google.com; s=arc-20260327;
 b=g40v0TabOAXoQzvmUtotA2iAMpSgeCQGQY5O6Pd4kw60mLIV6nWW9f9Kg6rRclRap6
 Ns0B+5P5QmFFgD3qTL2undkln74aPYOK2BuUE5Dv4SZ3M0t9AFdTHtQoxIiUtYmmt9Z8
 gtyTXQgEeVFH0DrWQGfzHXNxcHmp5QmXPyansHr2uTR50cLHbmOqU+5EkQYzvBbpPWQT
 CBcAcMWzCrNwEK6yf4Nq8Nv19D3YYuO9QNVOIq6IaPXdEMN+jtlonZheT9j01KDb2N9s
 wo0WxkCyAv8mivew1UjxVa+5CRTouU2z9R/7uf1gTHnG4rS2RCe79rai9VmusxNLBxpu
 xMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ent+e8+88shsT+f5bkRPSYgJV9ACUBBlL6QBTaEHXTY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XdKq0Id5ghUdZtoPk3UdrUl34Q17gyifQ30LDxroBUB+SLrqp8yuImLPOPQVlbnhxq
 kipkFqSVUi6HrN0BfkOdarW0BnRYOdSV6TTrFFpkCDWYQty++HoiPKbBHY+qwigaFUjd
 zuHtqo/zuLIdkKhFakmhkzQ3BFaQdLo8gUmavxRatjh/6Ve+nVX/GUizw9LEZzLS9/Zx
 34gmR9/vT32ilUptTqjqP0L0r3MJvdBmvL7BJspqZb1Gvff3OVz+LVjI4v7OodIk73dL
 8dtDmhiYHhzYMXtFS+LqSUa4JoOTH9chEmiVGbnqlN8hnRu90W4tIMD/PJtoKwHSEKQl
 nI0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252753; x=1785857553; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ent+e8+88shsT+f5bkRPSYgJV9ACUBBlL6QBTaEHXTY=;
 b=L8mi2pDaeLCKkiPlcNSKvgHydYxYn2nui3puWeQtRTOPsqPgL0N5oCS2z2JBBAq77h
 hM79nnJN92xyFp3telef8ymAJjS3OVXJetpasqpZSICkjw26IzgaJZtSF9xLZuoyF5Ge
 RxTh7KL9N3LkHxTw7XyjnLZjIvNtkkn5gzunHUXt6WMU5gCeX/fDwjHDwz0IArr8GqOU
 sQd5XzBV3w48CL0KDrfN3Abh0xL58v28oFZ+OL/2z0qgpihsOQJEZhdYWjiYVCI9c5RR
 DIfIqs18I64iU+Bnii6/vmG7og0HWNs4wnP1gaoFCbcyIVJe5/43Zwm6xgXsLES79zJp
 mf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252753; x=1785857553;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ent+e8+88shsT+f5bkRPSYgJV9ACUBBlL6QBTaEHXTY=;
 b=beZs7NTvTw2Lo076qb93/a0jX9A5okXld0rte4ZKSKUxCoqczAQpObSjip59gyUztI
 ApMkmsX6yTiwTGKWrPX/oHVV0LwqxGJr7BKO20dAF8Wp668vwJTEE3j+9NaGTLbFXUB3
 61fqHHTWkWcAZjECTy3w9hxSnGen97k9M1gUE8r/61uxUQOeM592EbQRpbHdmFBT3R5L
 Yd4egc8aIe8aLm2+z/5AEIRzD+/yU8uST85pNQbx6cgZI30TLRB2Ii+pyjGMFswoq29T
 3aK5L6hS9vXw0L9YqdQJsE06Z6NGFHmuiUAN8Twvz0i77OAiJ1BYWnaoqlmBDf31NI8X
 ew4w==
X-Gm-Message-State: AOJu0Ywnqjr6h56AjgHc06Q7uognEd9zq2coa3gNxwde8rhN3vEJBDay
 TVXpdUEIbRUXwU1w9J+u2dW/qtHTB5TVmVOiNp4umMjK7vv96rXmjDKnTmojfaxLlQy3dvMNPeO
 jNq4d5cE7KVvkrfFsELHIt0sAbUy6LtbmSpjDZ+x4lM/p72nhzaC6
X-Gm-Gg: AR+sD10VGdrEJYC1J4KlxktrcWI1gEyOCkPns2TgFBypWygE8jeKODghZPkZM9M+ohP
 6sYdx6YX28UBnzTNFJFidX2Ibe21pnXIrSoEYzFB1Lit/eRSlO/nRvw0pD4v8klx7yKIe5WfCeO
 GPJ1gxqPgbKz/Luqy83yrw9kh0Yzw3OuApCzgOdfC1fO3zVvEwCIfCXGfwrhGeCxYIS8JWidGks
 SkBSnxDjHzp0Iwem7NhJb9guO8GjiybMgD5eHZ7YHJz2xoebn5OkaFQASqm6JefSA4N4d7JUJv5
 GkUPUkpfkm1uy95XprvOmU8E34tECtyPQnPmFXXTUVxZF8d/1Dhp6jms
X-Received: by 2002:a17:907:d7cb:b0:c1f:1267:deb7 with SMTP id
 a640c23a62f3a-c1f721918c0mr165339866b.62.1785252753488; Tue, 28 Jul 2026
 08:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-10-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:32:19 +0100
X-Gm-Features: AUfX_mwl52ruR1jUPYHSphL9m9mruP7Ko5pWLodRQXjG5rGqB-bhe_cVIx7wVdg
Message-ID: <CAFEAcA-X6mZU3=zU+0G+aGi9JXp3Okse59c7dMe2aHEa8EcptA@mail.gmail.com>
Subject: Re: [PATCH 09/20] target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Tue, 21 Jul 2026 at 19:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 3 ++-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

