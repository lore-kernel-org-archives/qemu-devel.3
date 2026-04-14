Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F7DF9D0DA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgIw-0003wV-OF; Tue, 14 Apr 2026 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCgIs-0003wG-2X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:07:54 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCgIq-0003dG-Jv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:07:53 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so2181437d50.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 09:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776182870; cv=none;
 d=google.com; s=arc-20240605;
 b=E/Hxk3A0v9r7XYAgtnyKCW35YpX6FE+MhI3MVPzMRkS4eBG1zVxC9VLG2FylVs1DLq
 5WM7sRmg9cyT+OBgn/qvq5aaTP+1VPrwUIlMixlD2t+yuTs+LVYgqGAfQEFCjgSTeG9H
 MMZNeUNRdaIpSc1Uvh8vZXutlA/bIdIXy5Q3yvCBRl/yj/URRC+hv667l2qjVXT3b/+m
 X5aRJbBr+ZzXn1GxqnyKWHu4sn7QvUNV1EfOSCVwaLJ6YPzIQgkQ4HQabALfB84rh8Ew
 a/nPAE/a/frG3E7N9u3EuDi8olHWojHtnaTIDlE5hAj6xpvLxMuW0DAKH22pMyH5AASn
 QMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h1Gz+UDapnPG9yRjjyw4+Dk+QgOPJvqVPusAuaEqC3g=;
 fh=MFiJx8Ql5Uc0dXwP0Ww6JZ7Gtxy4tq4TxFQizRRbUEw=;
 b=fFLpuUTeMIN1cXoblD6YnrhZBso+HVL1Ly+wyhsho7CFqJjN+X4NRdJj/4kdRYjexa
 EcJjSfQQvVc8qX+Bkgub+dBfL0IRjeiFCChrGLRTxmhWCT4f9kNZlJi5xYazIdpu5Zhj
 OpVWGuuPnIvHN2J7zsQZEa52u94ArDO6Ph2SCDilh3jpr1XDhDDIvFRjUMgZ3rMwJ3X0
 jdoUlAm8OGzdLyUZAU+xWp7t/qQ29tXG+NzeWv0cGTnA3uKBwDi/T/Tk0t2cX+MpZB1R
 WFj7Qi9Ic8i5/3hmibah0Ea4X6FuYSfQIOFoWqRu4XBP4pWPJZ7wfZs4JX+BhgHQx+vn
 n1Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776182870; x=1776787670; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1Gz+UDapnPG9yRjjyw4+Dk+QgOPJvqVPusAuaEqC3g=;
 b=DWWQtS3Eh8NiNOx5vFD5T3lJ7vRRPWcTZjkE0C7b2BiUY9s7BiYVvFgF3eBxmp+r8L
 hiWndAQjyd+IdM84cufw6Y3g1NLVeJ529u2oUrQwggRhgzIPAaIaiHfxRxVC1GOINMH9
 GovA8vrG7lpNJbD85ylgfq+mMQTiRy4h+JTPzaETmwi6iNxxHcij6fqUR3QEgHi1dPQ3
 A+FqVCI8RNsQIiZkoe1JW8EqRkN+41mTWr1sAyCo3WAwT2B6rSpPgyURM8rRTy19XXDa
 Mp+6MpX6RX3HbgSjMFLwbbkpuQIN+OhFyxRddzhHrdgHFCWfdUv6SK/vonjm4/jHlVsu
 qYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776182870; x=1776787670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1Gz+UDapnPG9yRjjyw4+Dk+QgOPJvqVPusAuaEqC3g=;
 b=qGNq5i8By8uPsdSPC7QlTzkthRxXfcSzVjqIF6JxqF8rluYmX/78mRvS/hgWMSUVj/
 LuS6g2Aip0XmkwANQpPLYpDrJxW2p87uljhBSGEGWvyHJ45vIMnHAvGK35bt/n/Av+Fv
 FLBkdp340R5xggVaqlaeJcsbFbtArAhGxWimyQriW9HeAm/KgQEIAgbpUlLddhKC8slt
 LIJkCqvBfOBB/BxRNQVl4QOn3vpDef9CCtKmW/lhXT8uanQH0euvhAAME79MmXWsUPxQ
 +fKKaMFoOErhKRr2BMb7D1fCpqR5fOsF60XeJxw6YyJWluoJhdGuL1XQHT4vlYstmx1d
 wzIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ssYR5cJtjCRcfQHWTXnnNtEawN3z30CUy9DEnF52/bC0ET98g7qSCgXoumUBsN73XyEedaqBttI47@nongnu.org
