Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C689AD5E144
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9ghU-0004cG-Rw; Sat, 09 Nov 2024 03:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9ghR-0004aD-6B
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:20:05 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9ghP-0003EJ-5G
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:20:04 -0500
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso458984266b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140401; x=1731745201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbEp0zCyqU42pzn3ZwGoUhQCeI7Pl31wiMSGT0QYNJ0=;
 b=nFDMgsfpz8qkl1H+6T3/NqrcEmpBgEn8ZTvSL0TkFPXn0ybeDih4VN8yQN9HF+3I15
 rNSbD1nFc3IVou90Vh+C4f27afeTyljgnjBoB8VKiuhuOA41Ak6MOA9ccTK7us6aLUiH
 lErS90tUufe6XYOV0MAid4ofi/a5RgR+WMDIs1IbSEeceN5/QxemIHb2u0Kl311Lj0Ut
 4ZksNzYv9aKnSe1QWo0o8V269MradtkLCHFokLrcvd2fqN81gscDltvpqcd2+j1907nZ
 Rv06jCwBbKPd0r3czI8RmSwFNY6WSO7iny9KPYVbX/F9UTqH1b18HdYuQ9ONPe63Ib0v
 AuCQ==
X-Gm-Message-State: AOJu0Yx/AAxcg5h85GUx3XCvuz0Y88y/xI/S5HVf4XG4lUoF6xG1t3mZ
 JN3dRvONrDC9wqptISP0TVWIbfArz/KGPHGv24t70yUi7E8SeB4a
X-Google-Smtp-Source: AGHT+IHLX5DFe2zW0muF3Mf37OnurxyA6y1zZnRHlp6/Vtgh+D3kmUwGudKnilw9asOkMzuonRpTkQ==
X-Received: by 2002:a17:907:3e1a:b0:a9e:b08e:f766 with SMTP id
 a640c23a62f3a-a9eefe9bbf7mr514610066b.10.1731140401166; 
 Sat, 09 Nov 2024 00:20:01 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03a26cffsm2795932a12.0.2024.11.09.00.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:20:00 -0800 (PST)
Date: Sat, 9 Nov 2024 09:19:57 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 28/36] next-cube: move reset of next-rtc fields from
 next-pc to next-rtc
Message-ID: <20241109091957.698c147b@tpx1>
In-Reply-To: <20241023085852.1061031-29-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.42; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f42.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Am Wed, 23 Oct 2024 09:58:44 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

