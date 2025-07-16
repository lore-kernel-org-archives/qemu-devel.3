Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D1AC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0Yx-0005oi-8m; Wed, 16 Jul 2025 07:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc0XL-0004EJ-16
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc0XE-0005Mq-Kj
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752666169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubdDaC1/Grewr48cxcXxbH5EM6azpje+a9podswr42E=;
 b=CjegbCcaFXt1vxkdXnpRzGBDeuHm2bG8t+jGNVwbIedbv9yezdTftlviO+K7DV0a8RBOP6
 PHD9flsKaswfLSnYWH6DwVcVSinvVstkqhvHGwBUNutvkyeaZry2g03W+nu3Sv/Qmfwpju
 TVkSr0/KE6EQVuvfOU/GEFFYFP036C8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-QlVBwcThM9e6AS0Oivnbvw-1; Wed, 16 Jul 2025 07:42:48 -0400
X-MC-Unique: QlVBwcThM9e6AS0Oivnbvw-1
X-Mimecast-MFC-AGG-ID: QlVBwcThM9e6AS0Oivnbvw_1752666167
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso35753935e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 04:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752666167; x=1753270967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubdDaC1/Grewr48cxcXxbH5EM6azpje+a9podswr42E=;
 b=A7ATUzk+97AZbYudiWPX3VXcMQuv+f6fagUK0lJitpimZMyM8xvZlh1H6oBewVMKXk
 eYoW+BRWHaGlOBZ+J194x1ZEGT3ZnYxt7S30QYPe/Tmkf//JRi0L+A90b0yh2qNw0sUr
 DPiHZbwQHjE2sVzmAj7fFMeHykv8ikM3Pg0SFc5s7jqncb+VWBuKXdbj1AjPrJ4eoosu
 orwy3ezP9wURhuRaxV+vGymWfUJqlQNMqLv8AqgTw+r8UIbuSasQ41tkb4JK1IV9wSDC
 WLA/OIEZDK1eFrdWKIUeIGdtf5Jm2Akp0PPi19I9NaJl9uAZCpj2nP/oM9hVJRNS3cmF
 mIqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEDQWfeAXsGY7M8Pw5HjAntkBDFQcIAjkIovV3RBbVgyzcFvLuQPcXnb2cgapmjBMiE+chxsgbFgYa@nongnu.org
X-Gm-Message-State: AOJu0YyAAHbew29+2OgkwFckAlhMChsTc2cP26IoYWEkjcF+yVT7sCJE
 T/yl5vZ0xKjysoOm/rJqX/CiwdEUJqzghotdiOHoT4ZPBL5J7Ryvg0W8vkMC098btFNl1UzuHve
 oZFzu0hp6BAoX6iPRSxigGvFObNwQLGZOS6rpL8rmbPoRP88E1HFeoWon
X-Gm-Gg: ASbGnctzdssjyB650kFo13PBCPXV87uWro14No4hfsKzNYQtkSNEfJQ8CHQKLbuMV0g
 NzWEg4iGzT8jEGxTX0dQ7JlF0RVf0/lIq7fzOPX74uOZoukBhCofxk2VUKYbwp2eodM/z83HVOr
 IaHfDpr9qIQHULXqLXje9bLaWu+A42ENoMOHiCye8rAJcqfXbviM/Bh2y9ushHluBJxbtTbTcm7
 x7r3v2zHfkdjR7CwvaYDcUCtTwh+z1thwZ2TkPXD2vuJ01hPs58DR9qVt/L1aTaqdpPfDjfmy4n
 /MMN3wYdaXGnaEerfRjPZ65i40evOWeN
X-Received: by 2002:a05:600d:9:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-456306da0e0mr10335555e9.28.1752666166771; 
 Wed, 16 Jul 2025 04:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9MNvU/c2VNfJQLL+7WdLBSm/91m4ZifxUd7U4biH2fopHatpEebi+6DWmwp7gPIBeEHUwbQ==
X-Received: by 2002:a05:600d:9:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-456306da0e0mr10335295e9.28.1752666166394; 
 Wed, 16 Jul 2025 04:42:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18ffsm17367453f8f.9.2025.07.16.04.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 04:42:45 -0700 (PDT)
Date: Wed, 16 Jul 2025 07:42:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?=22Philippe_Mathieu-Daud=E9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>,
 Li Chen <chenl311@chinatelecom.cn>
Subject: Re: [PATCH REPOST v4 4/4] acpi/virt: suppress UART device & SPCR
 when guest has no serial hardware
Message-ID: <20250716074207-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
 <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 16, 2025 at 07:41:11PM +0800, Li Chen wrote:
> Hi Michael,
> 
> Thanks for your kind review! All issues below have been fixed in v5:
> https://lore.kernel.org/qemu-devel/20250716111959.404917-5-me@linux.beauty/T/#m696cee9a95646add1b74b866c3d6761aa4c5c762

Past soft freeze now: I tagged this but pls remind me after the release
to help make sure it's not lost.