X-Gm-Message-State: AOJu0Yx/cfhyfCN765u0rEW8ZTPo7XcHW5Y5GPyv6A7cuikTOlgdyiEM
 XNyySepqMYONvZKjMAHmbjvI024CF58vTbORSrE/nq7WNfren4bq7sWc1WBmZykbesVkiNlROV9
 jNGlDyPw/ic+c7j/2bIC1SugSYtcSGk/MpdOv3oi0Cw==
X-Gm-Gg: AeBDiesZ34gkIjTcc3KmqvoC+vh53gNOwcKg4pCDZQT0JeWOJshtyS6eQT/jFlXo9oc
 rjz0uRGrSeZHmb8b2psdlrNH4HF33ExI1xQORJ1vue9GzAOU3doM2VXoSkXgSWn95PesMMd7ULK
 MT02fg7vC8IA0wq6Pg1MkK4gKjPa7gZqrfAV5s+pDqP9A5T++MMQ/6Lk67s84scMCtiNtXQasUh
 m/fscpOnZq96JpNM3iDc4u1EGH4V+39N6ufQzGawgnh6QbGuH6DIfP4qHELjD8YD5w6Dg4yIOTx
 Quh457M7K0lr8R4tppDN1JU8P+D4/JsXMY75SRKWGVCVDfRT9care0T6J1naZYkzQTL132DGbhZ
 wdg==
X-Received: by 2002:a05:690e:43c1:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-6518724a43bmr11503053d50.33.1776182870023; Tue, 14 Apr 2026
 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
 <20260414053715.1378021-2-gaurav.sharma_7@nxp.com>
 <D981B877-F5F8-4873-B241-AE20CA354410@gmail.com>
 <AM0PR04MB4370D4D69523579FA7971C8A87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4370D4D69523579FA7971C8A87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 17:07:38 +0100
X-Gm-Features: AQROBzBgVyFAoUsfH2EmYPUvwYZd0pvl93NTTBIYbvJrTu-COkLWb4N5lOnPONY
Message-ID: <CAFEAcA9sgRbWtPeJ=B58nMBKNn4wciyXOgc0cX6xmPByAimuXQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCHv5 01/15] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: Bernhard Beschow <shentey@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Apr 2026 at 16:57, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
> > -----Original Message-----
> > From: Bernhard Beschow <shentey@gmail.com>
> > I get two warnings during compilation:
> >
> > 1)
> > ./src/docs/system/arm/imx8mp-evk.rst:2: WARNING: Title underline too
> > short.
> >
> > NXP i.MX 8M Plus and i.MX 8M Mini Evaluation Kits (``imx8mp-evk``,
> > ``imx8mm-evk``) ================================================
> > [docutils]
> >
> >
> > 2)
> > ./src/docs/system/target-arm.rst:71: WARNING: toctree contains reference to
> > nonexisting document 'system/arm/imx8mm-evk' [toc.not_readable]
> >
>
> I have been configuring and compiling like this:-
>
> ../configure --target-list="aarch64-softmmu" --enable-werror
> make -j32
>
> The build turns out to be fine. Not sure why it doesn't show these warnings in my build.

Your system is probably missing the necessary dependencies to
build the documentation, and so configure disables it.
If you pass configure '--enable-docs' it will insist that
it builds the docs and configure will fail, telling you
what you need to install, if it's missing something.

If you're adding something to the docs it's a good idea to also
check the built HTML (it appears in the docs/manual subdir of
your build tree) in a web browser to make sure it looks the
way you expect it to.

-- PMM

