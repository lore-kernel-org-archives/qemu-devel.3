Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8EACFB422
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z7b-0003vR-AQ; Mon, 04 Nov 2024 10:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7U-0003qb-Se; Mon, 04 Nov 2024 10:35:57 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7T-0003kB-3O; Mon, 04 Nov 2024 10:35:56 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a5e0bfc7fdso12814145ab.1; 
 Mon, 04 Nov 2024 07:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730734553; x=1731339353; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=hKvgXly1z1CaicGb+6SpfFpA2C3l1HDrjzMFn85ScT4=;
 b=mIg9uBdIzGVelfDFzAbeJv1h+Udt/SBSJJkSV0B4hiAToRkqeCDXbQ4LskuNhjfait
 KPhpjomsHgI9zpV8LHapEGJ7QwrDp3GupHfV5yrd+5Q9U5yGY88MMEAe2FfQp6xaPqnT
 4G9ni7nsyYBbbSZLpxrQLgsgvSWWZvo/+VEsfNl5wyoMa308TtES62jeCpdKyU1Fou6X
 mlXacwjJVFLOkLyvvcjrHgIPi4YaNNusLnn7cLflhHFI8a58TxHC8qqOQrrddOnCWRA4
 mq2DXgjdclIzWrx4GlMuNYNAozxFHfu+aM77g/mUC3+ABtwHO3/zwqSMshwwzuCw7sNa
 SKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730734553; x=1731339353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKvgXly1z1CaicGb+6SpfFpA2C3l1HDrjzMFn85ScT4=;
 b=UVZYYSCbpV9a0hOP0PZuB+8aPTPulZoC9Ohsz0q5svh5KMv5jcFXGZK3zPPtR5TwDU
 3JYCJy+6oTYcqjY21uGvxbXFv3aisCAnKts6EGI8VZ5QEALJV5UT5mTKFQ5CbP4IjJ+z
 b4GySCqJAJeLN9wcKouEg7b3J1bK13r4YTYChOXxdRlBdSLW7nzARBmBwEVUJzmGplI3
 Gx+xDuGsjeivyiwo4Xp5NRNOvv4lsykFsTBvIDH0Cx9vzn8I94JFLiYt7wqJXTfuZIlv
 IL2lL4wffi4vmSWH93TXIB0m7tKqZWT1v6qDgZgiKa9oLxtG3J+xFQfOq9TkX/nDVkNc
 xWpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1+WQ9EmYx5kLSIY9k8XoFeVKZmZXhOzq5Io8q9/yBls9JYL20NLD6HqKMRlHdHmMlY+I8E7WSnw==@nongnu.org
X-Gm-Message-State: AOJu0YyuMF1IRyB1thDUHUUGDhCXb4juMjKZqrp/UW66yAUuJWmg6yjR
 N1ZPZaFtAzYu0U5yvdXnruEjaSAqG94Mo8L7u1/Cpgb8JmqkkZmR
X-Google-Smtp-Source: AGHT+IGpdVC1Ozn+O2rIdUVsIy8hpuiDCbZON6f+xFRrnv99Tr+k4/glI11TOyt1FTXh0OAJ0INF7w==
X-Received: by 2002:a05:6e02:20c8:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a4ed305e5cmr270585045ab.23.1730734553540; 
 Mon, 04 Nov 2024 07:35:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee452a8b4asm7147377a12.20.2024.11.04.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 07:35:52 -0800 (PST)
Date: Mon, 4 Nov 2024 07:35:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/5] hw/net/lan9118_phy: Fix off-by-one error in
 MII_ANLPAR register
Message-ID: <e5cd7dc6-b35c-4ecb-81f8-413294e42924@roeck-us.net>
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102125724.532843-4-shentey@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=groeck7@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Sat, Nov 02, 2024 at 01:57:22PM +0100, Bernhard Beschow wrote:
> Turns 0x70 into 0xe0 (== 0x70 << 1) which adds the missing MII_ANLPAR_TX and
> fixes the MSB of selector field to be zero, as specified in the datasheet.
> 
> Fixes: 2a424990170b "LAN9118 emulation"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

