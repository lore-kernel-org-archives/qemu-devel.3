Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB8EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZwA4-00073m-SG; Tue, 13 Feb 2024 12:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZw9v-00072m-4N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:01:27 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZw9t-0002UT-Fq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:01:26 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-562092d8135so789130a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707843683; x=1708448483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L+aAXYeki9xBd9oatwJmd5E9UpeWCyJZmUJlybO1WlU=;
 b=FzoeZf92VzdXdOOnGtPXXaKKpbV063zZZvCQP8bqAyz9TYmttIXENIYCcV8fVPE+/B
 M1LX3dQgGHhkCJbqVx33R3EiD9NLlPQZymKbGuNrGxOMAtdofCQGxjblhtlIa0ZObq3T
 D7c95od4s2ORLfA80myu98BrcugQLlXleo/E1kcLVuVQwEHADQ0lrOUsgA3uOtkijcLc
 Noatm2JyFQBJfM4orUzl4TDHVh3OFmM1gx4tC3OEPWt6/B//I6FXTlqPQtJMah+rCDyU
 lib+o2I8Omunro7TBdXllZaG3KmmuryjbKUGQ5usClIVx39ehzYmBPLwQTITxglJl11d
 Vq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707843683; x=1708448483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+aAXYeki9xBd9oatwJmd5E9UpeWCyJZmUJlybO1WlU=;
 b=QrG+i8/19tiqbhWf7FArL9jzzkAToM23GTImN4NQY/8rAAOZrO7ijRh2HmySwZnFk7
 X/PDL/ErZmymuXQ6GTWWSyxHmjK7k9jkUSGNwvcM7zujo00/N/iQW/QSU/prj66kTHPl
 y5NtR94ZFgpgtad8jZ1qNlIO1nKvdIVvBPo7tlU7zF+xyiHbvefMZWYqAAO5NV03y1yX
 LY4FUXm8wkIG7k/kXQMxveOosH3vjJ7O3P20B2O54Daija4hrVQAyjGgP910oO4VjfW4
 1F3MMenWNJdm7eVmZN8x5u24pOsGBaJbSyNLJFvRgO3lhyZTYCMDmqKZwqLEsaogQmzn
 Wh9Q==
X-Gm-Message-State: AOJu0YyZ7GXSJCfzrrmJAQ3jMYe65v8lRebg63EGf2tNjtMov5ZcKxre
 GgGmLBhONsq2mn9Ls2R4ZJgVtDu9c2oSPg8DRMTe2jsXd1is8E1kiJJHDEH43fjwjWvdLeTO8K+
 Bi4RXa8XB18CtSZARKFdUGboyqg/hQizH1eudCQ==
X-Google-Smtp-Source: AGHT+IFGzb5RgwAog4RDF9x2MfA2V1xohXdugLSuO4IHVW4Imgxr5R06zrz/5EwDbul6/99LoH1/hbIg/fSuxGoL0m0=
X-Received: by 2002:aa7:d9d8:0:b0:560:c77f:a120 with SMTP id
 v24-20020aa7d9d8000000b00560c77fa120mr182400eds.8.1707843683025; Tue, 13 Feb
 2024 09:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20240213080151.160839-1-mjt@tls.msk.ru>
In-Reply-To: <20240213080151.160839-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 17:01:11 +0000
Message-ID: <CAFEAcA-Cqyz=1Cr1baUFjcSqy-m77ucqELnR72zzt+=nv=KBbw@mail.gmail.com>
Subject: Re: [PULL 00/15] Trivial patches for 2024-02-13
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 13 Feb 2024 at 08:03, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit 5005aed8a7e728d028efb40e243ecfc2b4f3df3a:
>
>   Merge tag 'pull-maintainer-updates-090224-1' of https://gitlab.com/stsquad/qemu into staging (2024-02-12 14:14:10 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to f6e33708bbb824d493863bc936d3c86fc86f2004:
>
>   monitor/target: Include missing 'exec/memory.h' header (2024-02-13 10:59:25 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2024-02-13
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

