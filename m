Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3852DC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6ZF-0003oZ-Ai; Sun, 11 May 2025 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6Z3-0003P7-Pt
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6Z0-0007fq-7q
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746969472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlM/mB2p583nl12ibez+I+eFFUE0estwQg9vKZ8UuQk=;
 b=W/bpq/v4d6pgfgW9LeiQtH8kkxOEPoL6PB023Crh9zrIG7c5jN6WgQrT7oZ4MPwuPjhphd
 DvuXHRRH3BujpComaul/CqxW8YHUl776qOz8/vZ5+cxU9Tc/IdiQvS/eAELisiXD5g54qB
 jXOxKYo/UclsKKbAOQnOkz6QBoZY+Go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-RJxtlk4IO2W8T9aubXwbxA-1; Sun, 11 May 2025 09:17:50 -0400
X-MC-Unique: RJxtlk4IO2W8T9aubXwbxA-1
X-Mimecast-MFC-AGG-ID: RJxtlk4IO2W8T9aubXwbxA_1746969469
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b7c8b3e2so2238769f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746969469; x=1747574269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlM/mB2p583nl12ibez+I+eFFUE0estwQg9vKZ8UuQk=;
 b=ZMCirSiG46g3RxKDrUrpyrCLiw0WO9JTQ2QQRl3nbjxEnbam4YdUPrOVVg/rp4ng4L
 YQJINOwXISUUiYs8ndtJtzsqaL7aSjbXjsXYFzhc5OyN6/AC7LFcCcagc4pvNyu2ZHcP
 9TDNbi/umZ8EXjFnfFet7RffZ0mW15lP7fVwQE3BevNQMy2GkfWunNqqAd7xw6OsTYwa
 fuyu2PeAvN4GgavSCLZawX/+VETFcWbchrjwg/Ex8J2n22jqggzsgSxpM2RSkQuE0AvE
 zfa2FX/uG4z1YQGhPs1KrfBOQ5j+Pwum1/7bhWzUq/QCOlnT6Md45JnZih07MnSTkU0P
 hTCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVITiVw/5i66DRyMmzv28zxXqw3Y2v0yq9xX4tILrwWGTalku+Z0i3pX3TY4IrS2XSeW5W+JhRcoee7@nongnu.org
X-Gm-Message-State: AOJu0YzmWZwNhH/gLrN77qaOvVEywpLsPamd3OngnRvYggq387+uL2LL
 KCL+ziPFRS1dSqa1XjRFw4GJ4UZ0SCwE/9g+Z3kPVH0JMk8WOyCfi6q9wdPXZ865db2axKVq4KF
 9GAjLufnM0U9TD1vTszbKwoQlrXutX3bGGQH2dEWH/ggf/LRDk9Du
X-Gm-Gg: ASbGncsJSh41U+8sJHkJVc1g4ZDPgTx9iVQPHfkCok7BjfntgtPvfhstcllE0HWw66Z
 bvrxV6WQFNEILitMdhBqwvjZW0Wcaaej6onopqjRaoOP3ocvw6U5BES726mTLl635+imfUwet1y
 dtcZ9NWklvwVasi565sJe3hnjrwss8pCuWpjvStwHEr/acMJb0tUIbHFvEm5PZtQdN4A3/wn0BR
 5oSvefenrNeq7lCQyw7NHeWfRjUecj0hCJUZW5LNBQFdwjhmMo25GsDcft93zW7/iDrY+1PPOzA
 8knPFw==
X-Received: by 2002:a05:6000:40e1:b0:39e:cc5e:147 with SMTP id
 ffacd0b85a97d-3a1f64acc2bmr8965212f8f.55.1746969469471; 
 Sun, 11 May 2025 06:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRw9lFPG98NUg39B4iKJl8h61Rat8yD8ay4FCzPWsnUl6vmjkrT6ovwlHAmWHLyalQLhYAJA==
X-Received: by 2002:a05:6000:40e1:b0:39e:cc5e:147 with SMTP id
 ffacd0b85a97d-3a1f64acc2bmr8965179f8f.55.1746969468759; 
 Sun, 11 May 2025 06:17:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4d0dbsm9101172f8f.88.2025.05.11.06.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 06:17:47 -0700 (PDT)
Date: Sun, 11 May 2025 09:17:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
Message-ID: <20250511091725-mutt-send-email-mst@kernel.org>
References: <20250228092729.543097-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228092729.543097-1-maobibo@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 28, 2025 at 05:27:23PM +0800, Bibo Mao wrote:
> This patchset add bios-tables-test for LoongArch64 virt machine
> system. It works with UEFI bios, with uefi-test-tools LoongArch64
> support is added to build bios-tables-test.loongarch64.iso.
> 
> Also with test case bios-tables-test, LoongArch64 support is added
> and some basic ACPI tables is added here. It passes with command
> make check-qtest-loongarch64 with the result:
>  qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed

Still waiting for Igor's comment on this to be addressed.


> Bibo Mao (6):
>   uefi-test-tools:: Add LoongArch64 support
>   tests/data/uefi-boot-images: Add ISO image for LoongArch system
>   tests/qtest/bios-tables-test: Add basic testing for LoongArch64
>   tests/acpi: Add empty ACPI data files for LoongArch64
>   tests/acpi: Fill acpi table data for LoongArch
>   tests/qtest: Enable bios-tables-test for LoongArch
> 
>  tests/data/acpi/loongarch64/virt/APIC         | Bin 0 -> 108 bytes
>  .../data/acpi/loongarch64/virt/APIC.topology  | Bin 0 -> 213 bytes
>  tests/data/acpi/loongarch64/virt/DSDT         | Bin 0 -> 3614 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 0 -> 4951 bytes
>  tests/data/acpi/loongarch64/virt/FACP         | Bin 0 -> 268 bytes
>  tests/data/acpi/loongarch64/virt/MCFG         | Bin 0 -> 60 bytes
>  tests/data/acpi/loongarch64/virt/PPTT         | Bin 0 -> 76 bytes
>  .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 0 -> 296 bytes
>  tests/data/acpi/loongarch64/virt/SLIT         |   0
>  tests/data/acpi/loongarch64/virt/SLIT.memhp   | Bin 0 -> 48 bytes
>  tests/data/acpi/loongarch64/virt/SPCR         | Bin 0 -> 80 bytes
>  tests/data/acpi/loongarch64/virt/SRAT         | Bin 0 -> 104 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.memhp   | Bin 0 -> 184 bytes
>  .../data/acpi/loongarch64/virt/SRAT.topology  | Bin 0 -> 216 bytes
>  .../bios-tables-test.loongarch64.iso.qcow2    | Bin 0 -> 12800 bytes
>  tests/qtest/bios-tables-test.c                |  62 ++++++++++++++++++
>  tests/qtest/meson.build                       |   3 +-
>  tests/uefi-test-tools/Makefile                |   5 +-
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
>  tests/uefi-test-tools/uefi-test-build.config  |  10 +++
>  20 files changed, 82 insertions(+), 4 deletions(-)
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
> 
> 
> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
> -- 
> 2.39.3


