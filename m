Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B579E77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnik-0001Ak-Un; Sun, 29 Dec 2024 02:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnia-0000Ub-OI
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:28:08 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniY-0002ol-Jy
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:28:07 -0500
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-aabfb33aff8so1455029766b.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457284; x=1736062084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7EIFKUfqXPPhOJYJN1KXzH84tgDNhhwbOVdQrNPcqQ=;
 b=ZyScH4yM2DxTDmDtbyRNAh50hkvw4VbmxSBXpZJwN+6McV9/BDsQrA2iZdFN01AWck
 Ff+UMtvbnReT7T3IfeNQMalbvcqtsxT1Wo3ImDY9KF+ZHh8xcXaNmgYubeFZ3mI0c7e0
 3RhosHT43orRPqxWK9g0kKxne+bHABJJp/R+pM/JpvbHTjAfkocpl10dbnQHaKsZC2h8
 9MljFkGuJFIPV2vjPysPv4CnaZm2sqNYFzLOZRuoNxWNIDO2ot9D+k5EbvYlGYurzMaq
 x+KfpiaYx1TPH4jKv2DxMPuksr3+7e6t/a89VJW5CAEcMX3i6QCKmixoCJwGagHbJfou
 Wx9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmf470l6kH8mYWtakF0FBsSd0FFNZcWukfKPIzcL1PZdCONjRgKMOGb4FRmZ/F4ZfupTzJ+PlUEi+Q@nongnu.org
X-Gm-Message-State: AOJu0YzDI6iHJmtulNwIvXJhJ/tl6jeyynlN/BTKYKuOpznX6LXvfdYp
 uKFM3olaxdBfmTV5ZiTMZVEQchirGH8yO+2ZRB3vxxqov/NjVRQnPuPwFQ==
X-Gm-Gg: ASbGncvkLjwffq7gD4cR4q0U2fmHR2ADH9c7ewAGnEnzJpAXgrqCVBUp2YcQvO0DGdR
 5iiCAexkxBG7SSp4+gXP516eCE7t+zXH6fm3paFlivfCqbj0iT+wti0hJGZT+Qo3aGtArwZR9i0
 3YODY5wLI4HPSShKyakafLl740CAA7D9GyasMQ1+2rvpQyEQMHMlIvm1vsoNRtSZE3okVjCpLvC
 cMUMdiEDDYZR+ZcMowIbuPPGQSPeY37YlmaR1UuDJYjlzZeNOfPXgEJnzOcif0WTU45SorZ+QJi
X-Google-Smtp-Source: AGHT+IGGCEUIQiYpcjeS3rcnjBM/egx2WIJyaoffObhgBPDcjwP4LSJjI/uUtt8K9y3D5YQX4pBiIQ==
X-Received: by 2002:a17:906:f596:b0:aa6:88a2:cfbd with SMTP id
 a640c23a62f3a-aac346918fcmr2377753966b.22.1735457282463; 
 Sat, 28 Dec 2024 23:28:02 -0800 (PST)
Received: from tpx1 (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f0160f8sm1337987466b.168.2024.12.28.23.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:28:01 -0800 (PST)
Date: Sun, 29 Dec 2024 08:27:59 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/33] next-cube: more tidy-ups and improvements
Message-ID: <20241229082759.35a4a307@tpx1>
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
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

Am Sun, 22 Dec 2024 12:59:39 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This series contains a number of tidy-ups and improvements to the NeXTCube machine
> which include:
> 
>   - Bringing the code up-to-date with our latest coding standards/APIs, in particular
>     related to the board configuration and IRQ wiring
> 
>   - Remove the remaining overlapping memory regions and consolidating multiple
>     register implementations into a single place
> 
>   - Add a new next-scsi device containing the ESP device and its associated
>     CSRs
> 
>   - Adding the empty_slot device to fill unimplemented devices and removing
>     the "catch-all" next.scr memory region
> 
>   - QOMifying the next-rtc device and wiring it up with gpios as required
> 
> The next-cube machine looks in fairly good shape now, the main remaining work is to
> create a separate device for the DMA controller and update the wiring of the IRQs
> (including to the CPU) accordingly.
> 
> There is no change to the behaviour of the next-cube machine with this series in
> that the next-cube machine with a suitable ROM image can now load the kernel from
> a pre-installed NeXTStep image and start executing it.
> 
> Note that due to the device model changes this is a migration break, however since
> the next-cube machine is currently unable to boot anything useful, I don't see
> this as an issue.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> [Patches still needing review: 21, 25, 28, 29, 30]

Thanks, I've queued the patches now!

 Thomas

