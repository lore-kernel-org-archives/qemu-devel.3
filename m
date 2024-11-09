Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892D3D5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f8N-0003Fj-Uu; Sat, 09 Nov 2024 01:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9f7x-0002wO-TM
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:39:23 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9f7u-0001xT-MG
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:39:19 -0500
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so2567582f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 22:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731134357; x=1731739157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0bCOe3u0gtgRNy9hKRvSdASo+/BgARCB/z16A9uSDU=;
 b=m+69z4B7lAcwVooyx+cvVFfWu1XFwWjJAPNP/V1arazGOXYjMu+J8ZPPA1ToAMi0hR
 QCK+hqzpYjt02uXb4Cnm1egvX/kXD0RexjIWUjP+rxpjL4r4uqbJj931jutQ0AfwQ5OG
 Qs5s6s7Ukk0Totz+fIf1s+E3aLWzFcODJCTs+cnnfZMouv7PWmh0Ntt9yO++yKN9zIC2
 Od3C8Naht3QHa5b5Ol85DyLQ3zuHrf+dQvdaaSfT0LPZbiWA1fTHzxrgZ96wzy61OzKZ
 iYTTPAiqh1VEPdmlreTylXseAeyHwlhcbkmHlLdJUHC3HZp91QPh7VlwvPh7VEVxSrMD
 c4ww==
X-Gm-Message-State: AOJu0YyonJfVtpKGgU4CKVtdoiKk+trzPpMnNQEGBfIabFJi9Gk3byx8
 qLkQOrEOoD/F4Kju3293YeknyM5vHOo49+nZDUhuBa9DqgZ3MC3L
X-Google-Smtp-Source: AGHT+IGzVbwX9id1Pl7vidS2UUBLfPO0kJyH3hRsr2sBMlSE6+jJdE0A7qwElRUZVOCsCCSoj+zjZQ==
X-Received: by 2002:a5d:5886:0:b0:37d:5130:b380 with SMTP id
 ffacd0b85a97d-381f186cbbemr5239484f8f.23.1731134355294; 
 Fri, 08 Nov 2024 22:39:15 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0deef4bsm324372866b.138.2024.11.08.22.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 22:39:14 -0800 (PST)
Date: Sat, 9 Nov 2024 07:39:12 +0100
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
Subject: Re: [PATCH 1/5] hw/i386: Mark devices as little-endian
Message-ID: <20241109073912.711357a8@tpx1>
In-Reply-To: <20241106184612.71897-2-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.221.53; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f53.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed,  6 Nov 2024 18:46:08 +0000
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> These devices are only used by the X86 targets, which are only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
> DEVICE_LITTLE_ENDIAN.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/i386/kvm/apic.c         | 2 +-
>  hw/i386/pc.c               | 4 ++--
>  hw/i386/vapic.c            | 2 +-
>  hw/i386/xen/xen_apic.c     | 2 +-
>  hw/i386/xen/xen_platform.c | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

