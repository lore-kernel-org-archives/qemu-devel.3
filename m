Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C521CD3C523
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TRf-0001P2-Gh; Thu, 17 Oct 2024 12:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TRd-0001N2-Ij
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:33:49 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TRc-0001ty-12
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:33:49 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so1417345a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182826; x=1729787626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NIxNF6zcwUJBfNODab+3warksDD9gq8C5scBjhfrsAg=;
 b=LCuRBtXuAwri2npqqBarHxg8I7Xpnlzk0w6j3jI2ns1n4QrsKl+hzllf0vBAs+xghg
 ZCU+jdBBNkdW39heaASTH5ON4EtivcrUcgwXTiH3KaEGK6ejYi9cbYsNorAcGWQdGbeU
 VC/PTM5FwTbP4fteehcvjERqRQVqtmJMHm30L7hAMCxgQE4SWsi5I7E+CMa1Rh9QupaM
 qvs0Y2H9Eaj3yejigM1xnC/LjqIMsXrwh1+/KgEc1CNWPV2k7JfRXiWf1o2HzwpnI43d
 9q/b0VfiRSPRbmybkqfwSvHLBc3yFINAYhwUINjYYO1ykCZH04HNL6qyFBGmgBAewbX8
 D1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182826; x=1729787626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIxNF6zcwUJBfNODab+3warksDD9gq8C5scBjhfrsAg=;
 b=BP0DHPj2ucQ0d0gG7Gppl7EZyNwo9aUpDVXsYmbUbjCQ72120GUegz7nB03SsyeRhI
 k9kZ8bydNOAbnM6KtlPqllDla8znRrSyXPIv5yQXZ1SiUqoTiHOc5sFUpDyS5Rg8FY9r
 B5LglBA+DNOGA/9ki9U/YB3fnKwO6jrh+GEPLc/AbxoUdyEleAwTHwl1HdqFBkwizY9Q
 dzJp7FIMZ1FzmAlbAZ8VyBAWvi3C4aQPTTFXkp8ZlkNhrQH8xEW7/UTHdh80xXOHnOIH
 YDLEK6KGlNXDvcfwlqawLcT67OXdC4NRSMAHcZMbv9E0JUQymqKRxbDbWu2a8Wj8H2N7
 8P3w==
X-Gm-Message-State: AOJu0Yx5zUt14xBizk8w+lMEGOpXjNP9ZwgpJpfp/ll0hcl6hpwgHPCp
 WL0BZ49gchmEsHixiWFrvJp/kGMzGjTSGbD1eyVnswRe8u0fwV/nlIKCJmFst1LT8XaCkD9F1/Z
 Hrj5qij0u3yXnTthWzBcCGpGj59ssGCEzzd7kxnNeo/7s7+yf
X-Google-Smtp-Source: AGHT+IG64JfgvXFNngWjCJDJbM9oKUmzYmtRienA23i6R/PHJt+k8+sA2vyO+3DkEROrro2xPw5KucIBzrnwDx6NHM0=
X-Received: by 2002:a05:6402:5201:b0:5c8:8416:cda7 with SMTP id
 4fb4d7f45d1cf-5c99510f3a8mr6175957a12.15.1729182826302; Thu, 17 Oct 2024
 09:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241016083103.2541727-1-gaosong@loongson.cn>
In-Reply-To: <20241016083103.2541727-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 17:33:34 +0100
Message-ID: <CAFEAcA8AwaM5nhGmwyOnVXy9dUNQ1xRWba9fmYznR=01oCBh=A@mail.gmail.com>
Subject: Re: [PULL 0/5] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 16 Oct 2024 at 09:49, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit f774a677507966222624a9b2859f06ede7608100:
>
>   Merge tag 'pull-target-arm-20241015-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-10-15 15:18:22 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241016
>
> for you to fetch changes up to e376c2d87cbbad3483adcd5e827bdd144edb7d2c:
>
>   hw/loongarch/fw_cfg: Build in common_ss[] (2024-10-16 16:06:07 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20241016
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

