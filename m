Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E1ED116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOybU-0008Bx-DX; Fri, 28 Nov 2025 08:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOybT-0008Bn-AF
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOybP-0002A1-KX
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764336812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7rPKt2YOVWZRcKDMw8BVkBeJDOg7PpeXo/5fzUrCYo=;
 b=c+pgRe4k+NFMhGrmFVBJgHvt3aJV+Ru9sIl8fMcx6QVtwYCZHddC3P2hXZpG4ZoBB/W0z4
 0Tn92xenVkb2Ehg+eS5EaPMKo/C1eVBPDFo+zUJCvxeLSBDVhhxi2uW5aEwOwcESViT/wY
 YLdq6sTs60iBpD8u7Sl8iXsG6WFaHAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-3uuN6aTgN12oOSzJ-EIiGA-1; Fri, 28 Nov 2025 08:33:31 -0500
X-MC-Unique: 3uuN6aTgN12oOSzJ-EIiGA-1
X-Mimecast-MFC-AGG-ID: 3uuN6aTgN12oOSzJ-EIiGA_1764336810
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106720618so21331735e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764336810; x=1764941610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7rPKt2YOVWZRcKDMw8BVkBeJDOg7PpeXo/5fzUrCYo=;
 b=cESFkmPdGvoIFQ03lxDi9DEL2huXji+O7G0a3zZx+3G36m2kwEMcxArineXt6kYpO0
 lyx8C24rOFEtWClQvJe+RUrnHutWRvHulAmC1OFbpG4yUuZJtQrDBuZwqWV4EHxfg8r9
 UgoGiWUj2vTClXJaAxeYYrNadf/BLKyy+WhmwH/wx9uD16xRvM/Y6R9n50gC1mhRc1bB
 RZCEplSTLRnMgVKKvejdYd1ghK51ToedGJFnshbqd8eWYao9dl2ymHRsbc5FgxFYM39A
 WxH0cX0Z0f20yTdIZH8jNwRJJaGooU0ElbjpiCQAJLZ0eq3scYULy0KDtzj68JN9yOYB
 ycrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764336810; x=1764941610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+7rPKt2YOVWZRcKDMw8BVkBeJDOg7PpeXo/5fzUrCYo=;
 b=JLhTqcfZIZ74MtE/ZgqT0JWccz+6UOfsOC2idqvf5wyQzl006MV4nl4xpMEqqy4JMM
 fYrAzb420zvpscKQG9tKVZFH8eZOgSAL37oXiexRpTp7nPxI9+TsCtHuAs+KTrJH02qO
 1NTBeFG977fHcyD4Gh53l0p//90+vg5GWSYLduWCdvtaU3gWO1+97+rPsSb7uGkr1l3U
 aNsFNLKGEL45RsMVxXyrg7DIXCA4GD5X7n0xkWOKOZ+K5UolB3YHzozFocJ/jMGG1XXD
 pKoUE7PH8pDb1DNTzZ4ciiQ8jtSz/RxXMfM7HH/6dvq35eLUxHAGVNl6/nXUHf/VpLF1
 X9Wg==
X-Gm-Message-State: AOJu0Yy/dxV2R5C14JSjuTezFVwOnVQG+1PZzEHEGuwwUGi21egTT3uN
 VPHY2YMTqeLVkpEoxbOXJYxPiKPRue1B//u1DC48xY0KZyFr4l308IH7uApH4k8X5VT5p1RFdIN
 9qyqi0/katRjMMEPfz9QIgYG3D1naMyxPjKRz0iB+8K5vxxaMuf1tM7hb
X-Gm-Gg: ASbGncsF0u+55K0sg1/iC3GiQsxRtLSXTx1WXNghhE6xKaeGGSxczhS1aRrrafFjYpN
 J8lWn7Jxi2ggaqlK+vzX3Uv19uN+qk/ZkHyE9tCxVL+SmQ52JyUxSUHZ1HmCl6HlOVucdz3S9XD
 pMjw+Xk8u/B6++tpqyhkeMGaBFullo/2iaE6W1wZHpyLeiWEv7cJG/u+YwNTLHdj7KR0aiwyWXj
 A1EcBUCqOS0Pp2dR8JZS3umOZKBYEolzHvsF3Vnre+AuNf88Q/OtECM3VYeulBInt5U2CApjv9t
 xwOQOzAZqcYDOD+jI4lA2UBTiZZyVZJ72IWXOSPX34LStyL9VO0lpniJ6IVGsBaam1Zmdg==
