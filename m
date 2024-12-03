Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7335E64A84
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRck-0007SB-5g; Tue, 03 Dec 2024 07:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRcc-0007RQ-GI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRca-0003up-Ie
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733227395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YQjTWNT2/ZULkAOQhIB/FrcUS2zmuZhKSNT4bwFCxU=;
 b=GMWT5Cu+SH0Z927cMUur6hGUf27gkkMcDaAYIcafpruRdFkmqEQhu1OhixEUMAs8WC73sx
 5624dGhLtJNLHdc+qaZDWUXvQLB9DAQx71W+V7nGLwsfu3Qw9b+yxZiceZqmcQuU8bA7ch
 gSHzDVMfYAmr6bew5NXX6/uVf+ySvYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-cP-CFLo0PyiAkiq7nUWxTQ-1; Tue, 03 Dec 2024 07:03:13 -0500
X-MC-Unique: cP-CFLo0PyiAkiq7nUWxTQ-1
X-Mimecast-MFC-AGG-ID: cP-CFLo0PyiAkiq7nUWxTQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso2038226f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 04:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733227392; x=1733832192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YQjTWNT2/ZULkAOQhIB/FrcUS2zmuZhKSNT4bwFCxU=;
 b=gmXeqJsR3PvBW3cxPZOKdqX47E6hhL0eoUatlI5m0v8MCkXgjtDpfjiIKTNIdv2r8v
 +OAp3JlqzF3+RehwOpT7zr/OTUJQqOb0ZE/sQFJ8Ns9xYMQ11AsuV0ldE/O2QPZ4YuEF
 OzRLfG9UZA00EGqIlAC7HsM+V0Y0KoG9HfyO2Di5fTa0ff4FxvW/xIbdnoD/cZy8GbrP
 Rv9uP+BEgA65erwI/d4ePjV4fJlSx4CY1mQdYmud0ftIr7xn24GpTyth3SQ9003JWEDp
 ce8zKXPgZ81bOqXMmzfcFaT4+uW3rUpA3WR/bkPbHyLxbwujX7N8q9CX2c7YaaOxJcSM
 LMUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkh0IePFkiKANGkZRTzWE+RplrFy392nCdpLAXPtfHcPIFk3ZSoOk3PVagWAHUx14QpngsgcurP/iv@nongnu.org
X-Gm-Message-State: AOJu0Yz7CrV7Xal66Eij3y+C0uTO9MXqC63LeY3/9mLSwBCwo7KcMVjk
 qDSAkpDIVJGoJ5jsoygvWaLvJ0SD+ilFyoSX2iIs+I31dEnHHLFQdLSUDzIC+dCZ5ljugdoJ9dq
 DiQ0YzrNmLu1nekw+hEMUkGUptD/EZPAhneV0lx+sqikvnOFx/VtM
X-Gm-Gg: ASbGncuitIm1Zz5BV8nAB2mdB++tC3ThnTr0vWGyhAdAwc6EbJ4GY8nxUl0ybAeZmxy
 pp1qv3ulVwUw59c3wHL/rrh7mIV/QnJhVem7Id+hrCVb2t1nENt5M7Y+g2xt/5GrRaaaoW+k072
 AdSboHxuXE2+7iPkdd3w4KzqSfJXc6jFwPOR13FBl21ONthlhs0VOu6UfIiV/dB1Ai4vZK3Eqp3
 6qP+uk0NryQguM8dKED9niO++36sb53y1GvqJIkDu9eKXj5MDjepC2/AwwfJfqL6EmAMeRnTRXd
 plLVKwfAq0Th6fRFISJtag==
X-Received: by 2002:a05:6000:1fae:b0:385:fa3d:19c6 with SMTP id
 ffacd0b85a97d-385fd419e15mr1905617f8f.38.1733227392541; 
 Tue, 03 Dec 2024 04:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1YWsA0JpLCh82fHGan3af+pICwsNMZCTgNqjdUsnEu76lurqxy+dTogsr7+4dMre2DbtZPg==
X-Received: by 2002:a05:6000:1fae:b0:385:fa3d:19c6 with SMTP id
 ffacd0b85a97d-385fd419e15mr1905565f8f.38.1733227392047; 
 Tue, 03 Dec 2024 04:03:12 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e06c485fsm12038499f8f.83.2024.12.03.04.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 04:03:11 -0800 (PST)
Date: Tue, 3 Dec 2024 13:03:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20241203130310.0bde48c0@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1732281080.git.mchehab+huawei@kernel.org>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 22 Nov 2024 14:14:10 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This  series was part of the previous PR to add generic error injection
> support on GHES. It depends on a cleanup patch series sent earlier
> today:
> 
> 	https://lore.kernel.org/qemu-devel/cover.1732266152.git.mchehab+huawei@kernel.org/T/#t
> 
> It contains the changes of the math used to calculate offsets at HEST table 
> and hardware_error firmware file. It prepares for the addition of GHES
> error injection.
> 
> The first patch was previously at the cleanup series. It prepares
> the logic to support multiple sources.
> 
> The second patch adds a new firmware file to store HEST address.
> 
> The third patch use the new firmware to calculate offsets using
> HEST table.
> 
> Patches 4 and 5 add migration support. They assume that this
> series will be merged for qemu 9.2 (maybe it is too late for that,
> as QEMU is now on soft freeze). 
> 
> I tested migration using both virt-9.1 and virt-9.2 machines
> on qemu 9.2.
> 
> I also tested migration with:
> 

> 	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
> 	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57
was that with HEST enabled (it's 'ras' machine option),
It would be better to provide full CLI used 

> 
> ---
> 
> v2:
>   - some whitespace and comment changes
>   - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
>     was merged on the cleanup series.
> 
> Mauro Carvalho Chehab (5):
>   acpi/ghes: Prepare to support multiple sources on ghes
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
> 
>  hw/acpi/generic_event_device.c |  30 +++++++
>  hw/acpi/ghes.c                 | 156 +++++++++++++++++++++++++++++----
>  hw/arm/virt-acpi-build.c       |  33 ++++++-
>  hw/core/machine.c              |   2 +
>  include/hw/acpi/ghes.h         |  23 +++--
>  5 files changed, 216 insertions(+), 28 deletions(-)
> 


