Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E908C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhasH-00050F-9W; Tue, 05 Mar 2024 14:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rhasF-000507-RL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:54:51 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rhasE-0001Eu-5W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:54:51 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4417fa396fso743229566b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709668488; x=1710273288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YC4b2cVXloWpoqqCBwlpKZuhf6Pn9xSqQ3vLqZEzSpw=;
 b=PZkxoRoUfFsGvWUVajTVJ18D5z0WYHBKcAQ4GWOM4k02R4WNaUPBeMOe/7Toy5//Nz
 3r8cZz1WJ/tG4AUX92vDi9L1yfq9CATXh7hyDtJvWmCH8Qz+yesoNEykMZMk6pcfxks1
 p/4QtXhkdQJPFKJzDt2FRj+mLgrZ+74EFf8xxAzqi+ovOu0sTL5lqTJV9yRvVBLjsVy+
 mvczKUJhUAEHNGgp+dnhFFUFDb8Qq+/FhgC0v34EMK/VAo0EhXgjHqyXFaKXJSVuIqe2
 W7sgCQl3cQMmY4XxsGDHkueqoVfZB9TRODlrSa32tqOJhh9wYqnTX4mkEDs6Oyq8tsHN
 ewEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709668488; x=1710273288;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YC4b2cVXloWpoqqCBwlpKZuhf6Pn9xSqQ3vLqZEzSpw=;
 b=evWoCCXW8iDyMZx0ZmBAdztw833HPagS1xPe9e9Oahl9EPcv/vJie9xURxj9Znf3wY
 6EqC2xc5iU6hAay62R/nA6C+NRHMa82rfJ/vXGzD+eL1CQswkSIyuK16z3/3F8V6x1SA
 UZMghmglkP4oLAcnEKbkVAzk/HLy3A2ihHw2iNs0Y2Qp89synL8UZi+4B43kQiOkQqgR
 9LCmGCxy5tw9vQZMmpP1z7vLCnesSZYdm52K+Ed+G+bqoMIAYc0w0+IOzTqYis86T/BU
 Rk++nitw7UwiPq18iuQTBouCkXT5N6+lZlqyn/riUbolY0GDBQ50+TqmPHBMHhlSwCoH
 ILzw==
X-Gm-Message-State: AOJu0Yzg7QYHHjfzCj8rEuYmlFFvY5+qpjrGCU2i+jQnIaRjnMEgZbDh
 IJVkwQZmAZ4LzzXz2acwDp820sAuCnDJfrfrsXjFU1IschYKdbAh3BXH+RTEWRQ=
X-Google-Smtp-Source: AGHT+IGbk2nM73u8f7iqJforIrOGcJV43J9g7hoFZPT1nPQmNWmSiDxeCzzIxaIyS63be+E4eLRTyw==
X-Received: by 2002:a17:906:c20f:b0:a45:a9c2:85d7 with SMTP id
 d15-20020a170906c20f00b00a45a9c285d7mr2115844ejz.44.1709668487978; 
 Tue, 05 Mar 2024 11:54:47 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-109-249.89.12.pool.telefonica.de.
 [89.12.109.249]) by smtp.gmail.com with ESMTPSA id
 f8-20020a17090660c800b00a45a09e7e23sm1205455ejk.136.2024.03.05.11.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 11:54:47 -0800 (PST)
Date: Tue, 05 Mar 2024 19:54:40 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 1/4] hw/i386/pc: Remove "rtc_state" link again
In-Reply-To: <CAFEAcA9tzgAetYu8QcR+CgN1L_1ZcCS3mYHbD9oPe5py7Tw1iw@mail.gmail.com>
References: <20240303185332.1408-1-shentey@gmail.com>
 <20240303185332.1408-2-shentey@gmail.com>
 <CAFEAcA9tzgAetYu8QcR+CgN1L_1ZcCS3mYHbD9oPe5py7Tw1iw@mail.gmail.com>
Message-ID: <23F8A871-DE41-4B76-A78E-C3C517FF6319@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 5=2E M=C3=A4rz 2024 15:57:08 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Sun, 3 Mar 2024 at 18:55, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made =
linking
>> the "rtc_state" property unnecessary and removed it=2E Commit 84e945aad=
2d0 "vl,
>> pc: turn -no-fd-bootchk into a machine property" accidently reintroduce=
d the
>> link=2E Remove it again since it is not needed=2E
>>
>> Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine propert=
y"
>> Cc: Paolo Bonzini <pbonzini@redhat=2Ecom>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Ah, I did wonder when I was working with this code whether that
>rtc_state link was really necessary=2E
>
>We could now remove the rtc argument from the pc_cmos_init()
>function, because we can guarantee that it's in x86ms->rtc,
>which the function already has access to from its pcms argument=2E

This series goes one step further and inlines this function=2E It would be=
 a nice to get some feedback before the freeze=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

