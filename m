Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA33C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEi-0008IP-DY; Thu, 28 Aug 2025 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdfi-0005uj-Vt
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:15 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdfb-0007vx-Ab
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:14 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e96df7ff20eso803831276.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391524; x=1756996324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hIe1mJc91astKDHfoo5Y8ygmXD2VsuojH3Ae6aO5EWE=;
 b=jtnCcUSrAN22RV0ddxld3F49pb7BIMkCXlbVS3x6f+TtoZqBF+wn8iMl9fUKxSqHbf
 7Ujx3+6ip5VaXXGN6CXOWp0ZYQOx1Yk+fJIFs3AAGgXs8X6PUkNQWS6bbR7pCCd1FAeW
 k4NeCpdj8Ov4FGLpR+h1+sxbxJv6S/9VE9jbkhtrRVLJgiBBY6ppuqfnWH+jhj69Qf9N
 /IwecJu5llK7o157K/7gaHL8Au/JCybE5CdjEAmunpnY5ydxnd7OIlN4n92lkwF95Oph
 X891pQ25ZRsCishd8GzhQllDqsiz8odl9yrzEIok4LVlvVVfx1BCcpkQ2JrWCBsH/5oH
 mCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391524; x=1756996324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hIe1mJc91astKDHfoo5Y8ygmXD2VsuojH3Ae6aO5EWE=;
 b=gOsucgjLEvog/4uzs8naFc5TusqMSJW7p1z99Nl1Po2hyJnIgdh4dt4u8V65LPs4un
 tCcm9ul7Cj7dO2RgovEfeFeApgVVb7fZQPYLhpFYKDgtH8sHEmFaL4j0QIuKLcRzF9ez
 YAKLvErLPtlGO92ss7PIGFZXi8jfAFt4jcMbYkeblvGxTBvs0a6fdDuXbO+FdEzH7K0F
 t38FoqTsLs8XdfIRK2CESc0C1B7AO6lHx5PHp9zZNKtzZ21jtu1trVi19B7ur9GL7XH/
 5IZ9EFfna1WfLV2z7CxOQ1UfKozg/VwQo5bGQ3oRT1mMWshEAY9coft/drmwOTusXzek
 nl0w==
X-Gm-Message-State: AOJu0Yw7liCJTLjH6hgrPEeZyT9Ki7zvEo0ro3M/KhfiHLmGv24131f0
 KQ5VPkjHOXDVXvKTRfg61HDtNKrYFoIFtw8PUhsd+7gnKvc/20dTDfMwrRAQhCpRzbpo1VW8ZSg
 AV5wfGyaCMFrrQveoFiexeqkk3jFWx+k/7biNYsTfxQYmAkkO9c3W
X-Gm-Gg: ASbGncsVLSfR3zn0WxnykO/6RrvJ0iXCdVowk5D5QTzEJ1ldlwR98d5z/TNFYCXIBao
 y+f6md4ZXk1YduAgf4JLLqVZ+xDi9pqtoU0a3k6piWtDN6BjZ/hDGWIzdYkUXZcl5hvp7EbkqMD
 KU5uOZMoZNRYlaFh+jcEvKBEqUIlrKTXC8Nh55+H37deKWsqBOU0+LMzKPsChir6H+WxRykwGdZ
 Qo9iQJV2GSZasvK04o=
X-Google-Smtp-Source: AGHT+IEN4aZXYo+Rv0xXkeet83qTplNQLNmMf2MAj9qRxrrvlJxo36EELo6BG0yJSuOElpX3VSYA+EUVvQRQzprhQCE=
X-Received: by 2002:a05:690c:6d07:b0:71e:84d6:afc4 with SMTP id
 00721157ae682-71fdc2e296emr273181097b3.14.1756391524266; Thu, 28 Aug 2025
 07:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-24-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:31:52 +0100
X-Gm-Features: Ac12FXzCs3lg4xnr8E3JFXLylhHKudUAK_KL_piSN8hu5_pP5salVvr635EkunA
Message-ID: <CAFEAcA_JtGjJnMzzw+pjB5Ohy-ABt-avk20YViJiXLp7MtYScA@mail.gmail.com>
Subject: Re: [PATCH v3 23/87] linux-user: Move elf_core_copy_regs to
 microblaze/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/microblaze/target_elf.h |  9 +++++++++
>  linux-user/elfload.c               | 21 ---------------------
>  linux-user/microblaze/elfload.c    | 17 +++++++++++++++++
>  3 files changed, 26 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

