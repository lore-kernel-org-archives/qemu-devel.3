Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA7D1BDC5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t806U-0000kO-0H; Mon, 04 Nov 2024 11:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t806P-0000jo-Dh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:38:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t806N-0003C2-8D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:38:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d63a79bb6so2954079f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730738329; x=1731343129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fXdY23zSMIOxlisonKVew/D+w5UQnBSolsTL3tXLl+o=;
 b=Xw7SgvD6Bj5ovIy51e73/fCB52dYDxUgD6arPn8dMerminCNUx0vfox5syuuar5ROy
 B0SNrnt9/ExgwzVLPDl0GplM+T7tuhjRPBI3DAeI9xjZZe7o7zzLloUTZ0j9aV3WNPaC
 MlVaUsG5zTcssIlacmyXi/pb440U9VhhdVJZhYOQ1D2xnRZnBayG+rd6W31AOloCpONo
 FDT6SrnxHux8hjnWt+xjcjkDX7wv04vLzrsg5zNQ4XNld/qOBrqbGFE/ZBOfFyJesYpg
 xPY6igYZGcUr8p0zpqH8dmZpabQL30T7uHEHbYJ28KhhwvdhmPqYQ5ljOxB63ieUuVj5
 f8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730738329; x=1731343129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXdY23zSMIOxlisonKVew/D+w5UQnBSolsTL3tXLl+o=;
 b=X+GClaDi966HmzGWr25+P0ByjdSBTWpsZ/7ACYzbVbIiOHFg0BOoxTwbh0PuCEQ9Rv
 VFZDpK6c6Q5Bd5Wmx1QIsG+fohNGZHavLwZyVe23n/54Ec3cBLLs7YF10cwab//NAWDs
 PLMr/IeizkYLyabYTkoPUwlTeIuN0Jke9MseuuzV9vihTlo8nEtrCsvYq1Bk292mGz4S
 WIDupJZhcop4US50jyCafQ9mJys+WX9yeIj5Cr7e1jTYApclBkkRTmaP7qU4C9hZk6Ja
 SqfM394F5nIES4hh1VUUFCByyhd+Ph1xy0WtcvoMbM+fmxShYqtBtV+r4nvOdZWEIC30
 YqaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV91qXYrjFV7l/5pmkFhsFwhtlb5cdrSGbgDjgseDnBJKhcd5fQog7MHUMZE4251sIVzqI/NBflGFe4@nongnu.org
X-Gm-Message-State: AOJu0Ywssv6iVS3NBDGiKGCfZXIG2u3o9tthqlrLQgMlUF/52lW9RYox
 9RcqUgd3NLV9njt9gmuzieVau81SrzPkm8hCbGgnHvyWJlre/bxwB5j2QMMa+J5NO5E1fs/ZYm+
 tSp84CCQYcy8Yiz5LaYnHvMdeOoV2Znt95QCvVQ==
X-Google-Smtp-Source: AGHT+IGsR7nnVO5svFFhdHh94HtSd/pkYdD8et1+URk6CDOu917YA6x1iDZVy5BMf96keIQQ1JD2/ZlSoPTrP3NQim4=
X-Received: by 2002:a05:6000:1446:b0:37d:52db:a0a7 with SMTP id
 ffacd0b85a97d-381be7adcf9mr12674763f8f.2.1730738328924; Mon, 04 Nov 2024
 08:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20241104163504.305955-1-thuth@redhat.com>
In-Reply-To: <20241104163504.305955-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 16:38:37 +0000
Message-ID: <CAFEAcA9RjN+bZ4PWMBwrF7GosKpWg=oVyHb7kfK0anW2a4Ww3g@mail.gmail.com>
Subject: Re: [PATCH] hw/char/sifive_uart: Fix broken UART on big endian hosts
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

On Mon, 4 Nov 2024 at 16:35, Thomas Huth <thuth@redhat.com> wrote:
>
> Casting a "uint32_t *" to a "uint8_t *" to get to the lowest 8-bit
> part of the value does not work on big endian hosts. We've got to
> take the proper detour through an 8-bit variable.
>
> Fixes: 53c1557b23 ("hw/char: sifive_uart: Print uart characters async")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/char/sifive_uart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

