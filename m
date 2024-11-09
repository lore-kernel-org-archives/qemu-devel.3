Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D1CD64075
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9exa-0006jU-Cg; Sat, 09 Nov 2024 01:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9exY-0006jM-Em
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:28:36 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9exW-0000uM-MW
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:28:36 -0500
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so577022266b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 22:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731133713; x=1731738513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNJVGivY9x2lfWzH3SyeTmuDvzlThAkBFU1sZtixOO0=;
 b=hxu5BG96PlXZVxWvGz2FvQYQgT6VcLQmdlggvd1DosmnK6Vk3dwjy2Y/t9pmajh9Da
 cPVhicyu12uxkjVObTm6n6Q74w2iLJJ4FWGZcfTdS78VWkBqOk0tG27PeQwgSTcRc7bF
 EnrsZihazhswm98GTQQ9dirc6Er6j9b6uknUW7fZOQrYM5yp352cCGUZeH7aqiMar5nv
 JdaG8OV+DJVc+Zw2hvgsiyuIyDss/1Fh3yyhb/ce61pwuG8AyNHpOY5Ccb/qlZrybV3O
 D61K0T9NseJqGDUp2GsyaT75ozKUCM8M8HhBLjx/x1AUQ96t/AdYcg5ToUkzVz/FfTnz
 v2SQ==
X-Gm-Message-State: AOJu0Yyqr4x4OmCYDR3Sw7967XaWVBxovSXU7HLZ/FgJS93WNXiqbZod
 RMgHJC3jvWEwzFNCEtpB2w0CL1d0uEwn1KY8BJMEpd72YANp+fFy
X-Google-Smtp-Source: AGHT+IEXPsP9CoMFa89mHLDjCHOdfjCyiUp6wyrPn1p/n+U5kkK9z9pYi0Eb3KM4Dr6nz3QLxzMJgQ==
X-Received: by 2002:a17:907:3e88:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-a9eec5823a8mr587122166b.0.1731133712484; 
 Fri, 08 Nov 2024 22:28:32 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2f063sm320647166b.203.2024.11.08.22.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 22:28:32 -0800 (PST)
Date: Sat, 9 Nov 2024 07:28:29 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Richard Henderson
 <richard.henderson@linaro.org>, xen-devel@lists.xenproject.org, Paolo
 Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jia Liu <proljc@gmail.com>, Stafford
 Horne <shorne@gmail.com>, Paul Durrant <paul@xen.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] hw/m68k: Mark devices as big-endian
Message-ID: <20241109072829.205680ca@tpx1>
In-Reply-To: <20241106184612.71897-4-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.52; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed,  6 Nov 2024 18:46:10 +0000
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> These devices are only used by the M68K target, which is only
> built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/mcf5206.c  | 2 +-
>  hw/m68k/mcf5208.c  | 6 +++---
>  hw/m68k/mcf_intc.c | 2 +-
>  hw/m68k/next-kbd.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

