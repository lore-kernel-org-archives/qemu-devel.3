Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6017E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 05:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMKlJ-0003aE-4P; Sat, 14 Dec 2024 00:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKlF-0003Zd-HE
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:32:18 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKlD-0006AD-7l
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:32:16 -0500
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso2877234a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 21:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734154333; x=1734759133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3SlfIrSElHvSJS8sCPhnUBbm4Mq3+boU/m1JKaoe4Q=;
 b=Erl8+yGfPGwjaxwzzNIWysdg5NNw55+yx9w3hNzl2rFDzhksKYCgoEy27gpwhtAzjj
 Hy7ZztCnWJeejcGPjnRt9lJ2gqBW1h8ufDedhIytj4wFFDVh1dZl5u3PsKIbaOJAnwWr
 KVTX0OdG8t6Ew9TWeporHF79qRngJUaMObKa6luVyA1m+k06DNsjSAPUpme4+aOcH1wP
 8kTixl8oL52Mn+zPO55+Id7T1CmtHtmpmZ2xjOfOdZsy2zVRVIIOXAdD+oVj5ixE5RiF
 bFg6grfhRdI4jYcXri1JrHZtgp0GpYJRhNh8w5UCkWkNI028OEHAEQs8MS7Fj2ua4AIL
 kTMw==
X-Gm-Message-State: AOJu0Yx6TClEIQTDoJdQm9o7MFyqSxb89EX++Pp1DKuvrHOlaxxOFpWk
 QP6db3tgftYcDlaexRTpTkd79ug7vQXY3zuC/1ZoeOkuCnpwu+Nn
X-Gm-Gg: ASbGnctR0IABgXaBSplfFtPZBVGZ5E/smes+rzif22e3LZ6JeOFy+T+RL244RQ1wRaC
 8GXwZc+RIsNvdO42KGp2MRxtUVBBM0Tn+dNGq8YF87xIVZQMk43k5MHmtxSD1aShj+tuXn+MGMv
 wQ0JLeDYIfBGqDaID1xID/RAokpRpfq4z6yZyzsw5+ylMc9tBR2JEJSEZDEIFeJihmgFnvANKbm
 +d1h381FM3VHMdShjDPTTa4m7oGHoA+fvsBTRWJsPsaSUFnCkFvUeCE7Zk/3O2DK/Vim+d2JB61
X-Google-Smtp-Source: AGHT+IF2AvGlci96PhElqZ9wfdytiXpIimf5SNLu9sohsUAQJfdG3gb0b2511oMm7nGpOpdAsG68sA==
X-Received: by 2002:a05:6402:5389:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d63c31936dmr12663982a12.11.1734154333513; 
 Fri, 13 Dec 2024 21:32:13 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9638ec48sm50696166b.147.2024.12.13.21.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 21:32:12 -0800 (PST)
Date: Sat, 14 Dec 2024 06:32:09 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/34] next-cube: move SCSI 4020/4021 logic from
 next-pc device to next-scsi device
Message-ID: <20241214063209.66539045@tpx1>
In-Reply-To: <20241212114620.549285-9-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.43; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f43.google.com
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

Am Thu, 12 Dec 2024 11:45:54 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The SCSI 4020/4021 logic refers to the offset of the SCSI CSRs within the NeXTCube
> address space. Due to the previously overlapping memory regions, there were
> duplicate MMIO accessors in the next.scr memory region for these registers but
> this has now been resolved.
> 
> Move the remaining SCSI 4020/4021 logic from the next-pc device to the next-scsi
> device, with the exception that the SCSI 4021 register now returns its previous
> value like a normal register instead of a hardcoded 0x40 value. This also matches
> how the registers are implemented in the Previous emulator.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 139 ++++++++++++++++++++------------------------
>  1 file changed, 62 insertions(+), 77 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


