Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60949D185DD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdotT-00062y-EB; Thu, 08 Jan 2026 07:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdotJ-000603-7R
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdotG-0005Dr-VN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767874401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afEvXB26Ewj5l0Ksf8Kd7PefTO7e/dCkUEQv3gAnKco=;
 b=UJ776i+4zMfc5cPr+EsQmaebDqn/aQWpYo3DkrSbJFiyWSvNIfQKAYll83sqY5G/6nrDZk
 m8xBlLRKU1MkxLyxVqI1p8ytT44BSvIL8aJT2XSxiwhlskk4I9CR1oMo44ThfrLC2OaUej
 aNeH35o9v/6q7sdtIh9X2zvN605rmE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-iEGUdafJNk6Cv8gMHSJdbA-1; Thu, 08 Jan 2026 07:13:18 -0500
X-MC-Unique: iEGUdafJNk6Cv8gMHSJdbA-1
X-Mimecast-MFC-AGG-ID: iEGUdafJNk6Cv8gMHSJdbA_1767874397
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso31742525e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 04:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767874397; x=1768479197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afEvXB26Ewj5l0Ksf8Kd7PefTO7e/dCkUEQv3gAnKco=;
 b=bNnAd8p5Klhjv6uVdBe3tIOWaOdp/9t1GxhJlW+h5zUFR29cXSCSKgYDv8I5BK+cPf
 ZVaSsux2KWcbzDVq2rG4BauwwawwFgbTo2OsCzd/TfFoeDaeIH7ALUnx+b5vM8dRTUkb
 GE/CyY9v0hizM06oN9WolfXonFacQ9Xi5yMWBfEGHvxZc0PjtHegSSzwAULKGBRIA0HN
 HS2ykFQiOTPfyHdDI1fK1oOInLLFiCVgf/C8MInjSCiyx3kaA6+ghuAH2ebE2LEN1t07
 HZukYc3Vmp1Kov0dwTeLzGN9VifBODKiR0OkJb9rfWyFjQihaKiBST+9WID/skos/sIb
 3euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767874397; x=1768479197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=afEvXB26Ewj5l0Ksf8Kd7PefTO7e/dCkUEQv3gAnKco=;
 b=cfgv/7CIqS04Gx8t3MDQ1z5YK6zIgkuRtc5ZB1FeCRe32igmnH+5/eSmpf459uVNC1
 rY9Ou1+zLBUCbVmix/ikqvxbBiZlEfu8+4MpYJ1QWpau+VDyYpJRSehfEosGvPA9P8gF
 Rsj8nNjTrE6RUVgVqBALIs7PGCaKmqRNWsrw67t4bZmLE3NKGtkJmPFDm65oOY6lq7a4
 ktfBfrgYzOI4aFxWpdPcww1AUGbRkAXR/bTSDeKJb5tNSF6mIEL4xNZ663zHw06vBD5g
 uE0h+oR5fL/ji3Zot2P7/vi3aExMrk3h2aRvuo6+d6WUph74vyJR1FkJPiykHdxMMII5
 rJmQ==
X-Gm-Message-State: AOJu0YypCi7DbWhiCTuY1Pempoi04L3vC6lnZvm7qUanXL5kr/PNDnVd
 I9Gq588CckFxod3a7hA6eRgzoAldKdLLHCsAcsH8CCBQs/QlURBs2xFw9jIOEafxkLjfCXYDYf1
 GKfa2xkQjb0fy6TruHvNkUwKVPoYjZ4RBPbmTwzHg/bMP1fFuhiO8XppRsQ3PWC1K4x/rpfJWus
 MC84HVA5cPVhQGamBTnHREbCvzUFumuwk=
X-Gm-Gg: AY/fxX4bRBFB0aOtomFPwNCgna/dP3e1I756mbCQigDTFbxVMu31TMNasz+CTdF1waR
 wxiEKxnihjS2Wm7GiFCtKD/6sddL/DrPI3/KT2GMB97DHZDvZL+MD/28d5ERnatyLo3bgXMMpOd
 OO0ZvRJMFpaOEmyUORdCcCe8lt3Mw6e7xHLvyoabaZVULiNAWQpXVE2iR9HbP06FkN74U=
X-Received: by 2002:a05:600c:4f53:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47d84b3b389mr74259585e9.31.1767874396851; 
 Thu, 08 Jan 2026 04:13:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWrTxf6G5hNqrr9JxRiBDZl20cUNHbJhrGx/8zgEa3Q6ahwq4MXm2aWKwmMaFoZ+rZv32w5bPpA4Zp37FtTk4=
X-Received: by 2002:a05:600c:4f53:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47d84b3b389mr74259395e9.31.1767874396441; Thu, 08 Jan 2026
 04:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-8-philmd@linaro.org>
In-Reply-To: <20260107200702.54582-8-philmd@linaro.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 8 Jan 2026 17:42:59 +0530
X-Gm-Features: AQt7F2pL2YJvmwfjrszehYvuZaybmJrKz6PoXN0SRaxKU4X399-Qp_6Z-X-QFe8
Message-ID: <CAE8KmOyPTqYau3OOAKVE05f40Y9oyLjsycc6mVAkzWiJEaU+hQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] target/hppa: Avoid target-specific migration headers
 in machine.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, Stafford Horne <shorne@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 8 Jan 2026 at 01:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header requiered:

* requiered -> required

> "migration/qemu-file-types.h" and "migration/vmstate.h", which are not ta=
rget-specific.

* They are included via migration/cpu.h; Still the change looks okay.

> diff --git a/target/hppa/machine.c b/target/hppa/machine.c
> index 13e555151a6..6a143cf8df2 100644
> --- a/target/hppa/machine.c
> +++ b/target/hppa/machine.c
> @@ -19,7 +19,8 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/vmstate.h"

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


