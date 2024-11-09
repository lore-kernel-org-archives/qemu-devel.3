Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B23AD5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f76-0002Iy-MX; Sat, 09 Nov 2024 01:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9f74-0002II-Cd
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:38:26 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9f71-0001s3-5e
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:38:25 -0500
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so4039346a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 22:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731134302; x=1731739102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yh9OIV9oZswSsFPCTF0kPB7VF1ucoQK7O4BeLuZMrcY=;
 b=H8Z4nFZcKztIkQxXs4v892Je8GUoxUpS2c0tgdsg9b+boV+jBtUaUDRTHMuBNlvjc7
 PHd3xq87pykefTJVhBrrCgLO+HiBKPH8jW2AMI5C2vUQKq4wndZ8jnZmHoKhkqrAVXxJ
 iC1HTLNnhrGIuEqbW/FbJTMsIEW4i2C4REFpXiIUOvK3APkJ+KrM0/78Q8tC3v763WQJ
 n3uwz8bInfmc4h+/YasrWIA6RN6xZqJYaxqQwxxteGvu2xzM0mrw6gy3QodzRV5f5OMg
 1h4dLju/fG2vCbL97S9NoX57TupVhedzVSyFCuXiuWPnpvjuU4GfmG2WCeDTMhuGNr8R
 DaUw==
X-Gm-Message-State: AOJu0YxPTGiXVLtSdGCsz6paORoz73tl1pAvc3XKfpmgloBC3hl211Gi
 aHd8D5kK4IkV8ta08RQrY4ZphLGVFXTTVBgTl4IEZ87LRbdL/6UM
X-Google-Smtp-Source: AGHT+IHPajL9uDCipqaoWRFvEDIWChGJwvUQQ3wq/EqOC6SQN31/8hSCkCC0GORuyRX1TGgUbym+oA==
X-Received: by 2002:a05:6402:1ed4:b0:5ca:14f3:2883 with SMTP id
 4fb4d7f45d1cf-5cf0a2faec8mr4822397a12.4.1731134301339; 
 Fri, 08 Nov 2024 22:38:21 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b7e803sm2718538a12.22.2024.11.08.22.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 22:38:20 -0800 (PST)
Date: Sat, 9 Nov 2024 07:38:17 +0100
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
Subject: Re: [PATCH 2/5] hw/tricore: Mark devices as little-endian
Message-ID: <20241109073817.40177d87@tpx1>
In-Reply-To: <20241106184612.71897-3-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.51; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f51.google.com
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

Am Wed,  6 Nov 2024 18:46:09 +0000
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> These devices are only used by the TriCore target, which is
> only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
> DEVICE_LITTLE_ENDIAN.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/tricore/tricore_testdevice.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

