Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF39DC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmb5-00060A-5l; Wed, 21 Aug 2024 10:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmb4-0005uL-5R
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmb1-00078j-2G
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724251557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwk5vvEa7saOxRVO1ubQpIepwxQPZ+YQi35HluJADR4=;
 b=hhwcxhT+DG6Cg/7Aepd6ZdNuhX58NwSaJiiaeJMYT3+u7M8R/yAe2ZycJcX00OmjHJxEZ5
 ERouQBzHAkBB5rhlypdktOWQN9lVqIGUHflyv6c4ZPtsNXiDuz14Gj1WwOGLeTNp8KvWQW
 PwPCGux1b0fGEgFj1rUEfy0wC3tj/qc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Lv0sohF5PlmG74MB8HWy-Q-1; Wed, 21 Aug 2024 10:45:56 -0400
X-MC-Unique: Lv0sohF5PlmG74MB8HWy-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42808685ef0so59756465e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 07:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251555; x=1724856355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwk5vvEa7saOxRVO1ubQpIepwxQPZ+YQi35HluJADR4=;
 b=Crd/EsIudbxc/QpEavROKZpnlFsSauCkHjmqY4gGgayNZzL9I/Wr9K8S/H4VMuD86L
 HBbJemXJv6gjLl5tWTVMBuG2fhMyqTtSOJHNzkXgo5OoNPu6VJic0QK6wv23YkpBPz2U
 kFs5t3cEresv1G6Mffdud8k3RYHbggsGhPFB8VGvpSzDi9+grF4O5BDFA2dcWjd77MIp
 qcEfxw0FqRGx5c9nqJKKX3fcxrXdnpzU4T8D53JmfOv2WuQQc9GhWd9zyFUKKMIBbCn1
 SIW4Alp/bdWirbznnws8doZ3f02bmU6FPFGjw5v7R9nvUAl4+IEhVLj2a6BMMEdbw6Eb
 NRxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7VbvHJ00D7BxAVlTaZg8AuqORVbA4MTErCW6o/FWv+nuC88St5jkcnzqGBIjgxsVfHNEWAMZ84cLa@nongnu.org
X-Gm-Message-State: AOJu0Yy/zOAxOkLv+Z5Kx0VosbkM5DaxeKe5RU8/93yWZEC8NyrwbYVy
 yb3nnpfdOV3r13KLRMcbXnQbY+HsIEneMZLAevrvv3msMXBSpQ8O+Mv+C+3ocOFEfhDRrhCId8a
 eq4Vnc4oiTiPlxNtlXJNBpTCtYH025OpV7I8ItBD7n/Rn7T7nI1Gz
X-Received: by 2002:a05:6000:1e84:b0:36b:bcef:b393 with SMTP id
 ffacd0b85a97d-372fd82732dmr1544176f8f.57.1724251555292; 
 Wed, 21 Aug 2024 07:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEqxGmPBtZnFyyNhMRxlx25ig9jAuIN0E6XDLaw6TgPLeJF1i52d42O5Aq6pOV5jtRwtIR2g==
X-Received: by 2002:a05:6000:1e84:b0:36b:bcef:b393 with SMTP id
 ffacd0b85a97d-372fd82732dmr1544147f8f.57.1724251554727; 
 Wed, 21 Aug 2024 07:45:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985a35fsm15874424f8f.59.2024.08.21.07.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 07:45:54 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:45:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Subject: Re: [PATCH v5 0/3] hw/i386/acpi: Pre-compute the _PRT table
Message-ID: <20240821164553.63007e25@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240814115736.1580337-1-ribalda@chromium.org>
References: <20240814115736.1580337-1-ribalda@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 14 Aug 2024 11:56:08 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Today for x86 the _PRT() table is computed in runtime.
> Under some configurations, computing the _PRT table can take more than
> 30 seconds and the ACPI timeout is violated.
> 
> This patchset modifies _PRT() to return a pre-computed table.

To be sure we are not breaking anything boot tested it with
rhel6.7/9.0, winxp, ws2022


> Changelog v3->v4 Thanks Richard:
> - Make link_name struct static
> 
> Changelog v3->v4 Thanks Igor:
> - Add missing files to tests/qtest/bios-tables-test-allowed-diff.h
> 
> Changelog v2->v3 Thanks Michael:
> - Code style
> - Add cover letter
> 
> Ricardo Ribalda (3):
>   tests/acpi: pc: allow DSDT acpi table changes
>   hw/i386/acpi-build: Return a pre-computed _PRT table
>   tests/acpi: pc: update golden masters for DSDT
> 
>  hw/i386/acpi-build.c                 | 120 +++++----------------------
>  tests/data/acpi/x86/pc/DSDT          | Bin 6830 -> 8527 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
>  tests/data/acpi/x86/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
>  16 files changed, 22 insertions(+), 98 deletions(-)
> 


