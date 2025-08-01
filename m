Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98797C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrYE-0005ca-Kj; Fri, 01 Aug 2025 11:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrBs-0006Br-IS
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:57:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrBr-00085Y-3b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:57:00 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-718389fb988so22728827b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060218; x=1754665018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=31fz8S601fdvKKGF1YSOGlyinnUzd5Q+Darm9n5JriY=;
 b=H7pvw58zyGF32vX7Yo1imGVNwlVkBz4TM0CN2RTEgZuxzkm23wu8JTFaEJeYCZgEQY
 ZHlS6YWo7FRd5M27caZuIlvXns/SFW5Ks80iHQqBOOi/4mwcokhQD8tWCMdBRv2eyByv
 D0Rf66949RNrmt0T/BdickaCJ4xf+I+/gE7/VdWR+xPWfql2NHYRy5zqf6K22YxowYvH
 XXup3WJqGez8hPaVW63bLSatZhG0prmPwA962BSQdctydG7I1FwIuaN6gMgJSt3tj9u7
 5B4jwpRv1O8EBDmgGRx4Wvhz2h9kkAr/Y6T0IHPLXFb1F2RtKiRamrnFPzfZxD8k1P3o
 9E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060218; x=1754665018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31fz8S601fdvKKGF1YSOGlyinnUzd5Q+Darm9n5JriY=;
 b=TqHOvc73JGwnjpa5rlqzDz7dQfuVj5LYnB2gWQlU30p4GEAwvlhK0byEMYrH8jGFK9
 40n9IyVM1e5LpBQaNpGQ8g0hUKFyWZeYXmIVirO+LgYGhUHmY/TssWzJwDPY+WKpy729
 LawTahqjI/I3WGjTlsZKtR+vkU+nujiD07cUw/qS6CCZtTexXgN16OR4nWnOOswemXY4
 oqKuJ5Un/tya37sCi1T6fNr9XwDvWH0m7O/LnYmUYRimw8LSI64nZIa2VmP/zaRRfCGK
 5IxSGm7cPrYesS4R60eqZVervjqBk7uiv6xOPP26+zoGw7P8zRdHMFOEWtFcFnxKRiKo
 V87A==
X-Gm-Message-State: AOJu0YwGuX3ZbOofGSB2Ukt/+UGi9skcAyGxkem4Qm2Avoo2sjQGBf/j
 yAlNcaizUzltbbQvEiQIH+KEYOCkGDIWjyMN3JqGxW4399RpzHjcjOzt8eEfdf1iSdVyjqGI79i
 NOEC35REwuh14bu4btjRywzhvXKxlTFq/cl9lfViq5c1JUymPU8mf
X-Gm-Gg: ASbGncsLIR3+Ppdpy9iGQqZBVeQ/yWplPd5T1jTZPIscKIvxh5y3USgysfHbl/5VWG3
 E2L4lshYELsnrtZHzhvzgDn5m+56rjzi0PyYNtLRnGlNnYMMlr/pnsC18klKi6i5Jooz22z4ZOj
 /8d149RqHJQ+Vp1Yvc/gnWEYZIpSF2AMARU7BQlNjxjfCsn6TsicLX4EQc9CVcjWrXHun32qB7d
 R33emby
X-Google-Smtp-Source: AGHT+IFjMng1PMpNLFiHWbLk6REawOPkRwtqyzXLFQ1ahhIHP25Hns96l+zuYh3Dii3yudqSTN849786Fgt0h8T4LTA=
X-Received: by 2002:a05:690c:650e:b0:719:edff:659c with SMTP id
 00721157ae682-71a46521a9fmr159946237b3.6.1754060217706; Fri, 01 Aug 2025
 07:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-10-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:56:46 +0100
X-Gm-Features: Ac12FXwXeaYjsxMJ4YucPe94JACI9IjQtF4IaOlwA8WDaDnsKlxglxvkL1BeDuE
Message-ID: <CAFEAcA-W2_oCxwMQi+--YivtAW20fvzAirG-8xAQUc+2e-DSCQ@mail.gmail.com>
Subject: Re: [PATCH 09/89] linux-user: Move hwcap functions to s390x/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For get_elf_hwcap, change the return type to abi_ulong
> and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

