Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F927D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOycU-0000Ab-VD; Fri, 28 Nov 2025 08:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOycT-00006c-Gz
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOycR-0002Db-Hn
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764336878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QYkmPFYq0z6TWxiQKC7YS7HCGsxdSnaAjUiuH9ULj0=;
 b=FoK6E+lEoVu6ntJD2ttFBmSf+72tKpoX3+4ljCH4+h83uy0laPK0YWBVKODNd/o/ff+FRt
 5wszRncKLLb6B/iYkiPkgAda+AhRxG2NibapdF63baYyb7p4vy6aLkxZ5RYV3xDFZOzF9b
 1ZUG3RuSAAuBQFYkfvaVkwJxVslJI+g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-q91SUbbuPTG2-FiGgqgl3w-1; Fri, 28 Nov 2025 08:34:36 -0500
X-MC-Unique: q91SUbbuPTG2-FiGgqgl3w-1
X-Mimecast-MFC-AGG-ID: q91SUbbuPTG2-FiGgqgl3w_1764336875
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so9962185e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764336875; x=1764941675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QYkmPFYq0z6TWxiQKC7YS7HCGsxdSnaAjUiuH9ULj0=;
 b=lK8zU6xEzARqw41nkvxqszmOay0fIeh7LnCq4gA/gaGl76K6XIlsmEmdkl9r/y3DO7
 oY0Xcxq7nvVG9UTMU7rlxPxfMOgtYgBg/yI+g4XEDZLVmI51I/wieg4cbBCTAJA5fQvP
 4yUTrpLUIYY3e2e/zNxZmunfaSP0AA3HGVYCk4NKB6t/YeqkYQVIxG5cFpL5CZDXAxqL
 lViCCAbg8GUDYN84k8qci+9qUJv6SINw5GUUuTpGqIGyN2K96IPXOBARfMo/muSP5qbU
 ycqTNo0WZUISOlx1adv9FA9Q6Pi03vGDEXvpukTUmvqazBppU1l30IbnDvg2noFk8M+e
 K8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764336875; x=1764941675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QYkmPFYq0z6TWxiQKC7YS7HCGsxdSnaAjUiuH9ULj0=;
 b=ssOcaZEi4uxzqoWChHbQCSP4azKi3o7OirkiEEf4KW/FkVw/8cZp/q+qRa6os8PTBR
 G9kPqeM8hfsXa80OqNnUvErG/j3TqM6oWXAJTnAhLQcG5L5JMumoN7e9qjIsFGevQ/7t
 vvbTtnyB9bzzc030omyRvcWKSipA/gKbjdjVoOejrkAL0oG0YExDX2/wq45HpZPyiwvt
 a2wuS00Sslp7LDprq+fbADr+PGPwJuTdoZA6X5MGbJsFij+vmggVZSyYimlP8sdO2vCa
 ilr7VJcdiKvCGBUwrONdyfyw3mGCnH6djfXcHREqNy7qbHa5MXchR9ACekKrUl0qfsHr
 vpWA==
X-Gm-Message-State: AOJu0Yw/sP5kE/D5YxENmLeZ2t17lZ7N2nCtu62g9kK6oKnNvfkE2B8x
 OfIx3dtNQJLEX0JuUFlOfwHwQ3uDxFLb/FOkulFU0jYw5MXSQMggTiwzQwmsvVin1ciqBd2rLn8
 s2afYbYD8tyLqXXfb5i/SsBgCAX0bjjizFzohiO2l9FtmdVrxQsR80eve
X-Gm-Gg: ASbGnct4s7PaXt5G4UGUgok18J0U+gVl5a9qK22BRPPlNixY8C/cVzyWhpDFMMiylBp
 m2qOlfbiEDaGe2S91Q52DQQVx29AX8dKuwlWd9gE4cMNJQpnvmvAAfGXP+IcwqKH7NzGSZUI2Bn
 IKTjNbJzG3TiiYCvjtpxa8XiFzeIEEBuBfahJnMNYl2dsjQvwPo3O32YcAjXXmGO73iAuVSuld6
 KzHDVlaAqAm1y0cFy99efi9uH/lOd+flJ2IiVy6tKcWO6LRN/6Tgmqq9GlFmIRjW5e4rfTIEyGN
 UMC7T+pcVa28lBfqckKPHO1GYCjuSmTPMyETaHKHbnQRyry//woJap3dCEkuDVA5pYfIxg==
