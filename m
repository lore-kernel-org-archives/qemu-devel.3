Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB6C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcB7-0004Ck-JI; Thu, 27 Aug 2026 11:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzcB6-0004Bu-6S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:38:08 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzcB4-00080p-Jx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:38:07 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-855de2d0d4dso21238567b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787845085; cv=none;
 d=google.com; s=arc-20260327;
 b=lnWzmluUtJuDj5uXGn1Fcf1T7Jw9jtP+GERsYbUCHXlgA+Sd1DvYkKCJ3oV6If+p3S
 HR0BuIuCHZgtKIdqmv6XPpNm2ds27XTOBf6+D7LPaHUYngjgFjhXOv0v8Kf2Z+2+oE2M
 FTwX49Dz0OR0H5rSs10x4FqI/1mnLUd+eg95tYBLP2CssJ34sWdjQ5vjvA0RJwZDAbcY
 von9DSjcrtqj2bY3SD1VTe7WER+ZDgnbICYRkOnI6qR/Fq1DM/DxGolEK7TgIVuJ7NhG
 Sq89VZPP3m+UFYjtPXADtp5zNz4edCSrYj0AnF6LpsufmsSpCIPaNFztoydXcGr8gyMX
 Eo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=evPZoOd3J89BjWhfOiGTl7xqmjIVFC1jrvFqOzTwlSU=;
 fh=bIE/bXSCkVaBwWnI5E22W+KoiLTAK5S4CW9f53swsiE=;
 b=QIlr6OvSga1UxFqj5e/oa9EF4v4qMZLdMsQBJcT2jerkT6dgiplWIj6kCTwNXMe2Fb
 Br4T3O0TMQ3qbwRW3PSiposrufYk734jsIEpWkpqPY1VCQ0yXariP5gJ9o1BxzUM1VB0
 q32MkCNkAzrE6SGrKREQGr8XbPzFfME5TiQGRTRv55Unr2zJOQdEDMzLCW6jzq8dRDKk
 RV7R5KLQV32vv6KID1j7fJOYUeqchHwfSxayirSKgwpDXiboAt21G+Jby1wrbGYc9ukK
 9xyw8vPd43VIpRllBPodDZgfig+wxSChP5mo+3/HF5kz8MNTK4mJ2G0Lk3rGUJ+SdsvV
 x1Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845085; x=1788449885; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=evPZoOd3J89BjWhfOiGTl7xqmjIVFC1jrvFqOzTwlSU=;
 b=jlxYAZFS3LKEGm1PYl7X1sZMcDhkf6sOu4Rfh1eJObAnoLu/rrDTe3Mf7j+eegEr8W
 K9fl+Uq3HpycKv/gTql/Seq/0KK3dz0IGTYqi30XygCCRl34UlCT+BO7gMWfbDeD9rCV
 JVF+EOAGY4eKT2FzgZxqZjhQ00rEXqLpi4yD4MKpvCuCaGVsab6qAJdH4ARR0TXkuYy8
 H5mPz3qwcD6S/Kz1bog8oB+9yDSPQNoModvvW70qJ0eGVoWUtXKFn0vDoOodZB0DR0ka
 +3fK2cq8Uy/S99tHGh5T7KrB6daQQxTjSCbgApkaqMPUWIHxsCiS4PshGewvjCv3X4XS
 mJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845085; x=1788449885;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=evPZoOd3J89BjWhfOiGTl7xqmjIVFC1jrvFqOzTwlSU=;
 b=G0puuEN9Y7Nplq6YJ6fWcL187FCFJV/XazTjthRaASUsQGz/FwNmM5WgVF6Uqp6/BD
 lg82QyTSExSWJ6Oqgyzs2dDWKJxg1bbE7e+WzFenGnhnIlSgdidsk6xZqGbZBb2Ktagf
 5mIkiUCt4WN8hemd8gNGcVvZvPAmv9CwxC5Ow5aBB5ncqNMkAPwVwD7ocgTTKxa/6Ni1
 ezBLT/G+TAOIhf8nBhn9/nonVnCcgAeHo9cUrfq9XIGyvmRyB4oEmMb/jmwRa+UcSiuF
 uGX2yPozOz9ys2Miv/+X6RFCPc0OAif8rSf0Jm+5pMabCdbdyJHUIOsCsFxyYHnSM31M
 lqTw==
X-Gm-Message-State: AFuF++lLO+cCIHMULY5ilhuqSqVhe5CXfkm2IHWS3f9jlkK68hXhcNp1
 h8pwU6tqpLd1zsMVhFybBjtg6c+O/ROJJeEDVsgS+c2Q2ynOL3lLf7uNnzunrJqxoGzttBwJey5
 yHW0MHyZLmg6OydrluBQ0ymq7ewfaZadnsSF9m1UiMQ==
X-Gm-Gg: AR+sD10tJrWh/h3wTbPgAuJeydjDUZsaIbLRc+NpIhVwTMQDMUfHcC6eTTY40HO/7/j
 NtvUn0TKTuSgG84itXrkizz3Z0hmSe1C03RIDqUG3N8D9pzadTiGEItBDYm3uja34Ie9DjeY3Ot
 XuT2V8A9i2+e9jlEoCLpjzhHl0zeaA1c4NgdMvDBCbdjR16kaF96qHR1xNYqr4qrx2zsG3dpNbw
 Fs4xxbkGhpeR6VkNN0aaewIW1yZPiJg2R0R3+QZp0tvvyfRxPhJt8s5McpMcw3O0KG4nTg4bFaR
 O4UyaaOR0ks9242SX/kP5Jck6cxveIfRr8rwdOLEc/gTtoKkeKo+ByWKz4+33bbMcb5SqArRn/X
 I8+SEkJaKRQ+wbSVTpkS8wyzSomFt
X-Received: by 2002:a05:690c:660b:b0:80e:dc2:873b with SMTP id
 00721157ae682-85d6c7ea528mr103807b3.16.1787845085072; Thu, 27 Aug 2026
 08:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-5-richard.henderson@linaro.org>
In-Reply-To: <20260827041557.775080-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 16:37:53 +0100
X-Gm-Features: AcwNN1XttaOzpnC91BNEx_86K4PMo7UkBT5co3atTT9xspb5NiKgrkKAOBQHpGc
Message-ID: <CAFEAcA8jk7w00+avXj14pkMEgvS0DPY8uR87psLP6+e2_fE1NQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 27 Aug 2026 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce the names and allow them with the virt and sbsa-ref
> machine types.  So far, the cpu types both exactly match "max".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

