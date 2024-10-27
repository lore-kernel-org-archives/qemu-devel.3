Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE6D10C16
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 10:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t50Ax-0005j9-9k; Sun, 27 Oct 2024 06:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t50Au-0005im-Ck
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:07:08 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t50Ar-0000gv-9Q
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:07:07 -0400
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so476526966b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 03:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730023623; x=1730628423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JBkHBkBTn+xLdFJgcE/bo400NVJM1YHn8lUs6xePI0=;
 b=Q/VfeCdRdJ18pEKH3QyE2TptEknUTB96iXnrxKvJDCAL93N4n9BYgKUax7WIA0C4GR
 fNeOoEWvqFj7aLPFEE4lD4KIb5lEUAJlbXPpUx/QBbEhrBYwJdDJFCkw3aQDn0/DH66P
 ZyiSb9AUEllQjQ0w/KNt+n/7qWnGBOSVjaHgh2bqQuHdQ/qd16ZETBbv7N8hkxn7ZWYQ
 iCMZl2/2phD2KJZhwkVbpCN9YIqKf6gVMIC26nLAirCJKB9uR33brx9u1CJTYb/tqb0d
 K+zaitbHKbLalfE8jMUAezYOGSG0EJhZRx5GG1G4/+dm7izZjvAFPM9SxmKQQ9gjfUfG
 musw==
X-Gm-Message-State: AOJu0Yz0x5KQfY5f//zEeZlFGv8GkK+GzRJuLEeNM3hFjdO39VnWWDIQ
 /cesquCkg6IXg82hFNquNywAwDZeYAFhCSED9PaLbJqf05S6XBONFRzn7Q==
X-Google-Smtp-Source: AGHT+IHZNzTQXrmLHTWatAByLPOX+dyaIpxSVkHmt2mWrTJVT0FtQskSN9bSi4ERZLF2lLt8PEhV/g==
X-Received: by 2002:a17:906:c14d:b0:a99:e98f:e73d with SMTP id
 a640c23a62f3a-a9de5ee15f8mr402969366b.37.1730023623089; 
 Sun, 27 Oct 2024 03:07:03 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629d76asm2228092a12.23.2024.10.27.03.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 03:07:02 -0700 (PDT)
Date: Sun, 27 Oct 2024 11:07:01 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 06/36] next-cube: move next_scsi_init() to
 next_pc_realize()
Message-ID: <20241027110701.6ef54acf@tpx1>
In-Reply-To: <20241023085852.1061031-7-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.42; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f42.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_NONE=-0.0001,
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

Am Wed, 23 Oct 2024 09:58:22 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This reflects that the SCSI interface exists within the NeXT Peripheral
> Controller (PC).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

