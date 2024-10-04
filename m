Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C9BCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJS-0006fI-5R; Fri, 04 Oct 2024 12:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1swlHc-0001J0-Hp; Fri, 04 Oct 2024 12:36:04 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1swlHa-0006aR-3q; Fri, 04 Oct 2024 12:36:00 -0400
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso346537866b.0; 
 Fri, 04 Oct 2024 09:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059755; x=1728664555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0EUiGvwv3mrmOCKDKoPvafdNdyF/xLK2qEfhfH4y3A=;
 b=IRTF9vGdZb8u+jG65IEiY+9dUGBww95G4MDfPysxlEBRvbX62dhy7sLvt2ldJaHWo4
 cmnLxDrom9HwrijuR7X//f2boxjGL6Kmnded6twlD5IbFVoydlVMiolTRDNDloderik7
 0H+SxxlFzoTmqyVGOfqxEw34cieKtS8PqPbSZGYp5oDxkLWBN7bSAz4jUswC/mBT2EG5
 jU64ZAedz/gyKEexThWlDidOArggnwXml15WtfzW5oSS0Ps4xQzaiArM4/JdstfgAT1s
 AY+y5QHIHJrOl587foFaVTyysWkU+beyLEAcmn3uzj2X25m0sd1FPorJW/Igazvktms/
 whZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgkVf+1YhIAlJgZqwdxunY5IfqRK/uKLmORKaJRpUsq9QaS/7TeHk+DQhxZ9q5kL29gYHg6yfiSHYA1w==@nongnu.org,
 AJvYcCVB7gXLqw1IiW/aczc9eTMVi1wV43uccdYVmKpjuqec8dqMrmcOzD5BHJxE7xPWb7+cOlEfUWlTcQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzsf3oIfyWnPu4whBKl/GVDN6+Poxpai7OLB8lz72afFNYPQE5H
 SDnGmfjrlhgurn4YFEoNrtDxxPIL+1t21rAUpoPG4ES46Ser1GRh
X-Google-Smtp-Source: AGHT+IGyfV5NLgU2kyU63zECXxYIt4UujchRL/O/Chddwg3oQ+2hYI5Z520eY29axIsOb3em8yX/ng==
X-Received: by 2002:a17:907:e6ca:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a991bd0b7demr322476466b.15.1728059754944; 
 Fri, 04 Oct 2024 09:35:54 -0700 (PDT)
Received: from tpx1 (ip-109-42-49-143.web.vodafone.de. [109.42.49.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e7e226bsm12542566b.210.2024.10.04.09.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:54 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:35:51 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Rolnik
 <mrolnik@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Artyom Tarasenko <atar4qemu@gmail.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Song
 Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Eric Farman
 <farman@linux.ibm.com>, =?UTF-8?B?Q2zDqW1lbnQ=?= Chigot
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Richard Henderson
 <richard.henderson@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 06/16] hw/m68k: Use explicit big-endian LD/ST API
Message-ID: <20241004183551.5f84a103@tpx1>
In-Reply-To: <20241003234211.53644-7-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
 <20241003234211.53644-7-philmd@linaro.org>
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

Am Fri,  4 Oct 2024 01:42:01 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> The M68K architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/bootinfo.h  | 28 ++++++++++++++--------------
>  hw/m68k/mcf5208.c   |  2 +-
>  hw/m68k/next-cube.c |  2 +-
>  hw/m68k/q800.c      |  4 ++--
>  4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

