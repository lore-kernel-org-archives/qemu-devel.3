Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A97D5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gJr-0007zq-Dd; Sat, 09 Nov 2024 02:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gJo-0007zU-0s
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:55:40 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gJm-00018r-KH
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:55:39 -0500
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso456974866b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731138936; x=1731743736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSqNzxRYdzO784o8DQtzALubth/P5Kt8AGLsTKOgWjY=;
 b=SKiy2g3fq+tWM3UA4nkO35PWND4mEQIi3qTy6jc34HfgeSSFohSrm6rpQFAgTbD/qa
 ufgJGwOVuvIxbnOeUI1v0AhV1qf/QuEq3n18m6KfdHxftttvG1hoU9w+PZDC5bV07gsY
 k5fn/bMI4mQv+hBX5BflOGTkFC93t7Qun95F4iRLSX0rOHi0/jj6UsnKUkWE8E0zy7Xj
 ExuWZxDwaxDPHPUj6FCkiS5/b6Ckc452gVb/ppkW3LGyH8X0zJb42w8CkAUTNibBvRSE
 kGUP+yLJGdtz5FQa9ITbSMqUoUpCYpr907v9FF+dP4lpuRLoFIITJbV7R5Z3QqSzz+FC
 9BCQ==
X-Gm-Message-State: AOJu0Yy53AJXStBfJ5RFDod2DbZ/urijkGLmt+k2E3PA+Jy3Y/T+4Hxr
 dXZ3tyd1usuyj42JDuAXqspmf+1kXlLXFYfYGtiJMHwJ6T3/emFcPcxEsezt
X-Google-Smtp-Source: AGHT+IFsqsg5ciQJjKgybI/mrhf9oYFm757FQxEB3rusK5tuayE808yZQN4T4Hd6T4wnvoS+9Q2cuA==
X-Received: by 2002:a17:907:3e9e:b0:a9a:8674:1739 with SMTP id
 a640c23a62f3a-a9ef0008cf0mr483868766b.53.1731138935677; 
 Fri, 08 Nov 2024 23:55:35 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18854sm337800166b.29.2024.11.08.23.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 23:55:34 -0800 (PST)
Date: Sat, 9 Nov 2024 08:55:33 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 25/36] next-cube: use named gpio to read RTC data bit in
 scr2
Message-ID: <20241109085533.258e4e25@tpx1>
In-Reply-To: <20241023085852.1061031-26-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
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

Am Wed, 23 Oct 2024 09:58:41 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This is in preparation for moving NeXTRTC to its own separate device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 169 ++++++++++++++++++++++++--------------------
>  1 file changed, 92 insertions(+), 77 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

