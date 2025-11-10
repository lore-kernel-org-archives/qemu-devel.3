Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DFACCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISch-0005i8-AS; Mon, 10 Nov 2025 09:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vISc2-0003nx-3J
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vISbz-0001GZ-IV
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762783874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnQX52BP8B72g2oD+fn3IJI+PJcrGdrAgHvNidLuJLw=;
 b=NOoO8u4GOkIGoTotdER8bLw69VKK0QlgHxcKyczs1SFqYJgf915PXVng5JzIfd3BX/al5P
 1B6kEqBa9H9lefRG0gIO3vT7AB6eShxnzSdF/ixBQsxsglcJYeD5vdx+T8dY/87rdCuIf0
 EECTTUKDiqeZTh1RKFGvvOQ5j7gBvUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-OCeBooMRO5ytYdsh7T06wQ-1; Mon, 10 Nov 2025 09:11:12 -0500
X-MC-Unique: OCeBooMRO5ytYdsh7T06wQ-1
X-Mimecast-MFC-AGG-ID: OCeBooMRO5ytYdsh7T06wQ_1762783870
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47775585257so14026405e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762783870; x=1763388670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnQX52BP8B72g2oD+fn3IJI+PJcrGdrAgHvNidLuJLw=;
 b=meeZ2NlWDLZCGpR8IQP4zQ3foJFptvc8b0WYj2YWbanfMOMv4emNahFROcwr+Da51e
 igC+Q9riC26ZQviEpBMmIfKeo9StqUMyVzyFqlkfO9mLqSjvMcgJCYdGPcPjKwSTFvJi
 7Wh8tum1HwSwa+a67xIPy+pDmpMcQyJogGPpwubZcY7vN3CjLMBmiGqXtS94zHfvcS4C
 w7izfD9PLCnDDvEh2cNwVnRNHfskqJ5LnbJDe5jRKcLLonw82odu4MVqk915deyJjDTr
 efeThb/83iROaloobmYHVYurRNeXshTY8VVFB6rYM9rCa0AMpqEkEZ974y4phKgT22as
 hOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762783870; x=1763388670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XnQX52BP8B72g2oD+fn3IJI+PJcrGdrAgHvNidLuJLw=;
 b=ofnUQajMBOTH+fBeLU6dY/2D8t8/JqlFKhZ3E086wprkfQm3IlsvndGB7e5u9IzGbU
 0AoLAPMmwNFnXgdnXHZgxm/vRg42ER+G+epLXM2yRuhMH1JLK+QKtKEaUW28j9a7aO9t
 qUlIXXi//Yqgi+xjCRu59UkJe78fqtzp7BIfwOWFj7rwQwjqPem7ZObQ9Ns+hSpAi6fD
 KnQWWAWwe0AvGIjG5cq/jFrN3MxQwwEmkRGuK8YcBIcqTDgLSWnmN5Axd3Ork+BTHCoZ
 +2tugfjnSsYRnYKpwfJLH/T3sXw5CTK4A5oNG8BZ+qBTHWKM/Hk0m+gR63Dgq1QEwrto
 pA7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2KVjzxpLo3hGbyzTFnwMeP06Yq93z+frdNBf9Wy/zh8IFMN7tcfkYgNTZ+dsZMr9n9msvJY6T6TJ@nongnu.org
X-Gm-Message-State: AOJu0Yy1siN4Fquq2UZbcWigPUKSt3Kmb9F/nimFc44z6zdilQX93BZj
 tSAclZAOoAkqnxssN30lCjv3eYdtDpW+aEvixzk2EEO5pSx8bJalTHj23pcNWVCaW/1ibikImP/
 5gd/KbAF38qpYCwgo54lHnmZvXBLqtlS9ut1UZtVF1gVxhzemAg0qQgs8
X-Gm-Gg: ASbGncsQOHaBM0XVIecGCfIqsyBgyNNGC2n32JEZeDwM8IggcxQ+GWcKCN/y301K/hi
 dsW3Tl7Yl6IkGyTt4T3mm4pC8c9/pW3U97v2/sJOB2VN6DT6REsqTbDHApNYsB+zgO5DVLPyd/W
 aZymY6Xfp8SMT7MsbldZvGLLZ+gQ9NNgFAPUZLC3YNwmGCSTVPgHcSSoizH6Vd/+xkZboBpjpbK
 rWl4FUgBTHX7lmXCREmyxjVRumnTq/ioLOTIRWPj4DbId0w4f28kPSKEAhE/iM8Cgew7YXCxi2r
 47YaekoYTFvT8d2EOzFrDuphRLdy15BOBK1RjjvAVRzqihkQMQReam1mB2HO/cPPGA==
X-Received: by 2002:a05:600c:8b38:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4777328683bmr75804615e9.29.1762783870314; 
 Mon, 10 Nov 2025 06:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElH4nhY/Rx50t8QLNR1GZHppzeNkOW+S13MslhbVkcCzzyxeCoLZoKELddpekTL9SitEuLfQ==
X-Received: by 2002:a05:600c:8b38:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4777328683bmr75804185e9.29.1762783869821; 
 Mon, 10 Nov 2025 06:11:09 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47761c2fe2asm266380765e9.5.2025.11.10.06.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:11:09 -0800 (PST)
Date: Mon, 10 Nov 2025 15:11:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 2/8] acpi/ghes: Increase GHES raw data maximal length
 to 4KiB
Message-ID: <20251110151107.5e825ea0@fedora>
In-Reply-To: <20251105114453.2164073-3-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-3-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed,  5 Nov 2025 21:44:47 +1000
Gavin Shan <gshan@redhat.com> wrote:

> The current GHES raw data maximal length isn't enough for 16 consecutive
> CPER errors, which will be sent to a guest with 4KiB page size on a
> erroneous 64KiB host page. Note those 16 CPER errors will be contained
> in one single error block, meaning all CPER errors should be identical
> in terms of type and severity and all of them should be delivered in
> one shot.
> 
> Increase GHES raw data maximal length from 1KiB to 4KiB so that the
> error block has enough storage space for 16 consecutive CPER errors.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  docs/specs/acpi_hest_ghes.rst | 2 +-
>  hw/acpi/ghes.c                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index aaf7b1ad11..acf31d6eeb 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -68,7 +68,7 @@ Design Details
>      and N Read Ack Register entries. The size for each entry is 8-byte.
>      The Error Status Data Block table contains N Error Status Data Block
>      entries. The size for each entry is defined at the source code as
> -    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
> +    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 4096 bytes). The total size

is it safe to bump without compat glue?

consider VM migrated from old QEMU to new one,
it will have  etc/hardware_errors allocated with 1K GESB,
and more importantly error_block_addressN will have 1K offsets as well

however with ACPI_GHES_MAX_RAW_DATA_LENGTH all length checks will
let >1K blocks to be written into into 1K 'formated' etc/hardware_errors.

Thanks to previous refactoring we get all addresses right (1K version),
but if you write large GESB there it will either overlap with the next GESB
or a smaller GESB might overwrite tail of preceding large one.
And in works case it's OOB when writing large GESB in the last block.

Given we have to write GESB successfully or abort, there is no point
in adding compat knobs. But we still need to check if GEBS will fit into
whatever block size etc/hardware_errors inside guest RAM is laid out originally.

>      for the "etc/hardware_errors" fw_cfg blob is
>      (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
>      N is the number of the kinds of hardware error sources.
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 06555905ce..a9c08e73c0 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -33,7 +33,7 @@
>  #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10


