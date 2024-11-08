Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65273D4335C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 02:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Epp-0002Fv-Jc; Thu, 07 Nov 2024 21:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9Epn-0002Fe-RT; Thu, 07 Nov 2024 21:34:51 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9Epl-0001uu-9B; Thu, 07 Nov 2024 21:34:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so16470495ad.2; 
 Thu, 07 Nov 2024 18:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731033287; x=1731638087; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkSdOxu3REu2YJvYGWQ1ONNbWIJFsj/XGqOblUbA3s0=;
 b=IdRs9Wmn+0nZQ3FNq/RlfDqXMM9gNoCEhj0I+tST1FSXwxdBISeeReN1Tao7tzpaeW
 Stm9MwmKMA9/M7EjVXq2+eD8k5qvqpjH/ywrDrGWxI0sMt1zZuKW4WF7K2Tttto4Qk/u
 ERp5/Qz/QFzA8Zn1rSOJp5GJNRE8Ku0JqRhWXW3KBK/45qBbFnl4LO3UROBl3KrVmPpl
 waY6rRIZNXGVChPGhg4tdwFknDOXV1JvCbdafg4+u3vcpPFxB8jspYDYC3uCpEHbYKwr
 5l7S+ZrNvK3spz8s04G8LZJjVaermr45VdXVODFHDS17gVC4+7UIMNL2uc7Oke2pXjm3
 qxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731033287; x=1731638087;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YkSdOxu3REu2YJvYGWQ1ONNbWIJFsj/XGqOblUbA3s0=;
 b=vdRy6BJGpcSn5goOilB9njvyMGh/8itq6ksAQ/x5jXL4m5bxEPbKXZasJKZnWbNptX
 6aoYXy1rfpcGHmgnjk/cFU9t1rYFA22yAWhTbVpoc9iKop7V7++5pEWf3LBE8KcMHaQl
 9m5WJ8vJDdIRJ0BNs04mMo2fCEiX+qQQ1RWkqEyvpEAn3jMzQ+aX4Lq7rtGSByY5lODY
 MiTeqc2qIP7elzeHWDPpoiA25D8Zmrub/DqVdacP6bbO/xNaaepZDWwWpT/dRFyP9ZSg
 L80XVn0JW62BjY5xoLv5J++nxPF9n0/s6zlaReyBZ1ydMcfRLrZSF7Np+jWcqjtjDuRG
 Cv+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzaOFB0parGEdg48NhkGr1NChzZc1ZAEHp5LK/2d7ZpAExmfmi9jygO1HrCaZO6Hwkj1m+yCV72GeG@nongnu.org,
 AJvYcCXujSQS0SZHoHedFMu+WqO+o+l5BpJXbALr/vKf+4+HI8YyU4osiuWTKGr0/vtnm/+QJm3RfIIWTzyGbZQ=@nongnu.org
X-Gm-Message-State: AOJu0Yy53gHAc3cYxR1Nd6unp/yge45us5ORo4L67faAXuuiWzJsnrgd
 z3uF+nuYhdwcuJW73Eq8GM4+9moIEdM8hnSlZNoN6MQH9fPOBHKXQ1hfhw==
X-Google-Smtp-Source: AGHT+IFz0ZetaG5Go+TiYnw3Wbc/g13LDYmsCV8N+qTF/I+Nt1GIzxQnvZTNc2WdnlrQuL5D/YgK8g==
X-Received: by 2002:a17:903:986:b0:20c:79f1:fed9 with SMTP id
 d9443c01a7336-2118356a2aamr17753425ad.25.1731033286835; 
 Thu, 07 Nov 2024 18:34:46 -0800 (PST)
Received: from localhost (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e4170csm20121855ad.158.2024.11.07.18.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 18:34:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Nov 2024 12:34:41 +1000
Message-Id: <D5GG33H5Y4C5.2QD6D3GW5TLMQ@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-stable@nongnu.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: [PULL 08/67] target/ppc: Fix HFSCR facility checks
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241104001900.682660-1-npiggin@gmail.com>
 <20241104001900.682660-9-npiggin@gmail.com>
 <eaa0f5d9-caf2-48bc-84f9-f5c1a2f38a33@tls.msk.ru>
In-Reply-To: <eaa0f5d9-caf2-48bc-84f9-f5c1a2f38a33@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Wed Nov 6, 2024 at 1:50 AM AEST, Michael Tokarev wrote:
> 04.11.2024 03:17, Nicholas Piggin wrote:
> > The HFSCR defines were being encoded as bit masks, but the users
> > expect (and analogous FSCR defines are) bit numbers.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/cpu.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index bd32a1a5f8..f7a2da2bbe 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -635,8 +635,8 @@ FIELD(MSR, LE, MSR_LE, 1)
> >   #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
> >  =20
> >   /* HFSCR bits */
> > -#define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Faciliti=
es */
> > -#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
> > +#define HFSCR_MSGP     PPC_BIT_NR(53) /* Privileged Message Send Facil=
ities */
> > +#define HFSCR_BHRB     PPC_BIT_NR(59) /* BHRB Instructions */
>
> v9.0.0-892-g6bfcf1dc23 "target/ppc: Add clrbhrb and mfbhrbe instructions"
> (ie v9.1.0 release) added the HFSCR_BHRB definition here.  While HFSCR_MS=
GP
> has been there for a very long time, since v4.2.0-1172-g493028d8d7 (2020)=
.
> Does it make sense to pick this change to older stable series (9.0 and be=
fore)
> keeping just the HFSCR_MSGP fix?
>
> How happened this hasn't been noticed for so long time?  Is it enough
> reason to not bother with older releases?

Mainly because KVM doesn't use the feature. PowerVM does, which is where
we caught it recently. I'd probably not bother further backporting.

Thanks,
Nick