X-Received: by 2002:a05:6000:26cf:b0:429:d66b:507f with SMTP id
 ffacd0b85a97d-42e0f34f9a3mr17383295f8f.48.1764336875270; 
 Fri, 28 Nov 2025 05:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF43UJbo5/vXRlzrnN/WZJLXUVlgi1Vg8ETDN00jRV9XTec6oTAFNzsj7LMkMbOK0ujvtCZ/Q==
X-Received: by 2002:a05:6000:26cf:b0:429:d66b:507f with SMTP id
 ffacd0b85a97d-42e0f34f9a3mr17383253f8f.48.1764336874864; 
 Fri, 28 Nov 2025 05:34:34 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c30c4sm10356060f8f.9.2025.11.28.05.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 05:34:34 -0800 (PST)
Date: Fri, 28 Nov 2025 14:34:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] edk2: update to edk2-stable202511
Message-ID: <20251128143433.677fa71e@imammedo>
In-Reply-To: <20251128143328.5e132d7b@imammedo>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128143328.5e132d7b@imammedo>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 28 Nov 2025 14:33:28 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 28 Nov 2025 09:45:07 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > Update edk2 firmware images to latest upstream release.
> > 
> > Noteworthy edk2 upstream change is that 32-bit architectures (ia32 and
> > arm) are not supported any more, so the qemu builds of these are removed
> > too.
> > 
> > v2:
> >  - add asl diff to test data update.
> >  - rename rischv builds.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>  
> 
> Reviewed-by: 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > 
> > Gerd Hoffmann (9):
> >   tests/acpi: enable updates
> >   edk2: update build script
> >   edk2: update submodule to edk2-stable202511
> >   edk2: drop 32-bit build config (ia32 and arm), update aarch64 vars
> >   edk2: drop 32-bit binaries (ia32 and arm)
> >   edk2: update binaries to edk2-stable202511
> >   edk2: rename risc-v firmware builds
> >   tests/acpi: update expected data files
> >   tests/acpi: disable updates
> > 
> >  roms/edk2-build.py                            |  21 +++++--
> >  tests/qtest/bios-tables-test.c                |  40 +++++++-------
> >  pc-bios/descriptors/50-edk2-i386-secure.json  |  34 ------------
> >  pc-bios/descriptors/60-edk2-aarch64.json      |   2 +-
> >  pc-bios/descriptors/60-edk2-arm.json          |  31 -----------
> >  pc-bios/descriptors/60-edk2-i386.json         |  33 -----------
> >  pc-bios/descriptors/60-edk2-riscv64.json      |   4 +-
> >  pc-bios/descriptors/meson.build               |   3 -
> >  pc-bios/edk2-aarch64-code.fd.bz2              | Bin 1565763 -> 1662423 bytes
> >  ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
> >  pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
> >  pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
> >  pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
> >  pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
> >  pc-bios/edk2-loongarch64-code.fd.bz2          | Bin 1148383 -> 1178146 bytes
> >  pc-bios/edk2-riscv-code.fd.bz2                | Bin 1296526 -> 0 bytes
> >  pc-bios/edk2-riscv64-code.fd.bz2              | Bin 0 -> 1252448 bytes
> >  ...v-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
> >  pc-bios/edk2-x86_64-code.fd.bz2               | Bin 1907255 -> 2138026 bytes
> >  pc-bios/edk2-x86_64-microvm.fd.bz2            | Bin 1787244 -> 1996414 bytes
> >  pc-bios/edk2-x86_64-secure-code.fd.bz2        | Bin 1962992 -> 2293816 bytes
> >  pc-bios/meson.build                           |  10 +---
> >  roms/edk2                                     |   2 +-
> >  roms/edk2-build.config                        |  52 +++---------------
> >  roms/edk2-version                             |   4 +-
> >  tests/data/acpi/aarch64/virt/HEST             | Bin 224 -> 224 bytes
> >  tests/data/acpi/aarch64/virt/SSDT.memhp       | Bin 1817 -> 1817 bytes
> >  27 files changed, 53 insertions(+), 183 deletions(-)
> >  delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
> >  delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
> >  delete mode 100644 pc-bios/descriptors/60-edk2-i386.json
> >  rename pc-bios/{edk2-arm-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} (100%)
> >  delete mode 100644 pc-bios/edk2-arm-code.fd.bz2
> >  delete mode 100644 pc-bios/edk2-i386-code.fd.bz2
> >  delete mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
> >  delete mode 100644 pc-bios/edk2-i386-vars.fd.bz2
> >  delete mode 100644 pc-bios/edk2-riscv-code.fd.bz2
> >  create mode 100644 pc-bios/edk2-riscv64-code.fd.bz2
> >  rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)
> >   
> 


