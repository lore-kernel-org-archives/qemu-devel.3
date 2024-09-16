Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DA1C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 07:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq63N-0000lR-DO; Mon, 16 Sep 2024 03:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sq63L-0000kY-MH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 03:21:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1sq63H-0001vk-Cw
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 03:21:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3770320574aso3082966f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726471297; x=1727076097; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MRnlXovOZCNqvQDBjyK4Gbmyl6UIDzJuCAVHdIfni5Y=;
 b=l8JDmr4IqbsiHUlAJjQxENigEmwYSOD2plW+j99mxGIxNnoJerEy7h/qGhgrKcw4bt
 m9P2fLT/cjEeA2HK1Yd9xiplwJU2w19lCT4j4IAN/t7HoMFvQDARHHPvGZ7lz1NaMO6m
 y1/x8r6YV/7uki7OfrXvfja9us34+lnbNzO1KBGHw0nRumxE0I58Vwy1xpU4So5QE40g
 lfv3fLAdwc7r3wdxHpQI0gfi8ETsyHkwsULfnm1NSxtKSWxFDafk1e9xiTanUSEUvsh1
 hU7wqLvw+2mztCBXTcoqVs1Zq1++lN0by1IiLUGY44dWcBPGtZk3/8kf/wc40mbOc2j2
 7Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726471297; x=1727076097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRnlXovOZCNqvQDBjyK4Gbmyl6UIDzJuCAVHdIfni5Y=;
 b=jURpyf8s3u3YbvdL2tRQJQe8p6slGqaOlIJc8viRNIBYlkbSCF8Lv3Q1U2u3JePBMW
 aey+BykrhvXuiRcGWcnIcHq3U4BtQoCZ1XxUX/0Ho4V8ECqAQj5DS3lSckVVGYWFlvsT
 CUR/BIIFoaYzek8lozR/ZJafH5GzLfn8ouoXcxXugqLX8AXFs3ZfOSvg9H4n98U7HX9V
 YNaW6MzBnbvbOtfA82tYodS9Gxcb2hU+HtomCb0OBtxOY3IXQvq6903Z9NAKwTfBQxjW
 3CB1w9raljc33UNyXlK3Ry8qxzyKZ4BciXQp8zXx0XIVhIiyv7R+iJ6DMXtI5b/iOjw/
 v0Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpnNbYoietO6j14sZODKt8pCt4kpqUDVhvKufZHhVpatG0KWZvLzYRT2TFKI/dojMkg8n7SjhPIJNQ@nongnu.org
X-Gm-Message-State: AOJu0Yxdx51BxMnTDHbF5kUa/SGLNh2VnUFlLGPBk0ZHsXMh1BXM/HiH
 lHVAFN8Pef8wZwRIT56NtaL8IhaH6fSFYACBb/yeNOx5HeNiSAXI
X-Google-Smtp-Source: AGHT+IEjU7goRqCqmFNDNkmwnfNDlHDV0r4BoVc33rbPZ42f/t67QeYJq0HWppwxmSpRPnmvQgtEZQ==
X-Received: by 2002:a05:6000:1448:b0:378:a935:482 with SMTP id
 ffacd0b85a97d-378c2d621c1mr10371580f8f.58.1726471296736; 
 Mon, 16 Sep 2024 00:21:36 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7805185sm6299712f8f.96.2024.09.16.00.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 00:21:35 -0700 (PDT)
Date: Mon, 16 Sep 2024 08:21:35 +0100
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
Message-ID: <Zufcf4iAqosZ7VBf@antec>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Rob,

Sorry, I haven't had much time to sit down and work on this mail in the last two
weeks but wanted to get somethign back to you.  Here it goes.

On Wed, Sep 11, 2024 at 12:42:58AM -0500, Rob Landley wrote:
> Grab this tarball, extract it, and ./run-qemu.sh. It's a simple
> linux+initramfs image that boots to a shell prompt.
> 
>   https://landley.net/bin/mkroot/latest/or1k.tgz
> 
> QEMU 7.0.0 ran that linux-or1k image, but newer qemu does not. I besected the
> issue to qemu commit 0a923be2f642, and it's still broken in current tip of tree.

Patch is:

 0a923be2f6 ("hw/openrisc: page-align FDT address")

> Rebuilding the image with current linux-git doesn't seem to make a difference?
> Either way I get serial output with old qemu and don't with current qemu.

The bisect looks strange as it's only moving a page boundary, it could be
correct but it seems harmeless.  There is another commit close by that was
causing issues with serial output for the barebox guys and this is a patch I am
working on to fix it.

https://lore.kernel.org/qemu-devel/20240908062756.70514-1-shorne@gmail.com/

I will try to get time today to look at your tarball and run it, but if not have
a look at this patch.

-Stafford

> Rob
> 
> P.S. Reproduction sequence for the tarball available upon request, kernel config
> is in the docs/ directory, userspace is just a toybox mkroot build but "not
> getting kernel boot messages" happens way before userspace gets a vote.
> 

