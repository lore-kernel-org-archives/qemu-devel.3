Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD8D3C935
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3DTS-0000Ab-R1; Tue, 22 Oct 2024 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3DTP-0000AF-1N
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:54:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3DTE-0003CW-KI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:54:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so512946866b.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1729598079; x=1730202879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O2axmDtZTaEE5CDh36x0Rh8mcoGAeF10A4q/Fe88qCk=;
 b=RYUzwlbPiASoZXT273VPxT1hsOUYJ+jY+nbnqo59EW8TU5BR/DmFBgKlgReHBC4ty8
 5kO2n8NQfUj2Mb2nrY1kxryeeavj1IBhNGa9zCy9ZCVVvQzWlL7MmqY0dvUNyN1w7AGR
 8JOGa1BmGNa+oiBs1SildWOdcMGhHx6MpSD/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598079; x=1730202879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2axmDtZTaEE5CDh36x0Rh8mcoGAeF10A4q/Fe88qCk=;
 b=wIEyLuBugoyZoqQG/IHLWlrWFsLRwtC6fb2csEdZvvsgRUjWCpP3L+E8kcqIEhnNpt
 rKapDH4GCH9DWY9U6cFrDXipXg8q/pD41MkufIm/J9z9fUH328OQ2Hoph+sMcwZGSQxj
 hODdaIhwlIEh/wd/gEDvWhbx4sNUqJ4x7B8mjm1qiC6d3ZZ2P7hX+fYsUiz33gbgw0SW
 g2vfcYkV9pOMaJMRFS/eRd+kUeFXvjGlyGsfqivhrDToY3IsfHkWYNl8N1vC/12apnan
 V7HO0AwPMNkEk4xobnKoO8QiyEhpWHjLlg5WP3UtvYXWRE9qgfFC/bILxlq4JwvFVqGR
 x2Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3siwlLNDmtBmZ4qDr8fXn5k8vpLlqgQ8xZKFo/RW9s08OCV90P7mhH7bglTeOkWMM/nACuW0y33qJ@nongnu.org
X-Gm-Message-State: AOJu0Yzx1QdCfhiFMaD/AlbUwqg3L5AsXIUrgwcoazT0eMNCWtsO8P2K
 KmwdebW0asxuJVxZ7Rbd8+LNeCf6IP2xOJdpzdNaBPar1leXwk3qHG7jOKypVE022T4Cn7UyUSS
 3SH4VW6aDwSj0hTim1t2JVdhWL+s=
X-Google-Smtp-Source: AGHT+IH8x5y0KRNMGddsIDlya/exEKpLCppLCkEQDXyIfo+wfZQ/0qlAVXvjOATb9LtcmRsweC+2O6EgKlh/IwPuNpA=
X-Received: by 2002:a17:907:3f1a:b0:a99:4ebc:82d4 with SMTP id
 a640c23a62f3a-a9a69de4cccmr1215643666b.55.1729598078317; Tue, 22 Oct 2024
 04:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
 <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Oct 2024 22:24:25 +1030
Message-ID: <CACPK8XfB=tfSBnPVUjJgAR23W3GXS_hxMiamPJT=7qL5Pgw8zQ@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "kris.conklin@seagate.com" <kris.conklin@seagate.com>, 
 "jonathan.henze@seagate.com" <jonathan.henze@seagate.com>, 
 "evan.burgess@seagate.com" <evan.burgess@seagate.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alejandro Zeise <alejandro.zeise@seagate.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.169,
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

On Wed, 16 Oct 2024 at 01:23, Jamin Lin <jamin_lin@aspeedtech.com> wrote:

> 3. Test HACE model with u-boot hash command
> a. load test file to address 83000000 via tftp
> ast# tftp 83000000 jamin_lin/32MB
> b. get sha256
> ast# hash sha256 83000000 2000000
> sha256 for 83000000 ... 84ffffff ==> 1ddcccdba742d762e2b8da0bceaf4778727c5eba54a24d7ae0c573c65414f736
> c. get sha384
> ast# hash sha384 83000000 2000000
> sha384 for 83000000 ... 84ffffff ==> 825d9b24bb797695545b3cbd2f373b9738627c7a1878e620415570a57c7faed77916d47084c954254f101fc0f10c0591
> d. get sha512
> ast# hash sha512 83000000 2000000
> sha512 for 83000000 ... 84ffffff ==> b5ae725b2dc1e521f48eae37dd82c3d5fc94f7acb5fff3dabf1caa4bb4b5bcfb498e7cc1fbaa97dda2664bff99f9f8e778f823e95afaf76fbf0985181522e478

I attempted this same test and noticed that the 'hash' command was not
using the hardware. You can see this by putting some printf or
breakpoint in eg hw/misc/aspeed_hace.c do_hash_operation. There's some
missing work on the u-boot side to move the "hash" command over to the
hash uclass, so it can be used to test this code path (or add support
for the old API to the hace driver).

Separately, I attempted to test with u-boot by enabling hash
verification of the FIT image, and it fails to calculate the correct
SHA.

I think to have any confidence that this model works, we need to add
some testing to qemu. I did this for the initial version of the model
in tests/qtest/aspeed_hace-test.c.

The upstream u-boot situation is a mess, and cannot be used to
exercise the qemu model at this stage.

Cheers,

Joel

