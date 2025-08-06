Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB1AC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 12:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujdeh-0003qd-KW; Wed, 06 Aug 2025 08:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ujdcX-00024X-OD
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 08:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ujdcU-0005dl-Ns
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 08:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754484707;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuUqgpXkbfQmUNwcuuyFyjahQwng9IDgxtlUsAQd7ZA=;
 b=FukqHdlsfuPI6Gq6O4i9LVs6+Kooe7fC/C2SboMvD8ufV95pnYucqWKaCVopxwP9lVyla3
 B1unOphwuX3a6WB4ssiDeK4OU8KDwrTD5GckS6J2FC+uwW5Pl5FypoQKY8vym2Rbzupj/y
 NMDTMWjH4OjFHU4iaxr1Qn0J0S2BX3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-nJu1uhPtNgWb_L90H2b1UQ-1; Wed, 06 Aug 2025 08:51:46 -0400
X-MC-Unique: nJu1uhPtNgWb_L90H2b1UQ-1
X-Mimecast-MFC-AGG-ID: nJu1uhPtNgWb_L90H2b1UQ_1754484705
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b78329f007so5680942f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 05:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754484705; x=1755089505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YuUqgpXkbfQmUNwcuuyFyjahQwng9IDgxtlUsAQd7ZA=;
 b=sxC4OkF0qYGLUeZrYKodHI9tKQGvMI7mYLIXO32VfcMwL6lZRWSraTMK8/kSDp5CUs
 ORHMUWg5eo54CY8C8Ll2sgqKIgwOJ9PuYwRWC2fwXZjq0fxHxnnH9I3PHyvAjyZQ0gLG
 uaA+TDsF/1HY/zXAJVZD2PK46Q1oKn1aTgbv1mVUB7riA1cDV64pFc/3kS6mKnNdpVB8
 rclaSrI//vNCQ7rBbF3V6W7BI013VbeAVj7MzLvNRhoUc5xcT+prhBogMs4+y2W36pXV
 4JDM1w66g8AkdP6T/ZQ66JcWXgefi+KQPWx9NPfHUOYtV38vRaiWzhW/vYoN9NOxeL7c
 8X0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYd3gzPzHZPuDz5xk2bKJM9k9Y4MlhI1QPAKgLHKUJ5Xiaeb/yUHrRSSoSrQ+Swa+e5fwcd/MbNJFr@nongnu.org
X-Gm-Message-State: AOJu0YyzdrYY7UgNIY5WlpEtAcs/hqkQTbXQtvKvbNbedCPjXWT5HG4q
 /U0pCBSYqxwydhfSLxRCAZA9g6EzZgxDVGInV7IGsQfgg8NzZm2g7+hlub87apSKNZbeOgPLJHr
 EyGfke/9UvojgKKovUA/5COLhhYjvRsP/u2683mK3at6k8iYZrkPRTUQq
X-Gm-Gg: ASbGncsIgD5cwDSwXn7h/K/vxHGz+kd59zYRALKVmPtBX6GPZ+1BrhbMPa14HpjSdW5
 MCV6bSc/xlR3lMwGl0mmXy5hZhQG2WHsUwDOQ4UbvY/QSs5js/LOnpxzcnBAZ2HPmzpXiwNW3R9
 gDVXwuVqhlqEbsxI903QwEeHfCRtZo7G/6nAQw7fX/8DIjiDKMfOXHe2zlGEbZ4+0QaLccnSEXO
 /tKYzyDszhqa2AgSv0oBT0aBGe+8ASoCjvv1Po2oMEGt7nlUT6PgNj1LWY4wwC6SVnQq56ibT63
 A8IlgvQHDKU2NsiJQGCx7NVdZR0W2diTFoRIxQKq4DzW
X-Received: by 2002:a5d:64c7:0:b0:3b7:9350:44d4 with SMTP id
 ffacd0b85a97d-3b8f48cd130mr2023567f8f.11.1754484704924; 
 Wed, 06 Aug 2025 05:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+oXlK9a92qIBV/Yb3ISOQjkWX+9UQFeAczkBCJm9a2F7YQEZppPlpCOvr4pgWURcW+VaPHA==
X-Received: by 2002:a5d:64c7:0:b0:3b7:9350:44d4 with SMTP id
 ffacd0b85a97d-3b8f48cd130mr2023546f8f.11.1754484704489; 
 Wed, 06 Aug 2025 05:51:44 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.28.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c470102sm22785068f8f.53.2025.08.06.05.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 05:51:43 -0700 (PDT)
Message-ID: <22bb66b6-998c-4cb9-a16b-386ff88bb197@redhat.com>
Date: Wed, 6 Aug 2025 14:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2 0/4] vfio: Remove 'vfio-platform'
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250731121947.1346927-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250731121947.1346927-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 7/31/25 2:19 PM, Cédric Le Goater wrote:
> Hello, 
>
> The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
> timeframe. QEMU 10.2 is the time for removal.
>
> The last patch moves vfio-region.h under hw/vfio since it no longer
> needs to be a public VFIO interface.
"tout ça... pour ça!" as we say in french ;-)

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> Thanks,
>
> C.
>
>
> Cédric Le Goater (4):
>   vfio: Remove 'vfio-amd-xgbe' device
>   vfio: Remove 'vfio-calxeda-xgmac' device
>   vfio: Remove 'vfio-platform'
>   vfio: Move vfio-region.h under hw/vfio/
>
>  docs/about/deprecated.rst             |  25 -
>  docs/about/removed-features.rst       |  25 +
>  docs/devel/kconfig.rst                |   2 -
>  {include/hw => hw}/vfio/vfio-region.h |   0
>  include/hw/vfio/vfio-amd-xgbe.h       |  46 --
>  include/hw/vfio/vfio-calxeda-xgmac.h  |  43 --
>  include/hw/vfio/vfio-device.h         |   2 +-
>  include/hw/vfio/vfio-platform.h       |  78 ---
>  hw/arm/virt.c                         |   5 -
>  hw/core/sysbus-fdt.c                  | 383 --------------
>  hw/vfio/amd-xgbe.c                    |  61 ---
>  hw/vfio/calxeda-xgmac.c               |  61 ---
>  hw/vfio/platform.c                    | 716 --------------------------
>  hw/arm/Kconfig                        |   3 -
>  hw/vfio/Kconfig                       |  16 -
>  hw/vfio/meson.build                   |   3 -
>  hw/vfio/trace-events                  |  11 -
>  17 files changed, 26 insertions(+), 1454 deletions(-)
>  rename {include/hw => hw}/vfio/vfio-region.h (100%)
>  delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
>  delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
>  delete mode 100644 include/hw/vfio/vfio-platform.h
>  delete mode 100644 hw/vfio/amd-xgbe.c
>  delete mode 100644 hw/vfio/calxeda-xgmac.c
>  delete mode 100644 hw/vfio/platform.c
>


