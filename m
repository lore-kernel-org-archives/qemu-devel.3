Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECECD116E8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t51vH-00035J-Uw; Sun, 27 Oct 2024 07:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t51vG-000354-35
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 07:59:06 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t51vD-0006Xu-1L
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 07:59:05 -0400
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso6655239a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 04:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730030341; x=1730635141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIVasYqKSblP9NGl/P7eCRWaDfIs5V2nTWzWd0Sz4rI=;
 b=OSD8aBnq75fkWg04tsGIGX/51RgtwcGw/9j8GvFzpw63udg2hLVg5xipZYmKyV9vfM
 K5+fMSy6aS3lzBnglXdJT0qkq7sCE1+ahyzf2rN3tD73Q2nGvs/zR5PXhfFqb/yby+Uc
 FodeKWeXLLroMT/cORkR2ypCxE3qp0+Ve4KXAiO/U+EDUeUTnfpRyvYyjB+8iPm9Q3H1
 nn04CrL1T64iQDNe8hjcWfKA+b10TpjOE/p1qtSW1RpiVxsCOvXukrncvKye/Efku25Y
 ntXJKMvg6t/MGPgWhKHV0XTRE/7mxl5czLPMNrj4s4TcmkVTiqcNB2b5+whbPJUfN2qa
 2dnQ==
X-Gm-Message-State: AOJu0YyhVtlzlius90j3AIEGKZtbhCq6xZVP/bwjQ3gl3SRXb9TJauXa
 JNZ8mFUMFzsHE+c4bkEhvuLCZFTgNMPQOfOLE8tRdK2WImBeKQqm
X-Google-Smtp-Source: AGHT+IGlH5b/+eYqqA5NEx/BfMH3+W2vTjdo85/dWOXq3z5uYimVwWLMe97zoFbayDIllS+qnhzgag==
X-Received: by 2002:a05:6402:2789:b0:5c9:7c78:4919 with SMTP id
 4fb4d7f45d1cf-5cbbfaaa664mr3901162a12.30.1730030341284; 
 Sun, 27 Oct 2024 04:59:01 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb6255c74sm2318409a12.4.2024.10.27.04.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 04:59:00 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:58:57 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/36] next-cube: introduce next-scsi device
Message-ID: <20241027125857.6f03068a@tpx1>
In-Reply-To: <20241023085852.1061031-9-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.49; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f49.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

Am Wed, 23 Oct 2024 09:58:24 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This device is intended to hold the ESP SCSI controller and the NeXT SCSI CSRs.
> Start by creating the device and moving the ESP SCSI controller to be an
> embedded child device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 93 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 74 insertions(+), 19 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

