Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CADEC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhW3H-0007NG-Io; Tue, 05 Mar 2024 09:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhW3B-0007LQ-EC
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:45:49 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhW38-00016e-LF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:45:49 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso867755a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709649944; x=1710254744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iar5Yqz2ndMcxExgXO/Vr1XhhBonegkGTYBbQCldPzg=;
 b=o4/20KFyfihYNWhfG++X9L+KeAL4FiLkk4+/GhVaalU6MAmGnFhlTkJ//+Nm2HanKk
 NkSU6vbZVQZpJvxX29rtjdeR/gluZc2odKVM6winjqE6p29NpCMetighBeQ3DRQLJC8h
 ipGFLamnqUIQgqzfS10323PZ3VDhEEcPhapF5K48rGFqGmcj6WYunklSFMwMhCvMSzVo
 gIjolI3EJa3nza4jMc+rlHwOhAcgpccUCuKM5kKppdcwaN3ZBONXbGRCNieuSvrgL5Do
 vGb4aPzZsZtE/LPNxgclgGDlhNodj3pLL0lOJ8CIH4H+7eFB9SD3V5DXBdceVbqO2taR
 2DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709649944; x=1710254744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iar5Yqz2ndMcxExgXO/Vr1XhhBonegkGTYBbQCldPzg=;
 b=unWclgWqPmagacpURo9uEWuDgyMDCRy9xzRu2PEXimUs+2QuEXbm5zGC60TqFLJrQM
 sBMbIoLNq4iQ+8+NVtKiY3pByVhomEvyWxhI2zvWqmT3ituW+UGGixzODgfKg42hqf75
 NSdExbqdhFAv7VCywpZ3UPbKw/1Y25nbtpXsfyNLYVopJqCb7lyu2IzQzl1fvkDWR23P
 cbyJpT+s+V780zjBAfD4a4qYI1byyFV7M9DZTtXfovD5MQLmQJ4V/7oicmKTyB5xWhT4
 lepXNZ6mkPuI9vIgFlXKOJPr6+AOkK5F78RxI9ixMCOaFz9NucqECtRpDZFKoqG2GxaN
 kwXA==
X-Gm-Message-State: AOJu0YyaDOP9ORMKmvChoUJIKZjh18sER1HAohL/F40yETcCM8/INKVh
 2bMmX21BvQ6VxV3sRGMNSS3tJBQTVTFTrEZQ+3FfwfhzcEbKSTbjBXSW+xWvE9cNyi/Vxmx9MAb
 GrPlDS2DLLx1pCFO9LKYNR+5ocipe0SPCtCbyDA==
X-Google-Smtp-Source: AGHT+IHD6utqPbacIH7U+XJmv2tIvemKmpl3Q5AUkz2UXFLSPUZA3kuZNOMVabVqGvvBYJDNxM4BLNTT9WIHcfa9q00=
X-Received: by 2002:a05:6402:1d18:b0:566:4dc1:522c with SMTP id
 dg24-20020a0564021d1800b005664dc1522cmr8461452edb.15.1709649944413; Tue, 05
 Mar 2024 06:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20240223161300.938542-1-peter.maydell@linaro.org>
 <CABgObfZ_FOs29mZJKcXWTJurWO8wDDWkhfFW9g9ppzOGG2_dKA@mail.gmail.com>
In-Reply-To: <CABgObfZ_FOs29mZJKcXWTJurWO8wDDWkhfFW9g9ppzOGG2_dKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 14:45:33 +0000
Message-ID: <CAFEAcA9JWQp39SQtB4JOZun9aYYvLKaaFH7Lto-Qet-0UAfJDw@mail.gmail.com>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 5 Mar 2024 at 14:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Fri, Feb 23, 2024 at 5:13=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> > was unfortunately added with a license of GPL-v3-or-later, which is
> > not compatible with other QEMU code which has a GPL-v2-only license.
> >
> > Relicense the code in the .c and the .h file to GPL-v2-or-later,
> > to make it compatible with the rest of QEMU.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Before we can commit this to either head-of-git or any stable branch,
> > we need a Signed-off-by: from everybody who's touched this file (or,
> > for corporate contributions, from somebody from the relevant company
> > who can confirm that the company is OK with the licensing, which is
> > RedHat and Linaro in this case).
>
> All contributions from Red Hat are GPLv2 or later (though it's nice
> that Markus signed off on his own), so
>
> Signed-off-by: Paolo Bonzini (for Red Hat) <pbonzini@redhat.com>

Excellent. I believe that is then everybody's signoff that
we need, so I'll make sure this gets into a pullreq by the end
of the week (and add the cc:stable tag for it).

Thanks everybody for your assistance in getting this sorted out.

-- PMM

