Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2FAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 07:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqeY-0007KG-QZ; Thu, 24 Jul 2025 03:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueqeM-0007G8-MF
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueqeK-0006wT-4L
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753343155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wX6HZ+UeM9JnvUfbodj8PdWMexklfZdlXskcrxQ81do=;
 b=feAzkgth35QZM6vsOmR2ia1r6KUQKIU0t7x3m1Dbh2+jNaKHhpdDcXWSlMHO8S5kibUaiG
 7CnWohuizJMWO1yur826+6gEiK0ob0XjkwwlkkcfHllircqyoMNO+5fQJjZ+rcW/1Nmjpx
 TZgNiYi3VIT1bZjM4j2Vyv/v166KF9Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-SeUXL8wuM-SQ9m2SDqmAzQ-1; Thu, 24 Jul 2025 03:45:52 -0400
X-MC-Unique: SeUXL8wuM-SQ9m2SDqmAzQ-1
X-Mimecast-MFC-AGG-ID: SeUXL8wuM-SQ9m2SDqmAzQ_1753343152
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so3518885e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 00:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753343151; x=1753947951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wX6HZ+UeM9JnvUfbodj8PdWMexklfZdlXskcrxQ81do=;
 b=So573XjjhcNk8ovF6Le/kQPa03bINqIVZwcLqHfXkpptGU5Pf8zpFxQG/EStUaxiYX
 9y3k7Xd/DFpIfrQoU2eq10FuKZSfXOdMsJqjfFGoaZ4K6O/gs/1LdTvsMM7vD2avi6TA
 bsWTIXzJbWw0dv0kNyJuA/KFDD2OLVOve5VqrBLyylN9/9k+Y3jeCqEd4Z4X5FD+nERx
 wEe0GjrA0Oww9rbAM2rfp0jyi5LPBK0CombiW1uYKB1zr8Q1YzrD5qYxOmRfWy7dmJBn
 /FOuNnX0nLuc3rJiuN6JhUGdjpE52H6258ztPA4O0Jr8KtzOFd77Hq4mEkv7aouO1Fhf
 ewEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLLwxycfjeakmLNalmtnCpZLKf3YEXtIcC/VB2Rn9e906sQXDwXgy2QpqL4f/zEckA3AfcU9tP93FL@nongnu.org
X-Gm-Message-State: AOJu0YyF1JF7RhneBakExUJ+oG9hAxcQgZhffS20tW2mM/IESKSBuFOs
 3PXtFHoVCu+MbkLoce/wg3hSq9fuk0Qer7W4tX//jvTRox0LaE2SqLvBiwpKSsLUJ11P7sHyXMt
 2junnJUJ+fL00bg+720QCz/SiB/WQyviiTBX2wM7LF0n9P3v13UI6htzY
X-Gm-Gg: ASbGncvcItFmyeb0C0DzrWzWqytqWsg2kXzoh/Ub99TbxM/nDkECJIb0U22jxc4ixwT
 yRJPFfCMbdyQYdfNvAJUgW7NRS7F+g2zViTHty27M9CZjXWZYTBrdORldVSmtSz3h4EfFFBsogi
 lKEoy/JjvYkA1/0kDacIdHVrpXoErFmYUxE1kw+Naa9UFS2SXBY/pkVMjNl90uGh4qpP52Pz4IM
 /RiKhIbx44YX7qWH8N02xsmKe0lCmyvj+YLR/wLirZGzw7mABsvRNsj3+T5jtWhnK2HLlkOEy0P
 QxNb3v5qwOiUlPS6U7PijmvpGYKSo5wuLmM=
X-Received: by 2002:a05:600c:1d8c:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-45868c8da9amr46915435e9.11.1753343151470; 
 Thu, 24 Jul 2025 00:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEliXnBkWxaouRo5J9gQJ4X2acNO2T4Ecwo6Yv/gA9h1Szojig/Xxuo4eOF755uQznkEojn1A==
X-Received: by 2002:a05:600c:1d8c:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-45868c8da9amr46915275e9.11.1753343151072; 
 Thu, 24 Jul 2025 00:45:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c819sm9267675e9.13.2025.07.24.00.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 00:45:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:45:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 0/3] RISC-V: ACPI: Update FADT and MADT versions
Message-ID: <20250724034501-mutt-send-email-mst@kernel.org>
References: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 16, 2025 at 08:11:37PM +0530, Sunil V L wrote:
> Since RISC-V support is added only in ACPI 6.6, it should adhere to the
> expected FADT and MADT versions. Update them.


Seems legit

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Risc maintainers, any feedback?

> Sunil V L (3):
>   bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT changes
>   hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
>   tests/data/acpi/riscv64: Update expected FADT and MADT
> 
>  hw/riscv/virt-acpi-build.c        |   4 ++--
>  tests/data/acpi/riscv64/virt/APIC | Bin 116 -> 116 bytes
>  tests/data/acpi/riscv64/virt/FACP | Bin 276 -> 276 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0


