Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5520AD3399E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SjV-0001GR-M2; Mon, 28 Oct 2024 12:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SjS-0001CO-Bi
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:36:42 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SjQ-0000sk-2p
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:36:42 -0400
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-539e690479cso4383898e87.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133398; x=1730738198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3N62ADahQoSAwncKYGnzp8r+7Qi3Y36Z7Iw8MX7pUf8=;
 b=IVbQcoLOV7GylegDYg1Uccw/lst3jyqBi/vXUvF4AYFCUzr+CGHQDQu0tdpCunTPtk
 a6ispoQWlmS8nvkZCUw9tnFm9ip9bi7iCd8O2/dax9ugJ+/IREEB614/bE0Jn+HMir4v
 QiNDyHdwbFXI/rGYGYoNHJFGORCIrkE4i+oItHrJ5FNpXBP/wy0Vu99g/mSmaXub4sC8
 je16hUtr+n3rgtTIJP3drMzsE/T817tyv+sJkt9M3jB5sJKiwzH3hGVm8xaNLltzR+4A
 6TW8GN/1bBwwTFYj7FwEOGOXQ1Y5oZulHN9kve+KCqIV8MfK73dLTG1SDWcPUVDDLkEt
 xHCg==
X-Gm-Message-State: AOJu0Yzp+j19BnqAQ6QvRGY+7FNlyVd7URdyEXBiDzifUBcGKUzHxsE5
 W4wmBsL2+sAcm07q+8fHec7/F48jDS7AyMEPg6otddSKvVeXy4/j
X-Google-Smtp-Source: AGHT+IFcp6fiuK7iuLhhOBJ8dMhxMunPHOxfg4RwONXeTHSABGxElJgXhipfQ0jErSY2qWmh28A40Q==
X-Received: by 2002:a05:6512:3d8e:b0:536:7a24:8e82 with SMTP id
 2adb3069b0e04-53b348ce9b7mr3362426e87.13.1730133398098; 
 Mon, 28 Oct 2024 09:36:38 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53b2e1df26fsm1126896e87.255.2024.10.28.09.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:36:37 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:36:35 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 12/36] next-cube: map ESCC registers as a subregion of
 the next.scr memory region
Message-ID: <20241028173635.7a69cac0@tpx1>
In-Reply-To: <20241023085852.1061031-13-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.167.45; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f45.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Wed, 23 Oct 2024 09:58:28 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Since the ESCC device exists within the memory range of the next.scr memory region, map
> the ESCC device registers as a subregion of the next.scr memory region instead of
> directly to the system address space.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

