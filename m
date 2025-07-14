Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA59C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSG8-00037R-GN; Mon, 14 Jul 2025 19:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG0-0002hc-Ee
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFy-0005OL-N6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ByXh3NCy3hfu/AZyGeZDrs8lL0yTfXk7SeuVflPlt2k=;
 b=MTr5a3MJZIMnpkGs0hVrXpT2F+wnj3EmKqaTGAaRKAGNUUjuuo8I436ZmaAE+eIc2x5zZO
 axXmp+sbHI6vHkVEpQVlXryQuvS0WWC5VjfCq5eNKYcNb/dgZR53TOxYfsu3LOdChn+GKs
 ZeY8YPUyfsoFiKzUNdhwHDHo9ZWh2fA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-m0GwcmVwNYixzpmnIARp4w-1; Mon, 14 Jul 2025 19:06:44 -0400
X-MC-Unique: m0GwcmVwNYixzpmnIARp4w-1
X-Mimecast-MFC-AGG-ID: m0GwcmVwNYixzpmnIARp4w_1752534403
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso27926455e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534403; x=1753139203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByXh3NCy3hfu/AZyGeZDrs8lL0yTfXk7SeuVflPlt2k=;
 b=wwVOIGMunwNvdvGu4LZdi1+zab/sJe0rn9UM0Gfxh2dj9I9fukrKRS+1iXfLmcNDep
 dKDoEIZXjTS2ANqlBrLowKzTS6zaJELjRSNINvge5UpYIKS6hmK103YduKqD7K6apn0o
 INlvr+DzGCzDegcIPccUyV8pW+wTqZYp2mCBnYGEORqqlvshC8HgxWHNpDguNaqQrWcY
 Nfl1N9AGF8k8HpRyAl7SL3WV6Yi8WRl9eSfePv9tghz2jRXzYBX4HHsyYoJjFHNuFbiL
 zLWXLLBkaaPz4RGFen7QUT7t8R4rojpeLnZGDP5C4MHUIzEG99Xz9xwVTG2JLmwZCJpy
 gJVQ==
X-Gm-Message-State: AOJu0YyjkqVvghLFqqaHnB88m2Zn8R8A09MCXdDeezeagODhArimKOdk
 DURrijTSBaT84ll5MWrB7Y+R0BOAD/DKbnCbSdq7N4IyyEOKiAFFXvX1gvIbqWjZb4r/QAW5icm
 cYWChjYCXliGt3JGFJy6MEw+KBbMM5jBMV661cZ9g3oFiTW0IZESfXi/V82sYkvR2ADY7MeXcmI
 HnWM5c+K5s+TA1WyfegM5NpWsxH15qoATOTA==
X-Gm-Gg: ASbGncvmvvTcLJltKCEHJaD+mG9uwdH8/zcoXDKt2LsBeyklen/v0K6z4vnWDpJqFjJ
 P1PqDH4iIk6jDTRR1IlnX+DNwqugJUNTc0hTaFNV28lrJNo/2mSQ9WSb7uIFDFitZJkwzUJ73RN
 fzm3r6Er9vS1SqujY9ikPP0fsxTmFvq8K1kD2vkgpzOqPf53iaTnLiowqZR6bdRUbZqeozEYEiO
 AMjdRpR7VT7ijJ0Qf0EjZ3//ix+GU78un4j+qCp/M8gZ+FIzINIR5EtNxTn0czhefD/6l0cQgMY
 kIn8N7kIQILJmS3mdk7VoizhvNG7Ftro
X-Received: by 2002:a05:600c:6d1:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-45625e663dbmr7614055e9.11.1752534403164; 
 Mon, 14 Jul 2025 16:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5E9vRMNGmVy0x30xqTSrFP4Fc2xO1YmZHrZVTJ4tjQP8Gou7fmaZmHW6rOBrNhMoB7QWBg==
X-Received: by 2002:a05:600c:6d1:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-45625e663dbmr7613945e9.11.1752534402748; 
 Mon, 14 Jul 2025 16:06:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c7cbe8sm3910705e9.0.2025.07.14.16.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:42 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 11/97] tests/acpi: Add empty ACPI data files for LoongArch
Message-ID: <f3bc2c3f33cc875a3b7e5349aa4141ea6789a01d.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Add empty acpi table for LoongArch virt machine, it is only empty
file and there is no data in these files.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250612090321.3416594-2-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 8 ++++++++
 tests/data/acpi/loongarch64/virt/APIC       | 0
 tests/data/acpi/loongarch64/virt/DSDT       | 0
 tests/data/acpi/loongarch64/virt/FACP       | 0
 tests/data/acpi/loongarch64/virt/MCFG       | 0
 tests/data/acpi/loongarch64/virt/PPTT       | 0
 tests/data/acpi/loongarch64/virt/SLIT       | 0
 tests/data/acpi/loongarch64/virt/SPCR       | 0
 tests/data/acpi/loongarch64/virt/SRAT       | 0
 9 files changed, 8 insertions(+)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
 create mode 100644 tests/data/acpi/loongarch64/virt/FACP
 create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
 create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bad1380eec 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,9 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/APIC",
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/FACP",
+"tests/data/acpi/loongarch64/virt/MCFG",
+"tests/data/acpi/loongarch64/virt/PPTT",
+"tests/data/acpi/loongarch64/virt/SLIT",
+"tests/data/acpi/loongarch64/virt/SPCR",
+"tests/data/acpi/loongarch64/virt/SRAT",
diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SLIT b/tests/data/acpi/loongarch64/virt/SLIT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


