Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A443AD5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gG6-0006vn-MY; Sat, 09 Nov 2024 02:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gG4-0006vd-GT
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:51:48 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gG2-0000s6-KV
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:51:48 -0500
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso3862167a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731138705; x=1731743505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCnQOQ5mwpORs8T3DJCtYUWMpuPeWAQc/dsm2mPtvsY=;
 b=m7+XkESNevLDk2+GvWVFmDm4j+jm6oj+uH8cpXn9GJ8eAOAq0dXKxa2aSTthMz+7eG
 uD7XjGk+a/jywwmgTV+J9fRW6PfUkqWSDWJ5l3QqXAR6vTR0PN4ghl6g1sPJQ0lvxPpo
 OZ/GTPJcSbVZ9eSYi+QbmedEQjpYaOkKFGfibXmmIEdajYw67RE6RowpEjzHx1aw60jW
 as726ejWshyIqYEWByG9aLhemM6tuEWv8VkBr3n24pI3SLfu7AQbYYZrxVOveoCh/eDB
 ZGs9LMTuguObc15UA5Eu0Lu019vmw9zoX5hE912qRDauB6ujvAmdhFYEZcGOXHeHSGcZ
 5QTw==
X-Gm-Message-State: AOJu0Yy7XT4zigGHEBlly72gVnPNRv3ZBixquXCQ5np2eS/o1weU3Nzv
 t9WYGq5d1Y7YJw9nEbVWmMq1K4j6JvEBljWkKNZCToHN+qKIbHSj
X-Google-Smtp-Source: AGHT+IHqsAnwhols5xwSPT/BEIryy03pkeDGs/j122Xz49JkRNqnQ04jj+jUDHF/u4EU0fORbVpiTQ==
X-Received: by 2002:a05:6402:13ca:b0:5c9:45cf:483d with SMTP id
 4fb4d7f45d1cf-5cf0a323567mr4581343a12.15.1731138704660; 
 Fri, 08 Nov 2024 23:51:44 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c4ecd5sm2743248a12.59.2024.11.08.23.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 23:51:43 -0800 (PST)
Date: Sat, 9 Nov 2024 08:51:41 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 24/36] next-cube: use named gpio to set RTC data bit in
 scr2
Message-ID: <20241109085141.04eff419@tpx1>
In-Reply-To: <20241023085852.1061031-25-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.50; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f50.google.com
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

Am Wed, 23 Oct 2024 09:58:40 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This is in preparation for moving NeXTRTC to its own separate device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

