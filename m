Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C773EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbhk-000390-Fi; Thu, 30 May 2024 05:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCbhg-00038K-VO
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:04:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCbhd-0001Ky-5g
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:04:08 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5a89787ea4so44271766b.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717059843; x=1717664643; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMxDFH8Hn+LC/xG4AeIYYMgPkRVjo3tO9XHDXoVHIQE=;
 b=r8yQTlYHu9pvJE/trv6uqTbBP5BCef+vnsdoK1+RXtbpR/QxloQkxb+KPCYtUXAF+d
 wn+wNY5xJEq5sPClVf4Kin5xOLkqHPQeVq24nV9rJcE3iyd1jjceZ97aI/iVKWfs6inN
 0fwH2/iub5tfwkgkwhLETsEubY/1i3g5Do982x9zbhC3xwzXObM8P1kikYFG5Hn9pG6n
 wzXmDS6bHEHbEcR1P5vVK0ySqN/K+WuLoLrVTTg8Hh6F6sqrlg++JycMMx095MpwDm9y
 DSGnAyv0Y0w+IN7bIMgOFpR4Do2jOQf8PYyxqEtfIlS/Yk0bwpXTWKy+uWmfZjTkheuR
 Gidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717059843; x=1717664643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMxDFH8Hn+LC/xG4AeIYYMgPkRVjo3tO9XHDXoVHIQE=;
 b=NixC1a5Qa6rHAFEdnSNrRfiXVGMrLh3MH5gjI9yTOAsmb8/zY5fABjIXKLz+Uqz9/i
 iNWxY0QL23IZK8UcwXGyO6tIuC47QEJdLVYwtnc3gI8gzWMMPU5QKNPS/t1sxrme95X+
 u5JW4AYlnODHUXBt023bqlOt95hptGAkuIpl38TMQxQv6ti31YHUdL9kcBmWlkwdQmV/
 Nd8qh6QC2Gcp8zzxWVTqahhQ2S1ntG/5HVY4/ugCGDv75h60ytg9khPhFlJvkSw8gWeA
 zSqI/iGmhpvxd69RzeFXIKeL/pOT5dRrCmlkDQQ4KWmSDhpyh1MQiECQ9QgOgeM3pNUV
 37KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Jn+pmXxdrZso6KZpqEGK8gS0Phsz8XsbrE8Q73XA/g0Sxd1GnuAf6A6U6xxLF/TauQVnxNOBAWbafQkhODcN34Lg6TU=
X-Gm-Message-State: AOJu0YxmdlqVqxg5+TxQDCe50vb+fXNut7NE0nT2c6Y+armptexSdG4b
 ogpgm2QxG7ca3DixftvTOEA1HBMIhE1LdA9re6ryM9eI5xXyGeDBcTheZrLzpLJeYbkPcyJ1tyb
 J9JajYnbrslFXVstQIRKOMbZBlnu0UwdnC4WxqQ==
X-Google-Smtp-Source: AGHT+IFmH4NN+LNvzDiqsfE2aFZnHq55mSp5ThAxId4tpAwmL6U6WLSjpVY54QyaEnZew7CIpcWHRHduh/cXWhDcegw=
X-Received: by 2002:a17:906:3887:b0:a59:c963:82b with SMTP id
 a640c23a62f3a-a65e8f74c35mr78034366b.33.1717059843243; Thu, 30 May 2024
 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
 <ZlfIU7TOiXnP96Aa@zatzit>
In-Reply-To: <ZlfIU7TOiXnP96Aa@zatzit>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 10:03:51 +0100
Message-ID: <CAFEAcA8zLOEo09dWioEac2tuPXv+jPYbnTduWZ-MixKbeNBC4g@mail.gmail.com>
Subject: Re: [PATCH] hw/net: prevent potential NULL dereference
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Thu, 30 May 2024 at 01:52, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Wed, May 29, 2024 at 02:07:18PM +0300, Oleg Sviridov wrote:
> > Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL and is dereferenced immediately after.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> > ---
> >  hw/net/spapr_llan.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > index ecb30b7c76..f40b733229 100644
> > --- a/hw/net/spapr_llan.c
> > +++ b/hw/net/spapr_llan.c
> > @@ -770,6 +770,10 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
> >      SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>
> Hmm... I thought VIO_SPAPR_VLAN_DEVICE() was supposed to abort if sdev
> was NULL or not of the right type.  Or have the rules for qom helpers
> changed since I wrote this.

QOM casts abort if the type is wrong, but a NULL pointer is
passed through as a NULL pointer.

thanks
-- PMM

