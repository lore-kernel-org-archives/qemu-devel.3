Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF0FCC050
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZnv-0001p8-NM; Fri, 06 Mar 2026 13:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZnq-0001nX-GJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:21:34 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZno-0003cU-Ct
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:21:33 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso9336283d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 10:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821289; cv=none;
 d=google.com; s=arc-20240605;
 b=T3Jsv9+5uuj4Aah+NME2oE46aGXdawjvRPhN2QyhUyZ2IWqx0tP3vFrfmQIxOYzUtq
 bKutd1CgahHFQjRiZsihlfPgKDZ5NF8e0p1KRIeQWOUAQXLi2qr/3ucvkWbZLUXxNtBB
 0M3yIa3ZXBCCfYwH2UJVf1tC+QU0sQSmr/IeLIUFPsJ+q5pa89tiQTskOn4zAOevvKJ8
 Pb5JarGSrYKxO2+2sHXatVj6lWHq7fKYwqvQ7koLHQfBMdlBUqyKf5U2Tzh1VsCWFsG/
 Ss64kyfeafJD8aNZPHT2P52zDnojnHVAX+V0kSXAt2E7ZcLiB1weWt3s67xCYlhezjgI
 xrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v/sgonH7NBzkWVYQYkEUKAH5wS1cGADkJj/ukazuJPI=;
 fh=WxvsqxiciAf0NtvTDc2UCw9slqvB1dwD5aM+s6G1YUA=;
 b=kmiEeMJkYCsBA09RAEOdIF1hHS9+AOOYpABaOyOy8KCNmwNjdygboWLFimzaQuKgby
 Dlxo3BTdmCDPvqXyoHW24W6JqRoS+tv8v78/Q9tUMcOwk33VedPiHGGz2xZNU7Mynzfb
 5pwObm3T0z/Zu/WBLTMIBxBVTjk6wSghLEbtEV6Mr4xvkvbmYLpWkcT31K88g/tHoXHx
 xSOC951WMv2kazClNDDF5LlasImKuJJ5Gvy4lfpSRmWET0YCoBc2AjzhPFc2Er6Dsv0z
 sJLgaq6qpWyt+EK077KkBhRmdTZYhJpd93bUbo7LAueV5AgH5jVz0K8v6d0gyiOLNLQf
 RXAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772821289; x=1773426089; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/sgonH7NBzkWVYQYkEUKAH5wS1cGADkJj/ukazuJPI=;
 b=pzpeTorVzULmZ3/yQ6MJCqSe8s9bmCMZfHYBgmlRC59c7yfDjQ1fNsPFA3Ye2XpC2q
 VoQeb10RVUvKolc1+GPpfsVQ7/mFTkZKPvMQj/eMkrhrg92uAlal6WxJ9Ra49WTF0vre
 2J9m797JdTnn3bQvAf3oQcyQ7E3UbMBpAi2L5VBM0zaq5B9AJ8nJikij2uFxXNbzIXTC
 E8gzFvGv7aeKJ3UoK4Mb3XLcMFvpg8hItCu8SNzQ5rf8oLzVJ/G03HjP4yKF+NC8ToIR
 rZ7YyTVIrqSkxgLeKNHH2qiNCK+e0ol3iioVe7KFSlRMrbfik/FOdBuwA0L+dPhJilCI
 aiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772821289; x=1773426089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/sgonH7NBzkWVYQYkEUKAH5wS1cGADkJj/ukazuJPI=;
 b=a9vX5EBJ7DDU8Yoju+1Enlv4FS3pqxfTeVTJ1ZVUXrk3iOw6kp87xBxkDlIj6GhFoy
 QOywYJmt6yYVemj3oEFC2RFYQgr22/zqP6LKi1BRE88D8TfRdKxy+yS1lFDtrNovJX2l
 vpfivOqJ9x2T8NkxyVb1fkZEk1eMSUSRZXKfG4mlaE839K72kFgDNJ9nnqQfDqZTM0Sc
 fjUWuL/0LCkda+jd9LlTAEqpBJr/+pEM8uvAUKNWCSpoMFKY8gDekXfMKbsHRP2hrPOQ
 B6T+wtTVSnEjU3qAZWDnow/plyw00Pg+FVOQ1k6RcepQUISZZz9xIyNEPWWVULlsXplj
 vaDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq69BtGr46ioIbl/jPrOiViVdem+heYcvzZlSXb2wDs+bWkKGbAWMGt+s2owP9XYOl+SBkLTz7QipU@nongnu.org
