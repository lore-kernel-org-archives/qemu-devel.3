Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247EDD1118C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 18:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7fio-0003Mi-FI; Sun, 03 Nov 2024 13:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7fih-0003MB-8A
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 13:53:04 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7fie-0001dj-Rh
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 13:53:02 -0500
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so2173399f8f.3
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 10:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730659979; x=1731264779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=briO0I5e/cdEHNGsEhRKvGrHxg63TiQSKUdpDFmit7g=;
 b=OZ2R9KJNZPe4GpZ1M+ZYwpSI3TZL06x8pG3aBv6XtZrkLAG0sPeaXhJc4HnvCNntpz
 Rqa5301Vw6jIvsrL9AQZD4dSLAkwHE06WD0KiERijbHvpTosvg3eiF+Tn+XD+a50caiC
 v4MtFBgsR1c0LYMo8QkhhX7UgR7tE+wMr39X7ktvy6ZloSA2mSIeVZPEgfZHRMXuLLRd
 4ig4fyawguVbk0rTiW4/Xfnq7AIcpjBHOIzpoZkMWcuyDOsHv8zMo9cANUWLhgonKc8X
 N/s6+/2CBuhO6xel+V0QZftSutUwEsJ+sgJJ29bP0pGjklxO2gY45jUJ3VheA9f4UDep
 dgww==
X-Gm-Message-State: AOJu0YzXgHM+vMlcS9MdVJNQD8wYxOoDbwahSO0JlygkaOaUpe9D3mBh
 4oNSdOGZkoUMOJbhjP0tjXFOgJEBZ47RmHMsGhhmdrJRmYH0FxZcnOEHnQ==
X-Google-Smtp-Source: AGHT+IH3BuOaZE6usJCQBxXberuGHMCq1w0fza/egBFwz5byq0PkMIGSphgEJkXSbT4LBoC52Hb6xg==
X-Received: by 2002:a05:6000:1c9:b0:37d:49a1:40c7 with SMTP id
 ffacd0b85a97d-3806115a20bmr20871318f8f.28.1730659978565; 
 Sun, 03 Nov 2024 10:52:58 -0800 (PST)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b32sm11245845f8f.18.2024.11.03.10.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 10:52:58 -0800 (PST)
Date: Sun, 3 Nov 2024 19:52:56 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 22/36] next-cube: separate rtc read and write shift logic
Message-ID: <20241103195256.72e700c4@tpx1>
In-Reply-To: <20241023085852.1061031-23-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.45; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f45.google.com
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

Am Wed, 23 Oct 2024 09:58:38 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Introduce a new next_rtc_cmd_is_write() function to determine if an rtc command
> is a read or write, and start by using it to avoid shifting the rtc input value
> if a rtc read command is executed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 138 ++++++++++++++++++++++++--------------------
>  1 file changed, 74 insertions(+), 64 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

