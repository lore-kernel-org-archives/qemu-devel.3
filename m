Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D870C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzY7C-0003rU-So; Thu, 27 Aug 2026 07:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzY7A-0003qh-Vm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:17:49 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzY77-0006x8-Nw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:17:48 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836c91bd782so35781167b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787829464; cv=none;
 d=google.com; s=arc-20260327;
 b=AMPXxb75j7H9T/lX+8qJI2NOnMMdA3AUbWELh+OzMyV2+yVXnRfs5saXtW8JgVhvtP
 8ase/sTEbDFOOJZ+ejQVq/rij7pePcBOLsoiqPR8p1s7x36CYkkTphNeCaKsMeYHYOor
 pYU/DSpcz/mh9Iru6sV6Ado9dImUDexWUrr2i9Rl5BKUgDz5GJRAgTuorLnulHYjwDUi
 3+WJbEaVNcbkimOJCvalBWIxwtuwDJWYCPqCDOpx7ALfvkkXzmEl/jK/5u3wveyMKJSp
 6Et4yowDYdgZSVEOqRI3UB3RRrPQPQHvIQ/kpyjZuwQzwGVhl5M6jz8l5Wb4My3ISKAU
 uBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IAupx9RnMDjq1cK/7Ka5dp50NQm4KtdcDaWyz2bg2Ko=;
 fh=6wG6+FzAH68gLJ7VB0gsIQvvPwKrTrabqbEqOfqD7Jk=;
 b=BfTnKTBJB5trkpUECuoQVZS6AkVnSlzFDPInLrmSeR/erUeSgA8zEcP12gtiBg2w4a
 JxK/VB4NdIJLOGJAPcFmwYNmyVIWSuPzsRhwKNPQM0x/vWhjD9RxhtJSt8yTEFxtL9Pd
 PgBMydQ6kr1dW44z6PhiC7KIOP2kx56ROX4LuplkRpg6FbT7Px+lMvoirqnQRwmBN5Po
 cF2MhluULaDEIU0zlv6/YbQUM/N/ZdM5+Pojil6FTLIZkffxZx9+TZkfb+r/n8SDvmxR
 cdr1cnz0ohye+khaBb8Z5SQkOeSKAxyw6IxiBG5mowuooVoCRjBEDVAYs+/6mCKkJBI8
 4QwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787829464; x=1788434264; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IAupx9RnMDjq1cK/7Ka5dp50NQm4KtdcDaWyz2bg2Ko=;
 b=NTXkFgx3ZCNpcV9z4ZOTvlgirvJPsptVGhNauNzF4uv9Wv0tuVUTaKRBuZPcCKPdH7
 H4U03WBsbQLPa2vupa3weFANMpqpHmdbYuXP1znFFKaunKOWeA552dhIbXwr+zTz8Wh4
 022Z9zlKciV0u6WxnzCGjXwvn5ZZPUpmONSV/lywIE+HncGk+9AWNJND/qhuom2Inqx6
 IXR1r4GOAdZk57ztxsmLeZfci5H7jcCy5HPSr0+Rddvrgtl0MGrWmz2ORl4LWloc6fXF
 B5b0m4Zda3RvNPIkvV2LffyOowmAqlgpvPTHVc2Z2ft2YiwQquUx2t1N5IHWvpEEFQJw
 E8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787829464; x=1788434264;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IAupx9RnMDjq1cK/7Ka5dp50NQm4KtdcDaWyz2bg2Ko=;
 b=YksJ0Wg4apNb/+sCVw9+QBDwYryUF38ISZUWoPVUzAt0rgkd9eLt3t5yJ7+dhz87pn
 0LHNjfd8xI2s/t430n8pfA4/LUTr93/OrEbjF92BIlB6TYDnnnQhm40KkKtaYHiCIh0e
 Q5rdDB5CcFN+eCVetA2kRWKB9HGvRUKMGDB6kFHKx1bE4BHQAPDnXzeFB06qDW7ZHssD
 jhcwhuzQ22czcQ2yKl/ImNy40kuqMrxaJ9YAo0q6ZzzxcISlDl3aet/zIFDJUMbegX/+
 +31LEfhv6f8t9q4iV7JznbMOwyL3XbJdmWSymfhTO3MViTokcEvDfenvy7XO2o++EX9Y
 gQKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6LrYG8k+XKR/zPNNNLzBqd9OaURyHYYST6mHS3LeKuDq2pcgh1l/UHlwKL4Gq1eQkfgDYzEXsrqn5@nongnu.org