X-Received: by 2002:a05:600c:3595:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-477c0184b34mr291857025e9.8.1764336809958; 
 Fri, 28 Nov 2025 05:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjoz5t3ba8eL0Yh9x9oP2YnTNXac6zuIC93/ZTVGCmoynlckXep60BROwKXOWyqJDs4iRrOw==
X-Received: by 2002:a05:600c:3595:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-477c0184b34mr291856625e9.8.1764336809546; 
 Fri, 28 Nov 2025 05:33:29 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc8bbbsm159367045e9.3.2025.11.28.05.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 05:33:29 -0800 (PST)
Date: Fri, 28 Nov 2025 14:33:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] edk2: update to edk2-stable202511
Message-ID: <20251128143328.5e132d7b@imammedo>
In-Reply-To: <20251128084524.363989-1-kraxel@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 28 Nov 2025 09:45:07 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Update edk2 firmware images to latest upstream release.
> 
> Noteworthy edk2 upstream change is that 32-bit architectures (ia32 and
> arm) are not supported any more, so the qemu builds of these are removed
> too.
> 
> v2:
>  - add asl diff to test data update.
>  - rename rischv builds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: 

> 
> Gerd Hoffmann (9):
>   tests/acpi: enable updates
>   edk2: update build script
>   edk2: update submodule to edk2-stable202511
>   edk2: drop 32-bit build config (ia32 and arm), update aarch64 vars
>   edk2: drop 32-bit binaries (ia32 and arm)
>   edk2: update binaries to edk2-stable202511
>   edk2: rename risc-v firmware builds
>   tests/acpi: update expected data files
>   tests/acpi: disable updates
> 
>  roms/edk2-build.py                            |  21 +++++--
>  tests/qtest/bios-tables-test.c                |  40 +++++++-------
>  pc-bios/descriptors/50-edk2-i386-secure.json  |  34 ------------
>  pc-bios/descriptors/60-edk2-aarch64.json      |   2 +-
>  pc-bios/descriptors/60-edk2-arm.json          |  31 -----------
>  pc-bios/descriptors/60-edk2-i386.json         |  33 -----------
>  pc-bios/descriptors/60-edk2-riscv64.json      |   4 +-
>  pc-bios/descriptors/meson.build               |   3 -
>  pc-bios/edk2-aarch64-code.fd.bz2              | Bin 1565763 -> 1662423 bytes
>  ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
>  pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
>  pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
>  pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
>  pc-bios/edk2-loongarch64-code.fd.bz2          | Bin 1148383 -> 1178146 bytes
>  pc-bios/edk2-riscv-code.fd.bz2                | Bin 1296526 -> 0 bytes
>  pc-bios/edk2-riscv64-code.fd.bz2              | Bin 0 -> 1252448 bytes
>  ...v-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
>  pc-bios/edk2-x86_64-code.fd.bz2               | Bin 1907255 -> 2138026 bytes
>  pc-bios/edk2-x86_64-microvm.fd.bz2            | Bin 1787244 -> 1996414 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2        | Bin 1962992 -> 2293816 bytes
>  pc-bios/meson.build                           |  10 +---
>  roms/edk2                                     |   2 +-
>  roms/edk2-build.config                        |  52 +++---------------
>  roms/edk2-version                             |   4 +-
>  tests/data/acpi/aarch64/virt/HEST             | Bin 224 -> 224 bytes
>  tests/data/acpi/aarch64/virt/SSDT.memhp       | Bin 1817 -> 1817 bytes
>  27 files changed, 53 insertions(+), 183 deletions(-)
>  delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>  delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
>  delete mode 100644 pc-bios/descriptors/60-edk2-i386.json
>  rename pc-bios/{edk2-arm-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} (100%)
>  delete mode 100644 pc-bios/edk2-arm-code.fd.bz2
>  delete mode 100644 pc-bios/edk2-i386-code.fd.bz2
>  delete mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
>  delete mode 100644 pc-bios/edk2-i386-vars.fd.bz2
>  delete mode 100644 pc-bios/edk2-riscv-code.fd.bz2
>  create mode 100644 pc-bios/edk2-riscv64-code.fd.bz2
>  rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)
> 


