Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2873CCA101A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 22:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk9iS-0001L6-W6; Fri, 30 Aug 2024 18:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9iQ-0001Ca-3Y
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:03:34 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9iO-0008U9-Li
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:03:33 -0400
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5c210e23573so2389422a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 15:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725055411; x=1725660211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0/rM2RuaCtjsOHMS/1iqX8W/syYLOHfrFN8B5ERug0=;
 b=PWKGs8Z9KSifyYpROTXg4rAiYKOOYDXEUzPU/gZ0xYopIAVDK7xOlwg1f+fI1l6RXg
 FK86ZakQUwIn4CtmTes0PzcH1KmgDtpQl77XvYED2dPnV6FW/LkCAR8pEtvK/dDceq72
 O7O/uiE9/ARu0V0yneCKds+xdS1bDM8pCHxJcuCufXLBwGgMGaDd17DiHBscSv8b7S35
 Lh4xz4cnCtUl2/UAuwJMRbl3f92oE5CdJ1Qh6EhUaReu12MeuqkAJo2ovOpKcaC5LD4X
 pSxnod784Vnn/2u2G8tVg3osD1epxReBJ088YYkzS8bVmfqW1GL8Cu75oL9aVgIVuPvG
 SmkA==
X-Gm-Message-State: AOJu0Yzta6Lf6w8GUdRO9LX3RIT0fhYtkKz8sJGK4CDHfDQmqhW4fv7L
 +TXXK23ezIkArFNCRClIEg7ayPKWjNcC5KV7AngIHo2NMQHj19xt
X-Google-Smtp-Source: AGHT+IHWYPHEM95eq37J0CLzXo3PrE+vGiL8Qan+RTrMyGAXlMykrc2VzDDh5bQGWUQ64xKZFBcfxw==
X-Received: by 2002:a17:907:3f14:b0:a86:a866:9e44 with SMTP id
 a640c23a62f3a-a897f1c576amr593308466b.0.1725055410515; 
 Fri, 30 Aug 2024 15:03:30 -0700 (PDT)
Received: from fedora (ip-109-43-179-35.web.vodafone.de. [109.43.179.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f6c4sm258574666b.68.2024.08.30.15.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 15:03:30 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:03:28 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 3/3] hw/nubus/nubus-device: Range check 'slot' property
Message-ID: <20240831000328.32af66af@fedora>
In-Reply-To: <20240830173452.2086140-4-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-4-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 30 Aug 2024 18:34:52 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> The TYPE_NUBUS_DEVICE class lets the user specify the nubus slot
> using an int32 "slot" QOM property.  Its realize method doesn't do
> any range checking on this value, which Coverity notices by way of
> the possibility that 'nd->slot * NUBUS_SUPER_SLOT_SIZE' might
> overflow the 32-bit arithmetic it is using.
> 
> Constrain the slot value to be less than NUBUS_SLOT_NB (16).
> 
> Resolves: Coverity CID 1464070
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/nubus/nubus-device.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

