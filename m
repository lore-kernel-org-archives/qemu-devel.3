Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D3C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 04:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Bkt-0003a7-CJ; Mon, 14 Apr 2025 00:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4Bkr-0003ZU-EZ; Mon, 14 Apr 2025 00:49:09 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4Bkp-0000FV-V1; Mon, 14 Apr 2025 00:49:09 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86dc3482b3dso4638787241.0; 
 Sun, 13 Apr 2025 21:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744606146; x=1745210946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp6XWlTgN+C/gKCzqEXbgMPNDPmD4QLPg75UWEWOPho=;
 b=KPdAGkXRe7xYOXViCwbskL77qRr5lOOKkpZBEg0gf84uUOtLJOYakAU9E1CwMMlfc0
 XeaT727A3W/drXO8A5sJfUX7ffMSd7HNlKu8JhSuGd9vJ3kJdjqvXf5+Oquod14USnu0
 sZRg3GeZLzAO5/FyJ+QuICkxfzk7vQ5blj08+WB+wLDSI9Gmk2rZ+KEYAAQ+iT3uASZU
 D+egr0TZxXfkoobitl5syF0qWAvZ5DSozwvzns3alp5uE7EnxPorFJAvD0RsupoXvlgN
 8ug899KP7yKExo7+6qL7tuq5OUfEU+a2QXOEqVx7Uh+f78BfC1AJHEgqqeEbYlU4xxDJ
 f+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744606146; x=1745210946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yp6XWlTgN+C/gKCzqEXbgMPNDPmD4QLPg75UWEWOPho=;
 b=km4ti7PlwNBhOXZ2fTK74lmLG+jrZZZjk5VdY+A76MOB6RX+7XkBGqYOQmMqkVx2am
 td8E34sArbcbDU5ZMJutC9D8R+tTD24HFLHE1g8XmPhaX6BZcyBj78djgtDMACXHiPVU
 hlnPaGFdIl536AoMHNUMrzdq+toB1BwJLVzEfiXJh77LgAt27ioBHebjjkJDYvcLR8BN
 KkWCML6mPqJRFJkz5TqNmw5d9PkwB0V2OqqY/l25TdGKlo53fccW3urgZDQsfnWYWrOx
 CKMk1anhRVVCiTprqyTXKc1MyTS9a2ouUrinzaUvgseibFBY1yzu+O7oR9SqPG25mV+j
 J4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdbh8GISrGbBHif6oELh9nLuIyPs13A0fWRvdHctdo+EqinaMJD0qBXErwqa8T3gSMvvh3OgSbMXo5@nongnu.org
X-Gm-Message-State: AOJu0YwcUUlVkaFWAMqgxqarr0a6PVqvrEJrgNIeBUIo/IPj01xrbnTB
 KjDmIk/GL+IyKJQ1z0kprsZH+M6EmGqEsyT11+1peCgA0mMjj0j5UYraWcizHoyB0INuTlN1/ta
 LkDltAc7AuCzjpb/etNqzYRr1Gu0=
X-Gm-Gg: ASbGncuQt2wQwZaLiZvlIJEtPAhfppv9+QmOl+Vhz82D/TxlIhRwywAdb/P9lrX/iMH
 tCkVrJRrNOWxp99ADLPpm2cvLjubfB0emEp1mSVGTAh9qUp8AiWLdUrrG1LKUnW5hGwlpAg3hQV
 e+T1u2x3S+Mgun+4AsiYRnQpRJZSB+ayYcD0X/pcPAoK5pVPMsN3bD
X-Google-Smtp-Source: AGHT+IFtjxEs77+g0t/lkRzdz+VECfaw27gIjJcsnRUTgTarLxggIjZArKS1vfiQNyaFalgR/s89PAjkZh5WLwajEhQ=
X-Received: by 2002:a05:6102:3ed4:b0:4c5:8b0c:5fde with SMTP id
 ada2fe7eead31-4c9e3d86d7bmr7114553137.8.1744606145524; Sun, 13 Apr 2025
 21:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250410161722.595634-1-pbonzini@redhat.com>
In-Reply-To: <20250410161722.595634-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 14 Apr 2025 14:48:38 +1000
X-Gm-Features: ATxdqUF3y-62G1FiABC_B9ftyawjdAtUdNOnai3v-GM1hN4ejMcS_yxFxg9dI5w
Message-ID: <CAKmqyKPZS4_4m5+O_4jT=Le_N5HHN3TE1=YBxg9zbdqwPozNKQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Fix type conflict of GLib function pointers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Apr 11, 2025 at 2:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> qtest_set_command_cb passed to g_once should match GThreadFunc,
> which it does not.  But using g_once is actually unnecessary,
> because the function is called by riscv_harts_realize() under
> the Big QEMU Lock.
>
> Reported-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv_hart.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d1566687..bb9104bae0b 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -104,8 +104,11 @@ static bool csr_qtest_callback(CharBackend *chr, gch=
ar **words)
>
>  static void riscv_cpu_register_csr_qtest_callback(void)
>  {
> -    static GOnce once;
> -    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback)=
;
> +    static bool first =3D true;
> +    if (first) {
> +        first =3D false;
> +        qtest_set_command_cb(csr_qtest_callback);
> +    }
>  }
>  #endif
>
> --
> 2.49.0
>
>

