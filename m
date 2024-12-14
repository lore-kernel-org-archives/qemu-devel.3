Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CBCE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 05:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tML2t-0005kH-Pl; Sat, 14 Dec 2024 00:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tML2r-0005k4-IJ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:50:29 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tML2o-0002Ik-F5
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:50:29 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so4153702a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 21:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734155424; x=1734760224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJ4IWLbtfLJGzZRDsq5WGLRrMUdi8HdsFnOfuqxil/w=;
 b=E8CedTIU0sS4SmzkXluXpukFDBknC7hNn3xh61Px96JKe65twFAyFcpIXgCKNaXHnd
 tFhjC5sKO+DldxxiRRPc626REeZ4Ur1xa5BNFFfdonyfBiu1yUUxBcisB5L2eOCoLB9v
 pCi+UETFwmKVaFJIPKrS8ggqt0C6Z5z5Clrc1Rp5b/dba8klPCICJSFPB+JvSA8CK9JO
 SrdQbmdvzK3mloQl/XboiWquJXiKUstlr2tb9dLYYmz3cSErsgf/OPUbjq19gnqErwPI
 ru8BgViJ4+tzcWXyrSMkh6KrqTuHLCAQIiyAPNuWVWRj6WeMIs2rG1RByBqLx+gIxyg1
 RS6g==
X-Gm-Message-State: AOJu0YxMj6j1TWDIKKz5wSI9kQ8GF5t12a6NfFDlxc5CNAlXILtquJlQ
 FVE1RejZr+2W3lvazx7ugsdgRuL8OTKcfsxSFMeA3UJQv2cywxrIBFAX7g==
X-Gm-Gg: ASbGncuHz54Q/deQPdDuE3kTxby0efI05Tzq0dUA+00Hs9D1+2xXUfICvgU1ZwGYqan
 LBnTimEcdT6f4Bn6afxM4BGg/3vxiRAvU8SAFLLo2hpXANnQmah8PNPYlAC9apYjJ2/Yy5gozNe
 eRA/fg+hy6KuCiGqSvsRDbsL2Cy1mmCf1w4HJ4suDMBvdu2LWthXmqb1ZfQiZ8SRJwhZZ8RE46z
 F0JoTlZ0eYBvHYwLqgrclW36AJz9mP/cwfHK4J7h0lqPyicW5cUGpcKE6hoAAdlgIXmb8xlDaw6
X-Google-Smtp-Source: AGHT+IEPKQ+QMW6Hh1bOOkEjO0BZZcJmLZZXmoBUcumr6QS0bmqq08vUwYavpe17L27e/SLYQipzFw==
X-Received: by 2002:a05:6402:3898:b0:5d1:2440:9ad3 with SMTP id
 4fb4d7f45d1cf-5d63c42a6c3mr4932971a12.30.1734155424339; 
 Fri, 13 Dec 2024 21:50:24 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ad15bfsm591812a12.19.2024.12.13.21.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 21:50:23 -0800 (PST)
Date: Sat, 14 Dec 2024 06:50:20 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/34] next-cube: move ESCC to be QOM child of
 next-pc device
Message-ID: <20241214065020.4a3b274f@tpx1>
In-Reply-To: <20241212114620.549285-12-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
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

Am Thu, 12 Dec 2024 11:45:57 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
> of the next-pc device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

