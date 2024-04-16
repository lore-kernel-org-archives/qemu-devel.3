Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiqv-00008E-TC; Tue, 16 Apr 2024 09:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwiqt-0008WQ-Kj
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:27:59 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwiqs-000519-2s
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:27:59 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516cbf3fe68so5517200e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713274076; x=1713878876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3F7bJ8nbnYbDWR3CYPhpYslCgWCxAo0NClKpbkxjhpg=;
 b=tbmmCGAWsINEyS7km9yOQl4EMDCwajI197kVZpVJmF6FE7MYucJ3iMzXT77/JffA9b
 7Cu/HfuITEAFrGEgKzVdrOcF/9DWPtZs/wZDb1MPgqZRkTfkL/8+lE6A5dtQdNn+8Byq
 +jPfuRngFt5hWfuOSe/S4Ta3m9hiobEf72Bs750ZOUf5v+4jVmuykA00zF69y+owuxjF
 ZGew8bVddO5Wf/hYkv3xQtD3FTPSRv1WlG96QrRrK1Yd5QeTz+Lxv4BpYLiCG0z4XcpI
 KkISgnQFKtiKho8OrcPDSPzExEccwB7yt5kC6CwwnzS5wqp+En/6OwaYEiDpnaQvTaj+
 wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274076; x=1713878876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3F7bJ8nbnYbDWR3CYPhpYslCgWCxAo0NClKpbkxjhpg=;
 b=F6RUZ7AaAolrzKLw9LuqeK04xkVCDDicz40+PGA8hDfCF+wZIIjTTwSSHV23VmxSWR
 J5DRNTAlUR/OqqUomAlAJ6Wvt1Hl/3g0erlMK32ifgM3LUojOM27ldp1Uxvx1KCd+Zxe
 0lDWRO3v9VaiFNIpml4sWusqlANwthNMMS/lCSORqa9FNbEXxQXanMwfpEJ/Fy1ACfJ3
 2wVjhannLPNksiQPD5rQWJo68frOOaPTtDG2DFxo5eg9xKXHOR8SyJzRxv9kDEJGqCCp
 qB8LNnf9JW5mFygtaSbiOaxhyN/UJop4HMPTF9kb8XCotfkRzQbeACNaKooAxF/E/qlh
 eGCQ==
X-Gm-Message-State: AOJu0YwDkoONI68Kps3OBbRi1jw+6Tqbn9RqgLLV9NELcOO2y8AqJ9tF
 If4O4Z6DVWoB6y6saOfOa6lGNOHUXc/ChFGRLY/4IMvqcm5gZKiFmzlcsSoBVs1Rubrzn8PTqLV
 LfzPCyszxxW2tO3tzobrSMFSONnRP1oWE3vf2Eb1zkd+6LA6x
X-Google-Smtp-Source: AGHT+IFOuLT33dfq8u6EYkimuPP4K0Etp3obeZvptHLXV55rP3MGfazaOIvg/2TZWFcLZy+zw5Tq7+inbvPQrLFzxhg=
X-Received: by 2002:a05:6512:3f10:b0:516:d126:719a with SMTP id
 y16-20020a0565123f1000b00516d126719amr10462205lfa.9.1713274076125; Tue, 16
 Apr 2024 06:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
In-Reply-To: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 14:27:45 +0100
Message-ID: <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
To: Peter Dave Hello <hsu@peterdavehello.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 16 Apr 2024 at 14:00, Peter Dave Hello <hsu@peterdavehello.org> wrote:
>
> From: Peter Dave Hello <hsu@peterdavehello.org>
> Date: Tue, 16 Apr 2024 00:43:29 +0800
> Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
>
> This patch adds a basic zh_TW translation file for Taiwan Traditional
> Chinese users.
>
> Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>

This name in your Signed-off-by line doesn't match the
name you use in the .po file...

> ---
>  po/LINGUAS  |  1 +
>  po/zh_TW.po | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 po/zh_TW.po
>
> diff --git a/po/LINGUAS b/po/LINGUAS
> index 9b33a36..08163e8 100644
> --- a/po/LINGUAS
> +++ b/po/LINGUAS
> @@ -7,3 +7,4 @@ sv
>  tr
>  uk
>  zh_CN
> +zh_TW
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> new file mode 100644
> index 0000000..d25557e
> --- /dev/null
> +++ b/po/zh_TW.po
> @@ -0,0 +1,93 @@
> +# Chinese translations for PACKAGE package.
> +# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
> +# This file is distributed under the same license as the PACKAGE package.

Can you replace all these placeholder ALLCAPS items
with the right values, please?

> +# Peter Hsu <hsu@peterdavehello.org>, 2024.
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: PACKAGE VERSION\n"

There's another one here.

> +"Report-Msgid-Bugs-To: \n"
> +"POT-Creation-Date: 2024-04-16 17:52+0800\n"
> +"PO-Revision-Date: 2024-04-16 17:52+0800\n"
> +"Last-Translator: Peter Hsu <hsu@peterdavehello.org>\n"
> +"Language-Team: Chinese (traditional)\n"
> +"Language: zh_TW\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=ASCII\n"
> +"Content-Transfer-Encoding: 8bit\n"

thanks
-- PMM

