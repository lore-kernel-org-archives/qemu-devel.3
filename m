Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0969FD1118C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 18:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7fO9-0007bH-V5; Sun, 03 Nov 2024 13:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7fO8-0007b8-Q7
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 13:31:48 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7fO6-0007Zh-Qa
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 13:31:48 -0500
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so1955587f8f.2
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 10:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730658704; x=1731263504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWNaVbeiGIx20U/8YbJxzDodp9wklQrTND81u6mNNUE=;
 b=K+uBij4vFO6g8l0d9p9QGLNALqFupthXwNAFajuscvbud5515THsx2FOg7we4IpYL5
 9/dzYJqg6oejlDhGjyRC7MDdBZcU17pxdyd+LcWJY31sKhbSsrAlTu7RNrfca/yB6309
 jLtUsbDBfrM6OBSXmQX29s2ZB25vkBd/1oBL3f0BNfDctyS3hlts4SkEe8kLHwX0+1kC
 a0TNXS3vfSr0R6fGLDUt1flhRS9+KXKhSz1tk5ghEK/gJfwsM/tTAlVNmQEXPqzIHK+m
 ppD0gSGlcPHwH27LG1Klzo7xEPix7g4kod81IlY/eYdIgaky3rhxFspcl2ssNJAdDnJy
 aPLA==
X-Gm-Message-State: AOJu0Yx5Oz+0Dy0FDHhKXbHw3D9IO9a7yRorX3MbU7QkMIn1xKOMPIAA
 QMuj8305Ogair5mCGQE5dNpzcssiL/2XvY05HpVzoV64wxrGh/45zX6xGQ==
X-Google-Smtp-Source: AGHT+IH/4/6HTViOkZl/bbdNQEJm3xO5LzSVKnRmTDv8ZF5OHvTAl2oVtcll67Gb+5zAG7ajF42vXw==
X-Received: by 2002:a05:6000:2a5:b0:37d:4833:38fa with SMTP id
 ffacd0b85a97d-381c7a4ce1amr6868106f8f.21.1730658704160; 
 Sun, 03 Nov 2024 10:31:44 -0800 (PST)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e5cbsm11168150f8f.80.2024.11.03.10.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 10:31:43 -0800 (PST)
Date: Sun, 3 Nov 2024 19:31:41 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 21/36] next-cube: use qemu_irq to drive int_status in
 next_scr2_rtc_update()
Message-ID: <20241103193141.7653f89f@tpx1>
In-Reply-To: <20241023085852.1061031-22-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.52; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f52.google.com
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

Am Wed, 23 Oct 2024 09:58:37 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Rather than directly clear bit 3 in int_status in next_scr2_rtc_update(), use
> a qemu_irq to drive the equivalent NEXT_PWR_I signal.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

