Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D007EE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 05:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMKi3-0002FW-Mp; Sat, 14 Dec 2024 00:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKi0-0002FJ-QK
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:28:56 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKhz-0005oH-6Y
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:28:56 -0500
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so4117436a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 21:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734154133; x=1734758933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0/WhonVpe/IavMDfKL51e3DbdGlaOGK01hLWj0CT74=;
 b=emhdgqqOR1rDOyoPG9azevrQJ0RoEHA4qSbVVl0F94dQAWEj18sEyHiAqR4UCRNUoz
 ENH8cCkj6XCI9VwSmIlMlVC7L7tx0Urp+rE0o4yami1LuzmYWYC4913Tdmj146BUF5gT
 nU4eUCn2WQgeONZAMKUzqvTpQLJJ9fePGdAIeqh7KKwzfz/Zf18sleGs2NI3L603/Kjz
 0zTPDpLOSU+zlSE3Ye4G17eFu6cO8+gxfQ7dt8iBfIYn0Sy9G3AEAKeMW4sbQ0O/5oU0
 z2roqfuslDZkc0Z5PBuimxM3bBV4aP4CbeTsWQZH2khptUXHyQ87QCqZ72gqyOL/+B0u
 zNSQ==
X-Gm-Message-State: AOJu0YwY5iftzCAz0DcHVWkCEwrqOkYAlstGoInrUXHi6NYVIv8fI+DO
 inE6oaz4w9NtOqV7GWzCWR+FtteRxVszXd7feIvaNPNKInTY/kqtvqClWA==
X-Gm-Gg: ASbGnct1WsxgsqQ6Wc/UHUgqBKClQtoBYr9GL4XVp5qz7zqqC3RNCmboquimEmbeZ0k
 h/vNSI7bYZCUjNPwogrmEPXfY6CEktWIPKhWb4ducSiLvYPST9dggEsHGcjSLqIgs+BQ9ny3hXw
 qBqO+FZXeOAHzkxc9ewErx5eX6Vrrp7W/eQbmlg5S+jFk0q6CK2jqxReh6QLTS6Dkzgd8N3smpp
 BkVHRnsD4sWjRJDAqmA9PxRfVfHEfsMO5vvU5MYanVmjHSHhEs4CAJI23OdO7kCv0w8pf86D31u
X-Google-Smtp-Source: AGHT+IElJ/dpBpZWB0V6gh69Qei3GFFGPV+FxhwhrmXpnALX3vftaB2jnGBNddGCV/eZqYplVMlSaw==
X-Received: by 2002:a05:6402:40d4:b0:5d0:ed71:3ce4 with SMTP id
 4fb4d7f45d1cf-5d63c2e9060mr4207787a12.6.1734154133331; 
 Fri, 13 Dec 2024 21:28:53 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f25d6csm578238a12.67.2024.12.13.21.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 21:28:52 -0800 (PST)
Date: Sat, 14 Dec 2024 06:28:50 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/34] next-cube: move SCSI CSRs from next-pc to the
 next-scsi device
Message-ID: <20241214062850.480546a1@tpx1>
In-Reply-To: <20241212114620.549285-8-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
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

Am Thu, 12 Dec 2024 11:45:53 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The SCSI CSRs are located within the SCSI subsystem of the NeXT PC (Peripheral
> Contoller) which is now modelled as a separate QEMU device. Add a new memory
> region subregion to contain the SCSI CSRs that simply store and retrieve the
> register values.
> 
> Add a new VMStateDescription for the next-scsi device to enable the SCSI CSRs
> to be migrated.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 88 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

