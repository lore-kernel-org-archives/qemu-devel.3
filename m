Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E9CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWZj-0004hS-Bv; Tue, 03 Sep 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWZh-0004cP-Ja
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:40:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWZf-0007RA-WB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:40:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so1836994f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725381609; x=1725986409; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ca4/u9BxH3ehujKMf3VQzgAvKmTY63OWpDI6n9L/94=;
 b=QXJAzkWL8dnt1YQUEtEG4rpWSume2XZkkQP7xUJLALZ0O4Ched7qXO/5rw6CuUrSEt
 l3XkpkaphQ4IiEWebjPQGxcWVdEV5DtCDBWj6G1eRNAIyUIXm3hbHJnHCfG+IASYOyY4
 HzcxjW/DfaspA2qQ94p1boHIwtlfrmkgr4JOrP8LmovlBwwEbpaVT18kgXRPCCc3xUyf
 bZr5DyeBm6p8oboaNATPDl6+3TlWhCa0Qhlz0f+tAzYyef3l3a/Y0k1/Yi/Z3pSau43x
 M93v4mWnTUaN78W5f+x+m+PmaaijN8a6ButYTJ1nfTY/F4PmQIAwAe6trzP9VQmeH8gr
 ikvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381609; x=1725986409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ca4/u9BxH3ehujKMf3VQzgAvKmTY63OWpDI6n9L/94=;
 b=NT1nUifCGYnEKv8gO5d/RWNanF5KrB6DSwSGJx0+1o5NPasuTCbZJ4qsY58wJmYp0c
 IcmAgfUgCn5cl+5CuJi+NB2UZrTDpHOPQHlSeKUlgqCq7r/dPs1bO6jUC5uumxiezpPH
 PzSOBSe/Tm5dTQ7hFPXCHbQYdYsnxSkE0glIV1aB/ZweLRVyUj4XLMFoSIM2vRXPOK5K
 YDEGfSZz5CCJlP809zPK0z2nE8MAeGyPRyydNwNp6ZvEbpmvGZel5N22T+ngcfJaA9gY
 t6FDhYr3wjbRTJY3i+PlKTLQ9ydwFDsl+xFIR8ZD0dLRrCIobzF3jEK1HI2nt+ajHPYl
 wfEA==
X-Gm-Message-State: AOJu0YxskUxFR7egrNS0kL//3INqXgozhC+bQDB/Y6y/1IBP+sT31iuB
 rPDE8btP+BT6+1EW7V5VZ0diA/c0Uqky1Fc2X0pVd6/iCBcEuCzJIu3jwXLBsNjzrWnbshglru1
 dTNAQHs/S97G2nRTxNVTA/jIniWVp6PXKwL92TA==
X-Google-Smtp-Source: AGHT+IFIMMkbh+81lxAC9Q9Wcmfqz5V5FMwoz/lBwheLstu0Uf9QN1yi5pFyg1f0rwgXX2rVdU4Fr2a8d1xkIQrdOls=
X-Received: by 2002:adf:f589:0:b0:374:c92e:f699 with SMTP id
 ffacd0b85a97d-374ecc8f1c7mr2962135f8f.23.1725381609426; Tue, 03 Sep 2024
 09:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240903144154.17135-1-philmd@linaro.org>
In-Reply-To: <20240903144154.17135-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 17:39:49 +0100
Message-ID: <CAFEAcA92ze+sow=S71hG0HNwYOyUnPh=+26kzxu=W7NLYN09KA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Explain why load_elf_hdr() error is ignored
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@huawei.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 3 Sept 2024 at 15:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> If the file is not an ELF file, arm_setup_direct_kernel_boot()
> falls back to try it as a uimage or an AArch64 Image file or as
> last resort a bare raw binary. We can discard load_elf_hdr()
> error and silently return.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

