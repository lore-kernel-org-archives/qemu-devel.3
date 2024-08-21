Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8443FC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmDv-0004yK-7C; Wed, 21 Aug 2024 10:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmDt-0004xe-9Y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmDq-0003eD-EX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724250119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZ3frT+NfBnXDtSSKeFB3LavyD9rk8n2mWeCOogMcHI=;
 b=EY7nbFE3Z/9umJhQnEUmgr2nHPno8r1kgkJYf5k8oHR9pOFgggfWErFIoMqgl8nuu+mnBD
 4KllmcD9bWXZ/IhHyTYN8W7EMWXSxjQjxu/bQXnxodquDxMhcKCv8XwzUbSGHK3H6c3SPK
 iTJCP3jqTFCsPYCFHlfIRyguWimh7Dc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-OoNIlkMsPwyUeg5ltDsNXw-1; Wed, 21 Aug 2024 10:21:57 -0400
X-MC-Unique: OoNIlkMsPwyUeg5ltDsNXw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42820c29a76so58492695e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724250116; x=1724854916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZ3frT+NfBnXDtSSKeFB3LavyD9rk8n2mWeCOogMcHI=;
 b=G0E0HVnN7llHIhhLfAcacjmaj2WFkaBv3eORv07NgKWdbLEl8QYws9kR6VkjvfYf79
 bun4XHUcPKhCPiL2i8K7+m13IiaHiOuW91HJwHP7EUbZ6nH9oyqw+mRCCCIb6cqXhbsN
 Wpe3cMhhKiHQpBHq8F+xuSc51mZfllG3m/jgGryzp/Lt45+tHYz3/6hTg722P6Kn6wkA
 RkVD/k134Y73yqqa7jga2SOcMjTiBGCoSoDvM9TWGUe/flck9g8YV6MBkt9598iy6ljM
 2qNGDN7zA1NXqkk8PJ9Mi7FzbyA5vl/OokYcBSuxKw5hQ5eIma6REfTpNe+RgMpNI60/
 K+zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXznLAOC/ZO8h5xy21MEC2bpNY93kmvYw/1JxfQUxzfoLUuuF9Kf4mk4WLi8w2TTpioxh3R4Qc9A9W@nongnu.org
X-Gm-Message-State: AOJu0YwsoF0WB/hk68VlMNGBV5HH1i+0FaM5iknqeE803rU5l6Z1R3SF
 HQAPCc9LPEmKd4YNZghOXwhzjqFUAsMc9VsI3kE8E5OCRwTYfHhNYSgu6zVT7zu7VjHDd7SDO6i
 hsxxzWPCloPflfgEtNfePqaVTRjg3KPISwZ+PLKx6Je0G1Nc/Z2qI
X-Received: by 2002:a05:600c:190e:b0:42a:ab31:c248 with SMTP id
 5b1f17b1804b1-42abd11dc5amr18293955e9.14.1724250115971; 
 Wed, 21 Aug 2024 07:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZCHbUNCpo9nWUowgu+SiSWhV9lN/Deleg4eiMEC47VsmBeNffBvqa07tvcBRMTQFIYvVaUA==
X-Received: by 2002:a05:600c:190e:b0:42a:ab31:c248 with SMTP id
 5b1f17b1804b1-42abd11dc5amr18293745e9.14.1724250115481; 
 Wed, 21 Aug 2024 07:21:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985d9d6sm15813617f8f.64.2024.08.21.07.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 07:21:54 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:21:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Subject: Re: [PATCH v5 1/3] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <20240821162153.6ef1f84b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240814115736.1580337-2-ribalda@chromium.org>
References: <20240814115736.1580337-1-ribalda@chromium.org>
 <20240814115736.1580337-2-ribalda@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 14 Aug 2024 11:56:09 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..f81f4e2469 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,16 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.viot",

g


