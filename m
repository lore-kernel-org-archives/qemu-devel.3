Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB4C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVQQ-0005Ez-4j; Mon, 24 Aug 2026 10:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyVQO-0005EG-9e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:13:20 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyVQM-0005ze-Gn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:13:20 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66c82b32121so5144875d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787580797; cv=none;
 d=google.com; s=arc-20260327;
 b=sEMMirZqDjc6c4fG3/7oJ8rVbn75fACEGL0h+gorzBSE8stv7KbxbZhlbpk3ZWolje
 gC9PqoRUWmxnCGKDcHX34oyuYrzLA+MwVlG+KEVRwlpgRHdX8yqF3wFz/B2XfiPikfiW
 5+RbPPG+gvwOaN6PKGvlAbE4mg05q+gvqLP2PJfg8WoP2rTfmKAae7Yj03cglOymXFf0
 7e800uSkqwgZkIUzH2X3RLetevx7+sxLqB0zUzqkXh6dnGZHkNkqHcP6ScimRUFUZCHX
 CoI/skeytryKoDdUA1h/cWxAyV7bcourfwoZEQl8g8YnM9Duie+f5GfXY4qLr5CX9hCN
 15Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i90qMMZqov8wxYQ380J3TeVkiRq0NLJOwuvPuDjyrj0=;
 fh=3rXYw5eioHC98TukW+HyGGPWtUDkJdl48TX1VVqGITM=;
 b=O4Jh6T+ONnvGX+ICkVuotzPyhIqQ8YPA6yLU1aNCpCj8ZloXT3dnU6c5Rz1Kh3C634
 838TT+jk2NP49HBiP1E31gg5rAy1P5ykWCit7al133DHWmDzEwICPrUkXboMZOLNFJl9
 TPHDNwPwDwLYeMQH6z2Y/W4skMvnSFBq4SLJitAYPFlqymEdcx8klXuhhSDvG0NLP1JE
 vPVj/s026F4KjD/h1CvLLRBNWH2ghRZuUZtjXNzEG5KwDfoZXVsScsu/kKeDtJBIN1JN
 bXU5iFa38d2RY+pxmnys1OLb+eYBcEn9hwJjscnbA7FXHKT1ohPesET5AEF+tzWvd3/e
 Xffw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787580797; x=1788185597; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i90qMMZqov8wxYQ380J3TeVkiRq0NLJOwuvPuDjyrj0=;
 b=MYSej5dM+4rXFsM3SccwTSQNXP/WH8xcymqJBUC/Nqiletom3Vi6/277P2cw5aD6Ei
 h640YfoMBVcb3jvUdEvr1FWOInYtsEE4bqIy4XTOneHzQqyu7/ZYSAq/iI//Q6onbZ3n
 4v6fEN4iDv3qbF4HT+GiifaMf25ctLlaI2LEgd+pg/uKExhxxOr9XaypChgzayoJtPJm
 XR1m832vo9huwGGNJ3T3+m4+ftkDU1aiFfhN7X91kETn4YZFjAoWq3G5lZPyABybJAAY
 Cx0b9MZBQhR6es1dLPotRwWvTPpc3/De9WJRqgk/b0WmJKWt7q1mzgAMjVitolvkRo7d
 Ef/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580797; x=1788185597;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i90qMMZqov8wxYQ380J3TeVkiRq0NLJOwuvPuDjyrj0=;
 b=CLvNcshNv30zpvruLKfc2sqa3uQK4tbCouMKK96yX3O5kEz4exA7En7yRzKb7xnGZl
 KUC/kt5mVlfipNLXZQPSb1JLuxrYvfwdQcu46k9gUhhFdrDkxdcSnYrBdCl6Kdakn+nf
 rm7gsRUDXczpUTDtp/oN92QHwx6/5kwO4cTuWIWLNL2gXsTzr+WMeFs0aYpJeOVKR4M5
 f/YHN3Rs8AyCQPJD/CMQIRwH1A5Jes89D2Hi55jmhVG/t0anduhqOrrRWG11TQ39Ip5k
 jZjV/pr29Xcqd0Pk/JX70H0n7eKz/vtlJ3YrcYgkVDuSu6r5p6gw201llAoqaIo1Q5M/
 KXRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH3DBXA+eDFKwxARBuQHr4BBaU9TaGpdLrN/ruFFsYuQmIq86tJ+I43mb0gCNvxk8BCUE+NijctlQB@nongnu.org
