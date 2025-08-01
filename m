Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5F4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 11:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uho36-00012i-HY; Fri, 01 Aug 2025 07:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uho34-0000wv-Db
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 07:35:42 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uho31-0003w7-EB
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 07:35:42 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8e14cf9e2aso1488619276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754048135; x=1754652935; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4nJpb7DSFM8hJTgd5bH9YK871TipPLQVzEfkTjAR8RY=;
 b=eRKhngmXAL0Ir6I0yQ7rTbe5ycqBZwcXIonp94Ore522nXOhgkO1xgX4Xkdo0/0tkF
 F0oj9kY2I4blF2jeJVLIDm4AAWtKVDioFulb+VVdNJ4Oxz0+MTpiEic5q/4AG1oCPUx1
 iJwt0uyA1ZqQOEXvoBM+PCwovPcrB9go2k3GykoQywLi3ROBXq06zFYq5sHwkQ5QpudZ
 0FcifD4yHWkSyAcwfaSnZXFLglPIkDnYukV80LUrkZ+jGnCoYxr73GpNFHzoRAdybe15
 E7Ca6zuSMMAgrukQAnL70UpZX7Fa+vkRRtz5YySMkt3mY5xJMYN6z9RC6APQz0p46fRn
 QdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754048135; x=1754652935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nJpb7DSFM8hJTgd5bH9YK871TipPLQVzEfkTjAR8RY=;
 b=lVgMnKnSGDzPrVXKraAhCDPgHJz9TOnr/UIKTVF/wpsRxc41TSwP7PISQDC9YzAlH8
 fCFkPv/+xSErg/yKFdB1m3PJCQG2zYPtYYsBzIaCESJQrRtHEwY9E0LV/efJ9yjYmW3j
 zI4gqxfiKJUAET/BC+JIQDBevrKiCew03CkAJV7h3gSbFRJZvN0jfEUW/62yBLCH2FLw
 QLqaEDX9TCthf7P9tuSwq0LERYSdj3HLoACzOyWrpg5mYFvrjo38lWcDS4LFIVIQ6J7t
 pLnzSu4kfcRVXTbThBcYsL9vVp9n3SMbC/aFPHT1vuuANkElgcZTTcV/oJpCRh7p/X84
 cTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/+gxOLTNX43mDeWjywYC8yk/k6RAbgx6kftbMfGinxOic6kKAX1vO06YEGmgR2RxeQTOb796b4XhY@nongnu.org
X-Gm-Message-State: AOJu0YxzyoFM2xzmWyjGhYaqOKJMX+7Q0G9nu2uBIbbks0iXJv+kb1HB
 MjgPLcBfTiiNS5i89MpaaTOLIHrJ0xP3/c13ZSnRs7HOeZCG5v3E9ugfoSg7dpHjj8m9eCJTSyw
 kIWvV3y2CfKG8ZyRXFc2hy7dxz2CN0XpOkvKfWLdmLQ==
X-Gm-Gg: ASbGncv3A+5+7/f1VwSLvdKubpzIvAmiskOnGZKiWOm/Amv0HWdajISuxABMG+4T8H2
 8mFSYr5D532fRxPptwmGNzWeK6yibIYgwKgy9SoFoGYTp3qhyvspC56AQPmR6pC54gTMfnWqyt5
 iV/20XzGCb5iDljChgC+9IzpGljUL7E0puuUsxkRPMrVOPY52C4VYN2K59onrWG6cDA68sLIDrL
 cAQqXKp
X-Google-Smtp-Source: AGHT+IFZvfl0uda3emGzGPNnNhKEQSnH8qaGSIjczEwhjNrFDQdMidu7OLeqS5dK9PqhYI1G/VAS0sqcBufHpiy12AY=
X-Received: by 2002:a05:690c:4d88:b0:71a:275e:a74a with SMTP id
 00721157ae682-71b6d6a7851mr29543007b3.34.1754048135329; Fri, 01 Aug 2025
 04:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
 <CAAjaMXZdHEQGi=w==iVCurTs1MrL=_2CfE+i8nTte7vjWL+T7Q@mail.gmail.com>
 <20250801130319.00736944@fedora>
In-Reply-To: <20250801130319.00736944@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 12:35:24 +0100
X-Gm-Features: Ac12FXyor-ffAq-Alu6OFNnJk66jS5sL6iAqBkbHgZE6u5Uunlh9Bciv7XpI8w8
Message-ID: <CAFEAcA_Du_Cwx3mYC6HCQtgoT1QDdO_f9GwFKSjrdd_=Au+RsQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
To: Igor Mammedov <imammedo@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Aug 2025 at 12:03, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 31 Jul 2025 15:20:29 +0300
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> > Yes. Our motivation for this patch is just feature parity with x86.
> > It's a nice-to-have, if it's possible.
>
> if it's parity with x86, then why not use acpi like x86 does?
>
> If I'm not mistaken, DT in arm/virt was mostly intended to bootstrap
> 1st steps of firmware, and the preferred way do get other info from QEMU
> was via fw_cfg or standard enumeration methods (PCI/ACPI/...).

For the virt board, both DT and ACPI are intended to be generally
on parity with each other for feature support. Typically you
use ACPI if you're booting into UEFI to boot a kernel, and you
use DT if you're doing a direct kernel boot. The former is a
bit closer to a "real hardware" setup, and the latter is faster
and usually simpler.

> (point is: do not duplicate acpi features in DT for arm/virt machine type,
> perhaps arm/sbsa-ref is a better target for DT).

No, sbsa-ref is intended as an exclusively ACPI setup:
it's the board type that is a reference platform for
full-firmware-stack development. Although it has a
"DT" of sorts, this is not a real DT, it's just a
convenient way of communicating a few critical bits of
information to the firmware. The guest kernel will never
see this DT, only the ACPI tables from the firmware.

thanks
-- PMM

