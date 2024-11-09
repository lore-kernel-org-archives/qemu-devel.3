Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB91D5E144
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gj5-0005PC-MG; Sat, 09 Nov 2024 03:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gj4-0005Oh-6V
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:21:46 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gj2-0003Wt-Hl
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:21:45 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so199941366b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140503; x=1731745303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wakWl2GFmoFiTacP5GSUJu7YQeFxdlhJ7DDJ/aWa24w=;
 b=eRG6DJnKR/4wxTPEq5aR3vr8kxQssZR5E0K8/i8pfvFVEmJyGhjY1d4VvC4rD+GeSJ
 dLadcjHFw3+t2qKfIYPhM5C8RJtyQpj4byfpL7EVdL1w1J0HKLysyzWrNC2qwPYcgQfg
 uVzjo7lv4SYSwWRJbAE/dcja0jxtU/voPY8G5dBSLFJQWuHacZ/O4R5dN7Egn5LrlItc
 9ujFf3p0UpF3GssD7zxOty+TztD98qTNX80FuSlLQB/tl+rrxpi7rVxseCbxb64VAyax
 ag7Ne9Fz+n1WKFDOWixUCY0mKCTUCKCfZ540XkCPTu4/J9WP121Lm42uwFKrYAwUqdbO
 ry4Q==
X-Gm-Message-State: AOJu0Yw7lKrWD0JWbuQb3cy10bc5q7QJK+KzueFray8tUTkWv69JEabH
 FU5dIOm+dPJojByk5gsTz09194KXeaN5Piv6zG/4MVqQ+kIXFoE8PsoAR1gu
X-Google-Smtp-Source: AGHT+IGdrcmPZPGGczkpa9RlIXGaNLz+jjVSOYwHE3LZaiyer8/O4qlX0oEXgiz2dXmG3dnp0MPo/w==
X-Received: by 2002:a05:6402:d07:b0:5ce:d6db:25e5 with SMTP id
 4fb4d7f45d1cf-5cf0a320407mr6866341a12.18.1731140502435; 
 Sat, 09 Nov 2024 00:21:42 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a48b09sm340058166b.63.2024.11.09.00.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:21:42 -0800 (PST)
Date: Sat, 9 Nov 2024 09:21:40 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 29/36] next-cube: move rtc-data-in gpio from next-pc to
 next-rtc device
Message-ID: <20241109092140.51af2289@tpx1>
In-Reply-To: <20241023085852.1061031-30-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
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

Am Wed, 23 Oct 2024 09:58:45 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Add a new rtc-data-out gpio to the next-pc device and wire it up to the next-rtc
> rtc-data-in gpio using the standard qdev gpio APIs.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

