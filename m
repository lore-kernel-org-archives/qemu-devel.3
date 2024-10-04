Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F9CF8853
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJT-0006m6-DL; Fri, 04 Oct 2024 12:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1swlID-0001nv-Sd; Fri, 04 Oct 2024 12:36:40 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1swlI9-0006g2-4R; Fri, 04 Oct 2024 12:36:36 -0400
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so2895417a12.2; 
 Fri, 04 Oct 2024 09:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059790; x=1728664590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMHZvx7l7Rej3OyF/0JYKtgw2tqUJj8iyIX5kSCvVi8=;
 b=ISYhVCY8qrJFtZ/vmdstBPPz7MiUi0qN+qzROEOAKJR9P5V6kbXHuo3XwdDyYnwPOx
 baI19ZNp3xCbHvNc2mk8VYYh5xoGBxiF462ijtRg5l74AKu0ZNQQFRRtOinde3V79gi6
 dVR7jT9JV4rf13TE0BXoHdtMsv653e2wQd2VjjtpuCNXVSdJ5iTtBSroAP3oO9u8/sxD
 tj3kZ/Sz9e4lIkIJU6KF4n9ncEa1dMyw5eQMPY73IExpN1rtx/gaT7ZXQGCGO50vP59O
 POnLk8kNGzBQOlgJfoeAwH6+nVoszElp3hZSy+O3dA5IAv+M/gQBmRPsNDPUcJVhF0Hr
 olUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG52MCfs0IP1wDt3rrD7RvzTKYnksjB/0ePQEedR/L/Bd+PDZQ30sbPv9Fw6lnqJepL2f5puaQDZTmdA==@nongnu.org,
 AJvYcCXQEAFIIv0/SZ6d1XaRggcSvaOtgS7GBX7mXH2WsdO/++/c0sBZ3hopT99DYb3mJba/uhXM2918fA==@nongnu.org
X-Gm-Message-State: AOJu0Yx4DPDp2L99Y1AH3Ny5/y81VD92gVl+xmbbUEvJzTAwDDuw9G1t
 BGkqz9MqDjyhHDuTq3pSoT17sNpHszcs1Y0Aw8g5BS91z+/Bbtw/
X-Google-Smtp-Source: AGHT+IGOU3Z3nHR4Ccqar0N+GTmld2Hg4NB7JpdaL6Kuns8YGn+84uNxzNyfs5ZU2KTtgsTYQzwNMA==
X-Received: by 2002:a17:906:bc14:b0:a86:6d39:cbfd with SMTP id
 a640c23a62f3a-a991bed85f5mr285065466b.57.1728059789989; 
 Fri, 04 Oct 2024 09:36:29 -0700 (PDT)
Received: from tpx1 (ip-109-42-49-143.web.vodafone.de. [109.42.49.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e6239b1sm13669566b.51.2024.10.04.09.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:36:29 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:36:26 +0200
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
Subject: Re: [PATCH 07/16] target/m68k: Use explicit big-endian LD/ST API
Message-ID: <20241004183626.73846f26@tpx1>
In-Reply-To: <20241003234211.53644-8-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
 <20241003234211.53644-8-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
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

Am Fri,  4 Oct 2024 01:42:02 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> The M68K architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/m68k/gdbstub.c |  2 +-
>  target/m68k/helper.c  | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