X-Gm-Message-State: AFuF++mVCP4bn04cHOoyijAtGP4WHlOBs9l/caQ3OGlpxWwHXevuUnBo
 48O+4C/Tgox7KGt95SBt9qP0m2iQERZzm1IXdwgKXXMx9xRRWH6RW+Xte8eJNFbHrWDjbaAXggM
 QF8Jlds5KndROxMI4o/I6QclRz6ADXz7WEPnQDmUAkg==
X-Gm-Gg: AR+sD11UflzewbRRsmz0sOCvpFroXZ7JyaSGkL/MIoKBpAVqAoZ6X4t6XzrKers/8YS
 owldNcL6U1ER1qJFiG3YLWgj5QIZeSOTt1/+PCwTmXDHa526r7dUtfkyQHWTS4QuhAluhBKM964
 dJVwl1k03qMjJPX6+3HvqNob6ZDKroOLvYku9zOMBBJWsXs+e6zEG5+qn7D2w+HgxdAHaqip/4X
 9PRvmdfOJU3M/zOdQV8Pu6rRaSlWCXrq1CMp63alW/w/R0CvO9K3JnQ2cAXPIYYDgAF2j8wHUo7
 c9PVr13fUYFovRsfvWNcDInoueoPocGvITennLzHQuNSSuzGQ1dWIiqy5h1ybrQIuDQ+l8MO6B+
 X1/gP4hgisEQzp5LZPDNhbH9F4UKH
X-Received: by 2002:a05:690c:c3a5:b0:845:69ad:b9b1 with SMTP id
 00721157ae682-8573be1b343mr53332187b3.3.1787829464363; Thu, 27 Aug 2026
 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
 <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
In-Reply-To: <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 12:17:33 +0100
X-Gm-Features: AcwNN1VUVmzqWF2W5hkS0W2o-_zqfDDH0ebmLyctS6dkcWYA5KVyPN2vudg4X80
Message-ID: <CAFEAcA9zz60hTDMEMePnc1osis7dPjn5KmSksrWKATpSMc8SHw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: Alistair <alistair@alistair23.me>
Cc: Portia Stephens <stephensportia@gmail.com>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Aug 2026 at 12:03, Alistair <alistair@alistair23.me> wrote:
>
> On Thu, 2026-08-27 at 11:53 +0100, Peter Maydell wrote:
> > But isn't this just the way the SSI specification is? If we're
> > modelling a "you just have to get this right in software" bit
> > of hardware then we don't need to somehow try to add extra
> > checks in QEMU for whether the software hasn't actually done
> > things right.
>
> From my reading of things this is a bug in QEMU, not a guest issue.
>
> The fact that aspeed_smc_flash_setup() for example iterates over a
> larger value to send a single byte at a time shows that currently
> everyone *thinks* think function should send a single byte.

Doesn't that just show that the aspeed flash controller knows
it is always talking to an 8-bit SSI device ? It wouldn't
surprise me if the SPI-NOR standard in particular insisted on
8-bit transfers, though I can't find anything claiming to be
that standard.

> So it does seem broken today. Making the current function clear seems
> like a good step. Supporting different or larger transfers in the
> future is then possible.

I think the current interface already supports different or
larger transfers. We just happen to not be using that.

-- PMM

