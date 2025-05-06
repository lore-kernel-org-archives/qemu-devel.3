Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2D8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 03:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC8u3-0001gB-A3; Mon, 05 May 2025 23:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uC8u1-0001fO-DG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 23:23:29 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uC8tz-0002qw-Ks
 for qemu-devel@nongnu.org; Mon, 05 May 2025 23:23:29 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c13802133so1297310a34.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746501806; x=1747106606; darn=nongnu.org;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njb47W0vhAtLje8FjaPe1bsO5O4v0DdC04nQs7Mwt3I=;
 b=DUFJhMSYhS7E7J6dMcqIMobAJvzQMavMwKpm3Fa7Vb18MWFGaIuVoURL7S87tKiOJj
 Ft0d01K1Vj6vQ9T7OF4o4PdvvENLhOLL7HkM1WMQhhKZB6OgEEtbPBuOE4Vw323uis8+
 gDphZRbd3em5nQsmD0b2ZNqHkkrmb4/h14/24Q+F9G9JvzmFHsHkfzsFmOtMWwVeT4rC
 sTIzpuVfMDEXIiuc2MZMzNkGXKWEojJHp6PHUb/uQHnvKVQiVN9F6Ai0yDBOsfHBIcve
 wlIjPU2PIRWJ/T5am6+F3b42kE6YAodrFSg7/ZqUmQU6KPrKi5ccq5J4iQ9ilW5DM3ph
 zbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746501806; x=1747106606;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njb47W0vhAtLje8FjaPe1bsO5O4v0DdC04nQs7Mwt3I=;
 b=mlUDNNPAze5bzk4+eYfUW5QHGkRzZkpgfDfvGQEr93VfqB053sMYIEq/GLQN+TVeWC
 4BeoKq/MIayvHH6XJZcznmkiGYKwY3UnJWxDeXl/P4kcw3L9BMuqsCMrmrVaYGyVahFP
 FB74VHRuvWCggsI6KqvNLvK8j2YWHapkrxWIvJNl66AIUVn75gJ5lk8YKj494UsJ4oaW
 Ty4/sRBUU46owSEnZbFcaCbKkJLzTGfn8UhMy7/vdhlPjnaHBCyRWIfnT+LrCM/YkQoS
 3/dIGtzAHvyZo/rRqD9gFAz2QIbHhdWdsg01p8CZMlJ0XPRerfABN+2bczb+QxY6Xki9
 WrhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQDswIAHV/A953/6suzHea/Tn+KalNzxf8bmXA7Sagt/nXWBHrcFsjDyXqdsB/CPbg/gKq1pMmzRbG@nongnu.org
X-Gm-Message-State: AOJu0Yw11nagbeo/xYutVDDfimdzXGK6rfZoAXDcaRk3jE4KuEQTu8/S
 l837fO2X5Xa2p46gTc3GEYjikVNugp/U6d0bdrpoI2LvvEhjKdxr+YwWOScqxwRhtLYxevw9NAF
 tLjq2+tdLyuR8L0bthycjziKs/Io=
X-Gm-Gg: ASbGncty8OYgFidVLkBDL2fDgNPwpOHZGQ1mKAauV6YuJxyUAmeegW2mKgNE6LeZDkN
 c3S56uBBj7v9DmcY9R0v/Sc5B7hokjGCNZsUYj2TBRUpKvDz4UU3RePPfNW98EHVv5VejrLyJ3P
 yej8oaDWJ1W8naDpFhLDyHnBc=
X-Received: by 2002:a05:6870:8909:b0:2b7:7abf:df6b with SMTP id
 586e51a60fabf-2db39103e68mt1185137fac.26.1746501805955; Mon, 05 May 2025
 20:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250401085903.224787-1-timlee660101@gmail.com>
 <2d3d33c3-21a6-4432-9d9e-7332c5de63bb@linaro.org>
In-Reply-To: <2d3d33c3-21a6-4432-9d9e-7332c5de63bb@linaro.org>
From: Tim Lee <timlee660101@gmail.com>
Date: Tue, 6 May 2025 11:23:14 +0800
X-Gm-Features: ATxdqUGUlAjHysGZeSKEjqPxD0jy5rzwGuXZsAMYVmt4WUYo3scqFwv_PYcZf-s
Message-ID: <CAJG6D+gBjd=1Xzk=OcsZWuMGqtPz2KhaQSVBYpZ-2LPhXFecFA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and
 device part number
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 wuhaotsh@google.com, chli30@nuvoton.com, kfting@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=timlee660101@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, MALFORMED_FREEMAIL=2.16, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> This won't work on read-only storage.
>
> > +        }
> >       }
> >       qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
> >
> > @@ -194,7 +206,8 @@ static void npcm845_evb_init(MachineState *machine)
> >       qdev_realize(DEVICE(soc), NULL, &error_fatal);
> >
> >       npcm8xx_load_bootrom(machine, soc);
> > -    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
> > +    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
> > +                          drive_get(IF_MTD, 0, 0));
> >       npcm845_evb_i2c_init(soc);
> >       npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
> >       npcm8xx_load_kernel(machine, soc);
>
Indeed, we didn't consider the read-only storage case. Should we add
bdrv_is_read_only() to check as shown in the code below? Thanks.

if (bdrv_is_read_only(bs)) {
     // Handle read-only storage
    if (blk_size < fiu->flash_size) {
        error_report("Read-only storage is too small for flash device");
        return;
    }
} else {
    // Handle writable storage
    if (blk_size < fiu->flash_size) {
        blk_get_perm(blk, &perm, &shared_perm);
        blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
        blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
                     BDRV_REQ_ZERO_WRITE, &error_abort);
        blk_set_perm(blk, perm, shared_perm, &error_abort);
    }
}
-- 
Best regards,
Tim Lee

