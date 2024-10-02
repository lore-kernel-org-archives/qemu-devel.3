Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D8CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzfo-0003H5-3R; Wed, 02 Oct 2024 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzfl-0003GU-6r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzfh-00027F-SY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727876739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20gZJz5o5n4XgAaHcnaiXhrD2M3yi0T2GQirhbkf0O8=;
 b=iXzfMM5hrBTNNIa4OsKJ7+vhioV18MU4k2T2v0CdSBIwg0b7c3j2bgJ7V6Cy0tIJAQnFye
 Exeexv1GHA13OCNU9Xx3+ASTq44htu/LOBW3O9Re7mEufUKU9PKccEjgEddSErdCx+Pc4c
 rGEt31jsxZhJ5v2QX0PkbudZA0VJQXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-uFUHlyUxNWKwpIBALu7mew-1; Wed, 02 Oct 2024 09:45:37 -0400
X-MC-Unique: uFUHlyUxNWKwpIBALu7mew-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb635b108so44464245e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727876736; x=1728481536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20gZJz5o5n4XgAaHcnaiXhrD2M3yi0T2GQirhbkf0O8=;
 b=p1W9TRhSy1BWbgrxQJ8HYE0wnpTxKm8Onq0mmrOGI06cfkxyAQ9odngG9OA2WFIAZn
 h5ptNN18aAgrsitk0xqQxjl7EQymwjstaZGIAhryNsN43wVapC+iPkg3To+4jR3apuNq
 vqZYzUtY1JfPyG7Y/gX774vjVvgCV8Yb8HVzJYSzopQj4NtJeQIFmRXmRGgTDoBTHZkt
 cNsutCwDDXOGfH5Zp0czPMfPEAyDiQV/qtwBGMGsGIWiuddLlbrAIEsb0ON1T89+qA/U
 fK009U7AZeh0DhVgZxzJyi2rut4f+kv4ZXlFc7SJrauAYCqC3teRYdlIPT0LyvibGLuU
 xY3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoT7ICqs4Dobzt6Bm9krWhpwXzidhzM77lDe5jcCc1dYtM0S6libxDCh/auuwqebWWPwTGMsJOSzPW@nongnu.org
X-Gm-Message-State: AOJu0YxnpJUAXs/1i+1Wyflf1vd9nPMXSKxFZs+o35FLXl1CnIowTPcR
 hTSxdbZG3211B50a/gVCzO/SQ89P7ELaH4P187BPMCtHU8no4pBlAGC7CYP1+ZEh91Jj4xFZfM5
 CcesNm/z3eKacu4YNhoYmZuJbhlch5apF2JP0x6g5hIftI+ml+WEj
X-Received: by 2002:adf:b1c3:0:b0:37c:d491:f2da with SMTP id
 ffacd0b85a97d-37cfb8a1e6emr1775784f8f.2.1727876736394; 
 Wed, 02 Oct 2024 06:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV7kmR1wjDV2IV5gYhtKKNB7cBBDndf+EUBVwZIDV/S/eaxC60IDebKTkUgWns3f+2Myz6lA==
X-Received: by 2002:adf:b1c3:0:b0:37c:d491:f2da with SMTP id
 ffacd0b85a97d-37cfb8a1e6emr1775764f8f.2.1727876735961; 
 Wed, 02 Oct 2024 06:45:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fb5dsm13994905f8f.88.2024.10.02.06.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:45:35 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:45:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20241002154534.3c58db06@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  1 Oct 2024 13:42:45 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This RFC series was part of the previous PR to add generic error injection
> support on GHES.
> 
> It contains only the changes of the math used to calculate offsets at
> HEST table and hardware_error firmware file.
> 
> The first patch adds a new firmware file to store HEST address.
> The second patch makes use of it.
> The remaining ones add migration support.
> 
> PS.: I'm sending this as a RFC as using the proceudure defined at the
> pseudo-migration of:
> 
> 	https://www.linux-kvm.org/page/Migration
> 
> Didn't work. I tried to use two different QEMU versions to check a
> real life case and also to use just one QEMU and trying to load a
> virt-9.1 state on a virt-9.2 machine. 
> 
> For instance, trying to restore a virt-9.1 state on virt-9.2 gave me
> this error:
> 
> 	(qemu) qemu: Machine type received is 'virt-9.1' and local is 'virt-9.2'
> 	qemu: load of migration failed: Invalid argument

that's expected (idea is to keep machine type (virt-X) ABI stable so
it would work the same way on old and new QEMU)
migration is meant to move VM of the same machine type to a new/another QEMU instance.

i.e try migrate 

qemu-9.1 -M virt-9.1  => qemu-9.2 -M virt-9.1
and vice-versa
migration should succeed and memory error injection should still work
the old way in both instances (I don't recall anymore how to simulate SEA,
perhaps original author left a description how to do that somewhere on mail-list).

virt-9.2 is never meant to be 

> Yet, running virt-9.1 used the old math code (offsets from hardware_errors firmware
> file) while running virt-9.2 executed the new math code using HEST address.
> 
> Mauro Carvalho Chehab (5):
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   arm/virt-acpi-build: Properly handle virt-9.1
> 
>  hw/acpi/generic_event_device.c |  30 +++++++++
>  hw/acpi/ghes.c                 | 108 ++++++++++++++++++++++++++++++---
>  hw/arm/virt-acpi-build.c       |  30 +++++++--
>  hw/core/machine.c              |   4 +-
>  include/hw/acpi/ghes.h         |   2 +
>  5 files changed, 159 insertions(+), 15 deletions(-)
> 


