Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996D8D185E8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdomv-0001zy-Tr; Thu, 08 Jan 2026 07:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdomj-0001bu-NL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdomi-0003jQ-7a
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767873991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P75vqgH2JGmyjPiVf4WrlChqenNybJ2egsWzv8PKRY4=;
 b=JLNQfKyqCJ0CZxa88HrjF2vlrjbySRnDJFuN5INKpc6k00MqiVoBUylC0RhsEgoBZN935E
 ooT01UDGTCEyRO7qnDGVtqtqCYLZt7mpm9z/EDcxezdGMXlkjnDwShRTUcQVQJnNtdeIpx
 xVhDaKaZ4PxvF0qscN7ZY4lKAgcG1nI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-gP9xYlE2N5q9bXuicMqLwA-1; Thu, 08 Jan 2026 07:06:30 -0500
X-MC-Unique: gP9xYlE2N5q9bXuicMqLwA-1
X-Mimecast-MFC-AGG-ID: gP9xYlE2N5q9bXuicMqLwA_1767873989
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a83800743so10122165e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 04:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767873988; x=1768478788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P75vqgH2JGmyjPiVf4WrlChqenNybJ2egsWzv8PKRY4=;
 b=jEfR7uivIyRJb50zxueowXTtLvqaxJAgot8a2Bn2CEkwERmRWxDdgizfPNpjvsbpPJ
 6semYZskF4Q+YB95QvI1CKQv2KRiRbSN8Ygre4EgiE6P3bfqVK3r1XubCr3g/tJ0aKHV
 P+J6UeBV0kcP6wBXsqb02+cdG7svzS/bcI+RZUBSfc/HNR18fTcYrI91YhkRWQV9QWz+
 +gZKcrX7ygv4N5SAUEHNJivsjYtQUGmzfdCE05HwlDvhaQtLqw3SugIQpT946SkXRTg7
 EE3lzM2bXZMrpaKhT5X9h1uOXjIc0q2cpNYK7C0BEIHw9XsWcNoBLU90geKadbet/dNv
 T2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767873988; x=1768478788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P75vqgH2JGmyjPiVf4WrlChqenNybJ2egsWzv8PKRY4=;
 b=nqhwsxt6LUTVwlG865r0qL8cQzro349ZwSyi2ZO9s6bYxgWgwqCddd5EPYB+qzMxYU
 bRQwO0cAAFFLa6UsbV26ntnG8Dv/OhrCzIzP5JSiBCsTr9rBYbVhETFvmRLh5AGDDW2o
 cKlKlsq26jGO6witKXxNBfPey8gbvpKpxDmrNJO0TkI/aAEWjns7O4xzV72XiaUdMBM4
 sdZk3VD6yOpaL/k/f/Z8BE4Vd1kUSebkq+ZvVzH21DlaxxaYL+RXIYW60ChWinLM2UdZ
 xJSYYZFCpyWN96iHpNZ5RqKzFYPONb6UxOAd/RjpfmqMoUfqikEYLwMWmCaNu/BVf6De
 l20w==
X-Gm-Message-State: AOJu0Yz47brZw6EaqHffno8+9bZklh0seYI85tMM1GVjKNEee8udRaOI
 IjGsFwqMvMPPfLoFkCBoCcqUJswse5M+Ud5vZjdIrmqU0xTre3bMBQrZOE6AeWHhO6ERFUxdWZ5
 J7jkZTklEsvtlr7fUc2+Glkh5Dcr8M4+prwOqDuxl1sljeaMsSMaB+mINUIqiYbGgX+w4HelJB0
 4gcosvnIMIP0mThwvh7qZGxbztIPIIML1s0eRS3W8FRg==
X-Gm-Gg: AY/fxX5ECLP8mcccElF5XpkGLR+8mkGZsAaNFBkxhe485Jt7Cp1I4IwwAHiQtKYjrEF
 GbiebSSBLhNy6BWtgJXvqc4GyO34rZEkHgg0PhCTXZOSFfcUYSs1WiZn8ZKASWf+CyuUYP7JIs2
 7vivc1kZGnbcdoFAf8jTfPygy6FwRyujCyUpZG5qrOSXldYOcIVSyfe07akX5pyNxNd0Y=
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-47d8484a4e7mr66678795e9.8.1767873987910; 
 Thu, 08 Jan 2026 04:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXT2uRbpYUMw+wlEh00XI8AvuVA/Y/+0WsqJLeJ71xzaUziW8JJHVvPuKn7BEYQza1T/arWAyNCY63KzfmNLA=
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-47d8484a4e7mr66678505e9.8.1767873987511; Thu, 08 Jan 2026
 04:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-6-philmd@linaro.org>
In-Reply-To: <20260107200702.54582-6-philmd@linaro.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 8 Jan 2026 17:36:10 +0530
X-Gm-Features: AQt7F2ogQO7OcCzMJqituu9atiWvQPtpqnfvPUZIJetL2OPoAk3n0pmukpUAYjE
Message-ID: <CAE8KmOzxmM0NVSAJWHjyUgRg8=3C48-sbVnaTxg4u8GyoDnJtQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] target/openrisc: Avoid target-specific migration
 headers in machine.c
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

On Thu, 8 Jan 2026 at 01:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header requiered:

* requiered -> required

> "migration/qemu-file-types.h" and "migration/vmstate.h", which are not ta=
rget-specific.

* They are included via migration/cpu.h too; Still the change looks fine.

> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index f2853674f0f..2d5ca16c511 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -19,7 +19,8 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/vmstate.h"
>
>  static const VMStateDescription vmstate_tlb_entry =3D {
>      .name =3D "tlb_entry",

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


