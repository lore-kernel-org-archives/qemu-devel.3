Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E31D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Seo-0006ep-1J; Mon, 28 Oct 2024 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5Sel-0006eP-QF
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:31:52 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5Sej-0000LO-TA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:31:51 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso675801366b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133108; x=1730737908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cr7klnDop923J4Cl6hxB1F3EHLPLN9IjujGKQiTFOwE=;
 b=LhcqFT+3a0xBNIjNCzyyuLTKMc7wDRqXzxwAW1go7pH2vtmf/UidfD+Fy8Mqwl5YVX
 w9VfCrdMtjH8v2zwE9fVNWTXO9wb4siNO8EKx4Oxh1s1/+WlPFAUJB6k7YRnW59DV3dH
 UJ3IDvKVIBIFQ1hNPY21PC/CQHcSQl8Jx1uZpFbZEvMHZsMalHEfrZxzup1r9b5j2DJc
 PsLHqg1UeEeYGQGfakIJrCl0V8cx+mQFzqUa/0DSIOoEqJ9pJKR3/Yz7HFGFmPwW3WMB
 R89lM6C/gLtBjdy8El6NKI+4vQtietC5x0+cuJXjH1bZljGvEevddS0//3K9TEngA7t7
 fpdw==
X-Gm-Message-State: AOJu0YxE7GCfH/1XxXb3xC9ca9WBPPaMXHNmRyveM0kXfaK5uoQ/uLiH
 b6PDBTXnr9OTBaX4FIAGmwN6/cSFjcSrOZWf6sDzzAqAN/UE+iqwUhdXzg==
X-Google-Smtp-Source: AGHT+IHSAzVA08Npli526uJpnucrFgelGbwPaUaZfCqDPLOC5bzQwy/7dPKfiVgq/HIj92bsiDPcpA==
X-Received: by 2002:a17:907:3f0a:b0:a9a:ca1:5e09 with SMTP id
 a640c23a62f3a-a9de5f23b50mr714956766b.29.1730133108069; 
 Mon, 28 Oct 2024 09:31:48 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0298f2sm391566066b.76.2024.10.28.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:31:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:31:46 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/36] next-cube: move floppy disk MMIO to separate
 memory region in next-pc
Message-ID: <20241028173146.4e684a9f@tpx1>
In-Reply-To: <20241023085852.1061031-12-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-12-mark.cave-ayland@ilande.co.uk>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Wed, 23 Oct 2024 09:58:27 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The dummy floppy disk device is part of the next-pc device, and not related to
> the NeXTCube SCRs.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 61 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 12 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

