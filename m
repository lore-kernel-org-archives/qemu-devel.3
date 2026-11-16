Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0F606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pQUwngK8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuFj-0005C0-To; Mon, 16 Nov 2026 05:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuFh-0005BW-QJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 05:47:57 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuFg-0007Aq-6S
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 05:47:57 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67c24619b19so2118864d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 02:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794826075; cv=none;
 d=google.com; s=arc-20260327;
 b=XlVsjPn7iGO05o5jWNM19IanM2AytYDruG1OdJz+XBMdN2jHN54tSuBXPTHSsl5vlf
 yrqVQWa1nEWfK2hiVpu6ijuYDFowg2d+x5p0ixCPbk6OpL6e3EgtkFo6W2t5/ON7dIb+
 CpXO2ZUd0qSYD6Pfy4F+XOoDEYGy7wxzpvZKugJrKvsrYN2SJ57ZUej0gmMYie3NBn2i
 cWEwl5TrumcK3DQPDVkHp2zGchJIABNooUQfne8Isx0c3uuyQ/LLMuSIvqrVNMcuLe5C
 Go8kVtSJ0CVZ9up+krLK39v1W4RNq9zWcxlYeM8j0Pb0VdawXmXZIFtA2QLWjFcQz7/5
 reDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FNq9PfJurnyuc7y5landwQ7qHd9nVILAiiD82paiYlo=;
 fh=nhKiv2WFBbyj6gzxfcstlbjQCNvQ3gV7AN1y+I4NMs4=;
 b=WKkgOLOG4feX2EKb94Wh6a4D1HmCOYg9yO5B8ye2LUzQeDlswSEZzztNHmZRViOl6L
 +6ID+Q7N2VKnI3zmEjlQbbpHlsqBNjcELl4Uky9ah4JTmARYUeQuX1Tr11ZXNm/YQ2c/
 jzjh9vhPlDovLpmvWFgliG6aKauPmNWZ3pmYs0Om2W1ttWsdqzCsa8UPdHuocY/CxF1S
 PZIa3eRW7briFYOLyhp2BGWo3J24jCoULEGUPjIabwnIs/+U8bloi6CRQpv6mL50uzpO
 ZB8yZwrc4CGJnKX6mN8hFYJBanProZjsWMdYvo3mNWiWpH+/go68uq+rIzmH7T5T0K1e
 fGLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826075; x=1795430875; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FNq9PfJurnyuc7y5landwQ7qHd9nVILAiiD82paiYlo=;
 b=pQUwngK8IDq+13qqezpk+c+FfEpb/ucnr51jXT1mzpTciiXdwyveg/YcYZRssEAmQA
 S1o2AY13U/UeZQnqNuEZaXJjP1r0L9v+BnGA8nmjPCbnk7smVzDVbKWnxkYpsIJSMwtV
 dsEG7CuBO6j0C/xhCRvW64ohy73kkWhLtObYKgSE92ygIe+QG+/w9dmWCA/Y8TJoSoEs
 3EPaXgWZ2Xzu+tFWu4mDCwwvMmzD0OEEu+b8vByNEQkPamAH2vIxYxuu5L8R2Tin4P6o
 bmTXlXWY2j1i+ot2c0AtnC4Q1VCV/gNRNIrYYqMxRNyq8s9IZqNUq8gc85HK7q1k6WMN
 ABlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826075; x=1795430875;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FNq9PfJurnyuc7y5landwQ7qHd9nVILAiiD82paiYlo=;
 b=B3Zkf/nLlIQXb9nIsp8QlljoGfTCog3uE70kTxxlfLOHaqghuf/GK3sumS4aTJ3AZf
 UAFZP5OtJNWkwHHex5ftBREWuLmW7DFTfRaFn/eWz+4LSv6fTG1+NO/2ZxK7A/W9tDYL
 NRXlunSZZcK2z0t/jljiuRqJ6wANRB3Nkz91pRC08Z+hjl7Amk6YmelC5/J2wAT2d6PM
 zAx2tH+0a7rP/b4AapjQAWsVN3BhlwQ284nvdalnPnVNyzdVoKXkAhLa6yTDSsmvAtT7
 08taFisodqtD9oP1Dq6+Y6BUSl898u5dFoTXuYUKzFbIWR8yMibmR8Sjf/Sg0WbeKDx7
 I8kA==
X-Forwarded-Encrypted: i=1;
 AL+hErFic4ZzUk7hWB7/+dDRAF9yJy5XMVoxromNQXBdc5zOBQefcoOT22O3RjsXXwwG+mV7TfgZ+lGobhQA@nongnu.org
X-Gm-Message-State: APuU4Z+BeEV53omNjaKGQ0j5UaHrwRKBu9m1BVB/ELXc5M+t4Bk7b/in
 NNlHVzJZx/4qPIcxopYF/0zX7hfDfohuX+W1UhDMYjPfHSq5cALC2VNuzjXL94Oks0zUx+CY70a
 pHJHE76od2O75A9H/3LOJh/8HEEot9m6Le849Q55mJA==
X-Gm-Gg: AZFdTZeh13pe/rlFhYc3kmxq5cOLKG1uYnm4Zvbq0TUD63qSjmIZgv5Auzbv7ybQab8
 V/mnJLLeF44NraqfCXEYvkNxFoShU/EzLuuNCY6VWvVxGHreiIWMlwNJsnDIDJJkqah2z9Wn8Er
 ZqJjyT84MKn7Xop3EsARfGICjDnbuRO+DnHHko0IY1BJzB9k4BpHE7sRCSYmm9xZghoV77+2Zy+
 N5p3eyYDoZQj5PA8p1VNY9wvljuoKrOZWw47FNKzRysvsbCAugqTqTPC4iIw4W0SWp+wgMD43Hh
 iWS+qRh8e/uzQ9f1NaCfOybPGevE5WOKk0SSwabO9EkRumGjU/xWX+IOWmqKQLTYRSJlKwuv1GO
 l6szMY7OgCF00Ati4zxwpm4+Ou6BTHlzk1Si/HiMyA7nDvydJBZnOatpRQFC98L+VtMPZx4AO2M
 AU2bLSmooN1Kw4y9qncvNl
X-Received: by 2002:a05:690e:191a:b0:67d:b7ed:2703 with SMTP id
 956f58d0204a3-67db7ed318dmr1363163d50.94.1794826074743; Mon, 16 Nov 2026
 02:47:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116083613.2032377-1-maobibo@loongson.cn>
 <20261116083613.2032377-2-maobibo@loongson.cn>
In-Reply-To: <20261116083613.2032377-2-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 10:47:42 +0000
X-Gm-Features: AclHuK87lNU2CVh9skagvREe_N3bVgFVwoAuXCkUYloYdM7yG45JIawJ8WjULMM
Message-ID: <CAFEAcA8EEt4VP_vcp43H_FOF__pCnpe4YNqgTe-UgTNbpzwx=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "target/loongarch: Remove TLB entry in vmstate"
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 08:34, Bibo Mao <maobibo@loongson.cn> wrote:
>
> This reverts commit 9e771d547b72d1eecd962725fad7508af3b97183.
> This change breaks migration of a loongarch "virt-11.1" machine from
> QEMU 11.1 to current head-of-git.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4879

-- PMM