X-Gm-Message-State: AOJu0YxJ5ThEkkBWc1JEMynTTdSzGlZg9bDlF4j1xKwk4mz+r87u2uRi
 ITPA7OWL4HAuT3iL+FDkZTLCVkSWCRPQduOGphIDei/Koz4eSYN/cKkPB8KOLN0CiiLIOoe9SAa
 msSZEaNieQnrIwCMKSsTsPLz7EJJiF2ucM4JcA8qKtyYOnEWBEpwQ
X-Gm-Gg: ATEYQzx+UpJYXoIUd5eXsQXf6Zq3PWWHphHFtZGpzlwrxU7MB0K55VHUcGH5B6zpXbG
 ZB1aC5f+bikl/BQGlxRvMOlkUSqSw4lvDuyp7SLYMS6LnB6hHrk1ERQTY+n5eOBrUI9E/UW6VgC
 n534XM0l9ZPNBiuaXO8vPIE6Tfup81JVcCrFTnQIEKedXlR5i4eUdMc5ad5iblWMO+thDWzoVI2
 d6zJ+KKXuiAyrQWOUoKhwoGEdGaU9vAcbWu5QjNx4XCDGK+psBDMRu92OcY2S9wLLVAppLkEXY4
 jVYxvCczP2lcO1iREVHuiugY2VizjC+MfQ6BleM2ztD8vtElixRorNpi7NcMSRTJzd0=
X-Received: by 2002:a53:ac90:0:b0:649:443f:ab2a with SMTP id
 956f58d0204a3-64d141f5c5dmr2868867d50.37.1772821289470; Fri, 06 Mar 2026
 10:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-20-peter.maydell@linaro.org>
 <20260306181008.00001850@huawei.com>
In-Reply-To: <20260306181008.00001850@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 18:21:18 +0000
X-Gm-Features: AaiRm50UZlofQL7qaLtHlG9U5ba9ujl03MdIhD9s6PoTqk5BiE2zue5yM0BTBds
Message-ID: <CAFEAcA_wJKO6nHnEJ3CjHZkt-1PwrVaWZbNGwy9ZarT477P-Ww@mail.gmail.com>
Subject: Re: [PATCH 19/65] hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 6 Mar 2026 at 18:10, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:01:26 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > The IRS register IRS_MAP_L2_ISTR is used by software to tell the IRS
> > that it has updated the address in an L1 IST entry to point to an
> > L2 IST. The sequence of events here is:
> >  * software writes to L1_ISTE.L2_ADDR for some L1 ISTE which is
> >    not valid (i.e. where L1_ISTE.VALID is 0); it leaves VALID at 0
> >  * software writes to IRS_MAP_L2_ISTR with some INTID that is inside
> >    the range for this L1 ISTE
> >  * the IRS sets IRS_IST_STATUSR.IDLE to 0
> >  * the IRS takes note of this information
> >  * the IRS writes to the L1_ISTE to set VALID=1
> >  * the IRS sets IRS_IST_STATUSR.IDLE to 1 to indicate that the
> >    update is complete
> >
> > For QEMU, we're strictly synchronous, so (as with IRS_IST_BASER
> > updates) we don't need to model the IDLE transitions and can have
> > IRS_IST_STATUSR always return IDLE=1.  We also don't currently cache
> > anything for ISTE lookups, so we don't need to invalidate or update
> > anything when software makes the L2 valid.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> One trivial thing inline.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> I think other code is all one blank line between functions.  Guessing no
> particular reason for 2 here?

No, no reason. This kind of thing usually creeps in during rebasing
or shuffling around of pieces between patches and I don't always
spot it.

thanks
-- PMM