X-Gm-Message-State: AFuF++kQZQ91HrOYUK3GrQX20RMNoe0N/b5fMC24slu6JH4WaTYI6AVU
 HhXvpFGY9UAL0UyRUp/ifMaU4i8dveO5uM+O/YXNsUlS1MIW54AM8u5uBEkEV8/WQP0sFu5RbTy
 4/mI4ckpH4zqgueHazRlP4PKM6aaboN2OLFE4XWMrwQ==
X-Gm-Gg: AR+sD11pEsOsauZYvqQ6Kozxuay8oH6A4MmCZsuPAhoWOobZKQmSNpITQpHyqUx6Rmt
 jzCclRoHKL5eXQTtLMKkAOS6zkuTodYDa+hKBy0ahglMCe/t0+LXueQPfkcU7m3AEd/jQ3soCgR
 xFRyRsruv6+wGGWbmbMB0h+6te+8bFfyQHH7L/qvbk7sAYTJcGXKY0/5AanOCNK+VyCjyZ4Uf0o
 wMpfnPIKjNzYkjLqDB+oYlUdPudC9kWcndXYEt/VD0a0z5xx9nB2XzJmQi8xjt4KGljOlCPv9Ub
 5gO/r7615kh+aU9x4OyGjrkZMHDICyf7LepXNEsiWKphgebLqs/4aFIB06vZlMjosmD0aKVLsWv
 7X8d2EvEl5/WGR9T6tzUXMwrOjIrl
X-Received: by 2002:a53:ac9d:0:b0:66c:9f99:9133 with SMTP id
 956f58d0204a3-66cf21bc69cmr6817963d50.29.1787580796530; Mon, 24 Aug 2026
 07:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
 <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
 <BL1PR12MB50322B1D97569B5CADEC8E55F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB50322B1D97569B5CADEC8E55F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 15:13:04 +0100
X-Gm-Features: AcwNN1VxiYK2jXYCrQnBcioJAtVp2kRV-_L71rBTzoEWsRsEjGV3LGfW0swuAp0
Message-ID: <CAFEAcA9rWqo92nt1StDuBwUjbV0eqdAA921nozpjQHDF_ARJyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
To: "Frager, Neal" <neal.frager@amd.com>
Cc: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, 
 "anthony@xenproject.org" <anthony@xenproject.org>, 
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Saleab,
 Micheal" <Micheal.Saleab@amd.com>, 
 "john.ernberg@actia.se" <john.ernberg@actia.se>, 
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>, 
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 24 Aug 2026 at 14:31, Frager, Neal <neal.frager@amd.com> wrote:
>
> AMD General
>
> Hi Peter,
>
> >
> > Hi Stewart,
> >
> > > The -I$(XEN_ROOT)/tools/include added to QEMU's extra-cflags causes
> > > __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included,
> > > triggering an include-order assertion. Downgrade to a warning since the
> > > version is consistent in cross-compile.
> > > Ref: https://github.com/qemu/qemu/commit/e2abfe5ec6
>
> > > This is a buildroot issue, so I don't believe it's necessary to fix from the
> > > qemu side.
> >
> > I am not sure I fully agree here. While this is a buildroot identified issue,
> > there could be other use cases for __XEN_INTERFACE_VERSION__ to be defined
> > before xen_native.h is included.
>
> > But what, though?
>
> > And what we have found is that if
> > __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included, it
> > is not a hard error.  For buildroot, the qemu works just fine in spite of
> > this.
>
>
> > I think that just means you got lucky. Either there is a hard requirement
> > for one header to be included before the other (in which case it must
> > be a #error, and whatever is causing the mis-ordering to happen must be
> > fixed), or it's fine for the ordering to be either way (in which case it
> > doesn't even need to be a #warning).
>
> From my view, the order the header files are included does not matter, and
> this should not be an error.  I agree with removing the warning as well, if
> that is what we all agree on in the end.

The rationale for the header ordering is in the comment in include/hw/xen/xen.h:

/*
 * C files using Xen toolstack libraries will have included those headers
 * already via xen_native.h, and having __XEM_TOOLS__ defined will have
 * automatically set __XEN_INTERFACE_VERSION__ to the latest supported
 * by the *system* Xen headers which were transitively included.
 *
 * C files which are part of the internal emulation, and which did not
 * include xen_native.h, may need this defined so that the Xen headers
 * imported to include/hw/xen/interface/ will expose the appropriate API
 * version.
 *
 * This is why there's a rule that xen_native.h must be included first.
 */

...basically, if something doesn't include xen_native.h before xen.h
then __XEN_INTERFACE_VERSION__ can end up defined to the wrong thing.
(Disclaimer: I'm not a Xen expert, I'm just applying Chesterton's Fence.)

thanks
-- PMM

