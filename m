Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242ADD5E144
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gmP-00072P-Pk; Sat, 09 Nov 2024 03:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gmO-000714-Dz
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:25:12 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gmM-0003wR-Vq
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:25:12 -0500
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so433870466b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140709; x=1731745509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onLvDw7ni9GxAbQoN2qpH5Kw0vHceJrjY0mRVF3fc2w=;
 b=hANGbvLpLJz46Mhn72iYfM7/iN3T35i1M/6vohZZOZeLwFMDU6nUtvg2psF9+f5DkP
 SNzzZnJ4xlK91vlFQ9u3Yk9dt31f8lTY0pn9Lo8PBntskGMnb9bimAyukAE0CF9VEqFx
 hjwP0J19BNnAo3t7XBqpB5E9Z1q1wzJYlRPyuBMv0HhLd0op+qDBdw10/caDhfNXq5mO
 OJUA+LHZdmkSz+L6+Y4SaO/siuBEYgQ0/Z/7abLCyxaxZwW3dSkolcse5o50E5RzV6IQ
 y3q5d7JhzRU0Krxx5Sx/ZtGaQ7IhxFSR79rv+4rnTOufE5xwPsosGEyUKArN4aMc6mRo
 W+og==
X-Gm-Message-State: AOJu0Yzcf3jGo90f5veH6W/21mkAaXBBIR0ehqNHpmYTkiqCuOsvMNQe
 WDFrEQ1+iKJlXVL487ysxkRAXvKlUxaKfF8Y4lKSwe4RsRu+SC/DNSV/x7QS
X-Google-Smtp-Source: AGHT+IHBJ4APJLrDRNXREtldaHGCLryrSOkSKQaZwRncqMK2d/5WyAZ1X0y6kUcMkxqFq1Sx0DYsoQ==
X-Received: by 2002:a17:907:a03:b0:a87:31c:c6c4 with SMTP id
 a640c23a62f3a-a9eefeece47mr487233666b.24.1731140708911; 
 Sat, 09 Nov 2024 00:25:08 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc50ccsm339542266b.100.2024.11.09.00.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:25:08 -0800 (PST)
Date: Sat, 9 Nov 2024 09:25:06 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 33/36] next-cube: move next_rtc_cmd_is_write() and
 next_rtc_data_in_irq() functions
Message-ID: <20241109092506.049f327f@tpx1>
In-Reply-To: <20241023085852.1061031-34-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-34-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.54; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f54.google.com
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

Am Wed, 23 Oct 2024 09:58:49 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move these functions in next-cube.c so that they are with the rest of the
> next-rtc functions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 172 ++++++++++++++++++++++----------------------
>  1 file changed, 86 insertions(+), 86 deletions(-)

Alternatively, move the rtc code to a separate file?

 Thomas

