Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC0C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOOW-0002rT-Uy; Tue, 04 Mar 2025 04:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1tpOOU-0002qe-Qr; Tue, 04 Mar 2025 04:16:54 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1tpOOT-0005zy-3t; Tue, 04 Mar 2025 04:16:54 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86b3b60d647so2376820241.3; 
 Tue, 04 Mar 2025 01:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741079809; x=1741684609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khSnok+77gU2+Ua7Eq+3VskYRb0Xp1MmA8gAW+FkOCY=;
 b=dX1DIx4/ZNZRppjDRkx2ymUuPnBlFumySZKRJu1487kurQgXIZalHvW5qtCobL+lyK
 d4VekvuUkUj0zcWezTR9HKQEZghZ4VzOtBa7Wpvnrjn5TvyjwhD8WMaJFQbBiV4MEKY0
 kyp/hpoT3Xa0jKKsDfiP4zs+hUpiw+VE3rkIma4umxDKHhBFcCGjIUTZPFao1AGdnYRp
 XoF8O6xlhYo0JZ2geMGJJ1xLsoLsRU4Y23fj2+/0i1LAY70qWy55ITllC86IhMtgWpSc
 44vBdVNdxqGL9hHKfAS05gZ5g4j8bXXdjtJ3aRDqvbT8hMTpo5KHRSgtDRdu0ORUoAFy
 63nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741079809; x=1741684609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khSnok+77gU2+Ua7Eq+3VskYRb0Xp1MmA8gAW+FkOCY=;
 b=SDFfCkuuHYRHi2i0f1khbefDF8jqR6xArtdBrFCaAH+G2TkXopsWEHtUpgosWwVcDI
 cykx87bVSc7PVPRvhu9hCo1tuM47fgBEjDtQJD6X9YAmJg7bVFPjVVDsHlZ8ghJPMv3a
 sJ9beJzhWGfxYzEUVVZ1nh9yWMmPWRX0NhCYicKkAvMSRHL6CsUpalWaX5m5LgKhnX6R
 12MdgYjsyISZFmuBMeL1ZX87ntNYcDiluI45U1kRQ8lHckxgW01Rr/dqCgS3LyZqtaBr
 g2HGwXNFBFldfJltaMgjKLkoKBx7IOhtFlFqBOxmsArNbJDuJRUDsNiHmPIkQj+TLGIj
 oXJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7+9rO48qn9VAb1irSUc0VCCc/fUe6YTllGX2SdwKP6Isa7PMRYMzN1y/CSZMR7CNCqMgzwn1hTcPK@nongnu.org
X-Gm-Message-State: AOJu0YxKWtIMUyIZiUEJmkRNgmEADePMYdAIZH9Xh5HO3FoXVg/7vcqu
 M+ym9dNMSBlaZX6+6Xk9zP4tCtSXeCAD4J/JrlKxnYK27G/B1nNmnmgKe2RtyAgYsUy5Us/V+UN
 hfXVl3NStrDVwqnboaDe/bmFsjQI=
X-Gm-Gg: ASbGnctZbRwPvvJNa8Osi1J6HChTbxDZviVviazLczo3raSqxbNSa6liuSYD7IBkpv+
 BwoXyxlf22ohsNbcIvo162Y8VX7Qj2iyNGwZOn5zcmxcwbWo1SZ5bXpTz/NZoXKLzlvrxaP8fEL
 fxCJhIdFQDp/VI40ZWcDFFS6w2mEEVVarx8YokMSUpeTrGRuJRNfeV1W7bJ1A=
X-Google-Smtp-Source: AGHT+IFY8klF4e3Wsx2zWD3E0d3kQVtkUmQ0zt4wd3XO74KYzrurxC46DEND9COldw/LSIucw5jyFBL2q/2Wp7EJMBk=
X-Received: by 2002:a05:6102:32ce:b0:4bb:eb4a:fa03 with SMTP id
 ada2fe7eead31-4c044d30a75mr9516707137.23.1741079809237; Tue, 04 Mar 2025
 01:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20250303133510.246424-1-Raman.Dzehtsiar@gmail.com>
 <ib3winvu67xep4eulruuw6kbxz7gggiiewssnw226wj2ch3hj6@ko7xdxjqfdw5>
In-Reply-To: <ib3winvu67xep4eulruuw6kbxz7gggiiewssnw226wj2ch3hj6@ko7xdxjqfdw5>
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Date: Tue, 4 Mar 2025 10:16:39 +0100
X-Gm-Features: AQ5f1Job715fcLZ8SdlZUTITYRJxmH0uiK04Lnn7sg5mau1wOj-9TPGlvLqYTW0
Message-ID: <CA+uc5a38bphJ+1ghcRGVJ=Wnn+JML694AQbAjG5ttPT0sCh5QQ@mail.gmail.com>
Subject: Re: [PATCH] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Wen Congyang <wencongyang2@huawei.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, John Snow <jsnow@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-ua1-x92e.google.com
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

Hi, Eric.

> >                              backup->on_target_error,
> > +                            backup->has_on_cbw_error ? backup->on_cbw_=
error : ON_CBW_ERROR_BREAK_GUEST_WRITE,
>
> Is there a way to avoid this long line, perhaps by using assignment
> into a temporary variable prior to the function call?

Good point. I=E2=80=99ve refactored it to improve readability.


> > +# @on-cbw-error: optional policy defining behavior on I/O errors in
> > +#     copy-before-write jobs; defaults to break-guest-write.  (Since 9=
.3)
>
> The next release is 10.0, not 9.3.

You're right. I've corrected the release number. Apologies for the mistake.
I'm still getting familiar with the process.

Thanks for your review! Both issues have been addressed in v2 of this patch=
.

--
Best regards,
Raman Dzehtsiar

