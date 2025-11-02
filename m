Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE1CCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFbvm-0003GY-0E; Sun, 02 Nov 2025 12:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFbve-0003G7-Vw
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 12:31:47 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1vFbvc-0001Jw-D4
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 12:31:46 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2956d816c10so9502755ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762104701; x=1762709501; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=5s3LOLBS75BZVnJh6WK8e5VzJ8/4jT9ApBG9Ud5wTBs=;
 b=WzQR/Xt9gdu8m6jmxX8g1Qx4S0CsmFjHfSCL12FUWg3h1P1Lw0bvKPvPEdxSa5zUAi
 VUWbvmzIU0xLj1xwlJ9mjI3EmlC5vjmy3oZUjL3o4yZylcClxRJMBuQtmb3FDkXJWutr
 4c5aNj3WDqC6r/d5AGFYzxjW1rlg6QTnvDgbOxjuYk6ylB25fgCTqUXbSqi2W8a3HK6Y
 D/0+yQEzB0cqNRSY+Vd69US6E/5jyMg2QkhYnFb0JcO7FYjffqh4jCjyATthQLJtaBxM
 tDbu/p587yglgpsZ1PbXEiHwmRe82suQY5/A5c6rcPueFwC3zKkNbaHsm74sawWncy+b
 4KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762104701; x=1762709501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5s3LOLBS75BZVnJh6WK8e5VzJ8/4jT9ApBG9Ud5wTBs=;
 b=L9q/DP/OxffUmAVdag8i9+hBeFVycgFqZUpK4MV85Lj0fsVc+I6z/uHl7fEC17O4X4
 IRatXr68IgU2Lw+yB3kxC9fAWupzgAuQg3+EgeNH6QvihqORQrGoucYiOle4wzD1XLnv
 Y8W4Qsm38kfeebTBiuXEKFZE0Mwe+dZVdwRtclXIeqb/OCg6uPCzMVFGF/ju+4aaTvYE
 CVSCNhBCSoXODbclnN7GhQ6hogo0nnUMZb74lM0esOVTzxNFxjlOkKCnk7ZB0zY5bmaN
 n1hB3ejyCC453zdw1laEf4jw7ACWj0EK6ifp18WoV7VEe6KUFI+n7OUdll7p0arbDQKM
 ATtw==
X-Gm-Message-State: AOJu0Yxi0Pwz7rhVIEmvJDultU2gr9ernYI4vQqyfDFZsGNf6iuHdXke
 3r8Vsm3Nrkut8m6hcpZWWhB9ovxJvt+OXUoPlpLPvyulrxsOszcet77K
X-Gm-Gg: ASbGncs0vy5Q006VkWxqOPysWKUnE5L2R6muA+36bpKmHDl7JWBa/pAWdGGuCVXQGQ4
 B4WtIrbLe/1FULnbH2usibbR4sj7Uto6A7O960zFzwIy+3wh5jWlRiPpCWjQqfJVApu68iD6Ux1
 mIFK1y2soCOPKuwWb+hDGKvsNzeEHkPd2AJwgafxicoNS4RZKQdfT2wcaTb1gnHirLZlysrZCcz
 3jIWdgz7x/MqF5AJtMcoCWqgnfZqCtx4i/bSvXSlI1AGL0juEepItAm3YLgcc+YVYfg1IDIaG2j
 H7JvTCLdXu8mcLTR4Kdzr8FW9h/qOjyG2OwutNsYFQtcn87ZSCCRv1SN3hJ9hLk6zokI9ctR9JP
 6ppHNbXHV/peFRtqPq3yqVzNdKvBmGgJJDA1y0A3Uy9pOSbYg1lBWyhmIrjyw+KUNiKOMSqyftE
 xbTthA7MZTUgYADZj10w8tJTg=
X-Google-Smtp-Source: AGHT+IGbQ9ok41cFKpzKbShjlnGaPlK8rGpxpuwSPiqMDJYtiE3ZfTf8sw6ymda9J+R0bv8XpOLBNQ==
X-Received: by 2002:a17:902:eccd:b0:295:32ea:4ce5 with SMTP id
 d9443c01a7336-29532ea502fmr100007835ad.6.1762104701355; 
 Sun, 02 Nov 2025 09:31:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295268b52dasm89957865ad.38.2025.11.02.09.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 09:31:40 -0800 (PST)
Date: Sun, 2 Nov 2025 09:31:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, deller@gmx.de,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Message-ID: <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
> 
> Enable the i82596 network chip which is included in the LASI
> multi I/O chip. Since LASI has different start addresses on
> the various machines, always initialize the LASI components
> by their offsets.
> 
> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Changes since v1:
> Added proper Qemu device initialization for LASI
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Signed-off-by: is missing. Other than that,

Tested-by: Guenter Roeck <linux@roeck-us.net>

Only on 715, though. The LASI Ethernet interface on B160L no longer
instantiates for me after the SeaBIOS update to version 19.

Guenter

