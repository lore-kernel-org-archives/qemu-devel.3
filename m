Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CE8E677EC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 07:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t78Wq-0002ai-NH; Sat, 02 Nov 2024 03:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t78Wo-0002aS-Iu
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 03:26:34 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t78Wm-00054n-Hx
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 03:26:34 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-37ec4e349f4so1649657f8f.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 00:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730532391; x=1731137191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rai0llbqwDtjVqw61Uu1KRkRB2U74DYIfZtCvJM2jkI=;
 b=ntgXWpj01JWAi+AzhwgVCDcemr5yvYl4d/LnnifyoZhuOyu57uXVHfyI9W/LrlubOU
 IAyB+3WWfB/8tUOZBy523gzBgbXlTPsMSx7lz5rZejz+E8MHDqL1+cOk0ImR0EQSW8ts
 heb7mnMy3PeGwLojbgXLDj2iPv6Xi26H9f88ey4FahvvJvYnm2QsTTzPVmC1+hJz8rLG
 bwMbRWBvLIZAoFb4Xw+v+HfEiLJNJbLEkWOtvw+jzwtRtzq9G3mJ5tc65TnLzEu2WfQy
 UG5lo8IaeFOu+5thTmJYXhBXbKkN6Jsymab6RZ4slZVog8O+uwBg4UVf2ybyf4tN0Eop
 lY0w==
X-Gm-Message-State: AOJu0YxXueSi1YfwuuXW7yeOXywG3Ywxi2S5LFr9s/6JPE5vsgxowGPK
 4K3GLAdpjLYrSizZa5ryd7vQLOLotG41CqDRbx1c5lzY7jRKQ14rB9MLmA==
X-Google-Smtp-Source: AGHT+IENdNW3LZzfqOFsuFCDM5zpkDc/OqqYD+qkMQNMjwO7K++gummMcFYHUSNXufspVUN/4i3eew==
X-Received: by 2002:a5d:47a4:0:b0:37d:4894:6878 with SMTP id
 ffacd0b85a97d-381c7a47dd6mr4777579f8f.10.1730532390577; 
 Sat, 02 Nov 2024 00:26:30 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685308sm83664705e9.33.2024.11.02.00.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 00:26:29 -0700 (PDT)
Date: Sat, 2 Nov 2024 08:26:28 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 15/36] next-cube: move en ethernet MMIO to separate
 memory region on next-pc device
Message-ID: <20241102082628.5998c97b@tpx1>
In-Reply-To: <20241023085852.1061031-16-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.51; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f51.google.com
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

Am Wed, 23 Oct 2024 09:58:31 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move the en ethernet MMIO accesses to a separate memory region on the next-pc
> device instead of being part of the next.scr MMIO memory region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 48 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

